Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbWH0JZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbWH0JZt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 05:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbWH0JZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 05:25:49 -0400
Received: from 32.sub-70-198-1.myvzw.com ([70.198.1.32]:54722 "EHLO
	mail.goop.org") by vger.kernel.org with ESMTP id S1751368AbWH0JZj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 05:25:39 -0400
Message-Id: <20060827084452.647282416@goop.org>
References: <20060827084417.918992193@goop.org>
User-Agent: quilt/0.45-1
Date: Sun, 27 Aug 2006 01:44:22 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: linux-kernel@vger.kernel.org
Cc: Chuck Ebbert <76306.1226@compuserve.com>, Zachary Amsden <zach@vmware.com>,
       Jan Beulich <jbeulich@novell.com>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH RFC 5/6] Implement smp_processor_id() with the PDA.
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
 arch/i386/kernel/cpu/common.c  |   16 +++++++++++++++-
 include/asm-i386/smp.h         |    3 ++-
 3 files changed, 18 insertions(+), 3 deletions(-)


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
@@ -78,4 +77,5 @@ void foo(void)
 
 	BLANK();
 	OFFSET(PDA_pcurrent, i386_pda, pcurrent);
+	OFFSET(PDA_cpu, i386_pda, cpu_number);
 }
===================================================================
--- a/arch/i386/kernel/cpu/common.c
+++ b/arch/i386/kernel/cpu/common.c
@@ -606,6 +606,20 @@ struct pt_regs * __devinit idle_regs(str
 	return regs;
 }
 
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
+	asm volatile ("mov %0, %%gs" : : "r" (__KERNEL_PDA));
+}
+
 /*
  * cpu_init() initializes state that is per-CPU. Some data is already
  * initialized (naturally) in the bootstrap process, such as the GDT
@@ -614,7 +628,7 @@ struct pt_regs * __devinit idle_regs(str
  */
 void __cpuinit cpu_init(void)
 {
-	int cpu = smp_processor_id();
+	int cpu = current_thread_info()->cpu; /* need to use this until the PDA is set up */
 	struct tss_struct * t = &per_cpu(init_tss, cpu);
 	struct thread_struct *thread = &current->thread;
 	struct desc_struct *gdt;
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
@@ -58,7 +59,7 @@ extern void cpu_uninit(void);
  * from the initial startup. We map APIC_BASE very early in page_setup(),
  * so this is correct in the x86 case.
  */
-#define raw_smp_processor_id() (current_thread_info()->cpu)
+#define raw_smp_processor_id() (read_pda(cpu_number))
 
 extern cpumask_t cpu_callout_map;
 extern cpumask_t cpu_callin_map;

--

