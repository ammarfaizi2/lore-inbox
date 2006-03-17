Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751674AbWCQX76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674AbWCQX76 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 18:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751689AbWCQX75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 18:59:57 -0500
Received: from CPE-70-92-180-7.mn.res.rr.com ([70.92.180.7]:35217 "EHLO
	cinder.waste.org") by vger.kernel.org with ESMTP id S1751648AbWCQX7i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 18:59:38 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <2.132654658@selenic.com>
Message-Id: <8.132654658@selenic.com>
Subject: [PATCH 7/14] RTC: Remove RTC UIP synchronization on MIPS Footbridge
Date: Fri, 17 Mar 2006 17:30:36 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove RTC UIP synchronization on MIPS Footbridge

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: rtc/arch/arm/mach-footbridge/time.c
===================================================================
--- rtc.orig/arch/arm/mach-footbridge/time.c	2005-10-27 19:02:08.000000000 -0500
+++ rtc/arch/arm/mach-footbridge/time.c	2006-03-12 13:00:51.000000000 -0600
@@ -34,27 +34,12 @@ static int rtc_base;
 static unsigned long __init get_isa_cmos_time(void)
 {
 	unsigned int year, mon, day, hour, min, sec;
-	int i;
 
 	// check to see if the RTC makes sense.....
 	if ((CMOS_READ(RTC_VALID) & RTC_VRT) == 0)
 		return mktime(1970, 1, 1, 0, 0, 0);
 
-	/* The Linux interpretation of the CMOS clock register contents:
-	 * When the Update-In-Progress (UIP) flag goes from 1 to 0, the
-	 * RTC registers show the second which has precisely just started.
-	 * Let's hope other operating systems interpret the RTC the same way.
-	 */
-	/* read RTC exactly on falling edge of update flag */
-	for (i = 0 ; i < 1000000 ; i++) /* may take up to 1 second... */
-		if (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP)
-			break;
-
-	for (i = 0 ; i < 1000000 ; i++) /* must try at least 2.228 ms */
-		if (!(CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP))
-			break;
-
-	do { /* Isn't this overkill ? UIP above should guarantee consistency */
+	do {
 		sec  = CMOS_READ(RTC_SECONDS);
 		min  = CMOS_READ(RTC_MINUTES);
 		hour = CMOS_READ(RTC_HOURS);
