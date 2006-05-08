Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbWEHFrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbWEHFrY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 01:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbWEHFrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 01:47:20 -0400
Received: from mga02.intel.com ([134.134.136.20]:43637 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932326AbWEHFrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 01:47:11 -0400
X-IronPort-AV: i="4.05,99,1146466800"; 
   d="scan'208"; a="32948506:sNHT284113606"
Subject: [PATCH 6/10] i386 implementation of cpu bulk removal
From: Shaohua Li <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>, Ashok Raj <ashok.raj@intel.com>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 08 May 2006 13:45:52 +0800
Message-Id: <1147067152.2760.85.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i386 specific implementation of cpu bulk removal. Add the config and make
__cpu_die/__cpu_disable work with cpumask_t.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---

 linux-2.6.17-rc3-root/arch/i386/Kconfig          |   11 ++
 linux-2.6.17-rc3-root/arch/i386/kernel/smpboot.c |  118 ++++++++++++++++-------
 2 files changed, 97 insertions(+), 32 deletions(-)

diff -puN arch/i386/Kconfig~i386-bulk-cpu-hotplug arch/i386/Kconfig
--- linux-2.6.17-rc3/arch/i386/Kconfig~i386-bulk-cpu-hotplug	2006-05-07 07:46:01.000000000 +0800
+++ linux-2.6.17-rc3-root/arch/i386/Kconfig	2006-05-07 07:46:01.000000000 +0800
@@ -763,6 +763,17 @@ config HOTPLUG_CPU
 
 	  Say N.
 
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
 endmenu
 
 
diff -puN arch/i386/kernel/smpboot.c~i386-bulk-cpu-hotplug arch/i386/kernel/smpboot.c
--- linux-2.6.17-rc3/arch/i386/kernel/smpboot.c~i386-bulk-cpu-hotplug	2006-05-07 07:46:01.000000000 +0800
+++ linux-2.6.17-rc3-root/arch/i386/kernel/smpboot.c	2006-05-07 07:46:01.000000000 +0800
@@ -1317,35 +1317,43 @@ void __devinit smp_prepare_boot_cpu(void
 
 #ifdef CONFIG_HOTPLUG_CPU
 static void
-remove_siblinginfo(int cpu)
+remove_siblinginfo(cpumask_t remove_mask)
 {
 	int sibling;
 	struct cpuinfo_x86 *c = cpu_data;
+	int cpu;
 
-	for_each_cpu_mask(sibling, cpu_core_map[cpu]) {
-		cpu_clear(cpu, cpu_core_map[sibling]);
-		/*
-		 * last thread sibling in this cpu core going down
-		 */
-		if (cpus_weight(cpu_sibling_map[cpu]) == 1)
-			c[sibling].booted_cores--;
-	}
+	for_each_cpu_mask(cpu, remove_mask) {
+		for_each_cpu_mask(sibling, cpu_core_map[cpu]) {
+			cpu_clear(cpu, cpu_core_map[sibling]);
+			/*
+			 * last thread sibling in this cpu core going down
+			 */
+			if (cpus_weight(cpu_sibling_map[cpu]) == 1)
+				c[sibling].booted_cores--;
+		}
 			
-	for_each_cpu_mask(sibling, cpu_sibling_map[cpu])
-		cpu_clear(cpu, cpu_sibling_map[sibling]);
-	cpus_clear(cpu_sibling_map[cpu]);
-	cpus_clear(cpu_core_map[cpu]);
-	phys_proc_id[cpu] = BAD_APICID;
-	cpu_core_id[cpu] = BAD_APICID;
-	cpu_clear(cpu, cpu_sibling_setup_map);
+		for_each_cpu_mask(sibling, cpu_sibling_map[cpu])
+			cpu_clear(cpu, cpu_sibling_map[sibling]);
+		cpus_clear(cpu_sibling_map[cpu]);
+		cpus_clear(cpu_core_map[cpu]);
+		phys_proc_id[cpu] = BAD_APICID;
+		cpu_core_id[cpu] = BAD_APICID;
+		cpu_clear(cpu, cpu_sibling_setup_map);
+	}
 }
 
+static cpumask_t cpu_dead_mask = CPU_MASK_NONE;
+static cpumask_t cpu_dead_error_mask = CPU_MASK_NONE;
+static atomic_t disable_cpu_start = ATOMIC_INIT(0); /* 1:start, 2:error */
 int __cpu_disable(cpumask_t remove_mask)
 {
-	cpumask_t map = cpu_online_map;
 	int cpu = smp_processor_id();
+	int master = 0;
 
-	BUG_ON(cpus_weight(remove_mask) != 1);
+	/* are we the master cpu? */
+	if (first_cpu(remove_mask) == cpu)
+		master = 1;
 	/*
 	 * Perhaps use cpufreq to drop frequency, but that could go
 	 * into generic code.
@@ -1354,21 +1362,58 @@ int __cpu_disable(cpumask_t remove_mask)
 	 * interrupts only being able to be serviced by the BSP.
 	 * Especially so if we're not using an IOAPIC	-zwane
 	 */
-	if (cpu == 0)
-		return -EBUSY;
+	if (master) {
+		if (cpu_isset(0, remove_mask)) {
+			/* report the error */
+			atomic_set(&disable_cpu_start, 2);
+			smp_wmb(); /* set error first */
+			cpu_set(cpu, cpu_dead_error_mask);
+			while (!cpus_equal(cpu_dead_error_mask, remove_mask))
+				cpu_relax();
+			atomic_set(&disable_cpu_start, 0);
+			cpus_clear(cpu_dead_error_mask);
+			return -EBUSY;
+		}
+		smp_mb();
+		atomic_set(&disable_cpu_start, 1);
+	} else {
+		while (atomic_read(&disable_cpu_start) == 0)
+			cpu_relax();
+		if (atomic_read(&disable_cpu_start) == 2) {
+			cpu_set(cpu, cpu_dead_error_mask);
+			return -EBUSY;
+		}
+	}
 
 	clear_local_APIC();
 	/* Allow any queued timer interrupts to get serviced */
 	local_irq_enable();
 	mdelay(1);
 	local_irq_disable();
-
-	remove_siblinginfo(cpu);
-
-	cpu_clear(cpu, map);
-	fixup_irqs(map);
 	/* It's now safe to remove this processor from the online map */
 	cpu_clear(cpu, cpu_online_map);
+
+	/*
+	 * Till here, all changes master cpu can't remotely do should be
+	 * finished. Remainings don't require local cpu access.
+	 */
+	smp_mb();
+	cpu_set(cpu, cpu_dead_mask);
+	if (!master)
+		return 0;
+	/* master does cleanup. */
+	while (!cpus_equal(cpu_dead_mask, remove_mask))
+		cpu_relax();
+
+	remove_siblinginfo(remove_mask);
+
+	cpus_clear(cpu_dead_mask);
+	atomic_set(&disable_cpu_start, 0);
+	/*
+	 * Note: this depends on fixup_irqs doesn't need access other CPUs'
+	 * local CPU registers, otherwise each cpu should call this routine.
+	 */
+	fixup_irqs(cpu_online_map);
 	return 0;
 }
 
@@ -1376,19 +1421,28 @@ void __cpu_die(cpumask_t remove_mask)
 {
 	/* We don't do anything here: idle task is faking death itself. */
 	unsigned int i;
-	int cpu = first_cpu(remove_mask);
+	int cpu;
 
 	for (i = 0; i < 10; i++) {
 		/* They ack this in play_dead by setting CPU_DEAD */
-		if (per_cpu(cpu_state, cpu) == CPU_DEAD) {
-			printk ("CPU %d is now offline\n", cpu);
-			if (1 == num_online_cpus())
-				alternatives_smp_switch(0);
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
+	if (1 == num_online_cpus())
+		alternatives_smp_switch(0);
 }
 #else /* ... !CONFIG_HOTPLUG_CPU */
 int __cpu_disable(cpumask_t remove_mask)
_
