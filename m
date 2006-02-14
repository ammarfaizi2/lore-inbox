Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030327AbWBNKLf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030327AbWBNKLf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 05:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030322AbWBNKLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 05:11:25 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:35562 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030316AbWBNKLT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 05:11:19 -0500
Date: Tue, 14 Feb 2006 11:11:15 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, mingo@elte.hu
Subject: [PATCH 05/12] hrtimer: cleanup nanosleep
Message-ID: <Pine.LNX.4.61.0602141111090.3716@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


nanosleep is the only user of the expired state, so let it manage this
itself, which makes the hrtimer code a bit simpler. The remaining time
is also only calculated if requested.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
Acked-by: Ingo Molnar <mingo@elte.hu>

---

 include/linux/hrtimer.h |    4 -
 kernel/hrtimer.c        |  140 ++++++++++++++++++++----------------------------
 2 files changed, 60 insertions(+), 84 deletions(-)

Index: linux-2.6-git/include/linux/hrtimer.h
===================================================================
--- linux-2.6-git.orig/include/linux/hrtimer.h	2006-02-14 04:56:33.000000000 +0100
+++ linux-2.6-git/include/linux/hrtimer.h	2006-02-14 04:56:34.000000000 +0100
@@ -38,9 +38,7 @@ enum hrtimer_restart {
  * Timer states:
  */
 enum hrtimer_state {
-	HRTIMER_INACTIVE,	/* Timer is inactive */
-	HRTIMER_EXPIRED,		/* Timer is expired */
-	HRTIMER_RUNNING,		/* Timer is running the callback function */
+	HRTIMER_INACTIVE,		/* Timer is inactive */
 	HRTIMER_PENDING,		/* Timer is pending */
 };
 
Index: linux-2.6-git/kernel/hrtimer.c
===================================================================
--- linux-2.6-git.orig/kernel/hrtimer.c	2006-02-14 04:56:33.000000000 +0100
+++ linux-2.6-git/kernel/hrtimer.c	2006-02-14 04:56:34.000000000 +0100
@@ -558,30 +558,20 @@ static inline void run_hrtimer_queue(str
 		fn = timer->function;
 		data = timer->data;
 		set_curr_timer(base, timer);
-		timer->state = HRTIMER_RUNNING;
+		timer->state = HRTIMER_INACTIVE;
 		__remove_hrtimer(timer, base);
 		spin_unlock_irq(&base->lock);
 
-		/*
-		 * fn == NULL is special case for the simplest timer
-		 * variant - wake up process and do not restart:
-		 */
-		if (!fn) {
-			wake_up_process(data);
-			restart = HRTIMER_NORESTART;
-		} else
-			restart = fn(data);
+		restart = fn(data);
 
 		spin_lock_irq(&base->lock);
 
 		/* Another CPU has added back the timer */
-		if (timer->state != HRTIMER_RUNNING)
+		if (timer->state != HRTIMER_INACTIVE)
 			continue;
 
-		if (restart == HRTIMER_RESTART)
+		if (restart != HRTIMER_NORESTART)
 			enqueue_hrtimer(timer, base);
-		else
-			timer->state = HRTIMER_EXPIRED;
 	}
 	set_curr_timer(base, NULL);
 	spin_unlock_irq(&base->lock);
@@ -612,79 +602,68 @@ void hrtimer_run_queues(void)
  * Sleep related functions:
  */
 
-/**
- * schedule_hrtimer - sleep until timeout
- *
- * @timer:	hrtimer variable initialized with the correct clock base
- * @mode:	timeout value is abs/rel
- *
- * Make the current task sleep until @timeout is
- * elapsed.
- *
- * You can set the task state as follows -
- *
- * %TASK_UNINTERRUPTIBLE - at least @timeout is guaranteed to
- * pass before the routine returns. The routine will return 0
- *
- * %TASK_INTERRUPTIBLE - the routine may return early if a signal is
- * delivered to the current task. In this case the remaining time
- * will be returned
- *
- * The current task state is guaranteed to be TASK_RUNNING when this
- * routine returns.
- */
-static ktime_t __sched
-schedule_hrtimer(struct hrtimer *timer, const enum hrtimer_mode mode)
-{
-	/* fn stays NULL, meaning single-shot wakeup: */
-	timer->data = current;
+struct sleep_hrtimer {
+	struct hrtimer timer;
+	struct task_struct *task;
+	int done;
+};
 
-	hrtimer_start(timer, timer->expires, mode);
+static int nanosleep_wakeup(void *data)
+{
+	struct sleep_hrtimer *t = data;
 
-	schedule();
-	hrtimer_cancel(timer);
+	t->done = 1;
+	wake_up_process(t->task);
 
-	/* Return the remaining time: */
-	if (timer->state != HRTIMER_EXPIRED)
-		return ktime_sub(timer->expires, timer->base->get_time());
-	else
-		return (ktime_t) {.tv64 = 0 };
+	return HRTIMER_NORESTART;
 }
 
-static inline ktime_t __sched
-schedule_hrtimer_interruptible(struct hrtimer *timer,
-			       const enum hrtimer_mode mode)
+static int __sched do_nanosleep(struct sleep_hrtimer *t, enum hrtimer_mode mode)
 {
-	set_current_state(TASK_INTERRUPTIBLE);
+	t->timer.function = nanosleep_wakeup;
+	t->timer.data = t;
+	t->task = current;
+	t->done = 0;
+
+	do {
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		hrtimer_start(&t->timer, t->timer.expires, mode);
+
+		schedule();
 
-	return schedule_hrtimer(timer, mode);
+		hrtimer_cancel(&t->timer);
+		if (t->done)
+			break;
+		mode = HRTIMER_ABS;
+	} while (!signal_pending(current));
+
+	return t->done;
 }
 
 static long __sched nanosleep_restart(struct restart_block *restart)
 {
+	struct sleep_hrtimer t;
 	struct timespec __user *rmtp;
 	struct timespec tu;
-	void *rfn_save = restart->fn;
-	struct hrtimer timer;
-	ktime_t rem;
+	ktime_t time;
 
 	restart->fn = do_no_restart_syscall;
 
-	hrtimer_init(&timer, (clockid_t) restart->arg3, HRTIMER_ABS);
-
-	timer.expires.tv64 = ((u64)restart->arg1 << 32) | (u64) restart->arg0;
-
-	rem = schedule_hrtimer_interruptible(&timer, HRTIMER_ABS);
-
-	if (rem.tv64 <= 0)
+	hrtimer_init(&t.timer, restart->arg3, HRTIMER_ABS);
+	t.timer.expires.tv64 = ((u64)restart->arg1 << 32) | (u64) restart->arg0;
+	if (do_nanosleep(&t, HRTIMER_ABS))
 		return 0;
 
 	rmtp = (struct timespec __user *) restart->arg2;
-	tu = ktime_to_timespec(rem);
-	if (rmtp && copy_to_user(rmtp, &tu, sizeof(tu)))
-		return -EFAULT;
+	if (rmtp) {
+		time = ktime_sub(t.timer.expires, t.timer.base->get_time());
+		tu = ktime_to_timespec(time);
+		if (copy_to_user(rmtp, &tu, sizeof(tu)))
+			return -EFAULT;
+	}
 
-	restart->fn = rfn_save;
+	restart->fn = nanosleep_restart;
 
 	/* The other values in restart are already filled in */
 	return -ERESTART_RESTARTBLOCK;
@@ -694,33 +673,32 @@ long hrtimer_nanosleep(struct timespec *
 		       const enum hrtimer_mode mode, const clockid_t clockid)
 {
 	struct restart_block *restart;
-	struct hrtimer timer;
+	struct sleep_hrtimer t;
 	struct timespec tu;
 	ktime_t rem;
 
-	hrtimer_init(&timer, clockid, mode);
-
-	timer.expires = timespec_to_ktime(*rqtp);
-
-	rem = schedule_hrtimer_interruptible(&timer, mode);
-	if (rem.tv64 <= 0)
+	hrtimer_init(&t.timer, clockid, mode);
+	t.timer.expires = timespec_to_ktime(*rqtp);
+	if (do_nanosleep(&t, mode))
 		return 0;
 
 	/* Absolute timers do not update the rmtp value and restart: */
 	if (mode == HRTIMER_ABS)
 		return -ERESTARTNOHAND;
 
-	tu = ktime_to_timespec(rem);
-
-	if (rmtp && copy_to_user(rmtp, &tu, sizeof(tu)))
-		return -EFAULT;
+	if (rmtp) {
+		rem = ktime_sub(t.timer.expires, t.timer.base->get_time());
+		tu = ktime_to_timespec(rem);
+		if (copy_to_user(rmtp, &tu, sizeof(tu)))
+			return -EFAULT;
+	}
 
 	restart = &current_thread_info()->restart_block;
 	restart->fn = nanosleep_restart;
-	restart->arg0 = timer.expires.tv64 & 0xFFFFFFFF;
-	restart->arg1 = timer.expires.tv64 >> 32;
+	restart->arg0 = t.timer.expires.tv64 & 0xFFFFFFFF;
+	restart->arg1 = t.timer.expires.tv64 >> 32;
 	restart->arg2 = (unsigned long) rmtp;
-	restart->arg3 = (unsigned long) timer.base->index;
+	restart->arg3 = (unsigned long) t.timer.base->index;
 
 	return -ERESTART_RESTARTBLOCK;
 }
