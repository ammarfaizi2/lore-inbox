Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030332AbVLOCB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030332AbVLOCB7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 21:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030271AbVLOCBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 21:01:35 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:60590 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S965143AbVLOCAu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 21:00:50 -0500
Date: Wed, 14 Dec 2005 19:00:48 -0700
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Darren Hart <dvhltc@us.ibm.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>, nikita@clusterfs.com,
       Frank Sorenson <frank@tuxrocks.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       john stultz <johnstul@us.ibm.com>
Message-Id: <20051215020047.25589.20275.sendpatchset@cog.beaverton.ibm.com>
In-Reply-To: <20051215020002.25589.55922.sendpatchset@cog.beaverton.ibm.com>
References: <20051215020002.25589.55922.sendpatchset@cog.beaverton.ibm.com>
Subject: [PATCH 6/13] Time: i386 Conversion - part 2: Move timer_tsc.c to tsc.c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	The conversion of i386 to use the generic timeofday subsystem 
has been split into 6 parts. This patch, the second of six, is a 
cleanup patch for the i386 arch in preparation of moving the the 
generic timeofday infrastructure. It moves some code from timer_tsc.c 
to a new tsc.c file.

It applies on top of my timeofday-arch-i386-part1 patch. This patch is 
part the timeofday-arch-i386 patchset, so without the following parts 
it is not expected to compile.

thanks
-john

Signed-off-by: John Stultz <johnstul@us.ibm.com>

 arch/i386/kernel/Makefile           |    2 
 arch/i386/kernel/timers/common.c    |   84 ---------
 arch/i386/kernel/timers/timer_tsc.c |  212 ------------------------
 arch/i386/kernel/tsc.c              |  312 ++++++++++++++++++++++++++++++++++++
 include/asm-i386/timex.h            |   34 ---
 include/asm-i386/tsc.h              |   44 +++++
 6 files changed, 358 insertions(+), 330 deletions(-)

linux-2.6.15-rc5_timeofday-arch-i386-part2_B14.patch
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
diff --git a/arch/i386/kernel/timers/common.c b/arch/i386/kernel/timers/common.c
index 8163fe0..535f4d8 100644
--- a/arch/i386/kernel/timers/common.c
+++ b/arch/i386/kernel/timers/common.c
@@ -14,66 +14,6 @@
 
 #include "mach_timer.h"
 
