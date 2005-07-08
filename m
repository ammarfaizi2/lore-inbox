Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262501AbVGHLE4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262501AbVGHLE4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 07:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262524AbVGHLEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 07:04:51 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:47291 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262509AbVGHLEg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 07:04:36 -0400
Date: Fri, 8 Jul 2005 16:35:11 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, "David S. Miller" <davem@davemloft.net>,
       systemtap@sources.redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [2/6 PATCH] Kprobes : Prevent possible race conditions i386 changes
Message-ID: <20050708110511.GA15502@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20050707101015.GE12106@in.ibm.com> <20050707101119.GF12106@in.ibm.com> <20050707131906.GY21330@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050707131906.GY21330@wotan.suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

I have updated the patch as per your comments to move int3,debug, page_fault,
general_protection routines to .kprobes.text section.

Please let me know if you any issues.

Thanks
Prasanna


This patch contains the i386 architecture specific changes to
prevent the possible race conditions.

Signed-off-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>


---

 linux-2.6.13-rc1-mm1-prasanna/arch/i386/kernel/entry.S       |   13 +++-
 linux-2.6.13-rc1-mm1-prasanna/arch/i386/kernel/kprobes.c     |   29 +++++------
 linux-2.6.13-rc1-mm1-prasanna/arch/i386/kernel/traps.c       |   12 ++--
 linux-2.6.13-rc1-mm1-prasanna/arch/i386/kernel/vmlinux.lds.S |    1 
 linux-2.6.13-rc1-mm1-prasanna/arch/i386/mm/fault.c           |    4 +
 5 files changed, 34 insertions(+), 25 deletions(-)

diff -puN arch/i386/kernel/kprobes.c~kprobes-exclude-functions-i386 arch/i386/kernel/kprobes.c
--- linux-2.6.13-rc1-mm1/arch/i386/kernel/kprobes.c~kprobes-exclude-functions-i386	2005-07-08 12:09:51.000000000 +0530
+++ linux-2.6.13-rc1-mm1-prasanna/arch/i386/kernel/kprobes.c	2005-07-08 12:09:51.000000000 +0530
@@ -62,32 +62,32 @@ static inline int is_IF_modifier(kprobe_
 	return 0;
 }
 
-int arch_prepare_kprobe(struct kprobe *p)
+int __kprobes arch_prepare_kprobe(struct kprobe *p)
 {
 	return 0;
 }
 
-void arch_copy_kprobe(struct kprobe *p)
+void __kprobes arch_copy_kprobe(struct kprobe *p)
 {
 	memcpy(p->ainsn.insn, p->addr, MAX_INSN_SIZE * sizeof(kprobe_opcode_t));
 	p->opcode = *p->addr;
 }
 
-void arch_arm_kprobe(struct kprobe *p)
+void __kprobes arch_arm_kprobe(struct kprobe *p)
 {
 	*p->addr = BREAKPOINT_INSTRUCTION;
 	flush_icache_range((unsigned long) p->addr,
 			   (unsigned long) p->addr + sizeof(kprobe_opcode_t));
 }
 
-void arch_disarm_kprobe(struct kprobe *p)
+void __kprobes arch_disarm_kprobe(struct kprobe *p)
 {
 	*p->addr = p->opcode;
 	flush_icache_range((unsigned long) p->addr,
 			   (unsigned long) p->addr + sizeof(kprobe_opcode_t));
 }
 
-void arch_remove_kprobe(struct kprobe *p)
+void __kprobes arch_remove_kprobe(struct kprobe *p)
 {
 }
 
@@ -127,7 +127,8 @@ static inline void prepare_singlestep(st
 		regs->eip = (unsigned long)&p->ainsn.insn;
 }
 
