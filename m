Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbUGaUvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbUGaUvV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 16:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbUGaUvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 16:51:21 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:13014 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S262406AbUGaUt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 16:49:27 -0400
Date: Sat, 31 Jul 2004 16:53:04 -0400 (EDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>, lhcs-devel@lists.sourceforge.net
Subject: [PATCH][2.6-mm] i386 Hotplug CPU
In-Reply-To: <Pine.LNX.4.58.0407270137510.25781@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.58.0407270440200.23985@montezuma.fsmlabs.com>
References: <1090870667.22306.40.camel@pants.austin.ibm.com>
 <20040726170157.7f4b414c.akpm@osdl.org> <Pine.LNX.4.58.0407270137510.25781@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
	Could you consider taking the i386 arch support bits for cpu
hotplug? The main purpose is allowing for easier testing at each release.

Pulled from Rusty's previous changelog, plus a few additions (2,11,12)

1) Add CONFIG_HOTPLUG_CPU
2) disable local APIC timer on dead cpus.
3) Disable preempt around irq balancing to prevent CPUs going down.
4) Print irq stats for all possible cpus.
5) Debugging check for interrupts on offline cpus.
6) Hacky fixup_irqs() to redirect irqs when cpus go off/online.
7) play_dead() for offline cpus to spin inside.
8) Handle offline cpus set in flush_tlb_others().
9) Grab lock earlier in smp_call_function() to prevent CPUs going down.
10) Implement __cpu_disable() and __cpu_die().
11) Enable local interrupts in cpu_enable() after fixup_irqs()
12) Don't fiddle with NMI on dead cpu, but leave intact on other cpus.

 arch/i386/Kconfig          |    9 ++++
 arch/i386/kernel/apic.c    |    3 +
 arch/i386/kernel/io_apic.c |    2 +
 arch/i386/kernel/irq.c     |   81 ++++++++++++++++++++++++++++++++++++------
 arch/i386/kernel/msr.c     |    2 -
 arch/i386/kernel/process.c |   36 ++++++++++++++++++
 arch/i386/kernel/smp.c     |   25 ++++++++-----
 arch/i386/kernel/smpboot.c |   86 ++++++++++++++++++++++++++++++++++++++++++---
 arch/i386/kernel/traps.c   |    8 ++++
 include/asm-i386/cpu.h     |    2 +
 include/asm-i386/smp.h     |    3 +
 11 files changed, 229 insertions(+), 28 deletions(-)

Signed-off-by: Zwane Mwaikambo <zwane@fsmlabs.com>

Index: linux-2.6.8-rc2-mm1-lch/arch/i386/Kconfig
===================================================================
RCS file: /home/cvsroot/linux-2.6.8-rc2-mm1/arch/i386/Kconfig,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 Kconfig
--- linux-2.6.8-rc2-mm1-lch/arch/i386/Kconfig	28 Jul 2004 14:35:21 -0000	1.1.1.1
+++ linux-2.6.8-rc2-mm1-lch/arch/i386/Kconfig	30 Jul 2004 02:12:44 -0000
@@ -1168,6 +1168,15 @@ config SCx200
 	  This support is also available as a module.  If compiled as a
 	  module, it will be called scx200.

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
Index: linux-2.6.8-rc2-mm1-lch/arch/i386/kernel/apic.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.8-rc2-mm1/arch/i386/kernel/apic.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 apic.c
--- linux-2.6.8-rc2-mm1-lch/arch/i386/kernel/apic.c	28 Jul 2004 14:35:21 -0000	1.1.1.1
+++ linux-2.6.8-rc2-mm1-lch/arch/i386/kernel/apic.c	31 Jul 2004 18:16:45 -0000
@@ -26,6 +26,7 @@
 #include <linux/mc146818rtc.h>
 #include <linux/kernel_stat.h>
 #include <linux/sysdev.h>
+#include <linux/cpu.h>

 #include <asm/atomic.h>
 #include <asm/smp.h>
@@ -1007,7 +1008,7 @@ void __init setup_secondary_APIC_clock(v
 	local_irq_enable();
 }

