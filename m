Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbVK2Bfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbVK2Bfp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 20:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbVK2Bfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 20:35:31 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:17854 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932326AbVK2BfE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 20:35:04 -0500
Date: Tue, 29 Nov 2005 02:35:03 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] introduce ktime_t
Message-ID: <Pine.LNX.4.61.0511290234570.2788@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This introduce ktime_t to allow operations in nanosecond resolution.  The main
part of the patch is to convert itimer/posix-timer from jiffies to ktime_t.

Although time is now maintained at higher resolution timers still work with the
same resolution as jiffies, I tried to keep the behaviour as close as possible
to old the code. To better understand the conversion it may help to look at the
spec of timer_settime():

"Time values that are between two consecutive non-negative integer multiples of
the resolution of the specified timer shall be rounded up to the larger
multiple of the resolution."

This is maybe a bit hard to understand, but it's not imprecise. It describes a
generic timer model: time = offset + count * resolution. Timers work with
integer values and mostly don't have nanosecond resolution (although that's
slowly changing with GHz cpus), so they have to be converted somehow to
timespec values.  Applied to Linux this means, we have jiffies as a timer
counter and at every timer tick xtime is updated by the the resolution (let's
ignore ntp time correction for a moment, the basic model is still the same), so
it looks something like this:

jiffies	5	6	7	8	9	10	11
 ... ---+-------+-------+-------+-------+-------+-------+--- ...
xtime	12.3	12.4	12.5	12.6	12.7	12.8	12.9

If we have now a time value inbetween these timer values, we can either round
down or up to the previous or next valid timer value and all the spec is saying
is that we to round the value up. This is rather simple for absolute times,
e.g. for a timer set to 12.45, we only have to wait until jiffies reaches 7 and
the actual expiry time is rounded to 12.5. The rationale to the spec also
explains it simple with "a timer expiration signal is requested when the
associated clock reaches or exceeds the specified time".

For relative timers the rationale says "a timer expiration signal is requested
when the specified interval, as measured by the associated clock, has passed"
(the "as measured" part becomes important later).  Relative time values first
have to be converted to absolute values (it's possible to implement relative
timers as countdown timers, but that's not what Linux does, so let's ignore
this) and for this we first have to read the timer clock and here is an
important difference to normal time readings - we have to round up the time
value to the next resolution step to avoid an early expiry, as the normally
read value is already in the past.  Here we have a problem in Linux, we
basically have no function to do "get me the next time", so what this patch
does instead is to round up to next timer expiry value, instead of doing the
old "jiffies + 1" it does now "xtime + TICK_NSEC". It's possible to do better
than this, but coming clock abstractions have to provide an interface for this.
If the clock has a higher resolution than the timer, it's not always necessary
to wait an extra tick, e.g. if a timer is set to 0.05 and the next time is
12.62, the absolute time value is 12.67 and the actual expiry time is rounded
to 12.7.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 include/linux/ktime.h        |  239 +++++++++++++++++++++++++
 include/linux/posix-timers.h |   33 +--
 include/linux/ptimer.h       |    8 
 include/linux/sched.h        |    3 
 include/linux/time.h         |   27 ++
 kernel/fork.c                |    3 
 kernel/itimer.c              |   47 +++--
 kernel/posix-timers.c        |  401 ++++++++++++++++---------------------------
 kernel/ptimer.c              |   55 ++++-
 kernel/time.c                |   42 ++++
 10 files changed, 551 insertions(+), 307 deletions(-)

