Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932378AbWHJARY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbWHJARY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 20:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbWHJARI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 20:17:08 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:16522 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932378AbWHJAPj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 20:15:39 -0400
Message-Id: <20060810001114.706731000@linux-m68k.org>
References: <20060810000146.913645000@linux-m68k.org>
User-Agent: quilt/0.45-1
Date: Thu, 10 Aug 2006 02:01:51 +0200
From: zippel@linux-m68k.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
Subject: [NTP 5/9] add time_adjust to tick length
Content-Disposition: inline; filename=0005-NTP-add-time_adjust-to-tick-length.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This folds update_ntp_one_tick() into second_overflow() and adds
time_adjust to the tick length, this makes time_next_adjust unnecessary.
This slightly changes the adjtime() behaviour, instead of applying it to
the next tick, it's applied to the next second.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
---
 include/linux/timex.h |    1 
 kernel/time/ntp.c     |   71 ++++++++++++--------------------------------------
 kernel/timer.c        |    2 -
 3 files changed, 18 insertions(+), 56 deletions(-)

Index: linux-2.6-mm/include/linux/timex.h
===================================================================
--- linux-2.6-mm.orig/include/linux/timex.h
+++ linux-2.6-mm/include/linux/timex.h
@@ -216,7 +216,6 @@ extern long time_freq;		/* frequency off
 extern long time_reftime;	/* time at last adjustment (s) */
 
 extern long time_adjust;	/* The amount of adjtime left */
-extern long time_next_adjust;	/* Value for time_adjust at next tick */
 
 extern void ntp_clear(void);
 extern void ntp_update_frequency(void);
Index: linux-2.6-mm/kernel/time/ntp.c
===================================================================
--- linux-2.6-mm.orig/kernel/time/ntp.c
+++ linux-2.6-mm/kernel/time/ntp.c
@@ -28,8 +28,9 @@ unsigned long tick_usec = TICK_USEC; 		/
 unsigned long tick_nsec;			/* ACTHZ period (nsec) */
 static u64 tick_length, tick_length_base;
 
-/* Don't completely fail for HZ > 500.  */
-int tickadj = 500/HZ ? : 1;		/* microsecs */
+#define MAX_TICKADJ		500		/* microsecs */
+#define MAX_TICKADJ_SCALED	(((u64)(MAX_TICKADJ * NSEC_PER_USEC) << \
+				  TICK_LENGTH_SHIFT) / HZ)
 
 /*
  * phase-lock loop variables
@@ -46,7 +47,6 @@ long time_esterror = NTP_PHASE_LIMIT;	/*
 long time_freq;				/* frequency offset (scaled ppm)*/
 long time_reftime;			/* time at last adjustment (s)	*/
 long time_adjust;
-long time_next_adjust;
 
 /**
  * ntp_clear - Clears the NTP state variables
@@ -166,46 +166,19 @@ void second_overflow(void)
 	time_adj = max(time_adj, ((MAXPHASE / HZ) << SHIFT_UPDATE) / MINSEC);
 	time_offset -= time_adj;
 	tick_length += (s64)time_adj << (TICK_LENGTH_SHIFT - SHIFT_UPDATE);
-}
-
-/*
- * Returns how many microseconds we need to add to xtime this tick
- * in doing an adjustment requested with adjtime.
- */
-static long adjtime_adjustment(void)
-{
-	long time_adjust_step;
-
-	time_adjust_step = time_adjust;
-	if (time_adjust_step) {
-		/*
-		 * We are doing an adjtime thing.  Prepare time_adjust_step to
-		 * be within bounds.  Note that a positive time_adjust means we
-		 * want the clock to run faster.
-		 *
-		 * Limit the amount of the step to be in the range
-		 * -tickadj .. +tickadj
-		 */
-		time_adjust_step = min(time_adjust_step, (long)tickadj);
-		time_adjust_step = max(time_adjust_step, (long)-tickadj);
-	}
-	return time_adjust_step;
-}
-
-/* in the NTP reference this is called "hardclock()" */
-void update_ntp_one_tick(void)
-{
-	long time_adjust_step;
 
-	time_adjust_step = adjtime_adjustment();
-	if (time_adjust_step)
-		/* Reduce by this step the amount of time left  */
-		time_adjust -= time_adjust_step;
-
-	/* Changes by adjtime() do not take effect till next tick. */
-	if (time_next_adjust != 0) {
-		time_adjust = time_next_adjust;
-		time_next_adjust = 0;
+	if (unlikely(time_adjust)) {
+		if (time_adjust > MAX_TICKADJ) {
+			time_adjust -= MAX_TICKADJ;
+			tick_length += MAX_TICKADJ_SCALED;
+		} else if (time_adjust < -MAX_TICKADJ) {
+			time_adjust += MAX_TICKADJ;
+			tick_length -= MAX_TICKADJ_SCALED;
+		} else {
+			time_adjust = 0;
+			tick_length += (s64)(time_adjust * NSEC_PER_USEC /
+					     HZ) << TICK_LENGTH_SHIFT;
+		}
 	}
 }
 
@@ -219,14 +192,7 @@ void update_ntp_one_tick(void)
  */
 u64 current_tick_length(void)
 {
-	u64 ret;
-
-	/* calculate the finest interval NTP will allow.
-	 */
-	ret = tick_length;
-	ret += (u64)(adjtime_adjustment() * 1000) << TICK_LENGTH_SHIFT;
-
-	return ret;
+	return tick_length;
 }
 
 
@@ -269,7 +235,7 @@ int do_adjtimex(struct timex *txc)
 	result = time_state;	/* mostly `TIME_OK' */
 
 	/* Save for later - semantics of adjtime is to return old value */
-	save_adjust = time_next_adjust ? time_next_adjust : time_adjust;
+	save_adjust = time_adjust;
 
 #if 0	/* STA_CLOCKERR is never set yet */
 	time_status &= ~STA_CLOCKERR;		/* reset STA_CLOCKERR */
@@ -316,8 +282,7 @@ int do_adjtimex(struct timex *txc)
 	    if (txc->modes & ADJ_OFFSET) {	/* values checked earlier */
 		if (txc->modes == ADJ_OFFSET_SINGLESHOT) {
 		    /* adjtime() is independent from ntp_adjtime() */
-		    if ((time_next_adjust = txc->offset) == 0)
-			 time_adjust = 0;
+		    time_adjust = txc->offset;
 		}
 		else if (time_status & STA_PLL) {
 		    ltemp = txc->offset;
Index: linux-2.6-mm/kernel/timer.c
===================================================================
--- linux-2.6-mm.orig/kernel/timer.c
+++ linux-2.6-mm/kernel/timer.c
@@ -943,8 +943,6 @@ static void update_wall_time(void)
 		/* interpolator bits */
 		time_interpolator_update(clock->xtime_interval
 						>> clock->shift);
-		/* increment the NTP state machine */
-		update_ntp_one_tick();
 
 		/* accumulate error between NTP and clock interval */
 		clock->error += current_tick_length();

--

