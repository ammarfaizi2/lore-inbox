Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265670AbTBFFsV>; Thu, 6 Feb 2003 00:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265675AbTBFFsP>; Thu, 6 Feb 2003 00:48:15 -0500
Received: from dp.samba.org ([66.70.73.150]:25808 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265670AbTBFFsK>;
	Thu, 6 Feb 2003 00:48:10 -0500
From: Rusty Trivial Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL] 2.5.59 RTC alarm and wildcards
Date: Thu, 06 Feb 2003 16:51:44 +1100
Message-Id: <20030206055747.5CD762C0C6@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Included in 2.4)
From:  Paul Gortmaker <p_gortmaker@yahoo.com>

  NB: patch for 2.4 and 2.2 already sent to Marcelo and Alan.
  
  Paul.
  
  ----------
  
  Summary: Wildcards in RTC alarm settings failed to work
  
  Description:
   The RTC has provision for wildcards when setting the alarm; to
   use them you have to write a value higher than 0xc0 to the
   appropriate hr/min/sec entry.  The driver used 0xff, which is
   fine, but it mistakenly fed the 0xff through BIN_TO_BCD before
   writing them (which is < 0xc0) and so wildcards didn't work.
   (Thanks to Gerhard Kurz for reporting the bug.)
  
  

--- trivial-2.5-bk/drivers/char/rtc.c.orig	2003-02-06 16:30:20.000000000 +1100
+++ trivial-2.5-bk/drivers/char/rtc.c	2003-02-06 16:30:20.000000000 +1100
@@ -171,7 +171,7 @@
  *	A very tiny interrupt handler. It runs with SA_INTERRUPT set,
  *	but there is possibility of conflicting with the set_rtc_mmss()
  *	call (the rtc irq and the timer irq can easily run at the same
- *	time in two different CPUs). So we need to serializes
+ *	time in two different CPUs). So we need to serialize
  *	accesses to the chip with the rtc_lock spinlock that each
  *	architecture should implement in the timer code.
  *	(See ./arch/XXXX/kernel/time.c for the set_rtc_mmss() function.)
@@ -401,22 +401,18 @@
 		min = alm_tm.tm_min;
 		sec = alm_tm.tm_sec;
 
-		if (hrs >= 24)
-			hrs = 0xff;
-
-		if (min >= 60)
-			min = 0xff;
-
-		if (sec >= 60)
-			sec = 0xff;
-
 		spin_lock_irq(&rtc_lock);
 		if (!(CMOS_READ(RTC_CONTROL) & RTC_DM_BINARY) ||
 		    RTC_ALWAYS_BCD)
 		{
-			BIN_TO_BCD(sec);
-			BIN_TO_BCD(min);
-			BIN_TO_BCD(hrs);
+			if (sec < 60) BIN_TO_BCD(sec);
+			else sec = 0xff;
+
+			if (min < 60) BIN_TO_BCD(min);
+			else min = 0xff;
+
+			if (hrs < 24) BIN_TO_BCD(hrs);
+			else hrs = 0xff;
 		}
 		CMOS_WRITE(hrs, RTC_HOURS_ALARM);
 		CMOS_WRITE(min, RTC_MINUTES_ALARM);
-- 
  Don't blame me: the Monkey is driving
  File: Paul Gortmaker <p_gortmaker@yahoo.com>: [PATCH] 2.5.59 RTC alarm and wildcards
