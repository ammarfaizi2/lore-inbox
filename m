Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932574AbWAFCO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932574AbWAFCO6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 21:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932551AbWAFCOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 21:14:19 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:28360 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932574AbWAFCOK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 21:14:10 -0500
Date: Thu, 5 Jan 2006 19:14:08 -0700
From: john stultz <johnstul@us.ibm.com>
To: akpm@osdl.org
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, john stultz <johnstul@us.ibm.com>
Message-Id: <20060106021407.6714.21719.sendpatchset@cog.beaverton.ibm.com>
In-Reply-To: <20060106021328.6714.45831.sendpatchset@cog.beaverton.ibm.com>
References: <20060106021328.6714.45831.sendpatchset@cog.beaverton.ibm.com>
Subject: [PATCH 6/10] Time: i386 Conversion - part 2: Rework TSC Support
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	As part of the i386 conversion to the generic timekeeping 
infrastructure, this introduces a new tsc.c file. The code in this file 
replaces the TSC initialization, management and access code currently 
in timer_tsc.c (which will be removed) that we want to preserve.
	
The code also introduces the following functionality:
o tsc_khz: like cpu_khz but stores the TSC frequency on systems that do 
not change TSC frequency w/ CPU frequency
o check/mark_tsc_unstable: accessor/modifier flag for TSC timekeeping 
usability
o minor cleanups to calibration math.

thanks
-john

Signed-off-by: John Stultz <johnstul@us.ibm.com>

 arch/i386/kernel/Makefile                   |    2 
 arch/i386/kernel/setup.c                    |    1 
 arch/i386/kernel/timers/timer_tsc.c         |  170 ---------------
 arch/i386/kernel/tsc.c                      |  303 ++++++++++++++++++++++++++++
 drivers/acpi/processor_idle.c               |    4 
 include/asm-i386/mach-default/mach_timer.h  |    4 
 include/asm-i386/mach-summit/mach_mpparse.h |    3 
 include/asm-i386/timex.h                    |   34 ---
 include/asm-i386/tsc.h                      |   49 ++++
 9 files changed, 365 insertions(+), 205 deletions(-)

linux-2.6.15-rc5_timeofday-arch-i386-part2_B15.patch
============================================
diff --git a/arch/i386/kernel/Makefile b/arch/i386/kernel/Makefile
index 7bc053f..4c4e1e5 100644
--- a/arch/i386/kernel/Makefile
+++ b/arch/i386/kernel/Makefile
@@ -7,7 +7,7 @@ extra-y := head.o init_task.o vmlinux.ld
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
 		ptrace.o time.o ioport.o ldt.o setup.o i8259.o sys_i386.o \
 		pci-dma.o i386_ksyms.o i387.o dmi_scan.o bootflag.o \
-		doublefault.o quirks.o i8237.o i8253.o
+		doublefault.o quirks.o i8237.o i8253.o tsc.o
 
 obj-y				+= cpu/
 obj-y				+= timers/
diff --git a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
index fdfcb0c..28ab317 100644
--- a/arch/i386/kernel/setup.c
+++ b/arch/i386/kernel/setup.c
@@ -1620,6 +1620,7 @@ void __init setup_arch(char **cmdline_p)
 	conswitchp = &dummy_con;
 #endif
 #endif
+	tsc_init();
 }
 
 #include "setup_arch_post.h"
diff --git a/arch/i386/kernel/timers/timer_tsc.c b/arch/i386/kernel/timers/timer_tsc.c
index d395e3b..efdbf5e 100644
--- a/arch/i386/kernel/timers/timer_tsc.c
+++ b/arch/i386/kernel/timers/timer_tsc.c
@@ -32,10 +32,6 @@ static unsigned long hpet_last;
 static struct timer_opts timer_tsc;
 #endif
 
-static inline void cpufreq_delayed_get(void);
-
-int tsc_disable __devinitdata = 0;
-
 static int use_tsc;
 /* Number of usecs that the last interrupt was delayed */
 static int delay_at_last_interrupt;
@@ -135,30 +131,6 @@ static unsigned long long monotonic_cloc
 	return base + cycles_2_ns(this_offset - last_offset);
 }
 
