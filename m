Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262726AbUKLX4d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262726AbUKLX4d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262745AbUKLXyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:54:54 -0500
Received: from pool-151-203-245-3.bos.east.verizon.net ([151.203.245.3]:28420
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262727AbUKLXse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:48:34 -0500
Message-Id: <200411130201.iAD210pT005889@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org, Blaisorblade <blaisorblade_spam@yahoo.it>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 9/11] - UML - fix signal mask on delivery error
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 12 Nov 2004 21:01:00 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Bodo Stroesser - If the user stack limit is reached or the
signal stack assigned with sigaltstack() is invalid when a user signal
handler with SA_ONSTACK has to be started, the signal mask of the
interrupted user program is modified. This happens because the mask,
that should be used with the handler only, is written to
"current->blocked" even if the handler could not be started. But
without a handler, no rewrite of the original mask at sys_sigreturn
will be done. A slightly different case is sys_sigsuspend(), where the
mask is already modified when kern_do_signal() is started. "*oldset" and
"current->blocked" are not equal here and thus current->blocked has to
be set to *oldset, if an error occurs in handle_signal().
For both cases I've written small tests, and with the patch the result
is OK.
This issue is relevant for other architectures too (e.g. i386, I've
seen).

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9/arch/um/kernel/signal_kern.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/signal_kern.c	2004-11-12 16:24:18.000000000 -0500
+++ 2.6.9/arch/um/kernel/signal_kern.c	2004-11-12 18:05:26.000000000 -0500
@@ -79,7 +79,14 @@
 	else
 		err = setup_signal_stack_sc(sp, signr, ka, regs, oldset);
 
-	if (!err && !(ka->sa.sa_flags & SA_NODEFER)) {
+	if(err){
+		spin_lock_irq(&current->sighand->siglock);
+		current->blocked = *oldset;
+		recalc_sigpending();
+		spin_unlock_irq(&current->sighand->siglock);
+		force_sigsegv(signr, current);
+	}
+	else if(!(ka->sa.sa_flags & SA_NODEFER)){
 		spin_lock_irq(&current->sighand->siglock);
 		sigorsets(&current->blocked, &current->blocked, 
 			  &ka->sa.sa_mask);
@@ -87,9 +94,6 @@
 		recalc_sigpending();
 		spin_unlock_irq(&current->sighand->siglock);
 	}
-
-	if(err)
-		force_sigsegv(signr, current);
 }
 
 static int kern_do_signal(struct pt_regs *regs, sigset_t *oldset)

