Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161452AbWATC4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161452AbWATC4L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 21:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161438AbWATCzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 21:55:45 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:39661
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1161421AbWATCzO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 21:55:14 -0500
Message-Id: <20060120021342.973972000@tglx.tec.linutronix.de>
References: <20060120021336.134802000@tglx.tec.linutronix.de>
Date: Fri, 20 Jan 2006 02:55:50 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       George Anzinger <george@wildturkeyranch.net>,
       Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 5/7] [hrtimers] Cleanups and simplifications
Content-Disposition: inline;
	filename=0005-hrtimers-Cleanups-and-simplifications.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: George Anzinger <george@wildturkeyranch.net>
Date: 1137711354 +0100

This patch cleans up the interface to hrtimers by changing the init code
to pass the mode as well as the clock.  This allow the init code to
select the correct base and eliminates extra timer re-init code in
posix-timers.  We also simplify the restart interface nanosleep use.

Signed-off-by: George Anzinger <george@mvista.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---

 include/linux/hrtimer.h |    5 ++--
 kernel/fork.c           |    2 +-
 kernel/hrtimer.c        |   59 +++++++++++++++++++----------------------------
 kernel/posix-timers.c   |   37 +++++++----------------------
 4 files changed, 36 insertions(+), 67 deletions(-)

0ea0b28ad86d611745b0a55b472f46d27c38e7a2
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index c657f3d..6361544 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -101,9 +101,8 @@ struct hrtimer_base {
 /* Exported timer functions: */
 
 /* Initialize timers: */
-extern void hrtimer_init(struct hrtimer *timer, const clockid_t which_clock);
-extern void hrtimer_rebase(struct hrtimer *timer, const clockid_t which_clock);
-
+extern void hrtimer_init(struct hrtimer *timer, clockid_t which_clock,
+			 enum hrtimer_mode mode);
 
 /* Basic timer operations: */
 extern int hrtimer_start(struct hrtimer *timer, ktime_t tim,
diff --git a/kernel/fork.c b/kernel/fork.c
index 4ae8cfc..7f0ab5e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -802,7 +802,7 @@ static inline int copy_signal(unsigned l
 	init_sigpending(&sig->shared_pending);
 	INIT_LIST_HEAD(&sig->posix_timers);
 
-	hrtimer_init(&sig->real_timer, CLOCK_MONOTONIC);
+	hrtimer_init(&sig->real_timer, CLOCK_MONOTONIC, HRTIMER_REL);
 	sig->it_real_incr.tv64 = 0;
 	sig->real_timer.function = it_real_fn;
 	sig->real_timer.data = tsk;
diff --git a/kernel/hrtimer.c b/kernel/hrtimer.c
index f580dd9..efff949 100644
--- a/kernel/hrtimer.c
+++ b/kernel/hrtimer.c
@@ -66,6 +66,12 @@ EXPORT_SYMBOL_GPL(ktime_get_real);
 
 /*
  * The timer bases:
+ *
+ * Note: If we want to add new timer bases, we have to skip the two
+ * clock ids captured by the cpu-timers. We do this by holding empty
+ * entries rather than doing math adjustment of the clock ids.
+ * This ensures that we capture erroneous accesses to these clock ids
+ * rather than moving them into the range of valid clock id's.
  */
 
 #define MAX_HRTIMER_BASES 2
@@ -483,29 +489,25 @@ ktime_t hrtimer_get_remaining(const stru
 }
 
 /**
- * hrtimer_rebase - rebase an initialized hrtimer to a different base
+ * hrtimer_init - initialize a timer to the given clock
  *
- * @timer:	the timer to be rebased
+ * @timer:	the timer to be initialized
  * @clock_id:	the clock to be used
+ * @mode:	timer mode abs/rel
  */
-void hrtimer_rebase(struct hrtimer *timer, const clockid_t clock_id)
+void hrtimer_init(struct hrtimer *timer, clockid_t clock_id,
+		  enum hrtimer_mode mode)
 {
 	struct hrtimer_base *bases;
 
+	memset(timer, 0, sizeof(struct hrtimer));
+
 	bases = per_cpu(hrtimer_bases, raw_smp_processor_id());
-	timer->base = &bases[clock_id];
-}
 
-/**
- * hrtimer_init - initialize a timer to the given clock
- *
- * @timer:	the timer to be initialized
- * @clock_id:	the clock to be used
- */
-void hrtimer_init(struct hrtimer *timer, const clockid_t clock_id)
-{
-	memset(timer, 0, sizeof(struct hrtimer));
-	hrtimer_rebase(timer, clock_id);
+	if (clock_id == CLOCK_REALTIME && mode != HRTIMER_ABS)
+		clock_id = CLOCK_MONOTONIC;
+
+	timer->base = &bases[clock_id];
 }
 
 /**
@@ -643,8 +645,7 @@ schedule_hrtimer_interruptible(struct hr
 	return schedule_hrtimer(timer, mode);
 }
 
-static long __sched
-nanosleep_restart(struct restart_block *restart, clockid_t clockid)
+static long __sched nanosleep_restart(struct restart_block *restart)
 {
 	struct timespec __user *rmtp;
 	struct timespec tu;
@@ -654,7 +655,7 @@ nanosleep_restart(struct restart_block *
 
 	restart->fn = do_no_restart_syscall;
 
-	hrtimer_init(&timer, clockid);
+	hrtimer_init(&timer, (clockid_t) restart->arg3, HRTIMER_ABS);
 
 	timer.expires.tv64 = ((u64)restart->arg1 << 32) | (u64) restart->arg0;
 
@@ -674,16 +675,6 @@ nanosleep_restart(struct restart_block *
 	return -ERESTART_RESTARTBLOCK;
 }
 
-static long __sched nanosleep_restart_mono(struct restart_block *restart)
-{
-	return nanosleep_restart(restart, CLOCK_MONOTONIC);
-}
-
-static long __sched nanosleep_restart_real(struct restart_block *restart)
-{
-	return nanosleep_restart(restart, CLOCK_REALTIME);
-}
-
 long hrtimer_nanosleep(struct timespec *rqtp, struct timespec __user *rmtp,
 		       const enum hrtimer_mode mode, const clockid_t clockid)
 {
@@ -692,7 +683,7 @@ long hrtimer_nanosleep(struct timespec *
 	struct timespec tu;
 	ktime_t rem;
 
-	hrtimer_init(&timer, clockid);
+	hrtimer_init(&timer, clockid, mode);
 
 	timer.expires = timespec_to_ktime(*rqtp);
 
@@ -700,7 +691,7 @@ long hrtimer_nanosleep(struct timespec *
 	if (rem.tv64 <= 0)
 		return 0;
 
-	/* Absolute timers do not update the rmtp value: */
+	/* Absolute timers do not update the rmtp value and restart: */
 	if (mode == HRTIMER_ABS)
 		return -ERESTARTNOHAND;
 
@@ -710,11 +701,11 @@ long hrtimer_nanosleep(struct timespec *
 		return -EFAULT;
 
 	restart = &current_thread_info()->restart_block;
-	restart->fn = (clockid == CLOCK_MONOTONIC) ?
-		nanosleep_restart_mono : nanosleep_restart_real;
+	restart->fn = nanosleep_restart;
 	restart->arg0 = timer.expires.tv64 & 0xFFFFFFFF;
 	restart->arg1 = timer.expires.tv64 >> 32;
 	restart->arg2 = (unsigned long) rmtp;
+	restart->arg3 = (unsigned long) timer.base->index;
 
 	return -ERESTART_RESTARTBLOCK;
 }
@@ -741,10 +732,8 @@ static void __devinit init_hrtimers_cpu(
 	struct hrtimer_base *base = per_cpu(hrtimer_bases, cpu);
 	int i;
 
-	for (i = 0; i < MAX_HRTIMER_BASES; i++) {
+	for (i = 0; i < MAX_HRTIMER_BASES; i++, base++)
 		spin_lock_init(&base->lock);
-		base++;
-	}
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
diff --git a/kernel/posix-timers.c b/kernel/posix-timers.c
index 3b606d3..28e72fd 100644
--- a/kernel/posix-timers.c
+++ b/kernel/posix-timers.c
@@ -194,9 +194,7 @@ static inline int common_clock_set(const
 
 static int common_timer_create(struct k_itimer *new_timer)
 {
-	hrtimer_init(&new_timer->it.real.timer, new_timer->it_clock);
-	new_timer->it.real.timer.data = new_timer;
-	new_timer->it.real.timer.function = posix_timer_fn;
+	hrtimer_init(&new_timer->it.real.timer, new_timer->it_clock, 0);
 	return 0;
 }
 
@@ -693,6 +691,7 @@ common_timer_set(struct k_itimer *timr, 
 		 struct itimerspec *new_setting, struct itimerspec *old_setting)
 {
 	struct hrtimer *timer = &timr->it.real.timer;
+	enum hrtimer_mode mode;
 
 	if (old_setting)
 		common_timer_get(timr, old_setting);
@@ -714,14 +713,10 @@ common_timer_set(struct k_itimer *timr, 
 	if (!new_setting->it_value.tv_sec && !new_setting->it_value.tv_nsec)
 		return 0;
 
-	/* Posix madness. Only absolute CLOCK_REALTIME timers
-	 * are affected by clock sets. So we must reiniatilize
-	 * the timer.
-	 */
-	if (timr->it_clock == CLOCK_REALTIME && (flags & TIMER_ABSTIME))
-		hrtimer_rebase(timer, CLOCK_REALTIME);
-	else
-		hrtimer_rebase(timer, CLOCK_MONOTONIC);
+	mode = flags & TIMER_ABSTIME ? HRTIMER_ABS : HRTIMER_REL;
+	hrtimer_init(&timr->it.real.timer, timr->it_clock, mode);
+	timr->it.real.timer.data = timr;
+	timr->it.real.timer.function = posix_timer_fn;
 
 	timer->expires = timespec_to_ktime(new_setting->it_value);
 
@@ -732,8 +727,7 @@ common_timer_set(struct k_itimer *timr, 
 	if (((timr->it_sigev_notify & ~SIGEV_THREAD_ID) == SIGEV_NONE))
 		return 0;
 
-	hrtimer_start(timer, timer->expires, (flags & TIMER_ABSTIME) ?
-		      HRTIMER_ABS : HRTIMER_REL);
+	hrtimer_start(timer, timer->expires, mode);
 	return 0;
 }
 
@@ -948,21 +942,8 @@ sys_clock_getres(const clockid_t which_c
 static int common_nsleep(const clockid_t which_clock, int flags,
 			 struct timespec *tsave, struct timespec __user *rmtp)
 {
-	int mode = flags & TIMER_ABSTIME ? HRTIMER_ABS : HRTIMER_REL;
-	int clockid = which_clock;
-
-	switch (which_clock) {
-	case CLOCK_REALTIME:
-		/* Posix madness. Only absolute timers on clock realtime
-		   are affected by clock set. */
-		if (mode != HRTIMER_ABS)
-			clockid = CLOCK_MONOTONIC;
-	case CLOCK_MONOTONIC:
-		break;
-	default:
-		return -EINVAL;
-	}
-	return hrtimer_nanosleep(tsave, rmtp, mode, clockid);
+	return hrtimer_nanosleep(tsave, rmtp, flags & TIMER_ABSTIME ?
+				 HRTIMER_ABS : HRTIMER_REL, which_clock);
 }
 
 asmlinkage long
-- 
1.0.8

--

