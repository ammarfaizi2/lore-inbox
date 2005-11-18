Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161079AbVKRMWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161079AbVKRMWT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 07:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161080AbVKRMWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 07:22:19 -0500
Received: from mail04.syd.optusnet.com.au ([211.29.132.185]:8145 "EHLO
	mail04.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1161079AbVKRMWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 07:22:18 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] i386 no idle hz - aka dynticks v051118-1
Date: Fri, 18 Nov 2005 23:22:10 +1100
User-Agent: KMail/1.8.3
Cc: ck@vds.kolivas.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_zdcfDXDG0PWYKGo"
Message-Id: <200511182322.11222.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_zdcfDXDG0PWYKGo
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Here is a complete respin of the dynamic ticks code for i386.

I thank Srivatsa Vaddagiri for attempting to unify the dyntick interfaces, and 
Russell King for suggestions on unifying it based on the arm code. Other 
dynticks versions have appeared sporadically for x86_64 and ppc64 without 
reference to the unified base. As the i386 code still has the beginnings of a 
unified dynticks, I have updated the i386 dynticks with this in mind, and 
hopefully unity can still be achieved in the future.

I've changed the portion of the arch independent code to resemble the arm base 
more closely with struct members of dyn_tick_timer, and extra members that 
may be helpful in other arches.

I've performed numerous cleanups and optimisations.

The timer reprogramming accuracy was improved.

The sys/ interface was made to resemble the arm one with a simple entry for on 
and off in
/sys/devices/system/timer/timer0/dyn_tick
as the other entries were redundant and it makes sense to be consistent.

i386 NO_IDLE_HZ now selects the pm_timer rather than is dependent on it since 
it is the only timer which can maintain accuracy with dynticks enabled.

So far this version seems to boot and run fine, but there are at least 2 
places in the kernel that need to be made aware of the fact they're running 
dynticks; the ondemand scaling governor and the bus mastering code (as 
pointed out by Tytso). Both don't realise the few ticks that have passed are 
quite some distance apart and overestimate the load grossly. They are not 
harmful, but lead to increase in power usage instead of a decrease. I have 
yet to investigate that code portion to see what needs to be done

The current patch is a series of 3 patches and a rollup and the split-out 
patches are all available here:
http://ck.kolivas.org/patches/dyn-ticks/

Attached is a rollup of the 3 patches for 2.6.15-rc1 to provide dynticks for 
i386

Please test and report, and feel free to provide code hints for ondemand and 
bus mastering :D

Cheers,
Con

--Boundary-00=_zdcfDXDG0PWYKGo
Content-Type: text/x-diff;
  charset="utf-8";
  name="2.6.15-rc1-dynticks-051118-1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="2.6.15-rc1-dynticks-051118-1.patch"

Index: linux-2.6.15-rc1-dt/arch/i386/Kconfig
===================================================================
--- linux-2.6.15-rc1-dt.orig/arch/i386/Kconfig
+++ linux-2.6.15-rc1-dt/arch/i386/Kconfig
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
+	  timer. TSC and HPET timers are not supported.
+
+	  Note that you can disable dynamic tick timer either by
+	  passing dyntick=disable command line option, or via sysfs:
+
+	  # echo 0 > /sys/devices/system/dyn_tick/dyn_tick0/enable
+
 config SMP
 	bool "Symmetric multi-processing support"
 	---help---
Index: linux-2.6.15-rc1-dt/arch/i386/defconfig
===================================================================
--- linux-2.6.15-rc1-dt.orig/arch/i386/defconfig
+++ linux-2.6.15-rc1-dt/arch/i386/defconfig
@@ -91,6 +91,7 @@ CONFIG_X86_INTEL_USERCOPY=y
 CONFIG_X86_USE_PPRO_CHECKSUM=y
 # CONFIG_HPET_TIMER is not set
 # CONFIG_HPET_EMULATE_RTC is not set
+# CONFIG_NO_IDLE_HZ is not set
 CONFIG_SMP=y
 CONFIG_NR_CPUS=8
 CONFIG_SCHED_SMT=y
Index: linux-2.6.15-rc1-dt/arch/i386/kernel/Makefile
===================================================================
--- linux-2.6.15-rc1-dt.orig/arch/i386/kernel/Makefile
+++ linux-2.6.15-rc1-dt/arch/i386/kernel/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_MODULES)		+= module.o
 obj-y				+= sysenter.o vsyscall.o
 obj-$(CONFIG_ACPI_SRAT) 	+= srat.o
 obj-$(CONFIG_HPET_TIMER) 	+= time_hpet.o
