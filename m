Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422662AbWIGCTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422662AbWIGCTy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 22:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422657AbWIGCTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 22:19:36 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:63377 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422659AbWIGCTQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 22:19:16 -0400
Date: Wed, 6 Sep 2006 20:19:14 -0600
From: john stultz <johnstul@us.ibm.com>
To: ak@suse.de
Cc: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org
Message-Id: <20060907021851.31476.8111.sendpatchset@localhost>
In-Reply-To: <20060907021820.31476.17484.sendpatchset@localhost>
References: <20060907021820.31476.17484.sendpatchset@localhost>
Subject: [PATCH 5/6] x86_64: Clocksources for x86-64
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Break up HPET and TSC code into their own .c files.
Also add clocksource structures for both.

Signed-off-by: John Stultz <johnstul@us.ibm.com>

 arch/x86_64/kernel/Makefile |    2 
 arch/x86_64/kernel/hpet.c   |  469 +++++++++++++++++++++++++++++++++++++
 arch/x86_64/kernel/time.c   |  557 --------------------------------------------
 arch/x86_64/kernel/tsc.c    |  222 +++++++++++++++++
 include/asm-x86_64/hpet.h   |    6 
 include/asm-x86_64/timex.h  |    2 
 6 files changed, 705 insertions(+), 553 deletions(-)

linux-2.6.18-rc6_timeofday-arch-x86-64-part4_C6.patch
============================================
diff --git a/arch/x86_64/kernel/Makefile b/arch/x86_64/kernel/Makefile
index b5aaeaf..5834f49 100644
--- a/arch/x86_64/kernel/Makefile
+++ b/arch/x86_64/kernel/Makefile
@@ -8,7 +8,7 @@ obj-y	:= process.o signal.o entry.o trap
 		ptrace.o time.o ioport.o ldt.o setup.o i8259.o sys_x86_64.o \
 		x8664_ksyms.o i387.o syscall.o vsyscall.o \
 		setup64.o bootflag.o e820.o reboot.o quirks.o i8237.o \
