Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbUCVGgu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 01:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbUCVGgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 01:36:50 -0500
Received: from ozlabs.org ([203.10.76.45]:57766 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261780AbUCVGfy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 01:35:54 -0500
Subject: [PATCH] Hotplug CPU toy for i386
From: Rusty Russell <rusty@rustcorp.com.au>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <405C1F42.9030901@cyberone.com.au>
References: <405C1F42.9030901@cyberone.com.au>
Content-Type: text/plain
Message-Id: <1079937266.5759.42.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 22 Mar 2004 17:34:28 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-03-20 at 21:38, Nick Piggin wrote:
> I remember you said you had a test implementation for i386 that
> allowed one to exercise the code paths. This would be useful to
> me. Not in yet? What are the plans for it?

Indeed, here it is.  Tested on Linus' tree, but applies to Andrew's
too...

Thanks!
Rusty.

Name: x86 code
Author: Rusty Russell
Status: Tested on 2.6.5-rc2-bk1

i386 hotplug CPU support.  As stands, it's a toy for experimentation
and exercising the code paths.

1) Add CONFIG_HOTPLUG_CPU
2) Ignore timer interrupt on offline cpu.
3) Disable preempt around irq balancing to prevent CPUs going down.
4) Print irq stats for all possible cpus.
5) Debugging check for interrupts on offline cpus.
6) Hacky fixup_irqs() to redirect irqs when cpus go off/online.
7) play_dead() for offline cpus to spin inside.
8) Handle offline cpus set in flush_tlb_others().
9) Grab lock earlier in smp_call_function() to prevent CPUs going down.
10) Implement __cpu_disable() and __cpu_die().

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .24305-2.6.3-mm1-atomic-cpudown-i386.pre/arch/i386/Kconfig .24305-2.6.3-mm1-atomic-cpudown-i386/arch/i386/Kconfig
--- .24305-2.6.3-mm1-atomic-cpudown-i386.pre/arch/i386/Kconfig	2004-02-18 23:55:46.000000000 +1100
+++ .24305-2.6.3-mm1-atomic-cpudown-i386/arch/i386/Kconfig	2004-02-20 10:31:00.000000000 +1100
@@ -1255,6 +1255,15 @@ config HOTPLUG
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .24305-2.6.3-mm1-atomic-cpudown-i386.pre/arch/i386/kernel/apic.c .24305-2.6.3-mm1-atomic-cpudown-i386/arch/i386/kernel/apic.c
--- .24305-2.6.3-mm1-atomic-cpudown-i386.pre/arch/i386/kernel/apic.c	2004-02-04 15:38:31.000000000 +1100
+++ .24305-2.6.3-mm1-atomic-cpudown-i386/arch/i386/kernel/apic.c	2004-02-20 10:31:00.000000000 +1100
@@ -26,6 +26,7 @@
 #include <linux/mc146818rtc.h>
 #include <linux/kernel_stat.h>
 #include <linux/sysdev.h>
+#include <linux/cpu.h>
 
 #include <asm/atomic.h>
 #include <asm/smp.h>
