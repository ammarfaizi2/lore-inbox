Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261296AbVELBO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbVELBO5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 21:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbVELBO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 21:14:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15029 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261296AbVELBOi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 21:14:38 -0400
Date: Wed, 11 May 2005 18:14:31 -0700
Message-Id: <200505120114.j4C1EVrr023955@magilla.sf.frob.com>
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] x86_64: never block forced SIGSEGV
X-Shopping-List: (1) Joyous oblivion
   (2) Sympathetic complicators
   (3) Conscious dogboys
   (4) Lily-livered domestic hamster-lip aspersions
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the x86_64 version of the signal fix I just posted for i386.


Thanks,
Roland

Signed-off-by: Roland McGrath <roland@redhat.com>

--- linux-2.6/arch/x86_64/ia32/ia32_signal.c  (mode:100644 sha1:fbd09b5126ce43038df29170ffec7c311a792bea)
+++ linux-2.6/arch/x86_64/ia32/ia32_signal.c  (mode:100644 sha1:be8c7e00eb0c0bb4dfb4d95210c80fbe067e2798)
@@ -428,8 +428,8 @@
 	return (void __user *)((rsp - frame_size) & -8UL);
 }
 
-void ia32_setup_frame(int sig, struct k_sigaction *ka,
-			compat_sigset_t *set, struct pt_regs * regs)
+int ia32_setup_frame(int sig, struct k_sigaction *ka,
+		     compat_sigset_t *set, struct pt_regs * regs)
 {
 	struct sigframe __user *frame;
 	int err = 0;
@@ -514,14 +514,15 @@
 		current->comm, current->pid, frame, regs->rip, frame->pretcode);
 #endif
 
-	return;
+	return 1;
 
 give_sigsegv:
 	force_sigsegv(sig, current);
+	return 0;
 }
 
-void ia32_setup_rt_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
-			   compat_sigset_t *set, struct pt_regs * regs)
+int ia32_setup_rt_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
+			compat_sigset_t *set, struct pt_regs * regs)
 {
 	struct rt_sigframe __user *frame;
 	int err = 0;
@@ -613,9 +614,9 @@
 		current->comm, current->pid, frame, regs->rip, frame->pretcode);
 #endif
 
-	return;
+	return 1;
 
 give_sigsegv:
 	force_sigsegv(sig, current);
+	return 0;
 }
-
--- linux-2.6/arch/x86_64/kernel/signal.c  (mode:100644 sha1:d439ced150c603c33cbc2220bec5532654822b86)
+++ linux-2.6/arch/x86_64/kernel/signal.c  (mode:100644 sha1:062179bca6eaa0179e321335daa5402d0cf7d8bc)
@@ -33,9 +33,9 @@
 
 #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
 
-void ia32_setup_rt_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
+int ia32_setup_rt_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
                sigset_t *set, struct pt_regs * regs); 
-void ia32_setup_frame(int sig, struct k_sigaction *ka,
+int ia32_setup_frame(int sig, struct k_sigaction *ka,
             sigset_t *set, struct pt_regs * regs); 
 
 asmlinkage long
@@ -237,7 +237,7 @@
 	return (void __user *)round_down(rsp - size, 16); 
 }
 
-static void setup_rt_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
+static int setup_rt_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
 			   sigset_t *set, struct pt_regs * regs)
 {
 	struct rt_sigframe __user *frame;
@@ -326,20 +326,23 @@
 		current->comm, current->pid, frame, regs->rip, frame->pretcode);
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
 		sigset_t *oldset, struct pt_regs *regs)
 {
+	int ret;
+
 #ifdef DEBUG_SIG
 	printk("handle_signal pid:%d sig:%lu rip:%lx rsp:%lx regs=%p\n",
 		current->pid, sig,
@@ -383,20 +386,22 @@
 #ifdef CONFIG_IA32_EMULATION
 	if (test_thread_flag(TIF_IA32)) {
 		if (ka->sa.sa_flags & SA_SIGINFO)
-			ia32_setup_rt_frame(sig, ka, info, oldset, regs);
+			ret = ia32_setup_rt_frame(sig, ka, info, oldset, regs);
 		else
-			ia32_setup_frame(sig, ka, oldset, regs);
+			ret = ia32_setup_frame(sig, ka, oldset, regs);
 	} else 
 #endif
-	setup_rt_frame(sig, ka, info, oldset, regs);
+	ret = setup_rt_frame(sig, ka, info, oldset, regs);
 
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
@@ -436,8 +441,7 @@
 			asm volatile("movq %0,%%db7"	: : "r" (current->thread.debugreg7));
 
 		/* Whee!  Actually deliver the signal.  */
-		handle_signal(signr, &info, &ka, oldset, regs);
-		return 1;
+		return handle_signal(signr, &info, &ka, oldset, regs);
 	}
 
  no_signal:
