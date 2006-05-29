Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbWE2MZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWE2MZl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 08:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbWE2MZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 08:25:41 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:57294 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1750735AbWE2MZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 08:25:39 -0400
Date: Mon, 29 May 2006 14:25:14 +0200 (CEST)
From: Simon Derr <Simon.Derr@bull.net>
X-X-Sender: derrs@openx3.frec.bull.fr
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: -rt IA64 update
Message-ID: <Pine.LNX.4.61.0605291356170.14092@openx3.frec.bull.fr>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 29/05/2006 14:28:46,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 29/05/2006 14:29:02,
	Serialize complete at 29/05/2006 14:29:02
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ingo,

This is an update of my IA64 port, against -rt25.

I have modified check_pgt_cache() as we discussed before, and the raw 
spinlock in the struct zone is no longer needed.

There's also a preliminary and certainly very bogus attempt to have the HR 
timers on IA64. I'd love to have comments on that part.

Some bits of the Kconfig have been stolen from a previous patch by Eric 
Piel.

This kernel boots OK on UP and SMP, and runs the sched_football test 
successfully.


A few notes:

* You can see at the end of the patch this ugly thing in 
clockevents_set_next_event()

+#ifndef CONFIG_IA64
        clc = mpy_sc32((unsigned long) delta, sources->nextevt->mult);
+#else
+       clc = (unsigned long) delta * (unsigned long) sources->nextevt->mult;
+       clc = clc >> sources->nextevt->shift;
+#endif
+

I made this ia64-only, but it seems to me that this code should be fixed 
as it works only for clocksources that have shift=32.



* This kernel, when booting, prints:

	BUG in check_monotonic_clock at kernel/time/timeofday.c:164

But I think this happens because two get_monotonic_clock() are racing on 
two cpus. There is a lock to prevent the race, but it is a seqlock. That 
means that it is okay if the race happens since another try will be 
attempted, but the message that has been printed on the console can't be 
removed, and the user is unnecessarily scared.



	Simon.





Signed-off-by: Simon Derr    <Simon.Derr@bull.net>

Index: rt25/arch/ia64/Kconfig
===================================================================
--- rt25.orig/arch/ia64/Kconfig	2006-05-29 10:43:00.961957695 +0200
+++ rt25/arch/ia64/Kconfig	2006-05-29 10:46:03.746135144 +0200
@@ -39,10 +39,6 @@ config GENERIC_CALIBRATE_DELAY
 	bool
 	default y
 
-config TIME_INTERPOLATION
-	bool
-	default y
-
 config EFI
 	bool
 	default y
@@ -241,6 +237,75 @@ config SMP
 
 	  If you don't know what to do here, say N.
 
+
+config GENERIC_TIME
+       bool
+       default y
+
+config TIME_INTERPOLATION
+	bool
+	default y
+	depends on !GENERIC_TIME
+
+
+config HIGH_RES_TIMERS
+	bool "High-Resolution Timers"
+	help
+
+	  POSIX timers are available by default.  This option enables
+	  high-resolution POSIX timers.  With this option the resolution
+	  is at least 1 microsecond.  High resolution is not free.  If
+	  enabled this option will add a small overhead each time a
+	  timer expires that is not on a 1/HZ tick boundary.  If no such
+	  timers are used the overhead is nil.
+
+	  This option enables two additional POSIX CLOCKS,
+	  CLOCK_REALTIME_HR and CLOCK_MONOTONIC_HR.  Note that this
+	  option does not change the resolution of CLOCK_REALTIME or
+	  CLOCK_MONOTONIC which remain at 1/HZ resolution.
+
+config HIGH_RES_RESOLUTION
+	int "High-Resolution-Timer resolution (nanoseconds)"	  
+	depends on HIGH_RES_TIMERS
+	default 1000
+	help
+
+	  This sets the resolution of timers accessed with
+          CLOCK_REALTIME_HR and CLOCK_MONOTONIC_HR.  Too 
+	  fine a resolution (small a number) will usually not
+          be observable due to normal system latencies.  For an
+          800 MHZ processor about 10,000 is the recommended maximum
+	  (smallest number).  If you don't need that sort of resolution,
+	  higher numbers may generate less overhead.
+
+choice
+	prompt "Clock source"
+	depends on HIGH_RES_TIMERS
+ 	default HIGH_RES_TIMER_ITC
+	help 
+	  This option allows you to choose the hardware source in charge
+	  of generating high precision interruptions on your system. 
+	  On IA-64 these are:
+
+	  <timer>				<resolution>
+	  ITC Interval Time Counter		1/CPU clock
+  	  HPET High Precision Event Timer	~ (XXX:have to check the spec)
+
+	  The ITC timer is available on all the ia64 computers because 
+	  it is integrated directly into the processor. However it may not
+	  give correct results on MP machines with processors running
+	  at different clock rates. In this case you may want to use
+	  the HPET if available on your machine.
+
+
+config HIGH_RES_TIMER_ITC
+	bool "Interval Time Counter/ITC"
+
+config HIGH_RES_TIMER_HPET
+	bool "High Precision Event Timer/HPET"
+	  
+endchoice	  
+ 
 config NR_CPUS
 	int "Maximum number of CPUs (2-1024)"
 	range 2 1024
