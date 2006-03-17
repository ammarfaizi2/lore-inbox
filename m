Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751700AbWCQX7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700AbWCQX7y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 18:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751659AbWCQX7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 18:59:32 -0500
Received: from CPE-70-92-180-7.mn.res.rr.com ([70.92.180.7]:34705 "EHLO
	cinder.waste.org") by vger.kernel.org with ESMTP id S1751674AbWCQX7b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 18:59:31 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <2.132654658@selenic.com>
Message-Id: <10.132654658@selenic.com>
Subject: [PATCH 9/14] RTC: Remove RTC UIP synchronization on MIPS-based DEC
Date: Fri, 17 Mar 2006 17:30:37 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove RTC UIP synchronization on MIPS-based DEC

Move real_year inside the read loop and move the spinlock up as well

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: rtc/arch/mips/dec/time.c
===================================================================
--- rtc.orig/arch/mips/dec/time.c	2006-03-16 16:47:15.000000000 -0600
+++ rtc/arch/mips/dec/time.c	2006-03-16 17:32:21.000000000 -0600
@@ -36,41 +36,13 @@
 #include <asm/dec/ioasic_addrs.h>
 #include <asm/dec/machtype.h>
 
-
-/*
- * Returns true if a clock update is in progress
- */
-static inline unsigned char dec_rtc_is_updating(void)
-{
-	unsigned char uip;
-	unsigned long flags;
-
-	spin_lock_irqsave(&rtc_lock, flags);
-	uip = (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP);
-	spin_unlock_irqrestore(&rtc_lock, flags);
-	return uip;
-}
-
 static unsigned long dec_rtc_get_time(void)
 {
 	unsigned int year, mon, day, hour, min, sec, real_year;
-	int i;
 	unsigned long flags;
 
-	/* The Linux interpretation of the DS1287 clock register contents:
-	 * When the Update-In-Progress (UIP) flag goes from 1 to 0, the
-	 * RTC registers show the second which has precisely just started.
-	 * Let's hope other operating systems interpret the RTC the same way.
-	 */
-	/* read RTC exactly on falling edge of update flag */
-	for (i = 0; i < 1000000; i++)	/* may take up to 1 second... */
-		if (dec_rtc_is_updating())
-			break;
-	for (i = 0; i < 1000000; i++)	/* must try at least 2.228 ms */
-		if (!dec_rtc_is_updating())
-			break;
 	spin_lock_irqsave(&rtc_lock, flags);
-	/* Isn't this overkill?  UIP above should guarantee consistency */
+
 	do {
 		sec = CMOS_READ(RTC_SECONDS);
 		min = CMOS_READ(RTC_MINUTES);
@@ -78,7 +50,16 @@ static unsigned long dec_rtc_get_time(vo
 		day = CMOS_READ(RTC_DAY_OF_MONTH);
 		mon = CMOS_READ(RTC_MONTH);
 		year = CMOS_READ(RTC_YEAR);
+		/*
+		 * The PROM will reset the year to either '72 or '73.
+		 * Therefore we store the real year separately, in one
+		 * of unused BBU RAM locations.
+		 */
+		real_year = CMOS_READ(RTC_DEC_YEAR);
 	} while (sec != CMOS_READ(RTC_SECONDS));
+
+	spin_unlock_irqrestore(&rtc_lock, flags);
+
 	if (!(CMOS_READ(RTC_CONTROL) & RTC_DM_BINARY) || RTC_ALWAYS_BCD) {
 		sec = BCD2BIN(sec);
 		min = BCD2BIN(min);
@@ -87,13 +68,7 @@ static unsigned long dec_rtc_get_time(vo
 		mon = BCD2BIN(mon);
 		year = BCD2BIN(year);
 	}
-	/*
-	 * The PROM will reset the year to either '72 or '73.
-	 * Therefore we store the real year separately, in one
-	 * of unused BBU RAM locations.
-	 */
-	real_year = CMOS_READ(RTC_DEC_YEAR);
-	spin_unlock_irqrestore(&rtc_lock, flags);
+
 	year += real_year - 72 + 2000;
 
 	return mktime(year, mon, day, hour, min, sec);
