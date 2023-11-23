################################################
# File: Statistical Consulting Center Workshop 3
# Fall 2023
# Author: Taeyong Park 
################################################


################################################
# Basics of R and RStudio
################################################

### FOUR WINDOWS IN RStudio
# Editor: you type R code.
# Console: the output of your code is displayed.
# In the two other windows, you can see plots, a history of your commands, etc.


### BASIC ARITHMETIC 
# Write something here and find the solution in the console. 

# To send a line of code to your console, 
# place your cursor on the line, and then press 
# (PC users:) "control + enter"
# (Mac users:) "command + return"
# Alternatively, click the Run icon. 
# You can also simply copy and paste the line of code. 

12-5
10+4
1+3
1+4
2 + 3  #addition 

##### BTW, What is the pound key (#) for?
# R doesn't read anything after #
# You can write explanations using it.
# If you don't put # before your writing, you will get an error.

2*3  # multiplication
5/3 #division
4-5 #subtraction
3^3 # exponentiation
exp(7) # exponential
log(10) # natural log
sqrt(100) # square root


### ASSIGNMENT OF VALUES 
# One important concept as you are programming is the notion of a variable.  
# The "<-" and "=" symbols are used to assign a value to a variable.
# You can use either "<-" or "=".

# Create a and b that take on the values of 78 and 8.
a <- 78
b = 8 
# Print the values.
print(a)
print(b)
# or simply
a
b
a; b


y <- 5
x <- 2*(y + 11)
y; x

addXY = x+y
addXandYorwhateveryouwant <- x + y

x=c(2,3,4,5,6)
y=c(0,1,2,3,4)

data = cbind(x,y)
data
# You can override previous code by assigning alternative values.
y = 3
x = (y-8) + 7
y; x
addXandY = x + y

########################################################
# Set up the working directory
########################################################

## The most common thing we want to do in R is working with data of some sort.
## Usually these data are in some format like .csv (excel spreadsheets),
## .dta (Stata dataset), or .txt (text files).

## Reading these into R (i.e. adding them to your workspace) is very simple,
## but it first requires telling R where they are on your computer.

## We do this by setting our working directory, which is the folder in which
## the files are stored. If you try to load data into R which is not inside
## the folder specified in your working directory, you'll get an error.
## Also, anytime you export anything from R (new datasets, graphs, etc.) it will
## save them to your working directory.

# 1. Create a new directory (a new folder) for this course; You will save
# every data file into this folder in this semester.
# 2. Download the files from Canvas and save them to the new folder you just created.
# 3. In the menu bar at RStudio, click Session 
# 4. Place the cussor on Set Working Directory and click Choose Directory.
# 5. Then choose the new directory to which you saved the files.
# 6. Check if your working directory is your desired folder using
getwd()
# 7. Check if your data is in your working directory
list.files()


##################################################
#
# Quantitative-Quantitative,
#
##################################################
# Import data into R
youtube = read.csv("YouTube.csv")

# log transformation
# "$" symbol is to pull out a variable from the data
# dataName$variableName
youtube$log_subscribers = log(youtube$subscribers)
youtube$log_views = log(youtube$views)

# bivariate linear regression
model = lm(log_views ~ log_subscribers, data=youtube)
summary(model)


#####################################
# Exercise
#####################################
# Does the number of videos of the channel
# influence the number of subscribers? 
# Test at 0.05 level.

# First check if log transformation is needed.
hist(youtube$videoUploads)
youtube$log_videoUploads = log(youtube$videoUploads)


##################################################
#
# Qualitative-Quantitative,
# where "Qualitative" means two groups 
#
##################################################
# Import data into R
dataStat = read.csv("IntroStatisticsSurvey.csv")

# Question: Do females and males have different verbal SAT scores?    

#####################################
# Define two groups
#####################################
sample_f = dataStat[dataStat$Gender=="female", 3] 
# "3" indicates the Verbal variable on the third column 
sample_m = dataStat[dataStat$Gender=="male", 3]

#####################################
# t.test function
#####################################
# By default, 0.05 sig level; 95% confidence level.
t.test(sample_f, sample_m)

# In the output, "t" refers to the test statistic
# df refers to degrees of freedom.

# 0.01 sig level; 99% confidence level.
t.test(sample_f, sample_m, conf.level = .99)

#####################################
# Exercise
#####################################
# Do the students taking Business Stats and 
# the student taking Stats for Science have
# different SAT Math scores at 0.05 level?
sample_b = dataStat$Math[dataStat$Course=="Business Stats"] 
sample_s = dataStat$Math[dataStat$Course=="Stats for Science"] 
t.test(sample_b, sample_s)



##################################################
#
# Qualitative-Quantitative,
# where "Qualitative" means three or more groups 
#
##################################################

# Do students taking different stat courses have
# different SAT Math scores at 0.05 level?

#####################################
# aov function for anova
#####################################
# Use the aov function to run an Anova model.
# in the aov function, the model must be "dependentV ~ independentV"
anova_stat = aov(Math ~ Course, data=dataStat)
summary(anova_stat)

#####################################
# Exercise
#####################################
# 1. Does the height of student's father differ 
# for student's preferred color at 0.05 level?

# Generate another question that can be answered
# by the anova method.
# And test your question at 0.05.


########################################################
# 
# Independence test for two qualitative variables 
#
########################################################

# Do females and males tend to take different stat courses?
# If Yes, gender and course are not independent.
# If No, they are independent of each other. 

# First, create a contingency table.
contingency = table(dataStat$Course, dataStat$Gender)

#####################################
# chisq.test function
#####################################
prop.test(contingency, correct=F)
# The correct argument is for the Yates continuity correction for small samples.
# It must be FALSE for large samples (n>10).
# X-squared refers to the test statistic.
# df refers to degrees of freedom.

#####################################
# Exercise
#####################################
# Generate a question that can be answered by 
# the test of independence. 
# And test your question at 0.01.





#####################################
# Please fill out the survey.
# Thank you!
#####################################
# https://forms.gle/icpBKehZV7oLPTmB9