Index: rt25/arch/ia64/kernel/asm-offsets.c
===================================================================
--- rt25.orig/arch/ia64/kernel/asm-offsets.c	2006-03-20 06:53:29.000000000 +0100
+++ rt25/arch/ia64/kernel/asm-offsets.c	2006-05-29 10:46:03.747111706 +0200
@@ -247,6 +247,7 @@ void foo(void)
 	       offsetof (struct pal_min_state_area_s, pmsa_xip));
 	BLANK();
 
+#ifdef CONFIG_TIME_INTERPOLATION
 	/* used by fsys_gettimeofday in arch/ia64/kernel/fsys.S */
 	DEFINE(IA64_TIME_INTERPOLATOR_ADDRESS_OFFSET, offsetof (struct time_interpolator, addr));
 	DEFINE(IA64_TIME_INTERPOLATOR_SOURCE_OFFSET, offsetof (struct time_interpolator, source));
@@ -260,5 +261,6 @@ void foo(void)
 	DEFINE(IA64_TIME_SOURCE_CPU, TIME_SOURCE_CPU);
 	DEFINE(IA64_TIME_SOURCE_MMIO64, TIME_SOURCE_MMIO64);
 	DEFINE(IA64_TIME_SOURCE_MMIO32, TIME_SOURCE_MMIO32);
+#endif
 	DEFINE(IA64_TIMESPEC_TV_NSEC_OFFSET, offsetof (struct timespec, tv_nsec));
 }
Index: rt25/arch/ia64/kernel/fsys.S
===================================================================
--- rt25.orig/arch/ia64/kernel/fsys.S	2006-03-20 06:53:29.000000000 +0100
+++ rt25/arch/ia64/kernel/fsys.S	2006-05-29 10:46:03.748088269 +0200
@@ -145,6 +145,7 @@ ENTRY(fsys_set_tid_address)
 	FSYS_RETURN
 END(fsys_set_tid_address)
 
+#ifdef CONFIG_TIME_INTERPOLATION
 /*
  * Ensure that the time interpolator structure is compatible with the asm code
  */
@@ -348,6 +349,26 @@ ENTRY(fsys_clock_gettime)
 	br.many .gettime
 END(fsys_clock_gettime)
 
+
+#else // !CONFIG_TIME_INTERPOLATION
+
+# define fsys_gettimeofday 0
+# define fsys_clock_gettime 0
+
+.fail_einval:
+	mov r8 = EINVAL
+	mov r10 = -1
+	FSYS_RETURN
+
+.fail_efault:
+	mov r8 = EFAULT
+	mov r10 = -1
+	FSYS_RETURN
+
+#endif
+
+
+
 /*
  * long fsys_rt_sigprocmask (int how, sigset_t *set, sigset_t *oset, size_t sigsetsize).
  */
Index: rt25/arch/ia64/kernel/process.c
===================================================================
--- rt25.orig/arch/ia64/kernel/process.c	2006-05-29 10:43:00.971723320 +0200
+++ rt25/arch/ia64/kernel/process.c	2006-05-29 10:46:03.748088269 +0200
@@ -306,7 +306,6 @@ cpu_idle (void)
 		__schedule();
 
 		preempt_disable();
-		check_pgt_cache();
 
 		if (cpu_is_offline(cpu))
 			play_dead();
