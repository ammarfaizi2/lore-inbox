Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262326AbUKKRsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262326AbUKKRsU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 12:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbUKKRrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 12:47:14 -0500
Received: from pool-151-203-245-3.bos.east.verizon.net ([151.203.245.3]:7940
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262326AbUKKRoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 12:44:25 -0500
Message-Id: <200411111957.iABJvHPV004137@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org, Blaisorblade <blaisorblade_spam@yahoo.it>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML - signal bug fix
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 11 Nov 2004 14:57:17 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a bug introduced in the last batch of signal fixes.  The
system call return value should only be reset if called diectly from a system
call, i.e. sigsuspend.  The fixes added earlier caused any interrupted non-zero
system call return to be reset, confusing fork and vfork, among others.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9/arch/um/kernel/signal_kern.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/signal_kern.c	2004-11-08 19:14:45.000000000 -0500
+++ 2.6.9/arch/um/kernel/signal_kern.c	2004-11-11 11:44:05.000000000 -0500
@@ -40,19 +40,19 @@
  */	
 static void handle_signal(struct pt_regs *regs, unsigned long signr,
 			  struct k_sigaction *ka, siginfo_t *info,
-			  sigset_t *oldset)
+			  sigset_t *oldset, int error)
 {
         __sighandler_t handler;
 	void (*restorer)(void);
 	unsigned long sp;
 	sigset_t save;
-	int error, err, ret;
+	int err, ret;
 
-	error = PT_REGS_SYSCALL_RET(&current->thread.regs);
+	err = PT_REGS_SYSCALL_RET(&current->thread.regs);
 	ret = 0;
 	/* Always make any pending restarted system calls return -EINTR */
 	current_thread_info()->restart_block.fn = do_no_restart_syscall;
-	switch(error){
+	switch(err){
 	case -ERESTART_RESTARTBLOCK:
 	case -ERESTARTNOHAND:
 		ret = -EINTR;
@@ -99,7 +99,8 @@
 	if((ka->sa.sa_flags & SA_ONSTACK) && (sas_ss_flags(sp) == 0))
 		sp = current->sas_ss_sp + current->sas_ss_size;
 	
-	if(error != 0) PT_REGS_SET_SYSCALL_RETURN(regs, ret);
+	if(error != 0)
+		PT_REGS_SET_SYSCALL_RETURN(regs, ret);
 
 	if (ka->sa.sa_flags & SA_RESTORER) restorer = ka->sa.sa_restorer;
 	else restorer = NULL;
@@ -114,7 +115,7 @@
 		force_sigsegv(signr, current);
 }
 
-static int kern_do_signal(struct pt_regs *regs, sigset_t *oldset)
+static int kern_do_signal(struct pt_regs *regs, sigset_t *oldset, int error)
 {
 	struct k_sigaction ka_copy;
 	siginfo_t info;
@@ -126,7 +127,7 @@
 	sig = get_signal_to_deliver(&info, &ka_copy, regs, NULL);
 	if(sig > 0){
 		/* Whee!  Actually deliver the signal.  */
-		handle_signal(regs, sig, &ka_copy, &info, oldset);
+		handle_signal(regs, sig, &ka_copy, &info, oldset, error);
 		return(1);
 	}
 
@@ -160,7 +161,7 @@
 
 int do_signal(int error)
 {
-	return(kern_do_signal(&current->thread.regs, NULL));
+	return(kern_do_signal(&current->thread.regs, NULL, error));
 }
 
 /*
@@ -181,7 +182,7 @@
 	while (1) {
 		current->state = TASK_INTERRUPTIBLE;
 		schedule();
-		if(kern_do_signal(&current->thread.regs, &saveset))
+		if(kern_do_signal(&current->thread.regs, &saveset, -EINTR))
 			return(-EINTR);
 	}
 }
@@ -208,7 +209,7 @@
 	while (1) {
 		current->state = TASK_INTERRUPTIBLE;
 		schedule();
-		if (kern_do_signal(&current->thread.regs, &saveset))
+		if (kern_do_signal(&current->thread.regs, &saveset, -EINTR))
 			return(-EINTR);
 	}
 }

