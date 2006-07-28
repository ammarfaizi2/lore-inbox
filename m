Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932563AbWG1DIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932563AbWG1DIB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 23:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932573AbWG1DHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 23:07:17 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:55274 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932563AbWG1DGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 23:06:49 -0400
Message-Id: <200607280306.k6S36UcA007951@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 7/7] UML - Improve SIGBUS diagnostics
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 27 Jul 2006 23:06:30 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

UML can get a SIGBUS anywhere if the tmpfs mount being used for its
memory runs out of space.  This patch adds a printk before the panic
to provide a clue as to what likely went wrong.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17/arch/um/kernel/trap.c
===================================================================
--- linux-2.6.17.orig/arch/um/kernel/trap.c	2006-07-12 10:47:56.000000000 -0400
+++ linux-2.6.17/arch/um/kernel/trap.c	2006-07-13 16:27:40.000000000 -0400
@@ -227,9 +227,16 @@ void bad_segv(struct faultinfo fi, unsig
 
 void relay_signal(int sig, union uml_pt_regs *regs)
 {
-	if(arch_handle_signal(sig, regs)) return;
-	if(!UPT_IS_USER(regs))
+	if(arch_handle_signal(sig, regs))
+		return;
+
+	if(!UPT_IS_USER(regs)){
+		if(sig == SIGBUS)
+			printk("Bus error - the /dev/shm or /tmp mount likely "
+			       "just ran out of space\n");
 		panic("Kernel mode signal %d", sig);
+	}
+
         current->thread.arch.faultinfo = *UPT_FAULTINFO(regs);
 	force_sig(sig, current);
 }

