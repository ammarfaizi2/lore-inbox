Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161001AbVKZOyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161001AbVKZOyr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 09:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbVKZOyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 09:54:47 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:26499 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964793AbVKZOyp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 09:54:45 -0500
Date: Sat, 26 Nov 2005 15:54:46 +0100
From: Ingo Molnar <mingo@elte.hu>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Darren Hart <dvhltc@us.ibm.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 6/13] Time: i386 Conversion - part 2: Move timer_tsc.c to tsc.c
Message-ID: <20051126145446.GH12999@elte.hu>
References: <20051122013515.18537.76463.sendpatchset@cog.beaverton.ibm.com> <20051122013554.18537.81282.sendpatchset@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051122013554.18537.81282.sendpatchset@cog.beaverton.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- clean up timeofday-arch-i386-part2.patch
- clean up timeofday-arch-i386-part3.patch

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 arch/i386/kernel/tsc.c |  156 ++++++++++++++++++++++++++++++-------------------
 include/asm-i386/tsc.h |   12 ++-
 2 files changed, 103 insertions(+), 65 deletions(-)

Index: linux/arch/i386/kernel/tsc.c
===================================================================
--- linux.orig/arch/i386/kernel/tsc.c
+++ linux/arch/i386/kernel/tsc.c
@@ -4,43 +4,55 @@
  * See comments there for proper credits.
  */
 
-#include <linux/init.h>
+#include <linux/clocksource.h>
+#include <linux/workqueue.h>
 #include <linux/cpufreq.h>
 #include <linux/jiffies.h>
-#include <asm/tsc.h>
+#include <linux/init.h>
+
 #include <asm/delay.h>
+#include <asm/tsc.h>
 #include <asm/io.h>
+
 #include "mach_timer.h"
 
-/* On some systems the TSC frequency does not
+/*
+ * On some systems the TSC frequency does not
  * change with the cpu frequency. So we need
  * an extra value to store the TSC freq
  */
 unsigned int tsc_khz;
 
 int tsc_disable __initdata = 0;
-#ifndef CONFIG_X86_TSC
-/* disable flag for tsc.  Takes effect by clearing the TSC cpu flag
- * in cpu/common.c */
+
+#ifdef CONFIG_X86_TSC
 static int __init tsc_setup(char *str)
 {
-	tsc_disable = 1;
+	printk(KERN_WARNING "notsc: Kernel compiled with CONFIG_X86_TSC, "
+				"cannot disable TSC.\n");
 	return 1;
 }
 #else
+/*
+ * disable flag for tsc. Takes effect by clearing the TSC cpu flag
+ * in cpu/common.c
+ */
 static int __init tsc_setup(char *str)
 {
-	printk(KERN_WARNING "notsc: Kernel compiled with CONFIG_X86_TSC, "
-				"cannot disable TSC.\n");
+	tsc_disable = 1;
+
 	return 1;
 }
 #endif
+
 __setup("notsc", tsc_setup);
 
-/* Code to mark and check if the TSC is unstable
+/*
+ * code to mark and check if the TSC is unstable
  * due to cpufreq or due to unsynced TSCs
  */
 static int tsc_unstable;
+
 static inline int check_tsc_unstable(void)
 {
 	return tsc_unstable;
@@ -53,10 +65,12 @@ void mark_tsc_unstable(void)
 
 /* Code to compensate for C3 stalls */
 static u64 tsc_c3_offset;
+
 void tsc_c3_compensate(unsigned long nsecs)
 {
 	/* this could def be optimized */
 	u64 cycles = ((u64)nsecs * tsc_khz);
+
 	do_div(cycles, 1000000);
 	tsc_c3_offset += cycles;
 }
@@ -90,6 +104,7 @@ static inline u64 tsc_read_c3_time(void)
  *			-johnstul@us.ibm.com "math is hard, lets go shopping!"
  */
 static unsigned long cyc2ns_scale;
+
 #define CYC2NS_SCALE_FACTOR 10 /* 2^10, carefully chosen */
 
 static inline void set_cyc2ns_scale(unsigned long cpu_khz)
@@ -110,7 +125,7 @@ unsigned long long sched_clock(void)
 	unsigned long long this_offset;
 
 	/*
-	 * In the NUMA case we dont use the TSC as they are not
+	 * in the NUMA case we dont use the TSC as they are not
 	 * synchronized across all CPUs.
 	 */
 #ifndef CONFIG_NUMA
@@ -119,7 +134,7 @@ unsigned long long sched_clock(void)
 		/* no locking but a rare wrong value is not a big deal */
 		return (jiffies_64 - INITIAL_JIFFIES) * (1000000000 / HZ);
 
-	/* Read the Time Stamp Counter */
+	/* read the Time Stamp Counter: */
 	rdtscll(this_offset);
 	this_offset += tsc_read_c3_time();
 
@@ -127,21 +142,22 @@ unsigned long long sched_clock(void)
 	return cycles_2_ns(this_offset);
 }
 
