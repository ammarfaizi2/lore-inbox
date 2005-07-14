Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262891AbVGNUow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262891AbVGNUow (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 16:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262988AbVGNUop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 16:44:45 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:22944 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262891AbVGNUn5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 16:43:57 -0400
Date: Thu, 14 Jul 2005 13:40:11 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 2/4] human-time soft-timer core changes
Message-ID: <20050714204011.GF28100@us.ibm.com>
References: <20050714202629.GD28100@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050714202629.GD28100@us.ibm.com>
X-Operating-System: Linux 2.6.13-rc2 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nishanth Aravamudan <nacc@us.ibm.com>

Description: The core revision to the soft-timer subsystem to divorce it
from the timer interrupt in software, i.e. jiffies. Instead, use
getnstimeofday() (via do_monotonic_clock()) as the basis for addition
and expiration of timers. Add a new unit, the timerinterval, which is
a 2^TIMERINTERVAL_BITS nanoseconds in length. The converted value in
timerintervals is used where we would have used the timer's expires
member before. Add set_timer_nsecs() and set_timer_nsecs_on() functions
to directly request nanosecond delays. These functions replace
add_timer(), mod_timer() and add_timer_on().

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

---

 include/linux/time.h  |    1 
 include/linux/timer.h |   27 +-----
 kernel/time.c         |   18 ++++
 kernel/timer.c        |  215 +++++++++++++++++++++++++++++++++++++++++++++-----
 4 files changed, 220 insertions(+), 41 deletions(-)

diff -urpN 2.6.13-rc3-base/include/linux/time.h 2.6.13-rc3-dev/include/linux/time.h
--- 2.6.13-rc3-base/include/linux/time.h	2005-03-01 23:38:12.000000000 -0800
+++ 2.6.13-rc3-dev/include/linux/time.h	2005-07-14 12:44:40.000000000 -0700
@@ -103,6 +103,7 @@ struct itimerval;
 extern int do_setitimer(int which, struct itimerval *value, struct itimerval *ovalue);
 extern int do_getitimer(int which, struct itimerval *value);
 extern void getnstimeofday (struct timespec *tv);
+extern u64 do_monotonic_clock(void);
 
 extern struct timespec timespec_trunc(struct timespec t, unsigned gran);
 
