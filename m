Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbVK2A5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbVK2A5w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 19:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbVK2A5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 19:57:50 -0500
Received: from baythorne.infradead.org ([81.187.2.161]:20671 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S932301AbVK2A5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 19:57:34 -0500
Subject: [PATCH] 3/3 Generic sys_rt_sigsuspend
From: David Woodhouse <dwmw2@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: drepper@redhat.com, linuxppc-dev@ozlabs.org, akpm@osdl.org
In-Reply-To: <1133225007.31573.86.camel@baythorne.infradead.org>
References: <1133225007.31573.86.camel@baythorne.infradead.org>
Content-Type: text/plain
Date: Tue, 29 Nov 2005 00:57:32 +0000
Message-Id: <1133225852.31573.115.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The TIF_RESTORE_SIGMASK flag allows us to have a generic implementation
of sys_rt_sigsuspend() instead of duplicating it for each architecture.
This provides such an implementation and makes arch/powerpc use it.

It also tidies up the ppc32 sys_sigsuspend() to use TIF_RESTORE_SIGMASK.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
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
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 5462bef..7a6f0f7 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
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
--- a/include/asm-powerpc/unistd.h
+++ b/include/asm-powerpc/unistd.h
@@ -444,11 +446,13 @@ type name(type1 arg1, type2 arg2, type3 
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
--- a/kernel/compat.c
+++ b/kernel/compat.c
@@ -855,3 +855,31 @@ asmlinkage long compat_sys_stime(compat_
 }
 
 #endif /* __ARCH_WANT_COMPAT_SYS_TIME */
+
+#ifdef __ARCH_WANT_COMPAT_SYS_RT_SIGSUSPEND
+long compat_sys_rt_sigsuspend(compat_sigset_t __user *unewset, compat_size_t sigsetsize)
+{
+	sigset_t saveset, newset;
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
+	saveset = current->blocked;
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
diff --git a/kernel/signal.c b/kernel/signal.c
index d7611f1..5e4c240 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2623,6 +2623,32 @@ sys_pause(void)
 
 #endif
 
+#ifdef __ARCH_WANT_SYS_RT_SIGSUSPEND
+long sys_rt_sigsuspend(sigset_t __user *unewset, size_t sigsetsize)
+{
+	sigset_t saveset, newset;
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
+	saveset = current->blocked;
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


