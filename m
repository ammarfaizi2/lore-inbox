Return-Path: <linux-kernel-owner+w=401wt.eu-S932345AbWLLUql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbWLLUql (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 15:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbWLLUql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 15:46:41 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:53850 "EHLO e3.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932345AbWLLUqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 15:46:40 -0500
Subject: [RFC] HZ free ntp
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0612061422190.1867@scrub.home>
References: <20061204204024.2401148d.akpm@osdl.org>
	 <Pine.LNX.4.64.0612060348150.1868@scrub.home>
	 <20061205203013.7073cb38.akpm@osdl.org>
	 <1165393929.24604.222.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0612061334230.1867@scrub.home>
	 <20061206131155.GA8558@elte.hu>
	 <Pine.LNX.4.64.0612061422190.1867@scrub.home>
Content-Type: text/plain
Date: Tue, 12 Dec 2006 12:40:20 -0800
Message-Id: <1165956021.20229.10.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-06 at 15:33 +0100, Roman Zippel wrote:
> On Wed, 6 Dec 2006, Ingo Molnar wrote:
> > i disagree with you and it's pretty low-impact anyway. There's still
> > quite many HZ/tick assumptions all around the time code (NTP being one
> > example), we'll deal with those via other patches.
> 
> Why do you pick on the NTP code? That's actually one of the places where
> assumptions about HZ are largely gone. NTP state is updated incrementally
> and this won't change, but the update frequency can now be easily
> disconnected from HZ.

Hey Roman,
	Here's my rough first attempt at doing so. I'd not call it easy, but
maybe you have some suggestions for a simpler way?

Basically INTERVAL_LENGTH_NSEC defines the NTP interval length that the
time code will use to accumulate with. In this patch I've pushed it out
to a full second, but it could be set via config (NSEC_PER_SEC/HZ for
regular systems, something larger for systems using dynticks).

Thoughts?

-john


diff --git a/include/linux/timex.h b/include/linux/timex.h
index db501dc..be13daf 100644
--- a/include/linux/timex.h
+++ b/include/linux/timex.h
@@ -286,9 +286,10 @@ #endif /* !CONFIG_TIME_INTERPOLATION */
 
 #define TICK_LENGTH_SHIFT	32
 
-/* Returns how long ticks are at present, in ns / 2^(SHIFT_SCALE-10). */
-extern u64 current_tick_length(void);
+#define INTERVAL_LENGTH_NSEC (NSEC_PER_SEC)
 
+/* Returns how long NTP intervals are at present, in ns / 2^(SHIFT_SCALE-10).*/
+extern u64 ntp_interval_length(void);
 extern void second_overflow(void);
 extern void update_ntp_one_tick(void);
 extern int do_adjtimex(struct timex *);
diff --git a/kernel/hrtimer.c b/kernel/hrtimer.c
index d0ba190..53979a9 100644
--- a/kernel/hrtimer.c
+++ b/kernel/hrtimer.c
@@ -127,12 +127,14 @@ EXPORT_SYMBOL_GPL(ktime_get_ts);
  */
 static void hrtimer_get_softirq_time(struct hrtimer_base *base)
 {
+	struct timespec ts;
 	ktime_t xtim, tomono;
 	unsigned long seq;
 
 	do {
 		seq = read_seqbegin(&xtime_lock);
-		xtim = timespec_to_ktime(xtime);
+		getnstimeofday(&ts);
+		xtim = timespec_to_ktime(ts);
 		tomono = timespec_to_ktime(wall_to_monotonic);
 
 	} while (read_seqretry(&xtime_lock, seq));
diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 3afeaa3..812c56f 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -20,11 +20,12 @@ #include <asm/timex.h>
  */
 unsigned long tick_usec = TICK_USEC; 		/* USER_HZ period (usec) */
 unsigned long tick_nsec;			/* ACTHZ period (nsec) */
-static u64 tick_length, tick_length_base;
+static u64 interval_length, interval_length_base;
 
 #define MAX_TICKADJ		500		/* microsecs */
-#define MAX_TICKADJ_SCALED	(((u64)(MAX_TICKADJ * NSEC_PER_USEC) << \
-				  TICK_LENGTH_SHIFT) / HZ)
+#define MAX_TICKADJ_SCALED \
+	((((u64)MAX_TICKADJ * NSEC_PER_USEC * INTERVAL_LENGTH_NSEC) \
+	/ NSEC_PER_SEC)<< TICK_LENGTH_SHIFT)
 
 /*
  * phase-lock loop variables
@@ -44,15 +45,45 @@ #define CLOCK_TICK_OVERFLOW	(LATCH * HZ 
 #define CLOCK_TICK_ADJUST	(((s64)CLOCK_TICK_OVERFLOW * NSEC_PER_SEC) / \
 					(s64)CLOCK_TICK_RATE)
 
+/**
+ * ntp_update_frequency - Calculates base values used for NTP adjustments
+ *
+ */
 static void ntp_update_frequency(void)
 {
-	tick_length_base = (u64)(tick_usec * NSEC_PER_USEC * USER_HZ) << TICK_LENGTH_SHIFT;
-	tick_length_base += (s64)CLOCK_TICK_ADJUST << TICK_LENGTH_SHIFT;
-	tick_length_base += (s64)time_freq << (TICK_LENGTH_SHIFT - SHIFT_NSEC);
-
-	do_div(tick_length_base, HZ);
-
-	tick_nsec = tick_length_base >> TICK_LENGTH_SHIFT;
+	u64 second_length;
+	s64 adj_length;
+	u64 tick_length;
+	int neg = 0;
+	/* calculate the length of one NTP adjusted second */
+	second_length = (u64)(tick_usec * NSEC_PER_USEC * USER_HZ);
+	second_length += (s64)CLOCK_TICK_ADJUST;
+	adj_length = (s64)time_freq;
+
+	/* calculate tick length @ HZ*/
+	tick_length = (second_length << TICK_LENGTH_SHIFT)
+			+ (adj_length << (TICK_LENGTH_SHIFT - SHIFT_NSEC));
+	do_div(tick_length, HZ);
+	tick_nsec = tick_length >> TICK_LENGTH_SHIFT;
+
+
+	/* calculate interval_length_base */
+	/* XXX - this is broken up to avoid 64bit overlfows */
+	interval_length_base = second_length * INTERVAL_LENGTH_NSEC;
+	interval_length_base <<= 2;
+	do_div(interval_length_base, NSEC_PER_SEC);
+	interval_length_base <<= TICK_LENGTH_SHIFT-2;
+
+	if (adj_length < 0) {
+		neg = 1;
+		adj_length = -adj_length;
+	}
+	adj_length *= INTERVAL_LENGTH_NSEC;
+	do_div(adj_length, NSEC_PER_SEC);
+	adj_length <<= (TICK_LENGTH_SHIFT - SHIFT_NSEC);
+	if(neg)
+		adj_length = -adj_length;
+	interval_length_base += adj_length;
 }
 
 /**
@@ -69,7 +100,7 @@ void ntp_clear(void)
 
 	ntp_update_frequency();
 
-	tick_length = tick_length_base;
+	interval_length = interval_length_base;
 	time_offset = 0;
 }
 
@@ -148,37 +179,39 @@ void second_overflow(void)
 	 * Compute the phase adjustment for the next second. The offset is
 	 * reduced by a fixed factor times the time constant.
 	 */