Index: linux-2.6-mm/include/linux/ktime.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-mm/include/linux/ktime.h	2005-11-29 01:03:10.000000000 +0100
@@ -0,0 +1,239 @@
+/*
+ *  ktime_t - nanosecond-resolution time format.
+ *
+ *   Copyright(C) 2005, Thomas Gleixner <tglx@linutronix.de>
+ *   Copyright(C) 2005, Red Hat, Inc., Ingo Molnar
+ *   Copyright(C) 2005, Roman Zippel <zippel@linux-m68k.org>
+ *
+ *  data type definitions, declarations, prototypes and macros.
+ *
+ *  Started by: Thomas Gleixner and Ingo Molnar
+ *
+ *  For licencing details see kernel-base/COPYING
+ */
+#ifndef _LINUX_KTIME_H
+#define _LINUX_KTIME_H
+
+#include <linux/time.h>
+#include <linux/jiffies.h>
+#include <asm/byteorder.h>
+
+/*
+ * ktime_t:
+ *
+ * On 64-bit CPUs a single 64-bit variable is used to store the ptimers
+ * internal representation of time values in scalar nanoseconds. The
+ * design plays out best on 64-bit CPUs, where most conversions are
+ * NOPs and most arithmetic ktime_t operations are plain arithmetic
+ * operations.
+ *
+ * On 32-bit CPUs an optimized representation of the timespec structure
+ * is used to avoid expensive conversions from and to timespecs. The
+ * endian-aware order of the tv struct members is choosen to allow
+ * mathematical operations on the tv64 member of the union too, which
+ * for certain operations produces better code.
+ *
+ * For architectures with efficient support for 64/32-bit conversions the
+ * plain scalar nanosecond based representation can be selected by the
+ * config switch CONFIG_KTIME_SCALAR.
+ */
+
+#define KTIME_ZERO			0
+#define KTIME_MAX			(~((u64)1 << 63))
+
+typedef union {
+	s64 tv64;
+#ifndef CONFIG_KTIME_SCALAR
+	struct {
+#ifdef __BIG_ENDIAN
+		s32 sec, nsec;
+#else
+		s32 nsec, sec;
+#endif
+	} tv;
+#endif
+} ktime_t;
+
+/*
+ * ktime_t definitions when using the 64-bit scalar representation:
+ */
+
+#ifdef CONFIG_KTIME_SCALAR
+
+/* Subtract two ktime_t variables. rem = lhs - rhs: */
+#define ktime_sub(lhs, rhs)		((ktime_t){ (lhs).tv64 - (rhs).tv64 })
+
+/* Add two ktime_t variables. res = lhs + rhs: */
+#define ktime_add(lhs, rhs)		((ktime_t){ (lhs).tv64 + (rhs).tv64 })
+
+/*
+ * Add a ktime_t variable and a scalar nanosecond value.
+ * res = kt + nsval:
+ */
+#define ktime_add_nsec(kt, nsval)	((ktime_t){ (kt).tv64 + (nsval) })
+
+/* convert a timespec to ktime_t format: */
+#define timespec_to_ktime(ts)		((ktime_t){ timespec_to_nsec(ts) })
+
+/* convert a timeval to ktime_t format: */
+#define timeval_to_ktime(tv)		((ktime_t){ timeval_to_nsec(tv) })
+
+/* Map the ktime_t to timespec conversion to the inline in time.h: */
+#define ktime_to_timespec(kt)		nsec_to_timespec((kt).tv64)
+
+/* Map the ktime_t to timeval conversion to the inline in time.h: */
+#define ktime_to_timeval(kt)		nsec_to_timeval((kt).tv64)
+
+/* Map the ktime_t to clock_t conversion to the inline in jiffies.h: */
+#define ktime_to_clock_t(kt)		nsec_to_clock_t((kt).tv64)
+
+/* Convert ktime_t to nanoseconds - NOP in the scalar storage format: */
+#define ktime_to_nsec(kt)		((kt).tv64)
+
+#define nsec_to_ktime(nsec)		((ktime_t){ (nsec) })
+
+#else
+
+/**
+ * ktime_sub - subtract two ktime_t variables
+ *
+ * @lhs:	minuend
+ * @rhs:	subtrahend
+ *
+ * Returns the remainder of the substraction
+ */
+static inline ktime_t ktime_sub(const ktime_t lhs, const ktime_t rhs)
+{
+	ktime_t res;
+
+	res.tv64 = lhs.tv64 - rhs.tv64;
+	if (res.tv.nsec < 0)
+		res.tv.nsec += NSEC_PER_SEC;
+
+	return res;
+}
+
+/**
+ * ktime_add - add two ktime_t variables
+ *
+ * @add1:	addend1
+ * @add2:	addend2
+ *
+ * Returns the sum of addend1 and addend2
+ */
+static inline ktime_t ktime_add(const ktime_t add1, const ktime_t add2)
+{
+	ktime_t res;
+
+	res.tv64 = add1.tv64 + add2.tv64;
+	/*
+	 * performance trick: the (u32) -NSEC gives 0x00000000Fxxxxxxx
+	 * so we subtract NSEC_PER_SEC and add 1 to the upper 32 bit.
+	 *
+	 * it's equivalent to:
+	 *   tv.nsec -= NSEC_PER_SEC
+	 *   tv.sec ++;
+	 */
+	if (res.tv.nsec >= NSEC_PER_SEC)
+		res.tv64 += (u32)-NSEC_PER_SEC;
+
+	return res;
+}
+
+/**
+ * ktime_add_nsec - Add a scalar nanoseconds value to a ktime_t variable
+ *
+ * @kt:		addend
+ * @nsec:	the scalar nsec value to add
+ *
+ * Returns the sum of kt and nsec in ktime_t format
+ */
+static inline ktime_t ktime_add_nsec(ktime_t kt, unsigned int nsec)
+{
+	ktime_t res;
+
+	res.tv64 = kt.tv64 + nsec;
+	if (res.tv.nsec >= NSEC_PER_SEC)
+		res.tv64 += (u32)-NSEC_PER_SEC;
+
+	return res;
+}
+
+/**
+ * timespec_to_ktime - convert a timespec to ktime_t format
+ *
+ * @ts:		the timespec variable to convert
+ *
+ * Returns a ktime_t variable with the converted timespec value
+ */
+static inline ktime_t timespec_to_ktime(struct timespec ts)
+{
+	return (ktime_t) { .tv.sec = (s32)ts.tv_sec,
+			   .tv.nsec = (s32)ts.tv_nsec };
+}
+
+/**
+ * ktime_to_timespec - convert a ktime_t variable to timespec format
+ *
+ * @kt:		the ktime_t variable to convert
+ *
+ * Returns a timespec variable with the converted value
+ */
+static inline struct timespec ktime_to_timespec(const ktime_t kt)
+{
+	return (struct timespec) { .tv_sec = (time_t) kt.tv.sec,
+				   .tv_nsec = (long) kt.tv.nsec };
+}
+
+/**
+ * ktime_to_timeval - convert a ktime_t variable to timeval format
+ * @kt:		the ktime_t variable to convert
+ *
+ * Returns a timeval variable with the converted value
+ */
+static inline struct timeval ktime_to_timeval(ktime_t kt)
+{
+	return (struct timeval)
+		{ .tv_sec = (time_t) kt.tv.sec,
+		  .tv_usec = (long) (kt.tv.nsec / NSEC_PER_USEC) };
+}
+
+static inline ktime_t timeval_to_ktime(struct timeval tv)
+{
+	return (ktime_t) { .tv.sec = tv.tv_sec,
+       			   .tv.nsec = tv.tv_usec * NSEC_PER_USEC };
+}
+
+/**
+ * ktime_to_clock_t - convert a ktime_t variable to clock_t format
+ * @kt:		the ktime_t variable to convert
+ *
+ * Returns a clock_t variable with the converted value
+ */
+static inline clock_t ktime_to_clock_t(ktime_t kt)
+{
+	return (u64)kt.tv.sec * USER_HZ + kt.tv.nsec / (NSEC_PER_SEC / USER_HZ);
+}
+
+/**
+ * ktime_to_nsec - convert a ktime_t variable to scalar nanoseconds
+ * @kt:		the ktime_t variable to convert
+ *
+ * Returns the scalar nanoseconds representation of kt
+ */
+static inline u64 ktime_to_nsec(ktime_t kt)
+{
+	return (u64) kt.tv.sec * NSEC_PER_SEC + kt.tv.nsec;
+}
+
+static inline ktime_t nsec_to_ktime(u64 nsec)
+{
+	ktime_t kt;
+	kt.tv.nsec = do_div(nsec, NSEC_PER_SEC);
+	kt.tv.sec = nsec;
+	return kt;
+}
+
+#endif
+
+#endif
Index: linux-2.6-mm/include/linux/posix-timers.h
===================================================================
--- linux-2.6-mm.orig/include/linux/posix-timers.h	2005-11-29 01:03:08.000000000 +0100
+++ linux-2.6-mm/include/linux/posix-timers.h	2005-11-29 01:03:10.000000000 +0100
@@ -54,8 +54,8 @@ struct k_itimer {
 		struct {
 			struct ptimer timer;
 			struct list_head abs_timer_entry; /* clock abs_timer_list */
-			struct timespec wall_to_prev;   /* wall_to_monotonic used when set */
-			unsigned long incr; /* interval in jiffies */
+			ktime_t wall_to_prev;   /* wall_to_monotonic used when set */
+			ktime_t incr;	/* interval */
 		} real;
 		struct cpu_timer_list cpu;
 		struct {
@@ -99,24 +99,21 @@ int do_posix_clock_nosettime(clockid_t, 
 int posix_timer_event(struct k_itimer *timr, int si_private);
 
 struct now_struct {
-	unsigned long jiffies;
+	ktime_t now, to_mono;
 };
 
-#define posix_get_now(now) (now)->jiffies = jiffies;
-#define posix_time_before(timer, now) \
-                      time_before((timer)->expires, (now)->jiffies)
-
-#define posix_bump_timer(timr, now)					\
-         do {								\
-              long delta, orun;						\
-	      delta = now.jiffies - (timr)->it.real.timer.expires;	\
-              if (delta >= 0) {						\
-	           orun = 1 + (delta / (timr)->it.real.incr);		\
-	          (timr)->it.real.timer.expires +=			\
-			 orun * (timr)->it.real.incr;			\
-                  (timr)->it_overrun += orun;				\
-              }								\
-            }while (0)
+static inline void posix_get_now(clock_t clock, struct now_struct *now)
+{
+	unsigned long seq;
+
+	do {
+		seq = read_seqbegin(&xtime_lock);
+		now->now = timespec_to_ktime(xtime);
+		now->to_mono = timespec_to_ktime(wall_to_monotonic);
+	} while (read_seqretry(&xtime_lock, seq));
+	if (clock == CLOCK_MONOTONIC)
+		now->now = ktime_add(now->now, now->to_mono);
+}
 
 int posix_cpu_clock_getres(clockid_t which_clock, struct timespec *);
 int posix_cpu_clock_get(clockid_t which_clock, struct timespec *);
Index: linux-2.6-mm/include/linux/ptimer.h
===================================================================
--- linux-2.6-mm.orig/include/linux/ptimer.h	2005-11-29 01:03:08.000000000 +0100
+++ linux-2.6-mm/include/linux/ptimer.h	2005-11-29 01:03:10.000000000 +0100
@@ -16,6 +16,7 @@
 #define _LINUX_PTIMER_H
 
 #include <linux/rbtree.h>
+#include <linux/ktime.h>
 #include <linux/wait.h>
 
 struct ptimer_base {
@@ -24,19 +25,20 @@ struct ptimer_base {
 	struct rb_root root;
 	struct rb_node *first_node;
 	struct ptimer *running_timer;
-	unsigned long last_expired;
+	unsigned long last_jiffies;
+	ktime_t last_expired;
 };
 
 struct ptimer {
 	struct ptimer_base *base;
 	struct rb_node node;
-	unsigned long expires;
+	ktime_t expires;
 	int (*function)(struct ptimer *);
 };
 
 extern void ptimer_init(struct ptimer *timer, int base);
 extern void ptimer_start(struct ptimer *timer);
-extern void ptimer_modify(struct ptimer *timer, unsigned long);
+extern void ptimer_modify(struct ptimer *timer, ktime_t);
 extern int ptimer_stop(struct ptimer *timer);
 extern int ptimer_try_to_stop(struct ptimer *timer);
 
Index: linux-2.6-mm/include/linux/sched.h
===================================================================
--- linux-2.6-mm.orig/include/linux/sched.h	2005-11-29 01:03:08.000000000 +0100
+++ linux-2.6-mm/include/linux/sched.h	2005-11-29 01:03:10.000000000 +0100
@@ -405,7 +405,8 @@ struct signal_struct {
 	/* ITIMER_REAL timer for the process */
 	struct ptimer real_timer;
 	struct task_struct *tsk;
-	unsigned long it_real_value, it_real_incr;
+	unsigned long it_real_value;
+	ktime_t it_real_incr;
 
 	/* ITIMER_PROF and ITIMER_VIRTUAL timers for the process */
 	cputime_t it_prof_expires, it_virt_expires;
Index: linux-2.6-mm/include/linux/time.h
===================================================================
--- linux-2.6-mm.orig/include/linux/time.h	2005-11-29 00:57:58.000000000 +0100
+++ linux-2.6-mm/include/linux/time.h	2005-11-29 01:03:10.000000000 +0100
@@ -113,6 +113,33 @@ set_normalized_timespec (struct timespec
 	ts->tv_nsec = nsec;
 }
 
+/**
+ * timespec_to_ns - Convert timespec to nanoseconds
+ * @ts:		timespec variable to be converted
+ *
+ * Returns the scalar nanosecond representation of the timespec
+ * variable
+ */
+static inline s64 timespec_to_nsec(struct timespec ts)
+{
+	return (s64)ts.tv_sec * NSEC_PER_SEC + ts.tv_nsec;
+}
+
+/**
+ * timeval_to_ns - Convert timeval to nanoseconds
+ * @tv:		timeval variable to be converted
+ *
+ * Returns the scalar nanosecond representation of the timeval
+ * variable
+ */
+static inline s64 timeval_to_nsec(struct timeval tv)
+{
+	return (s64)tv.tv_sec * NSEC_PER_SEC + tv.tv_usec * NSEC_PER_USEC;
+}
+
+extern struct timespec nsec_to_timespec(s64 nsec);
+extern struct timeval nsec_to_timeval(s64 nsec);
+
 #endif /* __KERNEL__ */
 
 #define NFDBITS			__NFDBITS
Index: linux-2.6-mm/kernel/fork.c
===================================================================
--- linux-2.6-mm.orig/kernel/fork.c	2005-11-29 01:03:09.000000000 +0100
+++ linux-2.6-mm/kernel/fork.c	2005-11-29 01:03:10.000000000 +0100
@@ -794,7 +794,8 @@ static inline int copy_signal(unsigned l
 	init_sigpending(&sig->shared_pending);
 	INIT_LIST_HEAD(&sig->posix_timers);
 
-	sig->it_real_value = sig->it_real_incr = 0;
+	sig->it_real_value = 0;
+	sig->it_real_incr.tv64 = KTIME_ZERO;
 	ptimer_init(&sig->real_timer, CLOCK_MONOTONIC);
 	sig->real_timer.function = it_real_fn;
 	sig->tsk = tsk;
Index: linux-2.6-mm/kernel/itimer.c
===================================================================
--- linux-2.6-mm.orig/kernel/itimer.c	2005-11-29 01:03:09.000000000 +0100
+++ linux-2.6-mm/kernel/itimer.c	2005-11-29 01:03:10.000000000 +0100
@@ -15,15 +15,20 @@
 
 #include <asm/uaccess.h>
 
-static unsigned long it_real_value(struct signal_struct *sig)
+static ktime_t it_real_value(struct signal_struct *sig)
 {
-	unsigned long val = 0;
+	ktime_t val;
+
+	val.tv64 = KTIME_ZERO;
 	if (ptimer_active(&sig->real_timer)) {
-		val = sig->real_timer.expires - jiffies;
+		struct now_struct now;
+
+		posix_get_now(CLOCK_MONOTONIC, &now);
+		val = ktime_sub(sig->real_timer.expires, now.now);
 
 		/* look out for negative/zero itimer.. */
-		if ((long) val <= 0)
-			val = 1;
+		if (val.tv64 <= KTIME_ZERO)
+			val = nsec_to_ktime(1);
 	}
 	return val;
 }
@@ -31,7 +36,7 @@ static unsigned long it_real_value(struc
 int do_getitimer(int which, struct itimerval *value)
 {
 	struct task_struct *tsk = current;
-	unsigned long interval, val;
+	ktime_t interval, val;
 	cputime_t cinterval, cval;
 
 	switch (which) {
@@ -40,8 +45,8 @@ int do_getitimer(int which, struct itime
 		interval = tsk->signal->it_real_incr;
 		val = it_real_value(tsk->signal);
 		spin_unlock_irq(&tsk->sighand->siglock);
-		jiffies_to_timeval(val, &value->it_value);
-		jiffies_to_timeval(interval, &value->it_interval);
+		value->it_value = ktime_to_timeval(val);
+		value->it_interval = ktime_to_timeval(interval);
 		break;
 	case ITIMER_VIRTUAL:
 		read_lock(&tasklist_lock);
@@ -116,7 +121,6 @@ asmlinkage long sys_getitimer(int which,
 int it_real_fn(struct ptimer *timer)
 {
 	struct signal_struct *sig = container_of(timer, struct signal_struct, real_timer);
-	unsigned long inc = sig->it_real_incr;
 
 	send_group_sig_info(SIGALRM, SEND_SIG_PRIV, sig->tsk);
 
@@ -130,16 +134,16 @@ int it_real_fn(struct ptimer *timer)
 	 * Deal with requesting a time prior to "now" here rather than
 	 * in add_timer.
 	 */
-	if (!inc)
+	if (sig->it_real_incr.tv64 == KTIME_ZERO)
 		return 0;
-	sig->real_timer.expires += inc;
+	sig->real_timer.expires = ktime_add(timer->base->last_expired, sig->it_real_incr);
 	return 1;
 }
 
 int do_setitimer(int which, struct itimerval *value, struct itimerval *ovalue)
 {
 	struct task_struct *tsk = current;
- 	unsigned long val, interval, expires;
+	ktime_t val, interval, expires;
 	cputime_t cval, cinterval, nval, ninterval;
 
 	switch (which) {
@@ -154,16 +158,21 @@ again:
 			goto again;
 		}
 		tsk->signal->it_real_incr =
-			timeval_to_jiffies(&value->it_interval);
-		expires = timeval_to_jiffies(&value->it_value);
-		if (expires)
+			timeval_to_ktime(value->it_interval);
+		expires = timeval_to_ktime(value->it_value);
+		if (expires.tv64 != KTIME_ZERO) {
+			struct now_struct now;
+
+			posix_get_now(CLOCK_MONOTONIC, &now);
+			now.now = ktime_add_nsec(now.now, TICK_NSEC);
+			expires = ktime_add(now.now, expires);
 			ptimer_modify(&tsk->signal->real_timer,
-				      jiffies + 1 + expires);
+				      expires);
+		}
 		spin_unlock_irq(&tsk->sighand->siglock);
 		if (ovalue) {
-			jiffies_to_timeval(val, &ovalue->it_value);
-			jiffies_to_timeval(interval,
-					   &ovalue->it_interval);
+			ovalue->it_value = ktime_to_timeval(val);
+			ovalue->it_interval = ktime_to_timeval(interval);
 		}
 		break;
 	case ITIMER_VIRTUAL:
Index: linux-2.6-mm/kernel/posix-timers.c
===================================================================
--- linux-2.6-mm.orig/kernel/posix-timers.c	2005-11-29 01:03:09.000000000 +0100
+++ linux-2.6-mm/kernel/posix-timers.c	2005-11-29 01:03:10.000000000 +0100
@@ -31,13 +31,9 @@
  * POSIX clocks & timers
  */
 #include <linux/mm.h>
-#include <linux/smp_lock.h>
 #include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/time.h>
-
-#include <asm/uaccess.h>
-#include <asm/semaphore.h>
 #include <linux/list.h>
 #include <linux/init.h>
 #include <linux/compiler.h>
@@ -48,15 +44,9 @@
 #include <linux/workqueue.h>
 #include <linux/module.h>
 
-#ifndef div_long_long_rem
+#include <asm/uaccess.h>
 #include <asm/div64.h>
 
-#define div_long_long_rem(dividend,divisor,remainder) ({ \
-		       u64 result = dividend;		\
-		       *remainder = do_div(result,divisor); \
-		       result; })
-
-#endif
 #define CLOCK_REALTIME_RES TICK_NSEC  /* In nano seconds. */
 
 static inline u64  mpy_l_X_l_ll(unsigned long mpy1,unsigned long mpy2)
@@ -156,8 +146,8 @@ static struct k_clock_abs abs_list = {.l
 				      .lock = SPIN_LOCK_UNLOCKED};
 
 static int posix_timer_fn(struct ptimer *timer);
-static u64 do_posix_clock_monotonic_gettime_parts(
-	struct timespec *tp, struct timespec *mo);
+static void do_posix_clock_monotonic_gettime_parts(struct timespec *tp,
+						   struct timespec *mo);
 int do_posix_clock_monotonic_gettime(struct timespec *tp);
 static int do_posix_clock_monotonic_get(clockid_t, struct timespec *tp);
 
@@ -264,25 +254,20 @@ static __init int init_posix_timers(void
 
 __initcall(init_posix_timers);
 
-static void tstojiffie(struct timespec *tp, int res, u64 *jiff)
+static u64 ktime_to_jiffie(const ktime_t time, int res)
 {
-	long sec = tp->tv_sec;
-	long nsec = tp->tv_nsec + res - 1;
-
-	if (nsec >= NSEC_PER_SEC) {
-		sec++;
-		nsec -= NSEC_PER_SEC;
-	}
+	struct timespec ts;
 
+	ts = ktime_to_timespec(ktime_add_nsec(time, res));
 	/*
 	 * The scaling constants are defined in <linux/time.h>
 	 * The difference between there and here is that we do the
 	 * res rounding and compute a 64-bit result (well so does that
 	 * but it then throws away the high bits).
-  	 */
-	*jiff =  (mpy_l_X_l_ll(sec, SEC_CONVERSION) +
-		  (mpy_l_X_l_ll(nsec, NSEC_CONVERSION) >> 
-		   (NSEC_JIFFIE_SC - SEC_JIFFIE_SC))) >> SEC_JIFFIE_SC;
+	 */
+	return (mpy_l_X_l_ll(ts.tv_sec, SEC_CONVERSION) +
+		(mpy_l_X_l_ll(ts.tv_nsec, NSEC_CONVERSION) >>
+		 (NSEC_JIFFIE_SC - SEC_JIFFIE_SC))) >> SEC_JIFFIE_SC;
 }
 
 /*
@@ -298,29 +283,15 @@ static void tstojiffie(struct timespec *
  * Return is true if there is a new time, else false.
  */
 static long add_clockset_delta(struct k_itimer *timr,
-			       struct timespec *new_wall_to)
+			       ktime_t new_wall_to)
 {
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
+	ktime_t delta;
+
+	delta = ktime_sub(new_wall_to, timr->it.real.wall_to_prev);
+	if (delta.tv64 == KTIME_ZERO)
 		return 0;
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
+	timr->it.real.wall_to_prev = new_wall_to;
+	timr->it.real.timer.expires = ktime_add(timr->it.real.timer.expires, delta);
 	return 1;
 }
 
@@ -333,11 +304,26 @@ static void remove_from_abslist(struct k
 	}
 }
 
+static void posix_advance_timer(struct k_itimer *timr, ktime_t now)
+{
+	ktime_t t;
+	u64 j;
+	unsigned long i, rem;
+
+	if (now.tv64 < timr->it.real.timer.expires.tv64)
+		return;
+	t = ktime_sub(now, timr->it.real.timer.expires);
+	i = ktime_to_jiffie(timr->it.real.incr, TICK_NSEC);
+	j = ktime_to_jiffie(t, 0);
+	rem = do_div(j, i);
+	timr->it_overrun += j + 1;
+	t = nsec_to_ktime((u64)(i - rem) * TICK_NSEC);
+	timr->it.real.timer.expires = ktime_add(now, t);
+}
+
 static int schedule_next_timer(struct k_itimer *timr)
 {
-	struct timespec new_wall_to;
 	struct now_struct now;
-	unsigned long seq;
 
 	/*
 	 * Set up the timer for the next interval (if there is one).
@@ -352,24 +338,20 @@ static int schedule_next_timer(struct k_
 	 * "other" CLOCKs "next timer" code (which, I suppose should
 	 * also be added to the k_clock structure).
 	 */
-	if (!timr->it.real.incr)
+	if (timr->it.real.incr.tv64 == KTIME_ZERO)
 		return 0;
 
-	do {
-		seq = read_seqbegin(&xtime_lock);
-		new_wall_to =	wall_to_monotonic;
-		posix_get_now(&now);
-	} while (read_seqretry(&xtime_lock, seq));
+	posix_get_now(CLOCK_MONOTONIC, &now);
 
 	if (!list_empty(&timr->it.real.abs_timer_entry)) {
 		spin_lock(&abs_list.lock);
-		add_clockset_delta(timr, &new_wall_to);
+		add_clockset_delta(timr, now.to_mono);
 
-		posix_bump_timer(timr, now);
+		posix_advance_timer(timr, now.now);
 
 		spin_unlock(&abs_list.lock);
 	} else {
-		posix_bump_timer(timr, now);
+		posix_advance_timer(timr, now.now);
 	}
 	timr->it_overrun--;
 	return 1;
@@ -463,34 +445,17 @@ static int posix_timer_fn(struct ptimer 
 {
 	struct k_itimer *timr = container_of(timer, struct k_itimer, it.real.timer);
 	unsigned long flags;
-	unsigned long seq;
-	struct timespec delta, new_wall_to;
-	u64 exp = 0;
 	int do_restart = 0;
 
 	spin_lock_irqsave(&timr->it_lock, flags);
 	if (!list_empty(&timr->it.real.abs_timer_entry)) {
+		struct now_struct now;
+
 		spin_lock(&abs_list.lock);
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
+		posix_get_now(CLOCK_MONOTONIC, &now);
+		add_clockset_delta(timr, now.to_mono);
+		if (now.now.tv64 < timr->it.real.timer.expires.tv64) {
 			/* timer is early due to a clock set */
-			tstojiffie(&delta,
-				   posix_clocks[timr->it_clock].res,
-				   &exp);
-			timr->it.real.wall_to_prev = new_wall_to;
-			timr->it.real.timer.expires += exp;
 			spin_unlock(&abs_list.lock);
 			do_restart = 1;
 			goto exit;
@@ -505,8 +470,9 @@ static int posix_timer_fn(struct ptimer 
 			timr->it_requeue_pending = 0;
 			timr->it_overrun++;
 		}
-		if (timr->it.real.incr) {
-			timr->it.real.timer.expires += timr->it.real.incr;
+		if (timr->it.real.incr.tv64 != KTIME_ZERO) {
+			timer->expires = ktime_add(timer->base->last_expired,
+						   timr->it.real.incr);
 			do_restart = 1;
 		}
 	} else {
@@ -782,34 +748,21 @@ static struct k_itimer * lock_timer(time
 static void
 common_timer_get(struct k_itimer *timr, struct itimerspec *cur_setting)
 {
-	unsigned long expires;
+	ktime_t expires;
 	struct now_struct now;
 
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
-		if (timr->it_requeue_pending > 1 ||
-		    (timr->it_sigev_notify & ~SIGEV_THREAD_ID) == SIGEV_NONE) {
-			posix_bump_timer(timr, now);
-			expires = timr->it.real.timer.expires;
-		}
-		else
-			if (!ptimer_active(&timr->it.real.timer))
-				expires = 0;
-		if (expires)
-			expires -= now.jiffies;
+	expires = timr->it.real.timer.expires;
+
+	posix_get_now(CLOCK_MONOTONIC, &now);
+
+	if (ptimer_active(&timr->it.real.timer)) {
+		expires = ktime_sub(timr->it.real.timer.expires, now.now);
+	} else if (timr->it_requeue_pending) {
+		posix_advance_timer(timr, now.now);
+		expires = ktime_sub(timr->it.real.timer.expires, now.now);
 	}
-	jiffies_to_timespec(expires, &cur_setting->it_value);
-	jiffies_to_timespec(timr->it.real.incr, &cur_setting->it_interval);
+	cur_setting->it_value = ktime_to_timespec(expires);
+	cur_setting->it_interval = ktime_to_timespec(timr->it.real.incr);
 
 	if (cur_setting->it_value.tv_sec < 0) {
 		cur_setting->it_value.tv_nsec = 1;
@@ -874,72 +827,23 @@ sys_timer_getoverrun(timer_t timer_id)
  * If it is relative time, we need to add the current (CLOCK_MONOTONIC)
  * time to it to get the proper time for the timer.
  */
-static int adjust_abs_time(struct k_clock *clock, struct timespec *tp, 
-			   int abs, u64 *exp, struct timespec *wall_to)
+static int adjust_abs_time(struct k_clock *clock, struct timespec *tp,
+			   int abs, struct ptimer *timer, ktime_t *to_mono)
 {
-	struct timespec now;
-	struct timespec oc = *tp;
-	u64 jiffies_64_f;
-	int rtn =0;
+	struct now_struct now;
+	int rtn = 0;
 
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
+	timer->expires = timespec_to_ktime(*tp);
+	if (!abs) {
+		posix_get_now(CLOCK_MONOTONIC, &now);
+		now.now = ktime_add_nsec(now.now, clock->res);
+		timer->expires = ktime_add(now.now, timer->expires);
+	} else if ((clock - posix_clocks) == CLOCK_REALTIME) {
+		posix_get_now(CLOCK_MONOTONIC, &now);
+		if (to_mono)
+			*to_mono = now.to_mono;
+		timer->expires = ktime_add(timer->expires, now.to_mono);
 	}
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
 	return rtn;
 }
 
@@ -950,30 +854,18 @@ common_timer_set(struct k_itimer *timr, 
 		 struct itimerspec *new_setting, struct itimerspec *old_setting)
 {
 	struct k_clock *clock = &posix_clocks[timr->it_clock];
-	u64 expire_64;
 
 	if (old_setting)
 		common_timer_get(timr, old_setting);
 
 	/* disable the timer */
-	timr->it.real.incr = 0;
+	timr->it.real.incr.tv64 = KTIME_ZERO;
 	/*
 	 * careful here.  If smp we could be in the "fire" routine which will
 	 * be spinning as we hold the lock.  But this is ONLY an SMP issue.
 	 */
-	if (ptimer_try_to_stop(&timr->it.real.timer) < 0) {
-#ifdef CONFIG_SMP
-		/*
-		 * It can only be active if on an other cpu.  Since
-		 * we have cleared the interval stuff above, it should
-		 * clear once we release the spin lock.  Of course once
-		 * we do that anything could happen, including the
-		 * complete melt down of the timer.  So return with
-		 * a "retry" exit status.
-		 */
+	if (ptimer_try_to_stop(&timr->it.real.timer) < 0)
 		return TIMER_RETRY;
-#endif
-	}
 
 	remove_from_abslist(timr);
 
@@ -984,18 +876,16 @@ common_timer_set(struct k_itimer *timr, 
 	 *switch off the timer when it_value is zero
 	 */
 	if (!new_setting->it_value.tv_sec && !new_setting->it_value.tv_nsec) {
-		timr->it.real.timer.expires = 0;
+		timr->it.real.timer.expires.tv64 = KTIME_ZERO;
 		return 0;
 	}
 
-	if (adjust_abs_time(clock,
-			    &new_setting->it_value, flags & TIMER_ABSTIME, 
-			    &expire_64, &(timr->it.real.wall_to_prev))) {
+	if (adjust_abs_time(clock, &new_setting->it_value,
+			    flags & TIMER_ABSTIME, &timr->it.real.timer,
+			    &timr->it.real.wall_to_prev))
 		return -EINVAL;
-	}
-	timr->it.real.timer.expires = (unsigned long)expire_64;
-	tstojiffie(&new_setting->it_interval, clock->res, &expire_64);
-	timr->it.real.incr = (unsigned long)expire_64;
+
+	timr->it.real.incr = timespec_to_ktime(new_setting->it_interval);
 
 	/*
 	 * We do not even queue SIGEV_NONE timers!  But we do put them
@@ -1057,7 +947,7 @@ retry:
 
 static inline int common_timer_del(struct k_itimer *timer)
 {
-	timer->it.real.incr = 0;
+	timer->it.real.incr.tv64 = KTIME_ZERO;
 
 	if (ptimer_try_to_stop(&timer->it.real.timer) < 0) {
 #ifdef CONFIG_SMP
@@ -1191,21 +1081,17 @@ void exit_itimers(struct signal_struct *
  *
  */
 
-static u64 do_posix_clock_monotonic_gettime_parts(
-	struct timespec *tp, struct timespec *mo)
+static void do_posix_clock_monotonic_gettime_parts(struct timespec *tp,
+						   struct timespec *mo)
 {
-	u64 jiff;
 	unsigned int seq;
 
 	do {
 		seq = read_seqbegin(&xtime_lock);
 		getnstimeofday(tp);
 		*mo = wall_to_monotonic;
-		jiff = jiffies_64;
 
 	} while(read_seqretry(&xtime_lock, seq));
-
-	return jiff;
 }
 
 static int do_posix_clock_monotonic_get(clockid_t clock, struct timespec *tp)
@@ -1296,6 +1182,20 @@ sys_clock_getres(clockid_t which_clock, 
 	return error;
 }
 
+struct nsleep_timer {
+	struct ptimer timer;
+	struct task_struct *task;
+	int done;
+};
+
+static int nanosleep_wake_up(struct ptimer *ptimer)
+{
+	struct nsleep_timer *timer = container_of(ptimer, struct nsleep_timer, timer);
+	timer->done = 1;
+	wake_up_process(timer->task);
+	return 0;
+}
+
 /*
  * The standard says that an absolute nanosleep call MUST wake up at
  * the requested time in spite of clock settings.  Here is what we do:
@@ -1322,7 +1222,7 @@ static DECLARE_MUTEX(clock_was_set_lock)
 void clock_was_set(void)
 {
 	struct k_itimer *timr;
-	struct timespec new_wall_to;
+	ktime_t new_wall_to;
 	LIST_HEAD(cws_list);
 	unsigned long seq;
 
@@ -1375,7 +1275,7 @@ void clock_was_set(void)
 	do {
 		do {
 			seq = read_seqbegin(&xtime_lock);
-			new_wall_to =	wall_to_monotonic;
+			new_wall_to = timespec_to_ktime(wall_to_monotonic);
 		} while (read_seqretry(&xtime_lock, seq));
 
 		spin_lock_irq(&abs_list.lock);
@@ -1387,7 +1287,7 @@ void clock_was_set(void)
 				  it.real.abs_timer_entry);
 
 		list_del_init(&timr->it.real.abs_timer_entry);
-		if (add_clockset_delta(timr, &new_wall_to) &&
+		if (add_clockset_delta(timr, new_wall_to) &&
 		    ptimer_stop(&timr->it.real.timer))  /* timer run yet? */
 			ptimer_start(&timr->it.real.timer);
 		list_add(&timr->it.real.abs_timer_entry, &abs_list.list);
@@ -1435,15 +1335,19 @@ sys_clock_nanosleep(clockid_t which_cloc
 static int common_nsleep(clockid_t which_clock,
 			 int flags, struct timespec *tsave)
 {
-	struct timespec t, dum;
+	struct timespec t;
+	struct nsleep_timer timer;
+	struct now_struct now;
 	DECLARE_WAITQUEUE(abs_wqueue, current);
-	u64 rq_time = (u64)0;
-	s64 left;
 	int abs;
 	struct restart_block *restart_block =
 	    &current_thread_info()->restart_block;
 
 	abs_wqueue.flags = 0;
+	ptimer_init(&timer.timer, CLOCK_MONOTONIC);
+	timer.timer.function = nanosleep_wake_up;
+	timer.task = current;
+	timer.done = 0;
 	abs = flags & TIMER_ABSTIME;
 
 	if (restart_block->fn == clock_nanosleep_restart) {
@@ -1453,13 +1357,8 @@ static int common_nsleep(clockid_t which
 		 */
 		restart_block->fn = do_no_restart_syscall;
 
-		rq_time = restart_block->arg3;
-		rq_time = (rq_time << 32) + restart_block->arg2;
-		if (!rq_time)
-			return -EINTR;
-		left = rq_time - get_jiffies_64();
-		if (left <= (s64)0)
-			return 0;	/* Already passed */
+		timer.timer.expires.tv64 = (s64)restart_block->arg3 << 32;
+		timer.timer.expires.tv64 += restart_block->arg2;
 	}
 
 	if (abs && (posix_clocks[which_clock].clock_get !=
@@ -1468,59 +1367,59 @@ static int common_nsleep(clockid_t which
 
 	do {
 		t = *tsave;
-		if (abs || !rq_time) {
-			adjust_abs_time(&posix_clocks[which_clock], &t, abs,
-					&rq_time, &dum);
+		if (abs || timer.timer.expires.tv64 == KTIME_ZERO) {
+			adjust_abs_time(&posix_clocks[which_clock], &t,
+					abs, &timer.timer, NULL);
 		}
 
-		left = rq_time - get_jiffies_64();
-		if (left >= (s64)MAX_JIFFY_OFFSET)
-			left = (s64)MAX_JIFFY_OFFSET;
-		if (left < (s64)0)
+		posix_get_now(CLOCK_MONOTONIC, &now);
+		if (now.now.tv64 > timer.timer.expires.tv64) {
+			timer.done = 1;
 			break;
+		}
+
+		ptimer_start(&timer.timer);
 
-		schedule_timeout_interruptible(left);
+		schedule();
 
-		left = rq_time - get_jiffies_64();
-	} while (left > (s64)0 && !test_thread_flag(TIF_SIGPENDING));
+		ptimer_stop(&timer.timer);
+	} while (!signal_pending(current));
 
 	if (abs_wqueue.task_list.next)
 		finish_wait(&nanosleep_abs_wqueue, &abs_wqueue);
 
-	if (left > (s64)0) {
+	if (timer.done)
+		return 0;
 
-		/*
-		 * Always restart abs calls from scratch to pick up any
-		 * clock shifting that happened while we are away.
-		 */
-		if (abs)
-			return -ERESTARTNOHAND;
+	/*
+	 * Always restart abs calls from scratch to pick up any
+	 * clock shifting that happened while we are away.
+	 */
+	if (abs)
+		return -ERESTARTNOHAND;
 
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
+	/*
+	 * Restart works by saving the time remaing in
+	 * arg2 & 3 (it is 64-bits of jiffies).  The other
+	 * info we need is the clock_id (saved in arg0).
+	 * The sys_call interface needs the users
+	 * timespec return address which _it_ saves in arg1.
+	 * Since we have cast the nanosleep call to a clock_nanosleep
+	 * both can be restarted with the same code.
+	 */
+	restart_block->fn = clock_nanosleep_restart;
+	restart_block->arg0 = which_clock;
+	/*
+	 * Caller sets arg1
+	 */
+	restart_block->arg2 = timer.timer.expires.tv64 & 0xffffffffLL;
+	restart_block->arg3 = timer.timer.expires.tv64 >> 32;
 
-		return -ERESTART_RESTARTBLOCK;
-	}
+	posix_get_now(CLOCK_MONOTONIC, &now);
+	now.now = ktime_sub(timer.timer.expires, now.now);
+	*tsave = ktime_to_timespec(now.now);
 
-	return 0;
+	return -ERESTART_RESTARTBLOCK;
 }
 /*
  * This will restart clock_nanosleep.
Index: linux-2.6-mm/kernel/ptimer.c
===================================================================
--- linux-2.6-mm.orig/kernel/ptimer.c	2005-11-29 01:03:09.000000000 +0100
+++ linux-2.6-mm/kernel/ptimer.c	2005-11-29 01:03:10.000000000 +0100
@@ -31,6 +31,10 @@
 #include <linux/spinlock.h>
 #include <linux/wait.h>
 
+#if (BITS_PER_LONG == 64) && !defined(CONFIG_KTIME_SCALAR)
+#warning define KTIME_SCALAR in Kconfig
+#endif
+
 #define PTIMER_INACTIVE	((void *)1)
 
 #define MAX_PTIMER_BASES       2
@@ -82,7 +86,7 @@ static void ptimer_enqueue(struct ptimer
 
 	if (!parent)
 		base->first_node = &timer->node;
-	else if (time_before(timer->expires, entry->expires)) {
+	else if (timer->expires.tv64 < entry->expires.tv64) {
 		link = &parent->rb_left;
 		base->first_node = &timer->node;
 	} else {
@@ -93,7 +97,7 @@ static void ptimer_enqueue(struct ptimer
 			 * We dont care about collisions. Nodes with
 			 * the same expiry time stay together.
 			 */
-			if (time_before(timer->expires, entry->expires))
+			if (timer->expires.tv64 < entry->expires.tv64)
 				link = &parent->rb_left;
 			else
 				link = &parent->rb_right;
@@ -141,7 +145,7 @@ void ptimer_start(struct ptimer *timer)
  *
  * @timer:	the timer to be modified
  */
-void ptimer_modify(struct ptimer *timer, unsigned long expires)
+void ptimer_modify(struct ptimer *timer, ktime_t expires)
 {
 	struct ptimer_base *base, *new_base;
 	unsigned long flags;
@@ -227,7 +231,7 @@ static inline void ptimer_run_queue(stru
 {
 	struct ptimer *timer;
 	struct rb_node *node;
-	unsigned long now;
+	ktime_t now;
 	int res;
 
 	spin_lock(&base->lock);
@@ -235,7 +239,7 @@ static inline void ptimer_run_queue(stru
 	now = base->last_expired;
 	while ((node = base->first_node) != NULL) {
 		timer = rb_entry(node, struct ptimer, node);
-		if (time_before(now, timer->expires))
+		if (now.tv64 < timer->expires.tv64)
 			break;
 		base->running_timer = timer;
 		ptimer_dequeue(timer, 1);
@@ -252,20 +256,32 @@ static inline void ptimer_run_queue(stru
 void ptimer_run_queues(void)
 {
 	struct ptimer_base *base;
-	unsigned long expired, now = jiffies;
+	unsigned long seq, last, j;
+	ktime_t now, mono;
 
 	base = __get_cpu_var(ptimer_bases);
-
-	expired = base[CLOCK_MONOTONIC].last_expired + 1;
-	if (unlikely(expired != now)) {
-		if (time_after(expired, now))
+	do {
+		seq = read_seqbegin(&xtime_lock);
+		j = jiffies;
+		now = timespec_to_ktime(xtime);
+		mono = timespec_to_ktime(wall_to_monotonic);
+	} while (read_seqretry(&xtime_lock, seq));
+
+	last = base[CLOCK_MONOTONIC].last_jiffies + 1;
+	if (unlikely(last != j)) {
+		if (time_after(last, j))
 			return;
 		do {
-			base[CLOCK_MONOTONIC].last_expired = expired;
+			base[CLOCK_MONOTONIC].last_jiffies = last;
+			base[CLOCK_MONOTONIC].last_expired =
+				ktime_add_nsec(base[CLOCK_MONOTONIC].last_expired,
+					       TICK_NSEC);
 			ptimer_run_queue(&base[CLOCK_MONOTONIC]);
-		} while (++expired != now);
+		} while (++last != j);
 	}
-	base[CLOCK_MONOTONIC].last_expired = jiffies;
+
+	base[CLOCK_MONOTONIC].last_jiffies = last;
+	base[CLOCK_MONOTONIC].last_expired = ktime_add(now, mono);
 	ptimer_run_queue(&base[CLOCK_MONOTONIC]);
 }
 
@@ -275,11 +291,22 @@ void ptimer_run_queues(void)
 static void __devinit init_ptimers_cpu(int cpu)
 {
 	struct ptimer_base *base = per_cpu(ptimer_bases, cpu);
+	ktime_t now, mono;
+	unsigned long seq;
 	int i;
 
+	do {
+		seq = read_seqbegin(&xtime_lock);
+		base[CLOCK_MONOTONIC].last_jiffies = jiffies;
+		now = timespec_to_ktime(xtime);
+		mono = timespec_to_ktime(wall_to_monotonic);
+	} while (read_seqretry(&xtime_lock, seq));
+
 	for (i = 0; i < MAX_PTIMER_BASES; i++) {
 		base[i].index = i;
-		base[i].last_expired = jiffies;
+		base[i].last_expired = now;
+		if (i == CLOCK_MONOTONIC)
+			base[i].last_expired = ktime_add(now, mono);
 		spin_lock_init(&base[i].lock);
 	}
 }
Index: linux-2.6-mm/kernel/time.c
===================================================================
--- linux-2.6-mm.orig/kernel/time.c	2005-11-29 00:57:58.000000000 +0100
+++ linux-2.6-mm/kernel/time.c	2005-11-29 01:03:10.000000000 +0100
@@ -561,6 +561,48 @@ void getnstimeofday(struct timespec *tv)
 EXPORT_SYMBOL_GPL(getnstimeofday);
 #endif
 
+/**
+ * ns_to_timespec - Convert nanoseconds to timespec
+ *
+ * @ts:                pointer to timespec variable to store result
+ * @nsec:      nanoseconds value to be converted
+ *
+ * Stores the timespec representation of the nanoseconds value in
+ * the timespec variable pointed to by @ts
+ */
+struct timespec nsec_to_timespec(s64 nsec)
+{
+	struct timespec ts;
+
+	if (nsec) {
+		ts.tv_nsec = do_div(nsec, NSEC_PER_SEC);
+		ts.tv_sec = nsec;
+	} else
+		ts.tv_sec = ts.tv_nsec = 0;
+	return ts;
+}
+
+/**
+ * ns_to_timeval - Convert nanoseconds to timeval
+ *
+ * @tv:                pointer to timeval variable to store result
+ * @nsec:      nanoseconds value to be converted
+ *
+ * Stores the timeval representation of the nanoseconds value in
+ * the timeval variable pointed to by @tv
+ */
+struct timeval nsec_to_timeval(s64 nsec)
+{
+	struct timeval tv;
+
+	if (nsec) {
+		tv.tv_usec = do_div(nsec, NSEC_PER_SEC) / NSEC_PER_USEC;
+		tv.tv_sec = nsec;
+	} else
+		tv.tv_sec = tv.tv_usec = 0;
+	return tv;
+}
+
 #if (BITS_PER_LONG < 64)
 u64 get_jiffies_64(void)
 {
