Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbVL1GTA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbVL1GTA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 01:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbVL1GTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 01:19:00 -0500
Received: from mail20.syd.optusnet.com.au ([211.29.132.201]:55257 "EHLO
	mail20.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750783AbVL1GS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 01:18:59 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] i386 No Idle HZ aka dynticks 051228
Date: Wed, 28 Dec 2005 17:18:14 +1100
User-Agent: KMail/1.9
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Petrini <d.pensator@gmail.com>, Tony Lindgren <tony@atomide.com>,
       vatsa@in.ibm.com, ck list <ck@vds.kolivas.org>,
       Pavel Machek <pavel@ucw.cz>, Adam Belay <abelay@novell.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>
MIME-Version: 1.0
Message-Id: <200512281718.14897.kernel@kolivas.org>
X-Length: 66668
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the latest version of the dynticks code incorporating yet another
huge rewrite.

Major Changes:
I attempted to move all timer ticks to APIC interrupts and found them
awfully unreliable on any i386 architecture, so the dependency on PIT
timer ticking is mandatory.

There are now only 3 ways to skip ticks - PIT only, PIT skipping with local
APIC disabling on UP, and APIC skipping per cpu on SMP with PIT skipping when
all cpus are idle.

The detection of and handling of all cpus busy and idle was incorrect. This
has been fixed and optimised. The tick rate on SMP is now much higher than the
previous version which was basically broken. I'm not sure yet if I can get
this rate down.

One new exported function dyn_tick_allcpus_skipping because dyn_tick_skipping
returns only if this cpu is skipping.

Lots of code cleanups simplifying greatly the dynticks setup code were
put in place.

General cleanups, optimisations, patch merging etc.

All bugs that showed up from the previous version have been fixed.
Of course that doesn't mean there won't be new ones...

Please test and comment.

Latest patch, split patches and timer utilties available here:
http://ck.kolivas.org/patches/dyn-ticks/

Rolled up patch in this email.

Cheers,
Con
---
Implement i386 no-idle-hz aka dynticks rolled up patch.

Original code by Tony Lindgen <tony@atomide.com>,
Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>,
Srivatsa Vaddagiri <vatsa@in.ibm.com>,
Daniel Petrini <d.pensator@gmail.com> and
Dominik Brodowski <linux@dominikbrodowski.net>.

Rewritten and updated by Con Kolivas <kernel@kolivas.org>

Signed-off-by: Con Kolivas <kernel@kolivas.org>

 arch/i386/Kconfig                       |   20 ++
 arch/i386/defconfig                     |    1
 arch/i386/kernel/Makefile               |    1
 arch/i386/kernel/apic.c                 |   37 +++
 arch/i386/kernel/dyn-tick.c             |  263 +++++++++++++++++++++++++++
 arch/i386/kernel/irq.c                  |    4
 arch/i386/kernel/process.c              |    4
 arch/i386/kernel/smp.c                  |    9
 arch/i386/kernel/time.c                 |   19 +-
 arch/i386/kernel/timers/timer_cyclone.c |    4
 arch/i386/kernel/timers/timer_hpet.c    |    4
 arch/i386/kernel/timers/timer_none.c    |    3
 arch/i386/kernel/timers/timer_pit.c     |   22 ++
 arch/i386/kernel/timers/timer_pm.c      |   32 +--
 arch/i386/kernel/timers/timer_tsc.c     |   64 ++----
 drivers/acpi/Kconfig                    |    2
 drivers/acpi/processor_idle.c           |   77 +++++++-
 drivers/input/serio/i8042.h             |    2
 include/acpi/processor.h                |    3
 include/asm-i386/apic.h                 |    2
 include/asm-i386/dyn-tick.h             |   69 +++++++
 include/asm-i386/timer.h                |   37 +++
 include/linux/dyn-tick.h                |  170 +++++++++++++++++
 include/linux/timer.h                   |    1
 kernel/Makefile                         |    2
 kernel/dyn-tick.c                       |  304 ++++++++++++++++++++++++++++++++
 kernel/timer.c                          |   10 +
 kernel/timer_top.c                      |  234 ++++++++++++++++++++++++
 lib/Kconfig.debug                       |   13 +
 29 files changed, 1338 insertions(+), 75 deletions(-)

