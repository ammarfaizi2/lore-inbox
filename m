Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751817AbWBRBTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817AbWBRBTK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 20:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751816AbWBRBTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 20:19:10 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:26794 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751817AbWBRBTI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 20:19:08 -0500
Subject: [RFC][PATCH] Time: Experimental improved ntp error accounting for
	TOD work
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, george@wildturkeyranch.net
Content-Type: text/plain
Date: Fri, 17 Feb 2006 17:19:04 -0800
Message-Id: <1140225544.2401.16.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All, 
	This includes suggestions from Roman on improving the NTP error 
accounting done by the timekeeping core. Currently this is a very ugly 
patch, that hurts the code's readability (which should not to be taken 
as a slight against Roman, this is my own interpretation of his 
suggestion) but I wanted to get it out for review and comment. I've 
added lots of comments just to document my current concerns that will 
be removed in the future, as well a number of spots where Roman's NTP 
patches will hopefully be used.

The patch drops the ntp_adj value, letting the code adjust the 
clocksource multiplier directly, and also uses clock shifted 
nanoseconds in a few places.

Unfortunately this patch does not apply against the current -mm tree, so
you will have to grab the full patchset from:
http://sr71.net/~jstultz/tod/ to play with this.

Anyway, I'm kicking it out because I don't want to sit on it any 
longer. I think I've got the bugs out of it, but I'm sure it needs more 
work.

Flame on.

thanks
-john

Signed-off-by: John Stultz <johnstul@us.ibm.com>

 Documentation/timekeeping.txt   |   22 +---
 include/asm-generic/timeofday.h |    5 -
 include/linux/clocksource.h     |  185 +++++++++++++++++++---------------------
 kernel/time/timeofday.c         |  140 ++++++++++++++----------------
 4 files changed, 167 insertions(+), 185 deletions(-)

linux-2.6.16-rc4_timeofday-ntp-error-fix_B19.patch
============================================
diff --git a/Documentation/timekeeping.txt b/Documentation/timekeeping.txt
index 23a5d9d..4ac91b2 100644
--- a/Documentation/timekeeping.txt
+++ b/Documentation/timekeeping.txt
@@ -37,12 +37,6 @@ this value in cycle_last.
 cycle_t cycle_last;
 
 
-Further since all clocks drift somewhat from each other, we use the adjustment
-values provided via adjtimex() to correct our clocksource frequency for each
-interval. This frequency adjustment value is stored in ntp_adj.
-
-long ntp_adj;
-
 Now that we've covered the core global variables for timekeeping, lets look at
 how we maintain these values.
 
@@ -54,7 +48,7 @@ presented as:
 timeofday_periodic_hook():
 	cycle_now = read_clocksource(clock)
 	cycle_delta = (cycle_now - cycle_last) & clock->mask
-	nsec = cyc2ns(clock, cycle_delta, ntp_adj)
+	nsec = cyc2ns(clock, cycle_delta)
 	system_time += nsec
 	cycle_last = cycle_now
 
@@ -62,10 +56,9 @@ timeofday_periodic_hook():
 
 You can see we read the cycle value from the clocksource, calculate a cycle
 delta for the interval since we last called timeofday_periodic_hook(), convert
-that cycle delta to a nanosecond interval (for now ignore ntp_adj), add it to
-the system time and finally set our cycle_last value to cycle_now for the next
-interval. Using this simple algorithm we can correctly measure and record the
-passing of time.
+that cycle delta to a nanosecond interval, add it to the system time and finally
+set our cycle_last value to cycle_now for the next interval. Using this simple
+algorithm we can correctly measure and record the passing of time.
 
 But just storing this info isn't very useful, we also want to make it available
 to be used elsewhere. So how do we provide a notion of how much time has passed
@@ -77,7 +70,7 @@ timeofday_peridoic_hook().
 get_nsec_offset():
 	cycle_now = read_clocksource(clock)
 	cycle_delta = (cycle_now - cycle_last) & clock->mask
-	nsec = cyc2ns(clock, cycle_delta, ntp_adj)
+	nsec = cyc2ns(clock, cycle_delta)
 	return nsec
 
 Here you can see, we read the clocksource, calculate a cycle interval, and
@@ -119,14 +112,14 @@ at a safe point, we use the update_callb
 see "How to write a clocksource driver" below), this too must be done
 in-between intervals in the periodic_hook call. Finally, since the ntp
 adjustment made in the cyc2ns conversion is not static, we need to update the
