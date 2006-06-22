Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161068AbWFVLTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161068AbWFVLTu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 07:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161069AbWFVLTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 07:19:50 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:26305 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1161068AbWFVLTt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 07:19:49 -0400
Date: Thu, 22 Jun 2006 13:19:28 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>
cc: johnstul@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix and optimize clock source update
In-Reply-To: <20060621145104.b13af6aa.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0606221308200.17704@scrub.home>
References: <Pine.LNX.4.64.0606211434020.904@scrub.home>
 <1150923519.2690.14.camel@leatherman> <Pine.LNX.4.64.0606212320450.12900@scrub.home>
 <20060621145104.b13af6aa.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 21 Jun 2006, Andrew Morton wrote:

> > The alternative is duplicating the code and an inline function which takes 
> > the address of these variables would likely generate worse code.
> 
> Can you verify that please?  It is pretty sick.

I'm pleasantly surprised. I already expected to be no difference with 
gcc-4.0, but gcc-3.x can deal with it as well.
Below is a new patch which moves the macro into the bigadjust function and 
includes John's changes, while at it I also added a few more comments.

bye, Roman




This fixes the clock source updates in update_wall_time() to correctly
track the time coming in via current_tick_length(). Optimize the fast
paths to be as short as possible to keep the overhead low.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

Andrew, please apply this patch, it's essential so that we can finally
get the clock source stuff merged. It keeps the overhead added by all
this in a not really good but acceptable range.
Tested with 2.6.17-rc6-mm2, applies and compiles with 2.6.17-mm1

 arch/powerpc/kernel/time.c  |    4 -
 include/linux/clocksource.h |  113 ++------------------------------
 include/linux/timex.h       |    4 -
 kernel/timer.c              |  151 +++++++++++++++++++++++++++++++-------------
 4 files changed, 123 insertions(+), 149 deletions(-)

Index: linux-2.6-mm/arch/powerpc/kernel/time.c
===================================================================
--- linux-2.6-mm.orig/arch/powerpc/kernel/time.c	2006-06-22 11:56:06.000000000 +0200
+++ linux-2.6-mm/arch/powerpc/kernel/time.c	2006-06-22 11:56:24.000000000 +0200
@@ -102,7 +102,7 @@ EXPORT_SYMBOL(tb_ticks_per_sec);	/* for 
 u64 tb_to_xs;
 unsigned tb_to_us;
 
-#define TICKLEN_SCALE	(SHIFT_SCALE - 10)
+#define TICKLEN_SCALE	TICK_LENGTH_SHIFT
 u64 last_tick_len;	/* units are ns / 2^TICKLEN_SCALE */
 u64 ticklen_to_xs;	/* 0.64 fraction */
 
@@ -534,7 +534,7 @@ static __inline__ void timer_recalc_offs
 
 	if (__USE_RTC())
 		return;
-	tlen = current_tick_length(SHIFT_SCALE - 10);
+	tlen = current_tick_length();
 	offset = cur_tb - do_gtod.varp->tb_orig_stamp;
 	if (tlen == last_tick_len && offset < 0x80000000u)
 		return;
Index: linux-2.6-mm/include/linux/clocksource.h
===================================================================
--- linux-2.6-mm.orig/include/linux/clocksource.h	2006-06-22 11:56:06.000000000 +0200
+++ linux-2.6-mm/include/linux/clocksource.h	2006-06-22 11:56:24.000000000 +0200
@@ -46,8 +46,8 @@ typedef u64 cycle_t;
  * @shift:		cycle to nanosecond divisor (power of two)
  * @update_callback:	called when safe to alter clocksource values
  * @is_continuous:	defines if clocksource is free-running.
