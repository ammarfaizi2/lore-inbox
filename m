Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262037AbVDLFnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbVDLFnl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 01:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262067AbVDLFlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 01:41:24 -0400
Received: from fmr19.intel.com ([134.134.136.18]:42972 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S262037AbVDLFdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 01:33:41 -0400
Subject: [PATCH 4/6]cpu state clean after hot remove
From: Li Shaohua <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>,
       ACPI-DEV <acpi-devel@lists.sourceforge.net>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@suse.cz>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1113283859.27646.430.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 12 Apr 2005 13:31:07 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clean CPU states in order to reuse smp boot code for CPU hotplug.

Signed-off-by: Li Shaohua<shaohua.li@intel.com>
---

 linux-2.6.11-root/arch/i386/kernel/cpu/common.c |   12 ++++
 linux-2.6.11-root/arch/i386/kernel/irq.c        |    5 +
 linux-2.6.11-root/arch/i386/kernel/process.c    |   19 +++----
 linux-2.6.11-root/arch/i386/kernel/smpboot.c    |   62 ++++++++++++++++++++++--
 linux-2.6.11-root/include/asm-i386/irq.h        |    2 
 linux-2.6.11-root/include/asm-i386/smp.h        |    5 +
 6 files changed, 89 insertions(+), 16 deletions(-)

diff -puN arch/i386/kernel/cpu/common.c~cpu_state_clean arch/i386/kernel/cpu/common.c
--- linux-2.6.11/arch/i386/kernel/cpu/common.c~cpu_state_clean	2005-04-12 10:37:50.642376224 +0800
+++ linux-2.6.11-root/arch/i386/kernel/cpu/common.c	2005-04-12 10:37:50.654374400 +0800
@@ -644,3 +644,15 @@ void __devinit cpu_init (void)
 	clear_used_math();
 	mxcsr_feature_mask_init();
 }
+
+#ifdef CONFIG_HOTPLUG_CPU
+void __devinit cpu_uninit(void)
+{
+	int cpu = _smp_processor_id();
+	cpu_clear(cpu, cpu_initialized);
+
+	/* lazy TLB state */
+	per_cpu(cpu_tlbstate, cpu).state = 0;
+	per_cpu(cpu_tlbstate, cpu).active_mm = &init_mm;
+}
+#endif
diff -puN arch/i386/kernel/irq.c~cpu_state_clean arch/i386/kernel/irq.c
--- linux-2.6.11/arch/i386/kernel/irq.c~cpu_state_clean	2005-04-12 10:37:50.643376072 +0800
+++ linux-2.6.11-root/arch/i386/kernel/irq.c	2005-04-12 10:37:50.654374400 +0800
@@ -158,6 +158,11 @@ void irq_ctx_init(int cpu)
 		cpu,hardirq_ctx[cpu],softirq_ctx[cpu]);
 }
 
+void irq_ctx_exit(int cpu)
+{
+	hardirq_ctx[cpu] = NULL;
+}
+
 extern asmlinkage void __do_softirq(void);
 
 asmlinkage void do_softirq(void)
diff -puN arch/i386/kernel/process.c~cpu_state_clean arch/i386/kernel/process.c
--- linux-2.6.11/arch/i386/kernel/process.c~cpu_state_clean	2005-04-12 10:37:50.645375768 +0800
+++ linux-2.6.11-root/arch/i386/kernel/process.c	2005-04-12 10:37:50.655374248 +0800
@@ -148,21 +148,18 @@ static void poll_idle (void)
 /* We don't actually take CPU down, just spin without interrupts. */
 static inline void play_dead(void)
 {
+	/* This must be done before dead CPU ack */
+	cpu_exit_clear();
+	mb();
 	/* Ack it */
 	__get_cpu_var(cpu_state) = CPU_DEAD;
 
-	/* We shouldn't have to disable interrupts while dead, but
-	 * some interrupts just don't seem to go away, and this makes
-	 * it "work" for testing purposes. */
-	/* Death loop */
-	while (__get_cpu_var(cpu_state) != CPU_UP_PREPARE)
-		cpu_relax();
-
+	/*
+	 * With physical CPU hotplug, we should halt the cpu
+	 */
 	local_irq_disable();
-	__flush_tlb_all();
-	cpu_set(smp_processor_id(), cpu_online_map);
-	enable_APIC_timer();
-	local_irq_enable();
+	while (1)
+		__asm__ __volatile__("hlt":::"memory");
 }
 #else
 static inline void play_dead(void)
