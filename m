Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751735AbWCQX76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751735AbWCQX76 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 18:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751659AbWCQX74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 18:59:56 -0500
Received: from CPE-70-92-180-7.mn.res.rr.com ([70.92.180.7]:35729 "EHLO
	cinder.waste.org") by vger.kernel.org with ESMTP id S1751674AbWCQX7w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 18:59:52 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <2.132654658@selenic.com>
Message-Id: <7.132654658@selenic.com>
Subject: [PATCH 6/14] RTC: Remove RTC UIP synchronization on PPC Maple
Date: Fri, 17 Mar 2006 17:30:36 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove RTC UIP synchronization on PPC Maple

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: rtc/arch/powerpc/platforms/maple/time.c
===================================================================
--- rtc.orig/arch/powerpc/platforms/maple/time.c	2006-03-16 16:48:37.000000000 -0600
+++ rtc/arch/powerpc/platforms/maple/time.c	2006-03-16 19:00:12.000000000 -0600
@@ -62,34 +62,14 @@ static void maple_clock_write(unsigned l
 
 void maple_get_rtc_time(struct rtc_time *tm)
 {
-	int uip, i;
-
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
-	for (i = 0; i<1000000; i++) {
-		uip = maple_clock_read(RTC_FREQ_SELECT);
+	do {
 		tm->tm_sec = maple_clock_read(RTC_SECONDS);
 		tm->tm_min = maple_clock_read(RTC_MINUTES);
 		tm->tm_hour = maple_clock_read(RTC_HOURS);
 		tm->tm_mday = maple_clock_read(RTC_DAY_OF_MONTH);
 		tm->tm_mon = maple_clock_read(RTC_MONTH);
 		tm->tm_year = maple_clock_read(RTC_YEAR);
-		uip |= maple_clock_read(RTC_FREQ_SELECT);
-		if ((uip & RTC_UIP)==0)
-			break;
-	}
+	} while (tm->tm_sec != maple_clock_read(RTC_SECONDS));
 
 	if (!(maple_clock_read(RTC_CONTROL) & RTC_DM_BINARY)
 	    || RTC_ALWAYS_BCD) {
