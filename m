Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261477AbVASAHI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbVASAHI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 19:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbVASAHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 19:07:08 -0500
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:28317 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S261477AbVASAGe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 19:06:34 -0500
Date: Tue, 18 Jan 2005 16:05:56 -0800
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@ucw.cz>, George Anzinger <george@mvista.com>,
       john stultz <johnstul@us.ibm.com>, Andrea Arcangeli <andrea@suse.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] dynamic tick patch
Message-ID: <20050119000556.GB14749@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="yEPQxsgoJgBvi8ip"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

Attached is the dynamic tick patch for x86 to play with
as I promised in few threads earlier on this list.[1][2]

The dynamic tick patch does following:

- Separates timer interrupts from updating system time

- Allows updating time from other interrupts in addition
  to timer interrupt

- Makes timer tick dynamic

- Allows power management modules to take advantage of the
  idle time inbetween skipped ticks

- Might help with the whistling caps?

The patch should be non-intrusive where possible. The system
boots with the regular timers, and then later on switches on
the dynamic tick if the selected driver implements get_hw_time()
function.

Currently supported timers are TSC and ACPI PM timer. Other
timers should be easy to add. Both TSC and ACPI PM timer
rely on the PIT timer for interrupts, so the maximum skip
inbetween ticks is only few seconds at most.

Please note that this patch alone does not help much with
power savings. More work is needed in that area to make the
system take advantage of the idle time inbetween the skipped
ticks.

The patch is based on a similar patch for ARM OMAP. The history
of the dynamic tick patch is something like:

Orignal 2.4 VST patch by George Anzinger -->
2.6 OS/390 next_timer_interrupt() patch Martin Schwidefsky --> 
2.6 OMAP dynamic tick patch --> This patch

As this patch is related to the VST/High-Res timers, there
are probably various things that can be merged. I have not
yet looked at what all could be merged.

I'd appreciate some comments and testing!

Regards,

Tony

[1] http://lkml.org/lkml/2004/12/11/24
[2] http://lkml.org/lkml/2005/1/13/104

--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="patch-dynamic-tick-2.6.11-rc1-050118-1"

diff -Nru a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	2005-01-18 15:50:17 -08:00
+++ b/arch/i386/Kconfig	2005-01-18 15:50:17 -08:00
@@ -452,6 +452,14 @@
 	bool "Provide RTC interrupt"
 	depends on HPET_TIMER && RTC=y
 
+config NO_IDLE_HZ
+	bool "Dynamic Tick Timer - Skip timer ticks during idle"
+	help
+	  This option enables support for skipping timer ticks when the
+	  processor is idle. During system load, timer is continuous.
+	  This option saves power, as it allows the system to stay in
+	  idle mode longer.
+
 config SMP
 	bool "Symmetric multi-processing support"
 	---help---
