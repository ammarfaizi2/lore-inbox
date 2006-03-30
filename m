Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750878AbWC3FEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbWC3FEQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 00:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbWC3FEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 00:04:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:8660 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750854AbWC3FEH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 00:04:07 -0500
Date: Wed, 29 Mar 2006 21:03:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch 3/8] cpu delays
Message-Id: <20060329210352.53a64b5c.akpm@osdl.org>
In-Reply-To: <442B2967.6010704@watson.ibm.com>
References: <442B271D.10208@watson.ibm.com>
	<442B2967.6010704@watson.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh Nagar <nagar@watson.ibm.com> wrote:
>
> delayacct-schedstats.patch
> 
> Make the task-related schedstats functions
> callable by delay accounting even if schedstats
> collection isn't turned on. This removes the
> dependency of delay accounting on schedstats and allows
> cpu delays to be exported.
> 
> ..
>
> Index: linux-2.6.16/include/linux/sched.h
> ===================================================================
> --- linux-2.6.16.orig/include/linux/sched.h	2006-03-29 18:13:13.000000000 -0500
> +++ linux-2.6.16/include/linux/sched.h	2006-03-29 18:13:15.000000000 -0500
> @@ -525,7 +525,7 @@ typedef struct prio_array prio_array_t;
>  struct backing_dev_info;
>  struct reclaim_state;
> 
> -#ifdef CONFIG_SCHEDSTATS
> +#if defined(CONFIG_SCHEDSTATS) || defined(CONFIG_TASK_DELAY_ACCT)
>  struct sched_info {
>  	/* cumulative counters */
>  	unsigned long	cpu_time,	/* time spent on the cpu */
> @@ -537,10 +537,14 @@ struct sched_info {
>  			last_queued;	/* when we were last queued to run */
>  };
> 
> +#ifdef CONFIG_SCHEDSTATS
>  extern struct file_operations proc_schedstat_operations;
> -#endif
> +#endif /* CONFIG_SCHEDSTATS */
> +#endif /* defined(CONFIG_SCHEDSTATS) || defined(CONFIG_TASK_DELAY_ACCT) */
> 
>  #ifdef CONFIG_TASK_DELAY_ACCT
> +extern int delayacct_on;
> +

This was already declared in delayacct.h and nothing in sched.h needs it. 
So it's better if .c files pick this declaration up from delayacct.h.

> 
> +static inline void rq_sched_info_arrive(struct runqueue *rq,
> +						unsigned long diff)
> +{
> +	if (rq) {
> +		rq->rq_sched_info.run_delay += diff;
> +		rq->rq_sched_info.pcnt++;
> +	}
> +}

The nonatomic updates need locking.  I assume it's runqueue.lock, but a
comment describing the rules would be good.

> +static inline void rq_sched_info_depart(struct runqueue *rq,
> +						unsigned long diff)
> +{
> +	if (rq)
> +		rq->rq_sched_info.cpu_time += diff;
> +}

Ditto.

>  static inline void sched_info_queued(task_t *t)
>  {
> -	if (!t->sched_info.last_queued)
> -		t->sched_info.last_queued = jiffies;
> +	if (unlikely(sched_info_on()))
> +		if (!t->sched_info.last_queued)
> +			t->sched_info.last_queued = jiffies;
>  }

It might be better to put the unlikely() into sched_info_on() itself.

