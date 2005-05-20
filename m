Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261436AbVETWsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbVETWsF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 18:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbVETWsD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 18:48:03 -0400
Received: from fmr19.intel.com ([134.134.136.18]:20934 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261436AbVETWjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 18:39:53 -0400
Message-Id: <20050520223417.532048000@csdlinux-2.jf.intel.com>
References: <20050520221622.124069000@csdlinux-2.jf.intel.com>
Date: Fri, 20 May 2005 15:16:24 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: ak@muc.de
Cc: zwane@arm.linux.org.uk, discuss@x86-64.org, shaohua.li@intel.com,
       linux-kernel@vger.kernel.org
Subject: [patch 2/4] CPU hot-plug support for x86_64
Content-Disposition: inline; filename=x86_64-cpuhotplug.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Experimental CPU hotplug patch for x86_64
-----------------------------------------
- Most of init code that needs to be there for hotplug marked now as __devinit
	(Didn't use cpuinit, simply because the main framework code in kernel
	 is not the same way, just trying to be consistent)
- Test with maxcpus=1, and then kick other cpu's off to test if init code
  is all cleaned up.
- idle threads are forked on demand from keventd threads for clean startup

TBD: 

1. Currently not tested for CONFIG_NUMA
2. CONFIG_SCHED_SMT seems to have trouble with booting maxcpus=1
   and then bringing up one cpu.
3. Handle ACPI pieces for physical hotplug support.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
-----------

 arch/i386/mach-default/topology.c |    7 -
 arch/x86_64/Kconfig               |    9 +
 arch/x86_64/kernel/irq.c          |   30 ++++
 arch/x86_64/kernel/process.c      |   33 +++++
 arch/x86_64/kernel/smp.c          |   12 +
 arch/x86_64/kernel/smpboot.c      |  241 ++++++++++++++++++++++++++++++++++----
 arch/x86_64/kernel/traps.c        |    9 +
 include/asm-x86_64/irq.h          |    5 
 include/asm-x86_64/smp.h          |    4 
 9 files changed, 322 insertions(+), 28 deletions(-)

Index: linux-2.6.12-rc4-mm2/arch/x86_64/Kconfig
===================================================================
--- linux-2.6.12-rc4-mm2.orig/arch/x86_64/Kconfig	2005-05-20 13:14:58.000000000 -0700
+++ linux-2.6.12-rc4-mm2/arch/x86_64/Kconfig	2005-05-20 13:17:43.000000000 -0700
@@ -294,6 +294,15 @@
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
Index: linux-2.6.12-rc4-mm2/arch/x86_64/kernel/smpboot.c
===================================================================
--- linux-2.6.12-rc4-mm2.orig/arch/x86_64/kernel/smpboot.c	2005-05-20 13:17:41.000000000 -0700
+++ linux-2.6.12-rc4-mm2/arch/x86_64/kernel/smpboot.c	2005-05-20 13:38:57.000000000 -0700
@@ -34,6 +34,7 @@
  *      Andi Kleen              :       Converted to new state machine.
  *					Various cleanups.
  *					Probably mostly hotplug CPU ready now.
+ *	Ashok Raj			: CPU hotplug support
  */
 
 
@@ -68,7 +69,6 @@
 
 /* Bitmask of currently online CPUs */
 cpumask_t cpu_online_map;
-
 EXPORT_SYMBOL(cpu_online_map);
 
 /*
@@ -97,6 +97,26 @@
 extern unsigned char trampoline_data[];
 extern unsigned char trampoline_end[];
 
+/* State of each CPU */
+DEFINE_PER_CPU(int, cpu_state) = { 0 };
+
+#ifdef CONFIG_HOTPLUG_CPU
+/*
+ * Store all idle threads, this can be reused instead of creating
+ * a new thread. Also avoids complicated thread destroy functionality
+ * for idle threads.
+ */
+struct task_struct *idle_thread_array[NR_CPUS];
+
+#define get_idle_for_cpu(x)     (idle_thread_array[(x)])
+#define set_idle_for_cpu(x,p)   (idle_thread_array[(x)] = (p))
+
+#else
+
+#define get_idle_for_cpu(x)     (NULL)
+#define set_idle_for_cpu(x,p)
+#endif
+
 /*
  * Currently trivial. Write the real->protected mode
  * bootstrap into the page concerned. The caller
@@ -182,9 +202,9 @@
    latency and low latency is the primary objective here. -AK */
 #define no_cpu_relax() barrier()
 
-static __cpuinitdata DEFINE_SPINLOCK(tsc_sync_lock);
-static volatile __cpuinitdata unsigned long go[SLAVE + 1];
-static int notscsync __cpuinitdata;
+static __devinitdata DEFINE_SPINLOCK(tsc_sync_lock);
+static volatile __devinitdata unsigned long go[SLAVE + 1];
+static int notscsync __devinitdata;
 
 #undef DEBUG_TSC_SYNC
 
@@ -192,7 +212,7 @@
 #define NUM_ITERS	5	/* likewise */
 
 /* Callback on boot CPU */
-static __cpuinit void sync_master(void *arg)
+static __devinit void sync_master(void *arg)
 {
 	unsigned long flags, i;
 
@@ -247,7 +267,7 @@
 	return tcenter - best_tm;
 }
 
-static __cpuinit void sync_tsc(void)
+static __devinit void sync_tsc(void)
 {
 	int i, done = 0;
 	long delta, adj, adjust_latency = 0;
@@ -258,7 +278,7 @@
 		long master;	/* master's timestamp */
 		long diff;	/* difference between midpoint and master's timestamp */
 		long lat;	/* estimate of tsc adjustment latency */
-	} t[NUM_ROUNDS] __cpuinitdata;
+	} t[NUM_ROUNDS] __devinitdata;
 #endif
 
 	go[MASTER] = 1;
