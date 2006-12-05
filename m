Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759965AbWLELJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759965AbWLELJI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 06:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759953AbWLELI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 06:08:56 -0500
Received: from gundega.hpl.hp.com ([192.6.19.190]:59825 "EHLO
	gundega.hpl.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968118AbWLELHy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 06:07:54 -0500
Date: Tue, 5 Dec 2006 03:07:01 -0800
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200612051107.kB5B713s017467@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 01/21] 2.6.19 perfmon2: arch-specific infrastructure changes
Cc: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@frankl.hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the remaining infrastructure changes required
for perfmon2 for all architectures. It is expected that this patch
will shrink as new kernel version are released.

i386:
	- add idle notifier and related callback in interrupt handlers
	- add BTS and PEBS detection with cpufeature bits (integrated in 2.6.20)

ia64:
	- add idle notifier
	- use idle notifier mechanism for SGI front panel activity LED blinking
	- add some PMU related MSR definitions (integrated in 2.6.20)

x86-64:
	- fix interrupt handlers to call enter_idle() (unecessary in 2.6.20)
	- add BTS and PEBS detection with cpufeature bits (integrated in 2.6.20)
	- add some PMU related MSR definitions (integrated in 2.6.20)

all:
	- remove carta_random32.h header file (integrated in 2.6.20)





diff -urNp --exclude=.git linux-2.6.19.orig/arch/i386/kernel/apic.c linux-2.6.19.base/arch/i386/kernel/apic.c
--- linux-2.6.19.orig/arch/i386/kernel/apic.c	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.19.base/arch/i386/kernel/apic.c	2006-12-03 14:24:40.000000000 -0800
@@ -36,6 +36,7 @@
 #include <asm/hpet.h>
 #include <asm/i8253.h>
 #include <asm/nmi.h>
+#include <asm/idle.h>
 
 #include <mach_apic.h>
 #include <mach_apicdef.h>
@@ -1241,10 +1242,12 @@ fastcall void smp_apic_timer_interrupt(s
 	 * Besides, if we don't timer interrupts ignore the global
 	 * interrupt lock, which is the WrongThing (tm) to do.
 	 */
+	exit_idle();
 	irq_enter();
 	smp_local_timer_interrupt();
 	irq_exit();
 	set_irq_regs(old_regs);
+	enter_idle();
 }
 
 #ifndef CONFIG_SMP
