Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267405AbUHJCtc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267405AbUHJCtc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 22:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267406AbUHJCtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 22:49:32 -0400
Received: from mail5.speakeasy.net ([216.254.0.205]:64187 "EHLO
	mail5.speakeasy.net") by vger.kernel.org with ESMTP id S267405AbUHJCtT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 22:49:19 -0400
Date: Mon, 9 Aug 2004 19:49:15 -0700
Message-Id: <200408100249.i7A2nFjg020384@magilla.sf.frob.com>
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 
X-Fcc: ~/Mail/linus
X-Antipastobozoticataclysm: When George Bush projectile vomits antipasto on the Japanese.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This replaces x86-64-singlestep-through-sigreturn-system-call-2.patch
from 2.6.8-rc2-mm2.  The second addition in entry.S is the difference.
This fixes a problem where additional singlesteps immediately after the
singlestep stop after sigreturn would not work right.

Note you might want to rename the patch, since this also has the effect of
making single-stepping of IA32 syscalls work right.


Thanks,
Roland


Signed-off-by: Roland McGrath <roland@redhat.com>

Index: linux-2.6/arch/x86_64/kernel/entry.S
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/arch/x86_64/kernel/entry.S,v
retrieving revision 1.22
diff -b -p -u -r1.22 entry.S
--- linux-2.6/arch/x86_64/kernel/entry.S 12 Apr 2004 20:29:12 -0000 1.22
+++ linux-2.6/arch/x86_64/kernel/entry.S 10 Aug 2004 02:34:01 -0000
@@ -297,7 +297,7 @@ int_very_careful:
 	sti
 	SAVE_REST
 	/* Check for syscall exit trace */	
-	testl $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT),%edx
+	testl $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SINGLESTEP),%edx
 	jz int_signal
 	pushq %rdi
 	leaq 8(%rsp),%rdi	# &ptregs -> arg1	
@@ -305,6 +305,7 @@ int_very_careful:
 	popq %rdi
 	btr  $TIF_SYSCALL_TRACE,%edi
 	btr  $TIF_SYSCALL_AUDIT,%edi
+	btr  $TIF_SINGLESTEP,%edi
 	jmp int_restore_rest
 	
 int_signal:
Index: linux-2.6/arch/x86_64/kernel/ptrace.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/arch/x86_64/kernel/ptrace.c,v
retrieving revision 1.16
diff -b -p -u -r1.16 ptrace.c
--- linux-2.6/arch/x86_64/kernel/ptrace.c 31 May 2004 03:07:42 -0000 1.16
+++ linux-2.6/arch/x86_64/kernel/ptrace.c 15 Jul 2004 23:56:44 -0000
@@ -88,6 +88,7 @@ void ptrace_disable(struct task_struct *
 { 
 	long tmp;
 
+	clear_tsk_thread_flag(child, TIF_SINGLESTEP);
 	tmp = get_stack_long(child, EFL_OFFSET) & ~TRAP_FLAG;
 	put_stack_long(child, EFL_OFFSET, tmp);
 }
@@ -344,6 +345,7 @@ asmlinkage long sys_ptrace(long request,
 			set_tsk_thread_flag(child,TIF_SYSCALL_TRACE);
 		else
 			clear_tsk_thread_flag(child,TIF_SYSCALL_TRACE);
+		clear_tsk_thread_flag(child, TIF_SINGLESTEP);
 		child->exit_code = data;
 	/* make sure the single step bit is not set. */
 		tmp = get_stack_long(child, EFL_OFFSET);
@@ -395,6 +397,7 @@ asmlinkage long sys_ptrace(long request,
 		ret = 0;
 		if (child->state == TASK_ZOMBIE)	/* already dead */
 			break;
+		clear_tsk_thread_flag(child, TIF_SINGLESTEP);
 		child->exit_code = SIGKILL;
 		/* make sure the single step bit is not set. */
 		tmp = get_stack_long(child, EFL_OFFSET) & ~TRAP_FLAG;
@@ -416,6 +419,7 @@ asmlinkage long sys_ptrace(long request,
 		}
 		tmp = get_stack_long(child, EFL_OFFSET) | TRAP_FLAG;
 		put_stack_long(child, EFL_OFFSET, tmp);
+		set_tsk_thread_flag(child, TIF_SINGLESTEP);
 		child->exit_code = data;
 		/* give it a chance to run. */
 		wake_up_process(child);
@@ -528,7 +532,8 @@ asmlinkage void syscall_trace_leave(stru
 	if (unlikely(current->audit_context))
 		audit_syscall_exit(current, regs->rax);
 
-	if (test_thread_flag(TIF_SYSCALL_TRACE)
+	if ((test_thread_flag(TIF_SYSCALL_TRACE)
+	     || test_thread_flag(TIF_SINGLESTEP))
 	    && (current->ptrace & PT_PTRACED))
 		syscall_trace(regs);
 }
