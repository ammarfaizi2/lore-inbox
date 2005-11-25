Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751410AbVKYF6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbVKYF6q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 00:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbVKYF6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 00:58:46 -0500
Received: from mail09.syd.optusnet.com.au ([211.29.132.190]:10373 "EHLO
	mail09.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751410AbVKYF6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 00:58:43 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] i386 No Idle Hz - aka Dynticks v051125-1
Date: Fri, 25 Nov 2005 16:58:55 +1100
User-Agent: KMail/1.8.2
Cc: ck@vds.kolivas.org, Daniel Petrini <d.pensator@gmail.com>,
       Adam Belay <abelay@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511251658.56449.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is an updated version of dynticks for i386

The major change in this version is I have attempted to address the problem
with the bus mastering accounting code which thinks bus mastering is
continually occurring and does not promote the power state into higher power 
saving modes.

With this change I am able to reproduce power savings (at last) without any 
other major changes, albeit rather modest, in the order of .4W at 1000HZ.
I don't know how this code will interact with laptops that support C4 which
has been causing rather weird behaviour with dynticks.

The known issue remaining with this version of dynticks is that ondemand cpu
scaling still does not recognise what the real cpu load is so it runs at
maximum frequency (on my hardware at least).

The latest version of this code can always be found here:
http://ck.kolivas.org/patches/dyn-ticks/

Rolled up patch included in this email.

Cheers,
Con

---

Rolled up patch to provide dynticks support for i386 v051125-1

Signed-off-by: Con Kolivas <kernel@kolivas.org>

 arch/i386/Kconfig                       |   16 ++
 arch/i386/defconfig                     |    1
 arch/i386/kernel/Makefile               |    1
 arch/i386/kernel/apic.c                 |   31 ++++
 arch/i386/kernel/dyn-tick.c             |  144 ++++++++++++++++++++++
 arch/i386/kernel/io_apic.c              |   26 +++-
 arch/i386/kernel/irq.c                  |    3
 arch/i386/kernel/process.c              |    3
 arch/i386/kernel/smp.c                  |    8 +
 arch/i386/kernel/time.c                 |   18 +-
 arch/i386/kernel/timers/timer_cyclone.c |    4
 arch/i386/kernel/timers/timer_hpet.c    |    4
 arch/i386/kernel/timers/timer_none.c    |    3
 arch/i386/kernel/timers/timer_pit.c     |   35 +++++
 arch/i386/kernel/timers/timer_pm.c      |   32 ++--
 arch/i386/kernel/timers/timer_tsc.c     |   62 ++++-----
 drivers/acpi/Kconfig                    |    2
 drivers/acpi/processor_idle.c           |   27 ++++
 include/asm-i386/apic.h                 |    2
 include/asm-i386/dyn-tick.h             |   67 ++++++++++
 include/asm-i386/timer.h                |   39 +++++-
 include/linux/dyn-tick.h                |   68 ++++++++++
 include/linux/timer.h                   |    1
 kernel/Makefile                         |    1
 kernel/dyn-tick.c                       |  208 ++++++++++++++++++++++++++++++++
 kernel/timer.c                          |    7 +
 26 files changed, 745 insertions(+), 68 deletions(-)

Index: linux-2.6.15-rc2-dt/arch/i386/Kconfig
===================================================================
--- linux-2.6.15-rc2-dt.orig/arch/i386/Kconfig	2005-11-22 13:07:48.000000000 +1100
+++ linux-2.6.15-rc2-dt/arch/i386/Kconfig	2005-11-25 15:58:18.000000000 +1100
@@ -173,6 +173,22 @@ config HPET_EMULATE_RTC
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
 config SMP
 	bool "Symmetric multi-processing support"
 	---help---
Index: linux-2.6.15-rc2-dt/arch/i386/defconfig
===================================================================
--- linux-2.6.15-rc2-dt.orig/arch/i386/defconfig	2005-10-28 13:03:02.000000000 +1000
+++ linux-2.6.15-rc2-dt/arch/i386/defconfig	2005-11-25 15:58:18.000000000 +1100
@@ -91,6 +91,7 @@ CONFIG_X86_INTEL_USERCOPY=y
 CONFIG_X86_USE_PPRO_CHECKSUM=y
 # CONFIG_HPET_TIMER is not set
 # CONFIG_HPET_EMULATE_RTC is not set
+# CONFIG_NO_IDLE_HZ is not set
 CONFIG_SMP=y
 CONFIG_NR_CPUS=8
 CONFIG_SCHED_SMT=y
Index: linux-2.6.15-rc2-dt/arch/i386/kernel/Makefile
===================================================================
--- linux-2.6.15-rc2-dt.orig/arch/i386/kernel/Makefile	2005-10-28 13:03:02.000000000 +1000
+++ linux-2.6.15-rc2-dt/arch/i386/kernel/Makefile	2005-11-25 15:58:18.000000000 +1100
@@ -32,6 +32,7 @@ obj-$(CONFIG_MODULES)		+= module.o
 obj-y				+= sysenter.o vsyscall.o
 obj-$(CONFIG_ACPI_SRAT) 	+= srat.o
 obj-$(CONFIG_HPET_TIMER) 	+= time_hpet.o
