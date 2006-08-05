Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422695AbWHEBRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422695AbWHEBRr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 21:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422696AbWHEBRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 21:17:47 -0400
Received: from smtp110.sbc.mail.mud.yahoo.com ([68.142.198.209]:13429 "HELO
	smtp110.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1422695AbWHEBRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 21:17:46 -0400
From: David Brownell <david-b@pacbell.net>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: [patch 2.6.18-rc3] RTC class, error checks
Date: Fri, 4 Aug 2006 17:41:37 -0700
User-Agent: KMail/1.7.1
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608041741.37482.david-b@pacbell.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The rtc_is_valid_tm() routine needs to treat some of the fields it checks
as unsigned, to prevent wrongly accepting invalid rtc_time structs; this
is the same approach used elsewhere in the RTC code for such tests.

Similarly, rtc_proc_show() is missing one invalid-day-of-month test that
rtc_is_valid_tm() makes:  there is no day zero.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: osk/drivers/rtc/rtc-lib.c
===================================================================
--- osk.orig/drivers/rtc/rtc-lib.c	2006-05-09 09:42:01.000000000 -0700
+++ osk/drivers/rtc/rtc-lib.c	2006-08-01 22:12:43.000000000 -0700
@@ -75,12 +75,12 @@ EXPORT_SYMBOL(rtc_time_to_tm);
 int rtc_valid_tm(struct rtc_time *tm)
 {
 	if (tm->tm_year < 70
-		|| tm->tm_mon >= 12
+		|| ((unsigned)tm->tm_mon) >= 12
 		|| tm->tm_mday < 1
 		|| tm->tm_mday > rtc_month_days(tm->tm_mon, tm->tm_year + 1900)
-		|| tm->tm_hour >= 24
-		|| tm->tm_min >= 60
-		|| tm->tm_sec >= 60)
+		|| ((unsigned)tm->tm_hour) >= 24
+		|| ((unsigned)tm->tm_min) >= 60
+		|| ((unsigned)tm->tm_sec) >= 60)
 		return -EINVAL;
 
 	return 0;
Index: osk/drivers/rtc/rtc-proc.c
===================================================================
--- osk.orig/drivers/rtc/rtc-proc.c	2006-05-09 09:42:01.000000000 -0700
+++ osk/drivers/rtc/rtc-proc.c	2006-08-01 22:15:19.000000000 -0700
@@ -61,7 +61,7 @@ static int rtc_proc_show(struct seq_file
 			seq_printf(seq, "%02d-", alrm.time.tm_mon + 1);
 		else
 			seq_printf(seq, "**-");
-		if ((unsigned int)alrm.time.tm_mday <= 31)
+		if (alrm.time.tm_mday && (unsigned int)alrm.time.tm_mday <= 31)
 			seq_printf(seq, "%02d\n", alrm.time.tm_mday);
 		else
 			seq_printf(seq, "**\n");
