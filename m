Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265209AbUELUF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265209AbUELUF7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 16:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265213AbUELUF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 16:05:59 -0400
Received: from cfcafw.sgi.com ([198.149.23.1]:35676 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S265209AbUELUF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 16:05:56 -0400
From: Dimitri Sivanich <sivanich@sgi.com>
Message-Id: <200405122005.i4CK5hli106052@fsgi142.americas.sgi.com>
Subject: [PATCH] 2.6.6. runqueue lock for RT priority tasks
To: george@mvista.com (George Anzinger)
Date: Wed, 12 May 2004 15:05:42 -0500 (CDT)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In the scheduler_tick code, the runqueue lock is currently taken before
checking whether a task is an RT task or not.  It would be more efficient to
take the lock only in cases where the task is not RT or the task policy is
SCHED_RR with no timeslice left.

I welcome your comments on the 2.6.6 patch presented below.

Thanks,

Dimitri Sivanich <sivanich@sgi.com>


Index: linux/kernel/sched.c
===================================================================
--- linux.orig/kernel/sched.c	2004-05-10 15:29:33.000000000 -0500
+++ linux/kernel/sched.c	2004-05-10 15:29:33.000000000 -0500
@@ -1521,7 +1521,6 @@
 		set_tsk_need_resched(p);
 		goto out;
 	}
-	spin_lock(&rq->lock);
 	/*
 	 * The task was running during this tick - update the
 	 * time slice counter. Note: we do not update a thread's
@@ -1535,6 +1534,7 @@
 		 * FIFO tasks have no timeslices.
 		 */
 		if ((p->policy == SCHED_RR) && !--p->time_slice) {
+			spin_lock(&rq->lock);
 			p->time_slice = task_timeslice(p);
 			p->first_time_slice = 0;
 			set_tsk_need_resched(p);
@@ -1542,9 +1542,11 @@
 			/* put it at the end of the queue: */
 			dequeue_task(p, rq->active);
 			enqueue_task(p, rq->active);
+			goto out_unlock;
 		}
-		goto out_unlock;
+		goto out;
 	}
+	spin_lock(&rq->lock);
 	if (!--p->time_slice) {
 		dequeue_task(p, rq->active);
 		set_tsk_need_resched(p);
