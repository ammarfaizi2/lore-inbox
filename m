Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267717AbTAIAHU>; Wed, 8 Jan 2003 19:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267993AbTAIAGe>; Wed, 8 Jan 2003 19:06:34 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:62703 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S267725AbTAIAEh>;
	Wed, 8 Jan 2003 19:04:37 -0500
Message-ID: <3E1CB04C.C319793A@mvista.com>
Date: Wed, 08 Jan 2003 15:12:12 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>
Subject: [PATCH 3/3] High-res-timers part 3 (posix to hrposix) take 24
References: <3DB9A314.6CECA1AC@mvista.com>
Content-Type: multipart/mixed;
 boundary="------------7F7E5CD37A918538CA13993B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------7F7E5CD37A918538CA13993B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

And this finishs the high res timers code.

Now for 2.5.54-bk6

Changes since last time:
-----------

I had to add arg3 to the restart_block to handle the two
word restart time...

This patch adds the two POSIX clocks CLOCK_REALTIME_HR and
CLOCK_MONOTONIC_HR to the posix clocks & timers package.  A
small change is made in sched.h and the rest of the patch is
against .../kernel/posix_timers.c and
.../include/linux/posix_timers.h


This patch takes advantage of the timer storm protection
features of the POSIX clock and timers patch.

This patch fixes the high resolution timer resolution at 1
micro second.  Should this number be a CONFIG option?

I think it would be a "good thing" to move the NTP stuff to
the jiffies clock.  This would allow the wall clock/ jiffies
clock difference to be a "fixed value" so that code that
needed this would not have to read two clocks.  Setting the
wall clock would then just be an adjustment to this "fixed
value".  It would also eliminate the problem of asking for a
wall clock offset and getting a jiffies clock offset.  This
issue is what causes the current 2.5.46 system to fail the
simple:

time sleep 60

test (any value less than 60 seconds violates the standard
in that it implies a timer expired early).

These patches as well as the POSIX clocks & timers patch are
available on the project site:
http://sourceforge.net/projects/high-res-timers/

The 3 parts to the high res timers are:
 core      The core kernel (i.e. platform independent)
 i386      The high-res changes for the i386 (x86) platform
*hrposix   The changes to the POSIX clocks & timers patch to
           use high-res timers

Please apply.
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
--------------7F7E5CD37A918538CA13993B
Content-Type: text/plain; charset=us-ascii;
 name="hrtimers-hrposix-2.5.54-bk6-1.0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hrtimers-hrposix-2.5.54-bk6-1.0.patch"

diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.54-bk6-i386/include/linux/posix-timers.h linux/include/linux/posix-timers.h
--- linux-2.5.54-bk6-i386/include/linux/posix-timers.h	Wed Jan  8 13:36:27 2003
+++ linux/include/linux/posix-timers.h	Wed Jan  8 13:41:50 2003
@@ -15,6 +15,39 @@
 	void (*timer_get) (struct k_itimer * timr,
 			   struct itimerspec * cur_setting);
 };
+
+#ifdef CONFIG_HIGH_RES_TIMERS
+struct now_struct {
+	unsigned long jiffies;
+	long sub_jiffie;
+};
+static inline void
+posix_get_now(struct now_struct *now)
+{
+	(now)->jiffies = jiffies;
+	(now)->sub_jiffie = quick_update_jiffies_sub((now)->jiffies);
+	while (unlikely(((now)->sub_jiffie - cycles_per_jiffies) > 0)) {
+		(now)->sub_jiffie = (now)->sub_jiffie - cycles_per_jiffies;
+		(now)->jiffies++;
+	}
+}
+
+#define posix_time_before(timer, now) \
+         ( {long diff = (long)(timer)->expires - (long)(now)->jiffies;  \
+           (diff < 0) ||                                      \
+	   ((diff == 0) && ((timer)->sub_expires < (now)->sub_jiffie)); })
+
+#define posix_bump_timer(timr) do { \
+          (timr)->it_timer.expires += (timr)->it_incr; \
+          (timr)->it_timer.sub_expires += (timr)->it_sub_incr; \
+          if (((timr)->it_timer.sub_expires - cycles_per_jiffies) >= 0){ \
+		  (timr)->it_timer.sub_expires -= cycles_per_jiffies; \
+		  (timr)->it_timer.expires++; \
+	  }                                 \
+          (timr)->it_overrun++;               \
+        }while (0)
+
+#else
 struct now_struct {
 	unsigned long jiffies;
 };
