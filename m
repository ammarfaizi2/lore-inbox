Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263140AbUJ2ISq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263140AbUJ2ISq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 04:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263144AbUJ2ISp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 04:18:45 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:15007 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S263140AbUJ2IRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 04:17:30 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] v850: signal handling race fix
Cc: linux-kernel@vger.kernel.org
From: Miles Bader <miles@gnu.org>
Message-Id: <20041029081548.0DE214D9@mctpc71>
Date: Fri, 29 Oct 2004 17:15:48 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Miles Bader <miles@gnu.org>

 arch/v850/kernel/signal.c |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff -ruN -X../cludes linux-2.6.9-uc0/arch/v850/kernel/signal.c linux-2.6.9-uc0-v850-20041028/arch/v850/kernel/signal.c
--- linux-2.6.9-uc0/arch/v850/kernel/signal.c	2004-10-25 15:14:32 +0900
+++ linux-2.6.9-uc0-v850-20041028/arch/v850/kernel/signal.c	2004-10-28 13:32:47 +0900
@@ -427,11 +427,9 @@
  */	
 
 static void
-handle_signal(unsigned long sig, siginfo_t *info, sigset_t *oldset,
-	struct pt_regs * regs)
+handle_signal(unsigned long sig, siginfo_t *info, struct k_sigaction *ka,
+	      sigset_t *oldset,	struct pt_regs * regs)
 {
-	struct k_sigaction *ka = &current->sighand->action[sig-1];
-
 	/* Are we from a system call? */
 	if (PT_REGS_SYSCALL (regs)) {
 		/* If so, check system call restarting.. */
@@ -464,9 +462,6 @@
 	else
 		setup_frame(sig, ka, oldset, regs);
 
-	if (ka->sa.sa_flags & SA_ONESHOT)
-		ka->sa.sa_handler = SIG_DFL;
-
 	if (!(ka->sa.sa_flags & SA_NODEFER)) {
 		spin_lock_irq(&current->sighand->siglock);
 		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
@@ -489,6 +484,7 @@
 {
 	siginfo_t info;
 	int signr;
+	struct k_sigaction ka;
 
 	/*
 	 * We want the common case to go fast, which
@@ -502,10 +498,10 @@
 	if (!oldset)
 		oldset = &current->blocked;
 
-	signr = get_signal_to_deliver(&info, regs, NULL);
+	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
 	if (signr > 0) {
 		/* Whee!  Actually deliver the signal.  */
-		handle_signal(signr, &info, oldset, regs);
+		handle_signal(signr, &info, &ka, oldset, regs);
 		return 1;
 	}
 
