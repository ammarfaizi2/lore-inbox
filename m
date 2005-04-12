Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262623AbVDMC4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262623AbVDMC4V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 22:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbVDLTmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:42:37 -0400
Received: from fire.osdl.org ([65.172.181.4]:969 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262183AbVDLKcE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:04 -0400
Message-Id: <200504121031.j3CAVvcH005455@shell0.pdx.osdl.net>
Subject: [patch 082/198] x86_64: Regularize exception stack handling
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:51 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Andi Kleen" <ak@suse.de>

This fixes various issues in the return path for "paranoid"
handlers (= running on a private exception stack that act like NMIs).

Generalize previous hack to switch back to process stack for
scheduling/signal handling purposes.

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/x86_64/kernel/entry.S |   49 +++++++++++++++++--------------
 25-akpm/arch/x86_64/kernel/traps.c |   57 ++++++++++++++++++-------------------
 2 files changed, 55 insertions(+), 51 deletions(-)

diff -puN arch/x86_64/kernel/entry.S~x86_64-regularize-exception-stack-handling arch/x86_64/kernel/entry.S
--- 25/arch/x86_64/kernel/entry.S~x86_64-regularize-exception-stack-handling	2005-04-12 03:21:22.841664440 -0700
+++ 25-akpm/arch/x86_64/kernel/entry.S	2005-04-12 03:21:22.846663680 -0700
@@ -579,6 +579,7 @@ ENTRY(spurious_interrupt)
 	movq ORIG_RAX(%rsp),%rsi
 	movq $-1,ORIG_RAX(%rsp)
 	call \sym
+	cli
 	.endm
 	
 /*
@@ -794,10 +795,6 @@ ENTRY(debug)
 	pushq $0
 	CFI_ADJUST_CFA_OFFSET 8		
 	paranoidentry do_debug
-	/* switch back to process stack to restore the state ptrace touched */
-	movq %rax,%rsp	
-	testl $3,CS(%rsp)
-	jnz   paranoid_userspace	
 	jmp paranoid_exit
 	CFI_ENDPROC
 
@@ -807,35 +804,49 @@ ENTRY(nmi)
 	pushq $-1
 	CFI_ADJUST_CFA_OFFSET 8		
 	paranoidentry do_nmi
+	/*
+ 	 * "Paranoid" exit path from exception stack.
+  	 * Paranoid because this is used by NMIs and cannot take
+	 * any kernel state for granted.
+	 * We don't do kernel preemption checks here, because only
+	 * NMI should be common and it does not enable IRQs and
+	 * cannot get reschedule ticks.
+	 */
 	/* ebx:	no swapgs flag */
 paranoid_exit:
 	testl %ebx,%ebx				/* swapgs needed? */
 	jnz paranoid_restore
+	testl $3,CS(%rsp)
+	jnz   paranoid_userspace
 paranoid_swapgs:	
-	cli
 	swapgs
 paranoid_restore:	
 	RESTORE_ALL 8
 	iretq
 paranoid_userspace:	
-	cli
 	GET_THREAD_INFO(%rcx)
-	movl threadinfo_flags(%rcx),%edx
-	testl $_TIF_WORK_MASK,%edx
+	movl threadinfo_flags(%rcx),%ebx
+	andl $_TIF_WORK_MASK,%ebx
 	jz paranoid_swapgs
-	testl $_TIF_NEED_RESCHED,%edx
-	jnz paranoid_resched
+	movq %rsp,%rdi			/* &pt_regs */
+	call sync_regs
+	movq %rax,%rsp			/* switch stack for scheduling */
+	testl $_TIF_NEED_RESCHED,%ebx
+	jnz paranoid_schedule
+	movl %ebx,%edx			/* arg3: thread flags */
 	sti
-	xorl %esi,%esi /* oldset */
-	movq %rsp,%rdi /* &pt_regs */
+	xorl %esi,%esi 			/* arg2: oldset */
+	movq %rsp,%rdi 			/* arg1: &pt_regs */
 	call do_notify_resume
-	jmp paranoid_exit
-paranoid_resched:
+	cli
+	jmp paranoid_userspace
+paranoid_schedule:
 	sti
 	call schedule
-	jmp paranoid_exit
+	cli
+	jmp paranoid_userspace
 	CFI_ENDPROC
-	
+
 ENTRY(int3)
 	zeroentry do_int3	
 
@@ -858,9 +869,6 @@ ENTRY(reserved)
 ENTRY(double_fault)
 	CFI_STARTPROC
 	paranoidentry do_double_fault
-	movq %rax,%rsp
-	testl $3,CS(%rsp)
-	jnz paranoid_userspace		
 	jmp paranoid_exit
 	CFI_ENDPROC
 
@@ -874,9 +882,6 @@ ENTRY(segment_not_present)
 ENTRY(stack_segment)
 	CFI_STARTPROC
 	paranoidentry do_stack_segment
-	movq %rax,%rsp
-	testl $3,CS(%rsp)
-	jnz paranoid_userspace
 	jmp paranoid_exit
 	CFI_ENDPROC
 
diff -puN arch/x86_64/kernel/traps.c~x86_64-regularize-exception-stack-handling arch/x86_64/kernel/traps.c
--- 25/arch/x86_64/kernel/traps.c~x86_64-regularize-exception-stack-handling	2005-04-12 03:21:22.842664288 -0700
+++ 25-akpm/arch/x86_64/kernel/traps.c	2005-04-12 03:21:22.847663528 -0700
@@ -488,24 +488,8 @@ DO_ERROR(10, SIGSEGV, "invalid TSS", inv
 DO_ERROR(11, SIGBUS,  "segment not present", segment_not_present)
 DO_ERROR_INFO(17, SIGBUS, "alignment check", alignment_check, BUS_ADRALN, 0)
 DO_ERROR(18, SIGSEGV, "reserved", reserved)
-
-#define DO_ERROR_STACK(trapnr, signr, str, name) \
-asmlinkage void *do_##name(struct pt_regs * regs, long error_code) \
-{ \
-	struct pt_regs *pr = ((struct pt_regs *)(current->thread.rsp0))-1; \
-	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) \
-							== NOTIFY_STOP) \
-		return regs; \
-	if (regs->cs & 3) { \
-		memcpy(pr, regs, sizeof(struct pt_regs)); \
-		regs = pr; \
-	} \
-	do_trap(trapnr, signr, str, regs, error_code, NULL); \
-	return regs;		\
-}
-
-DO_ERROR_STACK(12, SIGBUS,  "stack segment", stack_segment)
-DO_ERROR_STACK( 8, SIGSEGV, "double fault", double_fault)
+DO_ERROR(12, SIGBUS,  "stack segment", stack_segment)
+DO_ERROR( 8, SIGSEGV, "double fault", double_fault)
 
 asmlinkage void do_general_protection(struct pt_regs * regs, long error_code)
 {
@@ -584,6 +568,8 @@ static void unknown_nmi_error(unsigned c
 	printk("Do you have a strange power saving mode enabled?\n");
 }
 
+/* Runs on IST stack. This code must keep interrupts off all the time.
+   Nested NMIs are prevented by the CPU. */
 asmlinkage void default_do_nmi(struct pt_regs *regs)
 {
 	unsigned char reason = 0;
@@ -629,20 +615,34 @@ asmlinkage void do_int3(struct pt_regs *
 	return;
 }
 
+/* Help handler running on IST stack to switch back to user stack
+   for scheduling or signal handling. The actual stack switch is done in
+   entry.S */
+asmlinkage struct pt_regs *sync_regs(struct pt_regs *eregs)
+{
+	struct pt_regs *regs = eregs;
+	/* Did already sync */
+	if (eregs == (struct pt_regs *)eregs->rsp)
+		;
+	/* Exception from user space */
+	else if (eregs->cs & 3)
+		regs = ((struct pt_regs *)current->thread.rsp0) - 1;
+	/* Exception from kernel and interrupts are enabled. Move to
+ 	   kernel process stack. */
+	else if (eregs->eflags & X86_EFLAGS_IF)
+		regs = (struct pt_regs *)(eregs->rsp -= sizeof(struct pt_regs));
+	if (eregs != regs)
+		*regs = *eregs;
+	return regs;
+}
+
 /* runs on IST stack. */
-asmlinkage void *do_debug(struct pt_regs * regs, unsigned long error_code)
+asmlinkage void do_debug(struct pt_regs * regs, unsigned long error_code)
 {
-	struct pt_regs *pr;
 	unsigned long condition;
 	struct task_struct *tsk = current;
 	siginfo_t info;
 
-	pr = (struct pt_regs *)(current->thread.rsp0)-1;
-	if (regs->cs & 3) {
-		memcpy(pr, regs, sizeof(struct pt_regs));
-		regs = pr;
-	}	
-
 #ifdef CONFIG_CHECKING
        { 
 	       /* RED-PEN interaction with debugger - could destroy gs */
@@ -660,7 +660,7 @@ asmlinkage void *do_debug(struct pt_regs
 
 	if (notify_die(DIE_DEBUG, "debug", regs, condition, error_code,
 						SIGTRAP) == NOTIFY_STOP) {
-		return regs;
+		return;
 	}
 	conditional_sti(regs);
 
@@ -712,7 +712,7 @@ asmlinkage void *do_debug(struct pt_regs
 clear_dr7:
 	asm volatile("movq %0,%%db7"::"r"(0UL));
 	notify_die(DIE_DEBUG, "debug", regs, condition, 1, SIGTRAP);
-	return regs;
+	return;
 
 clear_TF_reenable:
 	set_tsk_thread_flag(tsk, TIF_SINGLESTEP);
@@ -722,7 +722,6 @@ clear_TF:
 	if (notify_die(DIE_DEBUG, "debug2", regs, condition, 1, SIGTRAP) 
 								!= NOTIFY_STOP)
 	regs->eflags &= ~TF_MASK;
-	return regs;	
 }
 
 static int kernel_math_error(struct pt_regs *regs, char *str)
_
