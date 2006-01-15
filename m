Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbWAOUsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWAOUsY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 15:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbWAOUsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 15:48:11 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:31139 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1750788AbWAOUrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 15:47:53 -0500
Message-Id: <200601152139.k0FLdsTv027758@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Subject: [PATCH 11/11] UML - TT mode softint fixes
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 15 Jan 2006 16:39:54 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

Some fixes to make softints work in tt mode.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15-mm/arch/um/kernel/time_kern.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/kernel/time_kern.c	2006-01-06 21:49:51.000000000 -0500
+++ linux-2.6.15-mm/arch/um/kernel/time_kern.c	2006-01-06 22:06:42.000000000 -0500
@@ -187,8 +187,9 @@ void timer_handler(int sig, union uml_pt
 {
 	local_irq_disable();
 	irq_enter();
-	update_process_times(CHOOSE_MODE(user_context(UPT_SP(regs)),
-					 (regs)->skas.is_user));
+	update_process_times(CHOOSE_MODE(
+	                     (UPT_SC(regs) && user_context(UPT_SP(regs))),
+			     (regs)->skas.is_user));
 	irq_exit();
 	local_irq_enable();
 	if(current_thread->cpu == 0)
Index: linux-2.6.15-mm/arch/um/kernel/tt/trap_user.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/kernel/tt/trap_user.c	2006-01-06 21:46:18.000000000 -0500
+++ linux-2.6.15-mm/arch/um/kernel/tt/trap_user.c	2006-01-06 22:06:42.000000000 -0500
@@ -18,7 +18,7 @@ void sig_handler_common_tt(int sig, void
 {
 	struct sigcontext *sc = sc_ptr;
 	struct tt_regs save_regs, *r;
-	int save_errno = errno, is_user;
+	int save_errno = errno, is_user = 0;
 	void (*handler)(int, union uml_pt_regs *);
 
 	/* This is done because to allow SIGSEGV to be delivered inside a SEGV
@@ -35,7 +35,8 @@ void sig_handler_common_tt(int sig, void
                 GET_FAULTINFO_FROM_SC(r->faultinfo, sc);
         }
 	save_regs = *r;
-	is_user = user_context(SC_SP(sc));
+	if (sc)
+		is_user = user_context(SC_SP(sc));
 	r->sc = sc;
 	if(sig != SIGUSR2) 
 		r->syscall = -1;

