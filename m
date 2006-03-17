Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751410AbWCQXbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbWCQXbM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 18:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbWCQXat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 18:30:49 -0500
Received: from CPE-70-92-180-7.mn.res.rr.com ([70.92.180.7]:40859 "EHLO
	cinder.waste.org") by vger.kernel.org with ESMTP id S1751105AbWCQXar
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 18:30:47 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <2.132654658@selenic.com>
Message-Id: <3.132654658@selenic.com>
Subject: [PATCH 2/14] RTC: Remove RTC UIP synchronization on x86_64
Date: Fri, 17 Mar 2006 17:30:35 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove RTC UIP synchronization on x86_64

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: rtc/arch/x86_64/kernel/time.c
===================================================================
--- rtc.orig/arch/x86_64/kernel/time.c	2006-03-16 16:48:38.000000000 -0600
+++ rtc/arch/x86_64/kernel/time.c	2006-03-16 17:21:17.000000000 -0600
@@ -514,36 +514,19 @@ unsigned long long sched_clock(void)
 
 static unsigned long get_cmos_time(void)
 {
-	unsigned int timeout = 1000000, year, mon, day, hour, min, sec;
-	unsigned char uip = 0, this = 0;
+	unsigned int year, mon, day, hour, min, sec;
 	unsigned long flags;
 
-/*
- * The Linux interpretation of the CMOS clock register contents: When the
- * Update-In-Progress (UIP) flag goes from 1 to 0, the RTC registers show the
- * second which has precisely just started. Waiting for this can take up to 1
- * second, we timeout approximately after 2.4 seconds on a machine with
- * standard 8.3 MHz ISA bus.
- */
-
 	spin_lock_irqsave(&rtc_lock, flags);
 
-	while (timeout && (!uip || this)) {
-		uip |= this;
-		this = CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP;
-		timeout--;
-	}
-
-	/*
-	 * Here we are safe to assume the registers won't change for a whole
-	 * second, so we just go ahead and read them.
- 	 */
-	sec = CMOS_READ(RTC_SECONDS);
-	min = CMOS_READ(RTC_MINUTES);
-	hour = CMOS_READ(RTC_HOURS);
-	day = CMOS_READ(RTC_DAY_OF_MONTH);
-	mon = CMOS_READ(RTC_MONTH);
-	year = CMOS_READ(RTC_YEAR);
+	do {
+		sec = CMOS_READ(RTC_SECONDS);
+		min = CMOS_READ(RTC_MINUTES);
+		hour = CMOS_READ(RTC_HOURS);
+		day = CMOS_READ(RTC_DAY_OF_MONTH);
+		mon = CMOS_READ(RTC_MONTH);
+		year = CMOS_READ(RTC_YEAR);
+	} while (sec != CMOS_READ(RTC_SECONDS));
 
 	spin_unlock_irqrestore(&rtc_lock, flags);
 
