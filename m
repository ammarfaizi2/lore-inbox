Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751570AbWCQX7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751570AbWCQX7V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 18:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751648AbWCQX7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 18:59:21 -0500
Received: from CPE-70-92-180-7.mn.res.rr.com ([70.92.180.7]:33681 "EHLO
	cinder.waste.org") by vger.kernel.org with ESMTP id S1751570AbWCQX7U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 18:59:20 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <2.132654658@selenic.com>
Message-Id: <12.132654658@selenic.com>
Subject: [PATCH 11/14] RTC: Remove RTC UIP synchronization on SH MPC1211
Date: Fri, 17 Mar 2006 17:30:37 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove RTC UIP synchronization on SH MPC1211

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6.16-rc4-rtc/arch/sh/boards/mpc1211/rtc.c
===================================================================
--- 2.6.16-rc4-rtc.orig/arch/sh/boards/mpc1211/rtc.c	2006-02-24 15:33:43.000000000 -0600
+++ 2.6.16-rc4-rtc/arch/sh/boards/mpc1211/rtc.c	2006-02-24 15:48:12.000000000 -0600
@@ -19,26 +19,13 @@
 #define BIN_TO_BCD(val) ((val)=(((val)/10)<<4) + (val)%10)
 #endif
 
-/* arc/i386/kernel/time.c */
 unsigned long get_cmos_time(void)
 {
 	unsigned int year, mon, day, hour, min, sec;
-	int i;
 
 	spin_lock(&rtc_lock);
-	/* The Linux interpretation of the CMOS clock register contents:
-	 * When the Update-In-Progress (UIP) flag goes from 1 to 0, the
-	 * RTC registers show the second which has precisely just started.
-	 * Let's hope other operating systems interpret the RTC the same way.
-	 */
-	/* read RTC exactly on falling edge of update flag */
-	for (i = 0 ; i < 1000000 ; i++)	/* may take up to 1 second... */
-		if (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP)
-			break;
-	for (i = 0 ; i < 1000000 ; i++)	/* must try at least 2.228 ms */
-		if (!(CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP))
-			break;
-	do { /* Isn't this overkill ? UIP above should guarantee consistency */
+
+	do {
 		sec = CMOS_READ(RTC_SECONDS);
 		min = CMOS_READ(RTC_MINUTES);
 		hour = CMOS_READ(RTC_HOURS);
@@ -46,6 +33,7 @@ unsigned long get_cmos_time(void)
 		mon = CMOS_READ(RTC_MONTH);
 		year = CMOS_READ(RTC_YEAR);
 	} while (sec != CMOS_READ(RTC_SECONDS));
+
 	if (!(CMOS_READ(RTC_CONTROL) & RTC_DM_BINARY) || RTC_ALWAYS_BCD)
 	  {
 	    BCD_TO_BIN(sec);