+obj-$(CONFIG_NO_IDLE_HZ) 	+= dyn-tick.o
 obj-$(CONFIG_EFI) 		+= efi.o efi_stub.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
Index: linux-2.6.15-rc2-dt/arch/i386/kernel/apic.c
===================================================================
--- linux-2.6.15-rc2-dt.orig/arch/i386/kernel/apic.c	2005-11-22 13:07:48.000000000 +1100
+++ linux-2.6.15-rc2-dt/arch/i386/kernel/apic.c	2005-11-25 15:58:18.000000000 +1100
@@ -26,6 +26,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/sysdev.h>
 #include <linux/cpu.h>
+#include <linux/dyn-tick.h>
 
 #include <asm/atomic.h>
 #include <asm/smp.h>
@@ -932,6 +933,9 @@ void (*wait_timer_tick)(void) __devinitd
 
 #define APIC_DIVISOR 16
 
+static u32 apic_timer_val __read_mostly;
+#define APIC_TIMER_VAL	((apic_timer_val) / (HZ))
+
 static void __setup_APIC_LVTT(unsigned int clocks)
 {
 	unsigned int lvtt_value, tmp_value, ver;
@@ -950,7 +954,9 @@ static void __setup_APIC_LVTT(unsigned i
 				& ~(APIC_TDR_DIV_1 | APIC_TDR_DIV_TMBASE))
 				| APIC_TDR_DIV_16);
 
-	apic_write_around(APIC_TMICT, clocks/APIC_DIVISOR);
+	apic_timer_val = clocks * HZ / APIC_DIVISOR;
+
+	apic_write_around(APIC_TMICT, APIC_TIMER_VAL);
 }
 
 static void __devinit setup_APIC_timer(unsigned int clocks)
@@ -969,6 +975,17 @@ static void __devinit setup_APIC_timer(u
 	local_irq_restore(flags);
 }
 
+/* Used by NO_IDLE_HZ to skip ticks on idle CPUs */
+void reprogram_apic_timer(unsigned long count)
+{
+	unsigned long flags;
+
+	count = count * apic_timer_val / HZ;
+	local_irq_save(flags);
+	apic_write_around(APIC_TMICT, count);
+	local_irq_restore(flags);
+}
+
 /*
  * In this function we calibrate APIC bus clocks to the external
  * timer. Unfortunately we cannot use jiffies and the timer irq
@@ -1064,6 +1081,9 @@ void __init setup_boot_APIC_clock(void)
 	 */
 	setup_APIC_timer(calibration_result);
 
+	setup_dyn_tick_use_apic(calibration_result);
+	set_dyn_tick_max_skip((0xFFFFFFFF / calibration_result) * APIC_DIVISOR);
+
 	local_irq_restore(flags);
 }
 
@@ -1202,6 +1222,9 @@ fastcall void smp_apic_timer_interrupt(s
 	 * interrupt lock, which is the WrongThing (tm) to do.
 	 */
 	irq_enter();
+
+	dyn_tick_interrupt(regs);
+
 	smp_local_timer_interrupt(regs);
 	irq_exit();
 }
