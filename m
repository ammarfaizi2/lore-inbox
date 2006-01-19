Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030501AbWASB4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030501AbWASB4I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 20:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030503AbWASB4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 20:56:07 -0500
Received: from gw02.applegatebroadband.net ([207.55.227.2]:1518 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S1030501AbWASB4F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 20:56:05 -0500
Message-ID: <43CEF172.2000308@mvista.com>
Date: Wed, 18 Jan 2006 17:54:58 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tglx@linutronix.de
CC: Lee Revell <rlrevell@joe-job.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: [PATCH] Clean up of hrtimer code.
Content-Type: multipart/mixed;
 boundary="------------090806040201010304080108"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090806040201010304080108
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch is against 2.6.15 with patch-2.6.15-hrt4.patch from Thomas applied.
-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/

--------------090806040201010304080108
Content-Type: text/plain;
 name="common_hrtimer.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="common_hrtimer.patch"

From: MontaVista Software, Inc.

Type: Enhancement

Description:

This patch cleans up the interface to hrtimers by changing the init code
to pass the mode as well as the clock.  This allow the init code to
select the correct base and eliminates extra timer re-init code in
posix-timers.  We also simplify the restart interface by defining a
restart union with an entry for nanosleep use.

Signed-off-by: George Anzinger <george@mvista.com>

 include/linux/hrtimer.h |   46 +++++++++++++++++--
 kernel/fork.c           |    2 
 kernel/hrtimer.c        |  113 ++++++++++++++++++++++++++----------------------
 kernel/posix-timers.c   |   36 +++------------
 4 files changed, 114 insertions(+), 83 deletions(-)

Index: linux-2.6.16-rc/kernel/hrtimer.c
===================================================================
--- linux-2.6.16-rc.orig/kernel/hrtimer.c
+++ linux-2.6.16-rc/kernel/hrtimer.c
@@ -113,6 +113,24 @@ static DEFINE_PER_CPU(struct hrtimer_bas
 		.resolution = KTIME_MONOTONIC_RES,
 	},
 };
+/**
+ * We want to use the "monotonic" base for everything except
+ * CLOCK_REALTIME* with the absolute flag set.  We need to
+ * account for the hole in the clocks caused by the CPU clocks
+ * (sigh).  We could use a case statement or, depend on REALTIME
+ * clocks being even and MONOTONIC being odd.  This even allow us
+ * to expand easily beyond 2 clocks.
+ *
+ */
+#define _clock_to_base(clock) (clock <= CLOCK_MONOTONIC ? clock : clock - 2)
+int clock_to_base_index(clock_t clock, enum hrtimer_mode mode)
+{
+	int baseindex = _clock_to_base(clock);
+
+	if (mode == HRTIMER_ABS)
+		return baseindex;
+	return baseindex | 1;
+}
 
 /*
  * Functions and macros which are different for UP/SMP systems are kept in a
@@ -120,7 +138,7 @@ static DEFINE_PER_CPU(struct hrtimer_bas
  */
 #ifdef CONFIG_SMP
 
-#define set_curr_timer(b, t)		do { (b)->curr_timer = (t); } while (0)
+#define set_curr_timer(b, t)	do { (b)->curr_timer = (t); } while (0)
 
 /*
  * We are using hashed locking: holding per_cpu(hrtimer_bases)[n].lock
@@ -147,6 +165,8 @@ static struct hrtimer_base *lock_hrtimer
 				return base;
 			/* The timer has migrated to another CPU: */
 			spin_unlock_irqrestore(&base->lock, *flags);
+		} else {
+			return base;
 		}
 		cpu_relax();
 	}
