Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbWCQXbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbWCQXbP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 18:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbWCQXbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 18:31:13 -0500
Received: from CPE-70-92-180-7.mn.res.rr.com ([70.92.180.7]:42395 "EHLO
	cinder.waste.org") by vger.kernel.org with ESMTP id S1751105AbWCQXaw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 18:30:52 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <2.132654658@selenic.com>
Message-Id: <5.132654658@selenic.com>
Subject: [PATCH 4/14] RTC: Remove RTC UIP synchronization on PPC CHRP (arch/ppc)
Date: Fri, 17 Mar 2006 17:30:35 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove RTC UIP synchronization on PPC CHRP (arch/ppc)

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: rtc/arch/ppc/platforms/chrp_time.c
===================================================================
--- rtc.orig/arch/ppc/platforms/chrp_time.c	2005-10-27 19:02:08.000000000 -0500
+++ rtc/arch/ppc/platforms/chrp_time.c	2006-03-12 13:00:51.000000000 -0600
@@ -121,33 +121,15 @@ int __chrp chrp_set_rtc_time(unsigned lo
 unsigned long __chrp chrp_get_rtc_time(void)
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
 
 	if (!(chrp_cmos_clock_read(RTC_CONTROL) & RTC_DM_BINARY) || RTC_ALWAYS_BCD)
 	  {
