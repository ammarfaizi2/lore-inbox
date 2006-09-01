Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964873AbWIAGtX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbWIAGtX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 02:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964784AbWIAGtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 02:49:18 -0400
Received: from gw.goop.org ([64.81.55.164]:3782 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932354AbWIAGsv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 02:48:51 -0400
Message-Id: <20060901064823.575019226@goop.org>
References: <20060901064718.918494029@goop.org>
User-Agent: quilt/0.45-1
Date: Thu, 31 Aug 2006 23:47:21 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: linux-kernel@vger.kernel.org
Cc: Chuck Ebbert <76306.1226@compuserve.com>, Zachary Amsden <zach@vmware.com>,
       Jan Beulich <jbeulich@novell.com>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Matt Tolentino <matthew.e.tolentino@intel.com>
Subject: [PATCH 3/8] Initialize the per-CPU data area.
Content-Disposition: inline; filename=i386-pda-init.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When a CPU is brought up, a PDA and GDT are allocated for it.  The
GDT's __KERNEL_PDA entry is pointed to the allocated PDA memory, so
that all references using this segment descriptor will refer to the PDA.

This patch rearranges CPU initialization a bit, so that the GDT/PDA
are set up as early as possible in cpu_init().  Also for secondary
CPUs, GDT+PDA are preallocated so the secondary CPU doesn't need to do
any memory allocation while setting up the PDA.  This will be
important once smp_processor_id() and current use the PDA.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Zachary Amsden <zach@vmware.com>
Cc: Jan Beulich <jbeulich@novell.com>
Cc: Andi Kleen <ak@suse.de>
Cc: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Matt Tolentino <matthew.e.tolentino@intel.com>

---
 arch/i386/kernel/cpu/common.c |  161 +++++++++++++++++++++++++++++------------
 arch/i386/kernel/smpboot.c    |   10 ++
 include/asm-i386/processor.h  |    1 
 3 files changed, 127 insertions(+), 45 deletions(-)


===================================================================
--- a/arch/i386/kernel/cpu/common.c
+++ b/arch/i386/kernel/cpu/common.c
@@ -18,6 +18,7 @@
 #include <asm/apic.h>
 #include <mach_apic.h>
 #endif
+#include <asm/pda.h>
 
 #include "cpu.h"
 
@@ -26,6 +27,9 @@ EXPORT_PER_CPU_SYMBOL(cpu_gdt_descr);
 
 DEFINE_PER_CPU(unsigned char, cpu_16bit_stack[CPU_16BIT_STACK_SIZE]);
 EXPORT_PER_CPU_SYMBOL(cpu_16bit_stack);
+
+struct i386_pda *_cpu_pda[NR_CPUS] __read_mostly;
+EXPORT_SYMBOL(_cpu_pda);
 
 static int cachesize_override __cpuinitdata = -1;
 static int disable_x86_fxsr __cpuinitdata;
@@ -582,6 +586,114 @@ void __init early_cpu_init(void)
 	disable_pse = 1;
 #endif
 }
