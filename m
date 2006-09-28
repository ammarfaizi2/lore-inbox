Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964946AbWI1R2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964946AbWI1R2O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 13:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964953AbWI1R2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 13:28:14 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:54762 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030261AbWI1R2M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 13:28:12 -0400
Date: Thu, 28 Sep 2006 22:58:03 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, Kirill Korotaev <dev@openvz.org>,
       Mike Galbraith <efault@gmx.de>, Balbir Singh <balbir@in.ibm.com>,
       sekharan@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       nagar@watson.ibm.com, matthltc@us.ibm.com, dipankar@in.ibm.com,
       ckrm-tech@lists.sourceforge.net
Subject: [RFC, PATCH 2/9] CPU Controller V2 - Task-group priority handling
Message-ID: <20060928172803.GC8746@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060928172520.GA8746@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060928172520.GA8746@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To retain good interactivity, priority of a task-group is defined to be the
same as the priority of the highest-priority runnable task it has in its
runqueue. 

This means as tasks come and go, priority of a task-group can change.

This patch deals with such changes to task-group priority.

P.S : Is this a good idea? Don't know. Other option is to to have a static
      task-group priority which is decided by its quota.
      
Signed-off-by : Srivatsa Vaddagiri <vatsa@in.ibm.com>

---

 linux-2.6.18-root/kernel/sched.c |   80 ++++++++++++++++++++++++++++++++++++++-
 1 files changed, 78 insertions(+), 2 deletions(-)

diff -puN kernel/sched.c~update_task_grp_prio kernel/sched.c
--- linux-2.6.18/kernel/sched.c~update_task_grp_prio	2006-09-28 16:39:15.840754048 +0530
+++ linux-2.6.18-root/kernel/sched.c	2006-09-28 17:23:21.191599592 +0530
@@ -191,7 +191,7 @@ static inline unsigned int task_timeslic
 
 struct prio_array {
 	unsigned int nr_active;
-	int best_static_prio;
+	int best_static_prio, best_dyn_prio;
 	DECLARE_BITMAP(bitmap, MAX_PRIO+1); /* include 1 bit for delimiter */
 	struct list_head queue[MAX_PRIO];
 };
@@ -710,6 +710,55 @@ sched_info_switch(struct task_struct *pr
 #define sched_info_switch(t, next)	do { } while (0)
 #endif /* CONFIG_SCHEDSTATS || CONFIG_TASK_DELAY_ACCT */
 
+/* Dequeue task-group object from the main per-cpu runqueue */
+static void dequeue_task_grp(struct task_grp_rq *tgrq)
+{
+	struct prio_array *array = tgrq->rq_array;
+
+	array->nr_active--;
+	list_del(&tgrq->list);
+	if (list_empty(array->queue + tgrq->prio))
+		__clear_bit(tgrq->prio, array->bitmap);
+	tgrq->rq_array = NULL;
+}
+
+/* Enqueue task-group object on the main per-cpu runqueue */
+static void enqueue_task_grp(struct task_grp_rq *tgrq, struct prio_array *array,
+				int head)
+{
+	if (!head)
+		list_add_tail(&tgrq->list, array->queue + tgrq->prio);
+	else
+        	list_add(&tgrq->list, array->queue + tgrq->prio);
+        __set_bit(tgrq->prio, array->bitmap);
+        array->nr_active++;
+        tgrq->rq_array = array;
+}
+
+/* Priority of a task-group is defined to be the priority of the highest
+ * priority runnable task it has. As tasks belonging to a task-group come in
+ * and go, the task-group priority can change on a particular CPU.
+ */
+static inline void update_task_grp_prio(struct task_grp_rq *tgrq, struct rq *rq,
+								 int head)
+{
+	int new_prio;
+	struct prio_array *array = tgrq->rq_array;
+
+	new_prio = tgrq->active->best_dyn_prio;
+	if (new_prio == MAX_PRIO)
+		new_prio = tgrq->expired->best_dyn_prio;
+
+	if (array)
+		dequeue_task_grp(tgrq);
+	tgrq->prio = new_prio;
+	if (new_prio != MAX_PRIO) {
+		if (!array)
+			array = rq->active;
+		enqueue_task_grp(tgrq, array, head);
+	}
+}
+
 /*
  * Adding/removing a task to/from a priority array:
  */
@@ -717,8 +766,17 @@ static void dequeue_task(struct task_str
 {
 	array->nr_active--;
 	list_del(&p->run_list);
-	if (list_empty(array->queue + p->prio))
+	if (list_empty(array->queue + p->prio)) {
 		__clear_bit(p->prio, array->bitmap);
+		if (p->prio == array->best_dyn_prio) {
+			struct task_grp_rq *tgrq = task_grp_rq(p);
+
+			array->best_dyn_prio =
+					sched_find_first_bit(array->bitmap);
+			if (array == tgrq->active || !tgrq->active->nr_active)
+				update_task_grp_prio(tgrq, task_rq(p), 0);
+		}
+	}
 }
 
 static void enqueue_task(struct task_struct *p, struct prio_array *array)
@@ -728,6 +786,14 @@ static void enqueue_task(struct task_str
 	__set_bit(p->prio, array->bitmap);
 	array->nr_active++;
 	p->array = array;
+
+	if (p->prio < array->best_dyn_prio) {
+		struct task_grp_rq *tgrq = task_grp_rq(p);
+
+		array->best_dyn_prio = p->prio;
+		if (array == tgrq->active || !tgrq->active->nr_active)
+			update_task_grp_prio(tgrq, task_rq(p), 0);
+	}
 }
 
 /*
@@ -746,6 +812,14 @@ enqueue_task_head(struct task_struct *p,
 	__set_bit(p->prio, array->bitmap);
 	array->nr_active++;
 	p->array = array;
+
+	if (p->prio < array->best_dyn_prio) {
+		struct task_grp_rq *tgrq = task_grp_rq(p);
+
+		array->best_dyn_prio = p->prio;
+		if (array == tgrq->active || !tgrq->active->nr_active)
+			update_task_grp_prio(tgrq, task_rq(p), 1);
+	}
 }
 
 /*
@@ -6831,7 +6905,9 @@ static void task_grp_rq_init(struct task
 	tgrq->expired = tgrq->arrays + 1;
 	tgrq->rq_array = NULL;
 	tgrq->expired->best_static_prio = MAX_PRIO;
+	tgrq->expired->best_dyn_prio = MAX_PRIO;
 	tgrq->active->best_static_prio = MAX_PRIO;
+	tgrq->active->best_dyn_prio = MAX_PRIO;
 	tgrq->prio = MAX_PRIO;
 	tgrq->tg = tg;
 	INIT_LIST_HEAD(&tgrq->list);
_
-- 
Regards,
vatsa
