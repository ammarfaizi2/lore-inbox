Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262217AbVFIAoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbVFIAoU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 20:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262219AbVFIAnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 20:43:16 -0400
Received: from mail12.syd.optusnet.com.au ([211.29.132.193]:54492 "EHLO
	mail12.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262217AbVFIAjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 20:39:55 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [ANNOUNCE][RFC] PlugSched-5.1 for 2.6.12-rc6 and 2.6.12-rc6-mm1
Date: Thu, 9 Jun 2005 10:42:19 +1000
User-Agent: KMail/1.8.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Han <xiphux@gmail.com>,
       William Lee Irwin III <wli@holomorphy.com>
References: <42A68159.9050808@bigpond.net.au>
In-Reply-To: <42A68159.9050808@bigpond.net.au>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_rB5pCbUq19r8XzI"
Message-Id: <200506091042.19987.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_rB5pCbUq19r8XzI
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wed, 8 Jun 2005 03:25 pm, Peter Williams wrote:
> The patch of PlugSched-5.1 for 2.6.12-rc5 applies cleanly to 2.6.12-rc6
> and is available at:

Hi Peter

The recent fix that Ingo posted for the changes to pipe code affects 
significantly the behaviour of the mainline scheduler and should be 
incorporated as soon as possible. Staircase has undergone substantial 
revision in response to this change, fortunately to its advantage removing 
all that extra code I added to your last plugsched version. Anyway here is a 
patch committing Ingo's pipe signalling changes, and the update to staircase 
11.3 in line with those changes. None of this changes the way the other cpu 
schedulers behave but it may be worth investigating how the pipe changes 
affect the behaviour of the ones you maintain.

Cheers,
Con

--Boundary-00=_rB5pCbUq19r8XzI
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="plugsched5.1-s11.2_s11.3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="plugsched5.1-s11.2_s11.3.diff"

Index: linux-2.6.12-rc6-plugsched/fs/pipe.c
===================================================================
--- linux-2.6.12-rc6-plugsched.orig/fs/pipe.c	2005-06-07 09:09:06.000000000 +1000
+++ linux-2.6.12-rc6-plugsched/fs/pipe.c	2005-06-09 10:03:08.000000000 +1000
@@ -39,7 +39,11 @@ void pipe_wait(struct inode * inode)
 {
 	DEFINE_WAIT(wait);
 
-	prepare_to_wait(PIPE_WAIT(*inode), &wait, TASK_INTERRUPTIBLE);
+	/*
+	 * Pipes are system-local resources, so sleeping on them
+	 * is considered a noninteractive wait:
+	 */
+	prepare_to_wait(PIPE_WAIT(*inode), &wait, TASK_INTERRUPTIBLE|TASK_NONINTERACTIVE);
 	up(PIPE_SEM(*inode));
 	schedule();
 	finish_wait(PIPE_WAIT(*inode), &wait);
Index: linux-2.6.12-rc6-plugsched/include/linux/sched.h
===================================================================
--- linux-2.6.12-rc6-plugsched.orig/include/linux/sched.h	2005-06-09 09:51:28.000000000 +1000
+++ linux-2.6.12-rc6-plugsched/include/linux/sched.h	2005-06-09 10:02:29.000000000 +1000
@@ -112,6 +112,7 @@ extern unsigned long nr_iowait(void);
 #define TASK_TRACED		8
 #define EXIT_ZOMBIE		16
 #define EXIT_DEAD		32
+#define TASK_NONINTERACTIVE	64
 
 #define __set_task_state(tsk, state_value)		\
 	do { (tsk)->state = (state_value); } while (0)
Index: linux-2.6.12-rc6-plugsched/include/linux/sched_drv.h
===================================================================
--- linux-2.6.12-rc6-plugsched.orig/include/linux/sched_drv.h	2005-06-09 09:51:28.000000000 +1000
+++ linux-2.6.12-rc6-plugsched/include/linux/sched_drv.h	2005-06-09 09:55:37.000000000 +1000
@@ -27,7 +27,6 @@ struct sched_drv {
 	int (*move_tasks)(runqueue_t *, int, runqueue_t *, unsigned long,
 		 struct sched_domain *, enum idle_type);
 #endif
-	void (*systime_hook)(runqueue_t *, cputime_t);
 	void (*tick)(struct task_struct*, struct runqueue *, unsigned long long);
 #ifdef CONFIG_SCHED_SMT
 	struct task_struct *(*head_of_queue)(union runqueue_queue *);
Index: linux-2.6.12-rc6-plugsched/include/linux/sched_runq.h
===================================================================
--- linux-2.6.12-rc6-plugsched.orig/include/linux/sched_runq.h	2005-06-09 09:51:28.000000000 +1000
+++ linux-2.6.12-rc6-plugsched/include/linux/sched_runq.h	2005-06-09 09:55:50.000000000 +1000
@@ -41,7 +41,6 @@ struct staircase_runqueue_queue {
 	struct list_head queue[STAIRCASE_NUM_PRIO_SLOTS - 1];
 	unsigned int cache_ticks;
 	unsigned int preempted;
-	unsigned long systime_centile;
 };
 #endif
 
Index: linux-2.6.12-rc6-plugsched/kernel/ingosched.c
===================================================================
--- linux-2.6.12-rc6-plugsched.orig/kernel/ingosched.c	2005-06-09 09:51:28.000000000 +1000
+++ linux-2.6.12-rc6-plugsched/kernel/ingosched.c	2005-06-09 10:19:08.000000000 +1000
@@ -388,6 +388,16 @@ static void ingo_wake_up_task(struct tas
 	}
 
 	/*
+	 * Tasks that have marked their sleep as noninteractive get
+	 * woken up without updating their sleep average. (i.e. their
+	 * sleep is handled in a priority-neutral manner, no priority
+	 * boost and no penalty.)
+	 */
+	if (old_state & TASK_NONINTERACTIVE)
+		__activate_task(p, rq);
+	else
+		activate_task(p, rq, same_cpu);
+	/*
 	 * Sync wakeups (i.e. those types of wakeups where the waker
 	 * has indicated that it will leave the CPU in short order)
 	 * don't trigger a preemption, if the woken up task will run on
@@ -395,7 +405,6 @@ static void ingo_wake_up_task(struct tas
 	 * the waker guarantees that the freshly woken up task is going
 	 * to be considered on this CPU.)
 	 */
-	activate_task(p, rq, same_cpu);
 	if (!sync || !same_cpu) {
 		if (TASK_PREEMPTS_CURR(p, rq))
 			resched_task(rq->curr);
@@ -1148,7 +1157,6 @@ const struct sched_drv ingo_sched_drv = 
 #ifdef CONFIG_SMP
 	.move_tasks = ingo_move_tasks,
 #endif
-	.systime_hook = blank_systime_hook,
 	.tick = ingo_tick,
 #ifdef CONFIG_SCHED_SMT
 	.head_of_queue = ingo_head_of_queue,
Index: linux-2.6.12-rc6-plugsched/kernel/nicksched.c
===================================================================
--- linux-2.6.12-rc6-plugsched.orig/kernel/nicksched.c	2005-06-09 09:51:28.000000000 +1000
+++ linux-2.6.12-rc6-plugsched/kernel/nicksched.c	2005-06-09 09:56:29.000000000 +1000
@@ -965,7 +965,6 @@ const struct sched_drv nick_sched_drv = 
 #ifdef CONFIG_SMP
 	.move_tasks = nick_move_tasks,
 #endif
-	.systime_hook = blank_systime_hook,
 	.tick = nick_tick,
 #ifdef CONFIG_SCHED_SMT
 	.head_of_queue = nick_head_of_queue,
Index: linux-2.6.12-rc6-plugsched/kernel/sched.c
===================================================================
--- linux-2.6.12-rc6-plugsched.orig/kernel/sched.c	2005-06-09 09:51:28.000000000 +1000
+++ linux-2.6.12-rc6-plugsched/kernel/sched.c	2005-06-09 09:56:43.000000000 +1000
@@ -1401,7 +1401,6 @@ void account_system_time(struct task_str
 	acct_update_integrals(p);
 	/* Update rss highwater mark */
 	update_mem_hiwater(p);
-	sched_drvp->systime_hook(rq, cputime);
 }
 
 /*
Index: linux-2.6.12-rc6-plugsched/kernel/sched_drv.c
===================================================================
--- linux-2.6.12-rc6-plugsched.orig/kernel/sched_drv.c	2005-06-09 09:51:28.000000000 +1000
+++ linux-2.6.12-rc6-plugsched/kernel/sched_drv.c	2005-06-09 09:57:52.000000000 +1000
@@ -135,10 +135,3 @@ void __init sched_drv_sysfs_init(void)
 		(void)kobject_register(&sched_drv_kobj);
  	}
 }
-
-/*
- * Dummy functions
- */
-void blank_systime_hook(runqueue_t *rq, cputime_t cputime)
-{
-}
Index: linux-2.6.12-rc6-plugsched/kernel/sched_spa.c
===================================================================
--- linux-2.6.12-rc6-plugsched.orig/kernel/sched_spa.c	2005-06-09 09:51:28.000000000 +1000
+++ linux-2.6.12-rc6-plugsched/kernel/sched_spa.c	2005-06-09 09:57:03.000000000 +1000
@@ -1498,7 +1498,6 @@ const struct sched_drv spa_nf_sched_drv 
 #ifdef CONFIG_SMP
 	.move_tasks = spa_move_tasks,
 #endif
-	.systime_hook = blank_systime_hook,
 	.tick = spa_tick,
 #ifdef CONFIG_SCHED_SMT
 	.head_of_queue = spa_head_of_queue,
@@ -1545,7 +1544,6 @@ const struct sched_drv zaphod_sched_drv 
 	.head_of_queue = spa_head_of_queue,
 	.dependent_sleeper_trumps = spa_dependent_sleeper_trumps,
 #endif
-	.systime_hook = blank_systime_hook,
 	.schedule = spa_schedule,
 	.set_normal_task_nice = spa_set_normal_task_nice,
 	.setscheduler = spa_setscheduler,
Index: linux-2.6.12-rc6-plugsched/kernel/staircase.c
===================================================================
--- linux-2.6.12-rc6-plugsched.orig/kernel/staircase.c	2005-06-09 09:51:28.000000000 +1000
+++ linux-2.6.12-rc6-plugsched/kernel/staircase.c	2005-06-09 10:20:05.000000000 +1000
@@ -2,8 +2,8 @@
  *  kernel/staircase.c
  *  Copyright (C) 1991-2005  Linus Torvalds
  *
- * 2005-05-26 Staircase scheduler by Con Kolivas
- *            Staircase v11.2
+ * 2005-06-07 Staircase scheduler by Con Kolivas
+ *            Staircase v11.3
  */
 #include <linux/sched.h>
 #include <linux/init.h>
@@ -17,9 +17,8 @@
 /*
  * Unique staircase process flags used by scheduler.
  */
-#define SF_FORKED	0x00000001	/* I have just forked */
+#define SF_NONSLEEP	0x00000001	/* Waiting on in kernel activity */
 #define SF_YIELDED	0x00000002	/* I have just yielded */
-#define SF_UISLEEP	0x00000004	/* Uninterruptible sleep */
 
 #define task_is_queued(p) (!list_empty(&(p)->run_list))
 
@@ -263,31 +262,29 @@ static void continue_slice(task_t *p)
  * slice instead of starting a new one at high priority.
  */
 static inline void recalc_task_prio(task_t *p, unsigned long long now,
-	unsigned long rq_systime, unsigned long rq_running)
+	unsigned long rq_running)
 {
 	unsigned long sleep_time = ns_diff(now, p->timestamp);
 
 	/*
 	 * Priority is elevated back to best by amount of sleep_time.
-	 * sleep_time is scaled down by in-kernel system time and by
-	 * number of tasks currently running.
+	 * sleep_time is scaled down by number of tasks currently running.
 	 */
-	sleep_time /= rq_running + 1;
-	if (rq_systime)
-		sleep_time = sleep_time / 200 * (100 - rq_systime);
+	if (rq_running > 1)
+		sleep_time /= rq_running;
 
 	p->sdu.staircase.totalrun += p->sdu.staircase.runtime;
 	if (NS_TO_JIFFIES(p->sdu.staircase.totalrun) >=
 		p->sdu.staircase.slice && NS_TO_JIFFIES(sleep_time) <
 		p->sdu.staircase.slice) {
-			p->sdu.staircase.sflags &= ~SF_FORKED;
+			p->sdu.staircase.sflags &= ~SF_NONSLEEP;
 			dec_burst(p);
 			goto new_slice;
 	}
 
-	if (p->sdu.staircase.sflags & SF_FORKED) {
+	if (p->sdu.staircase.sflags & SF_NONSLEEP) {
 		continue_slice(p);
-		p->sdu.staircase.sflags &= ~SF_FORKED;
+		p->sdu.staircase.sflags &= ~SF_NONSLEEP;
 		return;
 	}
 
@@ -297,7 +294,7 @@ static inline void recalc_task_prio(task
 	}
 
 	if (sleep_time >= p->sdu.staircase.totalrun) {
-		if (!(p->sdu.staircase.sflags & SF_UISLEEP))
+		if (!(p->sdu.staircase.sflags & SF_NONSLEEP))
 			inc_burst(p);
 		goto new_slice;
 	}
@@ -330,9 +327,8 @@ static void activate_task(task_t *p, run
 #endif
 	p->sdu.staircase.slice = slice(p);
 	p->sdu.staircase.time_slice = rr_interval(p);
-	recalc_task_prio(p, now, rq->qu.staircase.systime_centile / 100,
-		rq->nr_running);
-	p->sdu.staircase.sflags &= ~SF_UISLEEP;
+	recalc_task_prio(p, now, rq->nr_running);
+	p->sdu.staircase.sflags &= ~SF_NONSLEEP;
 	p->prio = effective_prio(p);
 	p->timestamp = now;
 	__activate_task(p, rq);
@@ -387,6 +383,13 @@ static void staircase_wake_up_task(struc
 		rq->nr_uninterruptible--;
 
 	/*
+	 * Tasks that have marked their sleep as noninteractive get
+	 * woken up without their sleep counting.
+	 */
+	if (old_state & TASK_NONINTERACTIVE)
+		p->sdu.staircase.sflags |= SF_NONSLEEP;
+
+	/*
 	 * Sync wakeups (i.e. those types of wakeups where the waker
 	 * has indicated that it will leave the CPU in short order)
 	 * don't trigger a preemption, if the woken up task will run on
@@ -432,7 +435,7 @@ static void staircase_wake_up_new_task(t
 	p->sdu.staircase.burst = 0;
 
 	if (likely(cpu == this_cpu)) {
-		current->sdu.staircase.sflags |= SF_FORKED;
+		current->sdu.staircase.sflags |= SF_NONSLEEP;
 		activate_task(p, rq, 1);
 		if (!(clone_flags & CLONE_VM))
 			/*
@@ -467,7 +470,7 @@ static void staircase_wake_up_new_task(t
 		 */
 		task_rq_unlock(rq, &flags);
 		this_rq = task_rq_lock(current, &flags);
-		current->sdu.staircase.sflags |= SF_FORKED;
+		current->sdu.staircase.sflags |= SF_NONSLEEP;
 	}
 
 	task_rq_unlock(this_rq, &flags);
@@ -582,12 +585,6 @@ static void time_slice_expired(task_t *p
 	enqueue_task(p, rqq);
 }
 
-static void staircase_systime_hook(runqueue_t *rq, cputime_t cputime)
-{
-	/* For calculating rolling percentage of sys time per runqueue */
-	rq->qu.staircase.systime_centile += cputime * 100;
-}
-
 /*
  * This function gets called by the timer code, with HZ frequency.
  * We call it with interrupts disabled.
@@ -598,10 +595,6 @@ static void staircase_tick(struct task_s
 	int cpu = smp_processor_id();
 	unsigned long debit, expired_balance = rq->nr_running;
 
-	/* Rolling percentage systime per runqueue */
-	rq->qu.staircase.systime_centile = rq->qu.staircase.systime_centile *
-		99 / 100;
-
 	if (p == rq->idle) {
 		if (wake_priority_sleeper(rq))
 			goto out;
@@ -711,7 +704,7 @@ static void staircase_schedule(void)
 		else {
 			if (prev->state == TASK_UNINTERRUPTIBLE) {
 				rq->nr_uninterruptible++;
-				prev->sdu.staircase.sflags |= SF_UISLEEP;
+				prev->sdu.staircase.sflags |= SF_NONSLEEP;
 			}
 			deactivate_task(prev, rq);
 		}
@@ -1014,7 +1007,6 @@ const struct sched_drv staircase_sched_d
 #ifdef CONFIG_SMP
 	.move_tasks = staircase_move_tasks,
 #endif
-	.systime_hook = staircase_systime_hook,
 	.tick = staircase_tick,
 #ifdef CONFIG_SCHED_SMT
 	.head_of_queue = staircase_head_of_queue,

--Boundary-00=_rB5pCbUq19r8XzI--