- * @interval_cycles:	Used internally by timekeeping core, please ignore.
- * @interval_snsecs:	Used internally by timekeeping core, please ignore.
+ * @cycle_interval:	Used internally by timekeeping core, please ignore.
+ * @xtime_interval:	Used internally by timekeeping core, please ignore.
  */
 struct clocksource {
 	char *name;
@@ -61,8 +61,9 @@ struct clocksource {
 	int is_continuous;
 
 	/* timekeeping specific data, ignore */
-	cycle_t interval_cycles;
-	u64 interval_snsecs;
+	cycle_t cycle_last, cycle_interval;
+	u64 xtime_nsec, xtime_interval;
+	s64 error;
 };
 
 /* simplify initialization of mask field */
@@ -168,107 +169,11 @@ static inline void clocksource_calculate
 	tmp += c->mult/2;
 	do_div(tmp, c->mult);
 
-	c->interval_cycles = (cycle_t)tmp;
-	if(c->interval_cycles == 0)
-		c->interval_cycles = 1;
+	c->cycle_interval = (cycle_t)tmp;
+	if (c->cycle_interval == 0)
+		c->cycle_interval = 1;
 
-	c->interval_snsecs = (u64)c->interval_cycles * c->mult;
-}
-
-
-/**
- * error_aproximation - calculates an error adjustment for a given error
- *
- * @error:	Error value (unsigned)
- * @unit:	Adjustment unit
- *
- * For a given error value, this function takes the adjustment unit
- * and uses binary approximation to return a power of two adjustment value.
- *
- * This function is only for use by the the make_ntp_adj() function
- * and you must hold a write on the xtime_lock when calling.
- */
-static inline int error_aproximation(u64 error, u64 unit)
-{
-	static int saved_adj = 0;
-	u64 adjusted_unit = unit << saved_adj;
-
-	if (error > (adjusted_unit * 2)) {
-		/* large error, so increment the adjustment factor */
-		saved_adj++;
-	} else if (error > adjusted_unit) {
-		/* just right, don't touch it */
-	} else if (saved_adj) {
-		/* small error, so drop the adjustment factor */
-		saved_adj--;
-		return 0;
-	}
-
-	return saved_adj;
-}
-
-
-/**
- * make_ntp_adj - Adjusts the specified clocksource for a given error
- *
- * @clock:		Pointer to clock to be adjusted
- * @cycles_delta:	Current unacounted cycle delta
- * @error:		Pointer to current error value
- *
- * Returns clock shifted nanosecond adjustment to be applied against
- * the accumulated time value (ie: xtime).
- *
- * If the error value is large enough, this function calulates the
- * (power of two) adjustment value, and adjusts the clock's mult and
- * interval_snsecs values accordingly.
- *
- * However, since there may be some unaccumulated cycles, to avoid
- * time inconsistencies we must adjust the accumulation value
- * accordingly.
- *
- * This is not very intuitive, so the following proof should help:
- * The basic timeofday algorithm:  base + cycle * mult
- * Thus:
- *    new_base + cycle * new_mult = old_base + cycle * old_mult
- *    new_base = old_base + cycle * old_mult - cycle * new_mult
- *    new_base = old_base + cycle * (old_mult - new_mult)
- *    new_base - old_base = cycle * (old_mult - new_mult)
- *    base_delta = cycle * (old_mult - new_mult)
- *    base_delta = cycle * (mult_delta)
- *
- * Where mult_delta is the adjustment value made to mult
- *
- */
-static inline s64 make_ntp_adj(struct clocksource *clock,
-				cycles_t cycles_delta, s64* error)
-{
-	s64 ret = 0;
-	if (*error  > ((s64)clock->interval_cycles+1)/2) {
-		/* calculate adjustment value */
-		int adjustment = error_aproximation(*error,
-						clock->interval_cycles);
-		/* adjust clock */
-		clock->mult += 1 << adjustment;
-		clock->interval_snsecs += clock->interval_cycles << adjustment;
-
-		/* adjust the base and error for the adjustment */
-		ret =  -(cycles_delta << adjustment);
-		*error -= clock->interval_cycles << adjustment;
-		/* XXX adj error for cycle_delta offset? */
-	} else if ((-(*error))  > ((s64)clock->interval_cycles+1)/2) {
-		/* calculate adjustment value */
-		int adjustment = error_aproximation(-(*error),
-						clock->interval_cycles);
-		/* adjust clock */
-		clock->mult -= 1 << adjustment;
-		clock->interval_snsecs -= clock->interval_cycles << adjustment;
-
-		/* adjust the base and error for the adjustment */
-		ret =  cycles_delta << adjustment;
-		*error += clock->interval_cycles << adjustment;
-		/* XXX adj error for cycle_delta offset? */
-	}
-	return ret;
+	c->xtime_interval = (u64)c->cycle_interval * c->mult;
 }
 
 
Index: linux-2.6-mm/include/linux/timex.h
===================================================================
--- linux-2.6-mm.orig/include/linux/timex.h	2006-06-22 11:56:06.000000000 +0200
+++ linux-2.6-mm/include/linux/timex.h	2006-06-22 11:56:24.000000000 +0200
@@ -303,8 +303,10 @@ time_interpolator_reset(void)
 
 #endif /* !CONFIG_TIME_INTERPOLATION */
 
+#define TICK_LENGTH_SHIFT	32
+
 /* Returns how long ticks are at present, in ns / 2^(SHIFT_SCALE-10). */
-extern u64 current_tick_length(long);
+extern u64 current_tick_length(void);
 
 extern int do_adjtimex(struct timex *);
 
