Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbVLPPe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbVLPPe1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 10:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbVLPPe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 10:34:27 -0500
Received: from mail05.syd.optusnet.com.au ([211.29.132.186]:16818 "EHLO
	mail05.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751283AbVLPPeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 10:34:25 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] i386 No Idle HZ aka dynticks 051216
Date: Sat, 17 Dec 2005 02:33:11 +1100
User-Agent: KMail/1.9
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Petrini <d.pensator@gmail.com>, Tony Lindgren <tony@atomide.com>,
       vatsa@in.ibm.com, ck list <ck@vds.kolivas.org>,
       Pavel Machek <pavel@ucw.cz>, Adam Belay <abelay@novell.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
MIME-Version: 1.0
Message-Id: <200512170233.15628.kernel@kolivas.org>
X-Length: 65737
Content-Type: multipart/signed;
  boundary="nextPart1678477.cyGSsIncVv";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1678477.cyGSsIncVv
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Here is an updated version of the dynticks code.

Changes:

The problem with unreliable APICs was fixed - a sanity check to see that mo=
re
than the maximum skip time was lost and if so dynticks drops to PIT.

A small improvement in cacheline thrashing was done by using per cpu variab=
les
and reading them first where possible.

Timertop was updated to clean up its data if passed the stop command and had
some locking improvements and cleanups added.

The timertop utility was updated slightly to match the timertop patch

Numerous other small cleanups

The only known issue remaining is that cpu accounting (eg time make) will
wrongly report high percentages.

Latest patch, split patches and timer utilties available here:
http://ck.kolivas.org/patches/dyn-ticks/

Rolled up patch in this email.

Cheers,
Con
=2D--
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
 arch/i386/kernel/apic.c                 |   33 +++
 arch/i386/kernel/dyn-tick.c             |  182 +++++++++++++++++++++
 arch/i386/kernel/io_apic.c              |   26 ++-
 arch/i386/kernel/irq.c                  |    4
 arch/i386/kernel/process.c              |    4
 arch/i386/kernel/smp.c                  |    9 +
 arch/i386/kernel/time.c                 |   19 +-
 arch/i386/kernel/timers/timer_cyclone.c |    4
 arch/i386/kernel/timers/timer_hpet.c    |    4
 arch/i386/kernel/timers/timer_none.c    |    3
 arch/i386/kernel/timers/timer_pit.c     |   35 ++++
 arch/i386/kernel/timers/timer_pm.c      |   32 +--
 arch/i386/kernel/timers/timer_tsc.c     |   62 +++----
 drivers/acpi/Kconfig                    |    2
 drivers/acpi/processor_idle.c           |   51 +++++-
 include/acpi/processor.h                |    1
 include/asm-i386/apic.h                 |    2
 include/asm-i386/dyn-tick.h             |   65 +++++++
 include/asm-i386/timer.h                |   39 ++++
 include/linux/dyn-tick.h                |   88 ++++++++++
 include/linux/timer.h                   |    1
 kernel/Makefile                         |    2
 kernel/dyn-tick.c                       |  266 +++++++++++++++++++++++++++=
+++++
 kernel/timer.c                          |   10 +
 kernel/timer_top.c                      |  234 ++++++++++++++++++++++++++++
 lib/Kconfig.debug                       |   13 +
 29 files changed, 1140 insertions(+), 73 deletions(-)

Index: linux-2.6.15-rc5-dt/include/linux/dyn-tick.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- /dev/null
+++ linux-2.6.15-rc5-dt/include/linux/dyn-tick.h
@@ -0,0 +1,88 @@
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
+/* Ok to be zero but no point reprogramming for <2ms intervals */
+#define DYN_TICK_MIN_SKIP	(HZ / 1000)
+/* Baseline tick rate of slowest timers in kernel - used for sanity checks=
 */
