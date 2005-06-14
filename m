Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261433AbVFNDu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbVFNDu7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 23:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbVFNDu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 23:50:58 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:30402 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261433AbVFNDsl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 23:48:41 -0400
Date: Mon, 13 Jun 2005 20:48:29 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org, kernel-stuff@comcast.net, frank@tuxrocks.com
Subject: [PATCH 1/4] convert soft-timer subsystem to timerintervals
Message-ID: <20050614034829.GB4180@us.ibm.com>
References: <1118286702.5754.44.camel@cog.beaverton.ibm.com> <20050614034655.GA4180@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050614034655.GA4180@us.ibm.com>
X-Operating-System: Linux 2.6.12-rc5 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.06.2005 [20:46:55 -0700], Nishanth Aravamudan wrote:
> On 08.06.2005 [20:11:42 -0700], john stultz wrote:
> > Hey Everyone,
> > 	I'm heading out on vacation until Monday, so I'm just re-spinning my
> > current tree for testing. If there's no major issues on Monday, I'll re-
> > diff against Andrew's tree and re-submit the patches for inclusion.
> 
> Here is an update of my soft-timer rework to John's latest patches. I
> have made some major changes in this revision. I would still greatly
> appreciate any comments.

<snip>

Description: Rework the soft-timer subsytem to use timerintervals (a new
unit) instead of jiffies for expiration and addition. timerintervals are
nothing more than the nanosecond time returned by the new
timeofday-subsystem shifted down a certain number of bits (thus
determining the precision of the soft-timer subsystem at compile-time).

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

diff -urpN 2.6.12-rc6-tod-timer-base/include/linux/jiffies.h 2.6.12-rc6-tod-timer-dev/include/linux/jiffies.h
--- 2.6.12-rc6-tod-timer-base/include/linux/jiffies.h	2005-03-01 23:37:31.000000000 -0800
+++ 2.6.12-rc6-tod-timer-dev/include/linux/jiffies.h	2005-06-13 19:46:34.000000000 -0700
@@ -263,7 +263,7 @@ static inline unsigned int jiffies_to_ms
 #endif
 }
 
-static inline unsigned int jiffies_to_usecs(const unsigned long j)
+static inline unsigned long jiffies_to_usecs(const unsigned long j)
 {
 #if HZ <= 1000000 && !(1000000 % HZ)
 	return (1000000 / HZ) * j;
@@ -274,6 +274,17 @@ static inline unsigned int jiffies_to_us
 #endif
 }
 
+static inline nsec_t jiffies_to_nsecs(const unsigned long j)
+{
+#if HZ <= NSEC_PER_SEC && !(NSEC_PER_SEC % HZ)
+	return (NSEC_PER_SEC / HZ) * (nsec_t)j;
+#elif HZ > NSEC_PER_SEC && !(HZ % NSEC_PER_SEC)
+	return ((nsec_t)j + (HZ / NSEC_PER_SEC) - 1)/(HZ / NSEC_PER_SEC);
+#else
+	return ((nsec_t)j * NSEC_PER_SEC) / HZ;
+#endif
+}
+
 static inline unsigned long msecs_to_jiffies(const unsigned int m)
 {
 	if (m > jiffies_to_msecs(MAX_JIFFY_OFFSET))
@@ -287,7 +298,7 @@ static inline unsigned long msecs_to_jif
 #endif
 }
 
-static inline unsigned long usecs_to_jiffies(const unsigned int u)
+static inline unsigned long usecs_to_jiffies(const unsigned long u)
 {
 	if (u > jiffies_to_usecs(MAX_JIFFY_OFFSET))
 		return MAX_JIFFY_OFFSET;
@@ -300,6 +311,24 @@ static inline unsigned long usecs_to_jif
 #endif
 }
 
