Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261379AbVBASZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbVBASZo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 13:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbVBASZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 13:25:44 -0500
Received: from fsmlabs.com ([168.103.115.128]:7555 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261379AbVBASYw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 13:24:52 -0500
Date: Tue, 1 Feb 2005 11:25:14 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Linux PPC64 <linuxppc64-dev@ozlabs.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Nathan Lynch <nathanl@austin.ibm.com>
Subject: [PATCH] PPC64: Generic hotplug cpu support
Message-ID: <Pine.LNX.4.61.0502010009010.3010@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch provides a generic hotplug cpu implementation, with the only current 
user being pmac. This doesn't replace real hotplug code as is currently 
used by LPAR systems. Ben i can add the additional pmac specific code to 
put the processor into a sleeping state seperately. Thanks to Nathan for 
testing.

 arch/ppc64/Kconfig                |    2
 arch/ppc64/kernel/idle.c          |    4 +
 arch/ppc64/kernel/irq.c           |   29 +++++++++++++
 arch/ppc64/kernel/pSeries_setup.c |    5 +-
 arch/ppc64/kernel/pmac_setup.c    |    3 +
 arch/ppc64/kernel/pmac_smp.c      |    5 ++
 arch/ppc64/kernel/setup.c         |    3 -
 arch/ppc64/kernel/smp.c           |   80 ++++++++++++++++++++++++++++++++++++++
 arch/ppc64/kernel/sysfs.c         |    6 --
 include/asm-ppc64/machdep.h       |    1
 include/asm-ppc64/smp.h           |    9 +++-
 11 files changed, 136 insertions(+), 11 deletions(-)

Signed-off-by: Zwane Mwaikambo <zwane@arm.linux.org.uk>

Index: linux-2.6.11-rc2-mm2-ppc64/arch/ppc64/Kconfig
===================================================================
RCS file: /home/cvsroot/linux-2.6.11-rc2-mm2/arch/ppc64/Kconfig,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 Kconfig
--- linux-2.6.11-rc2-mm2-ppc64/arch/ppc64/Kconfig	29 Jan 2005 21:29:21 -0000	1.1.1.1
+++ linux-2.6.11-rc2-mm2-ppc64/arch/ppc64/Kconfig	1 Feb 2005 05:01:10 -0000
@@ -313,7 +313,7 @@ source "drivers/pci/Kconfig"
 
 config HOTPLUG_CPU
 	bool "Support for hot-pluggable CPUs"
-	depends on SMP && EXPERIMENTAL && PPC_PSERIES
+	depends on SMP && EXPERIMENTAL && (PPC_PSERIES || PPC_PMAC)
 	select HOTPLUG
 	---help---
 	  Say Y here to be able to turn CPUs off and on.
Index: linux-2.6.11-rc2-mm2-ppc64/arch/ppc64/kernel/idle.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.11-rc2-mm2/arch/ppc64/kernel/idle.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 idle.c
--- linux-2.6.11-rc2-mm2-ppc64/arch/ppc64/kernel/idle.c	29 Jan 2005 21:29:21 -0000	1.1.1.1
+++ linux-2.6.11-rc2-mm2-ppc64/arch/ppc64/kernel/idle.c	1 Feb 2005 06:32:09 -0000
@@ -293,6 +293,10 @@ static int native_idle(void)
 			power4_idle();
 		if (need_resched())
 			schedule();
+
+		if (cpu_is_offline(smp_processor_id()) &&
+		    system_state == SYSTEM_RUNNING)
+			cpu_die();
 	}
 	return 0;
 }
