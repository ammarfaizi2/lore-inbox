Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264605AbUAaOUA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 09:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264855AbUAaOUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 09:20:00 -0500
Received: from dp.samba.org ([66.70.73.150]:15292 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264605AbUAaOTY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 09:19:24 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Nick Piggin <piggin@cyberone.com.au>,
       dipankar@in.ibm.com, vatsa@in.ibm.com
Subject: [PATCH 4/4] 2.6.2-rc2-mm2 CPU Hotplug: i386 support
Date: Sun, 01 Feb 2004 01:16:29 +1100
Message-Id: <20040131141937.F21E12C0A8@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the i386 portion: we've basically been using it to stress the
core code, unlike the PPC64 which actually has hotplug CPUs (but this
is better, because we can plug/unplug REALLY fast to find races).

As such, it's a curiousity, and a little rough (doesn't allow boot CPU
to go down, for example).  But great for playing with the code.

The main change is that the IPI-sending types of code have been
changed to use a cpumask_t rather than a count, since cpus may appear
and vanish and we don't want to hold a lock.

Name: Hotplug CPU Patch: i386 support: -mm Version
Author: Matt Fleming, Zwane Mwaikambo, Dipankar Sarma, Vatsa Vaddagiri
Status: Experimental
Depends: Hotcpu-mm/hotcpu-with-kthread-simple-mm.patch.gz
Depends: Hotcpu/hotcpu-cpu_active_map.patch.gz
Version: -mm

D: i386 hotplug CPU support, as modified by Dipankar and Vatsa.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26398-linux-2.6.2-rc2-mm2/arch/i386/Kconfig .26398-linux-2.6.2-rc2-mm2.updated/arch/i386/Kconfig
--- .26398-linux-2.6.2-rc2-mm2/arch/i386/Kconfig	2004-01-31 17:27:42.000000000 +1100
+++ .26398-linux-2.6.2-rc2-mm2.updated/arch/i386/Kconfig	2004-02-01 00:32:26.000000000 +1100
@@ -1229,6 +1229,15 @@ config HOTPLUG
 	  agent" (/sbin/hotplug) to load modules and set up software needed
 	  to use devices as you hotplug them.
 
+config HOTPLUG_CPU
+	bool "Support for hot-pluggable CPUs (EXPERIMENTAL)"
+	depends on SMP && HOTPLUG && EXPERIMENTAL
+	---help---
+	  Say Y here to experiment with turning CPUs off and on.  CPUs
+	  can be controlled through /sys/devices/system/cpu.
+
+	  Say N.
+
 source "drivers/pcmcia/Kconfig"
 
 source "drivers/pci/hotplug/Kconfig"
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26398-linux-2.6.2-rc2-mm2/arch/i386/kernel/irq.c .26398-linux-2.6.2-rc2-mm2.updated/arch/i386/kernel/irq.c
--- .26398-linux-2.6.2-rc2-mm2/arch/i386/kernel/irq.c	2004-01-31 17:27:42.000000000 +1100
+++ .26398-linux-2.6.2-rc2-mm2.updated/arch/i386/kernel/irq.c	2004-02-01 00:32:26.000000000 +1100
@@ -34,6 +34,8 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/kallsyms.h>
+#include <linux/notifier.h>
+#include <linux/cpu.h>
 
 #include <asm/atomic.h>
 #include <asm/io.h>
@@ -45,6 +47,7 @@
 #include <asm/delay.h>
 #include <asm/desc.h>
 #include <asm/irq.h>
