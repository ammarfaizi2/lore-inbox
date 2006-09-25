Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750995AbWIYUOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbWIYUOT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 16:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068AbWIYUOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 16:14:18 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:59114 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750995AbWIYUOP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 16:14:15 -0400
Message-Id: <20060925184638.385115998@goop.org>
References: <20060925184540.601971833@goop.org>
User-Agent: quilt/0.45-1
Date: Mon, 25 Sep 2006 11:45:41 -0700
From: jeremy@goop.org
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       Andi Kleen <ak@suse.de>, James Bottomley <James.Bottomley@SteelEye.com>,
       Matt Tolentino <matthew.e.tolentino@intel.com>
Subject: [PATCH 1/6] Initialize the per-CPU data area.
Content-Disposition: inline; filename=pda/i386-pda-init.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When a CPU is brought up, a PDA and GDT are allocated for it.  The
GDT's __KERNEL_PDA entry is pointed to the allocated PDA memory, so
that all references using this segment descriptor will refer to the PDA.

This patch rearranges CPU initialization a bit, so that the GDT/PDA
are set up as early as possible in cpu_init().  Also for secondary
CPUs, GDT+PDA are preallocated and initialized so all the secondary
CPU needs to do is set up the ldt and load %gs.  This will be
important once smp_processor_id() and current use the PDA.

In all cases, the PDA is set up in head.S, before a CPU starts running
C code, so the PDA is always available.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Zachary Amsden <zach@vmware.com>
Cc: Jan Beulich <jbeulich@novell.com>
Cc: Andi Kleen <ak@suse.de>
Cc: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Matt Tolentino <matthew.e.tolentino@intel.com>

---
 arch/i386/kernel/cpu/common.c |  293 +++++++++++++++++++++++++++--------------
 arch/i386/kernel/smpboot.c    |   31 +++-
 include/asm-i386/pda.h        |   20 ++
 include/asm-i386/processor.h  |    3 
 4 files changed, 239 insertions(+), 108 deletions(-)