+
+__cpuinit int alloc_gdt(int cpu)
+{
+	struct Xgt_desc_struct *cpu_gdt_descr = &per_cpu(cpu_gdt_descr, cpu);
+	struct desc_struct *gdt;
+	struct i386_pda *pda;
+
+	gdt = (struct desc_struct *)cpu_gdt_descr->address;
+	pda = cpu_pda(cpu);
+
+	/*
+	 * This is a horrible hack to allocate the GDT.  The problem
+	 * is that cpu_init() is called really early for the boot CPU
+	 * (and hence needs bootmem) but much later for the secondary
+	 * CPUs, when bootmem will have gone away
+	 */
+	if (NODE_DATA(0)->bdata->node_bootmem_map) {
+		BUG_ON(gdt != NULL || pda != NULL);
+
+		gdt = alloc_bootmem_pages(PAGE_SIZE);
+		pda = alloc_bootmem(sizeof(*pda));
+		/* alloc_bootmem(_pages) panics on failure, so no check */
+
+		memset(gdt, 0, PAGE_SIZE);
+		memset(pda, 0, sizeof(*pda));
+	} else {
+		/* GDT and PDA might already have been allocated if
+		   this is a CPU hotplug re-insertion. */
+		if (gdt == NULL)
+			gdt = (struct desc_struct *)get_zeroed_page(GFP_KERNEL);
+
+		if (pda == NULL)
+			pda = kmalloc_node(sizeof(*pda), GFP_KERNEL, cpu_to_node(cpu));
+
+		if (unlikely(!gdt || !pda)) {
+			free_pages((unsigned long)gdt, 0);
+			kfree(pda);
+			return 0;
+		}
+	}
+	
+ 	cpu_gdt_descr->address = (unsigned long)gdt;
+	cpu_pda(cpu) = pda;
+
+	return 1;
+}
+
+static __cpuinit void pda_init(int cpu, struct task_struct *curr)
+{
+	struct i386_pda *pda = cpu_pda(cpu);
+
+	memset(pda, 0, sizeof(*pda));
+
+	pda->_pda = pda;
+
+	pda->cpu_number = cpu;
+	pda->pcurrent = curr;
+
+	printk("cpu %d current %p\n", cpu, curr);
+}
+
+/* Initialize the CPU's GDT and PDA */
+static __cpuinit void init_gdt(void)
+{
+	int cpu = smp_processor_id();
+	struct task_struct *curr = current;
+	struct Xgt_desc_struct *cpu_gdt_descr = &per_cpu(cpu_gdt_descr, cpu);
+	__u32 stk16_off = (__u32)&per_cpu(cpu_16bit_stack, cpu);
+	struct desc_struct *gdt;
+	struct i386_pda *pda;
+
+	/* For non-boot CPUs, the GDT and PDA should already have been
+	   allocated. */
+	if (!alloc_gdt(cpu)) {
+		printk(KERN_CRIT "CPU%d failed to allocate GDT or PDA\n", cpu);
+		for (;;)
+			local_irq_enable();
+	}
+
+	gdt = (struct desc_struct *)cpu_gdt_descr->address;
+	pda = cpu_pda(cpu);
+
+	BUG_ON(gdt == NULL || pda == NULL);
+
+	/*
+	 * Initialize the per-CPU GDT with the boot GDT,
+	 * and set up the GDT descriptor:
+	 */
+ 	memcpy(gdt, cpu_gdt_table, GDT_SIZE);
+	cpu_gdt_descr->size = GDT_SIZE - 1;
+
+	/* Set up GDT entry for 16bit stack */
+ 	*(__u64 *)(&gdt[GDT_ENTRY_ESPFIX_SS]) |=
+		((((__u64)stk16_off) << 16) & 0x000000ffffff0000ULL) |
+		((((__u64)stk16_off) << 32) & 0xff00000000000000ULL) |
+		(CPU_16BIT_STACK_SIZE - 1);
+
+	pack_descriptor((u32 *)&gdt[GDT_ENTRY_PDA].a,
+			(u32 *)&gdt[GDT_ENTRY_PDA].b,
+			(unsigned long)pda, sizeof(*pda) - 1,
+			0x80 | DESCTYPE_S | 0x2, 0); /* present read-write data segment */
+
+	load_gdt(cpu_gdt_descr);
+
+	/* Do this once everything GDT-related has been set up. */
+	pda_init(cpu, curr);
+}
+
 /*
  * cpu_init() initializes state that is per-CPU. Some data is already
  * initialized (naturally) in the bootstrap process, such as the GDT
@@ -593,14 +705,16 @@ void __cpuinit cpu_init(void)
 	int cpu = smp_processor_id();
 	struct tss_struct * t = &per_cpu(init_tss, cpu);
 	struct thread_struct *thread = &current->thread;
-	struct desc_struct *gdt;
-	__u32 stk16_off = (__u32)&per_cpu(cpu_16bit_stack, cpu);
-	struct Xgt_desc_struct *cpu_gdt_descr = &per_cpu(cpu_gdt_descr, cpu);
 
 	if (cpu_test_and_set(cpu, cpu_initialized)) {
 		printk(KERN_WARNING "CPU#%d already initialized!\n", cpu);
 		for (;;) local_irq_enable();
 	}
+
+	/* Init the GDT and PDA early, before calling printk(),
+	   since it may end up using the PDA indirectly. */
+	init_gdt();
+
 	printk(KERN_INFO "Initializing CPU#%d\n", cpu);
 
 	if (cpu_has_vme || cpu_has_tsc || cpu_has_de)
