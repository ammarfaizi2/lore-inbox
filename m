Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbVLTUvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbVLTUvF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 15:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbVLTUvC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 15:51:02 -0500
Received: from jack.kinetikon.it ([62.152.125.81]:3308 "EHLO mail.towertech.it")
	by vger.kernel.org with ESMTP id S932097AbVLTUul (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 15:50:41 -0500
Date: Tue, 20 Dec 2005 21:46:12 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 2/6] RTC subsystem, ARM cleanup
Message-ID: <20051220214612.08cbe99f@inspiron>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes from the ARM subsytem some of the
rtc-related functions that have been included in
the RTC subsystem.

ARM Kconfig is modified to include the RTC subsystem.

Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>
--
 arch/arm/Kconfig          |    2 
 arch/arm/common/rtctime.c |  107 +++++-----------------------------------------
 2 files changed, 14 insertions(+), 95 deletions(-)

--- linux-nslu2.orig/arch/arm/Kconfig	2005-12-20 19:52:43.000000000 +0100
+++ linux-nslu2/arch/arm/Kconfig	2005-12-20 20:36:09.000000000 +0100
@@ -750,6 +750,8 @@ source "drivers/usb/Kconfig"
 
 source "drivers/mmc/Kconfig"
 
+source "drivers/rtc/Kconfig"
+
 endmenu
 
 source "fs/Kconfig"
--- linux-nslu2.orig/arch/arm/common/rtctime.c	2005-12-20 19:52:43.000000000 +0100
+++ linux-nslu2/arch/arm/common/rtctime.c	2005-12-20 20:36:09.000000000 +0100
@@ -40,89 +40,6 @@ static struct rtc_ops *rtc_ops;
 
 #define rtc_epoch 1900UL
 
