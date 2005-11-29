Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932419AbVK2VSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbVK2VSl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 16:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbVK2VSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 16:18:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:12483 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932416AbVK2VSS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 16:18:18 -0500
Date: Tue, 29 Nov 2005 21:18:01 GMT
Message-Id: <200511292118.jATLI1Tq006342@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, dalomar@serrasold.com
Cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Fcc: outgoing
Subject: [PATCH 1/2] Handle TIF_RESTORE_SIGMASK for FRV
In-Reply-To: <dhowells1133299080@warthog.cambridge.redhat.com>
References: <dhowells1133299080@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch handles TIF_RESTORE_SIGMASK as added by David Woodhouse's
patch entitled:

	[PATCH] 2/3 Add TIF_RESTORE_SIGMASK support for arch/powerpc
	[PATCH] 3/3 Generic sys_rt_sigsuspend

It does the following:

 (1) Declares TIF_RESTORE_SIGMASK for FRV.

 (2) Invokes it over to do_signal() when TIF_RESTORE_SIGMASK is set.

 (3) Makes do_signal() support TIF_RESTORE_SIGMASK, using the signal mask saved
     in current->saved_sigmask.

 (4) Discards sys_rt_sigsuspend() from the arch, using the generic one instead.

 (5) Makes sys_sigsuspend() save the signal mask and set TIF_RESTORE_SIGMASK
     rather than attempting to fudge the return registers.

 (6) Makes sys_sigsuspend() return -ERESTARTNOHAND rather than looping
     intrinsically.

 (7) Makes setup_frame(), setup_rt_frame() and handle_signal() return 0 or
     -EFAULT rather than true/false to be consistent with the rest of the
      kernel.

Due to the fact do_signal() is then only called from one place:

 (8) Make do_signal() no longer have a return value is it was just being
     ignored; force_sig() takes care of this.

 (9) Discards the old sigmask argument to do_signal() as it's no longer
     necessary.

This patch depends on the FRV signalling patches as well as the
sys_rt_sigsuspend patch.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 frv-tifrestore-2615rc2.diff
 arch/frv/kernel/signal.c      |  120 +++++++++++++++---------------------------
 include/asm-frv/thread_info.h |    2 
 include/asm-frv/unistd.h      |    1 
 3 files changed, 47 insertions(+), 76 deletions(-)

diff -uNrp linux-2.6.15-rc2-frv-dosignal/arch/frv/kernel/signal.c linux-2.6.15-rc2-frv-tifrestore/arch/frv/kernel/signal.c
--- linux-2.6.15-rc2-frv-dosignal/arch/frv/kernel/signal.c	2005-11-29 16:55:12.000000000 +0000
+++ linux-2.6.15-rc2-frv-tifrestore/arch/frv/kernel/signal.c	2005-11-29 18:54:24.000000000 +0000
@@ -35,74 +35,22 @@ struct fdpic_func_descriptor {
 	unsigned long	GOT;
 };
 