@@ -310,7 +330,7 @@
 	       smp_processor_id(), boot_cpu_id, delta, rt);
 }
 
-static void __cpuinit tsc_sync_wait(void)
+static void __devinit tsc_sync_wait(void)
 {
 	if (notscsync || !cpu_has_tsc)
 		return;
@@ -410,6 +430,8 @@
 	 * Allow the master to continue.
 	 */
 	cpu_set(cpuid, cpu_callin_map);
+	mb();
+	local_flush_tlb();
 }
 
 /*
@@ -444,8 +466,10 @@
 	/*
 	 * Allow the master to continue.
 	 */
+	lock_ipi_calllock();
 	cpu_set(smp_processor_id(), cpu_online_map);
 	mb();
+	unlock_ipi_calllock();
 
 	/* Wait for TSC sync to not schedule things before.
 	   We still process interrupts, which could see an inconsistent
@@ -622,33 +646,66 @@
 	return (send_status | accept_status);
 }
 
+struct create_idle {
+	struct task_struct *idle;
+	struct completion done;
+	int cpu;
+};
+
+void
+do_fork_idle(void *_c_idle)
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
 static int __devinit do_boot_cpu(int cpu, int apicid)
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
@@ -926,8 +983,14 @@
 			cpu_set(i, cpu_present_map);
 			/* possible map would be different if we supported real
 			   CPU hotplug. */
+#ifndef CONFIG_HOTPLUG_CPU
 			cpu_set(i, cpu_possible_map);
+#endif
 		}
