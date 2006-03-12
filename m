Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751427AbWCLKh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbWCLKh1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 05:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751526AbWCLKhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 05:37:00 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:27622
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751451AbWCLKg4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 05:36:56 -0500
Message-Id: <20060312080332.119016000@localhost.localdomain>
References: <20060312080316.826824000@localhost.localdomain>
Date: Sun, 12 Mar 2006 10:37:17 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: [patch 4/8] hrtimer simplify nanosleep
Content-Disposition: inline; filename=hrtimers-simplify-nanosleep.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Roman Zippel <zippel@linux-m68k.org>

nanosleep is the only user of the expired state, so let it manage this
itself, which makes the hrtimer code a bit simpler. The remaining time
is also only calculated if requested.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
Acked-by: Ingo Molnar <mingo@elte.hu>
Acked-by: Thomas Gleixner <tglx@linutronix.de>

 include/linux/hrtimer.h |    4 -
 kernel/hrtimer.c        |  142 ++++++++++++++++++++----------------------------
 2 files changed, 63 insertions(+), 83 deletions(-)

Index: linux-2.6.16-updates/include/linux/hrtimer.h
===================================================================
--- linux-2.6.16-updates.orig/include/linux/hrtimer.h
+++ linux-2.6.16-updates/include/linux/hrtimer.h
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
 
Index: linux-2.6.16-updates/kernel/hrtimer.c
===================================================================
--- linux-2.6.16-updates.orig/kernel/hrtimer.c
+++ linux-2.6.16-updates/kernel/hrtimer.c
@@ -625,30 +625,20 @@ static inline void run_hrtimer_queue(str
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
@@ -672,79 +662,70 @@ void hrtimer_run_queues(void)
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
+	int expired;
+};
 
-	hrtimer_start(timer, timer->expires, mode);
+static int nanosleep_wakeup(void *data)
+{
+	struct sleep_hrtimer *t = data;
 
-	schedule();
-	hrtimer_cancel(timer);
+	t->expired = 1;
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
+	t->expired = 0;
+
+	do {
+		set_current_state(TASK_INTERRUPTIBLE);
+		hrtimer_start(&t->timer, t->timer.expires, mode);
 
-	return schedule_hrtimer(timer, mode);
+		schedule();
+
+		if (unlikely(!t->expired)) {
+			hrtimer_cancel(&t->timer);
+			mode = HRTIMER_ABS;
+		}
+	} while (!t->expired && !signal_pending(current));
+
+	return t->expired;
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
+	hrtimer_init(&t.timer, restart->arg3, HRTIMER_ABS);
+	t.timer.expires.tv64 = ((u64)restart->arg1 << 32) | (u64) restart->arg0;
 
-	rem = schedule_hrtimer_interruptible(&timer, HRTIMER_ABS);
-
-	if (rem.tv64 <= 0)
+	if (do_nanosleep(&t, HRTIMER_ABS))
 		return 0;
 
 	rmtp = (struct timespec __user *) restart->arg2;
-	tu = ktime_to_timespec(rem);
-	if (rmtp && copy_to_user(rmtp, &tu, sizeof(tu)))
-		return -EFAULT;
+	if (rmtp) {
+		time = ktime_sub(t.timer.expires, t.timer.base->get_time());
+		if (time.tv64 <= 0)
+			return 0;
+		tu = ktime_to_timespec(time);
+		if (copy_to_user(rmtp, &tu, sizeof(tu)))
+			return -EFAULT;
+	}
 
-	restart->fn = rfn_save;
+	restart->fn = nanosleep_restart;
 
 	/* The other values in restart are already filled in */
 	return -ERESTART_RESTARTBLOCK;
@@ -754,33 +735,34 @@ long hrtimer_nanosleep(struct timespec *
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
+		if (rem.tv64 <= 0)
+			return 0;
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

--

