Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264860AbUEJQcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264860AbUEJQcX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 12:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264861AbUEJQcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 12:32:23 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:29096 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S264860AbUEJQcV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 12:32:21 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix init_idle() locking problem
Date: Mon, 10 May 2004 10:32:18 -0600
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405101032.18508.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When starting up secondary CPUs, most architectures do something
like this:

	do_boot_cpu(int cpu)
	{
		idle = fork_by_hand();
		wake_up_forked_process(idle);
		init_idle(idle, cpu);

init_idle() removes "idle" from its runqueue, but there's a window
between looking up the runqueue and locking it, where another CPU
can move "idle" to a different runqueue, i.e., via load_balance().

This is based on 2.6.6.

===== kernel/sched.c 1.261 vs edited =====
--- 1.261/kernel/sched.c	Mon Apr 26 23:07:43 2004
+++ edited/kernel/sched.c	Mon May 10 09:59:54 2004
@@ -2660,11 +2660,18 @@
 
 void __init init_idle(task_t *idle, int cpu)
 {
-	runqueue_t *idle_rq = cpu_rq(cpu), *rq = cpu_rq(task_cpu(idle));
+	runqueue_t *idle_rq = cpu_rq(cpu), *rq;
 	unsigned long flags;
 
+repeat_lock_runqueues:
+	rq = task_rq(idle);
 	local_irq_save(flags);
 	double_rq_lock(idle_rq, rq);
+	if (rq != task_rq(idle)) {
+		double_rq_unlock(idle_rq, rq);
+		local_irq_restore(flags);
+		goto repeat_lock_runqueues;
+	}
 
 	idle_rq->curr = idle_rq->idle = idle;
 	deactivate_task(idle, rq);