-static const unsigned char days_in_month[] = {
-	31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
-};
-
-#define LEAPS_THRU_END_OF(y) ((y)/4 - (y)/100 + (y)/400)
-#define LEAP_YEAR(year) ((!(year % 4) && (year % 100)) || !(year % 400))
-
-static int month_days(unsigned int month, unsigned int year)
-{
-	return days_in_month[month] + (LEAP_YEAR(year) && month == 1);
-}
-
-/*
- * Convert seconds since 01-01-1970 00:00:00 to Gregorian date.
- */
-void rtc_time_to_tm(unsigned long time, struct rtc_time *tm)
-{
-	int days, month, year;
-
-	days = time / 86400;
-	time -= days * 86400;
-
-	tm->tm_wday = (days + 4) % 7;
-
-	year = 1970 + days / 365;
-	days -= (year - 1970) * 365
-	        + LEAPS_THRU_END_OF(year - 1)
-	        - LEAPS_THRU_END_OF(1970 - 1);
-	if (days < 0) {
-		year -= 1;
-		days += 365 + LEAP_YEAR(year);
-	}
-	tm->tm_year = year - 1900;
-	tm->tm_yday = days + 1;
-
-	for (month = 0; month < 11; month++) {
-		int newdays;
-
-		newdays = days - month_days(month, year);
-		if (newdays < 0)
-			break;
-		days = newdays;
-	}
-	tm->tm_mon = month;
-	tm->tm_mday = days + 1;
-
-	tm->tm_hour = time / 3600;
-	time -= tm->tm_hour * 3600;
-	tm->tm_min = time / 60;
-	tm->tm_sec = time - tm->tm_min * 60;
-}
-EXPORT_SYMBOL(rtc_time_to_tm);
-
-/*
- * Does the rtc_time represent a valid date/time?
- */
-int rtc_valid_tm(struct rtc_time *tm)
-{
-	if (tm->tm_year < 70 ||
-	    tm->tm_mon >= 12 ||
-	    tm->tm_mday < 1 ||
-	    tm->tm_mday > month_days(tm->tm_mon, tm->tm_year + 1900) ||
-	    tm->tm_hour >= 24 ||
-	    tm->tm_min >= 60 ||
-	    tm->tm_sec >= 60)
-		return -EINVAL;
-
-	return 0;
-}
-EXPORT_SYMBOL(rtc_valid_tm);
-
-/*
- * Convert Gregorian date to seconds since 01-01-1970 00:00:00.
- */
-int rtc_tm_to_time(struct rtc_time *tm, unsigned long *time)
-{
-	*time = mktime(tm->tm_year + 1900, tm->tm_mon + 1, tm->tm_mday,
-		       tm->tm_hour, tm->tm_min, tm->tm_sec);
-
-	return 0;
-}
-EXPORT_SYMBOL(rtc_tm_to_time);
-
 /*
  * Calculate the next alarm time given the requested alarm time mask
  * and the current time.
@@ -141,13 +58,13 @@ void rtc_next_alarm_time(struct rtc_time
 	next->tm_sec = alrm->tm_sec;
 }
 
-static inline int rtc_read_time(struct rtc_ops *ops, struct rtc_time *tm)
+static inline int rtc_arm_read_time(struct rtc_ops *ops, struct rtc_time *tm)
 {
 	memset(tm, 0, sizeof(struct rtc_time));
 	return ops->read_time(tm);
 }
 
-static inline int rtc_set_time(struct rtc_ops *ops, struct rtc_time *tm)
+static inline int rtc_arm_set_time(struct rtc_ops *ops, struct rtc_time *tm)
 {
 	int ret;
 
@@ -158,7 +75,7 @@ static inline int rtc_set_time(struct rt
 	return ret;
 }
 
-static inline int rtc_read_alarm(struct rtc_ops *ops, struct rtc_wkalrm *alrm)
+static inline int rtc_arm_read_alarm(struct rtc_ops *ops, struct rtc_wkalrm *alrm)
 {
 	int ret = -EINVAL;
 	if (ops->read_alarm) {
@@ -168,7 +85,7 @@ static inline int rtc_read_alarm(struct 
 	return ret;
 }
 
-static inline int rtc_set_alarm(struct rtc_ops *ops, struct rtc_wkalrm *alrm)
+static inline int rtc_arm_set_alarm(struct rtc_ops *ops, struct rtc_wkalrm *alrm)
 {
 	int ret = -EINVAL;
 	if (ops->set_alarm)
@@ -256,7 +173,7 @@ static int rtc_ioctl(struct inode *inode
 
 	switch (cmd) {
 	case RTC_ALM_READ:
-		ret = rtc_read_alarm(ops, &alrm);
+		ret = rtc_arm_read_alarm(ops, &alrm);
 		if (ret)
 			break;
 		ret = copy_to_user(uarg, &alrm.time, sizeof(tm));
@@ -278,11 +195,11 @@ static int rtc_ioctl(struct inode *inode
 		alrm.time.tm_wday = -1;
 		alrm.time.tm_yday = -1;
 		alrm.time.tm_isdst = -1;
-		ret = rtc_set_alarm(ops, &alrm);
+		ret = rtc_arm_set_alarm(ops, &alrm);
 		break;
 
 	case RTC_RD_TIME:
-		ret = rtc_read_time(ops, &tm);
+		ret = rtc_arm_read_time(ops, &tm);
 		if (ret)
 			break;
 		ret = copy_to_user(uarg, &tm, sizeof(tm));
@@ -300,7 +217,7 @@ static int rtc_ioctl(struct inode *inode
 			ret = -EFAULT;
 			break;
 		}
-		ret = rtc_set_time(ops, &tm);
+		ret = rtc_arm_set_time(ops, &tm);
 		break;
 
 	case RTC_EPOCH_SET:
@@ -331,11 +248,11 @@ static int rtc_ioctl(struct inode *inode
 			ret = -EFAULT;
 			break;
 		}
-		ret = rtc_set_alarm(ops, &alrm);
+		ret = rtc_arm_set_alarm(ops, &alrm);
 		break;
 
 	case RTC_WKALM_RD:
-		ret = rtc_read_alarm(ops, &alrm);
+		ret = rtc_arm_read_alarm(ops, &alrm);
 		if (ret)
 			break;
 		ret = copy_to_user(uarg, &alrm, sizeof(alrm));
@@ -425,7 +342,7 @@ static int rtc_read_proc(char *page, cha
 	struct rtc_time tm;
 	char *p = page;
 
-	if (rtc_read_time(ops, &tm) == 0) {
+	if (rtc_arm_read_time(ops, &tm) == 0) {
 		p += sprintf(p,
 			"rtc_time\t: %02d:%02d:%02d\n"
 			"rtc_date\t: %04d-%02d-%02d\n"
@@ -435,7 +352,7 @@ static int rtc_read_proc(char *page, cha
 			rtc_epoch);
 	}
 
-	if (rtc_read_alarm(ops, &alrm) == 0) {
+	if (rtc_arm_read_alarm(ops, &alrm) == 0) {
 		p += sprintf(p, "alrm_time\t: ");
 		if ((unsigned int)alrm.time.tm_hour <= 24)
 			p += sprintf(p, "%02d:", alrm.time.tm_hour);