-/*
- * Scheduler clock - returns current time in nanosec units.
- */
-unsigned long long sched_clock(void)
-{
-	unsigned long long this_offset;
-
-	/*
-	 * In the NUMA case we dont use the TSC as they are not
-	 * synchronized across all CPUs.
-	 */
-#ifndef CONFIG_NUMA
-	if (!use_tsc)
-#endif
-		/* no locking but a rare wrong value is not a big deal */
-		return jiffies_64 * (1000000000 / HZ);
-
-	/* Read the Time Stamp Counter */
-	rdtscll(this_offset);
-
-	/* return the value in ns */
-	return cycles_2_ns(this_offset);
-}
-
 static void delay_tsc(unsigned long loops)
 {
 	unsigned long bclock, now;
@@ -222,128 +194,6 @@ static void mark_offset_tsc_hpet(void)
 #endif
 
 
-#ifdef CONFIG_CPU_FREQ
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
-/* if we notice lost ticks, schedule a call to cpufreq_get() as it tries
- * to verify the CPU frequency the timing core thinks the CPU is running
- * at is still correct.
- */
-static inline void cpufreq_delayed_get(void) 
-{
-	if (cpufreq_init && !cpufreq_delayed_issched) {
-		cpufreq_delayed_issched = 1;
-		printk(KERN_DEBUG "Losing some ticks... checking if CPU frequency changed.\n");
-		schedule_work(&cpufreq_delayed_get_work);
-	}
-}
-
-/* If the CPU frequency is scaled, TSC-based delays will need a different
- * loops_per_jiffy value to function properly.
- */
-
-static unsigned int  ref_freq = 0;
-static unsigned long loops_per_jiffy_ref = 0;
-
-#ifndef CONFIG_SMP
-static unsigned long fast_gettimeoffset_ref = 0;
-static unsigned int cpu_khz_ref = 0;
-#endif
-
-static int
-time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
-		       void *data)
-{
-	struct cpufreq_freqs *freq = data;
-
-	if (val != CPUFREQ_RESUMECHANGE)
-		write_seqlock_irq(&xtime_lock);
-	if (!ref_freq) {
-		ref_freq = freq->old;
-		loops_per_jiffy_ref = cpu_data[freq->cpu].loops_per_jiffy;
-#ifndef CONFIG_SMP
-		fast_gettimeoffset_ref = fast_gettimeoffset_quotient;
-		cpu_khz_ref = cpu_khz;
-#endif
-	}
-
-	if ((val == CPUFREQ_PRECHANGE  && freq->old < freq->new) ||
-	    (val == CPUFREQ_POSTCHANGE && freq->old > freq->new) ||
-	    (val == CPUFREQ_RESUMECHANGE)) {
-		if (!(freq->flags & CPUFREQ_CONST_LOOPS))
-			cpu_data[freq->cpu].loops_per_jiffy = cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
-#ifndef CONFIG_SMP
-		if (cpu_khz)
-			cpu_khz = cpufreq_scale(cpu_khz_ref, ref_freq, freq->new);
-		if (use_tsc) {
-			if (!(freq->flags & CPUFREQ_CONST_LOOPS)) {
-				fast_gettimeoffset_quotient = cpufreq_scale(fast_gettimeoffset_ref, freq->new, ref_freq);
-				set_cyc2ns_scale(cpu_khz);
-			}
-		}
-#endif
-	}
-
-	if (val != CPUFREQ_RESUMECHANGE)
-		write_sequnlock_irq(&xtime_lock);
-
-	return 0;
-}
-
-static struct notifier_block time_cpufreq_notifier_block = {
-	.notifier_call	= time_cpufreq_notifier
-};
-
-
-static int __init cpufreq_tsc(void)
-{
-	int ret;
-	INIT_WORK(&cpufreq_delayed_get_work, handle_cpufreq_delayed_get, NULL);
-	ret = cpufreq_register_notifier(&time_cpufreq_notifier_block,
-					CPUFREQ_TRANSITION_NOTIFIER);
-	if (!ret)
-		cpufreq_init = 1;
-	return ret;
-}
-core_initcall(cpufreq_tsc);
-
-#else /* CONFIG_CPU_FREQ */
-static inline void cpufreq_delayed_get(void) { return; }
-#endif 
-
-int recalibrate_cpu_khz(void)
-{
-#ifndef CONFIG_SMP
-	unsigned int cpu_khz_old = cpu_khz;
-
-	if (cpu_has_tsc) {
-		init_cpu_khz();
-		cpu_data[0].loops_per_jiffy =
-		    cpufreq_scale(cpu_data[0].loops_per_jiffy,
-			          cpu_khz_old,
-				  cpu_khz);
-		return 0;
-	} else
-		return -ENODEV;
-#else
-	return -ENODEV;
-#endif
-}
-EXPORT_SYMBOL(recalibrate_cpu_khz);
-
 static void mark_offset_tsc(void)
 {
 	unsigned long lost,delay;
@@ -434,9 +284,6 @@ static void mark_offset_tsc(void)
 
 			clock_fallback();
 		}