Index: rt25/arch/ia64/kernel/smpboot.c
===================================================================
--- rt25.orig/arch/ia64/kernel/smpboot.c	2006-03-20 06:53:29.000000000 +0100
+++ rt25/arch/ia64/kernel/smpboot.c	2006-05-29 10:46:03.749064831 +0200
@@ -324,6 +324,8 @@ smp_setup_percpu_timer (void)
 {
 }
 
+extern void register_itc_clockevent(void);
+
 static void __devinit
 smp_callin (void)
 {
@@ -379,7 +381,8 @@ smp_callin (void)
 #ifdef CONFIG_IA32_SUPPORT
 	ia32_gdt_init();
 #endif
-
+	register_itc_clockevent();
+ 
 	/*
 	 * Allow the master to continue.
 	 */
Index: rt25/arch/ia64/kernel/time.c
===================================================================
--- rt25.orig/arch/ia64/kernel/time.c	2006-03-20 06:53:29.000000000 +0100
+++ rt25/arch/ia64/kernel/time.c	2006-05-29 10:46:03.750041394 +0200
@@ -21,6 +21,7 @@
 #include <linux/efi.h>
 #include <linux/profile.h>
 #include <linux/timex.h>
+#include <linux/clockchips.h>
 
 #include <asm/machvec.h>
 #include <asm/delay.h>
@@ -41,12 +42,102 @@ EXPORT_SYMBOL(last_cli_ip);
 
 #endif
 
+#ifdef CONFIG_GENERIC_TIME
+static void itc_set_next_event(unsigned long evt)
+{
+	unsigned long flags;
+	unsigned long new_itm;
+
+	raw_local_irq_save(flags);
+	
+	new_itm = ia64_get_itc() + evt;
+	local_cpu_data->itm_timer_next = new_itm;
+
+	if (time_before(new_itm, local_cpu_data->itm_tick_next))
+		ia64_set_itm(new_itm);
+
+	raw_local_irq_restore(flags);	
+}
+
+static struct clock_event itc_clockevent = {
+	.name = "itc_clockevent",
+	.capabilities = CLOCK_CAP_NEXTEVT,
+	.max_delta_ns = 1000000000,    // fixme...
+	.min_delta_ns = 1000,	       // fixme...
+	.shift = 10,
+	.set_next_event = itc_set_next_event,
+};
+
+/* arch specific timeofday hooks */
+s64 read_persistent_clock(void)
+{
+	struct timespec ts;
+	efi_gettimeofday(&ts);
+	return (s64) ts.tv_sec * NSEC_PER_SEC + (s64) ts.tv_nsec;
+}
+
+void sync_persistent_clock(struct timespec ts)
+{
+	// todo
+}
+
+static unsigned long last_itc = 0;
+
+static cycle_t itc_clocksource_read(void)
+{
+	unsigned long now = ia64_get_itc();
+
+	// I suppose this should be sufficient to have a monotonic clock
+	if (last_itc < now)
+		last_itc = now;
+	
+	return (cycle_t) last_itc;
+}
+
+static struct clocksource itc_clocksource = {
+	.name = "itc_clocksource",
+	.rating = 200,
+	.shift = 10,
+	.mask = 0xffffffffffffffff,
+	.read = itc_clocksource_read,
+	.is_continuous	= 1,
+};
+
+
+static void register_itc_clocksource(void)
+{
+	printk("Registering itc clocksource\n");
+	itc_clocksource.mult = clocksource_hz2mult(local_cpu_data->itc_freq, itc_clocksource.shift);
+	printk("itc_freq = %lu itc_clocksource.mult = %u\n", local_cpu_data->itc_freq, itc_clocksource.mult);
+	register_clocksource(&itc_clocksource);
+}
+
+
+void register_itc_clockevent(void)
+{
+	printk("Registering itc clockevent on cpu %d\n", smp_processor_id());
+	if (!itc_clockevent.mult)
+		itc_clockevent.mult = clocksource_hz2mult(local_cpu_data->itc_freq, itc_clockevent.shift);
+	setup_local_clockevent(&itc_clockevent, CPU_MASK_NONE);
+}
+
+
+
+#endif
+
+
+
+
+#ifdef CONFIG_TIME_INTERPOLATION
+
 static struct time_interpolator itc_interpolator = {
 	.shift = 16,
 	.mask = 0xffffffffffffffffLL,
 	.source = TIME_SOURCE_CPU
 };
 
+#endif
+
 static irqreturn_t
 timer_interrupt (int irq, void *dev_id, struct pt_regs *regs)
 {
@@ -58,38 +149,57 @@ timer_interrupt (int irq, void *dev_id, 
 
 	platform_timer_interrupt(irq, dev_id, regs);
 
+#if 0
 	new_itm = local_cpu_data->itm_next;
 
 	if (!time_after(ia64_get_itc(), new_itm))
 		printk(KERN_ERR "Oops: timer tick before it's due (itc=%lx,itm=%lx)\n",
 		       ia64_get_itc(), new_itm);
+#endif
+		
+	if (time_after(ia64_get_itc(), local_cpu_data->itm_tick_next)) {
 
-	profile_tick(CPU_PROFILING, regs);
-
-	while (1) {
-		update_process_times(user_mode(regs));
-
-		new_itm += local_cpu_data->itm_delta;
-
-		if (smp_processor_id() == TIME_KEEPER_ID) {
-			/*
-			 * Here we are in the timer irq handler. We have irqs locally
-			 * disabled, but we don't know if the timer_bh is running on
-			 * another CPU. We need to avoid to SMP race by acquiring the
-			 * xtime_lock.
-			 */
-			write_seqlock(&xtime_lock);
-			do_timer(regs);
-			local_cpu_data->itm_next = new_itm;
-			write_sequnlock(&xtime_lock);
-		} else
-			local_cpu_data->itm_next = new_itm;
+		unsigned long new_tick_itm;
+		new_tick_itm = local_cpu_data->itm_tick_next;
+		
+		profile_tick(CPU_PROFILING, regs);
+
+		while (1) {
+			update_process_times(user_mode(regs));
+
+			new_tick_itm += local_cpu_data->itm_tick_delta;
+
+			if (smp_processor_id() == TIME_KEEPER_ID) {
+				/*
+				 * Here we are in the timer irq handler. We have irqs locally
+				 * disabled, but we don't know if the timer_bh is running on
+				 * another CPU. We need to avoid to SMP race by acquiring the
+				 * xtime_lock.
+				 */
+				write_seqlock(&xtime_lock);
+				do_timer(regs);
+				local_cpu_data->itm_tick_next = new_tick_itm;
+				write_sequnlock(&xtime_lock);
+			} else
+				local_cpu_data->itm_tick_next = new_tick_itm;
+
+			if (time_after(new_tick_itm, ia64_get_itc()))
+				break;
+		}
+	}
 
-		if (time_after(new_itm, ia64_get_itc()))
-			break;
+	if (time_after(ia64_get_itc(), local_cpu_data->itm_timer_next)) {
+		if (itc_clockevent.event_handler)
+			itc_clockevent.event_handler(regs);
 	}
 
 	do {
+		// FIXME, really, please
+		new_itm = local_cpu_data->itm_tick_next;
+
+		if (time_after(new_itm, local_cpu_data->itm_timer_next))
+			new_itm = local_cpu_data->itm_timer_next;
+
 		/*
 		 * If we're too close to the next clock tick for
 		 * comfort, we increase the safety margin by
@@ -99,8 +209,8 @@ timer_interrupt (int irq, void *dev_id, 
 		 * too fast (with the potentially devastating effect
 		 * of losing monotony of time).
 		 */
-		while (!time_after(new_itm, ia64_get_itc() + local_cpu_data->itm_delta/2))
-			new_itm += local_cpu_data->itm_delta;
+		while (!time_after(new_itm, ia64_get_itc() + local_cpu_data->itm_tick_delta/2))
+			new_itm += local_cpu_data->itm_tick_delta;
 		ia64_set_itm(new_itm);
 		/* double check, in case we got hit by a (slow) PMI: */
 	} while (time_after_eq(ia64_get_itc(), new_itm));
@@ -119,7 +229,7 @@ ia64_cpu_local_tick (void)
 	/* arrange for the cycle counter to generate a timer interrupt: */
 	ia64_set_itv(IA64_TIMER_VECTOR);
 
-	delta = local_cpu_data->itm_delta;
+	delta = local_cpu_data->itm_tick_delta;
 	/*
 	 * Stagger the timer tick for each CPU so they don't occur all at (almost) the
 	 * same time:
@@ -128,8 +238,8 @@ ia64_cpu_local_tick (void)
 		unsigned long hi = 1UL << ia64_fls(cpu);
 		shift = (2*(cpu - hi) + 1) * delta/hi/2;
 	}
-	local_cpu_data->itm_next = ia64_get_itc() + delta + shift;
-	ia64_set_itm(local_cpu_data->itm_next);
+	local_cpu_data->itm_tick_next = ia64_get_itc() + delta + shift;
+	ia64_set_itm(local_cpu_data->itm_tick_next);
 }
 
 static int nojitter;
@@ -187,7 +297,7 @@ ia64_init_itm (void)
 
 	itc_freq = (platform_base_freq*itc_ratio.num)/itc_ratio.den;
 
-	local_cpu_data->itm_delta = (itc_freq + HZ/2) / HZ;
+	local_cpu_data->itm_tick_delta = (itc_freq + HZ/2) / HZ;
 	printk(KERN_DEBUG "CPU %d: base freq=%lu.%03luMHz, ITC ratio=%lu/%lu, "
 	       "ITC freq=%lu.%03luMHz", smp_processor_id(),
 	       platform_base_freq / 1000000, (platform_base_freq / 1000) % 1000,
@@ -207,6 +317,7 @@ ia64_init_itm (void)
 	local_cpu_data->nsec_per_cyc = ((NSEC_PER_SEC<<IA64_NSEC_PER_CYC_SHIFT)
 					+ itc_freq/2)/itc_freq;
 
+#ifdef CONFIG_TIME_INTERPOLATION
 	if (!(sal_platform_features & IA64_SAL_PLATFORM_FEATURE_ITC_DRIFT)) {
 		itc_interpolator.frequency = local_cpu_data->itc_freq;
 		itc_interpolator.drift = itc_drift;
@@ -225,6 +336,7 @@ ia64_init_itm (void)
 #endif
 		register_time_interpolator(&itc_interpolator);
 	}
+#endif
 
 	/* Setup the CPU local timer tick */
 	ia64_cpu_local_tick();
@@ -232,7 +344,7 @@ ia64_init_itm (void)
 
 static struct irqaction timer_irqaction = {
 	.handler =	timer_interrupt,
-	.flags =	SA_INTERRUPT,
+	.flags =	SA_INTERRUPT | SA_NODELAY,
 	.name =		"timer"
 };
 
@@ -248,6 +360,8 @@ time_init (void)
 	 * tv_nsec field must be normalized (i.e., 0 <= nsec < NSEC_PER_SEC).
 	 */
 	set_normalized_timespec(&wall_to_monotonic, -xtime.tv_sec, -xtime.tv_nsec);
+	register_itc_clocksource();
+	register_itc_clockevent();
 }
 
 /*
Index: rt25/arch/ia64/kernel/unwind_i.h
===================================================================
--- rt25.orig/arch/ia64/kernel/unwind_i.h	2006-03-20 06:53:29.000000000 +0100
+++ rt25/arch/ia64/kernel/unwind_i.h	2006-05-29 10:46:03.751017956 +0200
@@ -154,7 +154,7 @@ struct unw_script {
 	unsigned long ip;		/* ip this script is for */
 	unsigned long pr_mask;		/* mask of predicates script depends on */
 	unsigned long pr_val;		/* predicate values this script is for */
-	rwlock_t lock;
+	raw_rwlock_t lock;
 	unsigned int flags;		/* see UNW_FLAG_* in unwind.h */
 	unsigned short lru_chain;	/* used for least-recently-used chain */
 	unsigned short coll_chain;	/* used for hash collisions */
Index: rt25/arch/ia64/mm/init.c
===================================================================
--- rt25.orig/arch/ia64/mm/init.c	2006-05-29 10:43:00.980512383 +0200
+++ rt25/arch/ia64/mm/init.c	2006-05-29 10:46:03.751017956 +0200
@@ -92,16 +92,12 @@ check_pgt_cache(void)
 
 	if (unlikely(pgtable_quicklist_size <= MIN_PGT_PAGES))
 		return;
-
-	preempt_disable();
+	
 	while (unlikely((pages_to_free = min_pages_to_free()) > 0)) {
 		while (pages_to_free--) {
 			free_page((unsigned long)pgtable_quicklist_alloc());
 		}
-		preempt_enable();
-		preempt_disable();
 	}
-	preempt_enable();
 }
 
 void
Index: rt25/include/asm-ia64/processor.h
===================================================================
--- rt25.orig/include/asm-ia64/processor.h	2006-03-20 06:53:29.000000000 +0100
+++ rt25/include/asm-ia64/processor.h	2006-05-29 10:46:03.751994519 +0200
@@ -129,8 +129,10 @@ struct ia64_psr {
  */
 struct cpuinfo_ia64 {
 	__u32 softirq_pending;
-	__u64 itm_delta;	/* # of clock cycles between clock ticks */
-	__u64 itm_next;		/* interval timer mask value to use for next clock tick */
+	__u64 itm_tick_delta;	/* # of clock cycles between clock ticks */
+	__u64 itm_tick_next;	/* interval timer mask value to use for next clock tick */
+	__u64 itm_timer_next;
+	__u64 __itm_next;
 	__u64 nsec_per_cyc;	/* (1000000000<<IA64_NSEC_PER_CYC_SHIFT)/itc_freq */
 	__u64 unimpl_va_mask;	/* mask of unimplemented virtual address bits (from PAL) */
 	__u64 unimpl_pa_mask;	/* mask of unimplemented physical address bits (from PAL) */
Index: rt25/include/asm-ia64/timeofday.h
===================================================================
--- rt25.orig/include/asm-ia64/timeofday.h	2004-02-18 16:27:36.000000000 +0100
+++ rt25/include/asm-ia64/timeofday.h	2006-05-29 10:46:03.751994519 +0200
@@ -0,0 +1,5 @@
+#ifndef _ASM_IA64_TIMEOFDAY_H
+#define _ASM_IA64_TIMEOFDAY_H
+#include <asm-generic/timeofday.h>
+#endif
+
Index: rt25/include/linux/mmzone.h
===================================================================
--- rt25.orig/include/linux/mmzone.h	2006-05-29 10:43:01.404340503 +0200
+++ rt25/include/linux/mmzone.h	2006-05-29 10:46:03.752971081 +0200
@@ -139,12 +139,7 @@ struct zone {
 	/*
 	 * free areas of different sizes
 	 */
-#ifdef CONFIG_IA64
-	/* IA64 calls check_pgt_cache from cpu_idle() */
-	raw_spinlock_t		lock;
-#else
 	spinlock_t		lock;
-#endif
 #ifdef CONFIG_MEMORY_HOTPLUG
 	/* see spanned/present_pages for more description */
 	seqlock_t		span_seqlock;
Index: rt25/kernel/fork.c
===================================================================
--- rt25.orig/kernel/fork.c	2006-05-29 10:43:01.446332690 +0200
+++ rt25/kernel/fork.c	2006-05-29 10:46:03.753947644 +0200
@@ -1738,6 +1738,12 @@ static int desched_thread(void * __bind_
 		if (mmdrop_complete())
 			continue;
 		schedule();
+
+		/* This must be called from time to time on ia64, and is a no-op on other archs.
+		 * Used to be in cpu_idle(), but with the new -rt semantics it can't stay there.
+		 */
+		check_pgt_cache();
+
 		set_current_state(TASK_INTERRUPTIBLE);
 	}
 	__set_current_state(TASK_RUNNING);
Index: rt25/kernel/time/clockevents.c
===================================================================
--- rt25.orig/kernel/time/clockevents.c	2006-05-29 10:43:01.511762376 +0200
+++ rt25/kernel/time/clockevents.c	2006-05-29 10:48:49.690469049 +0200
@@ -524,7 +524,13 @@ int clockevents_set_next_event(ktime_t e
 	if (delta < sources->nextevt->min_delta_ns)
 		delta = sources->nextevt->min_delta_ns;
 
+#ifndef CONFIG_IA64
 	clc = mpy_sc32((unsigned long) delta, sources->nextevt->mult);
+#else
+	clc = (unsigned long) delta * (unsigned long) sources->nextevt->mult;
+	clc = clc >> sources->nextevt->shift;
+#endif
+
 	sources->nextevt->set_next_event(clc);
 
 	hrtimer_trace(expires, clc);