+obj-$(CONFIG_NO_IDLE_HZ) 	+= dyn-tick.o
 obj-$(CONFIG_EFI) 		+= efi.o efi_stub.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
Index: linux-2.6.15-rc1-dt/arch/i386/kernel/apic.c
===================================================================
--- linux-2.6.15-rc1-dt.orig/arch/i386/kernel/apic.c
+++ linux-2.6.15-rc1-dt/arch/i386/kernel/apic.c
@@ -26,6 +26,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/sysdev.h>
 #include <linux/cpu.h>
+#include <linux/dyn-tick.h>
 
 #include <asm/atomic.h>
 #include <asm/smp.h>
@@ -932,6 +933,9 @@ void (*wait_timer_tick)(void) __devinitd
 
 #define APIC_DIVISOR 16
 
+static u32 apic_timer_val;
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
+	dyn_tick_interrupt(LOCAL_TIMER_VECTOR, regs);
+
 	smp_local_timer_interrupt(regs);
 	irq_exit();
 }
@@ -1214,6 +1237,9 @@ fastcall void smp_spurious_interrupt(str
 	unsigned long v;
 
 	irq_enter();
+
+	dyn_tick_interrupt(SPURIOUS_APIC_VECTOR, regs);
+
 	/*
 	 * Check if this really is a spurious interrupt and ACK it
 	 * if it is a vectored one.  Just in case...
@@ -1238,6 +1264,9 @@ fastcall void smp_error_interrupt(struct
 	unsigned long v, v1;
 
 	irq_enter();
+
+	dyn_tick_interrupt(ERROR_APIC_VECTOR, regs);
+
 	/* First tickle the hardware, only then report what went on. -- REW */
 	v = apic_read(APIC_ESR);
 	apic_write(APIC_ESR, 0);
Index: linux-2.6.15-rc1-dt/arch/i386/kernel/dyn-tick.c
===================================================================
--- /dev/null
+++ linux-2.6.15-rc1-dt/arch/i386/kernel/dyn-tick.c
@@ -0,0 +1,154 @@
+/*
+ * linux/arch/i386/kernel/dyn-tick.c
+ *
+ * Copyright (C) 2004 Nokia Corporation
+ * Written by Tony Lindgen <tony@atomide.com> and
+ * Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
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
+void dyn_tick_interrupt(int irq, struct pt_regs *regs)
+{
+	int all_were_sleeping = 0;
+	int cpu = smp_processor_id();
+
+	if (!cpu_isset(cpu, nohz_cpu_mask))
+		return;
+
+	spin_lock(dyn_tick_lock);
+
+	if (cpus_equal(nohz_cpu_mask, cpu_online_map))
+		all_were_sleeping = 1;
+	cpu_clear(cpu, nohz_cpu_mask);
+
+	if (all_were_sleeping) {
+		/* Recover jiffies */
+		if (irq) {
+			int lost;
+
+			lost = cur_timer->mark_offset();
+			if (lost)
+				do_timer(regs);
+		}
+		if (cpu_has_local_apic())
+			enable_pit_timer();
+	}
+
+	spin_unlock(dyn_tick_lock);
+
+	reprogram_timer(1);
+
+	conditional_run_local_timers();
+
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
Index: linux-2.6.15-rc1-dt/arch/i386/kernel/io_apic.c
===================================================================
--- linux-2.6.15-rc1-dt.orig/arch/i386/kernel/io_apic.c
+++ linux-2.6.15-rc1-dt/arch/i386/kernel/io_apic.c
@@ -32,6 +32,7 @@
 #include <linux/acpi.h>
 #include <linux/module.h>
 #include <linux/sysdev.h>
+#include <linux/dyn-tick.h>
 
 #include <asm/io.h>
 #include <asm/smp.h>
