Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264307AbUGLX6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264307AbUGLX6h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 19:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264297AbUGLX6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 19:58:37 -0400
Received: from mail2.speakeasy.net ([216.254.0.202]:49889 "EHLO
	mail2.speakeasy.net") by vger.kernel.org with ESMTP id S264307AbUGLX6d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 19:58:33 -0400
Date: Mon, 12 Jul 2004 16:58:26 -0700
Message-Id: <200407122358.i6CNwQ4Q001709@magilla.sf.frob.com>
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
X-Fcc: ~/Mail/linus
Cc: Ingo Molnar <mingo@redhat.com>, Jim Paradis <jparadis@redhat.com>,
       Andrew Cagney <cagney@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86-64 support for singlestep into 32-bit system calls
X-Shopping-List: (1) Dark mounds
   (2) Lustrous aristocratic nutrition
   (3) Savage benevolent chowder
   (4) Scrumptious compulsion compasses
   (5) Midget ambition holidays
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes x86-64's 32-bit support behave consistently with the
native i386 behavior achieved in Davide Libenzi's patch:

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm7/broken-out/really-ptrace-single-step-2.patch

I hope these both can go into 2.6.8 or 2.6.9, since they make life 
better for gdb.


Thanks,
Roland

Signed-off-by: Roland McGrath <roland@redhat.com>


Index: linux-2.6/arch/x86_64/kernel/entry.S
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/arch/x86_64/kernel/entry.S,v
retrieving revision 1.22
diff -b -p -u -r1.22 entry.S
--- linux-2.6/arch/x86_64/kernel/entry.S 12 Apr 2004 20:29:12 -0000 1.22
+++ linux-2.6/arch/x86_64/kernel/entry.S 12 Jul 2004 23:48:37 -0000
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
+++ linux-2.6/arch/x86_64/kernel/ptrace.c 12 Jul 2004 23:49:16 -0000
@@ -88,6 +88,9 @@ void ptrace_disable(struct task_struct *
 { 
 	long tmp;
 
+#ifdef CONFIG_IA32_EMULATION
+	clear_tsk_thread_flag(child, TIF_SINGLESTEP);
+#endif
 	tmp = get_stack_long(child, EFL_OFFSET) & ~TRAP_FLAG;
 	put_stack_long(child, EFL_OFFSET, tmp);
 }
@@ -344,6 +347,9 @@ asmlinkage long sys_ptrace(long request,
 			set_tsk_thread_flag(child,TIF_SYSCALL_TRACE);
 		else
 			clear_tsk_thread_flag(child,TIF_SYSCALL_TRACE);
+#ifdef CONFIG_IA32_EMULATION
+		clear_tsk_thread_flag(child, TIF_SINGLESTEP);
+#endif
 		child->exit_code = data;
 	/* make sure the single step bit is not set. */
 		tmp = get_stack_long(child, EFL_OFFSET);
@@ -395,6 +401,9 @@ asmlinkage long sys_ptrace(long request,
 		ret = 0;
 		if (child->state == TASK_ZOMBIE)	/* already dead */
 			break;
+#ifdef CONFIG_IA32_EMULATION
+		clear_tsk_thread_flag(child, TIF_SINGLESTEP);
+#endif
 		child->exit_code = SIGKILL;
 		/* make sure the single step bit is not set. */
 		tmp = get_stack_long(child, EFL_OFFSET) & ~TRAP_FLAG;
@@ -416,6 +425,10 @@ asmlinkage long sys_ptrace(long request,
 		}
 		tmp = get_stack_long(child, EFL_OFFSET) | TRAP_FLAG;
 		put_stack_long(child, EFL_OFFSET, tmp);
+#ifdef CONFIG_IA32_EMULATION
+		if (test_tsk_thread_flag(child, TIF_IA32))
+			set_tsk_thread_flag(child, TIF_SINGLESTEP);
+#endif
 		child->exit_code = data;
 		/* give it a chance to run. */
 		wake_up_process(child);
@@ -528,7 +541,10 @@ asmlinkage void syscall_trace_leave(stru
 	if (unlikely(current->audit_context))
 		audit_syscall_exit(current, regs->rax);
 
-	if (test_thread_flag(TIF_SYSCALL_TRACE)
-	    && (current->ptrace & PT_PTRACED))
+	if ((test_thread_flag(TIF_SYSCALL_TRACE)
+#ifdef CONFIG_IA32_EMULATION
+	     || test_thread_flag(TIF_SINGLESTEP)
+#endif
+		    ) && (current->ptrace & PT_PTRACED))
 		syscall_trace(regs);
 }
