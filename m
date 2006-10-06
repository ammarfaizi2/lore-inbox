Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422847AbWJFS6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422847AbWJFS6m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 14:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422853AbWJFS6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 14:58:39 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:29731 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP
	id S1422849AbWJFS6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 14:58:01 -0400
Message-Id: <20061006185457.153724000@mvista.com>
References: <20061006185439.667702000@mvista.com>
User-Agent: quilt/0.45-1
Date: Fri, 06 Oct 2006 11:54:46 -0700
From: Daniel Walker <dwalker@mvista.com>
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: [PATCH 07/10] -mm: clocksource: remove update_callback
Content-Disposition: inline; filename=clocksource_remove_update_callback.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Inorporated John's comment of moving the rating change code
into mark_tsc_unstable() , then I renamed tsc_update_callback()
to tsc_update_khz() and added a call to it into places that change
the tsc_khz variable.

With the new notifier block the update_callback becomes
obsolete.

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

---
 arch/i386/kernel/tsc.c      |   54 ++++++++++++++++++++++----------------------
 include/linux/clocksource.h |    2 -
 2 files changed, 28 insertions(+), 28 deletions(-)

Index: linux-2.6.18/arch/i386/kernel/tsc.c
===================================================================
--- linux-2.6.18.orig/arch/i386/kernel/tsc.c
+++ linux-2.6.18/arch/i386/kernel/tsc.c
@@ -50,8 +50,7 @@ static int __init tsc_setup(char *str)
 __setup("notsc", tsc_setup);
 
 /*
- * code to mark and check if the TSC is unstable
- * due to cpufreq or due to unsynced TSCs
+ * Flag that denotes an unstable tsc and check function.
  */
 static int tsc_unstable;
 
@@ -60,12 +59,6 @@ static inline int check_tsc_unstable(voi
 	return tsc_unstable;
 }
 
-void mark_tsc_unstable(void)
-{
-	tsc_unstable = 1;
-}
-EXPORT_SYMBOL_GPL(mark_tsc_unstable);
-
 /* Accellerators for sched_clock()
  * convert from cycles(64bits) => nanoseconds (64bits)
  *  basic equation:
@@ -171,6 +164,21 @@ err:
 	return 0;
 }
 
+#if !defined(CONFIG_SMP) || defined(CONFIG_CPU_FREQ)
+static struct clocksource clocksource_tsc;
+static unsigned long current_tsc_khz;
+static void tsc_update_khz(void)
+{
+	/* only update if tsc_khz has changed: */
+	if (current_tsc_khz != tsc_khz) {
+		current_tsc_khz = tsc_khz;
+		clocksource_tsc.mult = clocksource_khz2mult(current_tsc_khz,
+							clocksource_tsc.shift);
+	}
+
+}
+#endif
+
 int recalibrate_cpu_khz(void)
 {
 #ifndef CONFIG_SMP
@@ -179,6 +187,7 @@ int recalibrate_cpu_khz(void)
 	if (cpu_has_tsc) {
 		cpu_khz = calculate_cpu_khz();
 		tsc_khz = cpu_khz;
+		tsc_update_khz();
 		cpu_data[0].loops_per_jiffy =
 			cpufreq_scale(cpu_data[0].loops_per_jiffy,
 					cpu_khz_old, cpu_khz);
@@ -282,6 +291,7 @@ time_cpufreq_notifier(struct notifier_bl
 						ref_freq, freq->new);
 			if (!(freq->flags & CPUFREQ_CONST_LOOPS)) {
 				tsc_khz = cpu_khz;
+				tsc_update_khz();
 				set_cyc2ns_scale(cpu_khz);
 				/*
 				 * TSC based sched_clock turns
@@ -322,7 +332,6 @@ core_initcall(cpufreq_tsc);
 /* clock source code */
 
 static unsigned long current_tsc_khz = 0;
-static int tsc_update_callback(void);
 
 static cycle_t read_tsc(void)
 {
@@ -340,31 +349,24 @@ static struct clocksource clocksource_ts
 	.mask			= CLOCKSOURCE_MASK(64),
 	.mult			= 0, /* to be set */
 	.shift			= 22,
-	.update_callback	= tsc_update_callback,
 	.is_continuous		= 1,
 };
 
-static int tsc_update_callback(void)
-{
-	int change = 0;
 
-	/* check to see if we should switch to the safe clocksource: */
-	if (clocksource_tsc.rating != 50 && check_tsc_unstable()) {
+/*
+ * code to mark if the TSC is unstable
+ * due to cpufreq or due to unsynced TSCs
+ */
+void mark_tsc_unstable(void)
+{
+	if (unlikely(!tsc_unstable)) {
 		clocksource_tsc.rating = 50;
 		clocksource_rating_change(&clocksource_tsc);
-		change = 1;
 	}
-
-	/* only update if tsc_khz has changed: */
-	if (current_tsc_khz != tsc_khz) {
-		current_tsc_khz = tsc_khz;
-		clocksource_tsc.mult = clocksource_khz2mult(current_tsc_khz,
-							clocksource_tsc.shift);
-		change = 1;
-	}
-
-	return change;
+	tsc_unstable = 1;
 }
+EXPORT_SYMBOL_GPL(mark_tsc_unstable);
+
 
 static int __init dmi_mark_tsc_unstable(struct dmi_system_id *d)
 {
Index: linux-2.6.18/include/linux/clocksource.h
===================================================================
--- linux-2.6.18.orig/include/linux/clocksource.h
+++ linux-2.6.18/include/linux/clocksource.h
@@ -59,7 +59,6 @@ extern struct clocksource clocksource_ji
  *			subtraction of non 64 bit counters
  * @mult:		cycle to nanosecond multiplier
  * @shift:		cycle to nanosecond divisor (power of two)
- * @update_callback:	called when safe to alter clocksource values
  * @is_continuous:	defines if clocksource is free-running.
  * @cycle_interval:	Used internally by timekeeping core, please ignore.
  * @xtime_interval:	Used internally by timekeeping core, please ignore.
@@ -72,7 +71,6 @@ struct clocksource {
 	cycle_t mask;
 	u32 mult;
 	u32 shift;
-	int (*update_callback)(void);
 	int is_continuous;
 
 	/* timekeeping specific data, ignore */

--

