Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262382AbVCVXPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbVCVXPl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 18:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbVCVXPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 18:15:41 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:9370 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262382AbVCVXOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 18:14:32 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: swsusp smp problems... [was Re: swsusp: Remove arch-specific references from generic code]
Date: Wed, 23 Mar 2005 00:14:16 +0100
User-Agent: KMail/1.7.1
Cc: kernel list <linux-kernel@vger.kernel.org>
References: <20050316001207.GI21292@elf.ucw.cz> <200503211134.10431.rjw@sisk.pl> <20050321104120.GB28507@elf.ucw.cz>
In-Reply-To: <20050321104120.GB28507@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_JbKQCWoK/nKa+UP"
Message-Id: <200503230014.17135.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_JbKQCWoK/nKa+UP
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

Sorry for the delay, I had an urgent work to do yestarday ...

On Monday, 21 of March 2005 11:41, Pavel Machek wrote:
> Hi!
> 
> > > At least part of them is caused by CONFIG_MTRR. I had to disable it on
> > > i386 to make it work...
> > 
> > Later today I'll check if that helps on x86-64.

On vanilla 2.6.11-mm4 processes freeze successfully when CONFIG_MTRR
is disabled, but it doesn't help if the CPU hotplug code is used before freezing
the processes.


> > Anyway in the meantime I have played a bit with the CPU hotplug code.
> > It needs some work, but looks promising.  I've changed disable_nonboot_cpus()
> > to use the CPU hotplug code and it seems to work.  Well, almost, because some
> > traces of the second CPU remain in the kernel, as some things do not work
> > properly (eg flush_tlb_others() is called with a mask that triggers a BUG()
> > in it etc.).  This should not be difficult to get fixed, however.  Strangely enough,
> > the processes still fail to freeze after the second CPU has been disabled
> > (specifically one of them, which is "syslogd").  I'm going to investigate this
> > more thoroughly.
> > 
> > Turning the second CPU back on does not work for me, but in fact I haven't
> > looked at it so far.
> 
> Can youm mail me (and probably l-k) the latest diffs? I started
> playing with it, too... (remember that scrap-metal machine?).

All right, the current diff between 2.6.11-mm4 and my development tree on the
SMP box is attached.  It's quite big, as it contains the CPU hotplug code that
I've dragged to the x86-64 tree.  There's a lot of debug stuff (probably
bugs too) in it and it doesn't let the box actually suspend.  Also, it doesn't
enable the non-boot CPUs after they've been disabled.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

--Boundary-00=_JbKQCWoK/nKa+UP
Content-Type: text/x-diff;
  charset="iso-8859-2";
  name="smp-swsusp-050322.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="smp-swsusp-050322.diff"

diff -Nrup linux-2.6.11-mm4/arch/x86_64/Kconfig linux-2.6.11-mm4-new/arch/x86_64/Kconfig
--- linux-2.6.11-mm4/arch/x86_64/Kconfig	2005-03-17 01:04:34.000000000 +0100
+++ linux-2.6.11-mm4-new/arch/x86_64/Kconfig	2005-03-18 00:13:17.000000000 +0100
@@ -451,6 +451,16 @@ config UNORDERED_IO
 
 source "drivers/pci/Kconfig"
 
+config HOTPLUG_CPU
+	bool "Support for hot-pluggable CPUs (EXPERIMENTAL)"
+	depends on SMP && HOTPLUG && EXPERIMENTAL
+	---help---
+	  Say Y here to experiment with turning CPUs off and on
+	  or if you want to use software suspend (swsusp) with SMP.  CPUs
+	  can be controlled through /sys/devices/system/cpu.
+
+	  Say N.
+
 source "drivers/pcmcia/Kconfig"
 
 source "drivers/pci/hotplug/Kconfig"