Index: linux-2.6-mm/kernel/timer.c
===================================================================
--- linux-2.6-mm.orig/kernel/timer.c	2006-06-22 11:56:07.000000000 +0200
+++ linux-2.6-mm/kernel/timer.c	2006-06-22 12:29:37.000000000 +0200
@@ -771,7 +771,7 @@ static void update_ntp_one_tick(void)
  * specified number of bits to the right of the binary point.
  * This function has no side-effects.
  */
-u64 current_tick_length(long shift)
+u64 current_tick_length(void)
 {
 	long delta_nsec;
 	u64 ret;
@@ -780,14 +780,8 @@ u64 current_tick_length(long shift)
 	 *    ie: nanosecond value shifted by (SHIFT_SCALE - 10)
 	 */
 	delta_nsec = tick_nsec + adjtime_adjustment() * 1000;
-	ret = ((u64) delta_nsec << (SHIFT_SCALE - 10)) + time_adj;
-
-	/* convert from (SHIFT_SCALE - 10) to specified shift scale: */
-	shift = shift - (SHIFT_SCALE - 10);
-	if (shift < 0)
-		ret >>= -shift;
-	else
-		ret <<= shift;
+	ret = (u64)delta_nsec << TICK_LENGTH_SHIFT;
+	ret += (s64)time_adj << (TICK_LENGTH_SHIFT - (SHIFT_SCALE - 10));
 
 	return ret;
 }
@@ -795,7 +789,6 @@ u64 current_tick_length(long shift)
 /* XXX - all of this timekeeping code should be later moved to time.c */
 #include <linux/clocksource.h>
 static struct clocksource *clock; /* pointer to current clocksource */
-static cycle_t last_clock_cycle;  /* cycle value at last update_wall_time */
 
 #ifdef CONFIG_GENERIC_TIME
 /**
@@ -814,7 +807,7 @@ static inline s64 __get_nsec_offset(void
 	cycle_now = clocksource_read(clock);
 
 	/* calculate the delta since the last update_wall_time: */
-	cycle_delta = (cycle_now - last_clock_cycle) & clock->mask;
+	cycle_delta = (cycle_now - clock->cycle_last) & clock->mask;
 
 	/* convert to nanoseconds: */
 	ns_offset = cyc2ns(clock, cycle_delta);
@@ -928,7 +921,7 @@ static int change_clocksource(void)
 		timespec_add_ns(&xtime, nsec);
 
 		clock = new;
-		last_clock_cycle = now;
+		clock->cycle_last = now;
 		printk(KERN_INFO "Time: %s clocksource has been installed.\n",
 					clock->name);
 		return 1;
@@ -969,7 +962,7 @@ void __init timekeeping_init(void)
 	write_seqlock_irqsave(&xtime_lock, flags);
 	clock = clocksource_get_next();
 	clocksource_calculate_interval(clock, tick_nsec);
-	last_clock_cycle = clocksource_read(clock);
+	clock->cycle_last = clocksource_read(clock);
 	ntp_clear();
 	write_sequnlock_irqrestore(&xtime_lock, flags);
 }
@@ -989,7 +982,7 @@ static int timekeeping_resume(struct sys
 
 	write_seqlock_irqsave(&xtime_lock, flags);
 	/* restart the last cycle value */
-	last_clock_cycle = clocksource_read(clock);
+	clock->cycle_last = clocksource_read(clock);
 	write_sequnlock_irqrestore(&xtime_lock, flags);
 	return 0;
 }
