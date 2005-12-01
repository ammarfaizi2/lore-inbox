Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751311AbVLAAG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbVLAAG7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 19:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbVLAAGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 19:06:42 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:63906
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751311AbVK3X6O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:58:14 -0500
Subject: [patch 23/43] Simplify ktimers rearm code
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu, zippel@linux-m68k.org, george@mvista.com,
       johnstul@us.ibm.com
References: <20051130231140.164337000@tglx.tec.linutronix.de>
Content-Type: text/plain
Organization: linutronix
Date: Thu, 01 Dec 2005 01:03:42 +0100
Message-Id: <1133395422.32542.466.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment (ktimer-simplify-rearm.patch)
- Simplify the rearming code and expose the functionality so it
  can be used instead of forward_posix_timer(). This allows
  also to replace the posix-timer struct real by a simple ktimer
  structure.
  The automatic rearming in the expiry code was modified to depend
  on the return value of the callback function. This is based on
  an idea of Roman Zippel.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>


 include/linux/ktimer.h       |    6 ++
 include/linux/posix-timers.h |   92 --------------------------------------
 include/linux/timer.h        |    2 
 kernel/itimer.c              |    5 +-
 kernel/ktimer.c              |  103 ++++++++++++++++++++++++++++++++-----------
 kernel/posix-timers.c        |   66 +++++++++++++++------------
 6 files changed, 123 insertions(+), 151 deletions(-)

Index: linux-2.6.15-rc2-rework/include/linux/ktimer.h
===================================================================
--- linux-2.6.15-rc2-rework.orig/include/linux/ktimer.h
+++ linux-2.6.15-rc2-rework/include/linux/ktimer.h
@@ -87,7 +87,7 @@ struct ktimer {
 	ktime_t			interval;
 	int			overrun;
 	enum ktimer_state	state;
-	void			(*function)(void *);
+	int			(*function)(void *);
 	void			*data;
 	struct ktimer_base	*base;
 };
@@ -156,6 +156,10 @@ static inline int ktimer_active(const st
 	return timer->state != KTIMER_INACTIVE;
 }
 
+/* Forward a ktimer so it expires after now */
+extern void ktimer_forward(struct ktimer *timer,
+		    const ktime_t interval, const ktime_t now);
+
 /* Convert with rounding based on resolution of timer's clock: */
 extern ktime_t ktimer_round_timeval(const struct ktimer *timer,
 				    const struct timeval *tv);
