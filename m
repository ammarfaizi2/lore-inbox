Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbWHJAOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbWHJAOv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 20:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWHJAOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 20:14:51 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:12682 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932288AbWHJAOu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 20:14:50 -0400
Message-Id: <20060810001113.881368000@linux-m68k.org>
References: <20060810000146.913645000@linux-m68k.org>
User-Agent: quilt/0.45-1
Date: Thu, 10 Aug 2006 02:01:48 +0200
From: zippel@linux-m68k.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
Subject: [NTP 2/9] add time_adj to tick length
Content-Disposition: inline; filename=0002-NTP-add-time_adj-to-tick-length.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This makes time_adj local to second_overflow() and integrates it into
the tick length instead of adding it everytime.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
---
 kernel/time/ntp.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

Index: linux-2.6-mm/kernel/time/ntp.c
===================================================================
--- linux-2.6-mm.orig/kernel/time/ntp.c
+++ linux-2.6-mm/kernel/time/ntp.c
@@ -45,7 +45,6 @@ long time_maxerror = NTP_PHASE_LIMIT;	/*
 long time_esterror = NTP_PHASE_LIMIT;	/* estimated error (us)		*/
 long time_freq = (((NSEC_PER_SEC + HZ/2) % HZ - HZ/2) << SHIFT_USEC) / NSEC_PER_USEC;
 					/* frequency offset (scaled ppm)*/
-static long time_adj;			/* tick adjust (scaled 1 / HZ)	*/
 long time_reftime;			/* time at last adjustment (s)	*/
 long time_adjust;
 long time_next_adjust;
@@ -90,7 +89,7 @@ void ntp_update_frequency(void)
  */
 void second_overflow(void)
 {
-	long ltemp;
+	long ltemp, time_adj;
 
 	/* Bump the maxerror field */
 	time_maxerror += time_tolerance >> SHIFT_USEC;
@@ -195,6 +194,7 @@ void second_overflow(void)
 	time_adj += shift_right(time_adj, 6) + shift_right(time_adj, 7);
 #endif
 	tick_length = tick_length_base;
+	tick_length += (s64)time_adj << (TICK_LENGTH_SHIFT - (SHIFT_SCALE - 10));
 }
 
 /*
@@ -251,11 +251,9 @@ u64 current_tick_length(void)
 	u64 ret;
 
 	/* calculate the finest interval NTP will allow.
-	 *    ie: nanosecond value shifted by (SHIFT_SCALE - 10)
 	 */
 	ret = tick_length;
 	ret += (u64)(adjtime_adjustment() * 1000) << TICK_LENGTH_SHIFT;
-	ret += (s64)time_adj << (TICK_LENGTH_SHIFT - (SHIFT_SCALE - 10));
 
 	return ret;
 }

--

