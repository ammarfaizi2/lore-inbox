Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262739AbUKMAbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262739AbUKMAbc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 19:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262747AbUKLXzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:55:44 -0500
Received: from pool-151-203-245-3.bos.east.verizon.net ([151.203.245.3]:29700
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262739AbUKLXsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:48:36 -0500
Message-Id: <200411130200.iAD20wpT005884@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org, Blaisorblade <blaisorblade_spam@yahoo.it>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 8/11] - UML - make signal frame construction more resemble x86
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 12 Nov 2004 21:00:58 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Bodo Stroesser - This makes the UML signal frame construction interface 
somewhat more similar to x86 than before.  Also, some small code cleanup, 
and checking for errors before changing the signal mask in the SA_NODEFER 
case.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9/arch/um/include/frame_kern.h
===================================================================
--- 2.6.9.orig/arch/um/include/frame_kern.h	2004-11-12 16:21:46.000000000 -0500
+++ 2.6.9/arch/um/include/frame_kern.h	2004-11-12 16:24:18.000000000 -0500
@@ -10,13 +10,11 @@
 #include "sysdep/frame_kern.h"
 
 extern int setup_signal_stack_sc(unsigned long stack_top, int sig, 
-				 unsigned long handler,
-				 void (*restorer)(void), 
+				 struct k_sigaction *ka,
 				 struct pt_regs *regs, 
 				 sigset_t *mask);
 extern int setup_signal_stack_si(unsigned long stack_top, int sig, 
-				 unsigned long handler, 
-				 void (*restorer)(void), 
+				 struct k_sigaction *ka,
 				 struct pt_regs *regs, siginfo_t *info, 
 				 sigset_t *mask);
 
Index: 2.6.9/arch/um/kernel/frame_kern.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/frame_kern.c	2004-11-12 16:21:46.000000000 -0500
+++ 2.6.9/arch/um/kernel/frame_kern.c	2004-11-12 16:24:18.000000000 -0500
@@ -56,11 +56,11 @@
 }
 
 int setup_signal_stack_si(unsigned long stack_top, int sig, 
-			  unsigned long handler, void (*restorer)(void), 
-			  struct pt_regs *regs, siginfo_t *info, 
-			  sigset_t *mask)
+			  struct k_sigaction *ka, struct pt_regs *regs, 
+			  siginfo_t *info, sigset_t *mask)
 {
 	unsigned long start;
+	void *restorer;
 	void *sip, *ucp, *fp;
 
 	start = stack_top - signal_frame_si.common.len;
@@ -68,6 +68,10 @@
 	ucp = (void *) (start + signal_frame_si.uc_index);
 	fp = (void *) (((unsigned long) ucp) + sizeof(struct ucontext));
 
+	restorer = NULL;
+	if(ka->sa.sa_flags & SA_RESTORER)
+		restorer = ka->sa.sa_restorer;
+
 	if(restorer == NULL)
 		panic("setup_signal_stack_si - no restorer");
 
@@ -85,21 +89,26 @@
 			 signal_frame_si.common.sr_relative))
 		return(1);
 	
-	PT_REGS_IP(regs) = handler;
+	PT_REGS_IP(regs) = (unsigned long) ka->sa.sa_handler;
 	PT_REGS_SP(regs) = start + signal_frame_si.common.sp_index;
 	return(0);
 }
 
 int setup_signal_stack_sc(unsigned long stack_top, int sig, 
-			  unsigned long handler, void (*restorer)(void), 
-			  struct pt_regs *regs, sigset_t *mask)
+			  struct k_sigaction *ka, struct pt_regs *regs, 
+			  sigset_t *mask)
 {
 	struct frame_common *frame = &signal_frame_sc_sr.common;
+	void *restorer;
 	void *user_sc;
 	int sig_size = (_NSIG_WORDS - 1) * sizeof(unsigned long);
 	unsigned long sigs, sr;
 	unsigned long start = stack_top - frame->len - sig_size;
 
+	restorer = NULL;
+	if(ka->sa.sa_flags & SA_RESTORER)
+		restorer = ka->sa.sa_restorer;
+
 	user_sc = (void *) (start + signal_frame_sc_sr.sc_index);
 	if(restorer == NULL){
 		frame = &signal_frame_sc.common;
@@ -121,7 +130,7 @@
 	   copy_restorer(restorer, start, frame->sr_index, frame->sr_relative))
 		return(1);
 
-	PT_REGS_IP(regs) = handler;
+	PT_REGS_IP(regs) = (unsigned long) ka->sa.sa_handler;
 	PT_REGS_SP(regs) = start + frame->sp_index;
 
 	return(0);
Index: 2.6.9/arch/um/kernel/signal_kern.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/signal_kern.c	2004-11-12 16:24:17.000000000 -0500
+++ 2.6.9/arch/um/kernel/signal_kern.c	2004-11-12 18:05:26.000000000 -0500
@@ -42,7 +42,6 @@
 			  struct k_sigaction *ka, siginfo_t *info,
 			  sigset_t *oldset)
 {
-	void (*restorer)(void);
 	unsigned long sp;
 	int err;
 
@@ -75,20 +74,12 @@
 	if((ka->sa.sa_flags & SA_ONSTACK) && (sas_ss_flags(sp) == 0))
 		sp = current->sas_ss_sp + current->sas_ss_size;
 
-	if (ka->sa.sa_flags & SA_RESTORER) 
-		restorer = ka->sa.sa_restorer;
-	else restorer = NULL;
-
 	if(ka->sa.sa_flags & SA_SIGINFO)
-		err = setup_signal_stack_si(sp, signr, 
-					    (unsigned long) ka->sa.sa_handler,
-					    restorer, regs, info, oldset);
+		err = setup_signal_stack_si(sp, signr, ka, regs, info, oldset);
 	else
-		err = setup_signal_stack_sc(sp, signr, 
-					    (unsigned long) ka->sa.sa_handler,
-					    restorer, regs, oldset);
+		err = setup_signal_stack_sc(sp, signr, ka, regs, oldset);
 
-	if (!(ka->sa.sa_flags & SA_NODEFER)) {
+	if (!err && !(ka->sa.sa_flags & SA_NODEFER)) {
 		spin_lock_irq(&current->sighand->siglock);
 		sigorsets(&current->blocked, &current->blocked, 
 			  &ka->sa.sa_mask);
@@ -107,9 +98,6 @@
 	siginfo_t info;
 	int sig;
 
-	if (!oldset)
-		oldset = &current->blocked;
-
 	sig = get_signal_to_deliver(&info, &ka_copy, regs, NULL);
 	if(sig > 0){
 		/* Whee!  Actually deliver the signal.  */
@@ -147,7 +135,7 @@
 
 int do_signal(void)
 {
-	return(kern_do_signal(&current->thread.regs, NULL));
+	return(kern_do_signal(&current->thread.regs, &current->blocked));
 }
 
 /*