diff -urpN 2.6.13-rc3-base/include/linux/timer.h 2.6.13-rc3-dev/include/linux/timer.h
--- 2.6.13-rc3-base/include/linux/timer.h	2005-07-13 15:52:14.000000000 -0700
+++ 2.6.13-rc3-dev/include/linux/timer.h	2005-07-14 12:44:40.000000000 -0700
@@ -11,6 +11,7 @@ struct timer_base_s;
 struct timer_list {
 	struct list_head entry;
 	unsigned long expires;
+	u64 expires_nsecs;
 
 	unsigned long magic;
 
@@ -27,6 +28,7 @@ extern struct timer_base_s __init_timer_
 #define TIMER_INITIALIZER(_function, _expires, _data) {		\
 		.function = (_function),			\
 		.expires = (_expires),				\
+		.expires_nsecs = 0,				\
 		.data = (_data),				\
 		.base = &__init_timer_base,			\
 		.magic = TIMER_MAGIC,				\
@@ -51,30 +53,15 @@ static inline int timer_pending(const st
 
 extern void add_timer_on(struct timer_list *timer, int cpu);
 extern int del_timer(struct timer_list * timer);
-extern int __mod_timer(struct timer_list *timer, unsigned long expires);
+extern int __mod_timer(struct timer_list *timer);
 extern int mod_timer(struct timer_list *timer, unsigned long expires);
+extern void add_timer(struct timer_list *timer);
+extern int set_timer_nsecs(struct timer_list *timer, u64 expires_nsecs);
+extern void set_timer_on_nsecs(struct timer_list *timer, u64 expires_nsecs,
+								int cpu);
 
 extern unsigned long next_timer_interrupt(void);
 
-/***
- * add_timer - start a timer
- * @timer: the timer to be added
- *
- * The kernel will do a ->function(->data) callback from the
- * timer interrupt at the ->expired point in the future. The
- * current time is 'jiffies'.
- *
- * The timer's ->expired, ->function (and if the handler uses it, ->data)
- * fields must be set prior calling this function.
- *
- * Timers with an ->expired field in the past will be executed in the next
- * timer tick.
- */
-static inline void add_timer(struct timer_list * timer)
-{
-	__mod_timer(timer, timer->expires);
-}
-
 #ifdef CONFIG_SMP
   extern int try_to_del_timer_sync(struct timer_list *timer);
   extern int del_timer_sync(struct timer_list *timer);
diff -urpN 2.6.13-rc3-base/kernel/time.c 2.6.13-rc3-dev/kernel/time.c
--- 2.6.13-rc3-base/kernel/time.c	2005-07-13 15:51:57.000000000 -0700
+++ 2.6.13-rc3-dev/kernel/time.c	2005-07-14 12:44:40.000000000 -0700
@@ -589,3 +589,21 @@ EXPORT_SYMBOL(get_jiffies_64);
 #endif
 
 EXPORT_SYMBOL(jiffies);
+
+u64 do_monotonic_clock(void)
+{
+	struct timespec now, now_w2m;
+	unsigned long seq;
+
+	getnstimeofday(&now);
+
+	do {
+		seq = read_seqbegin(&xtime_lock);
+		now_w2m = wall_to_monotonic;
+	} while (read_seqretry(&xtime_lock, seq));
+
+	return (u64)(now.tv_sec + now_w2m.tv_sec) * NSEC_PER_SEC +
+				(now.tv_nsec + now_w2m.tv_nsec);
+}
+
+EXPORT_SYMBOL_GPL(do_monotonic_clock);
diff -urpN 2.6.13-rc3-base/kernel/timer.c 2.6.13-rc3-dev/kernel/timer.c
--- 2.6.13-rc3-base/kernel/timer.c	2005-07-13 15:52:14.000000000 -0700
+++ 2.6.13-rc3-dev/kernel/timer.c	2005-07-14 12:44:40.000000000 -0700
@@ -56,6 +56,15 @@ static void time_interpolator_update(lon
 #define TVR_SIZE (1 << TVR_BITS)
 #define TVN_MASK (TVN_SIZE - 1)
 #define TVR_MASK (TVR_SIZE - 1)
+/*
+ * Modifying TIMERINTERVAL_BITS changes the software resolution of
+ * soft-timers. While 20 bits would be closer to a millisecond, there
+ * are performance gains from allowing a software resolution finer than
+ * the hardware (HZ=1000)
+ */
+#define TIMERINTERVAL_BITS 19
+#define TIMERINTERVAL_SIZE (1 << TIMERINTERVAL_BITS)
+#define TIMERINTERVAL_MASK (TIMERINTERVAL_SIZE - 1)
 
 struct timer_base_s {
 	spinlock_t lock;
@@ -72,7 +81,7 @@ typedef struct tvec_root_s {
 
 struct tvec_t_base_s {
 	struct timer_base_s t_base;
-	unsigned long timer_jiffies;
+	unsigned long last_timer_time;
 	tvec_root_t tv1;
 	tvec_t tv2;
 	tvec_t tv3;
@@ -114,11 +123,88 @@ static inline void check_timer(struct ti
 		check_timer_failed(timer);
 }
 
+/*
+ * nsecs_to_timerintervals_ceiling - convert nanoseconds to timerintervals
+ * @n: number of nanoseconds to convert
+ *
+ * This is where changes to TIMERINTERVAL_BITS affect the soft-timer
+ * subsystem.
+ *
+ * Some explanation of the math is necessary:
+ * Rather than do decimal arithmetic, we shift for the sake of speed.
+ * This does mean that the actual requestable sleeps are
+ * 	2^(sizeof(unsigned long)*8 - TIMERINTERVAL_BITS)
+ * timerintervals.
+ *
+ * The conditional takes care of the corner case where we request a 0
+ * nanosecond sleep; if the quantity were unsigned, we would not
+ * propogate the carry and force a wrap when adding the 1.
+ *
+ * To prevent timers from being expired early, we:
+ *	Take the ceiling when we add; and
+ *	Take the floor when we expire.
+ */
+static inline unsigned long nsecs_to_timerintervals_ceiling(u64 nsecs)
+{
+	if (nsecs)
+		return (unsigned long)(((nsecs - 1) >> TIMERINTERVAL_BITS) + 1);
+	else
+		return 0UL;
+}
+
+/*
+ * nsecs_to_timerintervals_floor - convert nanoseconds to timerintervals
+ * @n: number of nanoseconds to convert
+ *
+ * This is where changes to TIMERINTERVAL_BITS affect the soft-timer
+ * subsystem.
+ *
+ * Some explanation of the math is necessary:
+ * Rather than do decimal arithmetic, we shift for the sake of speed.
+ * This does mean that the actual requestable sleeps are
+ * 	2^(sizeof(unsigned long)*8 - TIMERINTERVAL_BITS)
+ *
+ * There is no special case for 0 in the floor function, since we do not
+ * do any subtraction or addition of 1
+ *
+ * To prevent timers from being expired early, we:
+ *	Take the ceiling when we add; and
+ *	Take the floor when we expire.
+ */
+static inline unsigned long nsecs_to_timerintervals_floor(u64 nsecs)
+{
+	return (unsigned long)(nsecs >> TIMERINTERVAL_BITS);
+}
+
+/*
+ * jiffies_to_timerintervals - convert absolute jiffies to timerintervals
+ * @abs_jiffies: number of jiffies to convert
+ *
+ * First, we convert the absolute jiffies parameter to a relative
+ * jiffies value. To maintain precision, we convert the relative
+ * jiffies value to a relative nanosecond value and then convert that
+ * to a relative soft-timer interval unit value. We then add this
+ * relative value to the current time according to the timeofday-
+ * subsystem, converted to soft-timer interval units.
+ *
+ * We only use this function when adding timers, so we are free to
+ * always use the ceiling version of nsecs_to_timerintervals.
+ *
+ * This function only exists to support deprecated interfaces. Once
+ * those interfaces have been converted to the alternatives, it should
+ * be removed.
+ */
+static inline unsigned long jiffies_to_timerintervals(unsigned long abs_jiffies)
+{
+	unsigned long relative_jiffies = abs_jiffies - jiffies;
+	return nsecs_to_timerintervals_ceiling(do_monotonic_clock() +
+		jiffies_to_nsecs(relative_jiffies));
+}
 
 static void internal_add_timer(tvec_base_t *base, struct timer_list *timer)
 {
-	unsigned long expires = timer->expires;
-	unsigned long idx = expires - base->timer_jiffies;
+	unsigned long expires = nsecs_to_timerintervals_ceiling(timer->expires_nsecs);
+	unsigned long idx = expires - base->last_timer_time;
 	struct list_head *vec;
 
 	if (idx < TVR_SIZE) {
@@ -138,7 +224,7 @@ static void internal_add_timer(tvec_base
 		 * Can happen if you add a timer with expires == jiffies,
 		 * or you set a timer to go off in the past
 		 */
-		vec = base->tv1.vec + (base->timer_jiffies & TVR_MASK);
+		vec = base->tv1.vec + (base->last_timer_time & TVR_MASK);
 	} else {
 		int i;
 		/* If the timeout is larger than 0xffffffff on 64-bit
@@ -146,7 +232,7 @@ static void internal_add_timer(tvec_base
 		 */
 		if (idx > 0xffffffffUL) {
 			idx = 0xffffffffUL;
-			expires = idx + base->timer_jiffies;
+			expires = idx + base->last_timer_time;
 		}
 		i = (expires >> (TVR_BITS + 3 * TVN_BITS)) & TVN_MASK;
 		vec = base->tv5.vec + i;
@@ -222,7 +308,7 @@ static timer_base_t *lock_timer_base(str
 	}
 }
 
-int __mod_timer(struct timer_list *timer, unsigned long expires)
+int __mod_timer(struct timer_list *timer)
 {
 	timer_base_t *base;
 	tvec_base_t *new_base;
@@ -261,7 +347,7 @@ int __mod_timer(struct timer_list *timer
 		}
 	}
 
-	timer->expires = expires;
+	/* expires should be in timerintervals, and is currently ignored? */
 	internal_add_timer(new_base, timer);
 	spin_unlock_irqrestore(&new_base->t_base.lock, flags);
 
@@ -281,21 +367,50 @@ void add_timer_on(struct timer_list *tim
 {
 	tvec_base_t *base = &per_cpu(tvec_bases, cpu);
   	unsigned long flags;
-
+  
   	BUG_ON(timer_pending(timer) || !timer->function);
 
 	check_timer(timer);
 
 	spin_lock_irqsave(&base->t_base.lock, flags);
+	timer->expires_nsecs = do_monotonic_clock() +
+		jiffies_to_nsecs(timer->expires - jiffies);
 	timer->base = &base->t_base;
 	internal_add_timer(base, timer);
 	spin_unlock_irqrestore(&base->t_base.lock, flags);
 }
 
+/***
+ * add_timer - start a timer
+ * @timer: the timer to be added
+ *
+ * The kernel will do a ->function(->data) callback from the
+ * timer interrupt at the ->expired point in the future. The
+ * current time is 'jiffies'.
+ *
+ * The timer's ->expired, ->function (and if the handler uses it, ->data)
+ * fields must be set prior calling this function.
+ *
+ * Timers with an ->expired field in the past will be executed in the next
+ * timer tick.
+ *
+ * The callers of add_timer() should be aware that the interface is now
+ * deprecated. set_timer_nsecs() is the single interface for adding and
+ * modifying timers.
+ */
+void add_timer(struct timer_list * timer)
+{
+	timer->expires_nsecs = do_monotonic_clock() +
+		jiffies_to_nsecs(timer->expires - jiffies);
+	__mod_timer(timer);
+}
+
+EXPORT_SYMBOL(add_timer);
 
 /***
  * mod_timer - modify a timer's timeout
  * @timer: the timer to be modified
+ * @expires: absolute time, in jiffies, when timer should expire
  *
  * mod_timer is a more efficient way to update the expire field of an
  * active timer (if the timer is inactive it will be activated)
@@ -311,6 +426,10 @@ void add_timer_on(struct timer_list *tim
  * The function returns whether it has modified a pending timer or not.
  * (ie. mod_timer() of an inactive timer returns 0, mod_timer() of an
  * active timer returns 1.)
+ *
+ * The callers of mod_timer() should be aware that the interface is now
+ * deprecated. set_timer_nsecs() is the single interface for adding and
+ * modifying timers.
  */
 int mod_timer(struct timer_list *timer, unsigned long expires)
 {
@@ -318,6 +437,9 @@ int mod_timer(struct timer_list *timer, 
 
 	check_timer(timer);
 
+	timer->expires_nsecs = do_monotonic_clock() +
+		jiffies_to_nsecs(expires - jiffies);
+
 	/*
 	 * This is a common optimization triggered by the
 	 * networking code - if the timer is re-modified
@@ -326,10 +448,56 @@ int mod_timer(struct timer_list *timer, 
 	if (timer->expires == expires && timer_pending(timer))
 		return 1;
 
-	return __mod_timer(timer, expires);
+	return __mod_timer(timer);
 }
 
-EXPORT_SYMBOL(mod_timer);
+/*
+ * set_timer_nsecs - modify a timer's timeout in nsecs
+ * @timer: the timer to be modified
+ *
+ * set_timer_nsecs replaces both add_timer and mod_timer. The caller
+ * should call do_monotonic_clock() to determine the absolute timeout
+ * necessary.
+ */
+int set_timer_nsecs(struct timer_list *timer, u64 expires_nsecs)
+{
+	BUG_ON(!timer->function);
+
+	check_timer(timer);
+
+	if (timer_pending(timer) && timer->expires_nsecs == expires_nsecs)
+		return 1;
+
+	timer->expires_nsecs = expires_nsecs;
+
+	return __mod_timer(timer);
+}
+
+EXPORT_SYMBOL_GPL(set_timer_nsecs);
+
+/***
+ * set_timer_on_nsecs - start a timer on a particular CPU
+ * @timer: the timer to be added
+ * @expires_nsecs: absolute time in nsecs when timer should expire
+ * @cpu: the CPU to start it on
+ *
+ * This is not very scalable on SMP. Double adds are not possible.
+ */
+void set_timer_on_nsecs(struct timer_list *timer, u64 expires_nsecs, int cpu)
+{
+	tvec_base_t *base = &per_cpu(tvec_bases, cpu);
+  	unsigned long flags;
+
+  	BUG_ON(timer_pending(timer) || !timer->function);
+
+	check_timer(timer);
+
+	spin_lock_irqsave(&base->t_base.lock, flags);
+	timer->expires_nsecs = expires_nsecs;
+	timer->base = &base->t_base;
+	internal_add_timer(base, timer);
+	spin_unlock_irqrestore(&base->t_base.lock, flags);
+}
 
 /***
  * del_timer - deactive a timer.
@@ -455,17 +623,17 @@ static int cascade(tvec_base_t *base, tv
  * This function cascades all vectors and executes all expired timer
  * vectors.
  */
-#define INDEX(N) (base->timer_jiffies >> (TVR_BITS + N * TVN_BITS)) & TVN_MASK
+#define INDEX(N) (base->last_timer_time >> (TVR_BITS + N * TVN_BITS)) & TVN_MASK
 
-static inline void __run_timers(tvec_base_t *base)
+static inline void __run_timers(tvec_base_t *base, unsigned long current_timer_time)
 {
 	struct timer_list *timer;
 
 	spin_lock_irq(&base->t_base.lock);
-	while (time_after_eq(jiffies, base->timer_jiffies)) {
+	while (time_after_eq(current_timer_time, base->last_timer_time)) {
 		struct list_head work_list = LIST_HEAD_INIT(work_list);
 		struct list_head *head = &work_list;
- 		int index = base->timer_jiffies & TVR_MASK;
+ 		int index = base->last_timer_time & TVR_MASK;
  
 		/*
 		 * Cascade timers:
@@ -475,7 +643,7 @@ static inline void __run_timers(tvec_bas
 				(!cascade(base, &base->tv3, INDEX(1))) &&
 					!cascade(base, &base->tv4, INDEX(2)))
 			cascade(base, &base->tv5, INDEX(3));
-		++base->timer_jiffies; 
+		++base->last_timer_time;
 		list_splice_init(base->tv1.vec + index, &work_list);
 		while (!list_empty(head)) {
 			void (*fn)(unsigned long);
@@ -524,20 +692,20 @@ unsigned long next_timer_interrupt(void)
 
 	base = &__get_cpu_var(tvec_bases);
 	spin_lock(&base->t_base.lock);
-	expires = base->timer_jiffies + (LONG_MAX >> 1);
+	expires = base->last_timer_time + (LONG_MAX >> 1);
 	list = 0;
 
 	/* Look for timer events in tv1. */
-	j = base->timer_jiffies & TVR_MASK;
+	j = base->last_timer_time & TVR_MASK;
 	do {
 		list_for_each_entry(nte, base->tv1.vec + j, entry) {
 			expires = nte->expires;
-			if (j < (base->timer_jiffies & TVR_MASK))
+			if (j < (base->last_timer_time & TVR_MASK))
 				list = base->tv2.vec + (INDEX(0));
 			goto found;
 		}
 		j = (j + 1) & TVR_MASK;
-	} while (j != (base->timer_jiffies & TVR_MASK));
+	} while (j != (base->last_timer_time & TVR_MASK));
 
 	/* Check tv2-tv5. */
 	varray[0] = &base->tv2;
@@ -910,10 +1078,15 @@ EXPORT_SYMBOL(xtime_lock);
  */
 static void run_timer_softirq(struct softirq_action *h)
 {
+	unsigned long current_timer_time;
 	tvec_base_t *base = &__get_cpu_var(tvec_bases);
 
-	if (time_after_eq(jiffies, base->timer_jiffies))
-		__run_timers(base);
+	/* cache the converted current time, rounding down */
+	current_timer_time =
+		nsecs_to_timerintervals_floor(do_monotonic_clock());
+
+	if (time_after_eq(current_timer_time, base->last_timer_time))
+		__run_timers(base, current_timer_time);
 }
 
 /*
