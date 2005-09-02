Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751493AbVIBPob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbVIBPob (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 11:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbVIBPob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 11:44:31 -0400
Received: from mail28.syd.optusnet.com.au ([211.29.133.169]:35524 "EHLO
	mail28.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751493AbVIBPoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 11:44:30 -0400
From: Con Kolivas <kernel@kolivas.org>
To: vatsa@in.ibm.com
Subject: [PATCH 1/3] dynticks - implement no idle hz for x86
Date: Sat, 3 Sep 2005 01:43:57 +1000
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ck list <ck@vds.kolivas.org>
References: <20050831165843.GA4974@in.ibm.com> <20050831171211.GB4974@in.ibm.com>
In-Reply-To: <20050831171211.GB4974@in.ibm.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_9MHGDVTuDUbiSTu"
Message-Id: <200509030143.57782.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_9MHGDVTuDUbiSTu
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Ok I've resynced all the patches with 2.6.13-mm1, made some cleanups and minor 
modifications. As pm timer is the only supported timer for dynticks I've also 
made it depend on it.

A rollup patch against 2.6.13-mm1 is here:

http://ck.kolivas.org/patches/dyn-ticks/2.6.13-mm1-dtck1.patch

also available in the dyn-ticks directory are the older patches and these 
split out patches posted here.

Cheers,
Con
---



--Boundary-00=_9MHGDVTuDUbiSTu
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="dyntick.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="dyntick.patch"

This patch implements the no idle hz feature aka dynamic ticks for
i386 architecture. Work originally by Tony Lindgren <tony@atomide.com>
and Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>.

Modified for better smp scalability and accurate time by Srivatsa Vaddagiri
<vatsa@in.ibm.com>, with minor cleanups and modifications by Con Kolivas.

Signed-off-By: Con Kolivas <kernel@kolivas.org>

Index: linux-2.6.13-mm1/arch/i386/defconfig
===================================================================
--- linux-2.6.13-mm1.orig/arch/i386/defconfig	2005-09-02 23:57:29.000000000 +1000
+++ linux-2.6.13-mm1/arch/i386/defconfig	2005-09-02 23:57:33.000000000 +1000
@@ -91,6 +91,7 @@ CONFIG_X86_INTEL_USERCOPY=y
 CONFIG_X86_USE_PPRO_CHECKSUM=y
 # CONFIG_HPET_TIMER is not set
 # CONFIG_HPET_EMULATE_RTC is not set
+# CONFIG_NO_IDLE_HZ is not set
 CONFIG_SMP=y
 CONFIG_NR_CPUS=8
 CONFIG_SCHED_SMT=y
Index: linux-2.6.13-mm1/arch/i386/Kconfig
===================================================================
--- linux-2.6.13-mm1.orig/arch/i386/Kconfig	2005-09-02 23:57:29.000000000 +1000
+++ linux-2.6.13-mm1/arch/i386/Kconfig	2005-09-02 23:57:33.000000000 +1000
@@ -462,6 +462,21 @@ config HPET_EMULATE_RTC
 	depends on HPET_TIMER && RTC=y
 	default y
 
+config NO_IDLE_HZ
+	bool "Dynamic Tick Timer - Skip timer ticks during idle"
+	depends on EXPERIMENTAL && X86_PM_TIMER
+	help
+	  This option enables support for skipping timer ticks when the
+	  processor is idle. During system load, timer is continuous.
+	  This option saves power, as it allows the system to stay in
+	  idle mode longer. Currently supported timer is ACPI PM
+	  timer. TSC and HPET timers are currently not supported.
+
+	  Note that you can disable dynamic tick timer either by
+	  passing dyntick=disable command line option, or via sysfs:
+
+	  # echo 0 > /sys/devices/system/dyn_tick/dyn_tick0/enable
+
 config SMP
 	bool "Symmetric multi-processing support"
 	---help---
Index: linux-2.6.13-mm1/arch/i386/kernel/apic.c
===================================================================
--- linux-2.6.13-mm1.orig/arch/i386/kernel/apic.c	2005-09-02 23:57:29.000000000 +1000
+++ linux-2.6.13-mm1/arch/i386/kernel/apic.c	2005-09-02 23:57:33.000000000 +1000
@@ -27,6 +27,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/sysdev.h>
 #include <linux/cpu.h>
+#include <linux/dyn-tick.h>
 
 #include <asm/atomic.h>
 #include <asm/smp.h>
@@ -927,6 +928,8 @@ void (*wait_timer_tick)(void) __devinitd
 
 #define APIC_DIVISOR 16
 
+static u32 apic_timer_val;
+
 static void __setup_APIC_LVTT(unsigned int clocks)
 {
 	unsigned int lvtt_value, tmp_value, ver;
@@ -945,7 +948,9 @@ static void __setup_APIC_LVTT(unsigned i
 				& ~(APIC_TDR_DIV_1 | APIC_TDR_DIV_TMBASE))
 				| APIC_TDR_DIV_16);
 
-	apic_write_around(APIC_TMICT, clocks/APIC_DIVISOR);
+	apic_timer_val = clocks / APIC_DIVISOR;
+
+	apic_write_around(APIC_TMICT, apic_timer_val);
 }
 
 static void __devinit setup_APIC_timer(unsigned int clocks)
@@ -964,6 +969,21 @@ static void __devinit setup_APIC_timer(u
 	local_irq_restore(flags);
 }
 
+/* Used by NO_IDLE_HZ to skip ticks on idle CPUs */
+void reprogram_apic_timer(unsigned int count)
+{
+	unsigned long flags;
+
+	/*
+	 * FIXME: Make count more accurate. Otherwise can lead
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
@@ -1058,6 +1078,10 @@ void __init setup_boot_APIC_clock(void)
 	 */
 	setup_APIC_timer(calibration_result);
 
+	setup_dyn_tick_use_apic(calibration_result);
+	set_dyn_tick_max_skip((0xFFFFFFFF / calibration_result) *
+		APIC_DIVISOR);
+
 	local_irq_enable();
 }
 
@@ -1196,6 +1220,9 @@ fastcall void smp_apic_timer_interrupt(s
 	 * interrupt lock, which is the WrongThing (tm) to do.
 	 */
 	irq_enter();
+
+	dyn_tick_interrupt(LOCAL_TIMER_VECTOR, regs);
+
 	smp_local_timer_interrupt(regs);
 	irq_exit();
 }
@@ -1208,6 +1235,9 @@ fastcall void smp_spurious_interrupt(str
 	unsigned long v;
 
 	irq_enter();
+
+	dyn_tick_interrupt(SPURIOUS_APIC_VECTOR, regs);
+
 	/*
 	 * Check if this really is a spurious interrupt and ACK it
 	 * if it is a vectored one.  Just in case...
@@ -1232,6 +1262,9 @@ fastcall void smp_error_interrupt(struct
 	unsigned long v, v1;
 
 	irq_enter();
+
+	dyn_tick_interrupt(ERROR_APIC_VECTOR, regs);
+
 	/* First tickle the hardware, only then report what went on. -- REW */
 	v = apic_read(APIC_ESR);
 	apic_write(APIC_ESR, 0);
Index: linux-2.6.13-mm1/arch/i386/kernel/dyn-tick.c
===================================================================
--- linux-2.6.13-mm1.orig/arch/i386/kernel/dyn-tick.c	2005-01-12 16:19:45.000000000 +1100
+++ linux-2.6.13-mm1/arch/i386/kernel/dyn-tick.c	2005-09-03 01:11:54.000000000 +1000
@@ -0,0 +1,132 @@
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
+static void arch_reprogram_timer(unsigned long jif_next)
+{
+	unsigned int skip = jif_next - jiffies;
+
+	if (cpu_has_local_apic())
+		reprogram_apic_timer(skip);
+	else
+		reprogram_pit_timer(skip);
+
+	/* Fixme: Disable NMI Watchdog */
+}
+
+static void arch_all_cpus_idle(int how_long)
+{
+	if (cpu_has_local_apic())
+		disable_pit_timer();
+}
+
+static struct dyn_tick_timer arch_dyn_tick_timer = {
+	.arch_reprogram_timer	= &arch_reprogram_timer,
+	.arch_all_cpus_idle	= &arch_all_cpus_idle,
+};
+
+int __init dyn_tick_arch_init(void)
+{
+	if (!cpu_has_local_apic())
+		set_dyn_tick_max_skip(0xffff / LATCH);	/* PIT timer length */
+
+	printk(KERN_INFO "dyn-tick: Maximum ticks to skip limited to %i\n",
+		dyn_tick->max_skip);
+
+	return 0;
+}
+
+static int __init dyn_tick_init(void)
+{
+	arch_dyn_tick_timer.arch_init = dyn_tick_arch_init;
+	dyn_tick_register(&arch_dyn_tick_timer);
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
+		dyn_tick->arch_state |= DYN_TICK_APICABLE;
+	else {
+		dyn_tick->arch_state &= ~DYN_TICK_APICABLE;
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
+	spin_lock(&dyn_tick_lock);
+
+	if (cpus_equal(nohz_cpu_mask, cpu_online_map))
+		all_were_sleeping = 1;
+	cpu_clear(cpu, nohz_cpu_mask);
+
+	if (all_were_sleeping) {
+		/* Recover jiffies */
+		cur_timer->mark_offset();
+		if (cpu_has_local_apic())
+			enable_pit_timer();
+	}
+
+	spin_unlock(&dyn_tick_lock);
+
+	if (cpu_has_local_apic())
+		/* Fixme: Needs to be more accurate */
+		reprogram_apic_timer(1);
+	else
+		reprogram_pit_timer(1);
+
+	conditional_run_local_timers();
+
+	/* Fixme: Enable NMI watchdog */
+}
+
+
+void dyn_tick_time_init(struct timer_opts *cur_timer)
+{
+	spin_lock_init(&dyn_tick_lock);
+
+	if (strncmp(cur_timer->name, "pmtmr", 3) == 0) {
+		dyn_tick->state |= DYN_TICK_SUITABLE;
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
+		dyn_tick_reprogram_timer();
+	local_irq_enable();
+}
Index: linux-2.6.13-mm1/arch/i386/kernel/io_apic.c
===================================================================
--- linux-2.6.13-mm1.orig/arch/i386/kernel/io_apic.c	2005-09-02 23:57:29.000000000 +1000
+++ linux-2.6.13-mm1/arch/i386/kernel/io_apic.c	2005-09-03 00:54:58.000000000 +1000
@@ -33,6 +33,7 @@
 #include <linux/acpi.h>
 #include <linux/module.h>
 #include <linux/sysdev.h>
+#include <linux/dyn-tick.h>
 
 #include <asm/io.h>
 #include <asm/smp.h>
@@ -1159,15 +1160,19 @@ static inline void ioapic_register_intr(
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
@@ -1280,7 +1285,7 @@ static void __init setup_ExtINT_IRQ0_pin
 	 * The timer IRQ doesn't have to know that behind the
 	 * scene we have a 8259A-master in AEOI mode ...
 	 */
-	irq_desc[0].handler = &ioapic_edge_type;
+	irq_desc[0].handler = IOAPIC_EDGE_TYPE_IRQ0;
 
 	/*
 	 * Add it to the IO-APIC irq-routing table:
@@ -2015,6 +2020,20 @@ static struct hw_interrupt_type ioapic_l
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
Index: linux-2.6.13-mm1/arch/i386/kernel/irq.c
===================================================================
--- linux-2.6.13-mm1.orig/arch/i386/kernel/irq.c	2005-09-02 23:57:29.000000000 +1000
+++ linux-2.6.13-mm1/arch/i386/kernel/irq.c	2005-09-02 23:57:33.000000000 +1000
@@ -18,6 +18,7 @@
 #include <linux/notifier.h>
 #include <linux/cpu.h>
 #include <linux/delay.h>
+#include <linux/dyn-tick.h>
 
 DEFINE_PER_CPU(irq_cpustat_t, irq_stat) ____cacheline_maxaligned_in_smp;
 EXPORT_PER_CPU_SYMBOL(irq_stat);
@@ -79,6 +80,8 @@ fastcall unsigned int do_IRQ(struct pt_r
 	}
 #endif
 
+	dyn_tick_interrupt(irq, regs);
+
 #ifdef CONFIG_4KSTACKS
 
 	curctx = (union irq_ctx *) current_thread_info();
Index: linux-2.6.13-mm1/arch/i386/kernel/Makefile
===================================================================
--- linux-2.6.13-mm1.orig/arch/i386/kernel/Makefile	2005-09-02 23:57:29.000000000 +1000
+++ linux-2.6.13-mm1/arch/i386/kernel/Makefile	2005-09-02 23:57:33.000000000 +1000
@@ -33,6 +33,7 @@ obj-$(CONFIG_MODULES)		+= module.o
 obj-y				+= sysenter.o vsyscall.o
 obj-$(CONFIG_ACPI_SRAT) 	+= srat.o
 obj-$(CONFIG_HPET_TIMER) 	+= time_hpet.o
+obj-$(CONFIG_NO_IDLE_HZ) 	+= dyn-tick.o
 obj-$(CONFIG_EFI) 		+= efi.o efi_stub.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
Index: linux-2.6.13-mm1/arch/i386/kernel/process.c
===================================================================
--- linux-2.6.13-mm1.orig/arch/i386/kernel/process.c	2005-09-02 23:57:29.000000000 +1000
+++ linux-2.6.13-mm1/arch/i386/kernel/process.c	2005-09-02 23:57:33.000000000 +1000
@@ -40,6 +40,7 @@
 #include <linux/ptrace.h>
 #include <linux/random.h>
 #include <linux/kprobes.h>
+#include <linux/dyn-tick.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -201,6 +202,8 @@ void cpu_idle(void)
 			if (cpu_is_offline(cpu))
 				play_dead();
 
+			idle_reprogram_timer();
+
 			__get_cpu_var(irq_stat).idle_timestamp = jiffies;
 			idle();
 		}
Index: linux-2.6.13-mm1/arch/i386/kernel/smp.c
===================================================================
--- linux-2.6.13-mm1.orig/arch/i386/kernel/smp.c	2005-09-02 23:57:29.000000000 +1000
+++ linux-2.6.13-mm1/arch/i386/kernel/smp.c	2005-09-02 23:57:33.000000000 +1000
@@ -21,6 +21,7 @@
 #include <linux/interrupt.h>
 #include <linux/cpu.h>
 #include <linux/module.h>
+#include <linux/dyn-tick.h>
 
 #include <asm/nmi.h>
 #include <asm/mtrr.h>
@@ -315,6 +316,8 @@ fastcall void smp_invalidate_interrupt(s
 {
 	unsigned long cpu;
 
+	dyn_tick_interrupt(INVALIDATE_TLB_VECTOR, regs);
+
 	cpu = get_cpu();
 
 	if (!cpu_isset(cpu, flush_cpumask))
@@ -695,6 +698,8 @@ void smp_send_stop(void)
 fastcall void smp_reschedule_interrupt(struct pt_regs *regs)
 {
 	ack_APIC_irq();
+
+	dyn_tick_interrupt(RESCHEDULE_VECTOR, regs);
 }
 
 fastcall void smp_call_function_interrupt(struct pt_regs *regs)
@@ -704,6 +709,9 @@ fastcall void smp_call_function_interrup
 	int wait = call_data->wait;
 
 	ack_APIC_irq();
+
+	dyn_tick_interrupt(CALL_FUNCTION_VECTOR, regs);
+
 	/*
 	 * Notify initiating CPU that I've grabbed the data and am
 	 * about to execute the function
Index: linux-2.6.13-mm1/arch/i386/kernel/time.c
===================================================================
--- linux-2.6.13-mm1.orig/arch/i386/kernel/time.c	2005-09-02 23:57:29.000000000 +1000
+++ linux-2.6.13-mm1/arch/i386/kernel/time.c	2005-09-03 01:11:54.000000000 +1000
@@ -46,6 +46,7 @@
 #include <linux/bcd.h>
 #include <linux/efi.h>
 #include <linux/mca.h>
+#include <linux/dyn-tick.h>
 
 #include <asm/io.h>
 #include <asm/smp.h>
@@ -429,7 +430,7 @@ static struct sysdev_class timer_sysclas
 
 
 /* XXX this driverfs stuff should probably go elsewhere later -john */
-static struct sys_device device_timer = {
+struct sys_device device_timer = {
 	.id	= 0,
 	.cls	= &timer_sysclass,
 };
@@ -485,5 +486,7 @@ void __init time_init(void)
 	cur_timer = select_timer();
 	printk(KERN_INFO "Using %s for high-res timesource\n",cur_timer->name);
 
+	dyn_tick_time_init(cur_timer);
+
 	time_init_hook();
 }
Index: linux-2.6.13-mm1/arch/i386/kernel/timers/timer_pit.c
===================================================================
--- linux-2.6.13-mm1.orig/arch/i386/kernel/timers/timer_pit.c	2005-09-02 23:57:29.000000000 +1000
+++ linux-2.6.13-mm1/arch/i386/kernel/timers/timer_pit.c	2005-09-03 01:11:54.000000000 +1000
@@ -148,6 +148,38 @@ static unsigned long get_offset_pit(void
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
+void reprogram_pit_timer(int jiffies_to_skip)
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
Index: linux-2.6.13-mm1/arch/i386/kernel/timers/timer_pm.c
===================================================================
--- linux-2.6.13-mm1.orig/arch/i386/kernel/timers/timer_pm.c	2005-09-02 23:57:29.000000000 +1000
+++ linux-2.6.13-mm1/arch/i386/kernel/timers/timer_pm.c	2005-09-03 01:11:55.000000000 +1000
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/init.h>
+#include <linux/dyn-tick.h>
 #include <asm/types.h>
 #include <asm/timer.h>
 #include <asm/smp.h>
@@ -128,6 +129,7 @@ pm_good:
 		return -ENODEV;
 
 	init_cpu_khz();
+	set_dyn_tick_max_skip((0xFFFFFF / (286 * 1000000)) * 1024 * HZ);
 	return 0;
 }
 
Index: linux-2.6.13-mm1/arch/i386/kernel/timers/timer_tsc.c
===================================================================
--- linux-2.6.13-mm1.orig/arch/i386/kernel/timers/timer_tsc.c	2005-09-02 23:57:29.000000000 +1000
+++ linux-2.6.13-mm1/arch/i386/kernel/timers/timer_tsc.c	2005-09-03 01:11:54.000000000 +1000
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
@@ -166,10 +165,19 @@ static void delay_tsc(unsigned long loop
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
 static void mark_offset_tsc_hpet(void)
 {
-	unsigned long long this_offset, last_offset;
+	unsigned long long last_offset;
  	unsigned long offset, temp, hpet_current;
 
 	write_seqlock(&monotonic_lock);
@@ -197,9 +205,7 @@ static void mark_offset_tsc_hpet(void)
 	}
 	hpet_last = hpet_current;
 
-	/* update the monotonic base value */
-	this_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
-	monotonic_base += cycles_2_ns(this_offset - last_offset);
+	update_monotonic_base(last_offset);
 	write_sequnlock(&monotonic_lock);
 
 	/* calculate delay_at_last_interrupt */
@@ -237,7 +243,7 @@ static void handle_cpufreq_delayed_get(v
  * to verify the CPU frequency the timing core thinks the CPU is running
  * at is still correct.
  */
-static inline void cpufreq_delayed_get(void) 
+void cpufreq_delayed_get(void)
 {
 	if (cpufreq_init && !cpufreq_delayed_issched) {
 		cpufreq_delayed_issched = 1;
@@ -316,7 +322,7 @@ static int __init cpufreq_tsc(void)
 core_initcall(cpufreq_tsc);
 
 #else /* CONFIG_CPU_FREQ */
-static inline void cpufreq_delayed_get(void) { return; }
+void cpufreq_delayed_get(void) { return; }
 #endif 
 
 int recalibrate_cpu_khz(void)
@@ -346,8 +352,8 @@ static void mark_offset_tsc(void)
 	int count;
 	int countmp;
 	static int count1 = 0;
-	unsigned long long this_offset, last_offset;
-	static int lost_count = 0;
+	unsigned long long last_offset;
+	int lost_count = 0;
 
 	write_seqlock(&monotonic_lock);
 	last_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
@@ -417,26 +423,11 @@ static void mark_offset_tsc(void)
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
@@ -537,6 +528,9 @@ static int __init init_tsc(char* overrid
 					cpu_khz / 1000, cpu_khz % 1000);
 			}
 			set_cyc2ns_scale(cpu_khz/1000);
+			/* FIXME: Make use of 64-bit TSC to recover jiffies */
+			set_dyn_tick_max_skip((0xFFFFFFFF /
+				(cpu_khz * 1000)) * HZ);
 			return 0;
 		}
 	}
Index: linux-2.6.13-mm1/drivers/acpi/Kconfig
===================================================================
--- linux-2.6.13-mm1.orig/drivers/acpi/Kconfig	2005-09-02 23:57:29.000000000 +1000
+++ linux-2.6.13-mm1/drivers/acpi/Kconfig	2005-09-02 23:57:33.000000000 +1000
@@ -302,6 +302,8 @@ config X86_PM_TIMER
 	  like aggressive processor idling, throttling, frequency and/or
 	  voltage scaling, unlike the commonly used Time Stamp Counter
 	  (TSC) timing source.
+	  
+	  This timer is required by dyntick (NO_IDLE_HZ).
 
 	  So, if you see messages like 'Losing too many ticks!' in the
 	  kernel logs, and/or you are using this on a notebook which
Index: linux-2.6.13-mm1/include/asm-i386/apic.h
===================================================================
--- linux-2.6.13-mm1.orig/include/asm-i386/apic.h	2005-09-02 23:57:29.000000000 +1000
+++ linux-2.6.13-mm1/include/asm-i386/apic.h	2005-09-02 23:57:33.000000000 +1000
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
 
Index: linux-2.6.13-mm1/include/asm-i386/dyn-tick.h
===================================================================
--- linux-2.6.13-mm1.orig/include/asm-i386/dyn-tick.h	2005-01-12 16:19:45.000000000 +1100
+++ linux-2.6.13-mm1/include/asm-i386/dyn-tick.h	2005-09-03 01:12:03.000000000 +1000
@@ -0,0 +1,91 @@
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
+#define DYN_TICK_APICABLE	(1 << 0)
+
+#if (defined(CONFIG_SMP) || defined(CONFIG_X86_UP_APIC))
+static inline int cpu_has_local_apic(void)
+{
+	return (dyn_tick->arch_state & DYN_TICK_APICABLE);
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
Index: linux-2.6.13-mm1/include/asm-i386/timer.h
===================================================================
--- linux-2.6.13-mm1.orig/include/asm-i386/timer.h	2005-09-02 23:57:29.000000000 +1000
+++ linux-2.6.13-mm1/include/asm-i386/timer.h	2005-09-03 01:11:54.000000000 +1000
@@ -38,6 +38,9 @@ struct init_timer_opts {
 extern struct timer_opts* __init select_timer(void);
 extern void clock_fallback(void);
 void setup_pit_timer(void);
+extern void disable_pit_timer(void);
+extern void enable_pit_timer(void);
+extern void reprogram_pit_timer(int jiffies_to_skip);
 
 /* Modifiers for buggy PIT handling */
 
Index: linux-2.6.13-mm1/include/linux/dyn-tick.h
===================================================================
--- linux-2.6.13-mm1.orig/include/linux/dyn-tick.h	2005-01-12 16:19:45.000000000 +1100
+++ linux-2.6.13-mm1/include/linux/dyn-tick.h	2005-09-03 01:00:51.000000000 +1000
@@ -0,0 +1,70 @@
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
+#define DYN_TICK_ENABLED	(1 << 1)
+#define DYN_TICK_SUITABLE	(1 << 0)
+
+#define DYN_TICK_MIN_SKIP	2
+
+struct dyn_tick_state {
+	unsigned short state;		/* Current state */
+	unsigned short arch_state;	/* Arch-specific state */
+	unsigned int max_skip;		/* Max number of ticks to skip */
+};
+
+struct dyn_tick_timer {
+	int (*arch_init) (void);
+	void (*arch_enable) (void);
+	void (*arch_disable) (void);
+	void (*arch_reprogram_timer) (unsigned long);
+	void (*arch_all_cpus_idle) (int);
+};
+
+extern struct dyn_tick_state *dyn_tick;
+extern spinlock_t dyn_tick_lock;
+extern void dyn_tick_register(struct dyn_tick_timer *new_timer);
+
+#ifdef CONFIG_NO_IDLE_HZ
+extern unsigned int dyn_tick_reprogram_timer(void);
+extern void set_dyn_tick_max_skip(unsigned int max_skip);
+
+static inline int dyn_tick_enabled(void)
+{
+	return (dyn_tick->state & DYN_TICK_ENABLED);
+}
+
+#else	/* CONFIG_NO_IDLE_HZ */
+static inline unsigned int dyn_tick_reprogram_timer(void)
+{
+	return 0;
+}
+
+static inline void set_dyn_tick_max_skip(unsigned int max_skip)
+{
+}
+
+static inline int dyn_tick_enabled(void)
+{
+	return 0;
+}
+#endif	/* CONFIG_NO_IDLE_HZ */
+
+/* Pick up arch specific header */
+#include <asm/dyn-tick.h>
+
+#endif	/* _DYN_TICK_TIMER_H */
Index: linux-2.6.13-mm1/include/linux/timer.h
===================================================================
--- linux-2.6.13-mm1.orig/include/linux/timer.h	2005-09-02 23:57:29.000000000 +1000
+++ linux-2.6.13-mm1/include/linux/timer.h	2005-09-03 00:22:21.000000000 +1000
@@ -91,6 +91,7 @@ static inline void add_timer(struct time
 
 extern void init_timers(void);
 extern void run_local_timers(void);
+extern void conditional_run_local_timers(void);
 extern void it_real_fn(unsigned long);
 
 #endif
Index: linux-2.6.13-mm1/kernel/dyn-tick.c
===================================================================
--- linux-2.6.13-mm1.orig/kernel/dyn-tick.c	2005-01-12 16:19:45.000000000 +1100
+++ linux-2.6.13-mm1/kernel/dyn-tick.c	2005-09-03 00:22:44.000000000 +1000
@@ -0,0 +1,222 @@
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
+#define DYN_TICK_VERSION	"050610-1"
+#define DYN_TICK_IS_SET(x)	((dyn_tick->state & (x)) == (x))
+
+static struct dyn_tick_state dyn_tick_state;
+struct dyn_tick_state *dyn_tick = &dyn_tick_state;
+static struct dyn_tick_timer *dyn_tick_cfg;
+spinlock_t dyn_tick_lock;
+
+/*
+ * Arch independent code needed to reprogram next timer interrupt.
+ * Gets called, with IRQs disabled, from cpu_idle() before entering idle loop.
+ */
+unsigned int dyn_tick_reprogram_timer(void)
+{
+	int cpu = smp_processor_id();
+	unsigned int delta;
+
+	if (!DYN_TICK_IS_SET(DYN_TICK_ENABLED))
+		return 0;
+
+	if (rcu_pending(cpu) || local_softirq_pending())
+		return 0;
+
+	/* Check if we can start skipping ticks */
+	write_seqlock(&xtime_lock);
+
+	delta = next_timer_interrupt() - jiffies;
+	if (delta > dyn_tick->max_skip)
+		delta = dyn_tick->max_skip;
+
+	if (delta > DYN_TICK_MIN_SKIP) {
+		int idle_time = 0;
+
+		spin_lock(&dyn_tick_lock);
+
+		dyn_tick_cfg->arch_reprogram_timer(jiffies + delta);
+
+		cpu_set(cpu, nohz_cpu_mask);
+		if (cpus_equal(nohz_cpu_mask, cpu_online_map))
+			/* Fixme: idle_time needs to be computed */
+			dyn_tick_cfg->arch_all_cpus_idle(idle_time);
+
+		spin_unlock(&dyn_tick_lock);
+
+	} else
+		delta = 0;
+
+	write_sequnlock(&xtime_lock);
+
+	return delta;
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
+	dyn_tick_cfg = arch_timer;
+	printk(KERN_INFO "dyn-tick: Registering dynamic tick timer v%s\n",
+	       DYN_TICK_VERSION);
+}
+
+/*
+ * ---------------------------------------------------------------------------
+ * Command line options
+ * ---------------------------------------------------------------------------
+ */
+static int __initdata dyntick_autoenable = 1;
+
+/*
+ * dyntick=[disable]
+ */ 
+static int __init dyntick_setup(char *options)
+{
+	if (!options)
+		return 0;
+
+	if (!strncmp(options, "disable", 6))
+		dyntick_autoenable = 0;
+
+	return 0;
+}
+
+__setup("dyntick=", dyntick_setup);
+
+/*
+ * ---------------------------------------------------------------------------
+ * Sysfs interface
+ * ---------------------------------------------------------------------------
+ */
+
+extern struct sys_device device_timer;
+
+static ssize_t show_dyn_tick_state(struct sys_device *dev, char *buf)
+{
+	return sprintf(buf,
+		       "suitable:\t%i\n"
+		       "enabled:\t%i\n",
+		       DYN_TICK_IS_SET(DYN_TICK_SUITABLE),
+		       DYN_TICK_IS_SET(DYN_TICK_ENABLED));
+}
+
+static ssize_t show_dyn_tick_enable(struct sys_device *dev, char *buf)
+{
+	return sprintf(buf, "enabled:\t%i\n",
+		DYN_TICK_IS_SET(DYN_TICK_ENABLED));
+}
+
+static ssize_t set_dyn_tick_enable(struct sys_device *dev, const char *buf,
+				   size_t count)
+{
+	unsigned long flags;
+	unsigned int enable = simple_strtoul(buf, NULL, 2);
+
+	write_seqlock_irqsave(&xtime_lock, flags);
+	if (enable) {
+		if (dyn_tick_cfg->arch_enable)
+			dyn_tick_cfg->arch_enable();
+		dyn_tick->state |= DYN_TICK_ENABLED;
+	} else {
+		if (dyn_tick_cfg->arch_disable)
+			dyn_tick_cfg->arch_disable();
+		dyn_tick->state &= ~DYN_TICK_ENABLED;
+	}
+	write_sequnlock_irqrestore(&xtime_lock, flags);
+
+	return count;
+}
+
+static SYSDEV_ATTR(state, 0444, show_dyn_tick_state, NULL);
+static SYSDEV_ATTR(enable, 0644, show_dyn_tick_enable,
+		   set_dyn_tick_enable);
+
+static struct sysdev_class dyn_tick_sysclass = {
+	set_kset_name("dyn_tick"),
+};
+
+static struct sys_device device_dyn_tick = {
+	.id = 0,
+	.cls = &dyn_tick_sysclass,
+};
+
+static int init_dyn_tick_sysfs(void)
+{
+	int error = 0;
+	if ((error = sysdev_class_register(&dyn_tick_sysclass)))
+		goto out;
+	if ((error = sysdev_register(&device_dyn_tick)))
+		goto out;
+	if ((error = sysdev_create_file(&device_dyn_tick, &attr_state)))
+		goto out;
+	error = sysdev_create_file(&device_dyn_tick, &attr_enable);
+
+out:
+	return error;
+}
+
+device_initcall(init_dyn_tick_sysfs);
+
+/*
+ * ---------------------------------------------------------------------------
+ * Init functions
+ * ---------------------------------------------------------------------------
+ */
+
+/*
+ * We need to initialize dynamic tick after calibrate delay
+ */
+static int __init dyn_tick_late_init(void)
+{
+	int ret = 0;
+
+	if (dyn_tick_cfg == NULL || dyn_tick_cfg->arch_init == NULL ||
+	    !DYN_TICK_IS_SET(DYN_TICK_SUITABLE)) {
+		printk(KERN_ERR "dyn-tick: No suitable timer found\n");
+		return -ENODEV;
+	}
+
+	if ((ret = dyn_tick_cfg->arch_init())) {
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
Index: linux-2.6.13-mm1/kernel/Makefile
===================================================================
--- linux-2.6.13-mm1.orig/kernel/Makefile	2005-09-02 23:57:29.000000000 +1000
+++ linux-2.6.13-mm1/kernel/Makefile	2005-09-02 23:57:33.000000000 +1000
@@ -32,6 +32,7 @@ obj-$(CONFIG_DETECT_SOFTLOCKUP) += softl
 obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
 obj-$(CONFIG_CRASH_DUMP) += crash_dump.o
 obj-$(CONFIG_SECCOMP) += seccomp.o
+obj-$(CONFIG_NO_IDLE_HZ) += dyn-tick.o
 
 ifneq ($(CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
Index: linux-2.6.13-mm1/kernel/timer.c
===================================================================
--- linux-2.6.13-mm1.orig/kernel/timer.c	2005-09-02 23:57:29.000000000 +1000
+++ linux-2.6.13-mm1/kernel/timer.c	2005-09-03 00:32:19.000000000 +1000
@@ -939,6 +939,13 @@ void run_local_timers(void)
 	}
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

--Boundary-00=_9MHGDVTuDUbiSTu--
