Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751365AbWH0JZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbWH0JZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 05:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbWH0JZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 05:25:52 -0400
Received: from 32.sub-70-198-1.myvzw.com ([70.198.1.32]:53442 "EHLO
	mail.goop.org") by vger.kernel.org with ESMTP id S1751365AbWH0JZg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 05:25:36 -0400
Message-Id: <20060827084450.991618709@goop.org>
References: <20060827084417.918992193@goop.org>
User-Agent: quilt/0.45-1
Date: Sun, 27 Aug 2006 01:44:19 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: linux-kernel@vger.kernel.org
Cc: Chuck Ebbert <76306.1226@compuserve.com>, Zachary Amsden <zach@vmware.com>,
       Jan Beulich <jbeulich@novell.com>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH RFC 2/6] Initialize the per-CPU data area.
Content-Disposition: inline; filename=i386-pda-init.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When a CPU is brought up, a PDA and GDT are allocated for it.  The
GDT's __KERNEL_PDA entry is pointed to the allocated PDA memory, so
that all references using this segment selector will refer to the PDA.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Zachary Amsden <zach@vmware.com>
Cc: Jan Beulich <jbeulich@novell.com>
Cc: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/cpu/common.c |   49 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)


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
@@ -582,6 +586,26 @@ void __init early_cpu_init(void)
 	disable_pse = 1;
 #endif
 }
+
+static __cpuinit void pda_init(int cpu)
+{
+	struct i386_pda *pda = cpu_pda(cpu);
+
+	memset(pda, 0, sizeof(*pda));
+
+	pda->cpu_number = cpu;
+	pda->pcurrent = current;
+
+	printk("cpu %d current %p\n", cpu, current);
+}
+
+struct pt_regs * __devinit idle_regs(struct pt_regs *regs)
+{
+	memset(regs, 0, sizeof(struct pt_regs));
+	regs->xgs = __KERNEL_PDA;
+	return regs;
+}
+
 /*
  * cpu_init() initializes state that is per-CPU. Some data is already
  * initialized (naturally) in the bootstrap process, such as the GDT
@@ -594,6 +618,7 @@ void __cpuinit cpu_init(void)
 	struct tss_struct * t = &per_cpu(init_tss, cpu);
 	struct thread_struct *thread = &current->thread;
 	struct desc_struct *gdt;
+	struct i386_pda *pda;
 	__u32 stk16_off = (__u32)&per_cpu(cpu_16bit_stack, cpu);
 	struct Xgt_desc_struct *cpu_gdt_descr = &per_cpu(cpu_gdt_descr, cpu);
 
@@ -615,6 +640,10 @@ void __cpuinit cpu_init(void)
 	/* The CPU hotplug case */
 	if (cpu_gdt_descr->address) {
 		gdt = (struct desc_struct *)cpu_gdt_descr->address;
+		pda = cpu_pda(cpu);
+
+		BUG_ON(pda == NULL);
+
 		memset(gdt, 0, PAGE_SIZE);
 		goto old_gdt;
 	}
@@ -625,13 +654,17 @@ void __cpuinit cpu_init(void)
 	 * CPUs, when bootmem will have gone away
 	 */
 	if (NODE_DATA(0)->bdata->node_bootmem_map) {
-		gdt = (struct desc_struct *)alloc_bootmem_pages(PAGE_SIZE);
+		gdt = alloc_bootmem_pages(PAGE_SIZE);
+		pda = alloc_bootmem(sizeof(*pda));
+
 		/* alloc_bootmem_pages panics on failure, so no check */
 		memset(gdt, 0, PAGE_SIZE);
 	} else {
 		gdt = (struct desc_struct *)get_zeroed_page(GFP_KERNEL);
-		if (unlikely(!gdt)) {
-			printk(KERN_CRIT "CPU%d failed to allocate GDT\n", cpu);
+		pda = kmalloc_node(sizeof(*pda), GFP_KERNEL, cpu_to_node(cpu));
+
+		if (unlikely(!gdt || !pda)) {
+			printk(KERN_CRIT "CPU%d failed to allocate GDT or PDA\n", cpu);
 			for (;;)
 				local_irq_enable();
 		}
@@ -651,6 +684,16 @@ old_gdt:
 
 	cpu_gdt_descr->size = GDT_SIZE - 1;
  	cpu_gdt_descr->address = (unsigned long)gdt;
+
+	/* Set up the PDA in this CPU's GDT */
+	cpu_pda(cpu) = pda;
+
+	pda_init(cpu);
+
+	pack_descriptor((u32 *)&gdt[GDT_ENTRY_PDA].a,
+			(u32 *)&gdt[GDT_ENTRY_PDA].b,
+			(unsigned long)pda, sizeof(*pda) - 1,
+			0x80 | DESCTYPE_S | 0x2, 0); /* present read-write data segment */
 
 	load_gdt(cpu_gdt_descr);
 	load_idt(&idt_descr);

--

