Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267352AbUGVW7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267352AbUGVW7x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 18:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266697AbUGVW7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 18:59:53 -0400
Received: from mail2.speakeasy.net ([216.254.0.202]:13963 "EHLO
	mail2.speakeasy.net") by vger.kernel.org with ESMTP id S267352AbUGVW6s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 18:58:48 -0400
Date: Thu, 22 Jul 2004 15:58:43 -0700
Message-Id: <200407222258.i6MMwhVj003472@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@osdl.org>
X-Fcc: ~/Mail/linus
Cc: ak@muc.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86-64 singlestep through sigreturn system call
In-Reply-To: Andrew Morton's message of  Wednesday, 21 July 2004 23:11:28 -0700 <20040721231128.6b495d94.akpm@osdl.org>
X-Zippy-Says: If I had a Q-TIP, I could prevent th'collapse of NEGOTIATIONS!!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Am now all confused.  Please tell me which patches to drop, and ensure that
> I have the replacement patches, if any.  Thanks.

Please drop these two:

	x86-64-singlestep-through-sigreturn-system-call.patch
	x86-64-support-for-singlestep-into-32-bit-system-calls.patch 

and replace them with the following patch, which I first posted last week.
With this, x86-64's behavior for ia32 matches the native i386 behavior
given really-ptrace-single-step-2.patch, and x86-64's native behavior is
similarly improved.  The two patches above together do the same as this one
alone, but this one is cleaner.


Thanks,
Roland


Index: linux-2.6/arch/x86_64/kernel/entry.S
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/arch/x86_64/kernel/entry.S,v
retrieving revision 1.22
diff -b -p -u -r1.22 entry.S
--- linux-2.6/arch/x86_64/kernel/entry.S 12 Apr 2004 20:29:12 -0000 1.22
+++ linux-2.6/arch/x86_64/kernel/entry.S 15 Jul 2004 23:45:59 -0000
@@ -297,7 +297,7 @@ int_very_careful:
 	sti
 	SAVE_REST
 	/* Check for syscall exit trace */	
-	testl $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT),%edx
+	testl $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SINGLESTEP),%edx
 	jz int_signal
 	pushq %rdi
 	leaq 8(%rsp),%rdi	# &ptregs -> arg1	
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
