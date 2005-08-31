Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964895AbVHaRa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964895AbVHaRa6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 13:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbVHaRa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 13:30:57 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:47031 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964895AbVHaRa4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 13:30:56 -0400
Date: Wed, 31 Aug 2005 22:56:49 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: arjan@infradead.org, s0348365@sms.ed.ac.uk, kernel@kolivas.org,
       tytso@mit.edu, cfriesen@nortel.com, rlrevell@joe-job.com, trenn@suse.de,
       george@mvista.com, johnstul@us.ibm.com, akpm@osdl.org
Subject: [PATCH 2/3] Updated dynamic tick patches - Cleanup
Message-ID: <20050831172649.GC4974@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20050831165843.GA4974@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050831165843.GA4974@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2005 at 10:28:43PM +0530, Srivatsa Vaddagiri wrote:
> Following patches related to dynamic tick are posted in separate mails,
> for convenience of review. The first patch probably applies w/o dynamic
> tick consideration also.
> 
> Patch 2/3  -> Dyn-tick cleanups

This patch cleans up dynamic tick further. Notable changes:

	- Remove support for TSC timer. IMO supporting TSC does not
	  make much sense since TSC does not function in some deep
	  ACPI power-save states like C3 (?). Moreover, I think
	  it can drift with PIT, which makes lost tick calculation
	  more complicated.
	- Remove 'use_apic' tunable from sysfs and 'dyntick=noapic' bootup
	  option. Always use APIC timer if available.

Patch applies on top of Con's last posted patch, available here:

http://ck.kolivas.org/patches/dyn-ticks/2.6.13-rc6-dtck-2.patch

(The above patch was applied on top of 2.6.13-rc6-mm2 in my tests. The
time.c reject that was obtained can be ignored)




---

 linux-2.6.13-rc6-mm2-root/arch/i386/Kconfig           |   24 -----
 linux-2.6.13-rc6-mm2-root/arch/i386/kernel/apic.c     |   16 +++
 linux-2.6.13-rc6-mm2-root/arch/i386/kernel/dyn-tick.c |   52 ++++--------
 linux-2.6.13-rc6-mm2-root/arch/i386/kernel/io_apic.c  |    6 +
 linux-2.6.13-rc6-mm2-root/arch/i386/kernel/process.c  |    5 -
 linux-2.6.13-rc6-mm2-root/include/asm-i386/apic.h     |    2 
 linux-2.6.13-rc6-mm2-root/include/asm-i386/dyn-tick.h |   41 ---------
 linux-2.6.13-rc6-mm2-root/include/asm-i386/timer.h    |    3 
 linux-2.6.13-rc6-mm2-root/include/linux/dyn-tick.h    |   14 +--
 linux-2.6.13-rc6-mm2-root/kernel/dyn-tick.c           |   76 +++---------------
 10 files changed, 74 insertions(+), 165 deletions(-)