+#include <mach_apic.h>
 
 /*
  * Linux has a controller-independent x86 interrupt architecture.
@@ -964,7 +967,69 @@ static int irq_affinity_write_proc(struc
 
 	return full_count;
 }
+#endif
+
+#ifdef CONFIG_HOTPLUG_CPU
+static void migrate_irqs_from(int cpu)
+{
+	cpumask_t mask;
+	unsigned int irq;
+
+	mask = cpumask_of_cpu(cpu);
+	cpus_complement(mask);
+	cpus_and(mask, mask, cpu_online_map);
+	for (irq = 0; irq < NR_IRQS; irq++) {
+		cpus_and(irq_affinity[irq], irq_affinity[irq], mask);
+		if (cpus_empty(irq_affinity[irq]))
+			irq_affinity[irq] = cpumask_of_cpu(0);
 
+		if (irq_desc[irq].handler->set_affinity)
+			irq_desc[irq].handler->set_affinity(irq, mask);
+	}
+}
+
+void enable_all_irqs(int cpu)
+{
+	cpumask_t mask;
+	unsigned int irq;
+
+	mask = cpumask_of_cpu(cpu);
+	cpus_or(mask, mask, cpu_online_map);
+	for (irq = 0; irq < NR_IRQS; irq++) {
+		cpus_or(irq_affinity[irq], irq_affinity[irq], mask);
+		if (cpus_empty(irq_affinity[irq])) {
+			irq_affinity[irq] = cpumask_of_cpu(0);
+		}
+
+		if (irq_desc[irq].handler->set_affinity)
+			irq_desc[irq].handler->set_affinity(irq, mask);
+	}
+}
+
+static int irqs_cpu_notify(struct notifier_block *self,
+                                unsigned long action, void *hcpu)
+{
+	int cpu = (int)hcpu;
+	switch(action) {
+	case CPU_ONLINE:
+		/*
+		 * We could go through all the irqs and add
+		 * this processor to the cpu set - zwane
+		 */
+		enable_all_irqs(cpu);
+		break;
+	case CPU_OFFLINE:
+		migrate_irqs_from(cpu);
+		break;
+	default:
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block __devinitdata irqs_cpu_nb = {
+        .notifier_call  = irqs_cpu_notify,
+};
 #endif
 
 static int prof_cpu_mask_read_proc (char *page, char **start, off_t off,
@@ -1053,5 +1118,9 @@ void init_irq_proc (void)
 	 */
 	for (i = 0; i < NR_IRQS; i++)
 		register_irq_proc(i);
+#ifdef CONFIG_HOTPLUG_CPU
+	register_cpu_notifier(&irqs_cpu_nb);
+#endif
+
 }
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26398-linux-2.6.2-rc2-mm2/arch/i386/kernel/process.c .26398-linux-2.6.2-rc2-mm2.updated/arch/i386/kernel/process.c
--- .26398-linux-2.6.2-rc2-mm2/arch/i386/kernel/process.c	2004-01-31 17:27:42.000000000 +1100
+++ .26398-linux-2.6.2-rc2-mm2.updated/arch/i386/kernel/process.c	2004-02-01 00:32:26.000000000 +1100
@@ -14,6 +14,7 @@
 #define __KERNEL_SYSCALLS__
 #include <stdarg.h>
 
+#include <linux/cpu.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
 #include <linux/fs.h>
@@ -48,6 +49,8 @@
 #include <asm/irq.h>
 #include <asm/desc.h>
 #include <asm/atomic_kmap.h>
+#include <asm/tlbflush.h>
+#include <asm/cpu.h>
 #ifdef CONFIG_MATH_EMULATION
 #include <asm/math_emu.h>
 #endif
