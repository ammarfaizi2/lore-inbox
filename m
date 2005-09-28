Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbVI1Unz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbVI1Unz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 16:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbVI1Uny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 16:43:54 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:31166
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1750806AbVI1Unw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 16:43:52 -0400
Message-ID: <20050928224419.1.patchmail@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: linux-kernel@vger.kernel.org
Cc: mingo@elte.hu, akpm@osdl.org, george@mvista.com, johnstul@us.ibm.com,
       paulmck@us.ibm.com, hch@infradead.org, oleg@tv-sign.ru,
       zippel@linux-m68k.org, tim.bird@am.sony.com
Subject: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
Date: Wed, 28 Sep 2005 22:43:51 +0200 (CEST)
From: tglx@linutronix.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an updated version which contains following changes:

- Selectable time storage format: union/struct based, scalar (64bit)
- Fixed an endless loop in forward_posix_timer (George Anzinger)
- Fixed a wrong sizeof(x) (George Anzinger)
- Fixed build problems for non x86 architectures

Roman pointed out that the penalty for some architectures 
would be quite big when using the nsec_t (64bit) scalar time 
storage format. After a long discussion and some more detailed 
tests especially on ARM it turned out that the scalar format 
is unfortunately not suitable everywhere. The tradeoff between 
performance and cleanliness seems too big for some architectures. 

After several rounds of functional conversions and 
cleanups an acceptable compromise between cleanliness and 
storage format flexibility was found.

For 64bit architectures the scalar representation is definitely
a win and therefor enabled unconditionally. The code defaults to
the union/struct based implementation on 32bit archs, but can be
switched to the scalar storage format by setting 
CONFIG_KTIME_SCALAR=y if there is a benefit for the particular 
architecture. The union/struct magic has an advantage over the 
struct timespec based format which I considered to use first. It
produces better and denser code for most architecures and does no
harm anywhere else. This might change with improvements of 
compilers, but then it requires just a replacement of the related
macros / inlines.

The code is not harder to understand than the previous 
open coded scalar storage based implementation.

The correctness was verified with the posix timer tests from 
the HRT project on the forward ported ktimers based high 
resolution proof of concept implementation.
For those interested in this topic the patchseries is available
at http://www.tglx.de/private/tglx/ktimers/patch-2.6.14-rc2-kt5.patches.tar.bz2


Thanks for review and feedback.

tglx


ktimers seperate the "timer API" from the "timeout API". 
ktimers are used for:
- nanosleep
- posixtimers
- itimers


The patch contains the base implementation of ktimers and the
conversion of nanosleep, posixtimers and itimers to ktimer users. 

The patch does not require other changes to the Linux time(r) core
system.

The implementation was done with following constraints in mind:

- Not bound to jiffies
- Multiple time sources
- Per CPU timer queues
- Simplification of absolute CLOCK_REALTIME posix timers
- High resolution timer aware
- Allows the timeout API to reschedule the next event 
  (for tickless systems)

Ktimers enqueue the timers into a time sorted list, which is implemented 
with a rbtree, which is effiecient and already used in other performance 
critical parts of the kernel. This is a bit slower than the timer wheel, 
but due to the fact that the vast majority of timers is actually 
expiring it has to be waged versus the cascading penalty.

The code supports multiple time sources. Currently implemented are 
CLOCK_REALTIME and CLOCK_MONOTONIC. They provide seperate timer queues 
and support functions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

---
Index: linux-2.6.14-rc2-rt4/include/linux/calc64.h
===================================================================
--- /dev/null
+++ linux-2.6.14-rc2-rt4/include/linux/calc64.h
@@ -0,0 +1,31 @@
+#ifndef _linux_CALC64_H
+#define _linux_CALC64_H
+
+#include <linux/types.h>
+#include <asm/div64.h>
+
+#ifndef div_long_long_rem
+#define div_long_long_rem(dividend,divisor,remainder) 	\
+({							\
+	u64 result = dividend;				\
+	*remainder = do_div(result,divisor);		\
+	result;						\
+})
+#endif
+
+static inline long div_long_long_rem_signed(long long dividend,
+					    long divisor,
+					    long *remainder)
+{
+	long res;
+
+	if (unlikely(dividend < 0)) {
+		res = -div_long_long_rem(-dividend, divisor, remainder);
+		*remainder = -(*remainder);
+	} else {
+		res = div_long_long_rem(dividend, divisor, remainder);
+	}
+	return res;
+}
+
+#endif
Index: linux-2.6.14-rc2-rt4/include/linux/jiffies.h
===================================================================
--- linux-2.6.14-rc2-rt4.orig/include/linux/jiffies.h
+++ linux-2.6.14-rc2-rt4/include/linux/jiffies.h
@@ -1,21 +1,12 @@
 #ifndef _LINUX_JIFFIES_H
 #define _LINUX_JIFFIES_H
 
+#include <linux/calc64.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/time.h>
 #include <linux/timex.h>
 #include <asm/param.h>			/* for HZ */
-#include <asm/div64.h>
-
-#ifndef div_long_long_rem
-#define div_long_long_rem(dividend,divisor,remainder) \
-({							\
-	u64 result = dividend;				\
-	*remainder = do_div(result,divisor);		\
-	result;						\
-})
-#endif
 
 /*
  * The following defines establish the engineering parameters of the PLL
Index: linux-2.6.14-rc2-rt4/fs/exec.c
===================================================================
--- linux-2.6.14-rc2-rt4.orig/fs/exec.c
+++ linux-2.6.14-rc2-rt4/fs/exec.c
@@ -645,9 +645,10 @@ static inline int de_thread(struct task_
 		 * synchronize with any firing (by calling del_timer_sync)
 		 * before we can safely let the old group leader die.
 		 */