+#define DYN_TICK_MAX_SKIP	(HZ / 5)
+
+struct dyn_tick_timer {
+	spinlock_t lock;
+
+	int (*arch_init) (void);	/* dyn_tick init */
+	int (*arch_enable)(void);	/* Enables dynamic tick */
+	int (*arch_disable)(void);	/* Disables dynamic tick */
+	void (*arch_reprogram)(unsigned long);	/* Reprograms the timer */
+	void (*arch_all_cpus_idle) (int);	/* Function called when all */
+						/* cpus are idle */
+
+	unsigned short state;		/* Current state */
+	unsigned int min_skip;		/* Min number of ticks to skip */
+	unsigned int max_skip;		/* Max number of ticks to skip */
+	unsigned long skip_tick;	/* Current tick we started skipping */
+	unsigned long last_skip;	/* Last tick we started skipping */
+	unsigned long skip;		/* Ticks we're currently skipping */
+};
+
+extern struct dyn_tick_timer *dyn_tick;
+extern spinlock_t *dyn_tick_lock;
+
+extern void dyn_tick_register(struct dyn_tick_timer *new_timer);
+
+#ifdef CONFIG_NO_IDLE_HZ
+DECLARE_PER_CPU(unsigned int, nohz_cpu);
+extern int dyn_tick_enabled(void);
+extern void timer_dyn_reprogram(void);
+extern void dyn_early_reprogram(unsigned int delta);
+extern void set_dyn_tick_limits(unsigned int max_skip, unsigned int min_sk=
ip);
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
Index: linux-2.6.15-rc5-dt/include/linux/timer.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15-rc5-dt.orig/include/linux/timer.h
+++ linux-2.6.15-rc5-dt/include/linux/timer.h
@@ -97,5 +97,6 @@ static inline void add_timer(struct time
 extern void init_timers(void);
 extern void run_local_timers(void);
 extern void it_real_fn(unsigned long);
+extern void conditional_run_local_timers(void);
=20
 #endif
Index: linux-2.6.15-rc5-dt/kernel/dyn-tick.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- /dev/null
+++ linux-2.6.15-rc5-dt/kernel/dyn-tick.c
@@ -0,0 +1,266 @@
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
+#define DYN_TICK_VERSION	"051216"
+
+EXPORT_SYMBOL(dyn_tick);
+
+int dyn_tick_enabled(void)
+{
+	return !!(dyn_tick->state & DYN_TICK_ENABLED);
+}
+
+EXPORT_SYMBOL(dyn_tick_enabled);
+
+static inline int dyn_tick_suitable(void)
+{
+	return !!(dyn_tick->state & DYN_TICK_SUITABLE);
+}
+
+/*
+ * do_dyn_reprogram does the actual reprogramming. We should have already
+ * checked that the tick chosen is suitable and xtime_lock and dyn_tick->l=
ock
+ * must be held, and interrupts disabled.
+ */
+static void do_dyn_reprogram(unsigned int delta)
+{
+	dyn_tick->last_skip =3D dyn_tick->skip_tick;
+	dyn_tick->skip_tick =3D jiffies;
+	dyn_tick->skip =3D delta;
+	dyn_tick->arch_reprogram(jiffies + delta);
+}
+
+/*
+ * Per cpu nohz information. This seems redundant but querying this first
+ * elsewhere can avoid the need to query nohz_cpu_mask and the subsequent
+ * cache thrashing.
+ */
+DEFINE_PER_CPU(unsigned int, nohz_cpu);
+
+static inline void set_nohz_cpu(int cpu)
+{
+	if (get_cpu_var(nohz_cpu))
+		goto out;
+	__get_cpu_var(nohz_cpu) =3D 1;
+	cpu_set(cpu, nohz_cpu_mask);
+out:
+	put_cpu_var(nohz_cpu);
+}
+
+/*
+ * Arch independent code needed to reprogram next timer interrupt.
+ * Gets called, with IRQs disabled, from cpu_idle() before entering idle l=
oop.
+ */
+void timer_dyn_reprogram(void)
+{
+	int cpu;
+	unsigned int delta;
+
+	if (!dyn_tick_enabled())
+		return;
+
+	cpu =3D smp_processor_id();
+	if (rcu_pending(cpu) || local_softirq_pending())
+		return;
+
+	write_seqlock(&xtime_lock);
+
+	delta =3D next_timer_interrupt() - jiffies;
+	if (delta > dyn_tick->max_skip)
+		delta =3D dyn_tick->max_skip;
+
+	if (delta > dyn_tick->min_skip) {
+		int idle_time =3D 0;
+
+		if (dyn_tick->skip_tick + dyn_tick->skip =3D=3D jiffies)
+			idle_time =3D dyn_tick->skip;
+		spin_lock(&dyn_tick->lock);
+
+		do_dyn_reprogram(delta);
+
+		set_nohz_cpu(cpu);
+		if (cpus_equal(nohz_cpu_mask, cpu_online_map))
+			dyn_tick->arch_all_cpus_idle(idle_time);
+
+		spin_unlock(&dyn_tick->lock);
+	}
+
+	write_sequnlock(&xtime_lock);
+}
+
+/*
+ * dyn_early_reprogram is used to reprogram an earlier tick than is curren=
tly
+ * set by timer_dyn_reprogram.
+ * dyn_early_reprogram allows other code such as the acpi idle code to
+ * program an earlier tick than the one already chosen by timer_dyn_reprog=
ram.
+ * It only reprograms it if the tick is earlier than the next one planned.
+ */
+void dyn_early_reprogram(unsigned int delta)
+{
+	unsigned long flags, tick =3D jiffies + delta;
+
+	if (tick >=3D dyn_tick->last_skip + dyn_tick->skip)
+		return;
+
+	write_seqlock_irqsave(&xtime_lock, flags);
+	spin_lock(&dyn_tick->lock);
+	do_dyn_reprogram(delta);
+	spin_unlock(&dyn_tick->lock);
+	write_sequnlock_irqrestore(&xtime_lock, flags);
+}
+
+EXPORT_SYMBOL(dyn_early_reprogram);
+
+void set_dyn_tick_limits(unsigned int max_skip, unsigned int min_skip)
+{
+	if (max_skip > DYN_TICK_MAX_SKIP)
+		max_skip =3D DYN_TICK_MAX_SKIP;
+	if (!dyn_tick->max_skip || max_skip < dyn_tick->max_skip)
+		dyn_tick->max_skip =3D max_skip;
+	if (min_skip < DYN_TICK_MIN_SKIP)
+		min_skip =3D DYN_TICK_MIN_SKIP;
+	if (min_skip > dyn_tick->min_skip)
+		dyn_tick->min_skip =3D min_skip;
+}
+
+void __init dyn_tick_register(struct dyn_tick_timer *arch_timer)
+{
+	dyn_tick =3D arch_timer;
+}
+
+/* Default to enabled */
+static int __initdata dyntick_autoenable =3D 1;
+
+/*
+ * Command line options.
+ *
+ *  dyntick=3D[enable|disable]
+ */
+static int __init dyntick_setup(char *options)
+{
+	if (!options)
+		return 0;
+
+	if (!strncmp(options, "enable", 5))
+		dyntick_autoenable =3D 1;
+	if (!strncmp(options, "disable", 6))
+		dyntick_autoenable =3D 0;
+
+	return 0;
+}
+
+__setup("dyntick=3D", dyntick_setup);
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
+	unsigned int enable =3D simple_strtoul(buf, NULL, 2);
+	int ret =3D -ENODEV;
+
+	write_seqlock_irqsave(&xtime_lock, flags);
+	if (enable) {
+		ret =3D dyn_tick->arch_enable();
+		if (ret =3D=3D 0) {
+			dyn_tick->state |=3D DYN_TICK_ENABLED;
+			printk(KERN_INFO
+				"dyn-tick: Enabling dynamic tick timer \n");
+		}
+	} else {
+		ret =3D dyn_tick->arch_disable();
+		if (ret =3D=3D 0) {
+			dyn_tick->state &=3D ~DYN_TICK_ENABLED;
+			printk(KERN_INFO
+				"dyn-tick: Disabling dynamic tick timer \n");
+		}
+	}
+	write_sequnlock_irqrestore(&xtime_lock, flags);
+
+	return count;
+}
+
+static SYSDEV_ATTR(dyn_tick, 0644, timer_show_dyn_tick, timer_set_dyn_tick=
);
+
+static int __init init_dyn_tick_sysfs(void)
+{
+	int ret =3D sysdev_create_file(&device_timer, &attr_dyn_tick);
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
+	if (dyn_tick =3D=3D NULL || dyn_tick->arch_init =3D=3D NULL ||
+	    !dyn_tick_suitable()) {
+		printk(KERN_ERR "dyn-tick: No suitable timer found\n");
+		return -ENODEV;
+	}
+
+	if ((ret =3D dyn_tick->arch_init())) {
+		printk(KERN_ERR "dyn-tick: Init failed\n");
+		return -ENODEV;
+	}
+
+	if (!ret && dyntick_autoenable) {
+		dyn_tick->state |=3D DYN_TICK_ENABLED;
+		printk(KERN_INFO "dyn-tick: Enabling dynamic tick timer v%s\n",
+			DYN_TICK_VERSION);
+	} else
+		printk(KERN_INFO "dyn-tick: Dynamic tick timer v%s disabled\n",
+			DYN_TICK_VERSION);
+
+	dyn_tick->skip_tick =3D 0;
+	dyn_tick->last_skip =3D 0;
+	dyn_tick->skip =3D 0;
+
+	return ret;
+}
+
+late_initcall(dyn_tick_late_init);
Index: linux-2.6.15-rc5-dt/kernel/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15-rc5-dt.orig/kernel/Makefile
+++ linux-2.6.15-rc5-dt/kernel/Makefile
@@ -32,6 +32,8 @@ obj-$(CONFIG_GENERIC_HARDIRQS) +=3D irq/
 obj-$(CONFIG_CRASH_DUMP) +=3D crash_dump.o
 obj-$(CONFIG_SECCOMP) +=3D seccomp.o
 obj-$(CONFIG_RCU_TORTURE_TEST) +=3D rcutorture.o
