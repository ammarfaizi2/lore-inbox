Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261706AbVANAss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbVANAss (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 19:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbVANArG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 19:47:06 -0500
Received: from fsmlabs.com ([168.103.115.128]:35712 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261751AbVANAnk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 19:43:40 -0500
Date: Thu, 13 Jan 2005 17:43:39 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Anton Blanchard <anton@samba.org>
cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux PPC64 <linuxppc64-dev@ozlabs.org>
Subject: [PATCH] PPC64 pmac hotplug cpu
Message-ID: <Pine.LNX.4.61.0501122341410.23299@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found the following very handy for use as a reference platform when 
working on i386 hotplug cpu recently.

It's been tested on a G5 system with a cpu going on/offline every second 
and make -j. I've also tried a number of config options to avoid compile 
breakage.

Signed-off-by: Zwane Mwaikambo <zwane@arm.linux.org.uk>

Index: linux-2.6.10-mm3/arch/ppc64/Kconfig
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-mm3/arch/ppc64/Kconfig,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 Kconfig
--- linux-2.6.10-mm3/arch/ppc64/Kconfig	13 Jan 2005 16:27:26 -0000	1.1.1.1
+++ linux-2.6.10-mm3/arch/ppc64/Kconfig	13 Jan 2005 16:35:39 -0000
@@ -305,7 +305,7 @@ source "drivers/pci/Kconfig"
 
 config HOTPLUG_CPU
 	bool "Support for hot-pluggable CPUs"
-	depends on SMP && EXPERIMENTAL && PPC_PSERIES
+	depends on SMP && EXPERIMENTAL && (PPC_PSERIES || PPC_PMAC)
 	select HOTPLUG
 	---help---
 	  Say Y here to be able to turn CPUs off and on.
Index: linux-2.6.10-mm3/arch/ppc64/kernel/idle.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-mm3/arch/ppc64/kernel/idle.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 idle.c
--- linux-2.6.10-mm3/arch/ppc64/kernel/idle.c	13 Jan 2005 16:27:26 -0000	1.1.1.1
+++ linux-2.6.10-mm3/arch/ppc64/kernel/idle.c	13 Jan 2005 16:34:24 -0000
@@ -364,7 +364,7 @@ int idle_setup(void)
 		}
 	}
 #endif /* CONFIG_PPC_PSERIES */
-#ifndef CONFIG_PPC_ISERIES
+#if !defined(CONFIG_PPC_ISERIES) && !defined(CONFIG_HOTPLUG_CPU)
 	if (systemcfg->platform == PLATFORM_POWERMAC ||
 	    systemcfg->platform == PLATFORM_MAPLE) {
 		printk(KERN_INFO "Using native/NAP idle loop\n");
Index: linux-2.6.10-mm3/arch/ppc64/kernel/irq.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-mm3/arch/ppc64/kernel/irq.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 irq.c
--- linux-2.6.10-mm3/arch/ppc64/kernel/irq.c	13 Jan 2005 16:27:26 -0000	1.1.1.1
+++ linux-2.6.10-mm3/arch/ppc64/kernel/irq.c	13 Jan 2005 23:51:29 -0000
@@ -479,3 +479,31 @@ EXPORT_SYMBOL(do_softirq);
 
 #endif /* CONFIG_IRQSTACKS */
 
+#ifdef CONFIG_HOTPLUG_CPU
+void fixup_irqs(cpumask_t map)
+{
+	unsigned int irq;
+	static int warned;
+
+	for_each_irq(irq) {
+		cpumask_t mask;
+
+		if (irq_desc[irq].status & IRQ_PER_CPU)
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
+	local_irq_enable();
+	mdelay(1);
+	local_irq_disable();
+}
+#endif
Index: linux-2.6.10-mm3/arch/ppc64/kernel/pSeries_setup.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-mm3/arch/ppc64/kernel/pSeries_setup.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 pSeries_setup.c
--- linux-2.6.10-mm3/arch/ppc64/kernel/pSeries_setup.c	13 Jan 2005 16:27:27 -0000	1.1.1.1
+++ linux-2.6.10-mm3/arch/ppc64/kernel/pSeries_setup.c	13 Jan 2005 20:44:05 -0000
@@ -327,8 +327,9 @@ static  void __init pSeries_discover_pic
 	}
 }
 
