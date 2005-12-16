Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbVLPLpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbVLPLpZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 06:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbVLPLpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 06:45:24 -0500
Received: from canuck.infradead.org ([205.233.218.70]:24762 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S932213AbVLPLpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 06:45:21 -0500
Subject: [PATCH] [5/6] Handle TIF_RESTORE_SIGMASK for i386
From: David Woodhouse <dwmw2@infradead.org>
To: akpm@osdl.org
Cc: dhowells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1134732739.7104.54.camel@pmac.infradead.org>
References: <1134732739.7104.54.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Fri, 16 Dec 2005 11:45:11 +0000
Message-Id: <1134733511.7104.99.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

The attached patch handles TIF_RESTORE_SIGMASK as added by David Woodhouse's
patch entitled:

        [PATCH] 2/6 TIF_RESTORE_SIGMASK support for arch/powerpc
        [PATCH] 3/6 Generic sys_rt_sigsuspend

It does the following:

 (1) Declares TIF_RESTORE_SIGMASK for i386.

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

 (8) Makes do_signal() no longer have a return value is it was just being
     ignored; force_sig() takes care of this.

 (9) Discards the old sigmask argument to do_signal() as it's no longer
     necessary.

(10) Makes do_signal() static.

(11) Marks the second argument to do_notify_resume() as unused. The unused
     argument should remain in the middle as the arguments are passed in as
     registers, and the ordering is specific in entry.S

Given the way do_signal() is now no longer called from sys_{,rt_}sigsuspend(),
they no longer need access to the exception frame, and so can just take
arguments normally.

This patch depends on sys_rt_sigsuspend patch.

Signed-Off-By: David Howells <dhowells@redhat.com>
Signed-Off-By: David Woodhouse <dwmw2@infradead.org>

 arch/i386/kernel/signal.c      |  109 ++++++++++++++++++-----------------------
 include/asm-i386/signal.h      |    1 
 include/asm-i386/thread_info.h |    2 
 include/asm-i386/unistd.h      |    1 
 4 files changed, 51 insertions(+), 62 deletions(-)

diff -rup linux-2.6.15-rc5-mm3-pselect4/arch/i386/kernel/signal.c linux-2.6.15-rc5-mm3-pselect5/arch/i386/kernel/signal.c
--- linux-2.6.15-rc5-mm3-pselect4/arch/i386/kernel/signal.c	2005-10-28 01:02:08.000000000 +0100
+++ linux-2.6.15-rc5-mm3-pselect5/arch/i386/kernel/signal.c	2005-12-16 11:09:59.000000000 +0000
@@ -37,51 +37,17 @@
 asmlinkage int
 sys_sigsuspend(int history0, int history1, old_sigset_t mask)
 {
-	struct pt_regs * regs = (struct pt_regs *) &history0;
-	sigset_t saveset;
-
 	mask &= _BLOCKABLE;
 	spin_lock_irq(&current->sighand->siglock);
-	saveset = current->blocked;
+	current->saved_sigmask = current->blocked;
 	siginitset(&current->blocked, mask);
 	recalc_sigpending();
 	spin_unlock_irq(&current->sighand->siglock);
 
-	regs->eax = -EINTR;
-	while (1) {
-		current->state = TASK_INTERRUPTIBLE;
-		schedule();
-		if (do_signal(regs, &saveset))
-			return -EINTR;
-	}
-}
-
-asmlinkage int
-sys_rt_sigsuspend(struct pt_regs regs)
-{
-	sigset_t saveset, newset;
-
-	/* XXX: Don't preclude handling different sized sigset_t's.  */
-	if (regs.ecx != sizeof(sigset_t))
-		return -EINVAL;
-
-	if (copy_from_user(&newset, (sigset_t __user *)regs.ebx, sizeof(newset)))
-		return -EFAULT;
-	sigdelsetmask(&newset, ~_BLOCKABLE);
-
-	spin_lock_irq(&current->sighand->siglock);
-	saveset = current->blocked;
-	current->blocked = newset;
-	recalc_sigpending();
-	spin_unlock_irq(&current->sighand->siglock);
-
-	regs.eax = -EINTR;
-	while (1) {
-		current->state = TASK_INTERRUPTIBLE;
-		schedule();
-		if (do_signal(&regs, &saveset))
-			return -EINTR;
-	}
+	current->state = TASK_INTERRUPTIBLE;
+	schedule();
+	set_thread_flag(TIF_RESTORE_SIGMASK);
+	return -ERESTARTNOHAND;
 }
 
 asmlinkage int 
@@ -433,11 +399,11 @@ static int setup_frame(int sig, struct k
 		current->comm, current->pid, frame, regs->eip, frame->pretcode);
 #endif
 
-	return 1;
+	return 0;
 
 give_sigsegv:
 	force_sigsegv(sig, current);
-	return 0;
+	return -EFAULT;
 }
 
 static int setup_rt_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