-		sig->real_timer.data = (unsigned long)current;
-		if (del_timer_sync(&sig->real_timer))
-			add_timer(&sig->real_timer);
+		sig->real_timer.data = current;
+		if (stop_ktimer(&sig->real_timer))
+			start_ktimer(&sig->real_timer, NULL,
+				     KTIMER_RESTART|KTIMER_NOCHECK);
 	}
 	while (atomic_read(&sig->count) > count) {
 		sig->group_exit_task = current;
@@ -659,7 +660,7 @@ static inline int de_thread(struct task_
 	}
 	sig->group_exit_task = NULL;
 	sig->notify_count = 0;
-	sig->real_timer.data = (unsigned long)current;
+	sig->real_timer.data = current;
 	spin_unlock_irq(lock);
 
 	/*
Index: linux-2.6.14-rc2-rt4/fs/proc/array.c
===================================================================
--- linux-2.6.14-rc2-rt4.orig/fs/proc/array.c
+++ linux-2.6.14-rc2-rt4/fs/proc/array.c
@@ -330,7 +330,7 @@ static int do_task_stat(struct task_stru
 	unsigned long  min_flt = 0,  maj_flt = 0;
 	cputime_t cutime, cstime, utime, stime;
 	unsigned long rsslim = 0;
-	unsigned long it_real_value = 0;
+	DEFINE_KTIME(it_real_value);
 	struct task_struct *t;
 	char tcomm[sizeof(task->comm)];
 
@@ -386,7 +386,7 @@ static int do_task_stat(struct task_stru
 			utime = cputime_add(utime, task->signal->utime);
 			stime = cputime_add(stime, task->signal->stime);
 		}
-		it_real_value = task->signal->it_real_value;
+		it_real_value = task->signal->real_timer.expires;
 	}
 	ppid = pid_alive(task) ? task->group_leader->real_parent->tgid : 0;
 	read_unlock(&tasklist_lock);
@@ -435,7 +435,7 @@ static int do_task_stat(struct task_stru
 		priority,
 		nice,
 		num_threads,
-		jiffies_to_clock_t(it_real_value),
+		(clock_t) ktime_to_clock_t(it_real_value),
 		start_time,
 		vsize,
 		mm ? get_mm_counter(mm, rss) : 0, /* you might want to shift this left 3 */
Index: linux-2.6.14-rc2-rt4/include/linux/ktimer.h
===================================================================
--- /dev/null
+++ linux-2.6.14-rc2-rt4/include/linux/ktimer.h
@@ -0,0 +1,335 @@
+#ifndef _LINUX_KTIMER_H
+#define _LINUX_KTIMER_H
+
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/rbtree.h>
+#include <linux/time.h>
+#include <linux/wait.h>
+
+/* Timer API */
+
+/*
+ * Select the ktime_t data type
+ */
+#if defined(CONFIG_KTIME_SCALAR) || (BITS_PER_LONG == 64)
+ #define KTIME_IS_SCALAR
+#endif
+
+#ifndef KTIME_IS_SCALAR
+typedef union {
+	s64	tv64;
+	struct {
+#ifdef __BIG_ENDIAN
+	s32	sec, nsec;
+#else
+	s32	nsec, sec;
+#endif
+	} tv;
+} ktime_t;
+
+#else
+
+typedef s64 ktime_t;
+
+#endif
+
+struct ktimer_base;
+
+/*
+ * Timer structure must be initialized by init_ktimer_xxx !
+ */
+struct ktimer {
+	struct rb_node		node;
+	struct list_head	list;
+	ktime_t			expires;
+	ktime_t			expired;
+	ktime_t			interval;
+	int 	 	 	overrun;
+	unsigned long		status;
+	void 			(*function)(void *);
+	void			*data;
+	struct ktimer_base 	*base;
+};
+
+/*
+ * Timer base struct
+ */
+struct ktimer_base {
+	int			index;
+	char			*name;
+	spinlock_t		lock;
+	struct rb_root		active;
+	struct list_head	pending;
+	int			count;
+	unsigned long		resolution;
+	ktime_t			(*get_time)(void);
+	struct ktimer		*running_timer;
+	wait_queue_head_t	wait_for_running_timer;
+};
+
+/*
+ * Values for the mode argument of xxx_ktimer functions
+ */
+enum
+{
+	KTIMER_NOREARM,	/* Internal value */
+	KTIMER_ABS,	/* Time value is absolute */
+	KTIMER_REL,	/* Time value is relativ to now */
+	KTIMER_INCR,	/* Time value is relativ to previous expiry time */
+	KTIMER_FORWARD,	/* Timer is rearmed with value. Overruns are accounted */
+	KTIMER_REARM,	/* Timer is rearmed with interval. Overruns are accounted */
+	KTIMER_RESTART	/* Timer is restarted with the stored expiry value */
+};
+
+/* The timer states */
+enum
+{
+	KTIMER_INACTIVE,
+	KTIMER_PENDING,
+	KTIMER_EXPIRED,
+	KTIMER_EXPIRED_NOQUEUE,
+};
+
+/* Expiry must not be checked when the timer is started */
+#define KTIMER_NOCHECK		0x10000
+
+#define KTIMER_POISON		((void *) 0x00100101)
+
+#define KTIME_ZERO 		0LL
+
+#define ktimer_active(t) ((t)->status != KTIMER_INACTIVE)
+#define ktimer_before(t1, t2) (ktime_cmp((t1)->expires, <, (t2)->expires))
+
+#ifndef KTIME_IS_SCALAR
+/*
+ * Helper macros/inlines to get the math with ktime_t right. Uurgh, that's
+ * ugly as hell, but for performance sake we have to use this. The
+ * nsec_t based code was nice and simple. :(
+ *
+ * Be careful when using this stuff. It blows up on you if you dön't
+ * get the weirdness right.
+ *
+ * Be especially aware, that negative values are represented in the
+ * form:
+ * tv.sec < 0 and 0 >= tv.nsec < NSEC_PER_SEC
+ *
+ */
+#define DEFINE_KTIME(k) ktime_t k = {.tv64 = 0LL }
+
+#define ktime_cmp(a,op,b) ((a).tv64 op (b).tv64)
+#define ktime_cmp_val(a, op, b) ((a).tv64 op b)
+
+#define ktime_set(s,n) 		\
+({				\
+	ktime_t __kt;		\
+	__kt.tv.sec = s;	\
+	__kt.tv.nsec = n;	\
+	__kt;			\
+})
+
+#define ktime_set_zero(k) k.tv64 = 0LL
+
+#define ktime_set_low_high(l,h) ktime_set(h,l)
+
+#define ktime_get_low(t)	(t).tv.nsec
+#define ktime_get_high(t)	(t).tv.sec
+
+static inline ktime_t ktime_set_normalized(long sec, long nsec)
+{
+	ktime_t res;
+
+	while (nsec < 0) {
+                nsec += NSEC_PER_SEC;
+		sec--;
+        }
+	while (nsec >= NSEC_PER_SEC) {
+                nsec -= NSEC_PER_SEC;
+		sec++;
+	}
+
+	res.tv.sec = sec;
+	res.tv.nsec = nsec;
+	return res;
+}
+
+static inline ktime_t ktime_sub(ktime_t a, ktime_t b)
+{
+	ktime_t res;
+
+	res.tv64 = a.tv64 - b.tv64;
+	if (res.tv.nsec < 0)
+		res.tv.nsec += NSEC_PER_SEC;
+
+	return res;
+}
+
+static inline ktime_t ktime_add(ktime_t a, ktime_t b)
+{
+	ktime_t res;
+
+	res.tv64 = a.tv64 + b.tv64;
+	if (res.tv.nsec >= NSEC_PER_SEC) {
+		res.tv.nsec -= NSEC_PER_SEC;
+		res.tv.sec++;
+	}
+	return res;
+}
+
+static inline ktime_t ktime_add_ns(ktime_t a, u64 nsec)
+{
+	ktime_t tmp;
+
+	if (likely(nsec < NSEC_PER_SEC)) {
+		tmp.tv64 = nsec;
+	} else {
+		unsigned long rem;
+		rem = do_div(nsec, NSEC_PER_SEC);
+		tmp = ktime_set((long)nsec, rem);
+	}
+	return ktime_add(a,tmp);
+}
+
+#define timespec_to_ktime(ts)			\
+({						\
+	ktime_t __kt;				\
+	struct timespec __ts = (ts);		\
+	__kt.tv.sec = (s32)__ts.tv_sec;		\
+	__kt.tv.nsec = (s32)__ts.tv_nsec;	\
+	__kt;					\
+})
+
+#define ktime_to_timespec(kt)			\
+({						\
+	struct timespec __ts;			\
+	ktime_t __kt = (kt);			\
+	__ts.tv_sec = (time_t)__kt.tv.sec;	\
+	__ts.tv_nsec = (long)__kt.tv.nsec;	\
+	__ts;					\
+})
+
+#define ktime_to_timeval(kt)					\
+({								\
+	struct timeval __tv;					\
+	ktime_t __kt = (kt);					\
+	__tv.tv_sec = (time_t)__kt.tv.sec;			\
+	__tv.tv_usec = (long)(__kt.tv.nsec / NSEC_PER_USEC);	\
+	__tv;							\
+})
+
+#define ktime_to_clock_t(kt)				\
+({							\
+	ktime_t __kt = (kt);				\
+	u64 nsecs = (u64) __kt.tv.sec * NSEC_PER_SEC;	\
+	nsec_to_clock_t(nsecs + (u64) __kt.tv.nsec);	\
+})
+
+#define ktime_to_ns(kt) 					\
+({								\
+	ktime_t __kt = (kt);					\
+	(((u64)__kt.tv.sec * NSEC_PER_SEC) + (u64)__kt.tv.nsec);\
+})
+
+#else
+
+/* ktime_t macros when using a 64bit variable */
+
+#define DEFINE_KTIME(kt) ktime_t kt = 0LL
+
+#define ktime_cmp(a,op,b) ((a) op (b))
+#define ktime_cmp_val(a,op,b) ((a) op b)
+
+#define ktime_set(s,n) (((s64) s * NSEC_PER_SEC) + (s64)n)
+#define ktime_set_zero(kt) kt = 0LL
+
+#define ktime_set_low_high(l,h) ((s64)((u64)l) | (((s64) h) << 32))
+
+#define ktime_get_low(t)	((t) & 0xFFFFFFFFLL)
+#define ktime_get_high(t)	((t) >> 32)
+
+#define ktime_sub(a,b)	((a) - (b))
+#define ktime_add(a,b)	((a) + (b))
+#define ktime_add_ns(a,b) ((a) + (b))
+
+#define timespec_to_ktime(ts) ktime_set(ts.tv_sec, ts.tv_nsec)
+
+#define ktime_to_timespec(kt) ns_to_timespec(kt)
+#define ktime_to_timeval(kt) ns_to_timeval(kt)
+
+#define ktime_to_clock_t(kt) nsec_to_clock_t(kt)
+
+#define ktime_to_ns(kt) (kt)
+
+#define ktime_set_normalized(s,n) ktime_set(s,n)
+
+#endif
+
+/* Exported functions */
+extern void fastcall init_ktimer_real(struct ktimer *timer);
+extern void fastcall init_ktimer_mono(struct ktimer *timer);
+extern int modify_ktimer(struct ktimer *timer, ktime_t *tim, int mode);
+extern int start_ktimer(struct ktimer *timer, ktime_t *tim, int mode);
+extern int try_to_stop_ktimer(struct ktimer *timer);
+extern int stop_ktimer(struct ktimer *timer);
+extern ktime_t get_remtime_ktimer(struct ktimer *timer, long fake);
+extern ktime_t get_expiry_ktimer(struct ktimer *timer, ktime_t *now);
+extern void __init init_ktimers(void);
+
+/* Conversion functions with rounding based on resolution */
+extern ktime_t ktimer_convert_timeval(struct ktimer *timer, struct timeval *tv);
+extern ktime_t ktimer_convert_timespec(struct ktimer *timer, struct timespec *ts);
+
+/* Posix timers current quirks */
+extern int get_ktimer_mono_res(clockid_t which_clock, struct timespec *tp);
+extern int get_ktimer_real_res(clockid_t which_clock, struct timespec *tp);
+
+/* nanosleep functions */
+long ktimer_nanosleep_mono(struct timespec *rqtp, struct timespec __user *rmtp, int mode);
+long ktimer_nanosleep_real(struct timespec *rqtp, struct timespec __user *rmtp, int mode);
+
+#if defined(CONFIG_SMP)
+extern void wait_for_ktimer(struct ktimer *timer);
+#else
+#define wait_for_ktimer(t) do {} while (0)
+#endif
+
+#define KTIME_REALTIME_RES (NSEC_PER_SEC/HZ)
+#define KTIME_MONOTONIC_RES (NSEC_PER_SEC/HZ)
+
+static inline void get_ktime_mono_ts(struct timespec *ts)
+{
+	unsigned long seq;
+	struct timespec tomono;
+	do {
+		seq = read_seqbegin(&xtime_lock);
+		getnstimeofday(ts);
+		tomono = wall_to_monotonic;
+	} while (read_seqretry(&xtime_lock, seq));
+
+
+	set_normalized_timespec(ts, ts->tv_sec + tomono.tv_sec,
+				ts->tv_nsec + tomono.tv_nsec);
+
+}
+
+static inline ktime_t do_get_ktime_mono(void)
+{
+	struct timespec now;
+
+	get_ktime_mono_ts(&now);
+	return timespec_to_ktime(now);
+}
+
+#define get_ktime_real_ts(ts) getnstimeofday(ts)
+static inline ktime_t do_get_ktime_real(void)
+{
+	struct timespec now;
+
+	getnstimeofday(&now);
+	return timespec_to_ktime(now);
+}
+
+#define clock_was_set() do { } while (0)
+extern void run_ktimer_queues(void);
+
+#endif
Index: linux-2.6.14-rc2-rt4/include/linux/posix-timers.h
===================================================================
--- linux-2.6.14-rc2-rt4.orig/include/linux/posix-timers.h
+++ linux-2.6.14-rc2-rt4/include/linux/posix-timers.h
@@ -51,10 +51,9 @@ struct k_itimer {
 	struct sigqueue *sigq;		/* signal queue entry. */
 	union {
 		struct {
-			struct timer_list timer;
-			struct list_head abs_timer_entry; /* clock abs_timer_list */
-			struct timespec wall_to_prev;   /* wall_to_monotonic used when set */
-			unsigned long incr; /* interval in jiffies */
+			struct ktimer timer;
+			ktime_t incr;
+			int overrun;
 		} real;
 		struct cpu_timer_list cpu;
 		struct {
@@ -66,10 +65,6 @@ struct k_itimer {
 	} it;
 };
 
-struct k_clock_abs {
-	struct list_head list;
-	spinlock_t lock;
-};
 struct k_clock {
 	int res;		/* in nano seconds */
 	int (*clock_getres) (clockid_t which_clock, struct timespec *tp);
@@ -77,7 +72,7 @@ struct k_clock {
 	int (*clock_set) (clockid_t which_clock, struct timespec * tp);
 	int (*clock_get) (clockid_t which_clock, struct timespec * tp);
 	int (*timer_create) (struct k_itimer *timer);
-	int (*nsleep) (clockid_t which_clock, int flags, struct timespec *);
+	int (*nsleep) (clockid_t which_clock, int flags, struct timespec *, struct timespec __user *);
 	int (*timer_set) (struct k_itimer * timr, int flags,
 			  struct itimerspec * new_setting,
 			  struct itimerspec * old_setting);
@@ -91,37 +86,104 @@ void register_posix_clock(clockid_t cloc
 
 /* Error handlers for timer_create, nanosleep and settime */
 int do_posix_clock_notimer_create(struct k_itimer *timer);
-int do_posix_clock_nonanosleep(clockid_t, int flags, struct timespec *);
+int do_posix_clock_nonanosleep(clockid_t, int flags, struct timespec *, struct timespec __user *);
 int do_posix_clock_nosettime(clockid_t, struct timespec *tp);
 
 /* function to call to trigger timer event */
 int posix_timer_event(struct k_itimer *timr, int si_private);
 
-struct now_struct {
-	unsigned long jiffies;
-};
-
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
+#if (BITS_PER_LONG < 64)
+static inline ktime_t forward_posix_timer(struct k_itimer *t, ktime_t now)
+{
+	ktime_t delta = ktime_sub(now, t->it.real.timer.expires);
+	unsigned long orun = 1;
+
+	if (ktime_cmp_val(delta, <, KTIME_ZERO))
+		goto out;
+
+	if (unlikely(ktime_cmp(delta, >, t->it.real.incr))) {
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
+	if (ktime_cmp(t->it.real.timer.expires, <=, now)) {
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
+static inline ktime_t forward_posix_timer(struct k_itimer *t, ktime_t now)
+{
+	ktime_t delta = ktime_sub(now, t->it.real.timer.expires);
+	unsigned long orun = 1;
+
+	if (ktime_cmp_val(delta, <, KTIME_ZERO))
+		goto out;
+
+	if (unlikely(ktime_cmp(delta, >, t->it.real.incr))) {
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
+	if (ktime_cmp(t->it.real.timer.expires, <=, now)) {
+		t->it.real.timer.expires = ktime_add(t->it.real.timer.expires,
+						     t->it.real.incr);
+		orun++;
+	}
+	t->it_overrun += orun;
+ out:
+	return ktime_sub(t->it.real.timer.expires, now);
+}
+#endif
 
 int posix_cpu_clock_getres(clockid_t which_clock, struct timespec *);
 int posix_cpu_clock_get(clockid_t which_clock, struct timespec *);
 int posix_cpu_clock_set(clockid_t which_clock, const struct timespec *tp);
 int posix_cpu_timer_create(struct k_itimer *);
-int posix_cpu_nsleep(clockid_t, int, struct timespec *);
+int posix_cpu_nsleep(clockid_t, int, struct timespec *,
+		     struct timespec __user *);
 int posix_cpu_timer_set(struct k_itimer *, int,
 			struct itimerspec *, struct itimerspec *);
 int posix_cpu_timer_del(struct k_itimer *);
Index: linux-2.6.14-rc2-rt4/include/linux/sched.h
===================================================================
--- linux-2.6.14-rc2-rt4.orig/include/linux/sched.h
+++ linux-2.6.14-rc2-rt4/include/linux/sched.h
@@ -104,6 +104,7 @@ extern unsigned long nr_iowait(void);
 #include <linux/param.h>
 #include <linux/resource.h>
 #include <linux/timer.h>
+#include <linux/ktimer.h>
 
 #include <asm/processor.h>
 
@@ -346,8 +347,7 @@ struct signal_struct {
 	struct list_head posix_timers;
 
 	/* ITIMER_REAL timer for the process */
-	struct timer_list real_timer;
-	unsigned long it_real_value, it_real_incr;
+	struct ktimer real_timer;
 
 	/* ITIMER_PROF and ITIMER_VIRTUAL timers for the process */
 	cputime_t it_prof_expires, it_virt_expires;
Index: linux-2.6.14-rc2-rt4/include/linux/timer.h
===================================================================
--- linux-2.6.14-rc2-rt4.orig/include/linux/timer.h
+++ linux-2.6.14-rc2-rt4/include/linux/timer.h
@@ -91,6 +91,6 @@ static inline void add_timer(struct time
 
 extern void init_timers(void);
 extern void run_local_timers(void);
-extern void it_real_fn(unsigned long);
+extern void it_real_fn(void *);
 
 #endif
Index: linux-2.6.14-rc2-rt4/init/main.c
===================================================================
--- linux-2.6.14-rc2-rt4.orig/init/main.c
+++ linux-2.6.14-rc2-rt4/init/main.c
@@ -485,6 +485,7 @@ asmlinkage void __init start_kernel(void
 	init_IRQ();
 	pidhash_init();
 	init_timers();
+	init_ktimers();
 	softirq_init();
 	time_init();
 
Index: linux-2.6.14-rc2-rt4/kernel/Makefile
===================================================================
--- linux-2.6.14-rc2-rt4.orig/kernel/Makefile
+++ linux-2.6.14-rc2-rt4/kernel/Makefile
@@ -7,7 +7,8 @@ obj-y     = sched.o fork.o exec_domain.o
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
 	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
-	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o
+	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o \
+	    ktimers.o
 
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
Index: linux-2.6.14-rc2-rt4/kernel/exit.c
===================================================================
--- linux-2.6.14-rc2-rt4.orig/kernel/exit.c
+++ linux-2.6.14-rc2-rt4/kernel/exit.c
@@ -842,7 +842,7 @@ fastcall NORET_TYPE void do_exit(long co
 	update_mem_hiwater(tsk);
 	group_dead = atomic_dec_and_test(&tsk->signal->live);
 	if (group_dead) {
- 		del_timer_sync(&tsk->signal->real_timer);
+ 		stop_ktimer(&tsk->signal->real_timer);
 		acct_process(code);
 	}
 	exit_mm(tsk);
Index: linux-2.6.14-rc2-rt4/kernel/fork.c
===================================================================
--- linux-2.6.14-rc2-rt4.orig/kernel/fork.c
+++ linux-2.6.14-rc2-rt4/kernel/fork.c
@@ -804,10 +804,9 @@ static inline int copy_signal(unsigned l
 	init_sigpending(&sig->shared_pending);
 	INIT_LIST_HEAD(&sig->posix_timers);
 
-	sig->it_real_value = sig->it_real_incr = 0;
+	init_ktimer_mono(&sig->real_timer);
 	sig->real_timer.function = it_real_fn;
-	sig->real_timer.data = (unsigned long) tsk;
-	init_timer(&sig->real_timer);
+	sig->real_timer.data = tsk;
 
 	sig->it_virt_expires = cputime_zero;
 	sig->it_virt_incr = cputime_zero;
Index: linux-2.6.14-rc2-rt4/kernel/itimer.c
===================================================================
--- linux-2.6.14-rc2-rt4.orig/kernel/itimer.c
+++ linux-2.6.14-rc2-rt4/kernel/itimer.c
@@ -12,36 +12,22 @@
 #include <linux/syscalls.h>
 #include <linux/time.h>
 #include <linux/posix-timers.h>
+#include <linux/ktimer.h>
 
 #include <asm/uaccess.h>
 
-static unsigned long it_real_value(struct signal_struct *sig)
-{
-	unsigned long val = 0;
-	if (timer_pending(&sig->real_timer)) {
-		val = sig->real_timer.expires - jiffies;
-
-		/* look out for negative/zero itimer.. */
-		if ((long) val <= 0)
-			val = 1;
-	}
-	return val;
-}
-
 int do_getitimer(int which, struct itimerval *value)
 {
 	struct task_struct *tsk = current;
-	unsigned long interval, val;
+	ktime_t interval, val;
 	cputime_t cinterval, cval;
 
 	switch (which) {
 	case ITIMER_REAL:
-		spin_lock_irq(&tsk->sighand->siglock);
-		interval = tsk->signal->it_real_incr;
-		val = it_real_value(tsk->signal);
-		spin_unlock_irq(&tsk->sighand->siglock);
-		jiffies_to_timeval(val, &value->it_value);
-		jiffies_to_timeval(interval, &value->it_interval);
+		interval = tsk->signal->real_timer.interval;
+		val = get_remtime_ktimer(&tsk->signal->real_timer, NSEC_PER_USEC);
+		value->it_value = ktime_to_timeval(val);
+		value->it_interval = ktime_to_timeval(interval);
 		break;
 	case ITIMER_VIRTUAL:
 		read_lock(&tasklist_lock);
@@ -113,59 +99,35 @@ asmlinkage long sys_getitimer(int which,
 }
 
 
-void it_real_fn(unsigned long __data)
+/*
+ * The timer is automagically restarted, when interval != 0
+ */
+void it_real_fn(void *data)
 {
-	struct task_struct * p = (struct task_struct *) __data;
-	unsigned long inc = p->signal->it_real_incr;
-
-	send_group_sig_info(SIGALRM, SEND_SIG_PRIV, p);
-
-	/*
-	 * Now restart the timer if necessary.  We don't need any locking
-	 * here because do_setitimer makes sure we have finished running
-	 * before it touches anything.
-	 * Note, we KNOW we are (or should be) at a jiffie edge here so
-	 * we don't need the +1 stuff.  Also, we want to use the prior
-	 * expire value so as to not "slip" a jiffie if we are late.
-	 * Deal with requesting a time prior to "now" here rather than
-	 * in add_timer.
-	 */
-	if (!inc)
-		return;
-	while (time_before_eq(p->signal->real_timer.expires, jiffies))
-		p->signal->real_timer.expires += inc;
-	add_timer(&p->signal->real_timer);
+	send_group_sig_info(SIGALRM, SEND_SIG_PRIV, data);
 }
 
 int do_setitimer(int which, struct itimerval *value, struct itimerval *ovalue)
 {
 	struct task_struct *tsk = current;
- 	unsigned long val, interval, expires;
+	struct ktimer *timer;
+	ktime_t expires;
 	cputime_t cval, cinterval, nval, ninterval;
 
 	switch (which) {
 	case ITIMER_REAL:
-again:
-		spin_lock_irq(&tsk->sighand->siglock);
-		interval = tsk->signal->it_real_incr;
-		val = it_real_value(tsk->signal);
-		/* We are sharing ->siglock with it_real_fn() */
-		if (try_to_del_timer_sync(&tsk->signal->real_timer) < 0) {
-			spin_unlock_irq(&tsk->sighand->siglock);
-			goto again;
-		}
-		tsk->signal->it_real_incr =
-			timeval_to_jiffies(&value->it_interval);
-		expires = timeval_to_jiffies(&value->it_value);
-		if (expires)
-			mod_timer(&tsk->signal->real_timer,
-				  jiffies + 1 + expires);
-		spin_unlock_irq(&tsk->sighand->siglock);
+		timer = &tsk->signal->real_timer;
+		stop_ktimer(timer);
 		if (ovalue) {
-			jiffies_to_timeval(val, &ovalue->it_value);
-			jiffies_to_timeval(interval,
-					   &ovalue->it_interval);
-		}
+			ovalue->it_value = ktime_to_timeval(
+				get_remtime_ktimer(timer, NSEC_PER_USEC));
+			ovalue->it_interval = ktime_to_timeval(timer->interval);
+		}
+		timer->interval = ktimer_convert_timeval(timer, &value->it_interval);
+		expires = ktimer_convert_timeval(timer, &value->it_value);
+		if (ktime_cmp_val(expires, != , KTIME_ZERO))
+			modify_ktimer(timer, &expires, KTIMER_REL | KTIMER_NOCHECK);
+
 		break;
 	case ITIMER_VIRTUAL:
 		nval = timeval_to_cputime(&value->it_value);
Index: linux-2.6.14-rc2-rt4/kernel/ktimers.c
===================================================================
--- /dev/null
+++ linux-2.6.14-rc2-rt4/kernel/ktimers.c
@@ -0,0 +1,824 @@
+/*
+ *  linux/kernel/ktimers.c
+ *
+ *  Copyright(C) 2005 Thomas Gleixner <tglx@linutronix.de>
+ *
+ *  Kudos to Ingo Molnar for review, criticism, ideas
+ *
+ *  Credits:
+ *	Lot of ideas and implementation details taken from
+ *	timer.c and related code
+ *
+ *  Kernel timers
+ *
+ *  In contrast to the timeout related API found in kernel/timer.c,
+ *  ktimers provide finer resolution and accuracy depending on system
+ *  configuration and capabilities.
+ *
+ *  These timers are used for
+ *  - itimers
+ *  - posixtimers
+ *  - nanosleep
+ *  - precise in kernel timing
+ *
+ *  Please do not abuse this API for simple timeouts.
+ *
+ *  For licencing details see kernel-base/COPYING
+ *
+ */
+
+#include <linux/cpu.h>
+#include <linux/interrupt.h>
+#include <linux/ktimer.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/percpu.h>
+#include <linux/syscalls.h>
+
+#include <asm/uaccess.h>
+
+static ktime_t get_ktime_mono(void);
+static ktime_t get_ktime_real(void);
+
+/* The time bases */
+#define MAX_KTIMER_BASES	2
+static DEFINE_PER_CPU(struct ktimer_base, ktimer_bases[MAX_KTIMER_BASES]) =
+{
+	{
+		.index = CLOCK_REALTIME,
+		.name = "Realtime",
+		.get_time = &get_ktime_real,
+		.resolution = KTIME_REALTIME_RES,
+	},
+	{
+		.index = CLOCK_MONOTONIC,
+		.name = "Monotonic",
+		.get_time = &get_ktime_mono,
+		.resolution = KTIME_MONOTONIC_RES,
+	},
+};
+
+/*
+ * The SMP/UP kludge goes here
+ */
+#if defined(CONFIG_SMP)
+
+#define set_running_timer(b,t) b->running_timer = t
+#define wake_up_timer_waiters(b) wake_up(&b->wait_for_running_timer)
+#define ktimer_base_can_change (1)
+/*
+ * Wait for a running timer
+ */
+void wait_for_ktimer(struct ktimer *timer)
+{
+	struct ktimer_base *base = timer->base;
+
+	if (base && base->running_timer == timer)
+		wait_event(base->wait_for_running_timer,
+			   base->running_timer != timer);
+}
+
+/*
+ * We are using hashed locking: holding per_cpu(ktimer_bases)[n].lock
+ * means that all timers which are tied to this base via timer->base are
+ * locked, and the base itself is locked too.
+ *
+ * So __run_timers/migrate_timers can safely modify all timers which could
+ * be found on the lists/queues.
+ *
+ * When the timer's base is locked, and the timer removed from list, it is
+ * possible to set timer->base = NULL and drop the lock: the timer remains
+ * locked.
+ */
+static inline struct ktimer_base *lock_ktimer_base(struct ktimer *timer,
+					    unsigned long *flags)
+{
+	struct ktimer_base *base;
+
+	for (;;) {
+		base = timer->base;
+		if (likely(base != NULL)) {
+			spin_lock_irqsave(&base->lock, *flags);
+			if (likely(base == timer->base))
+				return base;
+			/* The timer has migrated to another CPU */
+			spin_unlock_irqrestore(&base->lock, *flags);
+		}
+		cpu_relax();
+	}
+}
+
+static inline struct ktimer_base *switch_ktimer_base(struct ktimer *timer,
+						     struct ktimer_base *base)
+{
+	int ktidx = base->index;
+	struct ktimer_base *new_base = &__get_cpu_var(ktimer_bases[ktidx]);
+
+	if (base != new_base) {
+		/*
+		 * We are trying to schedule the timer on the local CPU.
+		 * However we can't change timer's base while it is running,
+		 * so we keep it on the same CPU. No hassle vs. reprogramming
+		 * the event source in the high resolution case. The softirq
+		 * code will take care of this when the timer function has
+		 * completed. There is no conflict as we hold the lock until
+		 * the timer is enqueued.
+		 */
+		if (unlikely(base->running_timer == timer)) {
+			return base;
+		} else {
+			/* See the comment in lock_timer_base() */
+			timer->base = NULL;
+			spin_unlock(&base->lock);
+			spin_lock(&new_base->lock);
+			timer->base = new_base;
+		}
+	}
+	return new_base;
+}
+
+/*
+ * Get the timer base unlocked
+ *
+ * Take care of timer->base = NULL in switch_ktimer_base !
+ */
+static inline struct ktimer_base *get_ktimer_base_unlocked(struct ktimer *timer)
+{
+	struct ktimer_base *base;
+	while (!(base = timer->base));
+	return base;
+}
+#else
+
+#define set_running_timer(b,t) do {} while (0)
+#define wake_up_timer_waiters(b)  do {} while (0)
+
+static inline struct ktimer_base *lock_ktimer_base(struct ktimer *timer,
+					    unsigned long *flags)
+{
+	struct ktimer_base *base;
+
+	base = timer->base;
+	spin_lock_irqsave(&base->lock, *flags);
+	return base;
+}
+
+#define switch_ktimer_base(t, b) b
+
+#define get_ktimer_base_unlocked(t) (t)->base
+#define ktimer_base_can_change (0)
+
+#endif	/* !CONFIG_SMP */
+
+/*
+ * Convert timespec to ktime_t with resolution adjustment
+ *
+ * Note: We can access base without locking here, as ktimers can
+ * migrate between CPUs but can not be moved from one clock source to
+ * another. The clock source binding is set at init_ktimer_XXX.
+ */
+ktime_t ktimer_convert_timespec(struct ktimer *timer, struct timespec *ts)
+{
+	struct ktimer_base *base = get_ktimer_base_unlocked(timer);
+	ktime_t t;
+	long rem = ts->tv_nsec % base->resolution;
+
+	t = ktime_set(ts->tv_sec, ts->tv_nsec);
+
+	/* Check, if the value has to be rounded */
+	if (rem)
+		t = ktime_add_ns(t, base->resolution - rem);
+	return t;
+}
+
+/*
+ * Convert timeval to ktime_t with resolution adjustment
+ */
+ktime_t ktimer_convert_timeval(struct ktimer *timer, struct timeval *tv)
+{
+	struct timespec ts;
+
+	ts.tv_sec = tv->tv_sec;
+	ts.tv_nsec = tv->tv_usec * NSEC_PER_USEC;
+
+	return ktimer_convert_timespec(timer, &ts);
+}
+
+/*
+ * Internal function to add (re)start a timer
+ *
+ * The timer is inserted in expiry order.
+ * Insertion into the red black tree is O(log(n))
+ *
+ */
+static int enqueue_ktimer(struct ktimer *timer, struct ktimer_base *base,
+			   ktime_t *tim, int mode)
+{
+	struct rb_node **link = &base->active.rb_node;
+	struct rb_node *parent = NULL;
+	struct ktimer *entry;
+	struct list_head *prev = &base->pending;
+	ktime_t now;
+
+	/* Get current time */
+	now = base->get_time();
+
+	/* Timer expiry mode */
+	switch (mode & ~KTIMER_NOCHECK) {
+	case KTIMER_ABS:
+		timer->expires = *tim;
+		break;
+	case KTIMER_REL:
+		timer->expires = ktime_add(now, *tim);
+		break;
+	case KTIMER_INCR:
+		timer->expires = ktime_add(timer->expires, *tim);
+		break;
+	case KTIMER_FORWARD:
+		while ktime_cmp(timer->expires, <= , now) {
+			timer->expires = ktime_add(timer->expires, *tim);
+			timer->overrun++;
+		}
+		goto nocheck;
+	case KTIMER_REARM:
+		while ktime_cmp(timer->expires, <= , now) {
+			timer->expires = ktime_add(timer->expires, *tim);
+			timer->overrun++;
+		}
+		goto nocheck;
+	case KTIMER_RESTART:
+		break;
+	default:
+		BUG();
+	}
+
+	/* Already expired.*/
+	if ktime_cmp(timer->expires, <=, now) {
+		timer->expired = now;
+		/* The caller takes care of expiry */
+		if (!(mode & KTIMER_NOCHECK))
+			return -1;
+	}
+ nocheck:
+
+	while (*link) {
+		parent = *link;
+		entry = rb_entry(parent, struct ktimer, node);
+		/*
+		 * We dont care about collisions. Nodes with
+		 * the same expiry time stay together.
+		 */
+		if (ktimer_before(timer, entry))
+			link = &(*link)->rb_left;
+		else {
+			link = &(*link)->rb_right;
+			prev = &entry->list;
+		}
+	}
+
+	rb_link_node(&timer->node, parent, link);
+	rb_insert_color(&timer->node, &base->active);
+	list_add(&timer->list, prev);
+	timer->status = KTIMER_PENDING;
+	base->count++;
+	return 0;
+}
+
+/*
+ * Internal helper to remove a timer
+ *
+ * The function allows automatic rearming for interval
+ * timers.
+ *
+ */
+static inline void do_remove_ktimer(struct ktimer *timer,
+				    struct ktimer_base *base, int rearm)
+{
+	list_del(&timer->list);
+	rb_erase(&timer->node, &base->active);
+	timer->node.rb_parent = KTIMER_POISON;
+	timer->status = KTIMER_INACTIVE;
+	base->count--;
+	BUG_ON(base->count < 0);
+	/* Auto rearm the timer ? */
+	if (rearm && ktime_cmp_val(timer->interval, !=, KTIME_ZERO))
+		enqueue_ktimer(timer, base, NULL, KTIMER_REARM);
+}
+
+/*
+ * Called with base lock held
+ */
+static inline int remove_ktimer(struct ktimer *timer, struct ktimer_base *base)
+{
+	if (ktimer_active(timer)) {
+		do_remove_ktimer(timer, base, KTIMER_NOREARM);
+		return 1;
+	}
+	return 0;
+}
+
+/*
+ * Internal function to (re)start a timer.
+ */
+static int internal_restart_ktimer(struct ktimer *timer, ktime_t *tim,
+				   int mode)
+{
+	struct ktimer_base *base, *new_base;
+  	unsigned long flags;
+	int ret;
+
+	BUG_ON(!timer->function);
+
+	base = lock_ktimer_base(timer, &flags);
+
+	/* Remove an active timer from the queue */
+	ret = remove_ktimer(timer, base);
+
+	/* Switch the timer base, if necessary */
+	new_base = switch_ktimer_base(timer, base);
+
+	/*
+	 * When the new timer setting is already expired,
+	 * let the calling code deal with it.
+	 */
+	if (enqueue_ktimer(timer, new_base, tim, mode))
+		ret = -1;
+
+	spin_unlock_irqrestore(&new_base->lock, flags);
+	return ret;
+}
+
+/***
+ * modify_ktimer - modify a running timer
+ * @timer: the timer to be modified
+ * @tim: expiry time (required)
+ * @mode: timer setup mode
+ *
+ */
+int modify_ktimer(struct ktimer *timer, ktime_t *tim, int mode)
+{
+  	BUG_ON(!tim || !timer->function);
+	return internal_restart_ktimer(timer, tim, mode);
+}
+
+/***
+ * start_ktimer - start a timer on current CPU
+ * @timer: the timer to be added
+ * @tim: expiry time (optional, if not set in the timer)
+ * @mode: timer setup mode
+ */
+int start_ktimer(struct ktimer *timer, ktime_t *tim, int mode)
+{
+  	BUG_ON(ktimer_active(timer) || !timer->function);
+
+	return internal_restart_ktimer(timer, tim, mode);
+}
+
+/***
+ * try_to_stop_ktimer - try to deactivate a timer
+ */
+int try_to_stop_ktimer(struct ktimer *timer)
+{
+	struct ktimer_base *base;
+	unsigned long flags;
+	int ret = -1;
+
+	base = lock_ktimer_base(timer, &flags);
+
+	if (base->running_timer != timer) {
+		ret = remove_ktimer(timer, base);
+		if (ret)
+			timer->expired = base->get_time();
+	}
+
+	spin_unlock_irqrestore(&base->lock, flags);
+
+	return ret;
+
+}
+
+/***
+ * stop_timer_sync - deactivate a timer and wait for the handler to finish.
+ * @timer: the timer to be deactivated
+ *
+ */
+int stop_ktimer(struct ktimer *timer)
+{
+	for (;;) {
+		int ret = try_to_stop_ktimer(timer);
+		if (ret >= 0)
+			return ret;
+		wait_for_ktimer(timer);
+	}
+}
+
+/***
+ * get_remtime_ktimer - get remaining time for the timer
+ * @timer: the timer to read
+ * @fake:  when fake > 0 a pending, but expired timer
+ *	   returns fake (itimers need this, uurg)
+ */
+ktime_t get_remtime_ktimer(struct ktimer *timer, long fake)
+{
+	struct ktimer_base *base;
+	unsigned long flags;
+	ktime_t rem;
+
+	base = lock_ktimer_base(timer, &flags);
+	if (ktimer_active(timer)) {
+		rem = ktime_sub(timer->expires,base->get_time());
+		if (fake && ktime_cmp_val(rem, <=, KTIME_ZERO))
+			rem = ktime_set(0, fake);
+	} else {
+		if (!fake)
+			rem = ktime_sub(timer->expires,base->get_time());
+		else
+			ktime_set_zero(rem);
+	}
+	spin_unlock_irqrestore(&base->lock, flags);
+	return rem;
+}
+
+/***
+ * get_expiry_ktimer - get expiry time for the timer
+ * @timer: the timer to read
+ * @now:   if != NULL store current base->time
+ */
+ktime_t get_expiry_ktimer(struct ktimer *timer, ktime_t *now)
+{
+	struct ktimer_base *base;
+	unsigned long flags;
+	ktime_t expiry;
+
+	base = lock_ktimer_base(timer, &flags);
+	expiry = timer->expires;
+	if (now)
+		*now = base->get_time();
+	spin_unlock_irqrestore(&base->lock, flags);
+	return expiry;
+}
+
+/*
+ * Functions related to clock sources
+ */
+
+static inline void ktimer_common_init(struct ktimer *timer)
+{
+	memset(timer, 0, sizeof(struct ktimer));
+	timer->node.rb_parent = KTIMER_POISON;
+}
+
+/*
+ * Get monotonic time
+ */
+static ktime_t get_ktime_mono(void)
+{
+	return do_get_ktime_mono();
+}
+
+/***
+ * init_ktimer_mono - initialize a timer on monotonic time
+ * @timer: the timer to be initialized
+ *
+ */
+void fastcall init_ktimer_mono(struct ktimer *timer)
+{
+	ktimer_common_init(timer);
+	timer->base =
+		&per_cpu(ktimer_bases, raw_smp_processor_id())[CLOCK_MONOTONIC];
+}
+
+/***
+ * get_ktimer_mono_res - get the monotonic timer resolution
+ *
+ */
+int get_ktimer_mono_res(clockid_t which_clock, struct timespec *tp)
+{
+	tp->tv_sec = 0;
+	tp->tv_nsec =
+		per_cpu(ktimer_bases, raw_smp_processor_id())[CLOCK_MONOTONIC].resolution;
+	return 0;
+}
+
+/*
+ * Get real time
+ */
+static ktime_t get_ktime_real(void)
+{
+	return do_get_ktime_real();
+}
+
+/***
+ * init_ktimer_real - initialize a timer on real time
+ * @timer: the timer to be initialized
+ *
+ */
+void fastcall init_ktimer_real(struct ktimer *timer)
+{
+	ktimer_common_init(timer);
+	timer->base =
+		&per_cpu(ktimer_bases, raw_smp_processor_id())[CLOCK_REALTIME];
+}
+
+/***
+ * get_ktimer_real_res - get the real timer resolution
+ *
+ */
+int get_ktimer_real_res(clockid_t which_clock, struct timespec *tp)
+{
+	tp->tv_sec = 0;
+	tp->tv_nsec =
+		per_cpu(ktimer_bases, raw_smp_processor_id())[CLOCK_REALTIME].resolution;
+	return 0;
+}
+
+/*
+ * The per base runqueue
+ */
+static inline void run_ktimer_queue(struct ktimer_base *base)
+{
+	ktime_t now = base->get_time();
+
+	spin_lock_irq(&base->lock);
+	while (!list_empty(&base->pending)) {
+		void (*fn)(void *);
+		void *data;
+		struct ktimer *timer = list_entry(base->pending.next,
+						  struct ktimer, list);
+		if ktime_cmp(now, <=, timer->expires)
+			break;
+		timer->expired = now;
+		fn = timer->function;
+		data = timer->data;
+		set_running_timer(base, timer);
+		do_remove_ktimer(timer, base, KTIMER_REARM);
+		spin_unlock_irq(&base->lock);
+ 		fn(data);
+		spin_lock_irq(&base->lock);
+		set_running_timer(base, NULL);
+	}
+	spin_unlock_irq(&base->lock);
+	wake_up_timer_waiters(base);
+}
+
+/*
+ * Called from timer softirq every jiffy
+ */
+void run_ktimer_queues(void)
+{
+	struct ktimer_base *base = __get_cpu_var(ktimer_bases);
+	int i;
+
+	for (i = 0; i < MAX_KTIMER_BASES; i++)
+		run_ktimer_queue(&base[i]);
+}
+
+/*
+ * Functions related to initialization
+ */
+static void __devinit init_ktimers_cpu(int cpu)
+{
+	struct ktimer_base *base = per_cpu(ktimer_bases, cpu);
+	int i;
+
+	for (i = 0; i < MAX_KTIMER_BASES; i++) {
+		spin_lock_init(&base->lock);
+		INIT_LIST_HEAD(&base->pending);
+		init_waitqueue_head(&base->wait_for_running_timer);
+		base++;
+	}
+}
+
+#ifdef CONFIG_HOTPLUG_CPU
+static void migrate_ktimer_list(struct ktimer_base *old_base,
+				struct ktimer_base *new_base)
+{
+	struct ktimer *timer;
+	struct rb_node *node;
+
+	while ((node = rb_first(&old_base->active))) {
+		timer = rb_entry(node, struct ktimer, node);
+		remove_ktimer(timer, old_base);
+		timer->base = new_base;
+		enqueue_ktimer(timer, new_base, NULL, KTIMER_RESTART);
+	}
+}
+
+static void __devinit migrate_ktimers(int cpu)
+{
+	struct ktimer_base *old_base;
+	struct ktimer_base *new_base;
+	int i;
+
+	BUG_ON(cpu_online(cpu));
+	old_base = per_cpu(ktimer_bases, cpu);
+	new_base = get_cpu_var(ktimer_bases);
+
+	local_irq_disable();
+
+	for (i = 0; i < MAX_KTIMER_BASES; i++) {
+
+		spin_lock(&new_base->lock);
+		spin_lock(&old_base->lock);
+
+		if (old_base->running_timer)
+			BUG();
+
+		migrate_ktimer_list(old_base, new_base);
+
+		spin_unlock(&old_base->lock);
+		spin_unlock(&new_base->lock);
+		old_base++;
+		new_base++;
+	}
+
+	local_irq_enable();
+	&put_cpu_var(ktimer_bases);
+}
+#endif /* CONFIG_HOTPLUG_CPU */
+
+static int __devinit ktimer_cpu_notify(struct notifier_block *self,
+				       unsigned long action, void *hcpu)
+{
+	long cpu = (long)hcpu;
+	switch(action) {
+	case CPU_UP_PREPARE:
+		init_ktimers_cpu(cpu);
+		break;
+#ifdef CONFIG_HOTPLUG_CPU
+	case CPU_DEAD:
+		migrate_ktimers(cpu);
+		break;
+#endif
+	default:
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block __devinitdata ktimers_nb = {
+	.notifier_call	= ktimer_cpu_notify,
+};
+
+void __init init_ktimers(void)
+{
+	ktimer_cpu_notify(&ktimers_nb, (unsigned long)CPU_UP_PREPARE,
+				(void *)(long)smp_processor_id());
+	register_cpu_notifier(&ktimers_nb);
+}
+
+/*
+ * system interface related functions
+ */
+static void process_ktimer(void *data)
+{
+	wake_up_process(data);
+}
+
+/**
+ * schedule_ktimer - sleep until timeout
+ * @timeout: timeout value
+ * @state:   state to use for sleep
+ * @rel:    timeout value is abs/rel
+ *
+ * Make the current task sleep until @timeout is
+ * elapsed.
+ *
+ * You can set the task state as follows -
+ *
+ * %TASK_UNINTERRUPTIBLE - at least @timeout is guaranteed to
+ * pass before the routine returns. The routine will return 0
+ *
+ * %TASK_INTERRUPTIBLE - the routine may return early if a signal is
+ * delivered to the current task. In this case the remaining time
+ * will be returned
+ *
+ * The current task state is guaranteed to be TASK_RUNNING when this
+ * routine returns.
+ *
+ */
+static fastcall ktime_t __sched schedule_ktimer(struct ktimer *timer,
+					ktime_t *t, int state, int mode)
+{
+	timer->data = current;
+	timer->function = process_ktimer;
+
+	current->state = state;
+	if (start_ktimer(timer, t, mode)) {
+		current->state = TASK_RUNNING;
+		goto out;
+	}
+	if (current->state != TASK_RUNNING)
+		schedule();
+	stop_ktimer(timer);
+ out:
+	/* Store the absolute expiry time */
+	*t = timer->expires;
+	/* Return the remaining time */
+	return ktime_sub(timer->expires, timer->expired);
+}
+
+static long __sched nanosleep_restart(struct ktimer *timer,
+				      struct restart_block *restart)
+{
+	struct timespec tu;
+	ktime_t t, rem;
+	void *rfn = restart->fn;
+	struct timespec __user *rmtp = (struct timespec __user *) restart->arg2;
+
+	restart->fn = do_no_restart_syscall;
+
+	t = ktime_set_low_high(restart->arg0, restart->arg1);
+
+	rem = schedule_ktimer(timer, &t, TASK_INTERRUPTIBLE, KTIMER_ABS);
+
+	if (ktime_cmp_val(rem, <=, KTIME_ZERO))
+		return 0;
+
+	tu = ktime_to_timespec(rem);
+	if (rmtp && copy_to_user(rmtp, &rem, sizeof(tu)))
+		return -EFAULT;
+
+	restart->fn = rfn;
+	/* The other values in restart are already filled in */
+	return -ERESTART_RESTARTBLOCK;
+}
+
+static long __sched nanosleep_restart_mono(struct restart_block *restart)
+{
+	struct ktimer timer;
+
+	init_ktimer_mono(&timer);
+	return nanosleep_restart(&timer, restart);
+}
+
+static long __sched nanosleep_restart_real(struct restart_block *restart)
+{
+	struct ktimer timer;
+
+	init_ktimer_real(&timer);
+	return nanosleep_restart(&timer, restart);
+}
+
+static long ktimer_nanosleep(struct ktimer *timer, struct timespec *rqtp,
+			     struct timespec __user *rmtp, int mode,
+			     long (*rfn)(struct restart_block *))
+{
+	struct timespec tu;
+	ktime_t rem, t;
+	struct restart_block *restart;
+
+	t = ktimer_convert_timespec(timer, rqtp);
+
+	/* t is updated to absolute expiry time ! */
+	rem = schedule_ktimer(timer, &t, TASK_INTERRUPTIBLE, mode);
+
+	if (ktime_cmp_val(rem, <=, KTIME_ZERO))
+		return 0;
+
+	tu = ktime_to_timespec(rem);
+
+	if (rmtp && copy_to_user(rmtp, &tu, sizeof(tu)))
+		return -EFAULT;
+
+	restart = &current_thread_info()->restart_block;
+	restart->fn = rfn;
+	restart->arg0 = ktime_get_low(t);
+	restart->arg1 = ktime_get_high(t);
+	restart->arg2 = (unsigned long) rmtp;
+	return -ERESTART_RESTARTBLOCK;
+
+}
+
+long ktimer_nanosleep_mono(struct timespec *rqtp,
+			   struct timespec __user *rmtp, int mode)
+{
+	struct ktimer timer;
+
+	init_ktimer_mono(&timer);
+	return ktimer_nanosleep(&timer, rqtp, rmtp, mode, nanosleep_restart_mono);
+}
+
+long ktimer_nanosleep_real(struct timespec *rqtp,
+			   struct timespec __user *rmtp, int mode)
+{
+	struct ktimer timer;
+
+	init_ktimer_real(&timer);
+	return ktimer_nanosleep(&timer, rqtp, rmtp, mode, nanosleep_restart_real);
+}
+
+asmlinkage long sys_nanosleep(struct timespec __user *rqtp,
+			      struct timespec __user *rmtp)
+{
+	struct timespec tu;
+
+	if (copy_from_user(&tu, rqtp, sizeof(tu)))
+		return -EFAULT;
+
+	if (!timespec_valid(&tu))
+		return -EINVAL;
+
+	return ktimer_nanosleep_mono(&tu, rmtp, KTIMER_REL);
+}
+
Index: linux-2.6.14-rc2-rt4/kernel/posix-cpu-timers.c
===================================================================
--- linux-2.6.14-rc2-rt4.orig/kernel/posix-cpu-timers.c
+++ linux-2.6.14-rc2-rt4/kernel/posix-cpu-timers.c
@@ -1394,7 +1394,7 @@ void set_process_cpu_timer(struct task_s
 static long posix_cpu_clock_nanosleep_restart(struct restart_block *);
 
 int posix_cpu_nsleep(clockid_t which_clock, int flags,
-		     struct timespec *rqtp)
+		     struct timespec *rqtp, struct timespec __user *rmtp)
 {
 	struct restart_block *restart_block =
 	    &current_thread_info()->restart_block;
@@ -1419,7 +1419,6 @@ int posix_cpu_nsleep(clockid_t which_clo
 	error = posix_cpu_timer_create(&timer);
 	timer.it_process = current;
 	if (!error) {
-		struct timespec __user *rmtp;
 		static struct itimerspec zero_it;
 		struct itimerspec it = { .it_value = *rqtp,
 					 .it_interval = {} };
@@ -1466,7 +1465,6 @@ int posix_cpu_nsleep(clockid_t which_clo
 		/*
 		 * Report back to the user the time still remaining.
 		 */
-		rmtp = (struct timespec __user *) restart_block->arg1;
 		if (rmtp != NULL && !(flags & TIMER_ABSTIME) &&
 		    copy_to_user(rmtp, &it.it_value, sizeof *rmtp))
 			return -EFAULT;
@@ -1474,6 +1472,7 @@ int posix_cpu_nsleep(clockid_t which_clo
 		restart_block->fn = posix_cpu_clock_nanosleep_restart;
 		/* Caller already set restart_block->arg1 */
 		restart_block->arg0 = which_clock;
+		restart_block->arg1 = (unsigned long) rmtp;
 		restart_block->arg2 = rqtp->tv_sec;
 		restart_block->arg3 = rqtp->tv_nsec;
 
@@ -1487,10 +1486,15 @@ static long
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
 
 
@@ -1511,9 +1515,10 @@ static int process_cpu_timer_create(stru
 	return posix_cpu_timer_create(timer);
 }
 static int process_cpu_nsleep(clockid_t which_clock, int flags,
-			      struct timespec *rqtp)
+			      struct timespec *rqtp,
+			      struct timespec __user *rmtp)
 {
-	return posix_cpu_nsleep(PROCESS_CLOCK, flags, rqtp);
+	return posix_cpu_nsleep(PROCESS_CLOCK, flags, rqtp, rmtp);
 }
 static int thread_cpu_clock_getres(clockid_t which_clock, struct timespec *tp)
 {
@@ -1529,7 +1534,7 @@ static int thread_cpu_timer_create(struc
 	return posix_cpu_timer_create(timer);
 }
 static int thread_cpu_nsleep(clockid_t which_clock, int flags,
-			      struct timespec *rqtp)
+			      struct timespec *rqtp, struct timespec __user *rmtp)
 {
 	return -EINVAL;
 }
Index: linux-2.6.14-rc2-rt4/kernel/posix-timers.c
===================================================================
--- linux-2.6.14-rc2-rt4.orig/kernel/posix-timers.c
+++ linux-2.6.14-rc2-rt4/kernel/posix-timers.c
@@ -48,21 +48,6 @@
 #include <linux/workqueue.h>
 #include <linux/module.h>
 
-#ifndef div_long_long_rem
-#include <asm/div64.h>
-
-#define div_long_long_rem(dividend,divisor,remainder) ({ \
-		       u64 result = dividend;		\
-		       *remainder = do_div(result,divisor); \
-		       result; })
-
-#endif
-#define CLOCK_REALTIME_RES TICK_NSEC  /* In nano seconds. */
-
-static inline u64  mpy_l_X_l_ll(unsigned long mpy1,unsigned long mpy2)
-{
-	return (u64)mpy1 * mpy2;
-}
 /*
  * Management arrays for POSIX timers.	 Timers are kept in slab memory
  * Timer ids are allocated by an external routine that keeps track of the
@@ -148,18 +133,18 @@ static DEFINE_SPINLOCK(idr_lock);
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
+static int common_nsleep(clockid_t, int flags, struct timespec *t,
+			 struct timespec __user *rmtp);
+static void common_timer_get(struct k_itimer *, struct itimerspec *);
+static int common_timer_set(struct k_itimer *, int,
+			    struct itimerspec *, struct itimerspec *);
+static int common_timer_del(struct k_itimer *timer);
 
-static void posix_timer_fn(unsigned long);
-static u64 do_posix_clock_monotonic_gettime_parts(
-	struct timespec *tp, struct timespec *mo);
-int do_posix_clock_monotonic_gettime(struct timespec *tp);
-static int do_posix_clock_monotonic_get(clockid_t, struct timespec *tp);
+static void posix_timer_fn(void *data);
 
 static struct k_itimer *lock_timer(timer_t timer_id, unsigned long *flags);
 
@@ -205,21 +190,25 @@ static inline int common_clock_set(clock
 
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
+	init_ktimer_mono(&new_timer->it.real.timer);
+	new_timer->it.real.timer.data = new_timer;
+	new_timer->it.real.timer.function = posix_timer_fn;
+	return 0;
+}
+
+static int timer_create_real(struct k_itimer *new_timer)
+{
+	init_ktimer_real(&new_timer->it.real.timer);
+	new_timer->it.real.timer.data = new_timer;
 	new_timer->it.real.timer.function = posix_timer_fn;
 	return 0;
 }
 
-/*
- * These ones are defined below.
- */
-static int common_nsleep(clockid_t, int flags, struct timespec *t);
-static void common_timer_get(struct k_itimer *, struct itimerspec *);
-static int common_timer_set(struct k_itimer *, int,
-			    struct itimerspec *, struct itimerspec *);
-static int common_timer_del(struct k_itimer *timer);
 
 /*
  * Return nonzero iff we know a priori this clockid_t value is bogus.
@@ -239,19 +228,44 @@ static inline int invalid_clockid(clocki
 	return 1;
 }
 
+/*
+ * Get real time for posix timers
+ */
+static int posix_get_ktime_real_ts(clockid_t which_clock, struct timespec *tp)
+{
+	get_ktime_real_ts(tp);
+	return 0;
+}
+
+/*
+ * Get monotonic time for posix timers
+ */
+static int posix_get_ktime_mono_ts(clockid_t which_clock, struct timespec *tp)
+{
+	get_ktime_mono_ts(tp);
+	return 0;
+}
+
+void do_posix_clock_monotonic_gettime(struct timespec *ts)
+{
+	get_ktime_mono_ts(ts);
+}
 
 /*
  * Initialize everything, well, just everything in Posix clocks/timers ;)
  */
 static __init int init_posix_timers(void)
 {
-	struct k_clock clock_realtime = {.res = CLOCK_REALTIME_RES,
-					 .abs_struct = &abs_list
+	struct k_clock clock_realtime = {
+		.clock_getres = get_ktimer_real_res,
+		.clock_get = posix_get_ktime_real_ts,
+		.timer_create = timer_create_real,
 	};
-	struct k_clock clock_monotonic = {.res = CLOCK_REALTIME_RES,
-		.abs_struct = NULL,
-		.clock_get = do_posix_clock_monotonic_get,
-		.clock_set = do_posix_clock_nosettime
+	struct k_clock clock_monotonic = {
+		.clock_getres = get_ktimer_mono_res,
+		.clock_get = posix_get_ktime_mono_ts,
+		.clock_set = do_posix_clock_nosettime,
+		.timer_create = timer_create_mono,
 	};
 
 	register_posix_clock(CLOCK_REALTIME, &clock_realtime);
@@ -265,117 +279,17 @@ static __init int init_posix_timers(void
 
 __initcall(init_posix_timers);
 
-static void tstojiffie(struct timespec *tp, int res, u64 *jiff)
-{
-	long sec = tp->tv_sec;
-	long nsec = tp->tv_nsec + res - 1;
-
-	if (nsec > NSEC_PER_SEC) {
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
+	if (ktime_cmp_val(timr->it.real.incr, ==, KTIME_ZERO))
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
+	timr->it_overrun_last = timr->it.real.overrun;
+	timr->it.real.overrun = timr->it.real.timer.overrun = -1;
 	++timr->it_requeue_pending;
-	add_timer(&timr->it.real.timer);
+	start_ktimer(&timr->it.real.timer, &timr->it.real.incr, KTIMER_FORWARD);
+	timr->it.real.overrun = timr->it.real.timer.overrun;
 }
 
 /*
@@ -413,14 +327,7 @@ int posix_timer_event(struct k_itimer *t
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
@@ -454,65 +361,28 @@ EXPORT_SYMBOL_GPL(posix_timer_event);
 
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
+	if (ktime_cmp_val(timr->it.real.incr, !=, KTIME_ZERO))
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
@@ -776,39 +646,40 @@ static struct k_itimer * lock_timer(time
 static void
 common_timer_get(struct k_itimer *timr, struct itimerspec *cur_setting)
 {
-	unsigned long expires;
-	struct now_struct now;
+	ktime_t expires, now, remaining;
+	struct ktimer *timer = &timr->it.real.timer;
 
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
-
-	if (cur_setting->it_value.tv_sec < 0) {
+	memset(cur_setting, 0, sizeof(struct itimerspec));
+	expires = get_expiry_ktimer(timer, &now);
+	remaining = ktime_sub(expires, now);
+
+	/* Time left ? or timer pending */
+	if (ktime_cmp_val(remaining, >, KTIME_ZERO) || ktimer_active(timer))
+		goto calci;
+	/* interval timer ? */
+	if (ktime_cmp_val(timr->it.real.incr, ==, 0))
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
+	if (ktime_cmp_val(timr->it.real.incr, !=, KTIME_ZERO))
+		cur_setting->it_interval = ktime_to_timespec(timr->it.real.incr);
+	/* Return 0 only, when the timer is expired and not pending */
+	if (ktime_cmp_val(remaining, <=, KTIME_ZERO))
 		cur_setting->it_value.tv_nsec = 1;
-		cur_setting->it_value.tv_sec = 0;
-	}
+	else
+		cur_setting->it_value = ktime_to_timespec(remaining);
 }
 
 /* Get the time remaining on a POSIX.1b interval timer. */
@@ -832,6 +703,7 @@ sys_timer_gettime(timer_t timer_id, stru
 
 	return 0;
 }
+
 /*
  * Get the number of overruns of a POSIX.1b interval timer.  This is to
  * be the overrun of the timer last delivered.  At the same time we are
@@ -858,84 +730,6 @@ sys_timer_getoverrun(timer_t timer_id)
 
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
@@ -943,68 +737,52 @@ static inline int
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
+	ktime_set_zero(timr->it.real.incr);
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
+	if (try_to_stop_ktimer(&timr->it.real.timer) < 0)
 		return TIMER_RETRY;
-#endif
-	}
-
-	remove_from_abslist(timr);
 
 	timr->it_requeue_pending = (timr->it_requeue_pending + 2) & 
 		~REQUEUE_PENDING;
 	timr->it_overrun_last = 0;
 	timr->it_overrun = -1;
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
+	expires = ktimer_convert_timespec(&timr->it.real.timer,
+					  &new_setting->it_value);
+	/* This should be moved to the auto rearm code */
+	timr->it.real.incr = ktimer_convert_timespec(&timr->it.real.timer,
+						     &new_setting->it_interval);
+
+	/* SIGEV_NONE timers are not queued ! See common_timer_get */
 	if (((timr->it_sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_NONE))
-		add_timer(&timr->it.real.timer);
+		start_ktimer(&timr->it.real.timer, &expires,
+			     mode | KTIMER_NOCHECK);
 
-	if (flags & TIMER_ABSTIME && clock->abs_struct) {
-		spin_lock(&clock->abs_struct->lock);
-		list_add_tail(&(timr->it.real.abs_timer_entry),
-			      &(clock->abs_struct->list));
-		spin_unlock(&clock->abs_struct->lock);
-	}
 	return 0;
 }
 
@@ -1039,6 +817,7 @@ retry:
 
 	unlock_timer(timr, flag);
 	if (error == TIMER_RETRY) {
+		wait_for_ktimer(&timr->it.real.timer);
 		rtn = NULL;	// We already got the old time...
 		goto retry;
 	}
@@ -1052,24 +831,10 @@ retry:
 
 static inline int common_timer_del(struct k_itimer *timer)
 {
-	timer->it.real.incr = 0;
+	ktime_set_zero(timer->it.real.incr);
 
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
+	if (try_to_stop_ktimer(&timer->it.real.timer) < 0)
 		return TIMER_RETRY;
-#endif
-	}
-
-	remove_from_abslist(timer);
-
 	return 0;
 }
 
@@ -1085,24 +850,17 @@ sys_timer_delete(timer_t timer_id)
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
@@ -1119,6 +877,7 @@ retry_delete:
 	release_posix_timer(timer, IT_ID_SET);
 	return 0;
 }
+
 /*
  * return timer owned by the process, used by exit_itimers
  */
@@ -1126,22 +885,14 @@ static inline void itimer_delete(struct 
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
@@ -1170,60 +921,7 @@ void exit_itimers(struct signal_struct *
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
-static int do_posix_clock_monotonic_get(clockid_t clock, struct timespec *tp)
-{
-	struct timespec wall_to_mono;
-
-	do_posix_clock_monotonic_gettime_parts(tp, &wall_to_mono);
-
-	tp->tv_sec += wall_to_mono.tv_sec;
-	tp->tv_nsec += wall_to_mono.tv_nsec;
-
-	if ((tp->tv_nsec - NSEC_PER_SEC) > 0) {
-		tp->tv_nsec -= NSEC_PER_SEC;
-		tp->tv_sec++;
-	}
-	return 0;
-}
-
-int do_posix_clock_monotonic_gettime(struct timespec *tp)
-{
-	return do_posix_clock_monotonic_get(CLOCK_MONOTONIC, tp);
-}
-
+/* Not available / possible... functions */
 int do_posix_clock_nosettime(clockid_t clockid, struct timespec *tp)
 {
 	return -EINVAL;
@@ -1236,7 +934,8 @@ int do_posix_clock_notimer_create(struct
 }
 EXPORT_SYMBOL_GPL(do_posix_clock_notimer_create);
 
-int do_posix_clock_nonanosleep(clockid_t clock, int flags, struct timespec *t)
+int do_posix_clock_nonanosleep(clockid_t clock, int flags, struct timespec *t,
+			       struct timespec __user *r)
 {
 #ifndef ENOTSUP
 	return -EOPNOTSUPP;	/* aka ENOTSUP in userland for POSIX */
@@ -1295,125 +994,34 @@ sys_clock_getres(clockid_t which_clock, 
 	return error;
 }
 
-static void nanosleep_wake_up(unsigned long __data)
-{
-	struct task_struct *p = (struct task_struct *) __data;
-
-	wake_up_process(p);
-}
-
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
+ * nanosleep for monotonic and realtime clocks
  */
-
-static DECLARE_WAIT_QUEUE_HEAD(nanosleep_abs_wqueue);
-static DECLARE_WORK(clock_was_set_work, (void(*)(void*))clock_was_set, NULL);
-
-static DECLARE_MUTEX(clock_was_set_lock);
-
-void clock_was_set(void)
+static int common_nsleep(clockid_t which_clock, int flags,
+			 struct timespec *tsave, struct timespec __user *rmtp)
 {
-	struct k_itimer *timr;
-	struct timespec new_wall_to;
-	LIST_HEAD(cws_list);
-	unsigned long seq;
-
+	int mode = flags & TIMER_ABSTIME ? KTIMER_ABS : KTIMER_REL;
 
-	if (unlikely(in_interrupt())) {
-		schedule_work(&clock_was_set_work);
-		return;
+	switch (which_clock) {
+	case CLOCK_REALTIME:
+		/* Posix madness. Only absolute timers on clock realtime
+		   are affected by clock set. */
+		if (mode == KTIMER_ABS)
+			return ktimer_nanosleep_real(tsave, rmtp, mode);
+	case CLOCK_MONOTONIC:
+		return ktimer_nanosleep_mono(tsave, rmtp, mode);
+	default:
+		break;
 	}
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
+	return -EINVAL;
 }
 
-long clock_nanosleep_restart(struct restart_block *restart_block);
-
 asmlinkage long
 sys_clock_nanosleep(clockid_t which_clock, int flags,
 		    const struct timespec __user *rqtp,
 		    struct timespec __user *rmtp)
 {
 	struct timespec t;
-	struct restart_block *restart_block =
-	    &(current_thread_info()->restart_block);
-	int ret;
 
 	if (invalid_clockid(which_clock))
 		return -EINVAL;
@@ -1421,135 +1029,8 @@ sys_clock_nanosleep(clockid_t which_cloc
 	if (copy_from_user(&t, rqtp, sizeof (struct timespec)))
 		return -EFAULT;
 
-	if ((unsigned) t.tv_nsec >= NSEC_PER_SEC || t.tv_sec < 0)
+	if (!timespec_valid(&t))
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
-static int common_nsleep(clockid_t which_clock,
-			 int flags, struct timespec *tsave)
-{
-	struct timespec t, dum;
-	struct timer_list new_timer;
-	DECLARE_WAITQUEUE(abs_wqueue, current);
-	u64 rq_time = (u64)0;
-	s64 left;
-	int abs;
-	struct restart_block *restart_block =
-	    &current_thread_info()->restart_block;
-
-	abs_wqueue.flags = 0;
-	init_timer(&new_timer);
-	new_timer.expires = 0;
-	new_timer.data = (unsigned long) current;
-	new_timer.function = nanosleep_wake_up;
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
-		new_timer.expires = jiffies + left;
-		__set_current_state(TASK_INTERRUPTIBLE);
-		add_timer(&new_timer);
-
-		schedule();
-
-		del_timer_sync(&new_timer);
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
+	return CLOCK_DISPATCH(which_clock, nsleep, (which_clock, flags, &t, rmtp));
 }
Index: linux-2.6.14-rc2-rt4/kernel/timer.c
===================================================================
--- linux-2.6.14-rc2-rt4.orig/kernel/timer.c
+++ linux-2.6.14-rc2-rt4/kernel/timer.c
@@ -912,6 +912,7 @@ static void run_timer_softirq(struct sof
 {
 	tvec_base_t *base = &__get_cpu_var(tvec_bases);
 
+ 	run_ktimer_queues();
 	if (time_after_eq(jiffies, base->timer_jiffies))
 		__run_timers(base);
 }
@@ -1177,62 +1178,6 @@ asmlinkage long sys_gettid(void)
 	return current->pid;
 }
 
-static long __sched nanosleep_restart(struct restart_block *restart)
-{
-	unsigned long expire = restart->arg0, now = jiffies;
-	struct timespec __user *rmtp = (struct timespec __user *) restart->arg1;
-	long ret;
-
-	/* Did it expire while we handled signals? */
-	if (!time_after(expire, now))
-		return 0;
-
-	expire = schedule_timeout_interruptible(expire - now);
-
-	ret = 0;
-	if (expire) {
-		struct timespec t;
-		jiffies_to_timespec(expire, &t);
-
-		ret = -ERESTART_RESTARTBLOCK;
-		if (rmtp && copy_to_user(rmtp, &t, sizeof(t)))
-			ret = -EFAULT;
-		/* The 'restart' block is already filled in */
-	}
-	return ret;
-}
-
-asmlinkage long sys_nanosleep(struct timespec __user *rqtp, struct timespec __user *rmtp)
-{
-	struct timespec t;
-	unsigned long expire;
-	long ret;
-
-	if (copy_from_user(&t, rqtp, sizeof(t)))
-		return -EFAULT;
-
-	if ((t.tv_nsec >= 1000000000L) || (t.tv_nsec < 0) || (t.tv_sec < 0))
-		return -EINVAL;
-
-	expire = timespec_to_jiffies(&t) + (t.tv_sec || t.tv_nsec);
-	expire = schedule_timeout_interruptible(expire);
-
-	ret = 0;
-	if (expire) {
-		struct restart_block *restart;
-		jiffies_to_timespec(expire, &t);
-		if (rmtp && copy_to_user(rmtp, &t, sizeof(t)))
-			return -EFAULT;
-
-		restart = &current_thread_info()->restart_block;
-		restart->fn = nanosleep_restart;
-		restart->arg0 = jiffies + expire;
-		restart->arg1 = (unsigned long) rmtp;
-		ret = -ERESTART_RESTARTBLOCK;
-	}
-	return ret;
-}
-
 /*
  * sys_sysinfo - fill in sysinfo struct
  */ 
Index: linux-2.6.14-rc2-rt4/include/linux/time.h
===================================================================
--- linux-2.6.14-rc2-rt4.orig/include/linux/time.h
+++ linux-2.6.14-rc2-rt4/include/linux/time.h
@@ -4,6 +4,7 @@
 #include <linux/types.h>
 
 #ifdef __KERNEL__
+#include <linux/calc64.h>
 #include <linux/seqlock.h>
 #endif
 
@@ -38,6 +39,11 @@ static __inline__ int timespec_equal(str
 	return (a->tv_sec == b->tv_sec) && (a->tv_nsec == b->tv_nsec);
 } 
 
+#define timespec_valid(ts) \
+(((ts)->tv_sec >= 0) && (((unsigned) (ts)->tv_nsec) < NSEC_PER_SEC))
+
+typedef s64 nsec_t;
+
 /* Converts Gregorian date to seconds since 1970-01-01 00:00:00.
  * Assumes input in normal date format, i.e. 1980-12-31 23:59:59
  * => year=1980, mon=12, day=31, hour=23, min=59, sec=59.
@@ -88,8 +94,7 @@ struct timespec current_kernel_time(void
 extern void do_gettimeofday(struct timeval *tv);
 extern int do_settimeofday(struct timespec *tv);
 extern int do_sys_settimeofday(struct timespec *tv, struct timezone *tz);
-extern void clock_was_set(void); // call when ever the clock is set
-extern int do_posix_clock_monotonic_gettime(struct timespec *tp);
+extern void do_posix_clock_monotonic_gettime(struct timespec *ts);
 extern long do_utimes(char __user * filename, struct timeval * times);
 struct itimerval;
 extern int do_setitimer(int which, struct itimerval *value, struct itimerval *ovalue);
@@ -113,6 +118,40 @@ set_normalized_timespec (struct timespec
 	ts->tv_nsec = nsec;
 }
 
+static __inline__ nsec_t timespec_to_ns(struct timespec *s)
+{
+	nsec_t res = (nsec_t) s->tv_sec * NSEC_PER_SEC;
+	return res + (nsec_t) s->tv_nsec;
+}
+
+static __inline__ struct timespec ns_to_timespec(nsec_t n)
+{
+	struct timespec ts;
+
+	if (n)
+		ts.tv_sec = div_long_long_rem_signed(n, NSEC_PER_SEC, &ts.tv_nsec);
+	else
+		ts.tv_sec = ts.tv_nsec = 0;
+	return ts;
+}
+
+static __inline__ nsec_t timeval_to_ns(struct timeval *s)
+{
+	nsec_t res = (nsec_t) s->tv_sec * NSEC_PER_SEC;
+	return res + (nsec_t) s->tv_usec * NSEC_PER_USEC;
+}
+
+static __inline__ struct timeval ns_to_timeval(nsec_t n)
+{
+	struct timeval tv;
+	if (n) {
+		tv.tv_sec = div_long_long_rem_signed(n, NSEC_PER_SEC, &tv.tv_usec);
+		tv.tv_usec /= 1000;
+	} else
+		tv.tv_sec = tv.tv_usec = 0;
+	return tv;
+}
+
 #endif /* __KERNEL__ */
 
 #define NFDBITS			__NFDBITS
@@ -145,23 +184,18 @@ struct	itimerval {
 /*
  * The IDs of the various system clocks (for POSIX.1b interval timers).
  */
-#define CLOCK_REALTIME		  0
-#define CLOCK_MONOTONIC	  1
+#define CLOCK_REALTIME		 0
+#define CLOCK_MONOTONIC	  	 1
 #define CLOCK_PROCESS_CPUTIME_ID 2
 #define CLOCK_THREAD_CPUTIME_ID	 3
-#define CLOCK_REALTIME_HR	 4
-#define CLOCK_MONOTONIC_HR	  5
 
 /*
  * The IDs of various hardware clocks
  */
-
-
 #define CLOCK_SGI_CYCLE 10
 #define MAX_CLOCKS 16
-#define CLOCKS_MASK  (CLOCK_REALTIME | CLOCK_MONOTONIC | \
-                     CLOCK_REALTIME_HR | CLOCK_MONOTONIC_HR)
-#define CLOCKS_MONO (CLOCK_MONOTONIC & CLOCK_MONOTONIC_HR)
+#define CLOCKS_MASK  (CLOCK_REALTIME | CLOCK_MONOTONIC)
+#define CLOCKS_MONO (CLOCK_MONOTONIC)
 
 /*
  * The various flags for setting POSIX.1b interval timers.