-		pci-dma.o pci-nommu.o alternative.o
+		pci-dma.o pci-nommu.o alternative.o hpet.o tsc.o
 
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-$(CONFIG_X86_MCE)         += mce.o
diff --git a/arch/x86_64/kernel/hpet.c b/arch/x86_64/kernel/hpet.c
new file mode 100644
index 0000000..8ac58a8
--- /dev/null
+++ b/arch/x86_64/kernel/hpet.c
@@ -0,0 +1,469 @@
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/init.h>
+#include <linux/mc146818rtc.h>
+#include <linux/time.h>
+#include <linux/clocksource.h>
+#include <linux/ioport.h>
+#include <linux/acpi.h>
+#include <linux/hpet.h>
+#include <asm/timex.h>
+#include <asm/hpet.h>
+
+int nohpet __initdata = 0;
+
+unsigned long hpet_address;
+static unsigned long hpet_period;			/* fsecs / HPET clock */
+unsigned long hpet_tick;				/* HPET clocks / interrupt */
+int hpet_use_timer;				/* Use counter of hpet for time keeping, otherwise PIT */
+
+#define FSEC_PER_TICK (FSEC_PER_SEC / HZ)
+
+/*
+ * calibrate_tsc() calibrates the processor TSC in a very simple way, comparing
+ * it to the HPET timer of known frequency.
+ */
+
+#define TICK_COUNT 100000000
+
+unsigned int __init hpet_calibrate_tsc(void)
+{
+	int tsc_start, hpet_start;
+	int tsc_now, hpet_now;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	local_irq_disable();
+
+	hpet_start = hpet_readl(HPET_COUNTER);
+	rdtscl(tsc_start);
+
+	do {
+		local_irq_disable();
+		hpet_now = hpet_readl(HPET_COUNTER);
+		tsc_now = get_cycles_sync();
+		local_irq_restore(flags);
+	} while ((tsc_now - tsc_start) < TICK_COUNT &&
+		 (hpet_now - hpet_start) < TICK_COUNT);
+
+	return (tsc_now - tsc_start) * 1000000000L
+		/ ((hpet_now - hpet_start) * hpet_period / 1000);
+}
+
+
+
+#ifdef	CONFIG_HPET
+static __init int late_hpet_init(void)
+{
+	struct hpet_data	hd;
+	unsigned int 		ntimer;
+
+	if (!hpet_address)
+        	return 0;
+
+	memset(&hd, 0, sizeof (hd));
+
+	ntimer = hpet_readl(HPET_ID);
+	ntimer = (ntimer & HPET_ID_NUMBER) >> HPET_ID_NUMBER_SHIFT;
+	ntimer++;
+
+	/*
+	 * Register with driver.
+	 * Timer0 and Timer1 is used by platform.
+	 */
+	hd.hd_phys_address = hpet_address;
+	hd.hd_address = (void __iomem *)fix_to_virt(FIX_HPET_BASE);
+	hd.hd_nirqs = ntimer;
+	hd.hd_flags = HPET_DATA_PLATFORM;
+	hpet_reserve_timer(&hd, 0);
+#ifdef	CONFIG_HPET_EMULATE_RTC
+	hpet_reserve_timer(&hd, 1);
+#endif
+	hd.hd_irq[0] = HPET_LEGACY_8254;
+	hd.hd_irq[1] = HPET_LEGACY_RTC;
+	if (ntimer > 2) {
+		struct hpet		*hpet;
+		struct hpet_timer	*timer;
+		int			i;
+
+		hpet = (struct hpet *) fix_to_virt(FIX_HPET_BASE);
+		timer = &hpet->hpet_timers[2];
+		for (i = 2; i < ntimer; timer++, i++)
+			hd.hd_irq[i] = (timer->hpet_config &
+					Tn_INT_ROUTE_CNF_MASK) >>
+				Tn_INT_ROUTE_CNF_SHIFT;
+
+	}
+
+	hpet_alloc(&hd);
+	return 0;
+}
+fs_initcall(late_hpet_init);
+#endif
+
+static int hpet_timer_stop_set_go(unsigned long tick)
+{
+	unsigned int cfg;
+
+/*
+ * Stop the timers and reset the main counter.
+ */
+
+	cfg = hpet_readl(HPET_CFG);
+	cfg &= ~(HPET_CFG_ENABLE | HPET_CFG_LEGACY);
+	hpet_writel(cfg, HPET_CFG);
+	hpet_writel(0, HPET_COUNTER);
+	hpet_writel(0, HPET_COUNTER + 4);
+
+/*
+ * Set up timer 0, as periodic with first interrupt to happen at hpet_tick,
+ * and period also hpet_tick.
+ */
+	if (hpet_use_timer) {
+		hpet_writel(HPET_TN_ENABLE | HPET_TN_PERIODIC | HPET_TN_SETVAL |
+		    HPET_TN_32BIT, HPET_T0_CFG);
+		hpet_writel(hpet_tick, HPET_T0_CMP); /* next interrupt */
+		hpet_writel(hpet_tick, HPET_T0_CMP); /* period */
+		cfg |= HPET_CFG_LEGACY;
+	}
+/*
+ * Go!
+ */
+
+	cfg |= HPET_CFG_ENABLE;
+	hpet_writel(cfg, HPET_CFG);
+
+	return 0;
+}
+
+int hpet_arch_init(void)
+{
+	unsigned int id;
+
+	if (!hpet_address)
+		return -1;
+	set_fixmap_nocache(FIX_HPET_BASE, hpet_address);
+	__set_fixmap(VSYSCALL_HPET, hpet_address, PAGE_KERNEL_VSYSCALL_NOCACHE);
+
+/*
+ * Read the period, compute tick and quotient.
+ */
+
+	id = hpet_readl(HPET_ID);
+
+	if (!(id & HPET_ID_VENDOR) || !(id & HPET_ID_NUMBER))
+		return -1;
+
+	hpet_period = hpet_readl(HPET_PERIOD);
+	if (hpet_period < 100000 || hpet_period > 100000000)
+		return -1;
+
+	hpet_tick = (FSEC_PER_TICK + hpet_period / 2) / hpet_period;
+
+	hpet_use_timer = (id & HPET_ID_LEGSUP);
+
+	return hpet_timer_stop_set_go(hpet_tick);
+}
+
+int hpet_reenable(void)
+{
+	return hpet_timer_stop_set_go(hpet_tick);
+}
+
+int hpet_stop(void)
+{
+	return hpet_timer_stop_set_go(0);
+}
+
+#ifdef CONFIG_HPET_EMULATE_RTC
+/* HPET in LegacyReplacement Mode eats up RTC interrupt line. When, HPET
+ * is enabled, we support RTC interrupt functionality in software.
+ * RTC has 3 kinds of interrupts:
+ * 1) Update Interrupt - generate an interrupt, every sec, when RTC clock
+ *    is updated
+ * 2) Alarm Interrupt - generate an interrupt at a specific time of day
+ * 3) Periodic Interrupt - generate periodic interrupt, with frequencies
+ *    2Hz-8192Hz (2Hz-64Hz for non-root user) (all freqs in powers of 2)
+ * (1) and (2) above are implemented using polling at a frequency of
+ * 64 Hz. The exact frequency is a tradeoff between accuracy and interrupt
+ * overhead. (DEFAULT_RTC_INT_FREQ)
+ * For (3), we use interrupts at 64Hz or user specified periodic
+ * frequency, whichever is higher.
+ */
+#include <linux/rtc.h>
+
+#define DEFAULT_RTC_INT_FREQ 	64
+#define RTC_NUM_INTS 		1
+
+static unsigned long UIE_on;
+static unsigned long prev_update_sec;
+
+static unsigned long AIE_on;
+static struct rtc_time alarm_time;
+
+static unsigned long PIE_on;
+static unsigned long PIE_freq = DEFAULT_RTC_INT_FREQ;
+static unsigned long PIE_count;
+
+static unsigned long hpet_rtc_int_freq; /* RTC interrupt frequency */
+static unsigned int hpet_t1_cmp; /* cached comparator register */
+
+int is_hpet_enabled(void)
+{
+	return hpet_address != 0;
+}
+
+/*
+ * Timer 1 for RTC, we do not use periodic interrupt feature,
+ * even if HPET supports periodic interrupts on Timer 1.
+ * The reason being, to set up a periodic interrupt in HPET, we need to
+ * stop the main counter. And if we do that everytime someone diables/enables
+ * RTC, we will have adverse effect on main kernel timer running on Timer 0.
+ * So, for the time being, simulate the periodic interrupt in software.
+ *
+ * hpet_rtc_timer_init() is called for the first time and during subsequent
+ * interuppts reinit happens through hpet_rtc_timer_reinit().
+ */
+int hpet_rtc_timer_init(void)
+{
+	unsigned int cfg, cnt;
+	unsigned long flags;
+
+	if (!is_hpet_enabled())
+		return 0;
+	/*
+	 * Set the counter 1 and enable the interrupts.
+	 */
+	if (PIE_on && (PIE_freq > DEFAULT_RTC_INT_FREQ))
+		hpet_rtc_int_freq = PIE_freq;
+	else
+		hpet_rtc_int_freq = DEFAULT_RTC_INT_FREQ;
+
+	local_irq_save(flags);
+	cnt = hpet_readl(HPET_COUNTER);
+	cnt += ((hpet_tick*HZ)/hpet_rtc_int_freq);
+	hpet_writel(cnt, HPET_T1_CMP);
+	hpet_t1_cmp = cnt;
+	local_irq_restore(flags);
+
+	cfg = hpet_readl(HPET_T1_CFG);
+	cfg &= ~HPET_TN_PERIODIC;
+	cfg |= HPET_TN_ENABLE | HPET_TN_32BIT;
+	hpet_writel(cfg, HPET_T1_CFG);
+
+	return 1;
+}
+
+static void hpet_rtc_timer_reinit(void)
+{
+	unsigned int cfg, cnt;
+
+	if (unlikely(!(PIE_on | AIE_on | UIE_on))) {
+		cfg = hpet_readl(HPET_T1_CFG);
+		cfg &= ~HPET_TN_ENABLE;
+		hpet_writel(cfg, HPET_T1_CFG);
+		return;
+	}
+
+	if (PIE_on && (PIE_freq > DEFAULT_RTC_INT_FREQ))
+		hpet_rtc_int_freq = PIE_freq;
+	else
+		hpet_rtc_int_freq = DEFAULT_RTC_INT_FREQ;
+
+	/* It is more accurate to use the comparator value than current count.*/
+	cnt = hpet_t1_cmp;
+	cnt += hpet_tick*HZ/hpet_rtc_int_freq;
+	hpet_writel(cnt, HPET_T1_CMP);
+	hpet_t1_cmp = cnt;
+}
+
+/*
+ * The functions below are called from rtc driver.
+ * Return 0 if HPET is not being used.
+ * Otherwise do the necessary changes and return 1.
+ */
+int hpet_mask_rtc_irq_bit(unsigned long bit_mask)
+{
+	if (!is_hpet_enabled())
+		return 0;
+
+	if (bit_mask & RTC_UIE)
+		UIE_on = 0;
+	if (bit_mask & RTC_PIE)
+		PIE_on = 0;
+	if (bit_mask & RTC_AIE)
+		AIE_on = 0;
+
+	return 1;
+}
+
+int hpet_set_rtc_irq_bit(unsigned long bit_mask)
+{
+	int timer_init_reqd = 0;
+
+	if (!is_hpet_enabled())
+		return 0;
+
+	if (!(PIE_on | AIE_on | UIE_on))
+		timer_init_reqd = 1;
+
+	if (bit_mask & RTC_UIE) {
+		UIE_on = 1;
+	}
+	if (bit_mask & RTC_PIE) {
+		PIE_on = 1;
+		PIE_count = 0;
+	}
+	if (bit_mask & RTC_AIE) {
+		AIE_on = 1;
+	}
+
+	if (timer_init_reqd)
+		hpet_rtc_timer_init();
+
+	return 1;
+}
+
+int hpet_set_alarm_time(unsigned char hrs, unsigned char min, unsigned char sec)
+{
+	if (!is_hpet_enabled())
+		return 0;
+
+	alarm_time.tm_hour = hrs;
+	alarm_time.tm_min = min;
+	alarm_time.tm_sec = sec;
+
+	return 1;
+}
+
+int hpet_set_periodic_freq(unsigned long freq)
+{
+	if (!is_hpet_enabled())
+		return 0;
+
+	PIE_freq = freq;
+	PIE_count = 0;
+
+	return 1;
+}
+
+int hpet_rtc_dropped_irq(void)
+{
+	if (!is_hpet_enabled())
+		return 0;
+
+	return 1;
+}
+
+irqreturn_t hpet_rtc_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	struct rtc_time curr_time;
+	unsigned long rtc_int_flag = 0;
+	int call_rtc_interrupt = 0;
+
+	hpet_rtc_timer_reinit();
+
+	if (UIE_on | AIE_on) {
+		rtc_get_rtc_time(&curr_time);
+	}
+	if (UIE_on) {
+		if (curr_time.tm_sec != prev_update_sec) {
+			/* Set update int info, call real rtc int routine */
+			call_rtc_interrupt = 1;
+			rtc_int_flag = RTC_UF;
+			prev_update_sec = curr_time.tm_sec;
+		}
+	}
+	if (PIE_on) {
+		PIE_count++;
+		if (PIE_count >= hpet_rtc_int_freq/PIE_freq) {
+			/* Set periodic int info, call real rtc int routine */
+			call_rtc_interrupt = 1;
+			rtc_int_flag |= RTC_PF;
+			PIE_count = 0;
+		}
+	}
+	if (AIE_on) {
+		if ((curr_time.tm_sec == alarm_time.tm_sec) &&
+		    (curr_time.tm_min == alarm_time.tm_min) &&
+		    (curr_time.tm_hour == alarm_time.tm_hour)) {
+			/* Set alarm int info, call real rtc int routine */
+			call_rtc_interrupt = 1;
+			rtc_int_flag |= RTC_AF;
+		}
+	}
+	if (call_rtc_interrupt) {
+		rtc_int_flag |= (RTC_IRQF | (RTC_NUM_INTS << 8));
+		rtc_interrupt(rtc_int_flag, dev_id, regs);
+	}
+	return IRQ_HANDLED;
+}
+#endif
+
+static int __init nohpet_setup(char *s)
+{
+	nohpet = 1;
+	return 1;
+}
+
+__setup("nohpet", nohpet_setup);
+
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
diff --git a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
index d18230a..aafcd2f 100644
--- a/arch/x86_64/kernel/time.c
+++ b/arch/x86_64/kernel/time.c
@@ -39,6 +39,7 @@
 #include <asm/sections.h>
 #include <linux/cpufreq.h>
 #include <linux/hpet.h>
