Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423003AbWF1DFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423003AbWF1DFz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 23:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423002AbWF1DFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 23:05:54 -0400
Received: from omta01sl.mx.bigpond.com ([144.140.92.153]:54636 "EHLO
	omta01sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1423001AbWF1DFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 23:05:53 -0400
From: Peter Williams <pwil3058@bigpond.net.au>
To: Ingo Molnar <mingo@elte.hu>
Cc: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Date: Wed, 28 Jun 2006 13:05:50 +1000
Message-Id: <20060628030550.15257.67334.sendpatchset@heathwren.pw.nest>
Subject: [PATCH] sched: fix bug in __migrate_task()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem:

In the function __migrate_task(), deactivate_task() followed by
activate_task() is used to move the task from one run queue to
another.  This has two undesirable effects:

1. The task's priority is recalculated. (Nowhere else in the
scheduler code is the priority recalculated for a change of CPU.)

2. The task's time stamp is set to the current time.  At the very least,
this makes the adjustment of the time stamp before the call to
deactivate_task() redundant but I believe the problem is more serious
as the time stamp now holds the time of the queue change instead of
the time at which the task was woken.  In addition, unless dest_rq is
the same queue as "current" is on the time stamp could be inaccurate
due to inter CPU drift.

Solution:

Replace the call to activate_task() with one to __activate_task().

Signed-off-by: Peter Williams <pwil3058@bigpond.net.au>

---
 kernel/sched.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/kernel/sched.c
===================================================================
--- linux-2.6.orig/kernel/sched.c	2006-06-28 11:19:51.000000000 +1000
+++ linux-2.6/kernel/sched.c	2006-06-28 11:58:01.000000000 +1000
@@ -4504,7 +4504,7 @@ static void __migrate_task(struct task_s
 		p->timestamp = p->timestamp - rq_src->timestamp_last_tick
 				+ rq_dest->timestamp_last_tick;
 		deactivate_task(p, rq_src);
-		activate_task(p, rq_dest, 0);
+		__activate_task(p, rq_dest);
 		if (TASK_PREEMPTS_CURR(p, rq_dest))
 			resched_task(rq_dest->curr);
 	}

-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
 -- Ambrose Bierce
