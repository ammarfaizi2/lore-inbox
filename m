Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964941AbVIAHTe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964941AbVIAHTe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 03:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964920AbVIAHTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 03:19:34 -0400
Received: from c-24-10-253-213.hsd1.ut.comcast.net ([24.10.253.213]:7808 "EHLO
	linux.site") by vger.kernel.org with ESMTP id S964941AbVIAHTd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 03:19:33 -0400
Subject: [patch 1/1] Hot plug CPU to support physical add of new processors (i386)
To: shaohua.li@intel.com
Cc: zwane@arm.linux.org.uk, ashok.raj@intel.com, akpm@osdl.org, ak@suse.de,
       lhcs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       hotplug_sig@lists.osdl.org, Natalie.Protasevich@unisys.com
From: Natalie.Protasevich@unisys.com
Date: Wed, 31 Aug 2005 05:13:10 -0700
Message-Id: <20050831121311.5FC7C57D99@linux.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Current IA32 CPU hotplug code doesn't allow bringing up processors that were not present in the boot configuration. 
To make existing hot plug facility more practical for physical hot plug, possible processors should be encountered 
during boot for potentual hot add/replace/remove. On ES7000, ACPI marks all the sockets that are empty or not assigned
to the partitionas as "disabled". The patch allows arrays/masks with APIC info for disabled processors to be 
initialized. Then the OS can bring up a processor that was inserted in the socked and brought into configuration 
during runtime. 
To test the code, one can boot the system with maxcpu=1 and then bring the rest of the processors up, which was not 
possible so far (only maxcpus number of nodes were created).
The patch also makes proc entry for interrupts dynamically change to only show current onlined processors.

Signed-off-by: Natalie Protasevich  <Natalie.Protasevich@unisys.com>
---

 arch/i386/kernel/acpi/boot.c      |    2 ++
 arch/i386/kernel/irq.c            |    8 ++++----
 arch/i386/kernel/mpparse.c        |    4 ++++
 arch/i386/kernel/smpboot.c        |    3 ++-
 arch/i386/mach-default/topology.c |    4 ++--
 kernel/cpu.c                      |    4 ++++
 6 files changed, 18 insertions(+), 7 deletions(-)

diff -puN arch/i386/kernel/acpi/boot.c~hotcpu-i386 arch/i386/kernel/acpi/boot.c
--- linux-2.6.13-rc6-mm2/arch/i386/kernel/acpi/boot.c~hotcpu-i386	2005-08-31 04:17:20.832038600 -0700
+++ linux-2.6.13-rc6-mm2-root/arch/i386/kernel/acpi/boot.c	2005-08-31 04:19:35.259602504 -0700
@@ -255,9 +255,11 @@ acpi_parse_lapic(acpi_table_entry_header
 
 	acpi_table_print_madt_entry(header);
 
+#ifndef CONFIG_HOTPLUG_CPU
 	/* no utility in registering a disabled processor */
 	if (processor->flags.enabled == 0)
 		return 0;
+#endif
 
 	x86_acpiid_to_apicid[processor->acpi_id] = processor->id;
 
diff -puN arch/i386/kernel/mpparse.c~hotcpu-i386 arch/i386/kernel/mpparse.c
--- linux-2.6.13-rc6-mm2/arch/i386/kernel/mpparse.c~hotcpu-i386	2005-08-31 04:17:20.877031760 -0700
+++ linux-2.6.13-rc6-mm2-root/arch/i386/kernel/mpparse.c	2005-08-31 04:20:49.297347056 -0700
@@ -125,8 +125,10 @@ static void __init MP_processor_info (st
  	int ver, apicid, cpu, found_bsp = 0;
 	physid_mask_t tmp;
  	
+#ifndef CONFIG_HOTPLUG_CPU
 	if (!(m->mpc_cpuflag & CPU_ENABLED))
 		return;
+#endif
 
 	apicid = mpc_apic_id(m, translation_table[mpc_record]);
 
@@ -190,11 +192,13 @@ static void __init MP_processor_info (st
 		return;
 	}
 
+#ifndef CONFIG_HOTPLUG_CPU
 	if (num_processors >= maxcpus) {
 		printk(KERN_WARNING "WARNING: maxcpus limit of %i reached."
 			" Processor ignored.\n", maxcpus); 
 		return;
 	}
+#endif
 	num_processors++;
 	ver = m->mpc_apicver;
 
diff -puN arch/i386/kernel/smpboot.c~hotcpu-i386 arch/i386/kernel/smpboot.c
--- linux-2.6.13-rc6-mm2/arch/i386/kernel/smpboot.c~hotcpu-i386	2005-08-31 04:17:20.924024616 -0700
+++ linux-2.6.13-rc6-mm2-root/arch/i386/kernel/smpboot.c	2005-08-31 04:21:49.474198784 -0700
@@ -1003,9 +1003,10 @@ int __devinit smp_prepare_cpu(int cpu)
 	struct warm_boot_cpu_info info;
 	struct work_struct task;
 	int	apicid, ret;
+	extern u8 bios_cpu_apicid[NR_CPUS];
 
 	lock_cpu_hotplug();
-	apicid = x86_cpu_to_apicid[cpu];
+	apicid = bios_cpu_apicid[cpu];
 	if (apicid == BAD_APICID) {
 		ret = -ENODEV;
 		goto exit;
diff -puN arch/i386/mach-default/topology.c~hotcpu-i386 arch/i386/mach-default/topology.c
--- linux-2.6.13-rc6-mm2/arch/i386/mach-default/topology.c~hotcpu-i386	2005-08-31 04:17:20.957019600 -0700
+++ linux-2.6.13-rc6-mm2-root/arch/i386/mach-default/topology.c	2005-08-31 04:22:13.020619184 -0700
@@ -76,7 +76,7 @@ static int __init topology_init(void)
 	for_each_online_node(i)
 		arch_register_node(i);
 
-	for_each_present_cpu(i)
+	for_each_cpu(i)
 		arch_register_cpu(i);
 	return 0;
 }
@@ -87,7 +87,7 @@ static int __init topology_init(void)
 {
 	int i;
 
-	for_each_present_cpu(i)
+	for_each_cpu(i)
 		arch_register_cpu(i);
 	return 0;
 }
diff -puN kernel/cpu.c~hotcpu-i386 kernel/cpu.c
--- linux-2.6.13-rc6-mm2/kernel/cpu.c~hotcpu-i386	2005-08-31 04:17:21.002012760 -0700
+++ linux-2.6.13-rc6-mm2-root/kernel/cpu.c	2005-08-31 04:23:34.378250944 -0700
@@ -158,7 +158,11 @@ int __devinit cpu_up(unsigned int cpu)
 	if ((ret = down_interruptible(&cpucontrol)) != 0)
 		return ret;
 
+#ifdef CONFIG_HOTPLUG_CPU
+	if (cpu_online(cpu)) {
+#else
 	if (cpu_online(cpu) || !cpu_present(cpu)) {
+#endif
 		ret = -EINVAL;
 		goto out;
 	}
diff -puN arch/i386/kernel/irq.c~hotcpu-i386 arch/i386/kernel/irq.c
--- linux-2.6.13-rc6-mm2/arch/i386/kernel/irq.c~hotcpu-i386	2005-08-31 04:17:21.047005920 -0700
+++ linux-2.6.13-rc6-mm2-root/arch/i386/kernel/irq.c	2005-08-31 04:25:21.761926144 -0700
@@ -248,7 +248,7 @@ int show_interrupts(struct seq_file *p, 
 
 	if (i == 0) {
 		seq_printf(p, "           ");
-		for_each_cpu(j)
+		for_each_online_cpu(j)
 			seq_printf(p, "CPU%d       ",j);
 		seq_putc(p, '\n');
 	}
@@ -262,7 +262,7 @@ int show_interrupts(struct seq_file *p, 
 #ifndef CONFIG_SMP
 		seq_printf(p, "%10u ", kstat_irqs(i));
 #else
-		for_each_cpu(j)
+		for_each_online_cpu(j)
 			seq_printf(p, "%10u ", kstat_cpu(j).irqs[i]);
 #endif
 		seq_printf(p, " %14s", irq_desc[i].handler->typename);
@@ -276,12 +276,12 @@ skip:
 		spin_unlock_irqrestore(&irq_desc[i].lock, flags);
 	} else if (i == NR_IRQS) {
 		seq_printf(p, "NMI: ");
-		for_each_cpu(j)
+		for_each_online_cpu(j)
 			seq_printf(p, "%10u ", nmi_count(j));
 		seq_putc(p, '\n');
 #ifdef CONFIG_X86_LOCAL_APIC
 		seq_printf(p, "LOC: ");
-		for_each_cpu(j)
+		for_each_online_cpu(j)
 			seq_printf(p, "%10u ",
 				per_cpu(irq_stat,j).apic_timer_irqs);
 		seq_putc(p, '\n');
_