+#include <linux/clocksource.h>
 #ifdef CONFIG_X86_LOCAL_APIC
 #include <asm/apic.h>
 #endif
@@ -50,22 +51,10 @@ DEFINE_SPINLOCK(rtc_lock);
 EXPORT_SYMBOL(rtc_lock);
 DEFINE_SPINLOCK(i8253_lock);
 
-int nohpet __initdata = 0;
-static int notsc __initdata = 0;
-
 #define USEC_PER_TICK (USEC_PER_SEC / HZ)
 #define NSEC_PER_TICK (NSEC_PER_SEC / HZ)
-#define FSEC_PER_TICK (FSEC_PER_SEC / HZ)
 
-#define NS_SCALE	10 /* 2^10, carefully chosen */
-#define US_SCALE	32 /* 2^32, arbitralrily chosen */
 
-unsigned int cpu_khz;					/* TSC clocks / usec, not used here */
-EXPORT_SYMBOL(cpu_khz);
-unsigned long hpet_address;
-static unsigned long hpet_period;			/* fsecs / HPET clock */
-unsigned long hpet_tick;				/* HPET clocks / interrupt */
-int hpet_use_timer;				/* Use counter of hpet for time keeping, otherwise PIT */
 unsigned long vxtime_hz = PIT_TICK_RATE;
 int report_lost_ticks;				/* command line option */
 unsigned long long monotonic_base;
