Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422637AbWJDRl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422637AbWJDRl7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 13:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422634AbWJDRlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 13:41:55 -0400
Received: from www.osadl.org ([213.239.205.134]:19173 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1161901AbWJDRh4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 13:37:56 -0400
Message-Id: <20061004172222.893811000@cruncher.tec.linutronix.de>
References: <20061004172217.092570000@cruncher.tec.linutronix.de>
Date: Wed, 04 Oct 2006 17:31:39 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       John Stultz <johnstul@us.ibm.com>,
       Valdis Kletnieks <valdis.kletnieks@vt.edu>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>,
       David Woodhouse <dwmw2@infradead.org>, Jim Gettys <jg@laptop.org>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: [patch 09/22] hrtimers: namespace and enum cleanup
Content-Disposition: inline; filename=hrtimers-namespace-and-enum-cleanup.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

- hrtimers did not use the hrtimer_restart enum and relied on the implict
  int representation. Fix the prototypes and the functions using the enums.
- Use seperate name spaces for the enumerations
- Convert hrtimer_restart macro to inline function
- Add comments

No functional changes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
 include/linux/hrtimer.h |   20 ++++++++++++--------
 include/linux/timer.h   |    2 +-
 kernel/fork.c           |    2 +-
 kernel/futex.c          |    2 +-
 kernel/hrtimer.c        |   18 +++++++++---------
 kernel/itimer.c         |    4 ++--
 kernel/posix-timers.c   |   13 +++++++------
 kernel/rtmutex.c        |    2 +-
 8 files changed, 34 insertions(+), 29 deletions(-)

Index: linux-2.6.18-mm3/include/linux/hrtimer.h
===================================================================
--- linux-2.6.18-mm3.orig/include/linux/hrtimer.h	2006-10-04 18:13:54.000000000 +0200
+++ linux-2.6.18-mm3/include/linux/hrtimer.h	2006-10-04 18:13:55.000000000 +0200
@@ -25,17 +25,18 @@
  * Mode arguments of xxx_hrtimer functions:
  */
 enum hrtimer_mode {
-	HRTIMER_ABS,	/* Time value is absolute */
-	HRTIMER_REL,	/* Time value is relative to now */
+	HRTIMER_MODE_ABS,	/* Time value is absolute */
+	HRTIMER_MODE_REL,	/* Time value is relative to now */
 };
 
+/*
+ * Return values for the callback function
+ */
 enum hrtimer_restart {
-	HRTIMER_NORESTART,
-	HRTIMER_RESTART,
+	HRTIMER_NORESTART,	/* Timer is not restarted */
+	HRTIMER_RESTART,	/* Timer must be restarted */
 };
 
-#define HRTIMER_INACTIVE	((void *)1UL)
-
 struct hrtimer_base;
 
 /**
@@ -52,7 +53,7 @@ struct hrtimer_base;
 struct hrtimer {
 	struct rb_node		node;
 	ktime_t			expires;
-	int			(*function)(struct hrtimer *);
+	enum hrtimer_restart	(*function)(struct hrtimer *);
 	struct hrtimer_base	*base;
 };
 
@@ -114,7 +115,10 @@ extern int hrtimer_start(struct hrtimer 
 extern int hrtimer_cancel(struct hrtimer *timer);
 extern int hrtimer_try_to_cancel(struct hrtimer *timer);
 
-#define hrtimer_restart(timer) hrtimer_start((timer), (timer)->expires, HRTIMER_ABS)
+static inline int hrtimer_restart(struct hrtimer *timer)
+{
+	return hrtimer_start(timer, timer->expires, HRTIMER_MODE_ABS);
+}
 
 /* Query timers: */
 extern ktime_t hrtimer_get_remaining(const struct hrtimer *timer);
Index: linux-2.6.18-mm3/include/linux/timer.h
===================================================================
--- linux-2.6.18-mm3.orig/include/linux/timer.h	2006-10-04 18:13:55.000000000 +0200
+++ linux-2.6.18-mm3/include/linux/timer.h	2006-10-04 18:13:55.000000000 +0200
@@ -106,6 +106,6 @@ static inline void add_timer(struct time
 extern void init_timers(void);
 extern void run_local_timers(void);
 struct hrtimer;
-extern int it_real_fn(struct hrtimer *);
+extern enum hrtimer_restart it_real_fn(struct hrtimer *);
 
 #endif
Index: linux-2.6.18-mm3/kernel/fork.c
===================================================================
--- linux-2.6.18-mm3.orig/kernel/fork.c	2006-10-04 18:13:51.000000000 +0200
+++ linux-2.6.18-mm3/kernel/fork.c	2006-10-04 18:13:55.000000000 +0200
@@ -855,7 +855,7 @@ static inline int copy_signal(unsigned l
 	init_sigpending(&sig->shared_pending);
 	INIT_LIST_HEAD(&sig->posix_timers);
 
-	hrtimer_init(&sig->real_timer, CLOCK_MONOTONIC, HRTIMER_REL);
+	hrtimer_init(&sig->real_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	sig->it_real_incr.tv64 = 0;
 	sig->real_timer.function = it_real_fn;
 	sig->tsk = tsk;
Index: linux-2.6.18-mm3/kernel/futex.c
===================================================================
--- linux-2.6.18-mm3.orig/kernel/futex.c	2006-10-04 18:13:51.000000000 +0200
+++ linux-2.6.18-mm3/kernel/futex.c	2006-10-04 18:13:55.000000000 +0200
@@ -1135,7 +1135,7 @@ static int futex_lock_pi(u32 __user *uad
 
 	if (sec != MAX_SCHEDULE_TIMEOUT) {
 		to = &timeout;
-		hrtimer_init(&to->timer, CLOCK_REALTIME, HRTIMER_ABS);
+		hrtimer_init(&to->timer, CLOCK_REALTIME, HRTIMER_MODE_ABS);
 		hrtimer_init_sleeper(to, current);
 		to->timer.expires = ktime_set(sec, nsec);
 	}
Index: linux-2.6.18-mm3/kernel/hrtimer.c
===================================================================
--- linux-2.6.18-mm3.orig/kernel/hrtimer.c	2006-10-04 18:13:54.000000000 +0200
+++ linux-2.6.18-mm3/kernel/hrtimer.c	2006-10-04 18:13:55.000000000 +0200
@@ -439,7 +439,7 @@ hrtimer_start(struct hrtimer *timer, kti
 	/* Switch the timer base, if necessary: */
 	new_base = switch_hrtimer_base(timer, base);
 
-	if (mode == HRTIMER_REL) {
+	if (mode == HRTIMER_MODE_REL) {
 		tim = ktime_add(tim, new_base->get_time());
 		/*
 		 * CONFIG_TIME_LOW_RES is a temporary way for architectures
@@ -578,7 +578,7 @@ void hrtimer_init(struct hrtimer *timer,
 
 	bases = __raw_get_cpu_var(hrtimer_bases);
 
-	if (clock_id == CLOCK_REALTIME && mode != HRTIMER_ABS)
+	if (clock_id == CLOCK_REALTIME && mode != HRTIMER_MODE_ABS)
 		clock_id = CLOCK_MONOTONIC;
 
 	timer->base = &bases[clock_id];
@@ -622,7 +622,7 @@ static inline void run_hrtimer_queue(str
 
 	while ((node = base->first)) {
 		struct hrtimer *timer;
-		int (*fn)(struct hrtimer *);
+		enum hrtimer_restart (*fn)(struct hrtimer *);
 		int restart;
 
 		timer = rb_entry(node, struct hrtimer, node);
@@ -664,7 +664,7 @@ void hrtimer_run_queues(void)
 /*
  * Sleep related functions:
  */
-static int hrtimer_wakeup(struct hrtimer *timer)
+static enum hrtimer_restart hrtimer_wakeup(struct hrtimer *timer)
 {
 	struct hrtimer_sleeper *t =
 		container_of(timer, struct hrtimer_sleeper, timer);
@@ -694,7 +694,7 @@ static int __sched do_nanosleep(struct h
 		schedule();
 
 		hrtimer_cancel(&t->timer);
-		mode = HRTIMER_ABS;
+		mode = HRTIMER_MODE_ABS;
 
 	} while (t->task && !signal_pending(current));
 
@@ -710,10 +710,10 @@ long __sched hrtimer_nanosleep_restart(s
 
 	restart->fn = do_no_restart_syscall;
 
-	hrtimer_init(&t.timer, restart->arg0, HRTIMER_ABS);
+	hrtimer_init(&t.timer, restart->arg0, HRTIMER_MODE_ABS);
 	t.timer.expires.tv64 = ((u64)restart->arg3 << 32) | (u64) restart->arg2;
 
-	if (do_nanosleep(&t, HRTIMER_ABS))
+	if (do_nanosleep(&t, HRTIMER_MODE_ABS))
 		return 0;
 
 	rmtp = (struct timespec __user *) restart->arg1;
@@ -746,7 +746,7 @@ long hrtimer_nanosleep(struct timespec *
 		return 0;
 
 	/* Absolute timers do not update the rmtp value and restart: */
-	if (mode == HRTIMER_ABS)
+	if (mode == HRTIMER_MODE_ABS)
 		return -ERESTARTNOHAND;
 
 	if (rmtp) {
@@ -779,7 +779,7 @@ sys_nanosleep(struct timespec __user *rq
 	if (!timespec_valid(&tu))
 		return -EINVAL;
 
-	return hrtimer_nanosleep(&tu, rmtp, HRTIMER_REL, CLOCK_MONOTONIC);
+	return hrtimer_nanosleep(&tu, rmtp, HRTIMER_MODE_REL, CLOCK_MONOTONIC);
 }
 
 /*
Index: linux-2.6.18-mm3/kernel/itimer.c
===================================================================
--- linux-2.6.18-mm3.orig/kernel/itimer.c	2006-10-04 18:13:51.000000000 +0200
+++ linux-2.6.18-mm3/kernel/itimer.c	2006-10-04 18:13:55.000000000 +0200
@@ -128,7 +128,7 @@ asmlinkage long sys_getitimer(int which,
 /*
  * The timer is automagically restarted, when interval != 0
  */
-int it_real_fn(struct hrtimer *timer)
+enum hrtimer_restart it_real_fn(struct hrtimer *timer)
 {
 	struct signal_struct *sig =
 	    container_of(timer, struct signal_struct, real_timer);
@@ -235,7 +235,7 @@ again:
 			timeval_to_ktime(value->it_interval);
 		expires = timeval_to_ktime(value->it_value);
 		if (expires.tv64 != 0)
-			hrtimer_start(timer, expires, HRTIMER_REL);
+			hrtimer_start(timer, expires, HRTIMER_MODE_REL);
 		spin_unlock_irq(&tsk->sighand->siglock);
 		break;
 	case ITIMER_VIRTUAL:
Index: linux-2.6.18-mm3/kernel/posix-timers.c
===================================================================
--- linux-2.6.18-mm3.orig/kernel/posix-timers.c	2006-10-04 18:13:51.000000000 +0200
+++ linux-2.6.18-mm3/kernel/posix-timers.c	2006-10-04 18:13:55.000000000 +0200
@@ -145,7 +145,7 @@ static int common_timer_set(struct k_iti
 			    struct itimerspec *, struct itimerspec *);
 static int common_timer_del(struct k_itimer *timer);
 
-static int posix_timer_fn(struct hrtimer *data);
+static enum hrtimer_restart posix_timer_fn(struct hrtimer *data);
 
 static struct k_itimer *lock_timer(timer_t timer_id, unsigned long *flags);
 
@@ -334,12 +334,12 @@ EXPORT_SYMBOL_GPL(posix_timer_event);
 
  * This code is for CLOCK_REALTIME* and CLOCK_MONOTONIC* timers.
  */
-static int posix_timer_fn(struct hrtimer *timer)
+static enum hrtimer_restart posix_timer_fn(struct hrtimer *timer)
 {
 	struct k_itimer *timr;
 	unsigned long flags;
 	int si_private = 0;
-	int ret = HRTIMER_NORESTART;
+	enum hrtimer_restart ret = HRTIMER_NORESTART;
 
 	timr = container_of(timer, struct k_itimer, it.real.timer);
 	spin_lock_irqsave(&timr->it_lock, flags);
@@ -723,7 +723,7 @@ common_timer_set(struct k_itimer *timr, 
 	if (!new_setting->it_value.tv_sec && !new_setting->it_value.tv_nsec)
 		return 0;
 
-	mode = flags & TIMER_ABSTIME ? HRTIMER_ABS : HRTIMER_REL;
+	mode = flags & TIMER_ABSTIME ? HRTIMER_MODE_ABS : HRTIMER_MODE_REL;
 	hrtimer_init(&timr->it.real.timer, timr->it_clock, mode);
 	timr->it.real.timer.function = posix_timer_fn;
 
@@ -735,7 +735,7 @@ common_timer_set(struct k_itimer *timr, 
 	/* SIGEV_NONE timers are not queued ! See common_timer_get */
 	if (((timr->it_sigev_notify & ~SIGEV_THREAD_ID) == SIGEV_NONE)) {
 		/* Setup correct expiry time for relative timers */
-		if (mode == HRTIMER_REL)
+		if (mode == HRTIMER_MODE_REL)
 			timer->expires = ktime_add(timer->expires,
 						   timer->base->get_time());
 		return 0;
@@ -951,7 +951,8 @@ static int common_nsleep(const clockid_t
 			 struct timespec *tsave, struct timespec __user *rmtp)
 {
 	return hrtimer_nanosleep(tsave, rmtp, flags & TIMER_ABSTIME ?
-				 HRTIMER_ABS : HRTIMER_REL, which_clock);
+				 HRTIMER_MODE_ABS : HRTIMER_MODE_REL,
+				 which_clock);
 }
 
 asmlinkage long
Index: linux-2.6.18-mm3/kernel/rtmutex.c
===================================================================
--- linux-2.6.18-mm3.orig/kernel/rtmutex.c	2006-10-04 18:13:51.000000000 +0200
+++ linux-2.6.18-mm3/kernel/rtmutex.c	2006-10-04 18:13:55.000000000 +0200
@@ -625,7 +625,7 @@ rt_mutex_slowlock(struct rt_mutex *lock,
 	/* Setup the timer, when timeout != NULL */
 	if (unlikely(timeout))
 		hrtimer_start(&timeout->timer, timeout->timer.expires,
-			      HRTIMER_ABS);
+			      HRTIMER_MODE_ABS);
 
 	for (;;) {
 		/* Try to acquire the lock: */

--

