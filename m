Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263124AbTCLJ7i>; Wed, 12 Mar 2003 04:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263126AbTCLJ7i>; Wed, 12 Mar 2003 04:59:38 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:58609 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S263124AbTCLJ7a>;
	Wed, 12 Mar 2003 04:59:30 -0500
Message-ID: <3E6F0766.9090902@mvista.com>
Date: Wed, 12 Mar 2003 02:09:42 -0800
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: torvalds@transmeta.com, felipe_alfaro@linuxmail.org, cobra@compuserve.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Runaway cron task on 2.5.63/4 bk?
References: <Pine.LNX.4.44.0303101529040.20597-100000@home.transmeta.com>	<3E6EAD5F.801@mvista.com> <20030311205749.436eea7a.akpm@digeo.com>
In-Reply-To: <20030311205749.436eea7a.akpm@digeo.com>
Content-Type: multipart/mixed;
 boundary="------------090303060108030800010507"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------090303060108030800010507
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> george anzinger <george@mvista.com> wrote:
> 
>>Ok, here is what I have.  I changed nano sleep to use a local 64-bit
>>value for the target expire time in jiffies.  As much as MAX-INT/2-1
>>will be put in the timer at any one time. It loops till the target
>>time is met or exceeded.  The changes affect (clock)nanosleep only and
>>not timers (they still error out for large values).
> 
> 
> Seem sane.
> 
> 
>>I now use the simple u64=(long long) a * b for the mpy so I have 
>>dropped the sc_math.h stuff (I will bring that round again :).
> 
> 
> Resistance shall be unflagging!
> 
> 
>>What do you think?
> 
> 
> Sorry, but this little bit:
> 
> 	while ((active = del_timer_sync(&new_timer) || 
> 		rq_time > get_jiffies_64()) &&
>  	       !test_thread_flag(TIF_SIGPENDING));
>  
> 
>  	if (abs_struct.list.next) {
>  		spin_lock_irq(&nanosleep_abs_list_lock);
>  		list_del(&abs_struct.list);
>  		spin_unlock_irq(&nanosleep_abs_list_lock);
>  	}
>  	if (active) {
> 
> should be dragged out and mercifully shot.  Is it possible to make that while
> loop a little clearer?

I hung it!  It was less of a mess to clean up :)
> 
> The abs_list exactly duplicates the kernel's existing waitqueue
> functionality.  You can use prepare_to_wait()/finish_wait() there.

Well, almost.  Wants to mess with the state, but, try the attached.
> 
> posix_timers_id, posix_clocks[], nanosleep_abs_list_lock and
> nanosleep_abs_list should be static to posix-timers.c.

And a few more :)

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

--------------090303060108030800010507
Content-Type: text/plain;
 name="hrtimers-large-2.5.64-1.2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hrtimers-large-2.5.64-1.2.patch"

diff -urP -I '\$Id:.*Exp \$' -X /usr/src/patch.exclude linux-2.5.64-kb/include/linux/thread_info.h linux/include/linux/thread_info.h
--- linux-2.5.64-kb/include/linux/thread_info.h	2002-12-11 06:25:32.000000000 -0800
+++ linux/include/linux/thread_info.h	2003-03-10 16:39:52.000000000 -0800
@@ -12,7 +12,7 @@
  */
 struct restart_block {
 	long (*fn)(struct restart_block *);
-	unsigned long arg0, arg1, arg2;
+	unsigned long arg0, arg1, arg2, arg3;
 };
 
 extern long do_no_restart_syscall(struct restart_block *parm);
diff -urP -I '\$Id:.*Exp \$' -X /usr/src/patch.exclude linux-2.5.64-kb/kernel/posix-timers.c linux/kernel/posix-timers.c
--- linux-2.5.64-kb/kernel/posix-timers.c	2003-03-12 01:57:56.000000000 -0800
+++ linux/kernel/posix-timers.c	2003-03-12 02:04:31.000000000 -0800
@@ -9,7 +9,6 @@
 /* These are all the functions necessary to implement 
  * POSIX clocks & timers
  */
-
 #include <linux/mm.h>
 #include <linux/smp_lock.h>
 #include <linux/interrupt.h>
@@ -23,6 +22,7 @@
 #include <linux/compiler.h>
 #include <linux/idr.h>
 #include <linux/posix-timers.h>
+#include <linux/wait.h>
 
 #ifndef div_long_long_rem
 #include <asm/div64.h>
