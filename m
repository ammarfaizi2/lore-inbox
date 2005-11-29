Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbVK2Bgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbVK2Bgp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 20:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbVK2BfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 20:35:22 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:20158 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932332AbVK2BfM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 20:35:12 -0500
Date: Tue, 29 Nov 2005 02:35:10 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] CLOCK_REALTIME ptimer
Message-ID: <Pine.LNX.4.61.0511290235060.2829@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This introduce the CLOCK_REALTIME part of ptimer, which allows to remove
all the special handling of absolute timers in posix-timers.c.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 include/linux/posix-timers.h |    7 
 include/linux/ptimer.h       |    1 
 kernel/posix-timers.c        |  372 +++++++++----------------------------------
 kernel/ptimer.c              |   12 +
 4 files changed, 95 insertions(+), 297 deletions(-)

Index: linux-2.6-mm/include/linux/posix-timers.h
===================================================================
--- linux-2.6-mm.orig/include/linux/posix-timers.h	2005-11-28 23:54:07.000000000 +0100
+++ linux-2.6-mm/include/linux/posix-timers.h	2005-11-29 00:41:48.000000000 +0100
@@ -53,8 +53,6 @@ struct k_itimer {
 	union {
 		struct {
 			struct ptimer timer;
-			struct list_head abs_timer_entry; /* clock abs_timer_list */
-			ktime_t wall_to_prev;   /* wall_to_monotonic used when set */
 			ktime_t incr;	/* interval */
 		} real;
 		struct cpu_timer_list cpu;
@@ -67,14 +65,9 @@ struct k_itimer {
 	} it;
 };
 
-struct k_clock_abs {
-	struct list_head list;
-	spinlock_t lock;
-};
 struct k_clock {
 	int res;		/* in nano seconds */
 	int (*clock_getres) (clockid_t which_clock, struct timespec *tp);
-	struct k_clock_abs *abs_struct;
 	int (*clock_set) (clockid_t which_clock, struct timespec * tp);
 	int (*clock_get) (clockid_t which_clock, struct timespec * tp);
 	int (*timer_create) (struct k_itimer *timer);
Index: linux-2.6-mm/include/linux/ptimer.h
===================================================================
--- linux-2.6-mm.orig/include/linux/ptimer.h	2005-11-28 23:54:07.000000000 +0100
+++ linux-2.6-mm/include/linux/ptimer.h	2005-11-29 00:41:48.000000000 +0100
@@ -37,6 +37,7 @@ struct ptimer {
 };
 
 extern void ptimer_init(struct ptimer *timer, int base);
+extern void ptimer_set_base(struct ptimer *timer, int base);
 extern void ptimer_start(struct ptimer *timer);
 extern void ptimer_modify(struct ptimer *timer, ktime_t);
 extern int ptimer_stop(struct ptimer *timer);
Index: linux-2.6-mm/kernel/posix-timers.c
===================================================================
--- linux-2.6-mm.orig/kernel/posix-timers.c	2005-11-28 23:54:07.000000000 +0100
+++ linux-2.6-mm/kernel/posix-timers.c	2005-11-29 00:41:48.000000000 +0100
@@ -138,12 +138,6 @@ static DEFINE_SPINLOCK(idr_lock);
  */
 
 static struct k_clock posix_clocks[MAX_CLOCKS];
-/*
- * We only have one real clock that can be set so we need only one abs list,
- * even if we should want to have several clocks with differing resolutions.
- */
-static struct k_clock_abs abs_list = {.list = LIST_HEAD_INIT(abs_list.list),
-				      .lock = SPIN_LOCK_UNLOCKED};
 
 static int posix_timer_fn(struct ptimer *timer);
 static void do_posix_clock_monotonic_gettime_parts(struct timespec *tp,
@@ -195,9 +189,7 @@ static inline int common_clock_set(clock
 
 static inline int common_timer_create(struct k_itimer *new_timer)
 {
-	INIT_LIST_HEAD(&new_timer->it.real.abs_timer_entry);
 	ptimer_init(&new_timer->it.real.timer, CLOCK_MONOTONIC);
-	new_timer->it.real.timer.function = posix_timer_fn;
 	return 0;
 }
 
@@ -235,10 +227,8 @@ static inline int invalid_clockid(clocki
 static __init int init_posix_timers(void)
 {
 	struct k_clock clock_realtime = {.res = CLOCK_REALTIME_RES,
-					 .abs_struct = &abs_list
 	};
 	struct k_clock clock_monotonic = {.res = CLOCK_REALTIME_RES,
-		.abs_struct = NULL,
 		.clock_get = do_posix_clock_monotonic_get,
 		.clock_set = do_posix_clock_nosettime
 	};
@@ -270,91 +260,23 @@ static u64 ktime_to_jiffie(const ktime_t
 		 (NSEC_JIFFIE_SC - SEC_JIFFIE_SC))) >> SEC_JIFFIE_SC;
 }
 
-/*
- * This function adjusts the timer as needed as a result of the clock
- * being set.  It should only be called for absolute timers, and then
- * under the abs_list lock.  It computes the time difference and sets
- * the new jiffies value in the timer.  It also updates the timers
- * reference wall_to_monotonic value.  It is complicated by the fact
- * that tstojiffies() only handles positive times and it needs to work
- * with both positive and negative times.  Also, for negative offsets,
- * we need to defeat the res round up.
- *
- * Return is true if there is a new time, else false.
- */
-static long add_clockset_delta(struct k_itimer *timr,
-			       ktime_t new_wall_to)
-{
-	ktime_t delta;
-
-	delta = ktime_sub(new_wall_to, timr->it.real.wall_to_prev);
-	if (delta.tv64 == KTIME_ZERO)
-		return 0;
-	timr->it.real.wall_to_prev = new_wall_to;
-	timr->it.real.timer.expires = ktime_add(timr->it.real.timer.expires, delta);
-	return 1;
-}
-
-static void remove_from_abslist(struct k_itimer *timr)
-{
-	if (!list_empty(&timr->it.real.abs_timer_entry)) {
-		spin_lock(&abs_list.lock);
-		list_del_init(&timr->it.real.abs_timer_entry);
-		spin_unlock(&abs_list.lock);
-	}
-}
-
-static void posix_advance_timer(struct k_itimer *timr, ktime_t now)
+static void posix_advance_timer(struct k_itimer *timr)
 {
+	struct now_struct now;
 	ktime_t t;
 	u64 j;
 	unsigned long i, rem;
 
-	if (now.tv64 < timr->it.real.timer.expires.tv64)
+	posix_get_now(timr->it.real.timer.base->index, &now);
+	if (now.now.tv64 < timr->it.real.timer.expires.tv64)
 		return;
-	t = ktime_sub(now, timr->it.real.timer.expires);
+	t = ktime_sub(now.now, timr->it.real.timer.expires);
 	i = ktime_to_jiffie(timr->it.real.incr, TICK_NSEC);
 	j = ktime_to_jiffie(t, 0);
 	rem = do_div(j, i);
 	timr->it_overrun += j + 1;
 	t = nsec_to_ktime((u64)(i - rem) * TICK_NSEC);
-	timr->it.real.timer.expires = ktime_add(now, t);
-}
-
-static int schedule_next_timer(struct k_itimer *timr)
-{
-	struct now_struct now;
-
-	/*
-	 * Set up the timer for the next interval (if there is one).
-	 * Note: this code uses the abs_timer_lock to protect
-	 * it.real.wall_to_prev and must hold it until exp is set, not exactly
-	 * obvious...
-
-	 * This function is used for CLOCK_REALTIME* and
-	 * CLOCK_MONOTONIC* timers.  If we ever want to handle other
-	 * CLOCKs, the calling code (do_schedule_next_timer) would need
-	 * to pull the "clock" info from the timer and dispatch the
-	 * "other" CLOCKs "next timer" code (which, I suppose should
-	 * also be added to the k_clock structure).
-	 */
-	if (timr->it.real.incr.tv64 == KTIME_ZERO)
-		return 0;
-
-	posix_get_now(CLOCK_MONOTONIC, &now);
-
-	if (!list_empty(&timr->it.real.abs_timer_entry)) {
-		spin_lock(&abs_list.lock);
-		add_clockset_delta(timr, now.to_mono);
-
-		posix_advance_timer(timr, now.now);
-
-		spin_unlock(&abs_list.lock);
-	} else {
-		posix_advance_timer(timr, now.now);
-	}
-	timr->it_overrun--;
-	return 1;
+	timr->it.real.timer.expires = ktime_add(now.now, t);
 }
 
 /*
@@ -386,8 +308,14 @@ void do_schedule_next_timer(struct sigin
 	} else {
 		BUG_ON(!timr->it_requeue_pending);
 		if (timr->it_requeue_pending > 1 &&
-		    schedule_next_timer(timr))
+		    timr->it.real.incr.tv64 != KTIME_ZERO) {
+			/*
+			 * Set up the timer for the next interval.
+			 */
+			posix_advance_timer(timr);
+			timr->it_overrun--;
 			ptimer_start(&timr->it.real.timer);
+		}
 		timr->it_requeue_pending = 0;
 		info->si_overrun = timr->it_overrun_last = timr->it_overrun;
 		timr->it_overrun = 0;
@@ -448,21 +376,6 @@ static int posix_timer_fn(struct ptimer 
 	int do_restart = 0;
 
 	spin_lock_irqsave(&timr->it_lock, flags);
-	if (!list_empty(&timr->it.real.abs_timer_entry)) {
-		struct now_struct now;
-
-		spin_lock(&abs_list.lock);
-		posix_get_now(CLOCK_MONOTONIC, &now);
-		add_clockset_delta(timr, now.to_mono);
-		if (now.now.tv64 < timr->it.real.timer.expires.tv64) {
-			/* timer is early due to a clock set */
-			spin_unlock(&abs_list.lock);
-			do_restart = 1;
-			goto exit;
-		}
-		list_del_init(&timr->it.real.abs_timer_entry);
-		spin_unlock(&abs_list.lock);
-	}
 
 	if (!timr->it_requeue_pending) {
 		timr->it_requeue_pending = 1;
@@ -476,15 +389,27 @@ static int posix_timer_fn(struct ptimer 
 			do_restart = 1;
 		}
 	} else {
+		timer->expires = timer->base->last_expired;
 		timr->it_requeue_pending = 2;
 		timr->it_overrun++;
 	}
-exit:
+
 	unlock_timer(timr, flags); /* hold thru abs lock to keep irq off */
 
 	return do_restart;
 }
 
+static int posix_real_timer_fn(struct ptimer *timer)
+{
+	ptimer_set_base(timer, CLOCK_MONOTONIC);
+
+	if (posix_timer_fn(timer)) {
+		timer->function = posix_timer_fn;
+		ptimer_start(timer);
+	}
+
+	return 0;
+}
 
 static inline struct task_struct * good_sigevent(sigevent_t * event)
 {
@@ -748,19 +673,23 @@ static struct k_itimer * lock_timer(time
 static void
 common_timer_get(struct k_itimer *timr, struct itimerspec *cur_setting)
 {
-	ktime_t expires;
-	struct now_struct now;
+	struct timespec ts_now, ts_to_mono;
+	ktime_t expires, now;
 
 	expires = timr->it.real.timer.expires;
 
-	posix_get_now(CLOCK_MONOTONIC, &now);
-
-	if (ptimer_active(&timr->it.real.timer)) {
-		expires = ktime_sub(timr->it.real.timer.expires, now.now);
-	} else if (timr->it_requeue_pending) {
-		posix_advance_timer(timr, now.now);
-		expires = ktime_sub(timr->it.real.timer.expires, now.now);
+	do_posix_clock_monotonic_gettime_parts(&ts_now, &ts_to_mono);
+	now = timespec_to_ktime(ts_now);
+	if (timr->it.real.timer.base->index == CLOCK_MONOTONIC)
+		now = ktime_add(now, timespec_to_ktime(ts_to_mono));
+
+	if (expires.tv64 != KTIME_ZERO) {
+		if (timr->it_requeue_pending > 1 ||
+		    (timr->it_sigev_notify & ~SIGEV_THREAD_ID) == SIGEV_NONE)
+			posix_advance_timer(timr);
+		expires = ktime_sub(timr->it.real.timer.expires, now);
 	}
+
 	cur_setting->it_value = ktime_to_timespec(expires);
 	cur_setting->it_interval = ktime_to_timespec(timr->it.real.incr);
 
@@ -817,35 +746,6 @@ sys_timer_getoverrun(timer_t timer_id)
 
 	return overrun;
 }
-/*
- * Adjust for absolute time
- *
- * If absolute time is given and it is not CLOCK_MONOTONIC, we need to
- * adjust for the offset between the timer clock (CLOCK_MONOTONIC) and
- * what ever clock he is using.
- *
- * If it is relative time, we need to add the current (CLOCK_MONOTONIC)
- * time to it to get the proper time for the timer.
- */
-static int adjust_abs_time(struct k_clock *clock, struct timespec *tp,
-			   int abs, struct ptimer *timer, ktime_t *to_mono)
-{
-	struct now_struct now;
-	int rtn = 0;
-
-	timer->expires = timespec_to_ktime(*tp);
-	if (!abs) {
-		posix_get_now(CLOCK_MONOTONIC, &now);
-		now.now = ktime_add_nsec(now.now, clock->res);
-		timer->expires = ktime_add(now.now, timer->expires);
-	} else if ((clock - posix_clocks) == CLOCK_REALTIME) {
-		posix_get_now(CLOCK_MONOTONIC, &now);
-		if (to_mono)
-			*to_mono = now.to_mono;
-		timer->expires = ktime_add(timer->expires, now.to_mono);
-	}
-	return rtn;
-}
 
 /* Set a POSIX.1b interval timer. */
 /* timr->it_lock is taken. */
@@ -853,7 +753,7 @@ static inline int
 common_timer_set(struct k_itimer *timr, int flags,
 		 struct itimerspec *new_setting, struct itimerspec *old_setting)
 {
-	struct k_clock *clock = &posix_clocks[timr->it_clock];
+	clock_t which_clock = timr->it_clock;
 
 	if (old_setting)
 		common_timer_get(timr, old_setting);
@@ -867,39 +767,40 @@ common_timer_set(struct k_itimer *timr, 
 	if (ptimer_try_to_stop(&timr->it.real.timer) < 0)
 		return TIMER_RETRY;
 
-	remove_from_abslist(timr);
-
 	if (timr->it_requeue_pending)
 		timr->it_requeue_pending = 1;
 	timr->it_overrun = 0;
 	/*
-	 *switch off the timer when it_value is zero
+	 * switch off the timer when it_value is zero
 	 */
 	if (!new_setting->it_value.tv_sec && !new_setting->it_value.tv_nsec) {
 		timr->it.real.timer.expires.tv64 = KTIME_ZERO;
 		return 0;
 	}
 
-	if (adjust_abs_time(clock, &new_setting->it_value,
-			    flags & TIMER_ABSTIME, &timr->it.real.timer,
-			    &timr->it.real.wall_to_prev))
-		return -EINVAL;
-
+	timr->it.real.timer.function = posix_timer_fn;
+	timr->it.real.timer.expires = timespec_to_ktime(new_setting->it_value);
 	timr->it.real.incr = timespec_to_ktime(new_setting->it_interval);
 
+	if (!(flags & TIMER_ABSTIME)) {
+		struct now_struct now;
+
+		posix_get_now(CLOCK_MONOTONIC, &now);
+		timr->it.real.timer.expires = ktime_add(timr->it.real.timer.expires,
+							now.now);
+		timr->it.real.timer.expires = ktime_add_nsec(timr->it.real.timer.expires,
+							     TICK_NSEC);
+		which_clock = CLOCK_MONOTONIC;
+	} else if (which_clock == CLOCK_REALTIME)
+		timr->it.real.timer.function = posix_real_timer_fn;
+	ptimer_set_base(&timr->it.real.timer, which_clock);
+
 	/*
-	 * We do not even queue SIGEV_NONE timers!  But we do put them
-	 * in the abs list so we can do that right.
+	 * We do not even queue SIGEV_NONE timers!
 	 */
-	if (((timr->it_sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_NONE))
+	if ((timr->it_sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_NONE)
 		ptimer_start(&timr->it.real.timer);
 
-	if (flags & TIMER_ABSTIME && clock->abs_struct) {
-		spin_lock(&clock->abs_struct->lock);
-		list_add_tail(&(timr->it.real.abs_timer_entry),
-			      &(clock->abs_struct->list));
-		spin_unlock(&clock->abs_struct->lock);
-	}
 	return 0;
 }
 
@@ -963,8 +864,6 @@ static inline int common_timer_del(struc
 #endif
 	}
 
-	remove_from_abslist(timer);
-
 	return 0;
 }
 
@@ -1196,105 +1095,8 @@ static int nanosleep_wake_up(struct ptim
 	return 0;
 }
 
-/*
- * The standard says that an absolute nanosleep call MUST wake up at
- * the requested time in spite of clock settings.  Here is what we do:
- * For each nanosleep call that needs it (only absolute and not on
- * CLOCK_MONOTONIC* (as it can not be set)) we thread a little structure
- * into the "nanosleep_abs_list".  All we need is the task_struct pointer.
- * When ever the clock is set we just wake up all those tasks.	 The rest
- * is done by the while loop in clock_nanosleep().
- *
- * On locking, clock_was_set() is called from update_wall_clock which
- * holds (or has held for it) a write_lock_irq( xtime_lock) and is
- * called from the timer bh code.  Thus we need the irq save locks.
- *
- * Also, on the call from update_wall_clock, that is done as part of a
- * softirq thing.  We don't want to delay the system that much (possibly
- * long list of timers to fix), so we defer that work to keventd.
- */
-
-static DECLARE_WAIT_QUEUE_HEAD(nanosleep_abs_wqueue);
-static DECLARE_WORK(clock_was_set_work, (void(*)(void*))clock_was_set, NULL);
-
-static DECLARE_MUTEX(clock_was_set_lock);
-
 void clock_was_set(void)
 {
-	struct k_itimer *timr;
-	ktime_t new_wall_to;
-	LIST_HEAD(cws_list);
-	unsigned long seq;
-
-
-	if (unlikely(in_interrupt())) {
-		schedule_work(&clock_was_set_work);
-		return;
-	}
-	wake_up_all(&nanosleep_abs_wqueue);
-
-	/*
-	 * Check if there exist TIMER_ABSTIME timers to correct.
-	 *
-	 * Notes on locking: This code is run in task context with irq
-	 * on.  We CAN be interrupted!  All other usage of the abs list
-	 * lock is under the timer lock which holds the irq lock as
-	 * well.  We REALLY don't want to scan the whole list with the
-	 * interrupt system off, AND we would like a sequence lock on
-	 * this code as well.  Since we assume that the clock will not
-	 * be set often, it seems ok to take and release the irq lock
-	 * for each timer.  In fact add_timer will do this, so this is
-	 * not an issue.  So we know when we are done, we will move the
-	 * whole list to a new location.  Then as we process each entry,
-	 * we will move it to the actual list again.  This way, when our
-	 * copy is empty, we are done.  We are not all that concerned
-	 * about preemption so we will use a semaphore lock to protect
-	 * aginst reentry.  This way we will not stall another
-	 * processor.  It is possible that this may delay some timers
-	 * that should have expired, given the new clock, but even this
-	 * will be minimal as we will always update to the current time,
-	 * even if it was set by a task that is waiting for entry to
-	 * this code.  Timers that expire too early will be caught by
-	 * the expire code and restarted.
-
-	 * Absolute timers that repeat are left in the abs list while
-	 * waiting for the task to pick up the signal.  This means we
-	 * may find timers that are not in the "add_timer" list, but are
-	 * in the abs list.  We do the same thing for these, save
-	 * putting them back in the "add_timer" list.  (Note, these are
-	 * left in the abs list mainly to indicate that they are
-	 * ABSOLUTE timers, a fact that is used by the re-arm code, and
-	 * for which we have no other flag.)
-
-	 */
-
-	down(&clock_was_set_lock);
-	spin_lock_irq(&abs_list.lock);
-	list_splice_init(&abs_list.list, &cws_list);
-	spin_unlock_irq(&abs_list.lock);
-	do {
-		do {
-			seq = read_seqbegin(&xtime_lock);
-			new_wall_to = timespec_to_ktime(wall_to_monotonic);
-		} while (read_seqretry(&xtime_lock, seq));
-
-		spin_lock_irq(&abs_list.lock);
-		if (list_empty(&cws_list)) {
-			spin_unlock_irq(&abs_list.lock);
-			break;
-		}
-		timr = list_entry(cws_list.next, struct k_itimer,
-				  it.real.abs_timer_entry);
-
-		list_del_init(&timr->it.real.abs_timer_entry);
-		if (add_clockset_delta(timr, new_wall_to) &&
-		    ptimer_stop(&timr->it.real.timer))  /* timer run yet? */
-			ptimer_start(&timr->it.real.timer);
-		list_add(&timr->it.real.abs_timer_entry, &abs_list.list);
-		spin_unlock_irq(&abs_list.lock);
-	} while (1);
-
-	up(&clock_was_set_lock);
 }
 
 long clock_nanosleep_restart(struct restart_block *restart_block);
@@ -1335,20 +1137,22 @@ sys_clock_nanosleep(clockid_t which_cloc
 static int common_nsleep(clockid_t which_clock,
 			 int flags, struct timespec *tsave)
 {
-	struct timespec t;
 	struct nsleep_timer timer;
 	struct now_struct now;
-	DECLARE_WAITQUEUE(abs_wqueue, current);
 	int abs;
 	struct restart_block *restart_block =
 	    &current_thread_info()->restart_block;
 
-	abs_wqueue.flags = 0;
-	ptimer_init(&timer.timer, CLOCK_MONOTONIC);
+	abs = flags & TIMER_ABSTIME;
+	if (!abs)
+		which_clock = CLOCK_MONOTONIC;
+
+	posix_get_now(which_clock, &now);
+
+	ptimer_init(&timer.timer, which_clock);
 	timer.timer.function = nanosleep_wake_up;
 	timer.task = current;
 	timer.done = 0;
-	abs = flags & TIMER_ABSTIME;
 
 	if (restart_block->fn == clock_nanosleep_restart) {
 		/*
@@ -1359,47 +1163,35 @@ static int common_nsleep(clockid_t which
 
 		timer.timer.expires.tv64 = (s64)restart_block->arg3 << 32;
 		timer.timer.expires.tv64 += restart_block->arg2;
+	} else {
+		timer.timer.expires = timespec_to_ktime(*tsave);
+		if (!abs) {
+			timer.timer.expires = ktime_add(now.now, timer.timer.expires);
+			timer.timer.expires = ktime_add_nsec(timer.timer.expires,
+							     TICK_NSEC);
+		}
 	}
 
-	if (abs && (posix_clocks[which_clock].clock_get !=
-			    posix_clocks[CLOCK_MONOTONIC].clock_get))
-		add_wait_queue(&nanosleep_abs_wqueue, &abs_wqueue);
+	if (now.now.tv64 > timer.timer.expires.tv64)
+		return 0;
 
-	do {
-		t = *tsave;
-		if (abs || timer.timer.expires.tv64 == KTIME_ZERO) {
-			adjust_abs_time(&posix_clocks[which_clock], &t,
-					abs, &timer.timer, NULL);
-		}
+	ptimer_start(&timer.timer);
 
-		posix_get_now(CLOCK_MONOTONIC, &now);
-		if (now.now.tv64 > timer.timer.expires.tv64) {
-			timer.done = 1;
+	while (1) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		if (timer.done || signal_pending(current))
 			break;
-		}
-
-		ptimer_start(&timer.timer);
-
 		schedule();
+	}
 
-		ptimer_stop(&timer.timer);
-	} while (!signal_pending(current));
-
-	if (abs_wqueue.task_list.next)
-		finish_wait(&nanosleep_abs_wqueue, &abs_wqueue);
-
+	ptimer_stop(&timer.timer);
 	if (timer.done)
 		return 0;
 
-	/*
-	 * Always restart abs calls from scratch to pick up any
-	 * clock shifting that happened while we are away.
-	 */
 	if (abs)
 		return -ERESTARTNOHAND;
-
 	/*
-	 * Restart works by saving the time remaing in
+	 * Restart works by saving the expiry time in
 	 * arg2 & 3 (it is 64-bits of jiffies).  The other
 	 * info we need is the clock_id (saved in arg0).
 	 * The sys_call interface needs the users
@@ -1415,7 +1207,7 @@ static int common_nsleep(clockid_t which
 	restart_block->arg2 = timer.timer.expires.tv64 & 0xffffffffLL;
 	restart_block->arg3 = timer.timer.expires.tv64 >> 32;
 
-	posix_get_now(CLOCK_MONOTONIC, &now);
+	posix_get_now(which_clock, &now);
 	now.now = ktime_sub(timer.timer.expires, now.now);
 	*tsave = ktime_to_timespec(now.now);
 
Index: linux-2.6-mm/kernel/ptimer.c
===================================================================
--- linux-2.6-mm.orig/kernel/ptimer.c	2005-11-29 00:41:44.000000000 +0100
+++ linux-2.6-mm/kernel/ptimer.c	2005-11-29 00:41:48.000000000 +0100
@@ -53,6 +53,12 @@ void ptimer_init(struct ptimer *timer, i
 	timer->node.rb_parent = PTIMER_INACTIVE;
 }
 
+void ptimer_set_base(struct ptimer *timer, int base)
+{
+	BUG_ON(ptimer_active(timer));
+	timer->base = &per_cpu(ptimer_bases[base], raw_smp_processor_id());
+}
+
 int ptimer_active(struct ptimer *timer)
 {
 	return timer->node.rb_parent != PTIMER_INACTIVE;
@@ -273,6 +279,10 @@ void ptimer_run_queues(void)
 			return;
 		do {
 			base[CLOCK_MONOTONIC].last_jiffies = last;
+			base[CLOCK_REALTIME].last_expired =
+				ktime_add_nsec(base[CLOCK_REALTIME].last_expired,
+					       TICK_NSEC);
+			ptimer_run_queue(&base[CLOCK_REALTIME]);
 			base[CLOCK_MONOTONIC].last_expired =
 				ktime_add_nsec(base[CLOCK_MONOTONIC].last_expired,
 					       TICK_NSEC);
@@ -281,6 +291,8 @@ void ptimer_run_queues(void)
 	}
 
 	base[CLOCK_MONOTONIC].last_jiffies = last;
+	base[CLOCK_REALTIME].last_expired = now;
+	ptimer_run_queue(&base[CLOCK_REALTIME]);
 	base[CLOCK_MONOTONIC].last_expired = ktime_add(now, mono);
 	ptimer_run_queue(&base[CLOCK_MONOTONIC]);
 }