@@ -1214,6 +1237,9 @@ fastcall void smp_spurious_interrupt(str
 	unsigned long v;
 
 	irq_enter();
+
+	dyn_tick_interrupt(regs);
+
 	/*
 	 * Check if this really is a spurious interrupt and ACK it
 	 * if it is a vectored one.  Just in case...
@@ -1238,6 +1264,9 @@ fastcall void smp_error_interrupt(struct
 	unsigned long v, v1;
 
 	irq_enter();
+
+	dyn_tick_interrupt(regs);
+
 	/* First tickle the hardware, only then report what went on. -- REW */
 	v = apic_read(APIC_ESR);
 	apic_write(APIC_ESR, 0);
Index: linux-2.6.15-rc2-dt/arch/i386/kernel/dyn-tick.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-rc2-dt/arch/i386/kernel/dyn-tick.c	2005-11-25 15:59:11.000000000 +1100
@@ -0,0 +1,144 @@
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
+#include <asm/apic.h>
+
+static inline void reprogram_timer(unsigned long skip)
+{
+	if (cpu_has_local_apic())
+		reprogram_apic_timer(skip);
+	else
+		reprogram_pit_timer(skip);
+}
+
+static void arch_reprogram(unsigned long jif_next)
+{
+	unsigned long skip = jif_next - jiffies;
+
+	reprogram_timer(skip);
+	/* Fixme: Disable NMI Watchdog */
+}
+
+static void arch_all_cpus_idle(int how_long)
+{
+	if (cpu_has_local_apic())
+		disable_pit_timer();
+}
+
+static inline int arch_enable(void)
+{
+	return 0;
+}
+
+static inline int arch_disable(void)
+{
+	return 0;
+}
+
+static struct dyn_tick_timer arch_dyn_tick = {
+	.arch_reprogram		= &arch_reprogram,
+	.arch_all_cpus_idle	= &arch_all_cpus_idle,
+	.arch_enable		= &arch_enable,
+	.arch_disable		= &arch_disable,
+	.min_skip		= DYN_TICK_MIN_SKIP,
+};
+
+struct dyn_tick_timer *dyn_tick = &arch_dyn_tick;
+spinlock_t *dyn_tick_lock = &arch_dyn_tick.lock;
+
+int __init dyn_tick_arch_init(void)
+{
+	if (!cpu_has_local_apic())
+		set_dyn_tick_max_skip(0xffff / LATCH);	/* PIT timer length */
+
+	printk(KERN_INFO "dyn-tick: Maximum ticks to skip limited to %i\n",
+		arch_dyn_tick.max_skip);
+
+	return 0;
+}
+
+static int __init dyn_tick_init(void)
+{
+	arch_dyn_tick.arch_init = dyn_tick_arch_init;
+	dyn_tick_register(&arch_dyn_tick);
+
+	return 0;
+}
+
+arch_initcall(dyn_tick_init);
+
+/* Functions that need blank prototypes for !CONFIG_NO_IDLE_HZ below here */
+void setup_dyn_tick_use_apic(unsigned int calibration_result)
+{
+	if (calibration_result)
+		arch_dyn_tick.state |= DYN_TICK_APICABLE;
+	else {
+		arch_dyn_tick.state &= ~DYN_TICK_APICABLE;
+		printk(KERN_INFO "dyn-tick: Cannot use local APIC\n");
+	}
+}
+
+void dyn_tick_interrupt(struct pt_regs *regs)
+{
+	int cpu = smp_processor_id();
+
+	if (!cpu_isset(cpu, nohz_cpu_mask))
+		return;
+
+	spin_lock(dyn_tick_lock);
+	if (cpus_equal(nohz_cpu_mask, cpu_online_map)) {
+		/* All were sleeping, recover jiffies */
+		int lost = cur_timer->mark_offset();
+		if (lost && in_irq())
+			do_timer(regs);
+		if (cpu_has_local_apic())
+			enable_pit_timer();
+	}
+	cpu_clear(cpu, nohz_cpu_mask);
+	spin_unlock(dyn_tick_lock);
+
+	reprogram_timer(1);
+
+	conditional_run_local_timers();
+	/* Fixme: Enable NMI watchdog */
+}
+
+
+void dyn_tick_time_init(struct timer_opts *cur_timer)
+{
+	spin_lock_init(dyn_tick_lock);
+
+	if (strncmp(cur_timer->name, "pmtmr", 3) == 0) {
+		arch_dyn_tick.state |= DYN_TICK_SUITABLE;
+		printk(KERN_INFO "dyn-tick: Found suitable timer: %s\n",
+		       cur_timer->name);
+	} else
+		printk(KERN_ERR "dyn-tick: Cannot use timer %s\n",
+		       cur_timer->name);
+}
+
+void idle_reprogram_timer(void)
+{
+	local_irq_disable();
+	if (!need_resched())
+		timer_dyn_reprogram();
+	local_irq_enable();
+}
Index: linux-2.6.15-rc2-dt/arch/i386/kernel/io_apic.c
===================================================================
--- linux-2.6.15-rc2-dt.orig/arch/i386/kernel/io_apic.c	2005-11-22 13:07:48.000000000 +1100
+++ linux-2.6.15-rc2-dt/arch/i386/kernel/io_apic.c	2005-11-25 15:58:18.000000000 +1100
@@ -32,6 +32,7 @@
 #include <linux/acpi.h>
 #include <linux/module.h>
 #include <linux/sysdev.h>
+#include <linux/dyn-tick.h>
 
 #include <asm/io.h>
 #include <asm/smp.h>
@@ -1179,6 +1180,7 @@ next:
 
 static struct hw_interrupt_type ioapic_level_type;
 static struct hw_interrupt_type ioapic_edge_type;
+static struct hw_interrupt_type ioapic_edge_type_irq0;
 
 #define IOAPIC_AUTO	-1
 #define IOAPIC_EDGE	0
@@ -1190,15 +1192,19 @@ static inline void ioapic_register_intr(
 		if ((trigger == IOAPIC_AUTO && IO_APIC_irq_trigger(irq)) ||
 				trigger == IOAPIC_LEVEL)
 			irq_desc[vector].handler = &ioapic_level_type;
-		else
+		else if (vector)
 			irq_desc[vector].handler = &ioapic_edge_type;
+		else
+			irq_desc[vector].handler = &ioapic_edge_type_irq0;
 		set_intr_gate(vector, interrupt[vector]);
 	} else	{
 		if ((trigger == IOAPIC_AUTO && IO_APIC_irq_trigger(irq)) ||
 				trigger == IOAPIC_LEVEL)
 			irq_desc[irq].handler = &ioapic_level_type;
-		else
+		else if (irq)
 			irq_desc[irq].handler = &ioapic_edge_type;
+		else
+			irq_desc[irq].handler = &ioapic_edge_type_irq0;
 		set_intr_gate(vector, interrupt[irq]);
 	}
 }