diff -Nru a/arch/i386/kernel/irq.c b/arch/i386/kernel/irq.c
--- a/arch/i386/kernel/irq.c	2005-01-18 15:50:17 -08:00
+++ b/arch/i386/kernel/irq.c	2005-01-18 15:50:17 -08:00
@@ -15,6 +15,7 @@
 #include <linux/seq_file.h>
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
+#include <linux/dyn-tick-timer.h>
 
 #ifndef CONFIG_X86_LOCAL_APIC
 /*
@@ -100,6 +101,11 @@
 	} else
 #endif
 		__do_IRQ(irq, regs);
+
+#ifdef CONFIG_NO_IDLE_HZ
+	if (dyn_tick->state & (DYN_TICK_ENABLED | DYN_TICK_SKIPPING) && irq != 0)
+		dyn_tick->interrupt(irq, NULL, regs);
+#endif
 
 	irq_exit();
 
diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	2005-01-18 15:50:17 -08:00
+++ b/arch/i386/kernel/time.c	2005-01-18 15:50:17 -08:00
@@ -46,6 +46,7 @@
 #include <linux/bcd.h>
 #include <linux/efi.h>
 #include <linux/mca.h>
+#include <linux/dyn-tick-timer.h>
 
 #include <asm/io.h>
 #include <asm/smp.h>
@@ -301,6 +302,49 @@
 	return IRQ_HANDLED;
 }
 
+#ifdef CONFIG_NO_IDLE_HZ
+static unsigned long long last_tick;
+void reprogram_pit_tick(int jiffies_to_skip);
+
+#ifdef DEBUG
+#define dbg_dyn_tick_irq() {if (skipped < dyn_tick->skip) \
+				printk("%i/%i ", skipped, dyn_tick->skip);}
+#else
+#define dbg_dyn_tick_irq() {}
+#endif
+
+/*
+ * This interrupt handler updates the time based on number of jiffies skipped
+ * It would be somewhat more optimized to have a customa handler in each timer
+ * using hardware ticks instead of nanoseconds. Note that CONFIG_NO_IDLE_HZ
+ * currently disables timer fallback on skipped jiffies.
+ */
+irqreturn_t dyn_tick_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	unsigned long flags;
+	volatile unsigned long long now;
+	unsigned int skipped = 0;
+
+	write_seqlock_irqsave(&xtime_lock, flags);
+	now = cur_timer->get_hw_time();
+	while (now - last_tick >= NS_TICK_LEN) {
+		last_tick += NS_TICK_LEN;
+		cur_timer->mark_offset();
+		do_timer_interrupt(irq, NULL, regs);
+		skipped++;
+	}
+	if (dyn_tick->state & (DYN_TICK_ENABLED | DYN_TICK_SKIPPING)) {
+		dbg_dyn_tick_irq();
+		dyn_tick->skip = 1;
+		reprogram_pit_tick(dyn_tick->skip);
+		dyn_tick->state = DYN_TICK_ENABLED;
+	}
+	write_sequnlock_irqrestore(&xtime_lock, flags);
+
+	return IRQ_HANDLED;
+}
+#endif
+
 /* not static: needed by APM */
 unsigned long get_cmos_time(void)
 {
@@ -396,6 +440,53 @@
 }
 #endif
 
+#ifdef CONFIG_NO_IDLE_HZ
+static struct dyn_tick_timer arch_ltt;
+
+/*
+ * Reprograms the next timer interrupt
+ * PIT timer reprogramming code taken from APM code.
+ * Note that PIT timer is a 16-bit timer, which allows max
+ * skip of only few seconds.
+ */
+void reprogram_pit_tick(int jiffies_to_skip)
+{
+	int skip;
+	extern spinlock_t i8253_lock;
+	unsigned long flags;
+
+	skip = jiffies_to_skip * LATCH;
+	if (skip > 0xffff)
+		skip = 0xffff;
+	spin_lock_irqsave(&i8253_lock, flags);
+	outb_p(0x34, PIT_MODE);		/* binary, mode 2, LSB/MSB, ch 0 */
+	outb_p(skip & 0xff, PIT_CH0);	/* LSB */
+	outb(skip >> 8, PIT_CH0);	/* MSB */
+	spin_unlock_irqrestore(&i8253_lock, flags);
+}
+
+extern void replace_timer_interrupt(void * new_handler);
+
+static int dyn_tick_late_init(void)
+{
+	unsigned long flags;
+
+	if (!cur_timer->get_hw_time)
+		return -ENODEV;
+	write_seqlock_irqsave(&xtime_lock, flags);
+	last_tick = cur_timer->get_hw_time();
+	dyn_tick->skip = 1;
+	dyn_tick->state = DYN_TICK_ENABLED;
+	write_sequnlock_irqrestore(&xtime_lock, flags);
+	if (cur_timer->late_init)
+		cur_timer->late_init();
+	dyn_tick->interrupt = dyn_tick_timer_interrupt;
+	replace_timer_interrupt(dyn_tick->interrupt);
+
+	return 0;
+}
+#endif
+
 void __init time_init(void)
 {
 #ifdef CONFIG_HPET_TIMER
@@ -416,5 +507,9 @@
 	cur_timer = select_timer();
 	printk(KERN_INFO "Using %s for high-res timesource\n",cur_timer->name);
 
+#ifdef CONFIG_NO_IDLE_HZ
+	arch_ltt.init = dyn_tick_late_init;
+	dyn_tick_register(&arch_ltt);
+#endif
 	time_init_hook();
 }
