Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932659AbWBYEbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932659AbWBYEbK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 23:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932663AbWBYEbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 23:31:10 -0500
Received: from mail26.syd.optusnet.com.au ([211.29.133.167]:31138 "EHLO
	mail26.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932659AbWBYEbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 23:31:07 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux list <linux-kernel@vger.kernel.org>
Subject: [PATCH] No idle HZ aka dynticks i386 for 2.6.16-rc4
Date: Sat, 25 Feb 2006 15:30:57 +1100
User-Agent: KMail/1.9.1
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602251530.58797.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've only committed minor changes to dynticks since the last public release.

The smp idle handler was modified to wake up the APIC timer of the last cpu
going to sleep when the PIC timer is skipping.

One arch specific function was moved out of common code (noted by Thomas
Renninger thanks).

The fix for sys_nanosleep being converted to hrtimers breaking 
next_timer_interrupt was added by Tony Lindgren.

Latest rolled up patch, split patch series and tarball available here:
http://ck.kolivas.org/patches/dyn-ticks/

Uniprocessor dynticks has been working flawlessly for some time.

Known issues:
SMP still isn't playing well. Too many ticks still occur on the irq0 cpu and
eventually other cpus seem to go into a sustained long skip cycle (after a day
or so.) I haven't been able to track the cause of either of these and would
appreciate anyone's outside help if they're knowledgeable in this area.

Rolled up patch v060225 included here.

Cheers,
Con
---
Rolled up dynticks patch including arch independent code and i386
implementation.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

 arch/i386/Kconfig                       |   21 ++
 arch/i386/defconfig                     |    1
 arch/i386/kernel/Makefile               |    1
 arch/i386/kernel/apic.c                 |   34 +++
 arch/i386/kernel/dyntick.c              |  279 +++++++++++++++++++++++++++++
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
 drivers/acpi/processor_idle.c           |  108 +++++++++--
 drivers/input/serio/i8042.h             |    2
 include/acpi/processor.h                |    3
 include/asm-i386/apic.h                 |    2
 include/asm-i386/dyntick.h              |   70 +++++++
 include/asm-i386/timer.h                |   37 +++
 include/linux/dyntick.h                 |  170 +++++++++++++++++
 include/linux/hrtimer.h                 |    1
 include/linux/timer.h                   |    1
 kernel/Makefile                         |    2
 kernel/dyntick.c                        |  304 ++++++++++++++++++++++++++++++++
 kernel/hrtimer.c                        |   73 +++++++
 kernel/timer.c                          |   21 ++
 kernel/timer_top.c                      |  234 ++++++++++++++++++++++++
 lib/Kconfig.debug                       |   13 +
 31 files changed, 1459 insertions(+), 85 deletions(-)

Index: linux-2.6.16-rc4-dt/include/linux/timer.h
===================================================================
--- linux-2.6.16-rc4-dt.orig/include/linux/timer.h	2006-02-18 10:37:19.000000000 +1100
+++ linux-2.6.16-rc4-dt/include/linux/timer.h	2006-02-23 11:17:16.000000000 +1100
@@ -97,5 +97,6 @@ static inline void add_timer(struct time
 extern void init_timers(void);
 extern void run_local_timers(void);
 extern int it_real_fn(void *);
+extern void conditional_run_local_timers(void);
 
 #endif
Index: linux-2.6.16-rc4-dt/kernel/Makefile
===================================================================
--- linux-2.6.16-rc4-dt.orig/kernel/Makefile	2006-02-18 10:37:19.000000000 +1100
+++ linux-2.6.16-rc4-dt/kernel/Makefile	2006-02-23 11:39:38.000000000 +1100
@@ -34,6 +34,8 @@ obj-$(CONFIG_DETECT_SOFTLOCKUP) += softl
 obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
 obj-$(CONFIG_SECCOMP) += seccomp.o
 obj-$(CONFIG_RCU_TORTURE_TEST) += rcutorture.o
+obj-$(CONFIG_NO_IDLE_HZ) += dyntick.o
+obj-$(CONFIG_TIMER_INFO) += timer_top.o
 
 ifneq ($(CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
Index: linux-2.6.16-rc4-dt/kernel/timer.c
===================================================================
--- linux-2.6.16-rc4-dt.orig/kernel/timer.c	2006-02-18 10:37:19.000000000 +1100
+++ linux-2.6.16-rc4-dt/kernel/timer.c	2006-02-25 15:16:46.000000000 +1100
@@ -34,6 +34,7 @@
 #include <linux/cpu.h>
 #include <linux/syscalls.h>
 #include <linux/delay.h>
+#include <linux/dyntick.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -478,6 +479,7 @@ static inline void __run_timers(tvec_bas
 }
 
 #ifdef CONFIG_NO_IDLE_HZ
+
 /*
  * Find out when the next timer event is due to happen. This
  * is used on S/390 to stop all activity when a cpus is idle.
@@ -489,9 +491,15 @@ unsigned long next_timer_interrupt(void)
 	struct list_head *list;
 	struct timer_list *nte;
 	unsigned long expires;
+	unsigned long hr_expires = jiffies + 10 * HZ;	/* Anything far ahead */
 	tvec_t *varray[4];
 	int i, j;
 
+	/* Look for timer events in hrtimer. */
+	if ((hrtimer_next_jiffie(&hr_expires) == 0)
+		&& (time_before(hr_expires, jiffies + 2)))
+			return hr_expires;
+
 	base = &__get_cpu_var(tvec_bases);
 	spin_lock(&base->t_base.lock);
 	expires = base->timer_jiffies + (LONG_MAX >> 1);
@@ -541,7 +549,13 @@ found:
 				expires = nte->expires;
 		}
 	}
+	account_timer((unsigned long)nte->function, nte->data);
+
 	spin_unlock(&base->t_base.lock);
+
+	if (time_before(hr_expires, expires))
+		expires = hr_expires;
+
 	return expires;
 }
 #endif