+obj-$(CONFIG_NO_IDLE_HZ) +=3D dyn-tick.o
+obj-$(CONFIG_TIMER_INFO) +=3D timer_top.o
=20
 ifneq ($(CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-poi=
nter is
Index: linux-2.6.15-rc5-dt/kernel/timer.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15-rc5-dt.orig/kernel/timer.c
+++ linux-2.6.15-rc5-dt/kernel/timer.c
@@ -33,6 +33,7 @@
 #include <linux/posix-timers.h>
 #include <linux/cpu.h>
 #include <linux/syscalls.h>
+#include <linux/dyn-tick.h>
=20
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -540,6 +541,8 @@ found:
 				expires =3D nte->expires;
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
=20
+void conditional_run_local_timers(void)
+{
+	tvec_base_t *base  =3D &__get_cpu_var(tvec_bases);
+
+	if (base->timer_jiffies !=3D jiffies)
+		run_local_timers();
+}
 /*
  * Called by the timer interrupt. xtime_lock must already be taken
  * by the timer IRQ!
Index: linux-2.6.15-rc5-dt/drivers/acpi/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15-rc5-dt.orig/drivers/acpi/Kconfig
+++ linux-2.6.15-rc5-dt/drivers/acpi/Kconfig
@@ -301,6 +301,8 @@ config X86_PM_TIMER
 	  voltage scaling, unlike the commonly used Time Stamp Counter
 	  (TSC) timing source.
=20
+	  This timer is selected by dyntick (NO_IDLE_HZ).
+
 	  So, if you see messages like 'Losing too many ticks!' in the
 	  kernel logs, and/or you are using this on a notebook which
 	  does not yet have an HPET, you should say "Y" here.
Index: linux-2.6.15-rc5-dt/arch/i386/defconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15-rc5-dt.orig/arch/i386/defconfig
+++ linux-2.6.15-rc5-dt/arch/i386/defconfig
@@ -91,6 +91,7 @@ CONFIG_X86_INTEL_USERCOPY=3Dy
 CONFIG_X86_USE_PPRO_CHECKSUM=3Dy
 # CONFIG_HPET_TIMER is not set
 # CONFIG_HPET_EMULATE_RTC is not set
+# CONFIG_NO_IDLE_HZ is not set
 CONFIG_SMP=3Dy
 CONFIG_NR_CPUS=3D8
 CONFIG_SCHED_SMT=3Dy
Index: linux-2.6.15-rc5-dt/arch/i386/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15-rc5-dt.orig/arch/i386/Kconfig
+++ linux-2.6.15-rc5-dt/arch/i386/Kconfig
@@ -173,6 +173,26 @@ config HPET_EMULATE_RTC
 	depends on HPET_TIMER && RTC=3Dy
 	default y
=20
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
+	  passing dyntick=3Ddisable command line option, or via sysfs:
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
Index: linux-2.6.15-rc5-dt/arch/i386/kernel/apic.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15-rc5-dt.orig/arch/i386/kernel/apic.c
+++ linux-2.6.15-rc5-dt/arch/i386/kernel/apic.c
@@ -26,6 +26,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/sysdev.h>
 #include <linux/cpu.h>
+#include <linux/dyn-tick.h>
=20
 #include <asm/atomic.h>
 #include <asm/smp.h>
@@ -35,6 +36,7 @@
 #include <asm/arch_hooks.h>
 #include <asm/hpet.h>
 #include <asm/i8253.h>
+#include <asm/dyn-tick.h>
=20
 #include <mach_apic.h>
=20
@@ -932,6 +934,9 @@ void (*wait_timer_tick)(void) __devinitd
=20
 #define APIC_DIVISOR 16
=20
+static u32 apic_timer_val __read_mostly;
+#define APIC_TIMER_VAL	((apic_timer_val) / (HZ))
+
 static void __setup_APIC_LVTT(unsigned int clocks)
 {
 	unsigned int lvtt_value, tmp_value, ver;
@@ -950,7 +955,9 @@ static void __setup_APIC_LVTT(unsigned i
 				& ~(APIC_TDR_DIV_1 | APIC_TDR_DIV_TMBASE))
 				| APIC_TDR_DIV_16);
=20
=2D	apic_write_around(APIC_TMICT, clocks/APIC_DIVISOR);
+	apic_timer_val =3D clocks * HZ / APIC_DIVISOR;
+
+	apic_write_around(APIC_TMICT, APIC_TIMER_VAL);
 }
=20
 static void __devinit setup_APIC_timer(unsigned int clocks)
@@ -969,6 +976,17 @@ static void __devinit setup_APIC_timer(u
 	local_irq_restore(flags);
 }
=20
+/* Used by NO_IDLE_HZ to skip ticks on idle CPUs */
+void reprogram_apic_timer(unsigned long count)
+{
+	unsigned long flags;
+
+	count =3D count * apic_timer_val / HZ;
+	local_irq_save(flags);
+	apic_write_around(APIC_TMICT, count);
+	local_irq_restore(flags);
+}
+
 /*
  * In this function we calibrate APIC bus clocks to the external
  * timer. Unfortunately we cannot use jiffies and the timer irq
@@ -1064,6 +1082,10 @@ void __init setup_boot_APIC_clock(void)
 	 */
 	setup_APIC_timer(calibration_result);
=20
+	if (setup_dyn_tick_use_apic(calibration_result))
+		set_dyn_tick_limits((0xFFFFFFFF / calibration_result) *
+			APIC_DIVISOR, 0);
+
 	local_irq_restore(flags);
 }
=20
@@ -1202,6 +1224,9 @@ fastcall void smp_apic_timer_interrupt(s
 	 * interrupt lock, which is the WrongThing (tm) to do.
 	 */
 	irq_enter();
+
+	dyn_tick_interrupt(regs);
+
 	smp_local_timer_interrupt(regs);
 	irq_exit();
 }
@@ -1214,6 +1239,9 @@ fastcall void smp_spurious_interrupt(str
 	unsigned long v;
=20
 	irq_enter();
+
+	dyn_tick_interrupt(regs);
+
 	/*
 	 * Check if this really is a spurious interrupt and ACK it
 	 * if it is a vectored one.  Just in case...
@@ -1238,6 +1266,9 @@ fastcall void smp_error_interrupt(struct
 	unsigned long v, v1;
=20
 	irq_enter();
+
+	dyn_tick_interrupt(regs);
+
 	/* First tickle the hardware, only then report what went on. -- REW */
 	v =3D apic_read(APIC_ESR);
 	apic_write(APIC_ESR, 0);
Index: linux-2.6.15-rc5-dt/arch/i386/kernel/dyn-tick.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- /dev/null
+++ linux-2.6.15-rc5-dt/arch/i386/kernel/dyn-tick.c
@@ -0,0 +1,182 @@
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
+#include <asm/apic.h>
+#include <asm/dyn-tick.h>
+
+/* Fixme: Disable NMI Watchdog */
+static void apic_reprogram(unsigned long jif_next)
+{
+	reprogram_apic_timer(jif_next - jiffies);
+}
+
+static void pit_reprogram(unsigned long jif_next)
+{
+	reprogram_pit_timer(jif_next - jiffies);
+}
+
+static void arch_all_cpus_idle(int __unused)
+{
+	if (dyntick_using_lapic())
+		disable_pit_timer();
+}
+
+static int arch_enable(void)
+{
+	return 0;
+}
+
+static int arch_disable(void)
+{
+	return 0;
+}
+
+static struct dyn_tick_timer arch_dyn_tick =3D {
+	.arch_reprogram		=3D &pit_reprogram,
+	.arch_all_cpus_idle	=3D &arch_all_cpus_idle,
+	.arch_enable		=3D &arch_enable,
+	.arch_disable		=3D &arch_disable,
+	.min_skip		=3D DYN_TICK_MIN_SKIP,
+	.state			=3D 0,
+};
+
+struct dyn_tick_timer *dyn_tick =3D &arch_dyn_tick;
+
+static inline void set_pit_limits(void)
+{
+	set_dyn_tick_limits(0xffff / LATCH, 0);
+}
+
+int __init dyn_tick_arch_init(void)
+{
+	if (!dyntick_using_lapic())
+		set_pit_limits();
+
+	printk(KERN_INFO "dyn-tick: Maximum ticks to skip limited to %i\n",
+		dyn_tick->max_skip);
+
+	return 0;
+}
+
+static int __init dyn_tick_init(void)
+{
+	dyn_tick->arch_init =3D dyn_tick_arch_init;
+	dyn_tick_register(&arch_dyn_tick);
+
+	return 0;
+}
+
+arch_initcall(dyn_tick_init);
+
+static void dyntick_disable_lapic(void)
+{
+	dyn_tick->state &=3D ~DYN_TICK_APICABLE;
+	printk(KERN_INFO "dyn-tick: Cannot use local APIC\n");
+	set_pit_limits();
+	dyn_tick->arch_reprogram =3D &pit_reprogram;
+}
+
+/* Functions that need blank prototypes for !CONFIG_NO_IDLE_HZ below here =
*/
+int __init setup_dyn_tick_use_apic(unsigned int calibration_result)
+{
+	if (calibration_result) {
+		dyn_tick->arch_reprogram =3D &apic_reprogram;
+		dyn_tick->state |=3D DYN_TICK_APICABLE;
+		return 1;
+	}
+	dyntick_disable_lapic();
+	return 0;
+}
+
+/*
+ * The apparently redundant per_cpu nohz_cpu value is tested in this
+ * function and this is where we can avoid the cache thrashing of testing
+ * nohz_cpu_mask
+ */
+static inline int test_nohz_cpu(void)
+{
+	int ret =3D get_cpu_var(nohz_cpu);
+	put_cpu_var(nohz_cpu);
+	return ret;
+}
+
+static inline void clear_nohz_cpu(int cpu)
+{
+	get_cpu_var(nohz_cpu) =3D 0;
+	cpu_clear(cpu, nohz_cpu_mask);
+	put_cpu_var(nohz_cpu);
+}
+
+void dyn_tick_interrupt(struct pt_regs *regs)
+{
+	int cpu;
+
+	if (!test_nohz_cpu())
+		return;
+
+	cpu =3D smp_processor_id();
+
+	spin_lock(&dyn_tick->lock);
+	if (cpus_equal(nohz_cpu_mask, cpu_online_map)) {
+		/* All were sleeping, recover jiffies */
+		int lost =3D cur_timer->mark_offset();
+		if (lost && in_irq())
+			do_timer(regs);
+		if (dyntick_using_lapic()) {
+			enable_pit_timer();
+			if (unlikely(lost > DYN_TICK_MAX_SKIP + 1))
+				dyntick_disable_lapic();
+		}
+		if (lost > 1)
+			kstat_cpu(cpu).cpustat.idle +=3D (lost - 1);
+	}
+	clear_nohz_cpu(cpu);
+	spin_unlock(&dyn_tick->lock);
+
+	/* Make sure we don't miss the next timer tick */
+	dyn_early_reprogram(1);
+
+	conditional_run_local_timers();
+	/* Fixme: Enable NMI watchdog */
+}
+
+
+void __init dyn_tick_time_init(struct timer_opts *cur_timer)
+{
+	spin_lock_init(&dyn_tick->lock);
+
+	if (strncmp(cur_timer->name, "pmtmr", 3) =3D=3D 0) {
+		dyn_tick->state |=3D DYN_TICK_SUITABLE;
+		printk(KERN_INFO "dyn-tick: Found suitable timer: %s\n",
+		       cur_timer->name);
+	} else
+		printk(KERN_ERR "dyn-tick: Cannot use timer %s\n",
+		       cur_timer->name);
+}
+
+inline void idle_reprogram_timer(void)
+{
+	local_irq_disable();
+	if (!need_resched())
+		timer_dyn_reprogram();
+	local_irq_enable();
+}
Index: linux-2.6.15-rc5-dt/arch/i386/kernel/io_apic.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15-rc5-dt.orig/arch/i386/kernel/io_apic.c
+++ linux-2.6.15-rc5-dt/arch/i386/kernel/io_apic.c
@@ -32,6 +32,7 @@
 #include <linux/acpi.h>
 #include <linux/module.h>
 #include <linux/sysdev.h>
+#include <linux/dyn-tick.h>
=20
 #include <asm/io.h>
 #include <asm/smp.h>
@@ -1179,6 +1180,7 @@ next:
=20
 static struct hw_interrupt_type ioapic_level_type;
 static struct hw_interrupt_type ioapic_edge_type;
+static struct hw_interrupt_type ioapic_edge_type_irq0;
=20
 #define IOAPIC_AUTO	-1
 #define IOAPIC_EDGE	0
@@ -1190,15 +1192,19 @@ static inline void ioapic_register_intr(
 		if ((trigger =3D=3D IOAPIC_AUTO && IO_APIC_irq_trigger(irq)) ||
 				trigger =3D=3D IOAPIC_LEVEL)
 			irq_desc[vector].handler =3D &ioapic_level_type;
=2D		else
+		else if (vector)
 			irq_desc[vector].handler =3D &ioapic_edge_type;
+		else
+			irq_desc[vector].handler =3D &ioapic_edge_type_irq0;
 		set_intr_gate(vector, interrupt[vector]);
 	} else	{
 		if ((trigger =3D=3D IOAPIC_AUTO && IO_APIC_irq_trigger(irq)) ||
 				trigger =3D=3D IOAPIC_LEVEL)
 			irq_desc[irq].handler =3D &ioapic_level_type;
=2D		else
+		else if (irq)
 			irq_desc[irq].handler =3D &ioapic_edge_type;
+		else
+			irq_desc[irq].handler =3D &ioapic_edge_type_irq0;
 		set_intr_gate(vector, interrupt[irq]);
 	}
 }
@@ -1311,7 +1317,7 @@ static void __init setup_ExtINT_IRQ0_pin
 	 * The timer IRQ doesn't have to know that behind the
 	 * scene we have a 8259A-master in AEOI mode ...
 	 */
=2D	irq_desc[0].handler =3D &ioapic_edge_type;
+	irq_desc[0].handler =3D &ioapic_edge_type_irq0;
=20
 	/*
 	 * Add it to the IO-APIC irq-routing table:
@@ -2088,6 +2094,20 @@ static struct hw_interrupt_type ioapic_l
 #endif
 };
=20
+/* Needed to disable PIT interrupts when all CPUs sleep */
+static struct hw_interrupt_type ioapic_edge_type_irq0 __read_mostly =3D {
+	.typename 	=3D "IO-APIC-edge-irq0",
+	.startup 	=3D startup_edge_ioapic,
+	.shutdown 	=3D shutdown_edge_ioapic,
+	.enable 	=3D unmask_IO_APIC_irq,
+	.disable 	=3D mask_IO_APIC_irq,
+	.ack 		=3D ack_edge_ioapic,
+	.end 		=3D end_edge_ioapic,
+#ifdef CONFIG_SMP
+	.set_affinity 	=3D set_ioapic_affinity,
+#endif
+};
+
 static inline void init_IO_APIC_traps(void)
 {
 	int irq;
Index: linux-2.6.15-rc5-dt/arch/i386/kernel/irq.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15-rc5-dt.orig/arch/i386/kernel/irq.c
+++ linux-2.6.15-rc5-dt/arch/i386/kernel/irq.c
@@ -18,6 +18,8 @@
 #include <linux/notifier.h>
 #include <linux/cpu.h>
 #include <linux/delay.h>
+#include <linux/dyn-tick.h>
+#include <asm/dyn-tick.h>
=20
 DEFINE_PER_CPU(irq_cpustat_t, irq_stat) ____cacheline_maxaligned_in_smp;
 EXPORT_PER_CPU_SYMBOL(irq_stat);
@@ -76,6 +78,8 @@ fastcall unsigned int do_IRQ(struct pt_r
 	}
 #endif
=20
+	dyn_tick_interrupt(regs);
+
 #ifdef CONFIG_4KSTACKS
=20
 	curctx =3D (union irq_ctx *) current_thread_info();
Index: linux-2.6.15-rc5-dt/arch/i386/kernel/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15-rc5-dt.orig/arch/i386/kernel/Makefile
+++ linux-2.6.15-rc5-dt/arch/i386/kernel/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_MODULES)		+=3D module.o
 obj-y				+=3D sysenter.o vsyscall.o
 obj-$(CONFIG_ACPI_SRAT) 	+=3D srat.o
 obj-$(CONFIG_HPET_TIMER) 	+=3D time_hpet.o
+obj-$(CONFIG_NO_IDLE_HZ) 	+=3D dyn-tick.o
 obj-$(CONFIG_EFI) 		+=3D efi.o efi_stub.o
 obj-$(CONFIG_EARLY_PRINTK)	+=3D early_printk.o
=20
Index: linux-2.6.15-rc5-dt/arch/i386/kernel/process.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15-rc5-dt.orig/arch/i386/kernel/process.c
+++ linux-2.6.15-rc5-dt/arch/i386/kernel/process.c
@@ -39,6 +39,7 @@
 #include <linux/ptrace.h>
 #include <linux/random.h>
 #include <linux/kprobes.h>
+#include <linux/dyn-tick.h>
=20
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -56,6 +57,7 @@
=20
 #include <asm/tlbflush.h>
 #include <asm/cpu.h>
+#include <asm/dyn-tick.h>
=20
 asmlinkage void ret_from_fork(void) __asm__("ret_from_fork");
=20
@@ -193,6 +195,8 @@ void cpu_idle(void)
 			if (cpu_is_offline(cpu))
 				play_dead();
=20
+			idle_reprogram_timer();
+
 			__get_cpu_var(irq_stat).idle_timestamp =3D jiffies;
 			idle();
 		}
