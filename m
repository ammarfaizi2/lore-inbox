Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbTESIbN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 04:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbTESIbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 04:31:13 -0400
Received: from mx1.elte.hu ([157.181.1.137]:23459 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id S261279AbTESIbM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 04:31:12 -0400
Date: Mon, 19 May 2003 10:43:49 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Mike Galbraith <efault@gmx.de>
Subject: [patch] sched-rebalance-fix-2.5.69-A1
Message-ID: <Pine.LNX.4.44.0305191039430.4546-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch fixes a race noticed by Mike Galbraith: the scheduler
can lose a rebalance tick if some task happens to not be rescheduled in
time. This is not a fatal condition, but an inconsistency nevertheless.

	Ingo

--- linux/kernel/sched.c.orig	
+++ linux/kernel/sched.c	
@@ -1180,7 +1180,7 @@ void scheduler_tick(int user_ticks, int 
 	/* Task might have expired already, but not scheduled off yet */
 	if (p->array != rq->active) {
 		set_tsk_need_resched(p);
-		return;
+		goto out;
 	}
 	spin_lock(&rq->lock);
 	/*
@@ -1207,7 +1207,7 @@ void scheduler_tick(int user_ticks, int 
 			dequeue_task(p, rq->active);
 			enqueue_task(p, rq->active);
 		}
-		goto out;
+		goto out_unlock;
 	}
 	if (!--p->time_slice) {
 		dequeue_task(p, rq->active);
@@ -1223,8 +1223,9 @@ void scheduler_tick(int user_ticks, int 
 		} else
 			enqueue_task(p, rq->active);
 	}
-out:
+out_unlock:
 	spin_unlock(&rq->lock);
+out:
 	rebalance_tick(rq, 0);
 }
 