diff -Nru a/arch/i386/kernel/timers/timer_pm.c b/arch/i386/kernel/timers/timer_pm.c
--- a/arch/i386/kernel/timers/timer_pm.c	2005-01-18 15:50:17 -08:00
+++ b/arch/i386/kernel/timers/timer_pm.c	2005-01-18 15:50:17 -08:00
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/init.h>
+#include <linux/dyn-tick-timer.h>
 #include <asm/types.h>
 #include <asm/timer.h>
 #include <asm/smp.h>
@@ -168,6 +169,7 @@
 	monotonic_base += delta * NSEC_PER_USEC;
 	write_sequnlock(&monotonic_lock);
 
+#ifndef CONFIG_NO_IDLE_HZ
 	/* convert to ticks */
 	delta += offset_delay;
 	lost = delta / (USEC_PER_SEC / HZ);
@@ -184,6 +186,7 @@
 		first_run = 0;
 		offset_delay = 0;
 	}
+#endif
 }
 
 
@@ -238,6 +241,25 @@
 	return (unsigned long) offset_delay + cyc2us(delta);
 }
 
+static unsigned long long ns_time;
+
+static unsigned long long get_hw_time_pmtmr(void)
+{
+	u32 now, delta;
+	static unsigned int last_cycles;
+	now = read_pmtmr();
+	delta = (now - last_cycles) & ACPI_PM_MASK;
+	last_cycles = now;
+	ns_time += cyc2us(delta) * NSEC_PER_USEC;
+	return ns_time;
+}
+
+static void late_init_pmtmr(void)
+{
+	ns_time = monotonic_clock_pmtmr();
+}
+
+extern irqreturn_t pmtmr_interrupt(int irq, void *dev_id, struct pt_regs *regs);
 
 /* acpi timer_opts struct */
 static struct timer_opts timer_pmtmr = {
@@ -245,7 +267,9 @@
 	.mark_offset		= mark_offset_pmtmr,
 	.get_offset		= get_offset_pmtmr,
 	.monotonic_clock 	= monotonic_clock_pmtmr,
+	.get_hw_time		= get_hw_time_pmtmr,
 	.delay 			= delay_pmtmr,
+	.late_init		= late_init_pmtmr,
 };
 
 struct init_timer_opts __initdata timer_pmtmr_init = {
diff -Nru a/arch/i386/kernel/timers/timer_tsc.c b/arch/i386/kernel/timers/timer_tsc.c
--- a/arch/i386/kernel/timers/timer_tsc.c	2005-01-18 15:50:17 -08:00
+++ b/arch/i386/kernel/timers/timer_tsc.c	2005-01-18 15:50:17 -08:00
@@ -112,6 +112,15 @@
 	return delay_at_last_interrupt + edx;
 }
 
+static unsigned long get_hw_time_tsc(void)
+{
+	register unsigned long eax, edx;
+
+	unsigned long long hw_time;
+	rdtscll(hw_time);
+	return cycles_2_ns(hw_time);
+}
+
 static unsigned long long monotonic_clock_tsc(void)
 {
 	unsigned long long last_offset, this_offset, base;
@@ -348,6 +357,7 @@
 
 	rdtsc(last_tsc_low, last_tsc_high);
 
+#ifndef CONFIG_NO_IDLE_HZ
 	spin_lock(&i8253_lock);
 	outb_p(0x00, PIT_MODE);     /* latch the count ASAP */
 
@@ -415,14 +425,18 @@
 			cpufreq_delayed_get();
 	} else
 		lost_count = 0;
+#endif
+
 	/* update the monotonic base value */
 	this_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
 	monotonic_base += cycles_2_ns(this_offset - last_offset);
 	write_sequnlock(&monotonic_lock);
 
+#ifndef CONFIG_NO_IDLE_HZ
 	/* calculate delay_at_last_interrupt */
 	count = ((LATCH-1) - count) * TICK_SIZE;
 	delay_at_last_interrupt = (count + LATCH/2) / LATCH;