@@ -1190,15 +1191,19 @@ static inline void ioapic_register_intr(
 		if ((trigger == IOAPIC_AUTO && IO_APIC_irq_trigger(irq)) ||
 				trigger == IOAPIC_LEVEL)
 			irq_desc[vector].handler = &ioapic_level_type;
-		else
+		else if (vector)
 			irq_desc[vector].handler = &ioapic_edge_type;
+		else
+			irq_desc[vector].handler = IOAPIC_EDGE_TYPE_IRQ0;
 		set_intr_gate(vector, interrupt[vector]);
 	} else	{
 		if ((trigger == IOAPIC_AUTO && IO_APIC_irq_trigger(irq)) ||
 				trigger == IOAPIC_LEVEL)
 			irq_desc[irq].handler = &ioapic_level_type;
-		else
+		else if (irq)
 			irq_desc[irq].handler = &ioapic_edge_type;
+		else
+			irq_desc[irq].handler = IOAPIC_EDGE_TYPE_IRQ0;
 		set_intr_gate(vector, interrupt[irq]);
 	}
 }
@@ -1311,7 +1316,7 @@ static void __init setup_ExtINT_IRQ0_pin
 	 * The timer IRQ doesn't have to know that behind the
 	 * scene we have a 8259A-master in AEOI mode ...
 	 */
-	irq_desc[0].handler = &ioapic_edge_type;
+	irq_desc[0].handler = IOAPIC_EDGE_TYPE_IRQ0;
 
 	/*
 	 * Add it to the IO-APIC irq-routing table:
@@ -2088,6 +2093,20 @@ static struct hw_interrupt_type ioapic_l
 #endif
 };
 
+/* Needed to disable PIT interrupts when all CPUs sleep */
+struct hw_interrupt_type ioapic_edge_type_irq0 = {
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
Index: linux-2.6.15-rc1-dt/arch/i386/kernel/irq.c
===================================================================
--- linux-2.6.15-rc1-dt.orig/arch/i386/kernel/irq.c
+++ linux-2.6.15-rc1-dt/arch/i386/kernel/irq.c
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
 
+	dyn_tick_interrupt(irq, regs);
+
 #ifdef CONFIG_4KSTACKS
 
 	curctx = (union irq_ctx *) current_thread_info();
Index: linux-2.6.15-rc1-dt/arch/i386/kernel/process.c
===================================================================
--- linux-2.6.15-rc1-dt.orig/arch/i386/kernel/process.c
+++ linux-2.6.15-rc1-dt/arch/i386/kernel/process.c
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
Index: linux-2.6.15-rc1-dt/arch/i386/kernel/smp.c
===================================================================
--- linux-2.6.15-rc1-dt.orig/arch/i386/kernel/smp.c
+++ linux-2.6.15-rc1-dt/arch/i386/kernel/smp.c
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
 
+	dyn_tick_interrupt(INVALIDATE_TLB_VECTOR, regs);
+
 	cpu = get_cpu();
 
 	if (!cpu_isset(cpu, flush_cpumask))
@@ -600,6 +603,8 @@ void smp_send_stop(void)
 fastcall void smp_reschedule_interrupt(struct pt_regs *regs)
 {
 	ack_APIC_irq();
+
+	dyn_tick_interrupt(RESCHEDULE_VECTOR, regs);
 }
 
 fastcall void smp_call_function_interrupt(struct pt_regs *regs)
@@ -609,6 +614,9 @@ fastcall void smp_call_function_interrup
 	int wait = call_data->wait;
 
 	ack_APIC_irq();
+
+	dyn_tick_interrupt(CALL_FUNCTION_VECTOR, regs);
+
 	/*
 	 * Notify initiating CPU that I've grabbed the data and am
 	 * about to execute the function
Index: linux-2.6.15-rc1-dt/arch/i386/kernel/time.c
===================================================================
--- linux-2.6.15-rc1-dt.orig/arch/i386/kernel/time.c
+++ linux-2.6.15-rc1-dt/arch/i386/kernel/time.c
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
Index: linux-2.6.15-rc1-dt/arch/i386/kernel/timers/timer_pit.c
===================================================================
--- linux-2.6.15-rc1-dt.orig/arch/i386/kernel/timers/timer_pit.c
+++ linux-2.6.15-rc1-dt/arch/i386/kernel/timers/timer_pit.c
@@ -31,9 +31,10 @@ static int __init init_pit(char* overrid
 	return 0;
 }
 
-static void mark_offset_pit(void)
+static int mark_offset_pit(void)
 {
 	/* nothing needed */
+	return 1;
 }
 
 static unsigned long long monotonic_clock_pit(void)
