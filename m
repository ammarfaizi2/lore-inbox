Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbWCWDHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbWCWDHJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 22:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932551AbWCWDG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 22:06:58 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:16854 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932129AbWCWDGn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 22:06:43 -0500
Date: Wed, 22 Mar 2006 20:06:39 -0700
From: john stultz <johnstul@us.ibm.com>
To: akpm@osdl.org
Cc: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org,
       george@wildturkeyranch.net, Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Roman Zippel <zippel@linux-m68k.org>, Ingo Molnar <mingo@elte.hu>,
       Paul Mackerras <paulus@samba.org>
Message-Id: <20060323030638.19338.93592.sendpatchset@cog.beaverton.ibm.com>
In-Reply-To: <20060323030547.19338.95102.sendpatchset@cog.beaverton.ibm.com>
References: <20060323030547.19338.95102.sendpatchset@cog.beaverton.ibm.com>
Subject: [PATCH 8/10] Time: i386 Conversion - part 3: Enable Generic Timekeeping
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	This converts the i386 arch to use the generic timeofday 
subsystem. It enabled the GENERIC_TIME option, disables the timer_opts 
code and other arch specific timekeeping code and reworks the delay 
code.

While this patch enables the generic timekeeping, please note that this 
patch does not provide any i386 clocksource. Thus only the jiffies 
clocksource will be available. To get full replacements for the code 
being disabled here, the timeofday-clocks-i386 patch will needed.

thanks
-john

Signed-off-by: John Stultz <johnstul@us.ibm.com>

 arch/i386/Kconfig         |    4 +
 arch/i386/kernel/Makefile |    1 
 arch/i386/kernel/time.c   |  153 +++++-----------------------------------------
 arch/i386/kernel/tsc.c    |    3 
 arch/i386/lib/delay.c     |   65 +++++++++++++++++--
 include/asm-i386/delay.h  |    2 
 include/asm-i386/timer.h  |   57 -----------------
 7 files changed, 84 insertions(+), 201 deletions(-)

linux-2.6.16_timeofday-arch-i386-part3_C1.patch
============================================
diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
index 5b1a7d4..5f125f4 100644
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -14,6 +14,10 @@ config X86_32
 	  486, 586, Pentiums, and various instruction-set-compatible chips by
 	  AMD, Cyrix, and others.
 
+config GENERIC_TIME
+	bool
+	default y
+
 config SEMAPHORE_SLEEPERS
 	bool
 	default y
diff --git a/arch/i386/kernel/Makefile b/arch/i386/kernel/Makefile
index 16a2420..1477e69 100644
--- a/arch/i386/kernel/Makefile
+++ b/arch/i386/kernel/Makefile
@@ -10,7 +10,6 @@ obj-y	:= process.o semaphore.o signal.o 
 		quirks.o i8237.o i8253.o tsc.o topology.o
 
 obj-y				+= cpu/
-obj-y				+= timers/
 obj-y				+= acpi/
 obj-$(CONFIG_X86_BIOS_REBOOT)	+= reboot.o
 obj-$(CONFIG_MCA)		+= mca.o
diff --git a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
index 796e5fa..2a6ab86 100644
--- a/arch/i386/kernel/time.c
+++ b/arch/i386/kernel/time.c
@@ -82,7 +82,8 @@ extern unsigned long wall_jiffies;
 DEFINE_SPINLOCK(rtc_lock);
 EXPORT_SYMBOL(rtc_lock);
 
