Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751299AbVLAAHB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbVLAAHB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 19:07:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbVK3X6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 18:58:12 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:56482
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751303AbVK3X6E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:58:04 -0500
Subject: [patch 19/43] Introduce ktimer_nanosleep APIs
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu, zippel@linux-m68k.org, george@mvista.com,
       johnstul@us.ibm.com
References: <20051130231140.164337000@tglx.tec.linutronix.de>
Content-Type: text/plain
Organization: linutronix
Date: Thu, 01 Dec 2005 01:03:33 +0100
Message-Id: <1133395413.32542.462.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment (ktimer-nanosleep-interface.patch)
- introduce the ktimer_nanosleep() and ktimer_nanosleep_real() APIs.
  Not yet used by any code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

 include/linux/ktimer.h |    6 +
 kernel/ktimer.c        |  164 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 170 insertions(+)

Index: linux-2.6.15-rc2-rework/include/linux/ktimer.h
===================================================================
--- linux-2.6.15-rc2-rework.orig/include/linux/ktimer.h
+++ linux-2.6.15-rc2-rework/include/linux/ktimer.h
@@ -155,6 +155,12 @@ extern ktime_t ktimer_round_timeval(cons
 extern ktime_t ktimer_round_timespec(const struct ktimer *timer,
 				     const struct timespec *ts);
 
+/* Precise sleep: */
+extern long ktimer_nanosleep(struct timespec *rqtp,
+			     struct timespec __user *rmtp, const int mode);
+extern long ktimer_nanosleep_real(struct timespec *rqtp,
+				  struct timespec __user *rmtp, const int mode);
+
 #ifdef CONFIG_SMP
 extern void wait_for_ktimer(const struct ktimer *timer);
 #else
Index: linux-2.6.15-rc2-rework/kernel/ktimer.c
===================================================================
--- linux-2.6.15-rc2-rework.orig/kernel/ktimer.c
+++ linux-2.6.15-rc2-rework/kernel/ktimer.c
@@ -806,6 +806,170 @@ void ktimer_run_queues(void)
 }
 
 /*
+ * Sleep related functions:
+ */
+
+/*
+ * Process-wakeup callback:
+ */
+static void ktimer_wake_up(void *data)
+{
+	wake_up_process(data);
+}
+
+/**
+ * schedule_ktimer - sleep until timeout
+ *
+ * @timer:	ktimer variable initialized with the correct clock base
+ * @t:		timeout value
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
+schedule_ktimer(struct ktimer *timer, ktime_t *t, const int mode)
+{
+	timer->data = current;
+	timer->function = ktimer_wake_up;
+
+	if (unlikely(ktimer_start(timer, t, mode) < 0)) {
+		__set_current_state(TASK_RUNNING);
+	} else {
+		if (current->state != TASK_RUNNING)
+			schedule();
+		ktimer_cancel(timer);
+	}
+
+	/* Store the absolute expiry time */
+	*t = timer->expires;
+
+	/* Return the remaining time */
+	return ktime_sub(timer->expires, timer->expired);
+}
+
+static ktime_t __sched
+schedule_ktimer_interruptible(struct ktimer *timer, ktime_t *t, const int mode)
+{
+	set_current_state(TASK_INTERRUPTIBLE);
+
+	return schedule_ktimer(timer, t, mode);
+}
+
+static long __sched
+nanosleep_restart(struct ktimer *timer, struct restart_block *restart)
+{
+	void *rfn_save = restart->fn;
+	struct timespec __user *rmtp;
+	struct timespec tu;
+	ktime_t t, rem;
+
+	restart->fn = do_no_restart_syscall;
+
+	t = ktime_set_low_high(restart->arg0, restart->arg1);
+
+	rem = schedule_ktimer_interruptible(timer, &t, KTIMER_ABS);
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
+	struct ktimer timer;
+
+	ktimer_init(&timer);
+
+	return nanosleep_restart(&timer, restart);
+}
+
+static long __sched nanosleep_restart_real(struct restart_block *restart)
+{
+	struct ktimer timer;
+
+	ktimer_init_clock(&timer, CLOCK_REALTIME);
+
+	return nanosleep_restart(&timer, restart);
+}
+
+static long __ktimer_nanosleep(struct ktimer *timer, struct timespec *rqtp,
+			     struct timespec __user *rmtp, const int mode,
+			     long (*rfn)(struct restart_block *))
+{
+	struct timespec tu;
+	ktime_t rem, t;
+	struct restart_block *restart;
+
+	t = timespec_to_ktime(*rqtp);
+
+	/* t is updated to absolute expiry time ! */
+	rem = schedule_ktimer_interruptible(timer, &t, mode | KTIMER_ROUND);
+
+	if (rem.tv64 <= 0)
+		return 0;
+
+	/* Absolute timers do not update the rmtp value */
+	if (mode == KTIMER_ABS)
+		return -ERESTARTNOHAND;
+
+	tu = ktime_to_timespec(rem);
+
+	if (rmtp && copy_to_user(rmtp, &tu, sizeof(tu)))
+		return -EFAULT;
+
+	restart = &current_thread_info()->restart_block;
+	restart->fn = rfn;
+	restart->arg0 = ktime_get_low(t);
+	restart->arg1 = ktime_get_high(t);
+	restart->arg2 = (unsigned long) rmtp;
+
+	return -ERESTART_RESTARTBLOCK;
+}
+
+long ktimer_nanosleep(struct timespec *rqtp,
+			   struct timespec __user *rmtp, const int mode)
+{
+	struct ktimer timer;
+
+	ktimer_init(&timer);
+
+	return __ktimer_nanosleep(&timer, rqtp, rmtp, mode,
+				nanosleep_restart_mono);
+}
+
+long ktimer_nanosleep_real(struct timespec *rqtp,
+			   struct timespec __user *rmtp, const int mode)
+{
+	struct ktimer timer;
+
+	ktimer_init_clock(&timer, CLOCK_REALTIME);
+	return __ktimer_nanosleep(&timer, rqtp, rmtp, mode,
+				nanosleep_restart_real);
+}
+
+/*
  * Functions related to boot-time initialization:
  */
 static void __devinit init_ktimers_cpu(int cpu)

--

