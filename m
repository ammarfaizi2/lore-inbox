Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932507AbVI3Av2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507AbVI3Av2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 20:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932514AbVI3Av2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 20:51:28 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:47060 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932507AbVI3Av0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 20:51:26 -0400
Subject: [RFC][PATCH 9/11] generic timeofday i386 arch specific changes,
	part 5
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Darren Hart <dvhltc@us.ibm.com>, Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       George Anzinger <george@mvista.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <1128041439.8195.325.camel@cog.beaverton.ibm.com>
References: <1128040851.8195.307.camel@cog.beaverton.ibm.com>
	 <1128040939.8195.310.camel@cog.beaverton.ibm.com>
	 <1128041052.8195.312.camel@cog.beaverton.ibm.com>
	 <1128041118.8195.314.camel@cog.beaverton.ibm.com>
	 <1128041188.8195.317.camel@cog.beaverton.ibm.com>
	 <1128041282.8195.319.camel@cog.beaverton.ibm.com>
	 <1128041345.8195.321.camel@cog.beaverton.ibm.com>
	 <1128041391.8195.323.camel@cog.beaverton.ibm.com>
	 <1128041439.8195.325.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Thu, 29 Sep 2005 17:51:22 -0700
Message-Id: <1128041483.8195.327.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	The conversion of i386 to use the generic timeofday subsystem has been
split into 6 parts. This patch, the fifth of six, converts the i386 arch
to use the generic timeofday subsystem.

It applies on top of my timeofday-arch-i386-part4 patch. This patch is
the last in the the timeofday-arch-i386 patchset, so you should be able
to build and boot a kernel after it has been applied. 

Note that this patch does not provide any i386 timesources, so you will
only have the jiffies timesource. To get full replacements for the code
being removed here, the following timeofday-timesources-i386 patch will
need to be applied.

thanks
-john

 arch/i386/Kconfig            |    4 
 arch/i386/kernel/Makefile    |    1 
 arch/i386/kernel/time.c      |  219 ++++++-------------------------------------
 arch/i386/lib/delay.c        |   16 ++-
 include/asm-i386/timeofday.h |    4 
 include/asm-i386/timer.h     |   57 -----------
 6 files changed, 55 insertions(+), 246 deletions(-)

linux-2.6.14-rc2_timeofday-arch-i386-part5_B6.patch
============================================
diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -14,6 +14,10 @@ config X86
 	  486, 586, Pentiums, and various instruction-set-compatible chips by
 	  AMD, Cyrix, and others.
 
+config GENERICTOD
+	bool
+	default y
+
 config SEMAPHORE_SLEEPERS
 	bool
 	default y
diff --git a/arch/i386/kernel/Makefile b/arch/i386/kernel/Makefile
--- a/arch/i386/kernel/Makefile
+++ b/arch/i386/kernel/Makefile
@@ -10,7 +10,6 @@ obj-y	:= process.o semaphore.o signal.o 
 		doublefault.o quirks.o i8237.o tsc.o
 
 obj-y				+= cpu/
-obj-y				+= timers/
 obj-$(CONFIG_ACPI)		+= acpi/
 obj-$(CONFIG_X86_BIOS_REBOOT)	+= reboot.o
 obj-$(CONFIG_MCA)		+= mca.o
diff --git a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c
+++ b/arch/i386/kernel/time.c
@@ -56,6 +56,7 @@
 #include <asm/uaccess.h>
 #include <asm/processor.h>
 #include <asm/timer.h>
+#include <asm/timeofday.h>
 
 #include "mach_time.h"
 
@@ -91,8 +92,6 @@ EXPORT_SYMBOL(rtc_lock);
 DEFINE_SPINLOCK(i8253_lock);
 EXPORT_SYMBOL(i8253_lock);
 
-struct timer_opts *cur_timer __read_mostly = &timer_none;
-
 /*
  * This is a special lock that is owned by the CPU and holds the index
  * register we are working with.  It is required for NMI access to the
@@ -122,99 +121,19 @@ void rtc_cmos_write(unsigned char val, u
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
@@ -222,16 +141,6 @@ static int set_rtc_mmss(unsigned long no
 
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
@@ -246,11 +155,21 @@ EXPORT_SYMBOL(profile_pc);
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
@@ -283,27 +202,6 @@ static inline void do_timer_interrupt(in
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
@@ -327,58 +225,37 @@ unsigned long get_cmos_time(void)
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
@@ -387,16 +264,11 @@ static int timer_suspend(struct sys_devi
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
 
@@ -406,16 +278,8 @@ static int timer_resume(struct sys_devic
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
@@ -448,17 +312,10 @@ extern void (*late_time_init)(void);
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
@@ -476,13 +333,5 @@ void __init time_init(void)
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
diff --git a/arch/i386/lib/delay.c b/arch/i386/lib/delay.c
--- a/arch/i386/lib/delay.c
+++ b/arch/i386/lib/delay.c
@@ -13,6 +13,7 @@
 #include <linux/config.h>
 #include <linux/sched.h>
 #include <linux/delay.h>
+#include <linux/timeofday.h>
 #include <linux/module.h>
 #include <asm/processor.h>
 #include <asm/delay.h>
@@ -22,11 +23,20 @@
 #include <asm/smp.h>
 #endif
 
-extern struct timer_opts* timer;
-
+/* XXX - For now just use a simple loop delay
+ *  This has cpufreq issues, but so did the old method.
+ */
 void __delay(unsigned long loops)
 {
-	cur_timer->delay(loops);
+	int d0;
+	__asm__ __volatile__(
+		"\tjmp 1f\n"
+		".align 16\n"
+		"1:\tjmp 2f\n"
+		".align 16\n"
+		"2:\tdecl %0\n\tjns 2b"
+		:"=&a" (d0)
+		:"0" (loops));
 }
 
 inline void __const_udelay(unsigned long xloops)
diff --git a/include/asm-i386/timeofday.h b/include/asm-i386/timeofday.h
new file mode 100644
--- /dev/null
+++ b/include/asm-i386/timeofday.h
@@ -0,0 +1,4 @@
+#ifndef _ASM_I386_TIMEOFDAY_H
+#define _ASM_I386_TIMEOFDAY_H
+#include <asm-generic/timeofday.h>
+#endif
diff --git a/include/asm-i386/timer.h b/include/asm-i386/timer.h
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


