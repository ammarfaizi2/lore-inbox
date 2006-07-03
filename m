Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751025AbWGCJmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbWGCJmI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 05:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbWGCJmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 05:42:08 -0400
Received: from canuck.infradead.org ([205.233.218.70]:50820 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1751025AbWGCJmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 05:42:07 -0400
Subject: [PATCH 1/2] Support TIF_RESTORE_SIGMASK on x86_64
From: David Woodhouse <dwmw2@infradead.org>
To: ak@muc.de
Cc: drepper@redhat.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Mon, 03 Jul 2006 10:41:51 +0100
Message-Id: <1151919711.3000.82.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We need TIF_RESTORE_SIGMASK in order to support ppoll() and pselect()
system calls. This patch originally came from Andi, and was based
heavily on David Howells' implementation of same on i386. I fixed a typo
which was causing do_signal() to use the wrong signal mask.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/arch/x86_64/ia32/ia32_signal.c b/arch/x86_64/ia32/ia32_signal.c
index 25e5ca2..549de43 100644
--- a/arch/x86_64/ia32/ia32_signal.c
+++ b/arch/x86_64/ia32/ia32_signal.c
@@ -113,25 +113,19 @@ int copy_siginfo_from_user32(siginfo_t *
 }
 
 asmlinkage long
-sys32_sigsuspend(int history0, int history1, old_sigset_t mask,
-		 struct pt_regs *regs)
+sys32_sigsuspend(int history0, int history1, old_sigset_t mask)
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
 
-	regs->rax = -EINTR;
-	while (1) {
-		current->state = TASK_INTERRUPTIBLE;
-		schedule();
-		if (do_signal(regs, &saveset))
-			return -EINTR;
-	}
+	current->state = TASK_INTERRUPTIBLE;
+	schedule();
+	set_thread_flag(TIF_RESTORE_SIGMASK);
+	return -ERESTARTNOHAND;
 }
 
 asmlinkage long
@@ -508,11 +502,11 @@ #if DEBUG_SIG
 		current->comm, current->pid, frame, regs->rip, frame->pretcode);
 #endif
 
-	return 1;
+	return 0;
 
 give_sigsegv:
 	force_sigsegv(sig, current);
-	return 0;
+	return -EFAULT;
 }
 
 int ia32_setup_rt_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
@@ -595,7 +589,7 @@ int ia32_setup_rt_frame(int sig, struct 
 	regs->ss = __USER32_DS; 
 
 	set_fs(USER_DS);
-    regs->eflags &= ~TF_MASK;
+	regs->eflags &= ~TF_MASK;
     if (test_thread_flag(TIF_SINGLESTEP))
         ptrace_notify(SIGTRAP);
 
@@ -604,9 +598,9 @@ #if DEBUG_SIG
 		current->comm, current->pid, frame, regs->rip, frame->pretcode);
 #endif
 
-	return 1;
+	return 0;
 
 give_sigsegv:
 	force_sigsegv(sig, current);
-	return 0;
+	return -EFAULT;
 }
diff --git a/arch/x86_64/kernel/signal.c b/arch/x86_64/kernel/signal.c
index 2816117..7f58bc9 100644
--- a/arch/x86_64/kernel/signal.c
+++ b/arch/x86_64/kernel/signal.c
@@ -38,37 +38,6 @@ int ia32_setup_frame(int sig, struct k_s
             sigset_t *set, struct pt_regs * regs); 
 
 asmlinkage long
-sys_rt_sigsuspend(sigset_t __user *unewset, size_t sigsetsize, struct pt_regs *regs)
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
-#ifdef DEBUG_SIG
-	printk("rt_sigsuspend savset(%lx) newset(%lx) regs(%p) rip(%lx)\n",
-		saveset, newset, regs, regs->rip);
-#endif 
-	regs->rax = -EINTR;
-	while (1) {
-		current->state = TASK_INTERRUPTIBLE;
-		schedule();
-		if (do_signal(regs, &saveset))
-			return -EINTR;
-	}
-}
-
-asmlinkage long
 sys_sigaltstack(const stack_t __user *uss, stack_t __user *uoss,
 		struct pt_regs *regs)
 {
@@ -341,11 +310,11 @@ #ifdef DEBUG_SIG
 		current->comm, current->pid, frame, regs->rip, frame->pretcode);
 #endif
 
-	return 1;
+	return 0;
 
 give_sigsegv:
 	force_sigsegv(sig, current);
-	return 0;
+	return -EFAULT;
 }
 
 /*
@@ -408,7 +377,7 @@ #ifdef CONFIG_IA32_EMULATION
 #endif
 	ret = setup_rt_frame(sig, ka, info, oldset, regs);
 
-	if (ret) {
+	if (ret == 0) {
 		spin_lock_irq(&current->sighand->siglock);
 		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
 		if (!(ka->sa.sa_flags & SA_NODEFER))
@@ -425,11 +394,12 @@ #endif
  * want to handle. Thus you cannot kill init even with a SIGKILL even by
  * mistake.
  */