diff -puN arch/i386/kernel/dyn-tick.c~cleanup arch/i386/kernel/dyn-tick.c
--- linux-2.6.13-rc6-mm2/arch/i386/kernel/dyn-tick.c~cleanup	2005-08-31 16:34:51.000000000 +0530
+++ linux-2.6.13-rc6-mm2-root/arch/i386/kernel/dyn-tick.c	2005-08-31 16:35:17.000000000 +0530
@@ -24,15 +24,10 @@ static void arch_reprogram_timer(unsigne
 {
 	unsigned int skip = jif_next - jiffies;
 
-	if (cpu_has_local_apic()) {
-		if (dyn_tick->state & DYN_TICK_TIMER_INT)
-			reprogram_apic_timer(skip);
-	} else {
-		if (dyn_tick->state & DYN_TICK_TIMER_INT)
-			reprogram_pit_timer(skip);
-		else
-			disable_pit_timer();
-	}
+	if (cpu_has_local_apic())
+		reprogram_apic_timer(skip);
+	else
+		reprogram_pit_timer(skip);
 
 	/* Fixme: Disable NMI Watchdog */
 }
@@ -40,8 +35,7 @@ static void arch_reprogram_timer(unsigne
 static void arch_all_cpus_idle(int how_long)
 {
 	if (cpu_has_local_apic())
-		if (dyn_tick->state & DYN_TICK_TIMER_INT)
-			disable_pit_timer();
+		disable_pit_timer();
 }
 
 static struct dyn_tick_timer arch_dyn_tick_timer = {
@@ -49,40 +43,37 @@ static struct dyn_tick_timer arch_dyn_ti
 	.arch_all_cpus_idle	= &arch_all_cpus_idle,
 };
 
-static int __init dyn_tick_init(void)
-{
-	arch_dyn_tick_timer.arch_init = dyn_tick_arch_init;
-	dyn_tick_register(&arch_dyn_tick_timer);
-
-	return 0;
-}
-
-arch_initcall(dyn_tick_init);
-
 int __init dyn_tick_arch_init(void)
 {
 
-	if (!(dyn_tick->state & DYN_TICK_USE_APIC) || !cpu_has_local_apic())
-		dyn_tick->max_skip = 0xffff / LATCH;	/* PIT timer length */
+	if (!cpu_has_local_apic())
+		set_dyn_tick_max_skip(0xffff / LATCH);	/* PIT timer length */
+
 	printk(KERN_INFO "dyn-tick: Maximum ticks to skip limited to %i\n",
 	       dyn_tick->max_skip);
 
 	return 0;
 }
 
-/* Functions that need blank prototypes for !CONFIG_NO_IDLE_HZ below here */
-void set_dyn_tick_max_skip(unsigned int max_skip)
+static int __init dyn_tick_init(void)
 {
-	if (!dyn_tick->max_skip || max_skip < dyn_tick->max_skip)
-		dyn_tick->max_skip = max_skip;
+	arch_dyn_tick_timer.arch_init = dyn_tick_arch_init;
+	dyn_tick_register(&arch_dyn_tick_timer);
+
+	return 0;
 }
 
+arch_initcall(dyn_tick_init);
+
+/* Functions that need blank prototypes for !CONFIG_NO_IDLE_HZ below here */
 void setup_dyn_tick_use_apic(unsigned int calibration_result)
 {
 	if (calibration_result)
-		dyn_tick->state |= DYN_TICK_USE_APIC;
-	else
+		dyn_tick->arch_state |= DYN_TICK_APICABLE;
+	else {
+		dyn_tick->arch_state &= ~DYN_TICK_APICABLE;
 		printk(KERN_INFO "dyn-tick: Cannot use local APIC\n");
+	}
 }
 
 void dyn_tick_interrupt(int irq, struct pt_regs *regs)
@@ -103,8 +94,7 @@ void dyn_tick_interrupt(int irq, struct 
 		/* Recover jiffies */
 		cur_timer->mark_offset();
 		if (cpu_has_local_apic())
-			if (dyn_tick->state & DYN_TICK_TIMER_INT)
-				enable_pit_timer();
+			enable_pit_timer();
 	}
 
 	spin_unlock(&dyn_tick_lock);
diff -puN include/linux/dyn-tick.h~cleanup include/linux/dyn-tick.h
--- linux-2.6.13-rc6-mm2/include/linux/dyn-tick.h~cleanup	2005-08-31 16:34:51.000000000 +0530
+++ linux-2.6.13-rc6-mm2-root/include/linux/dyn-tick.h	2005-08-31 16:35:17.000000000 +0530
@@ -16,17 +16,14 @@
 #include <linux/interrupt.h>
 #include <asm/timer.h>
 
-#define DYN_TICK_APICABLE	(1 << 5)
-#define DYN_TICK_TIMER_INT	(1 << 4)
-#define DYN_TICK_USE_APIC	(1 << 3)
-#define DYN_TICK_SKIPPING	(1 << 2)
 #define DYN_TICK_ENABLED	(1 << 1)
 #define DYN_TICK_SUITABLE	(1 << 0)
 
 #define DYN_TICK_MIN_SKIP	2
 
 struct dyn_tick_state {
-	unsigned int state;		/* Current state */
+	unsigned short state;		/* Current state */
+	unsigned short arch_state;	/* Arch-specific state */
 	unsigned int max_skip;		/* Max number of ticks to skip */
 };
 
@@ -43,7 +40,8 @@ extern spinlock_t dyn_tick_lock;
 extern void dyn_tick_register(struct dyn_tick_timer *new_timer);
 
 #ifdef CONFIG_NO_IDLE_HZ
-extern unsigned long dyn_tick_reprogram_timer(void);
+extern unsigned int dyn_tick_reprogram_timer(void);
+extern void set_dyn_tick_max_skip(unsigned int max_skip);
 
 static inline int dyn_tick_enabled(void)
 {
@@ -51,12 +49,12 @@ static inline int dyn_tick_enabled(void)
 }
 
 #else	/* CONFIG_NO_IDLE_HZ */
-static inline int arch_has_safe_halt(void)
+static inline unsigned int dyn_tick_reprogram_timer(void)
 {
 	return 0;
 }
 
-static inline unsigned long dyn_tick_reprogram_timer(void)
+static inline void set_dyn_tick_max_skip(unsigned int max_skip)
 {
 }
 
diff -puN kernel/dyn-tick.c~cleanup kernel/dyn-tick.c
--- linux-2.6.13-rc6-mm2/kernel/dyn-tick.c~cleanup	2005-08-31 16:34:51.000000000 +0530
+++ linux-2.6.13-rc6-mm2-root/kernel/dyn-tick.c	2005-08-31 16:35:17.000000000 +0530
@@ -23,9 +23,6 @@
 #include <linux/pm.h>
 #include <linux/dyn-tick.h>
 #include <linux/rcupdate.h>
-#include <asm/io.h>
-
-#include "io_ports.h"
 
 #define DYN_TICK_VERSION	"050610-1"
 #define DYN_TICK_IS_SET(x)	((dyn_tick->state & (x)) == (x))
@@ -37,18 +34,16 @@ spinlock_t dyn_tick_lock;
 
 /*
  * Arch independent code needed to reprogram next timer interrupt.
- * Gets called from cpu_idle() before entering idle loop.
+ * Gets called, with IRQs disabled, from cpu_idle() before entering idle loop.
  */
-unsigned long dyn_tick_reprogram_timer(void)
+unsigned int dyn_tick_reprogram_timer(void)
 {
 	int cpu = smp_processor_id();
-	unsigned long delta, flags;
+	unsigned int delta;
 
 	if (!DYN_TICK_IS_SET(DYN_TICK_ENABLED))
 		return 0;
 
-	local_irq_save(flags);
-
 	if (rcu_pending(cpu) || local_softirq_pending())
 		return 0;
 
@@ -78,11 +73,15 @@ unsigned long dyn_tick_reprogram_timer(v
 
 	write_sequnlock(&xtime_lock);
 
-	local_irq_restore(flags);
-
 	return delta;
 }
 
+void set_dyn_tick_max_skip(unsigned int max_skip)
+{
+	if (!dyn_tick->max_skip || max_skip < dyn_tick->max_skip)
+		dyn_tick->max_skip = max_skip;
+}
+
 void __init dyn_tick_register(struct dyn_tick_timer *arch_timer)
 {
 	dyn_tick_cfg = arch_timer;
@@ -96,10 +95,9 @@ void __init dyn_tick_register(struct dyn
  * ---------------------------------------------------------------------------
  */
 static int __initdata dyntick_autoenable = 1;
-static int __initdata dyntick_useapic = 1;
 
 /*
- * dyntick=[disable],[noapic]
+ * dyntick=[disable]
  */ 
 static int __init dyntick_setup(char *options)
 {
@@ -109,9 +107,6 @@ static int __init dyntick_setup(char *op
 	if (!strncmp(options, "disable", 6))
 		dyntick_autoenable = 0;
 
-	if (strstr(options, "noapic"))
-		dyntick_useapic = 0;
-
 	return 0;
 }
 
@@ -129,13 +124,9 @@ static ssize_t show_dyn_tick_state(struc
 {
 	return sprintf(buf,
 		       "suitable:\t%i\n"
-		       "enabled:\t%i\n"
-		       "apic suitable:\t%i\n"
-		       "using APIC:\t%i\n",
+		       "enabled:\t%i\n",
 		       DYN_TICK_IS_SET(DYN_TICK_SUITABLE),
-		       DYN_TICK_IS_SET(DYN_TICK_ENABLED),
-		       DYN_TICK_IS_SET(DYN_TICK_APICABLE),
-		       DYN_TICK_IS_SET(DYN_TICK_USE_APIC));
+		       DYN_TICK_IS_SET(DYN_TICK_ENABLED));
 }
 
 static ssize_t show_dyn_tick_enable(struct sys_device *dev, char *buf)
@@ -165,35 +156,9 @@ static ssize_t set_dyn_tick_enable(struc
 	return count;
 }
 
-static ssize_t show_dyn_tick_useapic(struct sys_device *dev, char *buf)
-{
-	return sprintf(buf, "using APIC:\t%i\n",
-		       DYN_TICK_IS_SET(DYN_TICK_USE_APIC));
-}
-
-static ssize_t set_dyn_tick_useapic(struct sys_device *dev, const char *buf,
-				    size_t count)
-{
-	unsigned long flags;
-	unsigned int enable = simple_strtoul(buf, NULL, 2);
-
-	if (!DYN_TICK_IS_SET(DYN_TICK_APICABLE))
-		goto out;
-	write_seqlock_irqsave(&xtime_lock, flags);
-	if (enable)
-		dyn_tick->state |= DYN_TICK_USE_APIC;
-	else
-		dyn_tick->state &= ~DYN_TICK_USE_APIC;
-	write_sequnlock_irqrestore(&xtime_lock, flags);
-out:
-	return count;
-}
-
 static SYSDEV_ATTR(state, 0444, show_dyn_tick_state, NULL);
 static SYSDEV_ATTR(enable, 0644, show_dyn_tick_enable,
 		   set_dyn_tick_enable);
-static SYSDEV_ATTR(useapic, 0644, show_dyn_tick_useapic,
-		   set_dyn_tick_useapic);
 
 static struct sysdev_class dyn_tick_sysclass = {
 	set_kset_name("dyn_tick"),
@@ -213,9 +178,7 @@ static int init_dyn_tick_sysfs(void)
 		goto out;
 	if ((error = sysdev_create_file(&device_dyn_tick, &attr_state)))
 		goto out;
-	if ((error = sysdev_create_file(&device_dyn_tick, &attr_enable)))
-		goto out;
-	error = sysdev_create_file(&device_dyn_tick, &attr_useapic);
+	error = sysdev_create_file(&device_dyn_tick, &attr_enable);
 
 out:
 	return error;
@@ -229,14 +192,6 @@ device_initcall(init_dyn_tick_sysfs);
  * ---------------------------------------------------------------------------
  */
 
-static int __init dyn_tick_early_init(void)
-{
-	dyn_tick->state |= DYN_TICK_TIMER_INT;
-	return 0;
-}
-
-subsys_initcall(dyn_tick_early_init);
-
 /*
  * We need to initialize dynamic tick after calibrate delay
  */
@@ -250,11 +205,6 @@ static int __init dyn_tick_late_init(voi
 		return -ENODEV;
 	}
 
-	if (DYNTICK_APICABLE)
-		dyn_tick->state |= DYN_TICK_APICABLE;
-	if (!dyntick_useapic || !DYN_TICK_IS_SET(DYN_TICK_APICABLE))
-		dyn_tick->state &= ~DYN_TICK_USE_APIC;
-
 	if ((ret = dyn_tick_cfg->arch_init())) {
 		printk(KERN_ERR "dyn-tick: Init failed\n");
 		return -ENODEV;
diff -puN include/asm-i386/dyn-tick.h~cleanup include/asm-i386/dyn-tick.h
--- linux-2.6.13-rc6-mm2/include/asm-i386/dyn-tick.h~cleanup	2005-08-31 16:34:51.000000000 +0530
+++ linux-2.6.13-rc6-mm2-root/include/asm-i386/dyn-tick.h	2005-08-31 16:35:17.000000000 +0530
@@ -16,23 +16,16 @@
 #include <asm/apic.h>
 
 #ifdef CONFIG_NO_IDLE_HZ
-extern int dyn_tick_arch_init(void);
-extern void disable_pit_timer(void);
-extern void enable_pit_timer(void);
-extern void reprogram_pit_timer(int jiffies_to_skip);
-extern void set_dyn_tick_max_skip(unsigned int max_skip);
 extern void setup_dyn_tick_use_apic(unsigned int calibration_result);
 extern void dyn_tick_interrupt(int irq, struct pt_regs *regs);
 extern void dyn_tick_time_init(struct timer_opts *cur_timer);
-extern u32 apic_timer_val;
 
-#if defined(CONFIG_DYN_TICK_USE_APIC)
-#define DYNTICK_APICABLE	1
+#define DYN_TICK_APICABLE	(1 << 0)
 
 #if (defined(CONFIG_SMP) || defined(CONFIG_X86_UP_APIC))
 static inline int cpu_has_local_apic(void)
 {
-	return (dyn_tick->state & DYN_TICK_USE_APIC);
+	return (dyn_tick->arch_state & DYN_TICK_APICABLE);
 }
 
 #else	/* (defined(CONFIG_SMP) || defined(CONFIG_X86_UP_APIC)) */
@@ -42,37 +35,7 @@ static inline int cpu_has_local_apic(voi
 }
 #endif	/* (defined(CONFIG_SMP) || defined(CONFIG_X86_UP_APIC)) */
 
-#else	/*  defined(CONFIG_DYN_TICK_USE_APIC) */
-#define DYNTICK_APICABLE	0
-static inline int cpu_has_local_apic(void)
-{
-	return 0;
-}
-#endif	/*  defined(CONFIG_DYN_TICK_USE_APIC) */
-
-static inline void reprogram_apic_timer(unsigned int count)
-{
-#ifdef CONFIG_X86_LOCAL_APIC
-	unsigned long flags;
-
-	/* Fixme: Make count more accurate. Otherwise can lead
-	 * 	  to latencies of upto 1 jiffy in servicing timers.
-	 */
-	count *= apic_timer_val;
-	local_irq_save(flags);
-	apic_write_around(APIC_TMICT, count);
-	local_irq_restore(flags);
-#endif	/* CONFIG_X86_LOCAL_APIC */
-}
-
 #else /* CONFIG_NO_IDLE_HZ */
-static inline void set_dyn_tick_max_skip(unsigned int max_skip)
-{
-}
-
-static inline void reprogram_apic_timer(unsigned int count)
-{
-}
 
 static inline void setup_dyn_tick_use_apic(unsigned int calibration_result)
 {
diff -puN arch/i386/Kconfig~cleanup arch/i386/Kconfig
--- linux-2.6.13-rc6-mm2/arch/i386/Kconfig~cleanup	2005-08-31 16:34:51.000000000 +0530
+++ linux-2.6.13-rc6-mm2-root/arch/i386/Kconfig	2005-08-31 16:35:17.000000000 +0530
@@ -469,34 +469,14 @@ config NO_IDLE_HZ
 	  This option enables support for skipping timer ticks when the
 	  processor is idle. During system load, timer is continuous.
 	  This option saves power, as it allows the system to stay in
-	  idle mode longer. Currently supported timers are ACPI PM
-	  timer, local APIC timer, and TSC timer. HPET timer is currently
-	  not supported.
+	  idle mode longer. Currently supported timer is ACPI PM
+	  timer. TSC and HPET timers are currently not supported.
 
 	  Note that you can disable dynamic tick timer either by
 	  passing dyntick=disable command line option, or via sysfs:
 
 	  # echo 0 > /sys/devices/system/dyn_tick/dyn_tick0/enable
 
-config DYN_TICK_USE_APIC
-	bool "Use APIC timer instead of PIT timer"
-	depends on NO_IDLE_HZ
-	help
-	  This option enables using APIC timer interrupt if your hardware
-	  supports it. APIC timer allows longer sleep periods compared
-	  to PIT timer, however on MOST recent hardware disabling the PIT
-	  timer also disables APIC timer interrupts, and the system won't
-	  run properly. Symptoms include slow system boot, and time running 
-	  slow.
-
-	  If unsure, do NOT enable this option.
-
-	  Note that you can disable apic usage by dynamic tick timer
-	  either by passing dyntick=noapic command line option, or via 
-	  sysfs:
-
-	  # echo 0 > /sys/devices/system/dyn_tick/dyn_tick0/useapic
-
 config SMP
 	bool "Symmetric multi-processing support"
 	---help---
diff -puN include/asm-i386/timer.h~cleanup include/asm-i386/timer.h
--- linux-2.6.13-rc6-mm2/include/asm-i386/timer.h~cleanup	2005-08-31 16:34:51.000000000 +0530
+++ linux-2.6.13-rc6-mm2-root/include/asm-i386/timer.h	2005-08-31 16:35:17.000000000 +0530
@@ -38,6 +38,9 @@ struct init_timer_opts {
 extern struct timer_opts* __init select_timer(void);
 extern void clock_fallback(void);
 void setup_pit_timer(void);
+extern void disable_pit_timer(void);
+extern void enable_pit_timer(void);
+extern void reprogram_pit_timer(int jiffies_to_skip);
 
 /* Modifiers for buggy PIT handling */
 
diff -puN arch/i386/kernel/apic.c~cleanup arch/i386/kernel/apic.c
--- linux-2.6.13-rc6-mm2/arch/i386/kernel/apic.c~cleanup	2005-08-31 16:34:51.000000000 +0530
+++ linux-2.6.13-rc6-mm2-root/arch/i386/kernel/apic.c	2005-08-31 16:35:17.000000000 +0530
@@ -928,7 +928,7 @@ void (*wait_timer_tick)(void) __devinitd
 
 #define APIC_DIVISOR 16
 
-u32 apic_timer_val;
+static u32 apic_timer_val;
 
 static void __setup_APIC_LVTT(unsigned int clocks)
 {
@@ -969,6 +969,20 @@ static void __devinit setup_APIC_timer(u
 	local_irq_restore(flags);
 }
 
+/* Used by NO_IDLE_HZ to skip ticks on idle CPUs */
+void reprogram_apic_timer(unsigned int count)
+{
+	unsigned long flags;
+
+	/* Fixme: Make count more accurate. Otherwise can lead
+	 * 	  to latencies of upto 1 jiffy in servicing timers.
+	 */
+	count *= apic_timer_val;
+	local_irq_save(flags);
+	apic_write_around(APIC_TMICT, count);
+	local_irq_restore(flags);
+}
+
 /*
  * In this function we calibrate APIC bus clocks to the external
  * timer. Unfortunately we cannot use jiffies and the timer irq
diff -puN include/asm-i386/apic.h~cleanup include/asm-i386/apic.h
--- linux-2.6.13-rc6-mm2/include/asm-i386/apic.h~cleanup	2005-08-31 16:34:52.000000000 +0530
+++ linux-2.6.13-rc6-mm2-root/include/asm-i386/apic.h	2005-08-31 16:35:17.000000000 +0530
@@ -121,6 +121,7 @@ extern void nmi_watchdog_tick (struct pt
 extern int APIC_init_uniprocessor (void);
 extern void disable_APIC_timer(void);
 extern void enable_APIC_timer(void);
+extern void reprogram_apic_timer(unsigned int count);
 
 extern void enable_NMI_through_LVT0 (void * dummy);
 
@@ -132,6 +133,7 @@ extern unsigned int nmi_watchdog;
 
 #else /* !CONFIG_X86_LOCAL_APIC */
 static inline void lapic_shutdown(void) { }
+static inline void reprogram_apic_timer(unsigned int count) { }
 
 #endif /* !CONFIG_X86_LOCAL_APIC */
 
diff -puN arch/i386/kernel/process.c~cleanup arch/i386/kernel/process.c
--- linux-2.6.13-rc6-mm2/arch/i386/kernel/process.c~cleanup	2005-08-31 16:34:52.000000000 +0530
+++ linux-2.6.13-rc6-mm2-root/arch/i386/kernel/process.c	2005-08-31 16:35:17.000000000 +0530
@@ -202,7 +202,10 @@ void cpu_idle(void)
 			if (cpu_is_offline(cpu))
 				play_dead();
 
-			dyn_tick_reprogram_timer();
+			local_irq_disable();
+			if (!need_resched())
+				dyn_tick_reprogram_timer();
+			local_irq_enable();
 
 			__get_cpu_var(irq_stat).idle_timestamp = jiffies;
 			idle();
diff -puN arch/i386/kernel/io_apic.c~cleanup arch/i386/kernel/io_apic.c
--- linux-2.6.13-rc6-mm2/arch/i386/kernel/io_apic.c~cleanup	2005-08-31 16:34:52.000000000 +0530
+++ linux-2.6.13-rc6-mm2-root/arch/i386/kernel/io_apic.c	2005-08-31 16:35:17.000000000 +0530
@@ -1148,7 +1148,11 @@ next:
 
 static struct hw_interrupt_type ioapic_level_type;
 static struct hw_interrupt_type ioapic_edge_type;
+#ifdef CONFIG_NO_IDLE_HZ
 static struct hw_interrupt_type ioapic_edge_type_irq0;
+#else
+#define ioapic_edge_type_irq0 ioapic_edge_type
+#endif
 
 #define IOAPIC_AUTO	-1
 #define IOAPIC_EDGE	0
@@ -2020,6 +2024,7 @@ static struct hw_interrupt_type ioapic_l
 #endif
 };
 
+#ifdef CONFIG_NO_IDLE_HZ
 /* Needed to disable PIT interrupts when all CPUs sleep */
 static struct hw_interrupt_type ioapic_edge_type_irq0 = {
 	.typename 	= "IO-APIC-edge-irq0",
@@ -2031,6 +2036,7 @@ static struct hw_interrupt_type ioapic_e
 	.end 		= end_edge_ioapic,
 	.set_affinity 	= set_ioapic_affinity,
 };
+#endif
 
 static inline void init_IO_APIC_traps(void)
 {

_

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