@@ -147,6 +148,38 @@ static unsigned long get_offset_pit(void
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
Index: linux-2.6.15-rc1-dt/arch/i386/kernel/timers/timer_pm.c
===================================================================
--- linux-2.6.15-rc1-dt.orig/arch/i386/kernel/timers/timer_pm.c
+++ linux-2.6.15-rc1-dt/arch/i386/kernel/timers/timer_pm.c
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
 
 
Index: linux-2.6.15-rc1-dt/arch/i386/kernel/timers/timer_tsc.c
===================================================================
--- linux-2.6.15-rc1-dt.orig/arch/i386/kernel/timers/timer_tsc.c
+++ linux-2.6.15-rc1-dt/arch/i386/kernel/timers/timer_tsc.c
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
@@ -171,10 +170,19 @@ static void delay_tsc(unsigned long loop
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
 
 	write_seqlock(&monotonic_lock);
@@ -202,9 +210,7 @@ static void mark_offset_tsc_hpet(void)
 	}
 	hpet_last = hpet_current;
 
-	/* update the monotonic base value */
-	this_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
-	monotonic_base += cycles_2_ns(this_offset - last_offset);
+	update_monotonic_base(last_offset);
 	write_sequnlock(&monotonic_lock);
 
 	/* calculate delay_at_last_interrupt */
@@ -218,6 +224,8 @@ static void mark_offset_tsc_hpet(void)
 	delay_at_last_interrupt = hpet_current - offset;
 	ASM_MUL64_REG(temp, delay_at_last_interrupt,
 			hpet_usec_quotient, delay_at_last_interrupt);
+
+	return 1;
 }
 #endif
 
@@ -242,7 +250,7 @@ static void handle_cpufreq_delayed_get(v
  * to verify the CPU frequency the timing core thinks the CPU is running
  * at is still correct.
  */
-static inline void cpufreq_delayed_get(void) 
+void cpufreq_delayed_get(void)
 {
 	if (cpufreq_init && !cpufreq_delayed_issched) {
 		cpufreq_delayed_issched = 1;
@@ -321,7 +329,7 @@ static int __init cpufreq_tsc(void)
 core_initcall(cpufreq_tsc);
 
 #else /* CONFIG_CPU_FREQ */
-static inline void cpufreq_delayed_get(void) { return; }
+void cpufreq_delayed_get(void) { return; }
 #endif 
 
 int recalibrate_cpu_khz(void)
@@ -344,15 +352,15 @@ int recalibrate_cpu_khz(void)
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
+	int lost_count = 0;
 
 	write_seqlock(&monotonic_lock);
 	last_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
@@ -422,26 +430,11 @@ static void mark_offset_tsc(void)
 	if (lost >= 2) {
 		jiffies_64 += lost-1;
 
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
+		tsc_sanity_check(&lost_count);
 	} else
 		lost_count = 0;
-	/* update the monotonic base value */
-	this_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
-	monotonic_base += cycles_2_ns(this_offset - last_offset);
+
+	update_monotonic_base(last_offset);
 	write_sequnlock(&monotonic_lock);
 
 	/* calculate delay_at_last_interrupt */
@@ -452,8 +445,12 @@ static void mark_offset_tsc(void)
 	 * between tsc and pit reads (as noted when
 	 * usec delta is > 90% # of usecs/tick)
 	 */
-	if (lost && abs(delay - delay_at_last_interrupt) > (900000/HZ))
+	if (lost && abs(delay - delay_at_last_interrupt) > (900000/HZ)) {
 		jiffies_64++;
+		lost++;
+	}
+
+	return 1;
 }
 
 static int __init init_tsc(char* override)
@@ -542,6 +539,8 @@ static int __init init_tsc(char* overrid
 					cpu_khz / 1000, cpu_khz % 1000);
 			}
 			set_cyc2ns_scale(cpu_khz);
+			set_dyn_tick_max_skip((0xFFFFFFFF /
+				(cpu_khz * 1000)) * HZ);
 			return 0;
 		}
 	}
Index: linux-2.6.15-rc1-dt/drivers/acpi/Kconfig
===================================================================
--- linux-2.6.15-rc1-dt.orig/drivers/acpi/Kconfig
+++ linux-2.6.15-rc1-dt/drivers/acpi/Kconfig
@@ -302,6 +302,8 @@ config X86_PM_TIMER
 	  voltage scaling, unlike the commonly used Time Stamp Counter
 	  (TSC) timing source.
 
