Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262609AbVAUXij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262609AbVAUXij (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 18:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbVAUXg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 18:36:59 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:49117 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262589AbVAUXbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 18:31:00 -0500
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt
	scheduling
From: utz lehmann <lkml@s2y4n2c.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       rlrevell@joe-job.com, paul@linuxaudiosystems.com, joq@io.com,
       CK Kernel <ck@vds.kolivas.org>, Andrew Morton <akpm@osdl.org>,
       alexn@dsv.su.se
In-Reply-To: <41EEE1B1.9080909@kolivas.org>
References: <41EEE1B1.9080909@kolivas.org>
Content-Type: text/plain
Date: Sat, 22 Jan 2005 00:30:45 +0100
Message-Id: <1106350245.4442.5.camel@segv.aura.of.mankind>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a3828f1c4d839cf12e8a3b808f7ed34
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I dislike the behavior of the SCHED_ISO patch that iso tasks are
degraded to SCHED_NORMAL if they exceed the limit.
IMHO it's better to throttle them at the iso_cpu limit.

I have modified Con's iso2 patch to do this. If iso_cpu > 50 iso tasks
only get stalled for 1 tick (1ms on x86).

Fortunately there is a currently unused task prio (MAX_RT_PRIO-1) [1]. I
used it for ISO_PRIO. All SCHED_ISO tasks use it and they not changing
to other priorities. SCHED_ISO is a realtime class with the specialty
that it can preempted by SCHED_NORMAL tasks if iso_throttle is set. With
this the iso queue stuff is not needed.

iso_throttle controls if a SCHED_ISO task can be preempted. It's set by
the RT task load.

With my patch rt_task() also includes iso tasks. I have added a
posix_rt_task() for only SCHED_FIFO and SCHED_RR.
I changed the iso_period sysctl to iso_timeout which is in centisecs.
A iso_throttle_count sysctl is added which count the ticks when a iso
task is preempted by the timer. It uses currently a simple global
variable. It should be per runqueue. And i'm not sure a sysctl is an
appropriate place for it (/sys, /proc?).

It's for 2.6.11-rc1 and i have tested it only on UP x86.

I'm a kernel hacker newbie. Please tell me if this is nonsense, good,
can be improved, ...


utz

[1] Actually MAX_RT_PRIO-1 is used by sched_idle_next() and
migration_call(). I changed it to MAX_RT_PRIO-2 for them. I think it's
ok.


diff -Nrup linux-2.6.11-rc1/include/linux/sched.h linux-2.6.11-rc1-uiso2/include/linux/sched.h
--- linux-2.6.11-rc1/include/linux/sched.h	2005-01-21 19:46:54.677616421 +0100
+++ linux-2.6.11-rc1-uiso2/include/linux/sched.h	2005-01-21 20:30:29.616340716 +0100
@@ -130,6 +130,24 @@ extern unsigned long nr_iowait(void);
 #define SCHED_NORMAL		0
 #define SCHED_FIFO		1
 #define SCHED_RR		2
+/* policy 3 reserved for SCHED_BATCH */
+#define SCHED_ISO		4
+
+extern int iso_cpu, iso_timeout;
+extern int iso_throttle_count;
+extern void account_iso_ticks(struct task_struct *p);
+
+#define SCHED_RANGE(policy)	((policy) == SCHED_NORMAL || \
+				(policy) == SCHED_FIFO || \
+				(policy) == SCHED_RR || \
+				(policy) == SCHED_ISO)
+
+#define SCHED_RT(policy)	((policy) == SCHED_FIFO || \
+				(policy) == SCHED_RR || \
+				(policy) == SCHED_ISO)
+
+#define SCHED_POSIX_RT(policy)	((policy) == SCHED_FIFO || \
+				(policy) == SCHED_RR)
 
 struct sched_param {
 	int sched_priority;
@@ -342,9 +360,11 @@ struct signal_struct {
 
 /*
  * Priority of a process goes from 0..MAX_PRIO-1, valid RT
- * priority is 0..MAX_RT_PRIO-1, and SCHED_NORMAL tasks are
- * in the range MAX_RT_PRIO..MAX_PRIO-1. Priority values
- * are inverted: lower p->prio value means higher priority.
+ * priority is 0..MAX_RT_PRIO-1. SCHED_FIFO and SCHED_RR uses
+ * 0..MAX_RT_PRIO-2, SCHED_ISO uses MAX_RT_PRIO-1.
+ * SCHED_NORMAL tasks are in the range MAX_RT_PRIO..MAX_PRIO-1.
+ * Priority values are inverted: lower p->prio value means
+ * higher priority.
  *
  * The MAX_USER_RT_PRIO value allows the actual maximum
  * RT priority to be separate from the value exported to
@@ -358,7 +378,12 @@ struct signal_struct {
 
 #define MAX_PRIO		(MAX_RT_PRIO + 40)
 
+#define ISO_PRIO		(MAX_RT_PRIO - 1)
+
 #define rt_task(p)		(unlikely((p)->prio < MAX_RT_PRIO))
+#define posix_rt_task(p)       	(unlikely((p)->policy == SCHED_FIFO || \
+					  (p)->policy == SCHED_RR))
+#define iso_task(p)		(unlikely((p)->policy == SCHED_ISO))
 
 /*
  * Some day this will be a full-fledged user tracking system..
diff -Nrup linux-2.6.11-rc1/include/linux/sysctl.h linux-2.6.11-rc1-uiso2/include/linux/sysctl.h
--- linux-2.6.11-rc1/include/linux/sysctl.h	2005-01-21 19:46:54.717612339 +0100
+++ linux-2.6.11-rc1-uiso2/include/linux/sysctl.h	2005-01-21 20:30:38.105484416 +0100
@@ -135,6 +135,9 @@ enum
 	KERN_HZ_TIMER=65,	/* int: hz timer on or off */
 	KERN_UNKNOWN_NMI_PANIC=66, /* int: unknown nmi panic flag */
 	KERN_BOOTLOADER_TYPE=67, /* int: boot loader type */
+	KERN_ISO_CPU=68,        /* int: cpu% allowed by SCHED_ISO class */
+	KERN_ISO_TIMEOUT=69,    /* int: centisecs after SCHED_ISO is throttled */
+	KERN_ISO_THROTTLE_COUNT=70, /* int: no. of throttled SCHED_ISO ticks */
 };
 
 
diff -Nrup linux-2.6.11-rc1/kernel/sched.c linux-2.6.11-rc1-uiso2/kernel/sched.c
--- linux-2.6.11-rc1/kernel/sched.c	2005-01-21 19:46:55.650517137 +0100
+++ linux-2.6.11-rc1-uiso2/kernel/sched.c	2005-01-21 23:35:11.531981295 +0100
@@ -149,9 +149,6 @@
 	(JIFFIES_TO_NS(MAX_SLEEP_AVG * \
 		(MAX_BONUS / 2 + DELTA((p)) + 1) / MAX_BONUS - 1))
 
-#define TASK_PREEMPTS_CURR(p, rq) \
-	((p)->prio < (rq)->curr->prio)
-
 /*
  * task_timeslice() scales user-nice values [ -20 ... 0 ... 19 ]
  * to time slice values: [800ms ... 100ms ... 5ms]
@@ -171,6 +168,11 @@ static unsigned int task_timeslice(task_
 	else
 		return SCALE_PRIO(DEF_TIMESLICE, p->static_prio);
 }
+
+int iso_cpu = 70;	/* The soft %cpu limit on SCHED_ISO tasks */
+int iso_timeout = 500;	/* Cenitsecs after SCHED_ISO is throttled */
+int iso_throttle_count = 0; /* No. of throttled SCHED_ISO ticks */
+
 #define task_hot(p, now, sd) ((long long) ((now) - (p)->last_ran)	\
 				< (long long) (sd)->cache_hot_time)
 
