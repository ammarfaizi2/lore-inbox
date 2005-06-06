Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261637AbVFFTXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbVFFTXo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 15:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbVFFTXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 15:23:44 -0400
Received: from fmr18.intel.com ([134.134.136.17]:21719 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261637AbVFFTWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 15:22:32 -0400
Message-Id: <20050606192113.044405000@araj-em64t>
References: <20050606191433.104273000@araj-em64t>
Date: Mon, 06 Jun 2005 12:14:35 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Srivattsa Vaddagiri <vatsa@in.ibm.com>, discuss@x86-64.org,
       Rusty Russell <rusty@rustycorp.com.au>
Cc: Ashok Raj <ashok.raj@intel.com>
Subject: [patch 2/5] try2: x86_64: CPU hotplug support.
Content-Disposition: inline; filename=x86_64-cpuhotplug.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Experimental CPU hotplug patch for x86_64
-----------------------------------------
This supports logical CPU online and offline.
- Test with maxcpus=1, and then kick other cpu's off to test if init code
  is all cleaned up. CONFIG_SCHED_SMT works as well.
- idle threads are forked on demand from keventd threads for clean startup

TBD: 
1. Not tested on a real NUMA machine (tested with numa=fake=2)
2. Handle ACPI pieces for physical hotplug support.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Acked-by: Andi Kleen <ak@muc.de>
Acked-by: Zwane Mwaikambo <zwane@arm.linux.org.uk>
-----------------------------------------

 arch/i386/mach-default/topology.c |   15 +-
 arch/x86_64/Kconfig               |    9 +
 arch/x86_64/kernel/irq.c          |   30 +++++
 arch/x86_64/kernel/process.c      |   28 +++++
 arch/x86_64/kernel/smpboot.c      |  199 ++++++++++++++++++++++++++++++++++----
 arch/x86_64/kernel/traps.c        |    8 +
 include/asm-x86_64/irq.h          |    5 
 include/asm-x86_64/smp.h          |    2 
 8 files changed, 269 insertions(+), 27 deletions(-)

Index: linux-2.6.12-rc5-mm2/arch/x86_64/Kconfig
===================================================================
--- linux-2.6.12-rc5-mm2.orig/arch/x86_64/Kconfig
+++ linux-2.6.12-rc5-mm2/arch/x86_64/Kconfig
@@ -288,6 +288,15 @@ config NR_CPUS
 	  This is purely to save memory - each supported CPU requires
 	  memory in the static kernel configuration.
 
+config HOTPLUG_CPU
+	bool "Support for hot-pluggable CPUs (EXPERIMENTAL)"
+	depends on SMP && HOTPLUG && EXPERIMENTAL
+	help
+		Say Y here to experiment with turning CPUs off and on.  CPUs
+		can be controlled through /sys/devices/system/cpu/cpu#.
+		Say N if you want to disable CPU hotplug.
+
+
 config HPET_TIMER
 	bool
 	default y
Index: linux-2.6.12-rc5-mm2/arch/x86_64/kernel/smpboot.c
===================================================================
--- linux-2.6.12-rc5-mm2.orig/arch/x86_64/kernel/smpboot.c
+++ linux-2.6.12-rc5-mm2/arch/x86_64/kernel/smpboot.c
@@ -34,6 +34,7 @@
  *      Andi Kleen              :       Converted to new state machine.
  *					Various cleanups.
  *					Probably mostly hotplug CPU ready now.
+ *	Ashok Raj			: CPU hotplug support
  */
 
 
@@ -98,6 +99,37 @@ EXPORT_SYMBOL(cpu_core_map);
 extern unsigned char trampoline_data[];
 extern unsigned char trampoline_end[];
 
+/* State of each CPU */
+DEFINE_PER_CPU(int, cpu_state) = { 0 };
+
+/*
+ * Store all idle threads, this can be reused instead of creating
+ * a new thread. Also avoids complicated thread destroy functionality
+ * for idle threads.
+ */
+struct task_struct *idle_thread_array[NR_CPUS] __cpuinitdata ;
+
+#define get_idle_for_cpu(x)     (idle_thread_array[(x)])
+#define set_idle_for_cpu(x,p)   (idle_thread_array[(x)] = (p))
+
+/*
+ * cpu_possible_map should be static, it cannot change as cpu's
+ * are onlined, or offlined. The reason is per-cpu data-structures
+ * are allocated by some modules at init time, and dont expect to
+ * do this dynamically on cpu arrival/departure.
+ * cpu_present_map on the other hand can change dynamically.
+ * In case when cpu_hotplug is not compiled, then we resort to current
+ * behaviour, which is cpu_possible == cpu_present.
+ * If cpu-hotplug is supported, then we need to preallocate for all
+ * those NR_CPUS, hence cpu_possible_map represents entire NR_CPUS range.
+ * - Ashok Raj
+ */
+#ifdef CONFIG_HOTPLUG_CPU
+#define fixup_cpu_possible_map(x)	cpu_set((x), cpu_possible_map)
+#else
+#define fixup_cpu_possible_map(x)
+#endif
+
 /*
  * Currently trivial. Write the real->protected mode
  * bootstrap into the page concerned. The caller
@@ -623,33 +655,67 @@ static int __cpuinit wakeup_secondary_vi
 	return (send_status | accept_status);
 }
 
+struct create_idle {
+	struct task_struct *idle;
+	struct completion done;
+	int cpu;
+};
+
+void do_fork_idle(void *_c_idle)
+{
+	struct create_idle *c_idle = _c_idle;
+
+	c_idle->idle = fork_idle(c_idle->cpu);
+	complete(&c_idle->done);
+}
+
 /*
  * Boot one CPU.
  */
 static int __cpuinit do_boot_cpu(int cpu, int apicid)
 {
-	struct task_struct *idle;
 	unsigned long boot_error;
 	int timeout;
 	unsigned long start_rip;
-	/*
-	 * We can't use kernel_thread since we must avoid to
-	 * reschedule the child.
-	 */
-	idle = fork_idle(cpu);
-	if (IS_ERR(idle)) {
+	struct create_idle c_idle = {
+		.cpu = cpu,
+		.done = COMPLETION_INITIALIZER(c_idle.done),
+	};
+	DECLARE_WORK(work, do_fork_idle, &c_idle);
+
+	c_idle.idle = get_idle_for_cpu(cpu);
+
+	if (c_idle.idle) {
+		c_idle.idle->thread.rsp = (unsigned long) (((struct pt_regs *)
+			(THREAD_SIZE + (unsigned long) c_idle.idle->thread_info)) - 1);
+		init_idle(c_idle.idle, cpu);
+		goto do_rest;
+	}
+
+	if (!keventd_up() || current_is_keventd())
+		work.func(work.data);
+	else {
+		schedule_work(&work);
+		wait_for_completion(&c_idle.done);
+	}
+
+	if (IS_ERR(c_idle.idle)) {
 		printk("failed fork for CPU %d\n", cpu);
-		return PTR_ERR(idle);
+		return PTR_ERR(c_idle.idle);
 	}
 
-	cpu_pda[cpu].pcurrent = idle;
+	set_idle_for_cpu(cpu, c_idle.idle);
+
+do_rest:
+
+	cpu_pda[cpu].pcurrent = c_idle.idle;
 
 	start_rip = setup_trampoline();
 
-	init_rsp = idle->thread.rsp;
+	init_rsp = c_idle.idle->thread.rsp;
 	per_cpu(init_tss,cpu).rsp0 = init_rsp;
 	initial_code = start_secondary;
-	clear_ti_thread_flag(idle->thread_info, TIF_FORK);
+	clear_ti_thread_flag(c_idle.idle->thread_info, TIF_FORK);
 
 	printk(KERN_INFO "Booting processor %d/%d rip %lx rsp %lx\n", cpu, apicid,
 	       start_rip, init_rsp);
@@ -925,10 +991,9 @@ void __init smp_prepare_cpus(unsigned in
 		int apicid = cpu_present_to_apicid(i);
 		if (physid_isset(apicid, phys_cpu_present_map)) {
 			cpu_set(i, cpu_present_map);
-			/* possible map would be different if we supported real
-			   CPU hotplug. */
 			cpu_set(i, cpu_possible_map);
 		}
+		fixup_cpu_possible_map(i);
 	}
 
 	if (smp_sanity_check(max_cpus) < 0) {
@@ -977,9 +1042,6 @@ void __init smp_prepare_boot_cpu(void)
 
 /*
  * Entry point to boot a CPU.
- *
- * This is all __cpuinit, not __devinit for now because we don't support
- * CPU hotplug (yet).
  */
 int __cpuinit __cpu_up(unsigned int cpu)
 {
@@ -996,6 +1058,14 @@ int __cpuinit __cpu_up(unsigned int cpu)
 		return -EINVAL;
 	}
 
+	/*
+	 * Already booted CPU?
+	 */
+ 	if (cpu_isset(cpu, cpu_callin_map)) {
+		Dprintk ("do_boot_cpu %d Already started\n", cpu);
+ 		return -ENOSYS;
+	}
+
 	/* Boot it! */
 	err = do_boot_cpu(cpu, apicid);
 	if (err < 0) {
@@ -1008,7 +1078,9 @@ int __cpuinit __cpu_up(unsigned int cpu)
 
 	while (!cpu_isset(cpu, cpu_online_map))
 		cpu_relax();
-	return 0;
+	err = 0;
+
+	return err;
 }
 
 /*
@@ -1016,7 +1088,9 @@ int __cpuinit __cpu_up(unsigned int cpu)
  */
 void __init smp_cpus_done(unsigned int max_cpus)
 {
+#ifndef CONFIG_HOTPLUG_CPU
 	zap_low_mappings();
+#endif
 	smp_cleanup_boot();
 
 #ifdef CONFIG_X86_IO_APIC
@@ -1028,3 +1102,94 @@ void __init smp_cpus_done(unsigned int m
 
 	check_nmi_watchdog();
 }
+
+#ifdef CONFIG_HOTPLUG_CPU
+
+static void
+remove_siblinginfo(int cpu)
+{
+	int sibling;
+
+	for_each_cpu_mask(sibling, cpu_sibling_map[cpu])
+		cpu_clear(cpu, cpu_sibling_map[sibling]);
+	for_each_cpu_mask(sibling, cpu_core_map[cpu])
+		cpu_clear(cpu, cpu_core_map[sibling]);
+	cpus_clear(cpu_sibling_map[cpu]);
+	cpus_clear(cpu_core_map[cpu]);
+	phys_proc_id[cpu] = BAD_APICID;
+	cpu_core_id[cpu] = BAD_APICID;
+}
+
+void remove_cpu_from_maps(void)
+{
+	int cpu = smp_processor_id();
+
+	cpu_clear(cpu, cpu_callout_map);
+	cpu_clear(cpu, cpu_callin_map);
+	clear_bit(cpu, &cpu_initialized); /* was set by cpu_init() */
+}
+
+int __cpu_disable(void)
+{
+	int cpu = smp_processor_id();
+
+	/*
+	 * Perhaps use cpufreq to drop frequency, but that could go
+	 * into generic code.
+ 	 *
+	 * We won't take down the boot processor on i386 due to some
+	 * interrupts only being able to be serviced by the BSP.
+	 * Especially so if we're not using an IOAPIC	-zwane
+	 */
+	if (cpu == 0)
+		return -EBUSY;
+
+	disable_APIC_timer();
+
+	/*
+	 * HACK:
+	 * Allow any queued timer interrupts to get serviced
+	 * This is only a temporary solution until we cleanup
+	 * fixup_irqs as we do for IA64.
+	 */
+	local_irq_enable();
+	mdelay(1);
+
+	local_irq_disable();
+	remove_siblinginfo(cpu);
+
+	/* It's now safe to remove this processor from the online map */
+	cpu_clear(cpu, cpu_online_map);
+	remove_cpu_from_maps();
+	fixup_irqs(cpu_online_map);
+	return 0;
+}
+
+void __cpu_die(unsigned int cpu)
+{
+	/* We don't do anything here: idle task is faking death itself. */
+	unsigned int i;
+
+	for (i = 0; i < 10; i++) {
+		/* They ack this in play_dead by setting CPU_DEAD */
+		if (per_cpu(cpu_state, cpu) == CPU_DEAD)
+			return;
+		current->state = TASK_UNINTERRUPTIBLE;
+		schedule_timeout(HZ/10);
+	}
+ 	printk(KERN_ERR "CPU %u didn't die...\n", cpu);
+}
+
+#else /* ... !CONFIG_HOTPLUG_CPU */
+
+int __cpu_disable(void)
+{
+	return -ENOSYS;
+}
+
+void __cpu_die(unsigned int cpu)
+{
+	/* We said "no" in __cpu_disable */
+	BUG();
+}
+#endif /* CONFIG_HOTPLUG_CPU */
Index: linux-2.6.12-rc5-mm2/arch/x86_64/kernel/irq.c
===================================================================
--- linux-2.6.12-rc5-mm2.orig/arch/x86_64/kernel/irq.c
+++ linux-2.6.12-rc5-mm2/arch/x86_64/kernel/irq.c
@@ -14,6 +14,7 @@
 #include <linux/interrupt.h>
 #include <linux/seq_file.h>
 #include <linux/module.h>
+#include <linux/delay.h>
 #include <asm/uaccess.h>
 #include <asm/io_apic.h>
 
@@ -106,3 +107,32 @@ asmlinkage unsigned int do_IRQ(struct pt
 
 	return 1;
 }
+
+#ifdef CONFIG_HOTPLUG_CPU
+void fixup_irqs(cpumask_t map)
+{
+	unsigned int irq;
+	static int warned;
+
+	for (irq = 0; irq < NR_IRQS; irq++) {
+		cpumask_t mask;
+		if (irq == 2)
+			continue;
+
+		cpus_and(mask, irq_affinity[irq], map);
+		if (any_online_cpu(mask) == NR_CPUS) {
+			printk("Breaking affinity for irq %i\n", irq);
+			mask = map;
+		}
+		if (irq_desc[irq].handler->set_affinity)
+			irq_desc[irq].handler->set_affinity(irq, mask);
+		else if (irq_desc[irq].action && !(warned++))
+			printk("Cannot set affinity for irq %i\n", irq);
+	}
+
+	/* That doesn't seem sufficient.  Give it 1ms. */
+	local_irq_enable();
+	mdelay(1);
+	local_irq_disable();
+}
+#endif
Index: linux-2.6.12-rc5-mm2/include/asm-x86_64/irq.h
===================================================================
--- linux-2.6.12-rc5-mm2.orig/include/asm-x86_64/irq.h
+++ linux-2.6.12-rc5-mm2/include/asm-x86_64/irq.h
@@ -52,4 +52,9 @@ struct irqaction;
 struct pt_regs;
 int handle_IRQ_event(unsigned int, struct pt_regs *, struct irqaction *);
 
+#ifdef CONFIG_HOTPLUG_CPU
+#include <linux/cpumask.h>
+extern void fixup_irqs(cpumask_t map);
+#endif
+
 #endif /* _ASM_IRQ_H */
Index: linux-2.6.12-rc5-mm2/arch/x86_64/kernel/process.c
===================================================================
--- linux-2.6.12-rc5-mm2.orig/arch/x86_64/kernel/process.c
+++ linux-2.6.12-rc5-mm2/arch/x86_64/kernel/process.c
@@ -8,7 +8,8 @@
  * 
  *  X86-64 port
  *	Andi Kleen.
- * 
+ *
+ *	CPU hotplug support - ashok.raj@intel.com
  *  $Id: process.c,v 1.38 2002/01/15 10:08:03 ak Exp $
  */
 
@@ -18,6 +19,7 @@
 
 #include <stdarg.h>
 
+#include <linux/cpu.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
 #include <linux/kernel.h>
@@ -154,6 +156,28 @@ void cpu_idle_wait(void)
 }
 EXPORT_SYMBOL_GPL(cpu_idle_wait);
 
+#ifdef CONFIG_HOTPLUG_CPU
+DECLARE_PER_CPU(int, cpu_state);
+
+#include <asm/nmi.h>
+/* We don't actually take CPU down, just spin without interrupts. */
+static inline void play_dead(void)
+{
+	idle_task_exit();
+	mb();
+	/* Ack it */
+	__get_cpu_var(cpu_state) = CPU_DEAD;
+
+	while (1)
+		safe_halt();
+}
+#else
+static inline void play_dead(void)
+{
+	BUG();
+}
+#endif /* CONFIG_HOTPLUG_CPU */
+
 /*
  * The idle thread. There's no useful work to be
  * done, so just try to conserve power and have a
@@ -174,6 +198,8 @@ void cpu_idle (void)
 			idle = pm_idle;
 			if (!idle)
 				idle = default_idle;
+			if (cpu_is_offline(smp_processor_id()))
+				play_dead();
 			idle();
 		}
 
Index: linux-2.6.12-rc5-mm2/include/asm-x86_64/smp.h
===================================================================
--- linux-2.6.12-rc5-mm2.orig/include/asm-x86_64/smp.h
+++ linux-2.6.12-rc5-mm2/include/asm-x86_64/smp.h
@@ -77,6 +77,8 @@ extern __inline int hard_smp_processor_i
 }
 
 extern int safe_smp_processor_id(void);
+extern int __cpu_disable(void);
+extern void __cpu_die(unsigned int cpu);
 
 #endif /* !ASSEMBLY */
 
Index: linux-2.6.12-rc5-mm2/arch/x86_64/kernel/traps.c
===================================================================
--- linux-2.6.12-rc5-mm2.orig/arch/x86_64/kernel/traps.c
+++ linux-2.6.12-rc5-mm2/arch/x86_64/kernel/traps.c
@@ -589,11 +589,17 @@ static void unknown_nmi_error(unsigned c
 asmlinkage void default_do_nmi(struct pt_regs *regs)
 {
 	unsigned char reason = 0;
+	int cpu;
+
+	cpu = smp_processor_id();
 
 	/* Only the BSP gets external NMIs from the system.  */
-	if (!smp_processor_id())
+	if (!cpu)
 		reason = get_nmi_reason();
 
+	if (!cpu_online(cpu))
+		return;
+
 	if (!(reason & 0xc0)) {
 		if (notify_die(DIE_NMI_IPI, "nmi_ipi", regs, reason, 0, SIGINT)
 								== NOTIFY_STOP)
Index: linux-2.6.12-rc5-mm2/arch/i386/mach-default/topology.c
===================================================================
--- linux-2.6.12-rc5-mm2.orig/arch/i386/mach-default/topology.c
+++ linux-2.6.12-rc5-mm2/arch/i386/mach-default/topology.c
@@ -73,12 +73,11 @@ static int __init topology_init(void)
 {
 	int i;
 
-	for (i = 0; i < MAX_NUMNODES; i++) {
-		if (node_online(i))
-			arch_register_node(i);
-	}
-	for (i = 0; i < NR_CPUS; i++)
-		if (cpu_possible(i)) arch_register_cpu(i);
+	for_each_online_node(i)
+		arch_register_node(i);
+
+	for_each_cpu(i)
+		arch_register_cpu(i);
 	return 0;
 }
 
@@ -88,8 +87,8 @@ static int __init topology_init(void)
 {
 	int i;
 
-	for (i = 0; i < NR_CPUS; i++)
-		if (cpu_possible(i)) arch_register_cpu(i);
+	for_each_cpu(i)
+		arch_register_cpu(i);
 	return 0;
 }
 

--