-	tick_length = tick_length_base;
+	interval_length = interval_length_base;
 	time_adj = shift_right(time_offset, SHIFT_PLL + time_constant);
 	time_offset -= time_adj;
-	tick_length += (s64)time_adj << (TICK_LENGTH_SHIFT - SHIFT_UPDATE);
+	interval_length += (s64)time_adj << (TICK_LENGTH_SHIFT - SHIFT_UPDATE);
 
 	if (unlikely(time_adjust)) {
 		if (time_adjust > MAX_TICKADJ) {
 			time_adjust -= MAX_TICKADJ;
-			tick_length += MAX_TICKADJ_SCALED;
+			interval_length += MAX_TICKADJ_SCALED;
 		} else if (time_adjust < -MAX_TICKADJ) {
 			time_adjust += MAX_TICKADJ;
-			tick_length -= MAX_TICKADJ_SCALED;
+			interval_length -= MAX_TICKADJ_SCALED;
 		} else {
-			tick_length += (s64)(time_adjust * NSEC_PER_USEC /
-					     HZ) << TICK_LENGTH_SHIFT;
+			u64 adjlen = ((s64)time_adjust * NSEC_PER_USEC
+				* INTERVAL_LENGTH_NSEC) << TICK_LENGTH_SHIFT;
+			do_div(adjlen, NSEC_PER_SEC);
+			interval_length += adjlen;
 			time_adjust = 0;
 		}
 	}
 }
 
 /*
- * Return how long ticks are at the moment, that is, how much time
- * update_wall_time_one_tick will add to xtime next time we call it
+ * Return how long NTP intervals are at the moment, that is, how
+ * much time update_wall_time will add to xtime next time we call it
  * (assuming no calls to do_adjtimex in the meantime).
  * The return value is in fixed-point nanoseconds shifted by the
  * specified number of bits to the right of the binary point.
  * This function has no side-effects.
  */
-u64 current_tick_length(void)
+u64 ntp_interval_length(void)
 {
-	return tick_length;
+	return interval_length;
 }
 
 
diff --git a/kernel/timer.c b/kernel/timer.c
index 0256ab4..3a9f2b4 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -890,7 +890,7 @@ void __init timekeeping_init(void)
 	ntp_clear();
 
 	clock = clocksource_get_next();
-	clocksource_calculate_interval(clock, tick_nsec);
+	clocksource_calculate_interval(clock, INTERVAL_LENGTH_NSEC);
 	clock->cycle_last = clocksource_read(clock);
 
 	write_sequnlock_irqrestore(&xtime_lock, flags);
@@ -980,7 +980,7 @@ static __always_inline int clocksource_b
 	 * Now calculate the error in (1 << look_ahead) ticks, but first
 	 * remove the single look ahead already included in the error.
 	 */
-	tick_error = current_tick_length() >>
+	tick_error = ntp_interval_length() >>
 		(TICK_LENGTH_SHIFT - clock->shift + 1);
 	tick_error -= clock->xtime_interval >> 1;
 	error = ((error - tick_error) >> look_ahead) + tick_error;
@@ -1077,7 +1077,7 @@ #endif
 						>> clock->shift);
 
 		/* accumulate error between NTP and clock interval */
-		clock->error += current_tick_length();
+		clock->error += ntp_interval_length();
 		clock->error -= clock->xtime_interval << (TICK_LENGTH_SHIFT - clock->shift);
 	}
 
@@ -1092,7 +1092,7 @@ #endif
 	if (change_clocksource()) {
 		clock->error = 0;
 		clock->xtime_nsec = 0;
-		clocksource_calculate_interval(clock, tick_nsec);
+		clocksource_calculate_interval(clock, INTERVAL_LENGTH_NSEC);
 	}
 }
 