Index: linux-2.6.11-rc2-mm2-ppc64/arch/ppc64/kernel/irq.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.11-rc2-mm2/arch/ppc64/kernel/irq.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 irq.c
--- linux-2.6.11-rc2-mm2-ppc64/arch/ppc64/kernel/irq.c	29 Jan 2005 21:29:21 -0000	1.1.1.1
+++ linux-2.6.11-rc2-mm2-ppc64/arch/ppc64/kernel/irq.c	1 Feb 2005 05:18:21 -0000
@@ -115,6 +115,35 @@ skip:
 	return 0;
 }
 
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
+
 extern int noirqdebug;
 
 /*
Index: linux-2.6.11-rc2-mm2-ppc64/arch/ppc64/kernel/pSeries_setup.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.11-rc2-mm2/arch/ppc64/kernel/pSeries_setup.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 pSeries_setup.c
--- linux-2.6.11-rc2-mm2-ppc64/arch/ppc64/kernel/pSeries_setup.c	29 Jan 2005 21:29:21 -0000	1.1.1.1
+++ linux-2.6.11-rc2-mm2-ppc64/arch/ppc64/kernel/pSeries_setup.c	1 Feb 2005 05:01:10 -0000
@@ -320,8 +320,9 @@ static  void __init pSeries_discover_pic
 	}
 }
 
-static void pSeries_cpu_die(void)
+static void pSeries_mach_cpu_die(void)
 {
+	idle_task_exit();
 	local_irq_disable();
 	/* Some hardware requires clearing the CPPR, while other hardware does not
 	 * it is safe either way
@@ -599,7 +600,7 @@ struct machdep_calls __initdata pSeries_
 	.power_off		= rtas_power_off,
 	.halt			= rtas_halt,
 	.panic			= rtas_os_term,
-	.cpu_die		= pSeries_cpu_die,
+	.cpu_die		= pSeries_mach_cpu_die,
 	.get_boot_time		= pSeries_get_boot_time,
 	.get_rtc_time		= pSeries_get_rtc_time,
 	.set_rtc_time		= pSeries_set_rtc_time,
Index: linux-2.6.11-rc2-mm2-ppc64/arch/ppc64/kernel/pmac_setup.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.11-rc2-mm2/arch/ppc64/kernel/pmac_setup.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 pmac_setup.c
--- linux-2.6.11-rc2-mm2-ppc64/arch/ppc64/kernel/pmac_setup.c	29 Jan 2005 21:29:21 -0000	1.1.1.1
+++ linux-2.6.11-rc2-mm2-ppc64/arch/ppc64/kernel/pmac_setup.c	1 Feb 2005 06:49:25 -0000
@@ -439,6 +439,9 @@ static int __init pmac_probe(int platfor
 }
 
 struct machdep_calls __initdata pmac_md = {
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_die		= generic_mach_cpu_die,
+#endif
 	.probe			= pmac_probe,
 	.setup_arch		= pmac_setup_arch,
 	.init_early		= pmac_init_early,
Index: linux-2.6.11-rc2-mm2-ppc64/arch/ppc64/kernel/pmac_smp.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.11-rc2-mm2/arch/ppc64/kernel/pmac_smp.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 pmac_smp.c
--- linux-2.6.11-rc2-mm2-ppc64/arch/ppc64/kernel/pmac_smp.c	29 Jan 2005 21:29:21 -0000	1.1.1.1
+++ linux-2.6.11-rc2-mm2-ppc64/arch/ppc64/kernel/pmac_smp.c	1 Feb 2005 06:50:02 -0000
@@ -308,4 +308,9 @@ struct smp_ops_t core99_smp_ops __pmacda
 void __init pmac_setup_smp(void)
 {
 	smp_ops = &core99_smp_ops;
+#ifdef CONFIG_HOTPLUG_CPU
+	smp_ops->cpu_enable = generic_cpu_enable;
+	smp_ops->cpu_disable = generic_cpu_disable;
+	smp_ops->cpu_die = generic_cpu_die;
+#endif
 }
Index: linux-2.6.11-rc2-mm2-ppc64/arch/ppc64/kernel/setup.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.11-rc2-mm2/arch/ppc64/kernel/setup.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 setup.c
--- linux-2.6.11-rc2-mm2-ppc64/arch/ppc64/kernel/setup.c	29 Jan 2005 21:29:21 -0000	1.1.1.1
+++ linux-2.6.11-rc2-mm2-ppc64/arch/ppc64/kernel/setup.c	1 Feb 2005 06:25:29 -0000
@@ -1345,9 +1345,6 @@ early_param("xmon", early_xmon);
 
 void cpu_die(void)
 {
-	idle_task_exit();
 	if (ppc_md.cpu_die)
 		ppc_md.cpu_die();
-	local_irq_disable();
-	for (;;);
 }
Index: linux-2.6.11-rc2-mm2-ppc64/arch/ppc64/kernel/smp.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.11-rc2-mm2/arch/ppc64/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 smp.c
--- linux-2.6.11-rc2-mm2-ppc64/arch/ppc64/kernel/smp.c	29 Jan 2005 21:29:21 -0000	1.1.1.1
+++ linux-2.6.11-rc2-mm2-ppc64/arch/ppc64/kernel/smp.c	1 Feb 2005 06:36:42 -0000
@@ -30,6 +30,7 @@
 #include <linux/err.h>
 #include <linux/sysdev.h>
 #include <linux/cpu.h>
+#include <linux/notifier.h>
 
 #include <asm/ptrace.h>
 #include <asm/atomic.h>
@@ -406,10 +407,89 @@ void __devinit smp_prepare_boot_cpu(void
 	current_set[boot_cpuid] = current->thread_info;
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+/* State of each CPU during hotplug phases */
+DEFINE_PER_CPU(int, cpu_state) = { 0 };
+
+int generic_cpu_disable(void)
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
+int generic_cpu_enable(unsigned int cpu)
+{
+	/* Do the normal bootup if we haven't
+	 * already bootstrapped. */
+	if (system_state != SYSTEM_RUNNING)
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
+
+void generic_cpu_die(unsigned int cpu)
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
+void generic_mach_cpu_die(void)
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
+static int __devinit cpu_enable(unsigned int cpu)
+{
+	if (smp_ops->cpu_enable)
+		return smp_ops->cpu_enable(cpu);
+
+	return -ENOSYS;
+}
+
 int __devinit __cpu_up(unsigned int cpu)
 {
 	int c;
 
+	if (!cpu_enable(cpu))
+		return 0;
+
 	/* At boot, don't bother with non-present cpus -JSCHOPP */
 	if (system_state < SYSTEM_RUNNING && !cpu_present(cpu))
 		return -ENOENT;
Index: linux-2.6.11-rc2-mm2-ppc64/arch/ppc64/kernel/sysfs.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.11-rc2-mm2/arch/ppc64/kernel/sysfs.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 sysfs.c
--- linux-2.6.11-rc2-mm2-ppc64/arch/ppc64/kernel/sysfs.c	29 Jan 2005 21:29:21 -0000	1.1.1.1
+++ linux-2.6.11-rc2-mm2-ppc64/arch/ppc64/kernel/sysfs.c	1 Feb 2005 05:01:10 -0000
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
Index: linux-2.6.11-rc2-mm2-ppc64/include/asm-ppc64/machdep.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.11-rc2-mm2/include/asm-ppc64/machdep.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 machdep.h
--- linux-2.6.11-rc2-mm2-ppc64/include/asm-ppc64/machdep.h	29 Jan 2005 21:29:28 -0000	1.1.1.1
+++ linux-2.6.11-rc2-mm2-ppc64/include/asm-ppc64/machdep.h	1 Feb 2005 05:56:24 -0000
@@ -30,6 +30,7 @@ struct smp_ops_t {
 	void  (*setup_cpu)(int nr);
 	void  (*take_timebase)(void);
 	void  (*give_timebase)(void);
+	int   (*cpu_enable)(unsigned int nr);
 	int   (*cpu_disable)(void);
 	void  (*cpu_die)(unsigned int nr);
 };
Index: linux-2.6.11-rc2-mm2-ppc64/include/asm-ppc64/smp.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.11-rc2-mm2/include/asm-ppc64/smp.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 smp.h
--- linux-2.6.11-rc2-mm2-ppc64/include/asm-ppc64/smp.h	29 Jan 2005 21:29:28 -0000	1.1.1.1
+++ linux-2.6.11-rc2-mm2-ppc64/include/asm-ppc64/smp.h	1 Feb 2005 06:25:08 -0000
@@ -29,7 +29,7 @@
 extern int boot_cpuid;
 extern int boot_cpuid_phys;
 
-extern void cpu_die(void) __attribute__((noreturn));
+extern void cpu_die(void);
 
 #ifdef CONFIG_SMP
 
@@ -37,6 +37,13 @@ extern void smp_send_debugger_break(int 
 struct pt_regs;
 extern void smp_message_recv(int, struct pt_regs *);
 
+#ifdef CONFIG_HOTPLUG_CPU
+extern void fixup_irqs(cpumask_t map);
+int generic_cpu_disable(void);
+int generic_cpu_enable(unsigned int cpu);
+void generic_cpu_die(unsigned int cpu);
+void generic_mach_cpu_die(void);
+#endif
 
 #define __smp_processor_id() (get_paca()->paca_index)
 #define hard_smp_processor_id() (get_paca()->hw_cpu_id)
