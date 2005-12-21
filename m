Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964966AbVLUXWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964966AbVLUXWg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 18:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964957AbVLUXWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 18:22:35 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:60810 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964967AbVLUXWe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 18:22:34 -0500
Date: Thu, 22 Dec 2005 00:22:30 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: johnstul@us.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH 4/10] NTP: precalculate time_adj from frequency
Message-ID: <Pine.LNX.4.61.0512220022010.30903@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This adds the frequency part to ntp_update_frequency(). It basically
calculates from tick_usec and time_freq how many nsec the time should be
advanced per second and converts it into the nsec and fraction per tick
(tick_nsec and time_adj).
Precalculating these values allows to be more precise and avoids the
crude time_freq to time_adj conversion in second_overflow().


Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 kernel/time.c  |    2 +-
 kernel/timer.c |   36 ++++++++++++++++++++++++++++--------
 2 files changed, 29 insertions(+), 9 deletions(-)

Index: linux-2.6-mm/kernel/time.c
===================================================================
--- linux-2.6-mm.orig/kernel/time.c	2005-12-21 12:12:00.000000000 +0100
+++ linux-2.6-mm/kernel/time.c	2005-12-21 12:12:04.000000000 +0100
@@ -337,7 +337,7 @@ int do_adjtimex(struct timex *txc)
 	    if (txc->modes & ADJ_TICK)
 		tick_usec = txc->tick;
 
-	    if (txc->modes & ADJ_TICK)
+	    if (txc->modes & (ADJ_TICK|ADJ_FREQUENCY|ADJ_OFFSET))
 		    ntp_update_frequency();
 	} /* txc->modes */
 leave:	if ((time_status & (STA_UNSYNC|STA_CLOCKERR)) != 0)
Index: linux-2.6-mm/kernel/timer.c
===================================================================
--- linux-2.6-mm.orig/kernel/timer.c	2005-12-21 12:12:00.000000000 +0100
+++ linux-2.6-mm/kernel/timer.c	2005-12-21 12:12:04.000000000 +0100
@@ -584,9 +584,8 @@ long time_precision = 1;		/* clock preci
 long time_maxerror = NTP_PHASE_LIMIT;	/* maximum error (us)		*/
 long time_esterror = NTP_PHASE_LIMIT;	/* estimated error (us)		*/
 static long time_phase;			/* phase offset (scaled us)	*/
-long time_freq = (((NSEC_PER_SEC + HZ/2) % HZ - HZ/2) << SHIFT_USEC) / NSEC_PER_USEC;
-					/* frequency offset (scaled ppm)*/
-static long time_adj;			/* tick adjust (scaled 1 / HZ)	*/
+long time_freq;				/* frequency offset (scaled ppm)*/
+static long time_adj, time_adj_curr;	/* tick adjust (scaled 1 / HZ)	*/
 long time_reftime;			/* time at last adjustment (s)	*/
 long time_adjust;
 long time_next_adjust;
@@ -606,11 +605,33 @@ void ntp_clear(void)
 	ntp_update_frequency();
 
 	tick_nsec_curr = tick_nsec;
+	time_adj_curr = time_adj;
 }
 
 void ntp_update_frequency(void)
 {
-	tick_nsec = tick_usec * 1000;
+	long time;
+	s64 freq;
+
+	/*
+	 * Split the frequency value into a nsec value and fraction, which are
+	 * used to advance xtime at every tick. First calculate the nsec value
+	 * for the next HZ ticks with the remainder in freq (scaled by
+	 * (SHIFT_USEC - 3)).
+	 */
+	freq = (s64)time_freq * 1000;
+	time = tick_usec * 1000 * USER_HZ;
+	time += freq >> SHIFT_USEC;
+
+	/*
+	 * Now calculate the per tick values.
+	 */
+	tick_nsec = time / HZ;
+	time = (time % HZ) << SHIFT_USEC;
+	time += freq & ((1 << SHIFT_USEC) - 1);
+	time <<= SHIFT_SCALE - SHIFT_USEC;
+	time_adj = time / HZ;
+
 	tick_nsec -= NSEC_PER_SEC / HZ - TICK_NSEC;
 }
 
@@ -687,6 +708,7 @@ static void second_overflow(void)
 	}
 
 	tick_nsec_curr = tick_nsec;
+	time_adj_curr = time_adj;
 	/*
 	 * Compute the phase adjustment for the next second. In PLL mode, the
 	 * offset is reduced by a fixed factor times the time constant. In FLL
@@ -706,8 +728,6 @@ static void second_overflow(void)
 	 * Compute the frequency estimate and additional phase adjustment due
 	 * to frequency error for the next second.
 	 */
-	ltemp = time_freq;
-	adj += shift_right(ltemp,(SHIFT_USEC + SHIFT_HZ - SHIFT_SCALE));
 
 #if HZ == 100
 	/*
@@ -731,7 +751,7 @@ static void second_overflow(void)
 	adj += shift_right(adj, 6) + shift_right(adj, 7);
 #endif
 	tick_nsec_curr += adj >> (SHIFT_SCALE - 10);
-	time_adj = (adj << 10) & (FINENSEC - 1);
+	time_adj_curr += (adj << 10) & (FINENSEC - 1);
 }
 
 /* in the NTP reference this is called "hardclock()" */
@@ -759,7 +779,7 @@ static void update_wall_time_one_tick(vo
 	 * Advance the phase, once it gets to one microsecond, then
 	 * advance the tick more.
 	 */
-	time_phase += time_adj;
+	time_phase += time_adj_curr;
 	if (time_phase >= FINENSEC) {
 		long ltemp = time_phase >> SHIFT_SCALE;
 		time_phase -= ltemp << SHIFT_SCALE;