@@ -232,43 +221,6 @@ static irqreturn_t timer_interrupt(int i
 	return IRQ_HANDLED;
 }
 
-static unsigned int cyc2ns_scale __read_mostly;
-
-static inline void set_cyc2ns_scale(unsigned long cpu_khz)
-{
-	cyc2ns_scale = (NSEC_PER_MSEC << NS_SCALE) / cpu_khz;
-}
-
-static inline unsigned long long cycles_2_ns(unsigned long long cyc)
-{
-	return (cyc * cyc2ns_scale) >> NS_SCALE;
-}
-
-unsigned long long sched_clock(void)
-{
-	unsigned long a = 0;
-
-	/* Could do CPU core sync here. Opteron can execute rdtsc speculatively,
-	   which means it is not completely exact and may not be monotonous between
-	   CPUs. But the errors should be too small to matter for scheduling
-	   purposes. */
-
-	rdtscll(a);
-	return cycles_2_ns(a);
-}
-
-static int tsc_unstable;
-
-static inline int check_tsc_unstable(void)
-{
-	return tsc_unstable;
-}
-
-void mark_tsc_unstable(void)
-{
-	tsc_unstable = 1;
-}
-EXPORT_SYMBOL_GPL(mark_tsc_unstable);
 
 static unsigned long get_cmos_time(void)
 {
@@ -321,124 +273,6 @@ static unsigned long get_cmos_time(void)
 	return mktime(year, mon, day, hour, min, sec);
 }
 