+#ifdef CONFIG_HOTPLUG_CPU
+			printk ("Setting possible cpus %d\n", i);
+			cpu_set(i, cpu_possible_map);
+#endif
 	}
 
 	if (smp_sanity_check(max_cpus) < 0) {
@@ -974,11 +1037,29 @@
 	cpu_set(me, cpu_callout_map);
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+
+/* must be called with the cpucontrol mutex held */
+static int __devinit cpu_enable(unsigned int cpu)
+{
+	/* get the target out of its holding state */
+	per_cpu(cpu_state, cpu) = CPU_UP_PREPARE;
+	wmb();
+
+	/* wait for the processor to ack it. timeout? */
+	while (!cpu_online(cpu))
+		cpu_relax();
+
+	fixup_irqs(cpu_online_map);
+	/* counter the disable in fixup_irqs() */
+	local_irq_enable();
+	return 0;
+}
+
+#endif
+
 /*
  * Entry point to boot a CPU.
- *
- * This is all __devinit, not __devinit for now because we don't support
- * CPU hotplug (yet).
  */
 int __devinit __cpu_up(unsigned int cpu)
 {
@@ -994,12 +1075,26 @@
 		printk("__cpu_up: bad cpu %d\n", cpu);
 		return -EINVAL;
 	}
+ 
+	/*
+	 * FIXME: This is temporary.. will go away.
+	 * Already booted CPU, so just enable it.
+	 */
+ 	if (cpu_isset(cpu, cpu_callin_map)) {
+#ifdef CONFIG_HOTPLUG_CPU
+		cpu_enable(cpu);
+		return 0;
+#else
+		local_irq_enable();
+ 		return -ENOSYS;
+#endif
+	}
 
 	/* Boot it! */
 	err = do_boot_cpu(cpu, apicid);
 	if (err < 0) {
 		Dprintk("do_boot_cpu failed %d\n", err);
-		return err;
+		goto ret;
 	}
 
 	/* Unleash the CPU! */
@@ -1007,7 +1102,10 @@
 
 	while (!cpu_isset(cpu, cpu_online_map))
 		cpu_relax();
-	return 0;
+	err = 0;
+ret:
+	flush_tlb_all();
+	return err;
 }
 
 /*
@@ -1015,7 +1113,9 @@
  */
 void __init smp_cpus_done(unsigned int max_cpus)
 {
+#ifndef CONFIG_HOTPLUG_CPU
 	zap_low_mappings();
+#endif
 	smp_cleanup_boot();
 
 #ifdef CONFIG_X86_IO_APIC
@@ -1027,3 +1127,96 @@
 
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
+	/* Allow any queued timer interrupts to get serviced */
+	local_irq_enable();
+	mdelay(1);
+
+	/*
+	 * Need this per zwane, but this uses IPI, so cannot be used 
+	 * in the machine down state. Need to find something else
+	 *
+	 * flush_tlb_all(); 
+	 */
+	local_flush_tlb();
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
Index: linux-2.6.12-rc4-mm2/arch/x86_64/kernel/irq.c
===================================================================
--- linux-2.6.12-rc4-mm2.orig/arch/x86_64/kernel/irq.c	2005-05-20 13:14:58.000000000 -0700
+++ linux-2.6.12-rc4-mm2/arch/x86_64/kernel/irq.c	2005-05-20 13:17:43.000000000 -0700
@@ -14,6 +14,7 @@
 #include <linux/interrupt.h>
 #include <linux/seq_file.h>
 #include <linux/module.h>
+#include <linux/delay.h>
 #include <asm/uaccess.h>
 #include <asm/io_apic.h>
 
@@ -106,3 +107,32 @@
 
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
Index: linux-2.6.12-rc4-mm2/include/asm-x86_64/irq.h
===================================================================
--- linux-2.6.12-rc4-mm2.orig/include/asm-x86_64/irq.h	2005-05-20 13:14:58.000000000 -0700
+++ linux-2.6.12-rc4-mm2/include/asm-x86_64/irq.h	2005-05-20 13:17:43.000000000 -0700
@@ -52,4 +52,9 @@
 struct pt_regs;
 int handle_IRQ_event(unsigned int, struct pt_regs *, struct irqaction *);
 
+#ifdef CONFIG_HOTPLUG_CPU
+#include <linux/cpumask.h>
+extern void fixup_irqs(cpumask_t map);
+#endif
+
 #endif /* _ASM_IRQ_H */
Index: linux-2.6.12-rc4-mm2/arch/x86_64/kernel/process.c
===================================================================
--- linux-2.6.12-rc4-mm2.orig/arch/x86_64/kernel/process.c	2005-05-20 13:17:41.000000000 -0700
+++ linux-2.6.12-rc4-mm2/arch/x86_64/kernel/process.c	2005-05-20 13:17:43.000000000 -0700
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
@@ -154,6 +156,33 @@
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
+	local_irq_disable();
+	while (1)
+		safe_halt();
+#if 0
+	while (1)
+		__asm__ __volatile__("hlt":::"memory");
+#endif
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
@@ -174,6 +203,8 @@
 			idle = pm_idle;
 			if (!idle)
 				idle = default_idle;
+			if (cpu_is_offline(smp_processor_id()))
+				play_dead();
 			idle();
 		}
 