diff -r 1555a09108d1 arch/i386/kernel/cpu/common.c
--- a/arch/i386/kernel/cpu/common.c	Sun Sep 24 19:18:35 2006 -0700
+++ b/arch/i386/kernel/cpu/common.c	Mon Sep 25 01:46:27 2006 -0700
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
@@ -582,6 +586,184 @@ void __init early_cpu_init(void)
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
+/* Initial PDA used by boot CPU */
+struct i386_pda boot_pda = {
+	._pda = &boot_pda,
+	.cpu_number = 0,
+	.pcurrent = &init_task,
+};
+
+/* Initialize the CPU's GDT and PDA.  The boot CPU does this for
+   itself, but secondaries find this done for them. */
+__cpuinit int init_gdt(int cpu, struct task_struct *idle)
+{
+	struct Xgt_desc_struct *cpu_gdt_descr = &per_cpu(cpu_gdt_descr, cpu);
+	__u32 stk16_off = (__u32)&per_cpu(cpu_16bit_stack, cpu);
+	struct desc_struct *gdt;
+	struct i386_pda *pda;
+
+	/* For non-boot CPUs, the GDT and PDA should already have been
+	   allocated. */
+	if (!alloc_gdt(cpu)) {
+		printk(KERN_CRIT "CPU%d failed to allocate GDT or PDA\n", cpu);
+		return 0;
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
+	memset(pda, 0, sizeof(*pda));
+	pda->_pda = pda;
+	pda->cpu_number = cpu;
+	pda->pcurrent = idle;
+
+	return 1;
+}
+
+/* Common CPU init for both boot and secondary CPUs */
+static void __cpuinit _cpu_init(int cpu, struct task_struct *curr)
+{
+	struct tss_struct * t = &per_cpu(init_tss, cpu);
+	struct thread_struct *thread = &curr->thread;
+	struct Xgt_desc_struct *cpu_gdt_descr = &per_cpu(cpu_gdt_descr, cpu);
+
+	/* Reinit these anyway, even if they've already been done (on
+	   the boot CPU, this will transition from the boot gdt+pda to
+	   the real ones). */
+	load_gdt(cpu_gdt_descr);
+
+	if (cpu_test_and_set(cpu, cpu_initialized)) {
+		printk(KERN_WARNING "CPU#%d already initialized!\n", cpu);
+		for (;;) local_irq_enable();
+	}
+
+	printk(KERN_INFO "Initializing CPU#%d\n", cpu);
+
+	if (cpu_has_vme || cpu_has_tsc || cpu_has_de)
+		clear_in_cr4(X86_CR4_VME|X86_CR4_PVI|X86_CR4_TSD|X86_CR4_DE);
+	if (tsc_disable && cpu_has_tsc) {
+		printk(KERN_NOTICE "Disabling TSC...\n");
+		/**** FIX-HPA: DOES THIS REALLY BELONG HERE? ****/
+		clear_bit(X86_FEATURE_TSC, boot_cpu_data.x86_capability);
+		set_in_cr4(X86_CR4_TSD);
+	}
+
+	load_idt(&idt_descr);
+
+	/*
+	 * Set up and load the per-CPU TSS and LDT
+	 */
+	atomic_inc(&init_mm.mm_count);
+	curr->active_mm = &init_mm;
+	if (curr->mm)
+		BUG();
+	enter_lazy_tlb(&init_mm, curr);
+
+	load_esp0(t, thread);
+	set_tss_desc(cpu,t);
+	load_TR_desc();
+	load_LDT(&init_mm.context);
+
+#ifdef CONFIG_DOUBLEFAULT
+	/* Set up doublefault TSS pointer in the GDT */
+	__set_tss_desc(cpu, GDT_ENTRY_DOUBLEFAULT_TSS, &doublefault_tss);
+#endif
+
+	/* Clear %fs and %gs. */
+	asm volatile ("movl %0, %%fs; movl %0, %%gs" : : "r" (0));
+
+	/* Clear all 6 debug registers: */
+	set_debugreg(0, 0);
+	set_debugreg(0, 1);
+	set_debugreg(0, 2);
+	set_debugreg(0, 3);
+	set_debugreg(0, 6);
+	set_debugreg(0, 7);
+
+	/*
+	 * Force FPU initialization:
+	 */
+	current_thread_info()->status = 0;
+	clear_used_math();
+	mxcsr_feature_mask_init();
+}
+
+/* Entrypoint to initialize secondary CPU */
+void __cpuinit secondary_cpu_init(void)
+{
+	int cpu = smp_processor_id();
+	struct task_struct *curr = current;
+
+	_cpu_init(cpu, curr);
+}
+
 /*
  * cpu_init() initializes state that is per-CPU. Some data is already
  * initialized (naturally) in the bootstrap process, such as the GDT
@@ -591,106 +773,17 @@ void __cpuinit cpu_init(void)
 void __cpuinit cpu_init(void)
 {
 	int cpu = smp_processor_id();
-	struct tss_struct * t = &per_cpu(init_tss, cpu);
-	struct thread_struct *thread = &current->thread;
-	struct desc_struct *gdt;
-	__u32 stk16_off = (__u32)&per_cpu(cpu_16bit_stack, cpu);
-	struct Xgt_desc_struct *cpu_gdt_descr = &per_cpu(cpu_gdt_descr, cpu);
-
-	if (cpu_test_and_set(cpu, cpu_initialized)) {
-		printk(KERN_WARNING "CPU#%d already initialized!\n", cpu);
-		for (;;) local_irq_enable();
-	}
-	printk(KERN_INFO "Initializing CPU#%d\n", cpu);
-
-	if (cpu_has_vme || cpu_has_tsc || cpu_has_de)
-		clear_in_cr4(X86_CR4_VME|X86_CR4_PVI|X86_CR4_TSD|X86_CR4_DE);
-	if (tsc_disable && cpu_has_tsc) {
-		printk(KERN_NOTICE "Disabling TSC...\n");
-		/**** FIX-HPA: DOES THIS REALLY BELONG HERE? ****/
-		clear_bit(X86_FEATURE_TSC, boot_cpu_data.x86_capability);
-		set_in_cr4(X86_CR4_TSD);
-	}
-
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
-	load_idt(&idt_descr);
-
-	/*
-	 * Set up and load the per-CPU TSS and LDT
-	 */
-	atomic_inc(&init_mm.mm_count);
-	current->active_mm = &init_mm;
-	if (current->mm)
-		BUG();
-	enter_lazy_tlb(&init_mm, current);
-
-	load_esp0(t, thread);
-	set_tss_desc(cpu,t);
-	load_TR_desc();
-	load_LDT(&init_mm.context);
-
-#ifdef CONFIG_DOUBLEFAULT
-	/* Set up doublefault TSS pointer in the GDT */
-	__set_tss_desc(cpu, GDT_ENTRY_DOUBLEFAULT_TSS, &doublefault_tss);
-#endif
-
-	/* Clear %fs and %gs. */
-	asm volatile ("movl %0, %%fs; movl %0, %%gs" : : "r" (0));
-
-	/* Clear all 6 debug registers: */
-	set_debugreg(0, 0);
-	set_debugreg(0, 1);
-	set_debugreg(0, 2);
-	set_debugreg(0, 3);
-	set_debugreg(0, 6);
-	set_debugreg(0, 7);
-
-	/*
-	 * Force FPU initialization:
-	 */
-	current_thread_info()->status = 0;
-	clear_used_math();
-	mxcsr_feature_mask_init();
+	struct task_struct *curr = current;
+
+	/* Set up the real GDT and PDA, so we can transition from the
+	   boot versions. */
+	if (!init_gdt(cpu, curr)) {
+		/* failed to allocate something; not much we can do... */
+		for (;;)
+			local_irq_enable();
+	}
+
+	_cpu_init(cpu, curr);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
diff -r 1555a09108d1 arch/i386/kernel/smpboot.c
--- a/arch/i386/kernel/smpboot.c	Sun Sep 24 19:18:35 2006 -0700
+++ b/arch/i386/kernel/smpboot.c	Mon Sep 25 01:46:27 2006 -0700
@@ -536,11 +536,11 @@ static void __devinit start_secondary(vo
 static void __devinit start_secondary(void *unused)
 {
 	/*
-	 * Dont put anything before smp_callin(), SMP
+	 * Don't put *anything* before secondary_cpu_init(), SMP
 	 * booting is too fragile that we want to limit the
 	 * things done here to the most necessary things.
 	 */
-	cpu_init();
+	secondary_cpu_init();
 	preempt_disable();
 	smp_callin();
 	while (!cpu_isset(smp_processor_id(), smp_commenced_mask))
@@ -599,13 +599,16 @@ void __devinit initialize_secondary(void
 		"movl %0,%%esp\n\t"
 		"jmp *%1"
 		:
-		:"r" (current->thread.esp),"r" (current->thread.eip));
-}
-
+		:"m" (current->thread.esp),"m" (current->thread.eip));
+}
+
+/* Static state in head.S used to set up a CPU */
 extern struct {
 	void * esp;
 	unsigned short ss;
 } stack_start;
