Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964954AbVLUXVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964954AbVLUXVX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 18:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964956AbVLUXVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 18:21:22 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:59786 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964954AbVLUXVV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 18:21:21 -0500
Date: Thu, 22 Dec 2005 00:21:17 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: johnstul@us.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/10] NTP: normalize time_adj
Message-ID: <Pine.LNX.4.61.0512220020250.30897@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This normalizes the calculated value time_adj in second_overflow() to be
always positive. The difference is added to tick_nsec and stored in
tick_nsec_curr. This simplifies the work needed in
update_wall_time_one_tick() as time_phase is always positive.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 include/linux/timex.h |    2 +-
 kernel/timer.c        |   24 ++++++++++++++----------
 2 files changed, 15 insertions(+), 11 deletions(-)

Index: linux-2.6-mm/include/linux/timex.h
===================================================================
--- linux-2.6-mm.orig/include/linux/timex.h	2005-12-21 12:11:48.000000000 +0100
+++ linux-2.6-mm/include/linux/timex.h	2005-12-21 12:11:56.000000000 +0100
@@ -93,7 +93,7 @@
 #define SHIFT_SCALE 22		/* phase scale (shift) */
 #define SHIFT_UPDATE (SHIFT_KG + MAXTC) /* time offset scale (shift) */
 #define SHIFT_USEC 16		/* frequency offset scale (shift) */
-#define FINENSEC (1L << (SHIFT_SCALE - 10)) /* ~1 ns in phase units */
+#define FINENSEC (1L << SHIFT_SCALE) /* ~1 ns in phase units */
 
 #define MAXPHASE 512000L        /* max phase error (us) */
 #define MAXFREQ (512L << SHIFT_USEC)  /* max frequency error (ppm) */
Index: linux-2.6-mm/kernel/timer.c
===================================================================
--- linux-2.6-mm.orig/kernel/timer.c	2005-12-21 12:11:48.000000000 +0100
+++ linux-2.6-mm/kernel/timer.c	2005-12-21 12:11:56.000000000 +0100
@@ -552,6 +552,7 @@ found:
  */
 unsigned long tick_usec = TICK_USEC; 		/* USER_HZ period (usec) */
 unsigned long tick_nsec = TICK_NSEC;		/* ACTHZ period (nsec) */
+static unsigned long tick_nsec_curr = TICK_NSEC;
 
 /* 
  * The current time 
@@ -601,7 +602,7 @@ long time_next_adjust;
  */
 static void second_overflow(void)
 {
-	long ltemp;
+	long ltemp, adj;
 
 	/* Bump the maxerror field */
 	time_maxerror += time_tolerance >> SHIFT_USEC;
@@ -662,6 +663,7 @@ static void second_overflow(void)
 		time_state = TIME_OK;
 	}
 
+	tick_nsec_curr = tick_nsec;
 	/*
 	 * Compute the phase adjustment for the next second. In PLL mode, the
 	 * offset is reduced by a fixed factor times the time constant. In FLL
@@ -675,36 +677,38 @@ static void second_overflow(void)
 	ltemp = min(ltemp, (MAXPHASE / MINSEC) << SHIFT_UPDATE);
 	ltemp = max(ltemp, -(MAXPHASE / MINSEC) << SHIFT_UPDATE);
 	time_offset -= ltemp;
-	time_adj = ltemp << (SHIFT_SCALE - SHIFT_HZ - SHIFT_UPDATE);
+	adj = ltemp << (SHIFT_SCALE - SHIFT_HZ - SHIFT_UPDATE);
 
 	/*
 	 * Compute the frequency estimate and additional phase adjustment due
 	 * to frequency error for the next second.
 	 */
 	ltemp = time_freq;
-	time_adj += shift_right(ltemp,(SHIFT_USEC + SHIFT_HZ - SHIFT_SCALE));
+	adj += shift_right(ltemp,(SHIFT_USEC + SHIFT_HZ - SHIFT_SCALE));
 
 #if HZ == 100
 	/*
 	 * Compensate for (HZ==100) != (1 << SHIFT_HZ).  Add 25% and 3.125% to
 	 * get 128.125; => only 0.125% error (p. 14)
 	 */
-	time_adj += shift_right(time_adj, 2) + shift_right(time_adj, 5);
+	adj += shift_right(adj, 2) + shift_right(adj, 5);
 #endif
 #if HZ == 250
 	/*
 	 * Compensate for (HZ==250) != (1 << SHIFT_HZ).  Add 1.5625% and
 	 * 0.78125% to get 255.85938; => only 0.05% error (p. 14)
 	 */
-	time_adj += shift_right(time_adj, 6) + shift_right(time_adj, 7);
+	adj += shift_right(adj, 6) + shift_right(adj, 7);
 #endif
 #if HZ == 1000
 	/*
 	 * Compensate for (HZ==1000) != (1 << SHIFT_HZ).  Add 1.5625% and
 	 * 0.78125% to get 1023.4375; => only 0.05% error (p. 14)
 	 */
-	time_adj += shift_right(time_adj, 6) + shift_right(time_adj, 7);
+	adj += shift_right(adj, 6) + shift_right(adj, 7);
 #endif
+	tick_nsec_curr += adj >> (SHIFT_SCALE - 10);
+	time_adj = (adj << 10) & (FINENSEC - 1);
 }
 
 /* in the NTP reference this is called "hardclock()" */
@@ -727,15 +731,15 @@ static void update_wall_time_one_tick(vo
 		/* Reduce by this step the amount of time left  */
 		time_adjust -= time_adjust_step;
 	}
-	delta_nsec = tick_nsec + time_adjust_step * 1000;
+	delta_nsec = tick_nsec_curr + time_adjust_step * 1000;
 	/*
 	 * Advance the phase, once it gets to one microsecond, then
 	 * advance the tick more.
 	 */
 	time_phase += time_adj;
-	if ((time_phase >= FINENSEC) || (time_phase <= -FINENSEC)) {
-		long ltemp = shift_right(time_phase, (SHIFT_SCALE - 10));
-		time_phase -= ltemp << (SHIFT_SCALE - 10);
+	if (time_phase >= FINENSEC) {
+		long ltemp = time_phase >> SHIFT_SCALE;
+		time_phase -= ltemp << SHIFT_SCALE;
 		delta_nsec += ltemp;
 	}
 	xtime.tv_nsec += delta_nsec;
