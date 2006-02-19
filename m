Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932441AbWBSXfG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbWBSXfG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 18:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbWBSXer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 18:34:47 -0500
Received: from 213-140-6-124.ip.fastwebnet.it ([213.140.6.124]:5058 "EHLO
	linux") by vger.kernel.org with ESMTP id S932413AbWBSXeo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 18:34:44 -0500
Message-Id: <20060219232211.761694000@towertech.it>
References: <20060219232211.368740000@towertech.it>
User-Agent: quilt/0.43-1
Date: Mon, 20 Feb 2006 00:22:13 +0100
From: Alessandro Zummo <a.zummo@towertech.it>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] RTC subsystem, ARM cleanup
Content-Disposition: inline; filename=rtc-arm-cleanup.patch
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
 drivers/char/Kconfig      |    2 
 include/asm-arm/rtc.h     |    3 -
 4 files changed, 15 insertions(+), 99 deletions(-)

--- linux-rtc.orig/arch/arm/Kconfig	2006-02-13 19:34:30.000000000 +0100
+++ linux-rtc/arch/arm/Kconfig	2006-02-13 19:35:30.000000000 +0100
@@ -817,6 +817,8 @@ source "drivers/usb/Kconfig"
 
 source "drivers/mmc/Kconfig"
 
+source "drivers/rtc/Kconfig"
+
 endmenu
 
 source "fs/Kconfig"
--- linux-rtc.orig/arch/arm/common/rtctime.c	2006-02-13 19:34:30.000000000 +0100
+++ linux-rtc/arch/arm/common/rtctime.c	2006-02-13 19:35:30.000000000 +0100
@@ -42,89 +42,6 @@ static struct rtc_ops *rtc_ops;
 
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
@@ -143,13 +60,13 @@ void rtc_next_alarm_time(struct rtc_time
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
 
@@ -160,7 +77,7 @@ static inline int rtc_set_time(struct rt
 	return ret;
 }
 
-static inline int rtc_read_alarm(struct rtc_ops *ops, struct rtc_wkalrm *alrm)
+static inline int rtc_arm_read_alarm(struct rtc_ops *ops, struct rtc_wkalrm *alrm)
 {
 	int ret = -EINVAL;
 	if (ops->read_alarm) {
@@ -170,7 +87,7 @@ static inline int rtc_read_alarm(struct 
 	return ret;
 }
 
-static inline int rtc_set_alarm(struct rtc_ops *ops, struct rtc_wkalrm *alrm)
+static inline int rtc_arm_set_alarm(struct rtc_ops *ops, struct rtc_wkalrm *alrm)
 {
 	int ret = -EINVAL;
 	if (ops->set_alarm)
@@ -258,7 +175,7 @@ static int rtc_ioctl(struct inode *inode
 
 	switch (cmd) {
 	case RTC_ALM_READ:
-		ret = rtc_read_alarm(ops, &alrm);
+		ret = rtc_arm_read_alarm(ops, &alrm);
 		if (ret)
 			break;
 		ret = copy_to_user(uarg, &alrm.time, sizeof(tm));
@@ -280,11 +197,11 @@ static int rtc_ioctl(struct inode *inode
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
@@ -302,7 +219,7 @@ static int rtc_ioctl(struct inode *inode
 			ret = -EFAULT;
 			break;
 		}
-		ret = rtc_set_time(ops, &tm);
+		ret = rtc_arm_set_time(ops, &tm);
 		break;
 
 	case RTC_EPOCH_SET:
@@ -333,11 +250,11 @@ static int rtc_ioctl(struct inode *inode
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
@@ -427,7 +344,7 @@ static int rtc_read_proc(char *page, cha
 	struct rtc_time tm;
 	char *p = page;
 
-	if (rtc_read_time(ops, &tm) == 0) {
+	if (rtc_arm_read_time(ops, &tm) == 0) {
 		p += sprintf(p,
 			"rtc_time\t: %02d:%02d:%02d\n"
 			"rtc_date\t: %04d-%02d-%02d\n"
@@ -437,7 +354,7 @@ static int rtc_read_proc(char *page, cha
 			rtc_epoch);
 	}
 
-	if (rtc_read_alarm(ops, &alrm) == 0) {
+	if (rtc_arm_read_alarm(ops, &alrm) == 0) {
 		p += sprintf(p, "alrm_time\t: ");
 		if ((unsigned int)alrm.time.tm_hour <= 24)
 			p += sprintf(p, "%02d:", alrm.time.tm_hour);
--- linux-rtc.orig/include/asm-arm/rtc.h	2006-01-03 04:21:10.000000000 +0100
+++ linux-rtc/include/asm-arm/rtc.h	2006-02-13 19:35:30.000000000 +0100
@@ -25,9 +25,6 @@ struct rtc_ops {
 	int		(*proc)(char *buf);
 };
 
-void rtc_time_to_tm(unsigned long, struct rtc_time *);
-int rtc_tm_to_time(struct rtc_time *, unsigned long *);
-int rtc_valid_tm(struct rtc_time *);
 void rtc_next_alarm_time(struct rtc_time *, struct rtc_time *, struct rtc_time *);
 void rtc_update(unsigned long, unsigned long);
 int register_rtc(struct rtc_ops *);
--- linux-rtc.orig/drivers/char/Kconfig	2006-02-13 19:34:36.000000000 +0100
+++ linux-rtc/drivers/char/Kconfig	2006-02-13 19:35:30.000000000 +0100
@@ -695,7 +695,7 @@ config NVRAM
 
 config RTC
 	tristate "Enhanced Real Time Clock Support"
-	depends on !PPC32 && !PARISC && !IA64 && !M68K && (!SPARC || PCI) && !FRV
+	depends on !PPC32 && !PARISC && !IA64 && !M68K && (!SPARC || PCI) && !FRV && !ARM
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you

--