-static int do_signal(sigset_t *oldset);
-
 /*
  * Atomically swap in the new signal mask, and wait for a signal.
  */
 asmlinkage int sys_sigsuspend(int history0, int history1, old_sigset_t mask)
 {
-	sigset_t saveset;
-
 	mask &= _BLOCKABLE;
 	spin_lock_irq(&current->sighand->siglock);
-	saveset = current->blocked;
+	current->saved_sigmask = current->blocked;
 	siginitset(&current->blocked, mask);
 	recalc_sigpending();
 	spin_unlock_irq(&current->sighand->siglock);
 
-	__frame->gr8 = -EINTR;
-	while (1) {
-		current->state = TASK_INTERRUPTIBLE;
-		schedule();
-		if (do_signal(&saveset))
-			/* return the signal number as the return value of this function
-			 * - this is an utterly evil hack. syscalls should not invoke do_signal()
-			 *   as entry.S sets regs->gr8 to the return value of the system call
-			 * - we can't just use sigpending() as we'd have to discard SIG_IGN signals
-			 *   and call waitpid() if SIGCHLD needed discarding
-			 * - this only works on the i386 because it passes arguments to the signal
-			 *   handler on the stack, and the return value in EAX is effectively
-			 *   discarded
-			 */
-			return __frame->gr8;
-	}
-}
-
-asmlinkage int sys_rt_sigsuspend(sigset_t __user *unewset, size_t sigsetsize)
-{
-	sigset_t saveset, newset;
-
-	/* XXX: Don't preclude handling different sized sigset_t's.  */
-	if (sigsetsize != sizeof(sigset_t))
-		return -EINVAL;
-
-	if (copy_from_user(&newset, unewset, sizeof(newset)))
-		return -EFAULT;
-	sigdelsetmask(&newset, ~_BLOCKABLE);
-
-	spin_lock_irq(&current->sighand->siglock);
-	saveset = current->blocked;
-	current->blocked = newset;
-	recalc_sigpending();
-	spin_unlock_irq(&current->sighand->siglock);
-
-	__frame->gr8 = -EINTR;
-	while (1) {
-		current->state = TASK_INTERRUPTIBLE;
-		schedule();
-		if (do_signal(&saveset))
-			/* return the signal number as the return value of this function
-			 * - this is an utterly evil hack. syscalls should not invoke do_signal()
-			 *   as entry.S sets regs->gr8 to the return value of the system call
-			 * - we can't just use sigpending() as we'd have to discard SIG_IGN signals
-			 *   and call waitpid() if SIGCHLD needed discarding
-			 * - this only works on the i386 because it passes arguments to the signal
-			 *   handler on the stack, and the return value in EAX is effectively
-			 *   discarded
-			 */
-			return __frame->gr8;
-	}
+	current->state = TASK_INTERRUPTIBLE;
+	schedule();
+	set_thread_flag(TIF_RESTORE_SIGMASK);
+	return -ERESTARTNOHAND;
 }
 
 asmlinkage int sys_sigaction(int sig,
@@ -372,11 +320,11 @@ static int setup_frame(int sig, struct k
 	       frame->pretcode);
 #endif
 
-	return 1;
+	return 0;
 
 give_sigsegv:
 	force_sig(SIGSEGV, current);
-	return 0;
+	return -EFAULT;
 
 } /* end setup_frame() */
 
@@ -471,11 +419,11 @@ static int setup_rt_frame(int sig, struc
 	       frame->pretcode);
 #endif
 
-	return 1;
+	return 0;
 
 give_sigsegv:
 	force_sig(SIGSEGV, current);
-	return 0;
+	return -EFAULT;
 
 } /* end setup_rt_frame() */
 
