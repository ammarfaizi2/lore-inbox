Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261310AbTCTHun>; Thu, 20 Mar 2003 02:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261312AbTCTHun>; Thu, 20 Mar 2003 02:50:43 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:65264 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S261310AbTCTHuk>;
	Thu, 20 Mar 2003 02:50:40 -0500
Message-ID: <3E79754E.8060504@mvista.com>
Date: Thu, 20 Mar 2003 00:01:18 -0800
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] nanosleep() fix for current bk
References: <20030319222633.72eafa25.akpm@digeo.com>
In-Reply-To: <20030319222633.72eafa25.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> This should fix up the various mysterious application failures which people
> have been seeing (xmms, mplayer, DB2 at least).
> 
> A couple of things:
> 
> -               if (rq_time <= get_jiffies_64())
> -                       return 0;
> 
> That was unsafe against wrapping.

Uh, I don't think so.  They are both 64 bits.  It that wraps we will 
both be long gone ...
> 
> 
> -		if ((rq_time - get_jiffies_64()) > MAX_JIFFY_OFFSET){
> -			new_timer.expires = MAX_JIFFY_OFFSET;
> 
> This is the big one.  get_jiffies_64() returns unsigned, so the whole
> expression is promoted to unsigned.  So if rq_time happens to be _before_
> jiffies_64 we end up sleeping for 0x7ffffffe jiffies.

Yes, this needs to be signed...
> 
> Also I think this calculation:
> 
> -		if (abs || !rq_time){
> -			adjust_abs_time(&posix_clocks[which_clock], &t, abs);
>  
> -			tstojiffie(&t, posix_clocks[which_clock].res, &rq_time);
> -		}
> 
> should be outside the loop, yes?

No.  If abs is set we need to redue the conversion just in case the 
clock was set (and setting the clock will wake us up early).  If abs 
is not set, we just do the conversion once, after which rq_time will 
be non-zero and we will use the old expire time.
> 
> The thing I have not explained is why the failure could only be triggered
> after 5 minutes uptime, when jiffies has become positive and when jiffies_64
> is using the upper 32 bits.  Can you see it??
> 
> 
>  kernel/posix-timers.c |   49 ++++++++++++++++++++++---------------------------
>  1 files changed, 22 insertions(+), 27 deletions(-)
> 
> diff -puN kernel/posix-timers.c~posix-timers-fixes kernel/posix-timers.c
> --- 25/kernel/posix-timers.c~posix-timers-fixes	2003-03-19 20:39:59.000000000 -0800
> +++ 25-akpm/kernel/posix-timers.c	2003-03-19 21:56:21.000000000 -0800
> @@ -182,8 +182,7 @@ init_posix_timers(void)
>  
>  __initcall(init_posix_timers);
>  
> -static inline int
> -tstojiffie(struct timespec *tp, int res, u64 *jiff)
> +static void tstojiffie(struct timespec *tp, int res, u64 *jiff)
>  {
>  	unsigned long sec = tp->tv_sec;
>  	long nsec = tp->tv_nsec + res - 1;
> @@ -212,17 +211,14 @@ tstojiffie(struct timespec *tp, int res,
>  	 * Split to jiffie and sub jiffie
>  	 */
>  	*jiff += nsec / (NSEC_PER_SEC / HZ);
> -	/*
> -	 * We trust that the optimizer will use the remainder from the 
> -	 * above div in the following operation as long as they are close. 
> -	 */
> -	return 0;
>  }
> +
>  static void
>  tstotimer(struct itimerspec *time, struct k_itimer *timer)
>  {
>  	u64 result;
>  	int res = posix_clocks[timer->it_clock].res;
> +
>  	tstojiffie(&time->it_value, res, &result);
>  	timer->it_timer.expires = (unsigned long)result;
>  	tstojiffie(&time->it_interval, res, &result);
> @@ -1195,6 +1191,7 @@ sys_clock_nanosleep(clockid_t which_cloc
>  	return ret;
>  
>  }
> +
>  long
>  do_clock_nanosleep(clockid_t which_clock, int flags, struct timespec *tsave)
>  {
> @@ -1225,30 +1222,30 @@ do_clock_nanosleep(clockid_t which_clock
>  		rq_time = (rq_time << 32) + restart_block->arg2;
>  		if (!rq_time)
>  			return -EINTR;
> -		if (rq_time <= get_jiffies_64())
> -			return 0;
> +		left = rq_time - get_jiffies_64();
> +		if (left <= 0LL)
> +			return 0;	/* Already passed */

I really don't think this will fail.
>  	}
>  
>  	if (abs && (posix_clocks[which_clock].clock_get !=
>  		    posix_clocks[CLOCK_MONOTONIC].clock_get)) {
>  		add_wait_queue(&nanosleep_abs_wqueue, &abs_wqueue);
>  	}
> -	do {
> -		t = *tsave;
> -		if (abs || !rq_time){
> -			adjust_abs_time(&posix_clocks[which_clock], &t, abs);
>  
> -			tstojiffie(&t, posix_clocks[which_clock].res, &rq_time);
> -		}
> -#if (BITS_PER_LONG < 64)
> -		if ((rq_time - get_jiffies_64()) > MAX_JIFFY_OFFSET){
> -			new_timer.expires = MAX_JIFFY_OFFSET;
> -		}else
> -#endif
> -		{
> -			new_timer.expires = (long)rq_time;
> -		}
> -		current->state = TASK_INTERRUPTIBLE;
> +	t = *tsave;
> +	if (abs || !rq_time) {
> +		adjust_abs_time(&posix_clocks[which_clock], &t, abs);
> +		tstojiffie(&t, posix_clocks[which_clock].res, &rq_time);
> +	}
> +
> +	left = rq_time - get_jiffies_64();
> +
> +	while (left > 0 && !test_thread_flag(TIF_SIGPENDING)) {
> +		if (left >= MAX_JIFFY_OFFSET)
> +			left = MAX_JIFFY_OFFSET;
> +
> +		new_timer.expires = jiffies + left;
> +		__set_current_state(TASK_INTERRUPTIBLE);
>  		add_timer(&new_timer);

This will fail the clock setting test.  The standard says that the abs 
sleep should stop "on time" even if the clock is set.  I think the 
only "real" issue is the unsigned compare.
>  
>  		schedule();
> @@ -1256,10 +1253,8 @@ do_clock_nanosleep(clockid_t which_clock
>  		del_timer_sync(&new_timer);
>  		left = rq_time - get_jiffies_64();
>  	}
> -	while ( (left > 0)  &&
> -		!test_thread_flag(TIF_SIGPENDING));
>  
> -	if( abs_wqueue.task_list.next)
> +	if (abs_wqueue.task_list.next)
>  		finish_wait(&nanosleep_abs_wqueue, &abs_wqueue);
>  
>  	if (left > 0) {
> 
> _
> 
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

