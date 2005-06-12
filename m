Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbVFLTUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbVFLTUl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 15:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbVFLTUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 15:20:38 -0400
Received: from aun.it.uu.se ([130.238.12.36]:26335 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262638AbVFLQaY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 12:30:24 -0400
Date: Sun, 12 Jun 2005 18:29:59 +0200 (MEST)
Message-Id: <200506121629.j5CGTx5K020388@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: ak@suse.de
Subject: Re: [PATCH 2.4.31 6/9] gcc4: fix x86_64 sys_iopl() bug
Cc: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Jun 2005 15:29:43 +0200, Andi Kleen wrote:
>> @@ -113,9 +113,18 @@ quiet_ni_syscall:
>>  	PTREGSCALL stub32_fork, sys32_fork
>>  	PTREGSCALL stub32_clone, sys32_clone
>>  	PTREGSCALL stub32_vfork, sys32_vfork
>> -	PTREGSCALL stub32_iopl, sys_iopl
>>  	PTREGSCALL stub32_rt_sigsuspend, sys_rt_sigsuspend
>>  
>> +	.macro PTREGSCALL3 label, func, arg
>
>PTREGSCALL3? I'm sure that is not in 2.6. How about just changing
>PTREGSCALL globally? 
>
>iirc the other ptregs syscalls were safe, but I still changed them in 2.6
>to use a pointer argument.

This patch changes all PTREGSCALLs to follow the 2.6 convention.
Unfortunately this is a much larger patch than the one that just
fixes sys_iopl(). I've triple-checked the register numbers passed
to the PTREGSCALL macro, and things do seem to work correctly.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 arch/x86_64/ia32/ia32_signal.c |   28 ++++++++++++++--------------
 arch/x86_64/ia32/ia32entry.S   |   23 ++++++++++++-----------
 arch/x86_64/ia32/sys_ia32.c    |   18 +++++++++---------
 arch/x86_64/kernel/entry.S     |   16 +++++++++-------
 arch/x86_64/kernel/ioport.c    |    6 +++---
 arch/x86_64/kernel/process.c   |   14 +++++++-------
 arch/x86_64/kernel/signal.c    |   24 ++++++++++++------------
 7 files changed, 66 insertions(+), 63 deletions(-)

diff -rupN linux-2.4.31/arch/x86_64/ia32/ia32_signal.c linux-2.4.31.gcc4-ptregscall-changes/arch/x86_64/ia32/ia32_signal.c
--- linux-2.4.31/arch/x86_64/ia32/ia32_signal.c	2003-11-29 00:28:11.000000000 +0100
+++ linux-2.4.31.gcc4-ptregscall-changes/arch/x86_64/ia32/ia32_signal.c	2005-06-12 17:55:52.000000000 +0200
@@ -89,7 +89,7 @@ static int ia32_copy_siginfo_to_user(sig
 }
 
 asmlinkage long
-sys32_sigsuspend(int history0, int history1, old_sigset_t mask, struct pt_regs regs)
+sys32_sigsuspend(int history0, int history1, old_sigset_t mask, struct pt_regs *regs)
 {
 	sigset_t saveset;
 
@@ -100,18 +100,18 @@ sys32_sigsuspend(int history0, int histo
 	recalc_sigpending(current);
 	spin_unlock_irq(&current->sigmask_lock);
 
-	regs.rax = -EINTR;
+	regs->rax = -EINTR;
 	while (1) {
 		current->state = TASK_INTERRUPTIBLE;
 		schedule();
-		if (do_signal(&regs, &saveset))
+		if (do_signal(regs, &saveset))
 			return -EINTR;
 	}
 }
 
 asmlinkage long
 sys32_sigaltstack(const stack_ia32_t *uss_ptr, stack_ia32_t *uoss_ptr, 
-				  struct pt_regs regs)
+				  struct pt_regs *regs)
 {
 	stack_t uss,uoss; 
 	int ret;
@@ -128,7 +128,7 @@ sys32_sigaltstack(const stack_ia32_t *us
 	}
 	seg = get_fs(); 
 	set_fs(KERNEL_DS); 
-	ret = do_sigaltstack(uss_ptr ? &uss : NULL, &uoss, regs.rsp);
+	ret = do_sigaltstack(uss_ptr ? &uss : NULL, &uoss, regs->rsp);
 	set_fs(seg); 
 	if (ret >= 0 && uoss_ptr)  {
 		if (!access_ok(VERIFY_WRITE,uoss_ptr,sizeof(stack_ia32_t)) ||
@@ -241,9 +241,9 @@ ia32_restore_sigcontext(struct pt_regs *
 	return err;
 }
 
-asmlinkage long sys32_sigreturn(struct pt_regs regs)
+asmlinkage long sys32_sigreturn(struct pt_regs *regs)
 {
-	struct sigframe *frame = (struct sigframe *)(regs.rsp - 8);
+	struct sigframe *frame = (struct sigframe *)(regs->rsp - 8);
 	sigset_t set;
 	unsigned int eax;
 
@@ -261,18 +261,18 @@ asmlinkage long sys32_sigreturn(struct p
 	recalc_sigpending(current);
 	spin_unlock_irq(&current->sigmask_lock);
 	
-	if (ia32_restore_sigcontext(&regs, &frame->sc, &eax))
+	if (ia32_restore_sigcontext(regs, &frame->sc, &eax))
 		goto badframe;
 	return eax;
 
 badframe:
-	signal_fault(&regs,frame,"32bit sigreturn");
+	signal_fault(regs,frame,"32bit sigreturn");
 	return 0;
 }	
 
-asmlinkage long sys32_rt_sigreturn(struct pt_regs regs)
+asmlinkage long sys32_rt_sigreturn(struct pt_regs *regs)
 {
-	struct rt_sigframe *frame = (struct rt_sigframe *)(regs.rsp - 4);
+	struct rt_sigframe *frame = (struct rt_sigframe *)(regs->rsp - 4);
 	sigset_t set;
 	stack_t st;
 	unsigned int eax;
@@ -288,7 +288,7 @@ asmlinkage long sys32_rt_sigreturn(struc
 	recalc_sigpending(current);
 	spin_unlock_irq(&current->sigmask_lock);
 	
-	if (ia32_restore_sigcontext(&regs, &frame->uc.uc_mcontext, &eax))
+	if (ia32_restore_sigcontext(regs, &frame->uc.uc_mcontext, &eax))
 		goto badframe;
 
 	if (__copy_from_user(&st, &frame->uc.uc_stack, sizeof(st)))
@@ -298,14 +298,14 @@ asmlinkage long sys32_rt_sigreturn(struc
 	{
 		mm_segment_t oldds = get_fs(); 
 		set_fs(KERNEL_DS); 
-		do_sigaltstack(&st, NULL, regs.rsp);
+		do_sigaltstack(&st, NULL, regs->rsp);
 		set_fs(oldds);  
 	}
 
 	return eax;
 
 badframe:
-	signal_fault(&regs,frame,"32bit rt sigreturn");
+	signal_fault(regs,frame,"32bit rt sigreturn");
 	return 0;
 }	
 
diff -rupN linux-2.4.31/arch/x86_64/ia32/ia32entry.S linux-2.4.31.gcc4-ptregscall-changes/arch/x86_64/ia32/ia32entry.S
--- linux-2.4.31/arch/x86_64/ia32/ia32entry.S	2005-01-19 18:00:53.000000000 +0100
+++ linux-2.4.31.gcc4-ptregscall-changes/arch/x86_64/ia32/ia32entry.S	2005-06-12 17:55:52.000000000 +0200
@@ -98,23 +98,24 @@ quiet_ni_syscall:
 	movl $-ENOSYS,%eax
 	ret	
 	
-	.macro PTREGSCALL label, func
+	.macro PTREGSCALL label, func, arg
 	.globl \label
 \label:
 	leaq \func(%rip),%rax
+	leaq -ARGOFFSET+8(%rsp),\arg	/* 8 for return address */
 	jmp  ia32_ptregs_common	
 	.endm
 
-	PTREGSCALL stub32_rt_sigreturn, sys32_rt_sigreturn
-	PTREGSCALL stub32_sigreturn, sys32_sigreturn
-	PTREGSCALL stub32_sigaltstack, sys32_sigaltstack
-	PTREGSCALL stub32_sigsuspend, sys32_sigsuspend
-	PTREGSCALL stub32_execve, sys32_execve
-	PTREGSCALL stub32_fork, sys32_fork
-	PTREGSCALL stub32_clone, sys32_clone
-	PTREGSCALL stub32_vfork, sys32_vfork
-	PTREGSCALL stub32_iopl, sys_iopl
-	PTREGSCALL stub32_rt_sigsuspend, sys_rt_sigsuspend
+	PTREGSCALL stub32_rt_sigreturn, sys32_rt_sigreturn, %rdi
+	PTREGSCALL stub32_sigreturn, sys32_sigreturn, %rdi
+	PTREGSCALL stub32_sigaltstack, sys32_sigaltstack, %rdx
+	PTREGSCALL stub32_sigsuspend, sys32_sigsuspend, %rcx
+	PTREGSCALL stub32_execve, sys32_execve, %rcx
+	PTREGSCALL stub32_fork, sys32_fork, %rdi
+	PTREGSCALL stub32_clone, sys32_clone, %rdx
+	PTREGSCALL stub32_vfork, sys32_vfork, %rdi
+	PTREGSCALL stub32_iopl, sys_iopl, %rsi
+	PTREGSCALL stub32_rt_sigsuspend, sys_rt_sigsuspend, %rdx
 
 ENTRY(ia32_ptregs_common)
 	popq %r11
diff -rupN linux-2.4.31/arch/x86_64/ia32/sys_ia32.c linux-2.4.31.gcc4-ptregscall-changes/arch/x86_64/ia32/sys_ia32.c
--- linux-2.4.31/arch/x86_64/ia32/sys_ia32.c	2005-01-19 18:00:53.000000000 +0100
+++ linux-2.4.31.gcc4-ptregscall-changes/arch/x86_64/ia32/sys_ia32.c	2005-06-12 17:55:52.000000000 +0200
@@ -2222,7 +2222,7 @@ static int nargs(u32 src, char **dst) 
 	return cnt; 
 } 
 
-asmlinkage long sys32_execve(char *name, u32 argv, u32 envp, struct pt_regs regs)
+asmlinkage long sys32_execve(char *name, u32 argv, u32 envp, struct pt_regs *regs)
 { 
 	mm_segment_t oldseg; 
 	char **buf = NULL; 
@@ -2270,7 +2270,7 @@ asmlinkage long sys32_execve(char *name,
 
 	oldseg = get_fs(); 
 	set_fs(KERNEL_DS);
-	ret = do_execve(name, argv ? buf : NULL, envp ? buf+na : NULL, &regs);  
+	ret = do_execve(name, argv ? buf : NULL, envp ? buf+na : NULL, regs);  
 	set_fs(oldseg); 
 
 	if (ret == 0)
@@ -2288,16 +2288,16 @@ free:
 	return ret; 
 } 
 
-asmlinkage long sys32_fork(struct pt_regs regs)
+asmlinkage long sys32_fork(struct pt_regs *regs)
 {
-	return do_fork(SIGCHLD, regs.rsp, &regs, 0);
+	return do_fork(SIGCHLD, regs->rsp, regs, 0);
 }
 
-asmlinkage long sys32_clone(unsigned int clone_flags, unsigned int newsp, struct pt_regs regs)
+asmlinkage long sys32_clone(unsigned int clone_flags, unsigned int newsp, struct pt_regs *regs)
 {
 	if (!newsp)
-		newsp = regs.rsp;
-	return do_fork(clone_flags, newsp, &regs, 0);
+		newsp = regs->rsp;
+	return do_fork(clone_flags, newsp, regs, 0);
 }
 
 /*
@@ -2310,9 +2310,9 @@ asmlinkage long sys32_clone(unsigned int
  * do not have enough call-clobbered registers to hold all
  * the information you need.
  */
-asmlinkage long sys32_vfork(struct pt_regs regs)
+asmlinkage long sys32_vfork(struct pt_regs *regs)
 {
-	return do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, regs.rsp, &regs, 0);
+	return do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, regs->rsp, regs, 0);
 }
 
 /*
diff -rupN linux-2.4.31/arch/x86_64/kernel/entry.S linux-2.4.31.gcc4-ptregscall-changes/arch/x86_64/kernel/entry.S
--- linux-2.4.31/arch/x86_64/kernel/entry.S	2003-11-29 00:28:11.000000000 +0100
+++ linux-2.4.31.gcc4-ptregscall-changes/arch/x86_64/kernel/entry.S	2005-06-12 17:55:52.000000000 +0200
@@ -237,19 +237,20 @@ intret_signal_test:		
  * Certain special system calls that need to save a complete stack frame.
  */ 								
 	
-	.macro PTREGSCALL label,func
+	.macro PTREGSCALL label,func,arg
 	.globl \label
 \label:
 	leaq	\func(%rip),%rax
+	leaq    -ARGOFFSET+8(%rsp),\arg /* 8 for return address */
 	jmp	ptregscall_common
 	.endm
 
-	PTREGSCALL stub_clone, sys_clone
-	PTREGSCALL stub_fork, sys_fork
-	PTREGSCALL stub_vfork, sys_vfork
-	PTREGSCALL stub_rt_sigsuspend, sys_rt_sigsuspend
-	PTREGSCALL stub_sigaltstack, sys_sigaltstack
-	PTREGSCALL stub_iopl, sys_iopl
+	PTREGSCALL stub_clone, sys_clone, %rdx /* not %r8 as it is in 2.6 */
+	PTREGSCALL stub_fork, sys_fork, %rdi
+	PTREGSCALL stub_vfork, sys_vfork, %rdi
+	PTREGSCALL stub_rt_sigsuspend, sys_rt_sigsuspend, %rdx
+	PTREGSCALL stub_sigaltstack, sys_sigaltstack, %rdx
+	PTREGSCALL stub_iopl, sys_iopl, %rsi
 
 ENTRY(ptregscall_common)
 	popq %r11
@@ -290,6 +291,7 @@ exec_32bit:
 ENTRY(stub_rt_sigreturn)
 	addq $8, %rsp		
 	SAVE_REST
+	movq %rsp,%rdi
 	FIXUP_TOP_OF_STACK %r11
 	call sys_rt_sigreturn
 	movq %rax,RAX(%rsp) # fixme, this could be done at the higher layer
diff -rupN linux-2.4.31/arch/x86_64/kernel/ioport.c linux-2.4.31.gcc4-ptregscall-changes/arch/x86_64/kernel/ioport.c
--- linux-2.4.31/arch/x86_64/kernel/ioport.c	2003-11-29 00:28:11.000000000 +0100
+++ linux-2.4.31.gcc4-ptregscall-changes/arch/x86_64/kernel/ioport.c	2005-06-12 17:55:52.000000000 +0200
@@ -81,9 +81,9 @@ asmlinkage long sys_ioperm(unsigned long
  * code.
  */
 
-asmlinkage long sys_iopl(unsigned int level, struct pt_regs regs)
+asmlinkage long sys_iopl(unsigned int level, struct pt_regs *regs)
 {
-	unsigned int old = (regs.eflags >> 12) & 3;
+	unsigned int old = (regs->eflags >> 12) & 3;
 
 	if (level > 3)
 		return -EINVAL;
@@ -92,6 +92,6 @@ asmlinkage long sys_iopl(unsigned int le
 		if (!capable(CAP_SYS_RAWIO))
 			return -EPERM;
 	}
-	regs.eflags = (regs.eflags & 0xffffffffffffcfff) | (level << 12);
+	regs->eflags = (regs->eflags &~ 0x3000UL) | (level << 12);
 	return 0;
 }
diff -rupN linux-2.4.31/arch/x86_64/kernel/process.c linux-2.4.31.gcc4-ptregscall-changes/arch/x86_64/kernel/process.c
--- linux-2.4.31/arch/x86_64/kernel/process.c	2005-06-01 18:02:21.000000000 +0200
+++ linux-2.4.31.gcc4-ptregscall-changes/arch/x86_64/kernel/process.c	2005-06-12 17:55:52.000000000 +0200
@@ -700,16 +700,16 @@ void set_personality_64bit(void)
 	current->thread.flags = 0;
 }
 
-asmlinkage long sys_fork(struct pt_regs regs)
+asmlinkage long sys_fork(struct pt_regs *regs)
 {
-	return do_fork(SIGCHLD, regs.rsp, &regs, 0);
+	return do_fork(SIGCHLD, regs->rsp, regs, 0);
 }
 
-asmlinkage long sys_clone(unsigned long clone_flags, unsigned long newsp, struct pt_regs regs)
+asmlinkage long sys_clone(unsigned long clone_flags, unsigned long newsp, struct pt_regs *regs)
 {
 	if (!newsp)
-		newsp = regs.rsp;
-	return do_fork(clone_flags, newsp, &regs, 0);
+		newsp = regs->rsp;
+	return do_fork(clone_flags, newsp, regs, 0);
 }
 
 /*
@@ -722,9 +722,9 @@ asmlinkage long sys_clone(unsigned long 
  * do not have enough call-clobbered registers to hold all
  * the information you need.
  */
-asmlinkage long sys_vfork(struct pt_regs regs)
+asmlinkage long sys_vfork(struct pt_regs *regs)
 {
-	return do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, regs.rsp, &regs, 0);
+	return do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, regs->rsp, regs, 0);
 }
 
 /*
diff -rupN linux-2.4.31/arch/x86_64/kernel/signal.c linux-2.4.31.gcc4-ptregscall-changes/arch/x86_64/kernel/signal.c
--- linux-2.4.31/arch/x86_64/kernel/signal.c	2005-01-19 18:00:53.000000000 +0100
+++ linux-2.4.31.gcc4-ptregscall-changes/arch/x86_64/kernel/signal.c	2005-06-12 17:55:52.000000000 +0200
@@ -82,7 +82,7 @@ int copy_siginfo_to_user(siginfo_t *to, 
 }
 
 asmlinkage long
-sys_rt_sigsuspend(sigset_t *unewset, size_t sigsetsize, struct pt_regs regs)
+sys_rt_sigsuspend(sigset_t *unewset, size_t sigsetsize, struct pt_regs *regs)
 {
 	sigset_t saveset, newset;
 
@@ -101,21 +101,21 @@ sys_rt_sigsuspend(sigset_t *unewset, siz
 	spin_unlock_irq(&current->sigmask_lock);
 #if DEBUG_SIG
 	printk("rt_sigsuspend savset(%lx) newset(%lx) regs(%p) rip(%lx)\n",
-		saveset, newset, &regs, regs.rip);
+		saveset, newset, regs, regs->rip);
 #endif 
-	regs.rax = -EINTR;
+	regs->rax = -EINTR;
 	while (1) {
 		current->state = TASK_INTERRUPTIBLE;
 		schedule();
-		if (do_signal(&regs, &saveset))
+		if (do_signal(regs, &saveset))
 			return -EINTR;
 	}
 }
 
 asmlinkage long
-sys_sigaltstack(const stack_t *uss, stack_t *uoss, struct pt_regs regs)
+sys_sigaltstack(const stack_t *uss, stack_t *uoss, struct pt_regs *regs)
 {
-	return do_sigaltstack(uss, uoss, regs.rsp);
+	return do_sigaltstack(uss, uoss, regs->rsp);
 }
 
 
@@ -180,9 +180,9 @@ restore_sigcontext(struct pt_regs *regs,
 }
 #undef COPY
 
-asmlinkage long sys_rt_sigreturn(struct pt_regs regs)
+asmlinkage long sys_rt_sigreturn(struct pt_regs *regs)
 {
-	struct rt_sigframe *frame = (struct rt_sigframe *)(regs.rsp - 8);
+	struct rt_sigframe *frame = (struct rt_sigframe *)(regs->rsp - 8);
 	sigset_t set;
 	stack_t st;
 	long eax;
@@ -198,23 +198,23 @@ asmlinkage long sys_rt_sigreturn(struct 
 	recalc_sigpending(current);
 	spin_unlock_irq(&current->sigmask_lock);
 	
-	if (restore_sigcontext(&regs, &frame->uc.uc_mcontext, &eax))
+	if (restore_sigcontext(regs, &frame->uc.uc_mcontext, &eax))
 		goto badframe;
 
 #if DEBUG_SIG
-	printk("%d sigreturn rip:%lx rsp:%lx frame:%p rax:%lx\n",current->pid,regs.rip,regs.rsp,frame,eax);
+	printk("%d sigreturn rip:%lx rsp:%lx frame:%p rax:%lx\n",current->pid,regs->rip,regs->rsp,frame,eax);
 #endif
 
 	if (__copy_from_user(&st, &frame->uc.uc_stack, sizeof(st)))
 		goto badframe;
 	/* It is more difficult to avoid calling this function than to
 	   call it and ignore errors.  */
-	do_sigaltstack(&st, NULL, regs.rsp);
+	do_sigaltstack(&st, NULL, regs->rsp);
 
 	return eax;
 
 badframe:
-	signal_fault(&regs, frame, "rt_sigreturn"); 
+	signal_fault(regs, frame, "rt_sigreturn"); 
 	return 0;
 }	
 
