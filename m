Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267683AbTA1UV6>; Tue, 28 Jan 2003 15:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267680AbTA1UV6>; Tue, 28 Jan 2003 15:21:58 -0500
Received: from air-2.osdl.org ([65.172.181.6]:11419 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267683AbTA1UVq>;
	Tue, 28 Jan 2003 15:21:46 -0500
Date: Tue, 28 Jan 2003 12:24:54 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: <jim.houston@attbi.com>, <high-res-timers-discourse@lists.sourceforge.net>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.54 alternate timers
Message-ID: <Pine.LNX.4.33L2.0301281208510.30636-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Jim,

I had made some comments about some changes to the alternate
high-res-timers patch.  Here is a patch that fulfills most
of those comments.  Please consider applying.

All of the test cases (from George's support package) still pass
with this code.

Thanks,
-- 
~Randy



patch_name:	hrt-alt-updates.patch
patch_version:	2003-01-28.11:58:00
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	_
product:	Linux
product_versions: linux-2554-alternate-high-res-posix-timers
changelog:	Use NSEC_PER_SEC;
		add syscall prototypes (always long);
		use all of mylog;
		whitespace change;
		make id_free and id_free_count static;
URL:		_
requires:	Jim Houston's alternate Posix timers patch version 8
conflicts:	_
diffstat:	=
 arch/i386/kernel/apic.c                 |    7 ++-
 arch/i386/kernel/time.c                 |   16 ++++----
 arch/i386/kernel/timers/timer_cyclone.c |    3 +
 include/linux/posix-timers.h            |   22 +++++++++--
 kernel/id2ptr.c                         |   12 +++---
 kernel/posix-timers.c                   |   60 ++++++++++++++++----------------
 kernel/timer.c                          |   11 +++--
 7 files changed, 74 insertions(+), 57 deletions(-)


diff -Naur ./arch/i386/kernel/timers/timer_cyclone.c%MOD ./arch/i386/kernel/timers/timer_cyclone.c
--- ./arch/i386/kernel/timers/timer_cyclone.c%MOD	Mon Jan 20 16:41:19 2003
+++ ./arch/i386/kernel/timers/timer_cyclone.c	Thu Jan 23 15:53:06 2003
@@ -9,6 +9,7 @@
 #include <linux/spinlock.h>
 #include <linux/init.h>
 #include <linux/timex.h>
+#include <linux/time.h>
 #include <linux/errno.h>

 #include <asm/timer.h>
@@ -66,7 +67,7 @@

 	/* convert cyclone ticks to nanoseconds */
 	/* XXX slow, can we speed this up? */
-	offset = offset*(1000000000/CYCLONE_TIMER_FREQ);
+	offset = offset*(NSEC_PER_SEC/CYCLONE_TIMER_FREQ);

 	/* our adjusted time offset in nanoseconds */
 	return delay_at_last_interrupt + offset;
diff -Naur ./arch/i386/kernel/apic.c%MOD ./arch/i386/kernel/apic.c
--- ./arch/i386/kernel/apic.c%MOD	Mon Jan 20 16:44:00 2003
+++ ./arch/i386/kernel/apic.c	Thu Jan 23 15:39:59 2003
@@ -23,6 +23,7 @@
 #include <linux/interrupt.h>
 #include <linux/mc146818rtc.h>
 #include <linux/kernel_stat.h>
+#include <linux/time.h>

 #include <asm/atomic.h>
 #include <asm/smp.h>
@@ -852,7 +853,7 @@
 	 * value into the APIC clock, we just want to get the
 	 * counter running for calibration.
 	 */
-	__setup_APIC_LVTT(1000000000);
+	__setup_APIC_LVTT(NSEC_PER_SEC);

 	/*
 	 * The timer chip counts down to zero. Let's wait
@@ -917,7 +918,7 @@
 	if (!ns2clock) {
 		tmp = (calibration_result * HZ);
 		tmp = tmp << 32;
-		do_div(tmp, 1000000000);
+		do_div(tmp, NSEC_PER_SEC);
 		ns2clock = (int)tmp;
 		clocks = ((long long)ns2clock * ns) >> 32;
 	}
@@ -1021,6 +1022,8 @@
 {
 	return(((struct pt_regs *)regs)->eip);
 }
+
+extern int run_posix_timers(void *regs);

 inline void smp_local_timer_interrupt(struct pt_regs * regs)
 {
diff -Naur ./arch/i386/kernel/time.c%MOD ./arch/i386/kernel/time.c
--- ./arch/i386/kernel/time.c%MOD	Mon Jan 20 16:41:19 2003
+++ ./arch/i386/kernel/time.c	Thu Jan 23 15:52:09 2003
@@ -92,9 +92,9 @@
 	tv->tv_sec = 0;
 	tv->tv_nsec = timer->get_offset();
 	if (lost)
-		tv->tv_nsec += lost * (1000000000 / HZ);
-	while (tv->tv_nsec >= 1000000000) {
-		tv->tv_nsec -= 1000000000;
+		tv->tv_nsec += lost * (NSEC_PER_SEC / HZ);
+	while (tv->tv_nsec >= NSEC_PER_SEC) {
+		tv->tv_nsec -= NSEC_PER_SEC;
 		tv->tv_sec++;
 	}
 }
@@ -108,8 +108,8 @@
 	ts.tv_sec += xtime.tv_sec;
 	ts.tv_nsec += xtime.tv_nsec;
 	read_unlock_irqrestore(&xtime_lock, flags);
-	if (ts.tv_nsec >= 1000000000) {
-		ts.tv_nsec -= 1000000000;
+	if (ts.tv_nsec >= NSEC_PER_SEC) {
+		ts.tv_nsec -= NSEC_PER_SEC;
 		ts.tv_sec += 1;
 	}
 	tv->tv_sec = ts.tv_sec;
@@ -136,8 +136,8 @@
 	ts.tv_sec += ytime.tv_sec;
 	ts.tv_nsec +=ytime.tv_nsec;
 	read_unlock_irqrestore(&xtime_lock, flags);
-	if (ts.tv_nsec >= 1000000000) {
-		ts.tv_nsec -= 1000000000;
+	if (ts.tv_nsec >= NSEC_PER_SEC) {
+		ts.tv_nsec -= NSEC_PER_SEC;
 		ts.tv_sec += 1;
 	}
 	tv->tv_sec = ts.tv_sec;
@@ -159,7 +159,7 @@
 	tv->tv_nsec -= ts.tv_nsec;
 	tv->tv_sec -= ts.tv_sec;
 	while (tv->tv_nsec < 0) {
-		tv->tv_nsec += 1000000000;
+		tv->tv_nsec += NSEC_PER_SEC;
 		tv->tv_sec--;
 	}
 	xtime.tv_sec = tv->tv_sec;
diff -Naur ./include/linux/posix-timers.h%MOD ./include/linux/posix-timers.h
--- ./include/linux/posix-timers.h%MOD	Mon Jan 20 16:41:19 2003
+++ ./include/linux/posix-timers.h	Tue Jan 28 11:46:08 2003
@@ -7,10 +7,8 @@
  *
  */

-#ifndef _linux_POSIX_TIMERS_H
-#define _linux_POSIX_TIMERS_H
-
-/* This should be in posix-timers.h - but this is easier now. */
+#ifndef _LINUX_POSIX_TIMERS_H
+#define _LINUX_POSIX_TIMERS_H

 enum timer_type {
 	TIMER,
@@ -57,6 +55,20 @@
 	.head = LIST_HEAD_INIT(name.head), \
 }

-asmlinkage int sys_timer_delete(timer_t timer_id);
+asmlinkage long sys_timer_create(clockid_t which_clock,
+				struct sigevent *timer_event_spec,
+				timer_t *created_timer_id);
+asmlinkage long sys_timer_delete(timer_t timer_id);
+asmlinkage long sys_timer_gettime(timer_t timer_id, struct itimerspec *setting);
+asmlinkage long sys_timer_settime(timer_t timer_id, int flags,
+				 const struct itimerspec *new_setting,
+				 struct itimerspec *old_setting);
+asmlinkage long sys_timer_getoverrun(timer_t timer_id);
+
+asmlinkage long sys_clock_gettime(clockid_t clock, struct timespec *tp);
+asmlinkage long sys_clock_settime(clockid_t clock, const struct timespec *tp);
+asmlinkage long sys_clock_getres(clockid_t clock, struct timespec *tp);
+asmlinkage long sys_clock_nanosleep(clockid_t which_clock, int flags,
+				const struct timespec *rqtp, struct timespec *rmtp);

 #endif
diff -Naur ./kernel/posix-timers.c%MOD ./kernel/posix-timers.c
--- ./kernel/posix-timers.c%MOD	Mon Jan 20 16:41:19 2003
+++ ./kernel/posix-timers.c	Tue Jan 28 11:48:54 2003
@@ -48,7 +48,7 @@
 	int i;

 	i = myoffset;
-	myoffset = (i+1) % (MAXLOG-1);
+	myoffset = (i+1) % MAXLOG;
 	rdtsc(eax,edx);
 	mylog[i].flag = flag << 16 | edx;
 	mylog[i].tsc = eax;
@@ -93,7 +93,7 @@
 	t->it_v.it_value.tv_sec = 0;
 	t->it_v.it_value.tv_nsec = 0;
 	t->it_v.it_interval.tv_sec = 0;
-	t->it_v.it_interval.tv_nsec = 1000000000/HZ;
+	t->it_v.it_interval.tv_nsec = NSEC_PER_SEC/HZ;
 	t->it_type = TICK;
 	t->it_clock = CLOCK_MONOTONIC;
 	t->it_pq = 0;
@@ -249,10 +249,10 @@
 	ts.tv_sec = timr->it_v.it_value.tv_sec - ts.tv_sec;
 	ts.tv_nsec = timr->it_v.it_value.tv_nsec - ts.tv_nsec;
 	if (ts.tv_nsec < 0) {
-		ts.tv_nsec += 1000000000;
+		ts.tv_nsec += NSEC_PER_SEC;
 		ts.tv_sec--;
 	}
-	if (ts.tv_sec > 0 || ts.tv_nsec > (1000000000/HZ))
+	if (ts.tv_sec > 0 || ts.tv_nsec > (NSEC_PER_SEC/HZ))
 		return;
 	if (ts.tv_sec < 0 || ts.tv_nsec < min_delay)
 		ts.tv_nsec = min_delay;
@@ -360,9 +360,9 @@
 	long long ldt, in;
 	long sec, nsec;

-	in =  (long long)t->it_v.it_interval.tv_sec*1000000000 +
+	in =  (long long)t->it_v.it_interval.tv_sec*NSEC_PER_SEC +
 		t->it_v.it_interval.tv_nsec;
-	ldt = (long long)dt.tv_sec * 1000000000 + dt.tv_nsec;
+	ldt = (long long)dt.tv_sec * NSEC_PER_SEC + dt.tv_nsec;
 	/* scale ldt and in so that in fits in 32 bits. */
 	while (in > (1LL << 31)) {
 		in >>= 1;
@@ -380,14 +380,14 @@
 	 * nsec = ldt % 1000000000;
 	 * sec = ldt / 1000000000;
 	 */
-	nsec = do_div(ldt, 1000000000);
+	nsec = do_div(ldt, NSEC_PER_SEC);
 	sec = (long)ldt;
 	sec += ovr * t->it_v.it_interval.tv_sec;
 	nsec += t->it_v.it_value.tv_nsec;
 	sec +=  t->it_v.it_value.tv_sec;
-	if (nsec > 1000000000) {
+	if (nsec > NSEC_PER_SEC) {
 		sec++;
-		nsec -= 1000000000;
+		nsec -= NSEC_PER_SEC;
 	}
 	t->it_v.it_value.tv_sec = sec;
 	t->it_v.it_value.tv_nsec = nsec;
@@ -456,7 +456,7 @@
 			 * second.
 			 */
 			if (dt.tv_sec >= -1) {
-				nsec = dt.tv_sec ? 1000000000-dt.tv_nsec :
+				nsec = dt.tv_sec ? NSEC_PER_SEC-dt.tv_nsec :
 					 -dt.tv_nsec;
 				if (nsec < *next_expiry)
 					*next_expiry = nsec;
@@ -471,7 +471,7 @@
 		 */
 		if (dt.tv_nsec < 0) {
 			dt.tv_sec--;
-			dt.tv_nsec += 1000000000;
+			dt.tv_nsec += NSEC_PER_SEC;
 		}
 if (dt.tv_sec || dt.tv_nsec > 50000) logit(8, dt.tv_nsec, get_eip(regs));
 		timer_remove_nolock(t);
@@ -486,8 +486,8 @@
 					t->it_v.it_interval.tv_nsec;
 				sec = t->it_v.it_value.tv_sec +
 					t->it_v.it_interval.tv_sec;
-				if (nsec > 1000000000) {
-					nsec -= 1000000000;
+				if (nsec > NSEC_PER_SEC) {
+					nsec -= NSEC_PER_SEC;
 					sec++;
 				}
 				t->it_v.it_value.tv_sec = sec;
@@ -559,13 +559,13 @@
 	 * hang during boot.
 	 */
 	if (!system_running) {
-		set_APIC_timer(1000000000/HZ);
+		set_APIC_timer(NSEC_PER_SEC/HZ);
 		put_cpu();
 		return(1);
 	}
 #endif
 	ret = 1;
-	next_expiry = 1000000000/HZ;
+	next_expiry = NSEC_PER_SEC/HZ;
 	do_gettime_sinceboot_ns(&now_mon);
 	do_gettimeofday_ns(&now_rt);
 	expiry_cnt = 0;
@@ -613,7 +613,7 @@

 /* Create a POSIX.1b interval timer. */

-asmlinkage int
+asmlinkage long
 sys_timer_create(clockid_t which_clock, struct sigevent *timer_event_spec,
 				timer_t *created_timer_id)
 {
@@ -800,7 +800,7 @@
 	ts.tv_sec = timr->it_v.it_value.tv_sec - ts.tv_sec;
 	ts.tv_nsec = timr->it_v.it_value.tv_nsec - ts.tv_nsec;
 	if (ts.tv_nsec < 0) {
-		ts.tv_nsec += 1000000000;
+		ts.tv_nsec += NSEC_PER_SEC;
 		ts.tv_sec--;
 	}
 	if (ts.tv_sec < 0)
@@ -810,7 +810,7 @@
 }

 /* Get the time remaining on a POSIX.1b interval timer. */
-asmlinkage int sys_timer_gettime(timer_t timer_id, struct itimerspec *setting)
+asmlinkage long sys_timer_gettime(timer_t timer_id, struct itimerspec *setting)
 {
 	struct k_itimer *timr;
 	struct itimerspec cur_setting;
@@ -833,7 +833,7 @@
  * shared and local queue.
  */

-asmlinkage int sys_timer_getoverrun(timer_t timer_id)
+asmlinkage long sys_timer_getoverrun(timer_t timer_id)
 {
 	struct k_itimer *timr;
 	int overrun, i;
@@ -841,7 +841,7 @@
 	struct sigpending *sig_queue;
 	struct task_struct * t;

-	timr = lock_timer( timer_id);
+	timr = lock_timer(timer_id);
 	if (!timr) return -EINVAL;

 	t = timr->it_process;
@@ -923,8 +923,8 @@
 	nsec = tp->tv_nsec;
 	nsec +=  res-1;
 	nsec -= nsec % res;
-	if (nsec > 1000000000) {
-		nsec -=1000000000;
+	if (nsec > NSEC_PER_SEC) {
+		nsec -=NSEC_PER_SEC;
 		tp->tv_sec++;
 	}
 	tp->tv_nsec = nsec;
@@ -932,7 +932,7 @@


 /* Set a POSIX.1b interval timer */
-asmlinkage int sys_timer_settime(timer_t timer_id, int flags,
+asmlinkage long sys_timer_settime(timer_t timer_id, int flags,
 				 const struct itimerspec *new_setting,
 				 struct itimerspec *old_setting)
 {
@@ -956,7 +956,7 @@
 		return -EINVAL;
 	}

-	timr = lock_timer( timer_id);
+	timr = lock_timer(timer_id);
 	if (!timr)
 		return -EINVAL;
 	res = posix_timers_res;
@@ -975,11 +975,11 @@
 }

 /* Delete a POSIX.1b interval timer. */
-asmlinkage int sys_timer_delete(timer_t timer_id)
+asmlinkage long sys_timer_delete(timer_t timer_id)
 {
 	struct k_itimer *timer;

-	timer = lock_timer( timer_id);
+	timer = lock_timer(timer_id);
 	if (!timer)
 		return -EINVAL;
 	timer_remove(timer);
@@ -999,7 +999,7 @@
 	return 0;
 }

-asmlinkage int sys_clock_settime(clockid_t clock, const struct timespec *tp)
+asmlinkage long sys_clock_settime(clockid_t clock, const struct timespec *tp)
 {
 	struct timespec new_tp;

@@ -1018,7 +1018,7 @@
 	return 0;
 }

-asmlinkage int sys_clock_gettime(clockid_t clock, struct timespec *tp)
+asmlinkage long sys_clock_gettime(clockid_t clock, struct timespec *tp)
 {
 	struct timespec rtn_tp;
 	int error = 0;
@@ -1032,7 +1032,7 @@

 }

-asmlinkage int	 sys_clock_getres(clockid_t clock, struct timespec *tp)
+asmlinkage long sys_clock_getres(clockid_t clock, struct timespec *tp)
 {
 	struct timespec rtn_tp;

@@ -1140,7 +1140,7 @@
 			ts.tv_sec = current->nanosleep_ts.tv_sec - ts.tv_sec;
 			ts.tv_nsec = current->nanosleep_ts.tv_nsec - ts.tv_nsec;
 			if (ts.tv_nsec < 0) {
-				ts.tv_nsec += 1000000000;
+				ts.tv_nsec += NSEC_PER_SEC;
 				ts.tv_sec--;
 			}
 			if (ts.tv_sec < 0) {
diff -Naur ./kernel/timer.c%MOD ./kernel/timer.c
--- ./kernel/timer.c%MOD	Mon Jan 20 16:41:19 2003
+++ ./kernel/timer.c	Thu Jan 23 16:27:34 2003
@@ -26,6 +26,7 @@
 #include <linux/mm.h>
 #include <linux/notifier.h>
 #include <linux/thread_info.h>
+#include <linux/time.h>

 #include <asm/uaccess.h>

@@ -613,8 +614,8 @@
 	xtime.tv_nsec += tick_nsec + time_adjust_step * 1000;
 	/* time since boot too */
 	ytime.tv_nsec += tick_nsec + time_adjust_step * 1000;
-	if (ytime.tv_nsec > 1000000000) {
-		ytime.tv_nsec -= 1000000000;
+	if (ytime.tv_nsec > NSEC_PER_SEC) {
+		ytime.tv_nsec -= NSEC_PER_SEC;
 		ytime.tv_sec++;
 	}
 	/*
@@ -648,8 +649,8 @@
 		update_wall_time_one_tick();
 	} while (ticks);

-	if (xtime.tv_nsec >= 1000000000) {
-	    xtime.tv_nsec -= 1000000000;
+	if (xtime.tv_nsec >= NSEC_PER_SEC) {
+	    xtime.tv_nsec -= NSEC_PER_SEC;
 	    xtime.tv_sec++;
 	    second_overflow();
 	}
@@ -1080,7 +1081,7 @@
 	if (copy_from_user(&t, rqtp, sizeof(t)))
 		return -EFAULT;

-	if ((t.tv_nsec >= 1000000000L) || (t.tv_nsec < 0) || (t.tv_sec < 0))
+	if ((t.tv_nsec >= NSEC_PER_SEC) || (t.tv_nsec < 0) || (t.tv_sec < 0))
 		return -EINVAL;

 	expire = timespec_to_jiffies(&t) + (t.tv_sec || t.tv_nsec);
diff -Naur ./kernel/id2ptr.c%MOD ./kernel/id2ptr.c
--- ./kernel/id2ptr.c%MOD	Mon Jan 27 16:54:51 2003
+++ ./kernel/id2ptr.c	Thu Jan 23 15:28:34 2003
@@ -29,8 +29,8 @@
  * worst case allocation.
  */

-struct id_layer *id_free;
-int id_free_cnt;
+static struct id_layer *id_free;
+static int id_free_count;

 static inline struct id_layer *alloc_layer(void)
 {
@@ -39,7 +39,7 @@
 	if (!(p = id_free))
 		BUG();
 	id_free = p->ary[0];
-	id_free_cnt--;
+	id_free_count--;
 	p->ary[0] = 0;
 	return(p);
 }
@@ -48,7 +48,7 @@
 {
 	p->ary[0] = id_free;
 	id_free = p;
-	id_free_cnt++;
+	id_free_count++;
 }

 /*
@@ -115,7 +115,7 @@
 	spin_lock_irq(&id_lock);
 	n = idp->layers * ID_BITS;
 	last = idp->last;
-	while (id_free_cnt < n+1) {
+	while (id_free_count < n+1) {
 		spin_unlock_irq(&id_lock);
 		/* If the allocation fails giveup. */
 		if (!(new = kmem_cache_alloc(id_layer_cache, GFP_KERNEL)))
@@ -193,7 +193,7 @@
 	spin_lock_irq(&id_lock);
 	sub_remove(idp->top, (idp->layers-1)*ID_BITS, id);
 	idp->count--;
-	if (id_free_cnt >= ID_FREE_MAX) {
+	if (id_free_count >= ID_FREE_MAX) {

 		p = alloc_layer();
 		spin_unlock_irq(&id_lock);

