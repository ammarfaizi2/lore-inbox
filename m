Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbWEHFr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbWEHFr6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 01:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbWEHFri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 01:47:38 -0400
Received: from mga02.intel.com ([134.134.136.20]:43637 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932325AbWEHFrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 01:47:17 -0400
X-IronPort-AV: i="4.05,99,1146466800"; 
   d="scan'208"; a="32948549:sNHT142187346"
Subject: [PATCH 8/10] ia64 implementation of cpu bulk removal
From: Shaohua Li <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>, Ashok Raj <ashok.raj@intel.com>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 08 May 2006 13:45:55 +0800
Message-Id: <1147067155.2760.88.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ia64 specific implementation of cpu bulk removal. Add the config and make
__cpu_die/__cpu_disable work with cpumask_t.

Signed-off-by: Ashok Raj <ashok.raj@intel.com> 
Signed-off-by: Shaohua Li <shaohua.li@intel.com> 
---

 linux-2.6.17-rc3-root/arch/ia64/Kconfig          |   11 +
 linux-2.6.17-rc3-root/arch/ia64/kernel/irq.c     |   38 -----
 linux-2.6.17-rc3-root/arch/ia64/kernel/smpboot.c |  172 ++++++++++++++++++-----
 linux-2.6.17-rc3-root/arch/ia64/kernel/time.c    |    5 
 4 files changed, 158 insertions(+), 68 deletions(-)

diff -puN arch/ia64/Kconfig~ia64-bulk-cpu-hotplug arch/ia64/Kconfig
--- linux-2.6.17-rc3/arch/ia64/Kconfig~ia64-bulk-cpu-hotplug	2006-05-07 07:46:35.000000000 +0800
+++ linux-2.6.17-rc3-root/arch/ia64/Kconfig	2006-05-07 07:46:35.000000000 +0800
@@ -270,6 +270,17 @@ config HOTPLUG_CPU
 	  can be controlled through /sys/devices/system/cpu/cpu#.
 	  Say N if you want to disable CPU hotplug.
 
+config BULK_CPU_REMOVE
+	bool "Support for bulk removal of CPUs (EXPERIMENTAL)"
+	depends on HOTPLUG_CPU && EXPERIMENTAL
+	help
+	  Say Y if need the ability to remove more than one cpu during cpu
+	  removal. Current mechanisms may be in-efficient when a NUMA
+	  node is being removed, which would involve removing one cpu at a
+	  time. This will let interrupts, timers and processes to be bound
+	  to a CPU that might be removed right after the current cpu is
+	  being offlined.
+
 config SCHED_SMT
 	bool "SMT scheduler support"
 	depends on SMP
diff -puN arch/ia64/kernel/irq.c~ia64-bulk-cpu-hotplug arch/ia64/kernel/irq.c
--- linux-2.6.17-rc3/arch/ia64/kernel/irq.c~ia64-bulk-cpu-hotplug	2006-05-07 07:46:35.000000000 +0800
+++ linux-2.6.17-rc3-root/arch/ia64/kernel/irq.c	2006-05-07 07:46:35.000000000 +0800
@@ -114,7 +114,7 @@ unsigned int vectors_in_migration[NR_IRQ
  * Since cpu_online_map is already updated, we just need to check for
  * affinity that has zeros
  */
-static void migrate_irqs(void)
+void ia64_migrate_irqs(void)
 {
 	cpumask_t	mask;
 	irq_desc_t *desc;
@@ -159,34 +159,9 @@ static void migrate_irqs(void)
 	}
 }
 
-void fixup_irqs(void)
+void ia64_fixup_irqs(void)
 {
 	unsigned int irq;
-	extern void ia64_process_pending_intr(void);
-	extern void ia64_disable_timer(void);
-	extern volatile int time_keeper_id;
-
-	ia64_disable_timer();
-
-	/*
-	 * Find a new timesync master
-	 */
-	if (smp_processor_id() == time_keeper_id) {
-		time_keeper_id = first_cpu(cpu_online_map);
-		printk ("CPU %d is now promoted to time-keeper master\n", time_keeper_id);
-	}
-
-	/*
-	 * Phase 1: Locate irq's bound to this cpu and
-	 * relocate them for cpu removal.
-	 */
-	migrate_irqs();
-
-	/*
-	 * Phase 2: Perform interrupt processing for all entries reported in
-	 * local APIC.
-	 */
-	ia64_process_pending_intr();
 
 	/*
 	 * Phase 3: Now handle any interrupts not captured in local APIC.
@@ -199,14 +174,5 @@ void fixup_irqs(void)
 			__do_IRQ(irq, NULL);
 		}
 	}
-
-	/*
-	 * Now let processor die. We do irq disable and max_xtp() to
-	 * ensure there is no more interrupts routed to this processor.
-	 * But the local timer interrupt can have 1 pending which we
-	 * take care in timer_interrupt().
-	 */
-	max_xtp();
-	local_irq_disable();
 }
 #endif
diff -puN arch/ia64/kernel/smpboot.c~ia64-bulk-cpu-hotplug arch/ia64/kernel/smpboot.c
--- linux-2.6.17-rc3/arch/ia64/kernel/smpboot.c~ia64-bulk-cpu-hotplug	2006-05-07 07:46:35.000000000 +0800
+++ linux-2.6.17-rc3-root/arch/ia64/kernel/smpboot.c	2006-05-07 07:46:35.000000000 +0800
@@ -639,24 +639,27 @@ clear_cpu_sibling_map(int cpu)
 }
 
 static void
