Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262648AbSJIXAH>; Wed, 9 Oct 2002 19:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262650AbSJIXAH>; Wed, 9 Oct 2002 19:00:07 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:49933
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262648AbSJIXAE>; Wed, 9 Oct 2002 19:00:04 -0400
Subject: [PATCH] set_cpus_allowed() atomicity fix
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 09 Oct 2002 19:05:44 -0400
Message-Id: <1034204745.794.206.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

L-Team Captain,

In set_cpus_allowed(), we hold the preempt_disable() over a
wait_for_completition() so it triggers the atomicity debugging.

There is (was) a kernel preemption race here which the preemption
disable is fixing.  I do not understand it; if this uncovers it there
should be some light shed on the subject.

Anyhow, attached patch fixes the atomicity debugging error.

Patch is against current BK.  Please, apply.

	Robert Love

 sched.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff -urN linux-bk/kernel/sched.c linux/kernel/sched.c
--- linux-bk/kernel/sched.c	2002-10-09 15:46:43.000000000 -0400
+++ linux/kernel/sched.c	2002-10-09 18:52:06.000000000 -0400
@@ -1953,7 +1953,6 @@
 		BUG();
 #endif
 
-	preempt_disable();
 	rq = task_rq_lock(p, &flags);
 	p->cpus_allowed = new_mask;
 	/*
@@ -1962,7 +1961,7 @@
 	 */
 	if (new_mask & (1UL << task_cpu(p))) {
 		task_rq_unlock(rq, &flags);
-		goto out;
+		return;
 	}
 	/*
 	 * If the task is not on a runqueue (and not running), then
@@ -1971,17 +1970,21 @@
 	if (!p->array && !task_running(rq, p)) {
 		set_task_cpu(p, __ffs(p->cpus_allowed));
 		task_rq_unlock(rq, &flags);
-		goto out;
+		return;
 	}
 	init_completion(&req.done);
 	req.task = p;
 	list_add(&req.list, &rq->migration_queue);
+
+	/*
+	 * counter the subsequent unlock - we do not want to preempt yet
+	 */
+	preempt_disable();
 	task_rq_unlock(rq, &flags);
 	wake_up_process(rq->migration_thread);
+	preempt_enable();
 
 	wait_for_completion(&req.done);
-out:
-	preempt_enable();
 }
 
 /*

