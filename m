Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271843AbTGRUja (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 16:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271844AbTGRUja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 16:39:30 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:32447 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S271843AbTGRUjQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 16:39:16 -0400
Message-Id: <200307182053.h6IKrSX06981@owlet.beaverton.ibm.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       Mike Kravetz <kravetz@us.ibm.com>, Erich Focht <efocht@hpce.nec.com>,
       LSE <lse-tech@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] [patch 2.6.0-test1] per cpu times 
In-reply-to: Your message of "Fri, 18 Jul 2003 12:57:47 PDT."
             <20030718195747.GU8121@holomorphy.com> 
Date: Fri, 18 Jul 2003 13:53:28 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    I wrote something to collect the standard queueing statistics a while
    back but am not sure what I did with it. I think Rick Lindsley might
    still have a copy around.

Actually, better than that -- it's in the mjb tree.  But I'll repost it
here for those who might find it generally useful.  I've regenerated the
patch below for 2.6.0-test1, but while it applies and compiles cleanly,
I haven't really exercised it to any extent yet in 2.6.

The code adds extra fields to the stat field for each process and
each cpu.

Note that per-process info is only available while that process is
alive.  Once a process exits, the specific information about it is lost.
The extra fields for the cpu info in /proc decay over time instead of
accumulating, so they are more of a "wait average" (similar to a load
average) rather than a sum of wait times.

Rick

diff -rup linux-2.6.0-test1/fs/proc/array.c linux-2.6.0-qs/fs/proc/array.c
--- linux-2.6.0-test1/fs/proc/array.c	Sun Jul 13 20:35:12 2003
+++ linux-2.6.0-qs/fs/proc/array.c	Fri Jul 18 15:51:33 2003
@@ -336,7 +336,7 @@ int proc_pid_stat(struct task_struct *ta
 	read_unlock(&tasklist_lock);
 	res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu \
 %lu %lu %lu %lu %lu %ld %ld %ld %ld %ld %ld %llu %lu %ld %lu %lu %lu %lu %lu \
-%lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu\n",
+%lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu %lu %lu %lu\n",
 		task->pid,
 		task->comm,
 		state,
@@ -382,7 +382,10 @@ int proc_pid_stat(struct task_struct *ta
 		task->exit_signal,
 		task_cpu(task),
 		task->rt_priority,
-		task->policy);
+		task->policy,
+		jiffies_to_clock_t(task->sched_info.inter_arrival_time),
+		jiffies_to_clock_t(task->sched_info.service_time),
+		jiffies_to_clock_t(task->sched_info.response_time));
 	if(mm)
 		mmput(mm);
 	return res;
diff -rup linux-2.6.0-test1/fs/proc/proc_misc.c linux-2.6.0-qs/fs/proc/proc_misc.c
--- linux-2.6.0-test1/fs/proc/proc_misc.c	Sun Jul 13 20:30:43 2003
+++ linux-2.6.0-qs/fs/proc/proc_misc.c	Fri Jul 18 15:51:33 2003
@@ -401,14 +401,20 @@ static int kstat_read_proc(char *page, c
 		jiffies_to_clock_t(idle),
 		jiffies_to_clock_t(iowait));
 	for (i = 0 ; i < NR_CPUS; i++){
-		if (!cpu_online(i)) continue;
-		len += sprintf(page + len, "cpu%d %u %u %u %u %u\n",
+		struct sched_info info;
+		if (!cpu_online(i))
+			continue;
+		cpu_sched_info(&info, i);
+		len += sprintf(page + len, "cpu%d %u %u %u %u %u %u %u %u\n",
 			i,
 			jiffies_to_clock_t(kstat_cpu(i).cpustat.user),
 			jiffies_to_clock_t(kstat_cpu(i).cpustat.nice),
 			jiffies_to_clock_t(kstat_cpu(i).cpustat.system),
 			jiffies_to_clock_t(kstat_cpu(i).cpustat.idle),
-			jiffies_to_clock_t(kstat_cpu(i).cpustat.iowait));
+			jiffies_to_clock_t(kstat_cpu(i).cpustat.iowait),
+			(uint) jiffies_to_clock_t(info.inter_arrival_time),
+			(uint) jiffies_to_clock_t(info.service_time),
+			(uint) jiffies_to_clock_t(info.response_time));
 	}
 	len += sprintf(page + len, "intr %u", sum);
 
diff -rup linux-2.6.0-test1/include/linux/sched.h linux-2.6.0-qs/include/linux/sched.h
--- linux-2.6.0-test1/include/linux/sched.h	Sun Jul 13 20:30:40 2003
+++ linux-2.6.0-qs/include/linux/sched.h	Fri Jul 18 15:51:33 2003
@@ -94,6 +94,9 @@ extern unsigned long nr_running(void);
 extern unsigned long nr_uninterruptible(void);
 extern unsigned long nr_iowait(void);
 
+struct sched_info;
+extern void cpu_sched_info(struct sched_info *, int);
+
 #include <linux/time.h>
 #include <linux/param.h>
 #include <linux/resource.h>
@@ -320,6 +323,13 @@ struct k_itimer {
 	struct sigqueue *sigq;		/* signal queue entry. */
 };
 
+struct sched_info {
+	/* running averages */
+	unsigned long response_time, inter_arrival_time, service_time;
+
+	/* timestamps */
+	unsigned long last_arrival, began_service;
+};
 
 struct io_context;			/* See blkdev.h */
 void exit_io_context(void);
