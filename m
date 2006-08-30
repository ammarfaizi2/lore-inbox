Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbWHaA2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbWHaA2I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 20:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWHaA2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 20:28:08 -0400
Received: from 207.47.60.101.static.nextweb.net ([207.47.60.101]:38054 "EHLO
	mail.goop.org") by vger.kernel.org with ESMTP id S932258AbWHaA2F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 20:28:05 -0400
Message-Id: <20060831000515.548517380@goop.org>
References: <20060830235201.106319215@goop.org>
User-Agent: quilt/0.45-1
Date: Wed, 30 Aug 2006 16:52:09 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: linux-kernel@vger.kernel.org
Cc: Chuck Ebbert <76306.1226@compuserve.com>, Zachary Amsden <zach@vmware.com>,
       Jan Beulich <jbeulich@novell.com>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 8/8] Implement "current" with the PDA.
Content-Disposition: inline; filename=i386-pda-current.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the pcurrent field in the PDA to implement the "current" macro.
This ends up compiling down to a single instruction to get the current
task.

This keeps the original definition of "get_current()" with the name
"early_current()", for use before the PDA has been set up.  On the
boot CPU, "current" will always work, but on secondary CPUs, it needs
the PDA to be explicitly set up first.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Zachary Amsden <zach@vmware.com>
Cc: Jan Beulich <jbeulich@novell.com>
Cc: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/cpu/common.c |   19 ++++++++++++-------
 arch/i386/kernel/smpboot.c    |    4 +++-
 include/asm-i386/current.h    |   10 ++++++++--
 3 files changed, 23 insertions(+), 10 deletions(-)


===================================================================
--- a/arch/i386/kernel/cpu/common.c
+++ b/arch/i386/kernel/cpu/common.c
@@ -665,7 +665,7 @@ static __cpuinit void init_gdt(void)
 static __cpuinit void init_gdt(void)
 {
 	int cpu = early_smp_processor_id();
-	struct task_struct *curr = current;
+	struct task_struct *curr = early_current();
 	struct Xgt_desc_struct *cpu_gdt_descr = &per_cpu(cpu_gdt_descr, cpu);
 	__u32 stk16_off = (__u32)&per_cpu(cpu_16bit_stack, cpu);
 	struct desc_struct *gdt;
@@ -709,15 +709,18 @@ static __cpuinit void init_gdt(void)
 	pda_init(cpu, curr);
 }
 
-/* Set up a very early PDA for the boot CPU so that smp_processor_id will work */
+/* Set up a very early PDA for the boot CPU so that smp_processor_id()
+   and current will work. */
 void __init smp_setup_processor_id(void)
 {
-	static const __initdata struct i386_pda boot_pda;
+	static __initdata struct i386_pda boot_pda;
 
 	pack_descriptor((u32 *)&cpu_gdt_table[GDT_ENTRY_PDA].a,
 			(u32 *)&cpu_gdt_table[GDT_ENTRY_PDA].b,
 			(unsigned long)&boot_pda, sizeof(struct i386_pda) - 1,
 			0x80 | DESCTYPE_S | 0x2, 0); /* present read-write data segment */
+
+	boot_pda.pcurrent = early_current();
 
 	/* Set %gs for this CPU's PDA */
 	set_kernel_gs();
@@ -732,8 +735,10 @@ void __cpuinit cpu_init(void)
 void __cpuinit cpu_init(void)
 {
 	int cpu = early_smp_processor_id();
+	struct task_struct *curr = early_current();
+
 	struct tss_struct * t = &per_cpu(init_tss, cpu);
-	struct thread_struct *thread = &current->thread;
+	struct thread_struct *thread = &curr->thread;
 
 	if (cpu_test_and_set(cpu, cpu_initialized)) {
 		printk(KERN_WARNING "CPU#%d already initialized!\n", cpu);
@@ -761,10 +766,10 @@ void __cpuinit cpu_init(void)
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
===================================================================
--- a/arch/i386/kernel/smpboot.c
+++ b/arch/i386/kernel/smpboot.c
@@ -590,6 +590,8 @@ static void __devinit start_secondary(vo
  */
 void __devinit initialize_secondary(void)
 {
+	struct task_struct *curr = early_current();
+
 	/*
 	 * We don't actually need to load the full TSS,
 	 * basically just the stack pointer and the eip.
@@ -599,7 +601,7 @@ void __devinit initialize_secondary(void
 		"movl %0,%%esp\n\t"
 		"jmp *%1"
 		:
-		:"r" (current->thread.esp),"r" (current->thread.eip));
+		:"r" (curr->thread.esp),"r" (curr->thread.eip));
 }
 
 extern struct {
===================================================================
--- a/include/asm-i386/current.h
+++ b/include/asm-i386/current.h
@@ -2,14 +2,20 @@
 #define _I386_CURRENT_H
 
 #include <linux/thread_info.h>
+#include <asm/pda.h>
 
 struct task_struct;
 
-static __always_inline struct task_struct * get_current(void)
+static __always_inline struct task_struct *early_current(void)
 {
 	return current_thread_info()->task;
 }
- 
+
+static __always_inline struct task_struct *get_current(void)
+{
+	return read_pda(pcurrent);
+}
+
 #define current get_current()
 
 #endif /* !(_I386_CURRENT_H) */

--

