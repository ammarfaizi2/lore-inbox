Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263975AbTDNX6y (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 19:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263996AbTDNX6y (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 19:58:54 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:48887 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S263975AbTDNX6p (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 19:58:45 -0400
Message-ID: <3E9B4DCD.3070204@mvista.com>
Date: Mon, 14 Apr 2003 17:09:49 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix POSIX timers to give CLOCK_MONOTONIC full resolution
 and tie it to xtime instead of jiffies
Content-Type: multipart/mixed;
 boundary="------------010904090407040806020408"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------010904090407040806020408
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The POSIX CLOCK_MONOTONIC currently has only 1/HZ resolution. 
Further, it is tied to jiffies (i.e. is a restatment of jiffies) 
rather than "xtime" or the gettimeofday() clock.

This patch changes CLOCK_MONOTONIC to be a restatment of 
gettimeofday() plus an offset to remove any clock setting activity 
from CLOCK_MONOTONIC.  An offset is kept that represents the 
difference between CLOCK_MONOTONIC and gettimeofday().  This offset is 
updated when ever the gettimeofday() clock is set to back the clock 
setting change out of CLOCK_MONOTONIC (which by the standard, can not 
be set).

With this change CLOCK_REALTIME (a direct restatement of 
gettimeofday()), CLOCK_MONOTONIC and gettimeofday() will all tick at 
the same time and with the same rate.  And all will be affected by NTP 
adjustments (save those which actually set the time).
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

--------------010904090407040806020408
Content-Type: text/plain;
 name="hrtimers-mono-2.5.67-bk3-1.0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hrtimers-mono-2.5.67-bk3-1.0.patch"

diff -urP -I '\$Id:.*Exp \$' -X /usr/src/patch.exclude linux-2.5.67-bk3-fix/arch/i386/kernel/time.c linux/arch/i386/kernel/time.c
--- linux-2.5.67-bk3-fix/arch/i386/kernel/time.c	2003-04-09 18:32:56.000000000 -0700
+++ linux/arch/i386/kernel/time.c	2003-04-12 02:49:36.000000000 -0700
@@ -121,15 +121,28 @@
 	 * made, and then undo it!
 	 */
 	tv->tv_usec -= timer->get_offset();
-	tv->tv_usec -= (jiffies - wall_jiffies) * (1000000 / HZ);
+	tv->tv_usec -= (jiffies - wall_jiffies) * (USEC_PER_SEC / HZ);
 
 	while (tv->tv_usec < 0) {
-		tv->tv_usec += 1000000;
+		tv->tv_usec += USEC_PER_SEC;
 		tv->tv_sec--;
 	}
+	tv->tv_usec *= NSEC_PER_USEC;
+
+	wall_to_monotonic.tv_sec += xtime.tv_sec - tv->tv_sec;
+	wall_to_monotonic.tv_nsec += xtime.tv_nsec - tv->tv_usec;
+
+	if(wall_to_monotonic.tv_nsec > NSEC_PER_SEC){
+		wall_to_monotonic.tv_nsec -= NSEC_PER_SEC;
+		wall_to_monotonic.tv_sec++;
+	}
+	if(wall_to_monotonic.tv_nsec < 0){
+		wall_to_monotonic.tv_nsec += NSEC_PER_SEC;
+		wall_to_monotonic.tv_sec--;
+	}
 
 	xtime.tv_sec = tv->tv_sec;
-	xtime.tv_nsec = (tv->tv_usec * 1000);
+	xtime.tv_nsec = tv->tv_usec;
 	time_adjust = 0;		/* stop active adjtime() */
 	time_status |= STA_UNSYNC;
 	time_maxerror = NTP_PHASE_LIMIT;
@@ -401,7 +414,9 @@
 {
 	
 	xtime.tv_sec = get_cmos_time();
-	xtime.tv_nsec = 0;
+	wall_to_monotonic.tv_sec = -xtime.tv_sec + INITIAL_JIFFIES / HZ;
+	xtime.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
+	wall_to_monotonic.tv_nsec = 0;
 
 
 	timer = select_timer();
diff -urP -I '\$Id:.*Exp \$' -X /usr/src/patch.exclude linux-2.5.67-bk3-fix/include/linux/time.h linux/include/linux/time.h
--- linux-2.5.67-bk3-fix/include/linux/time.h	2003-04-12 02:16:29.000000000 -0700
+++ linux/include/linux/time.h	2003-04-12 02:49:36.000000000 -0700
@@ -140,6 +140,7 @@
 }
 
 extern struct timespec xtime;
+extern struct timespec wall_to_monotonic;
 extern seqlock_t xtime_lock;
 
 static inline unsigned long get_seconds(void)
@@ -200,6 +201,9 @@
 #define CLOCK_MONOTONIC_HR	  5
 
 #define MAX_CLOCKS 6
+#define CLOCKS_MASK  (CLOCK_REALTIME | CLOCK_MONOTONIC | \
+                     CLOCK_REALTIME_HR | CLOCK_MONOTONIC_HR)
+#define CLOCKS_MONO (CLOCK_MONOTONIC & CLOCK_MONOTONIC_HR)
 
 /*
  * The various flags for setting POSIX.1b interval timers.
diff -urP -I '\$Id:.*Exp \$' -X /usr/src/patch.exclude linux-2.5.67-bk3-fix/kernel/posix-timers.c linux/kernel/posix-timers.c
--- linux-2.5.67-bk3-fix/kernel/posix-timers.c	2003-04-12 02:34:42.000000000 -0700
+++ linux/kernel/posix-timers.c	2003-04-14 16:10:43.000000000 -0700
@@ -48,7 +48,7 @@
  * The idr_get_new *may* call slab for more memory so it must not be
  * called under a spin lock.  Likewise idr_remore may release memory
  * (but it may be ok to do this under a lock...).
- * idr_find is just a memory look up and is quite fast.  A zero return
+ * idr_find is just a memory look up and is quite fast.  A -1 return
  * indicates that the requested id does not exist.
  */
 
@@ -82,6 +82,7 @@
  * For some reason mips/mips64 define the SIGEV constants plus 128.
  * Here we define a mask to get rid of the common bits.	 The
  * optimizer should make this costless to all but mips.
+ * Note that no common bits (the non-mips case) will give 0xffffffff.
  */
 #define MIPS_SIGEV ~(SIGEV_NONE & \
 		      SIGEV_SIGNAL & \
@@ -91,7 +92,7 @@
  * The timer ID is turned into a timer address by idr_find().
  * Verifying a valid ID consists of:
  *
- * a) checking that idr_find() returns other than zero.
+ * a) checking that idr_find() returns other than -1.
  * b) checking that the timer id matches the one in the timer itself.
  * c) that the timer owner is in the callers thread group.
  */
