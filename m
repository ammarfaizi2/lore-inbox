Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262168AbVGPDWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262168AbVGPDWS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 23:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbVGPDWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 23:22:08 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:40119 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262183AbVGPDKC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 23:10:02 -0400
Subject: [RFC][PATCH - 12/12] NTP cleanup: use ppm instead of unit adj
	returned by ntp_advance
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: George Anzinger <george@mvista.com>, frank@tuxrocks.com,
       Anton Blanchard <anton@samba.org>, benh@kernel.crashing.org,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <1121483274.28638.9.camel@cog.beaverton.ibm.com>
References: <1121482517.25236.29.camel@cog.beaverton.ibm.com>
	 <1121482620.25236.31.camel@cog.beaverton.ibm.com>
	 <1121482672.25236.33.camel@cog.beaverton.ibm.com>
	 <1121482713.25236.35.camel@cog.beaverton.ibm.com>
	 <1121482758.25236.37.camel@cog.beaverton.ibm.com>
	 <1121482804.25236.39.camel@cog.beaverton.ibm.com>
	 <1121482925.25236.42.camel@cog.beaverton.ibm.com>
	 <1121483064.28638.0.camel@cog.beaverton.ibm.com>
	 <1121483101.28638.2.camel@cog.beaverton.ibm.com>
	 <1121483160.28638.4.camel@cog.beaverton.ibm.com>
	 <1121483202.28638.6.camel@cog.beaverton.ibm.com>
	 <1121483274.28638.9.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Fri, 15 Jul 2005 20:09:58 -0700
Message-Id: <1121483398.28638.11.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	This patch stops ntp_advance() from returning unit adjustments (ie:
nanoseconds). Instead the update_wall_time() function uses the ppm
adjustment from get_ntp_adjustment() which is then converted into a
nanosecond adjustment value.

Any comments or feedback would be greatly appreciated.

thanks
-john


linux-2.6.13-rc3_timeofday-ntp-part12_B4.patch
============================================
diff --git a/include/linux/ntp.h b/include/linux/ntp.h
--- a/include/linux/ntp.h
+++ b/include/linux/ntp.h
@@ -9,8 +9,11 @@
 #include <linux/time.h>
 #include <linux/timex.h>
 
+/* Required to safely shift negative values */
+#define shiftR(x,s) (x < 0) ? (-((-x) >> (s))) : ((x) >> (s))
+
 /* NTP state machine interfaces */
-int ntp_advance(unsigned long interval_nsec);
+void ntp_advance(unsigned long interval_nsec);
 int ntp_adjtimex(struct timex*);
 int ntp_leapsecond(struct timespec now);
 void ntp_clear(void);
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
@@ -82,13 +82,9 @@ static seqlock_t ntp_lock = SEQLOCK_UNLO
 #define MAX_SINGLESHOT_ADJ 500 /* (ppm) */
 #define SEC_PER_DAY 86400
 