-
 static unsigned long calculate_cpu_khz(void)
 {
 	unsigned long long start, end;
 	unsigned long count;
 	u64 delta64;
 	int i;
+
 	/* run 3 times to ensure the cache is warm */
-	for(i=0; i<3; i++) {
+	for (i = 0; i < 3; i++) {
 		mach_prepare_counter();
 		rdtscll(start);
 		mach_countup(&count);
 		rdtscll(end);
 	}
-	/* Error: ECTCNEVERSET
+	/*
+	 * Error: ECTCNEVERSET
 	 * The CTC wasn't reliable: we got a hit on the very first read,
 	 * or the CPU was so fast/slow that the quotient wouldn't fit in
 	 * 32 bits..
@@ -151,10 +167,11 @@ static unsigned long calculate_cpu_khz(v
 
 	delta64 = end - start;
 
-	/* cpu freq too fast */
-	if(delta64 > (1ULL<<32))
+	/* cpu freq too fast: */
+	if (delta64 > (1ULL<<32))
 		return 0;
-	/* cpu freq too slow */
+
+	/* cpu freq too slow: */
 	if (delta64 <= CALIBRATE_TIME_MSEC)
 		return 0;
 
@@ -182,12 +199,12 @@ int recalibrate_cpu_khz(void)
 	return -ENODEV;
 #endif
 }
-EXPORT_SYMBOL(recalibrate_cpu_khz);
 
+EXPORT_SYMBOL(recalibrate_cpu_khz);
 
 void tsc_init(void)
 {
-	if(!cpu_has_tsc || tsc_disable)
+	if (!cpu_has_tsc || tsc_disable)
 		return;
 
 	cpu_khz = calculate_cpu_khz();
@@ -204,9 +221,7 @@ void tsc_init(void)
 	use_tsc_delay();
 }
 
-
 #ifdef CONFIG_CPU_FREQ
-#include <linux/workqueue.h>
 
 static unsigned int cpufreq_delayed_issched = 0;
 static unsigned int cpufreq_init = 0;
@@ -215,13 +230,15 @@ static struct work_struct cpufreq_delaye
 static void handle_cpufreq_delayed_get(void *v)
 {
 	unsigned int cpu;
-	for_each_online_cpu(cpu) {
+
+	for_each_online_cpu(cpu)
 		cpufreq_get(cpu);
-	}
+
 	cpufreq_delayed_issched = 0;
 }
 
-/* if we notice cpufreq oddness, schedule a call to cpufreq_get() as it tries
+/*
+ * if we notice cpufreq oddness, schedule a call to cpufreq_get() as it tries
  * to verify the CPU frequency the timing core thinks the CPU is running
  * at is still correct.
  */
@@ -234,24 +251,25 @@ static inline void cpufreq_delayed_get(v
 	}
 }
 
-/* If the CPU frequency is scaled, TSC-based delays will need a different
+/*
+ * if the CPU frequency is scaled, TSC-based delays will need a different
  * loops_per_jiffy value to function properly.
  */
-
-static unsigned int  ref_freq = 0;
+static unsigned int ref_freq = 0;
 static unsigned long loops_per_jiffy_ref = 0;
 
 #ifndef CONFIG_SMP
 static unsigned long cpu_khz_ref = 0;
 #endif
 