Index: linux-2.6.15-rc7-dt/include/linux/dyn-tick.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-rc7-dt/include/linux/dyn-tick.h	2005-12-28 16:38:54.000000000 +1100
@@ -0,0 +1,170 @@
+/*
+ * linux/include/linux/dyn-tick.h
+ *
+ * Copyright (C) 2004 Nokia Corporation
+ * Written by Tony Lindgen <tony@atomide.com> and
+ * Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
+ * Rewritten by Con Kolivas <kernel@kolivas.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _DYN_TICK_TIMER_H
+#define _DYN_TICK_TIMER_H
+
+#include <linux/interrupt.h>
+
+#define DYN_TICK_SKIPPING	(1 << 2)
+#define DYN_TICK_ENABLED	(1 << 1)
+#define DYN_TICK_SUITABLE	(1 << 0)
+
+/* Don't skip longer than NMI  */
+#define DYN_TICK_MAX_SKIP	(HZ * 5)
+
+struct dyn_tick_timer {
+	spinlock_t lock;
+
+	/* dyn_tick init */
+	int (*arch_init)(void);
+	/* Enables dynamic tick */
+	int (*arch_enable)(void);
+	/* Disables dynamic tick */
+	int (*arch_disable)(void);
+	/* Reprograms the timer */
+	void (*arch_reprogram)(unsigned long);
+	/* Function called when all cpus are idle, passing the idle duration */
+	void (*arch_all_cpus_idle)(unsigned int);
+
+	unsigned short state;		/* Current state */
+	unsigned int min_skip;		/* Min number of ticks to skip */
+	unsigned int max_skip;		/* Max number of ticks to skip */
+	unsigned long tick;		/* The next earliest tick */
+};
+
+typedef struct {
+	unsigned long next_tick;	/* Next tick we're skipping to */
+	unsigned long skip;		/* Ticks we're currently skipping */
+	unsigned int nohz_cpu;		/* This cpu is idle */
+} dyn_tick_data;
+
+extern struct dyn_tick_timer *dyn_tick;
+extern spinlock_t *dyn_tick_lock;
+
+extern void dyn_tick_register(struct dyn_tick_timer *new_timer);
+
+#ifdef CONFIG_NO_IDLE_HZ
+DECLARE_PER_CPU(dyn_tick_data, dyn_cpu);
+extern dyn_tick_data dyn_cpu;
+extern int dyn_tick_enabled(void);
+extern int dyn_tick_skipping(void);
+extern int dyn_tick_allcpus_skipping(void);
+extern int dyn_tick_current_skip(void);
+extern unsigned long dyn_tick_next_tick(void);
+extern void timer_dyn_reprogram(void);
+extern void dyn_early_reprogram(unsigned int delta);
+extern void set_dyn_tick_limits(unsigned int max_skip, unsigned int min_skip);
+
+/*
+ * The apparently redundant per_cpu nohz_cpu value is tested in this
+ * function and this is where we can avoid the cache thrashing of testing
+ * nohz_cpu_mask when possible.
+ */
+static inline int test_nohz_cpu(void)
+{
+	return __get_cpu_var(dyn_cpu).nohz_cpu;
+}
+
+/*
+ * This cpu is busy, clear the nohz_cpu value, test to see if all were idle
+ * till now. Returns whether all cpus were idle or not.
+ */
+static inline int clear_nohz_cpu(int cpu)
+{
+	int ret = 0;
+
+	if (!test_nohz_cpu())
+		return ret;
+	dyn_tick->tick = 0;
+	if (cpus_equal(nohz_cpu_mask, cpu_online_map)) {
+		dyn_tick->state &= ~DYN_TICK_SKIPPING;
+		ret = 1;
+	}
+	__get_cpu_var(dyn_cpu).next_tick = 0;
+	__get_cpu_var(dyn_cpu).nohz_cpu = 0;
+	cpu_clear(cpu, nohz_cpu_mask);
+	return ret;
+}
+
+/*
+ * This cpu has fallen idle, set the nohz_cpu value, test to see if all are
+ * idle, and if so do dyn_tick->arch_all_cpus_idle()
+ */
+static inline void set_nohz_cpu(int cpu)
+{
+	if (dyn_tick->tick <= jiffies ||
+		__get_cpu_var(dyn_cpu).next_tick < dyn_tick->tick)
+			dyn_tick->tick = __get_cpu_var(dyn_cpu).next_tick;
+
+	if (!test_nohz_cpu()) {
+		__get_cpu_var(dyn_cpu).nohz_cpu = 1;
+		cpu_set(cpu, nohz_cpu_mask);
+	}
+	if (cpus_equal(nohz_cpu_mask, cpu_online_map)) {
+		dyn_tick->state |= DYN_TICK_SKIPPING;
+		dyn_tick->arch_all_cpus_idle(dyn_tick->tick - jiffies);
+	}
+}
+
+#ifdef CONFIG_TIMER_INFO
+extern int account_timer(unsigned long function, unsigned long data);
+#else
+static inline int account_timer(unsigned long function, unsigned long data)
+{
+	return 0;
+}
+#endif
+
+#else	/* CONFIG_NO_IDLE_HZ */
+static inline int dyn_tick_enabled(void)
+{
+	return 0;
+}
+
+static inline int dyn_tick_skipping(void)
+{
+	return 0;
+}
+
+static inline int dyn_tick_allcpus_skipping(void)
+{
+	return 0;
+}
+
+static inline int dyn_tick_current_skip(void)
+{
+	return 0;
+}
+
+static inline unsigned long dyn_tick_next_tick(void)
+{
+	return 0;
+}
+
+static inline void set_dyn_tick_limits(unsigned int max_skip,
+	unsigned int min_skip)
+{
+}
+
+static inline void dyn_early_reprogram(unsigned int delta)
+{
+}
+
+static inline int account_timer(unsigned long function, unsigned long data)
+{
+	return 0;
+}
+#endif	/* CONFIG_NO_IDLE_HZ */
+
+#endif	/* _DYN_TICK_TIMER_H */
Index: linux-2.6.15-rc7-dt/include/linux/timer.h
===================================================================
--- linux-2.6.15-rc7-dt.orig/include/linux/timer.h	2005-12-28 16:37:36.000000000 +1100
+++ linux-2.6.15-rc7-dt/include/linux/timer.h	2005-12-28 16:37:37.000000000 +1100
@@ -97,5 +97,6 @@ static inline void add_timer(struct time
 extern void init_timers(void);
 extern void run_local_timers(void);
 extern void it_real_fn(unsigned long);
+extern void conditional_run_local_timers(void);
 
 #endif
Index: linux-2.6.15-rc7-dt/kernel/dyn-tick.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-rc7-dt/kernel/dyn-tick.c	2005-12-28 16:37:37.000000000 +1100
@@ -0,0 +1,304 @@
+/*
+ * linux/kernel/dyn-tick.c
+ *
+ * Generic dynamic tick timer support
+ *
+ * Copyright (C) 2004 Nokia Corporation
+ * Written by Tony Lindgen <tony@atomide.com> and
+ * Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
+ * Rewritten by Con Kolivas <kernel@kolivas.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/version.h>
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/sysdev.h>
+#include <linux/interrupt.h>
+#include <linux/cpumask.h>
+#include <linux/pm.h>
+#include <linux/dyn-tick.h>
+#include <linux/rcupdate.h>
+#include <asm/dyn-tick.h>
+
+#define DYN_TICK_VERSION	"051228"
+
+DEFINE_PER_CPU(dyn_tick_data, dyn_cpu);
+
+inline int dyn_tick_enabled(void)
+{
+	return !!(dyn_tick->state & DYN_TICK_ENABLED);
+}
+
+EXPORT_SYMBOL(dyn_tick_enabled);
+
+
+/*
+ * Returns if we are currently skipping ticks.
+ */
+int dyn_tick_skipping(void)
+{
+	int ret = (get_cpu_var(dyn_cpu).next_tick > jiffies);
+
+	put_cpu_var(dyn_cpu);
+	return ret;
+}
+
+EXPORT_SYMBOL(dyn_tick_skipping);
+
+inline int dyn_tick_allcpus_skipping(void)
+{
+	return !!(dyn_tick->state & DYN_TICK_SKIPPING);
+}
+
+EXPORT_SYMBOL(dyn_tick_allcpus_skipping);
+
+/*
+ * Returns the number of ticks we are currently skipping if we are skipping
+ */
+int dyn_tick_current_skip(void)
+{
+	int ret = 0;
+
+	if (get_cpu_var(dyn_cpu).next_tick > jiffies)
+		ret = __get_cpu_var(dyn_cpu).skip;
+	put_cpu_var(dyn_cpu);
+	return ret;
+}
+
+EXPORT_SYMBOL(dyn_tick_current_skip);
+
+/*
+ * Returns the next scheduled dyn_tick if we are skipping ticks.
+ */
+unsigned long dyn_tick_next_tick(void)
+{
+	unsigned long next = 0;
+
+	if (get_cpu_var(dyn_cpu).next_tick > jiffies)
+		next = __get_cpu_var(dyn_cpu).next_tick;
+	put_cpu_var(dyn_cpu);
+	return next;
+}
+
+EXPORT_SYMBOL(dyn_tick_next_tick);
+
+static inline int dyn_tick_suitable(void)
+{
+	return !!(dyn_tick->state & DYN_TICK_SUITABLE);
+}
+
+/*
+ * do_dyn_reprogram does the actual reprogramming. We should have already
+ * checked that the tick chosen is suitable, xtime_lock and dyn_tick->lock
+ * must be held, and interrupts disabled.
+ */
+static void do_dyn_reprogram(unsigned int delta)
+{
+	unsigned long next = jiffies + delta;
+
+	__get_cpu_var(dyn_cpu).next_tick = next;
+	__get_cpu_var(dyn_cpu).skip = delta;
+	dyn_tick->arch_reprogram(next);
+	/* We have to update the idle_timestamp */
+	__get_cpu_var(irq_stat).idle_timestamp = next;
+}
+
+/*
+ * Arch independent code needed to reprogram next timer interrupt.
+ * Gets called, with IRQs disabled, from cpu_idle() before entering idle loop
+ * If we are to acquire the xtime_lock we must acquire it before
+ * dyn_tick->lock
+ */
+void timer_dyn_reprogram(void)
+{
+	int cpu;
+	unsigned int delta;
+
+	if (!dyn_tick_enabled())
+		return;
+
+	cpu = smp_processor_id();
+	if (rcu_pending(cpu) || local_softirq_pending()) {
+		spin_lock(&dyn_tick->lock);
+		clear_nohz_cpu(cpu);
+		spin_unlock(&dyn_tick->lock);
+		return;
+	}
+
+	write_seqlock(&xtime_lock);
+	delta = next_timer_interrupt() - jiffies;
+	if (delta > dyn_tick->min_skip) {
+		if (delta > dyn_tick->max_skip)
+			delta = dyn_tick->max_skip;
+		spin_lock(&dyn_tick->lock);
+		do_dyn_reprogram(delta);
+		set_nohz_cpu(cpu);
+		spin_unlock(&dyn_tick->lock);
+	}
+	write_sequnlock(&xtime_lock);
+}
+
+/*
+ * dyn_early_reprogram is used to reprogram an earlier tick than is currently
+ * set by timer_dyn_reprogram.
+ * dyn_early_reprogram allows other code such as the acpi idle code to
+ * program an earlier tick than the one already chosen by timer_dyn_reprogram.
+ * It only reprograms it if the tick is earlier than the next one planned.
+ */
+void dyn_early_reprogram(unsigned int delta)
+{
+	unsigned long flags, tick = jiffies + delta;
+
+	if (tick >= get_cpu_var(dyn_cpu).next_tick &&
+		__get_cpu_var(dyn_cpu).next_tick > jiffies)
+			goto put_out;
+
+	write_seqlock_irqsave(&xtime_lock, flags);
+	spin_lock(&dyn_tick->lock);
+	do_dyn_reprogram(delta);
+	spin_unlock(&dyn_tick->lock);
+	write_sequnlock_irqrestore(&xtime_lock, flags);
+put_out:
+	put_cpu_var(dyn_cpu);
+}
+
+EXPORT_SYMBOL(dyn_early_reprogram);
+
+/*
+ * Set limits on minimum and maximum number of ticks to skip. The minimum
+ * may want to be set by other code but is at least one tick.
+ */
+void set_dyn_tick_limits(unsigned int max_skip, unsigned int min_skip)
+{
+	if (max_skip > DYN_TICK_MAX_SKIP)
+		max_skip = DYN_TICK_MAX_SKIP;
+	if (!dyn_tick->max_skip || max_skip < dyn_tick->max_skip)
+		dyn_tick->max_skip = max_skip;
+	if (min_skip < 1)
+		min_skip = 1;
+	if (min_skip > dyn_tick->min_skip)
+		dyn_tick->min_skip = min_skip;
+}
+
+void __init dyn_tick_register(struct dyn_tick_timer *arch_timer)
+{
+	dyn_tick = arch_timer;
+}
+
+/* Default to enabled */
+static int __initdata dyntick_autoenable = 1;
+
+/*
+ * Command line options.
+ *
+ *  dyntick=[enable|disable]
+ */
+static int __init dyntick_setup(char *options)
+{
+	if (!options)
+		return 0;
+
+	if (!strncmp(options, "enable", 5))
+		dyntick_autoenable = 1;
+	if (!strncmp(options, "disable", 6))
+		dyntick_autoenable = 0;
+
+	return 0;
+}
+
+__setup("dyntick=", dyntick_setup);
+
+/*
+ * Sysfs interface.
+ *
+ * Usually situated at:
+ *  /sys/devices/system/timer/timer0/dyn_tick
+ */
+extern struct sys_device device_timer;
+
+static ssize_t timer_show_dyn_tick(struct sys_device *dev, char *buf)
+{
+	return sprintf(buf, "%i\n", dyn_tick_enabled());
+}
+
+static ssize_t timer_set_dyn_tick(struct sys_device *dev, const char *buf,
+				  size_t count)
+{
+	unsigned long flags;
+	unsigned int enable = simple_strtoul(buf, NULL, 2);
+	int ret = -ENODEV;
+
+	write_seqlock_irqsave(&xtime_lock, flags);
+	if (enable) {
+		ret = dyn_tick->arch_enable();
+		if (ret == 0) {
+			spin_lock(&dyn_tick->lock);
+			dyn_tick->state |= DYN_TICK_ENABLED;
+			spin_unlock(&dyn_tick->lock);
+			printk(KERN_INFO
+				"dyn-tick: Enabling dynamic tick timer \n");
+		}
+	} else {
+		ret = dyn_tick->arch_disable();
+		if (ret == 0) {
+			spin_lock(&dyn_tick->lock);
+			dyn_tick->state &= ~DYN_TICK_ENABLED;
+			spin_unlock(&dyn_tick->lock);
+			printk(KERN_INFO
+				"dyn-tick: Disabling dynamic tick timer \n");
+		}
+	}
+	write_sequnlock_irqrestore(&xtime_lock, flags);
+
+	return count;
+}
+
+static SYSDEV_ATTR(dyn_tick, 0644, timer_show_dyn_tick, timer_set_dyn_tick);
+
+static int __init init_dyn_tick_sysfs(void)
+{
+	int ret = sysdev_create_file(&device_timer, &attr_dyn_tick);
+
+	return ret;
+}
+
+device_initcall(init_dyn_tick_sysfs);
+
+/*
+ * Init functions
+ *
+ * We need to initialise dynamic tick after calibrate delay
+ */
+static int __init dyn_tick_late_init(void)
+{
+	int ret;
+
+	if (dyn_tick == NULL || dyn_tick->arch_init == NULL ||
+	    !dyn_tick_suitable()) {
+		printk(KERN_ERR "dyn-tick: No suitable timer found\n");
+		return -ENODEV;
+	}
+
+	if ((ret = dyn_tick->arch_init())) {
+		printk(KERN_ERR "dyn-tick: Init failed\n");
+		return -ENODEV;
+	}
+
+	if (!ret && dyntick_autoenable) {
+		dyn_tick->state |= DYN_TICK_ENABLED;
+		printk(KERN_INFO "dyn-tick: Enabling dynamic tick timer v%s\n",
+			DYN_TICK_VERSION);
+	} else
+		printk(KERN_INFO "dyn-tick: Dynamic tick timer v%s disabled\n",
+			DYN_TICK_VERSION);
+
+	return ret;
+}
+
+late_initcall(dyn_tick_late_init);
Index: linux-2.6.15-rc7-dt/kernel/Makefile
===================================================================
--- linux-2.6.15-rc7-dt.orig/kernel/Makefile	2005-12-28 16:37:36.000000000 +1100
+++ linux-2.6.15-rc7-dt/kernel/Makefile	2005-12-28 16:38:54.000000000 +1100
@@ -32,6 +32,8 @@ obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
 obj-$(CONFIG_CRASH_DUMP) += crash_dump.o
 obj-$(CONFIG_SECCOMP) += seccomp.o
 obj-$(CONFIG_RCU_TORTURE_TEST) += rcutorture.o
+obj-$(CONFIG_NO_IDLE_HZ) += dyn-tick.o
+obj-$(CONFIG_TIMER_INFO) += timer_top.o
 
 ifneq ($(CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
Index: linux-2.6.15-rc7-dt/kernel/timer.c
===================================================================
--- linux-2.6.15-rc7-dt.orig/kernel/timer.c	2005-12-28 16:37:36.000000000 +1100
+++ linux-2.6.15-rc7-dt/kernel/timer.c	2005-12-28 16:38:54.000000000 +1100
@@ -33,6 +33,7 @@
 #include <linux/posix-timers.h>
 #include <linux/cpu.h>
 #include <linux/syscalls.h>
+#include <linux/dyn-tick.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -540,6 +541,8 @@ found:
 				expires = nte->expires;
 		}
 	}
+	account_timer((unsigned long)nte->function, nte->data);
+
 	spin_unlock(&base->t_base.lock);
 	return expires;
 }
