Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262477AbUKQSrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262477AbUKQSrS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 13:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262492AbUKQSpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 13:45:09 -0500
Received: from pool-151-203-245-3.bos.east.verizon.net ([151.203.245.3]:7684
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262417AbUKQSmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 13:42:45 -0500
Message-Id: <200411172056.iAHKu9Q3004642@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: user-mode-linux-devel@lists.sourceforge.net,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Bug report for UML in latest Linus 2.6-BK repository. 
In-Reply-To: Your message of "Tue, 16 Nov 2004 13:38:27 GMT."
             <1100612306.24599.37.camel@imp.csi.cam.ac.uk> 
References: <1100612306.24599.37.camel@imp.csi.cam.ac.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 17 Nov 2004 15:56:09 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

aia21@cam.ac.uk said:
> I get millions of these on the UML guest as soon as I start UML
> (.config is below), notably HIGHMEM is not enabled in the .config.
> They only stop when I shutdown.

The patch below fixes those for me.

				Jeff

Index: 2.6.9/arch/um/sys-i386/signal.c
===================================================================
--- 2.6.9.orig/arch/um/sys-i386/signal.c	2004-11-16 23:19:45.000000000 -0500
+++ 2.6.9/arch/um/sys-i386/signal.c	2004-11-16 23:27:54.000000000 -0500
@@ -305,35 +305,58 @@
 {
 	unsigned long __user sp = PT_REGS_SP(&current->thread.regs);
 	struct sigframe __user *frame = (struct sigframe *)(sp - 8);
+	sigset_t set;
 	struct sigcontext __user *sc = &frame->sc;
 	unsigned long __user *mask = &sc->oldmask;
 	int sig_size = (_NSIG_WORDS - 1) * sizeof(unsigned long);
 
+	if(copy_from_user(&set.sig[0], mask, sizeof(&set.sig[0])) ||
+	   copy_from_user(&set.sig[1], mask, sig_size))
+		goto segfault;
+
+	sigdelsetmask(&set, ~_BLOCKABLE);
+
 	spin_lock_irq(&current->sighand->siglock);
-	copy_from_user(&current->blocked.sig[0], mask,
-		       sizeof(current->blocked.sig[0]));
-	copy_from_user(&current->blocked.sig[1], mask, sig_size);
-	sigdelsetmask(&current->blocked, ~_BLOCKABLE);
+	current->blocked = set;
 	recalc_sigpending();
 	spin_unlock_irq(&current->sighand->siglock);
-	copy_sc_from_user(&current->thread.regs, sc);
+
+	if(copy_sc_from_user(&current->thread.regs, sc))
+		goto segfault;
+
 	return(PT_REGS_SYSCALL_RET(&current->thread.regs));
+
+ segfault:
+	force_sig(SIGSEGV, current);
+	return 0;
 }
 
 long sys_rt_sigreturn(struct pt_regs regs)
 {
 	unsigned long __user sp = PT_REGS_SP(&current->thread.regs);
 	struct rt_sigframe __user *frame = (struct rt_sigframe *) (sp - 4);
+	sigset_t set;
 	struct ucontext __user *uc = &frame->uc;
 	int sig_size = _NSIG_WORDS * sizeof(unsigned long);
 
+	if(copy_from_user(&set, &uc->uc_sigmask, sig_size))
+		goto segfault;
+
+	sigdelsetmask(&set, ~_BLOCKABLE);
+
 	spin_lock_irq(&current->sighand->siglock);
-	copy_from_user(&current->blocked, &uc->uc_sigmask, sig_size);
-	sigdelsetmask(&current->blocked, ~_BLOCKABLE);
+	current->blocked = set;
 	recalc_sigpending();
 	spin_unlock_irq(&current->sighand->siglock);
-	copy_sc_from_user(&current->thread.regs, &uc->uc_mcontext);
+
+	if(copy_sc_from_user(&current->thread.regs, &uc->uc_mcontext))
+		goto segfault;
+
 	return(PT_REGS_SYSCALL_RET(&current->thread.regs));
+
+ segfault:
+	force_sig(SIGSEGV, current);
+	return 0;
 }
 
 /*

