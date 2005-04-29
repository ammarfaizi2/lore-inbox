Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263067AbVD2Xgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263067AbVD2Xgi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 19:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263069AbVD2Xgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 19:36:38 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:54221 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S263067AbVD2Xfu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 19:35:50 -0400
Date: Fri, 29 Apr 2005 16:35:46 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, albert@users.sourceforge.net,
       paulus@samba.org, schwidefsky@de.ibm.com, mahuja@us.ibm.com,
       donf@us.ibm.com, mpm@selenic.com, benh@kernel.crashing.org
Subject: [RFC][PATCH] new timeofday-based soft-timer subsystem
Message-ID: <20050429233546.GB2664@us.ibm.com>
References: <1114814747.28231.2.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114814747.28231.2.camel@cog.beaverton.ibm.com>
X-Operating-System: Linux 2.6.11 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* john stultz <johnstul@us.ibm.com> [2005-0429 15:45:47 -0700]:

> All,
>         This patch implements the architecture independent portion of
> the time of day subsystem. For a brief description on the rework, see
> here: http://lwn.net/Articles/120850/ (Many thanks to the LWN team for
> that clear writeup!)

I have been working closely with John to re-work the soft-timer subsytem
to use the new timeofday() subsystem. The following patch attempts to
being this process. I would greatly appreciate any comments.

Some design points:

1) The patch is small but does a lot.
	a) Renames timer_jiffies to last_timer_time (now that we are not
	jiffies-based).
	b) Converts the soft-timer time-vector's/bucket's entries to
	timerinterval (a new unit) width, instead of jiffy width.
	c) Defines timerintervals to be the current time as reported by
	the new timeofday-subsystem shifted down by 20 bits and masked
	to only grab the lower 32 bits. This effectively emulates a
	32-bit millisecond value.
	d) Uses do_monotonic_clock() (converted to timerintervals) as the
	basis for addition and expiration instead of jiffies.
	e) Adds some new helper functions for dealing with nanosecond
	values.

2) Currently, the patch is dependent upon John's timeofday core rework.
For arches that will not have the new timeofday (or for which the rework
is still in progress), I can emulate the existing system with a
separate patch. The goal of this patch, though, is just to show how easy
the new system can be implemented and the benefits.

3) The reason for the re-work?: Many people complain about all of the
adding of 1 jiffy here or there to fix bugs. This new systems is
fundamentally human-time oriented and deals with those issues correctly.

The code is reasonably well commented, but does expect readers to
understand the current system to some degree.

This is my first posting of this re-work, so I expect criticism, but am
happy to make changes.

Thanks,
Nish

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

diff -urpN 2.6.12-rc2-tod2/include/linux/jiffies.h 2.6.12-rc2-tod2-timer/include/linux/jiffies.h
--- 2.6.12-rc2-tod2/include/linux/jiffies.h	2005-04-04 09:37:51.000000000 -0700
+++ 2.6.12-rc2-tod2-timer/include/linux/jiffies.h	2005-04-29 23:04:47.000000000 -0700
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
diff -urpN 2.6.12-rc2-tod2/include/linux/sched.h 2.6.12-rc2-tod2-timer/include/linux/sched.h
--- 2.6.12-rc2-tod2/include/linux/sched.h	2005-04-29 23:16:59.000000000 -0700
+++ 2.6.12-rc2-tod2-timer/include/linux/sched.h	2005-04-29 23:04:47.000000000 -0700
@@ -182,7 +182,13 @@ extern void scheduler_tick(void);
 extern int in_sched_functions(unsigned long addr);
 
 #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
+#define	MAX_SCHEDULE_TIMEOUT_NSECS	((nsec_t)(-1))
+#define	MAX_SCHEDULE_TIMEOUT_MSECS	ULONG_MAX
+#define	MAX_SCHEDULE_TIMEOUT_USECS	UINT_MAX
 extern signed long FASTCALL(schedule_timeout(signed long timeout));