@@ -1035,6 +1036,10 @@ inline void smp_local_timer_interrupt(st
 {
 	int cpu = smp_processor_id();
 
+	/* FIXME: Actually remove timer interrupt in __cpu_disable() --RR */
+	if (cpu_is_offline(cpu))
+		return;
+
 	x86_do_profile(regs);
 
 	if (--per_cpu(prof_counter, cpu) <= 0) {
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .24305-2.6.3-mm1-atomic-cpudown-i386.pre/arch/i386/kernel/io_apic.c .24305-2.6.3-mm1-atomic-cpudown-i386/arch/i386/kernel/io_apic.c
--- .24305-2.6.3-mm1-atomic-cpudown-i386.pre/arch/i386/kernel/io_apic.c	2004-02-18 23:55:46.000000000 +1100
+++ .24305-2.6.3-mm1-atomic-cpudown-i386/arch/i386/kernel/io_apic.c	2004-02-20 10:31:00.000000000 +1100
@@ -614,7 +614,10 @@ repeat:
 	if (time_after(jiffies, prev_balance_time+balanced_irq_interval)) {
 		Dprintk("balanced_irq: calling do_irq_balance() %lu\n",
 					jiffies);
+		/* Disable preempt to stop cpus going down. */
+		preempt_disable();
 		do_irq_balance();
+		preempt_enable();
 		prev_balance_time = jiffies;
 		time_remaining = balanced_irq_interval;
 	}
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .24305-2.6.3-mm1-atomic-cpudown-i386.pre/arch/i386/kernel/irq.c .24305-2.6.3-mm1-atomic-cpudown-i386/arch/i386/kernel/irq.c
--- .24305-2.6.3-mm1-atomic-cpudown-i386.pre/arch/i386/kernel/irq.c	2004-02-18 23:55:46.000000000 +1100
+++ .24305-2.6.3-mm1-atomic-cpudown-i386/arch/i386/kernel/irq.c	2004-02-20 10:31:01.000000000 +1100
@@ -34,6 +34,8 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/kallsyms.h>
+#include <linux/notifier.h>
+#include <linux/cpu.h>
 
 #include <asm/atomic.h>
 #include <asm/io.h>
@@ -144,9 +146,8 @@ int show_interrupts(struct seq_file *p, 
 
 	if (i == 0) {
 		seq_printf(p, "           ");
-		for (j=0; j<NR_CPUS; j++)
-			if (cpu_online(j))
-				seq_printf(p, "CPU%d       ",j);
+		for_each_cpu(j)
+			seq_printf(p, "CPU%d       ",j);
 		seq_putc(p, '\n');
 	}
 
@@ -159,9 +160,8 @@ int show_interrupts(struct seq_file *p, 
 #ifndef CONFIG_SMP
 		seq_printf(p, "%10u ", kstat_irqs(i));
 #else
-		for (j = 0; j < NR_CPUS; j++)
-			if (cpu_online(j))
-				seq_printf(p, "%10u ", kstat_cpu(j).irqs[i]);
+		for_each_cpu(j)
+			seq_printf(p, "%10u ", kstat_cpu(j).irqs[i]);
 #endif
 		seq_printf(p, " %14s", irq_desc[i].handler->typename);
 		seq_printf(p, "  %s", action->name);
@@ -174,15 +174,13 @@ skip:
 		spin_unlock_irqrestore(&irq_desc[i].lock, flags);
 	} else if (i == NR_IRQS) {
 		seq_printf(p, "NMI: ");
-		for (j = 0; j < NR_CPUS; j++)
-			if (cpu_online(j))
-				seq_printf(p, "%10u ", nmi_count(j));
+		for_each_cpu(j)
+			seq_printf(p, "%10u ", nmi_count(j));
 		seq_putc(p, '\n');
 #ifdef CONFIG_X86_LOCAL_APIC
 		seq_printf(p, "LOC: ");
-		for (j = 0; j < NR_CPUS; j++)
-			if (cpu_online(j))
-				seq_printf(p, "%10u ", irq_stat[j].apic_timer_irqs);
+		for_each_cpu(j)
+			seq_printf(p, "%10u ", irq_stat[j].apic_timer_irqs);
 		seq_putc(p, '\n');
 #endif
 		seq_printf(p, "ERR: %10u\n", atomic_read(&irq_err_count));
@@ -405,6 +403,8 @@ void enable_irq(unsigned int irq)
 	spin_unlock_irqrestore(&desc->lock, flags);
 }
 
+static int irqs_stabilizing;
+
 /*
  * do_IRQ handles all normal device IRQ's (the special
  * SMP cross-CPU interrupts have their own specific
@@ -429,6 +429,12 @@ asmlinkage unsigned int do_IRQ(struct pt
 
 	irq_enter();
 
+	if (cpu_is_offline(smp_processor_id())
+	    && system_running
+	    && !irqs_stabilizing)
+		printk(KERN_ERR "IRQ %i on offline %i\n",
+		       irq, smp_processor_id());
+
 #ifdef CONFIG_DEBUG_STACKOVERFLOW
 	/* Debugging check for stack overflow: is there less than 1KB free? */
 	{
@@ -964,7 +971,48 @@ static int irq_affinity_write_proc(struc
 
 	return full_count;
 }
+#endif
+
+#ifdef CONFIG_HOTPLUG_CPU
+#include <mach_apic.h>
+
+void fixup_irqs(void)
+{
+	unsigned int irq;
+	static int warned;
+
+	for (irq = 0; irq < NR_IRQS; irq++) {
+		cpumask_t mask;
+		cpus_and(mask, irq_affinity[irq], cpu_online_map);
+		if (any_online_cpu(mask) == NR_CPUS) {
+			printk("Breaking affinity for irq %i\n", irq);
+			mask = cpu_online_map;
+		}
+		if (irq_desc[irq].handler->set_affinity)
+			irq_desc[irq].handler->set_affinity(irq, mask);
+		else if (irq_desc[irq].action && !(warned++))
+			printk("Cannot set affinity for irq %i\n", irq);
+	}
 
+#if 0
+	irqs_stabilizing = 1;
+	barrier();
+	/* Ingo Molnar says: "after the IO-APIC masks have been redirected
+	   [note the nop - the interrupt-enable boundary on x86 is two
+	   instructions from sti] - to flush out pending hardirqs and
+	   IPIs. After this point nothing is supposed to reach this CPU." */
+	__asm__ __volatile__("sti; nop; cli");
+	barrier();
+	irqs_stabilizing = 0;
+#else
+	/* That doesn't seem sufficient.  Give it 0.02ms. */
+	irqs_stabilizing = 1;
+	local_irq_enable();
+	udelay(20);
+	local_irq_disable();
+	irqs_stabilizing = 0;
+#endif
+}
 #endif
 
 static int prof_cpu_mask_read_proc (char *page, char **start, off_t off,
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .24305-2.6.3-mm1-atomic-cpudown-i386.pre/arch/i386/kernel/process.c .24305-2.6.3-mm1-atomic-cpudown-i386/arch/i386/kernel/process.c
--- .24305-2.6.3-mm1-atomic-cpudown-i386.pre/arch/i386/kernel/process.c	2004-02-18 23:55:46.000000000 +1100
+++ .24305-2.6.3-mm1-atomic-cpudown-i386/arch/i386/kernel/process.c	2004-02-20 10:31:01.000000000 +1100
@@ -14,6 +14,7 @@
 #define __KERNEL_SYSCALLS__
 #include <stdarg.h>
 
+#include <linux/cpu.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
 #include <linux/fs.h>
@@ -55,6 +56,9 @@
 #include <linux/irq.h>
 #include <linux/err.h>
 
+#include <asm/tlbflush.h>
+#include <asm/cpu.h>
+
 asmlinkage void ret_from_fork(void) __asm__("ret_from_fork");
 
 int hlt_counter;
@@ -133,6 +137,35 @@ static void poll_idle (void)
 	}
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+/* We don't actually take CPU down, just spin without interrupts. */
+static inline void play_dead(void)
+{
+	/* Ack it */
+	__get_cpu_var(cpu_state) = CPU_DEAD;
+
+	disable_timer_nmi_watchdog();
+
+	/* We shouldn't have to disable interrupts while dead, but
+	 * some interrupts just don't seem to go away, and this makes
+	 * it "work" for testing purposes. */
+	/* Death loop */
+	while (__get_cpu_var(cpu_state) != CPU_UP_PREPARE)
+		cpu_relax();
+
+	local_irq_disable();
+	__flush_tlb_all();
+	cpu_set(smp_processor_id(), cpu_online_map);
+	local_irq_enable();
+	enable_timer_nmi_watchdog();
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
@@ -149,6 +182,8 @@ void cpu_idle (void)
 			if (!idle)
 				idle = default_idle;
 
+			if (cpu_is_offline(smp_processor_id()))
+				play_dead();
 			irq_stat[smp_processor_id()].idle_timestamp = jiffies;
 			idle();
 		}
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .24305-2.6.3-mm1-atomic-cpudown-i386.pre/arch/i386/kernel/smp.c .24305-2.6.3-mm1-atomic-cpudown-i386/arch/i386/kernel/smp.c
--- .24305-2.6.3-mm1-atomic-cpudown-i386.pre/arch/i386/kernel/smp.c	2004-02-18 23:55:46.000000000 +1100
+++ .24305-2.6.3-mm1-atomic-cpudown-i386/arch/i386/kernel/smp.c	2004-02-20 10:31:01.000000000 +1100
@@ -19,6 +19,7 @@
 #include <linux/mc146818rtc.h>
 #include <linux/cache.h>
 #include <linux/interrupt.h>
+#include <linux/cpu.h>
 
 #include <asm/mtrr.h>
 #include <asm/pgalloc.h>
@@ -164,6 +165,8 @@ inline void send_IPI_mask_bitmask(cpumas
 	unsigned long cfg;
 	unsigned long flags;
 
+	WARN_ON(mask & ~cpus_coerce(cpu_online_map));
+
 	local_irq_save(flags);
 		
 	/*
@@ -347,21 +350,21 @@ out:
 static void flush_tlb_others(cpumask_t cpumask, struct mm_struct *mm,
 						unsigned long va)
 {
-	cpumask_t tmp;
 	/*
 	 * A couple of (to be removed) sanity checks:
 	 *
-	 * - we do not send IPIs to not-yet booted CPUs.
 	 * - current CPU must not be in mask
 	 * - mask must exist :)
 	 */
 	BUG_ON(cpus_empty(cpumask));
-
-	cpus_and(tmp, cpumask, cpu_online_map);
-	BUG_ON(!cpus_equal(cpumask, tmp));
 	BUG_ON(cpu_isset(smp_processor_id(), cpumask));
 	BUG_ON(!mm);
 
+	/* If a CPU which we ran on has gone down, OK. */
+	cpus_and(cpumask, cpumask, cpu_online_map);
+	if (cpus_empty(cpumask))
+		return;
+
 	/*
 	 * i'm not happy about this global shared spinlock in the
 	 * MM hot path, but we'll see how contended it is.
@@ -474,6 +477,7 @@ void smp_send_nmi_allbutself(void)
  */
 void smp_send_reschedule(int cpu)
 {
+	WARN_ON(cpu_is_offline(cpu));
 	send_IPI_mask(cpumask_of_cpu(cpu), RESCHEDULE_VECTOR);
 }
 
@@ -514,10 +518,16 @@ int smp_call_function (void (*func) (voi
  */
 {
 	struct call_data_struct data;
-	int cpus = num_online_cpus()-1;
+	int cpus;
 
-	if (!cpus)
+	/* Holding any lock stops cpus from going down. */
+	spin_lock(&call_lock);
+	cpus = num_online_cpus()-1;
+
+	if (!cpus) {
+		spin_unlock(&call_lock);
 		return 0;
+	}
 
 	data.func = func;
 	data.info = info;
@@ -526,7 +536,6 @@ int smp_call_function (void (*func) (voi
 	if (wait)
 		atomic_set(&data.finished, 0);
 
-	spin_lock(&call_lock);
 	call_data = &data;
 	mb();
 	
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .24305-2.6.3-mm1-atomic-cpudown-i386.pre/arch/i386/kernel/smpboot.c .24305-2.6.3-mm1-atomic-cpudown-i386/arch/i386/kernel/smpboot.c
--- .24305-2.6.3-mm1-atomic-cpudown-i386.pre/arch/i386/kernel/smpboot.c	2004-02-18 23:55:46.000000000 +1100
+++ .24305-2.6.3-mm1-atomic-cpudown-i386/arch/i386/kernel/smpboot.c	2004-02-20 10:31:01.000000000 +1100
@@ -44,6 +44,9 @@
 #include <linux/smp_lock.h>
 #include <linux/irq.h>
 #include <linux/bootmem.h>
+#include <linux/notifier.h>
+#include <linux/cpu.h>
+#include <linux/percpu.h>
 
 #include <linux/delay.h>
 #include <linux/mc146818rtc.h>
@@ -84,6 +87,9 @@ extern unsigned char trampoline_data [];
 extern unsigned char trampoline_end  [];
 static unsigned char *trampoline_base;
 
+/* State of each CPU. */
+DEFINE_PER_CPU(int, cpu_state) = { 0 };
+
 /*
  * Currently trivial. Write the real->protected mode
  * bootstrap into the page concerned. The caller
@@ -1328,6 +1335,9 @@ __init void arch_init_sched_domains(void
    who understands all this stuff should rewrite it properly. --RR 15/Jul/02 */
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
+	smp_commenced_mask = cpumask_of_cpu(0);
+	cpu_callin_map = cpumask_of_cpu(0);
+	mb();
 	smp_boot_cpus(max_cpus);
 }
 
@@ -1337,20 +1347,86 @@ void __devinit smp_prepare_boot_cpu(void
 	cpu_set(smp_processor_id(), cpu_callout_map);
 }
 
-int __devinit __cpu_up(unsigned int cpu)
+#ifdef CONFIG_HOTPLUG_CPU
+extern void fixup_irqs(void);
+
+/* must be called with the cpucontrol mutex held */
+static int __devinit cpu_enable(unsigned int cpu)
 {
-	/* This only works at boot for x86.  See "rewrite" above. */
-	if (cpu_isset(cpu, smp_commenced_mask)) {
-		local_irq_enable();
-		return -ENOSYS;
+	/* get the target out of its holding state */
+	per_cpu(cpu_state, cpu) = CPU_UP_PREPARE;
+	wmb();
+
+	/* wait for the processor to ack it. timeout? */
+	while (!cpu_online(cpu))
+		cpu_relax();
+
+	fixup_irqs();
+
+	return 0;
+}
+
+int __cpu_disable(void)
+{
+	/*
+	 * Perhaps use cpufreq to drop frequency, but that could go
+	 * into generic code.
+ 	 *
+	 * We won't take down the boot processor on i386 due to some
+	 * interrupts only being able to be serviced by the BSP.
+	 * Especially so if we're not using an IOAPIC	-zwane
+	 */
+	if (smp_processor_id() == 0)
+		return -EBUSY;
+
+	fixup_irqs();
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
 	}
+ 	printk(KERN_ERR "CPU %u didn't die...\n", cpu);
+}
+#else /* ... !CONFIG_HOTPLUG_CPU */
+int __cpu_disable(unsigned int cpu)
+{
+	return -ENOSYS;
+}
 
+void __cpu_die(unsigned int cpu)
+{
+	/* We said "no" in __cpu_disable */
+	BUG();
+}
+#endif /* CONFIG_HOTPLUG_CPU */
+
+int __devinit __cpu_up(unsigned int cpu)
+{
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
+		return 0;
+	}
+#endif
+
 	local_irq_enable();
 	/* Unleash the CPU! */
 	cpu_set(cpu, smp_commenced_mask);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .24305-2.6.3-mm1-atomic-cpudown-i386.pre/include/asm-i386/cpu.h .24305-2.6.3-mm1-atomic-cpudown-i386/include/asm-i386/cpu.h
--- .24305-2.6.3-mm1-atomic-cpudown-i386.pre/include/asm-i386/cpu.h	2003-09-22 10:09:11.000000000 +1000
+++ .24305-2.6.3-mm1-atomic-cpudown-i386/include/asm-i386/cpu.h	2004-02-20 10:31:01.000000000 +1100
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .24305-2.6.3-mm1-atomic-cpudown-i386.pre/include/asm-i386/smp.h .24305-2.6.3-mm1-atomic-cpudown-i386/include/asm-i386/smp.h
--- .24305-2.6.3-mm1-atomic-cpudown-i386.pre/include/asm-i386/smp.h	2004-02-18 23:56:01.000000000 +1100
+++ .24305-2.6.3-mm1-atomic-cpudown-i386/include/asm-i386/smp.h	2004-02-20 10:31:01.000000000 +1100
@@ -84,6 +84,9 @@ static __inline int logical_smp_processo
 }
 
 #endif
+
+extern int __cpu_disable(void);
+extern void __cpu_die(unsigned int cpu);
 #endif /* !__ASSEMBLY__ */
 
 #define NO_PROC_ID		0xFF		/* No processor magic marker */


-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