-#ifdef CONFIG_CPU_FREQ
-
-/* Frequency scaling support. Adjust the TSC based timer when the cpu frequency
-   changes.
-   
-   RED-PEN: On SMP we assume all CPUs run with the same frequency.  It's
-   not that important because current Opteron setups do not support
-   scaling on SMP anyroads.
-
-   Should fix up last_tsc too. Currently gettimeofday in the
-   first tick after the change will be slightly wrong. */
-
-#include <linux/workqueue.h>
-
-static unsigned int cpufreq_delayed_issched = 0;
-static unsigned int cpufreq_init = 0;
-static struct work_struct cpufreq_delayed_get_work;
-
-static void handle_cpufreq_delayed_get(void *v)
-{
-	unsigned int cpu;
-	for_each_online_cpu(cpu) {
-		cpufreq_get(cpu);
-	}
-	cpufreq_delayed_issched = 0;
-}
-
-static unsigned int  ref_freq = 0;
-static unsigned long loops_per_jiffy_ref = 0;
-
-static unsigned long cpu_khz_ref = 0;
-
-static int time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
-				 void *data)
-{
-        struct cpufreq_freqs *freq = data;
-	unsigned long *lpj, dummy;
-
-	if (cpu_has(&cpu_data[freq->cpu], X86_FEATURE_CONSTANT_TSC))
-		return 0;
-
-	lpj = &dummy;
-	if (!(freq->flags & CPUFREQ_CONST_LOOPS))
-#ifdef CONFIG_SMP
-		lpj = &cpu_data[freq->cpu].loops_per_jiffy;
-#else
-		lpj = &boot_cpu_data.loops_per_jiffy;
-#endif
-
-	if (!ref_freq) {
-		ref_freq = freq->old;
-		loops_per_jiffy_ref = *lpj;
-		cpu_khz_ref = cpu_khz;
-	}
-        if ((val == CPUFREQ_PRECHANGE  && freq->old < freq->new) ||
-            (val == CPUFREQ_POSTCHANGE && freq->old > freq->new) ||
-	    (val == CPUFREQ_RESUMECHANGE)) {
-                *lpj =
-		cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
-
-		cpu_khz = cpufreq_scale(cpu_khz_ref, ref_freq, freq->new);
-		if (!(freq->flags & CPUFREQ_CONST_LOOPS))
-			vxtime.tsc_quot = (USEC_PER_MSEC << US_SCALE) / cpu_khz;
-	}
-	
-	set_cyc2ns_scale(cpu_khz_ref);
-
-	return 0;
-}
- 
-static struct notifier_block time_cpufreq_notifier_block = {
-         .notifier_call  = time_cpufreq_notifier
-};
-
-static int __init cpufreq_tsc(void)
-{
-	INIT_WORK(&cpufreq_delayed_get_work, handle_cpufreq_delayed_get, NULL);
-	if (!cpufreq_register_notifier(&time_cpufreq_notifier_block,
-				       CPUFREQ_TRANSITION_NOTIFIER))
-		cpufreq_init = 1;
-	return 0;
-}
-
-core_initcall(cpufreq_tsc);
-
-#endif
-
-/*
- * calibrate_tsc() calibrates the processor TSC in a very simple way, comparing
- * it to the HPET timer of known frequency.
- */
-
-#define TICK_COUNT 100000000
-
-static unsigned int __init hpet_calibrate_tsc(void)
-{
-	int tsc_start, hpet_start;
-	int tsc_now, hpet_now;
-	unsigned long flags;
-
-	local_irq_save(flags);
-	local_irq_disable();
-
-	hpet_start = hpet_readl(HPET_COUNTER);
-	rdtscl(tsc_start);
-
-	do {
-		local_irq_disable();
-		hpet_now = hpet_readl(HPET_COUNTER);
-		tsc_now = get_cycles_sync();
-		local_irq_restore(flags);
-	} while ((tsc_now - tsc_start) < TICK_COUNT &&
-		 (hpet_now - hpet_start) < TICK_COUNT);
-
-	return (tsc_now - tsc_start) * 1000000000L
-		/ ((hpet_now - hpet_start) * hpet_period / 1000);
-}
-
 
 /*
  * pit_calibrate_tsc() uses the speaker output (channel 2) of
@@ -469,124 +303,6 @@ static unsigned int __init pit_calibrate
 	return (end - start) / 50;
 }
 
-#ifdef	CONFIG_HPET
-static __init int late_hpet_init(void)
-{
-	struct hpet_data	hd;
-	unsigned int 		ntimer;
-
-	if (!hpet_address)
-        	return 0;
-
-	memset(&hd, 0, sizeof (hd));
-
-	ntimer = hpet_readl(HPET_ID);
-	ntimer = (ntimer & HPET_ID_NUMBER) >> HPET_ID_NUMBER_SHIFT;
-	ntimer++;
-
-	/*
-	 * Register with driver.
-	 * Timer0 and Timer1 is used by platform.
-	 */
-	hd.hd_phys_address = hpet_address;
-	hd.hd_address = (void __iomem *)fix_to_virt(FIX_HPET_BASE);
-	hd.hd_nirqs = ntimer;
-	hd.hd_flags = HPET_DATA_PLATFORM;
-	hpet_reserve_timer(&hd, 0);
-#ifdef	CONFIG_HPET_EMULATE_RTC
-	hpet_reserve_timer(&hd, 1);
-#endif
-	hd.hd_irq[0] = HPET_LEGACY_8254;
-	hd.hd_irq[1] = HPET_LEGACY_RTC;
-	if (ntimer > 2) {
-		struct hpet		*hpet;
-		struct hpet_timer	*timer;
-		int			i;
-
-		hpet = (struct hpet *) fix_to_virt(FIX_HPET_BASE);
-		timer = &hpet->hpet_timers[2];
-		for (i = 2; i < ntimer; timer++, i++)
-			hd.hd_irq[i] = (timer->hpet_config &
-					Tn_INT_ROUTE_CNF_MASK) >>
-				Tn_INT_ROUTE_CNF_SHIFT;
-
-	}
-
-	hpet_alloc(&hd);
-	return 0;
-}
-fs_initcall(late_hpet_init);
-#endif
-
-static int hpet_timer_stop_set_go(unsigned long tick)
-{
-	unsigned int cfg;
-
-/*
- * Stop the timers and reset the main counter.
- */
-
-	cfg = hpet_readl(HPET_CFG);
-	cfg &= ~(HPET_CFG_ENABLE | HPET_CFG_LEGACY);
-	hpet_writel(cfg, HPET_CFG);
-	hpet_writel(0, HPET_COUNTER);
-	hpet_writel(0, HPET_COUNTER + 4);
-
-/*
- * Set up timer 0, as periodic with first interrupt to happen at hpet_tick,
- * and period also hpet_tick.
- */
-	if (hpet_use_timer) {
-		hpet_writel(HPET_TN_ENABLE | HPET_TN_PERIODIC | HPET_TN_SETVAL |
-		    HPET_TN_32BIT, HPET_T0_CFG);
-		hpet_writel(hpet_tick, HPET_T0_CMP); /* next interrupt */
-		hpet_writel(hpet_tick, HPET_T0_CMP); /* period */
-		cfg |= HPET_CFG_LEGACY;
-	}
-/*
- * Go!
- */
-
-	cfg |= HPET_CFG_ENABLE;
-	hpet_writel(cfg, HPET_CFG);
-
-	return 0;
-}
-
-static int hpet_init(void)
-{
-	unsigned int id;
-
-	if (!hpet_address)
-		return -1;
-	set_fixmap_nocache(FIX_HPET_BASE, hpet_address);
-	__set_fixmap(VSYSCALL_HPET, hpet_address, PAGE_KERNEL_VSYSCALL_NOCACHE);
-
-/*
- * Read the period, compute tick and quotient.
- */
-
-	id = hpet_readl(HPET_ID);
-
-	if (!(id & HPET_ID_VENDOR) || !(id & HPET_ID_NUMBER))
-		return -1;
-
-	hpet_period = hpet_readl(HPET_PERIOD);
-	if (hpet_period < 100000 || hpet_period > 100000000)
-		return -1;
-
-	hpet_tick = (FSEC_PER_TICK + hpet_period / 2) / hpet_period;
-
-	hpet_use_timer = (id & HPET_ID_LEGSUP);
-
-	return hpet_timer_stop_set_go(hpet_tick);
-}
-
-static int hpet_reenable(void)
-{
-	return hpet_timer_stop_set_go(hpet_tick);
-}
-
 #define PIT_MODE 0x43
 #define PIT_CH0  0x40
 
