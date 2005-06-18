Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261889AbVFRDEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbVFRDEr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 23:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbVFRDEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 23:04:38 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:18397 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261667AbVFRC7Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 22:59:24 -0400
Subject: [PATCH 3/6] new timeofday i386 arch specific changes, part 2 for
	-mm (v.B3)
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
In-Reply-To: <1119063484.9663.4.camel@cog.beaverton.ibm.com>
References: <1119063400.9663.2.camel@cog.beaverton.ibm.com>
	 <1119063484.9663.4.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Fri, 17 Jun 2005 19:59:17 -0700
Message-Id: <1119063557.9663.6.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, All,
	To hopefully improve the review-ability of my changes, I've split up my
arch-i386 patch into four chunks. This patch is a cleanup patch for the
i386 arch in preparation of moving the the new timeofday infrastructure.
It moves some code from timer_tsc.c to a new tsc.c file.

It applies on top of my timeofday-arch-i386-part1_B3 patch. This patch
is part the timeofday-arch-i386 patchset, so without the following parts
it is not expected to compile.
	
Andrew, please consider for inclusion for testing into your tree.

thanks
-john

Signed-off-by: John Stultz <johnstul@us.ibm.com>

linux-2.6.12-rc6-mm1_timeofday-arch-i386-part2_B3.patch
=======================================================
diff -ruN linux-2.6.12-rc6-mm1/arch/i386/kernel/Makefile linux-2.6.12-rc6-mm1-tod/arch/i386/kernel/Makefile
--- linux-2.6.12-rc6-mm1/arch/i386/kernel/Makefile	2005-06-17 18:52:02.090991765 -0700
+++ linux-2.6.12-rc6-mm1-tod/arch/i386/kernel/Makefile	2005-06-17 18:35:08.000000000 -0700
@@ -7,7 +7,7 @@
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
 		ptrace.o time.o ioport.o ldt.o setup.o i8259.o sys_i386.o \
 		pci-dma.o i386_ksyms.o i387.o dmi_scan.o bootflag.o \
-		doublefault.o quirks.o
+		doublefault.o quirks.o tsc.o
 
 obj-y				+= cpu/
 obj-y				+= timers/
diff -ruN linux-2.6.12-rc6-mm1/arch/i386/kernel/timers/common.c linux-2.6.12-rc6-mm1-tod/arch/i386/kernel/timers/common.c
--- linux-2.6.12-rc6-mm1/arch/i386/kernel/timers/common.c	2005-06-17 18:52:02.091991641 -0700
+++ linux-2.6.12-rc6-mm1-tod/arch/i386/kernel/timers/common.c	2005-06-17 18:35:08.000000000 -0700
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
@@ -148,24 +88,3 @@
 }
 
 
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
-				printk("Detected %lu.%03lu MHz processor.\n", cpu_khz / 1000, cpu_khz % 1000);
-			}
-		}
-	}
-}
-
diff -ruN linux-2.6.12-rc6-mm1/arch/i386/kernel/timers/timer.c linux-2.6.12-rc6-mm1-tod/arch/i386/kernel/timers/timer.c
--- linux-2.6.12-rc6-mm1/arch/i386/kernel/timers/timer.c	2005-06-17 15:56:25.000000000 -0700
+++ linux-2.6.12-rc6-mm1-tod/arch/i386/kernel/timers/timer.c	2005-06-17 18:52:43.243878067 -0700
@@ -64,12 +64,3 @@
 	panic("select_timer: Cannot find a suitable timer\n");
 	return NULL;
 }
-
-int read_current_timer(unsigned long *timer_val)
-{
-	if (cur_timer->read_timer) {
-		*timer_val = cur_timer->read_timer();
-		return 0;
-	}
-	return -1;
-}
diff -ruN linux-2.6.12-rc6-mm1/arch/i386/kernel/timers/timer_tsc.c linux-2.6.12-rc6-mm1-tod/arch/i386/kernel/timers/timer_tsc.c
--- linux-2.6.12-rc6-mm1/arch/i386/kernel/timers/timer_tsc.c	2005-06-17 18:52:02.096991020 -0700
+++ linux-2.6.12-rc6-mm1-tod/arch/i386/kernel/timers/timer_tsc.c	2005-06-17 18:36:48.000000000 -0700
@@ -31,10 +31,6 @@
 static struct timer_opts timer_tsc;
 #endif
 
-static inline void cpufreq_delayed_get(void);
-
-int tsc_disable __devinitdata = 0;
-
 extern spinlock_t i8253_lock;
 
 static int use_tsc;