@@ -133,6 +136,60 @@ static void poll_idle (void)
 	}
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+
+/* We don't actually take CPU down, just spin without interrupts. */
+static inline void check_cpu_quiescent(void)
+{
+	if (unlikely(__get_cpu_var(cpu_state) == CPU_OFFLINE)) {
+		int cpu = smp_processor_id();
+
+		spin_lock(&call_lock);
+		local_irq_disable();
+		preempt_disable();
+
+		/* Ack it */
+		__get_cpu_var(cpu_state) = CPU_DEAD;
+
+		BUG_ON(cpu_isset(cpu, cpu_online_map));
+		BUG_ON(!cpu_isset(cpu, cpu_active_map));
+		cpu_clear(cpu, cpu_active_map);
+		spin_unlock(&call_lock);
+
+		/* Death loop */
+		while (__get_cpu_var(cpu_state) != CPU_UP_PREPARE)
+			cpu_relax();
+
+		/* Even with irqs disabled, this is safe, since no
+		 * smp_call_funcion can be headed for us now
+		 * (!cpu_active). */
+		spin_lock(&call_lock);
+
+		/* from hereon we're ready to do work */
+		__get_cpu_var(cpu_state) = CPU_ONLINE;
+		wmb();
+
+		//printk("Cpu %u arisen\n", smp_processor_id());
+
+		/* Put ourselves online before doing ___flush_tlb_all,
+		 * so we avoid losing one to a race. */
+		cpu_set(smp_processor_id(), cpu_active_map);
+		cpu_set(smp_processor_id(), cpu_online_map);
+		wmb();
+		spin_unlock(&call_lock);
+
+		__flush_tlb_all();
+		local_irq_enable();
+
+		preempt_enable();
+	}
+}
+#else
+static inline void check_cpu_quiescent(void)
+{
+}
+#endif /* CONFIG_HOTPLUG_CPU */
+
 /*
  * The idle thread. There's no useful work to be
  * done, so just try to conserve power and have a
@@ -149,6 +206,7 @@ void cpu_idle (void)
 			if (!idle)
 				idle = default_idle;
 
+			check_cpu_quiescent();
 			irq_stat[smp_processor_id()].idle_timestamp = jiffies;
 			idle();
 		}
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26398-linux-2.6.2-rc2-mm2/arch/i386/kernel/smp.c .26398-linux-2.6.2-rc2-mm2.updated/arch/i386/kernel/smp.c
--- .26398-linux-2.6.2-rc2-mm2/arch/i386/kernel/smp.c	2004-01-31 17:27:42.000000000 +1100
+++ .26398-linux-2.6.2-rc2-mm2.updated/arch/i386/kernel/smp.c	2004-02-01 00:32:26.000000000 +1100
@@ -357,11 +357,15 @@ static void flush_tlb_others(cpumask_t c
 	 */
 	BUG_ON(cpus_empty(cpumask));
 
-	cpus_and(tmp, cpumask, cpu_online_map);
+	cpus_and(tmp, cpumask, cpu_callout_map);
 	BUG_ON(!cpus_equal(cpumask, tmp));
 	BUG_ON(cpu_isset(smp_processor_id(), cpumask));
 	BUG_ON(!mm);
 
+	cpus_and(cpumask, cpumask, cpu_active_map);
+	if (cpus_empty(cpumask))
+		return;
+
 	/*
 	 * i'm not happy about this global shared spinlock in the
 	 * MM hot path, but we'll see how contended it is.
@@ -389,9 +393,11 @@ static void flush_tlb_others(cpumask_t c
 	 */
 	send_IPI_mask(cpumask, INVALIDATE_TLB_VECTOR);
 
-	while (!cpus_empty(flush_cpumask))
-		/* nothing. lockup detection does not belong here */
+	do {
 		mb();
+		tmp = flush_cpumask;
+		cpus_and(tmp, tmp, cpu_active_map);
+	} while (!cpus_empty(tmp));
 
 	flush_mm = NULL;
 	flush_va = 0;
@@ -481,13 +487,13 @@ void smp_send_reschedule(int cpu)
  * Structure and data for smp_call_function(). This is designed to minimise
  * static memory requirements. It also looks cleaner.
  */
-static spinlock_t call_lock = SPIN_LOCK_UNLOCKED;
+spinlock_t call_lock = SPIN_LOCK_UNLOCKED;
 
 struct call_data_struct {
 	void (*func) (void *info);
 	void *info;
-	atomic_t started;
-	atomic_t finished;
+	cpumask_t not_started;
+	cpumask_t not_finished;
 	int wait;
 };
 
