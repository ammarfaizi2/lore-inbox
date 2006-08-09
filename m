Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030419AbWHICSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030419AbWHICSH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 22:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030417AbWHICR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 22:17:57 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:17587 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030395AbWHICRg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 22:17:36 -0400
Date: Tue, 8 Aug 2006 22:17:33 -0400
From: john stultz <johnstul@us.ibm.com>
To: ak@suse.de
Cc: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org
Message-Id: <20060809021733.23103.35576.sendpatchset@cog.beaverton.ibm.com>
In-Reply-To: <20060809021707.23103.5607.sendpatchset@cog.beaverton.ibm.com>
References: <20060809021707.23103.5607.sendpatchset@cog.beaverton.ibm.com>
Subject: [RFC][PATCH 4/6] x86_64: Enable CONFIG_GENERIC_TIME
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Enable CONFIG_GENERIC_TIME on x86_64 and remove arch specific 
timekeeping code.

Signed-off-by: John Stultz <johnstul@us.ibm.com>

 arch/x86_64/Kconfig          |    4 
 arch/x86_64/kernel/pmtimer.c |   58 -------
 arch/x86_64/kernel/time.c    |  354 +------------------------------------------
 include/asm-x86_64/proto.h   |    1 
 4 files changed, 19 insertions(+), 398 deletions(-)

linux-2.6.18-rc4_timeofday-arch-x86-64-part3_C5.patch
============================================
diff --git a/arch/x86_64/Kconfig b/arch/x86_64/Kconfig
index 28df7d8..fabb174 100644
--- a/arch/x86_64/Kconfig
+++ b/arch/x86_64/Kconfig
@@ -24,6 +24,10 @@ config X86
 	bool
 	default y
 
+config GENERIC_TIME
+	bool
+	default y
+
 config LOCKDEP_SUPPORT
 	bool
 	default y
diff --git a/arch/x86_64/kernel/pmtimer.c b/arch/x86_64/kernel/pmtimer.c
index 7554458..ae8f912 100644
--- a/arch/x86_64/kernel/pmtimer.c
+++ b/arch/x86_64/kernel/pmtimer.c
@@ -24,15 +24,6 @@
 #include <asm/msr.h>
 #include <asm/vsyscall.h>
 
-/* The I/O port the PMTMR resides at.
- * The location is detected during setup_arch(),
- * in arch/i386/kernel/acpi/boot.c */
-u32 pmtmr_ioport __read_mostly;
-
-/* value of the Power timer at last timer interrupt */
-static u32 offset_delay;
-static u32 last_pmtmr_tick;
-
 #define ACPI_PM_MASK 0xFFFFFF /* limit it to 24 bits */
 
 static inline u32 cyc2us(u32 cycles)
@@ -48,38 +39,6 @@ static inline u32 cyc2us(u32 cycles)
 	return (cycles >> 10);
 }
 
-int pmtimer_mark_offset(void)
-{
-	static int first_run = 1;
-	unsigned long tsc;
-	u32 lost;
-
-	u32 tick = inl(pmtmr_ioport);
-	u32 delta;
-
-	delta = cyc2us((tick - last_pmtmr_tick) & ACPI_PM_MASK);
-
-	last_pmtmr_tick = tick;
-	monotonic_base += delta * NSEC_PER_USEC;
-
-	delta += offset_delay;
-
-	lost = delta / (USEC_PER_SEC / HZ);
-	offset_delay = delta % (USEC_PER_SEC / HZ);
-
-	rdtscll(tsc);
-	vxtime.last_tsc = tsc - offset_delay * (u64)cpu_khz / 1000;
-
-	/* don't calculate delay for first run,
-	   or if we've got less then a tick */
-	if (first_run || (lost < 1)) {
-		first_run = 0;
-		offset_delay = 0;
-	}
-
-	return lost - 1;
-}
-
 static unsigned pmtimer_wait_tick(void)
 {
 	u32 a, b;
@@ -101,23 +60,6 @@ void pmtimer_wait(unsigned us)
 	} while (cyc2us(b - a) < us);
 }
 