@@ -1311,7 +1317,7 @@ static void __init setup_ExtINT_IRQ0_pin
 	 * The timer IRQ doesn't have to know that behind the
 	 * scene we have a 8259A-master in AEOI mode ...
 	 */
-	irq_desc[0].handler = &ioapic_edge_type;
+	irq_desc[0].handler = &ioapic_edge_type_irq0;
 
 	/*
 	 * Add it to the IO-APIC irq-routing table:
@@ -2088,6 +2094,20 @@ static struct hw_interrupt_type ioapic_l
 #endif
 };
 
+/* Needed to disable PIT interrupts when all CPUs sleep */
+static struct hw_interrupt_type ioapic_edge_type_irq0 __read_mostly = {
+	.typename 	= "IO-APIC-edge-irq0",
+	.startup 	= startup_edge_ioapic,
+	.shutdown 	= shutdown_edge_ioapic,
+	.enable 	= unmask_IO_APIC_irq,
+	.disable 	= mask_IO_APIC_irq,
+	.ack 		= ack_edge_ioapic,
+	.end 		= end_edge_ioapic,
+#ifdef CONFIG_SMP
+	.set_affinity 	= set_ioapic_affinity,
+#endif
+};
+
 static inline void init_IO_APIC_traps(void)
 {
 	int irq;
Index: linux-2.6.15-rc2-dt/arch/i386/kernel/irq.c
===================================================================
--- linux-2.6.15-rc2-dt.orig/arch/i386/kernel/irq.c	2005-11-22 13:07:48.000000000 +1100
+++ linux-2.6.15-rc2-dt/arch/i386/kernel/irq.c	2005-11-25 15:58:18.000000000 +1100
@@ -18,6 +18,7 @@
 #include <linux/notifier.h>
 #include <linux/cpu.h>
 #include <linux/delay.h>
+#include <linux/dyn-tick.h>
 
 DEFINE_PER_CPU(irq_cpustat_t, irq_stat) ____cacheline_maxaligned_in_smp;
 EXPORT_PER_CPU_SYMBOL(irq_stat);
@@ -76,6 +77,8 @@ fastcall unsigned int do_IRQ(struct pt_r
 	}
 #endif
 
+	dyn_tick_interrupt(regs);
+
 #ifdef CONFIG_4KSTACKS
 
 	curctx = (union irq_ctx *) current_thread_info();
Index: linux-2.6.15-rc2-dt/arch/i386/kernel/process.c
===================================================================
--- linux-2.6.15-rc2-dt.orig/arch/i386/kernel/process.c	2005-11-22 13:07:48.000000000 +1100
+++ linux-2.6.15-rc2-dt/arch/i386/kernel/process.c	2005-11-25 15:58:18.000000000 +1100
@@ -39,6 +39,7 @@
 #include <linux/ptrace.h>
 #include <linux/random.h>
 #include <linux/kprobes.h>
+#include <linux/dyn-tick.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -193,6 +194,8 @@ void cpu_idle(void)
 			if (cpu_is_offline(cpu))
 				play_dead();
 
+			idle_reprogram_timer();
+
 			__get_cpu_var(irq_stat).idle_timestamp = jiffies;
 			idle();
 		}
Index: linux-2.6.15-rc2-dt/arch/i386/kernel/smp.c
===================================================================
--- linux-2.6.15-rc2-dt.orig/arch/i386/kernel/smp.c	2005-10-28 13:03:02.000000000 +1000
+++ linux-2.6.15-rc2-dt/arch/i386/kernel/smp.c	2005-11-25 15:58:18.000000000 +1100
@@ -20,6 +20,7 @@
 #include <linux/interrupt.h>
 #include <linux/cpu.h>
 #include <linux/module.h>
+#include <linux/dyn-tick.h>
 
 #include <asm/mtrr.h>
 #include <asm/tlbflush.h>