+static inline unsigned long nsecs_to_jiffies(const nsec_t n)
+{
+	nsec_t temp;
+	if (n > jiffies_to_nsecs(MAX_JIFFY_OFFSET))
+		return MAX_JIFFY_OFFSET;
+#if HZ <= NSEC_PER_SEC && !(NSEC_PER_SEC % HZ)
+	temp = n + (NSEC_PER_SEC / HZ) - 1;
+	do_div(temp, (NSEC_PER_SEC / HZ));
+	return (unsigned long)temp;
+#elif HZ > NSEC_PER_SEC && !(HZ % NSEC_PER_SEC)
+	return n * (HZ / NSEC_PER_SEC);
+#else
+	temp = n * HZ + NSEC_PER_SEC - 1;
+	do_div(temp, NSEC_PER_SEC);
+	return (unsigned long)temp;
+#endif
+}
+
 /*
  * The TICK_NSEC - 1 rounds up the value to the next resolution.  Note
  * that a remainder subtract here would not do the right thing as the
diff -urpN 2.6.12-rc6-tod-timer-base/include/linux/sched.h 2.6.12-rc6-tod-timer-dev/include/linux/sched.h
--- 2.6.12-rc6-tod-timer-base/include/linux/sched.h	2005-06-10 23:44:23.000000000 -0700
+++ 2.6.12-rc6-tod-timer-dev/include/linux/sched.h	2005-06-13 19:46:34.000000000 -0700
@@ -182,7 +182,13 @@ extern void scheduler_tick(void);
 extern int in_sched_functions(unsigned long addr);
 
 #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
+#define	MAX_SCHEDULE_TIMEOUT_NSECS	((nsec_t)(-1))
+#define	MAX_SCHEDULE_TIMEOUT_USECS	ULONG_MAX
+#define	MAX_SCHEDULE_TIMEOUT_MSECS	UINT_MAX
 extern signed long FASTCALL(schedule_timeout(signed long timeout));
+extern nsec_t FASTCALL(schedule_timeout_nsecs(nsec_t timeout_nsecs));
+extern unsigned long FASTCALL(schedule_timeout_usecs(unsigned long timeout_usecs));
+extern unsigned int FASTCALL(schedule_timeout_msecs(unsigned int timeout_msesc));
 asmlinkage void schedule(void);
 
 struct namespace;
diff -urpN 2.6.12-rc6-tod-timer-base/include/linux/time.h 2.6.12-rc6-tod-timer-dev/include/linux/time.h
--- 2.6.12-rc6-tod-timer-base/include/linux/time.h	2005-06-11 19:59:26.000000000 -0700
+++ 2.6.12-rc6-tod-timer-dev/include/linux/time.h	2005-06-13 19:46:34.000000000 -0700
@@ -40,6 +40,10 @@ typedef u64 cycle_t;
 #define NSEC_PER_SEC (1000000000L)
 #endif
 
+#ifndef NSEC_PER_MSEC
+#define NSEC_PER_MSEC (1000000L)
+#endif
+
 #ifndef NSEC_PER_USEC
 #define NSEC_PER_USEC (1000L)
 #endif
diff -urpN 2.6.12-rc6-tod-timer-base/include/linux/timer.h 2.6.12-rc6-tod-timer-dev/include/linux/timer.h
--- 2.6.12-rc6-tod-timer-base/include/linux/timer.h	2005-03-01 23:38:13.000000000 -0800
+++ 2.6.12-rc6-tod-timer-dev/include/linux/timer.h	2005-06-13 19:46:34.000000000 -0700
@@ -5,12 +5,14 @@
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/stddef.h>
+#include <linux/timeofday.h>
 
 struct tvec_t_base_s;
 
 struct timer_list {
 	struct list_head entry;
 	unsigned long expires;
+	nsec_t expires_nsecs;
 
 	spinlock_t lock;
 	unsigned long magic;
@@ -26,6 +28,7 @@ struct timer_list {
 #define TIMER_INITIALIZER(_function, _expires, _data) {		\
 		.function = (_function),			\
 		.expires = (_expires),				\
+		.expires_nsecs = 0,				\
 		.data = (_data),				\
 		.base = NULL,					\
 		.magic = TIMER_MAGIC,				\
@@ -63,29 +66,15 @@ static inline int timer_pending(const st
 
 extern void add_timer_on(struct timer_list *timer, int cpu);
 extern int del_timer(struct timer_list * timer);
-extern int __mod_timer(struct timer_list *timer, unsigned long expires);
+extern int __mod_timer(struct timer_list *timer);
 extern int mod_timer(struct timer_list *timer, unsigned long expires);
+extern void add_timer(struct timer_list *timer);
+extern int set_timer_nsecs(struct timer_list *timer, nsec_t expires_nsecs);
+extern void set_timer_on_nsecs(struct timer_list *timer, nsec_t expires_nsecs,
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
 
 #ifdef CONFIG_SMP
   extern int del_timer_sync(struct timer_list *timer);
diff -urpN 2.6.12-rc6-tod-timer-base/kernel/timer.c 2.6.12-rc6-tod-timer-dev/kernel/timer.c
--- 2.6.12-rc6-tod-timer-base/kernel/timer.c	2005-06-11 19:59:26.000000000 -0700
+++ 2.6.12-rc6-tod-timer-dev/kernel/timer.c	2005-06-13 19:46:34.000000000 -0700
@@ -33,6 +33,7 @@
 #include <linux/posix-timers.h>
 #include <linux/cpu.h>
 #include <linux/syscalls.h>
+#include <linux/timeofday.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -56,6 +57,15 @@ static void time_interpolator_update(lon
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
 
 typedef struct tvec_s {
 	struct list_head vec[TVN_SIZE];
@@ -67,7 +77,7 @@ typedef struct tvec_root_s {
 
 struct tvec_t_base_s {
 	spinlock_t lock;
-	unsigned long timer_jiffies;
+	unsigned long last_timer_time;		/* in timerintervals */
 	struct timer_list *running_timer;
 	tvec_root_t tv1;
 	tvec_t tv2;