@@ -27,4 +60,5 @@
                         (timr)->it_timer.expires += (timr)->it_incr; \
                         (timr)->it_overrun++;               \
                        }while (0)
+#endif				// CONFIG_HIGH_RES_TIMERS
 #endif
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.54-bk6-i386/include/linux/sched.h linux/include/linux/sched.h
--- linux-2.5.54-bk6-i386/include/linux/sched.h	Wed Jan  8 13:36:27 2003
+++ linux/include/linux/sched.h	Wed Jan  8 13:41:50 2003
@@ -289,6 +289,9 @@
 	int it_sigev_signo;		 /* signo word of sigevent struct */
 	sigval_t it_sigev_value;	 /* value word of sigevent struct */
 	unsigned long it_incr;		/* interval specified in jiffies */
+#ifdef CONFIG_HIGH_RES_TIMERS
+        int it_sub_incr;                /* sub jiffie part of interval */
+#endif
 	struct task_struct *it_process;	/* process to send signal to */
 	struct timer_list it_timer;
 };
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.54-bk6-i386/include/linux/thread_info.h linux/include/linux/thread_info.h
--- linux-2.5.54-bk6-i386/include/linux/thread_info.h	Wed Dec 11 06:25:32 2002
+++ linux/include/linux/thread_info.h	Wed Jan  8 13:41:51 2003
@@ -12,7 +12,7 @@
  */
 struct restart_block {
 	long (*fn)(struct restart_block *);
-	unsigned long arg0, arg1, arg2;
+	unsigned long arg0, arg1, arg2, arg3;
 };
 
 extern long do_no_restart_syscall(struct restart_block *parm);
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.54-bk6-i386/kernel/posix-timers.c linux/kernel/posix-timers.c
--- linux-2.5.54-bk6-i386/kernel/posix-timers.c	Wed Jan  8 13:36:27 2003
+++ linux/kernel/posix-timers.c	Wed Jan  8 13:41:51 2003
@@ -22,6 +22,7 @@
 #include <linux/init.h>
 #include <linux/compiler.h>
 #include <linux/idr.h>
+#include <linux/hrtime.h>
 #include <linux/posix-timers.h>
 
 #ifndef div_long_long_rem
@@ -178,6 +179,14 @@
 					       sizeof (struct k_itimer), 0, 0,
 					       0, 0);
 	idr_init(&posix_timers_id);
+	IF_HIGH_RES(clock_realtime.res = CONFIG_HIGH_RES_RESOLUTION;
+		    register_posix_clock(CLOCK_REALTIME_HR, &clock_realtime);
+		    clock_monotonic.res = CONFIG_HIGH_RES_RESOLUTION;
+		    register_posix_clock(CLOCK_MONOTONIC_HR,
+					 &clock_monotonic);;);
+#ifdef	 final_clock_init
+	final_clock_init();	// defined by arch header file
+#endif
 	return 0;
 }
 
@@ -217,8 +226,23 @@
 	 * We trust that the optimizer will use the remainder from the 
 	 * above div in the following operation as long as they are close. 
 	 */
-	return 0;
+	return (nsec_to_arch_cycles(nsec % (NSEC_PER_SEC / HZ)));
 }
