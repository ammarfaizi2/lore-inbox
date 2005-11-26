Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964779AbVKZOwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbVKZOwj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 09:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbVKZOwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 09:52:38 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:47316 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964779AbVKZOwh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 09:52:37 -0500
Date: Sat, 26 Nov 2005 15:52:43 +0100
From: Ingo Molnar <mingo@elte.hu>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Darren Hart <dvhltc@us.ibm.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/13] Time: Reduced NTP rework (part 1)
Message-ID: <20051126145243.GC12999@elte.hu>
References: <20051122013515.18537.76463.sendpatchset@cog.beaverton.ibm.com> <20051122013522.18537.97944.sendpatchset@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051122013522.18537.97944.sendpatchset@cog.beaverton.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- clean up the impact of timeofday-ntp-part1.patch

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 kernel/timer.c |  138 ++++++++++++++++++++++++++++++++++-----------------------
 1 files changed, 83 insertions(+), 55 deletions(-)

Index: linux/kernel/timer.c
===================================================================
--- linux.orig/kernel/timer.c
+++ linux/kernel/timer.c
@@ -623,9 +623,9 @@ static long time_adj;			/* tick adjust (
 long time_reftime;			/* time at last adjustment (s)	*/
 long time_adjust;
 long time_next_adjust;
-long time_adjust_step;	/* per tick time_adjust step */
+long time_adjust_step;			/* per tick time_adjust step */
 
-long total_sppm;	/* shifted ppm sum of all NTP adjustments */
+long total_sppm;			/* shifted ppm sum of all adjustments */
 long offset_adj_ppm;
 long tick_adj_ppm;
 long singleshot_adj_ppm;
