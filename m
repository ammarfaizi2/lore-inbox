Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263760AbTETMcO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 08:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263763AbTETMcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 08:32:14 -0400
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:58892 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id S263760AbTETMcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 08:32:12 -0400
To: rth@twiddle.net
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] do_fork fixes on Alpha
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 20 May 2003 14:37:54 +0200
Message-ID: <wrpbrxxu731.fsf@hina.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard, Linus,

The enclosed patch updates the Alpha architecture to the new do_fork
prototype (as of latest BK), following what has been done on x86.

Patched kernel is running fine on Jensen and AS1000. SMP case
compiles, but otherwise untested.

Thanks,

        M.

===== arch/alpha/kernel/process.c 1.26 vs edited =====
--- 1.26/arch/alpha/kernel/process.c	Mon Mar  3 03:13:32 2003
+++ edited/arch/alpha/kernel/process.c	Tue May 20 13:44:13 2003
@@ -235,23 +235,18 @@
 alpha_clone(unsigned long clone_flags, unsigned long usp, int *parent_tid,
 	    int *child_tid, unsigned long tls_value, struct pt_regs *regs)
 {
-	struct task_struct *p;
-
 	if (!usp)
 		usp = rdusp();
 
-	p = do_fork(clone_flags & ~CLONE_IDLETASK, usp, regs, 0,
-		    parent_tid, child_tid);
-	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
+	return do_fork(clone_flags & ~CLONE_IDLETASK, usp, regs, 0,
+		       parent_tid, child_tid);
 }
 
 int
 alpha_vfork(struct pt_regs *regs)
 {
-	struct task_struct *p;
-	p = do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, rdusp(),
-		    regs, 0, NULL, NULL);
-	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
+	return do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, rdusp(),
+		       regs, 0, NULL, NULL);
 }
 
 /*
===== arch/alpha/kernel/smp.c 1.34 vs edited =====
--- 1.34/arch/alpha/kernel/smp.c	Tue Apr  1 00:29:49 2003
+++ edited/arch/alpha/kernel/smp.c	Tue May 20 14:35:12 2003
@@ -417,7 +417,12 @@
 	/* Don't care about the contents of regs since we'll never
 	   reschedule the forked task. */
 	struct pt_regs regs;
-	return do_fork(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0, NULL, NULL);
+	int pid;
+	pid = do_fork(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0, NULL, NULL);
+	if (pid < 0)
+		return NULL;
+
+	return find_task_by_pid (pid);
 }
 
 /*
@@ -436,7 +441,7 @@
 	   wish.  We can't use kernel_thread since we must avoid
 	   rescheduling the child.  */
 	idle = fork_by_hand();
-	if (IS_ERR(idle))
+	if (!idle)
 		panic("failed fork for CPU %d", cpuid);
 
 	init_idle(idle, cpuid);

-- 
Places change, faces change. Life is so very strange.
