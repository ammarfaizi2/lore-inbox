Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932407AbWHJAQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbWHJAQF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 20:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbWHJAPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 20:15:42 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:14730 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932431AbWHJAPh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 20:15:37 -0400
Message-Id: <20060810001113.617857000@linux-m68k.org>
References: <20060810000146.913645000@linux-m68k.org>
User-Agent: quilt/0.45-1
Date: Thu, 10 Aug 2006 02:01:47 +0200
From: zippel@linux-m68k.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
Subject: [NTP 1/9] add ntp_update_frequency
Content-Disposition: inline; filename=0001-NTP-add-ntp_update_frequency.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces ntp_update_frequency() and deinlines ntp_clear() (as
it's not performance critical).
ntp_update_frequency() calculates the base tick length using tick_usec
and adds a base adjustment, in case the frequency doesn't divide evenly
by HZ.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
---
 include/linux/timex.h |   14 ++------------
 kernel/time/ntp.c     |   50 ++++++++++++++++++++++++++++++++++++++++++++------
 kernel/timer.c        |   11 ++++-------
 3 files changed, 50 insertions(+), 25 deletions(-)

Index: linux-2.6-mm/include/linux/timex.h
===================================================================
--- linux-2.6-mm.orig/include/linux/timex.h
+++ linux-2.6-mm/include/linux/timex.h
@@ -218,18 +218,8 @@ extern long time_reftime;	/* time at las
 extern long time_adjust;	/* The amount of adjtime left */
 extern long time_next_adjust;	/* Value for time_adjust at next tick */
 
-/**
- * ntp_clear - Clears the NTP state variables
- *
- * Must be called while holding a write on the xtime_lock
- */
-static inline void ntp_clear(void)
-{
-	time_adjust = 0;		/* stop active adjtime() */
-	time_status |= STA_UNSYNC;
-	time_maxerror = NTP_PHASE_LIMIT;
-	time_esterror = NTP_PHASE_LIMIT;
-}
+extern void ntp_clear(void);
+extern void ntp_update_frequency(void);
 
 /**
  * ntp_synced - Returns 1 if the NTP status is not UNSYNC
Index: linux-2.6-mm/kernel/time/ntp.c
===================================================================
--- linux-2.6-mm.orig/kernel/time/ntp.c
+++ linux-2.6-mm/kernel/time/ntp.c
@@ -21,6 +21,13 @@ void time_interpolator_update(long delta
 #define time_interpolator_update(x)
 #endif
 
+/*
+ * Timekeeping variables
+ */
+unsigned long tick_usec = TICK_USEC; 		/* USER_HZ period (usec) */
+unsigned long tick_nsec;			/* ACTHZ period (nsec) */
+static u64 tick_length, tick_length_base;
+
 /* Don't completely fail for HZ > 500.  */
 int tickadj = 500/HZ ? : 1;		/* microsecs */
 
@@ -43,6 +50,36 @@ long time_reftime;			/* time at last adj
 long time_adjust;
 long time_next_adjust;
 
+/**
+ * ntp_clear - Clears the NTP state variables
+ *
+ * Must be called while holding a write on the xtime_lock
+ */
+void ntp_clear(void)
+{
+	time_adjust = 0;		/* stop active adjtime() */
+	time_status |= STA_UNSYNC;
+	time_maxerror = NTP_PHASE_LIMIT;
+	time_esterror = NTP_PHASE_LIMIT;
+
+	ntp_update_frequency();
+
+	tick_length = tick_length_base;
+}
+
+#define CLOCK_TICK_OVERFLOW	(LATCH * HZ - CLOCK_TICK_RATE)
+#define CLOCK_TICK_ADJUST	(((s64)CLOCK_TICK_OVERFLOW * NSEC_PER_SEC) / CLOCK_TICK_RATE)
+
+void ntp_update_frequency(void)
+{
+	tick_length_base = (u64)(tick_usec * NSEC_PER_USEC * USER_HZ) << TICK_LENGTH_SHIFT;
+	tick_length_base += (s64)CLOCK_TICK_ADJUST << TICK_LENGTH_SHIFT;
+
+	do_div(tick_length_base, HZ);
+
+	tick_nsec = tick_length_base >> TICK_LENGTH_SHIFT;
+}
+
 /*
  * this routine handles the overflow of the microsecond field
  *
@@ -157,6 +194,7 @@ void second_overflow(void)
 	 */
 	time_adj += shift_right(time_adj, 6) + shift_right(time_adj, 7);
 #endif
+	tick_length = tick_length_base;
 }
 
 /*
@@ -210,14 +248,13 @@ void update_ntp_one_tick(void)
  */
 u64 current_tick_length(void)
 {
-	long delta_nsec;
 	u64 ret;
 
 	/* calculate the finest interval NTP will allow.
 	 *    ie: nanosecond value shifted by (SHIFT_SCALE - 10)
 	 */
-	delta_nsec = tick_nsec + adjtime_adjustment() * 1000;
-	ret = (u64)delta_nsec << TICK_LENGTH_SHIFT;
+	ret = tick_length;
+	ret += (u64)(adjtime_adjustment() * 1000) << TICK_LENGTH_SHIFT;
 	ret += (s64)time_adj << (TICK_LENGTH_SHIFT - (SHIFT_SCALE - 10));
 
 	return ret;
@@ -357,10 +394,11 @@ int do_adjtimex(struct timex *txc)
 		    time_freq = max(time_freq, -time_tolerance);
 		} /* STA_PLL */
 	    } /* txc->modes & ADJ_OFFSET */
-	    if (txc->modes & ADJ_TICK) {
+	    if (txc->modes & ADJ_TICK)
 		tick_usec = txc->tick;
-		tick_nsec = TICK_USEC_TO_NSEC(tick_usec);
-	    }
+
+	    if (txc->modes & ADJ_TICK)
+		    ntp_update_frequency();
 	} /* txc->modes */
 leave:	if ((time_status & (STA_UNSYNC|STA_CLOCKERR)) != 0)
 		result = TIME_ERROR;
Index: linux-2.6-mm/kernel/timer.c
===================================================================
--- linux-2.6-mm.orig/kernel/timer.c
+++ linux-2.6-mm/kernel/timer.c
@@ -568,12 +568,6 @@ found:
 
 /******************************************************************/
 
-/*
- * Timekeeping variables
- */
-unsigned long tick_usec = TICK_USEC; 		/* USER_HZ period (usec) */
-unsigned long tick_nsec = TICK_NSEC;		/* ACTHZ period (nsec) */
-
 /* 
  * The current time 
  * wall_to_monotonic is what we need to add to xtime (or xtime corrected 
@@ -763,10 +757,13 @@ void __init timekeeping_init(void)
 	unsigned long flags;
 
 	write_seqlock_irqsave(&xtime_lock, flags);
+
+	ntp_clear();
+
 	clock = clocksource_get_next();
 	clocksource_calculate_interval(clock, tick_nsec);
 	clock->cycle_last = clocksource_read(clock);
-	ntp_clear();
+
 	write_sequnlock_irqrestore(&xtime_lock, flags);
 }
 

--