@@ -848,8 +848,7 @@ static void second_overflow(void)
 
 
 /**
- * ntp_get_ppm_adjustment - Returns Shifted PPM adjustment
- *
+ * ntp_get_ppm_adjustment - return shifted PPM adjustment
  */
 long ntp_get_ppm_adjustment(void)
 {
@@ -857,41 +856,45 @@ long ntp_get_ppm_adjustment(void)
 }
 
 /**
- * ntp_advance() - increments the NTP state machine
- *
+ * ntp_advance - increments the NTP state machine
+ * @interval_ns: interval, in nanoseconds
  */
 void ntp_advance(unsigned long interval_ns)
 {
 	static unsigned long interval_sum;
+
 	unsigned long flags;
+
 	write_seqlock_irqsave(&ntp_lock, flags);
 
-	/* increment the interval sum */
+	/* increment the interval sum: */
 	interval_sum += interval_ns;
 
-	/* calculate the per tick singleshot adjtime adjustment step */
+	/* calculate the per tick singleshot adjtime adjustment step: */
 	while (interval_ns >= tick_nsec) {
 		time_adjust_step = time_adjust;
 		if (time_adjust_step) {
-	    		/* We are doing an adjtime thing.
-	     		 *
+			/*
+			 * We are doing an adjtime thing.
+			 *
 			 * Prepare time_adjust_step to be within bounds.
 			 * Note that a positive time_adjust means we want
 			 * the clock to run faster.
 			 *
-		    	 * Limit the amount of the step to be in the range
-			 * -tickadj .. +tickadj
+			 * Limit the amount of the step to be in the range
+			 * -tickadj .. +tickadj:
 			 */
-	    		time_adjust_step = min(time_adjust_step, (long)tickadj);
+			time_adjust_step = min(time_adjust_step, (long)tickadj);
 			time_adjust_step = max(time_adjust_step,
 							 (long)-tickadj);
 
-			/* Reduce by this step the amount of time left  */
-		    	time_adjust -= time_adjust_step;
+			/* Reduce by this step the amount of time left: */
+			time_adjust -= time_adjust_step;
 		}
 		interval_ns -= tick_nsec;
 	}
-	singleshot_adj_ppm = time_adjust_step*(1000000/HZ); /* usec/tick => ppm */
+	/* usec/tick => ppm: */
+	singleshot_adj_ppm = time_adjust_step*(1000000/HZ);
 
 	/* Changes by adjtime() do not take effect till next tick. */
 	if (time_next_adjust != 0) {
@@ -904,71 +907,96 @@ void ntp_advance(unsigned long interval_
 		second_overflow();
 	}
 
-	/* calculate the total continuous ppm adjustment */
+	/* calculate the total continuous ppm adjustment: */
 	total_sppm = time_freq; /* already shifted by SHIFT_USEC */
 	total_sppm += offset_adj_ppm << SHIFT_USEC;
 	total_sppm += tick_adj_ppm << SHIFT_USEC;
 	total_sppm += singleshot_adj_ppm << SHIFT_USEC;
 
 	write_sequnlock_irqrestore(&ntp_lock, flags);
+}
+
+#ifdef CONFIG_GENERIC_TIME
+# define update_wall_time(x) do { } while (0)
+#else
+
+/**
+ * phase_advance - advance the phase
+ * @time_adj: adjustment in nsecs
+ *
+ * advance the phase, once it gets to one microsecond advance the tick more.
+ */
+static inline long phase_advance(long time_adj)
+{
+	long delta = 0;
+
+	time_phase += time_adj;
+
+	if ((time_phase >= FINENSEC) || (time_phase <= -FINENSEC)) {
+		delta = shift_right(time_phase, (SHIFT_SCALE - 10));
+		time_phase -= delta << (SHIFT_SCALE - 10);
+	}
+
+	return delta;
+}
+
+/**
+ * xtime_advance - advance xtime
+ * @delta_nsec: adjustment in nsecs
+ */
+static inline void xtime_advance(long delta_nsec)
+{
+	int leapsecond;
+
+	xtime.tv_nsec += delta_nsec;
+	if (likely(xtime.tv_nsec < NSEC_PER_SEC))
+		return;
 
+	xtime.tv_nsec -= NSEC_PER_SEC;
+	xtime.tv_sec++;
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
 
-#ifndef CONFIG_GENERIC_TIME
 /*
  * Using a loop looks inefficient, but "ticks" is
  * usually just one (we shouldn't be losing ticks,
  * we're doing this this way mainly for interrupt
  * latency reasons, not because we think we'll
- * have lots of lost timer ticks
+ * have lots of lost timer ticks)
  */
 static void update_wall_time(unsigned long ticks)
 {
-	long delta_nsec;
-	static long time_phase; /* phase offset (scaled us)	*/
+	static long time_phase; /* phase offset (scaled us) */
 
 	do {
-		ticks--;
-
-		/* Calculate the nsec delta using the
-		 * precomputed NTP adjustments:
-		 *     tick_nsec, time_adjust_step, time_adj
-		 */
-		delta_nsec = tick_nsec + time_adjust_step * 1000;
 		/*
-		 * Advance the phase, once it gets to one microsecond, then
-		 * advance the tick more.
+		 * Calculate the nsec delta using the precomputed NTP
+		 * adjustments:
+		 *     tick_nsec, time_adjust_step, time_adj
 		 */
-		time_phase += time_adj;
-		if ((time_phase >= FINENSEC) || (time_phase <= -FINENSEC)) {
-			long ltemp = shift_right(time_phase,
-							(SHIFT_SCALE - 10));
-			time_phase -= ltemp << (SHIFT_SCALE - 10);
-			delta_nsec += ltemp;
-		}
+		long delta_nsec = tick_nsec + time_adjust_step * 1000;
 
-		xtime.tv_nsec += delta_nsec;
-		if (xtime.tv_nsec >= NSEC_PER_SEC) {
-			int leapsecond;
-			xtime.tv_nsec -= NSEC_PER_SEC;
-			xtime.tv_sec++;
-			/* process leapsecond */
-			leapsecond = ntp_leapsecond(xtime);
-			if (leapsecond) {
-				xtime.tv_sec += leapsecond;
-				wall_to_monotonic.tv_sec -= leapsecond;
-				/* Use of time interpolator for a gradual change of time */
-				time_interpolator_update(leapsecond*NSEC_PER_SEC);
-				clock_was_set();
-			}
-		}
+		delta_nsec += phase_advance();
+
+		xtime_advance(delta_nsec);
 		ntp_advance(tick_nsec);
 		time_interpolator_update(delta_nsec);
 
-	} while (ticks);
+	} while (--ticks);
 }
-#else /* !CONFIG_GENERIC_TIME */
-#define update_wall_time(x)
 #endif /* !CONFIG_GENERIC_TIME */
 
 /*
