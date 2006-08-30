Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbWHaA2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbWHaA2b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 20:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWHaA2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 20:28:12 -0400
Received: from 207.47.60.101.static.nextweb.net ([207.47.60.101]:37542 "EHLO
	mail.goop.org") by vger.kernel.org with ESMTP id S932256AbWHaA2F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 20:28:05 -0400
Message-Id: <20060831000515.338336117@goop.org>
References: <20060830235201.106319215@goop.org>
User-Agent: quilt/0.45-1
Date: Wed, 30 Aug 2006 16:52:08 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: linux-kernel@vger.kernel.org
Cc: Chuck Ebbert <76306.1226@compuserve.com>, Zachary Amsden <zach@vmware.com>,
       Jan Beulich <jbeulich@novell.com>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 7/8] Implement smp_processor_id() with the PDA.
Content-Disposition: inline; filename=i386-pda-smp_processor_id.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the cpu_number in the PDA to implement raw_smp_processor_id.  This
is a little simpler than using thread_info, though the cpu field in
thread_info cannot be removed since it is used for things other than
getting the current CPU in common code.

The slightly subtle part of this patch is dealing with very early uses
of smp_processor_id().  This is handled on the boot CPU by setting up
a very early PDA, which is later replaced when cpu_init() is called on
the boot CPU.  For other CPUs, it uses the thread_info cpu field until
the PDA has been set up.

This is more or less an example of using the PDA, and to give it a
proper exercising.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Zachary Amsden <zach@vmware.com>
Cc: Jan Beulich <jbeulich@novell.com>
Cc: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/asm-offsets.c |    2 +-
 arch/i386/kernel/cpu/common.c  |   18 ++++++++++++++++--
 include/asm-i386/smp.h         |    6 +++++-
 init/main.c                    |    9 +++++++--
 4 files changed, 29 insertions(+), 6 deletions(-)


===================================================================
--- a/arch/i386/kernel/asm-offsets.c
+++ b/arch/i386/kernel/asm-offsets.c
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
===================================================================
--- a/arch/i386/kernel/cpu/common.c
+++ b/arch/i386/kernel/cpu/common.c
@@ -664,7 +664,7 @@ static inline void set_kernel_gs(void)
 /* Initialize the CPU's GDT and PDA */
 static __cpuinit void init_gdt(void)
 {
-	int cpu = smp_processor_id();
+	int cpu = early_smp_processor_id();
 	struct task_struct *curr = current;
 	struct Xgt_desc_struct *cpu_gdt_descr = &per_cpu(cpu_gdt_descr, cpu);
 	__u32 stk16_off = (__u32)&per_cpu(cpu_16bit_stack, cpu);
@@ -707,6 +707,20 @@ static __cpuinit void init_gdt(void)
 
 	/* Do this once everything GDT-related has been set up. */
 	pda_init(cpu, curr);
+}
+
+/* Set up a very early PDA for the boot CPU so that smp_processor_id will work */
+void __init smp_setup_processor_id(void)
+{
+	static const __initdata struct i386_pda boot_pda;
+
+	pack_descriptor((u32 *)&cpu_gdt_table[GDT_ENTRY_PDA].a,
+			(u32 *)&cpu_gdt_table[GDT_ENTRY_PDA].b,
+			(unsigned long)&boot_pda, sizeof(struct i386_pda) - 1,
+			0x80 | DESCTYPE_S | 0x2, 0); /* present read-write data segment */
+
+	/* Set %gs for this CPU's PDA */
+	set_kernel_gs();
 }
 
 /*
@@ -717,7 +731,7 @@ static __cpuinit void init_gdt(void)
  */
 void __cpuinit cpu_init(void)
 {
-	int cpu = smp_processor_id();
+	int cpu = early_smp_processor_id();
 	struct tss_struct * t = &per_cpu(init_tss, cpu);
 	struct thread_struct *thread = &current->thread;
 
===================================================================
--- a/include/asm-i386/smp.h
+++ b/include/asm-i386/smp.h
@@ -8,6 +8,7 @@
 #include <linux/kernel.h>
 #include <linux/threads.h>
 #include <linux/cpumask.h>
+#include <asm/pda.h>
 #endif
 
 #ifdef CONFIG_X86_LOCAL_APIC
@@ -58,7 +59,10 @@ extern void cpu_uninit(void);
  * from the initial startup. We map APIC_BASE very early in page_setup(),
  * so this is correct in the x86 case.
  */
-#define raw_smp_processor_id() (current_thread_info()->cpu)
+#define raw_smp_processor_id() (read_pda(cpu_number))
+/* This is valid from the very earliest point in boot that we care
+   about. */
+#define early_smp_processor_id() (current_thread_info()->cpu)
 
 extern cpumask_t cpu_callout_map;
 extern cpumask_t cpu_callin_map;
===================================================================
--- a/init/main.c
+++ b/init/main.c
@@ -473,8 +473,13 @@ static void __init boot_cpu_init(void)
 	cpu_set(cpu, cpu_possible_map);
 }
 
-void __init __attribute__((weak)) smp_setup_processor_id(void)
-{
+/* Some versions of gcc seem to want to inline/eliminate the call to
+   this function, even though it is weak and could therefore be
+   replaced at link time.  Mark it noinline, and add an asm() to make
+   it harder to digest. */
+noinline void __init __attribute__((weak)) smp_setup_processor_id(void)
+{
+	asm volatile("" : : : "memory");
 }
 
 asmlinkage void __init start_kernel(void)

--