-ntp state machine and get a calculate a new adjustment value.
+ntp state machine and adjust the clocksource mult value.
 
 This adds some extra pseudo code to the timeofday_periodic_hook function:
 
 timeofday_periodic_hook():
 	cycle_now = read_clocksource(clock)
 	cycle_delta = (cycle_now - cycle_last) & clock->mask
-	nsec = cyc2ns(clock, cycle_delta, ntp_adj)
+	nsec = cyc2ns(clock, cycle_delta)
 	system_time += nsec
 	cycle_last = cycle_now
 
@@ -140,7 +133,6 @@ timeofday_periodic_hook():
 
 	ntp_advance(nsec)
 	ppm = ntp_get_ppm_adjustment()
-	ntp_adj = ppm_to_mult_adj(clock, ppm)
 
 
 Unfortunately, the actual timeofday_periodic_hook code is not as simple as this
diff --git a/include/asm-generic/timeofday.h b/include/asm-generic/timeofday.h
index 79b952f..ddcae35 100644
--- a/include/asm-generic/timeofday.h
+++ b/include/asm-generic/timeofday.h
@@ -20,10 +20,9 @@ extern void sync_persistent_clock(struct
 
 #ifdef CONFIG_GENERIC_TIME_VSYSCALL
 extern void arch_update_vsyscall_gtod(struct timespec wall_time,
-				cycle_t offset_base, struct clocksource* clock,
-				int ntp_adj);
+				cycle_t offset_base, struct clocksource* clock);
 #else
-# define arch_update_vsyscall_gtod(x,y,z,w) do { } while(0)
+# define arch_update_vsyscall_gtod(x,y,z) do { } while(0)
 #endif /* CONFIG_GENERIC_TIME_VSYSCALL */
 
 #endif /* CONFIG_GENERIC_TIME */
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index bfd61a2..29ade9c 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -48,6 +48,8 @@ typedef u64 cycle_t;
  * @is_continuous:	defines if clocksource is free-running.
  * @vread:		vsyscall read function
  * @vdata:		vsyscall data value passed to read function
