Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261914AbUEFSv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbUEFSv6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 14:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262772AbUEFSv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 14:51:58 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:29004 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261914AbUEFSs7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 14:48:59 -0400
Date: Thu, 6 May 2004 11:48:13 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Matthew Dobson <colpatch@us.ibm.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Joe Korty <joe.korty@ccur.com>,
       Jesse Barnes <jbarnes@sgi.com>
Subject: [PATCH mask 3/15] pj-fix-3-ashoks-updated-cpuhotplug-7-7
Message-Id: <20040506114813.7d897e49.pj@sgi.com>
In-Reply-To: <20040506111814.62d1f537.pj@sgi.com>
References: <20040506111814.62d1f537.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Name: hotcpu_ia64.patch
Author: Ashok Raj (Intel Corporation)
D: Supports basic ability to enable hotplug functions for IA64.
D: Code is just evolving, and there are several loose ends to tie up.
D:
D: What this code drop does
D: - Support logical online and offline
D: - Handles interrupt migration without loss of interrupts.
D: - Handles stress fine > 24+ hrs with make -j/ftp/rcp workloads
D: - Handles irq migration from a dying cpu without loss of interrupts.
D: What needs to be done
D: - Boot CPU removal support, with platform level authentication
D: - Putting cpu being removed in BOOT_RENDEZ mode.


---

 linux-2.6.6-rc3-root/arch/ia64/Kconfig           |    9 +
 linux-2.6.6-rc3-root/arch/ia64/kernel/iosapic.c  |    7 -
 linux-2.6.6-rc3-root/arch/ia64/kernel/irq.c      |  103 +++++++++++++++++
 linux-2.6.6-rc3-root/arch/ia64/kernel/irq_ia64.c |   60 +++++++++-
 linux-2.6.6-rc3-root/arch/ia64/kernel/process.c  |   43 +++++++
 linux-2.6.6-rc3-root/arch/ia64/kernel/sal.c      |   13 ++
 linux-2.6.6-rc3-root/arch/ia64/kernel/smp.c      |   26 ++++
 linux-2.6.6-rc3-root/arch/ia64/kernel/smpboot.c  |  136 +++++++++++++++++++++--
 linux-2.6.6-rc3-root/arch/ia64/kernel/time.c     |    5 
 linux-2.6.6-rc3-root/include/asm-ia64/smp.h      |    2 
 10 files changed, 386 insertions(+), 18 deletions(-)

diff -puN arch/ia64/Kconfig~hotcpu_ia64 arch/ia64/Kconfig
--- linux-2.6.6-rc3/arch/ia64/Kconfig~hotcpu_ia64	2004-05-04 20:52:19.527778099 -0700
+++ linux-2.6.6-rc3-root/arch/ia64/Kconfig	2004-05-04 20:52:19.553168737 -0700
@@ -78,6 +78,15 @@ config IA64_HP_SIM
 
 endchoice
 
+config HOTPLUG_CPU
+    bool "Support for hot-pluggable CPUs (EXPERIMENTAL)"
+    depends on SMP && HOTPLUG && EXPERIMENTAL
+	default n
+    ---help---
+      Say Y here to experiment with turning CPUs off and on.  CPUs
+      can be controlled through /sys/devices/system/cpu/cpu#.
+      Say N if you want to disable cpu hotplug.
+
 choice
 	prompt "Processor type"
 	default ITANIUM
diff -puN arch/ia64/kernel/irq.c~hotcpu_ia64 arch/ia64/kernel/irq.c
--- linux-2.6.6-rc3/arch/ia64/kernel/irq.c~hotcpu_ia64	2004-05-04 20:52:19.529731225 -0700
+++ linux-2.6.6-rc3-root/arch/ia64/kernel/irq.c	2004-05-04 20:52:19.554145300 -0700
@@ -8,6 +8,12 @@
  * instead of just grabbing them. Thus setups with different IRQ numbers
  * shouldn't result in any weird surprises, and installing new handlers
  * should be easier.
