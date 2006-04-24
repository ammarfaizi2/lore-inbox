Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750855AbWDXPDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbWDXPDJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 11:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750857AbWDXPDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 11:03:08 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:60703 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750833AbWDXPDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 11:03:07 -0400
Date: Mon, 24 Apr 2006 17:03:09 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org, heiko.carstens@de.ibm.com
Subject: [patch 3/13] s390: bug in setup_rt_frame.
Message-ID: <20060424150309.GD15613@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[patch 3/13] s390: bug in setup_rt_frame.

Consider return value of __put_user() when setting up a signal
frame instead of ignoring it.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/signal.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/signal.c linux-2.6-patched/arch/s390/kernel/signal.c
--- linux-2.6/arch/s390/kernel/signal.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/signal.c	2006-04-24 16:47:20.000000000 +0200
@@ -358,8 +358,9 @@ static int setup_rt_frame(int sig, struc
 	} else {
                 regs->gprs[14] = (unsigned long)
 			frame->retcode | PSW_ADDR_AMODE;
-		err |= __put_user(S390_SYSCALL_OPCODE | __NR_rt_sigreturn,
-	                          (u16 __user *)(frame->retcode));
+		if (__put_user(S390_SYSCALL_OPCODE | __NR_sigreturn,
+			       (u16 __user *)(frame->retcode)))
+			goto give_sigsegv;
 	}
 
 	/* Set up backchain. */
