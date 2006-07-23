Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWGWARz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWGWARz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 20:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbWGWARz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 20:17:55 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:7399 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750769AbWGWARy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 20:17:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:from:x-x-sender:to:subject:message-id:references:mime-version:content-type;
        b=V8PlCPpPkhGrPV1qp0QadMwVwDWuCintN2bQgO1N8EYpSqoT+Z+TlEEIZd9r9IaNF84iTNCP2ej1gSOaJnGJZ0GvExyrjJCtBSZ/gBkuOR9ztyDJh7cPa4rFp4KaT8dy2vPyx8AlaMir1jn9HS15aHGMIIG3DDmXJZLM8J3r48g=
Date: Sun, 23 Jul 2006 02:18:19 +0100 (BST)
From: Esben Nielsen <nielsen.esben@googlemail.com>
X-X-Sender: simlo@localhost.localdomain
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       Steven Rostedt <rostedt@goodmis.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [patch 1/3] [-rt] Fixes the timeout-bug in the rtmutex/PI-futex.
Message-ID: <Pine.LNX.4.64.0607230216470.11861@localhost.localdomain>
References: <20060723005210.973833000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new interface to the scheduler: A task can be scheduled in 
LIFO order for a while instead of the usual FIFO order. This is more or less 
equivalent to raising it's priority by 1/2.

This property is now needed by the rtmutexes to solve the last few issues, but
I can imagine it can be usefull for other subsystems too.

  include/linux/init_task.h |    1
  include/linux/sched.h     |   62 ++++++++++++++++++++++++++++++++++++++++++++++
  kernel/sched.c            |   29 +++++++++++++++++----
  3 files changed, 87 insertions(+), 5 deletions(-)

