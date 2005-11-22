Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964839AbVKVBii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbVKVBii (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 20:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbVKVBg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 20:36:28 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:16871 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S964833AbVKVBgR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 20:36:17 -0500
Date: Mon, 21 Nov 2005 18:36:16 -0700
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Darren Hart <dvhltc@us.ibm.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       john stultz <johnstul@us.ibm.com>
Message-Id: <20051122013614.18537.87345.sendpatchset@cog.beaverton.ibm.com>
In-Reply-To: <20051122013515.18537.76463.sendpatchset@cog.beaverton.ibm.com>
References: <20051122013515.18537.76463.sendpatchset@cog.beaverton.ibm.com>
Subject: [PATCH 9/13] Time: i386 Conversion - part 5: Enable Generic Timekeeping
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	The conversion of i386 to use the generic timeofday subsystem has been
split into 6 parts. This patch, the fifth of six, converts the i386 arch
to use the generic timeofday subsystem.

It applies on top of my timeofday-arch-i386-part4 patch. This patch is
the last in the timeofday-arch-i386 patchset, so you should be able to
build and boot a kernel after it has been applied. 

Note that this patch does not provide any i386 clocksource, so you will
only have the jiffies clocksource. To get full replacements for the code
being removed here, the following timeofday-clocks-i386 patch will need
to be applied.

thanks
-john

Signed-off-by: John Stultz <johnstul@us.ibm.com>

linux-2.6.15-rc1-mm2_timeofday-arch-i386-part5_B11.patch
============================================
diff -ruN tod-mm_1/arch/i386/Kconfig tod-mm_2/arch/i386/Kconfig
--- tod-mm_1/arch/i386/Kconfig	2005-11-21 16:39:09.000000000 -0800
+++ tod-mm_2/arch/i386/Kconfig	2005-11-21 16:52:33.000000000 -0800
@@ -14,6 +14,10 @@
 	  486, 586, Pentiums, and various instruction-set-compatible chips by
 	  AMD, Cyrix, and others.
 
+config GENERIC_TIME
+	bool
+	default y
+
 config SEMAPHORE_SLEEPERS
 	bool
 	default y
diff -ruN tod-mm_1/arch/i386/kernel/Makefile tod-mm_2/arch/i386/kernel/Makefile
--- tod-mm_1/arch/i386/kernel/Makefile	2005-11-21 16:51:16.000000000 -0800
+++ tod-mm_2/arch/i386/kernel/Makefile	2005-11-21 16:52:33.000000000 -0800
@@ -10,7 +10,6 @@
 		quirks.o i8237.o i8253.o tsc.o
 
 obj-y				+= cpu/
-obj-y				+= timers/
 obj-$(CONFIG_ACPI)		+= acpi/
 obj-$(CONFIG_X86_BIOS_REBOOT)	+= reboot.o
 obj-$(CONFIG_MCA)		+= mca.o
diff -ruN tod-mm_1/arch/i386/kernel/time.c tod-mm_2/arch/i386/kernel/time.c
--- tod-mm_1/arch/i386/kernel/time.c	2005-11-21 16:50:17.000000000 -0800
+++ tod-mm_2/arch/i386/kernel/time.c	2005-11-21 16:52:33.000000000 -0800
@@ -56,6 +56,7 @@
 #include <asm/uaccess.h>
 #include <asm/processor.h>
 #include <asm/timer.h>
+#include <asm/timeofday.h>
 
 #include "mach_time.h"
 
@@ -82,8 +83,6 @@
 DEFINE_SPINLOCK(rtc_lock);
 EXPORT_SYMBOL(rtc_lock);
 
-struct timer_opts *cur_timer __read_mostly = &timer_none;
-
 /*
  * This is a special lock that is owned by the CPU and holds the index
  * register we are working with.  It is required for NMI access to the
@@ -113,99 +112,19 @@
 }
 EXPORT_SYMBOL(rtc_cmos_write);
 
-/*
- * This version of gettimeofday has microsecond resolution
- * and better than microsecond precision on fast x86 machines with TSC.
- */
-void do_gettimeofday(struct timeval *tv)
-{
-	unsigned long seq;
-	unsigned long usec, sec;
-	unsigned long max_ntp_tick;
-
-	do {
-		unsigned long lost;
-
-		seq = read_seqbegin(&xtime_lock);
-
-		usec = cur_timer->get_offset();
-		lost = jiffies - wall_jiffies;
-
-		/*
-		 * If time_adjust is negative then NTP is slowing the clock
-		 * so make sure not to go into next possible interval.
-		 * Better to lose some accuracy than have time go backwards..
-		 */
-		if (unlikely(time_adjust < 0)) {
-			max_ntp_tick = (USEC_PER_SEC / HZ) - tickadj;
-			usec = min(usec, max_ntp_tick);
-
-			if (lost)
-				usec += lost * max_ntp_tick;
-		}
-		else if (unlikely(lost))
-			usec += lost * (USEC_PER_SEC / HZ);
-
-		sec = xtime.tv_sec;
-		usec += (xtime.tv_nsec / 1000);
-	} while (read_seqretry(&xtime_lock, seq));
-
-	while (usec >= 1000000) {
-		usec -= 1000000;
-		sec++;
-	}
-
-	tv->tv_sec = sec;
-	tv->tv_usec = usec;
-}
-
-EXPORT_SYMBOL(do_gettimeofday);
-
-int do_settimeofday(struct timespec *tv)
-{
-	time_t wtm_sec, sec = tv->tv_sec;
-	long wtm_nsec, nsec = tv->tv_nsec;
-
-	if ((unsigned long)tv->tv_nsec >= NSEC_PER_SEC)
-		return -EINVAL;
-
-	write_seqlock_irq(&xtime_lock);
-	/*
-	 * This is revolting. We need to set "xtime" correctly. However, the
-	 * value in this location is the value at the most recent update of
-	 * wall time.  Discover what correction gettimeofday() would have
-	 * made, and then undo it!
-	 */
-	nsec -= cur_timer->get_offset() * NSEC_PER_USEC;
-	nsec -= (jiffies - wall_jiffies) * TICK_NSEC;
-
-	wtm_sec  = wall_to_monotonic.tv_sec + (xtime.tv_sec - sec);
-	wtm_nsec = wall_to_monotonic.tv_nsec + (xtime.tv_nsec - nsec);
-
-	set_normalized_timespec(&xtime, sec, nsec);
-	set_normalized_timespec(&wall_to_monotonic, wtm_sec, wtm_nsec);
-
-	ntp_clear();
-	write_sequnlock_irq(&xtime_lock);
-	clock_was_set();
-	return 0;
-}
-
-EXPORT_SYMBOL(do_settimeofday);
-
 static int set_rtc_mmss(unsigned long nowtime)
 {
 	int retval;
-
-	WARN_ON(irqs_disabled());
+	unsigned long flags;
 
 	/* gets recalled with irq locally disabled */
-	spin_lock_irq(&rtc_lock);
+	/* XXX - does irqsave resolve this? -johnstul */
+	spin_lock_irqsave(&rtc_lock, flags);
 	if (efi_enabled)
 		retval = efi_set_rtc_mmss(nowtime);
 	else
 		retval = mach_set_rtc_mmss(nowtime);
-	spin_unlock_irq(&rtc_lock);
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	return retval;
 }
@@ -213,16 +132,6 @@
 
 int timer_ack;
 
-/* monotonic_clock(): returns # of nanoseconds passed since time_init()
- *		Note: This function is required to return accurate
- *		time even in the absence of multiple timer ticks.
- */
-unsigned long long monotonic_clock(void)
-{
-	return cur_timer->monotonic_clock();
-}
-EXPORT_SYMBOL(monotonic_clock);
-
 #if defined(CONFIG_SMP) && defined(CONFIG_FRAME_POINTER)
 unsigned long profile_pc(struct pt_regs *regs)
 {
@@ -237,11 +146,21 @@
 #endif
 
 /*
- * timer_interrupt() needs to keep up the real-time clock,
- * as well as call the "do_timer()" routine every clocktick
+ * This is the same as the above, except we _also_ save the current
+ * Time Stamp Counter value at the time of the timer interrupt, so that
+ * we later on can estimate the time of day more exactly.
  */
-static inline void do_timer_interrupt(int irq, struct pt_regs *regs)
+irqreturn_t timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
+	/*
+	 * Here we are in the timer irq handler. We just have irqs locally
+	 * disabled but we don't know if the timer_bh is running on the other
+	 * CPU. We need to avoid to SMP race with it. NOTE: we don' t need
+	 * the irq version of write_lock because as just said we have irq
+	 * locally disabled. -arca
+	 */
+	write_seqlock(&xtime_lock);
+
 #ifdef CONFIG_X86_IO_APIC
 	if (timer_ack) {
 		/*
@@ -274,27 +193,6 @@
 		irq = inb_p( 0x61 );	/* read the current state */
 		outb_p( irq|0x80, 0x61 );	/* reset the IRQ */
 	}
-}
-
-/*
- * This is the same as the above, except we _also_ save the current
- * Time Stamp Counter value at the time of the timer interrupt, so that
- * we later on can estimate the time of day more exactly.
- */
-irqreturn_t timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
-{
-	/*
-	 * Here we are in the timer irq handler. We just have irqs locally
-	 * disabled but we don't know if the timer_bh is running on the other
-	 * CPU. We need to avoid to SMP race with it. NOTE: we don' t need
-	 * the irq version of write_lock because as just said we have irq
-	 * locally disabled. -arca
-	 */
-	write_seqlock(&xtime_lock);
-
-	cur_timer->mark_offset();
- 
-	do_timer_interrupt(irq, regs);
 
 	write_sequnlock(&xtime_lock);
 	return IRQ_HANDLED;
@@ -318,58 +216,37 @@
 }
 EXPORT_SYMBOL(get_cmos_time);
 
-static void sync_cmos_clock(unsigned long dummy);
-
-static DEFINE_TIMER(sync_cmos_timer, sync_cmos_clock, 0, 0);
-
-static void sync_cmos_clock(unsigned long dummy)
+/* arch specific timeofday hooks */
+nsec_t read_persistent_clock(void)
 {
-	struct timeval now, next;
-	int fail = 1;
+	return (nsec_t)get_cmos_time() * NSEC_PER_SEC;
+}
 
+void sync_persistent_clock(struct timespec ts)
+{
+	static unsigned long last_rtc_update;
 	/*
 	 * If we have an externally synchronized Linux clock, then update
 	 * CMOS clock accordingly every ~11 minutes. Set_rtc_mmss() has to be
 	 * called as close as possible to 500 ms before the new second starts.
-	 * This code is run on a timer.  If the clock is set, that timer
-	 * may not expire at the correct time.  Thus, we adjust...
 	 */
-	if (!ntp_synced())
-		/*
-		 * Not synced, exit, do not restart a timer (if one is
-		 * running, let it run out).
-		 */
+	if (ts.tv_sec <= last_rtc_update + 660)
 		return;
 
-	do_gettimeofday(&now);
-	if (now.tv_usec >= USEC_AFTER - ((unsigned) TICK_SIZE) / 2 &&
-	    now.tv_usec <= USEC_BEFORE + ((unsigned) TICK_SIZE) / 2)
-		fail = set_rtc_mmss(now.tv_sec);
-
-	next.tv_usec = USEC_AFTER - now.tv_usec;
-	if (next.tv_usec <= 0)
-		next.tv_usec += USEC_PER_SEC;
-
-	if (!fail)
-		next.tv_sec = 659;
-	else
-		next.tv_sec = 0;
-
-	if (next.tv_usec >= USEC_PER_SEC) {
-		next.tv_sec++;
-		next.tv_usec -= USEC_PER_SEC;
+	if((ts.tv_nsec / 1000) >= USEC_AFTER - ((unsigned) TICK_SIZE) / 2 &&
+		(ts.tv_nsec / 1000) <= USEC_BEFORE + ((unsigned) TICK_SIZE) / 2) {
+		/* horrible...FIXME */
+		if (set_rtc_mmss(ts.tv_sec) == 0)
+			last_rtc_update = ts.tv_sec;
+		else
+			last_rtc_update = ts.tv_sec - 600; /* do it again in 60 s */
 	}
-	mod_timer(&sync_cmos_timer, jiffies + timeval_to_jiffies(&next));
 }
 
-void notify_arch_cmos_timer(void)
-{
-	mod_timer(&sync_cmos_timer, jiffies + 1);
-}
+
 
 static long clock_cmos_diff, sleep_start;
 
-static struct timer_opts *last_timer;
 static int timer_suspend(struct sys_device *dev, pm_message_t state)
 {
 	/*
@@ -378,16 +255,11 @@
 	clock_cmos_diff = -get_cmos_time();
 	clock_cmos_diff += get_seconds();
 	sleep_start = get_cmos_time();
-	last_timer = cur_timer;
-	cur_timer = &timer_none;
-	if (last_timer->suspend)
-		last_timer->suspend(state);
 	return 0;
 }
 
 static int timer_resume(struct sys_device *dev)
 {
-	unsigned long flags;
 	unsigned long sec;
 	unsigned long sleep_length;
 
@@ -397,16 +269,8 @@
 #endif
 	sec = get_cmos_time() + clock_cmos_diff;
 	sleep_length = (get_cmos_time() - sleep_start) * HZ;
-	write_seqlock_irqsave(&xtime_lock, flags);
-	xtime.tv_sec = sec;
-	xtime.tv_nsec = 0;
-	write_sequnlock_irqrestore(&xtime_lock, flags);
 	jiffies += sleep_length;
 	wall_jiffies += sleep_length;
-	if (last_timer->resume)
-		last_timer->resume();
-	cur_timer = last_timer;
-	last_timer = NULL;
 	touch_softlockup_watchdog();
 	return 0;
 }
@@ -439,17 +303,10 @@
 /* Duplicate of time_init() below, with hpet_enable part added */
 static void __init hpet_time_init(void)
 {
-	xtime.tv_sec = get_cmos_time();
-	xtime.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
-	set_normalized_timespec(&wall_to_monotonic,
-		-xtime.tv_sec, -xtime.tv_nsec);
-
 	if ((hpet_enable() >= 0) && hpet_use_timer) {
 		printk("Using HPET for base-timer\n");
 	}
 
-	cur_timer = select_timer();
-	printk(KERN_INFO "Using %s for high-res timesource\n",cur_timer->name);
 
 	time_init_hook();
 }
@@ -467,13 +324,5 @@
 		return;
 	}
 #endif
-	xtime.tv_sec = get_cmos_time();
-	xtime.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
-	set_normalized_timespec(&wall_to_monotonic,
-		-xtime.tv_sec, -xtime.tv_nsec);
-
-	cur_timer = select_timer();
-	printk(KERN_INFO "Using %s for high-res timesource\n",cur_timer->name);
-
 	time_init_hook();
 }
diff -ruN tod-mm_1/arch/i386/kernel/tsc.c tod-mm_2/arch/i386/kernel/tsc.c
--- tod-mm_1/arch/i386/kernel/tsc.c	2005-11-21 16:52:00.000000000 -0800
+++ tod-mm_2/arch/i386/kernel/tsc.c	2005-11-21 16:52:33.000000000 -0800
@@ -8,6 +8,7 @@
 #include <linux/cpufreq.h>
 #include <linux/jiffies.h>
 #include <asm/tsc.h>
+#include <asm/delay.h>
 #include <asm/io.h>
 #include "mach_timer.h"
 
@@ -36,16 +37,6 @@
 #endif
 __setup("notsc", tsc_setup);
 
-
-int read_current_timer(unsigned long *timer_val)
-{
-	if (!tsc_disable && cpu_khz) {
-		rdtscl(*timer_val);
-		return 0;
-	}
-	return -1;
-}
-
 /* Code to mark and check if the TSC is unstable
  * due to cpufreq or due to unsynced TSCs
  */
@@ -210,6 +201,7 @@
 				(unsigned long)cpu_khz % 1000);
 
 	set_cyc2ns_scale(cpu_khz);
+	use_tsc_delay();
 }
 
 
diff -ruN tod-mm_1/arch/i386/lib/delay.c tod-mm_2/arch/i386/lib/delay.c
--- tod-mm_1/arch/i386/lib/delay.c	2005-11-21 16:39:09.000000000 -0800
+++ tod-mm_2/arch/i386/lib/delay.c	2005-11-21 16:52:33.000000000 -0800
@@ -13,6 +13,7 @@
 #include <linux/config.h>
 #include <linux/sched.h>
 #include <linux/delay.h>
+#include <linux/timeofday.h>
 #include <linux/module.h>
 #include <asm/processor.h>
 #include <asm/delay.h>
@@ -22,11 +23,54 @@
 #include <asm/smp.h>
 #endif
 
-extern struct timer_opts* timer;
+/* simple loop based delay */
+static void delay_loop(unsigned long loops)
+{
+	int d0;
+	__asm__ __volatile__(
+		"\tjmp 1f\n"
+		".align 16\n"
+		"1:\tjmp 2f\n"
+		".align 16\n"
+		"2:\tdecl %0\n\tjns 2b"
+		:"=&a" (d0)
+		:"0" (loops));
+}
+
+/* TSC based delay */
+static void delay_tsc(unsigned long loops)
+{
+	unsigned long bclock, now;
+	rdtscl(bclock);
+	do {
+		rep_nop();
+		rdtscl(now);
+	} while ((now-bclock) < loops);
+}
+
+/* Since we calibrate only once at boot, this
+ * function should be set once at boot and not changed
+ */
+static void (*delay_fn)(unsigned long) = delay_loop;
+
+void use_tsc_delay(void)
+{
+	delay_fn = delay_tsc;
+}
+
+int read_current_timer(unsigned long *timer_val)
+{
+	if (delay_fn == delay_tsc) {
+		rdtscl(*timer_val);
+		return 0;
+	}
+	return -1;
+}
+
 
 void __delay(unsigned long loops)
 {
-	cur_timer->delay(loops);
+	delay_fn(loops);
 }
 
 inline void __const_udelay(unsigned long xloops)