@@ -527,11 +493,11 @@ static int setup_rt_frame(int sig, struc
 		current->comm, current->pid, frame, regs->eip, frame->pretcode);
 #endif
 
-	return 1;
+	return 0;
 
 give_sigsegv:
 	force_sigsegv(sig, current);
-	return 0;
+	return -EFAULT;
 }
 
 /*
@@ -581,7 +547,7 @@ handle_signal(unsigned long sig, siginfo
 	else
 		ret = setup_frame(sig, ka, oldset, regs);
 
-	if (ret) {
+	if (ret == 0) {
 		spin_lock_irq(&current->sighand->siglock);
 		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
 		if (!(ka->sa.sa_flags & SA_NODEFER))
@@ -598,11 +564,12 @@ handle_signal(unsigned long sig, siginfo
  * want to handle. Thus you cannot kill init even with a SIGKILL even by
  * mistake.
  */
-int fastcall do_signal(struct pt_regs *regs, sigset_t *oldset)
+static void fastcall do_signal(struct pt_regs *regs)
 {
 	siginfo_t info;
 	int signr;
 	struct k_sigaction ka;
+	sigset_t *oldset;
 
 	/*
 	 * We want the common case to go fast, which
@@ -613,12 +580,14 @@ int fastcall do_signal(struct pt_regs *r
  	 * CS suffices.
 	 */
 	if (!user_mode(regs))
-		return 1;
+		return;
 
 	if (try_to_freeze())
 		goto no_signal;
 
-	if (!oldset)
+	if (test_thread_flag(TIF_RESTORE_SIGMASK))
+		oldset = &current->saved_sigmask;
+	else
 		oldset = &current->blocked;
 
 	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
@@ -628,38 +597,55 @@ int fastcall do_signal(struct pt_regs *r
 		 * have been cleared if the watchpoint triggered
 		 * inside the kernel.
 		 */
-		if (unlikely(current->thread.debugreg[7])) {
+		if (unlikely(current->thread.debugreg[7]))
 			set_debugreg(current->thread.debugreg[7], 7);
-		}
 
 		/* Whee!  Actually deliver the signal.  */
-		return handle_signal(signr, &info, &ka, oldset, regs);
+		if (handle_signal(signr, &info, &ka, oldset, regs) == 0) {
+			/* a signal was successfully delivered; the saved
+			 * sigmask will have been stored in the signal frame,
+			 * and will be restored by sigreturn, so we can simply
+			 * clear the TIF_RESTORE_SIGMASK flag */
+			if (test_thread_flag(TIF_RESTORE_SIGMASK))
+				clear_thread_flag(TIF_RESTORE_SIGMASK);
+		}
+
+		return;
 	}
 
- no_signal:
+no_signal:
 	/* Did we come from a system call? */
 	if (regs->orig_eax >= 0) {
 		/* Restart the system call - no handlers present */
-		if (regs->eax == -ERESTARTNOHAND ||
-		    regs->eax == -ERESTARTSYS ||
-		    regs->eax == -ERESTARTNOINTR) {
+		switch (regs->eax) {
+		case -ERESTARTNOHAND:
+		case -ERESTARTSYS:
+		case -ERESTARTNOINTR:
 			regs->eax = regs->orig_eax;
 			regs->eip -= 2;
-		}
-		if (regs->eax == -ERESTART_RESTARTBLOCK){
+			break;
+
+		case -ERESTART_RESTARTBLOCK:
 			regs->eax = __NR_restart_syscall;
 			regs->eip -= 2;
+			break;
 		}
 	}
-	return 0;
+
+	/* if there's no signal to deliver, we just put the saved sigmask
+	 * back */
+	if (test_thread_flag(TIF_RESTORE_SIGMASK)) {
+		clear_thread_flag(TIF_RESTORE_SIGMASK);
+		sigprocmask(SIG_SETMASK, &current->saved_sigmask, NULL);
+	}
 }
 
 /*
  * notification of userspace execution resumption
- * - triggered by current->work.notify_resume
+ * - triggered by the TIF_WORK_MASK flags
  */
 __attribute__((regparm(3)))
-void do_notify_resume(struct pt_regs *regs, sigset_t *oldset,
+void do_notify_resume(struct pt_regs *regs, void *_unused,
 		      __u32 thread_info_flags)
 {
 	/* Pending single-step? */
@@ -667,9 +653,10 @@ void do_notify_resume(struct pt_regs *re
 		regs->eflags |= TF_MASK;
 		clear_thread_flag(TIF_SINGLESTEP);
 	}
+
 	/* deal with pending signal delivery */
-	if (thread_info_flags & _TIF_SIGPENDING)
-		do_signal(regs,oldset);
+	if (thread_info_flags & (_TIF_SIGPENDING | _TIF_RESTORE_SIGMASK))
+		do_signal(regs);
 	
 	clear_thread_flag(TIF_IRET);
 }
diff -rup linux-2.6.15-rc5-mm3-pselect4/include/asm-i386/signal.h linux-2.6.15-rc5-mm3-pselect5/include/asm-i386/signal.h
--- linux-2.6.15-rc5-mm3-pselect4/include/asm-i386/signal.h	2005-12-16 10:51:25.000000000 +0000
+++ linux-2.6.15-rc5-mm3-pselect5/include/asm-i386/signal.h	2005-12-16 11:09:59.000000000 +0000
@@ -218,7 +218,6 @@ static __inline__ int sigfindinword(unsi
 }
 
 struct pt_regs;
-extern int FASTCALL(do_signal(struct pt_regs *regs, sigset_t *oldset));
 
 #define ptrace_signal_deliver(regs, cookie)		\
 	do {						\
diff -rup linux-2.6.15-rc5-mm3-pselect4/include/asm-i386/thread_info.h linux-2.6.15-rc5-mm3-pselect5/include/asm-i386/thread_info.h
--- linux-2.6.15-rc5-mm3-pselect4/include/asm-i386/thread_info.h	2005-10-28 01:02:08.000000000 +0100
+++ linux-2.6.15-rc5-mm3-pselect5/include/asm-i386/thread_info.h	2005-12-16 11:09:59.000000000 +0000
@@ -142,6 +142,7 @@ register unsigned long current_stack_poi
 #define TIF_SYSCALL_EMU		6	/* syscall emulation active */
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
 #define TIF_SECCOMP		8	/* secure computing */
+#define TIF_RESTORE_SIGMASK	9	/* restore signal mask in do_signal() */
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_MEMDIE		17
 
@@ -154,6 +155,7 @@ register unsigned long current_stack_poi
 #define _TIF_SYSCALL_EMU	(1<<TIF_SYSCALL_EMU)
 #define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
 #define _TIF_SECCOMP		(1<<TIF_SECCOMP)
+#define _TIF_RESTORE_SIGMASK	(1<<TIF_RESTORE_SIGMASK)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
 
 /* work to do on interrupt/exception return */
diff -rup linux-2.6.15-rc5-mm3-pselect4/include/asm-i386/unistd.h linux-2.6.15-rc5-mm3-pselect5/include/asm-i386/unistd.h
--- linux-2.6.15-rc5-mm3-pselect4/include/asm-i386/unistd.h	2005-12-16 10:56:18.000000000 +0000
+++ linux-2.6.15-rc5-mm3-pselect5/include/asm-i386/unistd.h	2005-12-16 11:09:59.000000000 +0000
@@ -420,6 +420,7 @@ __syscall_return(type,__res); \
 #define __ARCH_WANT_SYS_SIGPENDING
 #define __ARCH_WANT_SYS_SIGPROCMASK
 #define __ARCH_WANT_SYS_RT_SIGACTION
+#define __ARCH_WANT_SYS_RT_SIGSUSPEND
 #endif
 
 #ifdef __KERNEL_SYSCALLS__


-- 
dwmw2