+extern nsec_t FASTCALL(schedule_timeout_nsecs(nsec_t timeout_nsecs));
+extern unsigned long FASTCALL(schedule_timeout_usecs(unsigned long timeout_usecs));
+extern unsigned int FASTCALL(schedule_timeout_msecs(unsigned int timeout_msesc));
 asmlinkage void schedule(void);
 
 struct namespace;
diff -urpN 2.6.12-rc2-tod2/include/linux/timer.h 2.6.12-rc2-tod2-timer/include/linux/timer.h
--- 2.6.12-rc2-tod2/include/linux/timer.h	2005-04-04 09:39:01.000000000 -0700
+++ 2.6.12-rc2-tod2-timer/include/linux/timer.h	2005-04-29 23:04:47.000000000 -0700
@@ -5,6 +5,7 @@
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/stddef.h>
+#include <linux/timeofday.h>
 
 struct tvec_t_base_s;
 
@@ -65,27 +66,11 @@ extern void add_timer_on(struct timer_li
 extern int del_timer(struct timer_list * timer);
 extern int __mod_timer(struct timer_list *timer, unsigned long expires);
 extern int mod_timer(struct timer_list *timer, unsigned long expires);
+extern void add_timer(struct timer_list *timer);
+extern int set_timer_nsecs(struct timer_list *timer, nsec_t expires_nsecs);
 
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
diff -urpN 2.6.12-rc2-tod2/kernel/timer.c 2.6.12-rc2-tod2-timer/kernel/timer.c
--- 2.6.12-rc2-tod2/kernel/timer.c	2005-04-29 23:16:52.000000000 -0700
+++ 2.6.12-rc2-tod2-timer/kernel/timer.c	2005-04-29 23:15:45.000000000 -0700
@@ -33,6 +33,7 @@
 #include <linux/posix-timers.h>
 #include <linux/cpu.h>
 #include <linux/syscalls.h>
+#include <linux/timeofday.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -40,6 +41,8 @@
 #include <asm/timex.h>
 #include <asm/io.h>
 
+#define TIMER_DBG 0
+
 #ifdef CONFIG_TIME_INTERPOLATION
 static void time_interpolator_update(long delta_nsec);
 #else
@@ -56,6 +59,9 @@ static void time_interpolator_update(lon
 #define TVR_SIZE (1 << TVR_BITS)
 #define TVN_MASK (TVN_SIZE - 1)
 #define TVR_MASK (TVR_SIZE - 1)
+#define TIMERINTERVAL_BITS 20
+#define TIMERINTERVAL_SIZE (1 << TIMERINTERVAL_BITS)
+#define TIMERINTERVAL_MASK (TIMERINTERVAL_SIZE - 1)
 
 typedef struct tvec_s {
 	struct list_head vec[TVN_SIZE];
@@ -67,7 +73,7 @@ typedef struct tvec_root_s {
 
 struct tvec_t_base_s {
 	spinlock_t lock;
-	unsigned long timer_jiffies;
+	unsigned long last_timer_time;
 	struct timer_list *running_timer;
 	tvec_root_t tv1;
 	tvec_t tv2;
@@ -113,11 +119,55 @@ static inline void check_timer(struct ti
 		check_timer_failed(timer);
 }
 
+/*
+ * nsecs_to_timerintervals - convert nsec value to soft-timer intervals
+ * @n: number of nanoseconds to convert
+ *
+ * This is "configurable" value, meaning it can be changed at compile-time
+ * and the soft-timer subsystem should change with it.
+ *
+ * Some explanation of the math is necessary:
+ * Currently we emulate milliseconds (but try to stay efficient)
+ * by dividing the nanosecond value by 2^20 (1048576 ~= 1000000)
+ * and masking it to an unsigned long
+ *
+ * To prevent timers from being expired early, we:
+ *	Take the ceiling when we add; and
+ *	Take the floor when we expire.
+ */
+static inline unsigned long nsecs_to_timerintervals_ceiling(nsec_t nsecs)
+{
+	return (unsigned long)((((nsecs - 1) >> TIMERINTERVAL_BITS) & ULONG_MAX) + 1);
+}
+
+static inline unsigned long nsecs_to_timerintervals_floor(nsec_t nsecs)
+{
+	return (unsigned long)((nsecs >> TIMERINTERVAL_BITS) & ULONG_MAX);
+}
+
+/*
+ * jiffies_to_timerintervals - convert absolute jiffies value to soft-timer intervals
+ * @abs_jiffies: number of jiffies to convert
+ *
+ * First, we convert the absolute jiffies parameter to a relative
+ * jiffies value. To maintain precision, we convert the relative
+ * jiffies value to a relative nanosecond value and then convert that
+ * to a relative soft-timer interval unit value. We then add this
+ * relative value to the current time according to the timeofday-
+ * subsystem, converted to soft-timer interval units.
+ *
+ */
+static inline unsigned long jiffies_to_timerintervals(unsigned long abs_jiffies)
+{
+	unsigned long relative_jiffies = abs_jiffies - jiffies;
+	return nsecs_to_timerintervals_ceiling(do_monotonic_clock()) +
+		nsecs_to_timerintervals_ceiling(jiffies_to_nsecs(relative_jiffies));
+}
 
 static void internal_add_timer(tvec_base_t *base, struct timer_list *timer)
 {
 	unsigned long expires = timer->expires;
-	unsigned long idx = expires - base->timer_jiffies;
+	unsigned long idx = expires - base->last_timer_time;
 	struct list_head *vec;
 
 	if (idx < TVR_SIZE) {
@@ -137,7 +187,7 @@ static void internal_add_timer(tvec_base
 		 * Can happen if you add a timer with expires == jiffies,
 		 * or you set a timer to go off in the past
 		 */
-		vec = base->tv1.vec + (base->timer_jiffies & TVR_MASK);
+		vec = base->tv1.vec + (base->last_timer_time & TVR_MASK);
 	} else {
 		int i;
 		/* If the timeout is larger than 0xffffffff on 64-bit
@@ -145,7 +195,7 @@ static void internal_add_timer(tvec_base
 		 */
 		if (idx > 0xffffffffUL) {
 			idx = 0xffffffffUL;
-			expires = idx + base->timer_jiffies;
+			expires = idx + base->last_timer_time;
 		}
 		i = (expires >> (TVR_BITS + 3 * TVN_BITS)) & TVN_MASK;
 		vec = base->tv5.vec + i;
@@ -238,11 +288,36 @@ void add_timer_on(struct timer_list *tim
 	check_timer(timer);
 
 	spin_lock_irqsave(&base->lock, flags);
+	timer->expires = jiffies_to_timerintervals(timer->expires);
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
+	__mod_timer(timer, jiffies_to_timerintervals(timer->expires));
+}
+
+EXPORT_SYMBOL(add_timer);
 
 /***
  * mod_timer - modify a timer's timeout
@@ -262,6 +337,10 @@ void add_timer_on(struct timer_list *tim
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
@@ -269,6 +348,7 @@ int mod_timer(struct timer_list *timer, 
 
 	check_timer(timer);
 
+	expires = jiffies_to_timerintervals(expires);
 	/*
 	 * This is a common optimization triggered by the
 	 * networking code - if the timer is re-modified
@@ -282,6 +362,29 @@ int mod_timer(struct timer_list *timer, 
 
 EXPORT_SYMBOL(mod_timer);
 
+/*
+ * set_timer_nsecs - modify a timer's timeout in nsecs
+ * @timer: the timer to be modified
+ *
+ * Do we want to modify via absolute nanoseconds instead of
+ * relative?
+ */
+int set_timer_nsecs(struct timer_list *timer, nsec_t expires_nsecs)
+{
+	unsigned long expires;
+
+	BUG_ON(!timer->function);
+
+	check_timer(timer);
+
+	expires = nsecs_to_timerintervals_ceiling(expires_nsecs);
+	if (timer_pending(timer) && timer->expires == expires)
+		return 1;
+
+	return __mod_timer(timer, expires);
+}
+EXPORT_SYMBOL_GPL(set_timer_nsecs);
+
 /***
  * del_timer - deactive a timer.
  * @timer: the timer to be deactivated
@@ -431,17 +534,17 @@ static int cascade(tvec_base_t *base, tv
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
@@ -451,7 +554,7 @@ static inline void __run_timers(tvec_bas
 				(!cascade(base, &base->tv3, INDEX(1))) &&
 					!cascade(base, &base->tv4, INDEX(2)))
 			cascade(base, &base->tv5, INDEX(3));
-		++base->timer_jiffies; 
+		++base->last_timer_time;
 		list_splice_init(base->tv1.vec + index, &work_list);
 repeat:
 		if (!list_empty(head)) {
@@ -500,20 +603,20 @@ unsigned long next_timer_interrupt(void)
 
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
@@ -890,10 +993,14 @@ EXPORT_SYMBOL(xtime_lock);
  */
 static void run_timer_softirq(struct softirq_action *h)
 {
+	unsigned long current_timer_time;
 	tvec_base_t *base = &__get_cpu_var(tvec_bases);
 
-	if (time_after_eq(jiffies, base->timer_jiffies))
-		__run_timers(base);
+	current_timer_time =
+		nsecs_to_timerintervals_floor(do_monotonic_clock());
+
+	if (time_after_eq(current_timer_time, base->last_timer_time))
+		__run_timers(base, current_timer_time);
 }
 
 /*
@@ -1133,6 +1240,69 @@ fastcall signed long __sched schedule_ti
 
 EXPORT_SYMBOL(schedule_timeout);
 
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
+fastcall unsigned long __sched schedule_timeout_usecs(unsigned long timeout_usecs)
+{
+	nsec_t timeout_nsecs;
+
+	if (timeout_usecs == MAX_SCHEDULE_TIMEOUT_USECS)
+		timeout_nsecs = MAX_SCHEDULE_TIMEOUT_NSECS;
+	else
+		timeout_nsecs = timeout_usecs * (nsec_t)1000UL;
+	timeout_nsecs = schedule_timeout_nsecs(timeout_nsecs) - 1;
+	do_div(timeout_nsecs, 1000UL);
+	timeout_usecs = (unsigned long)timeout_nsecs + 1UL;
+	return timeout_usecs;
+}
+
+EXPORT_SYMBOL_GPL(schedule_timeout_usecs);
+
+fastcall unsigned int __sched schedule_timeout_msecs(unsigned int timeout_msecs)
+{
+	nsec_t timeout_nsecs;
+
+	if (timeout_msecs == MAX_SCHEDULE_TIMEOUT_MSECS)
+		timeout_nsecs = MAX_SCHEDULE_TIMEOUT_NSECS;
+	else
+		timeout_nsecs = timeout_msecs * (nsec_t)1000000;
+	timeout_nsecs = schedule_timeout_nsecs(timeout_nsecs) - 1;
+	do_div(timeout_nsecs, 1000000UL);
+	timeout_msecs = (unsigned int)timeout_nsecs + 1;
+	return timeout_msecs;
+}
+
+EXPORT_SYMBOL_GPL(schedule_timeout_msecs);
+
 /* Thread ID - the internal kernel "pid" */
 asmlinkage long sys_gettid(void)
 {
@@ -1302,7 +1472,11 @@ static void __devinit init_timers_cpu(in
 	for (j = 0; j < TVR_SIZE; j++)
 		INIT_LIST_HEAD(base->tv1.vec + j);
 
-	base->timer_jiffies = jiffies;
+	/*
+	 * Under the new montonic_clock() oriented soft-timer subsystem,
+	 * we should begin at 0
+	 */
+	base->last_timer_time = 0UL;
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
