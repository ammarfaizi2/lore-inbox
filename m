Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbTDKSmo (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 14:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbTDKSmo (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 14:42:44 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:54262 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261412AbTDKSmk (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 14:42:40 -0400
Message-ID: <3E970F37.7040409@mvista.com>
Date: Fri, 11 Apr 2003 11:53:43 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: davidm@hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: too much timer simplification...
References: <200304110705.h3B75aQt026081@napali.hpl.hp.com> <20030411002816.786296e8.akpm@digeo.com>
In-Reply-To: <20030411002816.786296e8.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> David Mosberger <davidm@napali.hpl.hp.com> wrote:
> 
>>It appears to me that this changeset:
>>
>>  http://linux.bkbits.net:8080/linux-2.5/diffs/kernel/timer.c@1.48
>>
>>may have gone a little too far.
>>
>>What I'm seeing is that if someone happens to arm a periodic timer at
>>exactly 256 jiffies (as ohci happens to do on platforms with HZ=1024),
>>then you end up getting an endless loop of timer activations, causing
>>a machine hang.
>>
>>The problem is that __run_timers updates base->timer_jiffies _before_
>>running the callback routines.  If a callback re-arms the timer at
>>exactly 256 jiffies, add_timers() will reinsert the timer into the
>>list that we're currently processing, which of course will cause the
>>timer to expire immediately again, etc., etc., ad naseum...
>>
> 
> 
> OK, well unless George can pull a rabbit out of the hat it may
> be best to just revert it.
> 
I think the answer here is to move the whole expired list to a local 
header and to not look back.  I will work this into a patch...

-g

> This gives us the same algorithm as 2.4, which I think is good.
> 
> 
> --- 25/kernel/timer.c~timer-simplification-revert	2003-04-11 00:19:48.000000000 -0700
> +++ 25-akpm/kernel/timer.c	2003-04-11 00:19:48.000000000 -0700
> @@ -56,6 +56,7 @@ struct tvec_t_base_s {
>  	spinlock_t lock;
>  	unsigned long timer_jiffies;
>  	struct timer_list *running_timer;
> +	struct list_head *run_timer_list_running;
>  	tvec_root_t tv1;
>  	tvec_t tv2;
>  	tvec_t tv3;
> @@ -100,6 +101,12 @@ static inline void check_timer(struct ti
>  		check_timer_failed(timer);
>  }
>  
> +/*
> + * If a timer handler re-adds the timer with expires == jiffies, the timer
> + * running code can lock up.  So here we detect that situation and park the
> + * timer onto base->run_timer_list_running.  It will be added to the main timer
> + * structures later, by __run_timers().
> + */
>  
>  static void internal_add_timer(tvec_base_t *base, struct timer_list *timer)
>  {
> @@ -107,7 +114,9 @@ static void internal_add_timer(tvec_base
>  	unsigned long idx = expires - base->timer_jiffies;
>  	struct list_head *vec;
>  
> -	if (idx < TVR_SIZE) {
> +	if (base->run_timer_list_running) {
> +		vec = base->run_timer_list_running;
> +	} else if (idx < TVR_SIZE) {
>  		int i = expires & TVR_MASK;
>  		vec = base->tv1.vec + i;
>  	} else if (idx < 1 << (TVR_BITS + TVN_BITS)) {
> @@ -397,6 +406,7 @@ static inline void __run_timers(tvec_bas
>  
>  	spin_lock_irq(&base->lock);
>  	while (time_after_eq(jiffies, base->timer_jiffies)) {
> +		LIST_HEAD(deferred_timers);
>  		struct list_head *head;
>   		int index = base->timer_jiffies & TVR_MASK;
>   
> @@ -408,7 +418,7 @@ static inline void __run_timers(tvec_bas
>  				(!cascade(base, &base->tv3, INDEX(1))) &&
>  					!cascade(base, &base->tv4, INDEX(2)))
>  			cascade(base, &base->tv5, INDEX(3));
> -		++base->timer_jiffies; 
> +		base->run_timer_list_running = &deferred_timers;
>  repeat:
>  		head = base->tv1.vec + index;
>  		if (!list_empty(head)) {
> @@ -427,6 +437,14 @@ repeat:
>  			spin_lock_irq(&base->lock);
>  			goto repeat;
>  		}
> +		base->run_timer_list_running = NULL;
> +		++base->timer_jiffies; 
> +		while (!list_empty(&deferred_timers)) {
> +			timer = list_entry(deferred_timers.prev,
> +						struct timer_list, entry);
> +			list_del(&timer->entry);
> +			internal_add_timer(base, timer);
> +		}
>  	}
>  	set_running_timer(base, NULL);
>  	spin_unlock_irq(&base->lock);
> 
> _
> 
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