@@ -612,47 +726,6 @@ void __cpuinit cpu_init(void)
 		set_in_cr4(X86_CR4_TSD);
 	}
 
-	/* The CPU hotplug case */
-	if (cpu_gdt_descr->address) {
-		gdt = (struct desc_struct *)cpu_gdt_descr->address;
-		memset(gdt, 0, PAGE_SIZE);
-		goto old_gdt;
-	}
-	/*
-	 * This is a horrible hack to allocate the GDT.  The problem
-	 * is that cpu_init() is called really early for the boot CPU
-	 * (and hence needs bootmem) but much later for the secondary
-	 * CPUs, when bootmem will have gone away
-	 */
-	if (NODE_DATA(0)->bdata->node_bootmem_map) {
-		gdt = (struct desc_struct *)alloc_bootmem_pages(PAGE_SIZE);
-		/* alloc_bootmem_pages panics on failure, so no check */
-		memset(gdt, 0, PAGE_SIZE);
-	} else {
-		gdt = (struct desc_struct *)get_zeroed_page(GFP_KERNEL);
-		if (unlikely(!gdt)) {
-			printk(KERN_CRIT "CPU%d failed to allocate GDT\n", cpu);
-			for (;;)
-				local_irq_enable();
-		}
-	}
-old_gdt:
-	/*
-	 * Initialize the per-CPU GDT with the boot GDT,
-	 * and set up the GDT descriptor:
-	 */
- 	memcpy(gdt, cpu_gdt_table, GDT_SIZE);
-
-	/* Set up GDT entry for 16bit stack */
- 	*(__u64 *)(&gdt[GDT_ENTRY_ESPFIX_SS]) |=
-		((((__u64)stk16_off) << 16) & 0x000000ffffff0000ULL) |
-		((((__u64)stk16_off) << 32) & 0xff00000000000000ULL) |
-		(CPU_16BIT_STACK_SIZE - 1);
-
-	cpu_gdt_descr->size = GDT_SIZE - 1;
- 	cpu_gdt_descr->address = (unsigned long)gdt;
-
-	load_gdt(cpu_gdt_descr);
 	load_idt(&idt_descr);
 
 	/*
===================================================================
--- a/arch/i386/kernel/smpboot.c
+++ b/arch/i386/kernel/smpboot.c
@@ -536,7 +536,7 @@ static void __devinit start_secondary(vo
 static void __devinit start_secondary(void *unused)
 {
 	/*
-	 * Dont put anything before smp_callin(), SMP
+	 * Don't put *anything* before cpu_init(), SMP
 	 * booting is too fragile that we want to limit the
 	 * things done here to the most necessary things.
 	 */
@@ -931,6 +931,14 @@ static int __devinit do_boot_cpu(int api
 	int timeout;
 	unsigned long start_eip;
 	unsigned short nmi_high = 0, nmi_low = 0;
+
+	/* Pre-allocate the CPU's GDT and PDA so it doesn't have to do
+	   any memory allocation during the delicate CPU-bringup
+	   phase. */
+	if (!alloc_gdt(cpu)) {
+		printk(KERN_INFO "Couldn't allocate GDT/PDA for CPU %d\n", cpu);
+		return -1;	/* ? */
+	}
 
 	++cpucount;
 	alternatives_smp_switch(1);
===================================================================
--- a/include/asm-i386/processor.h
+++ b/include/asm-i386/processor.h
@@ -726,5 +726,6 @@ extern unsigned long boot_option_idle_ov
 extern unsigned long boot_option_idle_override;
 extern void enable_sep_cpu(void);
 extern int sysenter_setup(void);
+extern int alloc_gdt(int cpu);
 
 #endif /* __ASM_I386_PROCESSOR_H */

--

