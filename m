Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262683AbUKLX4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262683AbUKLX4c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262724AbUKLXyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:54:17 -0500
Received: from pool-151-203-245-3.bos.east.verizon.net ([151.203.245.3]:25604
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262723AbUKLXs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:48:26 -0500
Message-Id: <200411130200.iAD20qpT005869@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org, Blaisorblade <blaisorblade_spam@yahoo.it>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 5/11] - UML - redundant argument removal from handle_signal
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 12 Nov 2004 21:00:52 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Bodo Stroesser - Change the interface to handle_signal so that it
doesn't take the system call return value as an argument and eliminate
its return value.
kern_do_signal also now doesn't return immediately after determining that
there is no signal to deliver.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9/arch/um/kernel/signal_kern.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/signal_kern.c	2004-11-12 13:42:57.000000000 -0500
+++ 2.6.9/arch/um/kernel/signal_kern.c	2004-11-12 18:05:28.000000000 -0500
@@ -40,19 +40,19 @@
  */	
 static void handle_signal(struct pt_regs *regs, unsigned long signr,
 			  struct k_sigaction *ka, siginfo_t *info,
-			  sigset_t *oldset, int error)
+			  sigset_t *oldset)
 {
         __sighandler_t handler;
 	void (*restorer)(void);
 	unsigned long sp;
 	sigset_t save;
-	int err, ret;
+	int err, error, ret;
 
-	err = PT_REGS_SYSCALL_RET(&current->thread.regs);
+	error = PT_REGS_SYSCALL_RET(&current->thread.regs);
 	ret = 0;
 	/* Always make any pending restarted system calls return -EINTR */
 	current_thread_info()->restart_block.fn = do_no_restart_syscall;
-	switch(err){
+	switch(error){
 	case -ERESTART_RESTARTBLOCK:
 	case -ERESTARTNOHAND:
 		ret = -EINTR;
@@ -115,7 +115,7 @@
 		force_sigsegv(signr, current);
 }
 
-static int kern_do_signal(struct pt_regs *regs, sigset_t *oldset, int error)
+static int kern_do_signal(struct pt_regs *regs, sigset_t *oldset)
 {
 	struct k_sigaction ka_copy;
 	siginfo_t info;
@@ -127,7 +127,7 @@
 	sig = get_signal_to_deliver(&info, &ka_copy, regs, NULL);
 	if(sig > 0){
 		/* Whee!  Actually deliver the signal.  */
-		handle_signal(regs, sig, &ka_copy, &info, oldset, error);
+		handle_signal(regs, sig, &ka_copy, &info, oldset);
 		return(1);
 	}
 
@@ -161,8 +161,7 @@
 
 int do_signal(void)
 {
-	return(kern_do_signal(&current->thread.regs, NULL, 
-			      PT_REGS_SYSCALL_RET(&current->thread.regs)));
+	return(kern_do_signal(&current->thread.regs, NULL));
 }
 
 /*
@@ -183,7 +182,7 @@
 	while (1) {
 		current->state = TASK_INTERRUPTIBLE;
 		schedule();
-		if(kern_do_signal(&current->thread.regs, &saveset, -EINTR))
+		if(kern_do_signal(&current->thread.regs, &saveset))
 			return(-EINTR);
 	}
 }
@@ -210,7 +209,7 @@
 	while (1) {
 		current->state = TASK_INTERRUPTIBLE;
 		schedule();
-		if (kern_do_signal(&current->thread.regs, &saveset, -EINTR))
+		if (kern_do_signal(&current->thread.regs, &saveset))
 			return(-EINTR);
 	}
 }