@@ -869,6 +872,13 @@ void run_local_timers(void)
 	raise_softirq(TIMER_SOFTIRQ);
 }
 
+void conditional_run_local_timers(void)
+{
+	tvec_base_t *base  = &__get_cpu_var(tvec_bases);
+
+	if (base->timer_jiffies != jiffies)
+		run_local_timers();
+}
 /*
  * Called by the timer interrupt. xtime_lock must already be taken
  * by the timer IRQ!
Index: linux-2.6.15-rc7-dt/arch/i386/kernel/time.c
===================================================================
--- linux-2.6.15-rc7-dt.orig/arch/i386/kernel/time.c	2005-12-28 16:37:36.000000000 +1100
+++ linux-2.6.15-rc7-dt/arch/i386/kernel/time.c	2005-12-28 16:37:40.000000000 +1100
@@ -46,6 +46,7 @@
 #include <linux/bcd.h>
 #include <linux/efi.h>
 #include <linux/mca.h>
+#include <linux/dyn-tick.h>
 
 #include <asm/io.h>
 #include <asm/smp.h>
@@ -56,6 +57,7 @@
 #include <asm/uaccess.h>
 #include <asm/processor.h>
 #include <asm/timer.h>
+#include <asm/dyn-tick.h>
 
 #include "mach_time.h"
 
@@ -245,7 +247,7 @@ EXPORT_SYMBOL(profile_pc);
  * timer_interrupt() needs to keep up the real-time clock,
  * as well as call the "do_timer()" routine every clocktick
  */