Index: linux-2.6.15-rc5-dt/arch/i386/kernel/smp.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15-rc5-dt.orig/arch/i386/kernel/smp.c
+++ linux-2.6.15-rc5-dt/arch/i386/kernel/smp.c
@@ -20,9 +20,11 @@
 #include <linux/interrupt.h>
 #include <linux/cpu.h>
 #include <linux/module.h>
+#include <linux/dyn-tick.h>
=20
 #include <asm/mtrr.h>
 #include <asm/tlbflush.h>
+#include <asm/dyn-tick.h>
 #include <mach_apic.h>
=20
 /*
@@ -313,6 +315,8 @@ fastcall void smp_invalidate_interrupt(s
 {
 	unsigned long cpu;
=20
+	dyn_tick_interrupt(regs);
+
 	cpu =3D get_cpu();
=20
 	if (!cpu_isset(cpu, flush_cpumask))
@@ -600,6 +604,8 @@ void smp_send_stop(void)
 fastcall void smp_reschedule_interrupt(struct pt_regs *regs)
 {
 	ack_APIC_irq();
+
+	dyn_tick_interrupt(regs);
 }
=20
 fastcall void smp_call_function_interrupt(struct pt_regs *regs)
@@ -609,6 +615,9 @@ fastcall void smp_call_function_interrup
 	int wait =3D call_data->wait;
=20
 	ack_APIC_irq();
+
+	dyn_tick_interrupt(regs);
+
 	/*
 	 * Notify initiating CPU that I've grabbed the data and am
 	 * about to execute the function
Index: linux-2.6.15-rc5-dt/arch/i386/kernel/time.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15-rc5-dt.orig/arch/i386/kernel/time.c
+++ linux-2.6.15-rc5-dt/arch/i386/kernel/time.c
@@ -46,6 +46,7 @@
 #include <linux/bcd.h>
 #include <linux/efi.h>
 #include <linux/mca.h>
+#include <linux/dyn-tick.h>
=20
 #include <asm/io.h>
 #include <asm/smp.h>
@@ -56,6 +57,7 @@
 #include <asm/uaccess.h>
 #include <asm/processor.h>
 #include <asm/timer.h>
+#include <asm/dyn-tick.h>
=20
 #include "mach_time.h"
=20
@@ -245,7 +247,7 @@ EXPORT_SYMBOL(profile_pc);
  * timer_interrupt() needs to keep up the real-time clock,
  * as well as call the "do_timer()" routine every clocktick
  */