@@ -160,6 +161,8 @@
 
 void register_posix_clock(int clock_id, struct k_clock *new_clock);
 static int do_posix_gettime(struct k_clock *clock, struct timespec *tp);
+static u64 do_posix_clock_monotonic_gettime_parts(
+	struct timespec *tp, struct timespec *mo);
 int do_posix_clock_monotonic_gettime(struct timespec *tp);
 int do_posix_clock_monotonic_settime(struct timespec *tp);
 static struct k_itimer *lock_timer(timer_t timer_id, unsigned long *flags);
@@ -190,7 +193,7 @@
 
 static void tstojiffie(struct timespec *tp, int res, u64 *jiff)
 {
-	unsigned long sec = tp->tv_sec;
+	long sec = tp->tv_sec;
 	long nsec = tp->tv_nsec + res - 1;
 
 	if (nsec > NSEC_PER_SEC) {
@@ -208,7 +211,7 @@
 	 * below.  Here it is enough to just discard the high order
 	 * bits.
 	 */
-	*jiff = (u64)sec * HZ;
+	*jiff = (s64)sec * HZ;
 	/*
 	 * Do the res thing. (Don't forget the add in the declaration of nsec)
 	 */
@@ -219,17 +222,6 @@
 	*jiff += nsec / (NSEC_PER_SEC / HZ);
 }
 
-static void tstotimer(struct itimerspec *time, struct k_itimer *timer)
-{
-	u64 result;
-	int res = posix_clocks[timer->it_clock].res;
-
-	tstojiffie(&time->it_value, res, &result);
-	timer->it_timer.expires = (unsigned long)result;
-	tstojiffie(&time->it_interval, res, &result);
-	timer->it_incr = (unsigned long)result;
-}
-
 static void schedule_next_timer(struct k_itimer *timr)
 {
 	struct now_struct now;
@@ -693,57 +685,81 @@
  * If it is relative time, we need to add the current (CLOCK_MONOTONIC)
  * time to it to get the proper time for the timer.
  */
-static int adjust_abs_time(struct k_clock *clock, struct timespec *tp, int abs)
+static int adjust_abs_time(struct k_clock *clock, struct timespec *tp, 
+			   int abs, u64 *exp)
 {
 	struct timespec now;
-	struct timespec oc;
-	do_posix_clock_monotonic_gettime(&now);
-
-	if (!abs || (posix_clocks[CLOCK_MONOTONIC].clock_get !=
-							clock->clock_get)) {
-		if (abs)
-			do_posix_gettime(clock, &oc);
-		else
-			oc.tv_nsec = oc.tv_sec = 0;
-
-		tp->tv_sec += now.tv_sec - oc.tv_sec;
-		tp->tv_nsec += now.tv_nsec - oc.tv_nsec;
+	struct timespec oc = *tp;
+	struct timespec wall_to_mono;
+	u64 jiffies_64_f;
+	int rtn =0;
 
+	if(abs){
+		/*
+		 * The mask pick up the 4 basic clocks 
+		 */
+		if(! (clock - &posix_clocks[0]) & ~CLOCKS_MASK){
+			jiffies_64_f = do_posix_clock_monotonic_gettime_parts(
+				&now,  &wall_to_mono);
+			/*
+			 * If we are doing a MONOTONIC clock
+			 */
+			if((clock - &posix_clocks[0]) & CLOCKS_MONO){
+				now.tv_sec += wall_to_mono.tv_sec;
+				now.tv_nsec += wall_to_mono.tv_nsec;
+			}
+		}else{
+			/*
+			 * Not one of the basic clocks
+			 */
+			do_posix_gettime(clock, &now);	
+			jiffies_64_f = get_jiffies_64();
+		}
+		/*
+		 * Take away now to get delta
+		 */
+		oc.tv_sec -= now.tv_sec;
+		oc.tv_nsec -= now.tv_nsec;
 		/*
 		 * Normalize...
 		 */
-		if ((tp->tv_nsec - NSEC_PER_SEC) >= 0) {
-			tp->tv_nsec -= NSEC_PER_SEC;
-			tp->tv_sec++;
+		while ((oc.tv_nsec - NSEC_PER_SEC) >= 0) {
+			oc.tv_nsec -= NSEC_PER_SEC;
+			oc.tv_sec++;
 		}
-		if ((tp->tv_nsec) < 0) {
-			tp->tv_nsec += NSEC_PER_SEC;
-			tp->tv_sec--;
+		while ((oc.tv_nsec) < 0) {
+			oc.tv_nsec += NSEC_PER_SEC;
+			oc.tv_sec--;
 		}
+	}else{
+		jiffies_64_f = get_jiffies_64();
 	}
 	/*
-	 * Check if the requested time is prior to now (if so set now) or
-	 * is more than the timer code can handle (if so we error out).
-	 * The (unsigned) catches the case of prior to "now" with the same
-	 * test.  Only on failure do we sort out what happened, and then
-	 * we use the (unsigned) to error out negative seconds.
+	 * Check if the requested time is prior to now (if so set now)
 	 */
-	if ((unsigned) (tp->tv_sec - now.tv_sec) > (MAX_JIFFY_OFFSET / HZ)) {
-		if ((unsigned) tp->tv_sec < now.tv_sec) {
-			tp->tv_sec = now.tv_sec;
-			tp->tv_nsec = now.tv_nsec;
-		} else
+	if( oc.tv_sec < 0)
+		oc.tv_sec = oc.tv_nsec = 0;
+	tstojiffie(&oc, clock->res, exp);
+
+	/*
+	 * Check if the requested time is more than the timer code
+	 * can handle (if so we error out but return the value too).
+	 */
+	if ( *exp > ((u64)MAX_JIFFY_OFFSET ))
 			/*
 			 * This is a considered response, not exactly in
 			 * line with the standard (in fact it is silent on
-			 * possible overflows).  We assume such a large
+			 * possible overflows).  We assume such a large 
 			 * value is ALMOST always a programming error and
 			 * try not to compound it by setting a really dumb
 			 * value.
 			 */
-			return -EINVAL;
-	}
-	return 0;
+			rtn = -EINVAL;
+	/*
+	 * return the actual jiffies expire time, full 64 bits
+	 */
+	*exp += jiffies_64_f;
+	return rtn;
 }
 
 /* Set a POSIX.1b interval timer. */
@@ -753,6 +769,7 @@
 		 struct itimerspec *new_setting, struct itimerspec *old_setting)
 {
 	struct k_clock *clock = &posix_clocks[timr->it_clock];
+	u64 expire_64;
 
 	if (old_setting)
 		do_timer_gettime(timr, old_setting);
@@ -790,14 +807,15 @@
 		return 0;
 	}
 
-	if ((flags & TIMER_ABSTIME) &&
-	    (clock->clock_get != do_posix_clock_monotonic_gettime))
-		// FIXME: what is this?
-		;
 	if (adjust_abs_time(clock,
-			    &new_setting->it_value, flags & TIMER_ABSTIME))
+			    &new_setting->it_value, flags & TIMER_ABSTIME, 
+			    &expire_64)) {
 		return -EINVAL;
-	tstotimer(new_setting, timr);
+	}
+	timr->it_timer.expires = (unsigned long)expire_64;	
+	tstojiffie(&new_setting->it_interval, clock->res, &expire_64);
+	timr->it_incr = (unsigned long)expire_64;
+
 
 	/*
 	 * For some reason the timer does not fire immediately if expires is
@@ -966,30 +984,46 @@
  * Note also that the while loop assures that the sub_jiff_offset
  * will be less than a jiffie, thus no need to normalize the result.
  * Well, not really, if called with ints off :(
- *
- * HELP, this code should make an attempt at resolution beyond the
- * jiffie.  Trouble is this is "arch" dependent...
  */
 
-int do_posix_clock_monotonic_gettime(struct timespec *tp)
+static u64 do_posix_clock_monotonic_gettime_parts(
+	struct timespec *tp, struct timespec *mo)
 {
-	long sub_sec;
-	u64 jiffies_64_f;
-
-#if (BITS_PER_LONG > 32)
-	jiffies_64_f = jiffies_64;
-#else
+	u64 jiff;
+	struct timeval tpv;
 	unsigned int seq;
 
 	do {
 		seq = read_seqbegin(&xtime_lock);
-		jiffies_64_f = jiffies_64;
+		do_gettimeofday(&tpv);
+		*mo = wall_to_monotonic;
+		jiff = jiffies_64;
 
-	} while (read_seqretry(&xtime_lock, seq));
-#endif
-	tp->tv_sec = div_long_long_rem(jiffies_64_f, HZ, &sub_sec);
-	tp->tv_nsec = sub_sec * (NSEC_PER_SEC / HZ);
+	}while(  read_seqretry(&xtime_lock, seq));
 
+	/*
+	 * Love to get this before it is converted to usec.
+	 * It would save a div AND a mpy.
+	 */
+	tp->tv_sec = tpv.tv_sec;
+	tp->tv_nsec = tpv.tv_usec * NSEC_PER_USEC;
+
+	return jiff;
+}
+
+int do_posix_clock_monotonic_gettime(struct timespec *tp)
+{
+	struct timespec wall_to_mono;
+
+	do_posix_clock_monotonic_gettime_parts(tp, &wall_to_mono);
+
+	tp->tv_sec += wall_to_mono.tv_sec;
+	tp->tv_nsec += wall_to_mono.tv_nsec;
+
+	if( (tp->tv_nsec - NSEC_PER_SEC) > 0){
+		tp->tv_nsec -= NSEC_PER_SEC;
+		tp->tv_sec++;
+	}
 	return 0;
 }
 
@@ -1140,7 +1174,7 @@
 	struct timespec t;
 	struct timer_list new_timer;
 	DECLARE_WAITQUEUE(abs_wqueue, current);
-	u64 rq_time = 0;
+	u64 rq_time = (u64)0;
 	s64 left;
 	int abs;
 	struct restart_block *restart_block =
@@ -1165,7 +1199,7 @@
 		if (!rq_time)
 			return -EINTR;
 		left = rq_time - get_jiffies_64();
-		if (left <= 0LL)
+		if (left <= (s64)0)
 			return 0;	/* Already passed */
 	}
 
