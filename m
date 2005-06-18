Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261667AbVFRDPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbVFRDPK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 23:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbVFRDPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 23:15:10 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:28867 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261906AbVFRDDA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 23:03:00 -0400
Subject: [PATCH 5/6] new timeofday i386 arch specific changes, part 4 for
	-mm  (v.B3)
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Nishanth Aravamudan <nacc@us.ibm.com>, Darren Hart <darren@dvhart.com>,
       "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org, kernel-stuff@comcast.net, frank@tuxrocks.com
In-Reply-To: <1119063690.9947.1.camel@cog.beaverton.ibm.com>
References: <1119063400.9663.2.camel@cog.beaverton.ibm.com>
	 <1119063484.9663.4.camel@cog.beaverton.ibm.com>
	 <1119063557.9663.6.camel@cog.beaverton.ibm.com>
	 <1119063690.9947.1.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Fri, 17 Jun 2005 20:02:47 -0700
Message-Id: <1119063767.9947.3.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, All,
	To hopefully improve the review-ability of my changes, I've split up my
arch-i386 patch into four chunks. This patch converts the i386 arch to
use the new timeofday subsystem and removes the old timers/timer_opts
infrastructure. 
	
It applies on top of my timeofday-arch-i386-part3_B3 patch. This patch
is the last in the the timeofday-arch-i386 patchset, so you should be
able to build and boot a kernel after it has been applied. 

Note that this patch does not provide any i386 timesources, so you will
only have the jiffies timesource. To get full replacements for the code
being removed here, the following timeofday-timesources-i386 patch will
need to be applied.

Andrew, please consider for inclusion for testing into your tree.

thanks
-john

Signed-off-by: John Stultz <johnstul@us.ibm.com>

linux-2.6.12-rc6-mm1_timeofday-arch-i386-part4_B3.patch
=======================================================

diff -ruN linux-2.6.12-rc6-mm1/arch/i386/Kconfig linux-2.6.12-rc6-mm1-tod/arch/i386/Kconfig
--- linux-2.6.12-rc6-mm1/arch/i386/Kconfig	2005-06-17 19:22:40.047521801 -0700
+++ linux-2.6.12-rc6-mm1-tod/arch/i386/Kconfig	2005-06-17 19:05:21.000000000 -0700
@@ -14,6 +14,10 @@
 	  486, 586, Pentiums, and various instruction-set-compatible chips by
 	  AMD, Cyrix, and others.
 
+config NEWTOD
+	bool
+	default y
+
 config MMU
 	bool
 	default y
diff -ruN linux-2.6.12-rc6-mm1/arch/i386/kernel/Makefile linux-2.6.12-rc6-mm1-tod/arch/i386/kernel/Makefile
--- linux-2.6.12-rc6-mm1/arch/i386/kernel/Makefile	2005-06-17 19:22:40.047521801 -0700
+++ linux-2.6.12-rc6-mm1-tod/arch/i386/kernel/Makefile	2005-06-17 19:05:21.000000000 -0700
@@ -10,7 +10,6 @@
 		doublefault.o quirks.o tsc.o
 
 obj-y				+= cpu/
-obj-y				+= timers/
 obj-$(CONFIG_ACPI_BOOT)		+= acpi/
 obj-$(CONFIG_X86_BIOS_REBOOT)	+= reboot.o
 obj-$(CONFIG_MCA)		+= mca.o
diff -ruN linux-2.6.12-rc6-mm1/arch/i386/kernel/time.c linux-2.6.12-rc6-mm1-tod/arch/i386/kernel/time.c
--- linux-2.6.12-rc6-mm1/arch/i386/kernel/time.c	2005-06-17 19:22:40.049521552 -0700
+++ linux-2.6.12-rc6-mm1-tod/arch/i386/kernel/time.c	2005-06-17 19:07:22.000000000 -0700
@@ -56,6 +56,7 @@
 #include <asm/uaccess.h>
 #include <asm/processor.h>
 #include <asm/timer.h>
+#include <asm/timeofday.h>
 
 #include "mach_time.h"
 
@@ -88,8 +89,6 @@
 DEFINE_SPINLOCK(i8253_lock);
 EXPORT_SYMBOL(i8253_lock);
 
-struct timer_opts *cur_timer = &timer_none;
-
 /*
  * This is a special lock that is owned by the CPU and holds the index
  * register we are working with.  It is required for NMI access to the
@@ -119,102 +118,19 @@
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
-	time_adjust = 0;		/* stop active adjtime() */
-	time_status |= STA_UNSYNC;
-	time_maxerror = NTP_PHASE_LIMIT;
-	time_esterror = NTP_PHASE_LIMIT;
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
@@ -222,16 +138,6 @@
 
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
@@ -246,12 +152,21 @@
 #endif
 
 /*
- * timer_interrupt() needs to keep up the real-time clock,
- * as well as call the "do_timer()" routine every clocktick
+ * This is the same as the above, except we _also_ save the current
+ * Time Stamp Counter value at the time of the timer interrupt, so that
+ * we later on can estimate the time of day more exactly.
  */
-static inline void do_timer_interrupt(int irq, void *dev_id,
-					struct pt_regs *regs)
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
@@ -284,27 +199,6 @@
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
-	do_timer_interrupt(irq, NULL, regs);
 
 	write_sequnlock(&xtime_lock);
 	return IRQ_HANDLED;
@@ -328,55 +222,34 @@
 }
 EXPORT_SYMBOL(get_cmos_time);
 
-static void sync_cmos_clock(unsigned long dummy);
-
-static struct timer_list sync_cmos_timer =
-                                      TIMER_INITIALIZER(sync_cmos_clock, 0, 0);
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
-	if ((time_status & STA_UNSYNC) != 0)
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
 