-		/* ... but give the TSC a fair chance */
-		if (lost_count > 25)
-			cpufreq_delayed_get();
 	} else
 		lost_count = 0;
 	/* update the monotonic base value */
@@ -561,23 +408,6 @@ static int tsc_resume(void)
 	return 0;
 }
 
-#ifndef CONFIG_X86_TSC
-/* disable flag for tsc.  Takes effect by clearing the TSC cpu flag
- * in cpu/common.c */
-static int __init tsc_setup(char *str)
-{
-	tsc_disable = 1;
-	return 1;
-}
-#else
-static int __init tsc_setup(char *str)
-{
-	printk(KERN_WARNING "notsc: Kernel compiled with CONFIG_X86_TSC, "
-				"cannot disable TSC.\n");
-	return 1;
-}
-#endif
-__setup("notsc", tsc_setup);
 
 
 
diff --git a/arch/i386/kernel/tsc.c b/arch/i386/kernel/tsc.c
new file mode 100644
index 0000000..3e9774c
--- /dev/null
+++ b/arch/i386/kernel/tsc.c
@@ -0,0 +1,303 @@
+/*
+ * This code largely moved from arch/i386/kernel/timer/timer_tsc.c
+ * which was originally moved from arch/i386/kernel/time.c.
+ * See comments there for proper credits.
+ */
+
+#include <linux/workqueue.h>
+#include <linux/cpufreq.h>
+#include <linux/jiffies.h>
+#include <linux/init.h>
+
+#include <asm/tsc.h>
+#include <asm/io.h>
+
+#include "mach_timer.h"
+
+/*
+ * On some systems the TSC frequency does not
+ * change with the cpu frequency. So we need
+ * an extra value to store the TSC freq
+ */
+unsigned int tsc_khz;
+
+int tsc_disable __initdata = 0;
+
+#ifdef CONFIG_X86_TSC
+static int __init tsc_setup(char *str)
+{
+	printk(KERN_WARNING "notsc: Kernel compiled with CONFIG_X86_TSC, "
+				"cannot disable TSC.\n");
+	return 1;
+}
+#else
+/*
+ * disable flag for tsc. Takes effect by clearing the TSC cpu flag
+ * in cpu/common.c
+ */
+static int __init tsc_setup(char *str)
+{
+	tsc_disable = 1;
+
+	return 1;
+}
+#endif
+
+__setup("notsc", tsc_setup);
+
+
+/*
+ * code to mark and check if the TSC is unstable
+ * due to cpufreq or due to unsynced TSCs
+ */
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
+/* Accellerators for sched_clock()
+ * convert from cycles(64bits) => nanoseconds (64bits)
+ *  basic equation:
+ *		ns = cycles / (freq / ns_per_sec)
+ *		ns = cycles * (ns_per_sec / freq)
+ *		ns = cycles * (10^9 / (cpu_khz * 10^3))
+ *		ns = cycles * (10^6 / cpu_khz)
+ *
+ *	Then we use scaling math (suggested by george@mvista.com) to get:
+ *		ns = cycles * (10^6 * SC / cpu_khz) / SC
+ *		ns = cycles * cyc2ns_scale / SC
+ *
+ *	And since SC is a constant power of two, we can convert the div
+ *  into a shift.
+ *
+ *  We can use khz divisor instead of mhz to keep a better percision, since
+ *  cyc2ns_scale is limited to 10^6 * 2^10, which fits in 32 bits.
+ *  (mathieu.desnoyers@polymtl.ca)
+ *
+ *			-johnstul@us.ibm.com "math is hard, lets go shopping!"
+ */
+static unsigned long cyc2ns_scale;
+
+#define CYC2NS_SCALE_FACTOR 10 /* 2^10, carefully chosen */
+
+static inline void set_cyc2ns_scale(unsigned long cpu_khz)
+{
+	cyc2ns_scale = (1000000 << CYC2NS_SCALE_FACTOR)/cpu_khz;
+}
+
+static inline unsigned long long cycles_2_ns(unsigned long long cyc)
+{
+	return (cyc * cyc2ns_scale) >> CYC2NS_SCALE_FACTOR;
+}
+
+/*
+ * Scheduler clock - returns current time in nanosec units.
+ */
+unsigned long long sched_clock(void)
+{
+	unsigned long long this_offset;
+
+	/*
+	 * in the NUMA case we dont use the TSC as they are not
+	 * synchronized across all CPUs.
+	 */
+#ifndef CONFIG_NUMA
+	if (!cpu_khz || check_tsc_unstable())
+#endif
+		/* no locking but a rare wrong value is not a big deal */
+		return (jiffies_64 - INITIAL_JIFFIES) * (1000000000 / HZ);
+
+	/* read the Time Stamp Counter: */
+	rdtscll(this_offset);
+
+	/* return the value in ns */
+	return cycles_2_ns(this_offset);
+}
+
+static unsigned long calculate_cpu_khz(void)
+{
+	unsigned long long start, end;
+	unsigned long count;
+	u64 delta64;
+	int i;
+
+	/* run 3 times to ensure the cache is warm */
+	for (i = 0; i < 3; i++) {
+		mach_prepare_counter();
+		rdtscll(start);
+		mach_countup(&count);
+		rdtscll(end);
+	}
+	/*
+	 * Error: ECTCNEVERSET
+	 * The CTC wasn't reliable: we got a hit on the very first read,
+	 * or the CPU was so fast/slow that the quotient wouldn't fit in
+	 * 32 bits..
+	 */
+	if (count <= 1)
+		return 0;
+
+	delta64 = end - start;
+
+	/* cpu freq too fast: */
+	if (delta64 > (1ULL<<32))
+		return 0;
+
+	/* cpu freq too slow: */
+	if (delta64 <= CALIBRATE_TIME_MSEC)
+		return 0;
+
+	delta64 += CALIBRATE_TIME_MSEC/2; /* round for do_div */
+	do_div(delta64,CALIBRATE_TIME_MSEC);
+
+	return (unsigned long)delta64;
+}
+
+int recalibrate_cpu_khz(void)
+{
+#ifndef CONFIG_SMP
+	unsigned long cpu_khz_old = cpu_khz;
+
+	if (cpu_has_tsc) {
+		cpu_khz = calculate_cpu_khz();
+		tsc_khz = cpu_khz;
+		cpu_data[0].loops_per_jiffy =
+			cpufreq_scale(cpu_data[0].loops_per_jiffy,
+					cpu_khz_old, cpu_khz);
+		return 0;
+	} else
+		return -ENODEV;
+#else
+	return -ENODEV;
+#endif
+}
+
+EXPORT_SYMBOL(recalibrate_cpu_khz);
+
+void tsc_init(void)
+{
+	if (!cpu_has_tsc || tsc_disable)
+		return;
+
+	cpu_khz = calculate_cpu_khz();
+	tsc_khz = cpu_khz;
+
+	if (!cpu_khz)
+		return;
+
+	printk("Detected %lu.%03lu MHz processor.\n",
+				(unsigned long)cpu_khz / 1000,
+				(unsigned long)cpu_khz % 1000);
+
+	set_cyc2ns_scale(cpu_khz);
+}
+
+#ifdef CONFIG_CPU_FREQ
+
+static unsigned int cpufreq_delayed_issched = 0;
+static unsigned int cpufreq_init = 0;
+static struct work_struct cpufreq_delayed_get_work;
+
+static void handle_cpufreq_delayed_get(void *v)
+{
+	unsigned int cpu;
+
+	for_each_online_cpu(cpu)
+		cpufreq_get(cpu);
+
+	cpufreq_delayed_issched = 0;
+}
+
+/*
+ * if we notice cpufreq oddness, schedule a call to cpufreq_get() as it tries
+ * to verify the CPU frequency the timing core thinks the CPU is running
+ * at is still correct.
+ */
+static inline void cpufreq_delayed_get(void)
+{
+	if (cpufreq_init && !cpufreq_delayed_issched) {
+		cpufreq_delayed_issched = 1;
+		printk(KERN_DEBUG "Checking if CPU frequency changed.\n");
+		schedule_work(&cpufreq_delayed_get_work);
+	}
+}
+
+/*
+ * if the CPU frequency is scaled, TSC-based delays will need a different
+ * loops_per_jiffy value to function properly.
+ */
+static unsigned int ref_freq = 0;
+static unsigned long loops_per_jiffy_ref = 0;
+static unsigned long cpu_khz_ref = 0;
+
+static int
+time_cpufreq_notifier(struct notifier_block *nb, unsigned long val, void *data)
+{
+	struct cpufreq_freqs *freq = data;
+
+	if (val != CPUFREQ_RESUMECHANGE)
+		write_seqlock_irq(&xtime_lock);
+
+	if (!ref_freq) {
+		ref_freq = freq->old;
+		loops_per_jiffy_ref = cpu_data[freq->cpu].loops_per_jiffy;
+		cpu_khz_ref = cpu_khz;
+	}
+
+	if ((val == CPUFREQ_PRECHANGE  && freq->old < freq->new) ||
+	    (val == CPUFREQ_POSTCHANGE && freq->old > freq->new) ||
+	    (val == CPUFREQ_RESUMECHANGE)) {
+		if (!(freq->flags & CPUFREQ_CONST_LOOPS))
+			cpu_data[freq->cpu].loops_per_jiffy = cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
+
+		if (cpu_khz) {
+
+			if (num_online_cpus() == 1)
+				cpu_khz = cpufreq_scale(cpu_khz_ref,
+						ref_freq, freq->new);
+			if (!(freq->flags & CPUFREQ_CONST_LOOPS)) {
+				tsc_khz = cpu_khz;
+				set_cyc2ns_scale(cpu_khz);
+				/*
+				 * TSC based sched_clock turns
+				 * to junk w/ cpufreq
+				 */
+				mark_tsc_unstable();
+			}
+		}
+	}
+
+	if (val != CPUFREQ_RESUMECHANGE)
+		write_sequnlock_irq(&xtime_lock);
+
+	return 0;
+}
+
+static struct notifier_block time_cpufreq_notifier_block = {
+	.notifier_call	= time_cpufreq_notifier
+};
+
+static int __init cpufreq_tsc(void)
+{
+	int ret;
+
+	INIT_WORK(&cpufreq_delayed_get_work, handle_cpufreq_delayed_get, NULL);
+	ret = cpufreq_register_notifier(&time_cpufreq_notifier_block,
+					CPUFREQ_TRANSITION_NOTIFIER);
+	if (!ret)
+		cpufreq_init = 1;
+
+	return ret;
+}
+
+core_initcall(cpufreq_tsc);
+
+#endif
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 5f51057..2034ed4 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -371,6 +371,10 @@ static void acpi_processor_idle(void)
 					  ACPI_MTX_DO_NOT_LOCK);
 		}
 
