Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964871AbWDCT6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871AbWDCT6G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 15:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964869AbWDCT6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 15:58:05 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:3561 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964867AbWDCT6B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 15:58:01 -0400
Date: Mon, 3 Apr 2006 21:57:56 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: johnstul@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] cleanup clocksource drivers
Message-ID: <Pine.LNX.4.64.0604032157320.4723@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Cleanup the clocksource drivers a bit after the previous changes so that
they compile again.
The i8253 clocksource uses now the last_cycle member instead of jiffies.
Change the calls to do_timer() to clocksource_update().

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 arch/i386/kernel/hpet.c                  |    3 -
 arch/i386/kernel/i8253.c                 |   38 ++++++++---------
 arch/i386/kernel/tsc.c                   |   67 +++++++++++++++----------------
 drivers/clocksource/acpi_pm.c            |    3 -
 include/asm-i386/mach-visws/do_timer.h   |    2 
 include/asm-i386/mach-voyager/do_timer.h |    2 
 include/asm/mach-default/do_timer.h      |    2 
 7 files changed, 56 insertions(+), 61 deletions(-)

Index: linux-2.6-mm/arch/i386/kernel/hpet.c
===================================================================
--- linux-2.6-mm.orig/arch/i386/kernel/hpet.c	2006-04-02 17:24:44.000000000 +0200
+++ linux-2.6-mm/arch/i386/kernel/hpet.c	2006-04-02 17:24:51.000000000 +0200
@@ -26,7 +26,6 @@ static struct clocksource clocksource_hp
 	.mask		= (cycle_t)HPET_MASK,
 	.mult		= 0, /* set below */
 	.shift		= HPET_SHIFT,
-	.is_continuous	= 1,
 };
 
 static int __init init_hpet_clocksource(void)
@@ -61,7 +60,7 @@ static int __init init_hpet_clocksource(
 	do_div(tmp, FSEC_PER_NSEC);
 	clocksource_hpet.mult = (u32)tmp;
 
-	return register_clocksource(&clocksource_hpet);
+	return clocksource_register(&clocksource_hpet);
 }
 
 module_init(init_hpet_clocksource);
Index: linux-2.6-mm/arch/i386/kernel/i8253.c
===================================================================
--- linux-2.6-mm.orig/arch/i386/kernel/i8253.c	2006-04-02 17:24:44.000000000 +0200
+++ linux-2.6-mm/arch/i386/kernel/i8253.c	2006-04-02 17:24:51.000000000 +0200
@@ -16,9 +16,20 @@
 
 #include "io_ports.h"
 
+static cycle_t pit_read(void);
+
 DEFINE_SPINLOCK(i8253_lock);
 EXPORT_SYMBOL(i8253_lock);
 
+static struct clocksource pit_clocksource = {
+	.name	= "pit",
+	.rating = 110,
+	.read	= pit_read,
+	.mask	= (cycle_t)-1,
+	.mult	= 0,
+	.shift	= 20,
+};
+
 void setup_pit_timer(void)
 {
 	unsigned long flags;
@@ -34,14 +45,12 @@ void setup_pit_timer(void)
 
 /*
  * Since the PIT overflows every tick, its not very useful
- * to just read by itself. So use jiffies to emulate a free
- * running counter:
+ * to just read by itself.
  */
 static cycle_t pit_read(void)
 {
 	unsigned long flags;
 	int count;
-	u64 jifs;
 
 	spin_lock_irqsave(&i8253_lock, flags);
 	outb_p(0x00, PIT_MODE);	/* latch the count ASAP */
@@ -57,29 +66,18 @@ static cycle_t pit_read(void)
 	}
 	spin_unlock_irqrestore(&i8253_lock, flags);
 
-	jifs = jiffies_64;
-
-	jifs -= INITIAL_JIFFIES;
 	count = (LATCH-1) - count;
 
-	return (cycle_t)(jifs * LATCH) + count;
+	return pit_clocksource.cycles_last + count;
 }
 
-static struct clocksource clocksource_pit = {
-	.name	= "pit",
-	.rating = 110,
-	.read	= pit_read,
-	.mask	= (cycle_t)-1,
-	.mult	= 0,
-	.shift	= 20,
-};
-
-static int __init init_pit_clocksource(void)
+static int __init pit_init_clocksource(void)
 {
 	if (num_possible_cpus() > 4) /* PIT does not scale! */
 		return 0;
 
-	clocksource_pit.mult = clocksource_hz2mult(CLOCK_TICK_RATE, 20);
-	return register_clocksource(&clocksource_pit);
+	pit_clocksource.mult = clocksource_hz2mult(CLOCK_TICK_RATE, 20);
+	pit_clocksource.cycle_update = LATCH;
+	return clocksource_register(&pit_clocksource);
 }
