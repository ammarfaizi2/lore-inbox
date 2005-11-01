Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751351AbVKAWZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbVKAWZp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 17:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbVKAWZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 17:25:45 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:32976 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751351AbVKAWZo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 17:25:44 -0500
Subject: [RFC][PATCH 2/12] Reduced NTP rework (part 2)
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Darren Hart <dvhltc@us.ibm.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <1130883849.27168.458.camel@cog.beaverton.ibm.com>
References: <1130883795.27168.457.camel@cog.beaverton.ibm.com>
	 <1130883849.27168.458.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Tue, 01 Nov 2005 14:25:35 -0800
Message-Id: <1130883935.27168.461.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	Here is the second of two patches which try to minimize my ntp rework
patches.
	
This patch further changes the interrupt time NTP code, breaking out the
leapsecond processing and introduces an accessor to a shifted ppm
adjustment value. For correctness, I've also introduced a new lock, the
ntp_lock, which protects the NTP state machine when accessing it from my
timekeeping code (which does not use the xtime_lock).

Again, this patch should not affect the existing behavior, but just
separate the logical functionality so it can be re-used by my timeofday
patches.

thanks
-john

 include/linux/timex.h |   24 +++++++++
 kernel/time.c         |   25 +++++----
 kernel/timer.c        |  133 ++++++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 168 insertions(+), 14 deletions(-)

linux-2.6.14-rc5-mm1_timeofday-ntp-part2_B9.patch
============================================
diff --git a/include/linux/timex.h b/include/linux/timex.h
--- a/include/linux/timex.h
+++ b/include/linux/timex.h
@@ -260,6 +260,7 @@ extern long pps_calcnt;		/* calibration 
 extern long pps_errcnt;		/* calibration errors */
 extern long pps_stbcnt;		/* stability limit exceeded */
 
+extern seqlock_t ntp_lock;
 /**
  * ntp_clear - Clears the NTP state variables
  *
@@ -267,10 +268,14 @@ extern long pps_stbcnt;		/* stability li
  */
 static inline void ntp_clear(void)
 {
+	unsigned long flags;
+	write_seqlock_irqsave(&ntp_lock, flags);
 	time_adjust = 0;		/* stop active adjtime() */
 	time_status |= STA_UNSYNC;
 	time_maxerror = NTP_PHASE_LIMIT;
 	time_esterror = NTP_PHASE_LIMIT;
+	write_sequnlock_irqrestore(&ntp_lock, flags);
+
 }
 
 /**
@@ -282,6 +287,25 @@ static inline int ntp_synced(void)
 	return !(time_status & STA_UNSYNC);
 }
 
+/**
+ * ntp_get_ppm_adjustment - Returns Shifted PPM adjustment
+ *
+ */
+long ntp_get_ppm_adjustment(void);
+
+/**
+ * ntp_advance - Advances the NTP state machine by interval_ns
+ *
+ */
+void ntp_advance(unsigned long interval_ns);
+
+/**
+ * ntp_leapsecond - NTP leapsecond processing code.
+ *
+ */
+int ntp_leapsecond(struct timespec now);
+
+
 /* Required to safely shift negative values */
 #define shift_right(x, s) ({	\
 	__typeof__(x) __x = (x);	\
diff --git a/kernel/time.c b/kernel/time.c
--- a/kernel/time.c
+++ b/kernel/time.c
@@ -234,7 +234,9 @@ int do_adjtimex(struct timex *txc)
 {
         long ltemp, mtemp, save_adjust;
 	int result;
-
+	unsigned long flags;
+	struct timespec now_ts;
+	unsigned long seq;
 	/* In order to modify anything, you gotta be super-user! */
 	if (txc->modes && !capable(CAP_SYS_TIME))
 		return -EPERM;
@@ -257,7 +259,13 @@ int do_adjtimex(struct timex *txc)
 		    txc->tick > 1100000/USER_HZ)
 			return -EINVAL;
 
-	write_seqlock_irq(&xtime_lock);
+	do { /* save off current xtime */
+		seq = read_seqbegin(&xtime_lock);
+		now_ts = xtime;
+	} while (read_seqretry(&xtime_lock, seq));
+
+	write_seqlock_irqsave(&ntp_lock, flags);
+
 	result = time_state;	/* mostly `TIME_OK' */
 
 	/* Save for later - semantics of adjtime is to return old value */
@@ -334,9 +342,9 @@ int do_adjtimex(struct timex *txc)
 		     */
 
 		    if (time_status & STA_FREQHOLD || time_reftime == 0)