@@ -616,7 +332,7 @@ void __init stop_timer_interrupt(void)
 	char *name;
 	if (hpet_address) {
 		name = "HPET";
-		hpet_timer_stop_set_go(0);
+		hpet_stop();
 	} else {
 		name = "PIT";
 		pit_stop_interrupt();
@@ -646,7 +362,7 @@ void __init time_init(void)
 	set_normalized_timespec(&wall_to_monotonic,
 	                        -xtime.tv_sec, -xtime.tv_nsec);
 
-	if (hpet_init())
+	if (hpet_arch_init())
 		hpet_address = 0;
 
 	if (hpet_use_timer) {
@@ -660,6 +376,9 @@ void __init time_init(void)
 		timename = "PIT";
 	}
 
+	if (unsynchronized_tsc())
+		mark_tsc_unstable();
+
 	printk(KERN_INFO "time.c: Detected %d.%03d MHz processor.\n",
 		cpu_khz / 1000, cpu_khz % 1000);
 	setup_irq(0, &irq0);
@@ -667,30 +386,6 @@ void __init time_init(void)
 	set_cyc2ns_scale(cpu_khz);
 }
 
-/*
- * Make an educated guess if the TSC is trustworthy and synchronized
- * over all CPUs.
- */
-__cpuinit int unsynchronized_tsc(void)
-{
-#ifdef CONFIG_SMP
-	if (apic_is_clustered_box())
-		return 1;
-#endif
-	/* Most intel systems have synchronized TSCs except for
-	   multi node systems */
- 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) {
-#ifdef CONFIG_ACPI
-		/* But TSC doesn't tick in C3 so don't use it there */
-		if (acpi_fadt.length > 0 && acpi_fadt.plvl3_lat < 100)
-			return 1;
-#endif
- 		return 0;
-	}
-
- 	/* Assume multi socket systems are not synchronized */
- 	return num_present_cpus() > 1;
-}
 
 __setup("report_lost_ticks", time_setup);
 
@@ -759,243 +454,3 @@ static int time_init_device(void)
 
 device_initcall(time_init_device);
 
