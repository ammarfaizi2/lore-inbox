Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262727AbUKLX4d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262727AbUKLX4d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262746AbUKLXzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:55:08 -0500
Received: from pool-151-203-245-3.bos.east.verizon.net ([151.203.245.3]:28676
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262726AbUKLXsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:48:35 -0500
Message-Id: <200411130201.iAD211pT005896@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org, Blaisorblade <blaisorblade_spam@yahoo.it>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] - UML - Don't delay segfaults
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 12 Nov 2004 21:01:01 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Bodo Stroesser - This one covers the fact, that the SIGSEGV
signal, which is created by force_sigsegv() in case of an error in
handle_signal(), is not delivered to the user immediately. In the
worst case it even could be masked if a sigprocmask() systemcall
follows immediately after return from kernel. The patch is relevant
for other architectures, too.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9/arch/um/kernel/signal_kern.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/signal_kern.c	2004-11-12 16:24:20.000000000 -0500
+++ 2.6.9/arch/um/kernel/signal_kern.c	2004-11-12 16:24:21.000000000 -0500
@@ -38,9 +38,9 @@
 /*
  * OK, we're invoking a handler
  */	
-static void handle_signal(struct pt_regs *regs, unsigned long signr,
-			  struct k_sigaction *ka, siginfo_t *info,
-			  sigset_t *oldset)
+static int handle_signal(struct pt_regs *regs, unsigned long signr,
+			 struct k_sigaction *ka, siginfo_t *info,
+			 sigset_t *oldset)
 {
 	unsigned long sp;
 	int err;
@@ -94,23 +94,25 @@
 		recalc_sigpending();
 		spin_unlock_irq(&current->sighand->siglock);
 	}
+
+	return err;
 }
 
 static int kern_do_signal(struct pt_regs *regs, sigset_t *oldset)
 {
 	struct k_sigaction ka_copy;
 	siginfo_t info;
-	int sig;
+	int sig, handled_sig = 0;
 
-	sig = get_signal_to_deliver(&info, &ka_copy, regs, NULL);
-	if(sig > 0){
+	while((sig = get_signal_to_deliver(&info, &ka_copy, regs, NULL)) > 0){
+		handled_sig = 1;
 		/* Whee!  Actually deliver the signal.  */
-		handle_signal(regs, sig, &ka_copy, &info, oldset);
-		return(1);
+		if(!handle_signal(regs, sig, &ka_copy, &info, oldset))
+			break;
 	}
 
 	/* Did we come from a system call? */
-	if(PT_REGS_SYSCALL_NR(regs) >= 0){
+	if(!handled_sig && (PT_REGS_SYSCALL_NR(regs) >= 0)){
 		/* Restart the system call - no handlers present */
 		if(PT_REGS_SYSCALL_RET(regs) == -ERESTARTNOHAND ||
 		   PT_REGS_SYSCALL_RET(regs) == -ERESTARTSYS ||
@@ -134,7 +136,7 @@
 	if(current->ptrace & PT_DTRACE)
 		current->thread.singlestep_syscall =
 			is_syscall(PT_REGS_IP(&current->thread.regs));
-	return(0);
+	return(handled_sig);
 }
 
 int do_signal(void)