@@ -193,7 +213,8 @@ lock_hrtimer_base(const struct hrtimer *
 {
 	struct hrtimer_base *base = timer->base;
 
-	spin_lock_irqsave(&base->lock, *flags);
+	if (base)
+		spin_lock_irqsave(&base->lock, *flags);
 
 	return base;
 }
@@ -645,6 +666,9 @@ int hrtimer_try_to_cancel(struct hrtimer
 
 	base = lock_hrtimer_base(timer, &flags);
 
+	if (!base)
+		return 0;
+
 	if (base->curr_timer != timer)
 		ret = remove_hrtimer(timer, base);
 
@@ -677,6 +701,7 @@ int hrtimer_cancel(struct hrtimer *timer
  * hrtimer_get_remaining - get remaining time for the timer
  *
  * @timer:	the timer to read
+ * returns 0 if timer base is not set up.
  */
 ktime_t hrtimer_get_remaining(const struct hrtimer *timer)
 {
@@ -685,36 +710,30 @@ ktime_t hrtimer_get_remaining(const stru
 	ktime_t rem;
 
 	base = lock_hrtimer_base(timer, &flags);
+	if (!base)
+		return (ktime_t) {.tv64 = 0 };
 	rem = ktime_sub(timer->expires, timer->base->get_time());
 	unlock_hrtimer_base(timer, &flags);
 
 	return rem;
 }
 
-/**
- * hrtimer_rebase - rebase an initialized hrtimer to a different base
- *
- * @timer:	the timer to be rebased
- * @clock_id:	the clock to be used
- */
-void hrtimer_rebase(struct hrtimer *timer, const clockid_t clock_id)
-{
-	struct hrtimer_base *bases;
-
-	bases = per_cpu(hrtimer_bases, raw_smp_processor_id());
-	timer->base = &bases[clock_id];
-}
 
 /**
  * hrtimer_init - initialize a timer to the given clock
  *
  * @timer:	the timer to be initialized
  * @clock_id:	the clock to be used
- */
-void hrtimer_init(struct hrtimer *timer, const clockid_t clock_id)
+  * mode:        HRTIMER_ABS if absolute mode
+*/
+void hrtimer_init(struct hrtimer *timer, const clockid_t clock_id,
+		  enum hrtimer_mode mode)
 {
+	struct hrtimer_base *bases =
+		per_cpu(hrtimer_bases, raw_smp_processor_id());
+
 	memset(timer, 0, sizeof(struct hrtimer));
-	hrtimer_rebase(timer, clock_id);
+	timer->base = &bases[clock_to_base_index(clock_id, mode)];
 }
 
 /**
@@ -732,7 +751,7 @@ int hrtimer_get_res(const clockid_t whic
 
 	tp->tv_sec = 0;
 	bases = per_cpu(hrtimer_bases, raw_smp_processor_id());
-	tp->tv_nsec = bases[which_clock].resolution;
+	tp->tv_nsec = bases[_clock_to_base(which_clock)].resolution;
 
 	return 0;
 }
@@ -774,7 +793,7 @@ int hrtimer_interrupt(void)
 
 	base = per_cpu(hrtimer_bases, cpu);
 
-	for (i = 0; i < MAX_HRTIMER_BASES; i++) {
+	for (i = 0; i < MAX_HRTIMER_BASES; i++, base++) {
 		ktime_t basenow;
 		struct rb_node *node;
 
@@ -808,7 +827,6 @@ int hrtimer_interrupt(void)
 			}
 		}
 		spin_unlock(&base->lock);
-		base++;
 	}
 
 	hres->expires_next = expires_next;
@@ -1000,63 +1018,56 @@ schedule_hrtimer_interruptible(struct hr
 	return schedule_hrtimer(timer, mode);
 }
 
+
 static long __sched
-nanosleep_restart(struct restart_block *restart, clockid_t clockid)
+nanosleep_restart(union restart_union *restart)
 {
-	struct timespec __user *rmtp, tu;
-	void *rfn_save = restart->fn;
+	struct timespec tu;
 	struct hrtimer timer;
 	ktime_t rem;
 
-	restart->fn = do_no_restart_syscall;
+	restart->ns.fn =
+		(long (*)(union restart_union *))do_no_restart_syscall;
 
-	hrtimer_init(&timer, clockid);
-
-	timer.expires.tv64 = ((u64)restart->arg1 << 32) | (u64) restart->arg0;
+ 	hrtimer_init(&timer, (clock_t)restart->ns.clock,
+		     (enum hrtimer_mode)restart->ns.mode);
 
+	timer.expires = restart->ns.time;
 	rem = schedule_hrtimer_interruptible(&timer, HRTIMER_ABS);
 
 	if (rem.tv64 <= 0)
 		return 0;
 
-	rmtp = (struct timespec __user *) restart->arg2;
 	tu = ktime_to_timespec(rem);
-	if (rmtp && copy_to_user(rmtp, &tu, sizeof(tu)))
-		return -EFAULT;
+	if (restart->ns.rmtp &&
+	    copy_to_user(restart->ns.rmtp, &tu, sizeof(tu)))
 
-	restart->fn = rfn_save;
+ 	restart->ns.fn = nanosleep_restart;
 
 	/* The other values in restart are already filled in */
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
 
 long hrtimer_nanosleep(struct timespec *rqtp, struct timespec __user *rmtp,
 		       const enum hrtimer_mode mode, const clockid_t clockid)
 {
-	struct restart_block *restart;
+	union restart_union *restart;
 	struct hrtimer timer;
 	struct timespec tu;
 	ktime_t rem;
 
-	hrtimer_init(&timer, clockid);
+	hrtimer_init(&timer, clockid, mode);
 
 	timer.expires = timespec_to_ktime(*rqtp);
 
 	rem = schedule_hrtimer_interruptible(&timer, mode);
 	if (rem.tv64 <= 0)
 		return 0;
-
-	/* Absolute timers do not update the rmtp value: */
+	/*
+	 * Absolute timers do not update the rmtp value
+	 * and restart from scratch.
+	 */
 	if (mode == HRTIMER_ABS)
 		return -ERESTARTNOHAND;
 
@@ -1065,12 +1076,12 @@ long hrtimer_nanosleep(struct timespec *
 	if (rmtp && copy_to_user(rmtp, &tu, sizeof(tu)))
 		return -EFAULT;
 
-	restart = &current_thread_info()->restart_block;
-	restart->fn = (clockid == CLOCK_MONOTONIC) ?
-		nanosleep_restart_mono : nanosleep_restart_real;
-	restart->arg0 = timer.expires.tv64 & 0xFFFFFFFF;
-	restart->arg1 = timer.expires.tv64 >> 32;
-	restart->arg2 = (unsigned long) rmtp;
+	restart = (union restart_union *)&current_thread_info()->restart_block;
+	restart->ns.fn = nanosleep_restart;
+	restart->ns.time = timer.expires;
+	restart->ns.rmtp = rmtp;
+	restart->ns.mode = (unsigned char)mode;
+	restart->ns.clock = (unsigned char)clockid;
 
 	return -ERESTART_RESTARTBLOCK;
 }
Index: linux-2.6.16-rc/kernel/posix-timers.c
===================================================================
--- linux-2.6.16-rc.orig/kernel/posix-timers.c
+++ linux-2.6.16-rc/kernel/posix-timers.c
@@ -194,9 +194,6 @@ static inline int common_clock_set(const
 
 static inline int common_timer_create(struct k_itimer *new_timer)
 {
-	hrtimer_init(&new_timer->it.real.timer, new_timer->it_clock);
-	new_timer->it.real.timer.data = new_timer;
-	new_timer->it.real.timer.function = posix_timer_fn;
 	return 0;
 }
 
@@ -693,6 +690,8 @@ common_timer_set(struct k_itimer *timr, 
 		 struct itimerspec *new_setting, struct itimerspec *old_setting)
 {
 	struct hrtimer *timer = &timr->it.real.timer;
+	enum hrtimer_mode mode = (flags & TIMER_ABSTIME) ?
+		HRTIMER_ABS : HRTIMER_REL;
 
 	if (old_setting)
 		common_timer_get(timr, old_setting);
@@ -714,14 +713,9 @@ common_timer_set(struct k_itimer *timr, 
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
+	hrtimer_init(&timr->it.real.timer, timr->it_clock, mode);
+	timr->it.real.timer.data = timr;
+	timr->it.real.timer.function = posix_timer_fn;
 
 	timer->expires = timespec_to_ktime(new_setting->it_value);
 
@@ -732,8 +726,7 @@ common_timer_set(struct k_itimer *timr, 
 	if (((timr->it_sigev_notify & ~SIGEV_THREAD_ID) == SIGEV_NONE))
 		return 0;
 
-	hrtimer_start(timer, timer->expires, (flags & TIMER_ABSTIME) ?
-		      HRTIMER_ABS : HRTIMER_REL);
+	hrtimer_start(timer, timer->expires, mode);
 	return 0;
 }
 
@@ -948,21 +941,10 @@ sys_clock_getres(const clockid_t which_c
 static int common_nsleep(const clockid_t which_clock, int flags,
 			 struct timespec *tsave, struct timespec __user *rmtp)
 {
-	int mode = flags & TIMER_ABSTIME ? HRTIMER_ABS : HRTIMER_REL;
-	int clockid = which_clock;
+	enum hrtimer_mode mode = flags & TIMER_ABSTIME ?
+		HRTIMER_ABS : HRTIMER_REL;
 
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
+	return hrtimer_nanosleep(tsave, rmtp, mode, which_clock);
 }
 
 asmlinkage long
Index: linux-2.6.16-rc/include/linux/hrtimer.h
===================================================================
--- linux-2.6.16-rc.orig/include/linux/hrtimer.h
+++ linux-2.6.16-rc/include/linux/hrtimer.h
@@ -96,8 +96,6 @@ struct hrtimer_base {
 #ifdef CONFIG_HIGH_RES_TIMERS
 	struct list_head	expired;
 	ktime_t			offset;
-	int			(*reprogram)(struct hrtimer *t,
-					     struct hrtimer_base *b, ktime_t n);
 #endif
 };
 
@@ -134,9 +132,49 @@ extern int hrtimer_interrupt(void);
 /* Exported timer functions: */
 
 /* Initialize timers: */
-extern void hrtimer_init(struct hrtimer *timer, const clockid_t which_clock);
-extern void hrtimer_rebase(struct hrtimer *timer, const clockid_t which_clock);
+extern void hrtimer_init(struct hrtimer *timer, const clockid_t which_clock,
+			 enum hrtimer_mode mode);
+extern void hrtimer_init(struct hrtimer *timer, const clockid_t which_clock,
+			 enum hrtimer_mode mode);
+
+/*
+ * System call restart block.
+ *
+ * This really wants to be in the thread_info.h file, however, neither
+ * ktime_t nor timespec are defined at that time and trying to define
+ * them leads to a dependency loop that is rather hard to break.  We
+ * do the best thing we can here by using fill and some compile time
+ * "magic" to force errors if any assumptions are violated.
+ */
 
+union restart_union {
+	struct restart_block rsb;
+	struct {
+		long (*fn)(union restart_union *);
+		ktime_t time;
+		struct timespec  __user *rmtp;
+		unsigned char clock;
+		unsigned char mode;
+		unsigned char fill[sizeof(struct restart_block) -
+				   sizeof(ktime_t) -
+				   sizeof(struct timespec *) -
+				   sizeof(unsigned char) -
+				   sizeof(unsigned char)];
+		} ns;
+};
+/*
+* The above union uses the "fill" size to verify that the nano sleep
+* stuff fits in the same space as the struct restart_block (else we will
+* have a negative size which the compiler will complain about).  Here we
+* verify that the restart_union rsb.fn and ns.fn are at the same place.
+*/
+#define fn_error ((long)(&((union restart_union *)0)->rsb.fn) - \
+                  (long)(&((union restart_union *)0)->ns.fn))
+
+struct test{
+	char error1[fn_error];
+	char error2[-fn_error];
+};
 
 /* Basic timer operations: */
 extern int hrtimer_start(struct hrtimer *timer, ktime_t tim,
Index: linux-2.6.16-rc/kernel/fork.c
===================================================================
--- linux-2.6.16-rc.orig/kernel/fork.c
+++ linux-2.6.16-rc/kernel/fork.c
@@ -793,7 +793,7 @@ static inline int copy_signal(unsigned l
 	init_sigpending(&sig->shared_pending);
 	INIT_LIST_HEAD(&sig->posix_timers);
 
-	hrtimer_init(&sig->real_timer, CLOCK_MONOTONIC);
+	hrtimer_init(&sig->real_timer, CLOCK_MONOTONIC, 0);
 	sig->it_real_incr.tv64 = 0;
 	sig->real_timer.function = it_real_fn;
 	sig->real_timer.data = tsk;

--------------090806040201010304080108--
