Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030354AbVLOCfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030354AbVLOCfh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 21:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030358AbVLOCfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 21:35:36 -0500
Received: from serv01.siteground.net ([70.85.91.68]:33921 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1030354AbVLOCfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 21:35:36 -0500
Date: Wed, 14 Dec 2005 18:35:26 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org,
       Andrew Morton <akpm@osdl.org>
Subject: [patch 2/3] x86_64: Node local pda take 2 -- cpu_pda_prep
Message-ID: <20051215023526.GC3787@localhost.localdomain>
References: <20051215023345.GB3787@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051215023345.GB3787@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helper patch to change cpu_pda users to use macros to access cpu_pda
instead of the cpu_pda[] array.

Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

Index: linux-2.6.15-rc1git/arch/x86_64/kernel/irq.c
===================================================================
--- linux-2.6.15-rc1git.orig/arch/x86_64/kernel/irq.c	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.15-rc1git/arch/x86_64/kernel/irq.c	2005-11-16 14:08:14.000000000 -0800
@@ -69,13 +69,13 @@
 		seq_printf(p, "NMI: ");
 		for (j = 0; j < NR_CPUS; j++)
 			if (cpu_online(j))
-				seq_printf(p, "%10u ", cpu_pda[j].__nmi_count);
+				seq_printf(p, "%10u ", cpu_pda(j)->__nmi_count);
 		seq_putc(p, '\n');
 #ifdef CONFIG_X86_LOCAL_APIC
 		seq_printf(p, "LOC: ");
 		for (j = 0; j < NR_CPUS; j++)
 			if (cpu_online(j))
-				seq_printf(p, "%10u ", cpu_pda[j].apic_timer_irqs);
+				seq_printf(p, "%10u ", cpu_pda(j)->apic_timer_irqs);
 		seq_putc(p, '\n');
 #endif
 		seq_printf(p, "ERR: %10u\n", atomic_read(&irq_err_count));
Index: linux-2.6.15-rc1git/arch/x86_64/kernel/nmi.c
===================================================================
--- linux-2.6.15-rc1git.orig/arch/x86_64/kernel/nmi.c	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.15-rc1git/arch/x86_64/kernel/nmi.c	2005-11-16 14:08:14.000000000 -0800
@@ -155,19 +155,19 @@
 		smp_call_function(nmi_cpu_busy, (void *)&endflag, 0, 0);
 
 	for (cpu = 0; cpu < NR_CPUS; cpu++)
-		counts[cpu] = cpu_pda[cpu].__nmi_count; 
+		counts[cpu] = cpu_pda(cpu)->__nmi_count; 
 	local_irq_enable();
 	mdelay((10*1000)/nmi_hz); // wait 10 ticks
 
 	for (cpu = 0; cpu < NR_CPUS; cpu++) {
 		if (!cpu_online(cpu))
 			continue;
-		if (cpu_pda[cpu].__nmi_count - counts[cpu] <= 5) {
+		if (cpu_pda(cpu)->__nmi_count - counts[cpu] <= 5) {
 			endflag = 1;
 			printk("CPU#%d: NMI appears to be stuck (%d->%d)!\n",
 			       cpu,
 			       counts[cpu],
-			       cpu_pda[cpu].__nmi_count);
+			       cpu_pda(cpu)->__nmi_count);
 			nmi_active = 0;
 			lapic_nmi_owner &= ~LAPIC_NMI_WATCHDOG;
 			nmi_perfctr_msr = 0;
Index: linux-2.6.15-rc1git/arch/x86_64/kernel/setup64.c
===================================================================
--- linux-2.6.15-rc1git.orig/arch/x86_64/kernel/setup64.c	2005-11-16 12:13:40.000000000 -0800
+++ linux-2.6.15-rc1git/arch/x86_64/kernel/setup64.c	2005-11-16 14:08:14.000000000 -0800
@@ -30,7 +30,7 @@
 
 cpumask_t cpu_initialized __cpuinitdata = CPU_MASK_NONE;
 
-struct x8664_pda cpu_pda[NR_CPUS] __cacheline_aligned; 
+struct x8664_pda _cpu_pda[NR_CPUS] __cacheline_aligned; 
 
 struct desc_ptr idt_descr = { 256 * 16, (unsigned long) idt_table }; 
 
@@ -110,18 +110,18 @@
 		}
 		if (!ptr)
 			panic("Cannot allocate cpu data for CPU %d\n", i);
-		cpu_pda[i].data_offset = ptr - __per_cpu_start;
+		cpu_pda(i)->data_offset = ptr - __per_cpu_start;
 		memcpy(ptr, __per_cpu_start, __per_cpu_end - __per_cpu_start);
 	}
 } 
 
 void pda_init(int cpu)
 { 
-	struct x8664_pda *pda = &cpu_pda[cpu];
+	struct x8664_pda *pda = cpu_pda(cpu);
 
 	/* Setup up data that may be needed in __get_free_pages early */
 	asm volatile("movl %0,%%fs ; movl %0,%%gs" :: "r" (0)); 
-	wrmsrl(MSR_GS_BASE, cpu_pda + cpu);
+	wrmsrl(MSR_GS_BASE, pda);
 
 	pda->cpunumber = cpu; 
 	pda->irqcount = -1;
Index: linux-2.6.15-rc1git/arch/x86_64/kernel/smpboot.c
===================================================================
--- linux-2.6.15-rc1git.orig/arch/x86_64/kernel/smpboot.c	2005-11-16 12:13:40.000000000 -0800
+++ linux-2.6.15-rc1git/arch/x86_64/kernel/smpboot.c	2005-11-16 14:08:14.000000000 -0800
@@ -778,7 +778,7 @@
 
 do_rest:
 
-	cpu_pda[cpu].pcurrent = c_idle.idle;
+	cpu_pda(cpu)->pcurrent = c_idle.idle;
 
 	start_rip = setup_trampoline();
 
Index: linux-2.6.15-rc1git/arch/x86_64/kernel/traps.c
===================================================================
--- linux-2.6.15-rc1git.orig/arch/x86_64/kernel/traps.c	2005-11-16 12:13:40.000000000 -0800
+++ linux-2.6.15-rc1git/arch/x86_64/kernel/traps.c	2005-11-16 14:08:14.000000000 -0800
@@ -158,7 +158,7 @@
 {
 	unsigned long addr;
 	const unsigned cpu = safe_smp_processor_id();
-	unsigned long *irqstack_end = (unsigned long *)cpu_pda[cpu].irqstackptr;
+	unsigned long *irqstack_end = (unsigned long *)cpu_pda(cpu)->irqstackptr;
 	int i;
 	unsigned used = 0;
 
@@ -226,8 +226,8 @@
 	unsigned long *stack;
 	int i;
 	const int cpu = safe_smp_processor_id();
-	unsigned long *irqstack_end = (unsigned long *) (cpu_pda[cpu].irqstackptr);
-	unsigned long *irqstack = (unsigned long *) (cpu_pda[cpu].irqstackptr - IRQSTACKSIZE);    
+	unsigned long *irqstack_end = (unsigned long *) (cpu_pda(cpu)->irqstackptr);
+	unsigned long *irqstack = (unsigned long *) (cpu_pda(cpu)->irqstackptr - IRQSTACKSIZE);    
 
 	// debugging aid: "show_stack(NULL, NULL);" prints the
 	// back trace for this cpu.
@@ -275,7 +275,7 @@
 	int in_kernel = !user_mode(regs);
 	unsigned long rsp;
 	const int cpu = safe_smp_processor_id(); 
-	struct task_struct *cur = cpu_pda[cpu].pcurrent; 
+	struct task_struct *cur = cpu_pda(cpu)->pcurrent; 
 
 		rsp = regs->rsp;
 
Index: linux-2.6.15-rc1git/arch/x86_64/kernel/x8664_ksyms.c
===================================================================
--- linux-2.6.15-rc1git.orig/arch/x86_64/kernel/x8664_ksyms.c	2005-11-16 12:13:40.000000000 -0800
+++ linux-2.6.15-rc1git/arch/x86_64/kernel/x8664_ksyms.c	2005-11-16 14:08:14.000000000 -0800
@@ -109,7 +109,7 @@
 EXPORT_SYMBOL(copy_page);
 EXPORT_SYMBOL(clear_page);
 
-EXPORT_SYMBOL(cpu_pda);
+EXPORT_SYMBOL(_cpu_pda);
 #ifdef CONFIG_SMP
 EXPORT_SYMBOL(cpu_data);
 EXPORT_SYMBOL(cpu_online_map);
Index: linux-2.6.15-rc1git/arch/x86_64/mm/numa.c
===================================================================
--- linux-2.6.15-rc1git.orig/arch/x86_64/mm/numa.c	2005-11-16 12:13:40.000000000 -0800
+++ linux-2.6.15-rc1git/arch/x86_64/mm/numa.c	2005-11-16 14:11:41.000000000 -0800
@@ -270,7 +270,7 @@
 
 void __cpuinit numa_set_node(int cpu, int node)
 {
-	cpu_pda[cpu].nodenumber = node;
+	cpu_pda(cpu)->nodenumber = node;
 	cpu_to_node[cpu] = node;
 }
 
Index: linux-2.6.15-rc1git/include/asm-x86_64/pda.h
===================================================================
--- linux-2.6.15-rc1git.orig/include/asm-x86_64/pda.h	2005-11-16 12:13:40.000000000 -0800
+++ linux-2.6.15-rc1git/include/asm-x86_64/pda.h	2005-11-16 14:08:14.000000000 -0800
@@ -27,7 +27,9 @@
 #define IRQSTACK_ORDER 2
 #define IRQSTACKSIZE (PAGE_SIZE << IRQSTACK_ORDER) 
 
-extern struct x8664_pda cpu_pda[];
+extern struct x8664_pda _cpu_pda[];
+
+#define cpu_pda(i) (&_cpu_pda[i])
 
 /* 
  * There is no fast way to get the base address of the PDA, all the accesses
Index: linux-2.6.15-rc1git/include/asm-x86_64/percpu.h
===================================================================
--- linux-2.6.15-rc1git.orig/include/asm-x86_64/percpu.h	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.15-rc1git/include/asm-x86_64/percpu.h	2005-11-16 14:08:14.000000000 -0800
@@ -11,7 +11,7 @@
 
 #include <asm/pda.h>
 
-#define __per_cpu_offset(cpu) (cpu_pda[cpu].data_offset)
+#define __per_cpu_offset(cpu) (cpu_pda(cpu)->data_offset)
 #define __my_cpu_offset() read_pda(data_offset)
 
 /* Separate out the type, so (int[3], foo) works. */