+ * @interval_cycles:	Used internally by timekeeping core, please ignore.
+ * @interval_snsecs:	Used internally by timekeeping core, please ignore.
  */
 struct clocksource {
 	char *name;
@@ -61,6 +63,10 @@ struct clocksource {
 	int is_continuous;
 	cycle_t (*vread)(void *);
 	void *vdata;
+
+	/* timekeeping specific data, ignore */
+	cycle_t interval_cycles;
+	u64 interval_snsecs;
 };
 
 
@@ -127,58 +133,18 @@ static inline cycle_t read_clocksource(s
 }
 
 /**
- * ppm_to_mult_adj - Converts shifted ppm values to mult adjustment
- * @cs:		Pointer to clocksource
- * @ppm:	Shifted PPM value
- *
- * Helper which converts a shifted ppm value to clocksource mult_adj value.
- *
- * XXX - this could use some optimization
- */
-static inline int ppm_to_mult_adj(struct clocksource *cs, int ppm)
-{
-	u64 mult_adj;
-	int ret_adj;
-
-	/* The basic math is as follows:
-	 *     cyc * mult/2^shift * (1 + ppm/MILL) = scaled ns
-	 * We want to precalculate the ppm factor so it can be added
-	 * to the multiplyer saving the extra multiplication step.
-	 *     cyc * (mult/2^shift + (mult/2^shift) * (ppm/MILL)) =
-	 *     cyc * (mult/2^shift + (mult*ppm/MILL)/2^shift) =
-	 *     cyc * (mult + (mult*ppm/MILL))/2^shift =
-	 * Thus we want to calculate the value of:
-	 *     mult*ppm/MILL
-	 */
-	mult_adj = abs(ppm);
-	mult_adj = (mult_adj * cs->mult)>>SHIFT_USEC;
-	mult_adj += 1000000/2; /* round for div*/
-	do_div(mult_adj, 1000000);
-	if (ppm < 0)
-		ret_adj = -(int)mult_adj;
-	else
-		ret_adj = (int)mult_adj;
-
-	return ret_adj;
-}
-
-/**
  * cyc2ns - converts clocksource cycles to nanoseconds
  * @cs:		Pointer to clocksource
- * @ntp_adj:	Multiplier adjustment value
  * @cycles:	Cycles
  *
  * Uses the clocksource and ntp ajdustment to convert cycle_ts to nanoseconds.
  *
  * XXX - This could use some mult_lxl_ll() asm optimization
  */
-static inline s64 cyc2ns(struct clocksource *cs, int ntp_adj, cycle_t cycles)
+static inline s64 cyc2ns(struct clocksource *cs, cycle_t cycles)
 {
-	u64 ret = cycles;
-
-	ret *= (cs->mult + ntp_adj);
-	ret >>= cs->shift;
-
+	u64 ret = (u64)cycles;
+	ret = (ret * cs->mult) >> cs->shift;
 	return ret;
 }
 
@@ -195,12 +161,10 @@ static inline s64 cyc2ns(struct clocksou
  *
  * XXX - This could use some mult_lxl_ll() asm optimization.
  */
-static inline s64 cyc2ns_rem(struct clocksource *cs, int ntp_adj,
-				cycle_t cycles, u64* rem)
+static inline s64 cyc2ns_rem(struct clocksource *cs, cycle_t cycles,
+					u64* rem)
 {
-	u64 ret = cycles;
-
-	ret *= (cs->mult + ntp_adj);
+	u64 ret = (u64)cycles * cs->mult;
 	if (rem) {
 		ret += *rem;
 		*rem = ret & ((1<<cs->shift)-1);
@@ -212,27 +176,6 @@ static inline s64 cyc2ns_rem(struct cloc
 
 
 /**
- * struct clocksource_interval - Fixed interval conversion structure
- *
- * @cycles:	A specified number of cycles
- * @nsecs:	The number of nanoseconds equivalent to the cycles value
- * @remainder:	Non-integer nanosecond remainder stored in (ns<<cs->shift) units
- * @remainder_ns_overflow:	Value at which the remainder is equal to
- *				one second
- *
- * This is a optimization structure used by cyc2ns_fixed_rem() to avoid the
- * multiply in cyc2ns().
- *
- * Unless you're the timeofday_periodic_hook, you should not be using this!
- */
-struct clocksource_interval {
-	cycle_t cycles;
-	s64 nsecs;
-	u64 remainder;
-	u64 remainder_ns_overflow;
-};
-
-/**
  * calculate_clocksource_interval - Calculates a clocksource interval struct
  *
  * @c:		Pointer to clocksource.
@@ -244,36 +187,43 @@ struct clocksource_interval {
  *
  * Unless you're the timeofday_periodic_hook, you should not be using this!
  */
-static inline struct clocksource_interval
-calculate_clocksource_interval(struct clocksource *c, long adj,
-			       unsigned long length_nsec)
+static inline void calculate_clocksource_interval(struct clocksource *c,
+						unsigned long length_nsec)
 {
-	struct clocksource_interval ret;
 	u64 tmp;
 
 	/* XXX - All of this could use a whole lot of optimization */
 	tmp = length_nsec;
 	tmp <<= c->shift;
-	do_div(tmp, c->mult+adj);
+	tmp += c->mult/2;
+	do_div(tmp, c->mult);
 
-	ret.cycles = (cycle_t)tmp;
-	if(ret.cycles == 0)
-		ret.cycles = 1;
-
-	ret.remainder = 0;
-	ret.remainder_ns_overflow = 1 << c->shift;
-	ret.nsecs = cyc2ns_rem(c, adj, ret.cycles, &ret.remainder);
+	c->interval_cycles = (cycle_t)tmp;
+	if(c->interval_cycles == 0)
+		c->interval_cycles = 1;
+
+	c->interval_snsecs = (u64)c->interval_cycles * c->mult;
+
+	printk("requested: %lu  calculated %llu ns %llu cyc error: %lld\n", length_nsec, c->interval_snsecs>>c->shift, c->interval_cycles, (s64)length_nsec - (c->interval_snsecs>>c->shift) );
+}
 
+
+static inline s64 snsec2nsec_rem(u64 snsec, u32 shift, u64* rem)
+{
+	s64 ret = snsec >> shift;
+	if(rem)
+		*rem = snsec & ((1<<shift)-1);
 	return ret;
 }
 
 /**
- * cyc2ns_fixed_rem -
- *	converts clocksource cycles to nanoseconds using fixed intervals
+ * cyc2sns_fixed_error-
+ *	converts clocksource cycles to shifted nanoseconds using fixed intervals
  *
  * @interval:	precalculated clocksource_interval structure
  * @cycles:	Number of clocksource cycles
- * @rem:	Remainder
+ * @ppm:	NTP shifted ppm adjustment value
+ * @error:	pointer to error accumulation variable
  *
  * Uses a precalculated fixed cycle/nsec interval to convert cycles to
  * nanoseconds. Returns the unaccumulated cycles in the cycles pointer as
@@ -281,24 +231,67 @@ calculate_clocksource_interval(struct cl
  *
  * Unless you're the timeofday_periodic_hook, you should not be using this!
  */
-static inline s64 cyc2ns_fixed_rem(struct clocksource_interval interval,
-				      cycle_t *cycles, u64* rem)
+static inline u64 cyc2sns_fixed_error(struct clocksource *clock,
+				cycle_t *cycles, u64 ntp_interval, s64* error)
 {
-	s64 delta_nsec = 0;
+	u64 delta_snsec = 0;
+	s64 interval_error = (s64)ntp_interval - clock->interval_snsecs;
 
-	while (*cycles > interval.cycles) {
-		delta_nsec += interval.nsecs;
-		*cycles -= interval.cycles;
-		*rem += interval.remainder;
-		while(*rem > interval.remainder_ns_overflow) {
-			*rem -= interval.remainder_ns_overflow;
-			delta_nsec += 1;
-		}
+	/* accumulate cycles*/
+	while (*cycles  > clock->interval_cycles) {
+		*cycles -= clock->interval_cycles;
+		delta_snsec += clock->interval_snsecs;
+		*error += interval_error;
 	}
 
-	return delta_nsec;
+	return delta_snsec;
 }
 
+static inline int error_aproximation(u64 error, u64 unit)
+{
+	static int saved_adj = 0;
+	u64 adjusted_unit = unit << saved_adj;
+
+	if (error > (adjusted_unit * 2)) {
+		/* large error, so increment the adjustment factor */
+		saved_adj++;
+	} else if (error > adjusted_unit) {
+		/* just right, don't touch it */
+	} else if (saved_adj) {
+		/* small error, so drop the adjustment factor */
+		saved_adj--;
+		return 0;
+	}
+
+	return saved_adj;
+}
+
+static inline s64 make_ntp_adj(struct clocksource *clock,
+				cycles_t cycles_delta, s64* error)
+{
+	s64 ret = 0;
+	/* check NTP error */
+	if (*error  > (s64)clock->interval_cycles / 2 ) {
+		int adj_factor = error_aproximation(*error,
+					clock->interval_cycles);
+		clock->mult += 1 << adj_factor;
+		clock->interval_snsecs += clock->interval_cycles << adj_factor;
+		ret =  -(cycles_delta << adj_factor);
+		*error -= (clock->interval_cycles << adj_factor);
+		/* XXX adj error for cycle_delta offset? */
+	} else if ((-(*error))  > (s64)clock->interval_cycles/2) {
+		int adj_factor = error_aproximation(-(*error),
+					clock->interval_cycles);
+		clock->mult -= 1 << adj_factor;
+		clock->interval_snsecs -= clock->interval_cycles << adj_factor;
+		ret =  cycles_delta << adj_factor;
+		*error += (clock->interval_cycles << adj_factor);
+		/* XXX adj error for cycle_delta offset? */
+	}
+	return ret;
+}
+
+
 /* used to install a new clocksource */
 int register_clocksource(struct clocksource*);
 void reselect_clocksource(void);
diff --git a/kernel/time/timeofday.c b/kernel/time/timeofday.c
index 8085b86..9b960d8 100644
--- a/kernel/time/timeofday.c
+++ b/kernel/time/timeofday.c
@@ -39,6 +39,13 @@
 /* Periodic hook interval */
 #define PERIODIC_INTERVAL_MS 50
 
+/*
+ * INTERVAL_LEN:
+ *	This constant is the requested fixed interval period
+ *	in nanoseconds.
+ */
+#define INTERVAL_LEN ((PERIODIC_INTERVAL_MS)*1000000)
+
 /* [ktime_t based variables]
  * system_time:
  *	Monotonically increasing counter of the number of nanoseconds
@@ -72,30 +79,12 @@ static struct timespec monotonic_time_of
  */
 static cycle_t cycle_last;
 
-/* [clocksource_interval variables]
- * ts_interval:
- *	This clocksource_interval is used in the fixed interval
- *	cycles to nanosecond calculation.
- * INTERVAL_LEN:
- *	This constant is the requested fixed interval period
- *	in nanoseconds.
- */
-static struct clocksource_interval ts_interval;
-#define INTERVAL_LEN ((PERIODIC_INTERVAL_MS-1)*1000000)
-
 /* [clocksource data]
  * clock:
  *	current clocksource pointer
  */
 static struct clocksource *clock;
 
-/* [NTP adjustment]
- * ntp_adj:
- *	value of the current ntp adjustment, stored in
- *	clocksource multiplier units.
- */
-static int ntp_adj;
-
 /* [locks]
  * system_time_lock:
  *	generic lock for all locally scoped time values
@@ -145,7 +134,7 @@ static void update_legacy_time_values(vo
 	write_sequnlock_irqrestore(&xtime_lock, flags);
 
 	/* since time state has changed, notify vsyscall code */
-	arch_update_vsyscall_gtod(wall_time_ts, cycle_last, clock, ntp_adj);
+	arch_update_vsyscall_gtod(wall_time_ts, cycle_last, clock);
 }
 
 /**
@@ -167,7 +156,7 @@ static inline s64 __get_nsec_offset(void
 	cycle_delta = (cycle_now - cycle_last) & clock->mask;
 
 	/* convert to nanoseconds: */
-	ns_offset = cyc2ns(clock, ntp_adj, cycle_delta);
+	ns_offset = cyc2ns(clock, cycle_delta);
 
 	/*
 	 * special case for jiffies tick/offset based systems,
@@ -499,6 +488,7 @@ static int timeofday_init_device(void)
 
 device_initcall(timeofday_init_device);
 
+
 /**
  * timeofday_periodic_hook - Does periodic update of timekeeping values.
  * @unused:	unused value
@@ -514,30 +504,57 @@ static void timeofday_periodic_hook(unsi
 
 	cycle_t cycle_now, cycle_delta;
 	s64 delta_nsec;
-	static u64 remainder;
 
-	long leapsecond = 0;
-	struct clocksource* next;
+  	/* nanoseconds left-shifted by clock->shift */
+	static u64 shifted_nsecs; /* works as a remainder */
+	static s64 ntp_error; /* Error accumulator */
+	s64 ntp_interval; /* interval length from ntp */
 
+	static s64 second_check;
+	long leapsecond = 0;
 	int ppm;
-	static int ppm_last;
 
-	int something_changed = 0;
+	struct clocksource* next;
 	struct clocksource old_clock;
-	static s64 second_check;
 
 	write_seqlock_irqsave(&system_time_lock, flags);
-
-	/* read time source & calc time since last call: */
+/**** Accumulation chunk *****/
+	/* read time source & calc cycle delta since last call: */
 	cycle_now = read_clocksource(clock);
 	cycle_delta = (cycle_now - cycle_last) & clock->mask;
 
-	delta_nsec = cyc2ns_fixed_rem(ts_interval, &cycle_delta, &remainder);
+
+	/* Calculate ntp_inteval in clock-shifted nanoseconds
+	 * XXX - This should all go away w/ Roman's NTP bits
+	 */
+	ppm = ntp_get_ppm_adjustment(); /* ppm = shifted usec per sec */
+	ntp_interval = ((s64)INTERVAL_LEN * ppm);
+	/* convert to clock-shifted nanoseconds */
+	ntp_interval = shift_right(ntp_interval,
+				(SHIFT_USEC + 20 - clock->shift));
+	ntp_interval = (((s64)INTERVAL_LEN)<<clock->shift) + ntp_interval;
+
+	/* convert cycle_delta to shifted nanoseconds using fixed intervals */
+	/* XXX - ugh, way too much state going in and out of that function! */
+	shifted_nsecs += cyc2sns_fixed_error(clock, &cycle_delta, ntp_interval,
+						&ntp_error);
+
+	/* add accumulated cycles to cycle_last */
 	cycle_last = (cycle_now - cycle_delta)&clock->mask;
 
+	/* check for large NTP error and adjust clock->mult if needed */
+	/* XXX - This has sideeffects, can we make that more clear? */
+	shifted_nsecs += make_ntp_adj(clock, cycle_delta, &ntp_error);
+
+	/* convert shifted nanoseconds to seconds & remainder */
+	delta_nsec = snsec2nsec_rem(shifted_nsecs, clock->shift,
+					 &shifted_nsecs);
+
 	/* update system_time:  */
 	__increment_system_time(delta_nsec);
 
+/**** NTP book keeping chunk *****/
+	/* XXX - This all might be possible to ditch w/ Roman's bits */
 	/* advance the ntp state machine by ns interval: */
 	ntp_advance(delta_nsec);
 
@@ -555,69 +572,52 @@ static void timeofday_periodic_hook(unsi
 	if (ntp_synced())
 		sync_persistent_clock(wall_time_ts);
 
+/**** Clocksource change chunk ****/
+	old_clock.mult = 0;
 	/* if necessary, switch clocksources: */
 	next = get_next_clocksource();
-	if (next != clock) {
+	if (unlikely(next != clock)) {
 		/* immediately set new cycle_last: */
 		cycle_last = read_clocksource(next);
 		/* update cycle_now to avoid problems in accumulation later: */
 		cycle_now = cycle_last;
+
 		/* swap clocksources: */
-		old_clock = *clock;
+		old_clock.mult = clock->mult;
+		old_clock.shift = clock->shift;
 		clock = next;
 		printk(KERN_INFO "Time: %s clocksource has been installed.\n",
 					clock->name);
-		ntp_clear();
-		ntp_adj = 0;
-		remainder = 0;
-		something_changed = 1;
-	}
-
-	/*
-	 * now is a safe time, so allow clocksource to adjust
-	 * itself (for example: to make cpufreq changes):
-	 */
-	if (clock->update_callback) {
+	} else if (unlikely(clock->update_callback)) {
 		/*
-		 * since clocksource state might change,
-		 * keep a copy, but only if we've not
-		 * already changed timesources:
+		 * now is a safe time, so allow clocksource to adjust
+		 * itself (for example: to make cpufreq changes):
 		 */
-		if (!something_changed)
-			old_clock = *clock;
-		if (clock->update_callback()) {
-			remainder = 0;
-			something_changed = 1;
-		}
-	}
-
-	/* check for new PPM adjustment: */
-	ppm = ntp_get_ppm_adjustment();
-	if (ppm_last != ppm) {
-		/* make sure old_clock is set: */
-		if (!something_changed)
-			old_clock = *clock;
-		something_changed = 1;
+		old_clock.mult = clock->mult;
+		old_clock.shift = clock->shift;
+		if (!clock->update_callback())
+			old_clock.mult = 0;
 	}
 
 	/* if something changed, recalculate the ntp adjustment value: */
-	if (something_changed) {
+	if (unlikely(old_clock.mult)) {
 		/* accumulate current leftover cycles using old_clock: */
 		if (cycle_delta) {
-			delta_nsec = cyc2ns_rem(&old_clock, ntp_adj,
-						cycle_delta, &remainder);
+			delta_nsec = cyc2ns_rem(&old_clock, cycle_delta,
+						 &shifted_nsecs);
 			cycle_last = cycle_now;
 			__increment_system_time(delta_nsec);
 			ntp_advance(delta_nsec);
+			second_check += delta_nsec;
 		}
 
-		/* recalculate the ntp adjustment and fixed interval values: */
-		ppm_last = ppm;
-		ntp_adj = ppm_to_mult_adj(clock, ppm);
-		ts_interval = calculate_clocksource_interval(clock, ntp_adj,
-					INTERVAL_LEN);
+		ntp_clear();
+		shifted_nsecs = 0;
+		ntp_error = 0;
+		calculate_clocksource_interval(clock, INTERVAL_LEN);
 	}
 
+/**** Final bits chunk ****/
 	update_legacy_time_values();
 
 	write_sequnlock_irqrestore(&system_time_lock, flags);
@@ -660,6 +660,7 @@ void __init timeofday_init(void)
 
 	/* initialize the clock variable: */
 	clock = get_next_clocksource();
+	calculate_clocksource_interval(clock, INTERVAL_LEN);
 
 	/* initialize cycle_last offset base: */
 	cycle_last = read_clocksource(clock);
@@ -670,10 +671,7 @@ void __init timeofday_init(void)
 					read_persistent_clock()));
 
 	/* clear NTP scaling factor & state machine: */
-	ntp_adj = 0;
 	ntp_clear();
-	ts_interval = calculate_clocksource_interval(clock, ntp_adj,
-				INTERVAL_LEN);
 
 	/* initialize legacy time values: */
 	update_legacy_time_values();