Index: linux-2.6.12-rc4-mm2/include/asm-x86_64/smp.h
===================================================================
--- linux-2.6.12-rc4-mm2.orig/include/asm-x86_64/smp.h	2005-05-20 13:14:58.000000000 -0700
+++ linux-2.6.12-rc4-mm2/include/asm-x86_64/smp.h	2005-05-20 13:17:43.000000000 -0700
@@ -44,6 +44,8 @@
 extern volatile unsigned long smp_invalidate_needed;
 extern int pic_mode;
 extern int smp_num_siblings;
+extern void lock_ipi_calllock(void);
+extern void unlock_ipi_calllock(void);
 extern void smp_flush_tlb(void);
 extern void smp_message_irq(int cpl, void *dev_id, struct pt_regs *regs);
 extern void smp_send_reschedule(int cpu);
@@ -77,6 +79,8 @@
 }
 
 extern int safe_smp_processor_id(void);
+extern int __cpu_disable(void);
+extern void __cpu_die(unsigned int cpu);
 
 #endif /* !ASSEMBLY */
 
Index: linux-2.6.12-rc4-mm2/arch/x86_64/kernel/traps.c
===================================================================
--- linux-2.6.12-rc4-mm2.orig/arch/x86_64/kernel/traps.c	2005-05-20 13:14:58.000000000 -0700
+++ linux-2.6.12-rc4-mm2/arch/x86_64/kernel/traps.c	2005-05-20 13:17:43.000000000 -0700
@@ -587,11 +587,18 @@
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
 
+#ifdef CONFIG_HOTPLUG_CPU
+	if (!cpu_online(cpu))
+		return;
+#endif
 	if (!(reason & 0xc0)) {
 		if (notify_die(DIE_NMI_IPI, "nmi_ipi", regs, reason, 0, SIGINT)
 								== NOTIFY_STOP)
Index: linux-2.6.12-rc4-mm2/arch/x86_64/kernel/smp.c
===================================================================
--- linux-2.6.12-rc4-mm2.orig/arch/x86_64/kernel/smp.c	2005-05-20 13:14:58.000000000 -0700
+++ linux-2.6.12-rc4-mm2/arch/x86_64/kernel/smp.c	2005-05-20 13:18:10.000000000 -0700
@@ -295,6 +295,18 @@
 
 static struct call_data_struct * call_data;
 
+void
+lock_ipi_calllock(void)
+{
+	spin_lock_irq(&call_lock);
+}
+
+void
+unlock_ipi_calllock(void)
+{
+	spin_unlock_irq(&call_lock);
+}
+
 /*
  * this function sends a 'generic call function' IPI to all other CPUs
  * in the system.
Index: linux-2.6.12-rc4-mm2/arch/i386/mach-default/topology.c
===================================================================
--- linux-2.6.12-rc4-mm2.orig/arch/i386/mach-default/topology.c	2005-05-20 13:14:58.000000000 -0700
+++ linux-2.6.12-rc4-mm2/arch/i386/mach-default/topology.c	2005-05-20 13:17:43.000000000 -0700
@@ -88,8 +88,11 @@
 {
 	int i;
 
-	for (i = 0; i < NR_CPUS; i++)
-		if (cpu_possible(i)) arch_register_cpu(i);
+	for (i = 0; i < NR_CPUS; i++) {
+		if (cpu_possible(i))  {
+			arch_register_cpu(i);
+		}
+	}
 	return 0;
 }
 

--