@@ -514,32 +520,44 @@ int smp_call_function (void (*func) (voi
  */
 {
 	struct call_data_struct data;
-	int cpus = num_online_cpus()-1;
+	cpumask_t mask;
+	int cpu;
 
-	if (!cpus)
-		return 0;
+	spin_lock(&call_lock);
 
+	cpu = smp_processor_id();
 	data.func = func;
 	data.info = info;
-	atomic_set(&data.started, 0);
+	data.not_started = cpu_active_map;
+	cpu_clear(cpu, data.not_started);
+	if (cpus_empty(data.not_started))
+		goto out_unlock;
+
 	data.wait = wait;
 	if (wait)
-		atomic_set(&data.finished, 0);
+		data.not_finished = data.not_started;
 
-	spin_lock(&call_lock);
 	call_data = &data;
 	mb();
 	
 	/* Send a message to all other CPUs and wait for them to respond */
-	send_IPI_allbutself(CALL_FUNCTION_VECTOR);
+	send_IPI_mask(data.not_started, CALL_FUNCTION_VECTOR);
 
 	/* Wait for response */
-	while (atomic_read(&data.started) != cpus)
-		barrier();
+	do {
+		mb();
+		mask = data.not_started;
+		cpus_and(mask, mask, cpu_active_map);
+	} while(!cpus_empty(mask));
 
 	if (wait)
-		while (atomic_read(&data.finished) != cpus)
-			barrier();
+		do {
+			mb();
+			mask = data.not_finished;
+			cpus_and(mask, mask, cpu_active_map);
+		} while(!cpus_empty(mask));
+
+out_unlock:
 	spin_unlock(&call_lock);
 
 	return 0;
@@ -551,6 +569,7 @@ static void stop_this_cpu (void * dummy)
 	 * Remove this CPU:
 	 */
 	cpu_clear(smp_processor_id(), cpu_online_map);
+	cpu_clear(smp_processor_id(), cpu_active_map);
 	local_irq_disable();
 	disable_local_APIC();
 	if (cpu_data[smp_processor_id()].hlt_works_ok)
@@ -583,17 +602,25 @@ asmlinkage void smp_reschedule_interrupt
 
 asmlinkage void smp_call_function_interrupt(void)
 {
-	void (*func) (void *info) = call_data->func;
-	void *info = call_data->info;
-	int wait = call_data->wait;
+	void (*func) (void *info);
+	void *info;
+	int wait;
+	int cpu = smp_processor_id();
 
 	ack_APIC_irq();
+
+	func = call_data->func;
+	info = call_data->info;
+	wait = call_data->wait;
+
 	/*
 	 * Notify initiating CPU that I've grabbed the data and am
 	 * about to execute the function
 	 */
-	mb();
-	atomic_inc(&call_data->started);
+	smp_mb__before_clear_bit();
+	cpu_clear(cpu, call_data->not_started);
+	smp_mb__after_clear_bit();
+
 	/*
 	 * At this point the info structure may be out of scope unless wait==1
 	 */
@@ -602,8 +629,9 @@ asmlinkage void smp_call_function_interr
 	irq_exit();
 
 	if (wait) {
-		mb();
-		atomic_inc(&call_data->finished);
+		smp_mb__before_clear_bit();
+		cpu_clear(cpu, call_data->not_finished);
+		smp_mb__after_clear_bit();
 	}
 }
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26398-linux-2.6.2-rc2-mm2/arch/i386/kernel/smpboot.c .26398-linux-2.6.2-rc2-mm2.updated/arch/i386/kernel/smpboot.c
--- .26398-linux-2.6.2-rc2-mm2/arch/i386/kernel/smpboot.c	2004-01-31 17:27:42.000000000 +1100
+++ .26398-linux-2.6.2-rc2-mm2.updated/arch/i386/kernel/smpboot.c	2004-02-01 00:32:26.000000000 +1100
@@ -43,6 +43,9 @@
 #include <linux/smp_lock.h>
 #include <linux/irq.h>
 #include <linux/bootmem.h>
+#include <linux/notifier.h>
+#include <linux/cpu.h>
+#include <linux/percpu.h>
 
 #include <linux/delay.h>
 #include <linux/mc146818rtc.h>
@@ -65,7 +68,12 @@ int phys_proc_id[NR_CPUS]; /* Package ID
 /* bitmap of online cpus */
 cpumask_t cpu_online_map;
 
-static cpumask_t cpu_callin_map;
+#ifdef CONFIG_HOTPLUG_CPU
+cpumask_t cpu_active_map;
+#endif
+
+/* Initialize, although master cpu never calls in */
+static volatile cpumask_t cpu_callin_map;
 cpumask_t cpu_callout_map;
 static cpumask_t smp_commenced_mask;
 
@@ -83,6 +91,9 @@ extern unsigned char trampoline_data [];
 extern unsigned char trampoline_end  [];
 static unsigned char *trampoline_base;
 
+/* State of each CPU. */
+DEFINE_PER_CPU(int, cpu_state) = { 0 };
+
 /*
  * Currently trivial. Write the real->protected mode
  * bootstrap into the page concerned. The caller
@@ -457,7 +468,9 @@ int __init start_secondary(void *unused)
 	 * the local TLBs too.
 	 */
 	local_flush_tlb();
+	/* cpu_set should suffice for this stage of bootup -zwane*/
 	cpu_set(smp_processor_id(), cpu_online_map);
+	cpu_set(smp_processor_id(), cpu_active_map);
 	wmb();
 	return cpu_idle();
 }
@@ -1324,29 +1337,123 @@ __init void arch_init_sched_domains(void
    who understands all this stuff should rewrite it properly. --RR 15/Jul/02 */
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
+	smp_commenced_mask = cpumask_of_cpu(0);
+	cpu_callin_map = cpumask_of_cpu(0);
+	mb();
 	smp_boot_cpus(max_cpus);
 }
 
 void __devinit smp_prepare_boot_cpu(void)
 {
 	cpu_set(smp_processor_id(), cpu_online_map);
+	cpu_set(smp_processor_id(), cpu_active_map);
 	cpu_set(smp_processor_id(), cpu_callout_map);
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+/* must be called with the cpucontrol mutex held */
+static int __devinit cpu_enable(unsigned int cpu)
+{
+	/* get the target out of it's holding state */
+	per_cpu(cpu_state, cpu) = CPU_UP_PREPARE;
+	wmb();
+
+	/* wait for the processor to ack it. timeout? */
+	while (!cpu_online(cpu))
+		cpu_relax();
+	return 0;
+}
+
+int __cpu_disable(void)
+{
+	int cpu = smp_processor_id();
+	/*
+	 * Nothing for now, perhaps use cpufreq to drop frequency,
+	 * but that could go into generic code.
+ 	 *
+	 * We won't take down the boot processor on i386 due to some
+	 * interrupts only being able to be serviced by the BSP.
+	 * Especially so if we're not using an IOAPIC	-zwane
+	 */
+	if (cpu == 0)
+		return -EBUSY;
+
+	BUG_ON(!cpu_isset(cpu, cpu_active_map));
+	BUG_ON(!cpu_isset(cpu, cpu_online_map));
+	wmb();
+	cpu_clear(cpu, cpu_online_map);
+	wmb();
+
+	return 0;
+}
+
+static void do_nothing(void *unused)
+{
+	return;
+}
+
+void __cpu_die(unsigned int cpu)
+{
+	unsigned int i;
+
+	/* Final threads can take some time to actually clean up */
+	while (!idle_cpu(cpu))
+ 		yield();
+
+	per_cpu(cpu_state, cpu) = CPU_OFFLINE;
+	wmb();
+	for (i = 0; i < 10; i++) {
+		wake_idle_cpu(cpu);
+		/* They ack this in check_cpu_quiescent by setting CPU_DEAD */
+		if (per_cpu(cpu_state, cpu) == CPU_DEAD) {
+			/*
+			 * This prevents a race in smp_call_function due
+			 * to the rapid online of the same CPU which just died.
+			 */
+			smp_call_function(do_nothing, NULL, 1, 1);
+			return;
+		}
+		current->state = TASK_UNINTERRUPTIBLE;
+		schedule_timeout(HZ/10);
+	}
+ 	printk(KERN_ERR "CPU %u didn't die...\n", cpu);
+}
+#else /* ... !CONFIG_HOTPLUG_CPU */
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
+
 int __devinit __cpu_up(unsigned int cpu)
 {
 	/* This only works at boot for x86.  See "rewrite" above. */
-	if (cpu_isset(cpu, smp_commenced_mask)) {
+	if (cpu_isset(cpu, smp_commenced_mask) && cpu_online(cpu)) {
 		local_irq_enable();
 		return -ENOSYS;
 	}
 
 	/* In case one didn't come up */
 	if (!cpu_isset(cpu, cpu_callin_map)) {
+		printk(KERN_DEBUG "skipping cpu%d, didn't come online\n", cpu);
 		local_irq_enable();
 		return -EIO;
 	}
 
+#ifdef CONFIG_HOTPLUG_CPU
+	/* Already up, and in cpu_quiescent now? */
+	if (cpu_isset(cpu, smp_commenced_mask)) {
+		cpu_enable(cpu);
+		/* we can simply fall through */
+	}
+#endif
+ 
 	local_irq_enable();
 	/* Unleash the CPU! */
 	cpu_set(cpu, smp_commenced_mask);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26398-linux-2.6.2-rc2-mm2/include/asm-i386/cpu.h .26398-linux-2.6.2-rc2-mm2.updated/include/asm-i386/cpu.h
--- .26398-linux-2.6.2-rc2-mm2/include/asm-i386/cpu.h	2003-09-22 10:09:11.000000000 +1000
+++ .26398-linux-2.6.2-rc2-mm2.updated/include/asm-i386/cpu.h	2004-02-01 00:32:26.000000000 +1100
@@ -4,6 +4,7 @@
 #include <linux/device.h>
 #include <linux/cpu.h>
 #include <linux/topology.h>
+#include <linux/percpu.h>
 
 #include <asm/node.h>
 
@@ -23,4 +24,5 @@ static inline int arch_register_cpu(int 
 	return register_cpu(&cpu_devices[num].cpu, num, parent);
 }
 
+DECLARE_PER_CPU(int, cpu_state);
 #endif /* _ASM_I386_CPU_H_ */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26398-linux-2.6.2-rc2-mm2/include/asm-i386/smp.h .26398-linux-2.6.2-rc2-mm2.updated/include/asm-i386/smp.h
--- .26398-linux-2.6.2-rc2-mm2/include/asm-i386/smp.h	2004-01-31 17:28:16.000000000 +1100
+++ .26398-linux-2.6.2-rc2-mm2.updated/include/asm-i386/smp.h	2004-02-01 00:32:26.000000000 +1100
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/threads.h>
 #include <linux/cpumask.h>
+#include <linux/spinlock.h>
 #endif
 
 #ifdef CONFIG_X86_LOCAL_APIC
@@ -52,6 +53,7 @@ extern void zap_low_mappings (void);
  */
 #define smp_processor_id() (current_thread_info()->cpu)
 
+extern spinlock_t call_lock;
 extern cpumask_t cpu_callout_map;
 #define cpu_possible_map cpu_callout_map
 
@@ -84,6 +86,10 @@ static __inline int logical_smp_processo
 }
 
 #endif
+
+extern int __cpu_disable(void);
+extern void __cpu_die(unsigned int cpu);
+
 #endif /* !__ASSEMBLY__ */
 
 #define NO_PROC_ID		0xFF		/* No processor magic marker */

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