@@ -516,7 +464,7 @@ static int handle_signal(unsigned long s
 	else
 		ret = setup_frame(sig, ka, oldset);
 
-	if (ret) {
+	if (ret == 0) {
 		spin_lock_irq(&current->sighand->siglock);
 		sigorsets(&current->blocked, &current->blocked,
 			  &ka->sa.sa_mask);
@@ -536,10 +484,11 @@ static int handle_signal(unsigned long s
  * want to handle. Thus you cannot kill init even with a SIGKILL even by
  * mistake.
  */
-static int do_signal(sigset_t *oldset)
+static void do_signal(void)
 {
 	struct k_sigaction ka;
 	siginfo_t info;
+	sigset_t *oldset;
 	int signr;
 
 	/*
@@ -549,43 +498,62 @@ static int do_signal(sigset_t *oldset)
 	 * if so.
 	 */
 	if (!user_mode(__frame))
-		return 1;
+		return;
 
 	if (try_to_freeze())
 		goto no_signal;
 
-	if (!oldset)
+	if (test_thread_flag(TIF_RESTORE_SIGMASK))
+		oldset = &current->saved_sigmask;
+	else
 		oldset = &current->blocked;
 
 	signr = get_signal_to_deliver(&info, &ka, __frame, NULL);
-	if (signr > 0)
-		return handle_signal(signr, &info, &ka, oldset);
+	if (signr > 0) {
+		if (handle_signal(signr, &info, &ka, oldset) == 0) {
+			/* a signal was successfully delivered; the saved
+			 * sigmask will have been stored in the signal frame,
+			 * and will be restored by sigreturn, so we can simply
+			 * clear the TIF_RESTORE_SIGMASK flag */
+			if (test_thread_flag(TIF_RESTORE_SIGMASK))
+				clear_thread_flag(TIF_RESTORE_SIGMASK);
+		}
+
+		return;
+	}
 
 no_signal:
 	/* Did we come from a system call? */
 	if (__frame->syscallno >= 0) {
 		/* Restart the system call - no handlers present */
-		if (__frame->gr8 == -ERESTARTNOHAND ||
-		    __frame->gr8 == -ERESTARTSYS ||
-		    __frame->gr8 == -ERESTARTNOINTR) {
+		switch (__frame->gr8) {
+		case -ERESTARTNOHAND:
+		case -ERESTARTSYS:
+		case -ERESTARTNOINTR:
 			__frame->gr8 = __frame->orig_gr8;
 			__frame->pc -= 4;
-		}
+			break;
 
-		if (__frame->gr8 == -ERESTART_RESTARTBLOCK){
+		case -ERESTART_RESTARTBLOCK:
 			__frame->gr8 = __NR_restart_syscall;
 			__frame->pc -= 4;
+			break;
 		}
 	}
 
-	return 0;
+	/* if there's no signal to deliver, we just put the saved sigmask
+	 * back */
+	if (test_thread_flag(TIF_RESTORE_SIGMASK)) {
+		clear_thread_flag(TIF_RESTORE_SIGMASK);
+		sigprocmask(SIG_SETMASK, &current->saved_sigmask, NULL);
+	}
 
 } /* end do_signal() */
 
 /*****************************************************************************/
 /*
  * notification of userspace execution resumption
- * - triggered by current->work.notify_resume
+ * - triggered by the TIF_WORK_MASK flags
  */
 asmlinkage void do_notify_resume(__u32 thread_info_flags)
 {
@@ -594,7 +562,7 @@ asmlinkage void do_notify_resume(__u32 t
 		clear_thread_flag(TIF_SINGLESTEP);
 
 	/* deal with pending signal delivery */
-	if (thread_info_flags & _TIF_SIGPENDING)
-		do_signal(NULL);
+	if (thread_info_flags & (_TIF_SIGPENDING | _TIF_RESTORE_SIGMASK))
+		do_signal();
 
 } /* end do_notify_resume() */
diff -uNrp linux-2.6.15-rc2-frv-dosignal/include/asm-frv/thread_info.h linux-2.6.15-rc2-frv-tifrestore/include/asm-frv/thread_info.h
--- linux-2.6.15-rc2-frv-dosignal/include/asm-frv/thread_info.h	2005-11-29 16:41:11.000000000 +0000
+++ linux-2.6.15-rc2-frv-tifrestore/include/asm-frv/thread_info.h	2005-11-29 17:39:05.000000000 +0000
@@ -131,6 +131,7 @@ register struct thread_info *__current_t
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_SINGLESTEP		4	/* restore singlestep on return to user mode */
 #define TIF_IRET		5	/* return with iret */
+#define TIF_RESTORE_SIGMASK	6	/* restore signal mask in do_signal() */
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_MEMDIE		17	/* OOM killer killed process */
 
@@ -140,6 +141,7 @@ register struct thread_info *__current_t
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
 #define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
 #define _TIF_IRET		(1 << TIF_IRET)
+#define _TIF_RESTORE_SIGMASK	(1 << TIF_RESTORE_SIGMASK)
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 
 #define _TIF_WORK_MASK		0x0000FFFE	/* work to do on interrupt/exception return */
diff -uNrp linux-2.6.15-rc2-frv-dosignal/include/asm-frv/unistd.h linux-2.6.15-rc2-frv-tifrestore/include/asm-frv/unistd.h
--- linux-2.6.15-rc2-frv-dosignal/include/asm-frv/unistd.h	2005-06-22 13:52:26.000000000 +0100
+++ linux-2.6.15-rc2-frv-tifrestore/include/asm-frv/unistd.h	2005-11-29 18:02:04.000000000 +0000
@@ -486,6 +486,7 @@ static inline pid_t wait(int * wait_stat
 /* #define __ARCH_WANT_SYS_SIGPENDING */
 #define __ARCH_WANT_SYS_SIGPROCMASK
 #define __ARCH_WANT_SYS_RT_SIGACTION
+#define __ARCH_WANT_SYS_RT_SIGSUSPEND
 #endif
 
 /*
