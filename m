Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161442AbWI2GeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161442AbWI2GeS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 02:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161443AbWI2GeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 02:34:18 -0400
Received: from smtp110.sbc.mail.mud.yahoo.com ([68.142.198.209]:38817 "HELO
	smtp110.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161442AbWI2GeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 02:34:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:User-Agent:Cc:MIME-Version:Content-Disposition:Date:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=TMpnUh8SkmiLZiAqdkfzLc5k2BqTSpYtGM3RrdjmIL/JIjG0VzpeLFKotm/8NSpaplyHJmtCM5dyW/eU/1WFY2CqdUn0ZioRWUSW0Dr+EgHPPdzdujK/atal+EivDdSICjy9Jk+5iw/rj54se1NRekY0IYgHfkBWyKgtA2ddaVE=  ;
From: David Brownell <david-b@pacbell.net>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: [patch 2.6.18-git] RTC class, error checks
User-Agent: KMail/1.7.1
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Date: Thu, 28 Sep 2006 23:34:13 -0700
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200609282334.14257.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[RESEND] 

The rtc_is_valid_tm() routine needs to treat some of the fields it checks
as unsigned, to prevent wrongly accepting invalid rtc_time structs; this
is the same approach used elsewhere in the RTC code for such tests.

Conversely, rtc_proc_show() is missing one invalid-day-of-month test that
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