-void arch_prepare_kretprobe(struct kretprobe *rp, struct pt_regs *regs)
+void __kprobes arch_prepare_kretprobe(struct kretprobe *rp,
+				      struct pt_regs *regs)
 {
 	unsigned long *sara = (unsigned long *)&regs->esp;
         struct kretprobe_instance *ri;
@@ -150,7 +151,7 @@ void arch_prepare_kretprobe(struct kretp
  * Interrupts are disabled on entry as trap3 is an interrupt gate and they
  * remain disabled thorough out this function.
  */
-static int kprobe_handler(struct pt_regs *regs)
+static int __kprobes kprobe_handler(struct pt_regs *regs)
 {
 	struct kprobe *p;
 	int ret = 0;
@@ -259,7 +260,7 @@ no_kprobe:
 /*
  * Called when we hit the probe point at kretprobe_trampoline
  */
-int trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
+int __kprobes trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
 {
         struct kretprobe_instance *ri = NULL;
         struct hlist_head *head;
@@ -338,7 +339,7 @@ int trampoline_probe_handler(struct kpro
  * that is atop the stack is the address following the copied instruction.
  * We need to make it the address following the original instruction.
  */
-static void resume_execution(struct kprobe *p, struct pt_regs *regs)
+static void __kprobes resume_execution(struct kprobe *p, struct pt_regs *regs)
 {
 	unsigned long *tos = (unsigned long *)&regs->esp;
 	unsigned long next_eip = 0;
@@ -444,8 +445,8 @@ static inline int kprobe_fault_handler(s
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
@@ -473,7 +474,7 @@ int kprobe_exceptions_notify(struct noti
 	return NOTIFY_DONE;
 }
 
-int setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
+int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
 {
 	struct jprobe *jp = container_of(p, struct jprobe, kp);
 	unsigned long addr;
@@ -495,7 +496,7 @@ int setjmp_pre_handler(struct kprobe *p,
 	return 1;
 }
 
-void jprobe_return(void)
+void __kprobes jprobe_return(void)
 {
 	preempt_enable_no_resched();
 	asm volatile ("       xchgl   %%ebx,%%esp     \n"
@@ -506,7 +507,7 @@ void jprobe_return(void)
 		      (jprobe_saved_esp):"memory");
 }
 
-int longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
+int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
 {
 	u8 *addr = (u8 *) (regs->eip - 1);
 	unsigned long stack_addr = (unsigned long)jprobe_saved_esp;
diff -puN arch/i386/kernel/traps.c~kprobes-exclude-functions-i386 arch/i386/kernel/traps.c
--- linux-2.6.13-rc1-mm1/arch/i386/kernel/traps.c~kprobes-exclude-functions-i386	2005-07-08 12:09:51.000000000 +0530
+++ linux-2.6.13-rc1-mm1-prasanna/arch/i386/kernel/traps.c	2005-07-08 12:09:51.000000000 +0530
@@ -408,8 +408,9 @@ static inline void die_if_kernel(const c
 		die(str, regs, err);
 }
 
-static void do_trap(int trapnr, int signr, char *str, int vm86,
-			   struct pt_regs * regs, long error_code, siginfo_t *info)
+static void __kprobes do_trap(int trapnr, int signr, char *str, int vm86,
+			      struct pt_regs * regs, long error_code,
+			      siginfo_t *info)
 {
 	struct task_struct *tsk = current;
 	tsk->thread.error_code = error_code;
@@ -507,7 +508,8 @@ DO_ERROR(12, SIGBUS,  "stack segment", s
 DO_ERROR_INFO(17, SIGBUS, "alignment check", alignment_check, BUS_ADRALN, 0)
 DO_ERROR_INFO(32, SIGSEGV, "iret exception", iret_error, ILL_BADSTK, 0)
 
-fastcall void do_general_protection(struct pt_regs * regs, long error_code)
+fastcall void __kprobes do_general_protection(struct pt_regs * regs,
+					      long error_code)
 {
 	int cpu = get_cpu();
 	struct tss_struct *tss = &per_cpu(init_tss, cpu);
@@ -737,7 +739,7 @@ void unset_nmi_callback(void)
 EXPORT_SYMBOL_GPL(unset_nmi_callback);
 
 #ifdef CONFIG_KPROBES
-fastcall void do_int3(struct pt_regs *regs, long error_code)
+fastcall void __kprobes do_int3(struct pt_regs *regs, long error_code)
 {
 	if (notify_die(DIE_INT3, "int3", regs, error_code, 3, SIGTRAP)
 			== NOTIFY_STOP)
@@ -771,7 +773,7 @@ fastcall void do_int3(struct pt_regs *re
  * find every occurrence of the TF bit that could be saved away even
  * by user code)
  */
-fastcall void do_debug(struct pt_regs * regs, long error_code)
+fastcall void __kprobes do_debug(struct pt_regs * regs, long error_code)
 {
 	unsigned int condition;
 	struct task_struct *tsk = current;
diff -puN arch/i386/kernel/vmlinux.lds.S~kprobes-exclude-functions-i386 arch/i386/kernel/vmlinux.lds.S
--- linux-2.6.13-rc1-mm1/arch/i386/kernel/vmlinux.lds.S~kprobes-exclude-functions-i386	2005-07-08 12:09:51.000000000 +0530
+++ linux-2.6.13-rc1-mm1-prasanna/arch/i386/kernel/vmlinux.lds.S	2005-07-08 12:09:51.000000000 +0530
@@ -22,6 +22,7 @@ SECTIONS
 	*(.text)
 	SCHED_TEXT
 	LOCK_TEXT
+	KPROBES_TEXT
 	*(.fixup)
 	*(.gnu.warning)
 	} = 0x9090
diff -puN arch/i386/mm/fault.c~kprobes-exclude-functions-i386 arch/i386/mm/fault.c
--- linux-2.6.13-rc1-mm1/arch/i386/mm/fault.c~kprobes-exclude-functions-i386	2005-07-08 12:09:51.000000000 +0530
+++ linux-2.6.13-rc1-mm1-prasanna/arch/i386/mm/fault.c	2005-07-08 12:09:51.000000000 +0530
@@ -21,6 +21,7 @@
 #include <linux/vt_kern.h>		/* For unblank_screen() */
 #include <linux/highmem.h>
 #include <linux/module.h>
+#include <linux/kprobes.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -211,7 +212,8 @@ fastcall void do_invalid_op(struct pt_re
  *	bit 1 == 0 means read, 1 means write
  *	bit 2 == 0 means kernel, 1 means user-mode
  */
-fastcall void do_page_fault(struct pt_regs *regs, unsigned long error_code)
+fastcall void __kprobes do_page_fault(struct pt_regs *regs,
+				      unsigned long error_code)
 {
 	struct task_struct *tsk;
 	struct mm_struct *mm;
diff -puN arch/i386/kernel/entry.S~kprobes-exclude-functions-i386 arch/i386/kernel/entry.S
--- linux-2.6.13-rc1-mm1/arch/i386/kernel/entry.S~kprobes-exclude-functions-i386	2005-07-08 12:09:51.000000000 +0530
+++ linux-2.6.13-rc1-mm1-prasanna/arch/i386/kernel/entry.S	2005-07-08 12:09:51.000000000 +0530
@@ -532,7 +532,7 @@ label:						\
 	pushl $__KERNEL_CS;			\
 	pushl $sysenter_past_esp
 
-ENTRY(debug)
+KPROBE_ENTRY(debug)
 	cmpl $sysenter_entry,(%esp)
 	jne debug_stack_correct
 	FIX_STACK(12, debug_stack_correct, debug_esp_fix_insn)
@@ -543,7 +543,7 @@ debug_stack_correct:
 	movl %esp,%eax			# pt_regs pointer
 	call do_debug
 	jmp ret_from_exception
-
+	.previous .text
 /*
  * NMI is doubly nasty. It can happen _while_ we're handling
  * a debug fault, and the debug fault hasn't yet been able to
@@ -616,13 +616,14 @@ nmi_16bit_stack:
 	.long 1b,iret_exc
 .previous
 
-ENTRY(int3)
+KPROBE_ENTRY(int3)
 	pushl $-1			# mark this as an int
 	SAVE_ALL
 	xorl %edx,%edx		# zero error code
 	movl %esp,%eax		# pt_regs pointer
 	call do_int3
 	jmp ret_from_exception
+	.previous .text
 
 ENTRY(overflow)
 	pushl $0
@@ -656,17 +657,19 @@ ENTRY(stack_segment)
 	pushl $do_stack_segment
 	jmp error_code
 
-ENTRY(general_protection)
+KPROBE_ENTRY(general_protection)
 	pushl $do_general_protection
 	jmp error_code
+	.previous .text
 
 ENTRY(alignment_check)
 	pushl $do_alignment_check
 	jmp error_code
 
-ENTRY(page_fault)
+KPROBE_ENTRY(page_fault)
 	pushl $do_page_fault
 	jmp error_code
+	.previous .text
 
 #ifdef CONFIG_X86_MCE
 ENTRY(machine_check)

_
-- 

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
