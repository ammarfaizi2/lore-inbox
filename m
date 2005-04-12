Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262297AbVDLKd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbVDLKd5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 06:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262245AbVDLKdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 06:33:00 -0400
Received: from fire.osdl.org ([65.172.181.4]:200 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262117AbVDLKbF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:05 -0400
Message-Id: <200504121031.j3CAV2uF005214@shell0.pdx.osdl.net>
Subject: [patch 025/198] ppc32: fix bogosity in process-freezing code
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, paulus@samba.org
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:30:55 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paul Mackerras <paulus@samba.org>

The code that went into arch/ppc/kernel/signal.c recently to handle process
freezing seems to contain a dubious assumption: that a process that calls
do_signal when PF_FREEZE is set will have entered the kernel because of a
system call.  This patch removes that assumption.

Signed-off-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/ppc/kernel/signal.c |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)

diff -puN arch/ppc/kernel/signal.c~ppc32-fix-bogosity-in-process-freezing-code arch/ppc/kernel/signal.c
--- 25/arch/ppc/kernel/signal.c~ppc32-fix-bogosity-in-process-freezing-code	2005-04-12 03:21:09.526688624 -0700
+++ 25-akpm/arch/ppc/kernel/signal.c	2005-04-12 03:21:09.529688168 -0700
@@ -708,7 +708,6 @@ int do_signal(sigset_t *oldset, struct p
 	if (current->flags & PF_FREEZE) {
 		refrigerator(PF_FREEZE);
 		signr = 0;
-		ret = regs->gpr[3];
 		if (!signal_pending(current))
 			goto no_signal;
 	}
@@ -719,7 +718,7 @@ int do_signal(sigset_t *oldset, struct p
 	newsp = frame = 0;
 
 	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
-
+ no_signal:
 	if (TRAP(regs) == 0x0C00		/* System Call! */
 	    && regs->ccr & 0x10000000		/* error signalled */
 	    && ((ret = regs->gpr[3]) == ERESTARTSYS
@@ -735,7 +734,6 @@ int do_signal(sigset_t *oldset, struct p
 			regs->gpr[3] = EINTR;
 			/* note that the cr0.SO bit is already set */
 		} else {
-no_signal:
 			regs->nip -= 4;	/* Back up & retry system call */
 			regs->result = 0;
 			regs->trap = 0;
_