-#ifdef CONFIG_HPET_EMULATE_RTC
-/* HPET in LegacyReplacement Mode eats up RTC interrupt line. When, HPET
- * is enabled, we support RTC interrupt functionality in software.
- * RTC has 3 kinds of interrupts:
- * 1) Update Interrupt - generate an interrupt, every sec, when RTC clock
- *    is updated
- * 2) Alarm Interrupt - generate an interrupt at a specific time of day
- * 3) Periodic Interrupt - generate periodic interrupt, with frequencies
- *    2Hz-8192Hz (2Hz-64Hz for non-root user) (all freqs in powers of 2)
- * (1) and (2) above are implemented using polling at a frequency of
- * 64 Hz. The exact frequency is a tradeoff between accuracy and interrupt
- * overhead. (DEFAULT_RTC_INT_FREQ)
- * For (3), we use interrupts at 64Hz or user specified periodic
- * frequency, whichever is higher.
- */
-#include <linux/rtc.h>
-
-#define DEFAULT_RTC_INT_FREQ 	64
-#define RTC_NUM_INTS 		1
-
-static unsigned long UIE_on;
-static unsigned long prev_update_sec;
-
-static unsigned long AIE_on;
-static struct rtc_time alarm_time;
-
-static unsigned long PIE_on;
-static unsigned long PIE_freq = DEFAULT_RTC_INT_FREQ;
-static unsigned long PIE_count;
-
-static unsigned long hpet_rtc_int_freq; /* RTC interrupt frequency */
-static unsigned int hpet_t1_cmp; /* cached comparator register */
-
-int is_hpet_enabled(void)
-{
-	return hpet_address != 0;
-}
-
-/*
- * Timer 1 for RTC, we do not use periodic interrupt feature,
- * even if HPET supports periodic interrupts on Timer 1.
- * The reason being, to set up a periodic interrupt in HPET, we need to
- * stop the main counter. And if we do that everytime someone diables/enables
- * RTC, we will have adverse effect on main kernel timer running on Timer 0.
- * So, for the time being, simulate the periodic interrupt in software.
- *
- * hpet_rtc_timer_init() is called for the first time and during subsequent
- * interuppts reinit happens through hpet_rtc_timer_reinit().
- */
-int hpet_rtc_timer_init(void)
-{
-	unsigned int cfg, cnt;
-	unsigned long flags;
-
-	if (!is_hpet_enabled())
-		return 0;
-	/*
-	 * Set the counter 1 and enable the interrupts.
-	 */
-	if (PIE_on && (PIE_freq > DEFAULT_RTC_INT_FREQ))
-		hpet_rtc_int_freq = PIE_freq;
-	else
-		hpet_rtc_int_freq = DEFAULT_RTC_INT_FREQ;
-
-	local_irq_save(flags);
-	cnt = hpet_readl(HPET_COUNTER);
-	cnt += ((hpet_tick*HZ)/hpet_rtc_int_freq);
-	hpet_writel(cnt, HPET_T1_CMP);
-	hpet_t1_cmp = cnt;
-	local_irq_restore(flags);
-
-	cfg = hpet_readl(HPET_T1_CFG);
-	cfg &= ~HPET_TN_PERIODIC;
-	cfg |= HPET_TN_ENABLE | HPET_TN_32BIT;
-	hpet_writel(cfg, HPET_T1_CFG);
-
-	return 1;
-}
-
-static void hpet_rtc_timer_reinit(void)
-{
-	unsigned int cfg, cnt;
-
-	if (unlikely(!(PIE_on | AIE_on | UIE_on))) {
-		cfg = hpet_readl(HPET_T1_CFG);
-		cfg &= ~HPET_TN_ENABLE;
-		hpet_writel(cfg, HPET_T1_CFG);
-		return;
-	}
-
-	if (PIE_on && (PIE_freq > DEFAULT_RTC_INT_FREQ))
-		hpet_rtc_int_freq = PIE_freq;
-	else
-		hpet_rtc_int_freq = DEFAULT_RTC_INT_FREQ;
-
-	/* It is more accurate to use the comparator value than current count.*/
-	cnt = hpet_t1_cmp;
-	cnt += hpet_tick*HZ/hpet_rtc_int_freq;
-	hpet_writel(cnt, HPET_T1_CMP);
-	hpet_t1_cmp = cnt;
-}
-
-/*
- * The functions below are called from rtc driver.
- * Return 0 if HPET is not being used.
- * Otherwise do the necessary changes and return 1.
- */
-int hpet_mask_rtc_irq_bit(unsigned long bit_mask)
-{
-	if (!is_hpet_enabled())
-		return 0;
-
-	if (bit_mask & RTC_UIE)
-		UIE_on = 0;
-	if (bit_mask & RTC_PIE)
-		PIE_on = 0;
-	if (bit_mask & RTC_AIE)
-		AIE_on = 0;
-
-	return 1;
-}
-
-int hpet_set_rtc_irq_bit(unsigned long bit_mask)
-{
-	int timer_init_reqd = 0;
-
-	if (!is_hpet_enabled())
-		return 0;
-
-	if (!(PIE_on | AIE_on | UIE_on))
-		timer_init_reqd = 1;
-
-	if (bit_mask & RTC_UIE) {
-		UIE_on = 1;
-	}
-	if (bit_mask & RTC_PIE) {
-		PIE_on = 1;
-		PIE_count = 0;
-	}
-	if (bit_mask & RTC_AIE) {
-		AIE_on = 1;
-	}
-
-	if (timer_init_reqd)
-		hpet_rtc_timer_init();
-
-	return 1;
-}
-
-int hpet_set_alarm_time(unsigned char hrs, unsigned char min, unsigned char sec)
-{
-	if (!is_hpet_enabled())
-		return 0;
-
-	alarm_time.tm_hour = hrs;
-	alarm_time.tm_min = min;
-	alarm_time.tm_sec = sec;
-
-	return 1;
-}
-
-int hpet_set_periodic_freq(unsigned long freq)
-{
-	if (!is_hpet_enabled())
-		return 0;
-
-	PIE_freq = freq;
-	PIE_count = 0;
-
-	return 1;
-}
-
-int hpet_rtc_dropped_irq(void)
-{
-	if (!is_hpet_enabled())
-		return 0;
-
-	return 1;
-}
-
-irqreturn_t hpet_rtc_interrupt(int irq, void *dev_id, struct pt_regs *regs)
-{
-	struct rtc_time curr_time;
-	unsigned long rtc_int_flag = 0;
-	int call_rtc_interrupt = 0;
-
-	hpet_rtc_timer_reinit();
-
-	if (UIE_on | AIE_on) {
-		rtc_get_rtc_time(&curr_time);
-	}
-	if (UIE_on) {
-		if (curr_time.tm_sec != prev_update_sec) {
-			/* Set update int info, call real rtc int routine */
-			call_rtc_interrupt = 1;
-			rtc_int_flag = RTC_UF;
-			prev_update_sec = curr_time.tm_sec;
-		}
-	}
-	if (PIE_on) {
-		PIE_count++;
-		if (PIE_count >= hpet_rtc_int_freq/PIE_freq) {
-			/* Set periodic int info, call real rtc int routine */
-			call_rtc_interrupt = 1;
-			rtc_int_flag |= RTC_PF;
-			PIE_count = 0;
-		}
-	}
-	if (AIE_on) {
-		if ((curr_time.tm_sec == alarm_time.tm_sec) &&
-		    (curr_time.tm_min == alarm_time.tm_min) &&
-		    (curr_time.tm_hour == alarm_time.tm_hour)) {
-			/* Set alarm int info, call real rtc int routine */
-			call_rtc_interrupt = 1;
-			rtc_int_flag |= RTC_AF;
-		}
-	}
-	if (call_rtc_interrupt) {
-		rtc_int_flag |= (RTC_IRQF | (RTC_NUM_INTS << 8));
-		rtc_interrupt(rtc_int_flag, dev_id, regs);
-	}
-	return IRQ_HANDLED;
-}
-#endif
-
-static int __init nohpet_setup(char *s) 
-{ 
-	nohpet = 1;
-	return 1;
-} 
-
-__setup("nohpet", nohpet_setup);
-
-int __init notsc_setup(char *s)
-{
-	notsc = 1;
-	return 1;
-}
-
-__setup("notsc", notsc_setup);
diff --git a/arch/x86_64/kernel/tsc.c b/arch/x86_64/kernel/tsc.c
new file mode 100644
index 0000000..f662183
--- /dev/null
+++ b/arch/x86_64/kernel/tsc.c
@@ -0,0 +1,222 @@
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/clocksource.h>
+#include <linux/time.h>
+#include <linux/acpi.h>
+#include <linux/cpufreq.h>
+
+#include <asm/timex.h>
+
+#define NS_SCALE	10 /* 2^10, carefully chosen */
+#define US_SCALE	32 /* 2^32, arbitralrily chosen */
+
+static int notsc __initdata = 0;
+
+unsigned int cpu_khz;					/* TSC clocks / usec, not used here */
+EXPORT_SYMBOL(cpu_khz);
+
+static unsigned int cyc2ns_scale __read_mostly;
+
+void set_cyc2ns_scale(unsigned long khz)
+{
+	cyc2ns_scale = (NSEC_PER_MSEC << NS_SCALE) / khz;
+}
+
+static inline unsigned long long cycles_2_ns(unsigned long long cyc)
+{
+	return (cyc * cyc2ns_scale) >> NS_SCALE;
+}
+
+unsigned long long sched_clock(void)
+{
+	unsigned long a = 0;
+
+	/* Could do CPU core sync here. Opteron can execute rdtsc speculatively,
+	   which means it is not completely exact and may not be monotonous between
+	   CPUs. But the errors should be too small to matter for scheduling
+	   purposes. */
+
+	rdtscll(a);
+	return cycles_2_ns(a);
+}
+
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
+#ifdef CONFIG_CPU_FREQ
+
+/* Frequency scaling support. Adjust the TSC based timer when the cpu frequency
+   changes.
+
+   RED-PEN: On SMP we assume all CPUs run with the same frequency.  It's
+   not that important because current Opteron setups do not support
+   scaling on SMP anyroads.
+
+   Should fix up last_tsc too. Currently gettimeofday in the
+   first tick after the change will be slightly wrong. */
+
+#include <linux/workqueue.h>
+
+static unsigned int cpufreq_delayed_issched = 0;
+static unsigned int cpufreq_init = 0;
+static struct work_struct cpufreq_delayed_get_work;
+
+static void handle_cpufreq_delayed_get(void *v)
+{
+	unsigned int cpu;
+	for_each_online_cpu(cpu) {
+		cpufreq_get(cpu);
+	}
+	cpufreq_delayed_issched = 0;
+}
+
+static unsigned int  ref_freq = 0;
+static unsigned long loops_per_jiffy_ref = 0;
+
+static unsigned long cpu_khz_ref = 0;
+
+static int time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
+				 void *data)
+{
+        struct cpufreq_freqs *freq = data;
+	unsigned long *lpj, dummy;
+
+	if (cpu_has(&cpu_data[freq->cpu], X86_FEATURE_CONSTANT_TSC))
+		return 0;
+
+	lpj = &dummy;
+	if (!(freq->flags & CPUFREQ_CONST_LOOPS))
+#ifdef CONFIG_SMP
+		lpj = &cpu_data[freq->cpu].loops_per_jiffy;
+#else
+		lpj = &boot_cpu_data.loops_per_jiffy;
+#endif
+
+	if (!ref_freq) {
+		ref_freq = freq->old;
+		loops_per_jiffy_ref = *lpj;
+		cpu_khz_ref = cpu_khz;
+	}
+        if ((val == CPUFREQ_PRECHANGE  && freq->old < freq->new) ||
+            (val == CPUFREQ_POSTCHANGE && freq->old > freq->new) ||
+	    (val == CPUFREQ_RESUMECHANGE)) {
+                *lpj =
+		cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
+
+		cpu_khz = cpufreq_scale(cpu_khz_ref, ref_freq, freq->new);
+		if (!(freq->flags & CPUFREQ_CONST_LOOPS))
+			mark_tsc_unstable();
+	}
+
+	set_cyc2ns_scale(cpu_khz_ref);
+
+	return 0;
+}
+
+static struct notifier_block time_cpufreq_notifier_block = {
+	.notifier_call  = time_cpufreq_notifier
+};
+
+static int __init cpufreq_tsc(void)
+{
+	INIT_WORK(&cpufreq_delayed_get_work, handle_cpufreq_delayed_get, NULL);
+	if (!cpufreq_register_notifier(&time_cpufreq_notifier_block,
+				       CPUFREQ_TRANSITION_NOTIFIER))
+		cpufreq_init = 1;
+	return 0;
+}
+
+core_initcall(cpufreq_tsc);
+
+#endif
+/*
+ * Make an educated guess if the TSC is trustworthy and synchronized
+ * over all CPUs.
+ */
+__cpuinit int unsynchronized_tsc(void)
+{
+#ifdef CONFIG_SMP
+	if (apic_is_clustered_box())
+		return 1;
+#endif
+	/* Most intel systems have synchronized TSCs except for
+	   multi node systems */
+ 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) {
+#ifdef CONFIG_ACPI
+		/* But TSC doesn't tick in C3 so don't use it there */
+		if (acpi_fadt.length > 0 && acpi_fadt.plvl3_lat < 100)
+			return 1;
+#endif
+ 		return 0;
+	}
+
+ 	/* Assume multi socket systems are not synchronized */
+ 	return num_present_cpus() > 1;
+}
+
+int __init notsc_setup(char *s)
+{
+	notsc = 1;
+	return 1;
+}
+
+__setup("notsc", notsc_setup);
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
+		return clocksource_register(&clocksource_tsc);
+	}
+	return 0;
+}
+
+module_init(init_tsc_clocksource);
diff --git a/include/asm-x86_64/hpet.h b/include/asm-x86_64/hpet.h
index 60d5127..c10d4e4 100644
--- a/include/asm-x86_64/hpet.h
+++ b/include/asm-x86_64/hpet.h
@@ -60,6 +60,12 @@ extern int apic_is_clustered_box(void);
 extern int hpet_use_timer;
 extern unsigned long hpet_address;
 
+extern int hpet_reenable(void);
+extern int hpet_arch_init(void);
+extern int hpet_stop(void);
+extern unsigned int hpet_calibrate_tsc(void);
+
+
 #ifdef CONFIG_HPET_EMULATE_RTC
 extern int hpet_mask_rtc_irq_bit(unsigned long bit_mask);
 extern int hpet_set_rtc_irq_bit(unsigned long bit_mask);
diff --git a/include/asm-x86_64/timex.h b/include/asm-x86_64/timex.h
index 40167eb..c5165cd 100644
--- a/include/asm-x86_64/timex.h
+++ b/include/asm-x86_64/timex.h
@@ -42,7 +42,7 @@ static __always_inline cycles_t get_cycl
 extern unsigned int cpu_khz;
 
 extern void mark_tsc_unstable(void);
-
+extern void set_cyc2ns_scale(unsigned long khz);
 extern int read_current_timer(unsigned long *timer_value);
 #define ARCH_HAS_READ_CURRENT_TIMER	1
 