+#endif
 
 	/* catch corner case where tick rollover occured
 	 * between tsc and pit reads (as noted when
@@ -551,6 +565,7 @@
 	.mark_offset = mark_offset_tsc, 
 	.get_offset = get_offset_tsc,
 	.monotonic_clock = monotonic_clock_tsc,
+	.get_hw_time = get_hw_time_tsc,
 	.delay = delay_tsc,
 };
 
diff -Nru a/arch/i386/mach-default/setup.c b/arch/i386/mach-default/setup.c
--- a/arch/i386/mach-default/setup.c	2005-01-18 15:50:17 -08:00
+++ b/arch/i386/mach-default/setup.c	2005-01-18 15:50:17 -08:00
@@ -85,6 +85,22 @@
 	setup_irq(0, &irq0);
 }
 
+/**
+ * replace_timer_interrupt - allow replacing timer interrupt handler
+ *
+ * Description:
+ *	Can be used to replace timer interrupt handler with a more optimized
+ *	handler. Used for enabling and disabling of CONFIG_NO_IDLE_HZ.
+ */
+void replace_timer_interrupt(void * new_handler)
+{
+	unsigned long flags;
+
+	write_seqlock_irqsave(&xtime_lock, flags);
+	irq0.handler = new_handler;
+	write_sequnlock_irqrestore(&xtime_lock, flags);
+}
+
 #ifdef CONFIG_MCA
 /**
  * mca_nmi_hook - hook into MCA specific NMI chain
diff -Nru a/include/asm-i386/timer.h b/include/asm-i386/timer.h
--- a/include/asm-i386/timer.h	2005-01-18 15:50:17 -08:00
+++ b/include/asm-i386/timer.h	2005-01-18 15:50:17 -08:00
@@ -1,6 +1,7 @@
 #ifndef _ASMi386_TIMER_H
 #define _ASMi386_TIMER_H
 #include <linux/init.h>
+#include <linux/interrupt.h>
 
 /**
  * struct timer_ops - used to define a timer source
@@ -21,7 +22,9 @@
 	void (*mark_offset)(void);
 	unsigned long (*get_offset)(void);
 	unsigned long long (*monotonic_clock)(void);
+	unsigned long long (*get_hw_time)(void);
 	void (*delay)(unsigned long);
+	void (*late_init)(void);
 };
 
 struct init_timer_opts {
diff -Nru a/include/linux/dyn-tick-timer.h b/include/linux/dyn-tick-timer.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/linux/dyn-tick-timer.h	2005-01-18 15:50:17 -08:00
@@ -0,0 +1,55 @@
+/*
+ * linux/include/linux/dyn-tick-timer.h
+ *
+ * Copyright (C) 2004 Nokia Corporation
+ * Written by Tony Lindgen <tony@atomide.com> and
+ * Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/interrupt.h>
+
+#define DYN_TICK_SKIPPING	(1 << 2)
+#define DYN_TICK_RUNNING	(1 << 1)
+#define DYN_TICK_ENABLED	(1 << 0)
+
+struct dyn_tick_state {
+	unsigned int state;		/* Current state */
+	unsigned long idle_mask;	/* Idle processor mask */
+	unsigned int skip;		/* Ticks to skip */
+	unsigned long irq_skip_mask;	/* Do not update time from these irqs */
+	irqreturn_t (*interrupt)(int, void *, struct pt_regs *);
+};
+
+/* REVISIT: Add functions to enable/disable dyn-tick on the fly */
+struct dyn_tick_timer {
+	int (*init) (void);
+};
+
+extern struct dyn_tick_state * dyn_tick;
+extern struct dyn_tick_timer * ltt;
+extern void dyn_tick_register(struct dyn_tick_timer * new_timer);
+
+#define NS_TICK_LEN		((1 * 1000000000)/HZ)
+
+/* On x86, MAX_SKIP_JIFFIES is limited by the PIT timer length */
+#define MAX_SKIP_JIFFIES	(0xffff/LATCH)
diff -Nru a/kernel/Makefile b/kernel/Makefile
--- a/kernel/Makefile	2005-01-18 15:50:17 -08:00
+++ b/kernel/Makefile	2005-01-18 15:50:17 -08:00
@@ -26,6 +26,7 @@
 obj-$(CONFIG_KPROBES) += kprobes.o
 obj-$(CONFIG_SYSFS) += ksysfs.o
 obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