@@ -56,8 +56,8 @@
    * Lets keep our timers in a slab cache :-)
  */
 static kmem_cache_t *posix_timers_cache;
-struct idr posix_timers_id;
-spinlock_t idr_lock = SPIN_LOCK_UNLOCKED;
+static struct idr posix_timers_id;
+static spinlock_t idr_lock = SPIN_LOCK_UNLOCKED;
 
 /*
  * Just because the timer is not in the timer list does NOT mean it is
@@ -130,7 +130,7 @@
  *	    which we beg off on and pass to do_sys_settimeofday().
  */
 
-struct k_clock posix_clocks[MAX_CLOCKS];
+static struct k_clock posix_clocks[MAX_CLOCKS];
 
 #define if_clock_do(clock_fun, alt_fun,parms)	(! clock_fun)? alt_fun parms :\
 							      clock_fun parms
@@ -183,7 +183,7 @@
 __initcall(init_posix_timers);
 
 static inline int
-tstojiffie(struct timespec *tp, int res, unsigned long *jiff)
+tstojiffie(struct timespec *tp, int res, u64 *jiff)
 {
 	unsigned long sec = tp->tv_sec;
 	long nsec = tp->tv_nsec + res - 1;
@@ -203,7 +203,7 @@
 	 * below.  Here it is enough to just discard the high order
 	 * bits.  
 	 */
-	*jiff = HZ * sec;
+	*jiff = (u64)sec * HZ;
 	/*
 	 * Do the res thing. (Don't forget the add in the declaration of nsec) 
 	 */
@@ -221,9 +221,12 @@
 static void
 tstotimer(struct itimerspec *time, struct k_itimer *timer)
 {
+	u64 result;
 	int res = posix_clocks[timer->it_clock].res;
-	tstojiffie(&time->it_value, res, &timer->it_timer.expires);
-	tstojiffie(&time->it_interval, res, &timer->it_incr);
+	tstojiffie(&time->it_value, res, &result);
+	timer->it_timer.expires = (unsigned long)result;
+	tstojiffie(&time->it_interval, res, &result);
+	timer->it_incr = (unsigned long)result;
 }
 
 static void
@@ -1020,6 +1023,9 @@
  * Note also that the while loop assures that the sub_jiff_offset
  * will be less than a jiffie, thus no need to normalize the result.
  * Well, not really, if called with ints off :(
+
+ * HELP, this code should make an attempt at resolution beyond the 
+ * jiffie.  Trouble is this is "arch" dependent...
  */
 
 int
@@ -1127,26 +1133,14 @@
  * holds (or has held for it) a write_lock_irq( xtime_lock) and is 
  * called from the timer bh code.  Thus we need the irq save locks.
  */
-spinlock_t nanosleep_abs_list_lock = SPIN_LOCK_UNLOCKED;
 
-struct list_head nanosleep_abs_list = LIST_HEAD_INIT(nanosleep_abs_list);
+static DECLARE_WAIT_QUEUE_HEAD(nanosleep_abs_wqueue);
 
-struct abs_struct {
-	struct list_head list;
-	struct task_struct *t;
-};
 
 void
 clock_was_set(void)
 {
-	struct list_head *pos;
-	unsigned long flags;
-
-	spin_lock_irqsave(&nanosleep_abs_list_lock, flags);
-	list_for_each(pos, &nanosleep_abs_list) {
-		wake_up_process(list_entry(pos, struct abs_struct, list)->t);
-	}
-	spin_unlock_irqrestore(&nanosleep_abs_list_lock, flags);
+	wake_up_all(&nanosleep_abs_wqueue);
 }
 
 long clock_nanosleep_restart(struct restart_block *restart_block);
@@ -1201,19 +1195,19 @@
 	return ret;
 
 }
-
 long
 do_clock_nanosleep(clockid_t which_clock, int flags, struct timespec *tsave)
 {
 	struct timespec t;
 	struct timer_list new_timer;
-	struct abs_struct abs_struct = { .list = { .next = 0 } };
+	DECLARE_WAITQUEUE(abs_wqueue, current);
+	u64 rq_time = 0;
+	s64 left;
 	int abs;
-	int rtn = 0;
-	int active;
 	struct restart_block *restart_block =
 	    &current_thread_info()->restart_block;
 
+	abs_wqueue.flags = 0;
 	init_timer(&new_timer);
 	new_timer.expires = 0;
 	new_timer.data = (unsigned long) current;
@@ -1226,54 +1220,50 @@
 		 * time and continue.
 		 */
 		restart_block->fn = do_no_restart_syscall;
-		if (!restart_block->arg2)
-			return -EINTR;
 
-		new_timer.expires = restart_block->arg2;
-		if (time_before(new_timer.expires, jiffies))
+		rq_time = restart_block->arg3;
+		rq_time = (rq_time << 32) + restart_block->arg2;
+		if (!rq_time)
+			return -EINTR;
+		if (rq_time <= get_jiffies_64())
 			return 0;
 	}
 
 	if (abs && (posix_clocks[which_clock].clock_get !=
 		    posix_clocks[CLOCK_MONOTONIC].clock_get)) {
-		spin_lock_irq(&nanosleep_abs_list_lock);
-		list_add(&abs_struct.list, &nanosleep_abs_list);
-		abs_struct.t = current;
-		spin_unlock_irq(&nanosleep_abs_list_lock);
+		add_wait_queue(&nanosleep_abs_wqueue, &abs_wqueue);
 	}
 	do {
 		t = *tsave;
-		if ((abs || !new_timer.expires) &&
-		    !(rtn = adjust_abs_time(&posix_clocks[which_clock],
-					    &t, abs))) {
-			/*
-			 * On error, we don't set up the timer so
-			 * we don't arm the timer so
-			 * del_timer_sync() will return 0, thus
-			 * active is zero... and so it goes.
-			 */
+		if (abs || !rq_time){
+			adjust_abs_time(&posix_clocks[which_clock], &t, abs);
 
-			tstojiffie(&t,
-				   posix_clocks[which_clock].res,
-				   &new_timer.expires);
+			tstojiffie(&t, posix_clocks[which_clock].res, &rq_time);
 		}
-		if (new_timer.expires) {
-			current->state = TASK_INTERRUPTIBLE;
-			add_timer(&new_timer);
-
-			schedule();
+#if (BITS_PER_LONG < 64)
+		if ((rq_time - get_jiffies_64()) > MAX_JIFFY_OFFSET){
+			new_timer.expires = MAX_JIFFY_OFFSET;
+		}else
+#endif
+		{
+			new_timer.expires = (long)rq_time;
 		}
-	}
-	while ((active = del_timer_sync(&new_timer)) &&
-	       !test_thread_flag(TIF_SIGPENDING));
+		current->state = TASK_INTERRUPTIBLE;
+		add_timer(&new_timer);
+
+		schedule();
 
-	if (abs_struct.list.next) {
-		spin_lock_irq(&nanosleep_abs_list_lock);
-		list_del(&abs_struct.list);
-		spin_unlock_irq(&nanosleep_abs_list_lock);
+		del_timer_sync(&new_timer);
+		left = rq_time - get_jiffies_64();
 	}
-	if (active) {
-		long jiffies_left;
+	while ( (left > 0)  &&
+		!test_thread_flag(TIF_SIGPENDING));
+
+	if( abs_wqueue.task_list.next)
+		finish_wait(&nanosleep_abs_wqueue, &abs_wqueue);
+
+	if (left > 0) {
+		unsigned long rmd;
 
 		/*
 		 * Always restart abs calls from scratch to pick up any
@@ -1282,29 +1272,19 @@
 		if (abs)
 			return -ERESTARTNOHAND;
 
-		jiffies_left = new_timer.expires - jiffies;
-
-		if (jiffies_left < 0)
-			return 0;
-
-		jiffies_to_timespec(jiffies_left, tsave);
+		tsave->tv_sec = div_long_long_rem(left, HZ, &rmd);
+		tsave->tv_nsec = rmd * (NSEC_PER_SEC / HZ);
 
-		while (tsave->tv_nsec < 0) {
-			tsave->tv_nsec += NSEC_PER_SEC;
-			tsave->tv_sec--;
-		}
-		if (tsave->tv_sec < 0) {
-			tsave->tv_sec = 0;
-			tsave->tv_nsec = 1;
-		}
 		restart_block->fn = clock_nanosleep_restart;
 		restart_block->arg0 = which_clock;
 		restart_block->arg1 = (unsigned long)tsave;
-		restart_block->arg2 = new_timer.expires;
+		restart_block->arg2 = rq_time & 0xffffffffLL;
+		restart_block->arg3 = rq_time >> 32;
+
 		return -ERESTART_RESTARTBLOCK;
 	}
 
-	return rtn;
+	return 0;
 }
 /*
  * This will restart either clock_nanosleep or clock_nanosleep

--------------090303060108030800010507--