@@ -1176,14 +1210,14 @@
 	do {
 		t = *tsave;
 		if (abs || !rq_time) {
-			adjust_abs_time(&posix_clocks[which_clock], &t, abs);
-			tstojiffie(&t, posix_clocks[which_clock].res, &rq_time);
+			adjust_abs_time(&posix_clocks[which_clock], &t, abs,
+					&rq_time);
 		}
 
 		left = rq_time - get_jiffies_64();
-		if (left >= MAX_JIFFY_OFFSET)
-			left = MAX_JIFFY_OFFSET;
-		if (left < 0)
+		if (left >= (s64)MAX_JIFFY_OFFSET)
+			left = (s64)MAX_JIFFY_OFFSET;
+		if (left < (s64)0)
 			break;
 
 		new_timer.expires = jiffies + left;
@@ -1194,12 +1228,12 @@
 
 		del_timer_sync(&new_timer);
 		left = rq_time - get_jiffies_64();
-	} while (left > 0 && !test_thread_flag(TIF_SIGPENDING));
+	} while (left > (s64)0 && !test_thread_flag(TIF_SIGPENDING));
 
 	if (abs_wqueue.task_list.next)
 		finish_wait(&nanosleep_abs_wqueue, &abs_wqueue);
 
-	if (left > 0) {
+	if (left > (s64)0) {
 		unsigned long rmd;
 
 		/*
diff -urP -I '\$Id:.*Exp \$' -X /usr/src/patch.exclude linux-2.5.67-bk3-fix/kernel/timer.c linux/kernel/timer.c
--- linux-2.5.67-bk3-fix/kernel/timer.c	2003-04-12 02:16:30.000000000 -0700
+++ linux/kernel/timer.c	2003-04-12 02:49:36.000000000 -0700
@@ -440,8 +440,16 @@
 unsigned long tick_usec = TICK_USEC; 		/* ACTHZ   period (usec) */
 unsigned long tick_nsec = TICK_NSEC(TICK_USEC);	/* USER_HZ period (nsec) */
 
-/* The current time */
+/* 
+ * The current time 
+ * wall_to_monotonic is what we need to add to xtime (or xtime corrected 
+ * for sub jiffie times) to get to monotonic time.  Monotonic is pegged at zero
+ * at zero at system boot time, so wall_to_monotonic will be negative,
+ * however, we will ALWAYS keep the tv_nsec part positive so we can use
+ * the usual normalization.
+ */
 struct timespec xtime __attribute__ ((aligned (16)));
+struct timespec wall_to_monotonic __attribute__ ((aligned (16)));
 
 /* Don't completely fail for HZ > 500.  */
 int tickadj = 500/HZ ? : 1;		/* microsecs */
@@ -507,6 +515,7 @@
     case TIME_INS:
 	if (xtime.tv_sec % 86400 == 0) {
 	    xtime.tv_sec--;
+	    wall_to_monotonic.tv_sec++;
 	    time_state = TIME_OOP;
 	    clock_was_set();
 	    printk(KERN_NOTICE "Clock: inserting leap second 23:59:60 UTC\n");
@@ -516,6 +525,7 @@
     case TIME_DEL:
 	if ((xtime.tv_sec + 1) % 86400 == 0) {
 	    xtime.tv_sec++;
+	    wall_to_monotonic.tv_sec--;
 	    time_state = TIME_WAIT;
 	    clock_was_set();
 	    printk(KERN_NOTICE "Clock: deleting leap second 23:59:59 UTC\n");
Binary files linux-2.5.67-bk3-fix/usr/initramfs_data.cpio and linux/usr/initramfs_data.cpio differ
Binary files linux-2.5.67-bk3-fix/usr/initramfs_data.cpio.gz and linux/usr/initramfs_data.cpio.gz differ

--------------010904090407040806020408--