-module_init(init_pit_clocksource);
+module_init(pit_init_clocksource);
Index: linux-2.6-mm/arch/i386/kernel/tsc.c
===================================================================
--- linux-2.6-mm.orig/arch/i386/kernel/tsc.c	2006-04-02 17:24:44.000000000 +0200
+++ linux-2.6-mm/arch/i386/kernel/tsc.c	2006-04-02 17:24:51.000000000 +0200
@@ -55,7 +55,7 @@ __setup("notsc", tsc_setup);
  */
 static int tsc_unstable;
 
-static inline int check_tsc_unstable(void)
+static inline int tsc_check_unstable(void)
 {
 	return tsc_unstable;
 }
@@ -113,7 +113,7 @@ unsigned long long sched_clock(void)
 	 * synchronized across all CPUs.
 	 */
 #ifndef CONFIG_NUMA
-	if (!cpu_khz || check_tsc_unstable())
+	if (!cpu_khz || tsc_check_unstable())
 #endif
 		/* no locking but a rare wrong value is not a big deal */
 		return (jiffies_64 - INITIAL_JIFFIES) * (1000000000 / HZ);
@@ -302,7 +302,7 @@ static struct notifier_block time_cpufre
 	.notifier_call	= time_cpufreq_notifier
 };
 
-static int __init cpufreq_tsc(void)
+static int __init tsc_cpufreq(void)
 {
 	int ret;
 
@@ -315,16 +315,16 @@ static int __init cpufreq_tsc(void)
 	return ret;
 }
 
-core_initcall(cpufreq_tsc);
+core_initcall(tsc_cpufreq);
 
 #endif
 
 /* clock source code */
 
-static unsigned long current_tsc_khz = 0;
+static unsigned long tsc_current_khz = 0;
 static int tsc_update_callback(void);
 
-static cycle_t read_tsc(void)
+static cycle_t tsc_read(void)
 {
 	cycle_t ret;
 
@@ -333,15 +333,14 @@ static cycle_t read_tsc(void)
 	return ret;
 }
 
