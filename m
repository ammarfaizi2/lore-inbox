Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbVLPLos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbVLPLos (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 06:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbVLPLoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 06:44:46 -0500
Received: from canuck.infradead.org ([205.233.218.70]:22714 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S932202AbVLPLoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 06:44:44 -0500
Subject: [PATCH] [3/6] Generic sys_rt_sigsuspend()
From: David Woodhouse <dwmw2@infradead.org>
To: akpm@osdl.org
Cc: dhowells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1134732739.7104.54.camel@pmac.infradead.org>
References: <1134732739.7104.54.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Fri, 16 Dec 2005 11:44:37 +0000
Message-Id: <1134733477.7104.96.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The TIF_RESTORE_SIGMASK flag allows us to have a generic implementation
of sys_rt_sigsuspend() instead of duplicating it for each architecture.
This provides such an implementation and makes arch/powerpc use it.

It also tidies up the ppc32 sys_sigsuspend() to use TIF_RESTORE_SIGMASK.

Signed-Off-By: David Woodhouse <dwmw2@infradead.org>

 arch/powerpc/kernel/signal_32.c |   56 +++-------------------------------------
 arch/powerpc/kernel/signal_64.c |   36 -------------------------
 include/asm-powerpc/unistd.h    |    2 +
 kernel/compat.c                 |   28 ++++++++++++++++++++
 kernel/signal.c                 |   26 ++++++++++++++++++
 5 files changed, 61 insertions(+), 87 deletions(-)

diff -rup linux-2.6.15-rc5-mm3-pselect2/arch/powerpc/kernel/signal_32.c linux-2.6.15-rc5-mm3-pselect3/arch/powerpc/kernel/signal_32.c
--- linux-2.6.15-rc5-mm3-pselect2/arch/powerpc/kernel/signal_32.c	2005-12-16 11:02:43.000000000 +0000
+++ linux-2.6.15-rc5-mm3-pselect3/arch/powerpc/kernel/signal_32.c	2005-12-16 11:07:20.000000000 +0000
@@ -252,8 +252,7 @@ int do_signal(sigset_t *oldset, struct p
 /*
  * Atomically swap in the new signal mask, and wait for a signal.
  */
-long sys_sigsuspend(old_sigset_t mask, int p2, int p3, int p4, int p6, int p7,
-	       struct pt_regs *regs)
+long sys_sigsuspend(old_sigset_t mask)
 {
 	sigset_t saveset;
 
@@ -264,55 +263,10 @@ long sys_sigsuspend(old_sigset_t mask, i
 	recalc_sigpending();
 	spin_unlock_irq(&current->sighand->siglock);
 
-	regs->result = -EINTR;
-	regs->gpr[3] = EINTR;
-	regs->ccr |= 0x10000000;
-	while (1) {
-		current->state = TASK_INTERRUPTIBLE;
-		schedule();
-		if (do_signal(&saveset, regs)) {
-			set_thread_flag(TIF_RESTOREALL);
-			return 0;
-		}
-	}
-}
-
-long sys_rt_sigsuspend(
-#ifdef CONFIG_PPC64
-		compat_sigset_t __user *unewset,
-#else
-		sigset_t __user *unewset,
-#endif
-		size_t sigsetsize, int p3, int p4,
-		int p6, int p7, struct pt_regs *regs)
-{
-	sigset_t saveset, newset;
-
-	/* XXX: Don't preclude handling different sized sigset_t's.  */
-	if (sigsetsize != sizeof(sigset_t))
-		return -EINVAL;
-
-	if (get_sigset_t(&newset, unewset))
-		return -EFAULT;
-	sigdelsetmask(&newset, ~_BLOCKABLE);
-
-	spin_lock_irq(&current->sighand->siglock);
-	saveset = current->blocked;
-	current->blocked = newset;
-	recalc_sigpending();
-	spin_unlock_irq(&current->sighand->siglock);
-
-	regs->result = -EINTR;
-	regs->gpr[3] = EINTR;
-	regs->ccr |= 0x10000000;
-	while (1) {
-		current->state = TASK_INTERRUPTIBLE;
-		schedule();
-		if (do_signal(&saveset, regs)) {
-			set_thread_flag(TIF_RESTOREALL);
-			return 0;
-		}
-	}
+ 	current->state = TASK_INTERRUPTIBLE;
+ 	schedule();
+ 	set_thread_flag(TIF_RESTORE_SIGMASK);
+ 	return -ERESTARTNOHAND;
 }
 
 #ifdef CONFIG_PPC32
diff -rup linux-2.6.15-rc5-mm3-pselect2/arch/powerpc/kernel/signal_64.c linux-2.6.15-rc5-mm3-pselect3/arch/powerpc/kernel/signal_64.c
--- linux-2.6.15-rc5-mm3-pselect2/arch/powerpc/kernel/signal_64.c	2005-12-16 11:02:43.000000000 +0000
+++ linux-2.6.15-rc5-mm3-pselect3/arch/powerpc/kernel/signal_64.c	2005-12-16 11:07:20.000000000 +0000
@@ -67,42 +67,6 @@ struct rt_sigframe {
 	char abigap[288];
 } __attribute__ ((aligned (16)));
 
-
-/*
- * Atomically swap in the new signal mask, and wait for a signal.
- */
-long sys_rt_sigsuspend(sigset_t __user *unewset, size_t sigsetsize, int p3, int p4,
-		       int p6, int p7, struct pt_regs *regs)
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
-	regs->result = -EINTR;
-	regs->gpr[3] = EINTR;
-	regs->ccr |= 0x10000000;
-	while (1) {
-		current->state = TASK_INTERRUPTIBLE;
-		schedule();
-		if (do_signal(&saveset, regs)) {
-			set_thread_flag(TIF_RESTOREALL);
-			return 0;
-		}
-	}
-}
-
 long sys_sigaltstack(const stack_t __user *uss, stack_t __user *uoss, unsigned long r5,
 		     unsigned long r6, unsigned long r7, unsigned long r8,
 		     struct pt_regs *regs)
diff -rup linux-2.6.15-rc5-mm3-pselect2/include/asm-powerpc/unistd.h linux-2.6.15-rc5-mm3-pselect3/include/asm-powerpc/unistd.h
--- linux-2.6.15-rc5-mm3-pselect2/include/asm-powerpc/unistd.h	2005-12-16 11:03:30.000000000 +0000
+++ linux-2.6.15-rc5-mm3-pselect3/include/asm-powerpc/unistd.h	2005-12-16 11:07:20.000000000 +0000
@@ -448,11 +448,13 @@ type name(type1 arg1, type2 arg2, type3 
 #define __ARCH_WANT_SYS_SIGPENDING
 #define __ARCH_WANT_SYS_SIGPROCMASK
 #define __ARCH_WANT_SYS_RT_SIGACTION
+#define __ARCH_WANT_SYS_RT_SIGSUSPEND
 #ifdef CONFIG_PPC32
 #define __ARCH_WANT_OLD_STAT
 #endif
 #ifdef CONFIG_PPC64
 #define __ARCH_WANT_COMPAT_SYS_TIME
+#define __ARCH_WANT_COMPAT_SYS_RT_SIGSUSPEND
 #endif
 
 /*
diff -rup linux-2.6.15-rc5-mm3-pselect2/kernel/compat.c linux-2.6.15-rc5-mm3-pselect3/kernel/compat.c
--- linux-2.6.15-rc5-mm3-pselect2/kernel/compat.c	2005-12-16 10:56:18.000000000 +0000
+++ linux-2.6.15-rc5-mm3-pselect3/kernel/compat.c	2005-12-16 11:07:20.000000000 +0000
@@ -871,3 +871,31 @@ asmlinkage long compat_sys_stime(compat_
 }
 
 #endif /* __ARCH_WANT_COMPAT_SYS_TIME */
+
+#ifdef __ARCH_WANT_COMPAT_SYS_RT_SIGSUSPEND
+long compat_sys_rt_sigsuspend(compat_sigset_t __user *unewset, compat_size_t sigsetsize)
+{
+	sigset_t newset;
+	compat_sigset_t newset32;
+
+	/* XXX: Don't preclude handling different sized sigset_t's.  */
+	if (sigsetsize != sizeof(sigset_t))
+		return -EINVAL;
+
+	if (copy_from_user(&newset32, unewset, sizeof(compat_sigset_t)))
+		return -EFAULT;
+	sigset_from_compat(&newset, &newset32);
+	sigdelsetmask(&newset, sigmask(SIGKILL)|sigmask(SIGSTOP));
+
+	spin_lock_irq(&current->sighand->siglock);
+	current->saved_sigmask = current->blocked;
+	current->blocked = newset;
+	recalc_sigpending();
+	spin_unlock_irq(&current->sighand->siglock);
+
+	current->state = TASK_INTERRUPTIBLE;
+	schedule();
+	set_thread_flag(TIF_RESTORE_SIGMASK);
+	return -ERESTARTNOHAND;
+}
+#endif /* __ARCH_WANT_COMPAT_SYS_RT_SIGSUSPEND */
diff -rup linux-2.6.15-rc5-mm3-pselect2/kernel/signal.c linux-2.6.15-rc5-mm3-pselect3/kernel/signal.c
--- linux-2.6.15-rc5-mm3-pselect2/kernel/signal.c	2005-12-16 10:56:19.000000000 +0000
+++ linux-2.6.15-rc5-mm3-pselect3/kernel/signal.c	2005-12-16 11:07:20.000000000 +0000
@@ -2720,6 +2720,32 @@ sys_pause(void)
 
 #endif
 
+#ifdef __ARCH_WANT_SYS_RT_SIGSUSPEND
+long sys_rt_sigsuspend(sigset_t __user *unewset, size_t sigsetsize)
+{
+	sigset_t newset;
+
+	/* XXX: Don't preclude handling different sized sigset_t's.  */
+	if (sigsetsize != sizeof(sigset_t))
+		return -EINVAL;
+
+	if (copy_from_user(&newset, unewset, sizeof(newset)))
+		return -EFAULT;
+	sigdelsetmask(&newset, sigmask(SIGKILL)|sigmask(SIGSTOP));
+
+	spin_lock_irq(&current->sighand->siglock);
+	current->saved_sigmask = current->blocked;
+	current->blocked = newset;
+	recalc_sigpending();
+	spin_unlock_irq(&current->sighand->siglock);
+
+	current->state = TASK_INTERRUPTIBLE;
+	schedule();
+	set_thread_flag(TIF_RESTORE_SIGMASK);
+	return -ERESTARTNOHAND;
+}
+#endif /* __ARCH_WANT_SYS_RT_SIGSUSPEND */
+
 void __init signals_init(void)
 {
 	sigqueue_cachep =


-- 
dwmw2

