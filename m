Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261519AbUKBNUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbUKBNUj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 08:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbUKBMoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 07:44:05 -0500
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:37714 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261239AbUKBMgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 07:36:01 -0500
Message-ID: <41877F2D.6070200@yahoo.com.au>
Date: Tue, 02 Nov 2004 23:35:57 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] add requeue task
References: <418707E5.90705@kolivas.org>
In-Reply-To: <418707E5.90705@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> add requeue task
> 
> 
> 
> ------------------------------------------------------------------------
> 
> We can requeue tasks for cheaper then doing a complete dequeue followed by
> an enqueue. Add the requeue_task function and perform it where possible.
> 
> Change the granularity code to requeue tasks at their best priority
> instead of changing priority while they're running. This keeps tasks at
> their top interactive level during their whole timeslice.
> 

I wonder... these things are all in sufficiently rarely used places,
that the icache miss might be more costly than the operations saved.

But....

> Signed-off-by: Con Kolivas <kernel@kolivas.org>
> 
> Index: linux-2.6.10-rc1-mm2/kernel/sched.c
> ===================================================================
> --- linux-2.6.10-rc1-mm2.orig/kernel/sched.c	2004-11-02 14:48:54.686316718 +1100
> +++ linux-2.6.10-rc1-mm2/kernel/sched.c	2004-11-02 14:52:51.805763544 +1100
> @@ -579,6 +579,16 @@ static void enqueue_task(struct task_str
>  }
>  
>  /*
> + * Put task to the end of the run list without the overhead of dequeue
> + * followed by enqueue.
> + */
> +static void requeue_task(struct task_struct *p, prio_array_t *array)
> +{
> +	list_del(&p->run_list);
> +	list_add_tail(&p->run_list, array->queue + p->prio);
> +}
> +
> +/*
>   * Used by the migration code - we pull tasks from the head of the
>   * remote queue so we want these tasks to show up at the head of the
>   * local queue:
> @@ -2425,8 +2435,7 @@ void scheduler_tick(void)
>  			set_tsk_need_resched(p);
>  
>  			/* put it at the end of the queue: */
> -			dequeue_task(p, rq->active);
> -			enqueue_task(p, rq->active);
> +			requeue_task(p, rq->active);
>  		}
>  		goto out_unlock;
>  	}
> @@ -2467,10 +2476,8 @@ void scheduler_tick(void)
>  			(p->time_slice >= TIMESLICE_GRANULARITY(p)) &&
>  			(p->array == rq->active)) {
>  
> -			dequeue_task(p, rq->active);
> +			requeue_task(p, rq->active);
>  			set_tsk_need_resched(p);
> -			p->prio = effective_prio(p);
> -			enqueue_task(p, rq->active);
>  		}
>  	}
>  out_unlock:

This isn't a 1:1 transformation. Looks like the effective_prio there
might be superfluous, but if so that should be a different patch.

> @@ -3569,8 +3576,14 @@ asmlinkage long sys_sched_yield(void)
>  	} else if (!rq->expired->nr_active)
>  		schedstat_inc(rq, yld_exp_empty);
>  
> -	dequeue_task(current, array);
> -	enqueue_task(current, target);
> +	if (array != target) {
> +		dequeue_task(current, array);
> +		enqueue_task(current, target);
> +	} else
> +		/*
> +		 * requeue_task is cheaper so perform that if possible.
> +		 */
> +		requeue_task(current, array);
>  
>  	/*
>  	 * Since we are going to call schedule() anyway, there's
> 

Hmm if you have to go to this trouble I'd say its not worth it.
Ingo may want to weigh in though.