diff -Nrup linux-2.6.11-mm4/arch/x86_64/kernel/apic.c linux-2.6.11-mm4-new/arch/x86_64/kernel/apic.c
--- linux-2.6.11-mm4/arch/x86_64/kernel/apic.c	2005-03-17 01:04:34.000000000 +0100
+++ linux-2.6.11-mm4-new/arch/x86_64/kernel/apic.c	2005-03-20 21:22:50.000000000 +0100
@@ -816,7 +816,7 @@ void __init setup_secondary_APIC_clock(v
 	local_irq_enable();
 }
 
-void __init disable_APIC_timer(void)
+void disable_APIC_timer(void)
 {
 	if (using_apic_timer) {
 		unsigned long v;
diff -Nrup linux-2.6.11-mm4/arch/x86_64/kernel/irq.c linux-2.6.11-mm4-new/arch/x86_64/kernel/irq.c
--- linux-2.6.11-mm4/arch/x86_64/kernel/irq.c	2005-03-17 01:04:34.000000000 +0100
+++ linux-2.6.11-mm4-new/arch/x86_64/kernel/irq.c	2005-03-21 00:12:14.000000000 +0100
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <asm/uaccess.h>
 #include <asm/io_apic.h>
+#include <linux/delay.h>
 
 atomic_t irq_err_count;
 #ifdef CONFIG_X86_IO_APIC
@@ -106,3 +107,43 @@ asmlinkage unsigned int do_IRQ(struct pt
 
 	return 1;
 }
+
+#ifdef CONFIG_HOTPLUG_CPU
+
+void fixup_irqs(cpumask_t map)
+{
+	unsigned int irq;
+	static int warned;
+
+	for (irq = 0; irq < NR_IRQS; irq++) {
+		cpumask_t mask;
+
+		cpus_and(mask, irq_affinity[irq], map);
+		if (any_online_cpu(mask) == NR_CPUS) {
+			printk("Breaking affinity for irq %i\n", irq);
+			mask = map;
+		}
+		if (irq_desc[irq].handler->set_affinity) {
+			printk("Setting affinity for irq %d to 0x%x\n", irq, mask);
+			irq_desc[irq].handler->set_affinity(irq, mask);
+		}
+		else if (irq_desc[irq].action && !(warned++))
+			printk("Cannot set affinity for irq %i\n", irq);
+	}
+
+#if 0
+	barrier();
+	/* Ingo Molnar says: "after the IO-APIC masks have been redirected
+	   [note the nop - the interrupt-enable boundary on x86 is two
+	   instructions from sti] - to flush out pending hardirqs and
+	   IPIs. After this point nothing is supposed to reach this CPU." */
+	__asm__ __volatile__("sti; nop; cli");
+	barrier();
+#else
+	/* That doesn't seem sufficient.  Give it 1ms. */
+	local_irq_enable();
+	mdelay(1);
+	local_irq_disable();
+#endif
+}
+#endif
diff -Nrup linux-2.6.11-mm4/arch/x86_64/kernel/process.c linux-2.6.11-mm4-new/arch/x86_64/kernel/process.c
--- linux-2.6.11-mm4/arch/x86_64/kernel/process.c	2005-03-18 00:03:32.000000000 +0100
+++ linux-2.6.11-mm4-new/arch/x86_64/kernel/process.c	2005-03-18 00:56:10.000000000 +0100
@@ -49,6 +49,7 @@
 #include <asm/desc.h>
 #include <asm/proto.h>
 #include <asm/ia32.h>
+#include <asm/cpu.h>
 
 asmlinkage extern void ret_from_fork(void);
 
@@ -154,6 +155,34 @@ void cpu_idle_wait(void)
 }
 EXPORT_SYMBOL_GPL(cpu_idle_wait);
 
+#ifdef CONFIG_HOTPLUG_CPU
+#include <asm/nmi.h>
+/* We don't actually take CPU down, just spin without interrupts. */
+static inline void play_dead(void)
+{
+	/* Ack it */
+	__get_cpu_var(cpu_state) = CPU_DEAD;
+
+	/* We shouldn't have to disable interrupts while dead, but
+	* some interrupts just don't seem to go away, and this makes
+	* it "work" for testing purposes. */
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
@@ -174,6 +203,10 @@ void cpu_idle (void)
 			idle = pm_idle;
 			if (!idle)
 				idle = default_idle;
+
+			if (cpu_is_offline(smp_processor_id()))
+				play_dead();
+
 			idle();
 		}
 
diff -Nrup linux-2.6.11-mm4/arch/x86_64/kernel/smpboot.c linux-2.6.11-mm4-new/arch/x86_64/kernel/smpboot.c
--- linux-2.6.11-mm4/arch/x86_64/kernel/smpboot.c	2005-03-17 01:04:34.000000000 +0100
+++ linux-2.6.11-mm4-new/arch/x86_64/kernel/smpboot.c	2005-03-20 22:02:55.000000000 +0100
@@ -76,6 +76,9 @@ struct cpuinfo_x86 cpu_data[NR_CPUS] __c
 cpumask_t cpu_sibling_map[NR_CPUS] __cacheline_aligned;
 cpumask_t cpu_core_map[NR_CPUS] __cacheline_aligned;
 
+/* State of each CPU. */
+DEFINE_PER_CPU(int, cpu_state) = { 0 };
+
 /*
  * Trampoline 80x86 program as an array.
  */
@@ -919,13 +922,97 @@ void __devinit smp_prepare_boot_cpu(void
 	cpu_set(smp_processor_id(), cpu_callout_map);
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
+int __cpu_disable(void)
+{
+	cpumask_t map = cpu_online_map;
+	int cpu = smp_processor_id();
+
+	printk(KERN_WARNING "__cpu_disable(): cpu = %d\n", cpu);
+	/*
+	 * Perhaps use cpufreq to drop frequency, but that could go
+	 * into generic code.
+ 	 *
+	 * We won't take down the boot processor on x86-64
+	 */
+	if (cpu == 0)
+		return -EBUSY;
+
+	/* We enable the timer again on the exit path of the death loop */
+	disable_APIC_timer();
+	/* Allow any queued timer interrupts to get serviced */
+	local_irq_enable();
+	mdelay(1);
+	local_irq_disable();
+
+	cpu_clear(cpu, map);
+	fixup_irqs(map);
+	/* It's now safe to remove this processor from the online map */
+	__flush_tlb_global();
+	cpu_clear(cpu, cpu_online_map);
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
+#ifdef CONFIG_HOTPLUG_CPU
+	/* Already up, and in cpu_quiescent now? */
+	if (cpu_isset(cpu, smp_commenced_mask)) {
+		cpu_enable(cpu);
+		return 0;
+	}
+#else
 	/* This only works at boot for x86.  See "rewrite" above. */
 	if (cpu_isset(cpu, smp_commenced_mask)) {
 		local_irq_enable();
 		return -ENOSYS;
 	}
+#endif
 
 	/* In case one didn't come up */
 	if (!cpu_isset(cpu, cpu_callin_map)) {
diff -Nrup linux-2.6.11-mm4/arch/x86_64/kernel/traps.c linux-2.6.11-mm4-new/arch/x86_64/kernel/traps.c
--- linux-2.6.11-mm4/arch/x86_64/kernel/traps.c	2005-03-18 00:03:24.000000000 +0100
+++ linux-2.6.11-mm4-new/arch/x86_64/kernel/traps.c	2005-03-18 00:09:24.000000000 +0100
@@ -590,6 +590,12 @@ asmlinkage void default_do_nmi(struct pt
 {
 	unsigned char reason = 0;
 
+#ifdef CONFIG_HOTPLUG_CPU
+	/* Ignore offline CPUs */
+	if (!cpu_online(smp_processor_id()))
+		return;
+#endif
+
 	/* Only the BSP gets external NMIs from the system.  */
 	if (!smp_processor_id())
 		reason = get_nmi_reason();
diff -Nrup linux-2.6.11-mm4/drivers/serial/serial_core.c linux-2.6.11-mm4-new/drivers/serial/serial_core.c
--- linux-2.6.11-mm4/drivers/serial/serial_core.c	2005-03-17 01:04:37.000000000 +0100
+++ linux-2.6.11-mm4-new/drivers/serial/serial_core.c	2005-03-18 22:54:35.000000000 +0100
@@ -1831,6 +1831,9 @@ int uart_suspend_port(struct uart_driver
 {
 	struct uart_state *state = drv->state + port->line;
 
+	if (uart_console(port))
+		return 0;
+
 	down(&state->sem);
 
 	if (state->info && state->info->flags & UIF_INITIALIZED) {
@@ -1869,6 +1872,9 @@ int uart_resume_port(struct uart_driver 
 {
 	struct uart_state *state = drv->state + port->line;
 
+	if (uart_console(port))
+		return 0;
+
 	down(&state->sem);
 
 	uart_change_pm(state, 0);
diff -Nrup linux-2.6.11-mm4/include/asm-x86_64/irq.h linux-2.6.11-mm4-new/include/asm-x86_64/irq.h
--- linux-2.6.11-mm4/include/asm-x86_64/irq.h	2005-03-17 01:04:38.000000000 +0100
+++ linux-2.6.11-mm4-new/include/asm-x86_64/irq.h	2005-03-16 23:55:13.000000000 +0100
@@ -10,6 +10,9 @@
  *	<tomsoft@informatik.tu-chemnitz.de>
  */
 
+#include <linux/config.h>
+#include <linux/sched.h>
+
 #define TIMER_IRQ 0
 
 /*
@@ -52,4 +55,8 @@ struct irqaction;
 struct pt_regs;
 int handle_IRQ_event(unsigned int, struct pt_regs *, struct irqaction *);
 
+#ifdef CONFIG_HOTPLUG_CPU
+extern void fixup_irqs(cpumask_t map);
+#endif
+
 #endif /* _ASM_IRQ_H */
diff -Nrup linux-2.6.11-mm4/include/asm-x86_64/smp.h linux-2.6.11-mm4-new/include/asm-x86_64/smp.h
--- linux-2.6.11-mm4/include/asm-x86_64/smp.h	2005-03-17 01:04:38.000000000 +0100
+++ linux-2.6.11-mm4-new/include/asm-x86_64/smp.h	2005-03-17 00:01:05.000000000 +0100
@@ -145,6 +145,9 @@ static __inline int logical_smp_processo
 	/* we don't want to mark this access volatile - bad code generation */
 	return GET_APIC_LOGICAL_ID(*(unsigned long *)(APIC_BASE+APIC_LDR));
 }
+
+extern int __cpu_disable(void);
+extern void __cpu_die(unsigned int cpu);
 #endif
 
 #endif
diff -Nrup linux-2.6.11-mm4/include/linux/suspend.h linux-2.6.11-mm4-new/include/linux/suspend.h
--- linux-2.6.11-mm4/include/linux/suspend.h	2005-03-18 01:03:14.000000000 +0100
+++ linux-2.6.11-mm4-new/include/linux/suspend.h	2005-03-18 01:04:07.000000000 +0100
@@ -61,10 +61,10 @@ static inline int software_suspend(void)
 #endif
 
 #ifdef CONFIG_SMP
-extern void disable_nonboot_cpus(void);
+extern int disable_nonboot_cpus(void);
 extern void enable_nonboot_cpus(void);
 #else
-static inline void disable_nonboot_cpus(void) {}
+static inline int disable_nonboot_cpus(void) { return 0; }
 static inline void enable_nonboot_cpus(void) {}
 #endif
 
diff -Nrup linux-2.6.11-mm4/kernel/power/disk.c linux-2.6.11-mm4-new/kernel/power/disk.c
--- linux-2.6.11-mm4/kernel/power/disk.c	2005-03-17 01:04:39.000000000 +0100
+++ linux-2.6.11-mm4-new/kernel/power/disk.c	2005-03-21 00:26:41.000000000 +0100
@@ -117,8 +117,8 @@ static void finish(void)
 {
 	device_resume();
 	platform_finish();
-	enable_nonboot_cpus();
 	thaw_processes();
+	enable_nonboot_cpus();
 	pm_restore_console();
 }
 
@@ -127,8 +127,6 @@ static int prepare_processes(void)
 {
 	int error;
 
-	pm_prepare_console();
-
 	sys_sync();
 
 	if (freeze_processes()) {
@@ -151,8 +149,8 @@ static int prepare_processes(void)
 
 static void unprepare_processes(void)
 {
-	enable_nonboot_cpus();
 	thaw_processes();
+	enable_nonboot_cpus();
 	pm_restore_console();
 }
 
@@ -160,11 +158,9 @@ static int prepare_devices(void)
 {
 	int error;
 
-	disable_nonboot_cpus();
 	if ((error = device_suspend(PMSG_FREEZE))) {
 		printk("Some devices failed to suspend\n");
 		platform_finish();
-		enable_nonboot_cpus();
 		return error;
 	}
 
@@ -184,13 +180,22 @@ int pm_suspend_disk(void)
 {
 	int error;
 
+	pm_prepare_console();
+
+	if ((error = disable_nonboot_cpus())) {
+		/*enable_nonboot_cpus();*/
+		pm_restore_console();
+		return error;
+	}
 	error = prepare_processes();
-	if (!error) {
+	error = -EFAULT;
+	ssleep(5);
+	if (!error)
 		error = prepare_devices();
-	}
-
 	if (error) {
-		unprepare_processes();
+		thaw_processes();
+		/*enable_nonboot_cpus();*/
+		pm_restore_console();
 		return error;
 	}
 
diff -Nrup linux-2.6.11-mm4/kernel/power/Kconfig linux-2.6.11-mm4-new/kernel/power/Kconfig
--- linux-2.6.11-mm4/kernel/power/Kconfig	2005-03-02 08:38:25.000000000 +0100
+++ linux-2.6.11-mm4-new/kernel/power/Kconfig	2005-03-18 00:15:26.000000000 +0100
@@ -28,7 +28,7 @@ config PM_DEBUG
 
 config SOFTWARE_SUSPEND
 	bool "Software Suspend (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && PM && SWAP
+	depends on EXPERIMENTAL && PM && SWAP && (HOTPLUG_CPU || !SMP)
 	---help---
 	  Enable the possibility of suspending the machine.
 	  It doesn't need APM.
diff -Nrup linux-2.6.11-mm4/kernel/power/smp.c linux-2.6.11-mm4-new/kernel/power/smp.c
--- linux-2.6.11-mm4/kernel/power/smp.c	2005-03-17 01:04:39.000000000 +0100
+++ linux-2.6.11-mm4-new/kernel/power/smp.c	2005-03-21 00:12:39.000000000 +0100
@@ -7,79 +7,52 @@
  * This file is released under the GPLv2.
  */
 
-#undef DEBUG
-
 #include <linux/smp_lock.h>
 #include <linux/interrupt.h>
 #include <linux/suspend.h>
 #include <linux/module.h>
 #include <asm/atomic.h>
 #include <asm/tlbflush.h>
+#include <asm/cpu.h>
 
-static atomic_t cpu_counter, freeze;
-
-
-static void smp_pause(void * data)
-{
-	struct saved_context ctxt;
-	__save_processor_state(&ctxt);
-	printk("Sleeping in:\n");
-	dump_stack();
-	atomic_inc(&cpu_counter);
-	while (atomic_read(&freeze)) {
-		/* FIXME: restore takes place at random piece inside this.
-		   This should probably be written in assembly, and
-		   preserve general-purpose registers, too
-
-		   What about stack? We may need to move to new stack here.
-
-		   This should better be ran with interrupts disabled.
-		 */
-		cpu_relax();
-		barrier();
-	}
-	atomic_dec(&cpu_counter);
-	__restore_processor_state(&ctxt);
-}
-
-static cpumask_t oldmask;
+cpumask_t frozen_cpus;
 
-void disable_nonboot_cpus(void)
+int disable_nonboot_cpus(void)
 {
-	printk("Freezing CPUs (at %d)", smp_processor_id());
-	oldmask = current->cpus_allowed;
-	set_cpus_allowed(current, cpumask_of_cpu(0));
-	current->state = TASK_INTERRUPTIBLE;
-	schedule_timeout(HZ);
-	printk("...");
-	BUG_ON(smp_processor_id() != 0);
-
-	/* FIXME: for this to work, all the CPUs must be running
-	 * "idle" thread (or we deadlock). Is that guaranteed? */
+	int cpu, error;
 
-	atomic_set(&cpu_counter, 0);
-	atomic_set(&freeze, 1);
-	smp_call_function(smp_pause, NULL, 0, 0);
-	while (atomic_read(&cpu_counter) < (num_online_cpus() - 1)) {
-		cpu_relax();
-		barrier();
+	error = 0;
+	cpus_clear(frozen_cpus);
+	printk("Freezing cpus ...\n");
+	for_each_online_cpu(cpu) {
+		if (cpu == 0)
+			continue;
+		error = cpu_down(cpu);
+		if (!error) {
+			cpu_set(cpu, frozen_cpus);
+			printk("CPU%d is down\n", cpu);
+			continue;
+		}
+		printk("Error taking cpu %d down: %d\n", cpu, error);
 	}
-	printk("ok\n");
+	BUG_ON(smp_processor_id() != 0);
+	return error;
 }
 
 void enable_nonboot_cpus(void)
 {
-	printk("Restarting CPUs");
-	atomic_set(&freeze, 0);
-	while (atomic_read(&cpu_counter)) {
-		cpu_relax();
-		barrier();
-	}
-	printk("...");
-	set_cpus_allowed(current, oldmask);
-	schedule();
-	printk("ok\n");
+	int cpu, error;
 
+	printk("Thawing cpus ...\n");
+	for_each_cpu_mask(cpu, frozen_cpus) {
+		if (cpu == 0)
+			continue;
+		error = cpu_up(cpu);
+		if (!error) {
+			printk("CPU%d is up\n", cpu);
+			continue;
+		}
+		printk("Error taking cpu %d up: %d\n", cpu, error);
+		panic("Not enough cpus");
+	}
 }
-
-
diff -Nrup linux-2.6.11-mm4/kernel/stop_machine.c linux-2.6.11-mm4-new/kernel/stop_machine.c
--- linux-2.6.11-mm4/kernel/stop_machine.c	2005-03-02 08:37:47.000000000 +0100
+++ linux-2.6.11-mm4-new/kernel/stop_machine.c	2005-03-20 21:09:31.000000000 +0100
@@ -175,10 +175,13 @@ struct task_struct *__stop_machine_run(i
 
 	down(&stopmachine_mutex);
 
+	printk("__stop_machine_run(): cpu = %d\n", cpu);
 	/* If they don't care which CPU fn runs on, bind to any online one. */
 	if (cpu == NR_CPUS)
 		cpu = _smp_processor_id();
 
+	printk("__stop_machine_run(): Running on CPU %d\n", _smp_processor_id()); /*RJW*/
+	printk("__stop_machine_run(): Destination CPU %d\n", cpu); /*RJW*/
 	p = kthread_create(do_stop, &smdata, "kstopmachine");
 	if (!IS_ERR(p)) {
 		kthread_bind(p, cpu);

--Boundary-00=_JbKQCWoK/nKa+UP--