-static inline void do_timer_interrupt(int irq, struct pt_regs *regs)
+static inline void do_timer_interrupt(int irq, struct pt_regs *regs, int lost)
 {
 #ifdef CONFIG_X86_IO_APIC
 	if (timer_ack) {
@@ -263,7 +265,8 @@ static inline void do_timer_interrupt(in
 	}
 #endif
 
-	do_timer_interrupt_hook(regs);
+	if (!dyn_tick_enabled() || lost)
+		do_timer_interrupt_hook(regs);
 
 
 	if (MCA_bus) {
@@ -288,6 +291,8 @@ static inline void do_timer_interrupt(in
  */
 irqreturn_t timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
+	int lost;
+
 	/*
 	 * Here we are in the timer irq handler. We just have irqs locally
 	 * disabled but we don't know if the timer_bh is running on the other
@@ -297,9 +302,9 @@ irqreturn_t timer_interrupt(int irq, voi
 	 */
 	write_seqlock(&xtime_lock);
 
-	cur_timer->mark_offset();
- 
-	do_timer_interrupt(irq, regs);
+	lost = cur_timer->mark_offset();
+
+	do_timer_interrupt(irq, regs, lost);
 
 	write_sequnlock(&xtime_lock);
 	return IRQ_HANDLED;
@@ -425,7 +430,7 @@ static struct sysdev_class timer_sysclas
 
 
 /* XXX this driverfs stuff should probably go elsewhere later -john */
-static struct sys_device device_timer = {
+struct sys_device device_timer = {
 	.id	= 0,
 	.cls	= &timer_sysclass,
 };
@@ -481,5 +486,7 @@ void __init time_init(void)
 	cur_timer = select_timer();
 	printk(KERN_INFO "Using %s for high-res timesource\n",cur_timer->name);
 
+	dyn_tick_time_init(cur_timer);
+
 	time_init_hook();
 }
Index: linux-2.6.15-rc7-dt/arch/i386/kernel/timers/timer_cyclone.c
===================================================================
--- linux-2.6.15-rc7-dt.orig/arch/i386/kernel/timers/timer_cyclone.c	2005-12-28 16:37:36.000000000 +1100
+++ linux-2.6.15-rc7-dt/arch/i386/kernel/timers/timer_cyclone.c	2005-12-28 16:37:39.000000000 +1100
@@ -45,7 +45,7 @@ static seqlock_t monotonic_lock = SEQLOC
 	} while (high != cyclone_timer[1]);
 
 
-static void mark_offset_cyclone(void)
+static int mark_offset_cyclone(void)
 {
 	unsigned long lost, delay;
 	unsigned long delta = last_cyclone_low;
@@ -101,6 +101,8 @@ static void mark_offset_cyclone(void)
 	 */
 	if (lost && abs(delay - delay_at_last_interrupt) > (900000/HZ))
 		jiffies_64++;
+
+	return lost;
 }
 
 static unsigned long get_offset_cyclone(void)
Index: linux-2.6.15-rc7-dt/arch/i386/kernel/timers/timer_hpet.c
===================================================================
--- linux-2.6.15-rc7-dt.orig/arch/i386/kernel/timers/timer_hpet.c	2005-12-28 16:37:36.000000000 +1100
+++ linux-2.6.15-rc7-dt/arch/i386/kernel/timers/timer_hpet.c	2005-12-28 16:37:39.000000000 +1100
@@ -101,7 +101,7 @@ static unsigned long get_offset_hpet(voi
 	return edx;
 }
 
-static void mark_offset_hpet(void)
+static int mark_offset_hpet(void)
 {
 	unsigned long long this_offset, last_offset;
 	unsigned long offset;
@@ -124,6 +124,8 @@ static void mark_offset_hpet(void)
 	this_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
 	monotonic_base += cycles_2_ns(this_offset - last_offset);
 	write_sequnlock(&monotonic_lock);
+
+	return 1;
 }
 
 static void delay_hpet(unsigned long loops)
Index: linux-2.6.15-rc7-dt/arch/i386/kernel/timers/timer_none.c
===================================================================
--- linux-2.6.15-rc7-dt.orig/arch/i386/kernel/timers/timer_none.c	2005-12-28 16:37:36.000000000 +1100
+++ linux-2.6.15-rc7-dt/arch/i386/kernel/timers/timer_none.c	2005-12-28 16:37:39.000000000 +1100
@@ -1,9 +1,10 @@
 #include <linux/init.h>
 #include <asm/timer.h>
 
-static void mark_offset_none(void)
+static int mark_offset_none(void)
 {
 	/* nothing needed */
+	return 1;
 }
 
 static unsigned long get_offset_none(void)
Index: linux-2.6.15-rc7-dt/arch/i386/kernel/timers/timer_pit.c
===================================================================
--- linux-2.6.15-rc7-dt.orig/arch/i386/kernel/timers/timer_pit.c	2005-12-28 16:37:36.000000000 +1100
+++ linux-2.6.15-rc7-dt/arch/i386/kernel/timers/timer_pit.c	2005-12-28 16:37:40.000000000 +1100
@@ -32,9 +32,10 @@ static int __init init_pit(char* overrid
 	return 0;
 }
 
-static void mark_offset_pit(void)
+static int mark_offset_pit(void)
 {
 	/* nothing needed */
+	return 1;
 }
 
 static unsigned long long monotonic_clock_pit(void)
@@ -148,6 +149,25 @@ static unsigned long get_offset_pit(void
 	return count;
 }
 
+/*
+ * Reprograms the next timer interrupt
+ * PIT timer reprogramming code taken from APM code.
+ * Note that PIT timer is a 16-bit timer.
+ * Called with irqs already disabled.
+ */
+void reprogram_pit_timer(unsigned long jiffies_to_skip)
+{
+	int skip = jiffies_to_skip * LATCH;
+
+	if (skip > 0xffff)
+		skip = 0xffff;
+
+	spin_lock(&i8253_lock);
+	outb_p(0x34, PIT_MODE);		/* binary, mode 2, LSB/MSB, ch 0 */
+	outb_p(skip & 0xff, PIT_CH0);	/* LSB */
+	outb(skip >> 8, PIT_CH0);	/* MSB */
+	spin_unlock(&i8253_lock);
+}
 
 /* tsc timer_opts struct */
 struct timer_opts timer_pit = {
Index: linux-2.6.15-rc7-dt/arch/i386/kernel/timers/timer_pm.c
===================================================================
--- linux-2.6.15-rc7-dt.orig/arch/i386/kernel/timers/timer_pm.c	2005-12-28 16:37:36.000000000 +1100
+++ linux-2.6.15-rc7-dt/arch/i386/kernel/timers/timer_pm.c	2005-12-28 16:38:54.000000000 +1100
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/init.h>
+#include <linux/dyn-tick.h>
 #include <asm/types.h>
 #include <asm/timer.h>
 #include <asm/smp.h>
@@ -28,7 +29,7 @@
 #define PMTMR_TICKS_PER_SEC 3579545
 #define PMTMR_EXPECTED_RATE \
   ((CALIBRATE_LATCH * (PMTMR_TICKS_PER_SEC >> 10)) / (CLOCK_TICK_RATE>>10))
-
+#define PMTMR_TICKS_PER_JIFFY (PMTMR_EXPECTED_RATE / (CALIBRATE_LATCH/LATCH))
 
 /* The I/O port the PMTMR resides at.
  * The location is detected during setup_arch(),
@@ -127,7 +128,13 @@ pm_good:
 	if (verify_pmtmr_rate() != 0)
 		return -ENODEV;
 
+	printk("Using %u PM timer ticks per jiffy \n", PMTMR_TICKS_PER_JIFFY);
+
+	offset_tick = read_pmtmr();
+	setup_pit_timer();
+
 	init_cpu_khz();
+	set_dyn_tick_limits((0xFFFFFF / (286 * 1000000)) * 1024 * HZ, 0);
 	return 0;
 }
 
@@ -148,10 +155,9 @@ static inline u32 cyc2us(u32 cycles)
  * this gets called during each timer interrupt
  *   - Called while holding the writer xtime_lock
  */
-static void mark_offset_pmtmr(void)
+static int mark_offset_pmtmr(void)
 {
 	u32 lost, delta, last_offset;
-	static int first_run = 1;
 	last_offset = offset_tick;
 
 	write_seqlock(&monotonic_lock);
@@ -161,29 +167,20 @@ static void mark_offset_pmtmr(void)
 	/* calculate tick interval */
 	delta = (offset_tick - last_offset) & ACPI_PM_MASK;
 
-	/* convert to usecs */
-	delta = cyc2us(delta);
-
 	/* update the monotonic base value */
-	monotonic_base += delta * NSEC_PER_USEC;
+	monotonic_base += cyc2us(delta) * NSEC_PER_USEC;
 	write_sequnlock(&monotonic_lock);
 
 	/* convert to ticks */
 	delta += offset_delay;
-	lost = delta / (USEC_PER_SEC / HZ);
-	offset_delay = delta % (USEC_PER_SEC / HZ);
-
+	lost = delta / PMTMR_TICKS_PER_JIFFY;
+	offset_delay = delta % PMTMR_TICKS_PER_JIFFY;
 
 	/* compensate for lost ticks */
 	if (lost >= 2)
 		jiffies_64 += lost - 1;
 
-	/* don't calculate delay for first run,
-	   or if we've got less then a tick */
-	if (first_run || (lost < 1)) {
-		first_run = 0;
-		offset_delay = 0;
-	}
+	return lost;
 }
 
 static int pmtmr_resume(void)
@@ -192,6 +189,7 @@ static int pmtmr_resume(void)
 	/* Assume this is the last mark offset time */
 	offset_tick = read_pmtmr();
 	write_sequnlock(&monotonic_lock);
+	offset_delay = 0;
 	return 0;
 }
 
@@ -243,7 +241,7 @@ static unsigned long get_offset_pmtmr(vo
 	now = read_pmtmr();
 	delta = (now - offset)&ACPI_PM_MASK;
 
-	return (unsigned long) offset_delay + cyc2us(delta);
+	return (unsigned long) cyc2us(delta + offset_delay);
 }
 
 
Index: linux-2.6.15-rc7-dt/arch/i386/kernel/timers/timer_tsc.c
===================================================================
--- linux-2.6.15-rc7-dt.orig/arch/i386/kernel/timers/timer_tsc.c	2005-12-28 16:37:36.000000000 +1100
+++ linux-2.6.15-rc7-dt/arch/i386/kernel/timers/timer_tsc.c	2005-12-28 16:37:40.000000000 +1100
@@ -14,6 +14,7 @@
 #include <linux/cpufreq.h>
 #include <linux/string.h>
 #include <linux/jiffies.h>
+#include <linux/dyn-tick.h>
 
 #include <asm/timer.h>
 #include <asm/io.h>
@@ -32,8 +33,6 @@ static unsigned long hpet_last;
 static struct timer_opts timer_tsc;
 #endif
 
-static inline void cpufreq_delayed_get(void);
-
 int tsc_disable __devinitdata = 0;
 
 static int use_tsc;
@@ -171,11 +170,21 @@ static void delay_tsc(unsigned long loop
 	} while ((now-bclock) < loops);
 }
 
+/* update the monotonic base value */
+static inline void update_monotonic_base(unsigned long long last_offset)
+{
+	unsigned long long this_offset;
+
+	this_offset = ((unsigned long long)last_tsc_high << 32) | last_tsc_low;
+	monotonic_base += cycles_2_ns(this_offset - last_offset);
+}
+
 #ifdef CONFIG_HPET_TIMER
-static void mark_offset_tsc_hpet(void)
+static int mark_offset_tsc_hpet(void)
 {
-	unsigned long long this_offset, last_offset;
- 	unsigned long offset, temp, hpet_current;
+	unsigned long long last_offset;
+	unsigned long offset, temp, hpet_current;
+	int lost_ticks = 0;
 
 	write_seqlock(&monotonic_lock);
 	last_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
@@ -197,14 +206,12 @@ static void mark_offset_tsc_hpet(void)
 	/* lost tick compensation */
 	offset = hpet_readl(HPET_T0_CMP) - hpet_tick;
 	if (unlikely(((offset - hpet_last) > hpet_tick) && (hpet_last != 0))) {
-		int lost_ticks = (offset - hpet_last) / hpet_tick;
+		lost_ticks = (offset - hpet_last) / hpet_tick;
 		jiffies_64 += lost_ticks;
 	}
 	hpet_last = hpet_current;
 
-	/* update the monotonic base value */
-	this_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
-	monotonic_base += cycles_2_ns(this_offset - last_offset);
+	update_monotonic_base(last_offset);
 	write_sequnlock(&monotonic_lock);
 
 	/* calculate delay_at_last_interrupt */
@@ -218,6 +225,8 @@ static void mark_offset_tsc_hpet(void)
 	delay_at_last_interrupt = hpet_current - offset;
 	ASM_MUL64_REG(temp, delay_at_last_interrupt,
 			hpet_usec_quotient, delay_at_last_interrupt);
+
+	return lost_ticks;
 }
 #endif
 
@@ -242,7 +251,7 @@ static void handle_cpufreq_delayed_get(v
  * to verify the CPU frequency the timing core thinks the CPU is running
  * at is still correct.
  */
-static inline void cpufreq_delayed_get(void) 
+void cpufreq_delayed_get(void)
 {
 	if (cpufreq_init && !cpufreq_delayed_issched) {
 		cpufreq_delayed_issched = 1;
@@ -321,7 +330,7 @@ static int __init cpufreq_tsc(void)
 core_initcall(cpufreq_tsc);
 
 #else /* CONFIG_CPU_FREQ */
-static inline void cpufreq_delayed_get(void) { return; }
+void cpufreq_delayed_get(void) { return; }
 #endif 
 
 int recalibrate_cpu_khz(void)
@@ -344,15 +353,14 @@ int recalibrate_cpu_khz(void)
 }
 EXPORT_SYMBOL(recalibrate_cpu_khz);
 
-static void mark_offset_tsc(void)
+static int mark_offset_tsc(void)
 {
 	unsigned long lost,delay;
 	unsigned long delta = last_tsc_low;
 	int count;
 	int countmp;
 	static int count1 = 0;
-	unsigned long long this_offset, last_offset;
-	static int lost_count = 0;
+	unsigned long long last_offset;
 
 	write_seqlock(&monotonic_lock);
 	last_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
@@ -419,29 +427,9 @@ static void mark_offset_tsc(void)
 	delta += delay_at_last_interrupt;
 	lost = delta/(1000000/HZ);
 	delay = delta%(1000000/HZ);
-	if (lost >= 2) {
-		jiffies_64 += lost-1;
+	tsc_sanity_check(lost);
 
-		/* sanity check to ensure we're not always losing ticks */
-		if (lost_count++ > 100) {
-			printk(KERN_WARNING "Losing too many ticks!\n");
-			printk(KERN_WARNING "TSC cannot be used as a timesource.  \n");
-			printk(KERN_WARNING "Possible reasons for this are:\n");
-			printk(KERN_WARNING "  You're running with Speedstep,\n");
-			printk(KERN_WARNING "  You don't have DMA enabled for your hard disk (see hdparm),\n");
-			printk(KERN_WARNING "  Incorrect TSC synchronization on an SMP system (see dmesg).\n");
-			printk(KERN_WARNING "Falling back to a sane timesource now.\n");
-
-			clock_fallback();
-		}
-		/* ... but give the TSC a fair chance */
-		if (lost_count > 25)
-			cpufreq_delayed_get();
-	} else
-		lost_count = 0;
-	/* update the monotonic base value */
-	this_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
-	monotonic_base += cycles_2_ns(this_offset - last_offset);
+	update_monotonic_base(last_offset);
 	write_sequnlock(&monotonic_lock);
 
 	/* calculate delay_at_last_interrupt */
@@ -454,6 +442,8 @@ static void mark_offset_tsc(void)
 	 */
 	if (lost && abs(delay - delay_at_last_interrupt) > (900000/HZ))
 		jiffies_64++;
+
+	return lost;
 }
 
 static int __init init_tsc(char* override)
@@ -542,6 +532,8 @@ static int __init init_tsc(char* overrid
 					cpu_khz / 1000, cpu_khz % 1000);
 			}
 			set_cyc2ns_scale(cpu_khz);
+			set_dyn_tick_limits((0xFFFFFFFF / (cpu_khz * 1000)) *
+				HZ, 0);
 			return 0;
 		}
 	}
Index: linux-2.6.15-rc7-dt/include/asm-i386/timer.h
===================================================================
--- linux-2.6.15-rc7-dt.orig/include/asm-i386/timer.h	2005-12-28 16:37:36.000000000 +1100
+++ linux-2.6.15-rc7-dt/include/asm-i386/timer.h	2005-12-28 16:37:40.000000000 +1100
@@ -1,5 +1,6 @@
 #ifndef _ASMi386_TIMER_H
 #define _ASMi386_TIMER_H
+#include <linux/jiffies.h>
 #include <linux/init.h>
 #include <linux/pm.h>
 
@@ -19,7 +20,7 @@
  */
 struct timer_opts {
 	char* name;
-	void (*mark_offset)(void);
+	int (*mark_offset)(void);
 	unsigned long (*get_offset)(void);
 	unsigned long long (*monotonic_clock)(void);
 	void (*delay)(unsigned long);
@@ -38,6 +39,7 @@ struct init_timer_opts {
 extern struct timer_opts* __init select_timer(void);
 extern void clock_fallback(void);
 void setup_pit_timer(void);
+extern void reprogram_pit_timer(unsigned long jiffies_to_skip);
 
 /* Modifiers for buggy PIT handling */
 
@@ -67,4 +69,37 @@ extern unsigned long calibrate_tsc_hpet(
 #ifdef CONFIG_X86_PM_TIMER
 extern struct init_timer_opts timer_pmtmr_init;
 #endif
+#ifdef CONFIG_NO_IDLE_HZ
+static inline void tsc_sanity_check(int lost)
+{
+}
+#else /* CONFIG_NO_IDLE_HZ */
+extern void cpufreq_delayed_get(void);
+
+static inline void tsc_sanity_check(int lost)
+{
+	static int lost_count = 0;
+
+	if (lost >= 2) {
+		jiffies_64 += lost-1;
+
+		/* sanity check to ensure we're not always losing ticks */
+		if (lost_count++ > 100) {
+			printk(KERN_WARNING "Losing too many ticks!\n");
+			printk(KERN_WARNING "TSC cannot be used as a timesource.  \n");
+			printk(KERN_WARNING "Possible reasons for this are:\n");
+			printk(KERN_WARNING "  You're running with Speedstep,\n");
+			printk(KERN_WARNING "  You don't have DMA enabled for your hard disk (see hdparm),\n");
+			printk(KERN_WARNING "  Incorrect TSC synchronization on an SMP system (see dmesg).\n");
+			printk(KERN_WARNING "Falling back to a sane timesource now.\n");
+
+			clock_fallback();
+		}
+		/* ... but give the TSC a fair chance */
+		if (lost_count > 25)
+			cpufreq_delayed_get();
+	} else
+		lost_count = 0;
+}
+#endif /* CONFIG_NO_IDLE_HZ */
 #endif
Index: linux-2.6.15-rc7-dt/drivers/acpi/Kconfig
===================================================================
--- linux-2.6.15-rc7-dt.orig/drivers/acpi/Kconfig	2005-12-28 16:37:36.000000000 +1100
+++ linux-2.6.15-rc7-dt/drivers/acpi/Kconfig	2005-12-28 16:37:40.000000000 +1100
@@ -301,6 +301,8 @@ config X86_PM_TIMER
 	  voltage scaling, unlike the commonly used Time Stamp Counter
 	  (TSC) timing source.
 
+	  This timer is selected by dyntick (NO_IDLE_HZ).
+
 	  So, if you see messages like 'Losing too many ticks!' in the
 	  kernel logs, and/or you are using this on a notebook which
 	  does not yet have an HPET, you should say "Y" here.
Index: linux-2.6.15-rc7-dt/arch/i386/defconfig
===================================================================
--- linux-2.6.15-rc7-dt.orig/arch/i386/defconfig	2005-12-28 16:37:36.000000000 +1100
+++ linux-2.6.15-rc7-dt/arch/i386/defconfig	2005-12-28 16:37:40.000000000 +1100
@@ -91,6 +91,7 @@ CONFIG_X86_INTEL_USERCOPY=y
 CONFIG_X86_USE_PPRO_CHECKSUM=y
 # CONFIG_HPET_TIMER is not set
 # CONFIG_HPET_EMULATE_RTC is not set
+# CONFIG_NO_IDLE_HZ is not set
 CONFIG_SMP=y
 CONFIG_NR_CPUS=8
 CONFIG_SCHED_SMT=y
Index: linux-2.6.15-rc7-dt/arch/i386/Kconfig
===================================================================
--- linux-2.6.15-rc7-dt.orig/arch/i386/Kconfig	2005-12-28 16:37:36.000000000 +1100
+++ linux-2.6.15-rc7-dt/arch/i386/Kconfig	2005-12-28 16:37:40.000000000 +1100
@@ -173,6 +173,26 @@ config HPET_EMULATE_RTC
 	depends on HPET_TIMER && RTC=y
 	default y
 
+config NO_IDLE_HZ
+	bool "Dynamic Tick Timer - Skip timer ticks during idle"
+	depends on EXPERIMENTAL
+	select X86_PM_TIMER
+	help
+	  This option enables support for skipping timer ticks when the
+	  processor is idle. During system load, timer is continuous.
+	  This option saves power, as it allows the system to stay in
+	  idle mode longer. Currently the only supported timer is ACPI PM
+	  timer.
+
+	  Note that you can disable dynamic tick timer either by
+	  passing dyntick=disable command line option, or via sysfs:
+
+	  # echo 0 > /sys/devices/system/timer/timer0/dyn_tick
+
+	  Most users wishing to lower their power usage while retaining
+	  low latencies will most likely want to say Y here in combination
+	  with a high HZ value (eg 1000).
+
 config SMP
 	bool "Symmetric multi-processing support"
 	---help---
Index: linux-2.6.15-rc7-dt/arch/i386/kernel/apic.c
===================================================================
--- linux-2.6.15-rc7-dt.orig/arch/i386/kernel/apic.c	2005-12-28 16:37:36.000000000 +1100
+++ linux-2.6.15-rc7-dt/arch/i386/kernel/apic.c	2005-12-28 16:37:40.000000000 +1100
@@ -26,6 +26,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/sysdev.h>
 #include <linux/cpu.h>
+#include <linux/dyn-tick.h>
 
 #include <asm/atomic.h>
 #include <asm/smp.h>
@@ -35,10 +36,12 @@
 #include <asm/arch_hooks.h>
 #include <asm/hpet.h>
 #include <asm/i8253.h>
+#include <asm/dyn-tick.h>
 
 #include <mach_apic.h>
 
 #include "io_ports.h"
+#include "do_timer.h"
 
 /*
  * Knob to control our willingness to enable the local APIC.
@@ -932,6 +935,8 @@ void (*wait_timer_tick)(void) __devinitd
 
 #define APIC_DIVISOR 16
 
+static u32 apic_timer_val __read_mostly;
+
 static void __setup_APIC_LVTT(unsigned int clocks)
 {
 	unsigned int lvtt_value, tmp_value, ver;
@@ -950,7 +955,9 @@ static void __setup_APIC_LVTT(unsigned i
 				& ~(APIC_TDR_DIV_1 | APIC_TDR_DIV_TMBASE))
 				| APIC_TDR_DIV_16);
 
-	apic_write_around(APIC_TMICT, clocks/APIC_DIVISOR);
+	apic_timer_val = clocks / APIC_DIVISOR;
+
+	apic_write_around(APIC_TMICT, apic_timer_val);
 }
 
 static void __devinit setup_APIC_timer(unsigned int clocks)
@@ -970,6 +977,17 @@ static void __devinit setup_APIC_timer(u
 }
 
 /*
+ * Used by NO_IDLE_HZ to skip ticks on idle CPUs. Called with IRQs already
+ * disabled
+ */
+void reprogram_apic_timer(unsigned long count)
+{
+	count = count * apic_timer_val;
+	apic_read(APIC_TMICT);
+	apic_write_around(APIC_TMICT, count);
+}
+
+/*
  * In this function we calibrate APIC bus clocks to the external
  * timer. Unfortunately we cannot use jiffies and the timer irq
  * to calibrate, since some later bootup code depends on getting
@@ -1064,6 +1082,10 @@ void __init setup_boot_APIC_clock(void)
 	 */
 	setup_APIC_timer(calibration_result);
 
+	setup_dyn_tick_use_apic(calibration_result);
+	set_dyn_tick_limits((0xFFFFFFFF / calibration_result) * APIC_DIVISOR,
+		2);
+
 	local_irq_restore(flags);
 }
 
@@ -1072,7 +1094,7 @@ void __devinit setup_secondary_APIC_cloc
 	setup_APIC_timer(calibration_result);
 }
 
-void __devinit disable_APIC_timer(void)
+void disable_APIC_timer(void)
 {
 	if (using_apic_timer) {
 		unsigned long v;
@@ -1132,10 +1154,12 @@ int setup_profiling_timer(unsigned int m
  * value into /proc/profile.
  */
 
-inline void smp_local_timer_interrupt(struct pt_regs * regs)
+void smp_local_timer_interrupt(struct pt_regs * regs)
 {
 	int cpu = smp_processor_id();
 
+	dyn_tick_interrupt(regs);
+
 	profile_tick(CPU_PROFILING, regs);
 	if (--per_cpu(prof_counter, cpu) <= 0) {
 		/*
@@ -1202,6 +1226,7 @@ fastcall void smp_apic_timer_interrupt(s
 	 * interrupt lock, which is the WrongThing (tm) to do.
 	 */
 	irq_enter();
+
 	smp_local_timer_interrupt(regs);
 	irq_exit();
 }
@@ -1214,6 +1239,9 @@ fastcall void smp_spurious_interrupt(str
 	unsigned long v;
 
 	irq_enter();
+
+	dyn_tick_interrupt(regs);
+
 	/*
 	 * Check if this really is a spurious interrupt and ACK it
 	 * if it is a vectored one.  Just in case...
@@ -1238,6 +1266,9 @@ fastcall void smp_error_interrupt(struct
 	unsigned long v, v1;
 
 	irq_enter();
+
+	dyn_tick_interrupt(regs);
+
 	/* First tickle the hardware, only then report what went on. -- REW */
 	v = apic_read(APIC_ESR);
 	apic_write(APIC_ESR, 0);
Index: linux-2.6.15-rc7-dt/arch/i386/kernel/dyn-tick.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-rc7-dt/arch/i386/kernel/dyn-tick.c	2005-12-28 16:38:25.000000000 +1100
@@ -0,0 +1,263 @@
+/*
+ * linux/arch/i386/kernel/dyn-tick.c
+ *
+ * Copyright (C) 2004 Nokia Corporation
+ * Written by Tony Lindgen <tony@atomide.com> and
+ * Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
+ * Rewritten by Con Kolivas <kernel@kolivas.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/version.h>
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/dyn-tick.h>
+#include <linux/timer.h>
+#include <linux/irq.h>
+#include <linux/kernel_stat.h>
+#include <linux/delay.h>
+#include <asm/apic.h>
+#include <asm/dyn-tick.h>
+#include <asm/io.h>
+#include <asm/arch_hooks.h>
+#include "do_timer.h"
+
+/*
+ * These handlers deal with all cpus idle on either UP or SMP.
+ */
+static void reprogram_pit_handler(unsigned int skip)
+{
+	reprogram_pit_timer(skip);
+}
+
+static void smp_idle_handler(unsigned int skip)
+{
+	if (skip > PIT_MAX_SKIP) {
+		skip = PIT_MAX_SKIP;
+		dyn_tick->tick = jiffies + skip;
+	}
+	reprogram_pit_timer(skip);
+}
+
+/*
+ * These reset functions start timers at maximum frequency when the cpus are
+ * busy again or when dynticks are disabled
+ */
+static inline void reset_pit_timer(void)
+{
+	reprogram_pit_timer(1);
+}
+
+static void reset_apic_timer(void)
+{
+	reprogram_apic_timer(1);
+}
+
+/*
+ * Null handlers are used initially while APIC timers are set up as ticks
+ * start before the APIC timer is enabled and do_timer_interrupt_hook
+ * changes its behaviour after they are started
+ */
+static void null_reprogram(unsigned long __unused)
+{
+}
+
+static void null_idle_handler(unsigned int __unused)
+{
+}
+
+static void null_wake(void)
+{
+}
+
+/*
+ * Labels for the different skip mechanisms used
+ */
+enum skip_handler {
+	SKIP_PIT,
+	SKIP_APIC,
+	SKIP_SMP_APIC,
+};
+
+struct dyn_handler {
+	enum skip_handler skip_handler;
+	void (*cpu_wake)(void);
+} dyn_handler = {
+	.skip_handler = SKIP_PIT,
+	.cpu_wake = &null_wake,
+};
+
+/*
+ * The per cpu APIC timer skip function
+ */
+static void apic_reprogram(unsigned long jif_next)
+{
+	reprogram_apic_timer(jif_next - jiffies);
+}
+
+static int arch_enable(void)
+{
+	switch (dyn_handler.skip_handler) {
+		case SKIP_APIC:
+			stop_local_apic();
+		default:
+			break;
+	}
+	return 0;
+}
+
+static int arch_disable(void)
+{
+	reset_pit_timer();
+	switch (dyn_handler.skip_handler) {
+		case SKIP_PIT:
+			break;
+		case SKIP_APIC:
+			start_local_apic();
+			break;
+		case SKIP_SMP_APIC:
+			reset_apic_timer();
+			break;
+	}
+	return 0;
+}
+
+static struct dyn_tick_timer arch_dyn_tick = {
+	.lock			= SPIN_LOCK_UNLOCKED,
+	.arch_reprogram		= &null_reprogram,
+	.arch_all_cpus_idle	= &null_idle_handler,
+	.arch_enable		= &arch_enable,
+	.arch_disable		= &arch_disable,
+};
+
+struct dyn_tick_timer *dyn_tick = &arch_dyn_tick;
+
+/*
+ * Only PIT timer skipping is reliable so this is used on all configurations.
+ * All PIT skipping is done from arch_all_cpus_idle in either UP or SMP.
+ * When local APIC support on UP is enabled, the local APIC timer is disabled
+ * when dynticks is enabled and the PIT timer is used. On SMP each cpu also
+ * skips APIC ticks according to its own next timer interrupt from
+ * arch_reprogram.
+ */
+int __init dyn_tick_arch_init(void)
+{
+	if (dyn_handler.skip_handler == SKIP_APIC && num_present_cpus()> 1)
+		dyn_handler.skip_handler = SKIP_SMP_APIC;
+
+	switch (dyn_handler.skip_handler) {
+		case SKIP_PIT:
+			printk(KERN_INFO "dyn-tick: Using PIT "
+				"reprogramming\n");
+			dyn_tick->arch_all_cpus_idle = &reprogram_pit_handler;
+			set_dyn_tick_limits(PIT_MAX_SKIP, 1);
+			break;
+		case SKIP_APIC:
+			printk(KERN_INFO "dyn-tick: Disabling APIC timer, "
+				"using PIT reprogramming\n");
+			dyn_tick->arch_all_cpus_idle = &reprogram_pit_handler;
+			set_dyn_tick_limits(PIT_MAX_SKIP, 1);
+			stop_local_apic();
+			break;
+		case SKIP_SMP_APIC:
+			printk(KERN_INFO "dyn-tick: Using per cpu APIC "
+				"reprogramming, skipping PIT when all cpus "
+				"idle\n");
+			dyn_tick->arch_reprogram = &apic_reprogram;
+			dyn_tick->arch_all_cpus_idle = &smp_idle_handler;
+			dyn_handler.cpu_wake = &reset_apic_timer;
+			break;
+	}
+	cpus_clear(nohz_cpu_mask);
+	printk(KERN_INFO "dyn-tick: Maximum ticks to skip limited to %i\n",
+		dyn_tick->max_skip);
+
+	return 0;
+}
+
+static int __init dyn_tick_init(void)
+{
+	dyn_tick->arch_init = dyn_tick_arch_init;
+	dyn_tick_register(&arch_dyn_tick);
+
+	return 0;
+}
+
+arch_initcall(dyn_tick_init);
+
+void __init setup_dyn_tick_use_apic(unsigned int calibration_result)
+{
+	dyn_handler.skip_handler = SKIP_APIC;
+}
+
+/*
+ * When an interrupt occurs on a cpu that is already skipping, that cpu's
+ * timer is restarted at maximum frequency with cpu_wake if needed on SMP.
+ * The nohz_cpu_mask is checked at this point to see if all cpus are idle.
+ * When all cpus are detected as being idle (which is always true on UP when
+ * one is idle), the PIT timer is restarted at maximum frequency, and lost
+ * ticks are accounted for.
+ */
+static void do_dyn_tick_interrupt(struct pt_regs *regs)
+{
+	int cpu = smp_processor_id();
+
+	dyn_handler.cpu_wake();
+
+	spin_lock(&dyn_tick->lock);
+	if (clear_nohz_cpu(cpu)) {
+		int lost;
+
+		spin_unlock(&dyn_tick->lock);
+
+		reset_pit_timer();
+
+		write_seqlock(&xtime_lock);
+		lost = cur_timer->mark_offset();
+		if (lost && in_irq())
+			do_timer(regs);
+		write_sequnlock(&xtime_lock);
+
+		kstat_cpu(0).cpustat.idle += (lost - 1);
+		conditional_run_local_timers();
+	} else
+		spin_unlock(&dyn_tick->lock);
+}
+
+/*
+ * This is called from all interrupt handlers. It check per_cpu data first
+ * to see that this cpu is not currently skipping ticks. If it is skipping
+ * ticks it calls do_dyn_tick_interrupt.
+ */
+void dyn_tick_interrupt(struct pt_regs *regs)
+{
+	if (test_nohz_cpu())
+		do_dyn_tick_interrupt(regs);
+}
+
+/*
+ * Called from every idle tick.
+ */
+inline void idle_reprogram_timer(void)
+{
+	local_irq_disable();
+	if (!need_resched())
+		timer_dyn_reprogram();
+	local_irq_enable();
+}
+
+void __init dyn_tick_time_init(struct timer_opts *cur_timer)
+{
+	if (strncmp(cur_timer->name, "pmtmr", 3) == 0) {
+		dyn_tick->state |= DYN_TICK_SUITABLE;
+		printk(KERN_INFO "dyn-tick: Found suitable timer: %s\n",
+			cur_timer->name);
+	} else
+		printk(KERN_ERR "dyn-tick: Cannot use timer %s - pmtmr "
+			"failed: ACPI disabled?\n", cur_timer->name);
+}
Index: linux-2.6.15-rc7-dt/arch/i386/kernel/irq.c
===================================================================
--- linux-2.6.15-rc7-dt.orig/arch/i386/kernel/irq.c	2005-12-28 16:37:36.000000000 +1100
+++ linux-2.6.15-rc7-dt/arch/i386/kernel/irq.c	2005-12-28 16:37:40.000000000 +1100
@@ -18,6 +18,8 @@
 #include <linux/notifier.h>
 #include <linux/cpu.h>
 #include <linux/delay.h>
+#include <linux/dyn-tick.h>
+#include <asm/dyn-tick.h>
 
 DEFINE_PER_CPU(irq_cpustat_t, irq_stat) ____cacheline_maxaligned_in_smp;
 EXPORT_PER_CPU_SYMBOL(irq_stat);
@@ -76,6 +78,8 @@ fastcall unsigned int do_IRQ(struct pt_r
 	}
 #endif
 
+	dyn_tick_interrupt(regs);
+
 #ifdef CONFIG_4KSTACKS
 
 	curctx = (union irq_ctx *) current_thread_info();
Index: linux-2.6.15-rc7-dt/arch/i386/kernel/Makefile
===================================================================
--- linux-2.6.15-rc7-dt.orig/arch/i386/kernel/Makefile	2005-12-28 16:37:36.000000000 +1100
+++ linux-2.6.15-rc7-dt/arch/i386/kernel/Makefile	2005-12-28 16:37:40.000000000 +1100
@@ -32,6 +32,7 @@ obj-$(CONFIG_MODULES)		+= module.o
 obj-y				+= sysenter.o vsyscall.o
 obj-$(CONFIG_ACPI_SRAT) 	+= srat.o
 obj-$(CONFIG_HPET_TIMER) 	+= time_hpet.o
+obj-$(CONFIG_NO_IDLE_HZ) 	+= dyn-tick.o
 obj-$(CONFIG_EFI) 		+= efi.o efi_stub.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
Index: linux-2.6.15-rc7-dt/arch/i386/kernel/process.c
===================================================================
--- linux-2.6.15-rc7-dt.orig/arch/i386/kernel/process.c	2005-12-28 16:37:36.000000000 +1100
+++ linux-2.6.15-rc7-dt/arch/i386/kernel/process.c	2005-12-28 16:37:40.000000000 +1100
@@ -39,6 +39,7 @@
 #include <linux/ptrace.h>
 #include <linux/random.h>
 #include <linux/kprobes.h>
+#include <linux/dyn-tick.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -56,6 +57,7 @@
 
 #include <asm/tlbflush.h>
 #include <asm/cpu.h>
+#include <asm/dyn-tick.h>
 
 asmlinkage void ret_from_fork(void) __asm__("ret_from_fork");
 
@@ -194,6 +196,8 @@ void cpu_idle(void)
 				play_dead();
 
 			__get_cpu_var(irq_stat).idle_timestamp = jiffies;
+			idle_reprogram_timer();
+
 			idle();
 		}
 		preempt_enable_no_resched();
Index: linux-2.6.15-rc7-dt/arch/i386/kernel/smp.c
===================================================================
--- linux-2.6.15-rc7-dt.orig/arch/i386/kernel/smp.c	2005-12-28 16:37:36.000000000 +1100
+++ linux-2.6.15-rc7-dt/arch/i386/kernel/smp.c	2005-12-28 16:37:40.000000000 +1100
@@ -20,9 +20,11 @@
 #include <linux/interrupt.h>
 #include <linux/cpu.h>
 #include <linux/module.h>
+#include <linux/dyn-tick.h>
 
 #include <asm/mtrr.h>
 #include <asm/tlbflush.h>
+#include <asm/dyn-tick.h>
 #include <mach_apic.h>
 
 /*
@@ -313,6 +315,8 @@ fastcall void smp_invalidate_interrupt(s
 {
 	unsigned long cpu;
 
+	dyn_tick_interrupt(regs);
+
 	cpu = get_cpu();
 
 	if (!cpu_isset(cpu, flush_cpumask))
@@ -600,6 +604,8 @@ void smp_send_stop(void)
 fastcall void smp_reschedule_interrupt(struct pt_regs *regs)
 {
 	ack_APIC_irq();
+
+	dyn_tick_interrupt(regs);
 }
 
 fastcall void smp_call_function_interrupt(struct pt_regs *regs)
@@ -609,6 +615,9 @@ fastcall void smp_call_function_interrup
 	int wait = call_data->wait;
 
 	ack_APIC_irq();
+
+	dyn_tick_interrupt(regs);
+
 	/*
 	 * Notify initiating CPU that I've grabbed the data and am
 	 * about to execute the function
Index: linux-2.6.15-rc7-dt/include/asm-i386/apic.h
===================================================================
--- linux-2.6.15-rc7-dt.orig/include/asm-i386/apic.h	2005-12-28 16:37:36.000000000 +1100
+++ linux-2.6.15-rc7-dt/include/asm-i386/apic.h	2005-12-28 16:37:40.000000000 +1100
@@ -121,6 +121,7 @@ extern void nmi_watchdog_tick (struct pt
 extern int APIC_init_uniprocessor (void);
 extern void disable_APIC_timer(void);
 extern void enable_APIC_timer(void);
+extern void reprogram_apic_timer(unsigned long count);
 
 extern void enable_NMI_through_LVT0 (void * dummy);
 
@@ -134,6 +135,7 @@ extern int disable_timer_pin_1;
 
 #else /* !CONFIG_X86_LOCAL_APIC */
 static inline void lapic_shutdown(void) { }
+static inline void reprogram_apic_timer(unsigned long count) { }
 
 #endif /* !CONFIG_X86_LOCAL_APIC */
 
Index: linux-2.6.15-rc7-dt/include/asm-i386/dyn-tick.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-rc7-dt/include/asm-i386/dyn-tick.h	2005-12-28 16:37:40.000000000 +1100
@@ -0,0 +1,69 @@
+/*
+ * linux/include/asm-i386/dyn-tick.h
+ *
+ * Copyright (C) 2004 Nokia Corporation
+ * Written by Tony Lindgen <tony@atomide.com> and
+ * Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
+ * Rewritten by Con Kolivas <kernel@kolivas.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _ASM_I386_DYN_TICK_H_
+#define _ASM_I386_DYN_TICK_H_
+
+#include <asm/apic.h>
+#include <asm/timer.h>
+
+#ifdef CONFIG_NO_IDLE_HZ
+extern void idle_reprogram_timer(void);
+extern void dyn_tick_interrupt(struct pt_regs *regs);
+extern void __init setup_dyn_tick_use_apic(unsigned int calibration_result);
+extern void __init dyn_tick_time_init(struct timer_opts *cur_timer);
+
+#define PIT_MAX_SKIP	(0xffff / (LATCH))
+
+#if (defined(CONFIG_SMP) || defined(CONFIG_X86_UP_APIC))
+extern int using_apic_timer;
+
+static inline void start_local_apic(void)
+{
+	using_apic_timer = 1;
+	enable_APIC_timer();
+}
+
+static inline void stop_local_apic(void)
+{
+	disable_APIC_timer();
+	using_apic_timer = 0;
+}
+#else /* (defined(CONFIG_SMP) || defined(CONFIG_X86_UP_APIC)) */
+static inline void start_local_apic(void)
+{
+}
+
+static inline void stop_local_apic(void)
+{
+}
+#endif /* (defined(CONFIG_SMP) || defined(CONFIG_X86_UP_APIC)) */
+#else	/* CONFIG_NO_IDLE_HZ */
+static inline void idle_reprogram_timer(void)
+{
+}
+
+static inline void dyn_tick_interrupt(struct pt_regs *regs)
+{
+}
+
+static inline void setup_dyn_tick_use_apic(unsigned int calibration_result)
+{
+}
+
+static inline void dyn_tick_time_init(struct timer_opts *cur_timer)
+{
+}
+#endif	/* CONFIG_NO_IDLE_HZ */
+
+#endif /* _ASM_I386_DYN_TICK_H_ */
Index: linux-2.6.15-rc7-dt/kernel/timer_top.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-rc7-dt/kernel/timer_top.c	2005-12-28 16:38:54.000000000 +1100
@@ -0,0 +1,234 @@
+/*
+ * kernel/timer_top.c
+ *
+ * Export Timers information to /proc/timer_info
+ *
+ * Copyright (C) 2005 Instituto Nokia de Tecnologia - INdT - Manaus
+ * Written by Daniel Petrini <d.pensator@gmail.com>
+ *
+ * This utility should be used to get information from the system timers
+ * and maybe optimize the system once you know which timers are being used
+ * and the process which starts them.
+ * This is particular useful above dynamic tick implementation. One can
+ * see who is starting timers and make the HZ value increase.
+ *
+ * We export the addresses and counting of timer functions being called,
+ * the pid and cmdline from the owner process if applicable.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+
+#include <linux/list.h>
+#include <linux/proc_fs.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/sched.h>
+#include <linux/seq_file.h>
+#include <asm/uaccess.h>
+
+#define VERSION		"Timer Top v0.9.8"
+
+struct timer_top_info {
+	unsigned int		func_pointer;
+	unsigned long		counter;
+	pid_t			pid;
+	char 			comm[TASK_COMM_LEN];
+	struct list_head 	list;
+};
+
+struct timer_top_root {
+	spinlock_t		lock;
+	struct list_head	list;
+	kmem_cache_t		*cache;
+	int			record;	/* if currently collecting data */
+};
+
+static struct timer_top_root top_root = {
+	.lock		= SPIN_LOCK_UNLOCKED,
+	.list		= LIST_HEAD_INIT(top_root.list),
+};
+
+static struct list_head *timer_list = &top_root.list;
+static spinlock_t *top_lock = &top_root.lock;
+
+static inline int update_top_info(unsigned long function, pid_t pid_info)
+{
+	struct timer_top_info *top;
+
+	list_for_each_entry(top, timer_list, list) {
+		/* if it is in the list increment its count */
+		if (top->func_pointer == function && top->pid == pid_info) {
+			top->counter++;
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+int account_timer(unsigned long function, unsigned long data)
+{
+	struct timer_top_info *top;
+	struct task_struct * task_info;
+	pid_t pid_info = 0;
+	char name[TASK_COMM_LEN] = "";
+	unsigned long flags;
+
+	if (!top_root.record)
+		goto out;
+
+	spin_lock_irqsave(top_lock, flags);
+
+	if (data) {
+	       task_info = (struct task_struct *) data;
+		/* little sanity ... not enough yet */
+		if ((task_info->pid > 0) && (task_info->pid < PID_MAX_LIMIT)) {
+			pid_info = task_info->pid;
+			strncpy(name, task_info->comm, sizeof(task_info->comm));
+		}
+	}
+
+	if (update_top_info(function, pid_info))
+		goto out_unlock;
+
+	/* Function not found so insert it in the list */
+	top = kmem_cache_alloc(top_root.cache, GFP_ATOMIC);
+	if (unlikely(!top))
+		goto out_unlock;
+
+	top->func_pointer = function;
+	top->counter = 1;
+	top->pid = pid_info;
+	strncpy(top->comm, name, sizeof(name));
+	list_add(&top->list, timer_list);
+
+out_unlock:
+	spin_unlock_irqrestore(top_lock, flags);
+
+out:
+	return 0;
+}
+
+EXPORT_SYMBOL(account_timer);
+
+/*
+ * Must hold top_lock
+ */
+static void timer_list_del(void)
+{
+	struct list_head *aux1, *aux2;
+	struct timer_top_info *entry;
+
+	list_for_each_safe(aux1, aux2, timer_list) {
+		entry = list_entry(aux1, struct timer_top_info, list);
+		list_del(aux1);
+		kmem_cache_free(top_root.cache, entry);
+	}
+}
+
+/* PROC_FS_SECTION  */
+
+static struct proc_dir_entry *top_info_file;
+static struct proc_dir_entry *top_info_file_out;
+
+/* Statistics output - timer_info*/
+static int proc_read_top_info(struct seq_file *m, void *v)
+{
+	struct timer_top_info *top;
+
+	seq_printf(m, "Function counter - %s\n", VERSION);
+
+	list_for_each_entry(top, timer_list, list) {
+		seq_printf(m, "%x %lu %d %s\n", top->func_pointer,
+			top->counter, top->pid, top->comm);
+	}
+
+	if (!top_root.record)
+		seq_printf(m, "Disabled\n");
+
+	return 0;
+}
+
+static int proc_timertop_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, proc_read_top_info, NULL);
+}
+
+static struct file_operations proc_timertop_operations = {
+	.open		= proc_timertop_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+#define MAX_INPUT_TOP	10
+
+/* Receive some commands from user - timer_input */
+static int proc_write_timer_input(struct file *file, const char *page,
+                                 unsigned long count, void *data)
+{
+	int len;
+	char input_data[MAX_INPUT_TOP];
+	unsigned long flags;
+
+	/* input size checking */
+	if (count > MAX_INPUT_TOP - 1)
+		len = MAX_INPUT_TOP - 1;
+	else
+		len = count;
+
+	if (copy_from_user(input_data, page, len))
+		return -EFAULT;
+
+	input_data[len] = '\0';
+
+	spin_lock_irqsave(top_lock, flags);
+	if (!strncmp(input_data, "clear", 5))
+		timer_list_del();
+	else if (!strncmp(input_data, "start", 5))
+		top_root.record = 1;
+	else if (!strncmp(input_data, "stop", 4)) {
+		top_root.record = 0;
+		timer_list_del();
+	}
+	spin_unlock_irqrestore(top_lock, flags);
+
+	return len;
+}
+
+/* Print a sample string showing the possible inputs - timer_input */
+static int proc_read_timer_input(char *page, char **start, off_t off,
+                                int count, int *eof, void *data)
+{
+	int len = sprintf(page, "clear start stop\n");
+
+	return len;
+}
+
+static int __init init_top_info(void)
+{
+	top_root.cache = kmem_cache_create("top_info",
+		sizeof(struct timer_top_info), 0, SLAB_PANIC, NULL, NULL);
+
+	top_info_file = create_proc_entry("timer_info", 0444, NULL);
+	if (top_info_file == NULL)
+		return -ENOMEM;
+
+	top_info_file_out = create_proc_entry("timer_input", 0666, NULL);
+	if (top_info_file_out == NULL)
+		return -ENOMEM;
+
+	/* Statistics output */
+	top_info_file->proc_fops = &proc_timertop_operations;
+
+	/* Control */
+	top_info_file_out->write_proc = &proc_write_timer_input;
+	top_info_file_out->read_proc = &proc_read_timer_input;
+
+	return 0;
+}
+
+module_init(init_top_info);
Index: linux-2.6.15-rc7-dt/lib/Kconfig.debug
===================================================================
--- linux-2.6.15-rc7-dt.orig/lib/Kconfig.debug	2005-12-28 16:37:35.000000000 +1100
+++ linux-2.6.15-rc7-dt/lib/Kconfig.debug	2005-12-28 16:38:54.000000000 +1100
@@ -77,6 +77,19 @@ config SCHEDSTATS
 	  application, you can say N to avoid the very slight overhead
 	  this adds.
 
+config TIMER_INFO
+	bool "Collect kernel timers statistics"
+	depends on DEBUG_KERNEL && PROC_FS && NO_IDLE_HZ
+	help
+	  If you say Y here, additional code will be inserted into the
+	  timer routines to collect statistics about kernel timers being
+	  reprogrammed through dynamic ticks feature. The statistics
+	  will be provided in /proc/timer_info and the behavior of this
+	  feature can be controlled through /proc/timer_input.
+	  The goal is to offer some output to let user applications show
+	  timer pattern usage and allow some tuning in them to
+	  maximise idle time.
+
 config DEBUG_SLAB
 	bool "Debug memory allocations"
 	depends on DEBUG_KERNEL
Index: linux-2.6.15-rc7-dt/drivers/acpi/processor_idle.c
===================================================================
--- linux-2.6.15-rc7-dt.orig/drivers/acpi/processor_idle.c	2005-12-28 16:37:35.000000000 +1100
+++ linux-2.6.15-rc7-dt/drivers/acpi/processor_idle.c	2005-12-28 16:38:55.000000000 +1100
@@ -38,6 +38,7 @@
 #include <linux/dmi.h>
 #include <linux/moduleparam.h>
 #include <linux/sched.h>	/* need_resched() */
+#include <linux/dyn-tick.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -60,6 +61,8 @@ module_param(max_cstate, uint, 0644);
 static unsigned int nocst = 0;
 module_param(nocst, uint, 0000);
 
+#define BM_JIFFIES	(HZ >= 800 ? 4 : 2)
+
 /*
  * bm_history -- bit-mask with a bit per jiffy of bus-master activity
  * 1000 HZ: 0xFFFFFFFF: 32 jiffies = 32ms
@@ -256,10 +259,10 @@ static void acpi_processor_idle(void)
 		pr->power.bm_check_timestamp = jiffies;
 
 		/*
-		 * Apply bus mastering demotion policy.  Automatically demote
+		 * If bus mastering is or was active this jiffy, demote
 		 * to avoid a faulty transition.  Note that the processor
 		 * won't enter a low-power state during this call (to this
-		 * funciton) but should upon the next.
+		 * function) but should upon the next.
 		 *
 		 * TBD: A better policy might be to fallback to the demotion
 		 *      state (use it for this quantum only) istead of
@@ -267,13 +270,61 @@ static void acpi_processor_idle(void)
 		 *      qualification.  This may, however, introduce DMA
 		 *      issues (e.g. floppy DMA transfer overrun/underrun).
 		 */
-		if (pr->power.bm_activity & cx->demotion.threshold.bm) {
+		if ((pr->power.bm_activity & 0x01) &&
+		    cx->demotion.threshold.bm) {
 			local_irq_enable();
 			next_state = cx->demotion.state;
+			if (dyn_tick_enabled())
+				dyn_early_reprogram(BM_JIFFIES);
+			/* do not promote in fast-path */
+			pr->power.last_sleep = 0;
 			goto end;
 		}
 	}
 
+	/*
+	 * Some special policy tweaks for dynamic ticks
+	 */
+	if (dyn_tick_enabled()) {
+		/*
+		 * Fast-path promotion: if we slept for more than 2 jiffies the
+		 * last time, and we're intended to sleep for more than 2
+		 * jiffies now, promote. Note that the processor won't enter a
+		 * low-power state during this call (to this funciton) but
+		 * should upon the next.
+		 */
+		if (cx->promotion.state && cx->promotion.count &&
+		    dyn_tick_skipping() && ((pr->power.last_sleep >
+		      (BM_JIFFIES * cx->promotion.threshold.ticks)) ||
+		     (pr->power.quick_promotion == 1)) &&
+		    (dyn_tick_current_skip() > BM_JIFFIES)) {
+			local_irq_enable();
+			next_state = cx->promotion.state;
+			goto end;
+		}
+
+
+		/*
+		 * Fast-path demotion: if we're going to sleep for only one
+		 * jiffy, and we'd enter C3-type sleep, and the wakeup latency
+		 * is high, don't use C3-type sleep but (temporarily) C2.
+		 */
+		if (cx->demotion.state && cx->demotion.threshold.bm &&
+		    (dyn_tick_next_tick() < (jiffies + 1))
+		    && (cx->latency > 150)) {
+			local_irq_enable();
+			next_state = cx->demotion.state;
+
+			/* don't do a fast-path promotion next time... */
+			pr->power.last_sleep = 0;
+			/* ... but thereafter. */
+			pr->power.quick_promotion = 2;
+			goto end;
+		}
+	}
+
+	pr->power.last_sleep = 0;
+
 #ifdef CONFIG_HOTPLUG_CPU
 	/*
 	 * Check for P_LVL2_UP flag before entering C2 and above on
@@ -285,8 +336,6 @@ static void acpi_processor_idle(void)
 		cx = &pr->power.states[ACPI_STATE_C1];
 #endif
 
-	cx->usage++;
-
 	/*
 	 * Sleep:
 	 * ------
@@ -384,9 +433,22 @@ static void acpi_processor_idle(void)
 		local_irq_enable();
 		return;
 	}
+	cx->usage++;
+	if (cx->type != ACPI_STATE_C1) {
+		if (sleep_ticks > 0)
+			cx->time += sleep_ticks;
+	}
+
+	pr->power.last_sleep = sleep_ticks / (PM_TIMER_FREQUENCY / HZ);
+
+	if (pr->flags.bm_check)
+		pr->power.bm_check_timestamp += pr->power.last_sleep;
 
 	next_state = pr->power.state;
 
+	if (pr->power.quick_promotion)
+		pr->power.quick_promotion--;
+
 #ifdef CONFIG_HOTPLUG_CPU
 	/* Don't do promotion/demotion */
 	if ((cx->type == ACPI_STATE_C1) && (num_online_cpus() > 1) &&
@@ -998,9 +1060,10 @@ static int acpi_processor_power_seq_show
 		else
 			seq_puts(seq, "demotion[--] ");
 
-		seq_printf(seq, "latency[%03d] usage[%08d]\n",
+		seq_printf(seq, "latency[%03d] usage[%08d] time[%020llu]\n",
 			   pr->power.states[i].latency,
-			   pr->power.states[i].usage);
+			   pr->power.states[i].usage,
+			   pr->power.states[i].time);
 	}
 
       end:
Index: linux-2.6.15-rc7-dt/include/acpi/processor.h
===================================================================
--- linux-2.6.15-rc7-dt.orig/include/acpi/processor.h	2005-12-28 16:37:35.000000000 +1100
+++ linux-2.6.15-rc7-dt/include/acpi/processor.h	2005-12-28 16:38:55.000000000 +1100
@@ -51,6 +51,7 @@ struct acpi_processor_cx {
 	u32 latency_ticks;
 	u32 power;
 	u32 usage;
+	u64 time;
 	struct acpi_processor_cx_policy promotion;
 	struct acpi_processor_cx_policy demotion;
 };
@@ -60,6 +61,8 @@ struct acpi_processor_power {
 	unsigned long bm_check_timestamp;
 	u32 default_state;
 	u32 bm_activity;
+	u16 last_sleep;
+	u16 quick_promotion;
 	int count;
 	struct acpi_processor_cx states[ACPI_PROCESSOR_MAX_POWER];
 
Index: linux-2.6.15-rc7-dt/drivers/input/serio/i8042.h
===================================================================
--- linux-2.6.15-rc7-dt.orig/drivers/input/serio/i8042.h	2005-12-28 16:37:35.000000000 +1100
+++ linux-2.6.15-rc7-dt/drivers/input/serio/i8042.h	2005-12-28 16:38:55.000000000 +1100
@@ -44,7 +44,7 @@
  * polling.
  */
 
-#define I8042_POLL_PERIOD	HZ/20
+#define I8042_POLL_PERIOD	HZ/5
 
 /*
  * Status register bits.