-int do_signal(struct pt_regs *regs, sigset_t *oldset)
+static void do_signal(struct pt_regs *regs)
 {
 	struct k_sigaction ka;
 	siginfo_t info;
 	int signr;
+	sigset_t *oldset;
 
 	/*
 	 * We want the common case to go fast, which
@@ -438,9 +408,11 @@ int do_signal(struct pt_regs *regs, sigs
 	 * if so.
 	 */
 	if (!user_mode(regs))
-		return 1;
+		return;
 
-	if (!oldset)
+	if (test_thread_flag(TIF_RESTORE_SIGMASK))
+		oldset = &current->saved_sigmask;
+	else
 		oldset = &current->blocked;
 
 	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
@@ -454,30 +426,46 @@ int do_signal(struct pt_regs *regs, sigs
 			set_debugreg(current->thread.debugreg7, 7);
 
 		/* Whee!  Actually deliver the signal.  */
-		return handle_signal(signr, &info, &ka, oldset, regs);
+		if (handle_signal(signr, &info, &ka, oldset, regs) == 0) {
+			/* a signal was successfully delivered; the saved
+			 * sigmask will have been stored in the signal frame,
+			 * and will be restored by sigreturn, so we can simply
+			 * clear the TIF_RESTORE_SIGMASK flag */
+			clear_thread_flag(TIF_RESTORE_SIGMASK);
+		}
+		return;
 	}
 
 	/* Did we come from a system call? */
 	if ((long)regs->orig_rax >= 0) {
 		/* Restart the system call - no handlers present */
 		long res = regs->rax;
-		if (res == -ERESTARTNOHAND ||
-		    res == -ERESTARTSYS ||
-		    res == -ERESTARTNOINTR) {
+		switch (res) {
+		case -ERESTARTNOHAND:
+		case -ERESTARTSYS:
+		case -ERESTARTNOINTR:
 			regs->rax = regs->orig_rax;
 			regs->rip -= 2;
-		}
-		if (regs->rax == (unsigned long)-ERESTART_RESTARTBLOCK) {
+			break;
+		case -ERESTART_RESTARTBLOCK:
 			regs->rax = test_thread_flag(TIF_IA32) ?
 					__NR_ia32_restart_syscall :
 					__NR_restart_syscall;
 			regs->rip -= 2;
+			break;
 		}
 	}
-	return 0;
+
+	/* if there's no signal to deliver, we just put the saved sigmask
+	   back. */
+	if (test_thread_flag(TIF_RESTORE_SIGMASK)) {
+		clear_thread_flag(TIF_RESTORE_SIGMASK);
+		sigprocmask(SIG_SETMASK, &current->saved_sigmask, NULL);
+	}
 }
 
-void do_notify_resume(struct pt_regs *regs, sigset_t *oldset, __u32 thread_info_flags)
+void
+do_notify_resume(struct pt_regs *regs, void *unused, __u32 thread_info_flags)
 {
 #ifdef DEBUG_SIG
 	printk("do_notify_resume flags:%x rip:%lx rsp:%lx caller:%lx pending:%lx\n",
@@ -491,8 +479,8 @@ #endif
 	}
 
 	/* deal with pending signal delivery */
-	if (thread_info_flags & _TIF_SIGPENDING)
-		do_signal(regs,oldset);
+	if (thread_info_flags & (_TIF_SIGPENDING|_TIF_RESTORE_SIGMASK))
+		do_signal(regs);
 }
 
 void signal_fault(struct pt_regs *regs, void __user *frame, char *where)
diff --git a/include/asm-x86_64/signal.h b/include/asm-x86_64/signal.h
index cef7a7d..00f2d38 100644
--- a/include/asm-x86_64/signal.h
+++ b/include/asm-x86_64/signal.h
@@ -24,10 +24,6 @@ typedef struct {
 } sigset_t;
 
 
-struct pt_regs; 
-asmlinkage int do_signal(struct pt_regs *regs, sigset_t *oldset);
-
-
 #else
 /* Here we must cater to libcs that poke about in kernel headers.  */
 
diff --git a/include/asm-x86_64/thread_info.h b/include/asm-x86_64/thread_info.h
index 2029b00..790c512 100644
--- a/include/asm-x86_64/thread_info.h
+++ b/include/asm-x86_64/thread_info.h
@@ -114,6 +114,7 @@ #define TIF_SINGLESTEP		4	/* reenable si
 #define TIF_IRET		5	/* force IRET */
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
 #define TIF_SECCOMP		8	/* secure computing */
+#define TIF_RESTORE_SIGMASK	9	/* restore signal mask in do_signal */
 /* 16 free */
 #define TIF_IA32		17	/* 32bit process */ 
 #define TIF_FORK		18	/* ret_from_fork */
@@ -128,6 +129,7 @@ #define _TIF_NEED_RESCHED	(1<<TIF_NEED_R
 #define _TIF_IRET		(1<<TIF_IRET)
 #define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
 #define _TIF_SECCOMP		(1<<TIF_SECCOMP)
+#define _TIF_RESTORE_SIGMASK	(1<<TIF_RESTORE_SIGMASK)
 #define _TIF_IA32		(1<<TIF_IA32)
 #define _TIF_FORK		(1<<TIF_FORK)
 #define _TIF_ABI_PENDING	(1<<TIF_ABI_PENDING)
diff --git a/include/asm-x86_64/unistd.h b/include/asm-x86_64/unistd.h
index 94387c9..c9db37d 100644
--- a/include/asm-x86_64/unistd.h
+++ b/include/asm-x86_64/unistd.h
@@ -658,6 +658,7 @@ #define __ARCH_WANT_SYS_OLDUMOUNT
 #define __ARCH_WANT_SYS_SIGPENDING
 #define __ARCH_WANT_SYS_SIGPROCMASK
 #define __ARCH_WANT_SYS_RT_SIGACTION
+#define __ARCH_WANT_SYS_RT_SIGSUSPEND
 #define __ARCH_WANT_SYS_TIME
 #define __ARCH_WANT_COMPAT_SYS_TIME
 


-- 
dwmw2

