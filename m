Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264180AbTFIF3l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 01:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264181AbTFIF3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 01:29:41 -0400
Received: from franka.aracnet.com ([216.99.193.44]:26557 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264180AbTFIF3k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 01:29:40 -0400
Date: Sun, 08 Jun 2003 22:43:16 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: scheduler interactivity - does this patch help?
Message-ID: <36450000.1055137396@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've had this patch (I think from Ingo) kicking around in -mjb
for a while. I'm going to drop it unless someone thinks it's useful
for some testcase you have ... anyone interested?

Thanks,

M.

diff -urpN -X /home/fletch/.diff.exclude 400-reiserfs_dio/kernel/sched.c 420-sched_interactive/kernel/sched.c
--- 400-reiserfs_dio/kernel/sched.c	Fri May 30 19:26:34 2003
+++ 420-sched_interactive/kernel/sched.c	Fri May 30 19:28:06 2003
@@ -89,6 +89,8 @@ int node_threshold = 125;
 #define STARVATION_LIMIT	(starvation_limit)
 #define NODE_THRESHOLD		(node_threshold)
 
+#define TIMESLICE_GRANULARITY (HZ/20 ?: 1)
+
 /*
  * If a task is 'interactive' then we reinsert it in the active
  * array after it has expired its current timeslice. (it will not
@@ -1365,6 +1367,27 @@ void scheduler_tick(int user_ticks, int 
 			enqueue_task(p, rq->expired);
 		} else
 			enqueue_task(p, rq->active);
+	} else {
+		/*
+		 * Prevent a too long timeslice allowing a task to monopolize
+		 * the CPU. We do this by splitting up the timeslice into
+		 * smaller pieces.
+		 *
+		 * Note: this does not mean the task's timeslices expire or
+		 * get lost in any way, they just might be preempted by
+		 * another task of equal priority. (one with higher
+		 * priority would have preempted this task already.) We
+		 * requeue this task to the end of the list on this priority
+		 * level, which is in essence a round-robin of tasks with
+		 * equal priority.
+		 */
+		if (!(p->time_slice % TIMESLICE_GRANULARITY) &&
+			       		(p->array == rq->active)) {
+			dequeue_task(p, rq->active);
+			set_tsk_need_resched(p);
+			p->prio = effective_prio(p);
+			enqueue_task(p, rq->active);
+		}
 	}
 out_unlock:
 	spin_unlock(&rq->lock);