@@ -1291,6 +1294,7 @@ fastcall void smp_spurious_interrupt(str
 {
 	unsigned long v;
 
+	exit_idle();
 	irq_enter();
 	/*
 	 * Check if this really is a spurious interrupt and ACK it
@@ -1305,6 +1309,7 @@ fastcall void smp_spurious_interrupt(str
 	printk(KERN_INFO "spurious APIC interrupt on CPU#%d, should never happen.\n",
 			smp_processor_id());
 	irq_exit();
+	enter_idle();
 }
 
 /*
@@ -1315,6 +1320,7 @@ fastcall void smp_error_interrupt(struct
 {
 	unsigned long v, v1;
 
+	exit_idle();
 	irq_enter();
 	/* First tickle the hardware, only then report what went on. -- REW */
 	v = apic_read(APIC_ESR);
@@ -1336,6 +1342,7 @@ fastcall void smp_error_interrupt(struct
 	printk (KERN_DEBUG "APIC error on CPU%d: %02lx(%02lx)\n",
 	        smp_processor_id(), v , v1);
 	irq_exit();
+	enter_idle();
 }
 
 /*
diff -urNp --exclude=.git linux-2.6.19.orig/arch/i386/kernel/cpu/intel.c linux-2.6.19.base/arch/i386/kernel/cpu/intel.c
--- linux-2.6.19.orig/arch/i386/kernel/cpu/intel.c	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.19.base/arch/i386/kernel/cpu/intel.c	2006-12-03 14:24:40.000000000 -0800
@@ -97,7 +97,7 @@ static int __cpuinit num_cpu_cores(struc
 
 static void __cpuinit init_intel(struct cpuinfo_x86 *c)
 {
-	unsigned int l2 = 0;
+	unsigned int l1, l2 = 0;
 	char *p = NULL;
 
 #ifdef CONFIG_X86_F00F_BUG
@@ -195,6 +195,14 @@ static void __cpuinit init_intel(struct 
 	if ((c->x86 == 0xf && c->x86_model >= 0x03) ||
 		(c->x86 == 0x6 && c->x86_model >= 0x0e))
 		set_bit(X86_FEATURE_CONSTANT_TSC, c->x86_capability);
+
+	if (cpu_has_ds) {
+		rdmsr(MSR_IA32_MISC_ENABLE, l1, l2);
+		if (!(l1 & (1<<11)))
+			set_bit(X86_FEATURE_BTS, c->x86_capability);
+		if (!(l1 & (1<<12)))
+			set_bit(X86_FEATURE_PEBS, c->x86_capability);
+	}
 }
 
 
diff -urNp --exclude=.git linux-2.6.19.orig/arch/i386/kernel/cpu/mcheck/p4.c linux-2.6.19.base/arch/i386/kernel/cpu/mcheck/p4.c
--- linux-2.6.19.orig/arch/i386/kernel/cpu/mcheck/p4.c	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.19.base/arch/i386/kernel/cpu/mcheck/p4.c	2006-12-03 14:24:40.000000000 -0800
@@ -12,6 +12,7 @@
 #include <asm/system.h>
 #include <asm/msr.h>
 #include <asm/apic.h>
+#include <asm/idle.h>
 
 #include <asm/therm_throt.h>
 
@@ -59,9 +60,11 @@ static void (*vendor_thermal_interrupt)(
 
 fastcall void smp_thermal_interrupt(struct pt_regs *regs)
 {
+	exit_idle();
 	irq_enter();
 	vendor_thermal_interrupt(regs);
 	irq_exit();
+	enter_idle();
 }
 
 /* P4/Xeon Thermal regulation detect and init */
diff -urNp --exclude=.git linux-2.6.19.orig/arch/i386/kernel/irq.c linux-2.6.19.base/arch/i386/kernel/irq.c
--- linux-2.6.19.orig/arch/i386/kernel/irq.c	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.19.base/arch/i386/kernel/irq.c	2006-12-03 14:24:40.000000000 -0800
@@ -19,6 +19,8 @@
 #include <linux/cpu.h>
 #include <linux/delay.h>
 
+#include <asm/idle.h>
+
 DEFINE_PER_CPU(irq_cpustat_t, irq_stat) ____cacheline_internodealigned_in_smp;
 EXPORT_PER_CPU_SYMBOL(irq_stat);
 
@@ -61,6 +63,7 @@ fastcall unsigned int do_IRQ(struct pt_r
 	union irq_ctx *curctx, *irqctx;
 	u32 *isp;
 #endif
+	exit_idle();
 
 	if (unlikely((unsigned)irq >= NR_IRQS)) {
 		printk(KERN_EMERG "%s: cannot handle IRQ %d\n",
@@ -127,6 +130,7 @@ fastcall unsigned int do_IRQ(struct pt_r
 
 	irq_exit();
 	set_irq_regs(old_regs);
+	enter_idle();
 	return 1;
 }
 
diff -urNp --exclude=.git linux-2.6.19.orig/arch/i386/kernel/process.c linux-2.6.19.base/arch/i386/kernel/process.c
--- linux-2.6.19.orig/arch/i386/kernel/process.c	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.19.base/arch/i386/kernel/process.c	2006-12-04 07:51:01.000000000 -0800
@@ -48,6 +48,7 @@
 #include <asm/i387.h>
 #include <asm/desc.h>
 #include <asm/vm86.h>
+#include <asm/idle.h>
 #ifdef CONFIG_MATH_EMULATION
 #include <asm/math_emu.h>
 #endif
@@ -79,6 +80,37 @@ void (*pm_idle)(void);
 EXPORT_SYMBOL(pm_idle);
 static DEFINE_PER_CPU(unsigned int, cpu_idle_state);
 
+static ATOMIC_NOTIFIER_HEAD(idle_notifier);
+
+void idle_notifier_register(struct notifier_block *n)
+{
+	atomic_notifier_chain_register(&idle_notifier, n);
+}
+EXPORT_SYMBOL_GPL(idle_notifier_register);
+
+void idle_notifier_unregister(struct notifier_block *n)
+{
+	atomic_notifier_chain_unregister(&idle_notifier, n);
+}
+EXPORT_SYMBOL(idle_notifier_unregister);
+
+static DEFINE_PER_CPU(volatile unsigned long, idle_state);
+
+void __enter_idle(void)
+{
+	/* needs to be atomic w.r.t. interrupts, not against other CPUs */
+	__set_bit(0, &__get_cpu_var(idle_state));
+	atomic_notifier_call_chain(&idle_notifier, IDLE_START, NULL);
+}
+
+void __exit_idle(void)
+{
+	/* needs to be atomic w.r.t. interrupts, not against other CPUs */
+	if (__test_and_clear_bit(0, &__get_cpu_var(idle_state)) == 0)
+		return;
+	atomic_notifier_call_chain(&idle_notifier, IDLE_END, NULL);
+}
+
 void disable_hlt(void)
 {
 	hlt_counter++;
@@ -194,7 +226,9 @@ void cpu_idle(void)
 				play_dead();
 
 			__get_cpu_var(irq_stat).idle_timestamp = jiffies;
+			__enter_idle();
 			idle();
+			__exit_idle();
 		}
 		preempt_enable_no_resched();
 		schedule();
diff -urNp --exclude=.git linux-2.6.19.orig/arch/i386/kernel/smp.c linux-2.6.19.base/arch/i386/kernel/smp.c
--- linux-2.6.19.orig/arch/i386/kernel/smp.c	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.19.base/arch/i386/kernel/smp.c	2006-12-03 14:24:40.000000000 -0800
@@ -23,6 +23,7 @@
 
 #include <asm/mtrr.h>
 #include <asm/tlbflush.h>
+#include <asm/idle.h>
 #include <mach_apic.h>
 
 /*
@@ -629,6 +630,7 @@ fastcall void smp_call_function_interrup
 	/*
 	 * At this point the info structure may be out of scope unless wait==1
 	 */
+	exit_idle();
 	irq_enter();
 	(*func)(info);
 	irq_exit();
@@ -638,6 +640,7 @@ fastcall void smp_call_function_interrup
 		atomic_inc(&call_data->finished);
 	}
 	set_irq_regs(old_regs);
+	enter_idle();
 }
 
 /*
diff -urNp --exclude=.git linux-2.6.19.orig/arch/ia64/kernel/irq_ia64.c linux-2.6.19.base/arch/ia64/kernel/irq_ia64.c
--- linux-2.6.19.orig/arch/ia64/kernel/irq_ia64.c	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.19.base/arch/ia64/kernel/irq_ia64.c	2006-12-03 14:24:40.000000000 -0800
@@ -39,6 +39,7 @@
 #include <asm/machvec.h>
 #include <asm/pgtable.h>
 #include <asm/system.h>
+#include <asm/idle.h>
 
 #ifdef CONFIG_PERFMON
 # include <asm/perfmon.h>
@@ -176,6 +177,7 @@ ia64_handle_irq (ia64_vector vector, str
 	 * 16 (without this, it would be ~240, which could easily lead
 	 * to kernel stack overflows).
 	 */
+	exit_idle();
 	irq_enter();
 	saved_tpr = ia64_getreg(_IA64_REG_CR_TPR);
 	ia64_srlz_d();
@@ -204,6 +206,7 @@ ia64_handle_irq (ia64_vector vector, str
 	 */
 	irq_exit();
 	set_irq_regs(old_regs);
+	enter_idle();
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -218,7 +221,7 @@ void ia64_process_pending_intr(void)
 	extern unsigned int vectors_in_migration[NR_IRQS];
 
 	vector = ia64_get_ivr();
-
+	exit_idle();
 	 irq_enter();
 	 saved_tpr = ia64_getreg(_IA64_REG_CR_TPR);
 	 ia64_srlz_d();
@@ -255,6 +258,7 @@ void ia64_process_pending_intr(void)
 		vector = ia64_get_ivr();
 	}
 	irq_exit();
+	enter_idle();
 }
 #endif
 
diff -urNp --exclude=.git linux-2.6.19.orig/arch/ia64/kernel/process.c linux-2.6.19.base/arch/ia64/kernel/process.c
--- linux-2.6.19.orig/arch/ia64/kernel/process.c	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.19.base/arch/ia64/kernel/process.c	2006-12-03 14:24:40.000000000 -0800
@@ -41,6 +41,7 @@
 #include <asm/uaccess.h>
 #include <asm/unwind.h>
 #include <asm/user.h>
+#include <asm/idle.h>
 
 #include "entry.h"
 
@@ -50,11 +51,39 @@
 
 #include "sigframe.h"
 
-void (*ia64_mark_idle)(int);
 static DEFINE_PER_CPU(unsigned int, cpu_idle_state);
 
 unsigned long boot_option_idle_override = 0;
 EXPORT_SYMBOL(boot_option_idle_override);
+static ATOMIC_NOTIFIER_HEAD(idle_notifier);
+
+void idle_notifier_register(struct notifier_block *n)
+{
+	atomic_notifier_chain_register(&idle_notifier, n);
+}
+EXPORT_SYMBOL_GPL(idle_notifier_register);
+
+void idle_notifier_unregister(struct notifier_block *n)
+{
+	atomic_notifier_chain_unregister(&idle_notifier, n);
+}
+EXPORT_SYMBOL(idle_notifier_unregister);
+
+static DEFINE_PER_CPU(volatile unsigned long, idle_state);
+
+void __enter_idle(void)
+{
+	__get_cpu_var(idle_state) = 1;
+	atomic_notifier_call_chain(&idle_notifier, IDLE_START, NULL);
+}
+
+void __exit_idle(void)
+{
+	/* needs to be atomic w.r.t. interrupts, not against other CPUs */
+	if (cmpxchg(&__get_cpu_var(idle_state), 1, 0) == 0)
+		return;
+	atomic_notifier_call_chain(&idle_notifier, IDLE_END, NULL);
+}
 
 void
 ia64_do_show_stack (struct unw_frame_info *info, void *arg)
@@ -263,7 +292,6 @@ EXPORT_SYMBOL_GPL(cpu_idle_wait);
 void __attribute__((noreturn))
 cpu_idle (void)
 {
-	void (*mark_idle)(int) = ia64_mark_idle;
   	int cpu = smp_processor_id();
 
 	/* endless idle loop with no priority at all */
@@ -282,15 +310,13 @@ cpu_idle (void)
 				__get_cpu_var(cpu_idle_state) = 0;
 
 			rmb();
-			if (mark_idle)
-				(*mark_idle)(1);
 
 			idle = pm_idle;
 			if (!idle)
 				idle = default_idle;
+			__enter_idle();
 			(*idle)();
-			if (mark_idle)
-				(*mark_idle)(0);
+			__exit_idle();
 #ifdef CONFIG_SMP
 			normal_xtp();
 #endif
diff -urNp --exclude=.git linux-2.6.19.orig/arch/ia64/sn/kernel/idle.c linux-2.6.19.base/arch/ia64/sn/kernel/idle.c
--- linux-2.6.19.orig/arch/ia64/sn/kernel/idle.c	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.19.base/arch/ia64/sn/kernel/idle.c	2006-12-03 14:24:40.000000000 -0800
@@ -5,12 +5,14 @@
  *
  * Copyright (c) 2001-2004 Silicon Graphics, Inc.  All rights reserved.
  */
-
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <asm/idle.h>
 #include <asm/sn/leds.h>
 
-void snidle(int state)
+int snidle(struct notifier_block *nb, unsigned long state, void *data)
 {
-	if (state) {
+	if (state == IDLE_START) {
 		if (pda->idle_flag == 0) {
 			/* 
 			 * Turn the activity LED off.
@@ -27,4 +29,5 @@ void snidle(int state)
 
 		pda->idle_flag = 0;
 	}
+	return NOTIFY_OK;
 }
diff -urNp --exclude=.git linux-2.6.19.orig/arch/ia64/sn/kernel/setup.c linux-2.6.19.base/arch/ia64/sn/kernel/setup.c
--- linux-2.6.19.orig/arch/ia64/sn/kernel/setup.c	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.19.base/arch/ia64/sn/kernel/setup.c	2006-12-03 14:24:40.000000000 -0800
@@ -53,6 +53,7 @@
 #include "xtalk/xwidgetdev.h"
 #include "xtalk/hubdev.h"
 #include <asm/sn/klconfig.h>
+#include <asm/idle.h>
 
 
 DEFINE_PER_CPU(struct pda_s, pda_percpu);
@@ -63,8 +64,7 @@ extern void bte_init_node(nodepda_t *, c
 
 extern void sn_timer_init(void);
 extern unsigned long last_time_offset;
-extern void (*ia64_mark_idle) (int);
-extern void snidle(int);
+extern int snidle(struct notifier_block *nb, unsigned long state, void *data);
 extern unsigned long long (*ia64_printk_clock)(void);
 
 unsigned long sn_rtc_cycles_per_second;
@@ -123,6 +123,10 @@ struct screen_info sn_screen_info = {
 	.orig_video_points = 16
 };
 
+static struct notifier_block snidle_notifier= {
+	        .notifier_call = snidle
+};
+
 /*
  * This routine can only be used during init, since
  * smp_boot_data is an init data structure.
@@ -464,7 +468,7 @@ void __init sn_setup(char **cmdline_p)
 	 */
 	sn_init_pdas(cmdline_p);
 
-	ia64_mark_idle = &snidle;
+	idle_notifier_register(&snidle_notifier);
 
 	/*
 	 * For the bootcpu, we do this here. All other cpus will make the
diff -urNp --exclude=.git linux-2.6.19.orig/arch/x86_64/kernel/apic.c linux-2.6.19.base/arch/x86_64/kernel/apic.c
--- linux-2.6.19.orig/arch/x86_64/kernel/apic.c	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.19.base/arch/x86_64/kernel/apic.c	2006-12-03 14:24:40.000000000 -0800
@@ -937,6 +937,7 @@ void smp_apic_timer_interrupt(struct pt_
 	smp_local_timer_interrupt();
 	irq_exit();
 	set_irq_regs(old_regs);
+	enter_idle();
 }
 
 /*
@@ -1018,6 +1019,7 @@ asmlinkage void smp_spurious_interrupt(v
 	} 
 #endif 
 	irq_exit();
+	enter_idle();
 }
 
 /*
@@ -1050,6 +1052,7 @@ asmlinkage void smp_error_interrupt(void
 	printk (KERN_DEBUG "APIC error on CPU%d: %02x(%02x)\n",
 	        smp_processor_id(), v , v1);
 	irq_exit();
+	enter_idle();
 }
 
 int disable_apic; 
diff -urNp --exclude=.git linux-2.6.19.orig/arch/x86_64/kernel/mce_amd.c linux-2.6.19.base/arch/x86_64/kernel/mce_amd.c
--- linux-2.6.19.orig/arch/x86_64/kernel/mce_amd.c	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.19.base/arch/x86_64/kernel/mce_amd.c	2006-12-03 14:24:40.000000000 -0800
@@ -224,6 +224,7 @@ asmlinkage void mce_threshold_interrupt(
 	}
 out:
 	irq_exit();
+	enter_idle();
 }
 
 /*
diff -urNp --exclude=.git linux-2.6.19.orig/arch/x86_64/kernel/mce_intel.c linux-2.6.19.base/arch/x86_64/kernel/mce_intel.c
--- linux-2.6.19.orig/arch/x86_64/kernel/mce_intel.c	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.19.base/arch/x86_64/kernel/mce_intel.c	2006-12-03 14:24:40.000000000 -0800
@@ -27,6 +27,7 @@ asmlinkage void smp_thermal_interrupt(vo
 		mce_log_therm_throt_event(smp_processor_id(), msr_val);
 
 	irq_exit();
+	enter_idle();
 }
 
 static void __cpuinit intel_init_thermal(struct cpuinfo_x86 *c)
diff -urNp --exclude=.git linux-2.6.19.orig/arch/x86_64/kernel/setup.c linux-2.6.19.base/arch/x86_64/kernel/setup.c
--- linux-2.6.19.orig/arch/x86_64/kernel/setup.c	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.19.base/arch/x86_64/kernel/setup.c	2006-12-03 14:24:40.000000000 -0800
@@ -835,6 +835,15 @@ static void __cpuinit init_intel(struct 
 			set_bit(X86_FEATURE_ARCH_PERFMON, &c->x86_capability);
 	}
 
+	if (cpu_has_ds) {
+		unsigned int l1, l2;
+		rdmsr(MSR_IA32_MISC_ENABLE, l1, l2);
+		if (!(l1 & (1<<11)))
+			set_bit(X86_FEATURE_BTS, c->x86_capability);
+		if (!(l1 & (1<<12)))
+			set_bit(X86_FEATURE_PEBS, c->x86_capability);
+	}
+
 	n = c->extended_cpuid_level;
 	if (n >= 0x80000008) {
 		unsigned eax = cpuid_eax(0x80000008);
diff -urNp --exclude=.git linux-2.6.19.orig/arch/x86_64/kernel/smp.c linux-2.6.19.base/arch/x86_64/kernel/smp.c
--- linux-2.6.19.orig/arch/x86_64/kernel/smp.c	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.19.base/arch/x86_64/kernel/smp.c	2006-12-03 14:24:40.000000000 -0800
@@ -519,5 +519,6 @@ asmlinkage void smp_call_function_interr
 		mb();
 		atomic_inc(&call_data->finished);
 	}
+	enter_idle();
 }
 
diff -urNp --exclude=.git linux-2.6.19.orig/include/asm-i386/cpufeature.h linux-2.6.19.base/include/asm-i386/cpufeature.h
--- linux-2.6.19.orig/include/asm-i386/cpufeature.h	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.19.base/include/asm-i386/cpufeature.h	2006-12-03 14:24:40.000000000 -0800
@@ -73,6 +73,8 @@
 #define X86_FEATURE_UP		(3*32+ 9) /* smp kernel running on up */
 #define X86_FEATURE_FXSAVE_LEAK (3*32+10) /* FXSAVE leaks FOP/FIP/FOP */
 #define X86_FEATURE_ARCH_PERFMON (3*32+11) /* Intel Architectural PerfMon */
+#define X86_FEATURE_PEBS	(3*32+12)  /* Precise-Event Based Sampling */
+#define X86_FEATURE_BTS		(3*32+13)  /* Branch Trace Store */
 
 /* Intel-defined CPU features, CPUID level 0x00000001 (ecx), word 4 */
 #define X86_FEATURE_XMM3	(4*32+ 0) /* Streaming SIMD Extensions-3 */
@@ -134,6 +136,9 @@
 #define cpu_has_phe_enabled	boot_cpu_has(X86_FEATURE_PHE_EN)
 #define cpu_has_pmm		boot_cpu_has(X86_FEATURE_PMM)
 #define cpu_has_pmm_enabled	boot_cpu_has(X86_FEATURE_PMM_EN)
+#define cpu_has_ds 		boot_cpu_has(X86_FEATURE_DTES)
+#define cpu_has_pebs 		boot_cpu_has(X86_FEATURE_PEBS)
+#define cpu_has_bts		boot_cpu_has(X86_FEATURE_BTS)
 
 #endif /* __ASM_I386_CPUFEATURE_H */
 
diff -urNp --exclude=.git linux-2.6.19.orig/include/asm-i386/idle.h linux-2.6.19.base/include/asm-i386/idle.h
--- linux-2.6.19.orig/include/asm-i386/idle.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.19.base/include/asm-i386/idle.h	2006-12-03 14:24:40.000000000 -0800
@@ -0,0 +1,27 @@
+#ifndef _ASM_I386_IDLE_H
+#define _ASM_I386_IDLE_H 1
+
+#define IDLE_START 1
+#define IDLE_END 2
+
+struct notifier_block;
+void idle_notifier_register(struct notifier_block *n);
+void idle_notifier_unregister(struct notifier_block *n);
+
+void __exit_idle(void);
+void __enter_idle(void);
+
+static inline void enter_idle(void)
+{
+	if (current->pid)
+		return;
+	__enter_idle();
+}
+
+static inline void exit_idle(void)
+{
+	if (current->pid)
+		return;
+	__exit_idle();
+}
+#endif
diff -urNp --exclude=.git linux-2.6.19.orig/include/asm-i386/msr.h linux-2.6.19.base/include/asm-i386/msr.h
--- linux-2.6.19.orig/include/asm-i386/msr.h	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.19.base/include/asm-i386/msr.h	2006-12-03 14:24:40.000000000 -0800
@@ -141,6 +141,10 @@ static inline void wrmsrl (unsigned long
 #define MSR_IA32_MC0_ADDR		0x402
 #define MSR_IA32_MC0_MISC		0x403
 
+#define MSR_IA32_PEBS_ENABLE		0x3f1
+#define MSR_IA32_DS_AREA		0x600
+#define MSR_IA32_PERF_CAPABILITIES	0x345
+
 /* Pentium IV performance counter MSRs */
 #define MSR_P4_BPU_PERFCTR0 		0x300
 #define MSR_P4_BPU_PERFCTR1 		0x301
@@ -284,4 +288,13 @@ static inline void wrmsrl (unsigned long
 #define MSR_TMTA_LRTI_READOUT		0x80868018
 #define MSR_TMTA_LRTI_VOLT_MHZ		0x8086801a
 
+/* Intel Core-based CPU performance counters */
+#define MSR_CORE_PERF_FIXED_CTR0	0x309
+#define MSR_CORE_PERF_FIXED_CTR1	0x30a
+#define MSR_CORE_PERF_FIXED_CTR2	0x30b
+#define MSR_CORE_PERF_FIXED_CTR_CTRL	0x38d
+#define MSR_CORE_PERF_GLOBAL_STATUS	0x38e
+#define MSR_CORE_PERF_GLOBAL_CTRL	0x38f
+#define MSR_CORE_PERF_GLOBAL_OVF_CTRL	0x390
+
 #endif /* __ASM_MSR_H */
diff -urNp --exclude=.git linux-2.6.19.orig/include/asm-ia64/idle.h linux-2.6.19.base/include/asm-ia64/idle.h
--- linux-2.6.19.orig/include/asm-ia64/idle.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.19.base/include/asm-ia64/idle.h	2006-12-03 14:24:40.000000000 -0800
@@ -0,0 +1,32 @@
+#ifndef _ASM_IA64_IDLE_H
+#define _ASM_IA64_IDLE_H 1
+
+#include <linux/irq.h>
+#include <asm/ptrace.h>
+
+#define IDLE_START 1
+#define IDLE_END 2
+
+struct notifier_block;
+void idle_notifier_register(struct notifier_block *n);
+void idle_notifier_unregister(struct notifier_block *n);
+
+void __exit_idle(void);
+void __enter_idle(void);
+
+/* Called from interrupts to signify back to idle */
+static inline void enter_idle(void)
+{
+	if (current->pid)
+		return;
+	__enter_idle();
+}
+
+/* Called from interrupts to signify idle end */
+static inline void exit_idle(void)
+{
+	if (current->pid)
+		return;
+	__exit_idle();
+}
+#endif
diff -urNp --exclude=.git linux-2.6.19.orig/include/asm-x86_64/cpufeature.h linux-2.6.19.base/include/asm-x86_64/cpufeature.h
--- linux-2.6.19.orig/include/asm-x86_64/cpufeature.h	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.19.base/include/asm-x86_64/cpufeature.h	2006-12-03 14:24:40.000000000 -0800
@@ -68,6 +68,8 @@
 #define X86_FEATURE_FXSAVE_LEAK (3*32+7)  /* FIP/FOP/FDP leaks through FXSAVE */
 #define X86_FEATURE_UP		(3*32+8) /* SMP kernel running on UP */
 #define X86_FEATURE_ARCH_PERFMON (3*32+9) /* Intel Architectural PerfMon */
+#define X86_FEATURE_PEBS	(3*32+10) /* Precise-Event Based Sampling */
+#define X86_FEATURE_BTS		(3*32+11) /* Branch Trace Store */
 
 /* Intel-defined CPU features, CPUID level 0x00000001 (ecx), word 4 */
 #define X86_FEATURE_XMM3	(4*32+ 0) /* Streaming SIMD Extensions-3 */
@@ -112,5 +114,8 @@
 #define cpu_has_cyrix_arr      0
 #define cpu_has_centaur_mcr    0
 #define cpu_has_clflush	       boot_cpu_has(X86_FEATURE_CLFLSH)
+#define cpu_has_ds 	       boot_cpu_has(X86_FEATURE_DTES)
+#define cpu_has_pebs 	       boot_cpu_has(X86_FEATURE_PEBS)
+#define cpu_has_bts	       boot_cpu_has(X86_FEATURE_BTS)
 
 #endif /* __ASM_X8664_CPUFEATURE_H */
diff -urNp --exclude=.git linux-2.6.19.orig/include/asm-x86_64/msr.h linux-2.6.19.base/include/asm-x86_64/msr.h
--- linux-2.6.19.orig/include/asm-x86_64/msr.h	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.19.base/include/asm-x86_64/msr.h	2006-12-03 14:24:40.000000000 -0800
@@ -210,6 +210,10 @@ static inline unsigned int cpuid_edx(uns
 #define MSR_IA32_LASTINTFROMIP     0x1dd
 #define MSR_IA32_LASTINTTOIP       0x1de
 
+#define MSR_IA32_PEBS_ENABLE		0x3f1
+#define MSR_IA32_DS_AREA		0x600
+#define MSR_IA32_PERF_CAPABILITIES	0x345
+
 #define MSR_MTRRfix64K_00000	0x250
 #define MSR_MTRRfix16K_80000	0x258
 #define MSR_MTRRfix16K_A0000	0x259
@@ -407,4 +411,13 @@ static inline unsigned int cpuid_edx(uns
 #define MSR_P4_U2L_ESCR0 		0x3b0
 #define MSR_P4_U2L_ESCR1 		0x3b1
 
+/* Intel Core-based CPU performance counters */
+#define MSR_CORE_PERF_FIXED_CTR0	0x309
+#define MSR_CORE_PERF_FIXED_CTR1	0x30a
+#define MSR_CORE_PERF_FIXED_CTR2	0x30b
+#define MSR_CORE_PERF_FIXED_CTR_CTRL	0x38d
+#define MSR_CORE_PERF_GLOBAL_STATUS	0x38e
+#define MSR_CORE_PERF_GLOBAL_CTRL	0x38f
+#define MSR_CORE_PERF_GLOBAL_OVF_CTRL	0x390
+
 #endif
diff -urNp --exclude=.git linux-2.6.19.orig/include/linux/carta_random32.h linux-2.6.19.base/include/linux/carta_random32.h
--- linux-2.6.19.orig/include/linux/carta_random32.h	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.19.base/include/linux/carta_random32.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,29 +0,0 @@
-/*
- * Fast, simple, yet decent quality random number generator based on
- * a paper by David G. Carta ("Two Fast Implementations of the
- * `Minimal Standard' Random Number Generator," Communications of the
- * ACM, January, 1990).
- *
- * Copyright (c) 2002-2006 Hewlett-Packard Development Company, L.P.
- *	Contributed by Stephane Eranian <eranian@hpl.hp.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
- * 02111-1307 USA
- */
-#ifndef _LINUX_CARTA_RANDOM32_H_
-#define _LINUX_CARTA_RANDOM32_H_
-
-u64 carta_random32(u64 seed);
-
-#endif /* _LINUX_CARTA_RANDOM32_H_ */
