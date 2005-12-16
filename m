Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbVLPBI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbVLPBI2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 20:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbVLPBH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 20:07:59 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:2447 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751257AbVLPBHP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 20:07:15 -0500
Date: Thu, 15 Dec 2005 18:07:13 -0700
From: john stultz <johnstul@us.ibm.com>
To: akpm@osdl.org
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>, johnstul@us.ibm.com,
       john stultz <johnstul@us.ibm.com>
Message-Id: <20051216010712.19280.58044.sendpatchset@cog.beaverton.ibm.com>
In-Reply-To: <20051216010700.19280.66934.sendpatchset@cog.beaverton.ibm.com>
References: <20051216010700.19280.66934.sendpatchset@cog.beaverton.ibm.com>
Subject: [PATCH 2/11] Time: Reduced NTP Rework (part 2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, All,
	Here is the second of two patches which try to minimize my ntp 
rework patches.
	
This patch further changes the interrupt time NTP code, breaking out 
the leapsecond processing and introduces an accessor to a shifted ppm 
adjustment value. For correctness, I've also introduced a new lock, the 
ntp_lock, which protects the NTP state machine when accessing it from 
my timekeeping code (which does not use the xtime_lock).

Again, this patch should not affect the existing behavior, but just 
separate the logical functionality so it can be re-used by my timeofday 
patches.

Andrew, please consider for inclusion into your tree.

thanks
-john

Signed-off-by: John Stultz <johnstul@us.ibm.com>

 include/linux/timex.h |   23 +++++++
 kernel/time.c         |    8 +-
 kernel/timer.c        |  144 ++++++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 165 insertions(+), 10 deletions(-)

linux-2.6.15-rc5_timeofday-ntp-part2_B14.patch
============================================
diff --git a/include/linux/timex.h b/include/linux/timex.h
index 04a4a8c..e35c683 100644
--- a/include/linux/timex.h
+++ b/include/linux/timex.h
@@ -260,6 +260,8 @@ extern long pps_calcnt;		/* calibration 
 extern long pps_errcnt;		/* calibration errors */
 extern long pps_stbcnt;		/* stability limit exceeded */
 
+extern seqlock_t ntp_lock;
+
 /**
  * ntp_clear - Clears the NTP state variables
  *
@@ -267,21 +269,40 @@ extern long pps_stbcnt;		/* stability li
  */
 static inline void ntp_clear(void)
 {
+	unsigned long flags;
+
+	write_seqlock_irqsave(&ntp_lock, flags);
 	time_adjust = 0;		/* stop active adjtime() */
 	time_status |= STA_UNSYNC;
 	time_maxerror = NTP_PHASE_LIMIT;
 	time_esterror = NTP_PHASE_LIMIT;
+	write_sequnlock_irqrestore(&ntp_lock, flags);
 }
 
 /**
  * ntp_synced - Returns 1 if the NTP status is not UNSYNC
- *
  */
 static inline int ntp_synced(void)
 {
 	return !(time_status & STA_UNSYNC);
 }
 
+/**
+ * ntp_get_ppm_adjustment - Returns Shifted PPM adjustment
+ */
+extern long ntp_get_ppm_adjustment(void);
+
+/**
+ * ntp_advance - Advances the NTP state machine by interval_ns
+ */
+extern void ntp_advance(unsigned long interval_ns);
+
+/**
+ * ntp_leapsecond - NTP leapsecond processing code.
+ */
+extern int ntp_leapsecond(struct timespec now);
+
+
 /* Required to safely shift negative values */
 #define shift_right(x, s) ({	\
 	__typeof__(x) __x = (x);	\
diff --git a/kernel/time.c b/kernel/time.c
index cf5a458..6529064 100644
--- a/kernel/time.c
+++ b/kernel/time.c
@@ -258,6 +258,8 @@ int do_adjtimex(struct timex *txc)
 			return -EINVAL;
 
 	write_seqlock_irq(&xtime_lock);
+	write_seqlock(&ntp_lock);
+
 	result = time_state;	/* mostly `TIME_OK' */
 
 	/* Save for later - semantics of adjtime is to return old value */
@@ -395,6 +397,7 @@ leave:	if ((time_status & (STA_UNSYNC|ST
 	txc->calcnt	   = pps_calcnt;
 	txc->errcnt	   = pps_errcnt;
 	txc->stbcnt	   = pps_stbcnt;
+	write_sequnlock(&ntp_lock);
 	write_sequnlock_irq(&xtime_lock);
 	do_gettimeofday(&txc->time);
 	notify_arch_cmos_timer();
@@ -512,10 +515,7 @@ int do_settimeofday (struct timespec *tv
 		set_normalized_timespec(&xtime, sec, nsec);
 		set_normalized_timespec(&wall_to_monotonic, wtm_sec, wtm_nsec);
 
-		time_adjust = 0;		/* stop active adjtime() */
-		time_status |= STA_UNSYNC;
-		time_maxerror = NTP_PHASE_LIMIT;
-		time_esterror = NTP_PHASE_LIMIT;
+		ntp_clear();
 		time_interpolator_reset();
 	}
 	write_sequnlock_irq(&xtime_lock);
diff --git a/kernel/timer.c b/kernel/timer.c
index 2a0a549..a543d54 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -582,7 +582,6 @@ long time_tolerance = MAXFREQ;		/* frequ
 long time_precision = 1;		/* clock precision (us)		*/
 long time_maxerror = NTP_PHASE_LIMIT;	/* maximum error (us)		*/
 long time_esterror = NTP_PHASE_LIMIT;	/* estimated error (us)		*/
-static long time_phase;			/* phase offset (scaled us)	*/
 long time_freq = (((NSEC_PER_SEC + HZ/2) % HZ - HZ/2) << SHIFT_USEC) / NSEC_PER_USEC;
 					/* frequency offset (scaled ppm)*/
 static long time_adj;			/* tick adjust (scaled 1 / HZ)	*/
@@ -591,8 +590,91 @@ long time_adjust;
 long time_next_adjust;
 long time_adjust_step;			/* per tick time_adjust step */
 
+long total_sppm;			/* shifted ppm sum of all adjustments */
+long offset_adj_ppm;
+long tick_adj_ppm;
+long singleshot_adj_ppm;
+
+#define MAX_SINGLESHOT_ADJ	500	/* (ppm) */
+#define SEC_PER_DAY		86400
+#define END_OF_DAY(x)		((x) + SEC_PER_DAY - ((x) % SEC_PER_DAY) - 1)
+
+/* NTP lock, protects NTP state machine */
+seqlock_t ntp_lock = SEQLOCK_UNLOCKED;
+
+/**
+ * ntp_leapsecond - NTP leapsecond processing code.
+ * now: the current time
+ *
+ * Returns the number of seconds (-1, 0, or 1) that
+ * should be added to the current time to properly
+ * adjust for leapseconds.
+ */
+int ntp_leapsecond(struct timespec now)
+{
+	/*
+	 * Leap second processing. If in leap-insert state at
+	 * the end of the day, the system clock is set back one
+	 * second; if in leap-delete state, the system clock is
+	 * set ahead one second.
+	 */
+	static time_t leaptime = 0;
+
+	unsigned long flags;
+	int ret = 0;
+
+	write_seqlock_irqsave(&ntp_lock, flags);
+
+	switch (time_state) {
+
+	case TIME_OK:
+		if (time_status & STA_INS) {
+			time_state = TIME_INS;
+			leaptime = END_OF_DAY(now.tv_sec);
+		} else if (time_status & STA_DEL) {
+			time_state = TIME_DEL;
+			leaptime = END_OF_DAY(now.tv_sec);
+		}
+		break;
+
+	case TIME_INS:
+		/* Once we are at (or past) leaptime, insert the second */
+		if (now.tv_sec >= leaptime) {
+			time_state = TIME_OOP;
+			printk(KERN_NOTICE "Clock: inserting leap second 23:59:60 UTC\n");
+			ret = -1;
+		}
+		break;
+
+	case TIME_DEL:
+		/* Once we are at (or past) leaptime, delete the second */
+		if (now.tv_sec >= leaptime) {
+			time_state = TIME_WAIT;
+			printk(KERN_NOTICE "Clock: deleting leap second 23:59:59 UTC\n");
+			ret = 1;
+		}
+		break;
+
+	case TIME_OOP:
+		/* Wait for the end of the leap second */
+		if (now.tv_sec > (leaptime + 1))
+			time_state = TIME_WAIT;
+		time_state = TIME_WAIT;
+		break;
+
+	case TIME_WAIT:
+		if (!(time_status & (STA_INS | STA_DEL)))
+			time_state = TIME_OK;
+		break;
+	}
+
+	write_sequnlock_irqrestore(&ntp_lock, flags);
+
+	return ret;
+}
+
 /*
- * this routine handles the overflow of the microsecond field
+ * this routine handles the overflow of the nanosecond field
  *
  * The tricky bits of code to handle the accurate clock support
  * were provided by Dave Mills (Mills@UDEL.EDU) of NTP fame.
@@ -663,6 +745,13 @@ static void second_overflow(void)
 		time_state = TIME_OK;
 	}
 
+	/* Bump the maxerror field */
+	time_maxerror += time_tolerance >> SHIFT_USEC;
+	if ( time_maxerror > NTP_PHASE_LIMIT ) {
+		time_maxerror = NTP_PHASE_LIMIT;
+		time_status |= STA_UNSYNC;
+	}
+
 	/*
 	 * Compute the phase adjustment for the next second. In PLL mode, the
 	 * offset is reduced by a fixed factor times the time constant. In FLL
@@ -678,6 +767,13 @@ static void second_overflow(void)
 	time_offset -= ltemp;
 	time_adj = ltemp << (SHIFT_SCALE - SHIFT_HZ - SHIFT_UPDATE);
 
+	offset_adj_ppm = shift_right(ltemp, SHIFT_UPDATE); /* ppm */
+
+	/* first calculate usec/user_tick offset: */
+	tick_adj_ppm = ((USEC_PER_SEC + USER_HZ/2)/USER_HZ) - tick_usec;
+	/* multiply by user_hz to get usec/sec => ppm: */
+	tick_adj_ppm *= USER_HZ;
+
 	/*
 	 * Compute the frequency estimate and additional phase adjustment due
 	 * to frequency error for the next second. When the PPS signal is
@@ -718,15 +814,25 @@ static void second_overflow(void)
 }
 
 /**
+ * ntp_get_ppm_adjustment - return shifted PPM adjustment
+ */
+long ntp_get_ppm_adjustment(void)
+{
+	return total_sppm;
+}
+
+/**
  * ntp_advance - increments the NTP state machine
  * @interval_ns: interval, in nanoseconds
- *
- * Must be holding the xtime writelock when calling.
  */
-static void ntp_advance(unsigned long interval_ns)
+void ntp_advance(unsigned long interval_ns)
 {
 	static unsigned long interval_sum;
 
+	unsigned long flags;
+
+	write_seqlock_irqsave(&ntp_lock, flags);
+
 	/* increment the interval sum: */
 	interval_sum += interval_ns;
 
@@ -753,6 +859,8 @@ static void ntp_advance(unsigned long in
 		}
 		interval_ns -= tick_nsec;
 	}
+	/* usec/tick => ppm: */
+	singleshot_adj_ppm = time_adjust_step*(1000000/HZ);
 
 	/* Changes by adjtime() do not take effect till next tick. */
 	if (time_next_adjust != 0) {
@@ -764,6 +872,14 @@ static void ntp_advance(unsigned long in
 		interval_sum -= NSEC_PER_SEC;
 		second_overflow();
 	}
+
+	/* calculate the total continuous ppm adjustment: */
+	total_sppm = time_freq; /* already shifted by SHIFT_USEC */
+	total_sppm += offset_adj_ppm << SHIFT_USEC;
+	total_sppm += tick_adj_ppm << SHIFT_USEC;
+	total_sppm += singleshot_adj_ppm << SHIFT_USEC;
+
+	write_sequnlock_irqrestore(&ntp_lock, flags);
 }
 
 /**
@@ -773,6 +889,8 @@ static void ntp_advance(unsigned long in
  */
 static inline long phase_advance(void)
 {
+	static long time_phase; /* phase offset (scaled us) */
+
 	long delta = 0;
 
 	time_phase += time_adj;
@@ -791,12 +909,28 @@ static inline long phase_advance(void)
  */
 static inline void xtime_advance(long delta_nsec)
 {
+	int leapsecond;
+
 	xtime.tv_nsec += delta_nsec;
 	if (likely(xtime.tv_nsec < NSEC_PER_SEC))
 		return;
 
 	xtime.tv_nsec -= NSEC_PER_SEC;
 	xtime.tv_sec++;
+
+	/* process leapsecond: */
+	leapsecond = ntp_leapsecond(xtime);
+	if (likely(!leapsecond))
+		return;
+
+	xtime.tv_sec += leapsecond;
+	wall_to_monotonic.tv_sec -= leapsecond;
+	/*
+	 * Use of time interpolator for a gradual
+	 * change of time:
+	 */
+	time_interpolator_update(leapsecond*NSEC_PER_SEC);
+	clock_was_set();
 }
 
 /*
