Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265142AbUD3Lgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265142AbUD3Lgo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 07:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265157AbUD3Lgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 07:36:44 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:22404 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S265142AbUD3Lgh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 07:36:37 -0400
Date: Fri, 30 Apr 2004 17:07:51 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Fix deadlock in __create_workqueue
Message-ID: <20040430113751.GA18296@in.ibm.com>
Reply-To: vatsa@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Noticed a possible deadlock in __create_workqueue when CONFIG_HOTPLUG_CPU is
set.  This can happen when create_workqueue_thread fails to create a worker
thread. In that case, we call destroy_workqueue with cpu hotplug lock held.
destroy_workqueue however also attempts to take the same lock.

Patch below address this deadlock as well as a kthread_stop race. 
Its tested against 2.6.6-rc2-mm2 on a 4-way Intel SMP box.

---

 linux-2.6.6-rc2-mm2-root/kernel/workqueue.c |   58 +++++++++++++++++-----------
 1 files changed, 37 insertions(+), 21 deletions(-)

diff -puN kernel/workqueue.c~__create_workqueue_fix kernel/workqueue.c
--- linux-2.6.6-rc2-mm2/kernel/workqueue.c~__create_workqueue_fix	2004-04-29 18:53:03.722704312 +0530
+++ linux-2.6.6-rc2-mm2-root/kernel/workqueue.c	2004-04-29 18:53:09.623807208 +0530
@@ -201,8 +201,9 @@ static int worker_thread(void *__cwq)
 	siginitset(&sa.sa.sa_mask, sigmask(SIGCHLD));
 	do_sigaction(SIGCHLD, &sa, (struct k_sigaction *)0);
 
+	set_task_state(current, TASK_INTERRUPTIBLE);
+
 	while (!kthread_should_stop()) {
-		set_task_state(current, TASK_INTERRUPTIBLE);
 
 		add_wait_queue(&cwq->more_work, &wait);
 		if (list_empty(&cwq->worklist))
@@ -213,7 +214,11 @@ static int worker_thread(void *__cwq)
 
 		if (!list_empty(&cwq->worklist))
 			run_workqueue(cwq);
+
+		set_task_state(current, TASK_INTERRUPTIBLE);
 	}
+
+	__set_current_state(TASK_RUNNING);
 	return 0;
 }
 
@@ -297,6 +302,21 @@ static struct task_struct *create_workqu
 	return p;
 }
 
+static void cleanup_workqueue_thread(struct workqueue_struct *wq, int cpu)
+{
+	struct cpu_workqueue_struct *cwq;
+	unsigned long flags;
+	struct task_struct *p;
+
+	cwq = wq->cpu_wq + cpu;
+	spin_lock_irqsave(&cwq->lock, flags);
+	p = cwq->thread;
+	cwq->thread = NULL;
+	spin_unlock_irqrestore(&cwq->lock, flags);
+	if (p)
+		kthread_stop(p);
+}
+
 struct workqueue_struct *__create_workqueue(const char *name,
 					    int singlethread)
 {
@@ -322,16 +342,27 @@ struct workqueue_struct *__create_workqu
 		else
 			wake_up_process(p);
 	} else {
-		spin_lock(&workqueue_lock);
-		list_add(&wq->list, &workqueues);
-		spin_unlock_irq(&workqueue_lock);
 		for_each_online_cpu(cpu) {
 			p = create_workqueue_thread(wq, cpu);
 			if (p) {
 				kthread_bind(p, cpu);
 				wake_up_process(p);
-			} else
+			} else {
+				int i;
+
+				for (i=cpu-1; i>=0; --i)
+					if (cpu_online(i))
+						cleanup_workqueue_thread(wq, i);
+
 				destroy = 1;
+				break;
+			}
+		}
+
+		if (!destroy) {
+			spin_lock(&workqueue_lock);
+			list_add(&wq->list, &workqueues);
+			spin_unlock_irq(&workqueue_lock);
 		}
 	}
 
@@ -339,28 +370,13 @@ struct workqueue_struct *__create_workqu
 	 * Was there any error during startup? If yes then clean up:
 	 */
 	if (destroy) {
-		destroy_workqueue(wq);
+		kfree(wq);
 		wq = NULL;
 	}
 	unlock_cpu_hotplug();
 	return wq;
 }
 
-static void cleanup_workqueue_thread(struct workqueue_struct *wq, int cpu)
-{
-	struct cpu_workqueue_struct *cwq;
-	unsigned long flags;
-	struct task_struct *p;
-
-	cwq = wq->cpu_wq + cpu;
-	spin_lock_irqsave(&cwq->lock, flags);
-	p = cwq->thread;
-	cwq->thread = NULL;
-	spin_unlock_irqrestore(&cwq->lock, flags);
-	if (p)
-		kthread_stop(p);
-}
-
 void destroy_workqueue(struct workqueue_struct *wq)
 {
 	int cpu;

_


-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