@@ -206,6 +208,8 @@ struct runqueue {
 #ifdef CONFIG_SMP
 	unsigned long cpu_load;
 #endif
+	long iso_ticks;
+	int iso_throttle;
 	unsigned long long nr_switches;
 
 	/*
@@ -297,6 +301,19 @@ static DEFINE_PER_CPU(struct runqueue, r
 # define task_running(rq, p)		((rq)->curr == (p))
 #endif
 
+static inline int task_preempts_curr(task_t *p, runqueue_t *rq)
+{
+	if (unlikely(rq->iso_throttle)) { 
+		if (iso_task(p))
+			return 0;
+		if (iso_task(rq->curr))
+			return 1;
+	}
+	if (p->prio < rq->curr->prio)
+		return 1;
+	return 0;
+}
+
 /*
  * task_rq_lock - lock the runqueue a given task resides on and disable
  * interrupts.  Note the ordering: we can safely lookup the task_rq without
@@ -1101,7 +1118,7 @@ out_activate:
 	 */
 	activate_task(p, rq, cpu == this_cpu);
 	if (!sync || cpu != this_cpu) {
-		if (TASK_PREEMPTS_CURR(p, rq))
+		if (task_preempts_curr(p, rq))
 			resched_task(rq->curr);
 	}
 	success = 1;
@@ -1257,7 +1274,7 @@ void fastcall wake_up_new_task(task_t * 
 		p->timestamp = (p->timestamp - this_rq->timestamp_last_tick)
 					+ rq->timestamp_last_tick;
 		__activate_task(p, rq);
-		if (TASK_PREEMPTS_CURR(p, rq))
+		if (task_preempts_curr(p, rq))
 			resched_task(rq->curr);
 
 		schedstat_inc(rq, wunt_moved);
@@ -1634,7 +1651,7 @@ void pull_task(runqueue_t *src_rq, prio_
 	 * Note that idle threads have a prio of MAX_PRIO, for this test
 	 * to be always true for them.
 	 */
-	if (TASK_PREEMPTS_CURR(p, this_rq))
+	if (task_preempts_curr(p, this_rq))
 		resched_task(this_rq->curr);
 }
 
@@ -2315,6 +2332,33 @@ static void check_rlimit(struct task_str
 }
 
 /*
+ * Account RT tasks for SCHED_ISO throttle. Called every timer tick.
+ * @p: the process that gets accounted
+ */
+void account_iso_ticks(task_t *p)
+{
+	runqueue_t *rq = this_rq();
+
+	if (rt_task(p)) {
+		if (!rq->iso_throttle) {
+			rq->iso_ticks += (100 - iso_cpu);
+		}
+	} else {
+		rq->iso_ticks -= iso_cpu;
+		if (rq->iso_ticks < 0)
+			rq->iso_ticks = 0;
+	}
+
+	if (rq->iso_ticks >
+	    (iso_timeout * (100 - iso_cpu) * HZ / 100 + 100)) {
+		rq->iso_throttle = 1;
+	} else {
+		rq->iso_throttle = 0;
+	}
+
+}
+
+/*
  * Account user cpu time to a process.
  * @p: the process that the cpu time gets accounted to
  * @hardirq_offset: the offset to subtract from hardirq_count()
@@ -2427,7 +2471,7 @@ void scheduler_tick(void)
 	 * timeslice. This makes it possible for interactive tasks
 	 * to use up their timeslices at their highest priority levels.
 	 */
-	if (rt_task(p)) {
+	if (posix_rt_task(p)) {
 		/*
 		 * RR tasks need a special form of timeslice management.
 		 * FIFO tasks have no timeslices.
@@ -2442,6 +2486,22 @@ void scheduler_tick(void)
 		}
 		goto out_unlock;
 	}
+
+	if (iso_task(p)) {
+		if (rq->iso_throttle) {
+			iso_throttle_count++;
+			set_tsk_need_resched(p);
+			goto out_unlock;
+		}
+		if (!(--p->time_slice % GRANULARITY)) {
+			requeue_task(p, rq->active);
+			set_tsk_need_resched(p);
+		}
+		if (!p->time_slice)
+			p->time_slice = task_timeslice(p);
+		goto out_unlock;
+	}
+
 	if (!--p->time_slice) {
 		dequeue_task(p, rq->active);
 		set_tsk_need_resched(p);
@@ -2646,6 +2706,20 @@ EXPORT_SYMBOL(sub_preempt_count);
 
 #endif
 
+static inline void expire_all_iso_tasks(prio_array_t *active,
+					prio_array_t *expired)
+{
+	struct list_head *queue;
+	task_t *next;
+
+	queue = active->queue + ISO_PRIO;
+	while (!list_empty(queue)) {
+		next = list_entry(queue->next, task_t, run_list);
+		dequeue_task(next, active);
+		enqueue_task(next, expired);
+	}
+}
+
 /*
  * schedule() is the main scheduler function.
  */
@@ -2753,6 +2827,7 @@ go_idle:
 	}
 
 	array = rq->active;
+switch_to_expired:
 	if (unlikely(!array->nr_active)) {
 		/*
 		 * Switch the active and expired arrays.
@@ -2767,6 +2842,21 @@ go_idle:
 		schedstat_inc(rq, sched_noswitch);
 
 	idx = sched_find_first_bit(array->bitmap);
+	if (unlikely(rq->iso_throttle && (idx == ISO_PRIO))) {
+		idx = find_next_bit(array->bitmap, MAX_PRIO, ISO_PRIO + 1);
+		if (idx >= MAX_PRIO) {
+			/*
+			 * only SCHED_ISO tasks in active array
+			 */
+			if (rq->expired->nr_active) {
+				expire_all_iso_tasks(array, rq->expired);
+				goto switch_to_expired;
+			} else {
+				idx = ISO_PRIO;
+			}
+		}
+	}
+
 	queue = array->queue + idx;
 	next = list_entry(queue->next, task_t, run_list);
 
@@ -3213,7 +3303,8 @@ static void __setscheduler(struct task_s
 	BUG_ON(p->array);
 	p->policy = policy;
 	p->rt_priority = prio;
-	if (policy != SCHED_NORMAL)
+
+	if (SCHED_RT(policy))
 		p->prio = MAX_USER_RT_PRIO-1 - p->rt_priority;
 	else
 		p->prio = p->static_prio;
@@ -3238,9 +3329,8 @@ recheck:
 	/* double check policy once rq lock held */
 	if (policy < 0)
 		policy = oldpolicy = p->policy;
-	else if (policy != SCHED_FIFO && policy != SCHED_RR &&
-				policy != SCHED_NORMAL)
-			return -EINVAL;
+	else if (!SCHED_RANGE(policy))
+		return -EINVAL;
 	/*
 	 * Valid priorities for SCHED_FIFO and SCHED_RR are
 	 * 1..MAX_USER_RT_PRIO-1, valid priority for SCHED_NORMAL is 0.
@@ -3248,12 +3338,19 @@ recheck:
 	if (param->sched_priority < 0 ||
 	    param->sched_priority > MAX_USER_RT_PRIO-1)
 		return -EINVAL;
-	if ((policy == SCHED_NORMAL) != (param->sched_priority == 0))
+	if ((!SCHED_POSIX_RT(policy)) != (param->sched_priority == 0))
 		return -EINVAL;
 
-	if ((policy == SCHED_FIFO || policy == SCHED_RR) &&
-	    !capable(CAP_SYS_NICE))
-		return -EPERM;
+	if (SCHED_POSIX_RT(policy) && !capable(CAP_SYS_NICE)) {
+		/*
+		 * If the caller requested an POSIX RT policy without
+		 * having the necessary rights, we downgrade the policy
+		 * to SCHED_ISO. Temporary hack for testing.
+		 */
+		policy = SCHED_ISO;
+		param->sched_priority = 0;
+	}
+
 	if ((current->euid != p->euid) && (current->euid != p->uid) &&
 	    !capable(CAP_SYS_NICE))
 		return -EPERM;
@@ -3287,7 +3384,7 @@ recheck:
 		if (task_running(rq, p)) {
 			if (p->prio > oldprio)
 				resched_task(rq->curr);
-		} else if (TASK_PREEMPTS_CURR(p, rq))
+		} else if (task_preempts_curr(p, rq))
 			resched_task(rq->curr);
 	}
 	task_rq_unlock(rq, &flags);
