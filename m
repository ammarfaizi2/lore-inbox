Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751847AbWCRAA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847AbWCRAA7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 19:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751697AbWCRAAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 19:00:47 -0500
Received: from CPE-70-92-180-7.mn.res.rr.com ([70.92.180.7]:37265 "EHLO
	cinder.waste.org") by vger.kernel.org with ESMTP id S1751648AbWCRAAE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 19:00:04 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <2.132654658@selenic.com>
Message-Id: <9.132654658@selenic.com>
Subject: [PATCH 8/14] RTC: Remove RTC UIP synchronization on MIPS MC146818
Date: Fri, 17 Mar 2006 17:30:36 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove RTC UIP synchronization on MIPS MC146818

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: rtc/include/asm-mips/mc146818-time.h
===================================================================
--- rtc.orig/include/asm-mips/mc146818-time.h	2006-03-16 16:47:28.000000000 -0600
+++ rtc/include/asm-mips/mc146818-time.h	2006-03-16 17:25:54.000000000 -0600
@@ -86,43 +86,14 @@ static inline int mc146818_set_rtc_mmss(
 	return retval;
 }
 
-/*
- * Returns true if a clock update is in progress
- */
-static inline unsigned char rtc_is_updating(void)
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
 static inline unsigned long mc146818_get_cmos_time(void)
 {
 	unsigned int year, mon, day, hour, min, sec;
-	int i;
 	unsigned long flags;
 
-	/*
-	 * The Linux interpretation of the CMOS clock register contents:
-	 * When the Update-In-Progress (UIP) flag goes from 1 to 0, the
-	 * RTC registers show the second which has precisely just started.
-	 * Let's hope other operating systems interpret the RTC the same way.
-	 */
-
-	/* read RTC exactly on falling edge of update flag */
-	for (i = 0 ; i < 1000000 ; i++)	/* may take up to 1 second... */
-		if (rtc_is_updating())
-			break;
-	for (i = 0 ; i < 1000000 ; i++)	/* must try at least 2.228 ms */
-		if (!rtc_is_updating())
-			break;
-
 	spin_lock_irqsave(&rtc_lock, flags);
-	do { /* Isn't this overkill ? UIP above should guarantee consistency */
+
+	do {
 		sec = CMOS_READ(RTC_SECONDS);
 		min = CMOS_READ(RTC_MINUTES);
 		hour = CMOS_READ(RTC_HOURS);
