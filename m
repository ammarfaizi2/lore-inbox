Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbVKVL1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbVKVL1n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 06:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbVKVL1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 06:27:43 -0500
Received: from mail16.syd.optusnet.com.au ([211.29.132.197]:47766 "EHLO
	mail16.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750749AbVKVL1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 06:27:42 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] i386 No Idle Hz - aka Dynticks v051122-1
Date: Tue, 22 Nov 2005 22:26:36 +1100
User-Agent: KMail/1.8.3
Cc: ck list <ck@vds.kolivas.org>, Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>,
       Daniel Petrini <d.pensator@gmail.com>, Tony Lindgren <tony@atomide.com>,
       Adam Belay <abelay@novell.com>, trenn@suse.de
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1303658.B0tbJhkdnN";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200511222226.40854.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1303658.B0tbJhkdnN
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Here is an updated version of the dynticks patch for i386 built on 2.6.15-r=
c2.

Minor accounting errors were addressed hopefully fixing the per process cpu
statistics shown to userspace (top et al).
Some style changes as suggested by Zwane were attended to (thanks!).
Lock contention was improved slightly.
Minor optimisations.
Cleanups, documentation fixes.

The latest version of this code can always be found here:
http://ck.kolivas.org/patches/dyn-ticks/
including a copy of pmstats-0.3 by Tony Lindgren, and a bugfixed timer_top=
=20
script by Daniel Petrini which can be used to assess the effect of this pat=
ch
and to examine what timers are being used. To utilise the timer_top script
you must also patch with the timer_top patch in the split-out directory.

Here is a rolled up patch of the relevant necessary components of dynticks
v051122-1

Cheers,
Con
=2D--
Index: linux-2.6.15-rc2-dt/arch/i386/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15-rc2-dt.orig/arch/i386/Kconfig
+++ linux-2.6.15-rc2-dt/arch/i386/Kconfig
@@ -173,6 +173,22 @@ config HPET_EMULATE_RTC
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
 config SMP
 	bool "Symmetric multi-processing support"
 	---help---
Index: linux-2.6.15-rc2-dt/arch/i386/defconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15-rc2-dt.orig/arch/i386/defconfig
+++ linux-2.6.15-rc2-dt/arch/i386/defconfig
@@ -91,6 +91,7 @@ CONFIG_X86_INTEL_USERCOPY=3Dy
 CONFIG_X86_USE_PPRO_CHECKSUM=3Dy
 # CONFIG_HPET_TIMER is not set
 # CONFIG_HPET_EMULATE_RTC is not set
+# CONFIG_NO_IDLE_HZ is not set
 CONFIG_SMP=3Dy
 CONFIG_NR_CPUS=3D8
 CONFIG_SCHED_SMT=3Dy
Index: linux-2.6.15-rc2-dt/arch/i386/kernel/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15-rc2-dt.orig/arch/i386/kernel/Makefile
+++ linux-2.6.15-rc2-dt/arch/i386/kernel/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_MODULES)		+=3D module.o
 obj-y				+=3D sysenter.o vsyscall.o
 obj-$(CONFIG_ACPI_SRAT) 	+=3D srat.o
 obj-$(CONFIG_HPET_TIMER) 	+=3D time_hpet.o
+obj-$(CONFIG_NO_IDLE_HZ) 	+=3D dyn-tick.o
 obj-$(CONFIG_EFI) 		+=3D efi.o efi_stub.o
 obj-$(CONFIG_EARLY_PRINTK)	+=3D early_printk.o
=20
Index: linux-2.6.15-rc2-dt/arch/i386/kernel/apic.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15-rc2-dt.orig/arch/i386/kernel/apic.c
+++ linux-2.6.15-rc2-dt/arch/i386/kernel/apic.c
@@ -26,6 +26,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/sysdev.h>
 #include <linux/cpu.h>
+#include <linux/dyn-tick.h>
=20
 #include <asm/atomic.h>
 #include <asm/smp.h>
@@ -932,6 +933,9 @@ void (*wait_timer_tick)(void) __devinitd
=20
 #define APIC_DIVISOR 16
