Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262723AbUKLX4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262723AbUKLX4c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262743AbUKLXyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:54:32 -0500
Received: from pool-151-203-245-3.bos.east.verizon.net ([151.203.245.3]:27652
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262720AbUKLXsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:48:32 -0500
Message-Id: <200411130200.iAD20tpT005874@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org, Blaisorblade <blaisorblade_spam@yahoo.it>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 6/11] - UML - handle_signal simplification
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 12 Nov 2004 21:00:55 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Bodo Stroesser - Move the signal delivery code around to eliminate
a couple of temporary variables.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9/arch/um/kernel/signal_kern.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/signal_kern.c	2004-11-12 16:22:23.000000000 -0500
+++ 2.6.9/arch/um/kernel/signal_kern.c	2004-11-12 18:05:28.000000000 -0500
@@ -42,10 +42,8 @@
 			  struct k_sigaction *ka, siginfo_t *info,
 			  sigset_t *oldset)
 {
-        __sighandler_t handler;
 	void (*restorer)(void);
 	unsigned long sp;
-	sigset_t save;
 	int err, error, ret;
 
 	error = PT_REGS_SYSCALL_RET(&current->thread.regs);
@@ -79,11 +77,24 @@
 		break;
 	}
 
-	handler = ka->sa.sa_handler;
-	save = *oldset;
+	sp = PT_REGS_SP(regs);
+	if((ka->sa.sa_flags & SA_ONSTACK) && (sas_ss_flags(sp) == 0))
+		sp = current->sas_ss_sp + current->sas_ss_size;
 
-	if (ka->sa.sa_flags & SA_ONESHOT)
-		ka->sa.sa_handler = SIG_DFL;
+	if(error != 0) PT_REGS_SET_SYSCALL_RETURN(regs, ret);
+
+	if (ka->sa.sa_flags & SA_RESTORER) 
+		restorer = ka->sa.sa_restorer;
+	else restorer = NULL;
+
+	if(ka->sa.sa_flags & SA_SIGINFO)
+		err = setup_signal_stack_si(sp, signr, 
+					    (unsigned long) ka->sa.sa_handler,
+					    restorer, regs, info, oldset);
+	else
+		err = setup_signal_stack_sc(sp, signr, 
+					    (unsigned long) ka->sa.sa_handler,
+					    restorer, regs, oldset);
 
 	if (!(ka->sa.sa_flags & SA_NODEFER)) {
 		spin_lock_irq(&current->sighand->siglock);
@@ -94,23 +105,6 @@
 		spin_unlock_irq(&current->sighand->siglock);
 	}
 
-	sp = PT_REGS_SP(regs);
-
-	if((ka->sa.sa_flags & SA_ONSTACK) && (sas_ss_flags(sp) == 0))
-		sp = current->sas_ss_sp + current->sas_ss_size;
-	
-	if(error != 0)
-		PT_REGS_SET_SYSCALL_RETURN(regs, ret);
-
-	if (ka->sa.sa_flags & SA_RESTORER) restorer = ka->sa.sa_restorer;
-	else restorer = NULL;
-
-	if(ka->sa.sa_flags & SA_SIGINFO)
-		err = setup_signal_stack_si(sp, signr, (unsigned long) handler,
-					    restorer, regs, info, &save);
-	else
-		err = setup_signal_stack_sc(sp, signr, (unsigned long) handler,
-					    restorer, regs, &save);
 	if(err)
 		force_sigsegv(signr, current);
 }

