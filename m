Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751288AbVLAALE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbVLAALE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 19:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbVLAAK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 19:10:57 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:59298
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751310AbVK3X6G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:58:06 -0500
Subject: [patch 21/43] Switch clock_nanosleep to ktimer nanosleep API
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu, zippel@linux-m68k.org, george@mvista.com,
       johnstul@us.ibm.com
References: <20051130231140.164337000@tglx.tec.linutronix.de>
Content-Type: text/plain
Organization: linutronix
Date: Thu, 01 Dec 2005 01:03:38 +0100
Message-Id: <1133395418.32542.464.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment
(ktimer-convert-posix-clock-nanosleep.patch)
- Switch clock_nanosleep to use the new nanosleep functions
  in ktimer.c

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

 include/linux/posix-timers.h |    7 +-
 kernel/posix-cpu-timers.c    |   23 ++++--
 kernel/posix-timers.c        |  150 +++++++------------------------------------
 3 files changed, 44 insertions(+), 136 deletions(-)

Index: linux-2.6.15-rc2-rework/include/linux/posix-timers.h
===================================================================
--- linux-2.6.15-rc2-rework.orig/include/linux/posix-timers.h
+++ linux-2.6.15-rc2-rework/include/linux/posix-timers.h
@@ -81,7 +81,7 @@ struct k_clock {
 	int (*clock_get) (const clockid_t which_clock, struct timespec * tp);
 	int (*timer_create) (struct k_itimer *timer);
 	int (*nsleep) (const clockid_t which_clock, int flags,
-		       struct timespec *);
+		       struct timespec *, struct timespec __user *);
 	int (*timer_set) (struct k_itimer * timr, int flags,
 			  struct itimerspec * new_setting,
 			  struct itimerspec * old_setting);
