Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263812AbTETPHB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 11:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263813AbTETPHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 11:07:01 -0400
Received: from verein.lst.de ([212.34.181.86]:266 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S263812AbTETPG7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 11:06:59 -0400
Date: Tue, 20 May 2003 17:19:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com, paulus@samba.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] do_fork updates for ppc
Message-ID: <20030520171944.A20860@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	paulus@samba.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update ppc for mingo's do_fork changes.  Together with the pmac compile
fixes this allows me to stay at the bledding edge with my my ibook..

Paul, any chance for sending Linus more updates from the linuxppc tree?
I still can't build SMP or the sound drivers in mainline..



--- 1.33/arch/ppc/kernel/process.c	Tue May 13 03:59:20 2003
+++ edited/arch/ppc/kernel/process.c	Mon May 19 18:32:25 2003
@@ -445,33 +445,26 @@
 	      void *child_threadptr, int *child_tidp, int p6,
 	      struct pt_regs *regs)
 {
- 	struct task_struct *p;
-
 	CHECK_FULL_REGS(regs);
 	if (usp == 0)
 		usp = regs->gpr[1];	/* stack pointer for child */
- 	p = do_fork(clone_flags & ~CLONE_IDLETASK, usp, regs, 0,
-		    parent_tidp, child_tidp);
- 	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
+ 	return do_fork(clone_flags & ~CLONE_IDLETASK, usp, regs, 0,
+			parent_tidp, child_tidp);
 }
 
 int sys_fork(int p1, int p2, int p3, int p4, int p5, int p6,
 	     struct pt_regs *regs)
 {
-	struct task_struct *p;
 	CHECK_FULL_REGS(regs);
-	p = do_fork(SIGCHLD, regs->gpr[1], regs, 0, NULL, NULL);
-	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
+	return do_fork(SIGCHLD, regs->gpr[1], regs, 0, NULL, NULL);
 }
 
 int sys_vfork(int p1, int p2, int p3, int p4, int p5, int p6,
 	      struct pt_regs *regs)
 {
-	struct task_struct *p;
 	CHECK_FULL_REGS(regs);
-	p = do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, regs->gpr[1], regs,
-		    0, NULL, NULL);
-	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
+	return do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, regs->gpr[1],
+			regs, 0, NULL, NULL);
 }
 
 int sys_execve(unsigned long a0, unsigned long a1, unsigned long a2,
===== arch/ppc/kernel/smp.c 1.32 vs edited =====
--- 1.32/arch/ppc/kernel/smp.c	Wed Apr 30 14:41:43 2003
+++ edited/arch/ppc/kernel/smp.c	Mon May 19 18:33:32 2003
@@ -403,7 +403,7 @@
 	/* create a process for the processor */
 	/* only regs.msr is actually used, and 0 is OK for it */
 	memset(&regs, 0, sizeof(struct pt_regs));
-	p = do_fork(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0, NULL, NULL);
+	p = copy_process(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0, NULL, NULL);
 	if (IS_ERR(p))
 		panic("failed fork for CPU %u: %li", cpu, PTR_ERR(p));
 
===== drivers/ide/ppc/pmac.c 1.12 vs edited =====
