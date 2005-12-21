Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964986AbVLUXax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964986AbVLUXax (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 18:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964990AbVLUXax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 18:30:53 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:907 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964986AbVLUXaw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 18:30:52 -0500
Date: Thu, 22 Dec 2005 00:30:45 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: johnstul@us.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH/RFC 10/10] example of simple continuous gettimeofday
Message-ID: <Pine.LNX.4.61.0512220028250.30930@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch demonstrates how a guaranteed continuous timeofday can be
implemented on top of the previous patches. (It's full of debug prints
and rather hacked into the current infrastructure, so please ignore
these parts :) ).

The previous patches convert the ntp code to precalculate as much as
possible, so that at every tick the reference time has only to be
updated by tick_nsec_curr/time_adj_curr. What this patch adds over
update_wall_time_one_tick() is that it modifies the frequency of the
local time to match the reference time instead of simply jumping to it.
It does this by maintaining an error value and modifying the multiplier
to reduce the error. 

The basic idea behind this is that ntp defines the frequency of the
reference time, e.g. with a clock frequency of f=500MHz the clock should
advance exactly 1 second after f cycles, but a quartz is usually not
that precise and varies depending on the temperature, so ntp defines an
adjustment, which should be applied every f cycles. tick_nsec and
time_adj now specify this frequency by how much the time is advanced
every tick. The resolution of the frequency is currently 2^-12nsec,
which allows for a very stable clock.

OTOH when reading the clock source it depends on the used multiplier by
how much the time is advanced every f cycles (this is also the time
visible to the user), e.g. in this case we would initialize the
multiplier to 8388608 (the shift value used in the patch is 22, so
m=10^9*2^22/f) so that after f cycles the time is f*m>>22=10^9nsec. To
keep the time now incrementing monotonically we can change the
multiplier to change the speed of the clock. It depends now on the used
shift value and the update frequency, how close we can keep the user
time to the reference time, e.g. with HZ=250 the possible frequency
adjustment steps can be f/2^22/10^9/HZ or about 0.477nsec, as the
resolution of the clock itself is 1/f (or 2nsec), the resulting
resolution is still well within the practical limits of the clock. This
also means a good shift value for a clock is around log2(f^2/10^9/HZ), a
much larger shift value doesn't improve much over the clock resolution
and a lower shift value makes the clock resolution worse.

In any case the clock resolution will be coarser than the resolution of
the ntp reference time, so with every update step at a timer tick we
accumulate an error of (ntp_update-xtime_update) and after some time the
error is large enough that it can be corrected by adjusting the
multiplier. The tricky part here is to prevent the error value from
oscillating too much, what can happen if the update comes too late and
we compensated too much, this is not much of a problem for small error
values, but larger error values are incrementally corrected instead and
not all at once. Another important detail is that the error value is
calculated after possible adjustments from second_overflow(), this way
we basically look ahead to the next timer tick and compensate for the
expected error and don't wait until we exceeded the error. This means a
well synchronized clock with small update delays almost always stays
within the error limits.


John, I hope this helps you to understand what I have in mind, please ask
if something is unclear, I'm already working on it for a while, so I
have no idea how digestable this is all at once. :)
I certainly have now a much better picture of what's possible and how to
further optimize this for different clocks. Here are a few general
comments about your code:

- with the previous patches the ntp code doesn't need much more changes
  anymore to implement a continuous time source, all you need is access
  to tick_nsec_curr, time_adj_curr and second_overflow() and you have to
  keep the generic code from calling update_wall_time().
  The ntp code certainly can use some more cosmetic changes, but I'd
  prefer to leave it for later.

- your code doesn't maintain the long term error, which will cause a
  random drift. This basically means you need a large shift value to
  increase the resolution and keep this error small. The code below can
  maintain a stable clock even at low resolutions.

- I still don't like the idea of a generic gettimeofday() as it prevents
  more optimized versions, e.g. on the one end with a 1MHz clock you only
  have usec resolution anyway and this allows to keep almost everything
  within 32bits. On the other end 64bit archs can avoid the "if (nsec >
  NSEC_PER_SEC)" by doing something like ppc64 does, but requires a
  different scaling of the values (to sec instead of nsec).

- the clock switch infrastructure can be merged with the clock set
  mechanism. When setting a clock some internal variables have to be
  updated as well, which can be reused for the clock switch basically
  by setting the clock immediately before the switch, so that both
  clocks run synchronously for a few cycles.