-/* ------ Calibrate the TSC -------
- * Return 2^32 * (1 / (TSC clocks per usec)) for do_fast_gettimeoffset().
- * Too much 64-bit arithmetic here to do this cleanly in C, and for
- * accuracy's sake we want to keep the overhead on the CTC speaker (channel 2)
- * output busy loop as low as possible. We avoid reading the CTC registers
- * directly because of the awkward 8-bit access mechanism of the 82C54
- * device.
- */
-
-#define CALIBRATE_TIME	(5 * 1000020/HZ)
-
-unsigned long calibrate_tsc(void)
-{
-	mach_prepare_counter();
-
-	{
-		unsigned long startlow, starthigh;
-		unsigned long endlow, endhigh;
-		unsigned long count;
-
-		rdtsc(startlow,starthigh);
-		mach_countup(&count);
-		rdtsc(endlow,endhigh);
-
-
-		/* Error: ECTCNEVERSET */
-		if (count <= 1)
-			goto bad_ctc;
-
-		/* 64-bit subtract - gcc just messes up with long longs */
-		__asm__("subl %2,%0\n\t"
-			"sbbl %3,%1"
-			:"=a" (endlow), "=d" (endhigh)
-			:"g" (startlow), "g" (starthigh),
-			 "0" (endlow), "1" (endhigh));
-
-		/* Error: ECPUTOOFAST */
-		if (endhigh)
-			goto bad_ctc;
-
-		/* Error: ECPUTOOSLOW */
-		if (endlow <= CALIBRATE_TIME)
-			goto bad_ctc;
-
-		__asm__("divl %2"
-			:"=a" (endlow), "=d" (endhigh)
-			:"r" (endlow), "0" (0), "1" (CALIBRATE_TIME));
-
-		return endlow;
-	}
-
-	/*
-	 * The CTC wasn't reliable: we got a hit on the very first read,
-	 * or the CPU was so fast/slow that the quotient wouldn't fit in
-	 * 32 bits..
-	 */
-bad_ctc:
-	return 0;
-}
-
 #ifdef CONFIG_HPET_TIMER
 /* ------ Calibrate the TSC using HPET -------
  * Return 2^32 * (1 / (TSC clocks per usec)) for getting the CPU freq.
@@ -146,27 +86,3 @@ unsigned long read_timer_tsc(void)
 	rdtscl(retval);
 	return retval;
 }
-
-
-/* calculate cpu_khz */
-void init_cpu_khz(void)
-{
-	if (cpu_has_tsc) {
-		unsigned long tsc_quotient = calibrate_tsc();
-		if (tsc_quotient) {
-			/* report CPU clock rate in Hz.
-			 * The formula is (10^6 * 2^32) / (2^32 * 1 / (clocks/us)) =
-			 * clock/second. Our precision is about 100 ppm.
-			 */
-			{	unsigned long eax=0, edx=1000;
-				__asm__("divl %2"
-		       		:"=a" (cpu_khz), "=d" (edx)
-        	       		:"r" (tsc_quotient),
-	                	"0" (eax), "1" (edx));
-				printk("Detected %u.%03u MHz processor.\n",
-					cpu_khz / 1000, cpu_khz % 1000);
-			}
-		}
-	}
-}
-
diff --git a/arch/i386/kernel/timers/timer_tsc.c b/arch/i386/kernel/timers/timer_tsc.c
index d395e3b..93ec4c9 100644
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
@@ -45,39 +41,6 @@ static unsigned long last_tsc_high; /* m
 static unsigned long long monotonic_base;
 static seqlock_t monotonic_lock = SEQLOCK_UNLOCKED;
 
-/* convert from cycles(64bits) => nanoseconds (64bits)
- *  basic equation:
- *		ns = cycles / (freq / ns_per_sec)
- *		ns = cycles * (ns_per_sec / freq)
- *		ns = cycles * (10^9 / (cpu_khz * 10^3))
- *		ns = cycles * (10^6 / cpu_khz)
- *
- *	Then we use scaling math (suggested by george@mvista.com) to get:
- *		ns = cycles * (10^6 * SC / cpu_khz) / SC
- *		ns = cycles * cyc2ns_scale / SC
- *
- *	And since SC is a constant power of two, we can convert the div
- *  into a shift.
- *
- *  We can use khz divisor instead of mhz to keep a better percision, since
- *  cyc2ns_scale is limited to 10^6 * 2^10, which fits in 32 bits.
- *  (mathieu.desnoyers@polymtl.ca)
- *
- *			-johnstul@us.ibm.com "math is hard, lets go shopping!"
- */
-static unsigned long cyc2ns_scale; 
-#define CYC2NS_SCALE_FACTOR 10 /* 2^10, carefully chosen */
-
-static inline void set_cyc2ns_scale(unsigned long cpu_khz)
-{
-	cyc2ns_scale = (1000000 << CYC2NS_SCALE_FACTOR)/cpu_khz;
-}
-
-static inline unsigned long long cycles_2_ns(unsigned long long cyc)
-{
-	return (cyc * cyc2ns_scale) >> CYC2NS_SCALE_FACTOR;
-}
-
 static int count2; /* counter for mark_offset_tsc() */
 
 /* Cached *multiplier* to convert TSC counts to microseconds.
@@ -135,29 +98,6 @@ static unsigned long long monotonic_cloc
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
 
 static void delay_tsc(unsigned long loops)
 {
@@ -222,127 +162,6 @@ static void mark_offset_tsc_hpet(void)
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
 
 static void mark_offset_tsc(void)
 {
@@ -548,37 +367,6 @@ static int __init init_tsc(char* overrid
 	return -ENODEV;
 }
 
-static int tsc_resume(void)
-{
-	write_seqlock(&monotonic_lock);
-	/* Assume this is the last mark offset time */
-	rdtsc(last_tsc_low, last_tsc_high);
-#ifdef CONFIG_HPET_TIMER
-	if (is_hpet_enabled() && hpet_use_timer)
-		hpet_last = hpet_readl(HPET_COUNTER);
-#endif
-	write_sequnlock(&monotonic_lock);
-	return 0;
-}
-
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
-
 
 
 /************************************************************/