-void __init disable_APIC_timer(void)
+void __devinit disable_APIC_timer(void)
 {
 	if (using_apic_timer) {
 		unsigned long v;
Index: linux-2.6.8-rc2-mm1-lch/arch/i386/kernel/io_apic.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.8-rc2-mm1/arch/i386/kernel/io_apic.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 io_apic.c
--- linux-2.6.8-rc2-mm1-lch/arch/i386/kernel/io_apic.c	28 Jul 2004 14:35:21 -0000	1.1.1.1
+++ linux-2.6.8-rc2-mm1-lch/arch/i386/kernel/io_apic.c	30 Jul 2004 02:12:44 -0000
@@ -574,9 +574,11 @@ static int balanced_irq(void *unused)
 		time_remaining = schedule_timeout(time_remaining);
 		if (time_after(jiffies,
 				prev_balance_time+balanced_irq_interval)) {
+			preempt_disable();
 			do_irq_balance();
 			prev_balance_time = jiffies;
 			time_remaining = balanced_irq_interval;
+			preempt_enable();
 		}
 	}
 	return 0;
Index: linux-2.6.8-rc2-mm1-lch/arch/i386/kernel/irq.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.8-rc2-mm1/arch/i386/kernel/irq.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 irq.c
--- linux-2.6.8-rc2-mm1-lch/arch/i386/kernel/irq.c	28 Jul 2004 14:35:21 -0000	1.1.1.1
+++ linux-2.6.8-rc2-mm1-lch/arch/i386/kernel/irq.c	30 Jul 2004 02:12:44 -0000
@@ -34,6 +34,8 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/kallsyms.h>
+#include <linux/notifier.h>
+#include <linux/cpu.h>

 #include <asm/atomic.h>
 #include <asm/io.h>
@@ -149,9 +151,8 @@ int show_interrupts(struct seq_file *p,

 	if (i == 0) {
 		seq_printf(p, "           ");
-		for (j=0; j<NR_CPUS; j++)
-			if (cpu_online(j))
-				seq_printf(p, "CPU%d       ",j);
+		for_each_cpu(j)
+			seq_printf(p, "CPU%d       ",j);
 		seq_putc(p, '\n');
 	}

@@ -164,9 +165,8 @@ int show_interrupts(struct seq_file *p,
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
@@ -179,15 +179,13 @@ skip:
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
@@ -408,6 +406,20 @@ void enable_irq(unsigned int irq)
 	spin_unlock_irqrestore(&desc->lock, flags);
 }

+#ifdef CONFIG_HOTPLUG_CPU
+static int irqs_stabilizing;
+
+#define irq_is_cpu_offline() do {				\
+	if (cpu_is_offline(smp_processor_id())			\
+	    && (system_state == SYSTEM_RUNNING)			\
+	    && !irqs_stabilizing)				\
+		printk(KERN_ERR "IRQ %i on offline %i\n",	\
+		       irq, smp_processor_id());		\
+} while (0)
+#else
+#define irq_is_cpu_offline()	do {} while (0)
+#endif
+
 /*
  * do_IRQ handles all normal device IRQ's (the special
  * SMP cross-CPU interrupts have their own specific
@@ -431,6 +443,7 @@ asmlinkage unsigned int do_IRQ(struct pt
 	unsigned int status;

 	irq_enter();
+	irq_is_cpu_offline();

 #ifdef CONFIG_DEBUG_STACKOVERFLOW
 	/* Debugging check for stack overflow: is there less than 1KB free? */
@@ -1025,7 +1038,51 @@ static int irq_affinity_write_proc(struc

 	return full_count;
 }
+#endif
+
+#ifdef CONFIG_HOTPLUG_CPU
+#include <mach_apic.h>

+void fixup_irqs(void)
+{
+	unsigned int irq;
+	static int warned;
+
+	for (irq = 0; irq < NR_IRQS; irq++) {
+		cpumask_t mask;
+		if (irq == 2)
+			continue;
+
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
+
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
Index: linux-2.6.8-rc2-mm1-lch/arch/i386/kernel/msr.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.8-rc2-mm1/arch/i386/kernel/msr.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 msr.c
--- linux-2.6.8-rc2-mm1-lch/arch/i386/kernel/msr.c	28 Jul 2004 14:35:21 -0000	1.1.1.1
+++ linux-2.6.8-rc2-mm1-lch/arch/i386/kernel/msr.c	31 Jul 2004 19:09:41 -0000
@@ -260,7 +260,7 @@ static struct file_operations msr_fops =
 	.open = msr_open,
 };

-static int msr_class_simple_device_add(int i)
+static int __devinit msr_class_simple_device_add(int i)
 {
 	int err = 0;
 	struct class_device *class_err;
Index: linux-2.6.8-rc2-mm1-lch/arch/i386/kernel/process.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.8-rc2-mm1/arch/i386/kernel/process.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 process.c
--- linux-2.6.8-rc2-mm1-lch/arch/i386/kernel/process.c	28 Jul 2004 14:35:21 -0000	1.1.1.1
+++ linux-2.6.8-rc2-mm1-lch/arch/i386/kernel/process.c	31 Jul 2004 19:51:06 -0000
@@ -13,6 +13,7 @@

 #include <stdarg.h>

+#include <linux/cpu.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
 #include <linux/fs.h>
@@ -54,6 +55,9 @@
 #include <linux/irq.h>
 #include <linux/err.h>

+#include <asm/tlbflush.h>
+#include <asm/cpu.h>
+
 asmlinkage void ret_from_fork(void) __asm__("ret_from_fork");

 int hlt_counter;
@@ -132,6 +136,36 @@ static void poll_idle (void)
 	}
 }

+#ifdef CONFIG_HOTPLUG_CPU
+#include <asm/nmi.h>
+/* We don't actually take CPU down, just spin without interrupts. */
+static inline void play_dead(void)
+{
+	disable_APIC_timer();
+
+	/* Ack it */
+	__get_cpu_var(cpu_state) = CPU_DEAD;
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
+	enable_APIC_timer();
+	local_irq_enable();
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
@@ -148,6 +182,8 @@ void cpu_idle (void)
 			if (!idle)
 				idle = default_idle;

+			if (cpu_is_offline(smp_processor_id()))
+				play_dead();
 			irq_stat[smp_processor_id()].idle_timestamp = jiffies;
 			idle();
 		}
Index: linux-2.6.8-rc2-mm1-lch/arch/i386/kernel/smp.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.8-rc2-mm1/arch/i386/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 smp.c
--- linux-2.6.8-rc2-mm1-lch/arch/i386/kernel/smp.c	28 Jul 2004 14:35:21 -0000	1.1.1.1
+++ linux-2.6.8-rc2-mm1-lch/arch/i386/kernel/smp.c	31 Jul 2004 20:02:59 -0000
@@ -19,6 +19,7 @@
 #include <linux/mc146818rtc.h>
 #include <linux/cache.h>
 #include <linux/interrupt.h>
+#include <linux/cpu.h>

 #include <asm/mtrr.h>
 #include <asm/tlbflush.h>
@@ -163,7 +164,7 @@ void send_IPI_mask_bitmask(cpumask_t cpu
 	unsigned long flags;

 	local_irq_save(flags);
-
+	WARN_ON(mask & ~cpus_addr(cpu_online_map)[0]);
 	/*
 	 * Wait for idle.
 	 */
@@ -345,21 +346,21 @@ out:
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
@@ -484,6 +485,7 @@ void smp_send_nmi_allbutself(void)
  */
 void smp_send_reschedule(int cpu)
 {
+	WARN_ON(cpu_is_offline(cpu));
 	send_IPI_mask(cpumask_of_cpu(cpu), RESCHEDULE_VECTOR);
 }

@@ -524,10 +526,16 @@ int smp_call_function (void (*func) (voi
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

 	/* Can deadlock when called with interrupts disabled */
 	WARN_ON(irqs_disabled());
@@ -539,7 +547,6 @@ int smp_call_function (void (*func) (voi
 	if (wait)
 		atomic_set(&data.finished, 0);

-	spin_lock(&call_lock);
 	call_data = &data;
 	mb();

Index: linux-2.6.8-rc2-mm1-lch/arch/i386/kernel/smpboot.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.8-rc2-mm1/arch/i386/kernel/smpboot.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 smpboot.c
--- linux-2.6.8-rc2-mm1-lch/arch/i386/kernel/smpboot.c	28 Jul 2004 14:35:21 -0000	1.1.1.1
+++ linux-2.6.8-rc2-mm1-lch/arch/i386/kernel/smpboot.c	31 Jul 2004 19:30:38 -0000
@@ -44,6 +44,9 @@
 #include <linux/smp_lock.h>
 #include <linux/irq.h>
 #include <linux/bootmem.h>
+#include <linux/notifier.h>
+#include <linux/cpu.h>
+#include <linux/percpu.h>

 #include <linux/delay.h>
 #include <linux/mc146818rtc.h>
@@ -88,6 +91,9 @@ extern unsigned char trampoline_end  [];
 static unsigned char *trampoline_base;
 static int trampoline_exec;

+/* State of each CPU. */
+DEFINE_PER_CPU(int, cpu_state) = { 0 };
+
 /*
  * Currently trivial. Write the real->protected mode
  * bootstrap into the page concerned. The caller
@@ -1139,6 +1145,9 @@ static void __init smp_boot_cpus(unsigne
    who understands all this stuff should rewrite it properly. --RR 15/Jul/02 */
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
+	smp_commenced_mask = cpumask_of_cpu(0);
+	cpu_callin_map = cpumask_of_cpu(0);
+	mb();
 	smp_boot_cpus(max_cpus);
 }

@@ -1148,20 +1157,87 @@ void __devinit smp_prepare_boot_cpu(void
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
+	/* counter the disable in fixup_irqs() */
+	local_irq_enable();
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
Index: linux-2.6.8-rc2-mm1-lch/arch/i386/kernel/traps.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.8-rc2-mm1/arch/i386/kernel/traps.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 traps.c
--- linux-2.6.8-rc2-mm1-lch/arch/i386/kernel/traps.c	28 Jul 2004 14:35:21 -0000	1.1.1.1
+++ linux-2.6.8-rc2-mm1-lch/arch/i386/kernel/traps.c	31 Jul 2004 20:44:55 -0000
@@ -627,6 +627,14 @@ asmlinkage void do_nmi(struct pt_regs *
 	nmi_enter();

 	cpu = smp_processor_id();
+
+#ifdef CONFIG_HOTPLUG_CPU
+	if (!cpu_online(cpu)) {
+		nmi_exit();
+		return;
+	}
+#endif
+
 	++nmi_count(cpu);

 	if (!nmi_callback(regs, cpu))
Index: linux-2.6.8-rc2-mm1-lch/include/asm-i386/cpu.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.8-rc2-mm1/include/asm-i386/cpu.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 cpu.h
--- linux-2.6.8-rc2-mm1-lch/include/asm-i386/cpu.h	28 Jul 2004 14:35:23 -0000	1.1.1.1
+++ linux-2.6.8-rc2-mm1-lch/include/asm-i386/cpu.h	30 Jul 2004 02:13:42 -0000
@@ -5,6 +5,7 @@
 #include <linux/cpu.h>
 #include <linux/topology.h>
 #include <linux/nodemask.h>
+#include <linux/percpu.h>

 #include <asm/node.h>

@@ -26,4 +27,5 @@ static inline int arch_register_cpu(int
 	return register_cpu(&cpu_devices[num].cpu, num, parent);
 }

+DECLARE_PER_CPU(int, cpu_state);
 #endif /* _ASM_I386_CPU_H_ */
Index: linux-2.6.8-rc2-mm1-lch/include/asm-i386/smp.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.8-rc2-mm1/include/asm-i386/smp.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 smp.h
--- linux-2.6.8-rc2-mm1-lch/include/asm-i386/smp.h	28 Jul 2004 14:35:23 -0000	1.1.1.1
+++ linux-2.6.8-rc2-mm1-lch/include/asm-i386/smp.h	30 Jul 2004 02:12:44 -0000
@@ -84,6 +84,9 @@ static __inline int logical_smp_processo
 }

 #endif
+
+extern int __cpu_disable(void);
+extern void __cpu_die(unsigned int cpu);
 #endif /* !__ASSEMBLY__ */

 #define NO_PROC_ID		0xFF		/* No processor magic marker */
