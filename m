Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267521AbSLSCfw>; Wed, 18 Dec 2002 21:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267525AbSLSCfw>; Wed, 18 Dec 2002 21:35:52 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:41432 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S267521AbSLSCfs>; Wed, 18 Dec 2002 21:35:48 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] [v850]  Pass extra signal handler args correctly on the v850
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20021219024327.E62533702@mcspd15.ucom.lsi.nec.co.jp>
Date: Thu, 19 Dec 2002 11:43:27 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The old code seems completely wrong; I guess it was just left over from
whichever architecture this code was copied from.

diff -ruN -X../cludes ../orig/linux-2.5.52-uc0/arch/v850/kernel/signal.c arch/v850/kernel/signal.c
--- ../orig/linux-2.5.52-uc0/arch/v850/kernel/signal.c	2002-11-28 10:24:54.000000000 +0900
+++ arch/v850/kernel/signal.c	2002-12-19 11:37:31.000000000 +0900
@@ -147,8 +146,6 @@
 
 struct rt_sigframe
 {
-	struct siginfo *pinfo;
-	void *puc;
 	struct siginfo info;
 	struct ucontext uc;
 	unsigned long tramp[2];	/* signal trampoline */
@@ -330,10 +327,12 @@
 	if (err)
 		goto give_sigsegv;
 
-	/* Set up registers for signal handler */
-	regs->gpr[GPR_SP] = (unsigned long) frame;
-	regs->gpr[GPR_ARG0] = signal; /* Arg for signal handler */
-	regs->pc = (unsigned long) ka->sa.sa_handler;
+	/* Set up registers for signal handler.  */
+	regs->pc = (v850_reg_t) ka->sa.sa_handler;
+	regs->gpr[GPR_SP] = (v850_reg_t)frame;
+	/* Signal handler args:  */
+	regs->gpr[GPR_ARG0] = signal; /* arg 0: signum */
+	regs->gpr[GPR_ARG1] = (v850_reg_t)&frame->sc;/* arg 1: sigcontext */
 
 	set_fs(USER_DS);
 
@@ -368,8 +367,6 @@
 		? current_thread_info()->exec_domain->signal_invmap[sig]
 		: sig;
 
-	err |= __put_user(&frame->info, &frame->pinfo);
-	err |= __put_user(&frame->uc, &frame->puc);
 	err |= copy_siginfo_to_user(&frame->info, info);
 
 	/* Create the ucontext.  */
@@ -406,10 +403,13 @@
 	if (err)
 		goto give_sigsegv;
 
-	/* Set up registers for signal handler */
-	regs->gpr[GPR_SP] = (unsigned long) frame;
-	regs->gpr[GPR_ARG0] = signal; /* Arg for signal handler */
-	regs->pc = (unsigned long) ka->sa.sa_handler;
+	/* Set up registers for signal handler.  */
+	regs->pc = (v850_reg_t) ka->sa.sa_handler;
+	regs->gpr[GPR_SP] = (v850_reg_t)frame;
+	/* Signal handler args:  */
+	regs->gpr[GPR_ARG0] = signal; /* arg 0: signum */
+	regs->gpr[GPR_ARG1] = (v850_reg_t)&frame->info; /* arg 1: siginfo */
+	regs->gpr[GPR_ARG2] = (v850_reg_t)&frame->uc; /* arg 2: ucontext */
 
 	set_fs(USER_DS);
 