diff -ruN tod-mm_1/include/asm-i386/delay.h tod-mm_2/include/asm-i386/delay.h
--- tod-mm_1/include/asm-i386/delay.h	2005-11-21 16:39:14.000000000 -0800
+++ tod-mm_2/include/asm-i386/delay.h	2005-11-21 16:52:33.000000000 -0800
@@ -23,4 +23,6 @@
 	((n) > 20000 ? __bad_ndelay() : __const_udelay((n) * 5ul)) : \
 	__ndelay(n))
 
+void use_tsc_delay(void);
+
 #endif /* defined(_I386_DELAY_H) */
diff -ruN tod-mm_1/include/asm-i386/timeofday.h tod-mm_2/include/asm-i386/timeofday.h
--- tod-mm_1/include/asm-i386/timeofday.h	1969-12-31 16:00:00.000000000 -0800
+++ tod-mm_2/include/asm-i386/timeofday.h	2005-11-21 16:52:33.000000000 -0800
@@ -0,0 +1,4 @@
+#ifndef _ASM_I386_TIMEOFDAY_H
+#define _ASM_I386_TIMEOFDAY_H
+#include <asm-generic/timeofday.h>
+#endif
diff -ruN tod-mm_1/include/asm-i386/timer.h tod-mm_2/include/asm-i386/timer.h
--- tod-mm_1/include/asm-i386/timer.h	2005-11-21 16:39:14.000000000 -0800
+++ tod-mm_2/include/asm-i386/timer.h	2005-11-21 16:52:33.000000000 -0800
@@ -3,68 +3,11 @@
 #include <linux/init.h>
 #include <linux/pm.h>
 
