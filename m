Return-Path: <linux-kernel-owner+w=401wt.eu-S932903AbWLTBVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932903AbWLTBVL (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 20:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932897AbWLTBVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 20:21:10 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:45407 "EHLO e1.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932850AbWLTBU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 20:20:59 -0500
Date: Tue, 19 Dec 2006 20:20:57 -0500
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
Cc: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, mingo@elte.hu
Message-Id: <20061220011724.25341.59089.sendpatchset@localhost>
In-Reply-To: <20061220011707.25341.6522.sendpatchset@localhost>
References: <20061220011707.25341.6522.sendpatchset@localhost>
Subject: [PATCH 3/5][time][x86_64] Split x86_64/kernel/time.c up
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for the x86_64 generic time conversion, this patch 
splits out TSC and HPET related code from arch/x86_64/kernel/time.c 
into respective hpet.c and tsc.c files.

Signed-off-by: John Stultz <johnstul@us.ibm.com>

 arch/x86_64/kernel/Makefile |    2 
 arch/x86_64/kernel/hpet.c   |  437 ++++++++++++++++++++++++++++++
 arch/x86_64/kernel/time.c   |  628 --------------------------------------------
 arch/x86_64/kernel/tsc.c    |  201 ++++++++++++++
 include/asm-x86_64/hpet.h   |    6 
 include/asm-x86_64/timex.h  |   11 
 6 files changed, 660 insertions(+), 625 deletions(-)

linux-2.6.20-rc1_timeofday-arch-x86-64-split-hpet-tsc-time_C7.patch
============================================
diff --git a/arch/x86_64/kernel/Makefile b/arch/x86_64/kernel/Makefile
index 3c7cbff..e68a87e 100644
--- a/arch/x86_64/kernel/Makefile
+++ b/arch/x86_64/kernel/Makefile
@@ -8,7 +8,7 @@ obj-y	:= process.o signal.o entry.o trap
 		ptrace.o time.o ioport.o ldt.o setup.o i8259.o sys_x86_64.o \
 		x8664_ksyms.o i387.o syscall.o vsyscall.o \
 		setup64.o bootflag.o e820.o reboot.o quirks.o i8237.o \
-		pci-dma.o pci-nommu.o alternative.o
+		pci-dma.o pci-nommu.o alternative.o hpet.o tsc.o
 
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-$(CONFIG_X86_MCE)		+= mce.o therm_throt.o
diff --git a/arch/x86_64/kernel/hpet.c b/arch/x86_64/kernel/hpet.c
new file mode 100644
index 0000000..ad67c6b
--- /dev/null
+++ b/arch/x86_64/kernel/hpet.c
@@ -0,0 +1,437 @@
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/init.h>
+#include <linux/mc146818rtc.h>
+#include <linux/time.h>
+#include <linux/clocksource.h>
+#include <linux/ioport.h>
+#include <linux/acpi.h>
+#include <linux/hpet.h>
+#include <asm/pgtable.h>
+#include <asm/vsyscall.h>
+#include <asm/timex.h>
+#include <asm/hpet.h>
+
+int nohpet __initdata = 0;
+
+unsigned long hpet_address;
+unsigned long hpet_period;	/* fsecs / HPET clock */
+unsigned long hpet_tick;	/* HPET clocks / interrupt */
+
+int hpet_use_timer;		/* Use counter of hpet for time keeping,
+				 * otherwise PIT
+				 */
+unsigned int do_gettimeoffset_hpet(void)
+{
+	/* cap counter read to one tick to avoid inconsistencies */
+	unsigned long counter = hpet_readl(HPET_COUNTER) - vxtime.last;
+	return (min(counter,hpet_tick) * vxtime.quot) >> US_SCALE;
+}
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
+int hpet_timer_stop_set_go(unsigned long tick)
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
+		(hpet_now - hpet_start) < TICK_COUNT);
+
+	return (tsc_now - tsc_start) * 1000000000L
+		/ ((hpet_now - hpet_start) * hpet_period / 1000);
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
+
+	cnt = hpet_readl(HPET_COUNTER);
+	cnt += ((hpet_tick*HZ)/hpet_rtc_int_freq);
+	hpet_writel(cnt, HPET_T1_CMP);
+	hpet_t1_cmp = cnt;
+
+	cfg = hpet_readl(HPET_T1_CFG);
+	cfg &= ~HPET_TN_PERIODIC;
+	cfg |= HPET_TN_ENABLE | HPET_TN_32BIT;
+	hpet_writel(cfg, HPET_T1_CFG);
+
+	local_irq_restore(flags);
+
+	return 1;
+}
+
+static void hpet_rtc_timer_reinit(void)
+{
+	unsigned int cfg, cnt, ticks_per_int, lost_ints;
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
+	ticks_per_int = hpet_tick * HZ / hpet_rtc_int_freq;
+	hpet_t1_cmp += ticks_per_int;
+	hpet_writel(hpet_t1_cmp, HPET_T1_CMP);
+
+	/*
+	 * If the interrupt handler was delayed too long, the write above tries
+	 * to schedule the next interrupt in the past and the hardware would
+	 * not interrupt until the counter had wrapped around.
+	 * So we have to check that the comparator wasn't set to a past time.
+	 */
+	cnt = hpet_readl(HPET_COUNTER);
+	if (unlikely((int)(cnt - hpet_t1_cmp) > 0)) {
+		lost_ints = (cnt - hpet_t1_cmp) / ticks_per_int + 1;
+		/* Make sure that, even with the time needed to execute
+		 * this code, the next scheduled interrupt has been moved
+		 * back to the future: */
+		lost_ints++;
+
+		hpet_t1_cmp += lost_ints * ticks_per_int;
+		hpet_writel(hpet_t1_cmp, HPET_T1_CMP);
+
+		if (PIE_on)
+			PIE_count += lost_ints;
+
+		printk(KERN_WARNING "rtc: lost some interrupts at %ldHz.\n",
+		       hpet_rtc_int_freq);
+	}
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
+		rtc_interrupt(rtc_int_flag, dev_id);
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
diff --git a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
index af9b072..164ba5f 100644
--- a/arch/x86_64/kernel/time.c
+++ b/arch/x86_64/kernel/time.c
@@ -42,9 +42,10 @@ #include <asm/sections.h>
 #include <linux/cpufreq.h>
 #include <linux/hpet.h>
 #include <asm/apic.h>
+#include <asm/hpet.h>
 
 #ifdef CONFIG_CPU_FREQ
-static void cpufreq_delayed_get(void);
+extern void cpufreq_delayed_get(void);
 #endif
 extern void i8254_timer_resume(void);
 extern int using_apic_timer;
@@ -55,22 +56,6 @@ DEFINE_SPINLOCK(rtc_lock);
 EXPORT_SYMBOL(rtc_lock);
 DEFINE_SPINLOCK(i8253_lock);
 
-int nohpet __initdata = 0;
-static int notsc __initdata = 0;
-
-#define USEC_PER_TICK (USEC_PER_SEC / HZ)
-#define NSEC_PER_TICK (NSEC_PER_SEC / HZ)
-#define FSEC_PER_TICK (FSEC_PER_SEC / HZ)
-
-#define NS_SCALE	10 /* 2^10, carefully chosen */
-#define US_SCALE	32 /* 2^32, arbitralrily chosen */
-
-unsigned int cpu_khz;					/* TSC clocks / usec, not used here */
-EXPORT_SYMBOL(cpu_khz);
-unsigned long hpet_address;
-static unsigned long hpet_period;			/* fsecs / HPET clock */
-unsigned long hpet_tick;				/* HPET clocks / interrupt */
-int hpet_use_timer;				/* Use counter of hpet for time keeping, otherwise PIT */
 unsigned long vxtime_hz = PIT_TICK_RATE;
 int report_lost_ticks;				/* command line option */
 unsigned long long monotonic_base;
@@ -81,34 +66,6 @@ volatile unsigned long __jiffies __secti
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
 unsigned int (*do_gettimeoffset)(void) = do_gettimeoffset_tsc;
 
 /*
@@ -272,7 +229,7 @@ static void set_rtc_mmss(unsigned long n
  *		Note: This function is required to return accurate
  *		time even in the absence of multiple timer ticks.
  */
-static inline unsigned long long cycles_2_ns(unsigned long long cyc);
+extern unsigned long long cycles_2_ns(unsigned long long cyc);
 unsigned long long monotonic_clock(void)
 {
 	unsigned long seq;
@@ -462,40 +419,6 @@ static irqreturn_t timer_interrupt(int i
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
-#if 0
-	/* Don't do a HPET read here. Using TSC always is much faster
-	   and HPET may not be mapped yet when the scheduler first runs.
-           Disadvantage is a small drift between CPUs in some configurations,
-	   but that should be tolerable. */
-	if (__vxtime.mode == VXTIME_HPET)
-		return (hpet_readl(HPET_COUNTER) * vxtime.quot) >> US_SCALE;
-#endif
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
 static unsigned long get_cmos_time(void)
 {
 	unsigned int year, mon, day, hour, min, sec;
@@ -547,142 +470,6 @@ #endif
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
-static void handle_cpufreq_delayed_get(struct work_struct *v)
-{
-	unsigned int cpu;
-	for_each_online_cpu(cpu) {
-		cpufreq_get(cpu);
-	}
-	cpufreq_delayed_issched = 0;
-}
-
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
-	INIT_WORK(&cpufreq_delayed_get_work, handle_cpufreq_delayed_get);
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
@@ -713,124 +500,6 @@ static unsigned int __init pit_calibrate
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
 
@@ -888,7 +557,7 @@ void __init time_init(void)
 	set_normalized_timespec(&wall_to_monotonic,
 	                        -xtime.tv_sec, -xtime.tv_nsec);
 
-	if (!hpet_init())
+	if (!hpet_arch_init())
                 vxtime_hz = (FSEC_PER_SEC + hpet_period / 2) / hpet_period;
 	else
 		hpet_address = 0;
@@ -923,30 +592,6 @@ #ifndef CONFIG_SMP
 #endif
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
-		if (acpi_fadt.length > 0 && acpi_fadt.plvl3_lat < 1000)
-			return 1;
-#endif
- 		return 0;
-	}
-
- 	/* Assume multi socket systems are not synchronized */
- 	return num_present_cpus() > 1;
-}
 
 /*
  * Decide what mode gettimeofday should use.
@@ -1084,268 +729,3 @@ static int time_init_device(void)
 
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
-
-	cnt = hpet_readl(HPET_COUNTER);
-	cnt += ((hpet_tick*HZ)/hpet_rtc_int_freq);
-	hpet_writel(cnt, HPET_T1_CMP);
-	hpet_t1_cmp = cnt;
-
-	cfg = hpet_readl(HPET_T1_CFG);
-	cfg &= ~HPET_TN_PERIODIC;
-	cfg |= HPET_TN_ENABLE | HPET_TN_32BIT;
-	hpet_writel(cfg, HPET_T1_CFG);
-
-	local_irq_restore(flags);
-
-	return 1;
-}
-
-static void hpet_rtc_timer_reinit(void)
-{
-	unsigned int cfg, cnt, ticks_per_int, lost_ints;
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
-	ticks_per_int = hpet_tick * HZ / hpet_rtc_int_freq;
-	hpet_t1_cmp += ticks_per_int;
-	hpet_writel(hpet_t1_cmp, HPET_T1_CMP);
-
-	/*
-	 * If the interrupt handler was delayed too long, the write above tries
-	 * to schedule the next interrupt in the past and the hardware would
-	 * not interrupt until the counter had wrapped around.
-	 * So we have to check that the comparator wasn't set to a past time.
-	 */
-	cnt = hpet_readl(HPET_COUNTER);
-	if (unlikely((int)(cnt - hpet_t1_cmp) > 0)) {
-		lost_ints = (cnt - hpet_t1_cmp) / ticks_per_int + 1;
-		/* Make sure that, even with the time needed to execute
-		 * this code, the next scheduled interrupt has been moved
-		 * back to the future: */
-		lost_ints++;
-
-		hpet_t1_cmp += lost_ints * ticks_per_int;
-		hpet_writel(hpet_t1_cmp, HPET_T1_CMP);
-
-		if (PIE_on)
-			PIE_count += lost_ints;
-
-		printk(KERN_WARNING "rtc: lost some interrupts at %ldHz.\n",
-		       hpet_rtc_int_freq);
-	}
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
-		rtc_interrupt(rtc_int_flag, dev_id);
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
index 0000000..b490847
--- /dev/null
+++ b/arch/x86_64/kernel/tsc.c
@@ -0,0 +1,201 @@
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
+int notsc __initdata = 0;
+
+unsigned int cpu_khz;		/* TSC clocks / usec, not used here */
+EXPORT_SYMBOL(cpu_khz);
+
+/*
+ * do_gettimeoffset() returns microseconds since last timer interrupt was
+ * triggered by hardware. A memory read of HPET is slower than a register read
+ * of TSC, but much more reliable. It's also synchronized to the timer
+ * interrupt. Note that do_gettimeoffset() may return more than hpet_tick, if a
+ * timer interrupt has happened already, but vxtime.trigger wasn't updated yet.
+ * This is not a problem, because jiffies hasn't updated either. They are bound
+ * together by xtime_lock.
+ */
+
+unsigned int do_gettimeoffset_tsc(void)
+{
+	unsigned long t;
+	unsigned long x;
+	t = get_cycles_sync();
+	if (t < vxtime.last_tsc)
+		t = vxtime.last_tsc; /* hack */
+	x = ((t - vxtime.last_tsc) * vxtime.tsc_quot) >> US_SCALE;
+	return x;
+}
+
+static unsigned int cyc2ns_scale __read_mostly;
+
+void set_cyc2ns_scale(unsigned long khz)
+{
+	cyc2ns_scale = (NSEC_PER_MSEC << NS_SCALE) / khz;
+}
+
+unsigned long long cycles_2_ns(unsigned long long cyc)
+{
+	return (cyc * cyc2ns_scale) >> NS_SCALE;
+}
+
+unsigned long long sched_clock(void)
+{
+	unsigned long a = 0;
+
+	/* Could do CPU core sync here. Opteron can execute rdtsc speculatively,
+	 * which means it is not completely exact and may not be monotonous
+	 * between CPUs. But the errors should be too small to matter for
+	 * scheduling purposes.
+	 */
+
+	rdtscll(a);
+	return cycles_2_ns(a);
+}
+
+#ifdef CONFIG_CPU_FREQ
+
+/* Frequency scaling support. Adjust the TSC based timer when the cpu frequency
+ * changes.
+ *
+ * RED-PEN: On SMP we assume all CPUs run with the same frequency.  It's
+ * not that important because current Opteron setups do not support
+ * scaling on SMP anyroads.
+ *
+ * Should fix up last_tsc too. Currently gettimeofday in the
+ * first tick after the change will be slightly wrong.
+ */
+
+#include <linux/workqueue.h>
+
+static unsigned int cpufreq_delayed_issched = 0;
+static unsigned int cpufreq_init = 0;
+static struct work_struct cpufreq_delayed_get_work;
+
+static void handle_cpufreq_delayed_get(struct work_struct *v)
+{
+	unsigned int cpu;
+	for_each_online_cpu(cpu) {
+		cpufreq_get(cpu);
+	}
+	cpufreq_delayed_issched = 0;
+}
+
+/* if we notice lost ticks, schedule a call to cpufreq_get() as it tries
+ * to verify the CPU frequency the timing core thinks the CPU is running
+ * at is still correct.
+ */
+void cpufreq_delayed_get(void)
+{
+	static int warned;
+	if (cpufreq_init && !cpufreq_delayed_issched) {
+		cpufreq_delayed_issched = 1;
+		if (!warned) {
+			warned = 1;
+			printk(KERN_DEBUG "Losing some ticks... "
+				"checking if CPU frequency changed.\n");
+		}
+		schedule_work(&cpufreq_delayed_get_work);
+	}
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
+	struct cpufreq_freqs *freq = data;
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
+	if ((val == CPUFREQ_PRECHANGE  && freq->old < freq->new) ||
+		(val == CPUFREQ_POSTCHANGE && freq->old > freq->new) ||
+		(val == CPUFREQ_RESUMECHANGE)) {
+		*lpj =
+		cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
+
+		cpu_khz = cpufreq_scale(cpu_khz_ref, ref_freq, freq->new);
+		if (!(freq->flags & CPUFREQ_CONST_LOOPS))
+			vxtime.tsc_quot = (USEC_PER_MSEC << US_SCALE) / cpu_khz;
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
+	INIT_WORK(&cpufreq_delayed_get_work, handle_cpufreq_delayed_get);
+	if (!cpufreq_register_notifier(&time_cpufreq_notifier_block,
+				       CPUFREQ_TRANSITION_NOTIFIER))
+		cpufreq_init = 1;
+	return 0;
+}
+
+core_initcall(cpufreq_tsc);
+
+#endif
+
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
+		if (acpi_fadt.length > 0 && acpi_fadt.plvl3_lat < 1000)
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
diff --git a/include/asm-x86_64/hpet.h b/include/asm-x86_64/hpet.h
index 60d5127..59a66f0 100644
--- a/include/asm-x86_64/hpet.h
+++ b/include/asm-x86_64/hpet.h
@@ -56,9 +56,15 @@ #define HPET_TICK_RATE (HZ * 100000UL)
 extern int is_hpet_enabled(void);
 extern int hpet_rtc_timer_init(void);
 extern int apic_is_clustered_box(void);
+extern int hpet_arch_init(void);
+extern int hpet_timer_stop_set_go(unsigned long tick);
+extern int hpet_reenable(void);
+extern unsigned int hpet_calibrate_tsc(void);
 
 extern int hpet_use_timer;
 extern unsigned long hpet_address;
+extern unsigned long hpet_period;
+extern unsigned long hpet_tick;
 
 #ifdef CONFIG_HPET_EMULATE_RTC
 extern int hpet_mask_rtc_irq_bit(unsigned long bit_mask);
diff --git a/include/asm-x86_64/timex.h b/include/asm-x86_64/timex.h
index b9e5320..adb8c0d 100644
--- a/include/asm-x86_64/timex.h
+++ b/include/asm-x86_64/timex.h
@@ -44,6 +44,17 @@ extern unsigned int cpu_khz;
 extern int read_current_timer(unsigned long *timer_value);
 #define ARCH_HAS_READ_CURRENT_TIMER	1
 
+#define USEC_PER_TICK (USEC_PER_SEC / HZ)
+#define NSEC_PER_TICK (NSEC_PER_SEC / HZ)
+#define FSEC_PER_TICK (FSEC_PER_SEC / HZ)
+
+#define NS_SCALE        10 /* 2^10, carefully chosen */
+#define US_SCALE        32 /* 2^32, arbitralrily chosen */
+
 extern struct vxtime_data vxtime;
 
+extern unsigned int do_gettimeoffset_hpet(void);
+extern unsigned int do_gettimeoffset_tsc(void);
+extern void set_cyc2ns_scale(unsigned long khz);
+extern int notsc;
 #endif