-static void pSeries_cpu_die(void)
+static void pSeries_mach_cpu_die(void)
 {
+	idle_task_exit();
 	local_irq_disable();
 	/* Some hardware requires clearing the CPPR, while other hardware does not
 	 * it is safe either way
@@ -606,7 +607,7 @@ struct machdep_calls __initdata pSeries_
 	.power_off		= rtas_power_off,
 	.halt			= rtas_halt,
 	.panic			= rtas_os_term,
-	.cpu_die		= pSeries_cpu_die,
+	.cpu_die		= pSeries_mach_cpu_die,
 	.get_boot_time		= pSeries_get_boot_time,
 	.get_rtc_time		= pSeries_get_rtc_time,
 	.set_rtc_time		= pSeries_set_rtc_time,
Index: linux-2.6.10-mm3/arch/ppc64/kernel/pmac.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-mm3/arch/ppc64/kernel/pmac.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 pmac.h
--- linux-2.6.10-mm3/arch/ppc64/kernel/pmac.h	13 Jan 2005 16:27:27 -0000	1.1.1.1
+++ linux-2.6.10-mm3/arch/ppc64/kernel/pmac.h	13 Jan 2005 16:34:24 -0000
@@ -8,6 +8,9 @@
  * Declaration for the various functions exported by the
  * pmac_* files. Mostly for use by pmac_setup
  */
+#ifdef CONFIG_HOTPLUG_CPU
+DECLARE_PER_CPU(int, cpu_state);
+#endif
 
 extern void pmac_get_boot_time(struct rtc_time *tm);
 extern void pmac_get_rtc_time(struct rtc_time *tm);
Index: linux-2.6.10-mm3/arch/ppc64/kernel/pmac_setup.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-mm3/arch/ppc64/kernel/pmac_setup.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 pmac_setup.c
--- linux-2.6.10-mm3/arch/ppc64/kernel/pmac_setup.c	13 Jan 2005 16:27:27 -0000	1.1.1.1
+++ linux-2.6.10-mm3/arch/ppc64/kernel/pmac_setup.c	13 Jan 2005 16:34:24 -0000
@@ -229,6 +229,25 @@ void __pmac pmac_halt(void)
 	pmac_power_off();
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+static void pmac_mach_cpu_die(void)
+{
+	unsigned int cpu;
+
+	local_irq_disable();
+	cpu = smp_processor_id();
+	printk(KERN_DEBUG "CPU%d offline\n", cpu);
+	__get_cpu_var(cpu_state) = CPU_DEAD;
+	wmb();
+	while (__get_cpu_var(cpu_state) != CPU_UP_PREPARE)
+		cpu_relax();
+
+	flush_tlb_pending();
+	cpu_set(cpu, cpu_online_map);
+	local_irq_enable();
+}
+#endif
+
 #ifdef CONFIG_BOOTX_TEXT
 static int dummy_getc_poll(void)
 {
@@ -455,5 +474,8 @@ struct machdep_calls __initdata pmac_md 
       	.calibrate_decr		= pmac_calibrate_decr,
 	.feature_call		= pmac_do_feature_call,
 	.progress		= pmac_progress,
-	.check_legacy_ioport	= pmac_check_legacy_ioport
+	.check_legacy_ioport	= pmac_check_legacy_ioport,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_die		= pmac_mach_cpu_die,
+#endif
 };
Index: linux-2.6.10-mm3/arch/ppc64/kernel/pmac_smp.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-mm3/arch/ppc64/kernel/pmac_smp.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 pmac_smp.c
--- linux-2.6.10-mm3/arch/ppc64/kernel/pmac_smp.c	13 Jan 2005 16:27:27 -0000	1.1.1.1
+++ linux-2.6.10-mm3/arch/ppc64/kernel/pmac_smp.c	14 Jan 2005 00:32:10 -0000
@@ -35,6 +35,7 @@
 #include <linux/spinlock.h>
 #include <linux/errno.h>
 #include <linux/irq.h>
+#include <linux/delay.h>
 
 #include <asm/ptrace.h>
 #include <asm/atomic.h>
@@ -296,6 +297,38 @@ static void __init smp_core99_setup_cpu(
 	}
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+/* State of each CPU during hotplug phases */
+DEFINE_PER_CPU(int, cpu_state) = { 0 };
+
+static int pmac_cpu_disable(void)
+{
+	unsigned int cpu = smp_processor_id();
+
+	if (cpu == boot_cpuid)
+		return -EBUSY;
+
+	systemcfg->processorCount--;
+	cpu_clear(cpu, cpu_online_map);
+	fixup_irqs(cpu_online_map);
+	return 0;
+}
+
+static void pmac_cpu_die(unsigned int cpu)
+{
+	int i;
+	
+	for (i = 0; i < 100; i++) {
+		rmb();
+		if (per_cpu(cpu_state, cpu) == CPU_DEAD)
+			return;
+		msleep(100);
+	}
+	printk(KERN_ERR "CPU%d didn't die...\n", cpu);
+}
+
+#endif
+
 struct smp_ops_t core99_smp_ops __pmacdata = {
 	.message_pass	= smp_mpic_message_pass,
 	.probe		= smp_core99_probe,
@@ -308,4 +341,8 @@ struct smp_ops_t core99_smp_ops __pmacda
 void __init pmac_setup_smp(void)
 {
 	smp_ops = &core99_smp_ops;
+#ifdef CONFIG_HOTPLUG_CPU
+	smp_ops->cpu_disable = pmac_cpu_disable;
+	smp_ops->cpu_die = pmac_cpu_die;
+#endif
 }
Index: linux-2.6.10-mm3/arch/ppc64/kernel/setup.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-mm3/arch/ppc64/kernel/setup.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 setup.c
--- linux-2.6.10-mm3/arch/ppc64/kernel/setup.c	13 Jan 2005 16:27:26 -0000	1.1.1.1
+++ linux-2.6.10-mm3/arch/ppc64/kernel/setup.c	13 Jan 2005 21:26:48 -0000
@@ -1345,9 +1345,6 @@ early_param("xmon", early_xmon);
 
 void cpu_die(void)
 {
-	idle_task_exit();
 	if (ppc_md.cpu_die)
 		ppc_md.cpu_die();
-	local_irq_disable();
-	for (;;);
 }
Index: linux-2.6.10-mm3/arch/ppc64/kernel/smp.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-mm3/arch/ppc64/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 smp.c
--- linux-2.6.10-mm3/arch/ppc64/kernel/smp.c	13 Jan 2005 16:27:27 -0000	1.1.1.1
+++ linux-2.6.10-mm3/arch/ppc64/kernel/smp.c	14 Jan 2005 00:26:26 -0000
@@ -406,10 +406,39 @@ void __devinit smp_prepare_boot_cpu(void
 	current_set[boot_cpuid] = current->thread_info;
 }
 
+#if defined(CONFIG_HOTPLUG_CPU) && defined(CONFIG_PPC_PMAC)
+#include "pmac.h"
+static int cpu_enable(unsigned int cpu)
+{
+	if (systemcfg->platform == PLATFORM_PSERIES_LPAR)
+		return -ENOSYS;
+
+	/* get the target out of it's holding state */
+	per_cpu(cpu_state, cpu) = CPU_UP_PREPARE;
+	wmb();
+
+	while (!cpu_online(cpu))
+		cpu_relax();
+
+	fixup_irqs(cpu_online_map);
+	/* counter the irq disable in fixup_irqs */
+	local_irq_enable();
+	return 0;
+}
+#else
+static int cpu_enable(unsigned int cpu)
+{
+	return -ENOSYS;
+}
+#endif
+
 int __devinit __cpu_up(unsigned int cpu)
 {
 	int c;
 
+	if (system_state == SYSTEM_RUNNING && !cpu_enable(cpu))
+		return 0;
+
 	/* At boot, don't bother with non-present cpus -JSCHOPP */
 	if (system_state < SYSTEM_RUNNING && !cpu_present(cpu))
 		return -ENOENT;
Index: linux-2.6.10-mm3/arch/ppc64/kernel/sysfs.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-mm3/arch/ppc64/kernel/sysfs.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 sysfs.c
--- linux-2.6.10-mm3/arch/ppc64/kernel/sysfs.c	13 Jan 2005 16:27:27 -0000	1.1.1.1
+++ linux-2.6.10-mm3/arch/ppc64/kernel/sysfs.c	13 Jan 2005 16:36:23 -0000
@@ -18,7 +18,7 @@
 #include <asm/systemcfg.h>
 #include <asm/paca.h>
 #include <asm/lppaca.h>
-
+#include <asm/machdep.h>
 
 static DEFINE_PER_CPU(struct cpu, cpu_devices);
 
@@ -413,9 +413,7 @@ static int __init topology_init(void)
 		 * CPU.  For instance, the boot cpu might never be valid
 		 * for hotplugging.
 		 */
-#ifdef CONFIG_HOTPLUG_CPU
-		if (systemcfg->platform != PLATFORM_PSERIES_LPAR)
-#endif
+		if (!ppc_md.cpu_die)
 			c->no_control = 1;
 
 		if (cpu_online(cpu) || (c->no_control == 0)) {
Index: linux-2.6.10-mm3/include/asm-ppc64/smp.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-mm3/include/asm-ppc64/smp.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 smp.h
--- linux-2.6.10-mm3/include/asm-ppc64/smp.h	13 Jan 2005 16:27:35 -0000	1.1.1.1
+++ linux-2.6.10-mm3/include/asm-ppc64/smp.h	13 Jan 2005 16:34:24 -0000
@@ -29,7 +29,7 @@
 extern int boot_cpuid;
 extern int boot_cpuid_phys;
 
-extern void cpu_die(void) __attribute__((noreturn));
+extern void cpu_die(void);
 
 #ifdef CONFIG_SMP
 
@@ -37,6 +37,9 @@ extern void smp_send_debugger_break(int 
 struct pt_regs;
 extern void smp_message_recv(int, struct pt_regs *);
 
+#ifdef CONFIG_HOTPLUG_CPU
+extern void fixup_irqs(cpumask_t map);
+#endif
 
 #define smp_processor_id() (get_paca()->paca_index)
 #define hard_smp_processor_id() (get_paca()->hw_cpu_id)