@@ -3714,6 +3811,7 @@ asmlinkage long sys_sched_get_priority_m
 		ret = MAX_USER_RT_PRIO-1;
 		break;
 	case SCHED_NORMAL:
+	case SCHED_ISO:
 		ret = 0;
 		break;
 	}
@@ -3737,6 +3835,7 @@ asmlinkage long sys_sched_get_priority_m
 		ret = 1;
 		break;
 	case SCHED_NORMAL:
+	case SCHED_ISO:
 		ret = 0;
 	}
 	return ret;
@@ -4010,7 +4109,7 @@ static void __migrate_task(struct task_s
 				+ rq_dest->timestamp_last_tick;
 		deactivate_task(p, rq_src);
 		activate_task(p, rq_dest, 0);
-		if (TASK_PREEMPTS_CURR(p, rq_dest))
+		if (task_preempts_curr(p, rq_dest))
 			resched_task(rq_dest->curr);
 	}
 
@@ -4181,7 +4280,7 @@ void sched_idle_next(void)
 	 */
 	spin_lock_irqsave(&rq->lock, flags);
 
-	__setscheduler(p, SCHED_FIFO, MAX_RT_PRIO-1);
+	__setscheduler(p, SCHED_FIFO, MAX_RT_PRIO-2);
 	/* Add idle task to _front_ of it's priority queue */
 	__activate_idle_task(p, rq);
 