+#ifdef CONFIG_GENERIC_TIME
+		/* TSC halts in C3, so notify users */
+		mark_tsc_unstable();
+#endif
 		/* Re-enable interrupts */
 		local_irq_enable();
 		set_thread_flag(TIF_POLLING_NRFLAG);
diff --git a/include/asm-i386/mach-default/mach_timer.h b/include/asm-i386/mach-default/mach_timer.h
index 4b9703b..807992f 100644
--- a/include/asm-i386/mach-default/mach_timer.h
+++ b/include/asm-i386/mach-default/mach_timer.h
@@ -15,7 +15,9 @@
 #ifndef _MACH_TIMER_H
 #define _MACH_TIMER_H
 
-#define CALIBRATE_LATCH	(5 * LATCH)
+#define CALIBRATE_TIME_MSEC 30 /* 30 msecs */
+#define CALIBRATE_LATCH	\
+	((CLOCK_TICK_RATE * CALIBRATE_TIME_MSEC + 1000/2)/1000)
 
 static inline void mach_prepare_counter(void)
 {
diff --git a/include/asm-i386/mach-summit/mach_mpparse.h b/include/asm-i386/mach-summit/mach_mpparse.h
index 1cce2b9..9426839 100644
--- a/include/asm-i386/mach-summit/mach_mpparse.h
+++ b/include/asm-i386/mach-summit/mach_mpparse.h
@@ -2,6 +2,7 @@
 #define __ASM_MACH_MPPARSE_H
 
 #include <mach_apic.h>
+#include <asm/tsc.h>
 
 extern int use_cyclone;
 
@@ -29,6 +30,7 @@ static inline int mps_oem_check(struct m
 			(!strncmp(productid, "VIGIL SMP", 9) 
 			 || !strncmp(productid, "EXA", 3)
 			 || !strncmp(productid, "RUTHLESS SMP", 12))){
+		mark_tsc_unstable();
 		use_cyclone = 1; /*enable cyclone-timer*/
 		setup_summit();
 		return 1;
@@ -42,6 +44,7 @@ static inline int acpi_madt_oem_check(ch
 	if (!strncmp(oem_id, "IBM", 3) &&
 	    (!strncmp(oem_table_id, "SERVIGIL", 8)
 	     || !strncmp(oem_table_id, "EXA", 3))){
+		mark_tsc_unstable();
 		use_cyclone = 1; /*enable cyclone-timer*/
 		setup_summit();
 		return 1;
diff --git a/include/asm-i386/timex.h b/include/asm-i386/timex.h
index 292b5a6..ebcc74e 100644
--- a/include/asm-i386/timex.h
+++ b/include/asm-i386/timex.h
@@ -8,6 +8,7 @@
 
 #include <linux/config.h>
 #include <asm/processor.h>
+#include <asm/tsc.h>
 
 #ifdef CONFIG_X86_ELAN
 #  define CLOCK_TICK_RATE 1189200 /* AMD Elan has different frequency! */
@@ -16,39 +17,6 @@
 #endif
 
 
-/*
- * Standard way to access the cycle counter on i586+ CPUs.
- * Currently only used on SMP.
- *
- * If you really have a SMP machine with i486 chips or older,
- * compile for that, and this will just always return zero.
- * That's ok, it just means that the nicer scheduling heuristics
- * won't work for you.
- *
- * We only use the low 32 bits, and we'd simply better make sure
- * that we reschedule before that wraps. Scheduling at least every
- * four billion cycles just basically sounds like a good idea,
- * regardless of how fast the machine is. 
- */
-typedef unsigned long long cycles_t;
-
-static inline cycles_t get_cycles (void)
-{
-	unsigned long long ret=0;
-
-#ifndef CONFIG_X86_TSC
-	if (!cpu_has_tsc)
-		return 0;
-#endif
-
-#if defined(CONFIG_X86_GENERIC) || defined(CONFIG_X86_TSC)
-	rdtscll(ret);
-#endif
-	return ret;
-}
-
-extern unsigned int cpu_khz;
-
 extern int read_current_timer(unsigned long *timer_value);
 #define ARCH_HAS_READ_CURRENT_TIMER	1
 
diff --git a/include/asm-i386/tsc.h b/include/asm-i386/tsc.h
new file mode 100644
index 0000000..97b828c
--- /dev/null
+++ b/include/asm-i386/tsc.h
@@ -0,0 +1,49 @@
+/*
+ * linux/include/asm-i386/tsc.h
+ *
+ * i386 TSC related functions
+ */
+#ifndef _ASM_i386_TSC_H
+#define _ASM_i386_TSC_H
+
+#include <linux/config.h>
+#include <asm/processor.h>
+
+/*
+ * Standard way to access the cycle counter on i586+ CPUs.
+ * Currently only used on SMP.
+ *
+ * If you really have a SMP machine with i486 chips or older,
+ * compile for that, and this will just always return zero.
+ * That's ok, it just means that the nicer scheduling heuristics
+ * won't work for you.
+ *
+ * We only use the low 32 bits, and we'd simply better make sure
+ * that we reschedule before that wraps. Scheduling at least every
+ * four billion cycles just basically sounds like a good idea,
+ * regardless of how fast the machine is.
+ */
+typedef unsigned long long cycles_t;
+
+extern unsigned int cpu_khz;
+extern unsigned int tsc_khz;
+
+static inline cycles_t get_cycles(void)
+{
+	unsigned long long ret = 0;
+
+#ifndef CONFIG_X86_TSC
+	if (!cpu_has_tsc)
+		return 0;
+#endif
+
+#if defined(CONFIG_X86_GENERIC) || defined(CONFIG_X86_TSC)
+	rdtscll(ret);
+#endif
+	return ret;
+}
+
+extern void tsc_init(void);
+extern void mark_tsc_unstable(void);
+
+#endif
