Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263008AbTCLDf1>; Tue, 11 Mar 2003 22:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263009AbTCLDf1>; Tue, 11 Mar 2003 22:35:27 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:56570 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S263008AbTCLDfW>;
	Tue, 11 Mar 2003 22:35:22 -0500
Message-ID: <3E6EAD5F.801@mvista.com>
Date: Tue, 11 Mar 2003 19:45:35 -0800
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>, akpm@digeo.com,
       cobra@compuserve.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Re: Runaway cron task on 2.5.63/4 bk?
References: <Pine.LNX.4.44.0303101529040.20597-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0303101529040.20597-100000@home.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------050707010003020506090302"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------050707010003020506090302
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Ok, here is what I have.  I changed nano sleep to use a local 64-bit
value for the target expire time in jiffies.  As much as MAX-INT/2-1
will be put in the timer at any one time. It loops till the target
time is met or exceeded.  The changes affect (clock)nanosleep only and
not timers (they still error out for large values).

I now use the simple u64=(long long) a * b for the mpy so I have 
dropped the sc_math.h stuff (I will bring that round again :).

What do you think?

Oh, the code passes the tests I have, but I have not tried to test for
very large sleep times.
-g


Linus Torvalds wrote:
> On Tue, 11 Mar 2003, Felipe Alfaro Solana wrote:
> 
>> 
>>why not sleep(0)? 
> 
> 
> I think a much more likely (and correct) usage for big sleep values is 
> more something like this:
> 
> 	do_with_timeout(xxx, int timeout)
> 	{
> 		struct timespec ts;
> 
> 		... set up some async event ..
> 		ts.tv_nsec = 0;
> 		ts.tv_sec = timeout;
> 		while (nanosleep(&ts, &ts)) {
> 			if (async event happened)
> 				return happy;
> 		}
> 		.. tear down the async event if it didn't happen ..
> 	}
> 
> and here the natural thing to do in user space is to just make the "no 
> timeout" case be a huge value.
> 
> At which point it is a _bug_ in the kernel if we return early with some 
> random error code.
> 
> 		Linus
> 
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml


--------------050707010003020506090302
Content-Type: text/plain;
 name="hrtimers-large-2.5.64-1.1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hrtimers-large-2.5.64-1.1.patch"

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
--- linux-2.5.64-kb/kernel/posix-timers.c	2003-03-05 15:10:40.000000000 -0800
+++ linux/kernel/posix-timers.c	2003-03-11 16:51:39.000000000 -0800
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
@@ -1208,6 +1214,7 @@
 	struct timespec t;
 	struct timer_list new_timer;
 	struct abs_struct abs_struct = { .list = { .next = 0 } };
+	u64 rq_time = 0;
 	int abs;
 	int rtn = 0;
 	int active;
@@ -1226,11 +1233,12 @@
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
 
@@ -1243,37 +1251,37 @@
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
+		current->state = TASK_INTERRUPTIBLE;
+		add_timer(&new_timer);
+
+		schedule();
 	}
-	while ((active = del_timer_sync(&new_timer)) &&
+	while ((active = del_timer_sync(&new_timer) || 
+		rq_time > get_jiffies_64()) &&
 	       !test_thread_flag(TIF_SIGPENDING));
 
+
 	if (abs_struct.list.next) {
 		spin_lock_irq(&nanosleep_abs_list_lock);
 		list_del(&abs_struct.list);
 		spin_unlock_irq(&nanosleep_abs_list_lock);
 	}
 	if (active) {
-		unsigned long jiffies_f = jiffies;
+		s64 left;
+		unsigned long rmd;
 
 		/*
 		 * Always restart abs calls from scratch to pick up any
@@ -1282,20 +1290,19 @@
 		if (abs)
 			return -ERESTARTNOHAND;
 
-		jiffies_to_timespec(new_timer.expires - jiffies_f, tsave);
+		left = rq_time - get_jiffies_64();
+		if (left < 0)
+			return 0;
+
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
 

--------------050707010003020506090302--