@@ -113,13 +123,100 @@ static inline void check_timer(struct ti
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
+static inline unsigned long nsecs_to_timerintervals_ceiling(nsec_t nsecs)
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
+static inline unsigned long nsecs_to_timerintervals_floor(nsec_t nsecs)
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
+	/* expires needs to be in timerintervals, have nsecs in timer */
+	unsigned long expires = nsecs_to_timerintervals_ceiling(timer->expires_nsecs);
+	unsigned long idx = expires - base->last_timer_time;
 	struct list_head *vec;
 
+#if 0
+	{
+		static int debug = 0;
+		if(!((++debug)%10000)) {
+			printk("nacc: adding timer to expire at %llu nsecs, %lu tiu\n", timer->expires_nsecs, expires);
+		}
+	}
+#endif
+
 	if (idx < TVR_SIZE) {
 		int i = expires & TVR_MASK;
 		vec = base->tv1.vec + i;
@@ -137,7 +234,7 @@ static void internal_add_timer(tvec_base
 		 * Can happen if you add a timer with expires == jiffies,
 		 * or you set a timer to go off in the past
 		 */
-		vec = base->tv1.vec + (base->timer_jiffies & TVR_MASK);
+		vec = base->tv1.vec + (base->last_timer_time & TVR_MASK);
 	} else {
 		int i;
 		/* If the timeout is larger than 0xffffffff on 64-bit
@@ -145,7 +242,7 @@ static void internal_add_timer(tvec_base
 		 */
 		if (idx > 0xffffffffUL) {
 			idx = 0xffffffffUL;
-			expires = idx + base->timer_jiffies;
+			expires = idx + base->last_timer_time;
 		}
 		i = (expires >> (TVR_BITS + 3 * TVN_BITS)) & TVN_MASK;
 		vec = base->tv5.vec + i;
@@ -156,7 +253,7 @@ static void internal_add_timer(tvec_base
 	list_add_tail(&timer->entry, vec);
 }
 
-int __mod_timer(struct timer_list *timer, unsigned long expires)
+int __mod_timer(struct timer_list *timer)
 {
 	tvec_base_t *old_base, *new_base;
 	unsigned long flags;
@@ -207,7 +304,8 @@ repeat:
 		list_del(&timer->entry);
 		ret = 1;
 	}
-	timer->expires = expires;
+	/* expires is in timerintervals */
+	/* timer->expires = expires; */
 	internal_add_timer(new_base, timer);
 	timer->base = new_base;
 
@@ -238,15 +336,44 @@ void add_timer_on(struct timer_list *tim
 	check_timer(timer);
 
 	spin_lock_irqsave(&base->lock, flags);
+	timer->expires_nsecs = do_monotonic_clock() +
+		jiffies_to_nsecs(timer->expires - jiffies);
 	internal_add_timer(base, timer);
 	timer->base = base;
 	spin_unlock_irqrestore(&base->lock, flags);
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
@@ -262,6 +389,10 @@ void add_timer_on(struct timer_list *tim
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
@@ -269,6 +400,10 @@ int mod_timer(struct timer_list *timer, 
 
 	check_timer(timer);
 
+	timer->expires_nsecs = do_monotonic_clock() +
+		jiffies_to_nsecs(expires - jiffies);
+
+	expires = jiffies_to_timerintervals(expires);
 	/*
 	 * This is a common optimization triggered by the
 	 * networking code - if the timer is re-modified
@@ -277,11 +412,66 @@ int mod_timer(struct timer_list *timer, 
 	if (timer->expires == expires && timer_pending(timer))
 		return 1;
 
-	return __mod_timer(timer, expires);
+	return __mod_timer(timer);
 }
 
 EXPORT_SYMBOL(mod_timer);
 
+/*
+ * set_timer_nsecs - modify a timer's timeout in nsecs
+ * @timer: the timer to be modified
+ *
+ * set_timer_nsecs replaces both add_timer and mod_timer. The caller
+ * should call do_monotonic_clock() to determine the absolute timeout
+ * necessary.
+ */
+int set_timer_nsecs(struct timer_list *timer, nsec_t expires_nsecs)
+{
+	unsigned long expires;
+
+	BUG_ON(!timer->function);
+
+	check_timer(timer);
+
+	/* make sure to round up */
+	expires = nsecs_to_timerintervals_ceiling(expires_nsecs);
+	if (timer_pending(timer) && timer->expires == expires)
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
+void set_timer_on_nsecs(struct timer_list *timer, nsec_t expires_nsecs, int cpu)
+{
+	tvec_base_t *base = &per_cpu(tvec_bases, cpu);
+  	unsigned long flags;
+
+  	BUG_ON(timer_pending(timer) || !timer->function);
+
+	check_timer(timer);
+
+	spin_lock_irqsave(&base->lock, flags);
+	/* make sure to round up */
+	timer->expires_nsecs = expires_nsecs;
+	internal_add_timer(base, timer);
+	timer->base = base;
+	spin_unlock_irqrestore(&base->lock, flags);
+}
+
+EXPORT_SYMBOL_GPL(set_timer_on_nsecs);
+
 /***
  * del_timer - deactive a timer.
  * @timer: the timer to be deactivated
@@ -427,21 +617,22 @@ static int cascade(tvec_base_t *base, tv
 /***
  * __run_timers - run all expired timers (if any) on this CPU.
  * @base: the timer vector to be processed.
+ * @current_timer_time: the current time in soft-timer interval units
  *
  * This function cascades all vectors and executes all expired timer
  * vectors.
  */
-#define INDEX(N) (base->timer_jiffies >> (TVR_BITS + N * TVN_BITS)) & TVN_MASK
+#define INDEX(N) (base->last_timer_time >> (TVR_BITS + N * TVN_BITS)) & TVN_MASK
 
-static inline void __run_timers(tvec_base_t *base)
+static inline void __run_timers(tvec_base_t *base, unsigned long current_timer_time)
 {
 	struct timer_list *timer;
 
 	spin_lock_irq(&base->lock);
-	while (time_after_eq(jiffies, base->timer_jiffies)) {
+	while (time_after_eq(current_timer_time, base->last_timer_time)) {
 		struct list_head work_list = LIST_HEAD_INIT(work_list);
 		struct list_head *head = &work_list;
- 		int index = base->timer_jiffies & TVR_MASK;
+ 		int index = base->last_timer_time & TVR_MASK;
  
 		/*
 		 * Cascade timers:
@@ -451,7 +642,7 @@ static inline void __run_timers(tvec_bas
 				(!cascade(base, &base->tv3, INDEX(1))) &&
 					!cascade(base, &base->tv4, INDEX(2)))
 			cascade(base, &base->tv5, INDEX(3));
-		++base->timer_jiffies; 
+		++base->last_timer_time;
 		list_splice_init(base->tv1.vec + index, &work_list);
 repeat:
 		if (!list_empty(head)) {
@@ -500,20 +691,20 @@ unsigned long next_timer_interrupt(void)
 
 	base = &__get_cpu_var(tvec_bases);
 	spin_lock(&base->lock);
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
@@ -890,10 +1081,15 @@ EXPORT_SYMBOL(xtime_lock);
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
@@ -1078,6 +1274,10 @@ static void process_timeout(unsigned lon
  * value will be %MAX_SCHEDULE_TIMEOUT.
  *
  * In all cases the return value is guaranteed to be non-negative.
+ *
+ * The callers of schedule_timeout() should be aware that the interface
+ * is now deprecated. schedule_timeout_{msecs,usecs,nsecs}() are now the
+ * interfaces for relative timeout requests.
  */
 fastcall signed long __sched schedule_timeout(signed long timeout)
 {
@@ -1133,6 +1333,149 @@ fastcall signed long __sched schedule_ti
 
 EXPORT_SYMBOL(schedule_timeout);
 
+/**
+ * schedule_timeout_nsecs - sleep until timeout
+ * @timeout_nsecs: timeout value in nanoseconds
+ *
+ * Make the current task sleep until @timeout_nsecs nsecs have
+ * elapsed. The routine will return immediately unless
+ * the current task state has been set (see set_current_state()).
+ *
+ * You can set the task state as follows -
+ *
+ * %TASK_UNINTERRUPTIBLE - at least @timeout_nsecs nsecs are guaranteed
+ * to pass before the routine returns. The routine will return 0
+ *
+ * %TASK_INTERRUPTIBLE - the routine may return early if a signal is
+ * delivered to the current task. In this case the remaining time
+ * in nsecs will be returned, or 0 if the timer expired in time
+ *
+ * The current task state is guaranteed to be TASK_RUNNING when this
+ * routine returns.
+ *
+ * Specifying a @timeout value of %MAX_SCHEDULE_TIMEOUT_NSECS will
+ * schedule the CPU away without a bound on the timeout. In this case
+ * the return value will be %MAX_SCHEDULE_TIMEOUT_NSECS.
+ */
+fastcall nsec_t __sched schedule_timeout_nsecs(nsec_t timeout_nsecs)
+{
+	struct timer_list timer;
+	nsec_t expires;
+
+	if (timeout_nsecs == MAX_SCHEDULE_TIMEOUT_NSECS) {
+		schedule();
+		goto out;
+	}
+
+	expires = do_monotonic_clock() + timeout_nsecs;
+
+	init_timer(&timer);
+	timer.data = (unsigned long) current;
+	timer.function = process_timeout;
+
+	set_timer_nsecs(&timer, expires);
+	schedule();
+	del_singleshot_timer_sync(&timer);
+
+	timeout_nsecs = do_monotonic_clock();
+	if (expires < timeout_nsecs)
+		timeout_nsecs = (nsec_t)0UL;
+	else
+		timeout_nsecs = expires - timeout_nsecs;
+out:
+	return timeout_nsecs;
+}
+
+EXPORT_SYMBOL_GPL(schedule_timeout_nsecs);
+
+/**
+ * schedule_timeout_usecs - sleep until timeout
+ * @timeout_usecs: timeout value in nanoseconds
+ *
+ * Make the current task sleep until @timeout_usecs usecs have
+ * elapsed. The routine will return immediately unless
+ * the current task state has been set (see set_current_state()).
+ *
+ * You can set the task state as follows -
+ *
+ * %TASK_UNINTERRUPTIBLE - at least @timeout_usecs usecs are guaranteed
+ * to pass before the routine returns. The routine will return 0
+ *
+ * %TASK_INTERRUPTIBLE - the routine may return early if a signal is
+ * delivered to the current task. In this case the remaining time
+ * in usecs will be returned, or 0 if the timer expired in time
+ *
+ * The current task state is guaranteed to be TASK_RUNNING when this
+ * routine returns.
+ *
+ * Specifying a @timeout value of %MAX_SCHEDULE_TIMEOUT_USECS will
+ * schedule the CPU away without a bound on the timeout. In this case
+ * the return value will be %MAX_SCHEDULE_TIMEOUT_USECS.
+ */
+fastcall inline unsigned long __sched schedule_timeout_usecs(unsigned long timeout_usecs)
+{
+	nsec_t timeout_nsecs;
+
+	if (timeout_usecs == MAX_SCHEDULE_TIMEOUT_USECS)
+		timeout_nsecs = MAX_SCHEDULE_TIMEOUT_NSECS;
+	else
+		timeout_nsecs = timeout_usecs * (nsec_t)NSEC_PER_USEC;
+	/*
+	 * Make sure to round up by subtracting one before division and
+	 * adding one after
+	 */
+	timeout_nsecs = schedule_timeout_nsecs(timeout_nsecs) - 1;
+	do_div(timeout_nsecs, NSEC_PER_USEC);
+	timeout_usecs = (unsigned long)timeout_nsecs + 1UL;
+	return timeout_usecs;
+}
+
+EXPORT_SYMBOL_GPL(schedule_timeout_usecs);
+
+/**
+ * schedule_timeout_msecs - sleep until timeout
+ * @timeout_msecs: timeout value in nanoseconds
+ *
+ * Make the current task sleep until @timeout_msecs msecs have
+ * elapsed. The routine will return immediately unless
+ * the current task state has been set (see set_current_state()).
+ *
+ * You can set the task state as follows -
+ *
+ * %TASK_UNINTERRUPTIBLE - at least @timeout_msecs msecs are guaranteed
+ * to pass before the routine returns. The routine will return 0
+ *
+ * %TASK_INTERRUPTIBLE - the routine may return early if a signal is
+ * delivered to the current task. In this case the remaining time
+ * in msecs will be returned, or 0 if the timer expired in time
+ *
+ * The current task state is guaranteed to be TASK_RUNNING when this
+ * routine returns.
+ *
+ * Specifying a @timeout value of %MAX_SCHEDULE_TIMEOUT_MSECS will
+ * schedule the CPU away without a bound on the timeout. In this case
+ * the return value will be %MAX_SCHEDULE_TIMEOUT_MSECS.
+ */
+fastcall inline unsigned int __sched schedule_timeout_msecs(unsigned int timeout_msecs)
+{
+	nsec_t timeout_nsecs;
+
+	if (timeout_msecs == MAX_SCHEDULE_TIMEOUT_MSECS)
+		timeout_nsecs = MAX_SCHEDULE_TIMEOUT_NSECS;
+	else
+		timeout_nsecs = timeout_msecs * (nsec_t)NSEC_PER_MSEC;
+	/*
+	 * Make sure to round up by subtracting one before division and
+	 * adding one after
+	 */
+	timeout_nsecs = schedule_timeout_nsecs(timeout_nsecs) - 1;
+	do_div(timeout_nsecs, NSEC_PER_MSEC);
+	timeout_msecs = (unsigned int)timeout_nsecs + 1;
+	return timeout_msecs;
+}
+
+EXPORT_SYMBOL_GPL(schedule_timeout_msecs);
+
 /* Thread ID - the internal kernel "pid" */
 asmlinkage long sys_gettid(void)
 {
@@ -1302,7 +1645,11 @@ static void __devinit init_timers_cpu(in
 	for (j = 0; j < TVR_SIZE; j++)
 		INIT_LIST_HEAD(base->tv1.vec + j);
 
-	base->timer_jiffies = jiffies;
+	/*
+	 * Under the new montonic_clock() oriented soft-timer subsystem,
+	 * we begin at 0, not INITIAL_JIFFIES
+	 */
+	base->last_timer_time = 0UL;
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