diff -puN arch/i386/kernel/smpboot.c~cpu_state_clean arch/i386/kernel/smpboot.c
--- linux-2.6.11/arch/i386/kernel/smpboot.c~cpu_state_clean	2005-04-12 10:37:50.646375616 +0800
+++ linux-2.6.11-root/arch/i386/kernel/smpboot.c	2005-04-12 10:37:50.656374096 +0800
@@ -798,8 +798,18 @@ wakeup_secondary_cpu(int phys_apicid, un
 #endif	/* WAKE_SECONDARY_VIA_INIT */
 
 extern cpumask_t cpu_initialized;
+static inline int alloc_cpu_id(void)
+{
+	cpumask_t	tmp_map;
+	int cpu;
+	cpus_complement(tmp_map, cpu_present_map);
+	cpu = first_cpu(tmp_map);
+	if (cpu >= NR_CPUS)
+		return -ENODEV;
+	return cpu;
+}
 
-static int __devinit do_boot_cpu(int apicid)
+static int __devinit do_boot_cpu(int apicid, int cpu)
 /*
  * NOTE - on most systems this is a PHYSICAL apic ID, but on multiquad
  * (ie clustered apic addressing mode), this is a LOGICAL apic ID.
@@ -808,11 +818,12 @@ static int __devinit do_boot_cpu(int api
 {
 	struct task_struct *idle;
 	unsigned long boot_error;
-	int timeout, cpu;
+	int timeout;
 	unsigned long start_eip;
 	unsigned short nmi_high = 0, nmi_low = 0;
 
-	cpu = ++cpucount;
+	++cpucount;
+
 	/*
 	 * We can't use kernel_thread since we must avoid to
 	 * reschedule the child.
@@ -884,13 +895,16 @@ static int __devinit do_boot_cpu(int api
 			inquire_remote_apic(apicid);
 		}
 	}
-	x86_cpu_to_apicid[cpu] = apicid;
+
 	if (boot_error) {
 		/* Try to put things back the way they were before ... */
 		unmap_cpu_to_logical_apicid(cpu);
 		cpu_clear(cpu, cpu_callout_map); /* was set here (do_boot_cpu()) */
 		cpu_clear(cpu, cpu_initialized); /* was set by cpu_init() */
 		cpucount--;
+	} else {
+		x86_cpu_to_apicid[cpu] = apicid;
+		cpu_set(cpu, cpu_present_map);
 	}
 
 	/* mark "stuck" area as not stuck */
@@ -899,6 +913,26 @@ static int __devinit do_boot_cpu(int api
 	return boot_error;
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+void cpu_exit_clear(void)
+{
+	int cpu = _smp_processor_id();
+
+	idle_task_exit();
+
+	cpucount --;
+	cpu_uninit();
+	irq_ctx_exit(cpu);
+
+	cpu_clear(cpu, cpu_callout_map);
+	cpu_clear(cpu, cpu_callin_map);
+	cpu_clear(cpu, cpu_present_map);
+
+	cpu_clear(cpu, smp_commenced_mask);
+	unmap_cpu_to_logical_apicid(cpu);
+}
+#endif
+
 static void smp_tune_scheduling (void)
 {
 	unsigned long cachesize;       /* kB   */
@@ -1052,7 +1086,7 @@ static void __init smp_boot_cpus(unsigne
 		if (max_cpus <= cpucount+1)
 			continue;
 
-		if (do_boot_cpu(apicid))
+		if ((cpu = alloc_cpu_id() > 0) && do_boot_cpu(apicid, cpu))
 			printk("CPU #%d not responding - cannot use it.\n",
 								apicid);
 		else
@@ -1131,6 +1165,7 @@ void __devinit smp_prepare_boot_cpu(void
 {
 	cpu_set(smp_processor_id(), cpu_online_map);
 	cpu_set(smp_processor_id(), cpu_callout_map);
+	cpu_set(smp_processor_id(), cpu_present_map);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -1152,6 +1187,21 @@ static int __devinit cpu_enable(unsigned
 	return 0;
 }
 
+static void
+remove_siblinginfo(int cpu)
+{
+	int sibling;
+
+	for_each_cpu_mask(sibling, cpu_sibling_map[cpu])
+		cpu_clear(cpu, cpu_sibling_map[sibling]);
+	for_each_cpu_mask(sibling, cpu_core_map[cpu])
+		cpu_clear(cpu, cpu_core_map[sibling]);
+	cpus_clear(cpu_sibling_map[cpu]);
+	cpus_clear(cpu_core_map[cpu]);
+	phys_proc_id[cpu] = BAD_APICID;
+	cpu_core_id[cpu] = BAD_APICID;
+}
+
 int __cpu_disable(void)
 {
 	cpumask_t map = cpu_online_map;
@@ -1175,6 +1225,8 @@ int __cpu_disable(void)
 	mdelay(1);
 	local_irq_disable();
 
+	remove_siblinginfo(cpu);
+
 	cpu_clear(cpu, map);
 	fixup_irqs(map);
 	/* It's now safe to remove this processor from the online map */
diff -puN include/asm-i386/irq.h~cpu_state_clean include/asm-i386/irq.h
--- linux-2.6.11/include/asm-i386/irq.h~cpu_state_clean	2005-04-12 10:37:50.648375312 +0800
+++ linux-2.6.11-root/include/asm-i386/irq.h	2005-04-12 10:37:50.656374096 +0800
@@ -29,9 +29,11 @@ extern void release_vm86_irqs(struct tas
 
 #ifdef CONFIG_4KSTACKS
   extern void irq_ctx_init(int cpu);
+  extern void irq_ctx_exit(int cpu);
 # define __ARCH_HAS_DO_SOFTIRQ
 #else
 # define irq_ctx_init(cpu) do { } while (0)
+# define irq_ctx_exit(cpu) do { } while (0)
 #endif
 
 #ifdef CONFIG_IRQBALANCE
diff -puN include/asm-i386/smp.h~cpu_state_clean include/asm-i386/smp.h
--- linux-2.6.11/include/asm-i386/smp.h~cpu_state_clean	2005-04-12 10:37:50.649375160 +0800
+++ linux-2.6.11-root/include/asm-i386/smp.h	2005-04-12 10:37:50.656374096 +0800
@@ -49,6 +49,11 @@ extern void zap_low_mappings (void);
 #define MAX_APICID 256
 extern u8 x86_cpu_to_apicid[];
 
+#ifdef CONFIG_HOTPLUG_CPU
+extern void cpu_exit_clear(void);
+extern void cpu_uninit(void);
+#endif
+
 /*
  * This function is needed by all SMP systems. It must _always_ be valid
  * from the initial startup. We map APIC_BASE very early in page_setup(),
_


