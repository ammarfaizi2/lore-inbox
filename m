Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261372AbVDDEBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261372AbVDDEBU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 00:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261529AbVDDEBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 00:01:20 -0400
Received: from ozlabs.org ([203.10.76.45]:37820 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261372AbVDDEBN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 00:01:13 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16976.48195.349628.72191@cargo.ozlabs.ibm.com>
Date: Mon, 4 Apr 2005 14:02:11 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: benh@kernel.crashing.org, trini@kernel.crashing.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] ppc: fix bogosity in process-freezing code
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The code that went into arch/ppc/kernel/signal.c recently to handle
process freezing seems to contain a dubious assumption: that a process
that calls do_signal when PF_FREEZE is set will have entered the
kernel because of a system call.  This patch removes that assumption.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc/kernel/signal.c pmac-2.5/arch/ppc/kernel/signal.c
--- linux-2.5/arch/ppc/kernel/signal.c	2005-03-15 10:18:23.000000000 +1100
+++ pmac-2.5/arch/ppc/kernel/signal.c	2005-04-02 15:12:21.000000000 +1000
@@ -708,7 +708,6 @@
 	if (current->flags & PF_FREEZE) {
 		refrigerator(PF_FREEZE);
 		signr = 0;
-		ret = regs->gpr[3];
 		if (!signal_pending(current))
 			goto no_signal;
 	}
@@ -719,7 +718,7 @@
 	newsp = frame = 0;
 
 	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
-
+ no_signal:
 	if (TRAP(regs) == 0x0C00		/* System Call! */
 	    && regs->ccr & 0x10000000		/* error signalled */
 	    && ((ret = regs->gpr[3]) == ERESTARTSYS
@@ -735,7 +734,6 @@
 			regs->gpr[3] = EINTR;
 			/* note that the cr0.SO bit is already set */
 		} else {
-no_signal:
 			regs->nip -= 4;	/* Back up & retry system call */
 			regs->result = 0;
 			regs->trap = 0;