-/* Required to safely shift negative values */
-#define shiftR(x,s) (x < 0) ? (-((-x) >> (s))) : ((x) >> (s))
-
-int ntp_advance(unsigned long interval_nsec)
+void ntp_advance(unsigned long interval_nsec)
 {
 	static unsigned long interval_sum = 0;
-	long time_adjust_step, delta_nsec;
 	unsigned long flags;
 	static long ss_adj = 0;
 
@@ -130,23 +126,6 @@ int ntp_advance(unsigned long interval_n
 		ntp_offset -= next_adj;
 		offset_adj = shiftR(next_adj, SHIFT_UPDATE); /* ppm */
 
-
-		time_adj = next_adj << (SHIFT_SCALE - SHIFT_HZ - SHIFT_UPDATE);
-		time_adj += shiftR(ntp_freq, (SHIFT_USEC + SHIFT_HZ - SHIFT_SCALE));
-#if HZ == 100
-    	/* Compensate for (HZ==100) != (1 << SHIFT_HZ).
-	     * Add 25% and 3.125% to get 128.125;
-		 * => only 0.125% error (p. 14)
-    	 */
-		time_adj += shiftR(time_adj,2) + shiftR(time_adj,5);
-#endif
-#if HZ == 1000
-	    /* Compensate for (HZ==1000) != (1 << SHIFT_HZ).
-    	 * Add 1.5625% and 0.78125% to get 1023.4375;
-		 * => only 0.05% error (p. 14)
-	     */
-		time_adj += shiftR(time_adj,6) + shiftR(time_adj,7);
-#endif
 		/* Set ss_adj for the next second */
 		ss_adj = min_t(unsigned long, singleshot_adj, MAX_SINGLESHOT_ADJ);
 		singleshot_adj -= ss_adj;
@@ -158,42 +137,6 @@ int ntp_advance(unsigned long interval_n
 	shifted_ppm_sum += ntp_freq; /* already shifted by SHIFT_USEC */
 	shifted_ppm_sum += ss_adj << SHIFT_USEC;
 
-
-	if ( (time_adjust_step = ntp_adjtime_offset) != 0 ) {
-	    /* We are doing an adjtime thing.
-	     *
-	     * Prepare time_adjust_step to be within bounds.
-	     * Note that a positive ntp_adjtime_offset means we want the clock
-	     * to run faster.
-	     *
-	     * Limit the amount of the step to be in the range
-	     * -tickadj .. +tickadj
-	     */
-		if (ntp_adjtime_offset > tickadj)
-			time_adjust_step = tickadj;
-		else if (ntp_adjtime_offset < -tickadj)
-			time_adjust_step = -tickadj;
-
-	    /* Reduce by this step the amount of time left  */
-	    ntp_adjtime_offset -= time_adjust_step;
-	}
-	delta_nsec = time_adjust_step * 1000;
-
-	/*
-	 * Advance the phase, once it gets to one microsecond, then
-	 * advance the tick more.
-	 */
-	time_phase += time_adj;
-	if (time_phase <= -FINENSEC) {
-		long ltemp = -time_phase >> (SHIFT_SCALE - 10);
-		time_phase += ltemp << (SHIFT_SCALE - 10);
-		delta_nsec -= ltemp;
-	} else if (time_phase >= FINENSEC) {
-		long ltemp = time_phase >> (SHIFT_SCALE - 10);
-		time_phase -= ltemp << (SHIFT_SCALE - 10);
-		delta_nsec += ltemp;
-	}
-
 	/* Changes by adjtime() do not take effect till next tick. */
 	if (ntp_next_adjtime_offset != 0) {
 		ntp_adjtime_offset = ntp_next_adjtime_offset;
@@ -201,7 +144,6 @@ int ntp_advance(unsigned long interval_n
 	}
 	write_sequnlock_irqrestore(&ntp_lock, flags);
 
-	return delta_nsec;
 }
 
 /**
diff --git a/kernel/timer.c b/kernel/timer.c
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -598,17 +598,23 @@ struct timespec wall_to_monotonic __attr
 
 EXPORT_SYMBOL(xtime);
 
-
 /* in the NTP reference this is called "hardclock()" */
 static void update_wall_time_one_tick(void)
 {
-	long delta_nsec;
+	long delta_nsec, ppm;
+	unsigned long interval_nsec;
+	
+	interval_nsec = tick_nsec;
+	ppm = ntp_get_adjustment();
 
-	delta_nsec = tick_nsec + ntp_advance(tick_nsec);
+	delta_nsec = interval_nsec;
+	delta_nsec += shiftR((interval_nsec * ppm),SHIFT_USEC)/1000000;
 
 	xtime.tv_nsec += delta_nsec;
-	time_interpolator_update(delta_nsec);
 
+	ntp_advance(interval_nsec);
+
+	time_interpolator_update(delta_nsec);
 }
 
 /*