@@ -1016,60 +1009,134 @@ static int __init timekeeping_init_devic
 device_initcall(timekeeping_init_device);
 
 /*
+ * If the error is already larger, we look ahead another tick,
+ * to compensate for late or lost adjustments.
+ */
+static __always_inline int clocksource_bigadjust(int sign, s64 error, s64 *interval, s64 *offset)
+{
+	int adj;
+
+	/*
+	 * As soon as the machine is synchronized to the external time
+	 * source this should be the common case.
+	 */
+	error >>= 2;
+	if (likely(sign > 0 ? error <= *interval : error >= *interval))
+		return sign;
+
+	/*
+	 * An extra look ahead dampens the effect of the current error,
+	 * which can grow quite large with continously late updates, as
+	 * it would dominate the adjustment value and can lead to
+	 * oscillation.
+	 */
+	error += current_tick_length() >> (TICK_LENGTH_SHIFT - clock->shift + 1);
+	error -= clock->xtime_interval >> 1;
+
+	adj = 0;
+	while (1) {
+		error >>= 1;
+		if (sign > 0 ? error <= *interval : error >= *interval)
+			break;
+		adj++;
+	}
+
+	/*
+	 * Add the current adjustments to the error and take the offset
+	 * into account, the latter can cause the error to be hardly
+	 * reduced at the next tick. Check the error again if there's
+	 * room for another adjustment, thus further reducing the error
+	 * which otherwise had to be corrected at the next update.
+	 */
+	error = (error << 1) - *interval + *offset;
+	if (sign > 0 ? error > *interval : error < *interval)
+		adj++;
+
+	*interval <<= adj;
+	*offset <<= adj;
+	return sign << adj;
+}
+
+/*
+ * Adjust the multiplier to reduce the error value,
+ * this is optimized for the most common adjustments of -1,0,1,
+ * for other values we can do a bit more work.
+ */
+static void clocksource_adjust(struct clocksource *clock, s64 offset)
+{
+	s64 error, interval = clock->cycle_interval;
+	int adj;
+
+	error = clock->error >> (TICK_LENGTH_SHIFT - clock->shift - 1);
+	if (error > interval) {
+		adj = clocksource_bigadjust(1, error, &interval, &offset);
+	} else if (error < -interval) {
+		interval = -interval;
+		offset = -offset;
+		adj = clocksource_bigadjust(-1, error, &interval, &offset);
+	} else
+		return;
+
+	clock->mult += adj;
+	clock->xtime_interval += interval;
+	clock->xtime_nsec -= offset;
+	clock->error -= (interval - offset) << (TICK_LENGTH_SHIFT - clock->shift);
+}
+
+/*
  * update_wall_time - Uses the current clocksource to increment the wall time
  *
  * Called from the timer interrupt, must hold a write on xtime_lock.
  */
 static void update_wall_time(void)
 {
-	static s64 remainder_snsecs, error;
-	s64 snsecs_per_sec;
-	cycle_t now, offset;
+	cycle_t offset;
 
-	snsecs_per_sec = (s64)NSEC_PER_SEC << clock->shift;
-	remainder_snsecs += (s64)xtime.tv_nsec << clock->shift;
+	clock->xtime_nsec += (s64)xtime.tv_nsec << clock->shift;
 
-	now = clocksource_read(clock);
-	offset = (now - last_clock_cycle)&clock->mask;
+#ifdef CONFIG_GENERIC_TIME
+	offset = (clocksource_read(clock) - clock->cycle_last) & clock->mask;
+#else
+	offset = clock->cycle_interval;
+#endif
 
 	/* normally this loop will run just once, however in the
 	 * case of lost or late ticks, it will accumulate correctly.
 	 */
-	while (offset > clock->interval_cycles) {
-		/* get the ntp interval in clock shifted nanoseconds */
-		s64 ntp_snsecs	= current_tick_length(clock->shift);
-
+	while (offset >= clock->cycle_interval) {
 		/* accumulate one interval */
-		remainder_snsecs += clock->interval_snsecs;
-		last_clock_cycle += clock->interval_cycles;
-		offset -= clock->interval_cycles;
+		clock->xtime_nsec += clock->xtime_interval;
+		clock->cycle_last += clock->cycle_interval;
+		offset -= clock->cycle_interval;
+
+		if (clock->xtime_nsec >= (u64)NSEC_PER_SEC << clock->shift) {
+			clock->xtime_nsec -= (u64)NSEC_PER_SEC << clock->shift;
+			xtime.tv_sec++;
+			second_overflow();
+		}
 
 		/* interpolator bits */
-		time_interpolator_update(clock->interval_snsecs
+		time_interpolator_update(clock->xtime_interval
 						>> clock->shift);
 		/* increment the NTP state machine */
 		update_ntp_one_tick();
 
 		/* accumulate error between NTP and clock interval */
-		error += (ntp_snsecs - (s64)clock->interval_snsecs);
+		clock->error += current_tick_length();
+		clock->error -= clock->xtime_interval << (TICK_LENGTH_SHIFT - clock->shift);
+	}
 
-		/* correct the clock when NTP error is too big */
-		remainder_snsecs += make_ntp_adj(clock, offset, &error);
+	/* correct the clock when NTP error is too big */
+	clocksource_adjust(clock, offset);
 
-		if (remainder_snsecs >= snsecs_per_sec) {
-			remainder_snsecs -= snsecs_per_sec;
-			xtime.tv_sec++;
-			second_overflow();
-		}
-	}
 	/* store full nanoseconds into xtime */
-	xtime.tv_nsec = remainder_snsecs >> clock->shift;
-	remainder_snsecs -= (s64)xtime.tv_nsec << clock->shift;
+	xtime.tv_nsec = clock->xtime_nsec >> clock->shift;
+	clock->xtime_nsec -= (s64)xtime.tv_nsec << clock->shift;
 
 	/* check to see if there is a new clocksource to use */
 	if (change_clocksource()) {
-		error = 0;
-		remainder_snsecs = 0;
+		clock->error = 0;
+		clock->xtime_nsec = 0;
 		clocksource_calculate_interval(clock, tick_nsec);
 	}
 }
