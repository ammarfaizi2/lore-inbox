Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932568AbWAJUSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932568AbWAJUSx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 15:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932563AbWAJUSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 15:18:52 -0500
Received: from canuck.infradead.org ([205.233.218.70]:56249 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S932560AbWAJUSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 15:18:50 -0500
Subject: [PATCH] [3/6] Generic sys_rt_sigsuspend()
From: David Woodhouse <dwmw2@infradead.org>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, drepper@redhat.com
In-Reply-To: <1136923488.3435.78.camel@localhost.localdomain>
References: <1136923488.3435.78.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 10 Jan 2006 20:18:50 +0000
Message-Id: <1136924331.3435.105.camel@localhost.localdomain>
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

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

 arch/powerpc/kernel/signal_32.c |   56 +++-------------------------------------
 arch/powerpc/kernel/signal_64.c |   36 -------------------------
 include/asm-powerpc/unistd.h    |    2 +
 kernel/compat.c                 |   28 ++++++++++++++++++++
 kernel/signal.c                 |   26 ++++++++++++++++++
 5 files changed, 61 insertions(+), 87 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 784a4c2..a12d0a5 100644
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
index 2903e11..7a6f0f7 100644
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
diff --git a/include/asm-powerpc/unistd.h b/include/asm-powerpc/unistd.h
index e9cb713..a40cdff 100644
--- a/include/asm-powerpc/unistd.h
+++ b/include/asm-powerpc/unistd.h
@@ -446,11 +446,13 @@ type name(type1 arg1, type2 arg2, type3 
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
diff --git a/kernel/compat.c b/kernel/compat.c
index 256e5d9..da03f69 100644
--- a/kernel/compat.c
+++ b/kernel/compat.c
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
diff --git a/kernel/signal.c b/kernel/signal.c
index 08aa5b2..f859761 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
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

