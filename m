Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261815AbTCQSAh>; Mon, 17 Mar 2003 13:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261816AbTCQSAh>; Mon, 17 Mar 2003 13:00:37 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:6394 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261815AbTCQSAf>;
	Mon, 17 Mar 2003 13:00:35 -0500
Date: Mon, 17 Mar 2003 10:01:34 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
cc: Mike Galbraith <efault@gmx.de>, Andrew Morton <akpm@zip.com.au>
Subject: Re: [patch] sched-2.5.64-D3, more interactivity changes
Message-ID: <268320000.1047924094@flay>
In-Reply-To: <Pine.LNX.4.44.0303171114310.19107-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0303171114310.19107-100000@localhost.localdomain>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, I don't have an interactivity test ... but ran the kerbench and
SDET standard batch job stuff on the big NUMA-Q box, and it's the same ...
incidentally ... I tested the earlier changes individually, and they
actually made things slightly *faster*. Is cool to see that we're improving
both worlds at once.

M.

--On Monday, March 17, 2003 11:21:33 +0100 Ingo Molnar <mingo@elte.hu> wrote:

> 
> the attached patch (against BK-curr) implements more finegrained timeslice
> distribution, without changing the total balance of timeslices, by
> recalculating the priority of CPU-bound tasks at a finer granularity, and
> by roundrobining tasks. Right now this new granularity is 50 msecs (the
> default timeslice for default priority tasks is 100 msecs).
> 
> Could people, who can reproduce 'audio skips' kind of problems even with
> BK-curr, give this patch a go?
> 
> 	Ingo
> 
> --- linux/kernel/sched.c.orig	
> +++ linux/kernel/sched.c	
> @@ -73,6 +73,7 @@
>  #define INTERACTIVE_DELTA	2
>  #define MAX_SLEEP_AVG		(10*HZ)
>  #define STARVATION_LIMIT	(10*HZ)
> +#define TIMESLICE_GRANULARITY	(HZ/20 ?: 1)
>  #define NODE_THRESHOLD		125
>  
>  /*
> @@ -1259,6 +1260,27 @@ void scheduler_tick(int user_ticks, int 
>  			enqueue_task(p, rq->expired);
>  		} else
>  			enqueue_task(p, rq->active);
> +	} else {
> +		/*
> +		 * Prevent a too long timeslice allowing a task to monopolize
> +		 * the CPU. We do this by splitting up the timeslice into
> +		 * smaller pieces.
> +		 *
> +		 * Note: this does not mean the task's timeslices expire or
> +		 * get lost in any way, they just might be preempted by
> +		 * another task of equal priority. (one with higher
> +		 * priority would have preempted this task already.) We
> +		 * requeue this task to the end of the list on this priority
> +		 * level, which is in essence a round-robin of tasks with
> +		 * equal priority.
> +		 */
> +		if (!(p->time_slice % TIMESLICE_GRANULARITY) &&
> +			       		(p->array == rq->active)) {
> +			dequeue_task(p, rq->active);
> +			set_tsk_need_resched(p);
> +			p->prio = effective_prio(p);
> +			enqueue_task(p, rq->active);
> +		}
>  	}
>  out:
>  	spin_unlock(&rq->lock);
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


