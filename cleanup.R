library(dplyr)
library(magrittr)
library(ggplot2)

# Load the data
data <- read.csv("responses_raw.csv") %>% tbl_df()

# Rename all the columns
data %<>%
  rename(diet = What.best.describes.your.current.diet.,
         time.at.reed = How.many.semesters.have.you.attended.at.Reed.,
         attitudes.killing = Killing.animals.in.order.to.eat.them.is.abusive.,
         commons.freq = How.often.have.you.eaten.at.Commons.in.the.past.semester.,
         commons.veggie.good = When.Commons.serves.specials.that.are.vegetarian..they.are.good.,
         commons.vegan.good = When.Commons.serves.specials.that.are.vegan..they.are.usually.good.,
         attitudes.products = Raising.animals.to.harvest.products..such.as.eggs.or.milk..is.animal.abuse.,
         attitudes.env = The.mass.production.of.meat.posses.a.serious.threat.the.environment.,
         attitudes.veggie.health = A.diet.without.meat.is.healthier.,
         attitudes.vegan.health = A.diet.without.animal.products..such.as.milk.or.eggs..is.healthier.,
         attitudes.protein = It.is.harder.to.get.eat.enough.protein.without.meat.in.one.s.diet.,
         attitudes.culture = Eating.meat.is.an.important.part.of.the.culture.I.identify.with.,
         attitudes.longform = What.other.factors.motivate.your.choices.regarding.if.and.how.you.consume.meat.and.or.animal.products.,
         commons.pigday = Common.s.way.of.celebrating.National.Pig.Day.was.exclusionary.,
         permission.publish = I.give.you.permission.to.publish.my.free.form.responses.in.the.Quest.,
         permission.contact = I.give.the.Quest.permission.to.contact.me.to.further.discuss.my.responses.,
         commons.veggie.consistent = Commons.has.vegetarian.specials.consistently.,
         commons.vegan.consistent = Commons.has.vegan.specials.consistently.,
         commons.respect = I.feel.that.Commons.respects.my.beliefs.about.food.and.animals.,
         commons.longform = Would.you.like.to.provide.more.information.about.your.answers.above...Optional.
         )

# Remove longform answers we don't have permission to publish
data %<>% 
  mutate( attitudes.longform = as.character(attitudes.longform),
          commons.longform = as.character(commons.longform)) %>% 
  mutate(
  attitudes.longform = ifelse(permission.publish == 'Yes', attitudes.longform, ""),
  commons.longform = ifelse(permission.publish == 'Yes', attitudes.longform, ""))

# Remove unnecessary columns
data %<>%
  select(-Timestamp, -Email, -permission.contact, -permission.publish, -X,
         -Commons.has.excellent.coffee)

# Save the file
write.csv(data, file = "commons_food_animals_clean.csv")
