Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261293AbVELBMi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbVELBMi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 21:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbVELBMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 21:12:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8884 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261293AbVELBMa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 21:12:30 -0400
Date: Wed, 11 May 2005 18:12:21 -0700
Message-Id: <200505120112.j4C1CLaO023501@magilla.sf.frob.com>
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] i386: never block forced SIGSEGV
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This problem was first noticed on PPC and has already been fixed there.
But the exact same issue applies to other platforms in the same way.  The
signal blocking for sa_mask and the handled signal takes place after the
handler setup.  When the stack is bogus, the handler setup forces a
SIGSEGV.  But then this will be blocked, and returning to user mode will
fault again and iterate.  This patch fixes the problem by checking whether
signal handler setup failed, and not doing the signal-blocking if so.  This
copies what was done in the ppc code.  I think all architectures' signal
handler setup code follows this pattern and needs the change.


Thanks,
Roland

Signed-off-by: Roland McGrath <roland@redhat.com>

--- linux-2.6/arch/i386/kernel/signal.c  (mode:100644 sha1:ea46d028af0872f5df65188503fcd9f71f3004e1)
+++ linux-2.6/arch/i386/kernel/signal.c  (mode:100644 sha1:4ab1732427c84d6932d4f32f6b4c924605f873e6)
@@ -346,8 +346,8 @@
 extern void __user __kernel_sigreturn;
 extern void __user __kernel_rt_sigreturn;
 
-static void setup_frame(int sig, struct k_sigaction *ka,
-			sigset_t *set, struct pt_regs * regs)
+static int setup_frame(int sig, struct k_sigaction *ka,
+		       sigset_t *set, struct pt_regs * regs)
 {
 	void __user *restorer;
 	struct sigframe __user *frame;
@@ -429,13 +429,14 @@
 		current->comm, current->pid, frame, regs->eip, frame->pretcode);
 #endif
 
-	return;
+	return 1;
 
 give_sigsegv:
 	force_sigsegv(sig, current);
+	return 0;
 }
 
-static void setup_rt_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
+static int setup_rt_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
 			   sigset_t *set, struct pt_regs * regs)
 {
 	void __user *restorer;
@@ -522,20 +523,23 @@
 		current->comm, current->pid, frame, regs->eip, frame->pretcode);
 #endif
 
-	return;
+	return 1;
 
 give_sigsegv:
 	force_sigsegv(sig, current);
+	return 0;
 }
 
 /*
  * OK, we're invoking a handler
  */	
 
-static void
+static int
 handle_signal(unsigned long sig, siginfo_t *info, struct k_sigaction *ka,
 	      sigset_t *oldset,	struct pt_regs * regs)
 {
+	int ret;
+
 	/* Are we from a system call? */
 	if (regs->orig_eax >= 0) {
 		/* If so, check system call restarting.. */
@@ -569,17 +573,19 @@
 
 	/* Set up the stack frame */
 	if (ka->sa.sa_flags & SA_SIGINFO)
-		setup_rt_frame(sig, ka, info, oldset, regs);
+		ret = setup_rt_frame(sig, ka, info, oldset, regs);
 	else
-		setup_frame(sig, ka, oldset, regs);
+		ret = setup_frame(sig, ka, oldset, regs);
 
-	if (!(ka->sa.sa_flags & SA_NODEFER)) {
+	if (ret && !(ka->sa.sa_flags & SA_NODEFER)) {
 		spin_lock_irq(&current->sighand->siglock);
 		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
 		sigaddset(&current->blocked,sig);
 		recalc_sigpending();
 		spin_unlock_irq(&current->sighand->siglock);
 	}
+
+	return ret;
 }
 
 /*
@@ -622,8 +628,7 @@
 		}
 
 		/* Whee!  Actually deliver the signal.  */
-		handle_signal(signr, &info, &ka, oldset, regs);
-		return 1;
+		return handle_signal(signr, &info, &ka, oldset, regs);
 	}
 
  no_signal:
