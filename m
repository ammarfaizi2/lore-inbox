Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261291AbVGGKXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbVGGKXt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 06:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVGGKVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 06:21:22 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:21460 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261291AbVGGKUP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 06:20:15 -0400
Date: Thu, 7 Jul 2005 15:50:42 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: akpm@osdl.org, Andi Kleen <ak@suse.de>,
       "David S. Miller" <davem@davemloft.net>, systemtap@sources.redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [6/6 PATCH] Kprobes : Prevent possible race conditions sparc64 changes
Message-ID: <20050707102042.GJ12106@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20050707101015.GE12106@in.ibm.com> <20050707101119.GF12106@in.ibm.com> <20050707101447.GG12106@in.ibm.com> <20050707101650.GH12106@in.ibm.com> <20050707101833.GI12106@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050707101833.GI12106@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch contains the sparc64 architecture specific changes to
prevent the possible race conditions.

Signed-off-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>


---

 linux-2.6.13-rc1-mm1-prasanna/arch/sparc64/kernel/kprobes.c     |   36 +++++-----
 linux-2.6.13-rc1-mm1-prasanna/arch/sparc64/kernel/vmlinux.lds.S |    1 
 linux-2.6.13-rc1-mm1-prasanna/arch/sparc64/mm/fault.c           |    8 +-
 linux-2.6.13-rc1-mm1-prasanna/arch/sparc64/mm/init.c            |    3 
 linux-2.6.13-rc1-mm1-prasanna/arch/sparc64/mm/ultra.S           |    2 
 5 files changed, 30 insertions(+), 20 deletions(-)

diff -puN arch/sparc64/kernel/kprobes.c~kprobes-exclude-functions-sparc64 arch/sparc64/kernel/kprobes.c
--- linux-2.6.13-rc1-mm1/arch/sparc64/kernel/kprobes.c~kprobes-exclude-functions-sparc64	2005-07-06 20:08:40.000000000 +0530
+++ linux-2.6.13-rc1-mm1-prasanna/arch/sparc64/kernel/kprobes.c	2005-07-06 20:08:40.000000000 +0530
@@ -8,6 +8,7 @@
 #include <linux/kprobes.h>
 #include <asm/kdebug.h>
 #include <asm/signal.h>
+#include <asm/cacheflush.h>
 
 /* We do not have hardware single-stepping on sparc64.
  * So we implement software single-stepping with breakpoint
@@ -37,31 +38,31 @@
  * - Mark that we are no longer actively in a kprobe.
  */
 
-int arch_prepare_kprobe(struct kprobe *p)
+int __kprobes arch_prepare_kprobe(struct kprobe *p)
 {
 	return 0;
 }
 
-void arch_copy_kprobe(struct kprobe *p)
+void __kprobes arch_copy_kprobe(struct kprobe *p)
 {
 	p->ainsn.insn[0] = *p->addr;
 	p->ainsn.insn[1] = BREAKPOINT_INSTRUCTION_2;
 	p->opcode = *p->addr;
 }
 
-void arch_arm_kprobe(struct kprobe *p)
+void __kprobes arch_arm_kprobe(struct kprobe *p)
 {
 	*p->addr = BREAKPOINT_INSTRUCTION;
 	flushi(p->addr);
 }
 
-void arch_disarm_kprobe(struct kprobe *p)
+void __kprobes arch_disarm_kprobe(struct kprobe *p)
 {
 	*p->addr = p->opcode;
 	flushi(p->addr);
 }
 
-void arch_remove_kprobe(struct kprobe *p)
+void __kprobes arch_remove_kprobe(struct kprobe *p)
 {
 }
 
@@ -111,7 +112,7 @@ static inline void prepare_singlestep(st
 	}
 }
 
