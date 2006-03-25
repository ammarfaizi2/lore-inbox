Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751230AbWCYAhh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbWCYAhh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 19:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbWCYAhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 19:37:37 -0500
Received: from omta01sl.mx.bigpond.com ([144.140.92.153]:37807 "EHLO
	omta01sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751230AbWCYAhg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 19:37:36 -0500
Message-ID: <442490CC.8090200@bigpond.net.au>
Date: Sat, 25 Mar 2006 11:37:32 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Con Kolivas <kernel@kolivas.org>
Subject: Re: [2.6.16-mm1 patch] throttling tree patches
References: <1143198208.7741.8.camel@homer>
In-Reply-To: <1143198208.7741.8.camel@homer>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sat, 25 Mar 2006 00:37:33 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> Greetings,
> 
> I've broken down my throttling tree into 6 patches, which I'll send as
> replies to this start-point.
> 
> Patch 1/6
> 
> Ignore timewarps caused by SMP timestamp rounding.  Also, don't stamp a
> task with a computed timestamp, stamp with the already called clock.
> 
> Signed-off-by: Mike Galbraith <efault@gmx.de>
> 
> --- linux-2.6.16-mm1/kernel/sched.c.org	2006-03-23 15:01:41.000000000 +0100
> +++ linux-2.6.16-mm1/kernel/sched.c	2006-03-23 15:02:25.000000000 +0100
> @@ -805,6 +805,16 @@
>  	unsigned long long __sleep_time = now - p->timestamp;
>  	unsigned long sleep_time;
>  
> +	/*
> +	 * On SMP systems, a task can go to sleep on one CPU and
> +	 * wake up on another.  When this happens, the timestamp
> +	 * is rounded to the nearest tick,

Is this true?  There's no rounding that I can see.  An attempt is made 
to adjust the timestamp for the drift between time as seen from the two 
CPUs but there's no deliberate rounding involved.  Of course, that's not 
to say that the adjustment is accurate as I'm not convinced that the 
difference between the run queues' timestamp_last_tick is a always 
totally accurate measure of the drift in their clocks (due to possible 
races -- I may be wrong).

Of course, that doesn't mean that this chunk of code isn't required just 
that the comment is misleading.

> which can lead to now
> +	 * being less than p->timestamp for short sleeps. Ignore
> +	 * these, they're insignificant.
> +	 */
> +	if (unlikely(now < p->timestamp))
> +		__sleep_time = 0ULL;
> +
>  	if (batch_task(p))
>  		sleep_time = 0;
>  	else {
> @@ -871,20 +881,20 @@
>   */
>  static void activate_task(task_t *p, runqueue_t *rq, int local)
>  {
> -	unsigned long long now;
> +	unsigned long long now, comp;
>  
> -	now = sched_clock();
> +	now = comp = sched_clock();
>  #ifdef CONFIG_SMP
>  	if (!local) {
>  		/* Compensate for drifting sched_clock */
>  		runqueue_t *this_rq = this_rq();
> -		now = (now - this_rq->timestamp_last_tick)
> +		comp = (now - this_rq->timestamp_last_tick)
>  			+ rq->timestamp_last_tick;
>  	}
>  #endif
>  
>  	if (!rt_task(p))
> -		p->prio = recalc_task_prio(p, now);
> +		p->prio = recalc_task_prio(p, comp);
>  
>  	/*
>  	 * This checks to make sure it's not an uninterruptible task

I think that this will end up with p->timestamp being set with a time 
appropriate to the current task's CPU rather than its own.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
