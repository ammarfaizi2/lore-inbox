Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266458AbUGOX6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266458AbUGOX6e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 19:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266460AbUGOX6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 19:58:34 -0400
Received: from mail1.speakeasy.net ([216.254.0.201]:59305 "EHLO
	mail1.speakeasy.net") by vger.kernel.org with ESMTP id S266458AbUGOX6H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 19:58:07 -0400
Date: Thu, 15 Jul 2004 16:57:59 -0700
Message-Id: <200407152357.i6FNvxiu020873@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andi Kleen <ak@suse.de>
X-Fcc: ~/Mail/linus
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       jparadis@redhat.com, cagney@redhat.com, discuss@x86-64.org
Subject: Re: [PATCH] x86-64 singlestep through sigreturn system call
In-Reply-To: Andi Kleen's message of  Friday, 16 July 2004 00:06:18 +0200 <20040716000618.0441d268.ak@suse.de>
X-Shopping-List: (1) Cataclysmic chocolate
   (2) Reluctant commendations
   (3) Atlantic L'eggs
   (4) Naugahyde Pencil porno
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Anyways, even if I applied your patch there would be still inconsistency
> because there are several other system calls that use IRET. So I don't
> see much advantage in adding a special case just for sigreturn.

Now that I see that the difference is due to iret being used, I have a
different solution that handles all cases.  The following patch replaces
both my previous patch for x86-64 native behavior and my patch for x86-64's
ia32 support.  This patch just directly clones Davide Libenzi's i386 code
for x86-64 in both 64-bit and 32-bit cases.  With this, the behavior of
single-stepping all system calls is consistent.  

The syscall exit tracing caused by TIF_SINGLESTEP is superfluous in the
case of sysret returns, but harmlessly so (since continuing afterward with
PTRACE_CONT will have cleared TF as well as TIF_SINGLESTEP).  I figured
that little bit of extra processing in the single-step case was better than
adding code to ignore the flag in the sysret case.



Thanks,
Roland


Signed-off-by: Roland McGrath <roland@redhat.com>


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
