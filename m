Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265398AbUF2ERK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265398AbUF2ERK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 00:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265399AbUF2ERK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 00:17:10 -0400
Received: from fw.osdl.org ([65.172.181.6]:59856 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265398AbUF2ERD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 00:17:03 -0400
Date: Mon, 28 Jun 2004 21:15:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: roland@redhat.com, mingo@redhat.com, cagney@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] x86 single-step (TF) vs system calls & traps
Message-Id: <20040628211559.73ded525.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0406282049350.28764@ppc970.osdl.org>
References: <200406290346.i5T3keo1022764@magilla.sf.frob.com>
	<Pine.LNX.4.58.0406282049350.28764@ppc970.osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
>  On Mon, 28 Jun 2004, Roland McGrath wrote:
>  >
>  > > And I refuse to make the fast-path slower just because of this. 
>  > 
>  > You are talking about the int $0x80 system call path here?
>  > That is the only non-exception path touched by my changes.
> 
>  That's still the fast path on any machine where this matters.

Davide's patch (which has been in -mm for 6-7 weeks) doesn't add
fastpath overhead.


diff -puN arch/i386/kernel/entry.S~really-ptrace-single-step-2 arch/i386/kernel/entry.S
--- 25/arch/i386/kernel/entry.S~really-ptrace-single-step-2	2004-06-24 13:19:51.721958784 -0700
+++ 25-akpm/arch/i386/kernel/entry.S	2004-06-24 13:19:51.728957720 -0700
@@ -375,7 +375,7 @@ syscall_trace_entry:
 	# perform syscall exit tracing
 	ALIGN
 syscall_exit_work:
-	testb $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT), %cl
+	testb $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SINGLESTEP), %cl
 	jz work_pending
 	sti				# could let do_syscall_trace() call
 					# schedule() instead
diff -puN arch/i386/kernel/ptrace.c~really-ptrace-single-step-2 arch/i386/kernel/ptrace.c
--- 25/arch/i386/kernel/ptrace.c~really-ptrace-single-step-2	2004-06-24 13:19:51.723958480 -0700
+++ 25-akpm/arch/i386/kernel/ptrace.c	2004-06-24 13:19:51.729957568 -0700
@@ -147,6 +147,7 @@ void ptrace_disable(struct task_struct *
 { 
 	long tmp;
 
+	clear_tsk_thread_flag(child, TIF_SINGLESTEP);
 	tmp = get_stack_long(child, EFL_OFFSET) & ~TRAP_FLAG;
 	put_stack_long(child, EFL_OFFSET, tmp);
 }
@@ -370,6 +371,7 @@ asmlinkage int sys_ptrace(long request, 
 		else {
 			clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		}
+		clear_tsk_thread_flag(child, TIF_SINGLESTEP);
 		child->exit_code = data;
 	/* make sure the single step bit is not set. */
 		tmp = get_stack_long(child, EFL_OFFSET) & ~TRAP_FLAG;
@@ -391,6 +393,7 @@ asmlinkage int sys_ptrace(long request, 
 		if (child->state == TASK_ZOMBIE)	/* already dead */
 			break;
 		child->exit_code = SIGKILL;
+		clear_tsk_thread_flag(child, TIF_SINGLESTEP);
 		/* make sure the single step bit is not set. */
 		tmp = get_stack_long(child, EFL_OFFSET) & ~TRAP_FLAG;
 		put_stack_long(child, EFL_OFFSET, tmp);
@@ -411,6 +414,7 @@ asmlinkage int sys_ptrace(long request, 
 		}
 		tmp = get_stack_long(child, EFL_OFFSET) | TRAP_FLAG;
 		put_stack_long(child, EFL_OFFSET, tmp);
+		set_tsk_thread_flag(child, TIF_SINGLESTEP);
 		child->exit_code = data;
 		/* give it a chance to run. */
 		wake_up_process(child);
@@ -535,7 +539,8 @@ void do_syscall_trace(struct pt_regs *re
 			audit_syscall_exit(current, regs->eax);
 	}
 
-	if (!test_thread_flag(TIF_SYSCALL_TRACE))
+	if (!test_thread_flag(TIF_SYSCALL_TRACE) &&
+	    !test_thread_flag(TIF_SINGLESTEP))
 		return;
 	if (!(current->ptrace & PT_PTRACED))
 		return;
diff -puN include/asm-i386/thread_info.h~really-ptrace-single-step-2 include/asm-i386/thread_info.h
--- 25/include/asm-i386/thread_info.h~really-ptrace-single-step-2	2004-06-24 13:19:51.724958328 -0700
+++ 25-akpm/include/asm-i386/thread_info.h	2004-06-24 13:19:51.729957568 -0700
@@ -157,7 +157,7 @@ static inline unsigned long current_stac
 
 /* work to do on interrupt/exception return */
 #define _TIF_WORK_MASK \
-  (0x0000FFFF & ~(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT))
+  (0x0000FFFF & ~(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SINGLESTEP))
 #define _TIF_ALLWORK_MASK	0x0000FFFF	/* work to do on any return to u-space */
 
 /*
_