=2Dstatic inline void do_timer_interrupt(int irq, struct pt_regs *regs)
+static inline void do_timer_interrupt(int irq, struct pt_regs *regs, int l=
ost)
 {
 #ifdef CONFIG_X86_IO_APIC
 	if (timer_ack) {
@@ -263,7 +265,8 @@ static inline void do_timer_interrupt(in
 	}
 #endif
=20
=2D	do_timer_interrupt_hook(regs);
+	if (!dyn_tick_enabled() || lost)
+		do_timer_interrupt_hook(regs);
=20
=20
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
=20
=2D	cur_timer->mark_offset();
=2D=20
=2D	do_timer_interrupt(irq, regs);
+	lost =3D cur_timer->mark_offset();
+
+	do_timer_interrupt(irq, regs, lost);
=20
 	write_sequnlock(&xtime_lock);
 	return IRQ_HANDLED;
@@ -425,7 +430,7 @@ static struct sysdev_class timer_sysclas
=20
=20
 /* XXX this driverfs stuff should probably go elsewhere later -john */
=2Dstatic struct sys_device device_timer =3D {
+struct sys_device device_timer =3D {
 	.id	=3D 0,
 	.cls	=3D &timer_sysclass,
 };
@@ -481,5 +486,7 @@ void __init time_init(void)
 	cur_timer =3D select_timer();
 	printk(KERN_INFO "Using %s for high-res timesource\n",cur_timer->name);
=20
+	dyn_tick_time_init(cur_timer);
+
 	time_init_hook();
 }
Index: linux-2.6.15-rc5-dt/arch/i386/kernel/timers/timer_pit.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15-rc5-dt.orig/arch/i386/kernel/timers/timer_pit.c
+++ linux-2.6.15-rc5-dt/arch/i386/kernel/timers/timer_pit.c
@@ -32,9 +32,10 @@ static int __init init_pit(char* overrid
 	return 0;
 }
=20
=2Dstatic void mark_offset_pit(void)
+static int mark_offset_pit(void)
 {
 	/* nothing needed */
+	return 1;
 }
=20
 static unsigned long long monotonic_clock_pit(void)
@@ -148,6 +149,38 @@ static unsigned long get_offset_pit(void
 	return count;
 }
=20
+void disable_pit_timer(void)
+{
+	irq_desc[0].handler->disable(0);
+}
+
+void enable_pit_timer(void)
+{
+	irq_desc[0].handler->enable(0);
+}
+
+/*
+ * Reprograms the next timer interrupt
+ * PIT timer reprogramming code taken from APM code.
+ * Note that PIT timer is a 16-bit timer, which allows max
+ * skip of only few seconds.
+ */
+void reprogram_pit_timer(unsigned long jiffies_to_skip)
+{
+	int skip;
+	extern spinlock_t i8253_lock;
+	unsigned long flags;
+
+	skip =3D jiffies_to_skip * LATCH;
+	if (skip > 0xffff)
+		skip =3D 0xffff;
+
+	spin_lock_irqsave(&i8253_lock, flags);
+	outb_p(0x34, PIT_MODE);		/* binary, mode 2, LSB/MSB, ch 0 */
+	outb_p(skip & 0xff, PIT_CH0);	/* LSB */
+	outb(skip >> 8, PIT_CH0);	/* MSB */
+	spin_unlock_irqrestore(&i8253_lock, flags);
+}
=20
 /* tsc timer_opts struct */
 struct timer_opts timer_pit =3D {
Index: linux-2.6.15-rc5-dt/arch/i386/kernel/timers/timer_pm.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15-rc5-dt.orig/arch/i386/kernel/timers/timer_pm.c
+++ linux-2.6.15-rc5-dt/arch/i386/kernel/timers/timer_pm.c
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
=2D
+#define PMTMR_TICKS_PER_JIFFY (PMTMR_EXPECTED_RATE / (CALIBRATE_LATCH/LATC=
H))
=20
 /* The I/O port the PMTMR resides at.
  * The location is detected during setup_arch(),
@@ -127,7 +128,13 @@ pm_good:
 	if (verify_pmtmr_rate() !=3D 0)
 		return -ENODEV;
=20
+	printk("Using %u PM timer ticks per jiffy \n", PMTMR_TICKS_PER_JIFFY);
+
+	offset_tick =3D read_pmtmr();
+	setup_pit_timer();
+
 	init_cpu_khz();
+	set_dyn_tick_limits(((0xFFFFFF / 1000000) * 286 * HZ) >> 10, 0);
 	return 0;
 }
=20
@@ -148,10 +155,9 @@ static inline u32 cyc2us(u32 cycles)
  * this gets called during each timer interrupt
  *   - Called while holding the writer xtime_lock
  */
=2Dstatic void mark_offset_pmtmr(void)
+static int mark_offset_pmtmr(void)
 {
 	u32 lost, delta, last_offset;
=2D	static int first_run =3D 1;
 	last_offset =3D offset_tick;
=20
 	write_seqlock(&monotonic_lock);
@@ -161,29 +167,20 @@ static void mark_offset_pmtmr(void)
 	/* calculate tick interval */
 	delta =3D (offset_tick - last_offset) & ACPI_PM_MASK;
=20
=2D	/* convert to usecs */
=2D	delta =3D cyc2us(delta);
=2D
 	/* update the monotonic base value */
=2D	monotonic_base +=3D delta * NSEC_PER_USEC;
+	monotonic_base +=3D cyc2us(delta) * NSEC_PER_USEC;
 	write_sequnlock(&monotonic_lock);
=20
 	/* convert to ticks */
 	delta +=3D offset_delay;
=2D	lost =3D delta / (USEC_PER_SEC / HZ);
=2D	offset_delay =3D delta % (USEC_PER_SEC / HZ);
=2D
+	lost =3D delta / PMTMR_TICKS_PER_JIFFY;
+	offset_delay =3D delta % PMTMR_TICKS_PER_JIFFY;
=20
 	/* compensate for lost ticks */
 	if (lost >=3D 2)
 		jiffies_64 +=3D lost - 1;
=20
=2D	/* don't calculate delay for first run,
=2D	   or if we've got less then a tick */
=2D	if (first_run || (lost < 1)) {
=2D		first_run =3D 0;
=2D		offset_delay =3D 0;
=2D	}
+	return lost;
 }
=20
 static int pmtmr_resume(void)
@@ -192,6 +189,7 @@ static int pmtmr_resume(void)
 	/* Assume this is the last mark offset time */
 	offset_tick =3D read_pmtmr();
 	write_sequnlock(&monotonic_lock);
+	offset_delay =3D 0;
 	return 0;
 }
