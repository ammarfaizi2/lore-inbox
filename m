Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751314AbVLAAJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbVLAAJI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 19:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbVLAAIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 19:08:30 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:62370
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751284AbVK3X6L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:58:11 -0500
Subject: [patch 22/43] Convert posix interval timers to use ktimers
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu, zippel@linux-m68k.org, george@mvista.com,
       johnstul@us.ibm.com
References: <20051130231140.164337000@tglx.tec.linutronix.de>
Content-Type: text/plain
Organization: linutronix
Date: Thu, 01 Dec 2005 01:03:40 +0100
Message-Id: <1133395420.32542.465.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment (ktimer-convert-posix-timers.patch)
- convert posix-timers.c to use ktimers

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

 include/linux/ktimer.h       |    7 
 include/linux/posix-timers.h |  121 +++++--
 include/linux/time.h         |    3 
 kernel/posix-timers.c        |  690 +++++++++----------------------------------
 4 files changed, 246 insertions(+), 575 deletions(-)

Index: linux-2.6.15-rc2-rework/include/linux/ktimer.h
===================================================================
--- linux-2.6.15-rc2-rework.orig/include/linux/ktimer.h
+++ linux-2.6.15-rc2-rework/include/linux/ktimer.h
@@ -122,6 +122,13 @@ struct ktimer_base {
 
 #define KTIMER_POISON		((void *) 0x00100101)
 
+/*
+ * clock_was_set() is a NOP for non- high-resolution systems. The
+ * time-sorted order guarantees that a timer does not expire early and
+ * is expired in the next softirq when the clock was advanced.
+ */
+#define clock_was_set()		do { } while (0)
+
 /* Exported timer functions: */
 
 /* Initialize timers: */
Index: linux-2.6.15-rc2-rework/include/linux/posix-timers.h
===================================================================
--- linux-2.6.15-rc2-rework.orig/include/linux/posix-timers.h
+++ linux-2.6.15-rc2-rework/include/linux/posix-timers.h
@@ -51,12 +51,9 @@ struct k_itimer {
 	struct sigqueue *sigq;		/* signal queue entry. */
 	union {
 		struct {
-			struct timer_list timer;
-			/* clock abs_timer_list: */
-			struct list_head abs_timer_entry;
-			/* wall_to_monotonic used when set: */
-			struct timespec wall_to_prev;
-			unsigned long incr; /* interval in jiffies */
+			struct ktimer timer;
+			ktime_t incr;
+			int overrun;
 		} real;
 		struct cpu_timer_list cpu;
 		struct {
@@ -68,11 +65,6 @@ struct k_itimer {
 	} it;
 };
 
-struct k_clock_abs {
-	struct list_head list;
-	spinlock_t lock;
-};
-
 struct k_clock {
 	int res;		/* in nanoseconds */
 	int (*clock_getres) (const clockid_t which_clock, struct timespec *tp);
@@ -102,28 +94,91 @@ int do_posix_clock_nosettime(const clock
 /* function to call to trigger timer event */
 int posix_timer_event(struct k_itimer *timr, int si_private);
 
-struct now_struct {
-	unsigned long jiffies;
-};
-
-#define posix_get_now(now) \
-	do { (now)->jiffies = jiffies; } while (0)
-
-#define posix_time_before(timer, now) \
-                      time_before((timer)->expires, (now)->jiffies)
-
-#define posix_bump_timer(timr, now)					\
-	do {								\
-		long delta, orun;					\
-									\
-		delta = (now).jiffies - (timr)->it.real.timer.expires;	\
-		if (delta >= 0) {					\
-			orun = 1 + (delta / (timr)->it.real.incr);	\
-			(timr)->it.real.timer.expires +=		\
-				orun * (timr)->it.real.incr;		\
-			(timr)->it_overrun += orun;			\
-		}							\
-	} while (0)
+#if BITS_PER_LONG < 64
+static inline ktime_t forward_posix_timer(struct k_itimer *t, const ktime_t now)
+{
+	ktime_t delta = ktime_sub(now, t->it.real.timer.expires);
+	unsigned long orun = 1;
+
+	if (delta.tv64 < 0)
+		goto out;
+
+	if (unlikely(delta.tv64 > t->it.real.incr.tv64)) {
+
+		int sft = 0;
+		u64 div, dclc, inc, dns;
+
+		dclc = dns = ktime_to_ns(delta);
+		div = inc = ktime_to_ns(t->it.real.incr);
+		/* Make sure the divisor is less than 2^32 */
+		while(div >> 32) {
+			sft++;
+			div >>= 1;
+		}
+		dclc >>= sft;
+		do_div(dclc, (unsigned long) div);
+		orun = (unsigned long) dclc;
+		if (likely(!(inc >> 32)))
+			dclc *= (unsigned long) inc;
+		else
+			dclc *= inc;
+		t->it.real.timer.expires = ktime_add_ns(t->it.real.timer.expires,
+							dclc);
+	} else {
+		t->it.real.timer.expires = ktime_add(t->it.real.timer.expires,
+						     t->it.real.incr);
+	}
+	/*
+	 * Here is the correction for exact.  Also covers delta == incr
+	 * which is the else clause above.
+	 */
+	if (t->it.real.timer.expires.tv64 <= now.tv64) {
+		t->it.real.timer.expires = ktime_add(t->it.real.timer.expires,
+						     t->it.real.incr);
+		orun++;
+	}
+	t->it_overrun += orun;
+
+ out:
+	return ktime_sub(t->it.real.timer.expires, now);
+}
+#else
+static inline ktime_t forward_posix_timer(struct k_itimer *t, const ktime_t now)
+{
+	ktime_t delta = ktime_sub(now, t->it.real.timer.expires);
+	unsigned long orun = 1;
+
+	if (delta.tv64 < 0)
+		goto out;
+
+	if (unlikely(delta.tv64 > t->it.real.incr.tv64)) {
+
+		u64 dns, inc;
+
+		dns = ktime_to_ns(delta);
+		inc = ktime_to_ns(t->it.real.incr);
+
+		orun = dns / inc;
+		t->it.real.timer.expires = ktime_add_ns(t->it.real.timer.expires,
+							orun * inc);
+	} else {
+		t->it.real.timer.expires = ktime_add(t->it.real.timer.expires,
+						     t->it.real.incr);
+	}
+	/*
+	 * Here is the correction for exact.  Also covers delta == incr
+	 * which is the else clause above.
+	 */
+	if (t->it.real.timer.expires.tv64 <= now.tv64) {
+		t->it.real.timer.expires = ktime_add(t->it.real.timer.expires,
+						     t->it.real.incr);
+		orun++;
+	}
+	t->it_overrun += orun;
+ out:
+	return ktime_sub(t->it.real.timer.expires, now);
+}
+#endif
 
 int posix_cpu_clock_getres(const clockid_t which_clock, struct timespec *ts);
 int posix_cpu_clock_get(const clockid_t which_clock, struct timespec *ts);
Index: linux-2.6.15-rc2-rework/include/linux/time.h
===================================================================
--- linux-2.6.15-rc2-rework.orig/include/linux/time.h
+++ linux-2.6.15-rc2-rework/include/linux/time.h
@@ -73,8 +73,7 @@ struct timespec current_kernel_time(void
 extern void do_gettimeofday(struct timeval *tv);
 extern int do_settimeofday(struct timespec *tv);
 extern int do_sys_settimeofday(struct timespec *tv, struct timezone *tz);
-extern void clock_was_set(void); // call whenever the clock is set
-extern int do_posix_clock_monotonic_gettime(struct timespec *tp);
+extern void do_posix_clock_monotonic_gettime(struct timespec *ts);
 extern long do_utimes(char __user *filename, struct timeval *times);
 struct itimerval;
 extern int do_setitimer(int which, struct itimerval *value,
Index: linux-2.6.15-rc2-rework/kernel/posix-timers.c
===================================================================
--- linux-2.6.15-rc2-rework.orig/kernel/posix-timers.c
+++ linux-2.6.15-rc2-rework/kernel/posix-timers.c
@@ -35,7 +35,6 @@
 #include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/time.h>
-#include <linux/calc64.h>
 
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
@@ -49,12 +48,6 @@
 #include <linux/workqueue.h>
 #include <linux/module.h>
 
-#define CLOCK_REALTIME_RES TICK_NSEC  /* In nano seconds. */
-
-static inline u64  mpy_l_X_l_ll(unsigned long mpy1,unsigned long mpy2)
-{
-	return (u64)mpy1 * mpy2;
-}
 /*
  * Management arrays for POSIX timers.	 Timers are kept in slab memory
  * Timer ids are allocated by an external routine that keeps track of the
@@ -140,18 +133,18 @@ static DEFINE_SPINLOCK(idr_lock);
  */
 
 static struct k_clock posix_clocks[MAX_CLOCKS];
+
 /*
- * We only have one real clock that can be set so we need only one abs list,
- * even if we should want to have several clocks with differing resolutions.
+ * These ones are defined below.
  */
-static struct k_clock_abs abs_list = {.list = LIST_HEAD_INIT(abs_list.list),
-				      .lock = SPIN_LOCK_UNLOCKED};
+static int common_nsleep(const clockid_t, int flags, struct timespec *t,
+			 struct timespec __user *rmtp);
+static void common_timer_get(struct k_itimer *, struct itimerspec *);
+static int common_timer_set(struct k_itimer *, int,
+			    struct itimerspec *, struct itimerspec *);
+static int common_timer_del(struct k_itimer *timer);
 
-static void posix_timer_fn(unsigned long);
-static u64 do_posix_clock_monotonic_gettime_parts(
-	struct timespec *tp, struct timespec *mo);
-int do_posix_clock_monotonic_gettime(struct timespec *tp);
-static int do_posix_clock_monotonic_get(const clockid_t, struct timespec *tp);
+static void posix_timer_fn(void *data);
 
 static struct k_itimer *lock_timer(timer_t timer_id, unsigned long *flags);
 
@@ -199,22 +192,25 @@ static inline int common_clock_set(const
 
 static inline int common_timer_create(struct k_itimer *new_timer)
 {
-	INIT_LIST_HEAD(&new_timer->it.real.abs_timer_entry);
-	init_timer(&new_timer->it.real.timer);
-	new_timer->it.real.timer.data = (unsigned long) new_timer;
+	return -EINVAL;
+}
+
+static int timer_create_mono(struct k_itimer *new_timer)
+{
+	ktimer_init(&new_timer->it.real.timer);
+	new_timer->it.real.timer.data = new_timer;
+	new_timer->it.real.timer.function = posix_timer_fn;
+	return 0;
+}
+
+static int timer_create_real(struct k_itimer *new_timer)
+{
+	ktimer_init_clock(&new_timer->it.real.timer, CLOCK_REALTIME);
+	new_timer->it.real.timer.data = new_timer;
 	new_timer->it.real.timer.function = posix_timer_fn;
 	return 0;
 }
 
-/*
- * These ones are defined below.
- */
-static int common_nsleep(const clockid_t, int flags, struct timespec *t,
-			 struct timespec __user *rmtp);
-static void common_timer_get(struct k_itimer *, struct itimerspec *);
-static int common_timer_set(struct k_itimer *, int,
-			    struct itimerspec *, struct itimerspec *);
-static int common_timer_del(struct k_itimer *timer);
 
 /*
  * Return nonzero iff we know a priori this clockid_t value is bogus.
@@ -234,19 +230,44 @@ static inline int invalid_clockid(const 
 	return 1;
 }
 
+/*
+ * Get real time for posix timers
+ */
+static int posix_ktime_get_real_ts(clockid_t which_clock, struct timespec *tp)
+{
+	ktime_get_real_ts(tp);
+	return 0;
+}
+
+/*
+ * Get monotonic time for posix timers
+ */
+static int posix_ktime_get_ts(clockid_t which_clock, struct timespec *tp)
+{
+	ktime_get_ts(tp);
+	return 0;
+}
+
+void do_posix_clock_monotonic_gettime(struct timespec *ts)
+{
+	ktime_get_ts(ts);
+}
 
 /*
  * Initialize everything, well, just everything in Posix clocks/timers ;)
  */
 static __init int init_posix_timers(void)
 {
-	struct k_clock clock_realtime = {.res = CLOCK_REALTIME_RES,
-					 .abs_struct = &abs_list
+	struct k_clock clock_realtime = {
+		.clock_getres = ktimer_get_res_clock,
+		.clock_get = posix_ktime_get_real_ts,
+		.timer_create = timer_create_real,
 	};
-	struct k_clock clock_monotonic = {.res = CLOCK_REALTIME_RES,
-		.abs_struct = NULL,
-		.clock_get = do_posix_clock_monotonic_get,
-		.clock_set = do_posix_clock_nosettime
+	struct k_clock clock_monotonic = {
+		.clock_getres = ktimer_get_res,
+		.clock_get = posix_ktime_get_ts,
+		.clock_set = do_posix_clock_nosettime,
+		.timer_create = timer_create_mono,
 	};
 
 	register_posix_clock(CLOCK_REALTIME, &clock_realtime);
@@ -260,117 +281,15 @@ static __init int init_posix_timers(void
 
 __initcall(init_posix_timers);
 
-static void tstojiffie(struct timespec *tp, int res, u64 *jiff)
-{
-	long sec = tp->tv_sec;
-	long nsec = tp->tv_nsec + res - 1;
-
-	if (nsec >= NSEC_PER_SEC) {
-		sec++;
-		nsec -= NSEC_PER_SEC;
-	}
-
-	/*
-	 * The scaling constants are defined in <linux/time.h>
-	 * The difference between there and here is that we do the
-	 * res rounding and compute a 64-bit result (well so does that
-	 * but it then throws away the high bits).
-  	 */
-	*jiff =  (mpy_l_X_l_ll(sec, SEC_CONVERSION) +
-		  (mpy_l_X_l_ll(nsec, NSEC_CONVERSION) >> 
-		   (NSEC_JIFFIE_SC - SEC_JIFFIE_SC))) >> SEC_JIFFIE_SC;
-}
-
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
-			       struct timespec *new_wall_to)
-{
-	struct timespec delta;
-	int sign = 0;
-	u64 exp;
-
-	set_normalized_timespec(&delta,
-				new_wall_to->tv_sec -
-				timr->it.real.wall_to_prev.tv_sec,
-				new_wall_to->tv_nsec -
-				timr->it.real.wall_to_prev.tv_nsec);
-	if (likely(!(delta.tv_sec | delta.tv_nsec)))
-		return 0;
-	if (delta.tv_sec < 0) {
-		set_normalized_timespec(&delta,
-					-delta.tv_sec,
-					1 - delta.tv_nsec -
-					posix_clocks[timr->it_clock].res);
-		sign++;
-	}
-	tstojiffie(&delta, posix_clocks[timr->it_clock].res, &exp);
-	timr->it.real.wall_to_prev = *new_wall_to;
-	timr->it.real.timer.expires += (sign ? -exp : exp);
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
 static void schedule_next_timer(struct k_itimer *timr)
 {
-	struct timespec new_wall_to;
-	struct now_struct now;
-	unsigned long seq;
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
-	if (!timr->it.real.incr)
+	if (timr->it.real.incr.tv64 == 0)
 		return;
 
-	do {
-		seq = read_seqbegin(&xtime_lock);
-		new_wall_to =	wall_to_monotonic;
-		posix_get_now(&now);
-	} while (read_seqretry(&xtime_lock, seq));
-
-	if (!list_empty(&timr->it.real.abs_timer_entry)) {
-		spin_lock(&abs_list.lock);
-		add_clockset_delta(timr, &new_wall_to);
-
-		posix_bump_timer(timr, now);
-
-		spin_unlock(&abs_list.lock);
-	} else {
-		posix_bump_timer(timr, now);
-	}
-	timr->it_overrun_last = timr->it_overrun;
-	timr->it_overrun = -1;
+	timr->it.real.timer.overrun = -1;
 	++timr->it_requeue_pending;
-	add_timer(&timr->it.real.timer);
+	ktimer_start(&timr->it.real.timer, &timr->it.real.incr, KTIMER_FORWARD);
+	timr->it_overrun_last += timr->it.real.timer.overrun;
 }
 
 /*
@@ -394,11 +313,15 @@ void do_schedule_next_timer(struct sigin
 	if (!timr || timr->it_requeue_pending != info->si_sys_private)
 		goto exit;
 
-	if (timr->it_clock < 0)	/* CPU clock */
+	if (timr->it_clock < 0) {
+		/* CPU clock */
 		posix_cpu_timer_schedule(timr);
-	else
+		info->si_overrun = timr->it_overrun_last;
+	} else {
 		schedule_next_timer(timr);
-	info->si_overrun = timr->it_overrun_last;
+		info->si_overrun = timr->it_overrun_last;
+		timr->it_overrun_last = 0;
+	}
 exit:
 	if (timr)
 		unlock_timer(timr, flags);
@@ -408,14 +331,7 @@ int posix_timer_event(struct k_itimer *t
 {
 	memset(&timr->sigq->info, 0, sizeof(siginfo_t));
 	timr->sigq->info.si_sys_private = si_private;
-	/*
-	 * Send signal to the process that owns this timer.
-
-	 * This code assumes that all the possible abs_lists share the
-	 * same lock (there is only one list at this time). If this is
-	 * not the case, the CLOCK info would need to be used to find
-	 * the proper abs list lock.
-	 */
+	/* Send signal to the process that owns this timer.*/
 
 	timr->sigq->info.si_signo = timr->it_sigev_signo;
 	timr->sigq->info.si_errno = 0;
@@ -449,65 +365,28 @@ EXPORT_SYMBOL_GPL(posix_timer_event);
 
  * This code is for CLOCK_REALTIME* and CLOCK_MONOTONIC* timers.
  */
-static void posix_timer_fn(unsigned long __data)
+static void posix_timer_fn(void *data)
 {
-	struct k_itimer *timr = (struct k_itimer *) __data;
+	struct k_itimer *timr = data;
 	unsigned long flags;
-	unsigned long seq;
-	struct timespec delta, new_wall_to;
-	u64 exp = 0;
-	int do_notify = 1;
+	int si_private = 0;
 
 	spin_lock_irqsave(&timr->it_lock, flags);
-	if (!list_empty(&timr->it.real.abs_timer_entry)) {
-		spin_lock(&abs_list.lock);
-		do {
-			seq = read_seqbegin(&xtime_lock);
-			new_wall_to =	wall_to_monotonic;
-		} while (read_seqretry(&xtime_lock, seq));
-		set_normalized_timespec(&delta,
-					new_wall_to.tv_sec -
-					timr->it.real.wall_to_prev.tv_sec,
-					new_wall_to.tv_nsec -
-					timr->it.real.wall_to_prev.tv_nsec);
-		if (likely((delta.tv_sec | delta.tv_nsec ) == 0)) {
-			/* do nothing, timer is on time */
-		} else if (delta.tv_sec < 0) {
-			/* do nothing, timer is already late */
-		} else {
-			/* timer is early due to a clock set */
-			tstojiffie(&delta,
-				   posix_clocks[timr->it_clock].res,
-				   &exp);
-			timr->it.real.wall_to_prev = new_wall_to;
-			timr->it.real.timer.expires += exp;
-			add_timer(&timr->it.real.timer);
-			do_notify = 0;
-		}
-		spin_unlock(&abs_list.lock);
 
-	}
-	if (do_notify)  {
-		int si_private=0;
+	if (timr->it.real.incr.tv64 != 0)
+		si_private = ++timr->it_requeue_pending;
 
-		if (timr->it.real.incr)
-			si_private = ++timr->it_requeue_pending;
-		else {
-			remove_from_abslist(timr);
-		}
+	if (posix_timer_event(timr, si_private))
+		/*
+		 * signal was not sent because of sig_ignor
+		 * we will not get a call back to restart it AND
+		 * it should be restarted.
+		 */
+		schedule_next_timer(timr);
 
-		if (posix_timer_event(timr, si_private))
-			/*
-			 * signal was not sent because of sig_ignor
-			 * we will not get a call back to restart it AND
-			 * it should be restarted.
-			 */
-			schedule_next_timer(timr);
-	}
 	unlock_timer(timr, flags); /* hold thru abs lock to keep irq off */
 }
 
-
 static inline struct task_struct * good_sigevent(sigevent_t * event)
 {
 	struct task_struct *rtn = current->group_leader;
@@ -713,7 +592,8 @@ out:
  */
 static int good_timespec(const struct timespec *ts)
 {
-	if ((!ts) || !timespec_valid(ts))
+	if ((!ts) || (ts->tv_sec < 0) ||
+			((unsigned) ts->tv_nsec >= NSEC_PER_SEC))
 		return 0;
 	return 1;
 }
@@ -770,39 +650,41 @@ static struct k_itimer * lock_timer(time
 static void
 common_timer_get(struct k_itimer *timr, struct itimerspec *cur_setting)
 {
-	unsigned long expires;
-	struct now_struct now;
-
-	do
-		expires = timr->it.real.timer.expires;
-	while ((volatile long) (timr->it.real.timer.expires) != expires);
-
-	posix_get_now(&now);
-
-	if (expires &&
-	    ((timr->it_sigev_notify & ~SIGEV_THREAD_ID) == SIGEV_NONE) &&
-	    !timr->it.real.incr &&
-	    posix_time_before(&timr->it.real.timer, &now))
-		timr->it.real.timer.expires = expires = 0;
-	if (expires) {
-		if (timr->it_requeue_pending & REQUEUE_PENDING ||
-		    (timr->it_sigev_notify & ~SIGEV_THREAD_ID) == SIGEV_NONE) {
-			posix_bump_timer(timr, now);
-			expires = timr->it.real.timer.expires;
-		}
-		else
-			if (!timer_pending(&timr->it.real.timer))
-				expires = 0;
-		if (expires)
-			expires -= now.jiffies;
-	}
-	jiffies_to_timespec(expires, &cur_setting->it_value);
-	jiffies_to_timespec(timr->it.real.incr, &cur_setting->it_interval);
+	ktime_t expires, now, remaining;
+	struct ktimer *timer = &timr->it.real.timer;
 
-	if (cur_setting->it_value.tv_sec < 0) {
+	memset(cur_setting, 0, sizeof(struct itimerspec));
+	expires = ktimer_get_expiry(timer, &now);
+	remaining = ktime_sub(expires, now);
+
+	/* Time left ? or timer pending */
+	if (remaining.tv64 > 0 || ktimer_active(timer))
+		goto calci;
+	/* interval timer ? */
+	if (timr->it.real.incr.tv64 == 0)
+		return;
+	/*
+	 * When a requeue is pending or this is a SIGEV_NONE timer
+	 * move the expiry time forward by intervals, so expiry is >
+	 * now.
+	 * The active (non SIGEV_NONE) rearm should be done
+	 * automatically by the ktimer REARM mode. Thats the next
+	 * iteration.  The REQUEUE_PENDING part will go away !
+	 */
+	if (timr->it_requeue_pending & REQUEUE_PENDING ||
+	    (timr->it_sigev_notify & ~SIGEV_THREAD_ID) == SIGEV_NONE) {
+		remaining = forward_posix_timer(timr, now);
+	}
+ calci:
+	/* interval timer ? */
+	if (timr->it.real.incr.tv64 != 0)
+		cur_setting->it_interval =
+			ktime_to_timespec(timr->it.real.incr);
+	/* Return 0 only, when the timer is expired and not pending */
+	if (remaining.tv64 <= 0)
 		cur_setting->it_value.tv_nsec = 1;
-		cur_setting->it_value.tv_sec = 0;
-	}
+	else
+		cur_setting->it_value = ktime_to_timespec(remaining);
 }
 
 /* Get the time remaining on a POSIX.1b interval timer. */
@@ -826,6 +708,7 @@ sys_timer_gettime(timer_t timer_id, stru
 
 	return 0;
 }
+
 /*
  * Get the number of overruns of a POSIX.1b interval timer.  This is to
  * be the overrun of the timer last delivered.  At the same time we are
@@ -852,84 +735,6 @@ sys_timer_getoverrun(timer_t timer_id)
 
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
-			   int abs, u64 *exp, struct timespec *wall_to)
-{
-	struct timespec now;
-	struct timespec oc = *tp;
-	u64 jiffies_64_f;
-	int rtn =0;
-
-	if (abs) {
-		/*
-		 * The mask pick up the 4 basic clocks 
-		 */
-		if (!((clock - &posix_clocks[0]) & ~CLOCKS_MASK)) {
-			jiffies_64_f = do_posix_clock_monotonic_gettime_parts(
-				&now,  wall_to);
-			/*
-			 * If we are doing a MONOTONIC clock
-			 */
-			if((clock - &posix_clocks[0]) & CLOCKS_MONO){
-				now.tv_sec += wall_to->tv_sec;
-				now.tv_nsec += wall_to->tv_nsec;
-			}
-		} else {
-			/*
-			 * Not one of the basic clocks
-			 */
-			clock->clock_get(clock - posix_clocks, &now);
-			jiffies_64_f = get_jiffies_64();
-		}
-		/*
-		 * Take away now to get delta and normalize
-		 */
-		set_normalized_timespec(&oc, oc.tv_sec - now.tv_sec,
-					oc.tv_nsec - now.tv_nsec);
-	}else{
-		jiffies_64_f = get_jiffies_64();
-	}
-	/*
-	 * Check if the requested time is prior to now (if so set now)
-	 */
-	if (oc.tv_sec < 0)
-		oc.tv_sec = oc.tv_nsec = 0;
-
-	if (oc.tv_sec | oc.tv_nsec)
-		set_normalized_timespec(&oc, oc.tv_sec,
-					oc.tv_nsec + clock->res);
-	tstojiffie(&oc, clock->res, exp);
-
-	/*
-	 * Check if the requested time is more than the timer code
-	 * can handle (if so we error out but return the value too).
-	 */
-	if (*exp > ((u64)MAX_JIFFY_OFFSET))
-			/*
-			 * This is a considered response, not exactly in
-			 * line with the standard (in fact it is silent on
-			 * possible overflows).  We assume such a large 
-			 * value is ALMOST always a programming error and
-			 * try not to compound it by setting a really dumb
-			 * value.
-			 */
-			rtn = -EINVAL;
-	/*
-	 * return the actual jiffies expire time, full 64 bits
-	 */
-	*exp += jiffies_64_f;
-	return rtn;
-}
 
 /* Set a POSIX.1b interval timer. */
 /* timr->it_lock is taken. */
@@ -937,68 +742,51 @@ static inline int
 common_timer_set(struct k_itimer *timr, int flags,
 		 struct itimerspec *new_setting, struct itimerspec *old_setting)
 {
-	struct k_clock *clock = &posix_clocks[timr->it_clock];
-	u64 expire_64;
+	ktime_t expires;
+	int mode;
 
 	if (old_setting)
 		common_timer_get(timr, old_setting);
 
 	/* disable the timer */
-	timr->it.real.incr = 0;
+	timr->it.real.incr.tv64 = 0;
 	/*
 	 * careful here.  If smp we could be in the "fire" routine which will
 	 * be spinning as we hold the lock.  But this is ONLY an SMP issue.
 	 */
-	if (try_to_del_timer_sync(&timr->it.real.timer) < 0) {
-#ifdef CONFIG_SMP
-		/*
-		 * It can only be active if on an other cpu.  Since
-		 * we have cleared the interval stuff above, it should
-		 * clear once we release the spin lock.  Of course once
-		 * we do that anything could happen, including the
-		 * complete melt down of the timer.  So return with
-		 * a "retry" exit status.
-		 */
+	if (ktimer_try_to_cancel(&timr->it.real.timer) < 0)
 		return TIMER_RETRY;
-#endif
-	}
-
-	remove_from_abslist(timr);
 
 	timr->it_requeue_pending = (timr->it_requeue_pending + 2) & 
 		~REQUEUE_PENDING;
 	timr->it_overrun_last = 0;
-	timr->it_overrun = -1;
-	/*
-	 *switch off the timer when it_value is zero
-	 */
-	if (!new_setting->it_value.tv_sec && !new_setting->it_value.tv_nsec) {
-		timr->it.real.timer.expires = 0;
+
+	/* switch off the timer when it_value is zero */
+	if (!new_setting->it_value.tv_sec && !new_setting->it_value.tv_nsec)
 		return 0;
-	}
 
-	if (adjust_abs_time(clock,
-			    &new_setting->it_value, flags & TIMER_ABSTIME, 
-			    &expire_64, &(timr->it.real.wall_to_prev))) {
-		return -EINVAL;
-	}
-	timr->it.real.timer.expires = (unsigned long)expire_64;
-	tstojiffie(&new_setting->it_interval, clock->res, &expire_64);
-	timr->it.real.incr = (unsigned long)expire_64;
+	mode = flags & TIMER_ABSTIME ? KTIMER_ABS : KTIMER_REL;
 
-	/*
-	 * We do not even queue SIGEV_NONE timers!  But we do put them
-	 * in the abs list so we can do that right.
+	/* Posix madness. Only absolute CLOCK_REALTIME timers
+	 * are affected by clock sets. So we must reiniatilize
+	 * the timer.
 	 */
+	if (timr->it_clock == CLOCK_REALTIME && mode == KTIMER_ABS)
+		timer_create_real(timr);
+	else
+		timer_create_mono(timr);
+
+	expires = timespec_to_ktime(new_setting->it_value);
+
+	/* Convert and round the interval */
+	timr->it.real.incr = ktimer_round_timespec(&timr->it.real.timer,
+						     &new_setting->it_interval);
+
+	/* SIGEV_NONE timers are not queued ! See common_timer_get */
 	if (((timr->it_sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_NONE))
-		add_timer(&timr->it.real.timer);
+		ktimer_start(&timr->it.real.timer, &expires,
+			     mode | KTIMER_NOCHECK | KTIMER_ROUND);
 
-	if (flags & TIMER_ABSTIME && clock->abs_struct) {
-		spin_lock(&clock->abs_struct->lock);
-		list_add_tail(&(timr->it.real.abs_timer_entry),
-			      &(clock->abs_struct->list));
-		spin_unlock(&clock->abs_struct->lock);
-	}
 	return 0;
 }
 
@@ -1033,6 +821,7 @@ retry:
 
 	unlock_timer(timr, flag);
 	if (error == TIMER_RETRY) {
+		wait_for_ktimer(&timr->it.real.timer);
 		rtn = NULL;	// We already got the old time...
 		goto retry;
 	}
@@ -1046,24 +835,10 @@ retry:
 
 static inline int common_timer_del(struct k_itimer *timer)
 {
-	timer->it.real.incr = 0;
+	timer->it.real.incr.tv64 = 0;
 
-	if (try_to_del_timer_sync(&timer->it.real.timer) < 0) {
-#ifdef CONFIG_SMP
-		/*
-		 * It can only be active if on an other cpu.  Since
-		 * we have cleared the interval stuff above, it should
-		 * clear once we release the spin lock.  Of course once
-		 * we do that anything could happen, including the
-		 * complete melt down of the timer.  So return with
-		 * a "retry" exit status.
-		 */
+	if (ktimer_try_to_cancel(&timer->it.real.timer) < 0)
 		return TIMER_RETRY;
-#endif
-	}
-
-	remove_from_abslist(timer);
-
 	return 0;
 }
 
@@ -1079,24 +854,17 @@ sys_timer_delete(timer_t timer_id)
 	struct k_itimer *timer;
 	long flags;
 
-#ifdef CONFIG_SMP
-	int error;
 retry_delete:
-#endif
 	timer = lock_timer(timer_id, &flags);
 	if (!timer)
 		return -EINVAL;
 
-#ifdef CONFIG_SMP
-	error = timer_delete_hook(timer);
-
-	if (error == TIMER_RETRY) {
+	if (timer_delete_hook(timer) == TIMER_RETRY) {
 		unlock_timer(timer, flags);
+		wait_for_ktimer(&timer->it.real.timer);
 		goto retry_delete;
 	}
-#else
-	timer_delete_hook(timer);
-#endif
+
 	spin_lock(&current->sighand->siglock);
 	list_del(&timer->list);
 	spin_unlock(&current->sighand->siglock);
@@ -1113,6 +881,7 @@ retry_delete:
 	release_posix_timer(timer, IT_ID_SET);
 	return 0;
 }
+
 /*
  * return timer owned by the process, used by exit_itimers
  */
@@ -1120,22 +889,14 @@ static inline void itimer_delete(struct 
 {
 	unsigned long flags;
 
-#ifdef CONFIG_SMP
-	int error;
 retry_delete:
-#endif
 	spin_lock_irqsave(&timer->it_lock, flags);
 
-#ifdef CONFIG_SMP
-	error = timer_delete_hook(timer);
-
-	if (error == TIMER_RETRY) {
+	if (timer_delete_hook(timer) == TIMER_RETRY) {
 		unlock_timer(timer, flags);
+		wait_for_ktimer(&timer->it.real.timer);
 		goto retry_delete;
 	}
-#else
-	timer_delete_hook(timer);
-#endif
 	list_del(&timer->list);
 	/*
 	 * This keeps any tasks waiting on the spin lock from thinking
@@ -1164,57 +925,7 @@ void exit_itimers(struct signal_struct *
 	}
 }
 
-/*
- * And now for the "clock" calls
- *
- * These functions are called both from timer functions (with the timer
- * spin_lock_irq() held and from clock calls with no locking.	They must
- * use the save flags versions of locks.
- */
-
-/*
- * We do ticks here to avoid the irq lock ( they take sooo long).
- * The seqlock is great here.  Since we a reader, we don't really care
- * if we are interrupted since we don't take lock that will stall us or
- * any other cpu. Voila, no irq lock is needed.
- *
- */
-
-static u64 do_posix_clock_monotonic_gettime_parts(
-	struct timespec *tp, struct timespec *mo)
-{
-	u64 jiff;
-	unsigned int seq;
-
-	do {
-		seq = read_seqbegin(&xtime_lock);
-		getnstimeofday(tp);
-		*mo = wall_to_monotonic;
-		jiff = jiffies_64;
-
-	} while(read_seqretry(&xtime_lock, seq));
-
-	return jiff;
-}
-
-static int do_posix_clock_monotonic_get(const clockid_t clock,
-					struct timespec *tp)
-{
-	struct timespec wall_to_mono;
-
-	do_posix_clock_monotonic_gettime_parts(tp, &wall_to_mono);
-
-	set_normalized_timespec(tp, tp->tv_sec + wall_to_mono.tv_sec,
-				tp->tv_nsec + wall_to_mono.tv_nsec);
-
-	return 0;
-}
-
-int do_posix_clock_monotonic_gettime(struct timespec *tp)
-{
-	return do_posix_clock_monotonic_get(CLOCK_MONOTONIC, tp);
-}
-
+/* Not available / possible... functions */
 int do_posix_clock_nosettime(const clockid_t clockid, struct timespec *tp)
 {
 	return -EINVAL;
@@ -1288,107 +999,6 @@ sys_clock_getres(const clockid_t which_c
 }
 
 /*
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
-void clock_was_set(void)
-{
-	struct k_itimer *timr;
-	struct timespec new_wall_to;
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
-			new_wall_to =	wall_to_monotonic;
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
-		if (add_clockset_delta(timr, &new_wall_to) &&
-		    del_timer(&timr->it.real.timer))  /* timer run yet? */
-			add_timer(&timr->it.real.timer);
-		list_add(&timr->it.real.abs_timer_entry, &abs_list.list);
-		spin_unlock_irq(&abs_list.lock);
-	} while (1);
-
-	up(&clock_was_set_lock);
-}
-
-/*
  * nanosleep for monotonic and realtime clocks
  */
 static int common_nsleep(const clockid_t which_clock, int flags,

--