+#ifdef CONFIG_HIGH_RES_TIMERS
+static void
+tstotimer(struct itimerspec *time, struct k_itimer *timer)
+{
+	int res = posix_clocks[timer->it_clock].res;
+
+	timer->it_timer.sub_expires = tstojiffie(&time->it_value,
+						 res, &timer->it_timer.expires);
+	timer->it_sub_incr = tstojiffie(&time->it_interval,
+					res, (unsigned long *) &timer->it_incr);
+	if ((unsigned long) timer->it_incr > MAX_JIFFY_OFFSET)
+		timer->it_incr = MAX_JIFFY_OFFSET;
+}
+
+#else
 static void
 tstotimer(struct itimerspec *time, struct k_itimer *timer)
 {
@@ -227,6 +251,8 @@
 	tstojiffie(&time->it_interval, res, &timer->it_incr);
 }
 
+#endif
+
 static void
 schedule_next_timer(struct k_itimer *timr)
 {
@@ -234,7 +260,7 @@
 
 	/* Set up the timer for the next interval (if there is one) */
 	if (timr->it_incr == 0) {
-		{
+		IF_HIGH_RES(if (timr->it_sub_incr == 0)) {
 			set_timer_inactive(timr);
 			return;
 		}
@@ -307,7 +333,7 @@
 	info.si_code = SI_TIMER;
 	info.si_tid = timr->it_id;
 	info.si_value = timr->it_sigev_value;
-	if (timr->it_incr == 0) {
+	if ((timr->it_incr == 0) IF_HIGH_RES(&&(timr->it_sub_incr == 0))) {
 		set_timer_inactive(timr);
 	} else {
 		timr->it_requeue_pending = info.si_sys_private = 1;
@@ -631,13 +657,15 @@
 
 	do {
 		expires = timr->it_timer.expires;
+		IF_HIGH_RES(sub_expires = timr->it_timer.sub_expires);
 	} while ((volatile long) (timr->it_timer.expires) != expires);
 
 	posix_get_now(&now);
 
 	if (expires && (timr->it_sigev_notify & SIGEV_NONE) && !timr->it_incr) {
 		if (posix_time_before(&timr->it_timer, &now)) {
-			timr->it_timer.expires = expires = 0;
+			IF_HIGH_RES(timr->it_timer.sub_expires =)
+			    timr->it_timer.expires = expires = 0;
 		}
 	}
 	if (expires) {
@@ -653,11 +681,26 @@
 		}
 		if (expires) {
 			expires -= now.jiffies;
+			IF_HIGH_RES(sub_expires -= now.sub_jiffie);
 		}
 	}
 	jiffies_to_timespec(expires, &cur_setting->it_value);
 	jiffies_to_timespec(timr->it_incr, &cur_setting->it_interval);
 
+	IF_HIGH_RES(cur_setting->it_value.tv_nsec +=
+		    arch_cycles_to_nsec(sub_expires);
+		    if (cur_setting->it_value.tv_nsec < 0) {
+		    cur_setting->it_value.tv_nsec += NSEC_PER_SEC;
+		    cur_setting->it_value.tv_sec--;}
+		    if ((cur_setting->it_value.tv_nsec - NSEC_PER_SEC) >= 0) {
+		    cur_setting->it_value.tv_nsec -= NSEC_PER_SEC;
+		    cur_setting->it_value.tv_sec++;}
+		    cur_setting->it_interval.tv_nsec +=
+		    arch_cycles_to_nsec(timr->it_sub_incr);
+		    if ((cur_setting->it_interval.tv_nsec - NSEC_PER_SEC) >= 0) {
+		    cur_setting->it_interval.tv_nsec -= NSEC_PER_SEC;
+		    cur_setting->it_interval.tv_sec++;}
+	) ;
 	if (cur_setting->it_value.tv_sec < 0) {
 		cur_setting->it_value.tv_nsec = 1;
 		cur_setting->it_value.tv_sec = 0;
@@ -793,6 +836,7 @@
 
 	/* disable the timer */
 	timr->it_incr = 0;
+	IF_HIGH_RES(timr->it_sub_incr = 0);
 	/* 
 	 * careful here.  If smp we could be in the "fire" routine which will
 	 * be spinning as we hold the lock.  But this is ONLY an SMP issue.
@@ -822,6 +866,7 @@
 	if ((new_setting->it_value.tv_sec == 0) &&
 	    (new_setting->it_value.tv_nsec == 0)) {
 		timr->it_timer.expires = 0;
+		IF_HIGH_RES(timr->it_timer.sub_expires = 0);
 		return 0;
 	}
 
@@ -835,14 +880,19 @@
 	tstotimer(new_setting, timr);
 
 	/*
-	 * For some reason the timer does not fire immediately if expires is
-	 * equal to jiffies, so the timer notify function is called directly.
+
+	 * For some reason the timer does not fire immediately if
+	 * expires is equal to jiffies and the old cascade timer list,
+	 * so the timer notify function is called directly. 
 	 * We do not even queue SIGEV_NONE timers!
+
 	 */
 	if (!(timr->it_sigev_notify & SIGEV_NONE)) {
+#ifndef	 CONFIG_HIGH_RES_TIMERS
 		if (timr->it_timer.expires == jiffies) {
 			timer_notify_task(timr);
 		} else
+#endif
 			add_timer(&timr->it_timer);
 	}
 	return 0;
@@ -903,6 +953,7 @@
 do_timer_delete(struct k_itimer *timer)
 {
 	timer->it_incr = 0;
+	IF_HIGH_RES(timer->it_sub_incr = 0);
 #ifdef CONFIG_SMP
 	if (timer_active(timer) &&
 	    !del_timer(&timer->it_timer) && !timer->it_requeue_pending) {
@@ -1006,9 +1057,25 @@
 	if (clock->clock_get) {
 		return clock->clock_get(tp);
 	}
-
+#ifdef CONFIG_HIGH_RES_TIMERS
+	{
+		unsigned long flags;
+		write_lock_irqsave(&xtime_lock, flags);
+		update_jiffies_sub();
+		update_real_wall_time();
+		tp->tv_sec = xtime.tv_sec;
+		tp->tv_nsec = xtime.tv_nsec;
+		tp->tv_nsec += arch_cycles_to_nsec(sub_jiffie());
+		write_unlock_irqrestore(&xtime_lock, flags);
+		if (tp->tv_nsec > NSEC_PER_SEC) {
+			tp->tv_nsec -= NSEC_PER_SEC;
+			tp->tv_sec++;
+		}
+	}
+#else
 	do_gettimeofday((struct timeval *) tp);
 	tp->tv_nsec *= NSEC_PER_USEC;
+#endif
 	return 0;
 }
 
@@ -1024,10 +1091,10 @@
 {
 	long sub_sec;
 	u64 jiffies_64_f;
-
-#if (BITS_PER_LONG > 32)
-
-	jiffies_64_f = jiffies_64;
+	IF_HIGH_RES(long sub_jiff_offset;
+	    )
+#if (BITS_PER_LONG > 32) && !defined(CONFIG_HIGH_RES_TIMERS)
+	    jiffies_64_f = jiffies_64;
 
 #elif defined(CONFIG_SMP)
 
@@ -1039,6 +1106,9 @@
 		read_lock_irqsave(&xtime_lock, flags);
 		jiffies_64_f = jiffies_64;
 
+		IF_HIGH_RES(sub_jiff_offset =
+			    quick_update_jiffies_sub(jiffies));
+
 		read_unlock_irqrestore(&xtime_lock, flags);
 	}
 #elif ! defined(CONFIG_SMP) && (BITS_PER_LONG < 64)
@@ -1046,13 +1116,30 @@
 	do {
 		jiffies_f = jiffies;
 		barrier();
+		IF_HIGH_RES(sub_jiff_offset =
+			    quick_update_jiffies_sub(jiffies_f));
 		jiffies_64_f = jiffies_64;
 	} while (unlikely(jiffies_f != jiffies));
 
+#else				/* 64 bit long and high-res but no SMP if I did the Venn right */
+	    do {
+		jiffies_64_f = jiffies_64;
+		barrier();
+		sub_jiff_offset = quick_update_jiffies_sub(jiffies_64_f);
+	} while (unlikely(jiffies_64_f != jiffies_64));
+
 #endif
-	tp->tv_sec = div_long_long_rem(jiffies_64_f, HZ, &sub_sec);
+	/*
+	 * Remember that quick_update_jiffies_sub() can return more
+	 * than a jiffies worth of cycles...
+	 */
+	IF_HIGH_RES(while (unlikely(sub_jiff_offset > cycles_per_jiffies)) {
+		    sub_jiff_offset -= cycles_per_jiffies; jiffies_64_f++;}
+	)
+		tp->tv_sec = div_long_long_rem(jiffies_64_f, HZ, &sub_sec);
 
 	tp->tv_nsec = sub_sec * (NSEC_PER_SEC / HZ);
+	IF_HIGH_RES(tp->tv_nsec += arch_cycles_to_nsec(sub_jiff_offset));
 	return 0;
 }
 
@@ -1238,6 +1325,7 @@
 			return -EINTR;
 
 		new_timer.expires = restart_block->arg2;
+		IF_HIGH_RES(new_timer.sub_expires = restart_block->arg3);
 		if (time_before(new_timer.expires, jiffies))
 			return 0;
 	}
@@ -1251,7 +1339,9 @@
 	}
 	do {
 		t = *tsave;
-		if ((abs || !new_timer.expires) &&
+		if ((abs ||
+		     !(new_timer.expires
+		       IF_HIGH_RES(|new_timer.sub_expires))) &&
 		    !(rtn = adjust_abs_time(&posix_clocks[which_clock],
 					    &t, abs))) {
 			/*
@@ -1260,12 +1350,14 @@
 			 * del_timer_sync() will return 0, thus
 			 * active is zero... and so it goes.
 			 */
+			IF_HIGH_RES(new_timer.sub_expires =)
 
-			tstojiffie(&t,
-				   posix_clocks[which_clock].res,
-				   &new_timer.expires);
+			    tstojiffie(&t,
+				       posix_clocks[which_clock].res,
+				       &new_timer.expires);
 		}
-		if (new_timer.expires) {
+		if (new_timer.expires
+		    IF_HIGH_RES(|new_timer.sub_expires)) {
 			current->state = TASK_INTERRUPTIBLE;
 			add_timer(&new_timer);
 
@@ -1283,6 +1375,8 @@
 	if (active) {
 		unsigned long jiffies_f = jiffies;
 
+		IF_HIGH_RES(long sub_jiff =
+			    quick_update_jiffies_sub(jiffies_f));
 		/*
 		 * Always restart abs calls from scratch to pick up any
 		 * clock shifting that happened while we are away.
@@ -1292,6 +1386,9 @@
 
 		jiffies_to_timespec(new_timer.expires - jiffies_f, tsave);
 
+		IF_HIGH_RES(tsave->tv_nsec +=
+			    arch_cycles_to_nsec(new_timer.sub_expires -
+						sub_jiff));
 		while (tsave->tv_nsec < 0) {
 			tsave->tv_nsec += NSEC_PER_SEC;
 			tsave->tv_sec--;
@@ -1304,6 +1401,7 @@
 		restart_block->arg0 = which_clock;
 		restart_block->arg1 = (int)tsave;
 		restart_block->arg2 = new_timer.expires;
+		IF_HIGH_RES(restart_block->arg3 = new_timer.sub_expires);
 		return -ERESTART_RESTARTBLOCK;
 	}
 
Binary files linux-2.5.54-bk6-i386/lib/gen_crc32table and linux/lib/gen_crc32table differ
Binary files linux-2.5.54-bk6-i386/scripts/kallsyms and linux/scripts/kallsyms differ
Binary files linux-2.5.54-bk6-i386/scripts/lxdialog/lxdialog and linux/scripts/lxdialog/lxdialog differ
Binary files linux-2.5.54-bk6-i386/usr/gen_init_cpio and linux/usr/gen_init_cpio differ
Binary files linux-2.5.54-bk6-i386/usr/initramfs_data.cpio.gz and linux/usr/initramfs_data.cpio.gz differ

--------------7F7E5CD37A918538CA13993B--

