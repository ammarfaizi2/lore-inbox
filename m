Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264312AbTKOACH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 19:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264375AbTKOACH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 19:02:07 -0500
Received: from ozlabs.org ([203.10.76.45]:5278 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264312AbTKOACE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 19:02:04 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16309.28037.896731.19038@cargo.ozlabs.ibm.com>
Date: Sat, 15 Nov 2003 11:04:21 +1100
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org
Cc: trini@kernel.crashing.org, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] PPC32: cancel syscall restart on signal delivery
X-Mailer: VM 7.17 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

This patch ensures that the PPC kernel cancels any pending restarted
system call when it delivers a signal.  This is the PPC counterpart of
the change that has recently gone into i386 and other architectures.

BTW, do we have a test program that triggers the bug that this fixes?

Thanks,
Paul.

diff -urN linux-2.5/arch/ppc/kernel/signal.c pmac-2.5/arch/ppc/kernel/signal.c
--- linux-2.5/arch/ppc/kernel/signal.c	2003-09-27 19:46:43.000000000 +1000
+++ pmac-2.5/arch/ppc/kernel/signal.c	2003-11-14 23:08:22.000000000 +1100
@@ -569,10 +569,6 @@
 			regs->result = -EINTR;
 			regs->gpr[3] = EINTR;
 			/* note that the cr0.SO bit is already set */
-			/* clear any restart function that was set */
-			if (ret == ERESTART_RESTARTBLOCK)
-				current_thread_info()->restart_block.fn
-					= do_no_restart_syscall;
 		} else {
 			regs->nip -= 4;	/* Back up & retry system call */
 			regs->result = 0;
@@ -587,6 +583,9 @@
 	if (signr == 0)
 		return 0;		/* no signals delivered */
 
+	/* Always make any pending restarted system calls return -EINTR */
+	current_thread_info()->restart_block.fn = do_no_restart_syscall;
+
 	if ((ka->sa.sa_flags & SA_ONSTACK) && current->sas_ss_size
 	    && !on_sig_stack(regs->gpr[1]))
 		newsp = current->sas_ss_sp + current->sas_ss_size;