-/**
- * struct timer_ops - used to define a timer source
- *
- * @name: name of the timer.
- * @init: Probes and initializes the timer. Takes clock= override 
- *        string as an argument. Returns 0 on success, anything else
- *        on failure.
- * @mark_offset: called by the timer interrupt.
- * @get_offset:  called by gettimeofday(). Returns the number of microseconds
- *               since the last timer interupt.
- * @monotonic_clock: returns the number of nanoseconds since the init of the
- *                   timer.
- * @delay: delays this many clock cycles.
- */
-struct timer_opts {
-	char* name;
-	void (*mark_offset)(void);
-	unsigned long (*get_offset)(void);
-	unsigned long long (*monotonic_clock)(void);
-	void (*delay)(unsigned long);
-	unsigned long (*read_timer)(void);
-	int (*suspend)(pm_message_t state);
-	int (*resume)(void);
-};
-
-struct init_timer_opts {
-	int (*init)(char *override);
-	struct timer_opts *opts;
-};
-
 #define TICK_SIZE (tick_nsec / 1000)
-
-extern struct timer_opts* __init select_timer(void);
-extern void clock_fallback(void);
 void setup_pit_timer(void);
-
 /* Modifiers for buggy PIT handling */
-
 extern int pit_latch_buggy;
-
-extern struct timer_opts *cur_timer;
 extern int timer_ack;
-
-/* list of externed timers */
-extern struct timer_opts timer_none;
-extern struct timer_opts timer_pit;
-extern struct init_timer_opts timer_pit_init;
-extern struct init_timer_opts timer_tsc_init;
-#ifdef CONFIG_X86_CYCLONE_TIMER
-extern struct init_timer_opts timer_cyclone_init;
-#endif
-
-extern unsigned long calibrate_tsc(void);
-extern unsigned long read_timer_tsc(void);
-extern void init_cpu_khz(void);
 extern int recalibrate_cpu_khz(void);
-#ifdef CONFIG_HPET_TIMER
-extern struct init_timer_opts timer_hpet_init;
-extern unsigned long calibrate_tsc_hpet(unsigned long *tsc_hpet_quotient_ptr);
-#endif
 
-#ifdef CONFIG_X86_PM_TIMER
-extern struct init_timer_opts timer_pmtmr_init;
-#endif
 #endif
