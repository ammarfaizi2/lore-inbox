Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964874AbVLFAjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbVLFAjH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 19:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbVLFAfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 19:35:14 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:35278
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751543AbVLFAek
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 19:34:40 -0500
Message-Id: <20051206000155.335080000@tglx.tec.linutronix.de>
References: <20051206000126.589223000@tglx.tec.linutronix.de>
Date: Tue, 06 Dec 2005 01:01:44 +0100
From: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, rostedt@goodmis.org, johnstul@us.ibm.com,
       zippel@linux-m86k.org, mingo@elte.hu
Subject: [patch 18/21] Create hrtimer nanosleep API
Content-Disposition: inline; filename=hrtimer-nanosleep-interface.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- introduce the hrtimer_nanosleep() and hrtimer_nanosleep_real() APIs.
  Not yet used by any code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

 include/linux/hrtimer.h |    6 ++
 kernel/hrtimer.c        |  127 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 133 insertions(+)

Index: linux-2.6.15-rc5/include/linux/hrtimer.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/hrtimer.h
+++ linux-2.6.15-rc5/include/linux/hrtimer.h
@@ -121,6 +121,12 @@ static inline int hrtimer_active(const s
 extern unsigned long hrtimer_forward(struct hrtimer *timer,
 				     const ktime_t interval);
 
+/* Precise sleep: */
+extern long hrtimer_nanosleep(struct timespec *rqtp,
+			      struct timespec __user *rmtp,
+			      const enum hrtimer_mode mode,
+			      const clockid_t clockid);
+
 /* Soft interrupt function to run the hrtimer queues: */
 extern void hrtimer_run_queues(void);
 
Index: linux-2.6.15-rc5/kernel/hrtimer.c
===================================================================
--- linux-2.6.15-rc5.orig/kernel/hrtimer.c
+++ linux-2.6.15-rc5/kernel/hrtimer.c
@@ -581,6 +581,133 @@ void hrtimer_run_queues(void)
 }
 
 /*
+ * Sleep related functions:
+ */
+
+/**
+ * schedule_hrtimer - sleep until timeout
+ *
+ * @timer:	hrtimer variable initialized with the correct clock base
+ * @mode:	timeout value is abs/rel
+ *
+ * Make the current task sleep until @timeout is
+ * elapsed.
+ *
+ * You can set the task state as follows -
+ *
+ * %TASK_UNINTERRUPTIBLE - at least @timeout is guaranteed to
+ * pass before the routine returns. The routine will return 0
+ *
+ * %TASK_INTERRUPTIBLE - the routine may return early if a signal is
+ * delivered to the current task. In this case the remaining time
+ * will be returned
+ *
+ * The current task state is guaranteed to be TASK_RUNNING when this
+ * routine returns.
+ */
+static ktime_t __sched
+schedule_hrtimer(struct hrtimer *timer, const enum hrtimer_mode mode)
+{
+	/* fn stays NULL, meaning single-shot wakeup: */
+	timer->data = current;
+
+	hrtimer_start(timer, timer->expires, mode);
+
+	schedule();
+	hrtimer_cancel(timer);
+
+	/* Return the remaining time: */
+	if (timer->state != HRTIMER_EXPIRED)
+		return ktime_sub(timer->expires, timer->base->get_time());
+	else
+		return (ktime_t) {.tv64 = 0 };
+}
+
+static inline ktime_t __sched
+schedule_hrtimer_interruptible(struct hrtimer *timer,
+			       const enum hrtimer_mode mode)
+{
+	set_current_state(TASK_INTERRUPTIBLE);
+
+	return schedule_hrtimer(timer, mode);
+}
+
+static long __sched
+nanosleep_restart(struct restart_block *restart, clockid_t clockid)
+{
+	struct timespec __user *rmtp, tu;
+	void *rfn_save = restart->fn;
+	struct hrtimer timer;
+	ktime_t rem;
+
+	restart->fn = do_no_restart_syscall;
+
+	hrtimer_init(&timer, clockid);
+
+	timer.expires.tv64 = ((u64)restart->arg1 << 32) | (u64) restart->arg0;
+
+	rem = schedule_hrtimer_interruptible(&timer, HRTIMER_ABS);
+
+	if (rem.tv64 <= 0)
+		return 0;
+
+	rmtp = (struct timespec __user *) restart->arg2;
+	tu = ktime_to_timespec(rem);
+	if (rmtp && copy_to_user(rmtp, &tu, sizeof(tu)))
+		return -EFAULT;
+
+	restart->fn = rfn_save;
+
+	/* The other values in restart are already filled in */
+	return -ERESTART_RESTARTBLOCK;
+}
+
+static long __sched nanosleep_restart_mono(struct restart_block *restart)
+{
+	return nanosleep_restart(restart, CLOCK_MONOTONIC);
+}
+
+static long __sched nanosleep_restart_real(struct restart_block *restart)
+{
+	return nanosleep_restart(restart, CLOCK_REALTIME);
+}
+
+long hrtimer_nanosleep(struct timespec *rqtp, struct timespec __user *rmtp,
+		       const enum hrtimer_mode mode, const clockid_t clockid)
+{
+	struct restart_block *restart;
+	struct hrtimer timer;
+	struct timespec tu;
+	ktime_t rem;
+
+	hrtimer_init(&timer, clockid);
+
+	timer.expires = timespec_to_ktime(*rqtp);
+
+	rem = schedule_hrtimer_interruptible(&timer, mode);
+	if (rem.tv64 <= 0)
+		return 0;
+
+	/* Absolute timers do not update the rmtp value: */
+	if (mode == HRTIMER_ABS)
+		return -ERESTARTNOHAND;
+
+	tu = ktime_to_timespec(rem);
+
+	if (rmtp && copy_to_user(rmtp, &tu, sizeof(tu)))
+		return -EFAULT;
+
+	restart = &current_thread_info()->restart_block;
+	restart->fn = (clockid == CLOCK_MONOTONIC) ?
+		nanosleep_restart_mono : nanosleep_restart_real;
+	restart->arg0 = timer.expires.tv64 & 0xFFFFFFFF;
+	restart->arg1 = timer.expires.tv64 >> 32;
+	restart->arg2 = (unsigned long) rmtp;
+
+	return -ERESTART_RESTARTBLOCK;
+}
+
+/*
  * Functions related to boot-time initialization:
  */
 static void __devinit init_hrtimers_cpu(int cpu)

--

