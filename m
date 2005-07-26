Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261294AbVG0P6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbVG0P6O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 11:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262405AbVG0Py4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 11:54:56 -0400
Received: from [151.97.230.9] ([151.97.230.9]:20098 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S262433AbVG0PxJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 11:53:09 -0400
Subject: [patch 1/4] UML Support - Ptrace: adds the host SYSEMU support, for UML and general usage
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it,
       LaurentVivier@wanadoo.fr, blaisorblade_spam@yahoo.it,
       bstroesser@fujitsu-siemens.com
From: blaisorblade@yahoo.it
Date: Tue, 26 Jul 2005 20:43:46 +0200
Message-Id: <20050726184346.E7C9121DC1A@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Laurent Vivier <LaurentVivier@wanadoo.fr>,
Jeff Dike <jdike@addtoit.com>,
Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>,
Bodo Stroesser <bstroesser@fujitsu-siemens.com>

Adds a new ptrace(2) mode, called PTRACE_SYSEMU, resembling PTRACE_SYSCALL
except that the kernel does not execute the requested syscall; this is useful
to improve performance for virtual environments, like UML, which want to run
the syscall on their own.

In fact, using PTRACE_SYSCALL means stopping child execution twice, on entry
and on exit, and each time you also have two context switches; with SYSEMU you
avoid the 2nd stop and so save two context switches per syscall.

Also, some architectures don't have support in the host for changing the
syscall number via ptrace(), which is currently needed to skip syscall
execution (UML turns any syscall into getpid() to avoid it being executed on
the host). Fixing that is hard, while SYSEMU is easier to implement.

* This version of the patch includes some suggestions of Jeff Dike to avoid
  adding any instructions to the syscall fast path, plus some other little
  changes, by myself, to make it work even when the syscall is executed with
  SYSENTER (but I'm unsure about them). It has been widely tested for quite a
  lot of time.

* Various fixed were included to handle the various switches between
  various states, i.e. when for instance a syscall entry is traced with one of
  PT_SYSCALL / _SYSEMU / _SINGLESTEP and another one is used on exit.
  Basically, this is done by remembering which one of them was used even after
  the call to ptrace_notify().

* We're combining TIF_SYSCALL_EMU with TIF_SYSCALL_TRACE or TIF_SINGLESTEP
  to make do_syscall_trace() notice that the current syscall was started with
  SYSEMU on entry, so that no notification ought to be done in the exit path;
  this is a bit of a hack, so this problem is solved in another way in next
  patches.

* Also, the effects of the patch:
"Ptrace - i386: fix Syscall Audit interaction with singlestep"
are cancelled; they are restored back in the last patch of this series.

Detailed descriptions of the patches doing this kind of processing follow (but
I've already summed everything up).

* Fix behaviour when changing interception kind #1.

In do_syscall_trace(), we check the status of the TIF_SYSCALL_EMU flag only
after doing the debugger notification; but the debugger might have changed the
status of this flag because he continued execution with PTRACE_SYSCALL, so
this is wrong. This patch fixes it by saving the flag status before calling
ptrace_notify().

* Fix behaviour when changing interception kind #2:
  avoid intercepting syscall on return when using SYSCALL again.

A guest process switching from using PTRACE_SYSEMU to PTRACE_SYSCALL crashes.

The problem is in arch/i386/kernel/entry.S. The current SYSEMU patch inhibits
the syscall-handler to be called, but does not prevent do_syscall_trace() to
be called after this for syscall completion interception.

The appended patch fixes this. It reuses the flag TIF_SYSCALL_EMU to remember
"we come from PTRACE_SYSEMU and now are in PTRACE_SYSCALL", since the flag is
unused in the depicted situation.

* Fix behaviour when changing interception kind #3:
  avoid intercepting syscall on return when using SINGLESTEP.

When testing 2.6.9 and the skas3.v6 patch, with my latest
patch and had problems with singlestepping on UML in SKAS with SYSEMU.
It looped receiving SIGTRAPs without moving forward. EIP of the traced
process was the same for all SIGTRAPs.

What's missing is to handle switching from PTRACE_SYSCALL_EMU to
PTRACE_SINGLESTEP in a way very similar to what is done for the change
from PTRACE_SYSCALL_EMU to PTRACE_SYSCALL_TRACE.

I.e., after calling ptrace(PTRACE_SYSEMU), on the return path, the debugger is
notified and then wake ups the process; the syscall is executed (or skipped,
when do_syscall_trace() returns 0, i.e. when using PTRACE_SYSEMU), and
do_syscall_trace() is called again. Since we are on the return path of a
SYSEMU'd syscall, if the wake up is performed through ptrace(PTRACE_SYSCALL),
we must still avoid notifying the parent of the syscall exit. Now, this
behaviour is extended even to resuming with PTRACE_SINGLESTEP.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/i386/kernel/entry.S       |    9 ++-
 linux-2.6.git-paolo/arch/i386/kernel/ptrace.c      |   57 ++++++++++++++-------
 linux-2.6.git-paolo/include/asm-i386/thread_info.h |    5 +
 linux-2.6.git-paolo/include/linux/ptrace.h         |    1 
 linux-2.6.git-paolo/kernel/fork.c                  |    3 +
 5 files changed, 53 insertions(+), 22 deletions(-)

diff -puN arch/i386/kernel/ptrace.c~host-sysemu arch/i386/kernel/ptrace.c
--- linux-2.6.git/arch/i386/kernel/ptrace.c~host-sysemu	2005-07-26 20:24:57.000000000 +0200
+++ linux-2.6.git-paolo/arch/i386/kernel/ptrace.c	2005-07-26 20:39:59.000000000 +0200
@@ -509,15 +509,27 @@ asmlinkage int sys_ptrace(long request, 
 		  }
 		  break;
 
+	case PTRACE_SYSEMU: /* continue and stop at next syscall, which will not be executed */
 	case PTRACE_SYSCALL:	/* continue and stop at next (return from) syscall */
 	case PTRACE_CONT:	/* restart after signal. */
 		ret = -EIO;
 		if (!valid_signal(data))
 			break;
+		/* If we came here with PTRACE_SYSEMU and now continue with
+		 * PTRACE_SYSCALL, entry.S used to intercept the syscall return.
+		 * But it shouldn't!
+		 * So we don't clear TIF_SYSCALL_EMU, which is always unused in
+		 * this special case, to remember, we came from SYSEMU. That
+		 * flag will be cleared by do_syscall_trace().
+		 */
+		if (request == PTRACE_SYSEMU) {
+			set_tsk_thread_flag(child, TIF_SYSCALL_EMU);
+		} else if (request == PTRACE_CONT) {
+			clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
+		}
 		if (request == PTRACE_SYSCALL) {
 			set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
-		}
-		else {
+		} else {
 			clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		}
 		child->exit_code = data;
@@ -546,6 +558,8 @@ asmlinkage int sys_ptrace(long request, 
 		ret = -EIO;
 		if (!valid_signal(data))
 			break;
+		/*See do_syscall_trace to know why we don't clear
+		 * TIF_SYSCALL_EMU.*/
 		clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		set_singlestep(child);
 		child->exit_code = data;
@@ -678,37 +692,43 @@ void send_sigtrap(struct task_struct *ts
  * - triggered by current->work.syscall_trace
  */
 __attribute__((regparm(3)))
-void do_syscall_trace(struct pt_regs *regs, int entryexit)
+int do_syscall_trace(struct pt_regs *regs, int entryexit)
 {
+	int is_sysemu, is_systrace, is_singlestep, ret = 0;
 	/* do the secure computing check first */
 	secure_computing(regs->orig_eax);
 
-	if (unlikely(current->audit_context)) {
-		if (entryexit)
-			audit_syscall_exit(current, AUDITSC_RESULT(regs->eax), regs->eax);
-
-		/* Debug traps, when using PTRACE_SINGLESTEP, must be sent only
-		 * on the syscall exit path. Normally, when TIF_SYSCALL_AUDIT is
-		 * not used, entry.S will call us only on syscall exit, not
-		 * entry ; so when TIF_SYSCALL_AUDIT is used we must avoid
-		 * calling send_sigtrap() on syscall entry.
-		 */
-		else if (is_singlestep)
-			goto out;
-	}
+	if (unlikely(current->audit_context) && entryexit)
+		audit_syscall_exit(current, AUDITSC_RESULT(regs->eax), regs->eax);
 
 	if (!(current->ptrace & PT_PTRACED))
 		goto out;
 
+	is_sysemu = test_thread_flag(TIF_SYSCALL_EMU);
+	is_systrace = test_thread_flag(TIF_SYSCALL_TRACE);
+	is_singlestep = test_thread_flag(TIF_SINGLESTEP);
+
+	/* We can detect the case of coming from PTRACE_SYSEMU and now running
+	 * with PTRACE_SYSCALL or PTRACE_SINGLESTEP, by TIF_SYSCALL_EMU being
+	 * set additionally.
+	 * If so let's reset the flag and return without action (no singlestep
+	 * nor syscall tracing, since no actual step has been executed).
+	 */
+	if (is_sysemu && (is_systrace || is_singlestep)) {
+		clear_thread_flag(TIF_SYSCALL_EMU);
+		goto out;
+	}
+
 	/* Fake a debug trap */
 	if (test_thread_flag(TIF_SINGLESTEP))
 		send_sigtrap(current, regs, 0);
 
-	if (!test_thread_flag(TIF_SYSCALL_TRACE))
+	if (!is_systrace && !is_sysemu)
 		goto out;
 
 	/* the 0x80 provides a way for the tracing parent to distinguish
 	   between a syscall stop and SIGTRAP delivery */
+	/* Note that the debugger could change the result of test_thread_flag!*/
 	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD) ? 0x80 : 0));
 
 	/*
@@ -720,9 +740,10 @@ void do_syscall_trace(struct pt_regs *re
 		send_sig(current->exit_code, current, 1);
 		current->exit_code = 0;
 	}
+	ret = is_sysemu;
  out:
 	if (unlikely(current->audit_context) && !entryexit)
 		audit_syscall_entry(current, AUDIT_ARCH_I386, regs->orig_eax,
 				    regs->ebx, regs->ecx, regs->edx, regs->esi);
-
+	return ret;
 }
diff -puN arch/i386/kernel/entry.S~host-sysemu arch/i386/kernel/entry.S
--- linux-2.6.git/arch/i386/kernel/entry.S~host-sysemu	2005-07-26 20:24:57.000000000 +0200
+++ linux-2.6.git-paolo/arch/i386/kernel/entry.S	2005-07-26 20:39:59.000000000 +0200
@@ -203,7 +203,7 @@ sysenter_past_esp:
 	GET_THREAD_INFO(%ebp)
 
 	/* Note, _TIF_SECCOMP is bit number 8, and so it needs testw and not testb */
-	testw $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SECCOMP),TI_flags(%ebp)
+	testw $(_TIF_SYSCALL_EMU|_TIF_SYSCALL_TRACE|_TIF_SECCOMP|_TIF_SYSCALL_AUDIT),TI_flags(%ebp)
 	jnz syscall_trace_entry
 	cmpl $(nr_syscalls), %eax
 	jae syscall_badsys
@@ -226,9 +226,9 @@ ENTRY(system_call)
 	pushl %eax			# save orig_eax
 	SAVE_ALL
 	GET_THREAD_INFO(%ebp)
-					# system call tracing in operation
+					# system call tracing in operation / emulation
 	/* Note, _TIF_SECCOMP is bit number 8, and so it needs testw and not testb */
-	testw $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SECCOMP),TI_flags(%ebp)
+	testw $(_TIF_SYSCALL_EMU|_TIF_SYSCALL_TRACE|_TIF_SECCOMP|_TIF_SYSCALL_AUDIT),TI_flags(%ebp)
 	jnz syscall_trace_entry
 	cmpl $(nr_syscalls), %eax
 	jae syscall_badsys
@@ -338,6 +338,9 @@ syscall_trace_entry:
 	movl %esp, %eax
 	xorl %edx,%edx
 	call do_syscall_trace
+	cmpl $0, %eax
+	jne syscall_exit		# ret != 0 -> running under PTRACE_SYSEMU,
+					# so must skip actual syscall
 	movl ORIG_EAX(%esp), %eax
 	cmpl $(nr_syscalls), %eax
 	jnae syscall_call
diff -puN include/asm-i386/thread_info.h~host-sysemu include/asm-i386/thread_info.h
--- linux-2.6.git/include/asm-i386/thread_info.h~host-sysemu	2005-07-26 20:24:57.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-i386/thread_info.h	2005-07-26 20:24:57.000000000 +0200
@@ -139,6 +139,7 @@ register unsigned long current_stack_poi
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_SINGLESTEP		4	/* restore singlestep on return to user mode */
 #define TIF_IRET		5	/* return with iret */
+#define TIF_SYSCALL_EMU		6	/* syscall emulation active */
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
 #define TIF_SECCOMP		8	/* secure computing */
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
@@ -150,13 +151,15 @@ register unsigned long current_stack_poi
 #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
 #define _TIF_SINGLESTEP		(1<<TIF_SINGLESTEP)
 #define _TIF_IRET		(1<<TIF_IRET)
+#define _TIF_SYSCALL_EMU	(1<<TIF_SYSCALL_EMU)
 #define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
 #define _TIF_SECCOMP		(1<<TIF_SECCOMP)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
 
 /* work to do on interrupt/exception return */
 #define _TIF_WORK_MASK \
-  (0x0000FFFF & ~(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SINGLESTEP|_TIF_SECCOMP))
+  (0x0000FFFF & ~(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SINGLESTEP|\
+		  _TIF_SECCOMP|_TIF_SYSCALL_EMU))
 /* work to do on any return to u-space */
 #define _TIF_ALLWORK_MASK	(0x0000FFFF & ~_TIF_SECCOMP)
 
diff -puN include/linux/ptrace.h~host-sysemu include/linux/ptrace.h
--- linux-2.6.git/include/linux/ptrace.h~host-sysemu	2005-07-26 20:24:57.000000000 +0200
+++ linux-2.6.git-paolo/include/linux/ptrace.h	2005-07-26 20:39:57.000000000 +0200
@@ -20,6 +20,7 @@
 #define PTRACE_DETACH		0x11
 
 #define PTRACE_SYSCALL		  24
+#define PTRACE_SYSEMU		  31
 
 /* 0x4200-0x4300 are reserved for architecture-independent additions.  */
 #define PTRACE_SETOPTIONS	0x4200
diff -puN kernel/fork.c~host-sysemu kernel/fork.c
--- linux-2.6.git/kernel/fork.c~host-sysemu	2005-07-26 20:24:57.000000000 +0200
+++ linux-2.6.git-paolo/kernel/fork.c	2005-07-26 20:24:57.000000000 +0200
@@ -994,6 +994,9 @@ static task_t *copy_process(unsigned lon
 	 * of CLONE_PTRACE.
 	 */
 	clear_tsk_thread_flag(p, TIF_SYSCALL_TRACE);
+#ifdef TIF_SYSCALL_EMU
+	clear_tsk_thread_flag(p, TIF_SYSCALL_EMU);
+#endif
 
 	/* Our parent execution domain becomes current domain
 	   These must match for thread signalling to apply */
_
