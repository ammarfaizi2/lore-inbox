Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751589AbWCQXcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589AbWCQXcE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 18:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751576AbWCQXcB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 18:32:01 -0500
Received: from CPE-70-92-180-7.mn.res.rr.com ([70.92.180.7]:42651 "EHLO
	cinder.waste.org") by vger.kernel.org with ESMTP id S1751455AbWCQXbh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 18:31:37 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <2.132654658@selenic.com>
Message-Id: <6.132654658@selenic.com>
Subject: [PATCH 5/14] RTC: Remove RTC UIP synchronization on CHRP (arch/powerpc)
Date: Fri, 17 Mar 2006 17:30:36 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove RTC UIP synchronization on CHRP (arch/powerpc)

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: rtc/arch/powerpc/platforms/chrp/time.c
===================================================================
--- rtc.orig/arch/powerpc/platforms/chrp/time.c	2006-03-16 16:48:37.000000000 -0600
+++ rtc/arch/powerpc/platforms/chrp/time.c	2006-03-16 19:02:54.000000000 -0600
@@ -122,33 +122,15 @@ int chrp_set_rtc_time(struct rtc_time *t
 void chrp_get_rtc_time(struct rtc_time *tm)
 {
 	unsigned int year, mon, day, hour, min, sec;
-	int uip, i;
 
-	/* The Linux interpretation of the CMOS clock register contents:
-	 * When the Update-In-Progress (UIP) flag goes from 1 to 0, the
-	 * RTC registers show the second which has precisely just started.
-	 * Let's hope other operating systems interpret the RTC the same way.
-	 */
-
-	/* Since the UIP flag is set for about 2.2 ms and the clock
-	 * is typically written with a precision of 1 jiffy, trying
-	 * to obtain a precision better than a few milliseconds is
-	 * an illusion. Only consistency is interesting, this also
-	 * allows to use the routine for /dev/rtc without a potential
-	 * 1 second kernel busy loop triggered by any reader of /dev/rtc.
-	 */
-
-	for ( i = 0; i<1000000; i++) {
-		uip = chrp_cmos_clock_read(RTC_FREQ_SELECT);
+	do {
 		sec = chrp_cmos_clock_read(RTC_SECONDS);
 		min = chrp_cmos_clock_read(RTC_MINUTES);
 		hour = chrp_cmos_clock_read(RTC_HOURS);
 		day = chrp_cmos_clock_read(RTC_DAY_OF_MONTH);
 		mon = chrp_cmos_clock_read(RTC_MONTH);
 		year = chrp_cmos_clock_read(RTC_YEAR);
-		uip |= chrp_cmos_clock_read(RTC_FREQ_SELECT);
-		if ((uip & RTC_UIP)==0) break;
-	}
+	} while (sec != chrp_cmos_clock_read(RTC_SECONDS));
 
 	if (!(chrp_cmos_clock_read(RTC_CONTROL) & RTC_DM_BINARY) || RTC_ALWAYS_BCD) {
 		BCD_TO_BIN(sec);