Anyway, most important for me right now is to make sure, the stuff below
is understood and I didn't make a stupid mistake somewhere. After this 
we'll see how to take it from there.


---

 arch/i386/kernel/time.c                  |   13 ++-
 arch/i386/kernel/timers/common.c         |   28 ++----
 arch/i386/kernel/timers/timer_tsc.c      |  132 +++++++++++++++++++++++++++++++
 include/asm-i386/mach-default/do_timer.h |    5 -
 include/asm-i386/timer.h                 |    2 
 kernel/time.c                            |    3 
 kernel/timer.c                           |   23 ++++-
 7 files changed, 181 insertions(+), 25 deletions(-)

Index: linux-2.6-mm/arch/i386/kernel/time.c
===================================================================
--- linux-2.6-mm.orig/arch/i386/kernel/time.c	2005-12-21 12:09:42.000000000 +0100
+++ linux-2.6-mm/arch/i386/kernel/time.c	2005-12-21 12:12:30.000000000 +0100
@@ -128,6 +128,10 @@ void do_gettimeofday(struct timeval *tv)
 	unsigned long usec, sec;
 	unsigned long max_ntp_tick;
 
+	if (cur_timer->gettimeofday) {
+		cur_timer->gettimeofday(tv);
+		return;
+	}
 	do {
 		unsigned long lost;
 
@@ -175,14 +179,17 @@ int do_settimeofday(struct timespec *tv)
 		return -EINVAL;
 
 	write_seqlock_irq(&xtime_lock);
+	printk("stod: %lu:%09lu\n", tv->tv_sec, tv->tv_nsec);
 	/*
 	 * This is revolting. We need to set "xtime" correctly. However, the
 	 * value in this location is the value at the most recent update of
 	 * wall time.  Discover what correction gettimeofday() would have
 	 * made, and then undo it!
 	 */
-	nsec -= cur_timer->get_offset() * NSEC_PER_USEC;
-	nsec -= (jiffies - wall_jiffies) * TICK_NSEC;
+	if (!cur_timer->time_was_set) {
+		nsec -= cur_timer->get_offset() * NSEC_PER_USEC;
+		nsec -= (jiffies - wall_jiffies) * TICK_NSEC;
+	}
 
 	wtm_sec  = wall_to_monotonic.tv_sec + (xtime.tv_sec - sec);
 	wtm_nsec = wall_to_monotonic.tv_nsec + (xtime.tv_nsec - nsec);
@@ -191,6 +198,8 @@ int do_settimeofday(struct timespec *tv)
 	set_normalized_timespec(&wall_to_monotonic, wtm_sec, wtm_nsec);
 
 	ntp_clear();
+	if (cur_timer->time_was_set)
+		cur_timer->time_was_set();
 	write_sequnlock_irq(&xtime_lock);
 	clock_was_set();
 	return 0;
Index: linux-2.6-mm/arch/i386/kernel/timers/common.c
===================================================================
--- linux-2.6-mm.orig/arch/i386/kernel/timers/common.c	2005-12-21 12:04:39.000000000 +0100
+++ linux-2.6-mm/arch/i386/kernel/timers/common.c	2005-12-21 12:12:30.000000000 +0100
@@ -23,46 +23,36 @@
  * device.
  */
 
-#define CALIBRATE_TIME	(5 * 1000020/HZ)
+#define CALIBRATE_TIME	((((5LL * LATCH * 1000000) << 20) / CLOCK_TICK_RATE) << 12)
 
 unsigned long calibrate_tsc(void)
 {
 	mach_prepare_counter();
 
 	{
-		unsigned long startlow, starthigh;
-		unsigned long endlow, endhigh;
-		unsigned long count;
+		unsigned long long start, end;
+		unsigned long count, dummy;
 
-		rdtsc(startlow,starthigh);
+		rdtscll(start);
 		mach_countup(&count);
-		rdtsc(endlow,endhigh);
+		rdtscll(end);
 
 
 		/* Error: ECTCNEVERSET */
 		if (count <= 1)
 			goto bad_ctc;
 
-		/* 64-bit subtract - gcc just messes up with long longs */
-		__asm__("subl %2,%0\n\t"
-			"sbbl %3,%1"
-			:"=a" (endlow), "=d" (endhigh)
-			:"g" (startlow), "g" (starthigh),
-			 "0" (endlow), "1" (endhigh));
+		end -= start;
 
 		/* Error: ECPUTOOFAST */
-		if (endhigh)
+		if (end > 0xffffffff)
 			goto bad_ctc;
 
 		/* Error: ECPUTOOSLOW */
-		if (endlow <= CALIBRATE_TIME)
+		if (end <= CALIBRATE_TIME >> 32)
 			goto bad_ctc;
 
-		__asm__("divl %2"
-			:"=a" (endlow), "=d" (endhigh)
-			:"r" (endlow), "0" (0), "1" (CALIBRATE_TIME));
-
-		return endlow;
+		return div_long_long_rem(CALIBRATE_TIME, end, &dummy);
 	}
 
 	/*
Index: linux-2.6-mm/arch/i386/kernel/timers/timer_tsc.c
===================================================================
--- linux-2.6-mm.orig/arch/i386/kernel/timers/timer_tsc.c	2005-12-21 12:09:42.000000000 +0100
+++ linux-2.6-mm/arch/i386/kernel/timers/timer_tsc.c	2005-12-21 12:12:30.000000000 +0100
@@ -344,6 +344,7 @@ int recalibrate_cpu_khz(void)
 }
 EXPORT_SYMBOL(recalibrate_cpu_khz);
 
+#if 0
 static void mark_offset_tsc(void)
 {
 	unsigned long lost,delay;
@@ -455,6 +456,124 @@ static void mark_offset_tsc(void)
 	if (lost && abs(delay - delay_at_last_interrupt) > (900000/HZ))
 		jiffies_64++;
 }
+#endif
+
+extern unsigned long tick_nsec_curr, time_adj_curr;
+extern void second_overflow(void);
+
+u32 cycles_mult, update_cycles;
+u64 cycles_offset, xtime_nsec, xtime_update;
+s64 xtime_error;
+int error_adj;
+
+static void mark_offset_tsc(void)
+{
+	u64 cycles, update;
+	s64 off;
+	int adj;
+
+	//printk("[");
+	rdtscll(cycles);
+
+	while ((off = cycles - cycles_offset) >= update_cycles) {
+		//printk("*");
+		cycles_offset += update_cycles;
+		xtime_nsec += xtime_update;
+		if (xtime_nsec >= (u64)NSEC_PER_SEC << 22) {
+			xtime_nsec -= (u64)NSEC_PER_SEC << 22;
+			xtime.tv_sec++;
+			second_overflow();
+			if (!(xtime.tv_sec & 7))
+				printk("ft: %lld,%u,%llu,%u\n", xtime_error, cycles_mult, xtime_nsec, error_adj);
+		}
+		xtime.tv_nsec = xtime_nsec >> 22;
+		xtime_error += (u64)tick_nsec_curr << 22;
+		xtime_error += (u64)time_adj_curr << (22 - SHIFT_SCALE);
+		xtime_error -= xtime_update;
+	}
+
+	if (xtime_error > update_cycles / 2) {
+		//long dummy, tmp = div_ll_X_l_rem(xtime_error + update_cycles / 2, update_cycles, &dummy);
+		//printk("+");
+		adj = error_adj;
+		update = (u64)update_cycles << adj;
+		if (xtime_error > update) {
+			if (xtime_error > update << 1) {
+				update <<= 1;
+				error_adj = ++adj;
+				//printk("e+^:%ld\n", tmp);
+			}
+		} else if (adj) {
+			//printk("e+v:%ld\n", tmp);
+			error_adj--;
+			adj = 0;
+			update = update_cycles;
+		}
+		off <<= adj;
+		cycles_mult += 1 << adj;
+		xtime_update += update;
+		xtime_error -= update - off;
+		xtime_nsec -= off;
+	} else if (-xtime_error > update_cycles / 2) {
+		//long dummy, tmp = -div_ll_X_l_rem(-xtime_error + update_cycles / 2, update_cycles, &dummy);
+		//printk("-");
+		adj = error_adj;
+		update = (u64)update_cycles << adj;
+		if (-xtime_error > update) {
+			if (-xtime_error > update << 1) {
+				update <<= 1;
+				error_adj = ++adj;
+				//printk("e-^:%ld\n", tmp);
+			}
+		} else if (adj) {
+			//printk("e-v:%ld\n", tmp);
+			error_adj--;
+			adj = 0;
+			update = update_cycles;
+		}
+		off <<= adj;
+		cycles_mult -= 1 << adj;
+		xtime_update -= update;
+		xtime_error += update - off;
+		xtime_nsec += off;
+	}
+	//printk("]");
+}
+
+static int tod_test = 10;
+
+void tsc_gettimeofday(struct timeval *tv)
+{
+	u32 nsec, cycles;
+	int seq;
+
+	do {
+		seq = read_seqbegin(&xtime_lock);
+		tv->tv_sec = xtime.tv_sec;
+		rdtscl(cycles);
+		nsec = (xtime_nsec + (cycles - (u32)cycles_offset) * (u64)cycles_mult) >> 22;
+		if (nsec > NSEC_PER_SEC) {
+			nsec -= NSEC_PER_SEC;
+			tv->tv_sec++;
+		}
+		tv->tv_usec = nsec / 1000;
+	} while (unlikely(read_seqretry(&xtime_lock, seq)));
+	if (tod_test) {
+		tod_test--;
+		printk("gtod: %lu,%06lu\n", tv->tv_sec, tv->tv_usec);
+	}
+}
+
+void tsc_time_was_set(void)
+{
+	printk("tsc_time_was_set: %lu,%09lu\n", xtime.tv_sec, xtime.tv_nsec);
+	tod_test = 10;
+	rdtscll(cycles_offset);
+	xtime_nsec = (u64)xtime.tv_nsec << 22;
+	xtime_error = (u64)tick_nsec_curr << 22;
+	xtime_error += (u64)time_adj_curr << (22 - SHIFT_SCALE);
+	xtime_error -= xtime_update;
+}
 
 static int __init init_tsc(char* override)
 {
@@ -523,6 +642,17 @@ static int __init init_tsc(char* overrid
 		}
 
 		if (tsc_quotient) {
+			long dummy;
+
+			cycles_mult = ((u64)tsc_quotient * 1000) >> 10;
+			update_cycles = div_ll_X_l_rem((1000000000LL << 22) / HZ, cycles_mult, &dummy);
+			asm ("mull %1"
+				:"=A" (xtime_update)
+				:"rm" (cycles_mult), "a" (update_cycles));
+			ntp_clear();
+			tsc_time_was_set();
+			printk("tsc: %u,%u,%llu,%llu\n", cycles_mult, update_cycles, xtime_update, xtime_error);
+
 			fast_gettimeoffset_quotient = tsc_quotient;
 			use_tsc = 1;
 			/*
@@ -587,6 +717,8 @@ __setup("notsc", tsc_setup);
 static struct timer_opts timer_tsc = {
 	.name = "tsc",
 	.mark_offset = mark_offset_tsc, 
+	.gettimeofday = tsc_gettimeofday,
+	.time_was_set = tsc_time_was_set,
 	.get_offset = get_offset_tsc,
 	.monotonic_clock = monotonic_clock_tsc,
 	.delay = delay_tsc,
Index: linux-2.6-mm/include/asm-i386/mach-default/do_timer.h
===================================================================
--- linux-2.6-mm.orig/include/asm-i386/mach-default/do_timer.h	2005-12-21 12:04:39.000000000 +0100
+++ linux-2.6-mm/include/asm-i386/mach-default/do_timer.h	2005-12-21 12:12:30.000000000 +0100
@@ -16,7 +16,10 @@
 
 static inline void do_timer_interrupt_hook(struct pt_regs *regs)
 {
-	do_timer(regs);
+	if (cur_timer->gettimeofday)
+		do_timer2(regs);
+	else
+		do_timer(regs);
 #ifndef CONFIG_SMP
 	update_process_times(user_mode(regs));
 #endif
Index: linux-2.6-mm/include/asm-i386/timer.h
===================================================================
--- linux-2.6-mm.orig/include/asm-i386/timer.h	2005-12-21 12:04:39.000000000 +0100
+++ linux-2.6-mm/include/asm-i386/timer.h	2005-12-21 12:12:30.000000000 +0100
@@ -20,6 +20,8 @@
 struct timer_opts {
 	char* name;
 	void (*mark_offset)(void);
+	void (*gettimeofday)(struct timeval *);
+	void (*time_was_set)(void);
 	unsigned long (*get_offset)(void);
 	unsigned long long (*monotonic_clock)(void);
 	void (*delay)(unsigned long);
Index: linux-2.6-mm/kernel/time.c
===================================================================
--- linux-2.6-mm.orig/kernel/time.c	2005-12-21 12:12:26.000000000 +0100
+++ linux-2.6-mm/kernel/time.c	2005-12-21 12:12:30.000000000 +0100
@@ -320,6 +320,7 @@ int do_adjtimex(struct timex *txc)
 		    freq_adj = (s64)time_offset * mtemp;
 		    freq_adj = shift_right(freq_adj, (time_constant + SHIFT_PLL +
 						      2) * 2 - SHIFT_NSEC);
+		    printk("p: %ld,%lx,%llx", mtemp, time_offset, freq_adj);
 		    if (mtemp >= MINSEC && (time_status & STA_FLL || mtemp > MAXSEC)) {
 			if (time_offset < 0) {
 			    temp64 = (s64)-time_offset << SHIFT_NSEC;
@@ -330,8 +331,10 @@ int do_adjtimex(struct timex *txc)
 			    do_div(temp64, mtemp << SHIFT_FLL);
 			    freq_adj += temp64;
 			}
+			printk(",%llx", temp64);
 		    }
 		    freq_adj += time_freq;
+		    printk(",%lx->%llx\n", time_freq, freq_adj);
 		    freq_adj = min(freq_adj, (s64)MAXFREQ);
 		    time_freq = max(freq_adj, (s64)-MAXFREQ);
 		    time_offset = (time_offset / HZ) << SHIFT_HZ;
Index: linux-2.6-mm/kernel/timer.c
===================================================================
--- linux-2.6-mm.orig/kernel/timer.c	2005-12-21 12:12:26.000000000 +0100
+++ linux-2.6-mm/kernel/timer.c	2005-12-21 12:12:30.000000000 +0100
@@ -552,7 +552,7 @@ found:
  */
 unsigned long tick_usec = TICK_USEC; 		/* USER_HZ period (usec) */
 unsigned long tick_nsec;			/* ACTHZ period (nsec) */
-static unsigned long tick_nsec_curr;
+unsigned long tick_nsec_curr;
 
 /* 
  * The current time 
@@ -583,7 +583,7 @@ long time_maxerror = NTP_PHASE_LIMIT;	/*
 long time_esterror = NTP_PHASE_LIMIT;	/* estimated error (us)		*/
 static long time_phase;			/* phase offset (scaled us)	*/
 long time_freq;				/* frequency offset (scaled ppm)*/
-static long time_adj, time_adj_curr;	/* tick adjust (scaled 1 / HZ)	*/
+long time_adj, time_adj_curr;		/* tick adjust (scaled 1 / HZ)	*/
 long time_reftime;			/* time at last adjustment (s)	*/
 long time_adjust;
 
@@ -616,6 +616,7 @@ void ntp_update_frequency(void)
 	 * for the next HZ ticks with the remainder in freq (scaled by
 	 * (SHIFT_USEC - 3)).
 	 */
+	printk("f1: %ld,%lx,%ld\n", tick_usec, time_freq, time_offset);
 	time = tick_usec * 1000 * USER_HZ;
 	time += time_freq >> SHIFT_NSEC;
 
@@ -629,6 +630,7 @@ void ntp_update_frequency(void)
 	time_adj = time / HZ;
 
 	tick_nsec -= NSEC_PER_SEC / HZ - TICK_NSEC;
+	printk("f2: %lu,%lx\n", tick_nsec, time_adj);
 }
 
 /*
@@ -640,7 +642,7 @@ void ntp_update_frequency(void)
  * All the kudos should go to Dave for this stuff.
  *
  */
-static void second_overflow(void)
+void second_overflow(void)
 {
 	long ltemp;
 
@@ -779,6 +781,8 @@ static void update_wall_time(unsigned lo
 		ticks--;
 		update_wall_time_one_tick();
 		if (xtime.tv_nsec >= 1000000000) {
+			if (!(xtime.tv_sec & 127))
+				printk("f: %ld,%lx,%ld\n", tick_nsec_curr, time_adj_curr, time_offset);
 			xtime.tv_nsec -= 1000000000;
 			xtime.tv_sec++;
 			second_overflow();
@@ -907,6 +911,19 @@ void do_timer(struct pt_regs *regs)
 	softlockup_tick(regs);
 }
 
+void do_timer2(struct pt_regs *regs)
+{
+	unsigned long ticks;
+
+	jiffies_64++;
+	ticks = jiffies - wall_jiffies;
+	if (ticks) {
+		wall_jiffies += ticks;
+		calc_load(ticks);
+	}
+	softlockup_tick(regs);
+}
+
 #ifdef __ARCH_WANT_SYS_ALARM
 
 /*