-		        time_reftime = xtime.tv_sec;
-		    mtemp = xtime.tv_sec - time_reftime;
-		    time_reftime = xtime.tv_sec;
+		        time_reftime = now_ts.tv_sec;
+		    mtemp = now_ts.tv_sec - time_reftime;
+		    time_reftime = now_ts.tv_sec;
 		    if (time_status & STA_FLL) {
 		        if (mtemp >= MINSEC) {
 			    ltemp = (time_offset / mtemp) << (SHIFT_USEC -
@@ -395,7 +403,7 @@ leave:	if ((time_status & (STA_UNSYNC|ST
 	txc->calcnt	   = pps_calcnt;
 	txc->errcnt	   = pps_errcnt;
 	txc->stbcnt	   = pps_stbcnt;
-	write_sequnlock_irq(&xtime_lock);
+	write_sequnlock_irqrestore(&ntp_lock, flags);
 	do_gettimeofday(&txc->time);
 	notify_arch_cmos_timer();
 	return(result);
@@ -512,10 +520,7 @@ int do_settimeofday (struct timespec *tv
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
@@ -591,6 +590,87 @@ long time_adjust;
 long time_next_adjust;
 long time_adjust_step;	/* per tick time_adjust step */
 
+long total_sppm;	/* shifted ppm sum of all NTP adjustments */
+long offset_adj_ppm;
+long tick_adj_ppm;
+long singleshot_adj_ppm;
+
+#define MAX_SINGLESHOT_ADJ 500 /* (ppm) */
+#define SEC_PER_DAY 86400
+#define END_OF_DAY(x) (x + SEC_PER_DAY - (x % SEC_PER_DAY) - 1)
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
+
+int ntp_leapsecond(struct timespec now)
+{
+	unsigned long flags;
+	/*
+	 * Leap second processing. If in leap-insert state at
+	 * the end of the day, the system clock is set back one
+	 * second; if in leap-delete state, the system clock is
+	 * set ahead one second.
+	 */
+	static time_t leaptime = 0;
+	int ret = 0;
+
+	write_seqlock_irqsave(&ntp_lock, flags);
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
+		/*  Wait for the end of the leap second*/
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
+	return 0;
+}
+
 /*
  * this routine handles the overflow of the microsecond field
  *
@@ -663,6 +743,13 @@ static void second_overflow(void)
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
@@ -678,6 +765,13 @@ static void second_overflow(void)
 	time_offset -= ltemp;
 	time_adj = ltemp << (SHIFT_SCALE - SHIFT_HZ - SHIFT_UPDATE);
 
+	offset_adj_ppm = shift_right(ltemp, SHIFT_UPDATE); /* ppm */
+
+	/* first calculate usec/user_tick offset */
+	tick_adj_ppm = ((USEC_PER_SEC + USER_HZ/2)/USER_HZ) - tick_usec;
+	/* multiply by user_hz to get usec/sec => ppm */
+	tick_adj_ppm *= USER_HZ;
+
 	/*
 	 * Compute the frequency estimate and additional phase adjustment due
 	 * to frequency error for the next second. When the PPS signal is
@@ -717,15 +811,25 @@ static void second_overflow(void)
 #endif
 }
 
+
 /**
- * ntp_advance() - increments the NTP state machine
+ * ntp_get_ppm_adjustment - Returns Shifted PPM adjustment
  *
- * Must be holding the xtime writelock when calling.
+ */
+long ntp_get_ppm_adjustment(void)
+{
+	return total_sppm;
+}
+
+/**
+ * ntp_advance() - increments the NTP state machine
  *
  */
-static void ntp_advance(unsigned long interval_ns)
+void ntp_advance(unsigned long interval_ns)
 {
 	static unsigned long interval_sum;
+	unsigned long flags;
+	write_seqlock_irqsave(&ntp_lock, flags);
 
 	/* increment the interval sum */
 	interval_sum += interval_ns;
@@ -752,6 +856,7 @@ static void ntp_advance(unsigned long in
 		}
 		interval_ns -= tick_nsec;
 	}
+	singleshot_adj_ppm = time_adjust_step*(1000000/HZ); /* usec/tick => ppm */
 
 	/* Changes by adjtime() do not take effect till next tick. */
 	if (time_next_adjust != 0) {
@@ -763,6 +868,15 @@ static void ntp_advance(unsigned long in
 		interval_sum -= NSEC_PER_SEC;
 		second_overflow();
 	}
+
+	/* calculate the total continuous ppm adjustment */
+	total_sppm = time_freq; /* already shifted by SHIFT_USEC */
+	total_sppm += offset_adj_ppm << SHIFT_USEC;
+	total_sppm += tick_adj_ppm << SHIFT_USEC;
+	total_sppm += singleshot_adj_ppm << SHIFT_USEC;
+
+	write_sequnlock_irqrestore(&ntp_lock, flags);
+
 }
 
 /*
@@ -775,6 +889,7 @@ static void ntp_advance(unsigned long in
 static void update_wall_time(unsigned long ticks)
 {
 	long delta_nsec;
+	static long time_phase; /* phase offset (scaled us)	*/
 
 	do {
 		ticks--;
@@ -798,8 +913,18 @@ static void update_wall_time(unsigned lo
 
 		xtime.tv_nsec += delta_nsec;
 		if (xtime.tv_nsec >= NSEC_PER_SEC) {
+			int leapsecond;
 			xtime.tv_nsec -= NSEC_PER_SEC;
 			xtime.tv_sec++;
+			/* process leapsecond */
+			leapsecond = ntp_leapsecond(xtime);
+			if (leapsecond) {
+				xtime.tv_sec += leapsecond;
+				wall_to_monotonic.tv_sec -= leapsecond;
+				/* Use of time interpolator for a gradual change of time */
+				time_interpolator_update(leapsecond*NSEC_PER_SEC);
+				clock_was_set();
+			}
 		}
 		ntp_advance(tick_nsec);
 		time_interpolator_update(delta_nsec);