@@ -900,6 +914,13 @@ void run_local_timers(void)
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
Index: linux-2.6.16-rc4-dt/include/linux/dyntick.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.16-rc4-dt/include/linux/dyntick.h	2006-02-23 11:39:38.000000000 +1100
@@ -0,0 +1,170 @@
+/*
+ * linux/include/linux/dyntick.h
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
+#ifndef _dyntick_TIMER_H
+#define _dyntick_TIMER_H
+
+#include <linux/interrupt.h>
+
+#define dyntick_SKIPPING	(1 << 2)
+#define dyntick_ENABLED	(1 << 1)
+#define dyntick_SUITABLE	(1 << 0)
+
+/* Don't skip longer than NMI  */
+#define dyntick_MAX_SKIP	(HZ * 5)
+
+struct dyntick_timer {
+	spinlock_t lock;
+
+	/* dyntick init */
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
+} dyntick_data;
+
+extern struct dyntick_timer *dyntick;
+extern spinlock_t *dyntick_lock;
+
+extern void dyntick_register(struct dyntick_timer *new_timer);
+
+#ifdef CONFIG_NO_IDLE_HZ
+DECLARE_PER_CPU(dyntick_data, dyn_cpu);
+extern dyntick_data dyn_cpu;
+extern int dyntick_enabled(void);
+extern int dyntick_skipping(void);
+extern int dyntick_allcpus_skipping(void);
+extern int dyntick_current_skip(void);
+extern unsigned long dyntick_next_tick(void);
+extern void timer_dyn_reprogram(void);
+extern void dyn_early_reprogram(unsigned int delta);
+extern void set_dyntick_limits(unsigned int max_skip, unsigned int min_skip);
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
+	dyntick->tick = 0;
+	if (cpus_equal(nohz_cpu_mask, cpu_online_map)) {
+		dyntick->state &= ~dyntick_SKIPPING;
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
+ * idle, and if so do dyntick->arch_all_cpus_idle()
+ */
+static inline void set_nohz_cpu(int cpu)
+{
+	if (dyntick->tick <= jiffies ||
+		__get_cpu_var(dyn_cpu).next_tick < dyntick->tick)
+			dyntick->tick = __get_cpu_var(dyn_cpu).next_tick;
+
+	if (!test_nohz_cpu()) {
+		__get_cpu_var(dyn_cpu).nohz_cpu = 1;
+		cpu_set(cpu, nohz_cpu_mask);
+	}
+	if (cpus_equal(nohz_cpu_mask, cpu_online_map)) {
+		dyntick->state |= dyntick_SKIPPING;
+		dyntick->arch_all_cpus_idle(dyntick->tick - jiffies);
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
+static inline int dyntick_enabled(void)
+{
+	return 0;
+}
+
+static inline int dyntick_skipping(void)
+{
+	return 0;
+}
+
+static inline int dyntick_allcpus_skipping(void)
+{
+	return 0;
+}
+
+static inline int dyntick_current_skip(void)
+{
+	return 0;
+}
+
+static inline unsigned long dyntick_next_tick(void)
+{
+	return 0;
+}
+
+static inline void set_dyntick_limits(unsigned int max_skip,
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
+#endif	/* _dyntick_TIMER_H */
Index: linux-2.6.16-rc4-dt/kernel/dyntick.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.16-rc4-dt/kernel/dyntick.c	2006-02-23 11:23:47.000000000 +1100
@@ -0,0 +1,304 @@
+/*
+ * linux/kernel/dyntick.c
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
+#include <linux/dyntick.h>
+#include <linux/rcupdate.h>
+#include <asm/dyntick.h>
+
+#define dyntick_VERSION	"060223"
+
+DEFINE_PER_CPU(dyntick_data, dyn_cpu);
+
+inline int dyntick_enabled(void)
+{
+	return !!(dyntick->state & dyntick_ENABLED);
+}
+
+EXPORT_SYMBOL(dyntick_enabled);
+
+
+/*
+ * Returns if we are currently skipping ticks.
+ */
+int dyntick_skipping(void)
+{
+	int ret = (get_cpu_var(dyn_cpu).next_tick > jiffies);
+
+	put_cpu_var(dyn_cpu);
+	return ret;
+}
+
+EXPORT_SYMBOL(dyntick_skipping);
+
+inline int dyntick_allcpus_skipping(void)
+{
+	return !!(dyntick->state & dyntick_SKIPPING);
+}
+
+EXPORT_SYMBOL(dyntick_allcpus_skipping);
+
+/*
+ * Returns the number of ticks we are currently skipping if we are skipping
+ */
+int dyntick_current_skip(void)
+{
+	int ret = 0;
+
+	if (get_cpu_var(dyn_cpu).next_tick > jiffies)
+		ret = __get_cpu_var(dyn_cpu).skip;
+	put_cpu_var(dyn_cpu);
+	return ret;
+}
+
+EXPORT_SYMBOL(dyntick_current_skip);
+
+/*
+ * Returns the next scheduled dyntick if we are skipping ticks.
+ */
+unsigned long dyntick_next_tick(void)
+{
+	unsigned long next = 0;
+
+	if (get_cpu_var(dyn_cpu).next_tick > jiffies)
+		next = __get_cpu_var(dyn_cpu).next_tick;
+	put_cpu_var(dyn_cpu);
+	return next;
+}
+
+EXPORT_SYMBOL(dyntick_next_tick);
+
+static inline int dyntick_suitable(void)
+{
+	return !!(dyntick->state & dyntick_SUITABLE);
+}
+
+/*
+ * do_dyn_reprogram does the actual reprogramming. We should have already
+ * checked that the tick chosen is suitable, xtime_lock and dyntick->lock
+ * must be held, and interrupts disabled.
+ */
+static void do_dyn_reprogram(unsigned int delta)
+{
+	unsigned long next = jiffies + delta;
+
+	__get_cpu_var(dyn_cpu).next_tick = next;
+	__get_cpu_var(dyn_cpu).skip = delta;
+	dyntick->arch_reprogram(next);
+	/* We have to update the idle_timestamp */
+	set_irq_idle_timestamp(next);
+}
+
+/*
+ * Arch independent code needed to reprogram next timer interrupt.
+ * Gets called, with IRQs disabled, from cpu_idle() before entering idle loop
+ * If we are to acquire the xtime_lock we must acquire it before
+ * dyntick->lock
+ */
+void timer_dyn_reprogram(void)
+{
+	int cpu;
+	unsigned int delta;
+
+	if (!dyntick_enabled())
+		return;
+
+	cpu = smp_processor_id();
+	if (rcu_pending(cpu) || local_softirq_pending()) {
+		spin_lock(&dyntick->lock);
+		clear_nohz_cpu(cpu);
+		spin_unlock(&dyntick->lock);
+		return;
+	}
+
+	write_seqlock(&xtime_lock);
+	delta = next_timer_interrupt() - jiffies;
+	if (delta > dyntick->min_skip) {
+		if (delta > dyntick->max_skip)
+			delta = dyntick->max_skip;
+		spin_lock(&dyntick->lock);
+		do_dyn_reprogram(delta);
+		set_nohz_cpu(cpu);
+		spin_unlock(&dyntick->lock);
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
+	spin_lock(&dyntick->lock);
+	do_dyn_reprogram(delta);
+	spin_unlock(&dyntick->lock);
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
+void set_dyntick_limits(unsigned int max_skip, unsigned int min_skip)
+{
+	if (max_skip > dyntick_MAX_SKIP)
+		max_skip = dyntick_MAX_SKIP;
+	if (!dyntick->max_skip || max_skip < dyntick->max_skip)
+		dyntick->max_skip = max_skip;
+	if (min_skip < 1)
+		min_skip = 1;
+	if (min_skip > dyntick->min_skip)
+		dyntick->min_skip = min_skip;
+}
+
+void __init dyntick_register(struct dyntick_timer *arch_timer)
+{
+	dyntick = arch_timer;
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
+ *  /sys/devices/system/timer/timer0/dyntick
+ */
+extern struct sys_device device_timer;
+
+static ssize_t timer_show_dyntick(struct sys_device *dev, char *buf)
+{
+	return sprintf(buf, "%i\n", dyntick_enabled());
+}
+
+static ssize_t timer_set_dyntick(struct sys_device *dev, const char *buf,
+				  size_t count)
+{
+	unsigned long flags;
+	unsigned int enable = simple_strtoul(buf, NULL, 2);
+	int ret = -ENODEV;
+
+	write_seqlock_irqsave(&xtime_lock, flags);
+	if (enable) {
+		ret = dyntick->arch_enable();
+		if (ret == 0) {
+			spin_lock(&dyntick->lock);
+			dyntick->state |= dyntick_ENABLED;
+			spin_unlock(&dyntick->lock);
+			printk(KERN_INFO
+				"dyntick: Enabling dynamic tick timer \n");
+		}
+	} else {
+		ret = dyntick->arch_disable();
+		if (ret == 0) {
+			spin_lock(&dyntick->lock);
+			dyntick->state &= ~dyntick_ENABLED;
+			spin_unlock(&dyntick->lock);
+			printk(KERN_INFO
+				"dyntick: Disabling dynamic tick timer \n");
+		}
+	}
+	write_sequnlock_irqrestore(&xtime_lock, flags);
+
+	return count;
+}
+
+static SYSDEV_ATTR(dyntick, 0644, timer_show_dyntick, timer_set_dyntick);
+
+static int __init init_dyntick_sysfs(void)
+{
+	int ret = sysdev_create_file(&device_timer, &attr_dyntick);
+
+	return ret;
+}
+
+device_initcall(init_dyntick_sysfs);
+
+/*
+ * Init functions
+ *
+ * We need to initialise dynamic tick after calibrate delay
+ */
+static int __init dyntick_late_init(void)
+{
+	int ret;
+
+	if (dyntick == NULL || dyntick->arch_init == NULL ||
+	    !dyntick_suitable()) {
+		printk(KERN_ERR "dyntick: No suitable timer found\n");
+		return -ENODEV;
+	}
+
+	if ((ret = dyntick->arch_init())) {
+		printk(KERN_ERR "dyntick: Init failed\n");
+		return -ENODEV;
+	}
+
+	if (!ret && dyntick_autoenable) {
+		dyntick->state |= dyntick_ENABLED;
+		printk(KERN_INFO "dyntick: Enabling dynamic tick timer v%s\n",
+			dyntick_VERSION);
+	} else
+		printk(KERN_INFO "dyntick: Dynamic tick timer v%s disabled\n",
+			dyntick_VERSION);
+
+	return ret;
+}
+
+late_initcall(dyntick_late_init);
Index: linux-2.6.16-rc4-dt/arch/i386/kernel/time.c
===================================================================
--- linux-2.6.16-rc4-dt.orig/arch/i386/kernel/time.c	2006-02-18 10:36:52.000000000 +1100
+++ linux-2.6.16-rc4-dt/arch/i386/kernel/time.c	2006-02-23 11:24:12.000000000 +1100
@@ -46,6 +46,7 @@
 #include <linux/bcd.h>
 #include <linux/efi.h>
 #include <linux/mca.h>
+#include <linux/dyntick.h>
 
 #include <asm/io.h>
 #include <asm/smp.h>
@@ -56,6 +57,7 @@
 #include <asm/uaccess.h>
 #include <asm/processor.h>
 #include <asm/timer.h>
+#include <asm/dyntick.h>
 
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
+	if (!dyntick_enabled() || lost)
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
 
@@ -431,7 +436,7 @@ static struct sysdev_class timer_sysclas
 
 
 /* XXX this driverfs stuff should probably go elsewhere later -john */
-static struct sys_device device_timer = {
+struct sys_device device_timer = {
 	.id	= 0,
 	.cls	= &timer_sysclass,
 };
@@ -487,5 +492,7 @@ void __init time_init(void)
 	cur_timer = select_timer();
 	printk(KERN_INFO "Using %s for high-res timesource\n",cur_timer->name);
 
+	dyntick_time_init(cur_timer);
+
 	time_init_hook();
 }
Index: linux-2.6.16-rc4-dt/arch/i386/kernel/timers/timer_cyclone.c
===================================================================
--- linux-2.6.16-rc4-dt.orig/arch/i386/kernel/timers/timer_cyclone.c	2005-08-29 13:31:19.000000000 +1000
+++ linux-2.6.16-rc4-dt/arch/i386/kernel/timers/timer_cyclone.c	2006-02-23 11:24:02.000000000 +1100
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
Index: linux-2.6.16-rc4-dt/arch/i386/kernel/timers/timer_hpet.c
===================================================================
--- linux-2.6.16-rc4-dt.orig/arch/i386/kernel/timers/timer_hpet.c	2006-01-03 17:36:14.000000000 +1100
+++ linux-2.6.16-rc4-dt/arch/i386/kernel/timers/timer_hpet.c	2006-02-23 11:24:02.000000000 +1100
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
Index: linux-2.6.16-rc4-dt/arch/i386/kernel/timers/timer_none.c
===================================================================
--- linux-2.6.16-rc4-dt.orig/arch/i386/kernel/timers/timer_none.c	2004-12-25 10:14:46.000000000 +1100
+++ linux-2.6.16-rc4-dt/arch/i386/kernel/timers/timer_none.c	2006-02-23 11:24:02.000000000 +1100
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
Index: linux-2.6.16-rc4-dt/arch/i386/kernel/timers/timer_pit.c
===================================================================
--- linux-2.6.16-rc4-dt.orig/arch/i386/kernel/timers/timer_pit.c	2006-01-03 17:36:14.000000000 +1100
+++ linux-2.6.16-rc4-dt/arch/i386/kernel/timers/timer_pit.c	2006-02-23 11:24:12.000000000 +1100
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
Index: linux-2.6.16-rc4-dt/arch/i386/kernel/timers/timer_pm.c
===================================================================
--- linux-2.6.16-rc4-dt.orig/arch/i386/kernel/timers/timer_pm.c	2005-10-28 20:21:34.000000000 +1000
+++ linux-2.6.16-rc4-dt/arch/i386/kernel/timers/timer_pm.c	2006-02-23 11:39:37.000000000 +1100
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/init.h>
+#include <linux/dyntick.h>
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
+	set_dyntick_limits(((0xFFFFFF / 1000000) * 286 * HZ) >> 10, 0);
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
 
 
Index: linux-2.6.16-rc4-dt/arch/i386/kernel/timers/timer_tsc.c
===================================================================
--- linux-2.6.16-rc4-dt.orig/arch/i386/kernel/timers/timer_tsc.c	2006-02-18 10:36:52.000000000 +1100
+++ linux-2.6.16-rc4-dt/arch/i386/kernel/timers/timer_tsc.c	2006-02-23 11:24:12.000000000 +1100
@@ -14,6 +14,7 @@
 #include <linux/cpufreq.h>
 #include <linux/string.h>
 #include <linux/jiffies.h>
+#include <linux/dyntick.h>
 
 #include <asm/timer.h>
 #include <asm/io.h>
@@ -32,8 +33,6 @@ static unsigned long hpet_last;
 static struct timer_opts timer_tsc;
 #endif
 
-static inline void cpufreq_delayed_get(void);
-
 int tsc_disable __devinitdata = 0;
 
 static int use_tsc;
@@ -180,11 +179,21 @@ static void delay_tsc(unsigned long loop
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
@@ -207,14 +216,12 @@ static void mark_offset_tsc_hpet(void)
 	offset = hpet_readl(HPET_T0_CMP) - hpet_tick;
 	if (unlikely(((offset - hpet_last) > hpet_tick) && (hpet_last != 0))
 					&& detect_lost_ticks) {
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
@@ -228,6 +235,8 @@ static void mark_offset_tsc_hpet(void)
 	delay_at_last_interrupt = hpet_current - offset;
 	ASM_MUL64_REG(temp, delay_at_last_interrupt,
 			hpet_usec_quotient, delay_at_last_interrupt);
+
+	return lost_ticks;
 }
 #endif
 
@@ -252,7 +261,7 @@ static void handle_cpufreq_delayed_get(v
  * to verify the CPU frequency the timing core thinks the CPU is running
  * at is still correct.
  */
-static inline void cpufreq_delayed_get(void) 
+void cpufreq_delayed_get(void)
 {
 	if (cpufreq_init && !cpufreq_delayed_issched) {
 		cpufreq_delayed_issched = 1;
@@ -336,7 +345,7 @@ static int __init cpufreq_tsc(void)
 core_initcall(cpufreq_tsc);
 
 #else /* CONFIG_CPU_FREQ */
-static inline void cpufreq_delayed_get(void) { return; }
+void cpufreq_delayed_get(void) { return; }
 #endif 
 
 int recalibrate_cpu_khz(void)
@@ -361,15 +370,14 @@ int recalibrate_cpu_khz(void)
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
@@ -436,29 +444,9 @@ static void mark_offset_tsc(void)
 	delta += delay_at_last_interrupt;
 	lost = delta/(1000000/HZ);
 	delay = delta%(1000000/HZ);
-	if (lost >= 2 && detect_lost_ticks) {
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
@@ -471,6 +459,8 @@ static void mark_offset_tsc(void)
 	 */
 	if (lost && abs(delay - delay_at_last_interrupt) > (900000/HZ))
 		jiffies_64++;
+
+	return lost;
 }
 
 static int __init init_tsc(char* override)
@@ -559,6 +549,8 @@ static int __init init_tsc(char* overrid
 					cpu_khz / 1000, cpu_khz % 1000);
 			}
 			set_cyc2ns_scale(cpu_khz);
+			set_dyntick_limits((0xFFFFFFFF / (cpu_khz * 1000)) *
+				HZ, 0);
 			return 0;
 		}
 	}
Index: linux-2.6.16-rc4-dt/include/asm-i386/timer.h
===================================================================
--- linux-2.6.16-rc4-dt.orig/include/asm-i386/timer.h	2005-10-28 20:22:01.000000000 +1000
+++ linux-2.6.16-rc4-dt/include/asm-i386/timer.h	2006-02-23 11:24:12.000000000 +1100
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
Index: linux-2.6.16-rc4-dt/drivers/acpi/Kconfig
===================================================================
--- linux-2.6.16-rc4-dt.orig/drivers/acpi/Kconfig	2006-02-18 10:36:54.000000000 +1100
+++ linux-2.6.16-rc4-dt/drivers/acpi/Kconfig	2006-02-23 11:24:12.000000000 +1100
@@ -298,6 +298,8 @@ config X86_PM_TIMER
 	  voltage scaling, unlike the commonly used Time Stamp Counter
 	  (TSC) timing source.
 
+	  This timer is selected by dyntick (NO_IDLE_HZ).
+
 	  So, if you see messages like 'Losing too many ticks!' in the
 	  kernel logs, and/or you are using this on a notebook which
 	  does not yet have an HPET, you should say "Y" here.
Index: linux-2.6.16-rc4-dt/arch/i386/defconfig
===================================================================
--- linux-2.6.16-rc4-dt.orig/arch/i386/defconfig	2006-02-18 10:36:52.000000000 +1100
+++ linux-2.6.16-rc4-dt/arch/i386/defconfig	2006-02-23 11:24:12.000000000 +1100
@@ -91,6 +91,7 @@ CONFIG_X86_INTEL_USERCOPY=y
 CONFIG_X86_USE_PPRO_CHECKSUM=y
 # CONFIG_HPET_TIMER is not set
 # CONFIG_HPET_EMULATE_RTC is not set
+# CONFIG_NO_IDLE_HZ is not set
 CONFIG_SMP=y
 CONFIG_NR_CPUS=8
 CONFIG_SCHED_SMT=y
Index: linux-2.6.16-rc4-dt/arch/i386/Kconfig
===================================================================
--- linux-2.6.16-rc4-dt.orig/arch/i386/Kconfig	2006-02-18 10:36:52.000000000 +1100
+++ linux-2.6.16-rc4-dt/arch/i386/Kconfig	2006-02-23 11:24:12.000000000 +1100
@@ -173,6 +173,27 @@ config HPET_EMULATE_RTC
 	depends on HPET_TIMER && RTC=y
 	default y
 
+config NO_IDLE_HZ
+	bool "Dynamic Tick Timer - Skip timer ticks during idle"
+	depends on EXPERIMENTAL && X86_32
+	select X86_PM_TIMER
+	select ACPI
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
+	  # echo 0 > /sys/devices/system/timer/timer0/dyntick
+
+	  Most users wishing to lower their power usage while retaining
+	  low latencies will most likely want to say Y here in combination
+	  with a high HZ value (eg 1000).
+
 config SMP
 	bool "Symmetric multi-processing support"
 	---help---
Index: linux-2.6.16-rc4-dt/arch/i386/kernel/apic.c
===================================================================
--- linux-2.6.16-rc4-dt.orig/arch/i386/kernel/apic.c	2006-02-18 10:36:52.000000000 +1100
+++ linux-2.6.16-rc4-dt/arch/i386/kernel/apic.c	2006-02-23 11:37:45.000000000 +1100
@@ -27,6 +27,7 @@
 #include <linux/sysdev.h>
 #include <linux/cpu.h>
 #include <linux/module.h>
+#include <linux/dyntick.h>
 
 #include <asm/atomic.h>
 #include <asm/smp.h>
@@ -36,11 +37,13 @@
 #include <asm/arch_hooks.h>
 #include <asm/hpet.h>
 #include <asm/i8253.h>
+#include <asm/dyntick.h>
 
 #include <mach_apic.h>
 #include <mach_ipi.h>
 
 #include "io_ports.h"
+#include "do_timer.h"
 
 /*
  * cpu_mask that denotes the CPUs that needs timer interrupt coming in as
@@ -938,6 +941,8 @@ void (*wait_timer_tick)(void) __devinitd
 
 #define APIC_DIVISOR 16
 
+static u32 apic_timer_val __read_mostly;
+
 static void __setup_APIC_LVTT(unsigned int clocks)
 {
 	unsigned int lvtt_value, tmp_value, ver;
@@ -961,7 +966,9 @@ static void __setup_APIC_LVTT(unsigned i
 				& ~(APIC_TDR_DIV_1 | APIC_TDR_DIV_TMBASE))
 				| APIC_TDR_DIV_16);
 
-	apic_write_around(APIC_TMICT, clocks/APIC_DIVISOR);
+	apic_timer_val = clocks / APIC_DIVISOR;
+
+	apic_write_around(APIC_TMICT, apic_timer_val);
 }
 
 static void __devinit setup_APIC_timer(unsigned int clocks)
@@ -981,6 +988,17 @@ static void __devinit setup_APIC_timer(u
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
@@ -1075,6 +1093,10 @@ void __init setup_boot_APIC_clock(void)
 	 */
 	setup_APIC_timer(calibration_result);
 
+	setup_dyntick_use_apic();
+	set_dyntick_limits((0xFFFFFFFF / calibration_result) * APIC_DIVISOR,
+		2);
+
 	local_irq_restore(flags);
 }
 
@@ -1144,8 +1166,10 @@ EXPORT_SYMBOL(switch_ipi_to_APIC_timer);
  * value into /proc/profile.
  */
 
-inline void smp_local_timer_interrupt(struct pt_regs * regs)
+void smp_local_timer_interrupt(struct pt_regs * regs)
 {
+	dyntick_interrupt(regs);
+
 	profile_tick(CPU_PROFILING, regs);
 #ifdef CONFIG_SMP
 	update_process_times(user_mode_vm(regs));
@@ -1241,6 +1265,9 @@ fastcall void smp_spurious_interrupt(str
 	unsigned long v;
 
 	irq_enter();
+
+	dyntick_interrupt(regs);
+
 	/*
 	 * Check if this really is a spurious interrupt and ACK it
 	 * if it is a vectored one.  Just in case...
@@ -1265,6 +1292,9 @@ fastcall void smp_error_interrupt(struct
 	unsigned long v, v1;
 
 	irq_enter();
+
+	dyntick_interrupt(regs);
+
 	/* First tickle the hardware, only then report what went on. -- REW */
 	v = apic_read(APIC_ESR);
 	apic_write(APIC_ESR, 0);
Index: linux-2.6.16-rc4-dt/arch/i386/kernel/dyntick.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.16-rc4-dt/arch/i386/kernel/dyntick.c	2006-02-23 11:39:03.000000000 +1100
@@ -0,0 +1,279 @@
+/*
+ * linux/arch/i386/kernel/dyntick.c
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
+#include <linux/dyntick.h>
+#include <linux/timer.h>
+#include <linux/irq.h>
+#include <linux/kernel_stat.h>
+#include <linux/delay.h>
+#include <asm/apic.h>
+#include <asm/dyntick.h>
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
+		/*
+		 * The PIT timer skips significantly less duration than the
+		 * APIC timer, so we limit it to PIT_MAX_SKIP. As this is the
+		 * last cpu to fall idle we also reprogram its APIC timer to
+		 * wake at the same time.
+		 */
+		unsigned long next;
+
+		skip = PIT_MAX_SKIP;
+		next = jiffies + skip;
+		dyntick->tick = next;
+		__get_cpu_var(dyn_cpu).next_tick = next;
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
+static struct dyntick_timer arch_dyntick = {
+	.lock			= SPIN_LOCK_UNLOCKED,
+	.arch_reprogram		= &null_reprogram,
+	.arch_all_cpus_idle	= &null_idle_handler,
+	.arch_enable		= &arch_enable,
+	.arch_disable		= &arch_disable,
+};
+
+struct dyntick_timer *dyntick = &arch_dyntick;
+
+/*
+ * Only PIT timer skipping is reliable so this is used on all configurations.
+ * All PIT skipping is done from arch_all_cpus_idle in either UP or SMP.
+ * When local APIC support on UP is enabled, the local APIC timer is disabled
+ * when dynticks is enabled and the PIT timer is used. On SMP each cpu also
+ * skips APIC ticks according to its own next timer interrupt from
+ * arch_reprogram.
+ */
+int __init dyntick_arch_init(void)
+{
+	if (dyn_handler.skip_handler == SKIP_APIC && num_present_cpus()> 1)
+		dyn_handler.skip_handler = SKIP_SMP_APIC;
+
+	switch (dyn_handler.skip_handler) {
+		case SKIP_PIT:
+			printk(KERN_INFO "dyntick: Using PIT "
+				"reprogramming\n");
+			dyntick->arch_all_cpus_idle = &reprogram_pit_handler;
+			set_dyntick_limits(PIT_MAX_SKIP, 1);
+			break;
+		case SKIP_APIC:
+			printk(KERN_INFO "dyntick: Disabling APIC timer, "
+				"using PIT reprogramming\n");
+			dyntick->arch_all_cpus_idle = &reprogram_pit_handler;
+			set_dyntick_limits(PIT_MAX_SKIP, 1);
+			stop_local_apic();
+			break;
+		case SKIP_SMP_APIC:
+			printk(KERN_INFO "dyntick: Using per cpu APIC "
+				"reprogramming, skipping PIT when all cpus "
+				"idle\n");
+			dyntick->arch_reprogram = &apic_reprogram;
+			dyntick->arch_all_cpus_idle = &smp_idle_handler;
+			dyn_handler.cpu_wake = &reset_apic_timer;
+			break;
+	}
+	cpus_clear(nohz_cpu_mask);
+	printk(KERN_INFO "dyntick: Maximum ticks to skip limited to %i\n",
+		dyntick->max_skip);
+
+	return 0;
+}
+
+static int __init dyntick_init(void)
+{
+	dyntick->arch_init = dyntick_arch_init;
+	dyntick_register(&arch_dyntick);
+
+	return 0;
+}
+
+arch_initcall(dyntick_init);
+
+void __init setup_dyntick_use_apic(void)
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
+static void do_dyntick_interrupt(struct pt_regs *regs)
+{
+	int cpu = smp_processor_id();
+
+	dyn_handler.cpu_wake();
+
+	spin_lock(&dyntick->lock);
+	if (clear_nohz_cpu(cpu)) {
+		int lost;
+
+		spin_unlock(&dyntick->lock);
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
+		spin_unlock(&dyntick->lock);
+}
+
+/*
+ * This is called from all interrupt handlers. It checks per_cpu data first
+ * to see that this cpu is not currently skipping ticks. If it is skipping
+ * ticks it calls do_dyntick_interrupt.
+ */
+void dyntick_interrupt(struct pt_regs *regs)
+{
+	if (test_nohz_cpu())
+		do_dyntick_interrupt(regs);
+}
+
+/* Updates the irq idle timestamp when we reprogram it */
+void set_irq_idle_timestamp(const unsigned long next)
+{
+	__get_cpu_var(irq_stat).idle_timestamp = next;
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
+void __init dyntick_time_init(struct timer_opts *cur_timer)
+{
+	if (strncmp(cur_timer->name, "pmtmr", 3) == 0) {
+		dyntick->state |= dyntick_SUITABLE;
+		printk(KERN_INFO "dyntick: Found suitable timer: %s\n",
+			cur_timer->name);
+	} else
+		printk(KERN_ERR "dyntick: Cannot use timer %s - pmtmr "
+			"failed: ACPI disabled?\n", cur_timer->name);
+}
Index: linux-2.6.16-rc4-dt/arch/i386/kernel/irq.c
===================================================================
--- linux-2.6.16-rc4-dt.orig/arch/i386/kernel/irq.c	2006-02-18 10:36:52.000000000 +1100
+++ linux-2.6.16-rc4-dt/arch/i386/kernel/irq.c	2006-02-23 11:24:12.000000000 +1100
@@ -18,6 +18,8 @@
 #include <linux/notifier.h>
 #include <linux/cpu.h>
 #include <linux/delay.h>
+#include <linux/dyntick.h>
+#include <asm/dyntick.h>
 
 DEFINE_PER_CPU(irq_cpustat_t, irq_stat) ____cacheline_internodealigned_in_smp;
 EXPORT_PER_CPU_SYMBOL(irq_stat);
@@ -76,6 +78,8 @@ fastcall unsigned int do_IRQ(struct pt_r
 	}
 #endif
 
+	dyntick_interrupt(regs);
+
 #ifdef CONFIG_4KSTACKS
 
 	curctx = (union irq_ctx *) current_thread_info();
Index: linux-2.6.16-rc4-dt/arch/i386/kernel/Makefile
===================================================================
--- linux-2.6.16-rc4-dt.orig/arch/i386/kernel/Makefile	2006-02-18 10:36:52.000000000 +1100
+++ linux-2.6.16-rc4-dt/arch/i386/kernel/Makefile	2006-02-23 11:24:12.000000000 +1100
@@ -33,6 +33,7 @@ obj-$(CONFIG_MODULES)		+= module.o
 obj-y				+= sysenter.o vsyscall.o
 obj-$(CONFIG_ACPI_SRAT) 	+= srat.o
 obj-$(CONFIG_HPET_TIMER) 	+= time_hpet.o
+obj-$(CONFIG_NO_IDLE_HZ) 	+= dyntick.o
 obj-$(CONFIG_EFI) 		+= efi.o efi_stub.o
 obj-$(CONFIG_DOUBLEFAULT) 	+= doublefault.o
 obj-$(CONFIG_VM86)		+= vm86.o
Index: linux-2.6.16-rc4-dt/arch/i386/kernel/process.c
===================================================================
--- linux-2.6.16-rc4-dt.orig/arch/i386/kernel/process.c	2006-02-18 10:36:52.000000000 +1100
+++ linux-2.6.16-rc4-dt/arch/i386/kernel/process.c	2006-02-23 11:24:12.000000000 +1100
@@ -39,6 +39,7 @@
 #include <linux/ptrace.h>
 #include <linux/random.h>
 #include <linux/kprobes.h>
+#include <linux/dyntick.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -57,6 +58,7 @@
 
 #include <asm/tlbflush.h>
 #include <asm/cpu.h>
+#include <asm/dyntick.h>
 
 asmlinkage void ret_from_fork(void) __asm__("ret_from_fork");
 
@@ -195,6 +197,8 @@ void cpu_idle(void)
 				play_dead();
 
 			__get_cpu_var(irq_stat).idle_timestamp = jiffies;
+			idle_reprogram_timer();
+
 			idle();
 		}
 		preempt_enable_no_resched();
Index: linux-2.6.16-rc4-dt/arch/i386/kernel/smp.c
===================================================================
--- linux-2.6.16-rc4-dt.orig/arch/i386/kernel/smp.c	2005-10-28 20:21:34.000000000 +1000
+++ linux-2.6.16-rc4-dt/arch/i386/kernel/smp.c	2006-02-23 11:24:12.000000000 +1100
@@ -20,9 +20,11 @@
 #include <linux/interrupt.h>
 #include <linux/cpu.h>
 #include <linux/module.h>
+#include <linux/dyntick.h>
 
 #include <asm/mtrr.h>
 #include <asm/tlbflush.h>
+#include <asm/dyntick.h>
 #include <mach_apic.h>
 
 /*
@@ -313,6 +315,8 @@ fastcall void smp_invalidate_interrupt(s
 {
 	unsigned long cpu;
 
+	dyntick_interrupt(regs);
+
 	cpu = get_cpu();
 
 	if (!cpu_isset(cpu, flush_cpumask))
@@ -600,6 +604,8 @@ void smp_send_stop(void)
 fastcall void smp_reschedule_interrupt(struct pt_regs *regs)
 {
 	ack_APIC_irq();
+
+	dyntick_interrupt(regs);
 }
 
 fastcall void smp_call_function_interrupt(struct pt_regs *regs)
@@ -609,6 +615,9 @@ fastcall void smp_call_function_interrup
 	int wait = call_data->wait;
 
 	ack_APIC_irq();
+
+	dyntick_interrupt(regs);
+
 	/*
 	 * Notify initiating CPU that I've grabbed the data and am
 	 * about to execute the function
Index: linux-2.6.16-rc4-dt/include/asm-i386/apic.h
===================================================================
--- linux-2.6.16-rc4-dt.orig/include/asm-i386/apic.h	2006-02-18 10:37:18.000000000 +1100
+++ linux-2.6.16-rc4-dt/include/asm-i386/apic.h	2006-02-23 11:24:12.000000000 +1100
@@ -121,6 +121,7 @@ extern void nmi_watchdog_tick (struct pt
 extern int APIC_init_uniprocessor (void);
 extern void disable_APIC_timer(void);
 extern void enable_APIC_timer(void);
+extern void reprogram_apic_timer(unsigned long count);
 
 extern void enable_NMI_through_LVT0 (void * dummy);
 
@@ -139,6 +140,7 @@ void switch_ipi_to_APIC_timer(void *cpum
 
 #else /* !CONFIG_X86_LOCAL_APIC */
 static inline void lapic_shutdown(void) { }
+static inline void reprogram_apic_timer(unsigned long count) { }
 
 #endif /* !CONFIG_X86_LOCAL_APIC */
 
Index: linux-2.6.16-rc4-dt/include/asm-i386/dyntick.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.16-rc4-dt/include/asm-i386/dyntick.h	2006-02-23 11:38:34.000000000 +1100
@@ -0,0 +1,70 @@
+/*
+ * linux/include/asm-i386/dyntick.h
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
+#ifndef _ASM_I386_dyntick_H_
+#define _ASM_I386_dyntick_H_
+
+#include <asm/apic.h>
+#include <asm/timer.h>
+
+#ifdef CONFIG_NO_IDLE_HZ
+extern void idle_reprogram_timer(void);
+extern void dyntick_interrupt(struct pt_regs *regs);
+extern void __init setup_dyntick_use_apic(void);
+extern void __init dyntick_time_init(struct timer_opts *cur_timer);
+extern void set_irq_idle_timestamp(const unsigned long next);
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
+static inline void dyntick_interrupt(struct pt_regs *__unused)
+{
+}
+
+static inline void setup_dyntick_use_apic(void)
+{
+}
+
+static inline void dyntick_time_init(struct timer_opts *__unused)
+{
+}
+#endif	/* CONFIG_NO_IDLE_HZ */
+
+#endif /* _ASM_I386_dyntick_H_ */
Index: linux-2.6.16-rc4-dt/kernel/timer_top.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.16-rc4-dt/kernel/timer_top.c	2006-02-23 11:39:38.000000000 +1100
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
Index: linux-2.6.16-rc4-dt/lib/Kconfig.debug
===================================================================
--- linux-2.6.16-rc4-dt.orig/lib/Kconfig.debug	2006-02-18 10:37:19.000000000 +1100
+++ linux-2.6.16-rc4-dt/lib/Kconfig.debug	2006-02-23 11:39:38.000000000 +1100
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
 	depends on DEBUG_KERNEL && SLAB
Index: linux-2.6.16-rc4-dt/drivers/input/serio/i8042.h
===================================================================
--- linux-2.6.16-rc4-dt.orig/drivers/input/serio/i8042.h	2006-01-03 17:36:19.000000000 +1100
+++ linux-2.6.16-rc4-dt/drivers/input/serio/i8042.h	2006-02-23 11:39:39.000000000 +1100
@@ -44,7 +44,7 @@
  * polling.
  */
 
-#define I8042_POLL_PERIOD	HZ/20
+#define I8042_POLL_PERIOD	HZ/5
 
 /*
  * Status register bits.
Index: linux-2.6.16-rc4-dt/drivers/acpi/processor_idle.c
===================================================================
--- linux-2.6.16-rc4-dt.orig/drivers/acpi/processor_idle.c	2006-02-18 10:36:54.000000000 +1100
+++ linux-2.6.16-rc4-dt/drivers/acpi/processor_idle.c	2006-02-23 11:39:40.000000000 +1100
@@ -3,7 +3,7 @@
  *
  *  Copyright (C) 2001, 2002 Andy Grover <andrew.grover@intel.com>
  *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
- *  Copyright (C) 2004       Dominik Brodowski <linux@brodo.de>
+ *  Copyright (C) 2004, 2005 Dominik Brodowski <linux@brodo.de>
  *  Copyright (C) 2004  Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
  *  			- Added processor hotplug support
  *  Copyright (C) 2005  Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
@@ -38,6 +38,7 @@
 #include <linux/dmi.h>
 #include <linux/moduleparam.h>
 #include <linux/sched.h>	/* need_resched() */
+#include <linux/dyntick.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -60,6 +61,8 @@ module_param(max_cstate, uint, 0644);
 static unsigned int nocst = 0;
 module_param(nocst, uint, 0000);
 
+#define BM_JIFFIES	(HZ >= 800 ? 2 : 1)
+
 /*
  * bm_history -- bit-mask with a bit per jiffy of bus-master activity
  * 1000 HZ: 0xFFFFFFFF: 32 jiffies = 32ms
@@ -261,21 +264,15 @@ static void acpi_processor_idle(void)
 		u32 bm_status = 0;
 		unsigned long diff = jiffies - pr->power.bm_check_timestamp;
 
-		if (diff > 32)
-			diff = 32;
+		if (diff > 31)
+			diff = 31;
 
-		while (diff) {
-			/* if we didn't get called, assume there was busmaster activity */
-			diff--;
-			if (diff)
-				pr->power.bm_activity |= 0x1;
-			pr->power.bm_activity <<= 1;
-		}
+		pr->power.bm_activity <<= diff;
 
 		acpi_get_register(ACPI_BITREG_BUS_MASTER_STATUS,
 				  &bm_status, ACPI_MTX_DO_NOT_LOCK);
 		if (bm_status) {
-			pr->power.bm_activity++;
+			pr->power.bm_activity |= 0x1;
 			acpi_set_register(ACPI_BITREG_BUS_MASTER_STATUS,
 					  1, ACPI_MTX_DO_NOT_LOCK);
 		}
@@ -287,16 +284,16 @@ static void acpi_processor_idle(void)
 		else if (errata.piix4.bmisx) {
 			if ((inb_p(errata.piix4.bmisx + 0x02) & 0x01)
 			    || (inb_p(errata.piix4.bmisx + 0x0A) & 0x01))
-				pr->power.bm_activity++;
+				pr->power.bm_activity |= 0x1;
 		}
 
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
@@ -304,8 +301,11 @@ static void acpi_processor_idle(void)
 		 *      qualification.  This may, however, introduce DMA
 		 *      issues (e.g. floppy DMA transfer overrun/underrun).
 		 */
-		if (pr->power.bm_activity & cx->demotion.threshold.bm) {
+		if ((pr->power.bm_activity & 0x1) &&
+		    cx->demotion.threshold.bm) {
 			local_irq_enable();
+			if (!pr->power.pre_bm_state)
+				pr->power.pre_bm_state = cx;
 			next_state = cx->demotion.state;
 			goto end;
 		}
@@ -322,7 +322,68 @@ static void acpi_processor_idle(void)
 		cx = &pr->power.states[ACPI_STATE_C1];
 #endif
 
-	cx->usage++;
+	/*
+	 * Some special policy tweaks for dynamic ticks
+	 */
+	if (dyntick_enabled()) {
+	       /*
+		* Kick-back promotion: promote to C-State used before bm
+		* activity was detected if
+		*	- we have a pre-bm-state
+		*	- we do not have bus mastering at the moment
+  	  	*  	- we're scheduled to sleep at least BM_JIFFIES now
+		*/
+		if (pr->power.pre_bm_state &&
+		    !(pr->power.bm_activity & 0x1) &&
+		    (dyntick_current_skip() >= BM_JIFFIES)) {
+			local_irq_enable();
+			next_state = pr->power.pre_bm_state;
+			pr->power.pre_bm_state = NULL;
+			goto end;
+		}
+
+		/*
+		 * Fast-path promotion: promote to higher state if
+		 *   	- we can promote
+		 *	- there is no bm_activity this tick
+		 *	- we slept more than BM_JIFFIES ticks last time
+		 *	- we're scheduled to sleep at least BM_JIFFIES ticks
+ 		 */
+		if (cx->promotion.state &&
+		    !(pr->power.bm_activity & 0x1) &&
+		    (pr->power.last_sleep > BM_JIFFIES) &&
+		    (dyntick_current_skip() >= BM_JIFFIES)) {
+			local_irq_enable();
+			next_state = cx->promotion.state;
+			/*
+			 * Super-fast-path: promote to next higher state if
+			 * 	- we can promote
+			 *	- we did sleep longer than 2 * BM_JIFFIES
+			 *	  times last time
+			 *	- we're scheduled to sleep at least 2 *
+			 *	  BM_JIFFIES ticks
+			 */
+			if ((next_state->promotion.state) &&
+			    (pr->power.last_sleep > 2 * BM_JIFFIES) &&
+			    (dyntick_current_skip() >= 2 * BM_JIFFIES))
+				next_state = next_state->promotion.state;
+			pr->power.pre_bm_state = NULL;
+			goto end;
+		}
+
+		/*
+		 * Re-program if bm activity is present this jiffy -- we hope
+		 * that it ends soon, so that we can go into a deeper sleep
+		 * type
+		 */
+		if (cx->demotion.state &&
+		    (pr->power.bm_activity & 0x1) &&
+		    (pr->power.bm_check_timestamp == jiffies)) {
+			dyn_early_reprogram(BM_JIFFIES);
+		}
+	}
+
+	pr->power.last_sleep = 0;
 
 	/*
 	 * Sleep:
@@ -422,6 +483,13 @@ static void acpi_processor_idle(void)
 		return;
 	}
 
+	/* Accounting */
+	cx->usage++;
+	if ((cx->type != ACPI_STATE_C1) && (sleep_ticks > 0))
+		cx->time += sleep_ticks;
+	pr->power.last_sleep = sleep_ticks / (PM_TIMER_FREQUENCY / HZ);
+
+
 	next_state = pr->power.state;
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -454,10 +522,12 @@ static void acpi_processor_idle(void)
 					     promotion.threshold.bm)) {
 						next_state =
 						    cx->promotion.state;
+						pr->power.pre_bm_state = NULL;
 						goto end;
 					}
 				} else {
 					next_state = cx->promotion.state;
+					pr->power.pre_bm_state = NULL;
 					goto end;
 				}
 			}
@@ -475,6 +545,7 @@ static void acpi_processor_idle(void)
 			cx->demotion.count++;
 			cx->promotion.count = 0;
 			if (cx->demotion.count >= cx->demotion.threshold.count) {
+				pr->power.pre_bm_state = NULL;
 				next_state = cx->demotion.state;
 				goto end;
 			}
@@ -1048,9 +1119,10 @@ static int acpi_processor_power_seq_show
 		else
 			seq_puts(seq, "demotion[--] ");
 
-		seq_printf(seq, "latency[%03d] usage[%08d]\n",
+		seq_printf(seq, "latency[%03d] usage[%08d] duration[%020llu]\n",
 			   pr->power.states[i].latency,
-			   pr->power.states[i].usage);
+			   pr->power.states[i].usage,
+			   pr->power.states[i].time);
 	}
 
       end:
Index: linux-2.6.16-rc4-dt/include/acpi/processor.h
===================================================================
--- linux-2.6.16-rc4-dt.orig/include/acpi/processor.h	2006-02-18 10:37:17.000000000 +1100
+++ linux-2.6.16-rc4-dt/include/acpi/processor.h	2006-02-23 11:39:40.000000000 +1100
@@ -51,6 +51,7 @@ struct acpi_processor_cx {
 	u32 latency_ticks;
 	u32 power;
 	u32 usage;
+	u64 time;
 	struct acpi_processor_cx_policy promotion;
 	struct acpi_processor_cx_policy demotion;
 };
@@ -60,8 +61,10 @@ struct acpi_processor_power {
 	unsigned long bm_check_timestamp;
 	u32 default_state;
 	u32 bm_activity;
+	u16 last_sleep;
 	int count;
 	struct acpi_processor_cx states[ACPI_PROCESSOR_MAX_POWER];
+	struct acpi_processor_cx *pre_bm_state;
 };
 
 /* Performance Management */
Index: linux-2.6.16-rc4-dt/kernel/hrtimer.c
===================================================================
--- linux-2.6.16-rc4-dt.orig/kernel/hrtimer.c	2006-02-18 10:37:19.000000000 +1100
+++ linux-2.6.16-rc4-dt/kernel/hrtimer.c	2006-02-25 15:14:55.000000000 +1100
@@ -505,6 +505,79 @@ ktime_t hrtimer_get_remaining(const stru
 	return rem;
 }
 
+#ifdef CONFIG_NO_IDLE_HZ
+
+/**
+ * hrtimer_get_next - get next hrtimer to expire
+ *
+ * @bases:	ktimer base array
+ */
+static inline struct hrtimer * hrtimer_get_next(struct hrtimer_base *bases)
+{
+	unsigned long flags;
+	struct hrtimer *timer = NULL;
+	int i;
+
+	for (i = 0; i < MAX_HRTIMER_BASES; i++) {
+		struct hrtimer_base *base;
+		struct hrtimer *cur;
+
+		base = &bases[i];
+		spin_lock_irqsave(&base->lock, flags);
+		cur = rb_entry(base->first, struct hrtimer, node);
+		spin_unlock_irqrestore(&base->lock, flags);
+
+		if (cur == NULL)
+			continue;
+
+		if (timer == NULL || cur->expires.tv64 < timer->expires.tv64)
+			timer = cur;
+	}
+
+	return timer;
+}
+
+/**
+ * ktime_to_jiffies - converts ktime to jiffies
+ *
+ * @event:	ktime event to be converted to jiffies
+ *
+ * Caller must take care xtime locking.
+ */
+static inline unsigned long ktime_to_jiffies(const ktime_t event)
+{
+	ktime_t now, delta;
+
+	now = timespec_to_ktime(xtime);
+	delta = ktime_sub(event, now);
+
+	return jiffies + (((delta.tv64 * NSEC_CONVERSION) >>
+			(NSEC_JIFFIE_SC - SEC_JIFFIE_SC)) >> SEC_JIFFIE_SC);
+}
+
+/**
+ * hrtimer_next_jiffie - get next hrtimer event in jiffies
+ *
+ * Called from next_timer_interrupt() to get the next hrtimer event.
+ * Eventually we should change next_timer_interrupt() to return
+ * results in nanoseconds instead of jiffies. Caller must host xtime_lock.
+ */
+int hrtimer_next_jiffie(unsigned long *next_jiffie)
+{
+	struct hrtimer_base *base = __get_cpu_var(hrtimer_bases);
+	struct hrtimer * timer;
+
+	timer = hrtimer_get_next(base);
+	if (timer == NULL)
+		return -EAGAIN;
+
+	*next_jiffie = ktime_to_jiffies(timer->expires);
+
+	return 0;
+}
+
+#endif
+
 /**
  * hrtimer_init - initialize a timer to the given clock
  *
Index: linux-2.6.16-rc4-dt/include/linux/hrtimer.h
===================================================================
--- linux-2.6.16-rc4-dt.orig/include/linux/hrtimer.h	2006-02-18 10:37:19.000000000 +1100
+++ linux-2.6.16-rc4-dt/include/linux/hrtimer.h	2006-02-25 15:14:55.000000000 +1100
@@ -115,6 +115,7 @@ extern int hrtimer_try_to_cancel(struct 
 /* Query timers: */
 extern ktime_t hrtimer_get_remaining(const struct hrtimer *timer);
 extern int hrtimer_get_res(const clockid_t which_clock, struct timespec *tp);
+extern int hrtimer_next_jiffie(unsigned long *next_jiffie);
 
 static inline int hrtimer_active(const struct hrtimer *timer)
 {
