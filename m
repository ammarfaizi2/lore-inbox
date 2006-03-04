Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbWCDEoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbWCDEoP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 23:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbWCDEoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 23:44:15 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:42925 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751234AbWCDEoN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 23:44:13 -0500
Date: Fri, 3 Mar 2006 21:44:11 -0700
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: john stultz <johnstul@us.ibm.com>
Message-Id: <20060304044411.12782.37335.sendpatchset@cog.beaverton.ibm.com>
In-Reply-To: <20060304044404.12782.88641.sendpatchset@cog.beaverton.ibm.com>
References: <20060304044404.12782.88641.sendpatchset@cog.beaverton.ibm.com>
Subject: [PATCH 2/9] Time: Reduced NTP Rework (part 2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	This changes the interrupt time NTP code, breaking out the 
leapsecond processing and introduces an accessor to a shifted ppm 
adjustment value so they can be re-used by the generic timekeeping 
infrastructure.

For correctness, I've also introduced a new lock, the ntp_lock, which 
protects the NTP state machine when accessing it from the generic 
timekeeping code. Previously the xtime_lock is used to protect the NTP 
state variables, but since the generic timekeeping code does not 
utilize that lock, the new lock is necessary.

This should not affect the existing behavior, but just separate the 
logical functionality so it can be re-used by the generic timekeeping 
infrastructure.

thanks
-john

Signed-off-by: John Stultz <johnstul@us.ibm.com>

 include/linux/timex.h |   23 ++++++
 kernel/time.c         |    8 +-
 kernel/timer.c        |  180 +++++++++++++++++++++++++++++++++++---------------
 3 files changed, 154 insertions(+), 57 deletions(-)

linux-2.6.16-rc5_timeofday-ntp-part2_B20.patch
============================================
diff --git a/include/linux/timex.h b/include/linux/timex.h
index b7ca120..0eddf7b 100644
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
index 8045391..69bf208 100644
--- a/kernel/time.c
+++ b/kernel/time.c
@@ -259,6 +259,8 @@ int do_adjtimex(struct timex *txc)
 			return -EINVAL;
 
 	write_seqlock_irq(&xtime_lock);
+	write_seqlock(&ntp_lock);
+
 	result = time_state;	/* mostly `TIME_OK' */
 
 	/* Save for later - semantics of adjtime is to return old value */
@@ -396,6 +398,7 @@ leave:	if ((time_status & (STA_UNSYNC|ST
 	txc->calcnt	   = pps_calcnt;
 	txc->errcnt	   = pps_errcnt;
 	txc->stbcnt	   = pps_stbcnt;
+	write_sequnlock(&ntp_lock);
 	write_sequnlock_irq(&xtime_lock);
 	do_gettimeofday(&txc->time);
 	notify_arch_cmos_timer();
@@ -513,10 +516,7 @@ int do_settimeofday (struct timespec *tv
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
index 680fa7e..02a6d1d 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -583,7 +583,6 @@ long time_tolerance = MAXFREQ;		/* frequ
 long time_precision = 1;		/* clock precision (us)		*/
 long time_maxerror = NTP_PHASE_LIMIT;	/* maximum error (us)		*/
 long time_esterror = NTP_PHASE_LIMIT;	/* estimated error (us)		*/
-static long time_phase;			/* phase offset (scaled us)	*/
 long time_freq = (((NSEC_PER_SEC + HZ/2) % HZ - HZ/2) << SHIFT_USEC) / NSEC_PER_USEC;
 					/* frequency offset (scaled ppm)*/
 static long time_adj;			/* tick adjust (scaled 1 / HZ)	*/
@@ -591,76 +590,107 @@ long time_reftime;			/* time at last adj
 long time_adjust;
 long time_next_adjust;
 
-/*
- * this routine handles the overflow of the microsecond field
- *
- * The tricky bits of code to handle the accurate clock support
- * were provided by Dave Mills (Mills@UDEL.EDU) of NTP fame.
- * They were originally developed for SUN and DEC kernels.
- * All the kudos should go to Dave for this stuff.
+static long total_sppm;			/* shifted ppm sum of all adjustments */
+static long offset_adj_ppm;
+static long tick_adj_ppm;
+static long singleshot_adj_ppm;
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
  *
+ * Returns the number of seconds (-1, 0, or 1) that
+ * should be added to the current time to properly
+ * adjust for leapseconds.
  */
-static void second_overflow(void)
+int ntp_leapsecond(struct timespec now)
 {
-	long ltemp;
-
-	/* Bump the maxerror field */
-	time_maxerror += time_tolerance >> SHIFT_USEC;
-	if (time_maxerror > NTP_PHASE_LIMIT) {
-		time_maxerror = NTP_PHASE_LIMIT;
-		time_status |= STA_UNSYNC;
-	}
-
 	/*
-	 * Leap second processing. If in leap-insert state at the end of the
-	 * day, the system clock is set back one second; if in leap-delete
-	 * state, the system clock is set ahead one second. The microtime()
-	 * routine or external clock driver will insure that reported time is
-	 * always monotonic. The ugly divides should be replaced.
+	 * Leap second processing. If in leap-insert state at
+	 * the end of the day, the system clock is set back one
+	 * second; if in leap-delete state, the system clock is
+	 * set ahead one second.
 	 */
+	static time_t leaptime = 0;
+
+	unsigned long flags;
+	int ret = 0;
+
+	write_seqlock_irqsave(&ntp_lock, flags);
+
 	switch (time_state) {
+
 	case TIME_OK:
-		if (time_status & STA_INS)
+		if (time_status & STA_INS) {
 			time_state = TIME_INS;
-		else if (time_status & STA_DEL)
+			leaptime = END_OF_DAY(now.tv_sec);
+		} else if (time_status & STA_DEL) {
 			time_state = TIME_DEL;
+			leaptime = END_OF_DAY(now.tv_sec);
+		}
 		break;
+
 	case TIME_INS:
-		if (xtime.tv_sec % 86400 == 0) {
-			xtime.tv_sec--;
-			wall_to_monotonic.tv_sec++;
-			/*
-			 * The timer interpolator will make time change
-			 * gradually instead of an immediate jump by one second
-			 */
-			time_interpolator_update(-NSEC_PER_SEC);
+		/* Once we are at (or past) leaptime, insert the second */
+		if (now.tv_sec >= leaptime) {
 			time_state = TIME_OOP;
-			clock_was_set();
-			printk(KERN_NOTICE "Clock: inserting leap second "
-					"23:59:60 UTC\n");
+			printk(KERN_NOTICE "Clock: inserting leap second 23:59:60 UTC\n");
+			ret = -1;
 		}
 		break;
+
 	case TIME_DEL:
-		if ((xtime.tv_sec + 1) % 86400 == 0) {
-			xtime.tv_sec++;
-			wall_to_monotonic.tv_sec--;
-			/*
-			 * Use of time interpolator for a gradual change of
-			 * time
-			 */
-			time_interpolator_update(NSEC_PER_SEC);
+		/* Once we are at (or past) leaptime, delete the second */
+		if (now.tv_sec >= leaptime) {
 			time_state = TIME_WAIT;
-			clock_was_set();
-			printk(KERN_NOTICE "Clock: deleting leap second "
-					"23:59:59 UTC\n");
+			printk(KERN_NOTICE "Clock: deleting leap second 23:59:59 UTC\n");
+			ret = 1;
 		}
 		break;
+
 	case TIME_OOP:
+		/* Wait for the end of the leap second */
+		if (now.tv_sec > (leaptime + 1))
+			time_state = TIME_WAIT;
 		time_state = TIME_WAIT;
 		break;
+
 	case TIME_WAIT:
 		if (!(time_status & (STA_INS | STA_DEL)))
-		time_state = TIME_OK;
+			time_state = TIME_OK;
+		break;
+	}
+
+	write_sequnlock_irqrestore(&ntp_lock, flags);
+
+	return ret;
+}
+
+/*
+ * this routine handles the overflow of the nanosecond field
+ *
+ * The tricky bits of code to handle the accurate clock support
+ * were provided by Dave Mills (Mills@UDEL.EDU) of NTP fame.
+ * They were originally developed for SUN and DEC kernels.
+ * All the kudos should go to Dave for this stuff.
+ *
+ */
+static void second_overflow(void)
+{
+	long ltemp;
+
+	/* Bump the maxerror field */
+	time_maxerror += time_tolerance >> SHIFT_USEC;
+	if (time_maxerror > NTP_PHASE_LIMIT) {
+		time_maxerror = NTP_PHASE_LIMIT;
+		time_status |= STA_UNSYNC;
 	}
 
 	/*
@@ -678,6 +708,13 @@ static void second_overflow(void)
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
@@ -742,23 +779,36 @@ static long adjtime_adjustment(void)
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
+	long time_adjust_step;
+	unsigned long flags;
+
+	write_seqlock_irqsave(&ntp_lock, flags);
 
 	/* increment the interval sum: */
 	interval_sum += interval_ns;
 
+	time_adjust_step = adjtime_adjustment();
 	/* calculate the per tick singleshot adjtime adjustment step: */
 	while (interval_ns >= tick_nsec) {
-		time_adjust -= adjtime_adjustment();
+		time_adjust -= time_adjust_step;
 		interval_ns -= tick_nsec;
 	}
+	/* usec/tick => ppm: */
+	singleshot_adj_ppm = time_adjust_step*(1000000/HZ);
 
 	/* Changes by adjtime() do not take effect till next tick. */
 	if (time_next_adjust != 0) {
@@ -770,6 +820,14 @@ static void ntp_advance(unsigned long in
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
@@ -779,6 +837,8 @@ static void ntp_advance(unsigned long in
  */
 static inline long phase_advance(void)
 {
+	static long time_phase; /* phase offset (scaled us) */
+
 	long delta = 0;
 
 	time_phase += time_adj;
@@ -797,12 +857,28 @@ static inline long phase_advance(void)
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