@@ -344,6 +354,8 @@ struct task_struct {
 	unsigned long cpus_allowed;
 	unsigned int time_slice, first_time_slice;
 
+	struct sched_info sched_info;
+
 	struct list_head tasks;
 	struct list_head ptrace_children;
 	struct list_head ptrace_list;
diff -rup linux-2.6.0-test1/kernel/sched.c linux-2.6.0-qs/kernel/sched.c
--- linux-2.6.0-test1/kernel/sched.c	Sun Jul 13 20:37:14 2003
+++ linux-2.6.0-qs/kernel/sched.c	Fri Jul 18 15:52:26 2003
@@ -59,6 +59,11 @@
 #define TASK_USER_PRIO(p)	USER_PRIO((p)->static_prio)
 #define MAX_USER_PRIO		(USER_PRIO(MAX_PRIO))
 
+/* the FIXED_1 gunk is so running averages don't vanish prematurely */
+#define RAVG_WEIGHT		128
+#define RAVG_FACTOR		(RAVG_WEIGHT*FIXED_1)
+#define RUNNING_AVG(x,y)	(((RAVG_WEIGHT-1)*(x)+RAVG_FACTOR*(y))/RAVG_WEIGHT)
+
 /*
  * These are the 'tuning knobs' of the scheduler:
  *
@@ -171,6 +176,8 @@ struct runqueue {
 	struct list_head migration_queue;
 
 	atomic_t nr_iowait;
+
+	struct sched_info info;
 };
 
 static DEFINE_PER_CPU(struct runqueue, runqueues);
@@ -279,6 +286,74 @@ static inline void rq_unlock(runqueue_t 
 	spin_unlock_irq(&rq->lock);
 }
 
+static inline void sched_info_arrive(task_t *t)
+{
+	unsigned long now  = jiffies;
+	unsigned long diff = now - t->sched_info.last_arrival;
+	struct runqueue *rq = task_rq(t);
+
+	t->sched_info.inter_arrival_time =
+		RUNNING_AVG(t->sched_info.inter_arrival_time, diff);
+	t->sched_info.last_arrival = now;
+
+	if (!rq)
+		return;
+	diff = now - rq->info.last_arrival;
+	rq->info.inter_arrival_time =
+		RUNNING_AVG(rq->info.inter_arrival_time, diff);
+	rq->info.last_arrival = now;
+}
+
+/* is this ever used? */
+static inline void sched_info_depart(task_t *t)
+{
+	struct runqueue *rq = task_rq(t);
+	unsigned long diff, now = jiffies;
+
+	diff = now - t->sched_info.began_service;
+	t->sched_info.service_time =
+		RUNNING_AVG(t->sched_info.service_time, diff);
+
+	if (!rq)
+		return;
+	diff = now - rq->info.began_service;
+	rq->info.service_time =
+		RUNNING_AVG(rq->info.service_time, diff);
+}
+
+static inline void sched_info_switch(task_t *prev, task_t *next)
+{
+	struct runqueue *rq = task_rq(prev);
+	unsigned long diff, now = jiffies;
+
+	/* prev now departs the cpu */
+	sched_info_depart(prev);
+
+	/* only for involuntary context switches */
+	if (prev->state == TASK_RUNNING)
+		sched_info_arrive(prev);
+
+	diff = now - next->sched_info.last_arrival;
+	next->sched_info.response_time =
+		RUNNING_AVG(next->sched_info.response_time, diff);
+	next->sched_info.began_service = now;
+
+	if (!rq)
+		return;
+	/* yes, reusing next's service time is valid */
+	rq->info.response_time =
+		RUNNING_AVG(rq->info.response_time, diff);
+	rq->info.began_service = now;
+
+	if (prev->state != TASK_RUNNING)
+		return;
+	/* if prev arrived subtract rq's last arrival from its arrival */
+	diff = now - rq->info.last_arrival;
+	rq->info.inter_arrival_time =
+		RUNNING_AVG(rq->info.inter_arrival_time, diff);
+	rq->info.last_arrival = now;
+}
+
 /*
  * Adding/removing a task to/from a priority array:
  */
@@ -492,15 +567,18 @@ repeat_lock_task:
 				(p->cpus_allowed & (1UL << smp_processor_id())))) {
 
 				set_task_cpu(p, smp_processor_id());
+				sched_info_arrive(p);
 				task_rq_unlock(rq, &flags);
 				goto repeat_lock_task;
 			}
 			if (old_state == TASK_UNINTERRUPTIBLE)
 				rq->nr_uninterruptible--;
-			if (sync)
+			if (sync) {
+				sched_info_arrive(p);
 				__activate_task(p, rq);
-			else {
+			} else {
 				activate_task(p, rq);
+				sched_info_arrive(p);
 				if (p->prio < rq->curr->prio)
 					resched_task(rq->curr);
 			}
@@ -554,6 +632,7 @@ void wake_up_forked_process(task_t * p)
 	p->sleep_avg = p->sleep_avg * CHILD_PENALTY / 100;
 	p->prio = effective_prio(p);
 	set_task_cpu(p, smp_processor_id());
+	sched_info_arrive(p);
 
 	if (unlikely(!current->array))
 		__activate_task(p, rq);
@@ -715,6 +794,11 @@ unsigned long nr_iowait(void)
 	return sum;
 }
 
+void cpu_sched_info(struct sched_info *info, int cpu)
+{
+	memcpy(info, &cpu_rq(cpu)->info, sizeof(struct sched_info));
+}
+
 /*
  * double_rq_lock - safely lock two runqueues
  *
@@ -1337,6 +1421,7 @@ switch_tasks:
 
 	if (likely(prev != next)) {
 		rq->nr_switches++;
+		sched_info_switch(prev, next);
 		rq->curr = next;
 
 		prepare_arch_switch(rq, next);