-static int time_cpufreq_notifier(struct notifier_block *nb,
-		unsigned long val, void *data)
+static int
+time_cpufreq_notifier(struct notifier_block *nb, unsigned long val, void *data)
 {
 	struct cpufreq_freqs *freq = data;
 
 	if (val != CPUFREQ_RESUMECHANGE)
 		write_seqlock_irq(&xtime_lock);
+
 	if (!ref_freq) {
 		ref_freq = freq->old;
 		loops_per_jiffy_ref = cpu_data[freq->cpu].loops_per_jiffy;
@@ -268,12 +286,14 @@ static int time_cpufreq_notifier(struct 
 
 		if (cpu_khz) {
 #ifndef CONFIG_SMP
-			cpu_khz = cpufreq_scale(cpu_khz_ref, ref_freq, freq->new);
+			cpu_khz = cpufreq_scale(cpu_khz_ref, ref_freq,
+						freq->new);
 #endif
 			if (!(freq->flags & CPUFREQ_CONST_LOOPS)) {
 				tsc_khz = cpu_khz;
 				set_cyc2ns_scale(cpu_khz);
-				/* TSC based sched_clock turns
+				/*
+				 * TSC based sched_clock turns
 				 * to junk w/ cpufreq
 				 */
 				mark_tsc_unstable();
@@ -291,10 +311,10 @@ static struct notifier_block time_cpufre
 	.notifier_call	= time_cpufreq_notifier
 };
 
-
 static int __init cpufreq_tsc(void)
 {
 	int ret;
+
 	INIT_WORK(&cpufreq_delayed_get_work, handle_cpufreq_delayed_get, NULL);
 	ret = cpufreq_register_notifier(&time_cpufreq_notifier_block,
 					CPUFREQ_TRANSITION_NOTIFIER);
@@ -303,27 +323,28 @@ static int __init cpufreq_tsc(void)
 
 	return ret;
 }
+
 core_initcall(cpufreq_tsc);
 
 #endif
 
 /* Clock source code */
-#include <linux/clocksource.h>
 
 static unsigned long current_tsc_khz = 0;
 static int tsc_update_callback(void);
 
 #ifdef CONFIG_PARANOID_GENERIC_TIME
 /* This will hurt performance! */
-DEFINE_SPINLOCK(checktsc_lock);
-cycle_t last_tsc;
+static DEFINE_SPINLOCK(checktsc_lock);
+static cycle_t last_tsc;
 
 static cycle_t read_tsc(void)
 {
-	cycle_t ret;
-	unsigned long flags;
 	static int once = 1;
 
+	unsigned long flags;
+	cycle_t ret;
+
 	spin_lock_irqsave(&checktsc_lock, flags);
 
 	rdtscll(ret);
@@ -331,7 +352,9 @@ static cycle_t read_tsc(void)
 	if (once && ret < last_tsc) {
 		once = 0;
 		spin_unlock_irqrestore(&checktsc_lock, flags);
-		printk("BUG in read_tsc(): TSC went backward! Unsynced TSCs?\n");
+		printk("BUG in read_tsc(): TSC went backward!\n");
+		if (num_online_cpus() > 1)
+			printk("... Unsynced TSCs?\n");
 		printk("... [ from %016Lx to %016Lx ]\n", last_tsc, ret);
 
 	} else {
@@ -344,10 +367,11 @@ static cycle_t read_tsc(void)
 
 static cycle_t read_tsc_c3(void)
 {
-	cycle_t ret;
-	unsigned long flags;
 	static int once = 1;
 
+	unsigned long flags;
+	cycle_t ret;
+
 	spin_lock_irqsave(&checktsc_lock, flags);
 
 	rdtscll(ret);
@@ -356,12 +380,15 @@ static cycle_t read_tsc_c3(void)
 	if (once && ret < last_tsc) {
 		once = 0;
 		spin_unlock_irqrestore(&checktsc_lock, flags);
-		printk("BUG in read_tsc_c3(): TSC went backward! Unsynced TSCs?\n");
+		printk("BUG in read_tsc_c3(): TSC went backward!\n");
+		if (num_online_cpus() > 1)
+			printk("... Unsynced TSCs?\n");
 		printk("... [ from %016Lx to %016Lx ]\n", last_tsc, ret);
 	} else {
 		last_tsc = ret;
 		spin_unlock_irqrestore(&checktsc_lock, flags);
 	}
+
 	return ret;
 }
 
@@ -370,36 +397,40 @@ static cycle_t read_tsc_c3(void)
 static cycle_t read_tsc(void)
 {
 	cycle_t ret;
+
 	rdtscll(ret);
+
 	return ret;
 }
 
 static cycle_t read_tsc_c3(void)
 {
 	cycle_t ret;
+
 	rdtscll(ret);
+
 	return ret + tsc_read_c3_time();
 }
 
 #endif /* CONFIG_PARANOID_GENERIC_TIME */
 
 static struct clocksource clocksource_tsc = {
-	.name = "tsc",
-	.rating = 300,
-	.read = read_tsc,
-	.mask = (cycle_t)-1,
-	.mult = 0, /* to be set */
-	.shift = 22,
-	.update_callback = tsc_update_callback,
-	.is_continuous = 1,
+	.name			= "tsc",
+	.rating			= 300,
+	.read			= read_tsc,
+	.mask			= (cycle_t)-1,
+	.mult			= 0, /* to be set */
+	.shift			= 22,
+	.update_callback	= tsc_update_callback,
+	.is_continuous		= 1,
 };
 
 static int tsc_update_callback(void)
 {
 	int change = 0;
-	/* check to see if we should switch to the safe clocksource */
-	if (tsc_read_c3_time() &&
-		strncmp(clocksource_tsc.name, "c3tsc", 5)) {
+
+	/* check to see if we should switch to the safe clocksource: */
+	if (tsc_read_c3_time() && strncmp(clocksource_tsc.name, "c3tsc", 5)) {
 		printk("Falling back to C3 safe TSC\n");
 		clocksource_tsc.read = read_tsc_c3;
 		clocksource_tsc.name = "c3tsc";
@@ -411,13 +442,15 @@ static int tsc_update_callback(void)
 		reselect_clocksource();
 		change = 1;
 	}
-	/* only update if tsc_khz has changed */
-	if (current_tsc_khz != tsc_khz){
+
+	/* only update if tsc_khz has changed: */
+	if (current_tsc_khz != tsc_khz) {
 		current_tsc_khz = tsc_khz;
 		clocksource_tsc.mult = clocksource_khz2mult(current_tsc_khz,
 							clocksource_tsc.shift);
 		change = 1;
 	}
+
 	return change;
 }
 
@@ -427,20 +460,21 @@ static int tsc_update_callback(void)
  */
 static __init int unsynchronized_tsc(void)
 {
-	/* Intel systems are normally all synchronized.
-	 * Exceptions must mark TSC as unstable.
+	/*
+	 * Intel systems are normally all synchronized.
+	 * Exceptions must mark TSC as unstable:
 	 */
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
  		return 0;
 
-	/* Assume multi socket systems are not synchronized */
+	/* assume multi socket systems are not synchronized: */
  	return num_possible_cpus() > 1;
 }
 
-#ifndef CONFIG_X86_NUMAQ /* NUMAQ can't use TSC */
+/* NUMAQ can't use TSC: */
+#ifndef CONFIG_X86_NUMAQ
 static int __init init_tsc_clocksource(void)
 {
-
 	/* TSC initialization is done in arch/i386/kernel/tsc.c */
 	if (cpu_has_tsc && tsc_khz) {
 		if (unsynchronized_tsc()) /* lower rating if unsynced */
@@ -450,8 +484,10 @@ static int __init init_tsc_clocksource(v
 							clocksource_tsc.shift);
 		register_clocksource(&clocksource_tsc);
 	}
+
 	return 0;
 }
 
 module_init(init_tsc_clocksource);
+
 #endif
Index: linux/include/asm-i386/tsc.h
===================================================================
--- linux.orig/include/asm-i386/tsc.h
+++ linux/include/asm-i386/tsc.h
@@ -25,9 +25,12 @@
  */
 typedef unsigned long long cycles_t;
 
-static inline cycles_t get_cycles (void)
+extern unsigned int cpu_khz;
+extern unsigned int tsc_khz;
+
+static inline cycles_t get_cycles(void)
 {
-	unsigned long long ret=0;
+	unsigned long long ret = 0;
 
 #ifndef CONFIG_X86_TSC
 	if (!cpu_has_tsc)
@@ -40,9 +43,8 @@ static inline cycles_t get_cycles (void)
 	return ret;
 }
 
-extern unsigned int cpu_khz;
-extern unsigned int tsc_khz;
 extern void tsc_init(void);
-void tsc_c3_compensate(unsigned long usecs);
+extern void tsc_c3_compensate(unsigned long usecs);
 extern void mark_tsc_unstable(void);
+
 #endif
