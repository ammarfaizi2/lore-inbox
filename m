Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289608AbSAOTpK>; Tue, 15 Jan 2002 14:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289610AbSAOTpC>; Tue, 15 Jan 2002 14:45:02 -0500
Received: from zero.tech9.net ([209.61.188.187]:17927 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S289608AbSAOTow>;
	Tue, 15 Jan 2002 14:44:52 -0500
Subject: [PATCH] 2.5.2: sched fixes
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 15 Jan 2002 14:48:15 -0500
Message-Id: <1011124096.8754.1.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ some people have asked that I repost this, since it seems it never got
to the list.  I believe it is in Linus's queue now. ]

Linus,

The following is some of the sane bits from Ingo's latest H7 patch.  It
contains some critical bug fixes and should all by obviously correct.

I suspect Ingo will have a full patch ready in due time, but these fixes
should be merged sooner rather than later.  These don't infringe on any
of Davide's bits (another reason to just merge fixes for now).

Itemized Changes:

- avoid IPI lock with smp_send_reschedule in resched_task

- remove unneeded branch in try_to_wake_up, which also has a locking
rule error

- check to make sure new cpus_allowed mask is valid before setting

- fix locking rule error in set_cpus_allowed

- cleanup

	Robert Love

diff -urN linux-2.5.2/kernel/sched.c linux/kernel/sched.c
--- linux-2.5.2/kernel/sched.c	Mon Jan 14 22:46:56 2002
+++ linux/kernel/sched.c	Mon Jan 14 23:28:44 2002
@@ -126,7 +126,7 @@
 	need_resched = p->need_resched;
 	wmb();
 	p->need_resched = 1;
-	if (!need_resched)
+	if (!need_resched && (p->cpu != smp_processor_id()))
 		smp_send_reschedule(p->cpu);
 }
 
@@ -188,17 +188,9 @@
 	lock_task_rq(rq, p, flags);
 	p->state = TASK_RUNNING;
 	if (!p->array) {
-		if (!rt_task(p) && synchronous && (smp_processor_id() < p->cpu)) {
-			spin_lock(&this_rq()->lock);
-			p->cpu = smp_processor_id();
-			activate_task(p, this_rq());
-			spin_unlock(&this_rq()->lock);
-		} else {
-			activate_task(p, rq);
-			if ((rq->curr == rq->idle) ||
-					(p->prio < rq->curr->prio))
-				resched_task(rq->curr);
-		}
+		activate_task(p, rq);
+		if ((rq->curr == rq->idle) || (p->prio < rq->curr->prio))
+			resched_task(rq->curr);
 		success = 1;
 	}
 	unlock_task_rq(rq, p, flags);
@@ -690,6 +682,8 @@
 	int target_cpu;
 
 	new_mask &= cpu_online_map;
+	if (!new_mask)
+		BUG();
 	p->cpus_allowed = new_mask;
 	/*
 	 * Can the task run on the current CPU? If not then
@@ -703,8 +697,8 @@
 		spin_lock_irq(&target_rq->lock);
 		spin_lock(&this_rq->lock);
 	} else {
-		spin_lock_irq(&target_rq->lock);
-		spin_lock(&this_rq->lock);
+		spin_lock_irq(&this_rq->lock);
+		spin_lock(&target_rq->lock);
 	}
 	dequeue_task(p, p->array);
 	this_rq->nr_running--;
@@ -861,7 +855,7 @@
 		goto out_unlock;
 
 	retval = -EPERM;
-	if ((policy == SCHED_FIFO || policy == SCHED_RR) && 
+	if ((policy == SCHED_FIFO || policy == SCHED_RR) &&
 	    !capable(CAP_SYS_NICE))
 		goto out_unlock;
 	if ((current->euid != p->euid) && (current->euid != p->uid) &&
@@ -890,7 +884,7 @@
 	return retval;
 }
 
-asmlinkage long sys_sched_setscheduler(pid_t pid, int policy, 
+asmlinkage long sys_sched_setscheduler(pid_t pid, int policy,
 				      struct sched_param *param)
 {
 	return setscheduler(pid, policy, param);


