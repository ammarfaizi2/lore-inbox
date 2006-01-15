Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751671AbWAOFmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751671AbWAOFmF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 00:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751727AbWAOFmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 00:42:04 -0500
Received: from [198.99.130.12] ([198.99.130.12]:22428 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751671AbWAOFmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 00:42:00 -0500
Message-Id: <200601150633.k0F6Xa4u015465@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Miklos Szeredi <miklos@szeredi.hu>, dwmw2@infradead.org,
       David Howells <dhowells@redhat.com>,
       "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 2/3] UML - Use generic sys_rt_sigsuspend
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 15 Jan 2006 01:33:36 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the generic sys_rt_sigsuspend.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15-mm/arch/um/kernel/signal_kern.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/kernel/signal_kern.c	2006-01-14 19:06:20.000000000 -0500
+++ linux-2.6.15-mm/arch/um/kernel/signal_kern.c	2006-01-14 19:07:05.000000000 -0500
@@ -185,30 +185,6 @@ long sys_sigsuspend(int history0, int hi
 	return -ERESTARTNOHAND;
 }
 
-long sys_rt_sigsuspend(sigset_t __user *unewset, size_t sigsetsize)
-{
-	sigset_t newset;
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
-	current->saved_sigmask = current->blocked;
-	current->blocked = newset;
-	recalc_sigpending();
-	spin_unlock_irq(&current->sighand->siglock);
-
-	current->state = TASK_INTERRUPTIBLE;
-	schedule();
-	set_thread_flag(TIF_RESTORE_SIGMASK);
-	return -ERESTARTNOHAND;
-}
-
 long sys_sigaltstack(const stack_t __user *uss, stack_t __user *uoss)
 {
 	return(do_sigaltstack(uss, uoss, PT_REGS_SP(&current->thread.regs)));
Index: linux-2.6.15-mm/include/asm-um/unistd.h
===================================================================
--- linux-2.6.15-mm.orig/include/asm-um/unistd.h	2006-01-14 18:50:04.000000000 -0500
+++ linux-2.6.15-mm/include/asm-um/unistd.h	2006-01-14 19:06:46.000000000 -0500
@@ -34,6 +34,7 @@ extern int um_execve(const char *file, c
 #define __ARCH_WANT_SYS_SIGPENDING
 #define __ARCH_WANT_SYS_SIGPROCMASK
 #define __ARCH_WANT_SYS_RT_SIGACTION
+#define __ARCH_WANT_SYS_RT_SIGSUSPEND
 #endif
 
 #ifdef __KERNEL_SYSCALLS__