+extern struct i386_pda *start_pda;
+extern struct Xgt_desc_struct cpu_gdt_descr;
 
 #ifdef CONFIG_NUMA
 
@@ -936,9 +939,6 @@ static int __devinit do_boot_cpu(int api
 	unsigned long start_eip;
 	unsigned short nmi_high = 0, nmi_low = 0;
 
-	++cpucount;
-	alternatives_smp_switch(1);
-
 	/*
 	 * We can't use kernel_thread since we must avoid to
 	 * reschedule the child.
@@ -946,14 +946,29 @@ static int __devinit do_boot_cpu(int api
 	idle = alloc_idle_task(cpu);
 	if (IS_ERR(idle))
 		panic("failed fork for CPU %d", cpu);
+
+	/* Pre-allocate and initialize the CPU's GDT and PDA so it
+	   doesn't have to do any memory allocation during the
+	   delicate CPU-bringup phase. */
+	if (!init_gdt(cpu, idle)) {
+		printk(KERN_INFO "Couldn't allocate GDT/PDA for CPU %d\n", cpu);
+		return -1;	/* ? */
+	}
+
 	idle->thread.eip = (unsigned long) start_secondary;
 	/* start_eip had better be page-aligned! */
 	start_eip = setup_trampoline();
+
+	++cpucount;
+	alternatives_smp_switch(1);
 
 	/* So we see what's up   */
 	printk("Booting processor %d/%d eip %lx\n", cpu, apicid, start_eip);
 	/* Stack for startup_32 can be just as for start_secondary onwards */
 	stack_start.esp = (void *) idle->thread.esp;
+
+	start_pda = cpu_pda(cpu);
+	cpu_gdt_descr = per_cpu(cpu_gdt_descr, cpu);
 
 	irq_ctx_init(cpu);
 
diff -r 1555a09108d1 include/asm-i386/pda.h
--- a/include/asm-i386/pda.h	Sun Sep 24 19:18:35 2006 -0700
+++ b/include/asm-i386/pda.h	Mon Sep 25 01:46:27 2006 -0700
@@ -1,8 +1,12 @@
 #ifndef _I386_PDA_H
 #define _I386_PDA_H
 
+#include <linux/stddef.h>
+
 struct i386_pda
 {
+	struct i386_pda *_pda;		/* pointer to self */
+
 	struct task_struct *pcurrent;	/* current process */
 	int cpu_number;
 };
@@ -22,6 +26,12 @@ extern struct i386_pda _proxy_pda;
 		typedef typeof(_proxy_pda.field) T__;			\
 		if (0) { T__ tmp__; tmp__ = (val); }			\
 		switch (sizeof(_proxy_pda.field)) {			\
+		case 1:							\
+			asm(op "b %1,%%gs:%c2"				\
+			    : "+m" (_proxy_pda.field)			\
+			    :"ri" ((T__)val),				\
+			     "i"(pda_offset(field)));			\
+			break;						\
 		case 2:							\
 			asm(op "w %1,%%gs:%c2"				\
 			    : "+m" (_proxy_pda.field)			\
@@ -42,6 +52,12 @@ extern struct i386_pda _proxy_pda;
 	({								\
 		typeof(_proxy_pda.field) ret__;				\
 		switch (sizeof(_proxy_pda.field)) {			\
+		case 1:							\
+			asm(op "b %%gs:%c1,%0"				\
+			    : "=r" (ret__)				\
+			    : "i" (pda_offset(field)),			\
+			      "m" (_proxy_pda.field));			\
+			break;						\
 		case 2:							\
 			asm(op "w %%gs:%c1,%0"				\
 			    : "=r" (ret__)				\
@@ -58,6 +74,10 @@ extern struct i386_pda _proxy_pda;
 		}							\
 		ret__; })
 
+/* Return a pointer to a pda field */
+#define pda_addr(field)							\
+	((typeof(_proxy_pda.field) *)((unsigned char *)read_pda(_pda) + \
+				      pda_offset(field)))
 
 #define read_pda(field) pda_from_op("mov",field)
 #define write_pda(field,val) pda_to_op("mov",field,val)
diff -r 1555a09108d1 include/asm-i386/processor.h
--- a/include/asm-i386/processor.h	Sun Sep 24 19:18:35 2006 -0700
+++ b/include/asm-i386/processor.h	Mon Sep 25 01:46:27 2006 -0700
@@ -727,4 +727,7 @@ extern void enable_sep_cpu(void);
 extern void enable_sep_cpu(void);
 extern int sysenter_setup(void);
 
+extern int init_gdt(int cpu, struct task_struct *idle);
+extern void secondary_cpu_init(void);
+
 #endif /* __ASM_I386_PROCESSOR_H */

--

