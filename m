Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751794AbWJALh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751794AbWJALh2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 07:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751827AbWJALh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 07:37:27 -0400
Received: from mx04.stofanet.dk ([212.10.10.14]:57272 "EHLO mx04.stofanet.dk")
	by vger.kernel.org with ESMTP id S1751794AbWJALhZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 07:37:25 -0400
Date: Sun, 1 Oct 2006 13:36:45 +0200 (CEST)
From: Esben Nielsen <nielsen.esben@googlemail.com>
X-X-Sender: simlo@frodo.shire
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: [patch 1/5] Fix timeout bug in rtmutex in 2.6.18-rt
Message-ID: <Pine.LNX.4.64.0610011336400.29459@frodo.shire>
References: <20061001112829.630288000@frodo>
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

Index: linux-2.6.18-rt/include/linux/init_task.h
===================================================================
--- linux-2.6.18-rt.orig/include/linux/init_task.h
+++ linux-2.6.18-rt/include/linux/init_task.h
@@ -91,6 +91,7 @@ extern struct group_info init_groups;
  	.prio		= MAX_PRIO-20,					\
  	.static_prio	= MAX_PRIO-20,					\
  	.normal_prio	= MAX_PRIO-20,					\
+	.sched_lifo	= 0,						\
  	.policy		= SCHED_NORMAL,					\
  	.cpus_allowed	= CPU_MASK_ALL,					\
  	.mm		= NULL,						\
Index: linux-2.6.18-rt/include/linux/sched.h
===================================================================
--- linux-2.6.18-rt.orig/include/linux/sched.h
+++ linux-2.6.18-rt/include/linux/sched.h
@@ -928,6 +928,7 @@ struct task_struct {
  	int prio, static_prio, normal_prio;
  	struct list_head run_list;
  	struct prio_array *array;
+	int sched_lifo;

  	unsigned short ioprio;
  	unsigned int btrace_seq;
@@ -1329,6 +1330,67 @@ extern struct task_struct *curr_task(int
  extern void set_curr_task(int cpu, struct task_struct *p);
  extern void set_thread_priority(struct task_struct *p, int prio);

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

Index: linux-2.6.18-rt/kernel/sched.c
===================================================================
--- linux-2.6.18-rt.orig/kernel/sched.c
+++ linux-2.6.18-rt/kernel/sched.c
@@ -164,8 +164,8 @@
  	(JIFFIES_TO_NS(MAX_SLEEP_AVG * \
  		(MAX_BONUS / 2 + DELTA((p)) + 1) / MAX_BONUS - 1))

-#define TASK_PREEMPTS_CURR(p, rq) \
-	((p)->prio < (rq)->curr->prio)
+#define TASK_PREEMPTS(p,q) task_preempts(p,q)
+#define TASK_PREEMPTS_CURR(p, rq)	TASK_PREEMPTS(p,(rq)->curr)

  /*
   * task_timeslice() scales user-nice values [ -20 ... 0 ... 19 ]
@@ -707,6 +707,17 @@ sched_info_switch(struct task_struct *pr
  #define sched_info_switch(t, next)	do { } while (0)
  #endif /* CONFIG_SCHEDSTATS || CONFIG_TASK_DELAY_ACCT */

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
  #if defined(CONFIG_PREEMPT_RT) && defined(CONFIG_SMP)
  static __cacheline_aligned_in_smp atomic_t rt_overload;
  #endif
@@ -770,7 +781,12 @@ static void enqueue_task(struct task_str
  {
  	WARN_ON_ONCE(p->flags & PF_DEAD);
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
@@ -783,7 +799,10 @@ static void enqueue_task(struct task_str
   */
  static void requeue_task(struct task_struct *p, struct prio_array *array)
  {
-	list_move_tail(&p->run_list, array->queue + p->prio);
+	if (p->sched_lifo)
+		list_move(&p->run_list, array->queue + p->prio);
+	else
+		list_move_tail(&p->run_list, array->queue + p->prio);
  }

  static inline void
@@ -1463,7 +1482,7 @@ static void balance_rt_tasks(struct rq *
  		 * Do we have an RT task that preempts
  		 * the to-be-scheduled task?
  		 */
-		if (p && (p->prio < next->prio)) {
+		if (p && TASK_PREEMPTS(p,next)) {
  			WARN_ON(p == src_rq->curr);
  			WARN_ON(!p->array);
  			schedstat_inc(this_rq, rto_pulled);

--