+	  This timer is selected by dyntick (NO_IDLE_HZ).
+
 	  So, if you see messages like 'Losing too many ticks!' in the
 	  kernel logs, and/or you are using this on a notebook which
 	  does not yet have an HPET, you should say "Y" here.
Index: linux-2.6.15-rc1-dt/include/asm-i386/apic.h
===================================================================
--- linux-2.6.15-rc1-dt.orig/include/asm-i386/apic.h
+++ linux-2.6.15-rc1-dt/include/asm-i386/apic.h
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
 
Index: linux-2.6.15-rc1-dt/include/asm-i386/dyn-tick.h
===================================================================
--- /dev/null
+++ linux-2.6.15-rc1-dt/include/asm-i386/dyn-tick.h
@@ -0,0 +1,96 @@
+/*
+ * linux/include/asm-i386/dyn-tick.h
+ *
+ * Copyright (C) 2004 Nokia Corporation
+ * Written by Tony Lindgen <tony@atomide.com> and
+ * Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
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
+extern void cpufreq_delayed_get(void);
+
+#ifdef CONFIG_NO_IDLE_HZ
+extern void setup_dyn_tick_use_apic(unsigned int calibration_result);
+extern void dyn_tick_interrupt(int irq, struct pt_regs *regs);
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
+#define IOAPIC_EDGE_TYPE_IRQ0 (&(ioapic_edge_type_irq0))
+
+extern struct hw_interrupt_type ioapic_edge_type_irq0;
+
+extern void idle_reprogram_timer(void);
+
+static inline void tsc_sanity_check(int *lost_count)
+{
+}
+
+#else /* CONFIG_NO_IDLE_HZ */
+
+#define IOAPIC_EDGE_TYPE_IRQ0 (&(ioapic_edge_type))
+
+static inline void setup_dyn_tick_use_apic(unsigned int calibration_result)
+{
+}
+
+static inline void dyn_tick_interrupt(int irq, struct pt_regs *regs)
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
+static inline void tsc_sanity_check(int *lost_count)
+{
+	/* sanity check to ensure we're not always losing ticks */
+	if ((*lost_count)++ > 100) {
+		printk(KERN_WARNING "Losing too many ticks!\n");
+		printk(KERN_WARNING "TSC cannot be used as a timesource.  \n");
+		printk(KERN_WARNING "Possible reasons for this are:\n");
+		printk(KERN_WARNING "  You're running with Speedstep,\n");
+		printk(KERN_WARNING "  You don't have DMA enabled for your hard disk (see hdparm),\n");
+		printk(KERN_WARNING "  Incorrect TSC synchronization on an SMP system (see dmesg).\n");
+		printk(KERN_WARNING "Falling back to a sane timesource now.\n");
+
+		clock_fallback();
+	}
+	/* ... but give the TSC a fair chance */
+	if (*lost_count > 25)
+		cpufreq_delayed_get();
+}
+#endif /* CONFIG_NO_IDLE_HZ */
+
+#endif /* _ASM_I386_DYN_TICK_H_ */
Index: linux-2.6.15-rc1-dt/include/asm-i386/timer.h
===================================================================
--- linux-2.6.15-rc1-dt.orig/include/asm-i386/timer.h
+++ linux-2.6.15-rc1-dt/include/asm-i386/timer.h
@@ -19,7 +19,7 @@
  */
 struct timer_opts {
 	char* name;
-	void (*mark_offset)(void);
+	int (*mark_offset)(void);
 	unsigned long (*get_offset)(void);
 	unsigned long long (*monotonic_clock)(void);
 	void (*delay)(unsigned long);
@@ -38,6 +38,9 @@ struct init_timer_opts {
 extern struct timer_opts* __init select_timer(void);
 extern void clock_fallback(void);
 void setup_pit_timer(void);
+extern void disable_pit_timer(void);
+extern void enable_pit_timer(void);
+extern void reprogram_pit_timer(unsigned long jiffies_to_skip);
 
 /* Modifiers for buggy PIT handling */
 
Index: linux-2.6.15-rc1-dt/include/linux/dyn-tick.h
===================================================================
--- /dev/null
+++ linux-2.6.15-rc1-dt/include/linux/dyn-tick.h
@@ -0,0 +1,64 @@
+/*
+ * linux/include/linux/dyn-tick.h
+ *
+ * Copyright (C) 2004 Nokia Corporation
+ * Written by Tony Lindgen <tony@atomide.com> and
+ * Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
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
Index: linux-2.6.15-rc1-dt/include/linux/timer.h
===================================================================
--- linux-2.6.15-rc1-dt.orig/include/linux/timer.h
+++ linux-2.6.15-rc1-dt/include/linux/timer.h
@@ -97,5 +97,6 @@ static inline void add_timer(struct time
 extern void init_timers(void);
 extern void run_local_timers(void);
 extern void it_real_fn(unsigned long);
+extern void conditional_run_local_timers(void);
 
 #endif
Index: linux-2.6.15-rc1-dt/kernel/dyn-tick.c
===================================================================
--- /dev/null
+++ linux-2.6.15-rc1-dt/kernel/dyn-tick.c
@@ -0,0 +1,190 @@
+/*
+ * linux/kernel/dyn-tick.c
+ *
+ * Beginnings of generic dynamic tick timer support
+ *
+ * Copyright (C) 2004 Nokia Corporation
+ * Written by Tony Lindgen <tony@atomide.com> and
+ * Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
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
+#define DYN_TICK_VERSION	"051118-1"
+
+int dyn_tick_enabled(void)
+{
+	return (dyn_tick->state & DYN_TICK_ENABLED);
+}
+
+static inline int dyn_tick_suitable(void)
+{
+	return (dyn_tick->state & DYN_TICK_SUITABLE);
+}
+
+/*
+ * Arch independent code needed to reprogram next timer interrupt.
+ * Gets called, with IRQs disabled, from cpu_idle() before entering idle loop.
+ */
+void timer_dyn_reprogram(void)
+{
+	int cpu = smp_processor_id();
+	unsigned int delta;
+
+	if (!dyn_tick_enabled())
+		return;
+
+	if (rcu_pending(cpu) || local_softirq_pending())
+		return;
+
+	/* Check if we can start skipping ticks */
+	write_seqlock(&xtime_lock);
+
+	delta = next_timer_interrupt() - jiffies;
+	if (delta > dyn_tick->max_skip)
+		delta = dyn_tick->max_skip;
+
+	if (delta > dyn_tick->min_skip) {
+		int idle_time = 0;
+
+		spin_lock(dyn_tick_lock);
+
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
+ * We need to initialize dynamic tick after calibrate delay
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
+	return ret;
+}
+
+late_initcall(dyn_tick_late_init);
Index: linux-2.6.15-rc1-dt/kernel/timer.c
===================================================================
--- linux-2.6.15-rc1-dt.orig/kernel/timer.c
+++ linux-2.6.15-rc1-dt/kernel/timer.c
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
Index: linux-2.6.15-rc1-dt/kernel/Makefile
===================================================================
--- linux-2.6.15-rc1-dt.orig/kernel/Makefile
+++ linux-2.6.15-rc1-dt/kernel/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
 obj-$(CONFIG_CRASH_DUMP) += crash_dump.o
 obj-$(CONFIG_SECCOMP) += seccomp.o
 obj-$(CONFIG_RCU_TORTURE_TEST) += rcutorture.o
+obj-$(CONFIG_NO_IDLE_HZ) += dyn-tick.o
 
 ifneq ($(CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
Index: linux-2.6.15-rc1-dt/arch/i386/kernel/timers/timer_cyclone.c
===================================================================
--- linux-2.6.15-rc1-dt.orig/arch/i386/kernel/timers/timer_cyclone.c
+++ linux-2.6.15-rc1-dt/arch/i386/kernel/timers/timer_cyclone.c
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
+	return 1;
 }
 
 static unsigned long get_offset_cyclone(void)
Index: linux-2.6.15-rc1-dt/arch/i386/kernel/timers/timer_hpet.c
===================================================================
--- linux-2.6.15-rc1-dt.orig/arch/i386/kernel/timers/timer_hpet.c
+++ linux-2.6.15-rc1-dt/arch/i386/kernel/timers/timer_hpet.c
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
Index: linux-2.6.15-rc1-dt/arch/i386/kernel/timers/timer_none.c
===================================================================
--- linux-2.6.15-rc1-dt.orig/arch/i386/kernel/timers/timer_none.c
+++ linux-2.6.15-rc1-dt/arch/i386/kernel/timers/timer_none.c
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

--Boundary-00=_zdcfDXDG0PWYKGo--