=20
@@ -243,7 +241,7 @@ static unsigned long get_offset_pmtmr(vo
 	now =3D read_pmtmr();
 	delta =3D (now - offset)&ACPI_PM_MASK;
=20
=2D	return (unsigned long) offset_delay + cyc2us(delta);
+	return (unsigned long) cyc2us(delta + offset_delay);
 }
=20
=20
Index: linux-2.6.15-rc5-dt/arch/i386/kernel/timers/timer_tsc.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15-rc5-dt.orig/arch/i386/kernel/timers/timer_tsc.c
+++ linux-2.6.15-rc5-dt/arch/i386/kernel/timers/timer_tsc.c
@@ -14,6 +14,7 @@
 #include <linux/cpufreq.h>
 #include <linux/string.h>
 #include <linux/jiffies.h>
+#include <linux/dyn-tick.h>
=20
 #include <asm/timer.h>
 #include <asm/io.h>
@@ -32,8 +33,6 @@ static unsigned long hpet_last;
 static struct timer_opts timer_tsc;
 #endif
=20
=2Dstatic inline void cpufreq_delayed_get(void);
=2D
 int tsc_disable __devinitdata =3D 0;
=20
 static int use_tsc;
@@ -171,11 +170,21 @@ static void delay_tsc(unsigned long loop
 	} while ((now-bclock) < loops);
 }
=20
+/* update the monotonic base value */
+static inline void update_monotonic_base(unsigned long long last_offset)
+{
+	unsigned long long this_offset;
+
+	this_offset =3D ((unsigned long long)last_tsc_high << 32) | last_tsc_low;
+	monotonic_base +=3D cycles_2_ns(this_offset - last_offset);
+}
+
 #ifdef CONFIG_HPET_TIMER
=2Dstatic void mark_offset_tsc_hpet(void)
+static int mark_offset_tsc_hpet(void)
 {
=2D	unsigned long long this_offset, last_offset;
+	unsigned long long last_offset;
  	unsigned long offset, temp, hpet_current;
+ 	int lost_ticks =3D 0;
=20
 	write_seqlock(&monotonic_lock);
 	last_offset =3D ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
@@ -197,14 +206,12 @@ static void mark_offset_tsc_hpet(void)
 	/* lost tick compensation */
 	offset =3D hpet_readl(HPET_T0_CMP) - hpet_tick;
 	if (unlikely(((offset - hpet_last) > hpet_tick) && (hpet_last !=3D 0))) {
=2D		int lost_ticks =3D (offset - hpet_last) / hpet_tick;
+		lost_ticks =3D (offset - hpet_last) / hpet_tick;
 		jiffies_64 +=3D lost_ticks;
 	}
 	hpet_last =3D hpet_current;
=20
=2D	/* update the monotonic base value */
=2D	this_offset =3D ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
=2D	monotonic_base +=3D cycles_2_ns(this_offset - last_offset);
+	update_monotonic_base(last_offset);
 	write_sequnlock(&monotonic_lock);
=20
 	/* calculate delay_at_last_interrupt */
@@ -218,6 +225,8 @@ static void mark_offset_tsc_hpet(void)
 	delay_at_last_interrupt =3D hpet_current - offset;
 	ASM_MUL64_REG(temp, delay_at_last_interrupt,
 			hpet_usec_quotient, delay_at_last_interrupt);
+
+	return lost_ticks;
 }
 #endif
