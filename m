Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262268AbTEUU2E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 16:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbTEUU2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 16:28:04 -0400
Received: from mail.ccur.com ([208.248.32.212]:65030 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S262268AbTEUU2D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 16:28:03 -0400
Date: Wed, 21 May 2003 16:40:26 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] setscheduler resched bug
Message-ID: <20030521204026.GA13444@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

setscheduler is not forcing a reschedule when needed like set_user_nice
does.  It should.

Joe


--- 2.5.69/kernel/sched.c.orig	2003-05-21 14:50:53.000000000 -0400
+++ 2.5.69/kernel/sched.c	2003-05-21 15:01:13.000000000 -0400
@@ -1716,6 +1716,7 @@
 	unsigned long flags;
 	runqueue_t *rq;
 	task_t *p;
+	int oldprio;
 
 	if (!param || pid < 0)
 		goto out_nounlock;
@@ -1778,12 +1779,20 @@
 	retval = 0;
 	p->policy = policy;
 	p->rt_priority = lp.sched_priority;
+	oldprio = p->prio;
 	if (policy != SCHED_NORMAL)
 		p->prio = MAX_USER_RT_PRIO-1 - p->rt_priority;
 	else
 		p->prio = p->static_prio;
-	if (array)
+	if (array) {
 		__activate_task(p, task_rq(p));
+		/*
+		 * Reschedule if on a CPU and the priority dropped, or not on
+		 * a CPU and the priority rose above the currently running task.
+		 */
+		if ((rq->curr == p) ? (p->prio > oldprio) : (p->prio < rq->curr->prio))
+			resched_task(rq->curr);
+	}
 
 out_unlock:
 	task_rq_unlock(rq, &flags);
