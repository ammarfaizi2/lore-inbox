Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261317AbTCTITn>; Thu, 20 Mar 2003 03:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261319AbTCTITl>; Thu, 20 Mar 2003 03:19:41 -0500
Received: from packet.digeo.com ([12.110.80.53]:4247 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261317AbTCTIT1>;
	Thu, 20 Mar 2003 03:19:27 -0500
Date: Thu, 20 Mar 2003 00:30:26 -0800
From: Andrew Morton <akpm@digeo.com>
To: george anzinger <george@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] nanosleep() fix for current bk
Message-Id: <20030320003026.53add413.akpm@digeo.com>
In-Reply-To: <3E79754E.8060504@mvista.com>
References: <20030319222633.72eafa25.akpm@digeo.com>
	<3E79754E.8060504@mvista.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Mar 2003 08:30:17.0454 (UTC) FILETIME=[EFD078E0:01C2EEBA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger <george@mvista.com> wrote:
>
> Andrew Morton wrote:
> > This should fix up the various mysterious application failures which people
> > have been seeing (xmms, mplayer, DB2 at least).
> > 
> > A couple of things:
> > 
> > -               if (rq_time <= get_jiffies_64())
> > -                       return 0;
> > 
> > That was unsafe against wrapping.
> 
> Uh, I don't think so.  They are both 64 bits.  It that wraps we will 
> both be long gone ...

Well, someome may decide to set INTIAL_JIFFIES to -300HZ.  It is more
correct.

> > Also I think this calculation:
> > 
> > -		if (abs || !rq_time){
> > -			adjust_abs_time(&posix_clocks[which_clock], &t, abs);
> >  
> > -			tstojiffie(&t, posix_clocks[which_clock].res, &rq_time);
> > -		}
> > 
> > should be outside the loop, yes?
> 
> No.  If abs is set we need to redue the conversion just in case the 
> clock was set (and setting the clock will wake us up early).  If abs 
> is not set, we just do the conversion once, after which rq_time will 
> be non-zero and we will use the old expire time.

OK.   Here's an updated patch.

 kernel/posix-timers.c |   44 ++++++++++++++++++++------------------------
 1 files changed, 20 insertions(+), 24 deletions(-)

diff -puN kernel/posix-timers.c~posix-timers-fixes kernel/posix-timers.c
--- 25/kernel/posix-timers.c~posix-timers-fixes	2003-03-19 22:56:25.000000000 -0800
+++ 25-akpm/kernel/posix-timers.c	2003-03-20 00:15:17.000000000 -0800
@@ -182,8 +182,7 @@ init_posix_timers(void)
 
 __initcall(init_posix_timers);
 
-static inline int
-tstojiffie(struct timespec *tp, int res, u64 *jiff)
+static void tstojiffie(struct timespec *tp, int res, u64 *jiff)
 {
 	unsigned long sec = tp->tv_sec;
 	long nsec = tp->tv_nsec + res - 1;
@@ -212,17 +211,14 @@ tstojiffie(struct timespec *tp, int res,
 	 * Split to jiffie and sub jiffie
 	 */
 	*jiff += nsec / (NSEC_PER_SEC / HZ);
-	/*
-	 * We trust that the optimizer will use the remainder from the 
-	 * above div in the following operation as long as they are close. 
-	 */
-	return 0;
 }
+
 static void
 tstotimer(struct itimerspec *time, struct k_itimer *timer)
 {
 	u64 result;
 	int res = posix_clocks[timer->it_clock].res;
+
 	tstojiffie(&time->it_value, res, &result);
 	timer->it_timer.expires = (unsigned long)result;
 	tstojiffie(&time->it_interval, res, &result);
@@ -1195,6 +1191,7 @@ sys_clock_nanosleep(clockid_t which_cloc
 	return ret;
 
 }
+
 long
 do_clock_nanosleep(clockid_t which_clock, int flags, struct timespec *tsave)
 {
@@ -1225,41 +1222,40 @@ do_clock_nanosleep(clockid_t which_clock
 		rq_time = (rq_time << 32) + restart_block->arg2;
 		if (!rq_time)
 			return -EINTR;
-		if (rq_time <= get_jiffies_64())
-			return 0;
+		left = rq_time - get_jiffies_64();
+		if (left <= 0LL)
+			return 0;	/* Already passed */
 	}
 
 	if (abs && (posix_clocks[which_clock].clock_get !=
 		    posix_clocks[CLOCK_MONOTONIC].clock_get)) {
 		add_wait_queue(&nanosleep_abs_wqueue, &abs_wqueue);
 	}
+
 	do {
 		t = *tsave;
-		if (abs || !rq_time){
+		if (abs || !rq_time) {
 			adjust_abs_time(&posix_clocks[which_clock], &t, abs);
-
 			tstojiffie(&t, posix_clocks[which_clock].res, &rq_time);
 		}
-#if (BITS_PER_LONG < 64)
-		if ((rq_time - get_jiffies_64()) > MAX_JIFFY_OFFSET){
-			new_timer.expires = MAX_JIFFY_OFFSET;
-		}else
-#endif
-		{
-			new_timer.expires = (long)rq_time;
-		}
-		current->state = TASK_INTERRUPTIBLE;
+
+		left = rq_time - get_jiffies_64();
+		if (left >= MAX_JIFFY_OFFSET)
+			left = MAX_JIFFY_OFFSET;
+		if (left < 0)
+			break;
+
+		new_timer.expires = jiffies + left;
+		__set_current_state(TASK_INTERRUPTIBLE);
 		add_timer(&new_timer);
 
 		schedule();
 
 		del_timer_sync(&new_timer);
 		left = rq_time - get_jiffies_64();
-	}
-	while ( (left > 0)  &&
-		!test_thread_flag(TIF_SIGPENDING));
+	} while (left > 0 && !test_thread_flag(TIF_SIGPENDING));
 
-	if( abs_wqueue.task_list.next)
+	if (abs_wqueue.task_list.next)
 		finish_wait(&nanosleep_abs_wqueue, &abs_wqueue);
 
 	if (left > 0) {

_