Index: linux-2.6.15-rc2-rework/include/linux/posix-timers.h
===================================================================
--- linux-2.6.15-rc2-rework.orig/include/linux/posix-timers.h
+++ linux-2.6.15-rc2-rework/include/linux/posix-timers.h
@@ -50,11 +50,7 @@ struct k_itimer {
 	struct task_struct *it_process;	/* process to send signal to */
 	struct sigqueue *sigq;		/* signal queue entry. */
 	union {
-		struct {
-			struct ktimer timer;
-			ktime_t incr;
-			int overrun;
-		} real;
+		struct ktimer real;
 		struct cpu_timer_list cpu;
 		struct {
 			unsigned int clock;
@@ -94,92 +90,6 @@ int do_posix_clock_nosettime(const clock
 /* function to call to trigger timer event */
 int posix_timer_event(struct k_itimer *timr, int si_private);
 
-#if BITS_PER_LONG < 64
-static inline ktime_t forward_posix_timer(struct k_itimer *t, const ktime_t now)
-{
-	ktime_t delta = ktime_sub(now, t->it.real.timer.expires);
-	unsigned long orun = 1;
-
-	if (delta.tv64 < 0)
-		goto out;
-
-	if (unlikely(delta.tv64 > t->it.real.incr.tv64)) {
-
-		int sft = 0;
-		u64 div, dclc, inc, dns;
-
-		dclc = dns = ktime_to_ns(delta);
-		div = inc = ktime_to_ns(t->it.real.incr);
-		/* Make sure the divisor is less than 2^32 */
-		while(div >> 32) {
-			sft++;
-			div >>= 1;
-		}
-		dclc >>= sft;
-		do_div(dclc, (unsigned long) div);
-		orun = (unsigned long) dclc;
-		if (likely(!(inc >> 32)))
-			dclc *= (unsigned long) inc;
-		else
-			dclc *= inc;
-		t->it.real.timer.expires = ktime_add_ns(t->it.real.timer.expires,
-							dclc);
-	} else {
-		t->it.real.timer.expires = ktime_add(t->it.real.timer.expires,
-						     t->it.real.incr);
-	}
-	/*
-	 * Here is the correction for exact.  Also covers delta == incr
-	 * which is the else clause above.
-	 */
-	if (t->it.real.timer.expires.tv64 <= now.tv64) {
-		t->it.real.timer.expires = ktime_add(t->it.real.timer.expires,
-						     t->it.real.incr);
-		orun++;
-	}
-	t->it_overrun += orun;
-
- out:
-	return ktime_sub(t->it.real.timer.expires, now);
-}
-#else
-static inline ktime_t forward_posix_timer(struct k_itimer *t, const ktime_t now)
-{
-	ktime_t delta = ktime_sub(now, t->it.real.timer.expires);
-	unsigned long orun = 1;
-
-	if (delta.tv64 < 0)
-		goto out;
-
-	if (unlikely(delta.tv64 > t->it.real.incr.tv64)) {
-
-		u64 dns, inc;
-
-		dns = ktime_to_ns(delta);
-		inc = ktime_to_ns(t->it.real.incr);
-
-		orun = dns / inc;
-		t->it.real.timer.expires = ktime_add_ns(t->it.real.timer.expires,
-							orun * inc);
-	} else {
-		t->it.real.timer.expires = ktime_add(t->it.real.timer.expires,
-						     t->it.real.incr);
-	}
-	/*
-	 * Here is the correction for exact.  Also covers delta == incr
-	 * which is the else clause above.
-	 */
-	if (t->it.real.timer.expires.tv64 <= now.tv64) {
-		t->it.real.timer.expires = ktime_add(t->it.real.timer.expires,
-						     t->it.real.incr);
-		orun++;
-	}
-	t->it_overrun += orun;
- out:
-	return ktime_sub(t->it.real.timer.expires, now);
-}
-#endif
-
 int posix_cpu_clock_getres(const clockid_t which_clock, struct timespec *ts);
 int posix_cpu_clock_get(const clockid_t which_clock, struct timespec *ts);
 int posix_cpu_clock_set(const clockid_t which_clock, const struct timespec *ts);
Index: linux-2.6.15-rc2-rework/include/linux/timer.h
===================================================================
--- linux-2.6.15-rc2-rework.orig/include/linux/timer.h
+++ linux-2.6.15-rc2-rework/include/linux/timer.h
@@ -96,6 +96,6 @@ static inline void add_timer(struct time
 
 extern void init_timers(void);
 extern void run_local_timers(void);
-extern void it_real_fn(void *);
+extern int it_real_fn(void *);
 
 #endif
Index: linux-2.6.15-rc2-rework/kernel/itimer.c
===================================================================
--- linux-2.6.15-rc2-rework.orig/kernel/itimer.c
+++ linux-2.6.15-rc2-rework/kernel/itimer.c
@@ -129,9 +129,10 @@ asmlinkage long sys_getitimer(int which,
 /*
  * The timer is automagically restarted, when interval != 0
  */
-void it_real_fn(void *data)
+int it_real_fn(void *data)
 {
 	send_group_sig_info(SIGALRM, SEND_SIG_PRIV, data);
+	return KTIMER_REARM;
 }
 
 int do_setitimer(int which, struct itimerval *value, struct itimerval *ovalue)
@@ -151,7 +152,7 @@ int do_setitimer(int which, struct itime
 			ovalue->it_interval = ktime_to_timeval(timer->interval);
 		}
 		timer->interval = ktimer_round_timeval(timer,
-							&value->it_interval);
+						       &value->it_interval);
 		expires = timeval_to_ktime(value->it_value);
 		if (expires.tv64 != 0)
 			ktimer_restart(timer, &expires,
Index: linux-2.6.15-rc2-rework/kernel/ktimer.c
===================================================================
--- linux-2.6.15-rc2-rework.orig/kernel/ktimer.c
+++ linux-2.6.15-rc2-rework/kernel/ktimer.c
@@ -290,8 +290,32 @@ static unsigned long ktime_modulo(const 
 }
 
 # endif /* !CONFIG_KTIME_SCALAR */
+
+/*
+ * Divide a ktime value by a nanosecond value
+ */
+static unsigned long ktime_divns(const ktime_t kt, nsec_t div)
+{
+	int sft = 0;
+	u64 dclc, inc, dns;
+
+	dclc = dns = ktime_to_ns(kt);
+	inc = div;
+	/* Make sure the divisor is less than 2^32 */
+	while(div >> 32) {
+		sft++;
+		div >>= 1;
+	}
+	dclc >>= sft;
+	do_div(dclc, (unsigned long) div);
+	return (unsigned long) dclc;
+}
+
 #else /* BITS_PER_LONG < 64 */
+
 # define ktime_modulo(kt, div)		(unsigned long)((kt).tv64 % (div))
+# define ktime_divns(kt, div)		(unsigned long)((kt).tv64 / (div))
+
 #endif /* BITS_PER_LONG >= 64 */
 
 /*
@@ -304,6 +328,45 @@ void unlock_ktimer_base(const struct kti
 }
 
 /**
+ * ktimer_forward - forward the timer expiry
+ *
+ * @timer:	ktimer to forward
+ * @interval:	the interval to forward
+ * @now:	current time
+ *
+ * Forward the timer expiry so it will expire in the future.
+ * The number of overruns is added to the overrun field.
+ */
+void ktimer_forward(struct ktimer *timer,
+			 const ktime_t interval, const ktime_t now)
+{
+	ktime_t delta = ktime_sub(now, timer->expires);
+	unsigned long orun = 1;
+
+	if (delta.tv64 < 0)
+		return;
+
+	if (unlikely(delta.tv64 > interval.tv64)) {
+		nsec_t incr = ktime_to_ns(interval);
+
+		orun = ktime_divns(delta, incr);
+		timer->expires = ktime_add_ns(timer->expires, incr * orun);
+	} else {
+		timer->expires = ktime_add(timer->expires, interval);
+	}
+
+	/*
+	 * Here is the correction for exact. Also covers delta == incr
+	 * which is the else clause above.
+	 */
+	if (timer->expires.tv64 <= now.tv64) {
+		orun++;
+		timer->expires = ktime_add(timer->expires, interval);
+	}
+	timer->overrun += orun;
+}
+
+/**
  * ktimer_round_timespec - convert timespec to ktime_t with resolution
  *			     adjustment
  *
@@ -391,18 +454,7 @@ static int enqueue_ktimer(struct ktimer 
 		break;
 
 	case KTIMER_FORWARD:
-		while (timer->expires.tv64 <= now.tv64) {
-			timer->expires = ktime_add(timer->expires, *tim);
-			timer->overrun++;
-		}
-		goto nocheck;
-
-	case KTIMER_REARM:
-		while (timer->expires.tv64 <= now.tv64) {
-			timer->expires = ktime_add(timer->expires,
-						   timer->interval);
-			timer->overrun++;
-		}
+		ktimer_forward(timer, *tim, now);
 		goto nocheck;
 
 	case KTIMER_RESTART:
@@ -470,12 +522,9 @@ static int enqueue_ktimer(struct ktimer 
 /*
  * __remove_ktimer - internal function to remove a timer
  *
- * The function also allows automatic rearming for interval timers.
- * Must hold the base lock.
+ * Caller must hold the base lock.
  */
-static void
-__remove_ktimer(struct ktimer *timer, struct ktimer_base *base,
-		enum ktimer_rearm rearm)
+static void __remove_ktimer(struct ktimer *timer, struct ktimer_base *base)
 {
 	/*
 	 * Remove the timer from the sorted list and from the rbtree:
@@ -487,10 +536,6 @@ __remove_ktimer(struct ktimer *timer, st
 	timer->state = KTIMER_INACTIVE;
 	base->count--;
 	BUG_ON(base->count < 0);
-
-	/* Auto rearm the timer ? */
-	if (rearm && (timer->interval.tv64 != 0))
-		enqueue_ktimer(timer, base, NULL, KTIMER_REARM);
 }
 
 /*
@@ -499,7 +544,7 @@ __remove_ktimer(struct ktimer *timer, st
 static inline int remove_ktimer(struct ktimer *timer, struct ktimer_base *base)
 {
 	if (ktimer_active(timer)) {
-		__remove_ktimer(timer, base, KTIMER_NOREARM);
+		__remove_ktimer(timer, base);
 		return 1;
 	}
 	return 0;
@@ -769,7 +814,8 @@ static inline void run_ktimer_queue(stru
 
 	while (!list_empty(&base->pending)) {
 		struct ktimer *timer;
-		void (*fn)(void *);
+		int rearm;
+		int (*fn)(void *);
 		void *data;
 
 		timer = list_entry(base->pending.next, struct ktimer, list);
@@ -780,13 +826,17 @@ static inline void run_ktimer_queue(stru
 		fn = timer->function;
 		data = timer->data;
 		set_curr_timer(base, timer);
-		__remove_ktimer(timer, base, KTIMER_REARM);
+		__remove_ktimer(timer, base);
 		spin_unlock_irq(&base->lock);
 
-		fn(data);
+		rearm = fn(data);
 
 		spin_lock_irq(&base->lock);
 		set_curr_timer(base, NULL);
+
+		if (rearm && timer->interval.tv64)
+			enqueue_ktimer(timer, base, &timer->interval,
+				       KTIMER_FORWARD);
 	}
 	spin_unlock_irq(&base->lock);
 
@@ -812,9 +862,10 @@ void ktimer_run_queues(void)
 /*
  * Process-wakeup callback:
  */
-static void ktimer_wake_up(void *data)
+static int ktimer_wake_up(void *data)
 {
 	wake_up_process(data);
+	return 0;
 }
 
 /**
Index: linux-2.6.15-rc2-rework/kernel/posix-timers.c
===================================================================
--- linux-2.6.15-rc2-rework.orig/kernel/posix-timers.c
+++ linux-2.6.15-rc2-rework/kernel/posix-timers.c
@@ -144,7 +144,7 @@ static int common_timer_set(struct k_iti
 			    struct itimerspec *, struct itimerspec *);
 static int common_timer_del(struct k_itimer *timer);
 
-static void posix_timer_fn(void *data);
+static int posix_timer_fn(void *data);
 
 static struct k_itimer *lock_timer(timer_t timer_id, unsigned long *flags);
 
@@ -197,17 +197,17 @@ static inline int common_timer_create(st
 
 static int timer_create_mono(struct k_itimer *new_timer)
 {
-	ktimer_init(&new_timer->it.real.timer);
-	new_timer->it.real.timer.data = new_timer;
-	new_timer->it.real.timer.function = posix_timer_fn;
+	ktimer_init(&new_timer->it.real);
+	new_timer->it.real.data = new_timer;
+	new_timer->it.real.function = posix_timer_fn;
 	return 0;
 }
 
 static int timer_create_real(struct k_itimer *new_timer)
 {
-	ktimer_init_clock(&new_timer->it.real.timer, CLOCK_REALTIME);
-	new_timer->it.real.timer.data = new_timer;
-	new_timer->it.real.timer.function = posix_timer_fn;
+	ktimer_init_clock(&new_timer->it.real, CLOCK_REALTIME);
+	new_timer->it.real.data = new_timer;
+	new_timer->it.real.function = posix_timer_fn;
 	return 0;
 }
 
@@ -283,13 +283,13 @@ __initcall(init_posix_timers);
 
 static void schedule_next_timer(struct k_itimer *timr)
 {
-	if (timr->it.real.incr.tv64 == 0)
+	if (timr->it.real.interval.tv64 == 0)
 		return;
 
-	timr->it.real.timer.overrun = -1;
+	timr->it.real.overrun = -1;
 	++timr->it_requeue_pending;
-	ktimer_start(&timr->it.real.timer, &timr->it.real.incr, KTIMER_FORWARD);
-	timr->it_overrun_last += timr->it.real.timer.overrun;
+	ktimer_start(&timr->it.real, &timr->it.real.interval, KTIMER_FORWARD);
+	timr->it_overrun_last += timr->it.real.overrun;
 }
 
 /*
@@ -365,26 +365,29 @@ EXPORT_SYMBOL_GPL(posix_timer_event);
 
  * This code is for CLOCK_REALTIME* and CLOCK_MONOTONIC* timers.
  */
-static void posix_timer_fn(void *data)
+static int posix_timer_fn(void *data)
 {
 	struct k_itimer *timr = data;
 	unsigned long flags;
 	int si_private = 0;
+	int ret = 0;
 
 	spin_lock_irqsave(&timr->it_lock, flags);
 
-	if (timr->it.real.incr.tv64 != 0)
+	if (timr->it.real.interval.tv64 != 0)
 		si_private = ++timr->it_requeue_pending;
 
-	if (posix_timer_event(timr, si_private))
+	if (posix_timer_event(timr, si_private)) {
 		/*
 		 * signal was not sent because of sig_ignor
 		 * we will not get a call back to restart it AND
 		 * it should be restarted.
 		 */
-		schedule_next_timer(timr);
+		ret = (timr->it.real.interval.tv64 == 0) ? 0 : KTIMER_REARM;
+	}
 
 	unlock_timer(timr, flags); /* hold thru abs lock to keep irq off */
+	return ret;
 }
 
 static inline struct task_struct * good_sigevent(sigevent_t * event)
@@ -651,7 +654,7 @@ static void
 common_timer_get(struct k_itimer *timr, struct itimerspec *cur_setting)
 {
 	ktime_t expires, now, remaining;
-	struct ktimer *timer = &timr->it.real.timer;
+	struct ktimer *timer = &timr->it.real;
 
 	memset(cur_setting, 0, sizeof(struct itimerspec));
 	expires = ktimer_get_expiry(timer, &now);
@@ -661,7 +664,7 @@ common_timer_get(struct k_itimer *timr, 
 	if (remaining.tv64 > 0 || ktimer_active(timer))
 		goto calci;
 	/* interval timer ? */
-	if (timr->it.real.incr.tv64 == 0)
+	if (timer->interval.tv64 == 0)
 		return;
 	/*
 	 * When a requeue is pending or this is a SIGEV_NONE timer
@@ -673,13 +676,16 @@ common_timer_get(struct k_itimer *timr, 
 	 */
 	if (timr->it_requeue_pending & REQUEUE_PENDING ||
 	    (timr->it_sigev_notify & ~SIGEV_THREAD_ID) == SIGEV_NONE) {
-		remaining = forward_posix_timer(timr, now);
+		timer->overrun = 0;
+		ktimer_forward(timer, timer->interval, now);
+		remaining = ktime_sub(now, timer->expires);
+		timr->it_overrun += timer->overrun;
 	}
  calci:
 	/* interval timer ? */
-	if (timr->it.real.incr.tv64 != 0)
+	if (timr->it.real.interval.tv64 != 0)
 		cur_setting->it_interval =
-			ktime_to_timespec(timr->it.real.incr);
+			ktime_to_timespec(timr->it.real.interval);
 	/* Return 0 only, when the timer is expired and not pending */
 	if (remaining.tv64 <= 0)
 		cur_setting->it_value.tv_nsec = 1;
@@ -749,12 +755,12 @@ common_timer_set(struct k_itimer *timr, 
 		common_timer_get(timr, old_setting);
 
 	/* disable the timer */
-	timr->it.real.incr.tv64 = 0;
+	timr->it.real.interval.tv64 = 0;
 	/*
 	 * careful here.  If smp we could be in the "fire" routine which will
 	 * be spinning as we hold the lock.  But this is ONLY an SMP issue.
 	 */
-	if (ktimer_try_to_cancel(&timr->it.real.timer) < 0)
+	if (ktimer_try_to_cancel(&timr->it.real) < 0)
 		return TIMER_RETRY;
 
 	timr->it_requeue_pending = (timr->it_requeue_pending + 2) & 
@@ -779,12 +785,12 @@ common_timer_set(struct k_itimer *timr, 
 	expires = timespec_to_ktime(new_setting->it_value);
 
 	/* Convert and round the interval */
-	timr->it.real.incr = ktimer_round_timespec(&timr->it.real.timer,
-						     &new_setting->it_interval);
+	timr->it.real.interval = ktimer_round_timespec(&timr->it.real,
+						   &new_setting->it_interval);
 
 	/* SIGEV_NONE timers are not queued ! See common_timer_get */
 	if (((timr->it_sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_NONE))
-		ktimer_start(&timr->it.real.timer, &expires,
+		ktimer_start(&timr->it.real, &expires,
 			     mode | KTIMER_NOCHECK | KTIMER_ROUND);
 
 	return 0;
@@ -821,7 +827,7 @@ retry:
 
 	unlock_timer(timr, flag);
 	if (error == TIMER_RETRY) {
-		wait_for_ktimer(&timr->it.real.timer);
+		wait_for_ktimer(&timr->it.real);
 		rtn = NULL;	// We already got the old time...
 		goto retry;
 	}
@@ -835,9 +841,9 @@ retry:
 
 static inline int common_timer_del(struct k_itimer *timer)
 {
-	timer->it.real.incr.tv64 = 0;
+	timer->it.real.interval.tv64 = 0;
 
-	if (ktimer_try_to_cancel(&timer->it.real.timer) < 0)
+	if (ktimer_try_to_cancel(&timer->it.real) < 0)
 		return TIMER_RETRY;
 	return 0;
 }
@@ -861,7 +867,7 @@ retry_delete:
 
 	if (timer_delete_hook(timer) == TIMER_RETRY) {
 		unlock_timer(timer, flags);
-		wait_for_ktimer(&timer->it.real.timer);
+		wait_for_ktimer(&timer->it.real);
 		goto retry_delete;
 	}
 
@@ -894,7 +900,7 @@ retry_delete:
 
 	if (timer_delete_hook(timer) == TIMER_RETRY) {
 		unlock_timer(timer, flags);
-		wait_for_ktimer(&timer->it.real.timer);
+		wait_for_ktimer(&timer->it.real);
 		goto retry_delete;
 	}
 	list_del(&timer->list);

--