=20
@@ -242,7 +251,7 @@ static void handle_cpufreq_delayed_get(v
  * to verify the CPU frequency the timing core thinks the CPU is running
  * at is still correct.
  */
=2Dstatic inline void cpufreq_delayed_get(void)=20
+void cpufreq_delayed_get(void)
 {
 	if (cpufreq_init && !cpufreq_delayed_issched) {
 		cpufreq_delayed_issched =3D 1;
@@ -321,7 +330,7 @@ static int __init cpufreq_tsc(void)
 core_initcall(cpufreq_tsc);
=20
 #else /* CONFIG_CPU_FREQ */
=2Dstatic inline void cpufreq_delayed_get(void) { return; }
+void cpufreq_delayed_get(void) { return; }
 #endif=20
=20
 int recalibrate_cpu_khz(void)
@@ -344,15 +353,14 @@ int recalibrate_cpu_khz(void)
 }
 EXPORT_SYMBOL(recalibrate_cpu_khz);
=20
=2Dstatic void mark_offset_tsc(void)
+static int mark_offset_tsc(void)
 {
 	unsigned long lost,delay;
 	unsigned long delta =3D last_tsc_low;
 	int count;
 	int countmp;
 	static int count1 =3D 0;
=2D	unsigned long long this_offset, last_offset;
=2D	static int lost_count =3D 0;
+	unsigned long long last_offset;
=20
 	write_seqlock(&monotonic_lock);
 	last_offset =3D ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
@@ -419,29 +427,9 @@ static void mark_offset_tsc(void)
 	delta +=3D delay_at_last_interrupt;
 	lost =3D delta/(1000000/HZ);
 	delay =3D delta%(1000000/HZ);
=2D	if (lost >=3D 2) {
=2D		jiffies_64 +=3D lost-1;
+	tsc_sanity_check(lost);
=20
=2D		/* sanity check to ensure we're not always losing ticks */
=2D		if (lost_count++ > 100) {
=2D			printk(KERN_WARNING "Losing too many ticks!\n");
=2D			printk(KERN_WARNING "TSC cannot be used as a timesource.  \n");
=2D			printk(KERN_WARNING "Possible reasons for this are:\n");
=2D			printk(KERN_WARNING "  You're running with Speedstep,\n");
=2D			printk(KERN_WARNING "  You don't have DMA enabled for your hard disk =
(see hdparm),\n");
=2D			printk(KERN_WARNING "  Incorrect TSC synchronization on an SMP system=
 (see dmesg).\n");
=2D			printk(KERN_WARNING "Falling back to a sane timesource now.\n");
=2D
=2D			clock_fallback();
=2D		}
=2D		/* ... but give the TSC a fair chance */
=2D		if (lost_count > 25)
=2D			cpufreq_delayed_get();
=2D	} else
=2D		lost_count =3D 0;
=2D	/* update the monotonic base value */
=2D	this_offset =3D ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
=2D	monotonic_base +=3D cycles_2_ns(this_offset - last_offset);
+	update_monotonic_base(last_offset);
 	write_sequnlock(&monotonic_lock);
=20
 	/* calculate delay_at_last_interrupt */
@@ -454,6 +442,8 @@ static void mark_offset_tsc(void)
 	 */
 	if (lost && abs(delay - delay_at_last_interrupt) > (900000/HZ))
 		jiffies_64++;
+
+	return lost;
 }
=20
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
Index: linux-2.6.15-rc5-dt/include/asm-i386/apic.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15-rc5-dt.orig/include/asm-i386/apic.h
+++ linux-2.6.15-rc5-dt/include/asm-i386/apic.h
@@ -121,6 +121,7 @@ extern void nmi_watchdog_tick (struct pt
 extern int APIC_init_uniprocessor (void);
 extern void disable_APIC_timer(void);
 extern void enable_APIC_timer(void);
+extern void reprogram_apic_timer(unsigned long count);
=20
 extern void enable_NMI_through_LVT0 (void * dummy);
=20
@@ -134,6 +135,7 @@ extern int disable_timer_pin_1;
=20
 #else /* !CONFIG_X86_LOCAL_APIC */
 static inline void lapic_shutdown(void) { }
+static inline void reprogram_apic_timer(unsigned long count) { }
=20
 #endif /* !CONFIG_X86_LOCAL_APIC */
=20
Index: linux-2.6.15-rc5-dt/include/asm-i386/dyn-tick.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- /dev/null
+++ linux-2.6.15-rc5-dt/include/asm-i386/dyn-tick.h
@@ -0,0 +1,65 @@
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
+extern int __init setup_dyn_tick_use_apic(unsigned int calibration_result);
+extern void __init dyn_tick_time_init(struct timer_opts *cur_timer);
+
+/*
+ * Needs to be different to the arch independant values specified in
+ * include/linux/dyn-tick.h to share the dyn_tick_timer.state struct
+ * member.
+ */
+#define DYN_TICK_APICABLE	(1 << 3)
+
+#if (defined(CONFIG_SMP) || defined(CONFIG_X86_UP_APIC))
+static inline int dyntick_using_lapic(void)
+{
+	return (dyn_tick->state & DYN_TICK_APICABLE);
+}
+
+#else	/* (defined(CONFIG_SMP) || defined(CONFIG_X86_UP_APIC)) */
+static inline int dyntick_using_lapic(void)
+{
+	return 0;
+}
+#endif	/* (defined(CONFIG_SMP) || defined(CONFIG_X86_UP_APIC)) */
+
+#else	/* CONFIG_NO_IDLE_HZ */
+static inline void idle_reprogram_timer(void)
+{
+}
+
+static inline void dyn_tick_interrupt(struct pt_regs *regs)
+{
+}
+
+static inline int setup_dyn_tick_use_apic(unsigned int calibration_result)
+{
+	return 0;
+}
+
+static inline void dyn_tick_time_init(struct timer_opts *cur_timer)
+{
+}
+#endif	/* CONFIG_NO_IDLE_HZ */
+
+#endif /* _ASM_I386_DYN_TICK_H_ */
Index: linux-2.6.15-rc5-dt/include/asm-i386/timer.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15-rc5-dt.orig/include/asm-i386/timer.h
+++ linux-2.6.15-rc5-dt/include/asm-i386/timer.h
@@ -1,5 +1,6 @@
 #ifndef _ASMi386_TIMER_H
 #define _ASMi386_TIMER_H
+#include <linux/jiffies.h>
 #include <linux/init.h>
 #include <linux/pm.h>
=20
@@ -19,7 +20,7 @@
  */
 struct timer_opts {
 	char* name;
=2D	void (*mark_offset)(void);
+	int (*mark_offset)(void);
 	unsigned long (*get_offset)(void);
 	unsigned long long (*monotonic_clock)(void);
 	void (*delay)(unsigned long);
@@ -38,6 +39,9 @@ struct init_timer_opts {
 extern struct timer_opts* __init select_timer(void);
 extern void clock_fallback(void);
 void setup_pit_timer(void);
+extern void disable_pit_timer(void);
+extern void enable_pit_timer(void);
+extern void reprogram_pit_timer(unsigned long jiffies_to_skip);
=20
 /* Modifiers for buggy PIT handling */
=20
@@ -67,4 +71,37 @@ extern unsigned long calibrate_tsc_hpet(
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
+	static int lost_count =3D 0;
+
+	if (lost >=3D 2) {
+		jiffies_64 +=3D lost-1;
+
+		/* sanity check to ensure we're not always losing ticks */
+		if (lost_count++ > 100) {
+			printk(KERN_WARNING "Losing too many ticks!\n");
+			printk(KERN_WARNING "TSC cannot be used as a timesource.  \n");
+			printk(KERN_WARNING "Possible reasons for this are:\n");
+			printk(KERN_WARNING "  You're running with Speedstep,\n");
+			printk(KERN_WARNING "  You don't have DMA enabled for your hard disk (s=
ee hdparm),\n");
+			printk(KERN_WARNING "  Incorrect TSC synchronization on an SMP system (=
see dmesg).\n");
+			printk(KERN_WARNING "Falling back to a sane timesource now.\n");
+
+			clock_fallback();
+		}
+		/* ... but give the TSC a fair chance */
+		if (lost_count > 25)
+			cpufreq_delayed_get();
+	} else
+		lost_count =3D 0;
+}
+#endif /* CONFIG_NO_IDLE_HZ */
 #endif
Index: linux-2.6.15-rc5-dt/arch/i386/kernel/timers/timer_cyclone.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15-rc5-dt.orig/arch/i386/kernel/timers/timer_cyclone.c
+++ linux-2.6.15-rc5-dt/arch/i386/kernel/timers/timer_cyclone.c
@@ -45,7 +45,7 @@ static seqlock_t monotonic_lock =3D SEQLOC
 	} while (high !=3D cyclone_timer[1]);
=20
=20
=2Dstatic void mark_offset_cyclone(void)
+static int mark_offset_cyclone(void)
 {
 	unsigned long lost, delay;
 	unsigned long delta =3D last_cyclone_low;
@@ -101,6 +101,8 @@ static void mark_offset_cyclone(void)
 	 */
 	if (lost && abs(delay - delay_at_last_interrupt) > (900000/HZ))
 		jiffies_64++;
+
+	return lost;
 }
=20
 static unsigned long get_offset_cyclone(void)
Index: linux-2.6.15-rc5-dt/arch/i386/kernel/timers/timer_hpet.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15-rc5-dt.orig/arch/i386/kernel/timers/timer_hpet.c
+++ linux-2.6.15-rc5-dt/arch/i386/kernel/timers/timer_hpet.c
@@ -101,7 +101,7 @@ static unsigned long get_offset_hpet(voi
 	return edx;
 }
=20
=2Dstatic void mark_offset_hpet(void)
+static int mark_offset_hpet(void)
 {
 	unsigned long long this_offset, last_offset;
 	unsigned long offset;
@@ -124,6 +124,8 @@ static void mark_offset_hpet(void)
 	this_offset =3D ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
 	monotonic_base +=3D cycles_2_ns(this_offset - last_offset);
 	write_sequnlock(&monotonic_lock);
+
+	return 1;
 }
=20
 static void delay_hpet(unsigned long loops)
Index: linux-2.6.15-rc5-dt/arch/i386/kernel/timers/timer_none.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15-rc5-dt.orig/arch/i386/kernel/timers/timer_none.c
+++ linux-2.6.15-rc5-dt/arch/i386/kernel/timers/timer_none.c
@@ -1,9 +1,10 @@
 #include <linux/init.h>
 #include <asm/timer.h>
=20
=2Dstatic void mark_offset_none(void)
+static int mark_offset_none(void)
 {
 	/* nothing needed */
+	return 1;
 }
=20
 static unsigned long get_offset_none(void)
Index: linux-2.6.15-rc5-dt/kernel/timer_top.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- /dev/null
+++ linux-2.6.15-rc5-dt/kernel/timer_top.c
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
+static struct timer_top_root top_root =3D {
+	.lock		=3D SPIN_LOCK_UNLOCKED,
+	.list		=3D LIST_HEAD_INIT(top_root.list),
+};
+
+static struct list_head *timer_list =3D &top_root.list;
+static spinlock_t *top_lock =3D &top_root.lock;
+
+static inline int update_top_info(unsigned long function, pid_t pid_info)
+{
+	struct timer_top_info *top;
+
+	list_for_each_entry(top, timer_list, list) {
+		/* if it is in the list increment its count */
+		if (top->func_pointer =3D=3D function && top->pid =3D=3D pid_info) {
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
+	pid_t pid_info =3D 0;
+	char name[TASK_COMM_LEN] =3D "";
+	unsigned long flags;
+
+	if (!top_root.record)
+		goto out;
+
+	spin_lock_irqsave(top_lock, flags);
+
+	if (data) {
+	       task_info =3D (struct task_struct *) data;
+		/* little sanity ... not enough yet */
+		if ((task_info->pid > 0) && (task_info->pid < PID_MAX_LIMIT)) {
+			pid_info =3D task_info->pid;
+			strncpy(name, task_info->comm, sizeof(task_info->comm));
+		}
+	}
+
+	if (update_top_info(function, pid_info))
+		goto out_unlock;
+
+	/* Function not found so insert it in the list */
+	top =3D kmem_cache_alloc(top_root.cache, GFP_ATOMIC);
+	if (unlikely(!top))
+		goto out_unlock;
+
+	top->func_pointer =3D function;
+	top->counter =3D 1;
+	top->pid =3D pid_info;
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
+		entry =3D list_entry(aux1, struct timer_top_info, list);
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
+static struct file_operations proc_timertop_operations =3D {
+	.open		=3D proc_timertop_open,
+	.read		=3D seq_read,
+	.llseek		=3D seq_lseek,
+	.release	=3D single_release,
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
+		len =3D MAX_INPUT_TOP - 1;
+	else
+		len =3D count;
+
+	if (copy_from_user(input_data, page, len))
+		return -EFAULT;
+
+	input_data[len] =3D '\0';
+
+	spin_lock_irqsave(top_lock, flags);
+	if (!strncmp(input_data, "clear", 5))
+		timer_list_del();
+	else if (!strncmp(input_data, "start", 5))
+		top_root.record =3D 1;
+	else if (!strncmp(input_data, "stop", 4)) {
+		top_root.record =3D 0;
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
+	int len =3D sprintf(page, "clear start stop\n");
+
+	return len;
+}
+
+static int __init init_top_info(void)
+{
+	top_root.cache =3D kmem_cache_create("top_info",
+		sizeof(struct timer_top_info), 0, SLAB_PANIC, NULL, NULL);
+
+	top_info_file =3D create_proc_entry("timer_info", 0444, NULL);
+	if (top_info_file =3D=3D NULL)
+		return -ENOMEM;
+
+	top_info_file_out =3D create_proc_entry("timer_input", 0666, NULL);
+	if (top_info_file_out =3D=3D NULL)
+		return -ENOMEM;
+
+	/* Statistics output */
+	top_info_file->proc_fops =3D &proc_timertop_operations;
+
+	/* Control */
+	top_info_file_out->write_proc =3D &proc_write_timer_input;
+	top_info_file_out->read_proc =3D &proc_read_timer_input;
+
+	return 0;
+}
+
+module_init(init_top_info);
Index: linux-2.6.15-rc5-dt/lib/Kconfig.debug
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15-rc5-dt.orig/lib/Kconfig.debug
+++ linux-2.6.15-rc5-dt/lib/Kconfig.debug
@@ -77,6 +77,19 @@ config SCHEDSTATS
 	  application, you can say N to avoid the very slight overhead
 	  this adds.
=20
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
Index: linux-2.6.15-rc5-dt/drivers/acpi/processor_idle.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15-rc5-dt.orig/drivers/acpi/processor_idle.c
+++ linux-2.6.15-rc5-dt/drivers/acpi/processor_idle.c
@@ -38,6 +38,7 @@
 #include <linux/dmi.h>
 #include <linux/moduleparam.h>
 #include <linux/sched.h>	/* need_resched() */
+#include <linux/dyn-tick.h>
=20
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -60,6 +61,8 @@ module_param(max_cstate, uint, 0644);
 static unsigned int nocst =3D 0;
 module_param(nocst, uint, 0000);
=20
+#define BM_JIFFIES	(HZ >=3D 800 ? 4 : 2)
+
 /*
  * bm_history -- bit-mask with a bit per jiffy of bus-master activity
  * 1000 HZ: 0xFFFFFFFF: 32 jiffies =3D 32ms
@@ -177,6 +180,7 @@ static void acpi_safe_halt(void)
 }
=20
 static atomic_t c3_cpu_count;
+static int last_sleep =3D 0;
=20
 static void acpi_processor_idle(void)
 {
@@ -256,10 +260,10 @@ static void acpi_processor_idle(void)
 		pr->power.bm_check_timestamp =3D jiffies;
=20
 		/*
=2D		 * Apply bus mastering demotion policy.  Automatically demote
+		 * If bus mastering is or was active this jiffy, demote
 		 * to avoid a faulty transition.  Note that the processor
 		 * won't enter a low-power state during this call (to this
=2D		 * funciton) but should upon the next.
+		 * function) but should upon the next.
 		 *
 		 * TBD: A better policy might be to fallback to the demotion
 		 *      state (use it for this quantum only) istead of
@@ -267,14 +271,34 @@ static void acpi_processor_idle(void)
 		 *      qualification.  This may, however, introduce DMA
 		 *      issues (e.g. floppy DMA transfer overrun/underrun).
 		 */
=2D		if (pr->power.bm_activity & cx->demotion.threshold.bm) {
+		if ((pr->power.bm_activity & 0x01) &&
+		    cx->demotion.threshold.bm) {
 			local_irq_enable();
 			next_state =3D cx->demotion.state;
+			if (dyn_tick_enabled())
+				dyn_early_reprogram(BM_JIFFIES);
+			last_sleep =3D 0; /* do not promote in fast-path */
 			goto end;
 		}
 	}
=20
=2D	cx->usage++;
+	/*
+	 * Fast-path promotion: if we slept for more than 2 jiffies the last
+	 * time, and we're intended to sleep for more than 2 jiffies now,
+	 * promote. Note that the processor won't enter a low-power state
+	 * during this call (to this funciton) but should upon the next.
+	 */
+	if (dyn_tick_enabled()) {
+		if (cx->promotion.state && cx->promotion.count &&
+		    (last_sleep > BM_JIFFIES) &&
+		    (dyn_tick->skip > BM_JIFFIES)) {
+			local_irq_enable();
+			next_state =3D cx->promotion.state;
+			goto end;
+		}
+	}
+
+	last_sleep =3D 0;
=20
 #ifdef CONFIG_HOTPLUG_CPU
 	/*
@@ -383,6 +407,20 @@ static void acpi_processor_idle(void)
 		local_irq_enable();
 		return;
 	}
+	cx->usage++;
+	if (cx->type !=3D ACPI_STATE_C1) {
+		if (sleep_ticks > 0)
+			cx->time +=3D sleep_ticks;
+	} else {
+		/* for C1, where we don't know the exact value, assume 0.5 of
+		 * a jiffy */
+		cx->time +=3D (PM_TIMER_FREQUENCY / (2 * HZ));
+	}
+
+	last_sleep =3D sleep_ticks / (PM_TIMER_FREQUENCY / HZ);
+
+	if (pr->flags.bm_check)
+		pr->power.bm_check_timestamp +=3D last_sleep;
=20
 	next_state =3D pr->power.state;
=20
@@ -988,9 +1026,10 @@ static int acpi_processor_power_seq_show
 		else
 			seq_puts(seq, "demotion[--] ");
=20
=2D		seq_printf(seq, "latency[%03d] usage[%08d]\n",
+		seq_printf(seq, "latency[%03d] usage[%08d] time[%020llu]\n",
 			   pr->power.states[i].latency,
=2D			   pr->power.states[i].usage);
+			   pr->power.states[i].usage,
+			   pr->power.states[i].time);
 	}
=20
       end:
Index: linux-2.6.15-rc5-dt/include/acpi/processor.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15-rc5-dt.orig/include/acpi/processor.h
+++ linux-2.6.15-rc5-dt/include/acpi/processor.h
@@ -51,6 +51,7 @@ struct acpi_processor_cx {
 	u32 latency_ticks;
 	u32 power;
 	u32 usage;
+	u64 time;
 	struct acpi_processor_cx_policy promotion;
 	struct acpi_processor_cx_policy demotion;
 };

--nextPart1678477.cyGSsIncVv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDot47ZUg7+tp6mRURAieNAJ4hKTt5ou5AkiRC7XAiA6rWFdrNawCghsRy
OPwx2B2hnb+WuGUrK5d8JOo=
=ClbT
-----END PGP SIGNATURE-----

--nextPart1678477.cyGSsIncVv--
