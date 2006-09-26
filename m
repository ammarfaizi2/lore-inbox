Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751722AbWIZHKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722AbWIZHKn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 03:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751728AbWIZHKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 03:10:43 -0400
Received: from gw.goop.org ([64.81.55.164]:9865 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751722AbWIZHKk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 03:10:40 -0400
Message-ID: <4518D273.2030103@goop.org>
Date: Tue, 26 Sep 2006 00:10:43 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: revised pda patches
Content-Type: multipart/mixed;
 boundary="------------030400020009010601020700"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030400020009010601020700
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andi,

Here's an updated series of PDA patches based on your tree.  They're 
intended to replace these:

    i386-pda-basics
    i386-pda-init-pda
    i386-pda-use-gs
    i386-pda-user-abi
    i386-pda-vm86
    i386-pda-smp-processorid
    i386-pda-current

with these:

    i386-pda-definitions.patch
    i386-pda-init.patch
    i386-pda-use-gs.patch
    i386-pda-fix-abi.patch
    i386-pda-fix-vm86.patch
    i386-pda-smp_processor_id.patch
    i386-pda-current.patch

Thanks,
    J

--------------030400020009010601020700
Content-Type: text/x-patch;
 name="i386-pda-definitions.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i386-pda-definitions.patch"

Basic definitions for i386-pda

This patch has the basic definitions of struct i386_pda, and the
segment selector in the GDT.

asm-i386/pda.h is more or less a direct copy of asm-x86_64/pda.h.  The
most interesting difference is the use of _proxy_pda, which is used to
give gcc a model for the actual memory operations on the real pda
structure.  No actual reference is ever made to _proxy_pda, so it is
never defined.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Zachary Amsden <zach@vmware.com>
Cc: Jan Beulich <jbeulich@novell.com>
Cc: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/asm-offsets.c |    4 +
 arch/i386/kernel/head.S        |    2
 include/asm-i386/pda.h         |   86 ++++++++++++++++++++++++++++++++++++++++
 include/asm-i386/segment.h     |    5 +-
 4 files changed, 95 insertions(+), 2 deletions(-)

diff -r 0a6d1e9953f7 arch/i386/kernel/asm-offsets.c
--- a/arch/i386/kernel/asm-offsets.c	Mon Sep 25 15:41:31 2006 -0700
+++ b/arch/i386/kernel/asm-offsets.c	Mon Sep 25 22:36:23 2006 -0700
@@ -15,6 +15,7 @@
 #include <asm/processor.h>
 #include <asm/thread_info.h>
 #include <asm/elf.h>
+#include <asm/pda.h>
 
 #define DEFINE(sym, val) \
         asm volatile("\n->" #sym " %0 " #val : : "i" (val))
@@ -91,4 +92,7 @@ void foo(void)
 	DEFINE(VDSO_PRELINK, VDSO_PRELINK);
 
 	OFFSET(crypto_tfm_ctx_offset, crypto_tfm, __crt_ctx);
+
+	BLANK();
+	OFFSET(PDA_pcurrent, i386_pda, pcurrent);
 }
diff -r 0a6d1e9953f7 arch/i386/kernel/head.S
--- a/arch/i386/kernel/head.S	Mon Sep 25 15:41:31 2006 -0700
+++ b/arch/i386/kernel/head.S	Mon Sep 25 22:36:23 2006 -0700
@@ -518,7 +518,7 @@ ENTRY(cpu_gdt_table)
 	.quad 0x004092000000ffff	/* 0xc8 APM DS    data */
 
 	.quad 0x0000920000000000	/* 0xd0 - ESPFIX 16-bit SS */
-	.quad 0x0000000000000000	/* 0xd8 - unused */
+	.quad 0x0000000000000000	/* 0xd8 - PDA */
 	.quad 0x0000000000000000	/* 0xe0 - unused */
 	.quad 0x0000000000000000	/* 0xe8 - unused */
 	.quad 0x0000000000000000	/* 0xf0 - unused */
diff -r 0a6d1e9953f7 include/asm-i386/pda.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/include/asm-i386/pda.h	Mon Sep 25 22:40:32 2006 -0700
@@ -0,0 +1,98 @@
+/* 
+   Per-processor Data Areas
+   Jeremy Fitzhardinge <jeremy@goop.org> 2006
+   Based on asm-x86_64/pda.h by Andi Kleen.
+ */
+#ifndef _I386_PDA_H
+#define _I386_PDA_H
+
+#include <linux/stddef.h>
+
+struct i386_pda
+{
+	struct i386_pda *_pda;		/* pointer to self */
+
+	struct task_struct *pcurrent;	/* current process */
+	int cpu_number;
+};
+
+extern struct i386_pda *_cpu_pda[];
+
+#define cpu_pda(i)	(_cpu_pda[i])
+
+#define pda_offset(field) offsetof(struct i386_pda, field)
+
+extern void __bad_pda_field(void);
+
+/* This variable is never instantiated.  It is only used as a stand-in
+   for the real per-cpu PDA memory, so that gcc can understand what
+   memory operations the inline asms() below are performing.  This
+   eliminates the need to make the asms volatile or have memory
+   clobbers, so gcc can readily analyse them. */
+extern struct i386_pda _proxy_pda;
+
+#define pda_to_op(op,field,val)						\
+	do {								\
+		typedef typeof(_proxy_pda.field) T__;			\
+		if (0) { T__ tmp__; tmp__ = (val); }			\
+		switch (sizeof(_proxy_pda.field)) {			\
+		case 1:							\
+			asm(op "b %1,%%gs:%c2"				\
+			    : "+m" (_proxy_pda.field)			\
+			    :"ri" ((T__)val),				\
+			     "i"(pda_offset(field)));			\
+			break;						\
+		case 2:							\
+			asm(op "w %1,%%gs:%c2"				\
+			    : "+m" (_proxy_pda.field)			\
+			    :"ri" ((T__)val),				\
+			     "i"(pda_offset(field)));			\
+			break;						\
+		case 4:							\
+			asm(op "l %1,%%gs:%c2"				\
+			    : "+m" (_proxy_pda.field)			\
+			    :"ri" ((T__)val),				\
+			     "i"(pda_offset(field)));			\
+			break;						\
+		default: __bad_pda_field();				\
+		}							\
+	} while (0)
+
+#define pda_from_op(op,field)						\
+	({								\
+		typeof(_proxy_pda.field) ret__;				\
+		switch (sizeof(_proxy_pda.field)) {			\
+		case 1:							\
+			asm(op "b %%gs:%c1,%0"				\
+			    : "=r" (ret__)				\
+			    : "i" (pda_offset(field)),			\
+			      "m" (_proxy_pda.field));			\
+			break;						\
+		case 2:							\
+			asm(op "w %%gs:%c1,%0"				\
+			    : "=r" (ret__)				\
+			    : "i" (pda_offset(field)),			\
+			      "m" (_proxy_pda.field));			\
+			break;						\
+		case 4:							\
+			asm(op "l %%gs:%c1,%0"				\
+			    : "=r" (ret__)				\
+			    : "i" (pda_offset(field)),			\
+			      "m" (_proxy_pda.field));			\
+			break;						\
+		default: __bad_pda_field();				\
+		}							\
+		ret__; })
+
+/* Return a pointer to a pda field */
+#define pda_addr(field)							\
+	((typeof(_proxy_pda.field) *)((unsigned char *)read_pda(_pda) + \
+				      pda_offset(field)))
+
+#define read_pda(field) pda_from_op("mov",field)
+#define write_pda(field,val) pda_to_op("mov",field,val)
+#define add_pda(field,val) pda_to_op("add",field,val)
+#define sub_pda(field,val) pda_to_op("sub",field,val)
+#define or_pda(field,val) pda_to_op("or",field,val)
+
+#endif	/* _I386_PDA_H */
diff -r 0a6d1e9953f7 include/asm-i386/segment.h
--- a/include/asm-i386/segment.h	Mon Sep 25 15:41:31 2006 -0700
+++ b/include/asm-i386/segment.h	Mon Sep 25 15:41:36 2006 -0700
@@ -39,7 +39,7 @@
  *  25 - APM BIOS support 
  *
  *  26 - ESPFIX small SS
- *  27 - unused
+ *  27 - PDA				[ per-cpu private data area ]
  *  28 - unused
  *  29 - unused
  *  30 - unused
@@ -73,6 +73,9 @@
 
 #define GDT_ENTRY_ESPFIX_SS		(GDT_ENTRY_KERNEL_BASE + 14)
 #define __ESPFIX_SS (GDT_ENTRY_ESPFIX_SS * 8)
+
+#define GDT_ENTRY_PDA			(GDT_ENTRY_KERNEL_BASE + 15)
+#define __KERNEL_PDA (GDT_ENTRY_PDA * 8)
 
 #define GDT_ENTRY_DOUBLEFAULT_TSS	31
 

--------------030400020009010601020700
Content-Type: text/x-patch;
 name="i386-pda-init.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i386-pda-init.patch"

Initialize the per-CPU data area.

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

diff -r 575ec0ce9e80 arch/i386/kernel/cpu/common.c
--- a/arch/i386/kernel/cpu/common.c	Mon Sep 25 23:29:45 2006 -0700
+++ b/arch/i386/kernel/cpu/common.c	Mon Sep 25 23:30:45 2006 -0700
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
diff -r 575ec0ce9e80 arch/i386/kernel/smpboot.c
--- a/arch/i386/kernel/smpboot.c	Mon Sep 25 23:29:45 2006 -0700
+++ b/arch/i386/kernel/smpboot.c	Mon Sep 25 23:29:47 2006 -0700
@@ -534,11 +534,11 @@ static void __devinit start_secondary(vo
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
@@ -597,13 +597,16 @@ void __devinit initialize_secondary(void
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
 
@@ -929,9 +932,6 @@ static int __devinit do_boot_cpu(int api
 	unsigned long start_eip;
 	unsigned short nmi_high = 0, nmi_low = 0;
 
-	++cpucount;
-	alternatives_smp_switch(1);
-
 	/*
 	 * We can't use kernel_thread since we must avoid to
 	 * reschedule the child.
@@ -939,14 +939,29 @@ static int __devinit do_boot_cpu(int api
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
 
diff -r 575ec0ce9e80 include/asm-i386/processor.h
--- a/include/asm-i386/processor.h	Mon Sep 25 23:29:45 2006 -0700
+++ b/include/asm-i386/processor.h	Mon Sep 25 23:29:47 2006 -0700
@@ -731,4 +731,7 @@ extern void enable_sep_cpu(void);
 extern void enable_sep_cpu(void);
 extern int sysenter_setup(void);
 
+extern int init_gdt(int cpu, struct task_struct *idle);
+extern void secondary_cpu_init(void);
+
 #endif /* __ASM_I386_PROCESSOR_H */

--------------030400020009010601020700
Content-Type: text/x-patch;
 name="i386-pda-use-gs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i386-pda-use-gs.patch"

Use %gs as the PDA base-segment in the kernel.

This patch is the meat of the PDA change.  This patch makes several
related changes:

1: Most significantly, %gs is now used in the kernel.  This means that on
   entry, the old value of %gs is saved away, and it is reloaded with
   __KERNEL_PDA.

2: entry.S constructs the stack in the shape of struct pt_regs, and this
   is passed around the kernel so that the process's saved register
   state can be accessed.

   Unfortunately struct pt_regs doesn't currently have space for %gs
   (or %fs). This patch extends pt_regs to add space for gs (no space
   is allocated for %fs, since it won't be used, and it would just
   complicate the code in entry.S to work around the space).

3: Because %gs is now saved on the stack like %ds, %es and the integer
   registers, there are a number of places where it no longer needs to
   be handled specially; namely context switch, and saving/restoring the
   register state in a signal context.

4: And since kernel threads run in kernel space and call normal kernel
   code, they need to be created with their %gs == __KERNEL_PDA.

NOTE: even though it's called "ptrace-abi.h", this file does not
define a user-space visible ABI.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Zachary Amsden <zach@vmware.com>
Cc: Jan Beulich <jbeulich@novell.com>
Cc: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/asm-offsets.c |    1
 arch/i386/kernel/cpu/common.c  |   21 +++++++++-
 arch/i386/kernel/entry.S       |   81 +++++++++++++++++++++++-----------------
 arch/i386/kernel/head.S        |   33 +++++++++++++---
 arch/i386/kernel/process.c     |   27 ++++++-------
 arch/i386/kernel/signal.c      |    6 --
 include/asm-i386/mmu_context.h |    4 -
 include/asm-i386/processor.h   |    4 +
 include/asm-i386/ptrace.h      |    2
 kernel/fork.c                  |    2
 10 files changed, 119 insertions(+), 62 deletions(-)

diff -r 1b8b053ad03f arch/i386/kernel/asm-offsets.c
--- a/arch/i386/kernel/asm-offsets.c	Mon Sep 25 23:31:01 2006 -0700
+++ b/arch/i386/kernel/asm-offsets.c	Mon Sep 25 23:31:04 2006 -0700
@@ -68,6 +68,7 @@ void foo(void)
 	OFFSET(PT_EAX, pt_regs, eax);
 	OFFSET(PT_DS,  pt_regs, xds);
 	OFFSET(PT_ES,  pt_regs, xes);
+	OFFSET(PT_GS,  pt_regs, xgs);
 	OFFSET(PT_ORIG_EAX, pt_regs, orig_eax);
 	OFFSET(PT_EIP, pt_regs, eip);
 	OFFSET(PT_CS,  pt_regs, xcs);
diff -r 1b8b053ad03f arch/i386/kernel/cpu/common.c
--- a/arch/i386/kernel/cpu/common.c	Mon Sep 25 23:31:01 2006 -0700
+++ b/arch/i386/kernel/cpu/common.c	Mon Sep 25 23:31:04 2006 -0700
@@ -587,6 +587,14 @@ void __init early_cpu_init(void)
 #endif
 }
 
+/* Make sure %gs is initialized properly in idle threads */
+struct pt_regs * __devinit idle_regs(struct pt_regs *regs)
+{
+	memset(regs, 0, sizeof(struct pt_regs));
+	regs->xgs = __KERNEL_PDA;
+	return regs;
+}
+
 __cpuinit int alloc_gdt(int cpu)
 {
 	struct Xgt_desc_struct *cpu_gdt_descr = &per_cpu(cpu_gdt_descr, cpu);
@@ -640,6 +648,14 @@ struct i386_pda boot_pda = {
 	.pcurrent = &init_task,
 };
 
+static inline void set_kernel_gs(void)
+{
+	/* Set %gs for this CPU's PDA.  Memory clobber is to create a
+	   barrier with respect to any PDA operations, so the compiler
+	   doesn't move any before here. */
+	asm volatile ("mov %0, %%gs" : : "r" (__KERNEL_PDA) : "memory");
+}
+
 /* Initialize the CPU's GDT and PDA.  The boot CPU does this for
    itself, but secondaries find this done for them. */
 __cpuinit int init_gdt(int cpu, struct task_struct *idle)
@@ -698,6 +714,7 @@ static void __cpuinit _cpu_init(int cpu,
 	   the boot CPU, this will transition from the boot gdt+pda to
 	   the real ones). */
 	load_gdt(cpu_gdt_descr);
+	set_kernel_gs();
 
 	if (cpu_test_and_set(cpu, cpu_initialized)) {
 		printk(KERN_WARNING "CPU#%d already initialized!\n", cpu);
@@ -736,8 +753,8 @@ static void __cpuinit _cpu_init(int cpu,
 	__set_tss_desc(cpu, GDT_ENTRY_DOUBLEFAULT_TSS, &doublefault_tss);
 #endif
 
-	/* Clear %fs and %gs. */
-	asm volatile ("movl %0, %%fs; movl %0, %%gs" : : "r" (0));
+	/* Clear %fs. */
+	asm volatile ("mov %0, %%fs" : : "r" (0));
 
 	/* Clear all 6 debug registers: */
 	set_debugreg(0, 0);
diff -r 1b8b053ad03f arch/i386/kernel/entry.S
--- a/arch/i386/kernel/entry.S	Mon Sep 25 23:31:01 2006 -0700
+++ b/arch/i386/kernel/entry.S	Mon Sep 25 23:32:16 2006 -0700
@@ -30,12 +30,13 @@
  *	18(%esp) - %eax
  *	1C(%esp) - %ds
  *	20(%esp) - %es
- *	24(%esp) - orig_eax
- *	28(%esp) - %eip
- *	2C(%esp) - %cs
- *	30(%esp) - %eflags
- *	34(%esp) - %oldesp
- *	38(%esp) - %oldss
+ *	24(%esp) - %gs
+ *	28(%esp) - orig_eax
+ *	2C(%esp) - %eip
+ *	30(%esp) - %cs
+ *	34(%esp) - %eflags
+ *	38(%esp) - %oldesp
+ *	3C(%esp) - %oldss
  *
  * "current" is in register %ebx during any slow entries.
  */
@@ -91,6 +92,9 @@ 1:
 
 #define SAVE_ALL \
 	cld; \
+	pushl %gs; \
+	CFI_ADJUST_CFA_OFFSET 4;\
+	/*CFI_REL_OFFSET gs, 0;*/\
 	pushl %es; \
 	CFI_ADJUST_CFA_OFFSET 4;\
 	/*CFI_REL_OFFSET es, 0;*/\
@@ -120,8 +124,10 @@ 1:
 	CFI_REL_OFFSET ebx, 0;\
 	movl $(__USER_DS), %edx; \
 	movl %edx, %ds; \
-	movl %edx, %es;
-
+	movl %edx, %es; \
+	movl $(__KERNEL_PDA), %edx; \
+	movl %edx, %gs
+	
 #define RESTORE_INT_REGS \
 	popl %ebx;	\
 	CFI_ADJUST_CFA_OFFSET -4;\
@@ -153,17 +159,22 @@ 2:	popl %es;	\
 2:	popl %es;	\
 	CFI_ADJUST_CFA_OFFSET -4;\
 	/*CFI_RESTORE es;*/\
-.section .fixup,"ax";	\
-3:	movl $0,(%esp);	\
+3:	popl %gs;	\
+	CFI_ADJUST_CFA_OFFSET -4;\
+	/*CFI_RESTORE gs;*/\
+.pushsection .fixup,"ax";	\
+4:	movl $0,(%esp);	\
 	jmp 1b;		\
-4:	movl $0,(%esp);	\
+5:	movl $0,(%esp);	\
 	jmp 2b;		\
-.previous;		\
+6:	movl $0,(%esp);	\
+	jmp 3b;		\
 .section __ex_table,"a";\
 	.align 4;	\
-	.long 1b,3b;	\
-	.long 2b,4b;	\
-.previous
+	.long 1b,4b;	\
+	.long 2b,5b;	\
+	.long 3b,6b;	\
+.popsection
 
 #define RING0_INT_FRAME \
 	CFI_STARTPROC simple;\
@@ -321,10 +332,17 @@ 1:	movl (%ebp),%ebp
 	movl PT_EIP(%esp), %edx
 	movl PT_OLDESP(%esp), %ecx
 	xorl %ebp,%ebp
+1:	mov PT_GS(%esp), %gs
 	TRACE_IRQS_ON
 	ENABLE_INTERRUPTS_SYSEXIT
 	CFI_ENDPROC
-
+.pushsection .fixup,"ax"
+2:	movl $0,PT_GS(%esp)
+	jmp 1b
+.section __ex_table,"a"
+	.align 4
+	.long 1b,2b
+.popsection
 
 	# system call handler stub
 ENTRY(system_call)
@@ -370,7 +388,7 @@ restore_nocheck:
 	TRACE_IRQS_IRET
 restore_nocheck_notrace:
 	RESTORE_REGS
-	addl $4, %esp
+	addl $4, %esp			# skip orig_eax/error_code
 	CFI_ADJUST_CFA_OFFSET -4
 1:	INTERRUPT_RETURN
 .section .fixup,"ax"
@@ -512,14 +530,12 @@ syscall_badsys:
 	/* put ESP to the proper location */ \
 	movl %eax, %esp;
 #define UNWIND_ESPFIX_STACK \
-	pushl %eax; \
 	CFI_ADJUST_CFA_OFFSET 4; \
 	movl %ss, %eax; \
 	/* see if on 16bit stack */ \
-	cmpw $__ESPFIX_SS, %ax; \
+	cmp $__ESPFIX_SS, %eax; \
 	je 28f; \
-27:	popl %eax; \
-	CFI_ADJUST_CFA_OFFSET -4; \
+27:	CFI_ADJUST_CFA_OFFSET -4; \
 .section .fixup,"ax"; \
 28:	movl $__KERNEL_DS, %eax; \
 	movl %eax, %ds; \
@@ -588,13 +604,15 @@ KPROBE_ENTRY(page_fault)
 	CFI_ADJUST_CFA_OFFSET 4
 	ALIGN
 error_code:
+	/* the function address is in %gs's slot on the stack */
+	pushl %es
+	CFI_ADJUST_CFA_OFFSET 4
 	pushl %ds
 	CFI_ADJUST_CFA_OFFSET 4
 	/*CFI_REL_OFFSET ds, 0*/
 	pushl %eax
 	CFI_ADJUST_CFA_OFFSET 4
 	CFI_REL_OFFSET eax, 0
-	xorl %eax, %eax
 	pushl %ebp
 	CFI_ADJUST_CFA_OFFSET 4
 	CFI_REL_OFFSET ebp, 0
@@ -607,7 +625,6 @@ error_code:
 	pushl %edx
 	CFI_ADJUST_CFA_OFFSET 4
 	CFI_REL_OFFSET edx, 0
-	decl %eax			# eax = -1
 	pushl %ecx
 	CFI_ADJUST_CFA_OFFSET 4
 	CFI_REL_OFFSET ecx, 0
@@ -615,21 +632,17 @@ error_code:
 	CFI_ADJUST_CFA_OFFSET 4
 	CFI_REL_OFFSET ebx, 0
 	cld
-	pushl %es
-	CFI_ADJUST_CFA_OFFSET 4
-	/*CFI_REL_OFFSET es, 0*/
 	UNWIND_ESPFIX_STACK
-	popl %ecx
-	CFI_ADJUST_CFA_OFFSET -4
-	/*CFI_REGISTER es, ecx*/
-	movl PT_ES(%esp), %edi		# get the function address
+	movl PT_GS(%esp), %edi		# get the function address
 	movl PT_ORIG_EAX(%esp), %edx	# get the error code
-	movl %eax, PT_ORIG_EAX(%esp)
-	movl %ecx, PT_ES(%esp)
-	/*CFI_REL_OFFSET es, ES*/
+	movl $-1, PT_ORIG_EAX(%esp)	# no syscall to restart
+	mov  %gs, PT_GS(%esp)
+	/*CFI_REL_OFFSET gs, GS*/
 	movl $(__USER_DS), %ecx
 	movl %ecx, %ds
 	movl %ecx, %es
+	movl $(__KERNEL_PDA), %ecx
+	movl %ecx, %gs
 	movl %esp,%eax			# pt_regs pointer
 	call *%edi
 	jmp ret_from_exception
@@ -939,6 +952,7 @@ ENTRY(arch_unwind_init_running)
 	movl	%ebx, PT_EAX(%edx)
 	movl	$__USER_DS, PT_DS(%edx)
 	movl	$__USER_DS, PT_ES(%edx)
+	movl	$0, PT_GS(%edx)
 	movl	%ebx, PT_ORIG_EAX(%edx)
 	movl	%ecx, PT_EIP(%edx)
 	movl	12(%esp), %ecx
diff -r 1b8b053ad03f arch/i386/kernel/head.S
--- a/arch/i386/kernel/head.S	Mon Sep 25 23:31:01 2006 -0700
+++ b/arch/i386/kernel/head.S	Mon Sep 25 23:31:04 2006 -0700
@@ -302,6 +302,7 @@ 2:	movl %cr0,%eax
 	movl %eax,%cr0
 
 	call check_x87
+	call setup_pda
 	lgdt cpu_gdt_descr
 	lidt idt_descr
 	ljmp $(__KERNEL_CS),$1f
@@ -312,10 +313,13 @@ 1:	movl $(__KERNEL_DS),%eax	# reload all
 	movl %eax,%ds
 	movl %eax,%es
 
-	xorl %eax,%eax			# Clear FS/GS and LDT
+	xorl %eax,%eax			# Clear FS and LDT
 	movl %eax,%fs
-	movl %eax,%gs
 	lldt %ax
+
+	movl $(__KERNEL_PDA),%eax
+	mov  %eax,%gs
+	
 	cld			# gcc2 wants the direction flag cleared at all times
 	pushl %eax		# fake return address
 #ifdef CONFIG_SMP
@@ -345,6 +349,23 @@ 1:	movb $1,X86_HARD_MATH
 	.byte 0xDB,0xE4		/* fsetpm for 287, ignored by 387 */
 	ret
 
+/*
+ * Point the GDT at this CPU's PDA.  On boot this will be
+ * cpu_gdt_table and boot_pda; for secondary CPUs, these will be
+ * that CPU's GDT and PDA.
+ */
+setup_pda:
+	/* get the PDA pointer */
+	movl start_pda, %eax
+
+	/* slot the PDA address into the GDT */
+	mov cpu_gdt_descr+2, %ecx
+	mov %ax, (__KERNEL_PDA+0+2)(%ecx)		/* base & 0x0000ffff */
+	shr $16, %eax
+	mov %al, (__KERNEL_PDA+4+0)(%ecx)		/* base & 0x00ff0000 */
+	mov %ah, (__KERNEL_PDA+4+3)(%ecx)		/* base & 0xff000000 */
+	ret
+	
 /*
  *  setup_idt
  *
@@ -424,7 +445,9 @@ ENTRY(empty_zero_page)
  * This starts the data section.
  */
 .data
-
+ENTRY(start_pda)
+	.long boot_pda
+	
 ENTRY(stack_start)
 	.long init_thread_union+THREAD_SIZE
 	.long __BOOT_DS
@@ -458,7 +481,7 @@ idt_descr:
 
 # boot GDT descriptor (later on used by CPU#0):
 	.word 0				# 32 bit align gdt_desc.address
-cpu_gdt_descr:
+ENTRY(cpu_gdt_descr)
 	.word GDT_ENTRIES*8-1
 	.long cpu_gdt_table
 
@@ -518,7 +541,7 @@ ENTRY(cpu_gdt_table)
 	.quad 0x004092000000ffff	/* 0xc8 APM DS    data */
 
 	.quad 0x0000920000000000	/* 0xd0 - ESPFIX 16-bit SS */
-	.quad 0x0000000000000000	/* 0xd8 - PDA */
+	.quad 0x00cf92000000ffff	/* 0xd8 - PDA */
 	.quad 0x0000000000000000	/* 0xe0 - unused */
 	.quad 0x0000000000000000	/* 0xe8 - unused */
 	.quad 0x0000000000000000	/* 0xf0 - unused */
diff -r 1b8b053ad03f arch/i386/kernel/process.c
--- a/arch/i386/kernel/process.c	Mon Sep 25 23:31:01 2006 -0700
+++ b/arch/i386/kernel/process.c	Mon Sep 25 23:31:04 2006 -0700
@@ -56,6 +56,7 @@
 
 #include <asm/tlbflush.h>
 #include <asm/cpu.h>
+#include <asm/pda.h>
 
 asmlinkage void ret_from_fork(void) __asm__("ret_from_fork");
 
@@ -336,6 +337,7 @@ int kernel_thread(int (*fn)(void *), voi
 
 	regs.xds = __USER_DS;
 	regs.xes = __USER_DS;
+	regs.xgs = __KERNEL_PDA;
 	regs.orig_eax = -1;
 	regs.eip = (unsigned long) kernel_thread_helper;
 	regs.xcs = __KERNEL_CS | get_kernel_rpl();
@@ -421,7 +423,6 @@ int copy_thread(int nr, unsigned long cl
 	p->thread.eip = (unsigned long) ret_from_fork;
 
 	savesegment(fs,p->thread.fs);
-	savesegment(gs,p->thread.gs);
 
 	tsk = current;
 	if (unlikely(test_tsk_thread_flag(tsk, TIF_IO_BITMAP))) {
@@ -645,16 +646,16 @@ struct task_struct fastcall * __switch_t
 	load_esp0(tss, next);
 
 	/*
-	 * Save away %fs and %gs. No need to save %es and %ds, as
-	 * those are always kernel segments while inside the kernel.
-	 * Doing this before setting the new TLS descriptors avoids
-	 * the situation where we temporarily have non-reloadable
-	 * segments in %fs and %gs.  This could be an issue if the
-	 * NMI handler ever used %fs or %gs (it does not today), or
-	 * if the kernel is running inside of a hypervisor layer.
+	 * Save away %fs. No need to save %gs, as it was saved on the
+	 * stack on entry.  No need to save %es and %ds, as those are
+	 * always kernel segments while inside the kernel.  Doing this
+	 * before setting the new TLS descriptors avoids the situation
+	 * where we temporarily have non-reloadable segments in %fs
+	 * and %gs.  This could be an issue if the NMI handler ever
+	 * used %fs or %gs (it does not today), or if the kernel is
+	 * running inside of a hypervisor layer.
 	 */
 	savesegment(fs, prev->fs);
-	savesegment(gs, prev->gs);
 
 	/*
 	 * Load the per-thread Thread-Local Storage descriptor.
@@ -662,16 +663,14 @@ struct task_struct fastcall * __switch_t
 	load_TLS(next, cpu);
 
 	/*
-	 * Restore %fs and %gs if needed.
+	 * Restore %fs if needed.
 	 *
-	 * Glibc normally makes %fs be zero, and %gs is one of
-	 * the TLS segments.
+	 * Glibc normally makes %fs be zero.
 	 */
 	if (unlikely(prev->fs | next->fs))
 		loadsegment(fs, next->fs);
 
-	if (prev->gs | next->gs)
-		loadsegment(gs, next->gs);
+	write_pda(pcurrent, next_p);
 
 	/*
 	 * Restore IOPL if needed.
diff -r 1b8b053ad03f arch/i386/kernel/signal.c
--- a/arch/i386/kernel/signal.c	Mon Sep 25 23:31:01 2006 -0700
+++ b/arch/i386/kernel/signal.c	Mon Sep 25 23:31:04 2006 -0700
@@ -128,7 +128,7 @@ restore_sigcontext(struct pt_regs *regs,
 			 X86_EFLAGS_TF | X86_EFLAGS_SF | X86_EFLAGS_ZF | \
 			 X86_EFLAGS_AF | X86_EFLAGS_PF | X86_EFLAGS_CF)
 
-	GET_SEG(gs);
+	COPY_SEG(gs);
 	GET_SEG(fs);
 	COPY_SEG(es);
 	COPY_SEG(ds);
@@ -244,9 +244,7 @@ setup_sigcontext(struct sigcontext __use
 {
 	int tmp, err = 0;
 
-	tmp = 0;
-	savesegment(gs, tmp);
-	err |= __put_user(tmp, (unsigned int __user *)&sc->gs);
+	err |= __put_user(regs->xgs, (unsigned int __user *)&sc->gs);
 	savesegment(fs, tmp);
 	err |= __put_user(tmp, (unsigned int __user *)&sc->fs);
 
diff -r 1b8b053ad03f include/asm-i386/mmu_context.h
--- a/include/asm-i386/mmu_context.h	Mon Sep 25 23:31:01 2006 -0700
+++ b/include/asm-i386/mmu_context.h	Mon Sep 25 23:31:04 2006 -0700
@@ -62,8 +62,8 @@ static inline void switch_mm(struct mm_s
 #endif
 }
 
-#define deactivate_mm(tsk, mm) \
-	asm("movl %0,%%fs ; movl %0,%%gs": :"r" (0))
+#define deactivate_mm(tsk, mm)			\
+	asm("movl %0,%%fs": :"r" (0));
 
 #define activate_mm(prev, next) \
 	switch_mm((prev),(next),NULL)
diff -r 1b8b053ad03f include/asm-i386/processor.h
--- a/include/asm-i386/processor.h	Mon Sep 25 23:31:01 2006 -0700
+++ b/include/asm-i386/processor.h	Mon Sep 25 23:31:04 2006 -0700
@@ -477,6 +477,7 @@ struct thread_struct {
 	.vm86_info = NULL,						\
 	.sysenter_cs = __KERNEL_CS,					\
 	.io_bitmap_ptr = NULL,						\
+	.gs = __KERNEL_PDA,						\
 }
 
 /*
@@ -504,7 +505,8 @@ static inline void load_esp0(struct tss_
 }
 
 #define start_thread(regs, new_eip, new_esp) do {		\
-	__asm__("movl %0,%%fs ; movl %0,%%gs": :"r" (0));	\
+	__asm__("movl %0,%%fs": :"r" (0));			\
+	regs->xgs = 0;						\
 	set_fs(USER_DS);					\
 	regs->xds = __USER_DS;					\
 	regs->xes = __USER_DS;					\
diff -r 1b8b053ad03f include/asm-i386/ptrace.h
--- a/include/asm-i386/ptrace.h	Mon Sep 25 23:31:01 2006 -0700
+++ b/include/asm-i386/ptrace.h	Mon Sep 25 23:31:04 2006 -0700
@@ -33,6 +33,8 @@ struct pt_regs {
 	long eax;
 	int  xds;
 	int  xes;
+	/* int  xfs; */
+	int  xgs;
 	long orig_eax;
 	long eip;
 	int  xcs;
diff -r 1b8b053ad03f kernel/fork.c
--- a/kernel/fork.c	Mon Sep 25 23:31:01 2006 -0700
+++ b/kernel/fork.c	Mon Sep 25 23:31:04 2006 -0700
@@ -1299,7 +1299,7 @@ fork_out:
 	return ERR_PTR(retval);
 }
 
-struct pt_regs * __devinit __attribute__((weak)) idle_regs(struct pt_regs *regs)
+noinline struct pt_regs * __devinit __attribute__((weak)) idle_regs(struct pt_regs *regs)
 {
 	memset(regs, 0, sizeof(struct pt_regs));
 	return regs;

--------------030400020009010601020700
Content-Type: text/x-patch;
 name="i386-pda-fix-abi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i386-pda-fix-abi.patch"

Fix places where using %gs changes the usermode ABI.

There are a few places where the change in struct pt_regs and the use
of %gs affect the userspace ABI.  These are primarily debugging
interfaces where thread state can be inspected or extracted.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Zachary Amsden <zach@vmware.com>
Cc: Jan Beulich <jbeulich@novell.com>
Cc: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/process.c |    6 +++---
 arch/i386/kernel/ptrace.c  |   18 ++++++------------
 include/asm-i386/elf.h     |    2 +-
 include/asm-i386/unwind.h  |    1 +
 4 files changed, 11 insertions(+), 16 deletions(-)

===================================================================
--- a/arch/i386/kernel/process.c
+++ b/arch/i386/kernel/process.c
@@ -309,8 +309,8 @@ void show_regs(struct pt_regs * regs)
 		regs->eax,regs->ebx,regs->ecx,regs->edx);
 	printk("ESI: %08lx EDI: %08lx EBP: %08lx",
 		regs->esi, regs->edi, regs->ebp);
-	printk(" DS: %04x ES: %04x\n",
-		0xffff & regs->xds,0xffff & regs->xes);
+	printk(" DS: %04x ES: %04x GS: %04x\n",
+	       0xffff & regs->xds,0xffff & regs->xes, 0xffff & regs->xgs);
 
 	cr0 = read_cr0();
 	cr2 = read_cr2();
@@ -504,7 +504,7 @@ void dump_thread(struct pt_regs * regs, 
 	dump->regs.ds = regs->xds;
 	dump->regs.es = regs->xes;
 	savesegment(fs,dump->regs.fs);
-	savesegment(gs,dump->regs.gs);
+	dump->regs.gs = regs->xgs;
 	dump->regs.orig_eax = regs->orig_eax;
 	dump->regs.eip = regs->eip;
 	dump->regs.cs = regs->xcs;
===================================================================
--- a/arch/i386/kernel/ptrace.c
+++ b/arch/i386/kernel/ptrace.c
@@ -94,13 +94,9 @@ static int putreg(struct task_struct *ch
 				return -EIO;
 			child->thread.fs = value;
 			return 0;
-		case GS:
-			if (value && (value & 3) != 3)
-				return -EIO;
-			child->thread.gs = value;
-			return 0;
 		case DS:
 		case ES:
+		case GS:
 			if (value && (value & 3) != 3)
 				return -EIO;
 			value &= 0xffff;
@@ -116,8 +112,8 @@ static int putreg(struct task_struct *ch
 			value |= get_stack_long(child, EFL_OFFSET) & ~FLAG_MASK;
 			break;
 	}
-	if (regno > GS*4)
-		regno -= 2*4;
+	if (regno > ES*4)
+		regno -= 1*4;
 	put_stack_long(child, regno - sizeof(struct pt_regs), value);
 	return 0;
 }
@@ -131,18 +127,16 @@ static unsigned long getreg(struct task_
 		case FS:
 			retval = child->thread.fs;
 			break;
-		case GS:
-			retval = child->thread.gs;
-			break;
 		case DS:
 		case ES:
+		case GS:
 		case SS:
 		case CS:
 			retval = 0xffff;
 			/* fall through */
 		default:
-			if (regno > GS*4)
-				regno -= 2*4;
+			if (regno > ES*4)
+				regno -= 1*4;
 			regno = regno - sizeof(struct pt_regs);
 			retval &= get_stack_long(child, regno);
 	}
===================================================================
--- a/include/asm-i386/elf.h
+++ b/include/asm-i386/elf.h
@@ -88,7 +88,7 @@ typedef struct user_fxsr_struct elf_fpxr
 	pr_reg[7] = regs->xds;				\
 	pr_reg[8] = regs->xes;				\
 	savesegment(fs,pr_reg[9]);			\
-	savesegment(gs,pr_reg[10]);			\
+	pr_reg[10] = regs->xgs;				\
 	pr_reg[11] = regs->orig_eax;			\
 	pr_reg[12] = regs->eip;				\
 	pr_reg[13] = regs->xcs;				\
===================================================================
--- a/include/asm-i386/unwind.h
+++ b/include/asm-i386/unwind.h
@@ -64,6 +64,7 @@ static inline void arch_unw_init_blocked
 	info->regs.xss = __KERNEL_DS;
 	info->regs.xds = __USER_DS;
 	info->regs.xes = __USER_DS;
+	info->regs.xgs = __KERNEL_PDA;
 }
 
 extern asmlinkage int arch_unwind_init_running(struct unwind_frame_info *,

--------------030400020009010601020700
Content-Type: text/x-patch;
 name="i386-pda-fix-vm86.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i386-pda-fix-vm86.patch"

Update sys_vm86 to cope with changed pt_regs and %gs usage.

sys_vm86 uses a struct kernel_vm86_regs, which is identical to
pt_regs, but adds an extra space for all the segment registers.
Previously this structure was completely independent, so changes in
pt_regs had to be reflected in kernel_vm86_regs.  This changes just
embeds pt_regs in kernel_vm86_regs, and makes the appropriate changes
to vm86.c to deal with the new naming.

Also, since %gs is dealt with differently in the kernel, this change
adjusts vm86.c to reflect this.

While making these changes, I also cleaned up some frankly bizarre
code which was added when auditing was added to sys_vm86.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Zachary Amsden <zach@vmware.com>
Cc: Jan Beulich <jbeulich@novell.com>
Cc: Andi Kleen <ak@suse.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jason Baron <jbaron@redhat.com>
Cc: Chris Wright <chrisw@sous-sol.org>

---
 arch/i386/kernel/vm86.c |  125 ++++++++++++++++++++++++++++-------------------
 include/asm-i386/vm86.h |   17 ------
 2 files changed, 78 insertions(+), 64 deletions(-)

diff -r 448ac068c03f arch/i386/kernel/vm86.c
--- a/arch/i386/kernel/vm86.c	Sun Sep 24 19:26:47 2006 -0700
+++ b/arch/i386/kernel/vm86.c	Sun Sep 24 19:26:50 2006 -0700
@@ -43,6 +43,7 @@
 #include <linux/highmem.h>
 #include <linux/ptrace.h>
 #include <linux/audit.h>
+#include <linux/stddef.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -72,10 +73,10 @@
 /*
  * 8- and 16-bit register defines..
  */
-#define AL(regs)	(((unsigned char *)&((regs)->eax))[0])
-#define AH(regs)	(((unsigned char *)&((regs)->eax))[1])
-#define IP(regs)	(*(unsigned short *)&((regs)->eip))
-#define SP(regs)	(*(unsigned short *)&((regs)->esp))
+#define AL(regs)	(((unsigned char *)&((regs)->pt.eax))[0])
+#define AH(regs)	(((unsigned char *)&((regs)->pt.eax))[1])
+#define IP(regs)	(*(unsigned short *)&((regs)->pt.eip))
+#define SP(regs)	(*(unsigned short *)&((regs)->pt.esp))
 
 /*
  * virtual flags (16 and 32-bit versions)
@@ -89,10 +90,37 @@
 #define SAFE_MASK	(0xDD5)
 #define RETURN_MASK	(0xDFF)
 
-#define VM86_REGS_PART2 orig_eax
-#define VM86_REGS_SIZE1 \
-        ( (unsigned)( & (((struct kernel_vm86_regs *)0)->VM86_REGS_PART2) ) )
-#define VM86_REGS_SIZE2 (sizeof(struct kernel_vm86_regs) - VM86_REGS_SIZE1)
+/* convert kernel_vm86_regs to vm86_regs */
+static int copy_vm86_regs_to_user(struct vm86_regs __user *user,
+				  const struct kernel_vm86_regs *regs)
+{
+	int ret = 0;
+
+	/* kernel_vm86_regs is missing xfs, so copy everything up to
+	   (but not including) xgs, and then rest after xgs. */
+	ret += copy_to_user(user, regs, offsetof(struct kernel_vm86_regs, pt.xgs));
+	ret += copy_to_user(&user->__null_gs, &regs->pt.xgs,
+			    sizeof(struct kernel_vm86_regs) -
+			    offsetof(struct kernel_vm86_regs, pt.xgs));
+
+	return ret;
+}
+
+/* convert vm86_regs to kernel_vm86_regs */
+static int copy_vm86_regs_from_user(struct kernel_vm86_regs *regs,
+				    const struct vm86_regs __user *user,
+				    unsigned extra)
+{
+	int ret = 0;
+
+	ret += copy_from_user(regs, user, offsetof(struct kernel_vm86_regs, pt.xgs));
+	ret += copy_from_user(&regs->pt.xgs, &user->__null_gs,
+			      sizeof(struct kernel_vm86_regs) -
+			      offsetof(struct kernel_vm86_regs, pt.xgs) +
+			      extra);
+
+	return ret;
+}
 
 struct pt_regs * FASTCALL(save_v86_state(struct kernel_vm86_regs * regs));
 struct pt_regs * fastcall save_v86_state(struct kernel_vm86_regs * regs)
@@ -112,10 +140,8 @@ struct pt_regs * fastcall save_v86_state
 		printk("no vm86_info: BAD\n");
 		do_exit(SIGSEGV);
 	}
-	set_flags(regs->eflags, VEFLAGS, VIF_MASK | current->thread.v86mask);
-	tmp = copy_to_user(&current->thread.vm86_info->regs,regs, VM86_REGS_SIZE1);
-	tmp += copy_to_user(&current->thread.vm86_info->regs.VM86_REGS_PART2,
-		&regs->VM86_REGS_PART2, VM86_REGS_SIZE2);
+	set_flags(regs->pt.eflags, VEFLAGS, VIF_MASK | current->thread.v86mask);
+	tmp = copy_vm86_regs_to_user(&current->thread.vm86_info->regs,regs);
 	tmp += put_user(current->thread.screen_bitmap,&current->thread.vm86_info->screen_bitmap);
 	if (tmp) {
 		printk("vm86: could not access userspace vm86_info\n");
@@ -129,9 +155,11 @@ struct pt_regs * fastcall save_v86_state
 	current->thread.saved_esp0 = 0;
 	put_cpu();
 
+	ret = KVM86->regs32;
+
 	loadsegment(fs, current->thread.saved_fs);
-	loadsegment(gs, current->thread.saved_gs);
-	ret = KVM86->regs32;
+	ret->xgs = current->thread.saved_gs;
+
 	return ret;
 }
 
@@ -183,9 +211,9 @@ asmlinkage int sys_vm86old(struct pt_reg
 	tsk = current;
 	if (tsk->thread.saved_esp0)
 		goto out;
-	tmp  = copy_from_user(&info, v86, VM86_REGS_SIZE1);
-	tmp += copy_from_user(&info.regs.VM86_REGS_PART2, &v86->regs.VM86_REGS_PART2,
-		(long)&info.vm86plus - (long)&info.regs.VM86_REGS_PART2);
+	tmp = copy_vm86_regs_from_user(&info.regs, &v86->regs,
+				       offsetof(struct kernel_vm86_struct, vm86plus) -
+				       sizeof(info.regs));
 	ret = -EFAULT;
 	if (tmp)
 		goto out;
@@ -233,9 +261,9 @@ asmlinkage int sys_vm86(struct pt_regs r
 	if (tsk->thread.saved_esp0)
 		goto out;
 	v86 = (struct vm86plus_struct __user *)regs.ecx;
-	tmp  = copy_from_user(&info, v86, VM86_REGS_SIZE1);
-	tmp += copy_from_user(&info.regs.VM86_REGS_PART2, &v86->regs.VM86_REGS_PART2,
-		(long)&info.regs32 - (long)&info.regs.VM86_REGS_PART2);
+	tmp = copy_vm86_regs_from_user(&info.regs, &v86->regs,
+				       offsetof(struct kernel_vm86_struct, regs32) -
+				       sizeof(info.regs));
 	ret = -EFAULT;
 	if (tmp)
 		goto out;
@@ -252,15 +280,15 @@ static void do_sys_vm86(struct kernel_vm
 static void do_sys_vm86(struct kernel_vm86_struct *info, struct task_struct *tsk)
 {
 	struct tss_struct *tss;
-	long eax;
 /*
  * make sure the vm86() system call doesn't try to do anything silly
  */
-	info->regs.__null_ds = 0;
-	info->regs.__null_es = 0;
-
-/* we are clearing fs,gs later just before "jmp resume_userspace",
- * because starting with Linux 2.1.x they aren't no longer saved/restored
+	info->regs.pt.xds = 0;
+	info->regs.pt.xes = 0;
+	info->regs.pt.xgs = 0;
+
+/* we are clearing fs later just before "jmp resume_userspace",
+ * because it is not saved/restored.
  */
 
 /*
@@ -268,10 +296,10 @@ static void do_sys_vm86(struct kernel_vm
  * has set it up safely, so this makes sure interrupt etc flags are
  * inherited from protected mode.
  */
- 	VEFLAGS = info->regs.eflags;
-	info->regs.eflags &= SAFE_MASK;
-	info->regs.eflags |= info->regs32->eflags & ~SAFE_MASK;
-	info->regs.eflags |= VM_MASK;
+ 	VEFLAGS = info->regs.pt.eflags;
+	info->regs.pt.eflags &= SAFE_MASK;
+	info->regs.pt.eflags |= info->regs32->eflags & ~SAFE_MASK;
+	info->regs.pt.eflags |= VM_MASK;
 
 	switch (info->cpu_type) {
 		case CPU_286:
@@ -294,7 +322,7 @@ static void do_sys_vm86(struct kernel_vm
 	info->regs32->eax = 0;
 	tsk->thread.saved_esp0 = tsk->thread.esp0;
 	savesegment(fs, tsk->thread.saved_fs);
-	savesegment(gs, tsk->thread.saved_gs);
+	tsk->thread.saved_gs = info->regs32->xgs;
 
 	tss = &per_cpu(init_tss, get_cpu());
 	tsk->thread.esp0 = (unsigned long) &info->VM86_TSS_ESP0;
@@ -306,19 +334,18 @@ static void do_sys_vm86(struct kernel_vm
 	tsk->thread.screen_bitmap = info->screen_bitmap;
 	if (info->flags & VM86_SCREEN_BITMAP)
 		mark_screen_rdonly(tsk->mm);
-	__asm__ __volatile__("xorl %eax,%eax; movl %eax,%fs; movl %eax,%gs\n\t");
-	__asm__ __volatile__("movl %%eax, %0\n" :"=r"(eax));
 
 	/*call audit_syscall_exit since we do not exit via the normal paths */
 	if (unlikely(current->audit_context))
-		audit_syscall_exit(AUDITSC_RESULT(eax), eax);
+		audit_syscall_exit(AUDITSC_RESULT(0), 0);
 
 	__asm__ __volatile__(
 		"movl %0,%%esp\n\t"
 		"movl %1,%%ebp\n\t"
+		"mov  %2, %%fs\n\t"
 		"jmp resume_userspace"
 		: /* no outputs */
-		:"r" (&info->regs), "r" (task_thread_info(tsk)));
+		:"r" (&info->regs), "r" (task_thread_info(tsk)), "r" (0));
 	/* we never return here */
 }
 
@@ -348,12 +375,12 @@ static inline void clear_IF(struct kerne
 
 static inline void clear_TF(struct kernel_vm86_regs * regs)
 {
-	regs->eflags &= ~TF_MASK;
+	regs->pt.eflags &= ~TF_MASK;
 }
 
 static inline void clear_AC(struct kernel_vm86_regs * regs)
 {
-	regs->eflags &= ~AC_MASK;
+	regs->pt.eflags &= ~AC_MASK;
 }
 
 /* It is correct to call set_IF(regs) from the set_vflags_*
@@ -370,7 +397,7 @@ static inline void set_vflags_long(unsig
 static inline void set_vflags_long(unsigned long eflags, struct kernel_vm86_regs * regs)
 {
 	set_flags(VEFLAGS, eflags, current->thread.v86mask);
-	set_flags(regs->eflags, eflags, SAFE_MASK);
+	set_flags(regs->pt.eflags, eflags, SAFE_MASK);
 	if (eflags & IF_MASK)
 		set_IF(regs);
 	else
@@ -380,7 +407,7 @@ static inline void set_vflags_short(unsi
 static inline void set_vflags_short(unsigned short flags, struct kernel_vm86_regs * regs)
 {
 	set_flags(VFLAGS, flags, current->thread.v86mask);
-	set_flags(regs->eflags, flags, SAFE_MASK);
+	set_flags(regs->pt.eflags, flags, SAFE_MASK);
 	if (flags & IF_MASK)
 		set_IF(regs);
 	else
@@ -389,7 +416,7 @@ static inline void set_vflags_short(unsi
 
 static inline unsigned long get_vflags(struct kernel_vm86_regs * regs)
 {
-	unsigned long flags = regs->eflags & RETURN_MASK;
+	unsigned long flags = regs->pt.eflags & RETURN_MASK;
 
 	if (VEFLAGS & VIF_MASK)
 		flags |= IF_MASK;
@@ -493,7 +520,7 @@ static void do_int(struct kernel_vm86_re
 	unsigned long __user *intr_ptr;
 	unsigned long segoffs;
 
-	if (regs->cs == BIOSSEG)
+	if (regs->pt.xcs == BIOSSEG)
 		goto cannot_handle;
 	if (is_revectored(i, &KVM86->int_revectored))
 		goto cannot_handle;
@@ -505,9 +532,9 @@ static void do_int(struct kernel_vm86_re
 	if ((segoffs >> 16) == BIOSSEG)
 		goto cannot_handle;
 	pushw(ssp, sp, get_vflags(regs), cannot_handle);
-	pushw(ssp, sp, regs->cs, cannot_handle);
+	pushw(ssp, sp, regs->pt.xcs, cannot_handle);
 	pushw(ssp, sp, IP(regs), cannot_handle);
-	regs->cs = segoffs >> 16;
+	regs->pt.xcs = segoffs >> 16;
 	SP(regs) -= 6;
 	IP(regs) = segoffs & 0xffff;
 	clear_TF(regs);
@@ -524,7 +551,7 @@ int handle_vm86_trap(struct kernel_vm86_
 	if (VMPI.is_vm86pus) {
 		if ( (trapno==3) || (trapno==1) )
 			return_to_32bit(regs, VM86_TRAP + (trapno << 8));
-		do_int(regs, trapno, (unsigned char __user *) (regs->ss << 4), SP(regs));
+		do_int(regs, trapno, (unsigned char __user *) (regs->pt.xss << 4), SP(regs));
 		return 0;
 	}
 	if (trapno !=1)
@@ -560,10 +587,10 @@ void handle_vm86_fault(struct kernel_vm8
 		handle_vm86_trap(regs, 0, 1); \
 	return; } while (0)
 
-	orig_flags = *(unsigned short *)&regs->eflags;
-
-	csp = (unsigned char __user *) (regs->cs << 4);
-	ssp = (unsigned char __user *) (regs->ss << 4);
+	orig_flags = *(unsigned short *)&regs->pt.eflags;
+
+	csp = (unsigned char __user *) (regs->pt.xcs << 4);
+	ssp = (unsigned char __user *) (regs->pt.xss << 4);
 	sp = SP(regs);
 	ip = IP(regs);
 
@@ -650,7 +677,7 @@ void handle_vm86_fault(struct kernel_vm8
 			SP(regs) += 6;
 		}
 		IP(regs) = newip;
-		regs->cs = newcs;
+		regs->pt.xcs = newcs;
 		CHECK_IF_IN_TRAP;
 		if (data32) {
 			set_vflags_long(newflags, regs);
diff -r 448ac068c03f include/asm-i386/vm86.h
--- a/include/asm-i386/vm86.h	Sun Sep 24 19:26:47 2006 -0700
+++ b/include/asm-i386/vm86.h	Sun Sep 24 22:33:53 2006 -0700
@@ -145,26 +145,13 @@ struct vm86plus_struct {
  * at the end of the structure. Look at ptrace.h to see the "normal"
  * setup. For user space layout see 'struct vm86_regs' above.
  */
+#include <asm/ptrace.h>
 
 struct kernel_vm86_regs {
 /*
  * normal regs, with special meaning for the segment descriptors..
  */
-	long ebx;
-	long ecx;
-	long edx;
-	long esi;
-	long edi;
-	long ebp;
-	long eax;
-	long __null_ds;
-	long __null_es;
-	long orig_eax;
-	long eip;
-	unsigned short cs, __csh;
-	long eflags;
-	long esp;
-	unsigned short ss, __ssh;
+	struct pt_regs pt;
 /*
  * these are specific to v86 mode:
  */

--------------030400020009010601020700
Content-Type: text/x-patch;
 name="i386-pda-smp_processor_id.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i386-pda-smp_processor_id.patch"

Implement smp_processor_id() with the PDA.

Use the cpu_number in the PDA to implement raw_smp_processor_id.  This
is a little simpler than using thread_info, though the cpu field in
thread_info cannot be removed since it is used for things other than
getting the current CPU in common code.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Zachary Amsden <zach@vmware.com>
Cc: Jan Beulich <jbeulich@novell.com>
Cc: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/asm-offsets.c |    2 +-
 include/asm-i386/smp.h         |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff -r 412e9eb1cd8b arch/i386/kernel/asm-offsets.c
--- a/arch/i386/kernel/asm-offsets.c	Mon Sep 25 15:23:51 2006 -0700
+++ b/arch/i386/kernel/asm-offsets.c	Mon Sep 25 15:23:53 2006 -0700
@@ -52,7 +52,6 @@ void foo(void)
 	OFFSET(TI_exec_domain, thread_info, exec_domain);
 	OFFSET(TI_flags, thread_info, flags);
 	OFFSET(TI_status, thread_info, status);
-	OFFSET(TI_cpu, thread_info, cpu);
 	OFFSET(TI_preempt_count, thread_info, preempt_count);
 	OFFSET(TI_addr_limit, thread_info, addr_limit);
 	OFFSET(TI_restart_block, thread_info, restart_block);
@@ -96,4 +95,5 @@ void foo(void)
 
 	BLANK();
 	OFFSET(PDA_pcurrent, i386_pda, pcurrent);
+	OFFSET(PDA_cpu, i386_pda, cpu_number);
 }
diff -r 412e9eb1cd8b include/asm-i386/smp.h
--- a/include/asm-i386/smp.h	Mon Sep 25 15:23:51 2006 -0700
+++ b/include/asm-i386/smp.h	Mon Sep 25 15:23:53 2006 -0700
@@ -8,6 +8,7 @@
 #include <linux/kernel.h>
 #include <linux/threads.h>
 #include <linux/cpumask.h>
+#include <asm/pda.h>
 #endif
 
 #ifdef CONFIG_X86_LOCAL_APIC
@@ -56,7 +57,7 @@ extern void cpu_uninit(void);
  * from the initial startup. We map APIC_BASE very early in page_setup(),
  * so this is correct in the x86 case.
  */
-#define raw_smp_processor_id() (current_thread_info()->cpu)
+#define raw_smp_processor_id() (read_pda(cpu_number))
 
 extern cpumask_t cpu_callout_map;
 extern cpumask_t cpu_callin_map;

--------------030400020009010601020700
Content-Type: text/x-patch;
 name="i386-pda-current.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i386-pda-current.patch"

Implement "current" with the PDA.

Use the pcurrent field in the PDA to implement the "current" macro.
This ends up compiling down to a single instruction to get the current
task.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Zachary Amsden <zach@vmware.com>
Cc: Jan Beulich <jbeulich@novell.com>
Cc: Andi Kleen <ak@suse.de>

---
 include/asm-i386/current.h |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff -r 5eb01c4f49fe include/asm-i386/current.h
--- a/include/asm-i386/current.h	Mon Sep 25 23:05:11 2006 -0700
+++ b/include/asm-i386/current.h	Mon Sep 25 23:05:12 2006 -0700
@@ -1,13 +1,14 @@
 #ifndef _I386_CURRENT_H
 #define _I386_CURRENT_H
 
-#include <linux/thread_info.h>
+#include <asm/pda.h>
+#include <linux/compiler.h>
 
 struct task_struct;
 
-static __always_inline struct task_struct * get_current(void)
+static __always_inline struct task_struct *get_current(void)
 {
-	return current_thread_info()->task;
+	return read_pda(pcurrent);
 }
  
 #define current get_current()

--------------030400020009010601020700--