-void pmtimer_resume(void)
-{
-	last_pmtmr_tick = inl(pmtmr_ioport);
-}
-
-unsigned int do_gettimeoffset_pm(void)
-{
-	u32 now, offset, delta = 0;
-
-	offset = last_pmtmr_tick;
-	now = inl(pmtmr_ioport);
-	delta = (now - offset) & ACPI_PM_MASK;
-
-	return offset_delay + cyc2us(delta);
-}
-
-
 static int __init nopmtimer_setup(char *s)
 {
 	pmtmr_ioport = 0;
diff --git a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
index a4aef4e..d18230a 100644
--- a/arch/x86_64/kernel/time.c
+++ b/arch/x86_64/kernel/time.c
@@ -43,14 +43,9 @@
 #include <asm/apic.h>
 #endif
 
-#ifdef CONFIG_CPU_FREQ
-static void cpufreq_delayed_get(void);
-#endif
 extern void i8254_timer_resume(void);
 extern int using_apic_timer;
 
-static char *time_init_gtod(void);
-
 DEFINE_SPINLOCK(rtc_lock);
 EXPORT_SYMBOL(rtc_lock);
 DEFINE_SPINLOCK(i8253_lock);
@@ -82,108 +77,6 @@ unsigned long __wall_jiffies __section_w
 struct timespec __xtime __section_xtime;
 struct timezone __sys_tz __section_sys_tz;
 
-/*
- * do_gettimeoffset() returns microseconds since last timer interrupt was
- * triggered by hardware. A memory read of HPET is slower than a register read
- * of TSC, but much more reliable. It's also synchronized to the timer
- * interrupt. Note that do_gettimeoffset() may return more than hpet_tick, if a
- * timer interrupt has happened already, but vxtime.trigger wasn't updated yet.
- * This is not a problem, because jiffies hasn't updated either. They are bound
- * together by xtime_lock.
- */
-
-static inline unsigned int do_gettimeoffset_tsc(void)
-{
-	unsigned long t;
-	unsigned long x;
-	t = get_cycles_sync();
-	if (t < vxtime.last_tsc) 
-		t = vxtime.last_tsc; /* hack */
-	x = ((t - vxtime.last_tsc) * vxtime.tsc_quot) >> US_SCALE;
-	return x;
-}
-
-static inline unsigned int do_gettimeoffset_hpet(void)
-{
-	/* cap counter read to one tick to avoid inconsistencies */
-	unsigned long counter = hpet_readl(HPET_COUNTER) - vxtime.last;
-	return (min(counter,hpet_tick) * vxtime.quot) >> US_SCALE;
-}
-
-unsigned int (*do_gettimeoffset)(void) = do_gettimeoffset_tsc;
-
-/*
- * This version of gettimeofday() has microsecond resolution and better than
- * microsecond precision, as we're using at least a 10 MHz (usually 14.31818
- * MHz) HPET timer.
- */
-
-void do_gettimeofday(struct timeval *tv)
-{
-	unsigned long seq, t;
- 	unsigned int sec, usec;
-
-	do {
-		seq = read_seqbegin(&xtime_lock);
-
-		sec = xtime.tv_sec;
-		usec = xtime.tv_nsec / NSEC_PER_USEC;
-
-		/* i386 does some correction here to keep the clock 
-		   monotonous even when ntpd is fixing drift.
-		   But they didn't work for me, there is a non monotonic
-		   clock anyways with ntp.
-		   I dropped all corrections now until a real solution can
-		   be found. Note when you fix it here you need to do the same
-		   in arch/x86_64/kernel/vsyscall.c and export all needed
-		   variables in vmlinux.lds. -AK */ 
-
-		t = (jiffies - wall_jiffies) * USEC_PER_TICK +
-			do_gettimeoffset();
-		usec += t;
-
-	} while (read_seqretry(&xtime_lock, seq));
-
-	tv->tv_sec = sec + usec / USEC_PER_SEC;
-	tv->tv_usec = usec % USEC_PER_SEC;
-}
-
-EXPORT_SYMBOL(do_gettimeofday);
-
-/*
- * settimeofday() first undoes the correction that gettimeofday would do
- * on the time, and then saves it. This is ugly, but has been like this for
- * ages already.
- */
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
-
-	nsec -= do_gettimeoffset() * NSEC_PER_USEC +
-		(jiffies - wall_jiffies) * NSEC_PER_TICK;
-
-	wtm_sec  = wall_to_monotonic.tv_sec + (xtime.tv_sec - sec);
-	wtm_nsec = wall_to_monotonic.tv_nsec + (xtime.tv_nsec - nsec);
-
-	set_normalized_timespec(&xtime, sec, nsec);
-	set_normalized_timespec(&wall_to_monotonic, wtm_sec, wtm_nsec);
-
-	ntp_clear();
-
-	write_sequnlock_irq(&xtime_lock);
-	clock_was_set();
-	return 0;
-}
-
-EXPORT_SYMBOL(do_settimeofday);
-
 unsigned long profile_pc(struct pt_regs *regs)
 {
 	unsigned long pc = instruction_pointer(regs);
@@ -278,85 +171,9 @@ static void set_rtc_mmss(unsigned long n
 }
 
 
-/* monotonic_clock(): returns # of nanoseconds passed since time_init()
- *		Note: This function is required to return accurate
- *		time even in the absence of multiple timer ticks.
- */
-unsigned long long monotonic_clock(void)
-{
-	unsigned long seq;
- 	u32 last_offset, this_offset, offset;
-	unsigned long long base;
-
-	if (vxtime.mode == VXTIME_HPET) {
-		do {
-			seq = read_seqbegin(&xtime_lock);
-
-			last_offset = vxtime.last;
-			base = monotonic_base;
-			this_offset = hpet_readl(HPET_COUNTER);
-		} while (read_seqretry(&xtime_lock, seq));
-		offset = (this_offset - last_offset);
-		offset *= NSEC_PER_TICK / hpet_tick;
-	} else {
-		do {
-			seq = read_seqbegin(&xtime_lock);
-
-			last_offset = vxtime.last_tsc;
-			base = monotonic_base;
-		} while (read_seqretry(&xtime_lock, seq));
-		this_offset = get_cycles_sync();
-		/* FIXME: 1000 or 1000000? */
-		offset = (this_offset - last_offset)*1000 / cpu_khz;
-	}
-	return base + offset;
-}
-EXPORT_SYMBOL(monotonic_clock);
-
-static noinline void handle_lost_ticks(int lost, struct pt_regs *regs)
-{
-	static long lost_count;
-	static int warned;
-	if (report_lost_ticks) {
-		printk(KERN_WARNING "time.c: Lost %d timer tick(s)! ", lost);
-		print_symbol("rip %s)\n", regs->rip);
-	}
-
-	if (lost_count == 1000 && !warned) {
-		printk(KERN_WARNING "warning: many lost ticks.\n"
-		       KERN_WARNING "Your time source seems to be instable or "
-		   		"some driver is hogging interupts\n");
-		print_symbol("rip %s\n", regs->rip);
-		if (vxtime.mode == VXTIME_TSC && hpet_address) {
-			printk(KERN_WARNING "Falling back to HPET\n");
-			if (hpet_use_timer)
-				vxtime.last = hpet_readl(HPET_T0_CMP) - 
-							hpet_tick;
-			else
-				vxtime.last = hpet_readl(HPET_COUNTER);
-			vxtime.mode = VXTIME_HPET;
-			vxtime.hpet_address = hpet_address;
-			do_gettimeoffset = do_gettimeoffset_hpet;
-		}
-		/* else should fall back to PIT, but code missing. */
-		warned = 1;
-	} else
-		lost_count++;
-
-#ifdef CONFIG_CPU_FREQ
-	/* In some cases the CPU can change frequency without us noticing
-	   Give cpufreq a change to catch up. */
-	if ((lost_count+1) % 25 == 0)
-		cpufreq_delayed_get();
-#endif
-}
-
 void main_timer_handler(struct pt_regs *regs)
 {
 	static unsigned long rtc_update = 0;
-	unsigned long tsc;
-	int delay = 0, offset = 0, lost = 0;
-
 /*
  * Here we are in the timer irq handler. We have irqs locally disabled (so we
  * don't need spin_lock_irqsave()) but we don't know if the timer_bh is running
@@ -366,68 +183,6 @@ void main_timer_handler(struct pt_regs *
 
 	write_seqlock(&xtime_lock);
 
-	if (hpet_address)
-		offset = hpet_readl(HPET_COUNTER);
-
-	if (hpet_use_timer) {
-		/* if we're using the hpet timer functionality,
-		 * we can more accurately know the counter value
-		 * when the timer interrupt occured.
-		 */
-		offset = hpet_readl(HPET_T0_CMP) - hpet_tick;
-		delay = hpet_readl(HPET_COUNTER) - offset;
-	} else if (!pmtmr_ioport) {
-		spin_lock(&i8253_lock);
-		outb_p(0x00, 0x43);
-		delay = inb_p(0x40);
-		delay |= inb(0x40) << 8;
-		spin_unlock(&i8253_lock);
-		delay = LATCH - 1 - delay;
-	}
-
-	tsc = get_cycles_sync();
-
-	if (vxtime.mode == VXTIME_HPET) {
-		if (offset - vxtime.last > hpet_tick) {
-			lost = (offset - vxtime.last) / hpet_tick - 1;
-		}
-
-		monotonic_base += 
-			(offset - vxtime.last) * NSEC_PER_TICK / hpet_tick;
-
-		vxtime.last = offset;
-#ifdef CONFIG_X86_PM_TIMER
-	} else if (vxtime.mode == VXTIME_PMTMR) {
-		lost = pmtimer_mark_offset();
-#endif
-	} else {
-		offset = (((tsc - vxtime.last_tsc) *
-			   vxtime.tsc_quot) >> US_SCALE) - USEC_PER_TICK;
-
-		if (offset < 0)
-			offset = 0;
-
-		if (offset > USEC_PER_TICK) {
-			lost = offset / USEC_PER_TICK;
-			offset %= USEC_PER_TICK;
-		}
-
-		/* FIXME: 1000 or 1000000? */
-		monotonic_base += (tsc - vxtime.last_tsc) * 1000000 / cpu_khz;
-
-		vxtime.last_tsc = tsc - vxtime.quot * delay / vxtime.tsc_quot;
-
-		if ((((tsc - vxtime.last_tsc) *
-		      vxtime.tsc_quot) >> US_SCALE) < offset)
-			vxtime.last_tsc = tsc -
-				(((long) offset << US_SCALE) / vxtime.tsc_quot) - 1;
-	}
-
-	if (lost > 0) {
-		handle_lost_ticks(lost, regs);
-		jiffies += lost;
-	}
-
 /*
  * Do the timer stuff.
  */
@@ -493,15 +248,6 @@ unsigned long long sched_clock(void)
 {
 	unsigned long a = 0;
 
-#if 0
-	/* Don't do a HPET read here. Using TSC always is much faster
-	   and HPET may not be mapped yet when the scheduler first runs.
-           Disadvantage is a small drift between CPUs in some configurations,
-	   but that should be tolerable. */
-	if (__vxtime.mode == VXTIME_HPET)
-		return (hpet_readl(HPET_COUNTER) * vxtime.quot) >> US_SCALE;
-#endif
-
 	/* Could do CPU core sync here. Opteron can execute rdtsc speculatively,
 	   which means it is not completely exact and may not be monotonous between
 	   CPUs. But the errors should be too small to matter for scheduling
@@ -511,6 +257,19 @@ unsigned long long sched_clock(void)
 	return cycles_2_ns(a);
 }
 
+static int tsc_unstable;
+
+static inline int check_tsc_unstable(void)
+{
+	return tsc_unstable;
+}
+
+void mark_tsc_unstable(void)
+{
+	tsc_unstable = 1;
+}
+EXPORT_SYMBOL_GPL(mark_tsc_unstable);
+
 static unsigned long get_cmos_time(void)
 {
 	unsigned int year, mon, day, hour, min, sec;
@@ -589,24 +348,6 @@ static void handle_cpufreq_delayed_get(v
 	cpufreq_delayed_issched = 0;
 }
 
-/* if we notice lost ticks, schedule a call to cpufreq_get() as it tries
- * to verify the CPU frequency the timing core thinks the CPU is running
- * at is still correct.
- */
-static void cpufreq_delayed_get(void)
-{
-	static int warned;
-	if (cpufreq_init && !cpufreq_delayed_issched) {
-		cpufreq_delayed_issched = 1;
-		if (!warned) {
-			warned = 1;
-			printk(KERN_DEBUG 
-	"Losing some ticks... checking if CPU frequency changed.\n");
-		}
-		schedule_work(&cpufreq_delayed_get_work);
-	}
-}
-
 static unsigned int  ref_freq = 0;
 static unsigned long loops_per_jiffy_ref = 0;
 
@@ -896,7 +637,6 @@ static struct irqaction irq0 = {
 void __init time_init(void)
 {
 	char *timename;
-	char *gtod;
 
 	if (nohpet)
 		hpet_address = 0;
@@ -906,9 +646,7 @@ void __init time_init(void)
 	set_normalized_timespec(&wall_to_monotonic,
 	                        -xtime.tv_sec, -xtime.tv_nsec);
 
-	if (!hpet_init())
-                vxtime_hz = (FSEC_PER_SEC + hpet_period / 2) / hpet_period;
-	else
+	if (hpet_init())
 		hpet_address = 0;
 
 	if (hpet_use_timer) {
@@ -916,29 +654,14 @@ void __init time_init(void)
 	  	tick_nsec = TICK_NSEC_HPET;
 		cpu_khz = hpet_calibrate_tsc();
 		timename = "HPET";
-#ifdef CONFIG_X86_PM_TIMER
-	} else if (pmtmr_ioport && !hpet_address) {
-		vxtime_hz = PM_TIMER_FREQUENCY;
-		timename = "PM";
-		pit_init();
-		cpu_khz = pit_calibrate_tsc();
-#endif
 	} else {
 		pit_init();
 		cpu_khz = pit_calibrate_tsc();
 		timename = "PIT";
 	}
 
-	vxtime.mode = VXTIME_TSC;
-	gtod = time_init_gtod();
-
-	printk(KERN_INFO "time.c: Using %ld.%06ld MHz WALL %s GTOD %s timer.\n",
-	       vxtime_hz / 1000000, vxtime_hz % 1000000, timename, gtod);
 	printk(KERN_INFO "time.c: Detected %d.%03d MHz processor.\n",
 		cpu_khz / 1000, cpu_khz % 1000);
-	vxtime.quot = (USEC_PER_SEC << US_SCALE) / vxtime_hz;
-	vxtime.tsc_quot = (USEC_PER_MSEC << US_SCALE) / cpu_khz;
-	vxtime.last_tsc = get_cycles_sync();
 	setup_irq(0, &irq0);
 
 	set_cyc2ns_scale(cpu_khz);
@@ -969,41 +692,6 @@ __cpuinit int unsynchronized_tsc(void)
  	return num_present_cpus() > 1;
 }
 
-/*
- * Decide what mode gettimeofday should use.
- */
-__init static char *time_init_gtod(void)
-{
-	char *timetype;
-
-	if (unsynchronized_tsc())
-		notsc = 1;
-	if (hpet_address && notsc) {
-		timetype = hpet_use_timer ? "HPET" : "PIT/HPET";
-		if (hpet_use_timer)
-			vxtime.last = hpet_readl(HPET_T0_CMP) - hpet_tick;
-		else
-			vxtime.last = hpet_readl(HPET_COUNTER);
-		vxtime.mode = VXTIME_HPET;
-		vxtime.hpet_address = hpet_address;
-		do_gettimeoffset = do_gettimeoffset_hpet;
-#ifdef CONFIG_X86_PM_TIMER
-	/* Using PM for gettimeofday is quite slow, but we have no other
-	   choice because the TSC is too unreliable on some systems. */
-	} else if (pmtmr_ioport && !hpet_address && notsc) {
-		timetype = "PM";
-		do_gettimeoffset = do_gettimeoffset_pm;
-		vxtime.mode = VXTIME_PMTMR;
-		sysctl_vsyscall = 0;
-		printk(KERN_INFO "Disabling vsyscall due to use of PM timer\n");
-#endif
-	} else {
-		timetype = hpet_use_timer ? "HPET/TSC" : "PIT/TSC";
-		vxtime.mode = VXTIME_TSC;
-	}
-	return timetype;
-}
-
 __setup("report_lost_ticks", time_setup);
 
 static long clock_cmos_diff;
@@ -1042,21 +730,9 @@ static int timer_resume(struct sys_devic
 	write_seqlock_irqsave(&xtime_lock,flags);
 	xtime.tv_sec = sec;
 	xtime.tv_nsec = 0;
-	if (vxtime.mode == VXTIME_HPET) {
-		if (hpet_use_timer)
-			vxtime.last = hpet_readl(HPET_T0_CMP) - hpet_tick;
-		else
-			vxtime.last = hpet_readl(HPET_COUNTER);
-#ifdef CONFIG_X86_PM_TIMER
-	} else if (vxtime.mode == VXTIME_PMTMR) {
-		pmtimer_resume();
-#endif
-	} else
-		vxtime.last_tsc = get_cycles_sync();
-	write_sequnlock_irqrestore(&xtime_lock,flags);
 	jiffies += sleep_length;
 	wall_jiffies += sleep_length;
-	monotonic_base += sleep_length * (NSEC_PER_SEC/HZ);
+	write_sequnlock_irqrestore(&xtime_lock,flags);
 	touch_softlockup_watchdog();
 	return 0;
 }
diff --git a/include/asm-x86_64/proto.h b/include/asm-x86_64/proto.h
index 038fe1f..716ac55 100644
--- a/include/asm-x86_64/proto.h
+++ b/include/asm-x86_64/proto.h
@@ -47,7 +47,6 @@ extern u32 pmtmr_ioport;
 #else
 #define pmtmr_ioport 0
 #endif
-extern unsigned long long monotonic_base;
 extern int sysctl_vsyscall;
 extern int nohpet;
 extern unsigned long vxtime_hz;