@@ -313,6 +314,8 @@ fastcall void smp_invalidate_interrupt(s
 {
 	unsigned long cpu;
 
+	dyn_tick_interrupt(regs);
+
 	cpu = get_cpu();
 
 	if (!cpu_isset(cpu, flush_cpumask))
@@ -600,6 +603,8 @@ void smp_send_stop(void)
 fastcall void smp_reschedule_interrupt(struct pt_regs *regs)
 {
 	ack_APIC_irq();
+
+	dyn_tick_interrupt(regs);
 }
 
 fastcall void smp_call_function_interrupt(struct pt_regs *regs)
@@ -609,6 +614,9 @@ fastcall void smp_call_function_interrup
 	int wait = call_data->wait;
 
 	ack_APIC_irq();
+
+	dyn_tick_interrupt(regs);
+
 	/*
 	 * Notify initiating CPU that I've grabbed the data and am
 	 * about to execute the function
Index: linux-2.6.15-rc2-dt/arch/i386/kernel/time.c
===================================================================
--- linux-2.6.15-rc2-dt.orig/arch/i386/kernel/time.c	2005-11-22 13:07:48.000000000 +1100
+++ linux-2.6.15-rc2-dt/arch/i386/kernel/time.c	2005-11-25 15:59:11.000000000 +1100
@@ -46,6 +46,7 @@
 #include <linux/bcd.h>
 #include <linux/efi.h>
 #include <linux/mca.h>
+#include <linux/dyn-tick.h>
 
 #include <asm/io.h>
 #include <asm/smp.h>
@@ -245,7 +246,7 @@ EXPORT_SYMBOL(profile_pc);
  * timer_interrupt() needs to keep up the real-time clock,
  * as well as call the "do_timer()" routine every clocktick
  */
-static inline void do_timer_interrupt(int irq, struct pt_regs *regs)
+static inline void do_timer_interrupt(int irq, struct pt_regs *regs, int lost)
 {
 #ifdef CONFIG_X86_IO_APIC
 	if (timer_ack) {
@@ -263,7 +264,8 @@ static inline void do_timer_interrupt(in
 	}
 #endif
 
-	do_timer_interrupt_hook(regs);
+	if (!dyn_tick_enabled() || lost)
+		do_timer_interrupt_hook(regs);
 
 
 	if (MCA_bus) {
@@ -288,6 +290,8 @@ static inline void do_timer_interrupt(in
  */
 irqreturn_t timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
+	int lost;
+
 	/*
 	 * Here we are in the timer irq handler. We just have irqs locally
 	 * disabled but we don't know if the timer_bh is running on the other
@@ -297,9 +301,9 @@ irqreturn_t timer_interrupt(int irq, voi
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
@@ -425,7 +429,7 @@ static struct sysdev_class timer_sysclas
 
 
 /* XXX this driverfs stuff should probably go elsewhere later -john */
-static struct sys_device device_timer = {
+struct sys_device device_timer = {
 	.id	= 0,
 	.cls	= &timer_sysclass,
 };
@@ -481,5 +485,7 @@ void __init time_init(void)
 	cur_timer = select_timer();
 	printk(KERN_INFO "Using %s for high-res timesource\n",cur_timer->name);
 
+	dyn_tick_time_init(cur_timer);
+
 	time_init_hook();
 }
Index: linux-2.6.15-rc2-dt/arch/i386/kernel/timers/timer_pit.c
===================================================================
--- linux-2.6.15-rc2-dt.orig/arch/i386/kernel/timers/timer_pit.c	2005-11-22 13:07:48.000000000 +1100
+++ linux-2.6.15-rc2-dt/arch/i386/kernel/timers/timer_pit.c	2005-11-25 15:59:11.000000000 +1100
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
@@ -148,6 +149,38 @@ static unsigned long get_offset_pit(void
 	return count;
 }
 
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
+	skip = jiffies_to_skip * LATCH;
+	if (skip > 0xffff)
+		skip = 0xffff;
+
+	spin_lock_irqsave(&i8253_lock, flags);
+	outb_p(0x34, PIT_MODE);		/* binary, mode 2, LSB/MSB, ch 0 */
+	outb_p(skip & 0xff, PIT_CH0);	/* LSB */
+	outb(skip >> 8, PIT_CH0);	/* MSB */
+	spin_unlock_irqrestore(&i8253_lock, flags);
+}
 
 /* tsc timer_opts struct */
 struct timer_opts timer_pit = {
Index: linux-2.6.15-rc2-dt/arch/i386/kernel/timers/timer_pm.c
===================================================================
--- linux-2.6.15-rc2-dt.orig/arch/i386/kernel/timers/timer_pm.c	2005-10-28 13:03:02.000000000 +1000
+++ linux-2.6.15-rc2-dt/arch/i386/kernel/timers/timer_pm.c	2005-11-25 15:59:11.000000000 +1100
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
+	set_dyn_tick_max_skip(((0xFFFFFF / 1000000) * 286 * HZ) >> 10);
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
 
 
Index: linux-2.6.15-rc2-dt/arch/i386/kernel/timers/timer_tsc.c
===================================================================
--- linux-2.6.15-rc2-dt.orig/arch/i386/kernel/timers/timer_tsc.c	2005-11-22 13:07:48.000000000 +1100
+++ linux-2.6.15-rc2-dt/arch/i386/kernel/timers/timer_tsc.c	2005-11-25 15:59:11.000000000 +1100
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
+	unsigned long long last_offset;
  	unsigned long offset, temp, hpet_current;
+ 	int lost_ticks = 0;
 
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
+			set_dyn_tick_max_skip((0xFFFFFFFF /
+				(cpu_khz * 1000)) * HZ);
 			return 0;
 		}
 	}
Index: linux-2.6.15-rc2-dt/drivers/acpi/Kconfig
===================================================================
--- linux-2.6.15-rc2-dt.orig/drivers/acpi/Kconfig	2005-10-28 13:03:02.000000000 +1000
+++ linux-2.6.15-rc2-dt/drivers/acpi/Kconfig	2005-11-25 15:58:18.000000000 +1100
@@ -302,6 +302,8 @@ config X86_PM_TIMER
 	  voltage scaling, unlike the commonly used Time Stamp Counter
 	  (TSC) timing source.
 
+	  This timer is selected by dyntick (NO_IDLE_HZ).
+
 	  So, if you see messages like 'Losing too many ticks!' in the
 	  kernel logs, and/or you are using this on a notebook which
 	  does not yet have an HPET, you should say "Y" here.
Index: linux-2.6.15-rc2-dt/include/asm-i386/apic.h
===================================================================
--- linux-2.6.15-rc2-dt.orig/include/asm-i386/apic.h	2005-10-28 13:03:05.000000000 +1000
+++ linux-2.6.15-rc2-dt/include/asm-i386/apic.h	2005-11-25 15:58:18.000000000 +1100
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
 
Index: linux-2.6.15-rc2-dt/include/asm-i386/dyn-tick.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-rc2-dt/include/asm-i386/dyn-tick.h	2005-11-25 15:59:02.000000000 +1100
@@ -0,0 +1,67 @@
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
+extern void setup_dyn_tick_use_apic(unsigned int calibration_result);
+extern void dyn_tick_interrupt(struct pt_regs *regs);
+extern void dyn_tick_time_init(struct timer_opts *cur_timer);
+
+/*
+ * Needs to be different to the arch independant values specified in
+ * include/linux/dyn-tick.h to share the dyn_tick_timer.state struct
+ * member.
+ */
+#define DYN_TICK_APICABLE	(1 << 3)
+
+#if (defined(CONFIG_SMP) || defined(CONFIG_X86_UP_APIC))
+static inline int cpu_has_local_apic(void)
+{
+	return (dyn_tick->state & DYN_TICK_APICABLE);
+}
+
+#else	/* (defined(CONFIG_SMP) || defined(CONFIG_X86_UP_APIC)) */
+static inline int cpu_has_local_apic(void)
+{
+	return 0;
+}
+#endif	/* (defined(CONFIG_SMP) || defined(CONFIG_X86_UP_APIC)) */
+
+extern void idle_reprogram_timer(void);
+
+#else /* CONFIG_NO_IDLE_HZ */
+
+static inline void setup_dyn_tick_use_apic(unsigned int calibration_result)
+{
+}
+
+static inline void dyn_tick_interrupt(struct pt_regs *regs)
+{
+}
+
+static inline void dyn_tick_time_init(struct timer_opts *cur_timer)
+{
+}
+
+static inline void idle_reprogram_timer(void)
+{
+}
+
+#endif /* CONFIG_NO_IDLE_HZ */
+
+#endif /* _ASM_I386_DYN_TICK_H_ */
Index: linux-2.6.15-rc2-dt/include/asm-i386/timer.h
===================================================================
--- linux-2.6.15-rc2-dt.orig/include/asm-i386/timer.h	2005-10-28 13:03:05.000000000 +1000
+++ linux-2.6.15-rc2-dt/include/asm-i386/timer.h	2005-11-25 15:59:11.000000000 +1100
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
@@ -38,6 +39,9 @@ struct init_timer_opts {
 extern struct timer_opts* __init select_timer(void);
 extern void clock_fallback(void);
 void setup_pit_timer(void);
+extern void disable_pit_timer(void);
+extern void enable_pit_timer(void);
+extern void reprogram_pit_timer(unsigned long jiffies_to_skip);
 
 /* Modifiers for buggy PIT handling */
 
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
Index: linux-2.6.15-rc2-dt/include/linux/dyn-tick.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-rc2-dt/include/linux/dyn-tick.h	2005-11-25 15:59:55.000000000 +1100
@@ -0,0 +1,68 @@
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
+#include <asm/timer.h>
+
+#define DYN_TICK_SKIPPING	(1 << 2)
+#define DYN_TICK_ENABLED	(1 << 1)
+#define DYN_TICK_SUITABLE	(1 << 0)
+
+#define DYN_TICK_MIN_SKIP	2
+
+struct dyn_tick_timer {
+	spinlock_t lock;
+
+	int (*arch_init) (void);	/* dyn_tick init */
+	int (*arch_enable)(void);	/* Enables dynamic tick */
+	int (*arch_disable)(void);	/* Disables dynamic tick */
+	void (*arch_reprogram)(unsigned long); /* Reprograms the timer */
+	int (*arch_handler)(int, void *, struct pt_regs *);
+	void (*arch_all_cpus_idle) (int);
+
+	unsigned short state;		/* Current state */
+	unsigned int min_skip;		/* Max number of ticks to skip */
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
+extern int dyn_tick_enabled(void);
+extern void timer_dyn_reprogram(void);
+extern void set_dyn_tick_max_skip(unsigned int max_skip);
+
+#else	/* CONFIG_NO_IDLE_HZ */
+static inline int dyn_tick_enabled(void)
+{
+	return 0;
+}
+
+static inline void set_dyn_tick_max_skip(unsigned int max_skip)
+{
+}
+#endif	/* CONFIG_NO_IDLE_HZ */
+
+/* Pick up arch specific header */
+#include <asm/dyn-tick.h>
+
+#endif	/* _DYN_TICK_TIMER_H */
Index: linux-2.6.15-rc2-dt/include/linux/timer.h
===================================================================
--- linux-2.6.15-rc2-dt.orig/include/linux/timer.h	2005-11-22 13:07:52.000000000 +1100
+++ linux-2.6.15-rc2-dt/include/linux/timer.h	2005-11-25 15:58:18.000000000 +1100
@@ -97,5 +97,6 @@ static inline void add_timer(struct time
 extern void init_timers(void);
 extern void run_local_timers(void);
 extern void it_real_fn(unsigned long);
+extern void conditional_run_local_timers(void);
 
 #endif
Index: linux-2.6.15-rc2-dt/kernel/dyn-tick.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-rc2-dt/kernel/dyn-tick.c	2005-11-25 16:00:28.000000000 +1100
@@ -0,0 +1,208 @@
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
+
+#define DYN_TICK_VERSION	"051125-1"
+
+EXPORT_SYMBOL(dyn_tick);
+
+int dyn_tick_enabled(void)
+{
+	return (dyn_tick->state & DYN_TICK_ENABLED);
+}
+
+EXPORT_SYMBOL(dyn_tick_enabled);
+
+static inline int dyn_tick_suitable(void)
+{
+	return (dyn_tick->state & DYN_TICK_SUITABLE);
+}
+
+/*
+ * Arch independent code needed to reprogram next timer interrupt.
+ * Gets called, with IRQs disabled, from cpu_idle() before entering idle loop.
+ * Significant contention is possible so avoid spinning on locks and do not
+ * reprogram timers instead.
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
+	if (rcu_pending(cpu) || local_softirq_pending())
+		return;
+
+	/* Check if we can start skipping ticks */
+	if (unlikely(!write_tryseqlock(&xtime_lock)))
+		return;
+
+	delta = next_timer_interrupt() - jiffies;
+	if (delta > dyn_tick->max_skip)
+		delta = dyn_tick->max_skip;
+
+	if (delta > dyn_tick->min_skip) {
+		int idle_time = 0;
+
+		if (unlikely(!spin_trylock(dyn_tick_lock)))
+			goto out_unlock;
+
+		dyn_tick->last_skip = dyn_tick->skip_tick;
+		dyn_tick->skip_tick = jiffies;
+		dyn_tick->skip = delta;
+		dyn_tick->arch_reprogram(jiffies + delta);
+
+		cpu_set(cpu, nohz_cpu_mask);
+		if (cpus_equal(nohz_cpu_mask, cpu_online_map))
+			/* Fixme: idle_time needs to be computed */
+			dyn_tick->arch_all_cpus_idle(idle_time);
+
+		spin_unlock(dyn_tick_lock);
+	}
+
+out_unlock:
+	write_sequnlock(&xtime_lock);
+}
+
+void set_dyn_tick_max_skip(unsigned int max_skip)
+{
+	if (!dyn_tick->max_skip || max_skip < dyn_tick->max_skip)
+		dyn_tick->max_skip = max_skip;
+}
+
+void __init dyn_tick_register(struct dyn_tick_timer *arch_timer)
+{
+	dyn_tick = arch_timer;
+	printk(KERN_INFO "dyn-tick: Registering dynamic tick timer v%s\n",
+	       DYN_TICK_VERSION);
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
+		if (ret == 0)
+			dyn_tick->state |= DYN_TICK_ENABLED;
+	} else {
+		ret = dyn_tick->arch_disable();
+		if (ret == 0)
+			dyn_tick->state &= ~DYN_TICK_ENABLED;
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
+	int ret = 0;
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
+		printk(KERN_INFO "dyn-tick: Timer using dynamic tick\n");
+	} else
+		printk(KERN_INFO "dyn-tick: Timer not enabled during boot\n");
+
+	dyn_tick->skip_tick = 0;
+	dyn_tick->last_skip = 0;
+	dyn_tick->skip = 0;
+
+	return ret;
+}
+
+late_initcall(dyn_tick_late_init);
Index: linux-2.6.15-rc2-dt/kernel/timer.c
===================================================================
--- linux-2.6.15-rc2-dt.orig/kernel/timer.c	2005-11-22 13:07:52.000000000 +1100
+++ linux-2.6.15-rc2-dt/kernel/timer.c	2005-11-25 15:58:18.000000000 +1100
@@ -869,6 +869,13 @@ void run_local_timers(void)
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
Index: linux-2.6.15-rc2-dt/kernel/Makefile
===================================================================
--- linux-2.6.15-rc2-dt.orig/kernel/Makefile	2005-11-22 13:07:52.000000000 +1100
+++ linux-2.6.15-rc2-dt/kernel/Makefile	2005-11-25 15:58:18.000000000 +1100
@@ -32,6 +32,7 @@ obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
 obj-$(CONFIG_CRASH_DUMP) += crash_dump.o
 obj-$(CONFIG_SECCOMP) += seccomp.o
 obj-$(CONFIG_RCU_TORTURE_TEST) += rcutorture.o
+obj-$(CONFIG_NO_IDLE_HZ) += dyn-tick.o
 
 ifneq ($(CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
Index: linux-2.6.15-rc2-dt/arch/i386/kernel/timers/timer_cyclone.c
===================================================================
--- linux-2.6.15-rc2-dt.orig/arch/i386/kernel/timers/timer_cyclone.c	2005-11-25 15:58:51.000000000 +1100
+++ linux-2.6.15-rc2-dt/arch/i386/kernel/timers/timer_cyclone.c	2005-11-25 15:59:11.000000000 +1100
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
Index: linux-2.6.15-rc2-dt/arch/i386/kernel/timers/timer_hpet.c
===================================================================
--- linux-2.6.15-rc2-dt.orig/arch/i386/kernel/timers/timer_hpet.c	2005-11-25 15:58:51.000000000 +1100
+++ linux-2.6.15-rc2-dt/arch/i386/kernel/timers/timer_hpet.c	2005-11-25 15:59:11.000000000 +1100
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
Index: linux-2.6.15-rc2-dt/arch/i386/kernel/timers/timer_none.c
===================================================================
--- linux-2.6.15-rc2-dt.orig/arch/i386/kernel/timers/timer_none.c	2005-11-25 15:58:51.000000000 +1100
+++ linux-2.6.15-rc2-dt/arch/i386/kernel/timers/timer_none.c	2005-11-25 15:59:11.000000000 +1100
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
Index: linux-2.6.15-rc2-dt/drivers/acpi/processor_idle.c
===================================================================
--- linux-2.6.15-rc2-dt.orig/drivers/acpi/processor_idle.c	2005-11-22 13:07:49.000000000 +1100
+++ linux-2.6.15-rc2-dt/drivers/acpi/processor_idle.c	2005-11-25 15:59:55.000000000 +1100
@@ -38,6 +38,7 @@
 #include <linux/dmi.h>
 #include <linux/moduleparam.h>
 #include <linux/sched.h>	/* need_resched() */
+#include <linux/dyn-tick.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -182,6 +183,17 @@ static void acpi_safe_halt(void)
 
 static atomic_t c3_cpu_count;
 
+static inline int skipped_since_bm_check(void)
+{
+	/*
+	 * If we've been skipping ticks in the last few ticks there wouldn't be
+	 * any busmaster activity.
+	 */
+	if (dyn_tick->last_skip + dyn_tick->skip >= jiffies)
+		return dyn_tick->skip;
+	return 0;
+}
+
 static void acpi_processor_idle(void)
 {
 	struct acpi_processor *pr = NULL;
@@ -227,6 +239,18 @@ static void acpi_processor_idle(void)
 	if (pr->flags.bm_check) {
 		u32 bm_status = 0;
 		unsigned long diff = jiffies - pr->power.bm_check_timestamp;
+		int skipped = 0;
+
+		if (dyn_tick_enabled()) {
+			skipped = skipped_since_bm_check();
+			if (skipped) {
+				diff = 0;
+				do {
+					if (!(pr->power.bm_activity >>= 1))
+						break;
+				} while (skipped--);
+			}
+		}
 
 		if (diff > 32)
 			diff = 32;
@@ -242,7 +266,8 @@ static void acpi_processor_idle(void)
 		acpi_get_register(ACPI_BITREG_BUS_MASTER_STATUS,
 				  &bm_status, ACPI_MTX_DO_NOT_LOCK);
 		if (bm_status) {
-			pr->power.bm_activity++;
+			if (!skipped)
+				pr->power.bm_activity++;
 			acpi_set_register(ACPI_BITREG_BUS_MASTER_STATUS,
 					  1, ACPI_MTX_DO_NOT_LOCK);
 		}