-static struct clocksource clocksource_tsc = {
+static struct clocksource tsc_clocksource = {
 	.name			= "tsc",
 	.rating			= 300,
-	.read			= read_tsc,
+	.read			= tsc_read,
 	.mask			= (cycle_t)-1,
 	.mult			= 0, /* to be set */
 	.shift			= 22,
 	.update_callback	= tsc_update_callback,
-	.is_continuous		= 1,
 };
 
 static int tsc_update_callback(void)
@@ -349,17 +348,17 @@ static int tsc_update_callback(void)
 	int change = 0;
 
 	/* check to see if we should switch to the safe clocksource: */
-	if (clocksource_tsc.rating != 50 && check_tsc_unstable()) {
-		clocksource_tsc.rating = 50;
-		reselect_clocksource();
+	if (tsc_clocksource.rating != 50 && tsc_check_unstable()) {
+		tsc_clocksource.rating = 50;
+		clocksource_reselect();
 		change = 1;
 	}
 
 	/* only update if tsc_khz has changed: */
-	if (current_tsc_khz != tsc_khz) {
-		current_tsc_khz = tsc_khz;
-		clocksource_tsc.mult = clocksource_khz2mult(current_tsc_khz,
-							clocksource_tsc.shift);
+	if (tsc_current_khz != tsc_khz) {
+		tsc_current_khz = tsc_khz;
+		tsc_clocksource.mult = clocksource_khz2mult(tsc_current_khz,
+							    tsc_clocksource.shift);
 		change = 1;
 	}
 
@@ -388,10 +387,10 @@ static struct dmi_system_id __initdata b
 };
 
 #define TSC_FREQ_CHECK_INTERVAL (10*MSEC_PER_SEC) /* 10sec in MS */
-static struct timer_list verfiy_tsc_freq_timer;
+static struct timer_list tsc_verfiy_freq_timer;
 
 /* XXX - Probably should add locking */
-static void verify_tsc_freq(unsigned long unused)
+static void tsc_verify_freq(unsigned long unused)
 {
 	static u64 last_tsc;
 	static unsigned long last_jiffies;
@@ -400,7 +399,7 @@ static void verify_tsc_freq(unsigned lon
 	unsigned long now_jiffies, interval_jiffies;
 
 
-	if (check_tsc_unstable())
+	if (tsc_check_unstable())
 		return;
 
 	rdtscll(now_tsc);
@@ -426,7 +425,7 @@ out:
 	last_tsc = now_tsc;
 	last_jiffies = now_jiffies;
 	/* set us up to go off on the next interval: */
-	mod_timer(&verfiy_tsc_freq_timer,
+	mod_timer(&tsc_verfiy_freq_timer,
 		jiffies + msecs_to_jiffies(TSC_FREQ_CHECK_INTERVAL));
 }
 
@@ -434,7 +433,7 @@ out:
  * Make an educated guess if the TSC is trustworthy and synchronized
  * over all CPUs.
  */
-static __init int unsynchronized_tsc(void)
+static __init int tsc_unsynchronized(void)
 {
 	/*
 	 * Intel systems are normally all synchronized.
@@ -447,32 +446,32 @@ static __init int unsynchronized_tsc(voi
  	return num_possible_cpus() > 1;
 }
 
-static int __init init_tsc_clocksource(void)
+static int __init tsc_init_clocksource(void)
 {
 
 	if (cpu_has_tsc && tsc_khz && !tsc_disable) {
 		/* check blacklist */
 		dmi_check_system(bad_tsc_dmi_table);
 
-		if (unsynchronized_tsc()) /* mark unstable if unsynced */
+		if (tsc_unsynchronized()) /* mark unstable if unsynced */
 			mark_tsc_unstable();
-		current_tsc_khz = tsc_khz;
-		clocksource_tsc.mult = clocksource_khz2mult(current_tsc_khz,
-							clocksource_tsc.shift);
+		tsc_current_khz = tsc_khz;
+		tsc_clocksource.mult = clocksource_khz2mult(tsc_current_khz,
+							    tsc_clocksource.shift);
 		/* lower the rating if we already know its unstable: */
-		if (check_tsc_unstable())
-			clocksource_tsc.rating = 50;
+		if (tsc_check_unstable())
+			tsc_clocksource.rating = 50;
 
-		init_timer(&verfiy_tsc_freq_timer);
-		verfiy_tsc_freq_timer.function = verify_tsc_freq;
-		verfiy_tsc_freq_timer.expires =
+		init_timer(&tsc_verfiy_freq_timer);
+		tsc_verfiy_freq_timer.function = tsc_verify_freq;
+		tsc_verfiy_freq_timer.expires =
 			jiffies + msecs_to_jiffies(TSC_FREQ_CHECK_INTERVAL);
-		add_timer(&verfiy_tsc_freq_timer);
+		add_timer(&tsc_verfiy_freq_timer);
 
-		return register_clocksource(&clocksource_tsc);
+		return clocksource_register(&tsc_clocksource);
 	}
 
 	return 0;
 }
 
-module_init(init_tsc_clocksource);
+module_init(tsc_init_clocksource);
Index: linux-2.6-mm/drivers/clocksource/acpi_pm.c
===================================================================
--- linux-2.6-mm.orig/drivers/clocksource/acpi_pm.c	2006-04-02 17:24:49.000000000 +0200
+++ linux-2.6-mm/drivers/clocksource/acpi_pm.c	2006-04-02 17:24:51.000000000 +0200
@@ -72,7 +72,6 @@ static struct clocksource clocksource_ac
 	.mask		= (cycle_t)ACPI_PM_MASK,
 	.mult		= 0, /*to be caluclated*/
 	.shift		= 22,
-	.is_continuous	= 1,
 };
 
 
@@ -171,7 +170,7 @@ static int __init init_acpi_pm_clocksour
 	return -ENODEV;
 
 pm_good:
-	return register_clocksource(&clocksource_acpi_pm);
+	return clocksource_register(&clocksource_acpi_pm);
 }
 
 module_init(init_acpi_pm_clocksource);
Index: linux-2.6-mm/include/asm-i386/mach-visws/do_timer.h
===================================================================
--- linux-2.6-mm.orig/include/asm-i386/mach-visws/do_timer.h	2006-04-02 17:20:57.000000000 +0200
+++ linux-2.6-mm/include/asm-i386/mach-visws/do_timer.h	2006-04-02 17:24:51.000000000 +0200
@@ -9,7 +9,7 @@ static inline void do_timer_interrupt_ho
 	/* Clear the interrupt */
 	co_cpu_write(CO_CPU_STAT,co_cpu_read(CO_CPU_STAT) & ~CO_STAT_TIMEINTR);
 
-	do_timer(regs);
+	clocksource_update(regs);
 #ifndef CONFIG_SMP
 	update_process_times(user_mode_vm(regs));
 #endif
Index: linux-2.6-mm/include/asm-i386/mach-voyager/do_timer.h
===================================================================
--- linux-2.6-mm.orig/include/asm-i386/mach-voyager/do_timer.h	2006-04-02 17:20:57.000000000 +0200
+++ linux-2.6-mm/include/asm-i386/mach-voyager/do_timer.h	2006-04-02 17:24:51.000000000 +0200
@@ -3,7 +3,7 @@
 
 static inline void do_timer_interrupt_hook(struct pt_regs *regs)
 {
-	do_timer(regs);
+	clocksource_update(regs);
 #ifndef CONFIG_SMP
 	update_process_times(user_mode_vm(regs));
 #endif
Index: linux-2.6-mm/include/asm/mach-default/do_timer.h
===================================================================
--- linux-2.6-mm.orig/include/asm/mach-default/do_timer.h	2006-04-02 17:20:57.000000000 +0200
+++ linux-2.6-mm/include/asm/mach-default/do_timer.h	2006-04-02 17:24:51.000000000 +0200
@@ -16,7 +16,7 @@
 
 static inline void do_timer_interrupt_hook(struct pt_regs *regs)
 {
-	do_timer(regs);
+	clocksource_update(regs);
 #ifndef CONFIG_SMP
 	update_process_times(user_mode_vm(regs));
 #endif