-struct timer_opts *cur_timer __read_mostly = &timer_none;
+/* XXX - necessary to keep things compiling. to be removed later */
+u32 pmtmr_ioport;
 
 /*
  * This is a special lock that is owned by the CPU and holds the index
@@ -113,99 +114,19 @@ void rtc_cmos_write(unsigned char val, u
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
@@ -213,16 +134,6 @@ static int set_rtc_mmss(unsigned long no
 
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
@@ -237,11 +148,21 @@ EXPORT_SYMBOL(profile_pc);
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
@@ -274,27 +195,6 @@ static inline void do_timer_interrupt(in
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
 
@@ -375,7 +275,6 @@ void notify_arch_cmos_timer(void)
 
 static long clock_cmos_diff, sleep_start;
 
-static struct timer_opts *last_timer;
 static int timer_suspend(struct sys_device *dev, pm_message_t state)
 {
 	/*
@@ -384,10 +283,6 @@ static int timer_suspend(struct sys_devi
 	clock_cmos_diff = -get_cmos_time();
 	clock_cmos_diff += get_seconds();
 	sleep_start = get_cmos_time();
-	last_timer = cur_timer;
-	cur_timer = &timer_none;
-	if (last_timer->suspend)
-		last_timer->suspend(state);
 	return 0;
 }
 
@@ -410,10 +305,6 @@ static int timer_resume(struct sys_devic
 	jiffies_64 += sleep_length;
 	wall_jiffies += sleep_length;
 	write_sequnlock_irqrestore(&xtime_lock, flags);
-	if (last_timer->resume)
-		last_timer->resume();
-	cur_timer = last_timer;
-	last_timer = NULL;
 	touch_softlockup_watchdog();
 	return 0;
 }
@@ -455,9 +346,6 @@ static void __init hpet_time_init(void)
 		printk("Using HPET for base-timer\n");
 	}
 
-	cur_timer = select_timer();
-	printk(KERN_INFO "Using %s for high-res timesource\n",cur_timer->name);
-
 	time_init_hook();
 }
 #endif
@@ -479,8 +367,5 @@ void __init time_init(void)
 	set_normalized_timespec(&wall_to_monotonic,
 		-xtime.tv_sec, -xtime.tv_nsec);
 
-	cur_timer = select_timer();
-	printk(KERN_INFO "Using %s for high-res timesource\n",cur_timer->name);
-
 	time_init_hook();
 }
diff --git a/arch/i386/kernel/tsc.c b/arch/i386/kernel/tsc.c
index b1f588c..8a940b5 100644
--- a/arch/i386/kernel/tsc.c
+++ b/arch/i386/kernel/tsc.c
@@ -10,6 +10,7 @@
 #include <linux/init.h>
 
 #include <asm/tsc.h>
+#include <asm/delay.h>
 #include <asm/io.h>
 
 #include "mach_timer.h"
@@ -45,7 +46,6 @@ static int __init tsc_setup(char *str)
 
 __setup("notsc", tsc_setup);
 
-
 /*
  * code to mark and check if the TSC is unstable
  * due to cpufreq or due to unsynced TSCs
@@ -205,6 +205,7 @@ void tsc_init(void)
 				(unsigned long)cpu_khz % 1000);
 
 	set_cyc2ns_scale(cpu_khz);
+	use_tsc_delay();
 }
 
 #ifdef CONFIG_CPU_FREQ
diff --git a/arch/i386/lib/delay.c b/arch/i386/lib/delay.c
index c49a6ac..3c0714c 100644
--- a/arch/i386/lib/delay.c
+++ b/arch/i386/lib/delay.c
@@ -10,43 +10,92 @@
  *	we have to worry about.
  */
 
+#include <linux/module.h>
 #include <linux/config.h>
 #include <linux/sched.h>
 #include <linux/delay.h>
-#include <linux/module.h>
+
 #include <asm/processor.h>
 #include <asm/delay.h>
 #include <asm/timer.h>
 
 #ifdef CONFIG_SMP
-#include <asm/smp.h>
+# include <asm/smp.h>
 #endif
 
-extern struct timer_opts* timer;
+/* simple loop based delay: */
+static void delay_loop(unsigned long loops)
+{
+	int d0;
+
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
+/* TSC based delay: */
+static void delay_tsc(unsigned long loops)
+{
+	unsigned long bclock, now;
+
+	rdtscl(bclock);
+	do {
+		rep_nop();
+		rdtscl(now);
+	} while ((now-bclock) < loops);
+}
+
+/*
+ * Since we calibrate only once at boot, this
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
 
 void __delay(unsigned long loops)
 {
-	cur_timer->delay(loops);
+	delay_fn(loops);
 }
 
 inline void __const_udelay(unsigned long xloops)
 {
 	int d0;
+
 	xloops *= 4;
 	__asm__("mull %0"
 		:"=d" (xloops), "=&a" (d0)
-		:"1" (xloops),"0" (cpu_data[raw_smp_processor_id()].loops_per_jiffy * (HZ/4)));
-        __delay(++xloops);
+		:"1" (xloops), "0"
+		(cpu_data[raw_smp_processor_id()].loops_per_jiffy * (HZ/4)));
+
+	__delay(++xloops);
 }
 
 void __udelay(unsigned long usecs)
 {
-	__const_udelay(usecs * 0x000010c7);  /* 2**32 / 1000000 (rounded up) */
+	__const_udelay(usecs * 0x000010c7); /* 2**32 / 1000000 (rounded up) */
 }
 
 void __ndelay(unsigned long nsecs)
 {
-	__const_udelay(nsecs * 0x00005);  /* 2**32 / 1000000000 (rounded up) */
+	__const_udelay(nsecs * 0x00005); /* 2**32 / 1000000000 (rounded up) */
 }
 
 EXPORT_SYMBOL(__delay);
diff --git a/include/asm-i386/delay.h b/include/asm-i386/delay.h
index 456db85..b1c7650 100644
--- a/include/asm-i386/delay.h
+++ b/include/asm-i386/delay.h
@@ -23,4 +23,6 @@ extern void __delay(unsigned long loops)
 	((n) > 20000 ? __bad_ndelay() : __const_udelay((n) * 5ul)) : \
 	__ndelay(n))
 
+void use_tsc_delay(void);
+
 #endif /* defined(_I386_DELAY_H) */
diff --git a/include/asm-i386/timer.h b/include/asm-i386/timer.h
index aed1643..d0ebd05 100644
--- a/include/asm-i386/timer.h
+++ b/include/asm-i386/timer.h
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