@@ -393,7 +266,6 @@
 
 static int timer_resume(struct sys_device *dev)
 {
-	unsigned long flags;
 	unsigned long sec;
 	unsigned long sleep_length;
 
@@ -403,10 +275,6 @@
 #endif
 	sec = get_cmos_time() + clock_cmos_diff;
 	sleep_length = (get_cmos_time() - sleep_start) * HZ;
-	write_seqlock_irqsave(&xtime_lock, flags);
-	xtime.tv_sec = sec;
-	xtime.tv_nsec = 0;
-	write_sequnlock_irqrestore(&xtime_lock, flags);
 	jiffies += sleep_length;
 	wall_jiffies += sleep_length;
 	touch_softlockup_watchdog();
@@ -441,17 +309,10 @@
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
@@ -469,13 +330,5 @@
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
diff -ruN linux-2.6.12-rc6-mm1/arch/i386/kernel/timers/common.c linux-2.6.12-rc6-mm1-tod/arch/i386/kernel/timers/common.c
--- linux-2.6.12-rc6-mm1/arch/i386/kernel/timers/common.c	2005-06-17 19:22:40.057520557 -0700
+++ linux-2.6.12-rc6-mm1-tod/arch/i386/kernel/timers/common.c	1969-12-31 16:00:00.000000000 -0800
@@ -1,90 +0,0 @@
-/*
- *	Common functions used across the timers go here
- */
-
-#include <linux/init.h>
-#include <linux/timex.h>
-#include <linux/errno.h>
-#include <linux/jiffies.h>
-#include <linux/module.h>
-
-#include <asm/io.h>
-#include <asm/timer.h>
-#include <asm/hpet.h>
-
-#include "mach_timer.h"
-
-#ifdef CONFIG_HPET_TIMER
-/* ------ Calibrate the TSC using HPET -------
- * Return 2^32 * (1 / (TSC clocks per usec)) for getting the CPU freq.
- * Second output is parameter 1 (when non NULL)
- * Set 2^32 * (1 / (tsc per HPET clk)) for delay_hpet().
- * calibrate_tsc() calibrates the processor TSC by comparing
- * it to the HPET timer of known frequency.
- * Too much 64-bit arithmetic here to do this cleanly in C
- */
-#define CALIBRATE_CNT_HPET 	(5 * hpet_tick)
-#define CALIBRATE_TIME_HPET 	(5 * KERNEL_TICK_USEC)
-
-unsigned long __init calibrate_tsc_hpet(unsigned long *tsc_hpet_quotient_ptr)
-{
-	unsigned long tsc_startlow, tsc_starthigh;
-	unsigned long tsc_endlow, tsc_endhigh;
-	unsigned long hpet_start, hpet_end;
-	unsigned long result, remain;
-
-	hpet_start = hpet_readl(HPET_COUNTER);
-	rdtsc(tsc_startlow, tsc_starthigh);
-	do {
-		hpet_end = hpet_readl(HPET_COUNTER);
-	} while ((hpet_end - hpet_start) < CALIBRATE_CNT_HPET);
-	rdtsc(tsc_endlow, tsc_endhigh);
-
-	/* 64-bit subtract - gcc just messes up with long longs */
-	__asm__("subl %2,%0\n\t"
-		"sbbl %3,%1"
-		:"=a" (tsc_endlow), "=d" (tsc_endhigh)
-		:"g" (tsc_startlow), "g" (tsc_starthigh),
-		 "0" (tsc_endlow), "1" (tsc_endhigh));
-
-	/* Error: ECPUTOOFAST */
-	if (tsc_endhigh)
-		goto bad_calibration;
-
-	/* Error: ECPUTOOSLOW */
-	if (tsc_endlow <= CALIBRATE_TIME_HPET)
-		goto bad_calibration;
-
-	ASM_DIV64_REG(result, remain, tsc_endlow, 0, CALIBRATE_TIME_HPET);
-	if (remain > (tsc_endlow >> 1))
-		result++; /* rounding the result */
-
-	if (tsc_hpet_quotient_ptr) {
-		unsigned long tsc_hpet_quotient;
-
-		ASM_DIV64_REG(tsc_hpet_quotient, remain, tsc_endlow, 0,
-			CALIBRATE_CNT_HPET);
-		if (remain > (tsc_endlow >> 1))
-			tsc_hpet_quotient++; /* rounding the result */
-		*tsc_hpet_quotient_ptr = tsc_hpet_quotient;
-	}
-
-	return result;
-bad_calibration:
-	/*
-	 * the CPU was so fast/slow that the quotient wouldn't fit in
-	 * 32 bits..
-	 */
-	return 0;
-}
-#endif
-
-
-unsigned long read_timer_tsc(void)
-{
-	unsigned long retval;
-	rdtscl(retval);
-	return retval;
-}
-
-
diff -ruN linux-2.6.12-rc6-mm1/arch/i386/kernel/timers/Makefile linux-2.6.12-rc6-mm1-tod/arch/i386/kernel/timers/Makefile
--- linux-2.6.12-rc6-mm1/arch/i386/kernel/timers/Makefile	2005-06-17 19:22:40.057520557 -0700
+++ linux-2.6.12-rc6-mm1-tod/arch/i386/kernel/timers/Makefile	1969-12-31 16:00:00.000000000 -0800
@@ -1,9 +0,0 @@
-#
-# Makefile for x86 timers
-#
-
-obj-y := timer.o timer_none.o timer_tsc.o timer_pit.o common.o
-
-obj-$(CONFIG_X86_CYCLONE_TIMER)	+= timer_cyclone.o
-obj-$(CONFIG_HPET_TIMER)	+= timer_hpet.o
-obj-$(CONFIG_X86_PM_TIMER)	+= timer_pm.o
diff -ruN linux-2.6.12-rc6-mm1/arch/i386/kernel/timers/timer.c linux-2.6.12-rc6-mm1-tod/arch/i386/kernel/timers/timer.c
--- linux-2.6.12-rc6-mm1/arch/i386/kernel/timers/timer.c	2005-06-17 19:22:40.057520557 -0700
+++ linux-2.6.12-rc6-mm1-tod/arch/i386/kernel/timers/timer.c	1969-12-31 16:00:00.000000000 -0800
@@ -1,66 +0,0 @@
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <asm/timer.h>
-
-#ifdef CONFIG_HPET_TIMER
-/*
- * HPET memory read is slower than tsc reads, but is more dependable as it
- * always runs at constant frequency and reduces complexity due to
- * cpufreq. So, we prefer HPET timer to tsc based one. Also, we cannot use
- * timer_pit when HPET is active. So, we default to timer_tsc.
- */
-#endif
-/* list of timers, ordered by preference, NULL terminated */
-static struct init_timer_opts* __initdata timers[] = {
-#ifdef CONFIG_X86_CYCLONE_TIMER
-	&timer_cyclone_init,
-#endif
-#ifdef CONFIG_HPET_TIMER
-	&timer_hpet_init,
-#endif
-#ifdef CONFIG_X86_PM_TIMER
-	&timer_pmtmr_init,
-#endif
-	&timer_tsc_init,
-	&timer_pit_init,
-	NULL,
-};
-
-static char clock_override[10] __initdata;
-
-static int __init clock_setup(char* str)
-{
-	if (str)
-		strlcpy(clock_override, str, sizeof(clock_override));
-	return 1;
-}
-__setup("clock=", clock_setup);
-
-
-/* The chosen timesource has been found to be bad.
- * Fall back to a known good timesource (the PIT)
- */
-void clock_fallback(void)
-{
-	cur_timer = &timer_pit;
-}
-
-/* iterates through the list of timers, returning the first 
- * one that initializes successfully.
- */
-struct timer_opts* __init select_timer(void)
-{
-	int i = 0;
-	
-	/* find most preferred working timer */
-	while (timers[i]) {
-		if (timers[i]->init)
-			if (timers[i]->init(clock_override) == 0)
-				return timers[i]->opts;
-		++i;
-	}
-		
-	panic("select_timer: Cannot find a suitable timer\n");
-	return NULL;
-}
diff -ruN linux-2.6.12-rc6-mm1/arch/i386/kernel/timers/timer_cyclone.c linux-2.6.12-rc6-mm1-tod/arch/i386/kernel/timers/timer_cyclone.c
--- linux-2.6.12-rc6-mm1/arch/i386/kernel/timers/timer_cyclone.c	2005-06-17 19:22:40.058520433 -0700
+++ linux-2.6.12-rc6-mm1-tod/arch/i386/kernel/timers/timer_cyclone.c	1969-12-31 16:00:00.000000000 -0800
@@ -1,259 +0,0 @@
-/*	Cyclone-timer: 
- *		This code implements timer_ops for the cyclone counter found
- *		on IBM x440, x360, and other Summit based systems.
- *
- *	Copyright (C) 2002 IBM, John Stultz (johnstul@us.ibm.com)
- */
-
-
-#include <linux/spinlock.h>
-#include <linux/init.h>
-#include <linux/timex.h>
-#include <linux/errno.h>
-#include <linux/string.h>
-#include <linux/jiffies.h>
-
-#include <asm/timer.h>
-#include <asm/io.h>
-#include <asm/pgtable.h>
-#include <asm/fixmap.h>
-#include "io_ports.h"
-
-extern spinlock_t i8253_lock;
-
-/* Number of usecs that the last interrupt was delayed */
-static int delay_at_last_interrupt;
-
-#define CYCLONE_CBAR_ADDR 0xFEB00CD0
-#define CYCLONE_PMCC_OFFSET 0x51A0
-#define CYCLONE_MPMC_OFFSET 0x51D0
-#define CYCLONE_MPCS_OFFSET 0x51A8
-#define CYCLONE_TIMER_FREQ 100000000
-#define CYCLONE_TIMER_MASK (((u64)1<<40)-1) /* 40 bit mask */
-int use_cyclone = 0;
-
-static u32* volatile cyclone_timer;	/* Cyclone MPMC0 register */
-static u32 last_cyclone_low;
-static u32 last_cyclone_high;
-static unsigned long long monotonic_base;
-static seqlock_t monotonic_lock = SEQLOCK_UNLOCKED;
-
-/* helper macro to atomically read both cyclone counter registers */
-#define read_cyclone_counter(low,high) \
-	do{ \
-		high = cyclone_timer[1]; low = cyclone_timer[0]; \
-	} while (high != cyclone_timer[1]);
-
-
-static void mark_offset_cyclone(void)
-{
-	unsigned long lost, delay;
-	unsigned long delta = last_cyclone_low;
-	int count;
-	unsigned long long this_offset, last_offset;
-
-	write_seqlock(&monotonic_lock);
-	last_offset = ((unsigned long long)last_cyclone_high<<32)|last_cyclone_low;
-	
-	spin_lock(&i8253_lock);
-	read_cyclone_counter(last_cyclone_low,last_cyclone_high);
-
-	/* read values for delay_at_last_interrupt */
-	outb_p(0x00, 0x43);     /* latch the count ASAP */
-
-	count = inb_p(0x40);    /* read the latched count */
-	count |= inb(0x40) << 8;
-
-	/*
-	 * VIA686a test code... reset the latch if count > max + 1
-	 * from timer_pit.c - cjb
-	 */
-	if (count > LATCH) {
-		outb_p(0x34, PIT_MODE);
-		outb_p(LATCH & 0xff, PIT_CH0);
-		outb(LATCH >> 8, PIT_CH0);
-		count = LATCH - 1;
-	}
-	spin_unlock(&i8253_lock);
-
-	/* lost tick compensation */
-	delta = last_cyclone_low - delta;	
-	delta /= (CYCLONE_TIMER_FREQ/1000000);
-	delta += delay_at_last_interrupt;
-	lost = delta/(1000000/HZ);
-	delay = delta%(1000000/HZ);
-	if (lost >= 2)
-		jiffies_64 += lost-1;
-	
-	/* update the monotonic base value */
-	this_offset = ((unsigned long long)last_cyclone_high<<32)|last_cyclone_low;
-	monotonic_base += (this_offset - last_offset) & CYCLONE_TIMER_MASK;
-	write_sequnlock(&monotonic_lock);
-
-	/* calculate delay_at_last_interrupt */
-	count = ((LATCH-1) - count) * TICK_SIZE;
-	delay_at_last_interrupt = (count + LATCH/2) / LATCH;
-
-
-	/* catch corner case where tick rollover occured 
-	 * between cyclone and pit reads (as noted when 
-	 * usec delta is > 90% # of usecs/tick)
-	 */
-	if (lost && abs(delay - delay_at_last_interrupt) > (900000/HZ))
-		jiffies_64++;
-}
-
-static unsigned long get_offset_cyclone(void)
-{
-	u32 offset;
-
-	if(!cyclone_timer)
-		return delay_at_last_interrupt;
-
-	/* Read the cyclone timer */
-	offset = cyclone_timer[0];
-
-	/* .. relative to previous jiffy */
-	offset = offset - last_cyclone_low;
-
-	/* convert cyclone ticks to microseconds */	
-	/* XXX slow, can we speed this up? */
-	offset = offset/(CYCLONE_TIMER_FREQ/1000000);
-
-	/* our adjusted time offset in microseconds */
-	return delay_at_last_interrupt + offset;
-}
-
-static unsigned long long monotonic_clock_cyclone(void)
-{
-	u32 now_low, now_high;
-	unsigned long long last_offset, this_offset, base;
-	unsigned long long ret;
-	unsigned seq;
-
-	/* atomically read monotonic base & last_offset */
-	do {
-		seq = read_seqbegin(&monotonic_lock);
-		last_offset = ((unsigned long long)last_cyclone_high<<32)|last_cyclone_low;
-		base = monotonic_base;
-	} while (read_seqretry(&monotonic_lock, seq));
-
-
-	/* Read the cyclone counter */
-	read_cyclone_counter(now_low,now_high);
-	this_offset = ((unsigned long long)now_high<<32)|now_low;
-
-	/* convert to nanoseconds */
-	ret = base + ((this_offset - last_offset)&CYCLONE_TIMER_MASK);
-	return ret * (1000000000 / CYCLONE_TIMER_FREQ);
-}
-
-static int __init init_cyclone(char* override)
-{
-	u32* reg;	
-	u32 base;		/* saved cyclone base address */
-	u32 pageaddr;	/* page that contains cyclone_timer register */
-	u32 offset;		/* offset from pageaddr to cyclone_timer register */
-	int i;
-	
-	/* check clock override */
-	if (override[0] && strncmp(override,"cyclone",7))
-			return -ENODEV;
-
-	/*make sure we're on a summit box*/
-	if(!use_cyclone) return -ENODEV; 
-	
-	printk(KERN_INFO "Summit chipset: Starting Cyclone Counter.\n");
-
-	/* find base address */
-	pageaddr = (CYCLONE_CBAR_ADDR)&PAGE_MASK;
-	offset = (CYCLONE_CBAR_ADDR)&(~PAGE_MASK);
-	set_fixmap_nocache(FIX_CYCLONE_TIMER, pageaddr);
-	reg = (u32*)(fix_to_virt(FIX_CYCLONE_TIMER) + offset);
-	if(!reg){
-		printk(KERN_ERR "Summit chipset: Could not find valid CBAR register.\n");
-		return -ENODEV;
-	}
-	base = *reg;	
-	if(!base){
-		printk(KERN_ERR "Summit chipset: Could not find valid CBAR value.\n");
-		return -ENODEV;
-	}
-	
-	/* setup PMCC */
-	pageaddr = (base + CYCLONE_PMCC_OFFSET)&PAGE_MASK;
-	offset = (base + CYCLONE_PMCC_OFFSET)&(~PAGE_MASK);
-	set_fixmap_nocache(FIX_CYCLONE_TIMER, pageaddr);
-	reg = (u32*)(fix_to_virt(FIX_CYCLONE_TIMER) + offset);
-	if(!reg){
-		printk(KERN_ERR "Summit chipset: Could not find valid PMCC register.\n");
-		return -ENODEV;
-	}
-	reg[0] = 0x00000001;
-
-	/* setup MPCS */
-	pageaddr = (base + CYCLONE_MPCS_OFFSET)&PAGE_MASK;
-	offset = (base + CYCLONE_MPCS_OFFSET)&(~PAGE_MASK);
-	set_fixmap_nocache(FIX_CYCLONE_TIMER, pageaddr);
-	reg = (u32*)(fix_to_virt(FIX_CYCLONE_TIMER) + offset);
-	if(!reg){
-		printk(KERN_ERR "Summit chipset: Could not find valid MPCS register.\n");
-		return -ENODEV;
-	}
-	reg[0] = 0x00000001;
-
-	/* map in cyclone_timer */
-	pageaddr = (base + CYCLONE_MPMC_OFFSET)&PAGE_MASK;
-	offset = (base + CYCLONE_MPMC_OFFSET)&(~PAGE_MASK);
-	set_fixmap_nocache(FIX_CYCLONE_TIMER, pageaddr);
-	cyclone_timer = (u32*)(fix_to_virt(FIX_CYCLONE_TIMER) + offset);
-	if(!cyclone_timer){
-		printk(KERN_ERR "Summit chipset: Could not find valid MPMC register.\n");
-		return -ENODEV;
-	}
-
-	/*quick test to make sure its ticking*/
-	for(i=0; i<3; i++){
-		u32 old = cyclone_timer[0];
-		int stall = 100;
-		while(stall--) barrier();
-		if(cyclone_timer[0] == old){
-			printk(KERN_ERR "Summit chipset: Counter not counting! DISABLED\n");
-			cyclone_timer = 0;
-			return -ENODEV;
-		}
-	}
-
-	init_cpu_khz();
-
-	/* Everything looks good! */
-	return 0;
-}
-
-
-static void delay_cyclone(unsigned long loops)
-{
-	unsigned long bclock, now;
-	if(!cyclone_timer)
-		return;
-	bclock = cyclone_timer[0];
-	do {
-		rep_nop();
-		now = cyclone_timer[0];
-	} while ((now-bclock) < loops);
-}
-/************************************************************/
-
-/* cyclone timer_opts struct */
-static struct timer_opts timer_cyclone = {
-	.name = "cyclone",
-	.mark_offset = mark_offset_cyclone, 
-	.get_offset = get_offset_cyclone,
-	.monotonic_clock =	monotonic_clock_cyclone,
-	.delay = delay_cyclone,
-};
-
-struct init_timer_opts __initdata timer_cyclone_init = {
-	.init = init_cyclone,
-	.opts = &timer_cyclone,
-};
diff -ruN linux-2.6.12-rc6-mm1/arch/i386/kernel/timers/timer_hpet.c linux-2.6.12-rc6-mm1-tod/arch/i386/kernel/timers/timer_hpet.c
--- linux-2.6.12-rc6-mm1/arch/i386/kernel/timers/timer_hpet.c	2005-06-17 19:22:40.059520309 -0700
+++ linux-2.6.12-rc6-mm1-tod/arch/i386/kernel/timers/timer_hpet.c	1969-12-31 16:00:00.000000000 -0800
@@ -1,195 +0,0 @@
-/*
- * This code largely moved from arch/i386/kernel/time.c.
- * See comments there for proper credits.
- */
-
-#include <linux/spinlock.h>
-#include <linux/init.h>
-#include <linux/timex.h>
-#include <linux/errno.h>
-#include <linux/string.h>
-#include <linux/jiffies.h>
-
-#include <asm/timer.h>
-#include <asm/io.h>
-#include <asm/processor.h>
-
-#include "io_ports.h"
-#include "mach_timer.h"
-#include <asm/hpet.h>
-
-static unsigned long hpet_usec_quotient;	/* convert hpet clks to usec */
-static unsigned long tsc_hpet_quotient;		/* convert tsc to hpet clks */
-static unsigned long hpet_last; 	/* hpet counter value at last tick*/
-static unsigned long last_tsc_low;	/* lsb 32 bits of Time Stamp Counter */
-static unsigned long last_tsc_high; 	/* msb 32 bits of Time Stamp Counter */
-static unsigned long long monotonic_base;
-static seqlock_t monotonic_lock = SEQLOCK_UNLOCKED;
-
-/* convert from cycles(64bits) => nanoseconds (64bits)
- *  basic equation:
- *		ns = cycles / (freq / ns_per_sec)
- *		ns = cycles * (ns_per_sec / freq)
- *		ns = cycles * (10^9 / (cpu_mhz * 10^6))
- *		ns = cycles * (10^3 / cpu_mhz)
- *
- *	Then we use scaling math (suggested by george@mvista.com) to get:
- *		ns = cycles * (10^3 * SC / cpu_mhz) / SC
- *		ns = cycles * cyc2ns_scale / SC
- *
- *	And since SC is a constant power of two, we can convert the div
- *  into a shift.
- *			-johnstul@us.ibm.com "math is hard, lets go shopping!"
- */
-static unsigned long cyc2ns_scale;
-#define CYC2NS_SCALE_FACTOR 10 /* 2^10, carefully chosen */
-
-static inline void set_cyc2ns_scale(unsigned long cpu_mhz)
-{
-	cyc2ns_scale = (1000 << CYC2NS_SCALE_FACTOR)/cpu_mhz;
-}
-
-static inline unsigned long long cycles_2_ns(unsigned long long cyc)
-{
-	return (cyc * cyc2ns_scale) >> CYC2NS_SCALE_FACTOR;
-}
-
-static unsigned long long monotonic_clock_hpet(void)
-{
-	unsigned long long last_offset, this_offset, base;
-	unsigned seq;
-
-	/* atomically read monotonic base & last_offset */
-	do {
-		seq = read_seqbegin(&monotonic_lock);
-		last_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
-		base = monotonic_base;
-	} while (read_seqretry(&monotonic_lock, seq));
-
-	/* Read the Time Stamp Counter */
-	rdtscll(this_offset);
-
-	/* return the value in ns */
-	return base + cycles_2_ns(this_offset - last_offset);
-}
-
-static unsigned long get_offset_hpet(void)
-{
-	register unsigned long eax, edx;
-
-	eax = hpet_readl(HPET_COUNTER);
-	eax -= hpet_last;	/* hpet delta */
-	eax = min(hpet_tick, eax);
-	/*
-         * Time offset = (hpet delta) * ( usecs per HPET clock )
-	 *             = (hpet delta) * ( usecs per tick / HPET clocks per tick)
-	 *             = (hpet delta) * ( hpet_usec_quotient ) / (2^32)
-	 *
-	 * Where,
-	 * hpet_usec_quotient = (2^32 * usecs per tick)/HPET clocks per tick
-	 *
-	 * Using a mull instead of a divl saves some cycles in critical path.
-         */
-	ASM_MUL64_REG(eax, edx, hpet_usec_quotient, eax);
-
-	/* our adjusted time offset in microseconds */
-	return edx;
-}
-
-static void mark_offset_hpet(void)
-{
-	unsigned long long this_offset, last_offset;
-	unsigned long offset;
-
-	write_seqlock(&monotonic_lock);
-	last_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
-	rdtsc(last_tsc_low, last_tsc_high);
-
-	if (hpet_use_timer)
-		offset = hpet_readl(HPET_T0_CMP) - hpet_tick;
-	else
-		offset = hpet_readl(HPET_COUNTER);
-	if (unlikely(((offset - hpet_last) >= (2*hpet_tick)) && (hpet_last != 0))) {
-		int lost_ticks = ((offset - hpet_last) / hpet_tick) - 1;
-		jiffies_64 += lost_ticks;
-	}
-	hpet_last = offset;
-
-	/* update the monotonic base value */
-	this_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
-	monotonic_base += cycles_2_ns(this_offset - last_offset);
-	write_sequnlock(&monotonic_lock);
-}
-
-static void delay_hpet(unsigned long loops)
-{
-	unsigned long hpet_start, hpet_end;
-	unsigned long eax;
-
-	/* loops is the number of cpu cycles. Convert it to hpet clocks */
-	ASM_MUL64_REG(eax, loops, tsc_hpet_quotient, loops);
-
-	hpet_start = hpet_readl(HPET_COUNTER);
-	do {
-		rep_nop();
-		hpet_end = hpet_readl(HPET_COUNTER);
-	} while ((hpet_end - hpet_start) < (loops));
-}
-
-static int __init init_hpet(char* override)
-{
-	unsigned long result, remain;
-
-	/* check clock override */
-	if (override[0] && strncmp(override,"hpet",4))
-		return -ENODEV;
-
-	if (!is_hpet_enabled())
-		return -ENODEV;
-
-	printk("Using HPET for gettimeofday\n");
-	if (cpu_has_tsc) {
-		unsigned long tsc_quotient = calibrate_tsc_hpet(&tsc_hpet_quotient);
-		if (tsc_quotient) {
-			/* report CPU clock rate in Hz.
-			 * The formula is (10^6 * 2^32) / (2^32 * 1 / (clocks/us)) =
-			 * clock/second. Our precision is about 100 ppm.
-			 */
-			{	unsigned long eax=0, edx=1000;
-				ASM_DIV64_REG(cpu_khz, edx, tsc_quotient,
-						eax, edx);
-				printk("Detected %lu.%03lu MHz processor.\n",
-					cpu_khz / 1000, cpu_khz % 1000);
-			}
-			set_cyc2ns_scale(cpu_khz/1000);
-		}
-	}
-
-	/*
-	 * Math to calculate hpet to usec multiplier
-	 * Look for the comments at get_offset_hpet()
-	 */
-	ASM_DIV64_REG(result, remain, hpet_tick, 0, KERNEL_TICK_USEC);
-	if (remain > (hpet_tick >> 1))
-		result++; /* rounding the result */
-	hpet_usec_quotient = result;
-
-	return 0;
-}
-
-/************************************************************/
-
-/* tsc timer_opts struct */
-static struct timer_opts timer_hpet = {
-	.name = 		"hpet",
-	.mark_offset =		mark_offset_hpet,
-	.get_offset =		get_offset_hpet,
-	.monotonic_clock =	monotonic_clock_hpet,
-	.delay = 		delay_hpet,
-	.read_timer = 		read_timer_tsc,
-};
-
-struct init_timer_opts __initdata timer_hpet_init = {
-	.init =	init_hpet,
-	.opts = &timer_hpet,
-};
diff -ruN linux-2.6.12-rc6-mm1/arch/i386/kernel/timers/timer_none.c linux-2.6.12-rc6-mm1-tod/arch/i386/kernel/timers/timer_none.c
--- linux-2.6.12-rc6-mm1/arch/i386/kernel/timers/timer_none.c	2005-06-17 19:22:40.059520309 -0700
+++ linux-2.6.12-rc6-mm1-tod/arch/i386/kernel/timers/timer_none.c	1969-12-31 16:00:00.000000000 -0800
@@ -1,39 +0,0 @@
-#include <linux/init.h>
-#include <asm/timer.h>
-
-static void mark_offset_none(void)
-{
-	/* nothing needed */
-}
-
-static unsigned long get_offset_none(void)
-{
-	return 0;
-}
-
-static unsigned long long monotonic_clock_none(void)
-{
-	return 0;
-}
-
-static void delay_none(unsigned long loops)
-{
-	int d0;
-	__asm__ __volatile__(
-		"\tjmp 1f\n"
-		".align 16\n"
-		"1:\tjmp 2f\n"
-		".align 16\n"
-		"2:\tdecl %0\n\tjns 2b"
-		:"=&a" (d0)
-		:"0" (loops));
-}
-
-/* none timer_opts struct */
-struct timer_opts timer_none = {
-	.name = 	"none",
-	.mark_offset =	mark_offset_none, 
-	.get_offset =	get_offset_none,
-	.monotonic_clock =	monotonic_clock_none,
-	.delay = delay_none,
-};
diff -ruN linux-2.6.12-rc6-mm1/arch/i386/kernel/timers/timer_pit.c linux-2.6.12-rc6-mm1-tod/arch/i386/kernel/timers/timer_pit.c
--- linux-2.6.12-rc6-mm1/arch/i386/kernel/timers/timer_pit.c	2005-06-17 19:22:40.060520184 -0700
+++ linux-2.6.12-rc6-mm1-tod/arch/i386/kernel/timers/timer_pit.c	1969-12-31 16:00:00.000000000 -0800
@@ -1,165 +0,0 @@
-/*
- * This code largely moved from arch/i386/kernel/time.c.
- * See comments there for proper credits.
- */
-
-#include <linux/spinlock.h>
-#include <linux/module.h>
-#include <linux/device.h>
-#include <linux/irq.h>
-#include <linux/sysdev.h>
-#include <linux/timex.h>
-#include <asm/delay.h>
-#include <asm/mpspec.h>
-#include <asm/timer.h>
-#include <asm/smp.h>
-#include <asm/io.h>
-#include <asm/arch_hooks.h>
-
-extern spinlock_t i8259A_lock;
-extern spinlock_t i8253_lock;
-#include "do_timer.h"
-#include "io_ports.h"
-
-static int count_p; /* counter in get_offset_pit() */
-
-static int __init init_pit(char* override)
-{
- 	/* check clock override */
- 	if (override[0] && strncmp(override,"pit",3))
- 		printk(KERN_ERR "Warning: clock= override failed. Defaulting to PIT\n");
- 
-	count_p = LATCH;
-	return 0;
-}
-
-static void mark_offset_pit(void)
-{
-	/* nothing needed */
-}
-
-static unsigned long long monotonic_clock_pit(void)
-{
-	return 0;
-}
-
-static void delay_pit(unsigned long loops)
-{
-	int d0;
-	__asm__ __volatile__(
-		"\tjmp 1f\n"
-		".align 16\n"
-		"1:\tjmp 2f\n"
-		".align 16\n"
-		"2:\tdecl %0\n\tjns 2b"
-		:"=&a" (d0)
-		:"0" (loops));
-}
-
-
-/* This function must be called with xtime_lock held.
- * It was inspired by Steve McCanne's microtime-i386 for BSD.  -- jrs
- * 
- * However, the pc-audio speaker driver changes the divisor so that
- * it gets interrupted rather more often - it loads 64 into the
- * counter rather than 11932! This has an adverse impact on
- * do_gettimeoffset() -- it stops working! What is also not
- * good is that the interval that our timer function gets called
- * is no longer 10.0002 ms, but 9.9767 ms. To get around this
- * would require using a different timing source. Maybe someone
- * could use the RTC - I know that this can interrupt at frequencies
- * ranging from 8192Hz to 2Hz. If I had the energy, I'd somehow fix
- * it so that at startup, the timer code in sched.c would select
- * using either the RTC or the 8253 timer. The decision would be
- * based on whether there was any other device around that needed
- * to trample on the 8253. I'd set up the RTC to interrupt at 1024 Hz,
- * and then do some jiggery to have a version of do_timer that 
- * advanced the clock by 1/1024 s. Every time that reached over 1/100
- * of a second, then do all the old code. If the time was kept correct
- * then do_gettimeoffset could just return 0 - there is no low order
- * divider that can be accessed.
- *
- * Ideally, you would be able to use the RTC for the speaker driver,
- * but it appears that the speaker driver really needs interrupt more
- * often than every 120 us or so.
- *
- * Anyway, this needs more thought....		pjsg (1993-08-28)
- * 
- * If you are really that interested, you should be reading
- * comp.protocols.time.ntp!
- */
-
-static unsigned long get_offset_pit(void)
-{
-	int count;
-	unsigned long flags;
-	static unsigned long jiffies_p = 0;
-
-	/*
-	 * cache volatile jiffies temporarily; we have xtime_lock. 
-	 */
-	unsigned long jiffies_t;
-
-	spin_lock_irqsave(&i8253_lock, flags);
-	/* timer count may underflow right here */
-	outb_p(0x00, PIT_MODE);	/* latch the count ASAP */
-
-	count = inb_p(PIT_CH0);	/* read the latched count */
-
-	/*
-	 * We do this guaranteed double memory access instead of a _p 
-	 * postfix in the previous port access. Wheee, hackady hack
-	 */
- 	jiffies_t = jiffies;
-
-	count |= inb_p(PIT_CH0) << 8;
-	
-        /* VIA686a test code... reset the latch if count > max + 1 */
-        if (count > LATCH) {
-                outb_p(0x34, PIT_MODE);
-                outb_p(LATCH & 0xff, PIT_CH0);
-                outb(LATCH >> 8, PIT_CH0);
-                count = LATCH - 1;
-        }
-	
-	/*
-	 * avoiding timer inconsistencies (they are rare, but they happen)...
-	 * there are two kinds of problems that must be avoided here:
-	 *  1. the timer counter underflows
-	 *  2. hardware problem with the timer, not giving us continuous time,
-	 *     the counter does small "jumps" upwards on some Pentium systems,
-	 *     (see c't 95/10 page 335 for Neptun bug.)
-	 */
-
-	if( jiffies_t == jiffies_p ) {
-		if( count > count_p ) {
-			/* the nutcase */
-			count = do_timer_overflow(count);
-		}
-	} else
-		jiffies_p = jiffies_t;
-
-	count_p = count;
-
-	spin_unlock_irqrestore(&i8253_lock, flags);
-
-	count = ((LATCH-1) - count) * TICK_SIZE;
-	count = (count + LATCH/2) / LATCH;
-
-	return count;
-}
-
-
-/* tsc timer_opts struct */
-struct timer_opts timer_pit = {
-	.name = "pit",
-	.mark_offset = mark_offset_pit, 
-	.get_offset = get_offset_pit,
-	.monotonic_clock = monotonic_clock_pit,
-	.delay = delay_pit,
-};
-
-struct init_timer_opts __initdata timer_pit_init = {
-	.init = init_pit, 
-	.opts = &timer_pit,
-};
diff -ruN linux-2.6.12-rc6-mm1/arch/i386/kernel/timers/timer_pm.c linux-2.6.12-rc6-mm1-tod/arch/i386/kernel/timers/timer_pm.c
--- linux-2.6.12-rc6-mm1/arch/i386/kernel/timers/timer_pm.c	2005-06-17 19:22:40.060520184 -0700
+++ linux-2.6.12-rc6-mm1-tod/arch/i386/kernel/timers/timer_pm.c	1969-12-31 16:00:00.000000000 -0800
@@ -1,259 +0,0 @@
-/*
- * (C) Dominik Brodowski <linux@brodo.de> 2003
- *
- * Driver to use the Power Management Timer (PMTMR) available in some
- * southbridges as primary timing source for the Linux kernel.
- *
- * Based on parts of linux/drivers/acpi/hardware/hwtimer.c, timer_pit.c,
- * timer_hpet.c, and on Arjan van de Ven's implementation for 2.4.
- *
- * This file is licensed under the GPL v2.
- */
-
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/device.h>
-#include <linux/init.h>
-#include <asm/types.h>
-#include <asm/timer.h>
-#include <asm/smp.h>
-#include <asm/io.h>
-#include <asm/arch_hooks.h>
-
-#include <linux/timex.h>
-#include "mach_timer.h"
-
-/* Number of PMTMR ticks expected during calibration run */
-#define PMTMR_TICKS_PER_SEC 3579545
-#define PMTMR_EXPECTED_RATE \
-  ((CALIBRATE_LATCH * (PMTMR_TICKS_PER_SEC >> 10)) / (CLOCK_TICK_RATE>>10))
-
-
-/* The I/O port the PMTMR resides at.
- * The location is detected during setup_arch(),
- * in arch/i386/acpi/boot.c */
-u32 pmtmr_ioport = 0;
-
-
-/* value of the Power timer at last timer interrupt */
-static u32 offset_tick;
-static u32 offset_delay;
-
-static unsigned long long monotonic_base;
-static seqlock_t monotonic_lock = SEQLOCK_UNLOCKED;
-
-#define ACPI_PM_MASK 0xFFFFFF /* limit it to 24 bits */
-
-/*helper function to safely read acpi pm timesource*/
-static inline u32 read_pmtmr(void)
-{
-	u32 v1=0,v2=0,v3=0;
-	/* It has been reported that because of various broken
-	 * chipsets (ICH4, PIIX4 and PIIX4E) where the ACPI PM time
-	 * source is not latched, so you must read it multiple
-	 * times to insure a safe value is read.
-	 */
-	do {
-		v1 = inl(pmtmr_ioport);
-		v2 = inl(pmtmr_ioport);
-		v3 = inl(pmtmr_ioport);
-	} while ((v1 > v2 && v1 < v3) || (v2 > v3 && v2 < v1)
-			|| (v3 > v1 && v3 < v2));
-
-	/* mask the output to 24 bits */
-	return v2 & ACPI_PM_MASK;
-}
-
-
-/*
- * Some boards have the PMTMR running way too fast. We check
- * the PMTMR rate against PIT channel 2 to catch these cases.
- */
-static int verify_pmtmr_rate(void)
-{
-	u32 value1, value2;
-	unsigned long count, delta;
-
-	mach_prepare_counter();
-	value1 = read_pmtmr();
-	mach_countup(&count);
-	value2 = read_pmtmr();
-	delta = (value2 - value1) & ACPI_PM_MASK;
-
-	/* Check that the PMTMR delta is within 5% of what we expect */
-	if (delta < (PMTMR_EXPECTED_RATE * 19) / 20 ||
-	    delta > (PMTMR_EXPECTED_RATE * 21) / 20) {
-		printk(KERN_INFO "PM-Timer running at invalid rate: %lu%% of normal - aborting.\n", 100UL * delta / PMTMR_EXPECTED_RATE);
-		return -1;
-	}
-
-	return 0;
-}
-
-
-static int init_pmtmr(char* override)
-{
-	u32 value1, value2;
-	unsigned int i;
-
- 	if (override[0] && strncmp(override,"pmtmr",5))
-		return -ENODEV;
-
-	if (!pmtmr_ioport)
-		return -ENODEV;
-
-	/* we use the TSC for delay_pmtmr, so make sure it exists */
-	if (!cpu_has_tsc)
-		return -ENODEV;
-
-	/* "verify" this timing source */
-	value1 = read_pmtmr();
-	for (i = 0; i < 10000; i++) {
-		value2 = read_pmtmr();
-		if (value2 == value1)
-			continue;
-		if (value2 > value1)
-			goto pm_good;
-		if ((value2 < value1) && ((value2) < 0xFFF))
-			goto pm_good;
-		printk(KERN_INFO "PM-Timer had inconsistent results: 0x%#x, 0x%#x - aborting.\n", value1, value2);
-		return -EINVAL;
-	}
-	printk(KERN_INFO "PM-Timer had no reasonable result: 0x%#x - aborting.\n", value1);
-	return -ENODEV;
-
-pm_good:
-	if (verify_pmtmr_rate() != 0)
-		return -ENODEV;
-
-	init_cpu_khz();
-	return 0;
-}
-
-static inline u32 cyc2us(u32 cycles)
-{
-	/* The Power Management Timer ticks at 3.579545 ticks per microsecond.
-	 * 1 / PM_TIMER_FREQUENCY == 0.27936511 =~ 286/1024 [error: 0.024%]
-	 *
-	 * Even with HZ = 100, delta is at maximum 35796 ticks, so it can
-	 * easily be multiplied with 286 (=0x11E) without having to fear
-	 * u32 overflows.
-	 */
-	cycles *= 286;
-	return (cycles >> 10);
-}
-
-/*
- * this gets called during each timer interrupt
- *   - Called while holding the writer xtime_lock
- */
-static void mark_offset_pmtmr(void)
-{
-	u32 lost, delta, last_offset;
-	static int first_run = 1;
-	last_offset = offset_tick;
-
-	write_seqlock(&monotonic_lock);
-
-	offset_tick = read_pmtmr();
-
-	/* calculate tick interval */
-	delta = (offset_tick - last_offset) & ACPI_PM_MASK;
-
-	/* convert to usecs */
-	delta = cyc2us(delta);
-
-	/* update the monotonic base value */
-	monotonic_base += delta * NSEC_PER_USEC;
-	write_sequnlock(&monotonic_lock);
-
-	/* convert to ticks */
-	delta += offset_delay;
-	lost = delta / (USEC_PER_SEC / HZ);
-	offset_delay = delta % (USEC_PER_SEC / HZ);
-
-
-	/* compensate for lost ticks */
-	if (lost >= 2)
-		jiffies_64 += lost - 1;
-
-	/* don't calculate delay for first run,
-	   or if we've got less then a tick */
-	if (first_run || (lost < 1)) {
-		first_run = 0;
-		offset_delay = 0;
-	}
-}
-
-
-static unsigned long long monotonic_clock_pmtmr(void)
-{
-	u32 last_offset, this_offset;
-	unsigned long long base, ret;
-	unsigned seq;
-
-
-	/* atomically read monotonic base & last_offset */
-	do {
-		seq = read_seqbegin(&monotonic_lock);
-		last_offset = offset_tick;
-		base = monotonic_base;
-	} while (read_seqretry(&monotonic_lock, seq));
-
-	/* Read the pmtmr */
-	this_offset =  read_pmtmr();
-
-	/* convert to nanoseconds */
-	ret = (this_offset - last_offset) & ACPI_PM_MASK;
-	ret = base + (cyc2us(ret) * NSEC_PER_USEC);
-	return ret;
-}
-
-static void delay_pmtmr(unsigned long loops)
-{
-	unsigned long bclock, now;
-
-	rdtscl(bclock);
-	do
-	{
-		rep_nop();
-		rdtscl(now);
-	} while ((now-bclock) < loops);
-}
-
-
-/*
- * get the offset (in microseconds) from the last call to mark_offset()
- *	- Called holding a reader xtime_lock
- */
-static unsigned long get_offset_pmtmr(void)
-{
-	u32 now, offset, delta = 0;
-
-	offset = offset_tick;
-	now = read_pmtmr();
-	delta = (now - offset)&ACPI_PM_MASK;
-
-	return (unsigned long) offset_delay + cyc2us(delta);
-}
-
-
-/* acpi timer_opts struct */
-static struct timer_opts timer_pmtmr = {
-	.name			= "pmtmr",
-	.mark_offset		= mark_offset_pmtmr,
-	.get_offset		= get_offset_pmtmr,
-	.monotonic_clock 	= monotonic_clock_pmtmr,
-	.delay 			= delay_pmtmr,
-	.read_timer 		= read_timer_tsc,
-};
-
-struct init_timer_opts __initdata timer_pmtmr_init = {
-	.init = init_pmtmr,
-	.opts = &timer_pmtmr,
-};
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Dominik Brodowski <linux@brodo.de>");
-MODULE_DESCRIPTION("Power Management Timer (PMTMR) as primary timing source for x86");
diff -ruN linux-2.6.12-rc6-mm1/arch/i386/kernel/timers/timer_tsc.c linux-2.6.12-rc6-mm1-tod/arch/i386/kernel/timers/timer_tsc.c
--- linux-2.6.12-rc6-mm1/arch/i386/kernel/timers/timer_tsc.c	2005-06-17 19:22:40.061520060 -0700
+++ linux-2.6.12-rc6-mm1-tod/arch/i386/kernel/timers/timer_tsc.c	1969-12-31 16:00:00.000000000 -0800
@@ -1,386 +0,0 @@
-/*
- * This code largely moved from arch/i386/kernel/time.c.
- * See comments there for proper credits.
- *
- * 2004-06-25    Jesper Juhl
- *      moved mark_offset_tsc below cpufreq_delayed_get to avoid gcc 3.4
- *      failing to inline.
- */
-
-#include <linux/spinlock.h>
-#include <linux/init.h>
-#include <linux/timex.h>
-#include <linux/errno.h>
-#include <linux/cpufreq.h>
-#include <linux/string.h>
-#include <linux/jiffies.h>
-
-#include <asm/timer.h>
-#include <asm/io.h>
-/* processor.h for distable_tsc flag */
-#include <asm/processor.h>
-
-#include "io_ports.h"
-#include "mach_timer.h"
-
-#include <asm/hpet.h>
-
-#ifdef CONFIG_HPET_TIMER
-static unsigned long hpet_usec_quotient;
-static unsigned long hpet_last;
-static struct timer_opts timer_tsc;
-#endif
-
-extern spinlock_t i8253_lock;
-
-static int use_tsc;
-/* Number of usecs that the last interrupt was delayed */
-static int delay_at_last_interrupt;
-
-static unsigned long last_tsc_low; /* lsb 32 bits of Time Stamp Counter */
-static unsigned long last_tsc_high; /* msb 32 bits of Time Stamp Counter */
-static unsigned long long monotonic_base;
-static seqlock_t monotonic_lock = SEQLOCK_UNLOCKED;
-
-static int count2; /* counter for mark_offset_tsc() */
-
-/* Cached *multiplier* to convert TSC counts to microseconds.
- * (see the equation below).
- * Equal to 2^32 * (1 / (clocks per usec) ).
- * Initialized in time_init.
- */
-static unsigned long fast_gettimeoffset_quotient;
-
-static unsigned long get_offset_tsc(void)
-{
-	register unsigned long eax, edx;
-
-	/* Read the Time Stamp Counter */
-
-	rdtsc(eax,edx);
-
-	/* .. relative to previous jiffy (32 bits is enough) */
-	eax -= last_tsc_low;	/* tsc_low delta */
-
-	/*
-         * Time offset = (tsc_low delta) * fast_gettimeoffset_quotient
-         *             = (tsc_low delta) * (usecs_per_clock)
-         *             = (tsc_low delta) * (usecs_per_jiffy / clocks_per_jiffy)
-	 *
-	 * Using a mull instead of a divl saves up to 31 clock cycles
-	 * in the critical path.
-         */
-
-	__asm__("mull %2"
-		:"=a" (eax), "=d" (edx)
-		:"rm" (fast_gettimeoffset_quotient),
-		 "0" (eax));
-
-	/* our adjusted time offset in microseconds */
-	return delay_at_last_interrupt + edx;
-}
-
-static unsigned long long monotonic_clock_tsc(void)
-{
-	unsigned long long last_offset, this_offset, base;
-	unsigned seq;
-	
-	/* atomically read monotonic base & last_offset */
-	do {
-		seq = read_seqbegin(&monotonic_lock);
-		last_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
-		base = monotonic_base;
-	} while (read_seqretry(&monotonic_lock, seq));
-
-	/* Read the Time Stamp Counter */
-	rdtscll(this_offset);
-
-	/* return the value in ns */
-	return base + cycles_2_ns(this_offset - last_offset);
-}
-
-
-static void delay_tsc(unsigned long loops)
-{
-	unsigned long bclock, now;
-	
-	rdtscl(bclock);
-	do
-	{
-		rep_nop();
-		rdtscl(now);
-	} while ((now-bclock) < loops);
-}
-
-#ifdef CONFIG_HPET_TIMER
-static void mark_offset_tsc_hpet(void)
-{
-	unsigned long long this_offset, last_offset;
- 	unsigned long offset, temp, hpet_current;
-
-	write_seqlock(&monotonic_lock);
-	last_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
-	/*
-	 * It is important that these two operations happen almost at
-	 * the same time. We do the RDTSC stuff first, since it's
-	 * faster. To avoid any inconsistencies, we need interrupts
-	 * disabled locally.
-	 */
-	/*
-	 * Interrupts are just disabled locally since the timer irq
-	 * has the SA_INTERRUPT flag set. -arca
-	 */
-	/* read Pentium cycle counter */
-
-	hpet_current = hpet_readl(HPET_COUNTER);
-	rdtsc(last_tsc_low, last_tsc_high);
-
-	/* lost tick compensation */
-	offset = hpet_readl(HPET_T0_CMP) - hpet_tick;
-	if (unlikely(((offset - hpet_last) > hpet_tick) && (hpet_last != 0))) {
-		int lost_ticks = (offset - hpet_last) / hpet_tick;
-		jiffies_64 += lost_ticks;
-	}
-	hpet_last = hpet_current;
-
-	/* update the monotonic base value */
-	this_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
-	monotonic_base += cycles_2_ns(this_offset - last_offset);
-	write_sequnlock(&monotonic_lock);
-
-	/* calculate delay_at_last_interrupt */
-	/*
-	 * Time offset = (hpet delta) * ( usecs per HPET clock )
-	 *             = (hpet delta) * ( usecs per tick / HPET clocks per tick)
-	 *             = (hpet delta) * ( hpet_usec_quotient ) / (2^32)
-	 * Where,
-	 * hpet_usec_quotient = (2^32 * usecs per tick)/HPET clocks per tick
-	 */
-	delay_at_last_interrupt = hpet_current - offset;
-	ASM_MUL64_REG(temp, delay_at_last_interrupt,
-			hpet_usec_quotient, delay_at_last_interrupt);
-}
-#endif
-
-
-static void mark_offset_tsc(void)
-{
-	unsigned long lost,delay;
-	unsigned long delta = last_tsc_low;
-	int count;
-	int countmp;
-	static int count1 = 0;
-	unsigned long long this_offset, last_offset;
-	static int lost_count = 0;
-
-	write_seqlock(&monotonic_lock);
-	last_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
-	/*
-	 * It is important that these two operations happen almost at
-	 * the same time. We do the RDTSC stuff first, since it's
-	 * faster. To avoid any inconsistencies, we need interrupts
-	 * disabled locally.
-	 */
-
-	/*
-	 * Interrupts are just disabled locally since the timer irq
-	 * has the SA_INTERRUPT flag set. -arca
-	 */
-
-	/* read Pentium cycle counter */
-
-	rdtsc(last_tsc_low, last_tsc_high);
-
-	spin_lock(&i8253_lock);
-	outb_p(0x00, PIT_MODE);     /* latch the count ASAP */
-
-	count = inb_p(PIT_CH0);    /* read the latched count */
-	count |= inb(PIT_CH0) << 8;
-
-	/*
-	 * VIA686a test code... reset the latch if count > max + 1
-	 * from timer_pit.c - cjb
-	 */
-	if (count > LATCH) {
-		outb_p(0x34, PIT_MODE);
-		outb_p(LATCH & 0xff, PIT_CH0);
-		outb(LATCH >> 8, PIT_CH0);
-		count = LATCH - 1;
-	}
-
-	spin_unlock(&i8253_lock);
-
-	if (pit_latch_buggy) {
-		/* get center value of last 3 time lutch */
-		if ((count2 >= count && count >= count1)
-		    || (count1 >= count && count >= count2)) {
-			count2 = count1; count1 = count;
-		} else if ((count1 >= count2 && count2 >= count)
-			   || (count >= count2 && count2 >= count1)) {
-			countmp = count;count = count2;
-			count2 = count1;count1 = countmp;
-		} else {
-			count2 = count1; count1 = count; count = count1;
-		}
-	}
-
-	/* lost tick compensation */
-	delta = last_tsc_low - delta;
-	{
-		register unsigned long eax, edx;
-		eax = delta;
-		__asm__("mull %2"
-		:"=a" (eax), "=d" (edx)
-		:"rm" (fast_gettimeoffset_quotient),
-		 "0" (eax));
-		delta = edx;
-	}
-	delta += delay_at_last_interrupt;
-	lost = delta/(1000000/HZ);
-	delay = delta%(1000000/HZ);
-	if (lost >= 2) {
-		jiffies_64 += lost-1;
-
-		/* sanity check to ensure we're not always losing ticks */
-		if (lost_count++ > 100) {
-			printk(KERN_WARNING "Losing too many ticks!\n");
-			printk(KERN_WARNING "TSC cannot be used as a timesource.  \n");
-			printk(KERN_WARNING "Possible reasons for this are:\n");
-			printk(KERN_WARNING "  You're running with Speedstep,\n");
-			printk(KERN_WARNING "  You don't have DMA enabled for your hard disk (see hdparm),\n");
-			printk(KERN_WARNING "  Incorrect TSC synchronization on an SMP system (see dmesg).\n");
-			printk(KERN_WARNING "Falling back to a sane timesource now.\n");
-
-			clock_fallback();
-		}
-		/* ... but give the TSC a fair chance */
-		if (lost_count > 25)
-			cpufreq_delayed_get();
-	} else
-		lost_count = 0;
-	/* update the monotonic base value */
-	this_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
-	monotonic_base += cycles_2_ns(this_offset - last_offset);
-	write_sequnlock(&monotonic_lock);
-
-	/* calculate delay_at_last_interrupt */
-	count = ((LATCH-1) - count) * TICK_SIZE;
-	delay_at_last_interrupt = (count + LATCH/2) / LATCH;
-
-	/* catch corner case where tick rollover occured
-	 * between tsc and pit reads (as noted when
-	 * usec delta is > 90% # of usecs/tick)
-	 */
-	if (lost && abs(delay - delay_at_last_interrupt) > (900000/HZ))
-		jiffies_64++;
-}
-
-static int __init init_tsc(char* override)
-{
-
-	/* check clock override */
-	if (override[0] && strncmp(override,"tsc",3)) {
-#ifdef CONFIG_HPET_TIMER
-		if (is_hpet_enabled()) {
-			printk(KERN_ERR "Warning: clock= override failed. Defaulting to tsc\n");
-		} else
-#endif
-		{
-			return -ENODEV;
-		}
-	}
-
-	/*
-	 * If we have APM enabled or the CPU clock speed is variable
-	 * (CPU stops clock on HLT or slows clock to save power)
-	 * then the TSC timestamps may diverge by up to 1 jiffy from
-	 * 'real time' but nothing will break.
-	 * The most frequent case is that the CPU is "woken" from a halt
-	 * state by the timer interrupt itself, so we get 0 error. In the
-	 * rare cases where a driver would "wake" the CPU and request a
-	 * timestamp, the maximum error is < 1 jiffy. But timestamps are
-	 * still perfectly ordered.
-	 * Note that the TSC counter will be reset if APM suspends
-	 * to disk; this won't break the kernel, though, 'cuz we're
-	 * smart.  See arch/i386/kernel/apm.c.
-	 */
- 	/*
- 	 *	Firstly we have to do a CPU check for chips with
- 	 * 	a potentially buggy TSC. At this point we haven't run
- 	 *	the ident/bugs checks so we must run this hook as it
- 	 *	may turn off the TSC flag.
- 	 *
- 	 *	NOTE: this doesn't yet handle SMP 486 machines where only
- 	 *	some CPU's have a TSC. Thats never worked and nobody has
- 	 *	moaned if you have the only one in the world - you fix it!
- 	 */
-
-	count2 = LATCH; /* initialize counter for mark_offset_tsc() */
-
-	if (cpu_has_tsc) {
-		unsigned long tsc_quotient;
-#ifdef CONFIG_HPET_TIMER
-		if (is_hpet_enabled() && hpet_use_timer) {
-			unsigned long result, remain;
-			printk("Using TSC for gettimeofday\n");
-			tsc_quotient = calibrate_tsc_hpet(NULL);
-			timer_tsc.mark_offset = &mark_offset_tsc_hpet;
-			/*
-			 * Math to calculate hpet to usec multiplier
-			 * Look for the comments at get_offset_tsc_hpet()
-			 */
-			ASM_DIV64_REG(result, remain, hpet_tick,
-					0, KERNEL_TICK_USEC);
-			if (remain > (hpet_tick >> 1))
-				result++; /* rounding the result */
-
-			hpet_usec_quotient = result;
-		} else
-#endif
-		{
-			tsc_quotient = calibrate_tsc();
-		}
-
-		if (tsc_quotient) {
-			fast_gettimeoffset_quotient = tsc_quotient;
-			use_tsc = 1;
-			/*
-			 *	We could be more selective here I suspect
-			 *	and just enable this for the next intel chips ?
-			 */
-			/* report CPU clock rate in Hz.
-			 * The formula is (10^6 * 2^32) / (2^32 * 1 / (clocks/us)) =
-			 * clock/second. Our precision is about 100 ppm.
-			 */
-			{	unsigned long eax=0, edx=1000;
-				__asm__("divl %2"
-		       		:"=a" (cpu_khz), "=d" (edx)
-        	       		:"r" (tsc_quotient),
-	                	"0" (eax), "1" (edx));
-				printk("Detected %lu.%03lu MHz processor.\n", cpu_khz / 1000, cpu_khz % 1000);
-			}
-			set_cyc2ns_scale(cpu_khz/1000);
-			return 0;
-		}
-	}
-	return -ENODEV;
-}
-
-
-
-/************************************************************/
-
-/* tsc timer_opts struct */
-static struct timer_opts timer_tsc = {
-	.name = "tsc",
-	.mark_offset = mark_offset_tsc, 
-	.get_offset = get_offset_tsc,
-	.monotonic_clock = monotonic_clock_tsc,
-	.delay = delay_tsc,
-	.read_timer = read_timer_tsc,
-};
-
-struct init_timer_opts __initdata timer_tsc_init = {
-	.init = init_tsc,
-	.opts = &timer_tsc,
-};
diff -ruN linux-2.6.12-rc6-mm1/arch/i386/lib/delay.c linux-2.6.12-rc6-mm1-tod/arch/i386/lib/delay.c
--- linux-2.6.12-rc6-mm1/arch/i386/lib/delay.c	2005-06-17 19:22:40.067519314 -0700
+++ linux-2.6.12-rc6-mm1-tod/arch/i386/lib/delay.c	2005-06-17 19:08:14.000000000 -0700
@@ -14,6 +14,7 @@
 #include <linux/sched.h>
 #include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/timeofday.h>
 #include <asm/processor.h>
 #include <asm/delay.h>
 #include <asm/timer.h>
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
diff -ruN linux-2.6.12-rc6-mm1/include/asm-i386/timeofday.h linux-2.6.12-rc6-mm1-tod/include/asm-i386/timeofday.h
--- linux-2.6.12-rc6-mm1/include/asm-i386/timeofday.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.12-rc6-mm1-tod/include/asm-i386/timeofday.h	2005-06-17 19:05:24.000000000 -0700
@@ -0,0 +1,4 @@
+#ifndef _ASM_I386_TIMEOFDAY_H
+#define _ASM_I386_TIMEOFDAY_H
+#include <asm-generic/timeofday.h>
+#endif
diff -ruN linux-2.6.12-rc6-mm1/include/asm-i386/timer.h linux-2.6.12-rc6-mm1-tod/include/asm-i386/timer.h
--- linux-2.6.12-rc6-mm1/include/asm-i386/timer.h	2005-06-17 19:22:40.000000000 -0700
+++ linux-2.6.12-rc6-mm1-tod/include/asm-i386/timer.h	2005-06-17 19:23:21.000000000 -0700
@@ -2,66 +2,11 @@
 #define _ASMi386_TIMER_H
 #include <linux/init.h>
 
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


