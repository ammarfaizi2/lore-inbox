Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbVHKBiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbVHKBiN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 21:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbVHKBiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 21:38:13 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:41942 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932202AbVHKBiM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 21:38:12 -0400
Subject: [RFC][PATCH - 13/13] NTP cleanup: drop time_phase and time_adj add
	copyright
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: George Anzinger <george@mvista.com>, frank@tuxrocks.com,
       Anton Blanchard <anton@samba.org>, benh@kernel.crashing.org,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
In-Reply-To: <1123724180.32531.6.camel@cog.beaverton.ibm.com>
References: <1123723279.30963.267.camel@cog.beaverton.ibm.com>
	 <1123723384.30963.269.camel@cog.beaverton.ibm.com>
	 <1123723534.32330.0.camel@cog.beaverton.ibm.com>
	 <1123723578.32330.2.camel@cog.beaverton.ibm.com>
	 <1123723634.32330.4.camel@cog.beaverton.ibm.com>
	 <1123723696.32330.6.camel@cog.beaverton.ibm.com>
	 <1123723739.32330.8.camel@cog.beaverton.ibm.com>
	 <1123723875.32330.10.camel@cog.beaverton.ibm.com>
	 <1123723913.32330.12.camel@cog.beaverton.ibm.com>
	 <1123724003.32531.0.camel@cog.beaverton.ibm.com>
	 <1123724039.32531.2.camel@cog.beaverton.ibm.com>
	 <1123724120.32531.5.camel@cog.beaverton.ibm.com>
	 <1123724180.32531.6.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Wed, 10 Aug 2005 18:38:08 -0700
Message-Id: <1123724288.32531.9.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	This patch replaces two global variables with better named static local
variables. Additionally it adds my copyright.

Any comments or feedback would be greatly appreciated.

thanks
-john

linux-2.6.13-rc6_timeofday-ntp-part13_B5.patch
============================================
diff --git a/kernel/ntp.c b/kernel/ntp.c
--- a/kernel/ntp.c
+++ b/kernel/ntp.c
@@ -3,7 +3,9 @@
 *
 * NTP state machine and time scaling code.
 *
-* Code moved from kernel/time.c and kernel/timer.c
+* Copyright (C) 2004, 2005 IBM, John Stultz (johnstul@us.ibm.com)
+*
+* Code moved and rewritten from kernel/time.c and kernel/timer.c
 * Please see those files for original copyrights.
 *
 * This program is free software; you can redistribute it and/or modify
@@ -48,8 +50,6 @@
 
 /* Don't completely fail for HZ > 500.  */
 int tickadj = 500/HZ ? : 1;		/* microsecs */
-static long time_phase;                 /* phase offset (scaled us) */
-static long time_adj;                   /* tick adjust (scaled 1 / HZ) */
 
 /* Chapter 5: Kernel Variables [RFC 1589 pg. 28] */
 /* 5.1 Interface Variables */
@@ -86,9 +86,9 @@ static seqlock_t ntp_lock = SEQLOCK_UNLO
 void ntp_advance(unsigned long interval_nsec)
 {
 	static unsigned long interval_sum = 0;
-	long time_adjust_step;
 	unsigned long flags;
 	static long ss_adj = 0;
+	static long phase, phase_adj = 0;
 
 	write_seqlock_irqsave(&ntp_lock, flags);
 
@@ -128,22 +128,24 @@ void ntp_advance(unsigned long interval_
 		ntp_offset -= next_adj;
 		offset_adj = shiftR(next_adj, SHIFT_UPDATE); /* ppm */
 
-		time_adj = next_adj << (SHIFT_SCALE - SHIFT_HZ - SHIFT_UPDATE);
-		time_adj += shiftR(ntp_freq, (SHIFT_USEC + SHIFT_HZ - SHIFT_SCALE));
+		/* calculate the per tick phase adjustment for the next second */
+		phase_adj = next_adj << (SHIFT_SCALE - SHIFT_HZ - SHIFT_UPDATE);
+		phase_adj += shiftR(ntp_freq, (SHIFT_USEC + SHIFT_HZ - SHIFT_SCALE));
 #if HZ == 100
     	/* Compensate for (HZ==100) != (1 << SHIFT_HZ).
 	     * Add 25% and 3.125% to get 128.125;
 		 * => only 0.125% error (p. 14)
     	 */
-		time_adj += shiftR(time_adj,2) + shiftR(time_adj,5);
+		phase_adj += shiftR(phase_adj,2) + shiftR(phase_adj,5);
 #endif
 #if HZ == 1000
 	    /* Compensate for (HZ==1000) != (1 << SHIFT_HZ).
     	 * Add 1.5625% and 0.78125% to get 1023.4375;
 		 * => only 0.05% error (p. 14)
 	     */
-		time_adj += shiftR(time_adj,6) + shiftR(time_adj,7);
+		phase_adj += shiftR(phase_adj,6) + shiftR(phase_adj,7);
 #endif
+
 		/* Set ss_adj for the next second */
 		ss_adj = min_t(unsigned long, singleshot_adj, MAX_SINGLESHOT_ADJ);
 		singleshot_adj -= ss_adj;
@@ -176,14 +178,14 @@ void ntp_advance(unsigned long interval_
 	 * Advance the phase, once it gets to one nanosecond,
 	 * then advance the fixed_tick_ns_adj.
 	 */
-	time_phase += time_adj;
-	if (time_phase <= -FINENSEC) {
-		long ltemp = -time_phase >> (SHIFT_SCALE - 10);
-		time_phase += ltemp << (SHIFT_SCALE - 10);
+	phase += phase_adj;
+	if (phase <= -FINENSEC) {
+		long ltemp = -phase >> (SHIFT_SCALE - 10);
+		phase += ltemp << (SHIFT_SCALE - 10);
 		fixed_tick_ns_adj -= ltemp;
-	} else if (time_phase >= FINENSEC) {
-		long ltemp = time_phase >> (SHIFT_SCALE - 10);
-		time_phase -= ltemp << (SHIFT_SCALE - 10);
+	} else if (phase >= FINENSEC) {
+		long ltemp = phase >> (SHIFT_SCALE - 10);
+		phase -= ltemp << (SHIFT_SCALE - 10);
 		fixed_tick_ns_adj += ltemp;
 	}
 