-remove_siblinginfo(int cpu)
+remove_siblinginfo(cpumask_t remove_mask)
 {
 	int last = 0;
+	int cpu;
 
-	if (cpu_data(cpu)->threads_per_core == 1 &&
-	    cpu_data(cpu)->cores_per_socket == 1) {
-		cpu_clear(cpu, cpu_core_map[cpu]);
-		cpu_clear(cpu, cpu_sibling_map[cpu]);
-		return;
-	}
+	for_each_cpu_mask(cpu, remove_mask) {
+		if (cpu_data(cpu)->threads_per_core == 1 &&
+		    cpu_data(cpu)->cores_per_socket == 1) {
+			cpu_clear(cpu, cpu_core_map[cpu]);
+			cpu_clear(cpu, cpu_sibling_map[cpu]);
+			continue;
+		}
 
-	last = (cpus_weight(cpu_core_map[cpu]) == 1 ? 1 : 0);
+		last = (cpus_weight(cpu_core_map[cpu]) == 1 ? 1 : 0);
 
-	/* remove it from all sibling map's */
-	clear_cpu_sibling_map(cpu);
+		/* remove it from all sibling map's */
+		clear_cpu_sibling_map(cpu);
+	}
 }
 
-extern void fixup_irqs(void);
+extern void ia64_fixup_irqs(void);
 
 int migrate_platform_irqs(unsigned int cpu)
 {
@@ -699,49 +702,154 @@ int migrate_platform_irqs(unsigned int c
 }
 
 /* must be called with cpucontrol mutex held */
+static cpumask_t cpu_dead_mask = CPU_MASK_NONE;
+static cpumask_t cpu_dead_error_mask = CPU_MASK_NONE;
+static atomic_t disable_cpu_start = ATOMIC_INIT(0); /* 1:start, 2:error */
 int __cpu_disable(cpumask_t remove_mask)
 {
 	int cpu = smp_processor_id();
+	int master = 0;
+	extern void ia64_disable_timer(void);
+	extern void ia64_enable_timer(void);
+	extern void ia64_process_pending_intr(void);
+	extern void ia64_migrate_irqs(void);
+	extern volatile int time_keeper_id;
+
+	/* are we the master cpu? */
+	if (first_cpu(remove_mask) == cpu)
+		master = 1;
+
+	ia64_disable_timer();
+	if (master) {
+		int ret = 0, cpu_tmp;
+		cpumask_t temp_online_map, old_online_map;
+
+		/*
+		 * dont permit boot processor for now
+		 */
+		if (cpu_isset(0, remove_mask) && !bsp_remove_ok) {
+			printk ("Your platform does not support removal of BSP\n");
+			/* let slave report the error */
+			atomic_set(&disable_cpu_start, 2);
+			smp_wmb(); /* set error first */
+			cpu_set(cpu, cpu_dead_error_mask);
+			while (!cpus_equal(cpu_dead_error_mask, remove_mask))
+				cpu_relax();
+			atomic_set(&disable_cpu_start, 0);
+			cpus_clear(cpu_dead_error_mask);
+			ia64_enable_timer();
+			return -EBUSY;
+		}
 
-	BUG_ON(cpus_weight(remove_mask) != 1);
+		old_online_map = cpu_online_map;
+		cpus_andnot(temp_online_map, cpu_online_map, remove_mask);
+		cpu_online_map = temp_online_map;
+		/*
+		 * Find a new timesync master
+		 */
+		if (cpu_isset(time_keeper_id, remove_mask)) {
+			time_keeper_id = first_cpu(cpu_online_map);
+			printk ("CPU %d is now promoted to time-keeper master\n",
+								time_keeper_id);
+		}
+
+		/*
+		 * Check if platform irq's can be migrated
+		 */
+		for_each_cpu_mask(cpu_tmp, remove_mask) {
+			if ((ret = migrate_platform_irqs(cpu_tmp)))
+				break;
+		}
+		if (ret) {
+			cpu_online_map = old_online_map;
+			/* let slave report the error */
+			atomic_set(&disable_cpu_start, 2);
+			smp_wmb(); /* set error first */
+			cpu_set(cpu, cpu_dead_error_mask);
+			while (!cpus_equal(cpu_dead_error_mask, remove_mask))
+				cpu_relax();
+			atomic_set(&disable_cpu_start, 0);
+			cpus_clear(cpu_dead_error_mask);
+			ia64_enable_timer();
+			return -EBUSY;
+		}
+		/*
+		 * Phase I: IRQ migration: migrate irqs to eligible online cpus
+		 */
+		ia64_migrate_irqs();
+
+		smp_mb();
+		/* Let the party begin */
+		atomic_set(&disable_cpu_start, 1);
+	} else {
+		while (atomic_read(&disable_cpu_start) == 0)
+			cpu_relax();
+		if (atomic_read(&disable_cpu_start) == 2) {
+			ia64_enable_timer();
+			cpu_set(cpu, cpu_dead_error_mask);
+			return -EBUSY;
+		}
+	}
 	/*
-	 * dont permit boot processor for now
+	 * Phase II: IRQ Migration: process any local pending interrupts
+	 *           that were queued up.
 	 */
-	if (cpu == 0 && !bsp_remove_ok) {
-		printk ("Your platform does not support removal of BSP\n");
-		return (-EBUSY);
-	}
+	ia64_process_pending_intr();
 
-	cpu_clear(cpu, cpu_online_map);
+	/*
+	 * Now let processor die. We do irq disable and max_xtp() to
+	 * ensure there is no more interrupts routed to this processor.
+	 * But the local timer interrupt can have 1 pending which we
+	 * take care in timer_interrupt().
+	 */
+	max_xtp();
+	local_irq_disable();
 
-	if (migrate_platform_irqs(cpu)) {
-		cpu_set(cpu, cpu_online_map);
-		return (-EBUSY);
-	}
+	cpu_clear(cpu, cpu_callin_map);
+ 	cpu_clear(cpu, cpu_online_map);
+	smp_mb();
+	cpu_set(cpu, cpu_dead_mask);
+	if (!master)
+		return 0;
+	/* master does cleanup */
+	while (!cpus_equal(cpu_dead_mask, remove_mask))
+		cpu_relax();
+
+	remove_siblinginfo(remove_mask);
 
-	remove_siblinginfo(cpu);
-	cpu_clear(cpu, cpu_online_map);
-	fixup_irqs();
+	/*
+	 * Phase III: irq migration.
+	 */
+	ia64_fixup_irqs();
 	local_flush_tlb_all();
-	cpu_clear(cpu, cpu_callin_map);
+	cpus_clear(cpu_dead_mask);
+	atomic_set(&disable_cpu_start, 0);
 	return 0;
 }
 
 void __cpu_die(cpumask_t remove_mask)
 {
 	unsigned int i;
-	int cpu = first_cpu(remove_mask);
+	int cpu;
 
 	for (i = 0; i < 100; i++) {
 		/* They ack this in play_dead by setting CPU_DEAD */
-		if (per_cpu(cpu_state, cpu) == CPU_DEAD)
-		{
-			printk ("CPU %d is now offline\n", cpu);
-			return;
+		for_each_cpu_mask(cpu, remove_mask) {
+			if (per_cpu(cpu_state, cpu) == CPU_DEAD) {
+				printk ("CPU %d is now offline\n", cpu);
+				cpu_clear(cpu, remove_mask);
+			}
 		}
+		if (cpus_empty(remove_mask))
+			break;
+
 		msleep(100);
 	}
- 	printk(KERN_ERR "CPU %u didn't die...\n", cpu);
+
+	if (!cpus_empty(remove_mask)) {
+		for_each_cpu_mask(cpu, remove_mask)
+ 			printk(KERN_ERR "CPU %u didn't die...\n", cpu);
+	}
 }
 #else /* !CONFIG_HOTPLUG_CPU */
 int __cpu_disable(cpumask_t remove_mask)
diff -puN arch/ia64/kernel/time.c~ia64-bulk-cpu-hotplug arch/ia64/kernel/time.c
--- linux-2.6.17-rc3/arch/ia64/kernel/time.c~ia64-bulk-cpu-hotplug	2006-05-07 07:46:35.000000000 +0800
+++ linux-2.6.17-rc3-root/arch/ia64/kernel/time.c	2006-05-07 07:46:35.000000000 +0800
@@ -241,6 +241,11 @@ void __devinit ia64_disable_timer(void)
 	ia64_set_itv(1 << 16);
 }
 
+void __devinit ia64_enable_timer(void)
+{
+	ia64_set_itv(IA64_TIMER_VECTOR);
+}
+
 void __init
 time_init (void)
 {
_