-static int kprobe_handler(struct pt_regs *regs)
+static int __kprobes kprobe_handler(struct pt_regs *regs)
 {
 	struct kprobe *p;
 	void *addr = (void *) regs->tpc;
@@ -191,8 +192,9 @@ no_kprobe:
  * The original INSN location was REAL_PC, it actually
  * executed at PC and produced destination address NPC.
  */
-static unsigned long relbranch_fixup(u32 insn, unsigned long real_pc,
-				     unsigned long pc, unsigned long npc)
+static unsigned long __kprobes relbranch_fixup(u32 insn, unsigned long real_pc,
+					       unsigned long pc,
+					       unsigned long npc)
 {
 	/* Branch not taken, no mods necessary.  */
 	if (npc == pc + 0x4UL)
@@ -217,7 +219,8 @@ static unsigned long relbranch_fixup(u32
 /* If INSN is an instruction which writes it's PC location
  * into a destination register, fix that up.
  */
-static void retpc_fixup(struct pt_regs *regs, u32 insn, unsigned long real_pc)
+static void __kprobes retpc_fixup(struct pt_regs *regs, u32 insn,
+				  unsigned long real_pc)
 {
 	unsigned long *slot = NULL;
 
@@ -257,7 +260,7 @@ static void retpc_fixup(struct pt_regs *
  * This function prepares to return from the post-single-step
  * breakpoint trap.
  */
-static void resume_execution(struct kprobe *p, struct pt_regs *regs)
+static void __kprobes resume_execution(struct kprobe *p, struct pt_regs *regs)
 {
 	u32 insn = p->ainsn.insn[0];
 
@@ -315,8 +318,8 @@ static inline int kprobe_fault_handler(s
 /*
  * Wrapper routine to for handling exceptions.
  */
-int kprobe_exceptions_notify(struct notifier_block *self, unsigned long val,
-			     void *data)
+int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
+				       unsigned long val, void *data)
 {
 	struct die_args *args = (struct die_args *)data;
 	switch (val) {
@@ -344,7 +347,8 @@ int kprobe_exceptions_notify(struct noti
 	return NOTIFY_DONE;
 }
 
-asmlinkage void kprobe_trap(unsigned long trap_level, struct pt_regs *regs)
+asmlinkage void __kprobes kprobe_trap(unsigned long trap_level,
+				      struct pt_regs *regs)
 {
 	BUG_ON(trap_level != 0x170 && trap_level != 0x171);
 
@@ -368,7 +372,7 @@ static struct pt_regs jprobe_saved_regs;
 static struct pt_regs *jprobe_saved_regs_location;
 static struct sparc_stackf jprobe_saved_stack;
 
-int setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
+int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
 {
 	struct jprobe *jp = container_of(p, struct jprobe, kp);
 
@@ -390,7 +394,7 @@ int setjmp_pre_handler(struct kprobe *p,
 	return 1;
 }
 
-void jprobe_return(void)
+void __kprobes jprobe_return(void)
 {
 	preempt_enable_no_resched();
 	__asm__ __volatile__(
@@ -403,7 +407,7 @@ extern void jprobe_return_trap_instructi
 
 extern void __show_regs(struct pt_regs * regs);
 
-int longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
+int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
 {
 	u32 *addr = (u32 *) regs->tpc;
 
diff -puN arch/sparc64/kernel/vmlinux.lds.S~kprobes-exclude-functions-sparc64 arch/sparc64/kernel/vmlinux.lds.S
--- linux-2.6.13-rc1-mm1/arch/sparc64/kernel/vmlinux.lds.S~kprobes-exclude-functions-sparc64	2005-07-06 20:08:40.000000000 +0530
+++ linux-2.6.13-rc1-mm1-prasanna/arch/sparc64/kernel/vmlinux.lds.S	2005-07-06 20:08:40.000000000 +0530
@@ -17,6 +17,7 @@ SECTIONS
     *(.text)
     SCHED_TEXT
     LOCK_TEXT
+    KPROBES_TEXT
     *(.gnu.warning)
   } =0
   _etext = .;
diff -puN arch/sparc64/mm/fault.c~kprobes-exclude-functions-sparc64 arch/sparc64/mm/fault.c
--- linux-2.6.13-rc1-mm1/arch/sparc64/mm/fault.c~kprobes-exclude-functions-sparc64	2005-07-06 20:08:40.000000000 +0530
+++ linux-2.6.13-rc1-mm1-prasanna/arch/sparc64/mm/fault.c	2005-07-06 20:08:40.000000000 +0530
@@ -18,6 +18,7 @@
 #include <linux/smp_lock.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/kprobes.h>
 
 #include <asm/page.h>
 #include <asm/pgtable.h>
@@ -133,8 +134,9 @@ unsigned long __init prom_probe_memory (
 	return tally;
 }
 
-static void unhandled_fault(unsigned long address, struct task_struct *tsk,
-			    struct pt_regs *regs)
+static void __kprobes unhandled_fault(unsigned long address,
+				      struct task_struct *tsk,
+				      struct pt_regs *regs)
 {
 	if ((unsigned long) address < PAGE_SIZE) {
 		printk(KERN_ALERT "Unable to handle kernel NULL "
@@ -320,7 +322,7 @@ cannot_handle:
 	unhandled_fault (address, current, regs);
 }
 
-asmlinkage void do_sparc64_fault(struct pt_regs *regs)
+asmlinkage void __kprobes do_sparc64_fault(struct pt_regs *regs)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
diff -puN arch/sparc64/mm/init.c~kprobes-exclude-functions-sparc64 arch/sparc64/mm/init.c
--- linux-2.6.13-rc1-mm1/arch/sparc64/mm/init.c~kprobes-exclude-functions-sparc64	2005-07-06 20:08:40.000000000 +0530
+++ linux-2.6.13-rc1-mm1-prasanna/arch/sparc64/mm/init.c	2005-07-06 20:08:40.000000000 +0530
@@ -19,6 +19,7 @@
 #include <linux/pagemap.h>
 #include <linux/fs.h>
 #include <linux/seq_file.h>
+#include <linux/kprobes.h>
 
 #include <asm/head.h>
 #include <asm/system.h>
@@ -239,7 +240,7 @@ out:
 	put_cpu();
 }
 
-void flush_icache_range(unsigned long start, unsigned long end)
+void __kprobes flush_icache_range(unsigned long start, unsigned long end)
 {
 	/* Cheetah has coherent I-cache. */
 	if (tlb_type == spitfire) {
diff -puN arch/sparc64/mm/ultra.S~kprobes-exclude-functions-sparc64 arch/sparc64/mm/ultra.S
--- linux-2.6.13-rc1-mm1/arch/sparc64/mm/ultra.S~kprobes-exclude-functions-sparc64	2005-07-06 20:08:40.000000000 +0530
+++ linux-2.6.13-rc1-mm1-prasanna/arch/sparc64/mm/ultra.S	2005-07-07 10:19:48.000000000 +0530
@@ -112,6 +112,7 @@ __spitfire_flush_tlb_mm_slow:
 #else
 #error unsupported PAGE_SIZE
 #endif
+	.section .kprobes.text
 	.align		32
 	.globl		__flush_icache_page
 __flush_icache_page:	/* %o0 = phys_page */
@@ -194,6 +195,7 @@ dflush4:stxa		%g0, [%o4] ASI_DCACHE_TAG
 	 nop
 #endif /* DCACHE_ALIASING_POSSIBLE */
 
+	.previous .text
 	.align		32
 __prefill_dtlb:
 	rdpr		%pstate, %g7

_
-- 

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