@@ -46,34 +42,6 @@
 static unsigned long long monotonic_base;
 static seqlock_t monotonic_lock = SEQLOCK_UNLOCKED;
 
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
 static int count2; /* counter for mark_offset_tsc() */
 
 /* Cached *multiplier* to convert TSC counts to microseconds.
@@ -131,29 +99,6 @@
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
@@ -218,128 +163,6 @@
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
-static unsigned long cpu_khz_ref = 0;
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
-				set_cyc2ns_scale(cpu_khz/1000);
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
-	unsigned long cpu_khz_old = cpu_khz;
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
@@ -543,24 +366,6 @@
 	return -ENODEV;
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
-
 
 
 /************************************************************/
diff -ruN linux-2.6.12-rc6-mm1/arch/i386/kernel/tsc.c linux-2.6.12-rc6-mm1-tod/arch/i386/kernel/tsc.c
--- linux-2.6.12-rc6-mm1/arch/i386/kernel/tsc.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.12-rc6-mm1-tod/arch/i386/kernel/tsc.c	2005-06-17 18:52:39.975284226 -0700
@@ -0,0 +1,298 @@
+/*
+ * This code largely moved from arch/i386/kernel/timer/timer_tsc.c
+ * which was originally moved from arch/i386/kernel/time.c.
+ * See comments there for proper credits.
+ */
+
+#include <linux/init.h>
+#include <linux/timex.h>
+#include <linux/cpufreq.h>
+#include <asm/io.h>
+#include "mach_timer.h"
+
+int tsc_disable __initdata = 0;
+#ifndef CONFIG_X86_TSC
+/* disable flag for tsc.  Takes effect by clearing the TSC cpu flag
+ * in cpu/common.c */
+static int __init tsc_setup(char *str)
+{
+	tsc_disable = 1;
+	return 1;
+}
+#else
+static int __init tsc_setup(char *str)
+{
+	printk(KERN_WARNING "notsc: Kernel compiled with CONFIG_X86_TSC, "
+				"cannot disable TSC.\n");
+	return 1;
+}
+#endif
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
+ *		ns = cycles * (10^9 / (cpu_mhz * 10^6))
+ *		ns = cycles * (10^3 / cpu_mhz)
+ *
+ *	Then we use scaling math (suggested by george@mvista.com) to get:
+ *		ns = cycles * (10^3 * SC / cpu_mhz) / SC
+ *		ns = cycles * cyc2ns_scale / SC
+ *
+ *	And since SC is a constant power of two, we can convert the div
+ *  into a shift.
+ *			-johnstul@us.ibm.com "math is hard, lets go shopping!"
+ */
+static unsigned long cyc2ns_scale;
+#define CYC2NS_SCALE_FACTOR 10 /* 2^10, carefully chosen */
+
+static inline void set_cyc2ns_scale(unsigned long cpu_mhz)
+{
+	cyc2ns_scale = (1000 << CYC2NS_SCALE_FACTOR)/cpu_mhz;
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
+	 * In the NUMA case we dont use the TSC as they are not
+	 * synchronized across all CPUs.
+	 */
+#ifndef CONFIG_NUMA
+	if (!use_tsc)
+#endif
+		/* no locking but a rare wrong value is not a big deal */
+		return jiffies_64 * (1000000000 / HZ);
+
+	/* Read the Time Stamp Counter */
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
+
+#ifdef CONFIG_CPU_FREQ
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
+/* if we notice lost ticks, schedule a call to cpufreq_get() as it tries
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
+/* If the CPU frequency is scaled, TSC-based delays will need a different
+ * loops_per_jiffy value to function properly.
+ */
+
+static unsigned int  ref_freq = 0;
+static unsigned long loops_per_jiffy_ref = 0;
+
+#ifndef CONFIG_SMP
+static unsigned long fast_gettimeoffset_ref = 0;
+static unsigned long cpu_khz_ref = 0;
+#endif
+
+static int
+time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
+		       void *data)
+{
+	struct cpufreq_freqs *freq = data;
+
+	if (val != CPUFREQ_RESUMECHANGE)
+		write_seqlock_irq(&xtime_lock);
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
+				set_cyc2ns_scale(cpu_khz/1000);
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
+
+static int __init cpufreq_tsc(void)
+{
+	int ret;
+	INIT_WORK(&cpufreq_delayed_get_work, handle_cpufreq_delayed_get, NULL);
+	ret = cpufreq_register_notifier(&time_cpufreq_notifier_block,
+					CPUFREQ_TRANSITION_NOTIFIER);
+	if (!ret)
+		cpufreq_init = 1;
+	return ret;
+}
+core_initcall(cpufreq_tsc);
+
+#else /* CONFIG_CPU_FREQ */
+void cpufreq_delayed_get(void) { return; }
+#endif


