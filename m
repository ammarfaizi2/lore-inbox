Return-Path: <linux-kernel-owner+w=401wt.eu-S1030389AbWLTWNx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030389AbWLTWNx (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 17:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030388AbWLTWNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 17:13:52 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:51049 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030386AbWLTWNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 17:13:49 -0500
Date: Wed, 20 Dec 2006 17:13:43 -0500
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu,
       Valdis.Kletnieks@vt.edu, john stultz <johnstul@us.ibm.com>
Message-Id: <20061220221009.15178.6526.sendpatchset@localhost>
In-Reply-To: <20061220220945.15178.2669.sendpatchset@localhost>
References: <20061220220945.15178.2669.sendpatchset@localhost>
Subject: [PATCH -mm 4/5][time][x86_64] Convert x86_64 to use GENERIC_TIME
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts x86_64 to use the GENERIC_TIME infrastructure and 
adds clocksource structures for both TSC and HPET (ACPI PM is shared w/ 
i386).

Signed-off-by: John Stultz <johnstul@us.ibm.com>

 arch/x86_64/Kconfig            |    4 
 arch/x86_64/kernel/apic.c      |    2 
 arch/x86_64/kernel/hpet.c      |   65 ++++++++
 arch/x86_64/kernel/pmtimer.c   |   58 -------
 arch/x86_64/kernel/smpboot.c   |    1 
 arch/x86_64/kernel/time.c      |  301 -----------------------------------------
 arch/x86_64/kernel/tsc.c       |  108 ++++++++------
 drivers/char/hangcheck-timer.c |    2 
 include/asm-x86_64/proto.h     |    2 
 include/asm-x86_64/timex.h     |    5 
 10 files changed, 137 insertions(+), 411 deletions(-)

linux-2.6.20-rc1_timeofday-arch-x86-64-generic-time-conversion_C7.patch
============================================
Index: 2.6-mm/arch/x86_64/Kconfig
===================================================================
--- 2.6-mm.orig/arch/x86_64/Kconfig	2006-12-20 12:19:26.000000000 -0800
+++ 2.6-mm/arch/x86_64/Kconfig	2006-12-20 12:24:10.000000000 -0800
@@ -24,6 +24,10 @@ config X86
 	bool
 	default y
 
+config GENERIC_TIME
+	bool
+	default y
+
 config ZONE_DMA32
 	bool
 	default y
Index: 2.6-mm/arch/x86_64/kernel/apic.c
===================================================================
--- 2.6-mm.orig/arch/x86_64/kernel/apic.c	2006-12-20 12:20:01.000000000 -0800
+++ 2.6-mm/arch/x86_64/kernel/apic.c	2006-12-20 12:24:10.000000000 -0800
@@ -785,7 +785,7 @@ static void setup_APIC_timer(unsigned in
 	/* Turn off PIT interrupt if we use APIC timer as main timer.
 	   Only works with the PM timer right now
 	   TBD fix it for HPET too. */
-	if (vxtime.mode == VXTIME_PMTMR &&
+	if ((pmtmr_ioport != 0) &&
 		smp_processor_id() == boot_cpu_id &&
 		apic_runs_main_timer == 1 &&
 		!cpu_isset(boot_cpu_id, timer_interrupt_broadcast_ipi_mask)) {
Index: 2.6-mm/arch/x86_64/kernel/hpet.c
===================================================================
--- 2.6-mm.orig/arch/x86_64/kernel/hpet.c	2006-12-20 12:23:00.000000000 -0800
+++ 2.6-mm/arch/x86_64/kernel/hpet.c	2006-12-20 12:24:10.000000000 -0800
@@ -21,12 +21,6 @@ unsigned long hpet_tick;	/* HPET clocks 
 int hpet_use_timer;		/* Use counter of hpet for time keeping,
 				 * otherwise PIT
 				 */
-unsigned int do_gettimeoffset_hpet(void)
-{
-	/* cap counter read to one tick to avoid inconsistencies */
-	unsigned long counter = hpet_readl(HPET_COUNTER) - vxtime.last;
-	return (min(counter,hpet_tick) * vxtime.quot) >> US_SCALE;
-}
 
 #ifdef	CONFIG_HPET
 static __init int late_hpet_init(void)
@@ -436,3 +430,62 @@ static int __init nohpet_setup(char *s)
 
 __setup("nohpet", nohpet_setup);
 
+#define HPET_MASK	0xFFFFFFFF
+#define HPET_SHIFT	22
+
+/* FSEC = 10^-15 NSEC = 10^-9 */
+#define FSEC_PER_NSEC	1000000
+
+static void *hpet_ptr;
+
+static cycle_t read_hpet(void)
+{
+	return (cycle_t)readl(hpet_ptr);
+}
+
+struct clocksource clocksource_hpet = {
+	.name		= "hpet",
+	.rating		= 250,
+	.read		= read_hpet,
+	.mask		= (cycle_t)HPET_MASK,
+	.mult		= 0, /* set below */
+	.shift		= HPET_SHIFT,
+	.is_continuous	= 1,
+};
+
+static int __init init_hpet_clocksource(void)
+{
+	unsigned long hpet_period;
+	void __iomem *hpet_base;
+	u64 tmp;
+
+	if (!hpet_address)
+		return -ENODEV;
+
+	/* calculate the hpet address: */
+	hpet_base =
+		(void __iomem*)ioremap_nocache(hpet_address, HPET_MMAP_SIZE);
+	hpet_ptr = hpet_base + HPET_COUNTER;
+
+	/* calculate the frequency: */
+	hpet_period = readl(hpet_base + HPET_PERIOD);
+
+	/*
+	 * hpet period is in femto seconds per cycle
+	 * so we need to convert this to ns/cyc units
+	 * aproximated by mult/2^shift
+	 *
+	 *  fsec/cyc * 1nsec/1000000fsec = nsec/cyc = mult/2^shift
+	 *  fsec/cyc * 1ns/1000000fsec * 2^shift = mult
+	 *  fsec/cyc * 2^shift * 1nsec/1000000fsec = mult
+	 *  (fsec/cyc << shift)/1000000 = mult
+	 *  (hpet_period << shift)/FSEC_PER_NSEC = mult
+	 */
+	tmp = (u64)hpet_period << HPET_SHIFT;
+	do_div(tmp, FSEC_PER_NSEC);
+	clocksource_hpet.mult = (u32)tmp;
+
+	return clocksource_register(&clocksource_hpet);
+}
+
+module_init(init_hpet_clocksource);
Index: 2.6-mm/arch/x86_64/kernel/pmtimer.c
===================================================================
--- 2.6-mm.orig/arch/x86_64/kernel/pmtimer.c	2006-12-20 12:18:18.000000000 -0800
+++ 2.6-mm/arch/x86_64/kernel/pmtimer.c	2006-12-20 12:24:10.000000000 -0800
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
Index: 2.6-mm/arch/x86_64/kernel/smpboot.c
===================================================================
--- 2.6-mm.orig/arch/x86_64/kernel/smpboot.c	2006-12-20 12:19:26.000000000 -0800
+++ 2.6-mm/arch/x86_64/kernel/smpboot.c	2006-12-20 12:24:10.000000000 -0800
@@ -1181,7 +1181,6 @@ void __init smp_cpus_done(unsigned int m
 	smp_cleanup_boot();
 	setup_ioapic_dest();
 	check_nmi_watchdog();
-	time_init_gtod();
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
Index: 2.6-mm/arch/x86_64/kernel/time.c
===================================================================
--- 2.6-mm.orig/arch/x86_64/kernel/time.c	2006-12-20 12:23:54.000000000 -0800
+++ 2.6-mm/arch/x86_64/kernel/time.c	2006-12-20 12:29:59.000000000 -0800
@@ -44,9 +44,6 @@
 #include <asm/apic.h>
 #include <asm/hpet.h>
 
-#ifdef CONFIG_CPU_FREQ
-extern void cpufreq_delayed_get(void);
-#endif
 extern void i8254_timer_resume(void);
 extern int using_apic_timer;
 
@@ -57,8 +54,6 @@ EXPORT_SYMBOL(rtc_lock);
 DEFINE_SPINLOCK(i8253_lock);
 
 unsigned long vxtime_hz = PIT_TICK_RATE;
-int report_lost_ticks;				/* command line option */
-unsigned long long monotonic_base;
 
 struct vxtime_data __vxtime __section_vxtime;	/* for vsyscalls */
 
@@ -66,76 +61,6 @@ volatile unsigned long __jiffies __secti
 struct timespec __xtime __section_xtime;
 struct timezone __sys_tz __section_sys_tz;
 
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
-	unsigned long seq;
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
-		usec += do_gettimeoffset();
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
-	nsec -= do_gettimeoffset() * NSEC_PER_USEC;
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
@@ -225,85 +150,9 @@ static void set_rtc_mmss(unsigned long n
 }
 
 
-/* monotonic_clock(): returns # of nanoseconds passed since time_init()
- *		Note: This function is required to return accurate
- *		time even in the absence of multiple timer ticks.
- */
-extern unsigned long long cycles_2_ns(unsigned long long cyc);
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
-		offset = cycles_2_ns(this_offset - last_offset);
-	}
-	return base + offset;
-}
-EXPORT_SYMBOL(monotonic_clock);
-
-static noinline void handle_lost_ticks(int lost)
-{
-	static long lost_count;
-	static int warned;
-	if (report_lost_ticks) {
-		printk(KERN_WARNING "time.c: Lost %d timer tick(s)! ", lost);
-		print_symbol("rip %s)\n", get_irq_regs()->rip);
-	}
-
-	if (lost_count == 1000 && !warned) {
-		printk(KERN_WARNING "warning: many lost ticks.\n"
-		       KERN_WARNING "Your time source seems to be instable or "
-		   		"some driver is hogging interupts\n");
-		print_symbol("rip %s\n", get_irq_regs()->rip);
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
 void main_timer_handler(void)
 {
 	static unsigned long rtc_update = 0;
-	unsigned long tsc;
-	int delay = 0, offset = 0, lost = 0;
-
 /*
  * Here we are in the timer irq handler. We have irqs locally disabled (so we
  * don't need spin_lock_irqsave()) but we don't know if the timer_bh is running
@@ -313,72 +162,11 @@ void main_timer_handler(void)
 
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
-		monotonic_base += cycles_2_ns(tsc - vxtime.last_tsc);
-
-		vxtime.last_tsc = tsc - vxtime.quot * delay / vxtime.tsc_quot;
-
-		if ((((tsc - vxtime.last_tsc) *
-		      vxtime.tsc_quot) >> US_SCALE) < offset)
-			vxtime.last_tsc = tsc -
-				(((long) offset << US_SCALE) / vxtime.tsc_quot) - 1;
-	}
-
-	if (lost > 0)
-		handle_lost_ticks(lost);
-	else
-		lost = 0;
-
 /*
  * Do the timer stuff.
  */
 
-	do_timer(lost + 1);
+	do_timer(1);
 #ifndef CONFIG_SMP
 	update_process_times(user_mode(get_irq_regs()));
 #endif
@@ -537,12 +325,6 @@ void __init stop_timer_interrupt(void)
 	printk(KERN_INFO "timer: %s interrupt stopped.\n", name);
 }
 
-int __init time_setup(char *str)
-{
-	report_lost_ticks = 1;
-	return 1;
-}
-
 static struct irqaction irq0 = {
 	timer_interrupt, IRQF_DISABLED, CPU_MASK_NONE, "timer", NULL, NULL
 };
@@ -557,9 +339,7 @@ void __init time_init(void)
 	set_normalized_timespec(&wall_to_monotonic,
 	                        -xtime.tv_sec, -xtime.tv_nsec);
 
-	if (!hpet_arch_init())
-                vxtime_hz = (FSEC_PER_SEC + hpet_period / 2) / hpet_period;
-	else
+	if (hpet_arch_init())
 		hpet_address = 0;
 
 	if (hpet_use_timer) {
@@ -567,82 +347,25 @@ void __init time_init(void)
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
-	vxtime.quot = (USEC_PER_SEC << US_SCALE) / vxtime_hz;
-	vxtime.tsc_quot = (USEC_PER_MSEC << US_SCALE) / cpu_khz;
-	vxtime.last_tsc = get_cycles_sync();
-	set_cyc2ns_scale(cpu_khz);
-	setup_irq(0, &irq0);
-
-#ifndef CONFIG_SMP
-	time_init_gtod();
-#endif
-}
-
-/*
- * Decide what mode gettimeofday should use.
- */
-void time_init_gtod(void)
-{
-	char *timetype;
-
 	if (unsynchronized_tsc())
-		notsc = 1;
+		mark_tsc_unstable();
 
 	if (cpu_has(&boot_cpu_data, X86_FEATURE_RDTSCP))
 		vgetcpu_mode = VGETCPU_RDTSCP;
 	else
 		vgetcpu_mode = VGETCPU_LSL;
 
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
-
-	printk(KERN_INFO "time.c: Using %ld.%06ld MHz WALL %s GTOD %s timer.\n",
-	       vxtime_hz / 1000000, vxtime_hz % 1000000, timename, timetype);
 	printk(KERN_INFO "time.c: Detected %d.%03d MHz processor.\n",
 		cpu_khz / 1000, cpu_khz % 1000);
-	vxtime.quot = (USEC_PER_SEC << US_SCALE) / vxtime_hz;
-	vxtime.tsc_quot = (USEC_PER_MSEC << US_SCALE) / cpu_khz;
-	vxtime.last_tsc = get_cycles_sync();
-
-	set_cyc2ns_scale(cpu_khz);
+	setup_irq(0, &irq0);
 }
 
-__setup("report_lost_ticks", time_setup);
 
 static long clock_cmos_diff;
 static unsigned long sleep_start;
@@ -688,20 +411,8 @@ static int timer_resume(struct sys_devic
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
-	monotonic_base += sleep_length * (NSEC_PER_SEC/HZ);
+	write_sequnlock_irqrestore(&xtime_lock,flags);
 	touch_softlockup_watchdog();
 	return 0;
 }
Index: 2.6-mm/arch/x86_64/kernel/tsc.c
===================================================================
--- 2.6-mm.orig/arch/x86_64/kernel/tsc.c	2006-12-20 12:21:16.000000000 -0800
+++ 2.6-mm/arch/x86_64/kernel/tsc.c	2006-12-20 12:24:10.000000000 -0800
@@ -9,32 +9,11 @@
 
 #include <asm/timex.h>
 
-int notsc __initdata = 0;
+static int notsc __initdata = 0;
 
 unsigned int cpu_khz;		/* TSC clocks / usec, not used here */
 EXPORT_SYMBOL(cpu_khz);
 
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
-unsigned int do_gettimeoffset_tsc(void)
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
 static unsigned int cyc2ns_scale __read_mostly;
 
 void set_cyc2ns_scale(unsigned long khz)
@@ -42,7 +21,7 @@ void set_cyc2ns_scale(unsigned long khz)
 	cyc2ns_scale = (NSEC_PER_MSEC << NS_SCALE) / khz;
 }
 
-unsigned long long cycles_2_ns(unsigned long long cyc)
+static unsigned long long cycles_2_ns(unsigned long long cyc)
 {
 	return (cyc * cyc2ns_scale) >> NS_SCALE;
 }
@@ -61,6 +40,19 @@ unsigned long long sched_clock(void)
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
 #ifdef CONFIG_CPU_FREQ
 
 /* Frequency scaling support. Adjust the TSC based timer when the cpu frequency
@@ -89,24 +81,6 @@ static void handle_cpufreq_delayed_get(s
 	cpufreq_delayed_issched = 0;
 }
 
-/* if we notice lost ticks, schedule a call to cpufreq_get() as it tries
- * to verify the CPU frequency the timing core thinks the CPU is running
- * at is still correct.
- */
-void cpufreq_delayed_get(void)
-{
-	static int warned;
-	if (cpufreq_init && !cpufreq_delayed_issched) {
-		cpufreq_delayed_issched = 1;
-		if (!warned) {
-			warned = 1;
-			printk(KERN_DEBUG "Losing some ticks... "
-				"checking if CPU frequency changed.\n");
-		}
-		schedule_work(&cpufreq_delayed_get_work);
-	}
-}
-
 static unsigned int  ref_freq = 0;
 static unsigned long loops_per_jiffy_ref = 0;
 
@@ -142,7 +116,7 @@ static int time_cpufreq_notifier(struct 
 
 		cpu_khz = cpufreq_scale(cpu_khz_ref, ref_freq, freq->new);
 		if (!(freq->flags & CPUFREQ_CONST_LOOPS))
-			vxtime.tsc_quot = (USEC_PER_MSEC << US_SCALE) / cpu_khz;
+			mark_tsc_unstable();
 	}
 
 	set_cyc2ns_scale(cpu_khz_ref);
@@ -207,3 +181,53 @@ int __init notsc_setup(char *s)
 }
 
 __setup("notsc", notsc_setup);
+
+
+/* clock source code: */
+
+static int tsc_update_callback(void);
+
+static cycle_t read_tsc(void)
+{
+	cycle_t ret = (cycle_t)get_cycles_sync();
+	return ret;
+}
+
+static struct clocksource clocksource_tsc = {
+	.name			= "tsc",
+	.rating			= 300,
+	.read			= read_tsc,
+	.mask			= (cycle_t)-1,
+	.mult			= 0, /* to be set */
+	.shift			= 22,
+	.update_callback	= tsc_update_callback,
+	.is_continuous		= 1,
+};
+
+static int tsc_update_callback(void)
+{
+	int change = 0;
+
+	/* check to see if we should switch to the safe clocksource: */
+	if (clocksource_tsc.rating != 50 && check_tsc_unstable()) {
+		clocksource_tsc.rating = 50;
+		clocksource_reselect();
+		change = 1;
+	}
+	return change;
+}
+
+static int __init init_tsc_clocksource(void)
+{
+	if (!notsc) {
+		clocksource_tsc.mult = clocksource_khz2mult(cpu_khz,
+							clocksource_tsc.shift);
+		if (check_tsc_unstable())
+			clocksource_tsc.rating = 50;
+
+		return clocksource_register(&clocksource_tsc);
+	}
+	return 0;
+}
+
+module_init(init_tsc_clocksource);
Index: 2.6-mm/drivers/char/hangcheck-timer.c
===================================================================
--- 2.6-mm.orig/drivers/char/hangcheck-timer.c	2006-12-20 12:18:53.000000000 -0800
+++ 2.6-mm/drivers/char/hangcheck-timer.c	2006-12-20 12:24:10.000000000 -0800
@@ -117,7 +117,7 @@ __setup("hcheck_reboot", hangcheck_parse
 __setup("hcheck_dump_tasks", hangcheck_parse_dump_tasks);
 #endif /* not MODULE */
 
-#if defined(CONFIG_X86_64) || defined(CONFIG_S390)
+#if defined(CONFIG_S390)
 # define HAVE_MONOTONIC
 # define TIMER_FREQ 1000000000ULL
 #elif defined(CONFIG_IA64)
Index: 2.6-mm/include/asm-x86_64/proto.h
===================================================================
--- 2.6-mm.orig/include/asm-x86_64/proto.h	2006-12-20 12:19:27.000000000 -0800
+++ 2.6-mm/include/asm-x86_64/proto.h	2006-12-20 12:24:10.000000000 -0800
@@ -45,11 +45,9 @@ extern u32 pmtmr_ioport;
 #else
 #define pmtmr_ioport 0
 #endif
-extern unsigned long long monotonic_base;
 extern int sysctl_vsyscall;
 extern int nohpet;
 extern unsigned long vxtime_hz;
-extern void time_init_gtod(void);
 
 extern void early_printk(const char *fmt, ...) __attribute__((format(printf,1,2)));
 
Index: 2.6-mm/include/asm-x86_64/timex.h
===================================================================
--- 2.6-mm.orig/include/asm-x86_64/timex.h	2006-12-20 12:20:12.000000000 -0800
+++ 2.6-mm/include/asm-x86_64/timex.h	2006-12-20 12:24:10.000000000 -0800
@@ -52,9 +52,6 @@ extern int read_current_timer(unsigned l
 #define US_SCALE        32 /* 2^32, arbitralrily chosen */
 
 extern struct vxtime_data vxtime;
-
-extern unsigned int do_gettimeoffset_hpet(void);
-extern unsigned int do_gettimeoffset_tsc(void);
+extern void mark_tsc_unstable(void);
 extern void set_cyc2ns_scale(unsigned long khz);
-extern int notsc;
 #endif