diff --git a/arch/i386/kernel/tsc.c b/arch/i386/kernel/tsc.c
new file mode 100644
index 0000000..2e94eaf
--- /dev/null
+++ b/arch/i386/kernel/tsc.c
@@ -0,0 +1,312 @@
+/*
+ * This code largely moved from arch/i386/kernel/timer/timer_tsc.c
+ * which was originally moved from arch/i386/kernel/time.c.
+ * See comments there for proper credits.
+ */
+
+#include <linux/workqueue.h>
+#include <linux/cpufreq.h>
+#include <linux/init.h>
+
+#include <asm/io.h>
+
+#include "mach_timer.h"
+
+int tsc_disable __initdata = 0;
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
+int read_current_timer(unsigned long *timer_val)
+{
+	if (cur_timer->read_timer) {
+		*timer_val = cur_timer->read_timer();
+		return 0;
+	}
+	return -1;
+}
+
+
+/* convert from cycles(64bits) => nanoseconds (64bits)
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
+	if (!use_tsc)
+#endif
+		/* no locking but a rare wrong value is not a big deal */
+		return jiffies_64 * (1000000000 / HZ);
+
+	/* read the Time Stamp Counter: */
+	rdtscll(this_offset);
+
+	/* return the value in ns */
+	return cycles_2_ns(this_offset);
+}
+
+/* ------ Calibrate the TSC -------
+ * Return 2^32 * (1 / (TSC clocks per usec)) for do_fast_gettimeoffset().
+ * Too much 64-bit arithmetic here to do this cleanly in C, and for
+ * accuracy's sake we want to keep the overhead on the CTC speaker (channel 2)
+ * output busy loop as low as possible. We avoid reading the CTC registers
+ * directly because of the awkward 8-bit access mechanism of the 82C54
+ * device.
+ */
+
+#define CALIBRATE_TIME	(5 * 1000020/HZ)
+
+unsigned long calibrate_tsc(void)
+{
+	mach_prepare_counter();
+
+	{
+		unsigned long startlow, starthigh;
+		unsigned long endlow, endhigh;
+		unsigned long count;
+
+		rdtsc(startlow,starthigh);
+		mach_countup(&count);
+		rdtsc(endlow,endhigh);
+
+
+		/* Error: ECTCNEVERSET */
+		if (count <= 1)
+			goto bad_ctc;
+
+		/* 64-bit subtract - gcc just messes up with long longs */
+		__asm__("subl %2,%0\n\t"
+			"sbbl %3,%1"
+			:"=a" (endlow), "=d" (endhigh)
+			:"g" (startlow), "g" (starthigh),
+			 "0" (endlow), "1" (endhigh));
+
+		/* Error: ECPUTOOFAST */
+		if (endhigh)
+			goto bad_ctc;
+
+		/* Error: ECPUTOOSLOW */
+		if (endlow <= CALIBRATE_TIME)
+			goto bad_ctc;
+
+		__asm__("divl %2"
+			:"=a" (endlow), "=d" (endhigh)
+			:"r" (endlow), "0" (0), "1" (CALIBRATE_TIME));
+
+		return endlow;
+	}
+
+	/*
+	 * The CTC wasn't reliable: we got a hit on the very first read,
+	 * or the CPU was so fast/slow that the quotient wouldn't fit in
+	 * 32 bits..
+	 */
+bad_ctc:
+	return 0;
+}
+
+int recalibrate_cpu_khz(void)
+{
+#ifndef CONFIG_SMP
+	unsigned long cpu_khz_old = cpu_khz;
+
+	if (cpu_has_tsc) {
+		init_cpu_khz();
+		cpu_data[0].loops_per_jiffy =
+		    cpufreq_scale(cpu_data[0].loops_per_jiffy,
+			          cpu_khz_old,
+				  cpu_khz);
+		return 0;
+	} else
+		return -ENODEV;
+#else
+	return -ENODEV;
+#endif
+}
+EXPORT_SYMBOL(recalibrate_cpu_khz);
+
+
+/* calculate cpu_khz */
+void init_cpu_khz(void)
+{
+	if (cpu_has_tsc) {
+		unsigned long tsc_quotient = calibrate_tsc();
+		if (tsc_quotient) {
+			/* report CPU clock rate in Hz.
+			 * The formula is (10^6 * 2^32) / (2^32 * 1 / (clocks/us)) =
+			 * clock/second. Our precision is about 100 ppm.
+			 */
+			{	unsigned long eax=0, edx=1000;
+				__asm__("divl %2"
+		       		:"=a" (cpu_khz), "=d" (edx)
+        	       		:"r" (tsc_quotient),
+	                	"0" (eax), "1" (edx));
+				printk("Detected %lu.%03lu MHz processor.\n", cpu_khz / 1000, cpu_khz % 1000);
+			}
+		}
+	}
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
+ * if we notice lost ticks, schedule a call to cpufreq_get() as it tries
+ * to verify the CPU frequency the timing core thinks the CPU is running
+ * at is still correct.
+ */
+void cpufreq_delayed_get(void)
+{
+	if (cpufreq_init && !cpufreq_delayed_issched) {
+		cpufreq_delayed_issched = 1;
+		printk(KERN_DEBUG "Losing some ticks... checking if CPU frequency changed.\n");
+		schedule_work(&cpufreq_delayed_get_work);
+	}
+}
+
+/*
+ * if the CPU frequency is scaled, TSC-based delays will need a different
+ * loops_per_jiffy value to function properly.
+ */
+
+static unsigned int ref_freq = 0;
+static unsigned long loops_per_jiffy_ref = 0;
+
+#ifndef CONFIG_SMP
+static unsigned long fast_gettimeoffset_ref = 0;
+static unsigned long cpu_khz_ref = 0;
+#endif
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
+#ifndef CONFIG_SMP
+		fast_gettimeoffset_ref = fast_gettimeoffset_quotient;
+		cpu_khz_ref = cpu_khz;
+#endif
+	}
+
+	if ((val == CPUFREQ_PRECHANGE  && freq->old < freq->new) ||
+	    (val == CPUFREQ_POSTCHANGE && freq->old > freq->new) ||
+	    (val == CPUFREQ_RESUMECHANGE)) {
+		if (!(freq->flags & CPUFREQ_CONST_LOOPS))
+			cpu_data[freq->cpu].loops_per_jiffy = cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
+#ifndef CONFIG_SMP
+		if (cpu_khz)
+			cpu_khz = cpufreq_scale(cpu_khz_ref, ref_freq, freq->new);
+		if (use_tsc) {
+			if (!(freq->flags & CPUFREQ_CONST_LOOPS)) {
+				fast_gettimeoffset_quotient = cpufreq_scale(fast_gettimeoffset_ref, freq->new, ref_freq);
+				set_cyc2ns_scale(cpu_khz);
+			}
+		}
+#endif
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
+	return ret;
+}
+
+core_initcall(cpufreq_tsc);
+
+#else /* CONFIG_CPU_FREQ */
+void cpufreq_delayed_get(void) { return; }
+#endif
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
index 0000000..86288f2
--- /dev/null
+++ b/include/asm-i386/tsc.h
@@ -0,0 +1,44 @@
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
+static inline cycles_t get_cycles (void)
+{
+	unsigned long long ret=0;
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
+extern unsigned int cpu_khz;
+#endif
