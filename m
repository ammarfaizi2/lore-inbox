Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbUKBMZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbUKBMZq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 07:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbUKBMZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 07:25:46 -0500
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:3506 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261216AbUKBMZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 07:25:09 -0500
Message-ID: <41877C9C.7070507@yahoo.com.au>
Date: Tue, 02 Nov 2004 23:25:00 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] consolidate task preempts
References: <418707E2.1060105@kolivas.org>
In-Reply-To: <418707E2.1060105@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> consolidate task preempts
> 
> 
> 
> ------------------------------------------------------------------------
> 
> TASK_PREEMPTS_CURR is only used when followed by resched_task. Consolidate
> the two into a single function.
> 

I don't like the name.

I actually don't mind the code as it is now; it looks like it gets harder
to read, especially with that name.

Also, I think you might be better off to leave it inline, as it is just
a single comparison.

> Allow tasks of equal dynamic priority to preempt tasks of lower static
> priority.
> 

Although this change makes the condition more complex. Is it really worth
doing?

> Signed-off-by: Con Kolivas <kernel@kolivas.org>
> 
> Index: linux-2.6.10-rc1-mm2/kernel/sched.c
> ===================================================================
> --- linux-2.6.10-rc1-mm2.orig/kernel/sched.c	2004-11-02 14:19:32.973509317 +1100
> +++ linux-2.6.10-rc1-mm2/kernel/sched.c	2004-11-02 14:26:23.444588405 +1100
> @@ -157,9 +157,6 @@
>  	(JIFFIES_TO_NS(MAX_SLEEP_AVG * \
>  		(MAX_BONUS / 2 + DELTA((p)) + 1) / MAX_BONUS - 1))
>  
> -#define TASK_PREEMPTS_CURR(p, rq) \
> -	((p)->prio < (rq)->curr->prio)
> -
>  /*
>   * task_timeslice() scales user-nice values [ -20 ... 0 ... 19 ]
>   * to time slice values: [800ms ... 100ms ... 5ms]
> @@ -810,6 +807,13 @@ inline int task_curr(const task_t *p)
>  	return cpu_curr(task_cpu(p)) == p;
>  }
>  
> +static void preempt(task_t *p, runqueue_t *rq)
> +{
> +	if (p->prio < rq->curr->prio || (p->prio == rq->curr->prio &&
> +		p->static_prio < rq->curr->static_prio))
> +			resched_task(rq->curr);
> +}
> +
>  #ifdef CONFIG_SMP
>  enum request_type {
>  	REQ_MOVE_TASK,
> @@ -1106,10 +1110,8 @@ out_activate:
>  	 * to be considered on this CPU.)
>  	 */
>  	activate_task(p, rq, cpu == this_cpu);
> -	if (!sync || cpu != this_cpu) {
> -		if (TASK_PREEMPTS_CURR(p, rq))
> -			resched_task(rq->curr);
> -	}
> +	if (!sync || cpu != this_cpu)
> +		preempt(p, rq);
>  	success = 1;
>  
>  out_running:
> @@ -1263,8 +1265,7 @@ void fastcall wake_up_new_task(task_t * 
>  		p->timestamp = (p->timestamp - this_rq->timestamp_last_tick)
>  					+ rq->timestamp_last_tick;
>  		__activate_task(p, rq);
> -		if (TASK_PREEMPTS_CURR(p, rq))
> -			resched_task(rq->curr);
> +		preempt(p, rq);
>  
>  		schedstat_inc(rq, wunt_moved);
>  		/*
> @@ -1621,8 +1622,7 @@ void pull_task(runqueue_t *src_rq, prio_
>  	 * Note that idle threads have a prio of MAX_PRIO, for this test
>  	 * to be always true for them.
>  	 */
> -	if (TASK_PREEMPTS_CURR(p, this_rq))
> -		resched_task(this_rq->curr);
> +	preempt(p, this_rq);
>  }
>  
>  /*
> @@ -3306,8 +3306,8 @@ recheck:
>  		if (task_running(rq, p)) {
>  			if (p->prio > oldprio)
>  				resched_task(rq->curr);
> -		} else if (TASK_PREEMPTS_CURR(p, rq))
> -			resched_task(rq->curr);
> +		} else
> +			preempt(p, rq);
>  	}
>  	task_rq_unlock(rq, &flags);
>  out_unlock:
> @@ -4008,8 +4008,7 @@ static void __migrate_task(struct task_s
>  				+ rq_dest->timestamp_last_tick;
>  		deactivate_task(p, rq_src);
>  		activate_task(p, rq_dest, 0);
> -		if (TASK_PREEMPTS_CURR(p, rq_dest))
> -			resched_task(rq_dest->curr);
> +		preempt(p, rq_dest);
>  	}
>  
>  out:
> 

