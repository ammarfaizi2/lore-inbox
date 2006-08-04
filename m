Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030322AbWHDD0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030322AbWHDD0N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 23:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030317AbWHDD0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 23:26:11 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:16073 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP
	id S1030315AbWHDDZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 23:25:55 -0400
Message-Id: <20060804032523.569641000@mvista.com>
References: <20060804032414.304636000@mvista.com>
User-Agent: quilt/0.45-1
Date: Thu, 03 Aug 2006 20:24:24 -0700
From: dwalker@mvista.com
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: [PATCH 10/10] -mm  clocksource: add generic sched_clock()
Content-Disposition: inline; filename=add_generic_sched_clock.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a generic sched_clock, along with a boot time override for the
scheduler clocksource. Hopefully the config option would eventually 
be removed.

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

---
 arch/i386/Kconfig      |    4 +++
 arch/i386/kernel/tsc.c |   61 ------------------------------------------------
 kernel/sched.c         |   62 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+), 61 deletions(-)

Index: linux-2.6.17/arch/i386/Kconfig
===================================================================
--- linux-2.6.17.orig/arch/i386/Kconfig
+++ linux-2.6.17/arch/i386/Kconfig
@@ -18,6 +18,10 @@ config GENERIC_TIME
 	bool
 	default y
 
+config GENERIC_SCHED_CLOCK
+	bool
+	default y
+
 config LOCKDEP_SUPPORT
 	bool
 	default y
Index: linux-2.6.17/arch/i386/kernel/tsc.c
===================================================================
--- linux-2.6.17.orig/arch/i386/kernel/tsc.c
+++ linux-2.6.17/arch/i386/kernel/tsc.c
@@ -69,65 +69,6 @@ void mark_tsc_unstable(void)
 }
 EXPORT_SYMBOL_GPL(mark_tsc_unstable);
 
-/* Accellerators for sched_clock()
- * convert from cycles(64bits) => nanoseconds (64bits)
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
-static unsigned long cyc2ns_scale __read_mostly;
-
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
-/*
- * Scheduler clock - returns current time in nanosec units.
- */
-unsigned long long sched_clock(void)
-{
-	unsigned long long this_offset;
-
-	/*
-	 * in the NUMA case we dont use the TSC as they are not
-	 * synchronized across all CPUs.
-	 */
-#ifndef CONFIG_NUMA
-	if (!cpu_khz || check_tsc_unstable())
-#endif
-		/* no locking but a rare wrong value is not a big deal */
-		return (jiffies_64 - INITIAL_JIFFIES) * (1000000000 / HZ);
-
-	/* read the Time Stamp Counter: */
-	rdtscll(this_offset);
-
-	/* return the value in ns */
-	return cycles_2_ns(this_offset);
-}
-
 static unsigned long calculate_cpu_khz(void)
 {
 	unsigned long long start, end;
@@ -210,7 +151,6 @@ void tsc_init(void)
 				(unsigned long)cpu_khz / 1000,
 				(unsigned long)cpu_khz % 1000);
 
-	set_cyc2ns_scale(cpu_khz);
 	use_tsc_delay();
 }
 
@@ -285,7 +225,6 @@ time_cpufreq_notifier(struct notifier_bl
 						ref_freq, freq->new);
 			if (!(freq->flags & CPUFREQ_CONST_LOOPS)) {
 				tsc_khz = cpu_khz;
-				set_cyc2ns_scale(cpu_khz);
 				/*
 				 * TSC based sched_clock turns
 				 * to junk w/ cpufreq
Index: linux-2.6.17/kernel/sched.c
===================================================================
--- linux-2.6.17.orig/kernel/sched.c
+++ linux-2.6.17/kernel/sched.c
@@ -16,6 +16,7 @@
  *		by Davide Libenzi, preemptible kernel bits by Robert Love.
  *  2003-09-03	Interactivity tuning by Con Kolivas.
  *  2004-04-02	Scheduler domains code by Nick Piggin
+ *  2006-08-03	Generic sched_clock() implementation by Daniel Walker
  */
 
 #include <linux/mm.h>
@@ -53,6 +54,7 @@
 #include <linux/acct.h>
 #include <linux/kprobes.h>
 #include <linux/delayacct.h>
+#include <linux/clocksource.h>
 #include <asm/tlb.h>
 
 #include <asm/unistd.h>
@@ -6843,6 +6845,66 @@ int in_sched_functions(unsigned long add
 		&& addr < (unsigned long)__sched_text_end);
 }
 
+#ifdef CONFIG_GENERIC_SCHED_CLOCK
+static struct clocksource *sched_clocksource = &clocksource_jiffies;
+static char __initdata sched_clock_override[32];
+
+unsigned long long sched_clock(void)
+{
+	return cyc2ns(sched_clocksource, clocksource_read(sched_clocksource));
+}
+
+static int __init boot_override_sched_clocksource(char* str)
+{
+	if (str)
+		strlcpy(sched_clock_override, str,
+			sizeof(sched_clock_override));
+
+	return 1;
+}
+__setup("sched_clocksource=", boot_override_sched_clocksource);
+
+static int
+sched_clock_callback(struct notifier_block *nb, unsigned long op, void *c)
+{
+	/*
+	 * If our clock just became unstable switch to the safe,
+	 * slow, fast jiffies clock.
+	 *
+	 * XXX : We could just switch to the next best clock.
+	 */
+	if (op == CLOCKSOURCE_NOTIFY_RATING && sched_clocksource == c)
+		sched_clocksource = &clocksource_jiffies;
+	return 0;
+}
+
+static struct notifier_block sched_clock_nb = {
+	.notifier_call = sched_clock_callback,
+};
+
+static int __init sched_clock_init(void)
+{
+	clocksource_notifier_register(&sched_clock_nb);
+
+	if (*sched_clock_override != 0) {
+		sched_clocksource = clocksource_get_clock(sched_clock_override);
+		if (unlikely(sched_clocksource == NULL)) {
+			sched_clocksource = clocksource_get_best_clock();
+			printk(KERN_ERR "Warning: "
+			       "Invalid scheduler clock override.\n");
+			return 1;
+		}
+
+		printk(KERN_INFO "Scheduler: %s clocksource has been "
+		       "installed.\n", sched_clocksource->name);
+	} else
+		sched_clocksource = clocksource_get_best_clock();
+
+	return 0;
+}
+__initcall(sched_clock_init);
+#endif /* CONFIG_GENERIC_SCHED_CLOCK */
+
 void __init sched_init(void)
 {
 	int i, j, k;

--