+ *
+ * Copyright (C) Ashok Raj<ashok.raj@intel.com>, Intel Corporation 2004
+ *
+ * 4/14/2004: Added code to handle cpu migration and do safe irq
+ *			migration without lossing interrupts for iosapic
+ *			architecture.
  */
 
 /*
@@ -27,6 +33,7 @@
 #include <linux/timex.h>
 #include <linux/slab.h>
 #include <linux/random.h>
+#include <linux/cpu.h>
 #include <linux/ctype.h>
 #include <linux/smp_lock.h>
 #include <linux/init.h>
@@ -35,14 +42,17 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/kallsyms.h>
+#include <linux/notifier.h>
 
 #include <asm/atomic.h>
+#include <asm/cpu.h>
 #include <asm/io.h>
 #include <asm/smp.h>
 #include <asm/system.h>
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
+#include <asm/tlbflush.h>
 #include <asm/delay.h>
 #include <asm/irq.h>
 
@@ -1006,6 +1016,99 @@ static int irq_affinity_write_proc (stru
 
 #endif /* CONFIG_SMP */
 
+#ifdef CONFIG_HOTPLUG_CPU
+unsigned int vectors_in_migration[NR_IRQS];
+
+/*
+ * Since cpu_online_map is already updated, we just need to check for
+ * affinity that has zeros
+ */
+static void migrate_irqs(void)
+{
+	cpumask_t	mask;
+	irq_desc_t *desc;
+	int 		irq, new_cpu;
+
+	for (irq=0; irq < NR_IRQS; irq++) {
+		desc = irq_descp(irq);
+
+		/*
+		 * No handling for now.
+		 * TBD: Implement a disable function so we can now
+		 * tell CPU not to respond to these local intr sources.
+		 * such as ITV,CPEI,MCA etc.
+		 */
+		if (desc->status == IRQ_PER_CPU)
+			continue;
+
+		cpus_and(mask, irq_affinity[irq], cpu_online_map);
+		if (any_online_cpu(mask) == NR_CPUS) {
+			/*
+			 * Save it for phase 2 processing
+			 */
+			vectors_in_migration[irq] = irq;
+
+			new_cpu = any_online_cpu(cpu_online_map);
+			mask = cpumask_of_cpu(new_cpu);
+
+			/*
+			 * Al three are essential, currently WARN_ON.. maybe panic?
+			 */
+			if (desc->handler && desc->handler->disable &&
+				desc->handler->enable && desc->handler->set_affinity) {
+				desc->handler->disable(irq);
+				desc->handler->set_affinity(irq, mask);
+				desc->handler->enable(irq);
+			} else {
+				WARN_ON((!(desc->handler) || !(desc->handler->disable) ||
+						!(desc->handler->enable) ||
+						!(desc->handler->set_affinity)));
+			}
+		}
+	}
+}
+
+void fixup_irqs(void)
+{
+	unsigned int irq;
+	extern void ia64_process_pending_intr(void);
+
+	ia64_set_itv(1<<16);
+	/*
+	 * Phase 1: Locate irq's bound to this cpu and
+	 * relocate them for cpu removal.
+	 */
+	migrate_irqs();
+
+	/*
+	 * Phase 2: Perform interrupt processing for all entries reported in
+	 * local APIC.
+	 */
+	ia64_process_pending_intr();
+
+	/*
+	 * Phase 3: Now handle any interrupts not captured in local APIC.
+	 * This is to account for cases that device interrupted during the time the
+	 * rte was being disabled and re-programmed.
+	 */
+	for (irq=0; irq < NR_IRQS; irq++) {
+		if (vectors_in_migration[irq]) {
+			vectors_in_migration[irq]=0;
+			do_IRQ(irq, NULL);
+		}
+	}
+
+	/*
+	 * Now let processor die. We do irq disable and max_xtp() to
+	 * ensure there is no more interrupts routed to this processor.
+	 * But the local timer interrupt can have 1 pending which we
+	 * take care in timer_interrupt().
+	 */
+	max_xtp();
+	local_irq_disable();
+}
+#endif
+
 static int prof_cpu_mask_read_proc (char *page, char **start, off_t off,
 			int count, int *eof, void *data)
 {
diff -puN arch/ia64/kernel/process.c~hotcpu_ia64 arch/ia64/kernel/process.c
--- linux-2.6.6-rc3/arch/ia64/kernel/process.c~hotcpu_ia64	2004-05-04 20:52:19.530707788 -0700
+++ linux-2.6.6-rc3-root/arch/ia64/kernel/process.c	2004-05-04 20:52:19.554145300 -0700
@@ -7,6 +7,7 @@
 #define __KERNEL_SYSCALLS__	/* see <asm/unistd.h> */
 #include <linux/config.h>
 
+#include <linux/cpu.h>
 #include <linux/pm.h>
 #include <linux/elf.h>
 #include <linux/errno.h>
@@ -14,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/module.h>
+#include <linux/notifier.h>
 #include <linux/personality.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
@@ -22,13 +24,17 @@
 #include <linux/thread_info.h>
 #include <linux/unistd.h>
 #include <linux/efi.h>
+#include <linux/interrupt.h>
 
+#include <asm/cpu.h>
 #include <asm/delay.h>
 #include <asm/elf.h>
 #include <asm/ia32.h>
+#include <asm/irq.h>
 #include <asm/pgalloc.h>
 #include <asm/processor.h>
 #include <asm/sal.h>
+#include <asm/tlbflush.h>
 #include <asm/uaccess.h>
 #include <asm/unwind.h>
 #include <asm/user.h>
@@ -180,6 +186,40 @@ default_idle (void)
 			safe_halt();
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+/* We don't actually take CPU down, just spin without interrupts. */
+static inline void play_dead(void)
+{
+	extern void ia64_cpu_local_tick (void);
+	/* Ack it */
+	__get_cpu_var(cpu_state) = CPU_DEAD;
+
+	/* We shouldn't have to disable interrupts while dead, but
+	 * some interrupts just don't seem to go away, and this makes
+	 * it "work" for testing purposes. */
+	max_xtp();
+	local_irq_disable();
+	/* Death loop */
+	while (__get_cpu_var(cpu_state) != CPU_UP_PREPARE)
+		cpu_relax();
+
+	/*
+	 * Enable timer interrupts from now on
+	 * Not required if we put processor in SAL_BOOT_RENDEZ mode.
+	 */
+	local_flush_tlb_all();
+	cpu_set(smp_processor_id(), cpu_online_map);
+	wmb();
+	ia64_cpu_local_tick ();
+	local_irq_enable();
+}
+#else
+static inline void play_dead(void)
+{
+	BUG();
+}
+#endif /* CONFIG_HOTPLUG_CPU */
+
 void __attribute__((noreturn))
 cpu_idle (void *unused)
 {
@@ -195,7 +235,6 @@ cpu_idle (void *unused)
 		if (!need_resched())
 			min_xtp();
 #endif
-
 		while (!need_resched()) {
 			if (mark_idle)
 				(*mark_idle)(1);
@@ -210,6 +249,8 @@ cpu_idle (void *unused)
 #endif
 		schedule();
 		check_pgt_cache();
+		if (cpu_is_offline(smp_processor_id()))
+			play_dead();
 	}
 }
 
diff -puN arch/ia64/kernel/smpboot.c~hotcpu_ia64 arch/ia64/kernel/smpboot.c
--- linux-2.6.6-rc3/arch/ia64/kernel/smpboot.c~hotcpu_ia64	2004-05-04 20:52:19.532660914 -0700
+++ linux-2.6.6-rc3-root/arch/ia64/kernel/smpboot.c	2004-05-04 20:52:19.555121863 -0700
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/acpi.h>
 #include <linux/bootmem.h>
+#include <linux/cpu.h>
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -22,10 +23,12 @@
 #include <linux/kernel.h>
 #include <linux/kernel_stat.h>
 #include <linux/mm.h>
+#include <linux/notifier.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/spinlock.h>
 #include <linux/efi.h>
+#include <linux/percpu.h>
 
 #include <asm/atomic.h>
 #include <asm/bitops.h>
@@ -44,6 +47,7 @@
 #include <asm/ptrace.h>
 #include <asm/sal.h>
 #include <asm/system.h>
+#include <asm/tlbflush.h>
 #include <asm/unistd.h>
 
 #define SMP_DEBUG 0
@@ -75,6 +79,11 @@ extern unsigned long ia64_iobase;
 
 task_t *task_for_booting_cpu;
 
+/*
+ * State for each CPU
+ */
+DEFINE_PER_CPU(int, cpu_state);
+
 /* Bitmasks of currently online, and possible CPUs */
 cpumask_t cpu_online_map;
 EXPORT_SYMBOL(cpu_online_map);
@@ -281,12 +290,16 @@ smp_callin (void)
 	cpuid = smp_processor_id();
 	phys_id = hard_smp_processor_id();
 
-	if (cpu_test_and_set(cpuid, cpu_online_map)) {
+	if (cpu_online(cpuid)) {
 		printk(KERN_ERR "huh, phys CPU#0x%x, CPU#0x%x already present??\n",
 		       phys_id, cpuid);
 		BUG();
 	}
 
+	lock_ipi_calllock();
+	cpu_set(cpuid, cpu_online_map);
+	unlock_ipi_calllock();
+
 	smp_setup_percpu_timer();
 
 	/*
@@ -357,29 +370,51 @@ fork_by_hand (void)
 	return copy_process(CLONE_VM|CLONE_IDLETASK, 0, 0, 0, NULL, NULL);
 }
 
+struct create_idle {
+	struct task_struct *idle;
+	struct completion done;
+};
+
+void
+do_fork_idle(void *_c_idle)
+{
+	struct create_idle *c_idle = _c_idle;
+
+	c_idle->idle = fork_by_hand();
+	complete(&c_idle->done);
+}
+
 static int __devinit
 do_boot_cpu (int sapicid, int cpu)
 {
-	struct task_struct *idle;
 	int timeout;
+	struct create_idle c_idle;
+	DECLARE_WORK(work, do_fork_idle, &c_idle);
 
+	init_completion(&c_idle.done);
 	/*
 	 * We can't use kernel_thread since we must avoid to reschedule the child.
 	 */
-	idle = fork_by_hand();
-	if (IS_ERR(idle))
+	if (!keventd_up() || current_is_keventd())
+		work.func(work.data);
+	else {
+		schedule_work(&work);
+		wait_for_completion(&c_idle.done);
+	}
+
+	if (IS_ERR(c_idle.idle))
 		panic("failed fork for CPU %d", cpu);
-	wake_up_forked_process(idle);
+	wake_up_forked_process(c_idle.idle);
 
 	/*
 	 * We remove it from the pidhash and the runqueue
 	 * once we got the process:
 	 */
-	init_idle(idle, cpu);
+	init_idle(c_idle.idle, cpu);
 
-	unhash_process(idle);
+	unhash_process(c_idle.idle);
 
-	task_for_booting_cpu = idle;
+	task_for_booting_cpu = c_idle.idle;
 
 	Dprintk("Sending wakeup vector %lu to AP 0x%x/0x%x.\n", ap_wakeup_vector, cpu, sapicid);
 
@@ -438,8 +473,12 @@ smp_build_cpu_map (void)
 	int sapicid, cpu, i;
 	int boot_cpu_id = hard_smp_processor_id();
 
-	for (cpu = 0; cpu < NR_CPUS; cpu++)
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
 		ia64_cpu_to_sapicid[cpu] = -1;
+#ifdef CONFIG_HOTPLUG_CPU
+		cpu_set(cpu, cpu_possible_map);
+#endif
+	}
 
 	ia64_cpu_to_sapicid[0] = boot_cpu_id;
 	cpus_clear(cpu_present_map);
@@ -546,6 +585,74 @@ void __devinit smp_prepare_boot_cpu(void
 	cpu_set(smp_processor_id(), cpu_callin_map);
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+extern void fixup_irqs(void);
+/* must be called with cpucontrol mutex held */
+static int __devinit cpu_enable(unsigned int cpu)
+{
+	per_cpu(cpu_state,cpu) = CPU_UP_PREPARE;
+	wmb();
+
+	while (!cpu_online(cpu))
+		cpu_relax();
+	return 0;
+}
+
+int __cpu_disable(void)
+{
+	int cpu = smp_processor_id();
+
+	/*
+	 * dont permit boot processor for now
+	 */
+	if (cpu == 0)
+		return -EBUSY;
+
+	fixup_irqs();
+	local_flush_tlb_all();
+	printk ("Disabled cpu %u\n", smp_processor_id());
+	return 0;
+}
+
+void __cpu_die(unsigned int cpu)
+{
+	unsigned int i;
+
+	for (i = 0; i < 100; i++) {
+		/* They ack this in play_dead by setting CPU_DEAD */
+		if (per_cpu(cpu_state, cpu) == CPU_DEAD)
+		{
+			/*
+			 * TBD: Enable this when physical removal
+			 * or when we put the processor is put in
+			 * SAL_BOOT_RENDEZ mode
+			 * cpu_clear(cpu, cpu_callin_map);
+			 */
+			return;
+		}
+		current->state = TASK_UNINTERRUPTIBLE;
+		schedule_timeout(HZ/10);
+	}
+ 	printk(KERN_ERR "CPU %u didn't die...\n", cpu);
+}
+#else /* !CONFIG_HOTPLUG_CPU */
+static int __devinit cpu_enable(unsigned int cpu)
+{
+	return 0;
+}
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
+
 void
 smp_cpus_done (unsigned int dummy)
 {
@@ -574,6 +681,17 @@ __cpu_up (unsigned int cpu)
 	if (sapicid == -1)
 		return -EINVAL;
 
+	/*
+	 * Already booted.. just enable and get outa idle lool
+	 */
+	if (cpu_isset(cpu, cpu_callin_map))
+	{
+		cpu_enable(cpu);
+		local_irq_enable();
+		while (!cpu_isset(cpu, cpu_online_map))
+			mb();
+		return 0;
+	}
 	/* Processor goes to start_secondary(), sets online flag */
 	ret = do_boot_cpu(sapicid, cpu);
 	if (ret < 0)
diff -puN arch/ia64/kernel/smp.c~hotcpu_ia64 arch/ia64/kernel/smp.c
--- linux-2.6.6-rc3/arch/ia64/kernel/smp.c~hotcpu_ia64	2004-05-04 20:52:19.533637477 -0700
+++ linux-2.6.6-rc3-root/arch/ia64/kernel/smp.c	2004-05-04 20:52:19.556098426 -0700
@@ -71,10 +71,23 @@ static volatile struct call_data_struct 
 /* This needs to be cacheline aligned because it is written to by *other* CPUs.  */
 static DEFINE_PER_CPU(u64, ipi_operation) ____cacheline_aligned;
 
+extern void cpu_halt (void);
+
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
 static void
 stop_this_cpu (void)
 {
-	extern void cpu_halt (void);
 	/*
 	 * Remove this CPU:
 	 */
@@ -84,6 +97,17 @@ stop_this_cpu (void)
 	cpu_halt();
 }
 
+void
+cpu_die(void)
+{
+	max_xtp();
+	local_irq_disable();
+	cpu_halt();
+	/* Should never be here */
+	BUG();
+	for (;;);
+}
+
 irqreturn_t
 handle_IPI (int irq, void *dev_id, struct pt_regs *regs)
 {
diff -puN arch/ia64/kernel/time.c~hotcpu_ia64 arch/ia64/kernel/time.c
--- linux-2.6.6-rc3/arch/ia64/kernel/time.c~hotcpu_ia64	2004-05-04 20:52:19.534614040 -0700
+++ linux-2.6.6-rc3-root/arch/ia64/kernel/time.c	2004-05-04 20:52:19.556098426 -0700
@@ -10,6 +10,7 @@
  */
 #include <linux/config.h>
 
+#include <linux/cpu.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -244,6 +245,10 @@ timer_interrupt (int irq, void *dev_id, 
 {
 	unsigned long new_itm;
 
+	if (unlikely(cpu_is_offline(smp_processor_id()))) {
+		return IRQ_HANDLED;
+	}
+
 	platform_timer_interrupt(irq, dev_id, regs);
 
 	new_itm = local_cpu_data->itm_next;
diff -puN include/asm-ia64/smp.h~hotcpu_ia64 include/asm-ia64/smp.h
--- linux-2.6.6-rc3/include/asm-ia64/smp.h~hotcpu_ia64	2004-05-04 20:52:19.536567166 -0700
+++ linux-2.6.6-rc3-root/include/asm-ia64/smp.h	2004-05-04 20:52:19.556098426 -0700
@@ -120,6 +120,8 @@ extern void smp_do_timer (struct pt_regs
 extern int smp_call_function_single (int cpuid, void (*func) (void *info), void *info,
 				     int retry, int wait);
 extern void smp_send_reschedule (int cpu);
+extern void lock_ipi_calllock(void);
+extern void unlock_ipi_calllock(void);
 
 #endif /* CONFIG_SMP */
 #endif /* _ASM_IA64_SMP_H */
diff -puN arch/ia64/kernel/iosapic.c~hotcpu_ia64 arch/ia64/kernel/iosapic.c
--- linux-2.6.6-rc3/arch/ia64/kernel/iosapic.c~hotcpu_ia64	2004-05-04 20:52:19.537543729 -0700
+++ linux-2.6.6-rc3-root/arch/ia64/kernel/iosapic.c	2004-05-04 20:52:19.557074989 -0700
@@ -32,6 +32,8 @@
  * 03/02/19	B. Helgaas	Make pcat_compat system-wide, not per-IOSAPIC.
  *				Remove iosapic_address & gsi_base from external interfaces.
  *				Rationalize __init/__devinit attributes.
+ * 04/12/04 Ashok Raj	<ashok.raj@intel.com> Intel Corporation 2004
+ *				Updated to work with irq migration necessary for CPU Hotplug
  */
 /*
  * Here is what the interrupt logic between a PCI device and the kernel looks like:
@@ -189,8 +191,10 @@ set_rte (unsigned int vector, unsigned i
 	pol     = iosapic_intr_info[vector].polarity;
 	trigger = iosapic_intr_info[vector].trigger;
 	dmode   = iosapic_intr_info[vector].dmode;
+	vector &= (~IA64_IRQ_REDIRECTED);
 
 	redir = (dmode == IOSAPIC_LOWEST_PRIORITY) ? 1 : 0;
+
 #ifdef CONFIG_SMP
 	{
 		unsigned int irq;
@@ -312,9 +316,8 @@ iosapic_set_affinity (unsigned int irq, 
 
 	spin_lock_irqsave(&iosapic_lock, flags);
 	{
-		/* get current delivery mode by reading the low32 */
-		writel(IOSAPIC_RTE_LOW(rte_index), addr + IOSAPIC_REG_SELECT);
 		low32 = iosapic_intr_info[vec].low32 & ~(7 << IOSAPIC_DELIVERY_SHIFT);
+
 		if (redir)
 		        /* change delivery mode to lowest priority */
 			low32 |= (IOSAPIC_LOWEST_PRIORITY << IOSAPIC_DELIVERY_SHIFT);
diff -puN arch/ia64/kernel/irq_ia64.c~hotcpu_ia64 arch/ia64/kernel/irq_ia64.c
--- linux-2.6.6-rc3/arch/ia64/kernel/irq_ia64.c~hotcpu_ia64	2004-05-04 20:52:19.550239048 -0700
+++ linux-2.6.6-rc3-root/arch/ia64/kernel/irq_ia64.c	2004-05-04 20:52:19.557074989 -0700
@@ -10,6 +10,8 @@
  *
  * 09/15/00 Goutham Rao <goutham.rao@intel.com> Implemented pci_irq_to_vector
  *                      PCI to vector allocation routine.
+ * 04/14/2004 Ashok Raj <ashok.raj@intel.com>
+ *						Added CPU Hotplug handling for IPF.
  */
 
 #include <linux/config.h>
@@ -85,6 +87,11 @@ assign_irq_vector (int irq)
 
 extern unsigned int do_IRQ(unsigned long irq, struct pt_regs *regs);
 
+#ifdef CONFIG_SMP
+#	define IS_RESCHEDULE(vec)	(vec == IA64_IPI_RESCHEDULE)
+#else
+#	define IS_RESCHEDULE(vec)	(0)
+#endif
 /*
  * That's where the IVT branches when we get an external
  * interrupt. This branches to the correct hardware IRQ handler via
@@ -94,11 +101,6 @@ void
 ia64_handle_irq (ia64_vector vector, struct pt_regs *regs)
 {
 	unsigned long saved_tpr;
-#ifdef CONFIG_SMP
-#	define IS_RESCHEDULE(vec)	(vec == IA64_IPI_RESCHEDULE)
-#else
-#	define IS_RESCHEDULE(vec)	(0)
-#endif
 
 #if IRQ_DEBUG
 	{
@@ -162,6 +164,54 @@ ia64_handle_irq (ia64_vector vector, str
 	irq_exit();
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+/*
+ * This function emulates a interrupt processing when a cpu is about to be
+ * brought down.
+ */
+void ia64_process_pending_intr(void)
+{
+	ia64_vector vector;
+	unsigned long saved_tpr;
+	extern unsigned int vectors_in_migration[NR_IRQS];
+
+	vector = ia64_get_ivr();
+
+	 irq_enter();
+	 saved_tpr = ia64_getreg(_IA64_REG_CR_TPR);
+	 ia64_srlz_d();
+
+	 /*
+	  * Perform normal interrupt style processing
+	  */
+	while (vector != IA64_SPURIOUS_INT_VECTOR) {
+		if (!IS_RESCHEDULE(vector)) {
+			ia64_setreg(_IA64_REG_CR_TPR, vector);
+			ia64_srlz_d();
+
+			/*
+			 * Now try calling normal ia64_handle_irq as it would have got called
+			 * from a real intr handler. Try passing null for pt_regs, hopefully
+			 * it will work. I hope it works!.
+			 * Probably could shared code.
+			 */
+			vectors_in_migration[local_vector_to_irq(vector)]=0;
+			do_IRQ(local_vector_to_irq(vector), NULL);
+
+			/*
+			 * Disable interrupts and send EOI
+			 */
+			local_irq_disable();
+			ia64_setreg(_IA64_REG_CR_TPR, saved_tpr);
+		}
+		ia64_eoi();
+		vector = ia64_get_ivr();
+	}
+	irq_exit();
+}
+#endif
+
+
 #ifdef CONFIG_SMP
 extern irqreturn_t handle_IPI (int irq, void *dev_id, struct pt_regs *regs);
 
diff -puN arch/ia64/kernel/sal.c~hotcpu_ia64 arch/ia64/kernel/sal.c
--- linux-2.6.6-rc3/arch/ia64/kernel/sal.c~hotcpu_ia64	2004-05-04 20:52:19.551215611 -0700
+++ linux-2.6.6-rc3-root/arch/ia64/kernel/sal.c	2004-05-04 20:52:19.557074989 -0700
@@ -122,10 +122,23 @@ sal_desc_entry_point (void *p)
 static void __init
 set_smp_redirect (int flag)
 {
+#ifndef CONFIG_HOTPLUG_CPU
 	if (no_int_routing)
 		smp_int_redirect &= ~flag;
 	else
 		smp_int_redirect |= flag;
+#else
+	/*
+	 * For CPU Hotplug we dont want to do any chipset supported
+	 * interrupt redirection. The reason is this would require that
+	 * All interrupts be stopped and hard bind the irq to a cpu.
+	 * Later when the interrupt is fired we need to set the redir hint
+	 * on again in the vector. This is combersome for something that the
+	 * user mode irq balancer will solve anyways.
+	 */
+	no_int_routing=1;
+	smp_int_redirect &= ~flag;
+#endif
 }
 #else
 #define set_smp_redirect(flag)	do { } while (0)

_
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