+obj-$(CONFIG_NO_IDLE_HZ) += dyn-tick-timer.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff -Nru a/kernel/dyn-tick-timer.c b/kernel/dyn-tick-timer.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/kernel/dyn-tick-timer.c	2005-01-18 15:50:17 -08:00
@@ -0,0 +1,121 @@
+/*
+ * linux/kernel/dyn-tick-timer.c
+ *
+ * Beginnings of generic dynamic tick timer support
+ *
+ * Copyright (C) 2004 Nokia Corporation
+ * Written by Tony Lindgen <tony@atomide.com> and
+ * Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *
+ * TODO:
+ * - Add functions for enabling/disabling dyn-tick on the fly
+ * - Generalize to work with ARM sys_timer
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/cpumask.h>
+#include <linux/pm.h>
+#include <linux/dyn-tick-timer.h>
+#include <asm/io.h>
+
+#include "io_ports.h"
+
+#define VERSION	050109-4
+
+struct dyn_tick_state dyn_tick_state;
+struct dyn_tick_state * dyn_tick = &dyn_tick_state;
+struct dyn_tick_timer dyn_tick_timer;
+struct dyn_tick_timer * ltt = &dyn_tick_timer;
+static void (*orig_idle) (void) = 0;
+extern void reprogram_pit_tick(int jiffies_to_skip);
+static cpumask_t dyn_cpu_map;
+
+/*
+ * We want to have all processors idle before reprogramming the next
+ * timer interrupt. Note that we must maintain the state for dynamic tick,
+ * otherwise the idle loop could be reprogramming the timer continuously
+ * further into the future, and the timer interrupt would never happen.
+ */
+static void dyn_tick_idle(void)
+{
+	int cpu;
+	unsigned long flags;
+
+	if (!(dyn_tick->state & DYN_TICK_ENABLED))
+		goto out;
+
+	write_seqlock_irqsave(&xtime_lock, flags);
+	cpu = smp_processor_id();
+	cpu_set(cpu, dyn_cpu_map);
+	if (!(dyn_tick->state & DYN_TICK_SKIPPING) && cpus_full(dyn_cpu_map)) {
+		dyn_tick->skip = next_timer_interrupt();
+		if (dyn_tick->skip > MAX_SKIP_JIFFIES)
+			dyn_tick->skip = MAX_SKIP_JIFFIES;
+		reprogram_pit_tick(dyn_tick->skip);
+		dyn_tick->state |= DYN_TICK_SKIPPING;
+		cpus_clear(dyn_cpu_map);
+	}
+	write_sequnlock_irqrestore(&xtime_lock, flags);
+
+out:
+	if (orig_idle)
+		orig_idle();
+	else
+		safe_halt();
+}
+
+void __init dyn_tick_register(struct dyn_tick_timer * new_timer)
+{
+	ltt->init = new_timer->init;
+	printk(KERN_INFO "dyn-tick: Registering dynamic tick timer\n");
+}
+
+/*
+ * We need to initialize dynamic tick after calibrate delay
+ */
+static int __init dyn_tick_init(void)
+{
+	int ret = 0;
+
+	printk(KERN_INFO "dyn-tick: Enabling dynamic tick timer\n");
+	if (ltt->init) {
+		ret = ltt->init();
+		if (ret != 0) {
+			printk(KERN_WARNING "dyn-tick: Cannot use this timer\n");
+			goto out;
+		}
+	}
+	orig_idle = pm_idle;
+	pm_idle = dyn_tick_idle;
+	cpu_idle_wait();
+	printk(KERN_INFO "dyn-tick: Timer using dynamic tick\n");
+
+ out:
+	return ret;
+}
+late_initcall(dyn_tick_init);

--yEPQxsgoJgBvi8ip--