@@ -4265,7 +4364,7 @@ static int migration_call(struct notifie
 		kthread_bind(p, cpu);
 		/* Must be high prio: stop_machine expects to yield to it. */
 		rq = task_rq_lock(p, &flags);
-		__setscheduler(p, SCHED_FIFO, MAX_RT_PRIO-1);
+		__setscheduler(p, SCHED_FIFO, MAX_RT_PRIO-2);
 		task_rq_unlock(rq, &flags);
 		cpu_rq(cpu)->migration_thread = p;
 		break;
diff -Nrup linux-2.6.11-rc1/kernel/sysctl.c linux-2.6.11-rc1-uiso2/kernel/sysctl.c
--- linux-2.6.11-rc1/kernel/sysctl.c	2005-01-21 19:46:55.666515504 +0100
+++ linux-2.6.11-rc1-uiso2/kernel/sysctl.c	2005-01-21 20:30:21.820127147 +0100
@@ -219,6 +219,11 @@ static ctl_table root_table[] = {
 	{ .ctl_name = 0 }
 };
 
+/* Constants for minimum and maximum testing in vm_table.
+   We use these as one-element integer vectors. */
+static int zero;
+static int one_hundred = 100;
+
 static ctl_table kern_table[] = {
 	{
 		.ctl_name	= KERN_OSTYPE,
@@ -633,15 +638,36 @@ static ctl_table kern_table[] = {
 		.proc_handler	= &proc_dointvec,
 	},
 #endif
+	{
+		.ctl_name	= KERN_ISO_CPU,
+		.procname	= "iso_cpu",
+		.data		= &iso_cpu,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_minmax,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &zero,
+		.extra2		= &one_hundred,
+	},
+	{
+		.ctl_name	= KERN_ISO_TIMEOUT,
+		.procname	= "iso_timeout",
+		.data		= &iso_timeout,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= KERN_ISO_THROTTLE_COUNT,
+		.procname	= "iso_throttle_count",
+		.data		= &iso_throttle_count,
+		.maxlen		= sizeof(int),
+		.mode		= 0444,
+		.proc_handler	= &proc_dointvec,
+	},
 	{ .ctl_name = 0 }
 };
 
-/* Constants for minimum and maximum testing in vm_table.
-   We use these as one-element integer vectors. */
-static int zero;
-static int one_hundred = 100;
-
-
 static ctl_table vm_table[] = {
 	{
 		.ctl_name	= VM_OVERCOMMIT_MEMORY,
diff -Nrup linux-2.6.11-rc1/kernel/timer.c linux-2.6.11-rc1-uiso2/kernel/timer.c
--- linux-2.6.11-rc1/kernel/timer.c	2005-01-21 19:46:55.672514892 +0100
+++ linux-2.6.11-rc1-uiso2/kernel/timer.c	2005-01-21 20:30:14.254890301 +0100
@@ -815,6 +815,8 @@ void update_process_times(int user_tick)
 	struct task_struct *p = current;
 	int cpu = smp_processor_id();
 
+	account_iso_ticks(p);
+
 	/* Note: this timer irq context must be accounted for as well. */
 	if (user_tick)
 		account_user_time(p, jiffies_to_cputime(1));


