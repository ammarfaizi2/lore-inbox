Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751366AbWH0JZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbWH0JZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 05:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWH0JZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 05:25:54 -0400
Received: from 32.sub-70-198-1.myvzw.com ([70.198.1.32]:54978 "EHLO
	mail.goop.org") by vger.kernel.org with ESMTP id S1751366AbWH0JZj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 05:25:39 -0400
Message-Id: <20060827084453.452516832@goop.org>
References: <20060827084417.918992193@goop.org>
User-Agent: quilt/0.45-1
Date: Sun, 27 Aug 2006 01:44:23 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: linux-kernel@vger.kernel.org
Cc: Chuck Ebbert <76306.1226@compuserve.com>, Zachary Amsden <zach@vmware.com>,
       Jan Beulich <jbeulich@novell.com>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH RFC 6/6] Implement "current" with the PDA.
Content-Disposition: inline; filename=i386-pda-current.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the pcurrent field in the PDA to implement the "current" macro.
This ends up compiling down to a single instruction to get the current
task.

The slightly tricky part about this patch is that cpu_init() uses
current very early, before the PDA has been set up.  In this instance,
it uses current_thread_info()->task to get the current task.

Also, the very early PDA set up for the boot cpu contains the initial
task pointer so current works from a very early stage.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Zachary Amsden <zach@vmware.com>
Cc: Jan Beulich <jbeulich@novell.com>
Cc: Andi Kleen <ak@suse.de>

--
 arch/i386/kernel/cpu/common.c |   27 ++++++++++++++++-----------
 include/asm-i386/current.h    |   11 ++---------
 2 files changed, 18 insertions(+), 20 deletions(-)


===================================================================
--- a/include/asm-i386/current.h
+++ b/include/asm-i386/current.h
@@ -1,15 +1,8 @@
 #ifndef _I386_CURRENT_H
 #define _I386_CURRENT_H
 
-#include <linux/thread_info.h>
+#include <asm/pda.h>
 
-struct task_struct;
-
-static __always_inline struct task_struct * get_current(void)
-{
-	return current_thread_info()->task;
-}
- 
-#define current get_current()
+#define current (read_pda(pcurrent))
 
 #endif /* !(_I386_CURRENT_H) */
===================================================================
--- a/arch/i386/kernel/cpu/common.c
+++ b/arch/i386/kernel/cpu/common.c
@@ -587,16 +587,16 @@ void __init early_cpu_init(void)
 #endif
 }
 
-static __cpuinit void pda_init(int cpu)
+static __cpuinit void pda_init(int cpu, struct task_struct *curr)
 {
 	struct i386_pda *pda = cpu_pda(cpu);
 
 	memset(pda, 0, sizeof(*pda));
 
 	pda->cpu_number = cpu;
-	pda->pcurrent = current;
-
-	printk("cpu %d current %p\n", cpu, current);
+	pda->pcurrent = curr;
+
+	printk("cpu %d current %p\n", cpu, curr);
 }
 
 struct pt_regs * __devinit idle_regs(struct pt_regs *regs)
@@ -609,7 +609,7 @@ struct pt_regs * __devinit idle_regs(str
 /* Set up a very early PDA for the boot CPU so that smp_processor_id will work */
 void __init smp_setup_processor_id(void)
 {
-	static const __initdata struct i386_pda boot_pda;
+	static __initdata struct i386_pda boot_pda;
 
 	pack_descriptor((u32 *)&cpu_gdt_table[GDT_ENTRY_PDA].a,
 			(u32 *)&cpu_gdt_table[GDT_ENTRY_PDA].b,
@@ -618,6 +618,8 @@ void __init smp_setup_processor_id(void)
 
 	/* Set %gs for this CPU's PDA */
 	asm volatile ("mov %0, %%gs" : : "r" (__KERNEL_PDA));
+
+	boot_pda.pcurrent = current_thread_info()->task;
 }
 
 /*
@@ -628,9 +630,12 @@ void __init smp_setup_processor_id(void)
  */
 void __cpuinit cpu_init(void)
 {
-	int cpu = current_thread_info()->cpu; /* need to use this until the PDA is set up */
+	/* Need to use thread_info for cpu and current until the PDA is set up */
+	int cpu = current_thread_info()->cpu;
+	struct task_struct *curr = current_thread_info()->task;
+
 	struct tss_struct * t = &per_cpu(init_tss, cpu);
-	struct thread_struct *thread = &current->thread;
+	struct thread_struct *thread = &curr->thread;
 	struct desc_struct *gdt;
 	struct i386_pda *pda;
 	__u32 stk16_off = (__u32)&per_cpu(cpu_16bit_stack, cpu);
@@ -702,7 +707,7 @@ old_gdt:
 	/* Set up the PDA in this CPU's GDT */
 	cpu_pda(cpu) = pda;
 
-	pda_init(cpu);
+	pda_init(cpu, curr);
 
 	pack_descriptor((u32 *)&gdt[GDT_ENTRY_PDA].a,
 			(u32 *)&gdt[GDT_ENTRY_PDA].b,
@@ -716,10 +721,10 @@ old_gdt:
 	 * Set up and load the per-CPU TSS and LDT
 	 */
 	atomic_inc(&init_mm.mm_count);
-	current->active_mm = &init_mm;
-	if (current->mm)
+	curr->active_mm = &init_mm;
+	if (curr->mm)
 		BUG();
-	enter_lazy_tlb(&init_mm, current);
+	enter_lazy_tlb(&init_mm, curr);
 
 	load_esp0(t, thread);
 	set_tss_desc(cpu,t);

--