Index: linux-2.6.17-rt7/include/linux/sched.h
===================================================================
--- linux-2.6.17-rt7.orig/include/linux/sched.h
+++ linux-2.6.17-rt7/include/linux/sched.h
@@ -853,6 +853,7 @@ struct task_struct {
  	int prio, static_prio, normal_prio;
  	struct list_head run_list;
  	prio_array_t *array;
+	int sched_lifo;

  	unsigned short ioprio;
  	unsigned int btrace_seq;
@@ -1233,6 +1234,67 @@ extern task_t *idle_task(int cpu);
  extern task_t *curr_task(int cpu);
  extern void set_curr_task(int cpu, task_t *p);

+/*
+ * sched_lifo: A task can be sched-lifo mode and be sure to be scheduled before
+ * any other task with the same or lower priority - except for later arriving
+ * tasks with the sched_lifo property set.
+ *
+ * It is supposed to work similar to irq-flags:
+ *
+ *          int old_sched_lifo;
+ *          ...
+ *          old_sched_lifo = enter_sched_lifo();
+ *          ...
+ *          leave_sched_lifo(old_sched_lifo);
+ *
+ * The purpose is that the sched-lifo sections can be easily nested.
+ *
+ * With the get/enter/leave_sched_lifo_other() the lifo status on another task
+ * can be manipulated, The status is neither atomic, nor protected by any lock.
+ * Therefore it is up to the user of those function to ensure that the
+ * operations a properly serialized. The easiest will be not to use
+ * *_sched_lifo_other() functions.
+ */
+
+static inline int get_sched_lifo_other(struct task_struct *task)
+{
+	return task->sched_lifo;
+}
+
+static inline int get_sched_lifo(void)
+{
+	return get_sched_lifo_other(current);
+}
+
+static inline int enter_sched_lifo_other(struct task_struct *task)
+{
+	int old = task->sched_lifo;
+	task->sched_lifo = 1;
+	return old;
+}
+
+static inline int enter_sched_lifo(void)
+{
+	return enter_sched_lifo_other(current);
+}
+
+
+static inline void leave_sched_lifo_other(struct task_struct *task,
+					  int old_value)
+{
+	task->sched_lifo = old_value;
+  /*
+   * if sched_lifo == 0 should we move to the tail of the runqueue ?
+   * what if we never sleeped while in sched_lifo  ?
+   */
+}
+
+static inline void leave_sched_lifo(int old_value)
+{
+	leave_sched_lifo_other(current, old_value);
+}
+
+
  void yield(void);
  void __yield(void);

Index: linux-2.6.17-rt7/kernel/sched.c
===================================================================
--- linux-2.6.17-rt7.orig/kernel/sched.c
+++ linux-2.6.17-rt7/kernel/sched.c
@@ -162,8 +162,8 @@
  	(JIFFIES_TO_NS(MAX_SLEEP_AVG * \
  		(MAX_BONUS / 2 + DELTA((p)) + 1) / MAX_BONUS - 1))

-#define TASK_PREEMPTS_CURR(p, rq) \
-	((p)->prio < (rq)->curr->prio)
+#define TASK_PREEMPTS(p,q) task_preempts(p,q)
+#define TASK_PREEMPTS_CURR(p, rq)  TASK_PREEMPTS(p,(rq)->curr)

  /*
   * task_timeslice() scales user-nice values [ -20 ... 0 ... 19 ]
@@ -646,6 +646,17 @@ static inline void sched_info_switch(tas
  #define sched_info_switch(t, next)	do { } while (0)
  #endif /* CONFIG_SCHEDSTATS */

+int task_preempts(struct task_struct *p, struct task_struct *q)
+{
+	if (p->prio < q->prio)
+		return 1;
+
+	if (p->prio > q->prio)
+		return 0;
+
+	return p->sched_lifo;
+}
+
  static __cacheline_aligned_in_smp atomic_t rt_overload;

  static inline void inc_rt_tasks(task_t *p, runqueue_t *rq)
@@ -710,7 +721,12 @@ static void enqueue_task(struct task_str
  		dump_stack();
  	}
  	sched_info_queued(p);
-	list_add_tail(&p->run_list, array->queue + p->prio);
+
+	if (p->sched_lifo)
+		list_add(&p->run_list, array->queue + p->prio);
+	else
+		list_add_tail(&p->run_list, array->queue + p->prio);
+
  	__set_bit(p->prio, array->bitmap);
  	array->nr_active++;
  	p->array = array;
@@ -723,7 +739,10 @@ static void enqueue_task(struct task_str
   */
  static void requeue_task(struct task_struct *p, prio_array_t *array)
  {
-	list_move_tail(&p->run_list, array->queue + p->prio);
+	if (p->sched_lifo)
+		list_move(&p->run_list, array->queue + p->prio);
+	else
+		list_move_tail(&p->run_list, array->queue + p->prio);
  }

  static inline void enqueue_task_head(struct task_struct *p, prio_array_t *array)
@@ -1313,7 +1332,7 @@ static void balance_rt_tasks(runqueue_t
  		 * Do we have an RT task that preempts
  		 * the to-be-scheduled task?
  		 */
-		if (p && (p->prio < next->prio)) {
+		if (p && TASK_PREEMPTS(p,next)) {
  			WARN_ON(p == src_rq->curr);
  			WARN_ON(!p->array);
  			schedstat_inc(this_rq, rto_pulled);
Index: linux-2.6.17-rt7/include/linux/init_task.h
===================================================================
--- linux-2.6.17-rt7.orig/include/linux/init_task.h
+++ linux-2.6.17-rt7/include/linux/init_task.h
@@ -89,6 +89,7 @@ extern struct group_info init_groups;
  	.prio		= MAX_PRIO-20,					\
  	.static_prio	= MAX_PRIO-20,					\
  	.normal_prio	= MAX_PRIO-20,					\
+        .sched_lifo     = 0,						\
  	.policy		= SCHED_NORMAL,					\
  	.cpus_allowed	= CPU_MASK_ALL,					\
  	.mm		= NULL,						\

--
