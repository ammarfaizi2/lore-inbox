Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266676AbUGVCRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266676AbUGVCRJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 22:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266678AbUGVCRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 22:17:08 -0400
Received: from mail4.speakeasy.net ([216.254.0.204]:9953 "EHLO
	mail4.speakeasy.net") by vger.kernel.org with ESMTP id S266676AbUGVCQ7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 22:16:59 -0400
Date: Wed, 21 Jul 2004 19:16:52 -0700
Message-Id: <200407220216.i6M2GqEv007394@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andi Kleen <ak@muc.de>
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] x86-64 singlestep through sigreturn system call
In-Reply-To: Andi Kleen's message of  Saturday, 17 July 2004 13:12:50 +0200 <m3eknaj39p.fsf@averell.firstfloor.org>
X-Windows: it could happen to you.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmm, but now the behaviour for 32bit processes is different from the
> native 32bit kernel, since 32bit didn't apply any patch so far AFAIK.

Well, I was (and am) advocating that Davide's patch for native 32-bit be
applied as well.  If it is, then my last x86-64 patch covers both 32-bit
and 64-bit cases with minimal cruft.  In particular, 2.6.8-rc1-mm1 contains
Davide's patch and both of my earlier x86-64 patches.  I hope Andrew will
replace those two patches with the later cleaner single x86-64 patch.  If
Linus merges that patch of mine and Davide's i386 patch, I will be a happy
camper.

> If you send me a patch that just changes the behaviour of 64bit 
> IRET I would apply it.

Ok.  This is just one line different from the patch I just posted.  In
32-bit processes, some ptrace operations will superfluously clear a flag
bit that can never be set, rather than test another flag bit to branch
around doing it.  If/when the native 32-bit behavior fix gets merged in and
you want to match it, just remove `if (!test_tsk_thread_flag(child, TIF_IA32))'
(which is the same as reverting this patch and applying the earlier one).


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
Index: linux-2.6/ptrace.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/arch/x86_64/kernel/ptrace.c,v
retrieving revision 1.16
diff -u -b -p -r1.16 ptrace.c
--- linux-2.6/ptrace.c 31 May 2004 03:07:42 -0000 1.16
+++ linux-2.6/ptrace.c 22 Jul 2004 00:42:06 -0000
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
@@ -416,6 +419,8 @@ asmlinkage long sys_ptrace(long request,
 		}
 		tmp = get_stack_long(child, EFL_OFFSET) | TRAP_FLAG;
 		put_stack_long(child, EFL_OFFSET, tmp);
+		if (!test_tsk_thread_flag(child, TIF_IA32))
+			set_tsk_thread_flag(child, TIF_SINGLESTEP);
 		child->exit_code = data;
 		/* give it a chance to run. */
 		wake_up_process(child);
@@ -528,7 +533,8 @@ asmlinkage void syscall_trace_leave(stru
 	if (unlikely(current->audit_context))
 		audit_syscall_exit(current, regs->rax);
 
-	if (test_thread_flag(TIF_SYSCALL_TRACE)
+	if ((test_thread_flag(TIF_SYSCALL_TRACE)
+	     || test_thread_flag(TIF_SINGLESTEP))
 	    && (current->ptrace & PT_PTRACED))
 		syscall_trace(regs);
 }
