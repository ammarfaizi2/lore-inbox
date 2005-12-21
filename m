Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964979AbVLUXZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964979AbVLUXZx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 18:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964980AbVLUXZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 18:25:53 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:62090 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964979AbVLUXZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 18:25:52 -0500
Date: Thu, 22 Dec 2005 00:25:51 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: johnstul@us.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH 6/10] NTP: add time_adjust to tick_nsec
Message-ID: <Pine.LNX.4.61.0512220024290.30918@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This removes time_adjust from update_wall_time_one_tick() and moves it
to second_overflow() and adds it to tick_nsec_curr instead.
This slightly changes the adjtime() behaviour, instead of applying it to
the next tick, it's applied to the next second. As this interface isn't
used by ntp, there shouldn't be much users left.



Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 include/linux/timex.h |    1 -
 kernel/time.c         |    5 ++---
 kernel/timer.c        |   42 ++++++++++++++++--------------------------
 3 files changed, 18 insertions(+), 30 deletions(-)

Index: linux-2.6-mm/include/linux/timex.h
===================================================================
--- linux-2.6-mm.orig/include/linux/timex.h	2005-12-21 12:12:08.000000000 +0100
+++ linux-2.6-mm/include/linux/timex.h	2005-12-21 12:12:11.000000000 +0100
@@ -217,7 +217,6 @@ extern long time_freq;		/* frequency off
 extern long time_reftime;	/* time at last adjustment (s) */
 
 extern long time_adjust;	/* The amount of adjtime left */
-extern long time_next_adjust;	/* Value for time_adjust at next tick */
 
 extern void ntp_clear(void);
 extern void ntp_update_frequency(void);
Index: linux-2.6-mm/kernel/time.c
===================================================================
--- linux-2.6-mm.orig/kernel/time.c	2005-12-21 12:12:08.000000000 +0100
+++ linux-2.6-mm/kernel/time.c	2005-12-21 12:12:11.000000000 +0100
@@ -242,7 +242,7 @@ int do_adjtimex(struct timex *txc)
 	result = time_state;	/* mostly `TIME_OK' */
 
 	/* Save for later - semantics of adjtime is to return old value */
-	save_adjust = time_next_adjust ? time_next_adjust : time_adjust;
+	save_adjust = time_adjust;
 
 #if 0	/* STA_CLOCKERR is never set yet */
 	time_status &= ~STA_CLOCKERR;		/* reset STA_CLOCKERR */
@@ -289,8 +289,7 @@ int do_adjtimex(struct timex *txc)
 	    if (txc->modes & ADJ_OFFSET) {	/* values checked earlier */
 		if (txc->modes == ADJ_OFFSET_SINGLESHOT) {
 		    /* adjtime() is independent from ntp_adjtime() */
-		    if ((time_next_adjust = txc->offset) == 0)
-			 time_adjust = 0;
+		    time_adjust = txc->offset;
 		}
 		else if (time_status & STA_PLL) {
 		    ltemp = txc->offset * 1000;
Index: linux-2.6-mm/kernel/timer.c
===================================================================
--- linux-2.6-mm.orig/kernel/timer.c	2005-12-21 12:12:08.000000000 +0100
+++ linux-2.6-mm/kernel/timer.c	2005-12-21 12:12:11.000000000 +0100
@@ -567,8 +567,7 @@ struct timespec wall_to_monotonic __attr
 
 EXPORT_SYMBOL(xtime);
 
-/* Don't completely fail for HZ > 500.  */
-int tickadj = 500/HZ ? : 1;		/* microsecs */
+#define MAX_TICKADJ	500000		/* nanosecs */
 
 
 /*
@@ -588,7 +587,6 @@ long time_freq;				/* frequency offset (
 static long time_adj, time_adj_curr;	/* tick adjust (scaled 1 / HZ)	*/
 long time_reftime;			/* time at last adjustment (s)	*/
 long time_adjust;
-long time_next_adjust;
 
 /**
  * ntp_clear - Clears the NTP state variables
@@ -744,29 +742,27 @@ static void second_overflow(void)
 			time_adj_curr -= FINENSEC;
 		}
 	}
+
+	if (unlikely(time_adjust)) {
+		if (time_adjust > MAX_TICKADJ / 1000) {
+			time_adjust -= MAX_TICKADJ / 1000;
+			tick_nsec_curr += MAX_TICKADJ / HZ;
+		} else if (time_adjust < -MAX_TICKADJ / 1000) {
+			time_adjust += MAX_TICKADJ / 1000;
+			tick_nsec_curr -= MAX_TICKADJ / HZ;
+		} else {
+			tick_nsec_curr += time_adjust * 1000 / HZ;
+			time_adjust = 0;
+		}
+	}
 }
 
 /* in the NTP reference this is called "hardclock()" */
 static void update_wall_time_one_tick(void)
 {
-	long time_adjust_step, delta_nsec;
+	long delta_nsec;
 
-	if ((time_adjust_step = time_adjust) != 0 ) {
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
-
-		/* Reduce by this step the amount of time left  */
-		time_adjust -= time_adjust_step;
-	}
-	delta_nsec = tick_nsec_curr + time_adjust_step * 1000;
+	delta_nsec = tick_nsec_curr;
 	/*
 	 * Advance the phase, once it gets to one microsecond, then
 	 * advance the tick more.
@@ -779,12 +775,6 @@ static void update_wall_time_one_tick(vo
 	}
 	xtime.tv_nsec += delta_nsec;
 	time_interpolator_update(delta_nsec);
-
-	/* Changes by adjtime() do not take effect till next tick. */
-	if (time_next_adjust != 0) {
-		time_adjust = time_next_adjust;
-		time_next_adjust = 0;
-	}
 }
 
 /*