=20
+static u32 apic_timer_val __read_mostly;
+#define APIC_TIMER_VAL	((apic_timer_val) / (HZ))
+
 static void __setup_APIC_LVTT(unsigned int clocks)
 {
 	unsigned int lvtt_value, tmp_value, ver;
@@ -950,7 +954,9 @@ static void __setup_APIC_LVTT(unsigned i
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
@@ -969,6 +975,17 @@ static void __devinit setup_APIC_timer(u
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
@@ -1064,6 +1081,9 @@ void __init setup_boot_APIC_clock(void)
 	 */
 	setup_APIC_timer(calibration_result);
=20
+	setup_dyn_tick_use_apic(calibration_result);
+	set_dyn_tick_max_skip((0xFFFFFFFF / calibration_result) * APIC_DIVISOR);
+
 	local_irq_restore(flags);
 }
=20
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
=20
 	irq_enter();
+
+	dyn_tick_interrupt(regs);
+
 	/*
 	 * Check if this really is a spurious interrupt and ACK it
 	 * if it is a vectored one.  Just in case...
@@ -1238,6 +1264,9 @@ fastcall void smp_error_interrupt(struct
 	unsigned long v, v1;
=20
 	irq_enter();
+
+	dyn_tick_interrupt(regs);
+
 	/* First tickle the hardware, only then report what went on. -- REW */
 	v =3D apic_read(APIC_ESR);
 	apic_write(APIC_ESR, 0);
Index: linux-2.6.15-rc2-dt/arch/i386/kernel/dyn-tick.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- /dev/null
+++ linux-2.6.15-rc2-dt/arch/i386/kernel/dyn-tick.c
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
+	unsigned long skip =3D jif_next - jiffies;
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
+static struct dyn_tick_timer arch_dyn_tick =3D {
+	.arch_reprogram		=3D &arch_reprogram,
+	.arch_all_cpus_idle	=3D &arch_all_cpus_idle,
+	.arch_enable		=3D &arch_enable,
+	.arch_disable		=3D &arch_disable,
+	.min_skip		=3D DYN_TICK_MIN_SKIP,
+};
+
+struct dyn_tick_timer *dyn_tick =3D &arch_dyn_tick;
+spinlock_t *dyn_tick_lock =3D &arch_dyn_tick.lock;
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
+	arch_dyn_tick.arch_init =3D dyn_tick_arch_init;
+	dyn_tick_register(&arch_dyn_tick);
+
+	return 0;
+}
+
+arch_initcall(dyn_tick_init);
+
+/* Functions that need blank prototypes for !CONFIG_NO_IDLE_HZ below here =
*/
+void setup_dyn_tick_use_apic(unsigned int calibration_result)
+{
+	if (calibration_result)
+		arch_dyn_tick.state |=3D DYN_TICK_APICABLE;
+	else {
+		arch_dyn_tick.state &=3D ~DYN_TICK_APICABLE;
+		printk(KERN_INFO "dyn-tick: Cannot use local APIC\n");
+	}
+}
+
+void dyn_tick_interrupt(struct pt_regs *regs)
+{
+	int cpu =3D smp_processor_id();
+
+	if (!cpu_isset(cpu, nohz_cpu_mask))
+		return;
+
+	spin_lock(dyn_tick_lock);
+	if (cpus_equal(nohz_cpu_mask, cpu_online_map)) {
+		/* All were sleeping, recover jiffies */
+		int lost =3D cur_timer->mark_offset();
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
+	if (strncmp(cur_timer->name, "pmtmr", 3) =3D=3D 0) {
+		arch_dyn_tick.state |=3D DYN_TICK_SUITABLE;
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
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15-rc2-dt.orig/arch/i386/kernel/io_apic.c
+++ linux-2.6.15-rc2-dt/arch/i386/kernel/io_apic.c
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
Index: linux-2.6.15-rc2-dt/arch/i386/kernel/irq.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15-rc2-dt.orig/arch/i386/kernel/irq.c
+++ linux-2.6.15-rc2-dt/arch/i386/kernel/irq.c
@@ -18,6 +18,7 @@
 #include <linux/notifier.h>
 #include <linux/cpu.h>
 #include <linux/delay.h>
+#include <linux/dyn-tick.h>
=20
 DEFINE_PER_CPU(irq_cpustat_t, irq_stat) ____cacheline_maxaligned_in_smp;
 EXPORT_PER_CPU_SYMBOL(irq_stat);
@@ -76,6 +77,8 @@ fastcall unsigned int do_IRQ(struct pt_r
 	}
 #endif
=20
+	dyn_tick_interrupt(regs);
+
 #ifdef CONFIG_4KSTACKS
=20
 	curctx =3D (union irq_ctx *) current_thread_info();
Index: linux-2.6.15-rc2-dt/arch/i386/kernel/process.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15-rc2-dt.orig/arch/i386/kernel/process.c
+++ linux-2.6.15-rc2-dt/arch/i386/kernel/process.c
@@ -39,6 +39,7 @@
 #include <linux/ptrace.h>
 #include <linux/random.h>
 #include <linux/kprobes.h>
+#include <linux/dyn-tick.h>
=20
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -193,6 +194,8 @@ void cpu_idle(void)
 			if (cpu_is_offline(cpu))
 				play_dead();
=20
+			idle_reprogram_timer();
+
 			__get_cpu_var(irq_stat).idle_timestamp =3D jiffies;
 			idle();
 		}
Index: linux-2.6.15-rc2-dt/arch/i386/kernel/smp.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15-rc2-dt.orig/arch/i386/kernel/smp.c
+++ linux-2.6.15-rc2-dt/arch/i386/kernel/smp.c
@@ -20,6 +20,7 @@
 #include <linux/interrupt.h>
 #include <linux/cpu.h>
 #include <linux/module.h>
+#include <linux/dyn-tick.h>
=20
 #include <asm/mtrr.h>
 #include <asm/tlbflush.h>
@@ -313,6 +314,8 @@ fastcall void smp_invalidate_interrupt(s
 {
 	unsigned long cpu;
=20
+	dyn_tick_interrupt(regs);
+
 	cpu =3D get_cpu();
=20
 	if (!cpu_isset(cpu, flush_cpumask))
@@ -600,6 +603,8 @@ void smp_send_stop(void)
 fastcall void smp_reschedule_interrupt(struct pt_regs *regs)
 {
 	ack_APIC_irq();
+
+	dyn_tick_interrupt(regs);
 }
=20
 fastcall void smp_call_function_interrupt(struct pt_regs *regs)
@@ -609,6 +614,9 @@ fastcall void smp_call_function_interrup
 	int wait =3D call_data->wait;
=20
 	ack_APIC_irq();
+
+	dyn_tick_interrupt(regs);
+
 	/*
 	 * Notify initiating CPU that I've grabbed the data and am
 	 * about to execute the function
Index: linux-2.6.15-rc2-dt/arch/i386/kernel/time.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15-rc2-dt.orig/arch/i386/kernel/time.c
+++ linux-2.6.15-rc2-dt/arch/i386/kernel/time.c
@@ -46,6 +46,7 @@
 #include <linux/bcd.h>
 #include <linux/efi.h>
 #include <linux/mca.h>
+#include <linux/dyn-tick.h>
=20
 #include <asm/io.h>
 #include <asm/smp.h>
@@ -245,7 +246,7 @@ EXPORT_SYMBOL(profile_pc);
  * timer_interrupt() needs to keep up the real-time clock,
  * as well as call the "do_timer()" routine every clocktick
  */
=2Dstatic inline void do_timer_interrupt(int irq, struct pt_regs *regs)
+static inline void do_timer_interrupt(int irq, struct pt_regs *regs, int l=
ost)
 {
 #ifdef CONFIG_X86_IO_APIC
 	if (timer_ack) {
@@ -263,7 +264,8 @@ static inline void do_timer_interrupt(in
 	}
 #endif
=20
=2D	do_timer_interrupt_hook(regs);
+	if (!dyn_tick_enabled() || lost)
+		do_timer_interrupt_hook(regs);
=20
=20
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
@@ -425,7 +429,7 @@ static struct sysdev_class timer_sysclas
=20
=20
 /* XXX this driverfs stuff should probably go elsewhere later -john */
=2Dstatic struct sys_device device_timer =3D {
+struct sys_device device_timer =3D {
 	.id	=3D 0,
 	.cls	=3D &timer_sysclass,
 };
@@ -481,5 +485,7 @@ void __init time_init(void)
 	cur_timer =3D select_timer();
 	printk(KERN_INFO "Using %s for high-res timesource\n",cur_timer->name);
=20
+	dyn_tick_time_init(cur_timer);
+
 	time_init_hook();
 }
Index: linux-2.6.15-rc2-dt/arch/i386/kernel/timers/timer_pit.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15-rc2-dt.orig/arch/i386/kernel/timers/timer_pit.c
+++ linux-2.6.15-rc2-dt/arch/i386/kernel/timers/timer_pit.c
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
Index: linux-2.6.15-rc2-dt/arch/i386/kernel/timers/timer_pm.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15-rc2-dt.orig/arch/i386/kernel/timers/timer_pm.c
+++ linux-2.6.15-rc2-dt/arch/i386/kernel/timers/timer_pm.c
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
+	set_dyn_tick_max_skip(((0xFFFFFF / 1000000) * 286 * HZ) >> 10);
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
Index: linux-2.6.15-rc2-dt/arch/i386/kernel/timers/timer_tsc.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15-rc2-dt.orig/arch/i386/kernel/timers/timer_tsc.c
+++ linux-2.6.15-rc2-dt/arch/i386/kernel/timers/timer_tsc.c
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
@@ -344,15 +353,15 @@ int recalibrate_cpu_khz(void)
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
+	int lost_count =3D 0;
=20
 	write_seqlock(&monotonic_lock);
 	last_offset =3D ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
@@ -422,26 +431,11 @@ static void mark_offset_tsc(void)
 	if (lost >=3D 2) {
 		jiffies_64 +=3D lost-1;
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
+		tsc_sanity_check(&lost_count);
 	} else
 		lost_count =3D 0;
=2D	/* update the monotonic base value */
=2D	this_offset =3D ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
=2D	monotonic_base +=3D cycles_2_ns(this_offset - last_offset);
+
+	update_monotonic_base(last_offset);
 	write_sequnlock(&monotonic_lock);
=20
 	/* calculate delay_at_last_interrupt */
@@ -454,6 +448,8 @@ static void mark_offset_tsc(void)
 	 */
 	if (lost && abs(delay - delay_at_last_interrupt) > (900000/HZ))
 		jiffies_64++;
+
+	return lost;
 }
=20
 static int __init init_tsc(char* override)
@@ -542,6 +538,8 @@ static int __init init_tsc(char* overrid
 					cpu_khz / 1000, cpu_khz % 1000);
 			}
 			set_cyc2ns_scale(cpu_khz);
+			set_dyn_tick_max_skip((0xFFFFFFFF /
+				(cpu_khz * 1000)) * HZ);
 			return 0;
 		}
 	}
Index: linux-2.6.15-rc2-dt/drivers/acpi/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15-rc2-dt.orig/drivers/acpi/Kconfig
+++ linux-2.6.15-rc2-dt/drivers/acpi/Kconfig
@@ -302,6 +302,8 @@ config X86_PM_TIMER
 	  voltage scaling, unlike the commonly used Time Stamp Counter
 	  (TSC) timing source.
=20
+	  This timer is selected by dyntick (NO_IDLE_HZ).
+
 	  So, if you see messages like 'Losing too many ticks!' in the
 	  kernel logs, and/or you are using this on a notebook which
 	  does not yet have an HPET, you should say "Y" here.
Index: linux-2.6.15-rc2-dt/include/asm-i386/apic.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15-rc2-dt.orig/include/asm-i386/apic.h
+++ linux-2.6.15-rc2-dt/include/asm-i386/apic.h
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
Index: linux-2.6.15-rc2-dt/include/asm-i386/dyn-tick.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- /dev/null
+++ linux-2.6.15-rc2-dt/include/asm-i386/dyn-tick.h
@@ -0,0 +1,91 @@
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
+extern void cpufreq_delayed_get(void);
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
+static inline void tsc_sanity_check(int *lost_count)
+{
+}
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
+static inline void tsc_sanity_check(int *lost_count)
+{
+	/* sanity check to ensure we're not always losing ticks */
+	if ((*lost_count)++ > 100) {
+		printk(KERN_WARNING "Losing too many ticks!\n");
+		printk(KERN_WARNING "TSC cannot be used as a timesource.  \n");
+		printk(KERN_WARNING "Possible reasons for this are:\n");
+		printk(KERN_WARNING "  You're running with Speedstep,\n");
+		printk(KERN_WARNING "  You don't have DMA enabled for your hard disk (se=
e hdparm),\n");
+		printk(KERN_WARNING "  Incorrect TSC synchronization on an SMP system (s=
ee dmesg).\n");
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
Index: linux-2.6.15-rc2-dt/include/asm-i386/timer.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15-rc2-dt.orig/include/asm-i386/timer.h
+++ linux-2.6.15-rc2-dt/include/asm-i386/timer.h
@@ -19,7 +19,7 @@
  */
 struct timer_opts {
 	char* name;
=2D	void (*mark_offset)(void);
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
=20
 /* Modifiers for buggy PIT handling */
=20
Index: linux-2.6.15-rc2-dt/include/linux/dyn-tick.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- /dev/null
+++ linux-2.6.15-rc2-dt/include/linux/dyn-tick.h
@@ -0,0 +1,65 @@
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
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15-rc2-dt.orig/include/linux/timer.h
+++ linux-2.6.15-rc2-dt/include/linux/timer.h
@@ -97,5 +97,6 @@ static inline void add_timer(struct time
 extern void init_timers(void);
 extern void run_local_timers(void);
 extern void it_real_fn(unsigned long);
+extern void conditional_run_local_timers(void);
=20
 #endif
Index: linux-2.6.15-rc2-dt/kernel/dyn-tick.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- /dev/null
+++ linux-2.6.15-rc2-dt/kernel/dyn-tick.c
@@ -0,0 +1,197 @@
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
+#define DYN_TICK_VERSION	"051122-1"
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
+ * Gets called, with IRQs disabled, from cpu_idle() before entering idle l=
oop.
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
+	cpu =3D smp_processor_id();
+	if (rcu_pending(cpu) || local_softirq_pending())
+		return;
+
+	/* Check if we can start skipping ticks */
+	if (unlikely(!write_tryseqlock(&xtime_lock)))
+		return;
+
+	delta =3D next_timer_interrupt() - jiffies;
+	if (delta > dyn_tick->max_skip)
+		delta =3D dyn_tick->max_skip;
+
+	if (delta > dyn_tick->min_skip) {
+		int idle_time =3D 0;
+
+		if (unlikely(!spin_trylock(dyn_tick_lock)))
+			goto out_unlock;
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
+out_unlock:
+	write_sequnlock(&xtime_lock);
+}
+
+void set_dyn_tick_max_skip(unsigned int max_skip)
+{
+	if (!dyn_tick->max_skip || max_skip < dyn_tick->max_skip)
+		dyn_tick->max_skip =3D max_skip;
+}
+
+void __init dyn_tick_register(struct dyn_tick_timer *arch_timer)
+{
+	dyn_tick =3D arch_timer;
+	printk(KERN_INFO "dyn-tick: Registering dynamic tick timer v%s\n",
+	       DYN_TICK_VERSION);
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
+		if (ret =3D=3D 0)
+			dyn_tick->state |=3D DYN_TICK_ENABLED;
+	} else {
+		ret =3D dyn_tick->arch_disable();
+		if (ret =3D=3D 0)
+			dyn_tick->state &=3D ~DYN_TICK_ENABLED;
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
+	int ret =3D 0;
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
+		printk(KERN_INFO "dyn-tick: Timer using dynamic tick\n");
+	} else
+		printk(KERN_INFO "dyn-tick: Timer not enabled during boot\n");
+
+	return ret;
+}
+
+late_initcall(dyn_tick_late_init);
Index: linux-2.6.15-rc2-dt/kernel/timer.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15-rc2-dt.orig/kernel/timer.c
+++ linux-2.6.15-rc2-dt/kernel/timer.c
@@ -869,6 +869,13 @@ void run_local_timers(void)
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
Index: linux-2.6.15-rc2-dt/kernel/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15-rc2-dt.orig/kernel/Makefile
+++ linux-2.6.15-rc2-dt/kernel/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_GENERIC_HARDIRQS) +=3D irq/
 obj-$(CONFIG_CRASH_DUMP) +=3D crash_dump.o
 obj-$(CONFIG_SECCOMP) +=3D seccomp.o
 obj-$(CONFIG_RCU_TORTURE_TEST) +=3D rcutorture.o
+obj-$(CONFIG_NO_IDLE_HZ) +=3D dyn-tick.o
=20
 ifneq ($(CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-poi=
nter is
Index: linux-2.6.15-rc2-dt/arch/i386/kernel/timers/timer_cyclone.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15-rc2-dt.orig/arch/i386/kernel/timers/timer_cyclone.c
+++ linux-2.6.15-rc2-dt/arch/i386/kernel/timers/timer_cyclone.c
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
Index: linux-2.6.15-rc2-dt/arch/i386/kernel/timers/timer_hpet.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15-rc2-dt.orig/arch/i386/kernel/timers/timer_hpet.c
+++ linux-2.6.15-rc2-dt/arch/i386/kernel/timers/timer_hpet.c
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
Index: linux-2.6.15-rc2-dt/arch/i386/kernel/timers/timer_none.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15-rc2-dt.orig/arch/i386/kernel/timers/timer_none.c
+++ linux-2.6.15-rc2-dt/arch/i386/kernel/timers/timer_none.c
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

--nextPart1303658.B0tbJhkdnN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDgwBwZUg7+tp6mRURAo7sAJ9XgFApl5iFHpKAiVPwxIvhd+eO9QCfQJV/
67fNto7g4Mf42fd8okN3oKw=
=i2qp
-----END PGP SIGNATURE-----

--nextPart1303658.B0tbJhkdnN--