@@ -95,7 +95,8 @@ void register_posix_clock(const clockid_
 
 /* error handlers for timer_create, nanosleep and settime */
 int do_posix_clock_notimer_create(struct k_itimer *timer);
-int do_posix_clock_nonanosleep(const clockid_t, int flags, struct timespec *);
+int do_posix_clock_nonanosleep(const clockid_t, int flags, struct timespec *,
+			       struct timespec __user *);
 int do_posix_clock_nosettime(const clockid_t, struct timespec *tp);
 
 /* function to call to trigger timer event */
@@ -129,7 +130,7 @@ int posix_cpu_clock_get(const clockid_t 
 int posix_cpu_clock_set(const clockid_t which_clock, const struct timespec *ts);
 int posix_cpu_timer_create(struct k_itimer *timer);
 int posix_cpu_nsleep(const clockid_t which_clock, int flags,
-		     struct timespec *ts);
+		     struct timespec *rqtp, struct timespec __user *rmtp);
 int posix_cpu_timer_set(struct k_itimer *timer, int flags,
 			struct itimerspec *new, struct itimerspec *old);
 int posix_cpu_timer_del(struct k_itimer *timer);
Index: linux-2.6.15-rc2-rework/kernel/posix-cpu-timers.c
===================================================================
--- linux-2.6.15-rc2-rework.orig/kernel/posix-cpu-timers.c
+++ linux-2.6.15-rc2-rework/kernel/posix-cpu-timers.c
@@ -1411,7 +1411,7 @@ void set_process_cpu_timer(struct task_s
 static long posix_cpu_clock_nanosleep_restart(struct restart_block *);
 
 int posix_cpu_nsleep(const clockid_t which_clock, int flags,
-		     struct timespec *rqtp)
+		     struct timespec *rqtp, struct timespec __user *rmtp)
 {
 	struct restart_block *restart_block =
 	    &current_thread_info()->restart_block;
@@ -1436,7 +1436,6 @@ int posix_cpu_nsleep(const clockid_t whi
 	error = posix_cpu_timer_create(&timer);
 	timer.it_process = current;
 	if (!error) {
-		struct timespec __user *rmtp;
 		static struct itimerspec zero_it;
 		struct itimerspec it = { .it_value = *rqtp,
 					 .it_interval = {} };
@@ -1483,7 +1482,6 @@ int posix_cpu_nsleep(const clockid_t whi
 		/*
 		 * Report back to the user the time still remaining.
 		 */
-		rmtp = (struct timespec __user *) restart_block->arg1;
 		if (rmtp != NULL && !(flags & TIMER_ABSTIME) &&
 		    copy_to_user(rmtp, &it.it_value, sizeof *rmtp))
 			return -EFAULT;
@@ -1491,6 +1489,7 @@ int posix_cpu_nsleep(const clockid_t whi
 		restart_block->fn = posix_cpu_clock_nanosleep_restart;
 		/* Caller already set restart_block->arg1 */
 		restart_block->arg0 = which_clock;
+		restart_block->arg1 = (unsigned long) rmtp;
 		restart_block->arg2 = rqtp->tv_sec;
 		restart_block->arg3 = rqtp->tv_nsec;
 
@@ -1504,10 +1503,15 @@ static long
 posix_cpu_clock_nanosleep_restart(struct restart_block *restart_block)
 {
 	clockid_t which_clock = restart_block->arg0;
-	struct timespec t = { .tv_sec = restart_block->arg2,
-			      .tv_nsec = restart_block->arg3 };
+	struct timespec __user *rmtp;
+	struct timespec t;
+
+	rmtp = (struct timespec __user *) restart_block->arg1;
+	t.tv_sec = restart_block->arg2;
+	t.tv_nsec = restart_block->arg3;
+
 	restart_block->fn = do_no_restart_syscall;
-	return posix_cpu_nsleep(which_clock, TIMER_ABSTIME, &t);
+	return posix_cpu_nsleep(which_clock, TIMER_ABSTIME, &t, rmtp);
 }
 

@@ -1530,9 +1534,10 @@ static int process_cpu_timer_create(stru
 	return posix_cpu_timer_create(timer);
 }
 static int process_cpu_nsleep(const clockid_t which_clock, int flags,
-			      struct timespec *rqtp)
+			      struct timespec *rqtp,
+			      struct timespec __user *rmtp)
 {
-	return posix_cpu_nsleep(PROCESS_CLOCK, flags, rqtp);
+	return posix_cpu_nsleep(PROCESS_CLOCK, flags, rqtp, rmtp);
 }
 static int thread_cpu_clock_getres(const clockid_t which_clock,
 				   struct timespec *tp)
@@ -1550,7 +1555,7 @@ static int thread_cpu_timer_create(struc
 	return posix_cpu_timer_create(timer);
 }
 static int thread_cpu_nsleep(const clockid_t which_clock, int flags,
-			      struct timespec *rqtp)
+			      struct timespec *rqtp, struct timespec __user *rmtp)
 {
 	return -EINVAL;
 }
Index: linux-2.6.15-rc2-rework/kernel/posix-timers.c
===================================================================
--- linux-2.6.15-rc2-rework.orig/kernel/posix-timers.c
+++ linux-2.6.15-rc2-rework/kernel/posix-timers.c
@@ -209,7 +209,8 @@ static inline int common_timer_create(st
 /*
  * These ones are defined below.
  */
-static int common_nsleep(const clockid_t, int flags, struct timespec *t);
+static int common_nsleep(const clockid_t, int flags, struct timespec *t,
+			 struct timespec __user *rmtp);
 static void common_timer_get(struct k_itimer *, struct itimerspec *);
 static int common_timer_set(struct k_itimer *, int,
 			    struct itimerspec *, struct itimerspec *);
@@ -1227,7 +1228,7 @@ int do_posix_clock_notimer_create(struct
 EXPORT_SYMBOL_GPL(do_posix_clock_notimer_create);
 
 int do_posix_clock_nonanosleep(const clockid_t clock, int flags,
-			       struct timespec *t)
+			       struct timespec *t, struct timespec __user *r)
 {
 #ifndef ENOTSUP
 	return -EOPNOTSUPP;	/* aka ENOTSUP in userland for POSIX */
@@ -1387,7 +1388,27 @@ void clock_was_set(void)
 	up(&clock_was_set_lock);
 }
 
-long clock_nanosleep_restart(struct restart_block *restart_block);
+/*
+ * nanosleep for monotonic and realtime clocks
+ */
+static int common_nsleep(const clockid_t which_clock, int flags,
+			 struct timespec *tsave, struct timespec __user *rmtp)
+{
+	int mode = flags & TIMER_ABSTIME ? KTIMER_ABS : KTIMER_REL;
+
+	switch (which_clock) {
+	case CLOCK_REALTIME:
+		/* Posix madness. Only absolute timers on clock realtime
+		   are affected by clock set. */
+		if (mode == KTIMER_ABS)
+			return ktimer_nanosleep_real(tsave, rmtp, mode);
+	case CLOCK_MONOTONIC:
+		return ktimer_nanosleep(tsave, rmtp, mode);
+	default:
+		break;
+	}
+	return -EINVAL;
+}
 
 asmlinkage long
 sys_clock_nanosleep(const clockid_t which_clock, int flags,
@@ -1395,9 +1416,6 @@ sys_clock_nanosleep(const clockid_t whic
 		    struct timespec __user *rmtp)
 {
 	struct timespec t;
-	struct restart_block *restart_block =
-	    &(current_thread_info()->restart_block);
-	int ret;
 
 	if (invalid_clockid(which_clock))
 		return -EINVAL;
@@ -1408,122 +1426,6 @@ sys_clock_nanosleep(const clockid_t whic
 	if (!timespec_valid(&t))
 		return -EINVAL;
 
-	/*
-	 * Do this here as nsleep function does not have the real address.
-	 */
-	restart_block->arg1 = (unsigned long)rmtp;
-
-	ret = CLOCK_DISPATCH(which_clock, nsleep, (which_clock, flags, &t));
-
-	if ((ret == -ERESTART_RESTARTBLOCK) && rmtp &&
-					copy_to_user(rmtp, &t, sizeof (t)))
-		return -EFAULT;
-	return ret;
-}
-
-
-static int common_nsleep(const clockid_t which_clock,
-			 int flags, struct timespec *tsave)
-{
-	struct timespec t, dum;
-	DECLARE_WAITQUEUE(abs_wqueue, current);
-	u64 rq_time = (u64)0;
-	s64 left;
-	int abs;
-	struct restart_block *restart_block =
-	    &current_thread_info()->restart_block;
-
-	abs_wqueue.flags = 0;
-	abs = flags & TIMER_ABSTIME;
-
-	if (restart_block->fn == clock_nanosleep_restart) {
-		/*
-		 * Interrupted by a non-delivered signal, pick up remaining
-		 * time and continue.  Remaining time is in arg2 & 3.
-		 */
-		restart_block->fn = do_no_restart_syscall;
-
-		rq_time = restart_block->arg3;
-		rq_time = (rq_time << 32) + restart_block->arg2;
-		if (!rq_time)
-			return -EINTR;
-		left = rq_time - get_jiffies_64();
-		if (left <= (s64)0)
-			return 0;	/* Already passed */
-	}
-
-	if (abs && (posix_clocks[which_clock].clock_get !=
-			    posix_clocks[CLOCK_MONOTONIC].clock_get))
-		add_wait_queue(&nanosleep_abs_wqueue, &abs_wqueue);
-
-	do {
-		t = *tsave;
-		if (abs || !rq_time) {
-			adjust_abs_time(&posix_clocks[which_clock], &t, abs,
-					&rq_time, &dum);
-		}
-
-		left = rq_time - get_jiffies_64();
-		if (left >= (s64)MAX_JIFFY_OFFSET)
-			left = (s64)MAX_JIFFY_OFFSET;
-		if (left < (s64)0)
-			break;
-
-		schedule_timeout_interruptible(left);
-
-		left = rq_time - get_jiffies_64();
-	} while (left > (s64)0 && !test_thread_flag(TIF_SIGPENDING));
-
-	if (abs_wqueue.task_list.next)
-		finish_wait(&nanosleep_abs_wqueue, &abs_wqueue);
-
-	if (left > (s64)0) {
-
-		/*
-		 * Always restart abs calls from scratch to pick up any
-		 * clock shifting that happened while we are away.
-		 */
-		if (abs)
-			return -ERESTARTNOHAND;
-
-		left *= TICK_NSEC;
-		tsave->tv_sec = div_long_long_rem(left, 
-						  NSEC_PER_SEC, 
-						  &tsave->tv_nsec);
-		/*
-		 * Restart works by saving the time remaing in 
-		 * arg2 & 3 (it is 64-bits of jiffies).  The other
-		 * info we need is the clock_id (saved in arg0). 
-		 * The sys_call interface needs the users 
-		 * timespec return address which _it_ saves in arg1.
-		 * Since we have cast the nanosleep call to a clock_nanosleep
-		 * both can be restarted with the same code.
-		 */
-		restart_block->fn = clock_nanosleep_restart;
-		restart_block->arg0 = which_clock;
-		/*
-		 * Caller sets arg1
-		 */
-		restart_block->arg2 = rq_time & 0xffffffffLL;
-		restart_block->arg3 = rq_time >> 32;
-
-		return -ERESTART_RESTARTBLOCK;
-	}
-
-	return 0;
-}
-/*
- * This will restart clock_nanosleep.
- */
-long
-clock_nanosleep_restart(struct restart_block *restart_block)
-{
-	struct timespec t;
-	int ret = common_nsleep(restart_block->arg0, 0, &t);
-
-	if ((ret == -ERESTART_RESTARTBLOCK) && restart_block->arg1 &&
-	    copy_to_user((struct timespec __user *)(restart_block->arg1), &t,
-			 sizeof (t)))
-		return -EFAULT;
-	return ret;
+	return CLOCK_DISPATCH(which_clock, nsleep,
+			      (which_clock, flags, &t, rmtp));
 }

--

