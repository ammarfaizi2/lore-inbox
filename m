Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750836AbWAJBiC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbWAJBiC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 20:38:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbWAJBiC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 20:38:02 -0500
Received: from gw02.applegatebroadband.net ([207.55.227.2]:28651 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S1750836AbWAJBiA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 20:38:00 -0500
Message-ID: <43C30FB9.1000609@mvista.com>
Date: Mon, 09 Jan 2006 17:36:57 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH RT] make hrtimer_nanosleep return immediately if time
 has	passed
References: <1136557086.12468.138.camel@localhost.localdomain>	 <43BEEEED.9040308@mvista.com> <1136588597.12468.162.camel@localhost.localdomain>
In-Reply-To: <1136588597.12468.162.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> On Fri, 2006-01-06 at 14:27 -0800, George Anzinger wrote:
> 
>>Steven Rostedt wrote:
>>
>>>Thomas,
>>
>>~
>>
>>
>>>usecs as was shown in the jitter test.
>>>
>>>My patch does the following:
>>>
>>>- Changes enqueue_hrtimer from void to int and returns 1 and does 
>>>  nothing else in the case of the timer has passed.
>>>
>>>- Change hrtimer_start to return 1 if the timer has passed and not when
>>>  the timer was active.  I searched the kernel and I could not find one
>>>  instance where this hrtimer_start had its return code checked.
>>>
>>>- Changed schedule_hrtimer to not go to sleep if the time has passed.
>>
>>At this time the posix timer code depends on the call back.  Either you will 
>>need to make this an option or change that code to do the right thing.
> 
> 
> George,
> 
> Thanks for showing me this.  How about the following patch. It leaves
> hrtimer_restart queuing the timer by adding an internal function
> __hrtimer_restart that adds the option "queue".  Since the only time you
> don't want to queue it (that I know of) is internally to nanosleep. But
> then again maybe others will want too.  But anyway, this keeps the
> current API to hrtimers unchanged.

Uh... I have been wondering about the "mode" thing, thinking "flags" might be 
better.  And allowing, say, a "return if elapsed" flag as well as the ABS 
flag.  Then all you would need to do is to add the "return if elapsed" flag 
to the nanosleep calls.  I have other reasons for wanting to expand the 
"mode" to more that two states... but, even with out that, I think the result 
would be a) less code, and b) easier to follow and understand.  I just have 
trouble pushing a word on the stack to make a call and then use only one bit 
of it when it could be combined...

Never the less, the following code looks like is does the right thing.

George
> 
> -- Steve
> 
> Index: linux-2.6.15-rt2/kernel/hrtimer.c
> ===================================================================
> --- linux-2.6.15-rt2.orig/kernel/hrtimer.c	2006-01-06 17:49:47.000000000 -0500
> +++ linux-2.6.15-rt2/kernel/hrtimer.c	2006-01-06 17:53:25.000000000 -0500
> @@ -226,6 +226,10 @@
>   * for which the hrt time source was armed.
>   *
>   * Called with interrupts disabled and base lock held
> + *
> + * Returns:
> + *  0 on success
> + *  1 if time has already past.
>   */
>  static int hrtimer_reprogram(struct hrtimer *timer, struct hrtimer_base *base)
>  {
> @@ -239,6 +243,8 @@
>  	res = clockevents_set_next_event(expires);
>  	if (!res)
>  		*expires_next = expires;
> +	else
> +		res = 1;
>  	return res;
>  }
>  
> @@ -381,11 +387,24 @@
>  	       smp_processor_id());
>  }
>  
> +/*
> + * kick_off_hrtimer - queue the timer to the expire list and
> + *                    raise the hrtimer softirq.
> + */
> +static void
> +kick_off_hrtimer(struct hrtimer *timer, struct hrtimer_base *base)
> +{
> +	list_add_tail(&timer->list, &base->expired);
> +	timer->state = HRTIMER_PENDING_CALLBACK;
> +	raise_softirq(HRTIMER_SOFTIRQ);
> +}
> +
>  #else /* CONFIG_HIGH_RES_TIMERS */
>  
>  # define hrtimer_hres_active		0
>  # define hres_enqueue_expired(t,b,n)	0
>  # define hrtimer_check_clocks()		do { } while (0)
> +# define kick_off_hrtimer		do { } while (0)
>  
>  #endif /* !CONFIG_HIGH_RES_TIMERS */
>  
> @@ -501,9 +520,14 @@
>   *
>   * The timer is inserted in expiry order. Insertion into the
>   * red black tree is O(log(n)). Must hold the base lock.
> + *
> + * Returns:
> + *  0 on success
> + *  1 if time has already past.
>   */
> -static void enqueue_hrtimer(struct hrtimer *timer, struct hrtimer_base *base)
> +static int enqueue_hrtimer(struct hrtimer *timer, struct hrtimer_base *base)
>  {
> +
>  	struct rb_node **link = &base->active.rb_node;
>  	struct rb_node *parent = NULL;
>  	struct hrtimer *entry;
> @@ -534,12 +558,8 @@
>  		 * past we just move it to the expired list
>  		 * and schedule the softirq.
>  		 */
> -		if (hrtimer_hres_active && hrtimer_reprogram(timer, base)) {
> -			list_add_tail(&timer->list, &base->expired);
> -			timer->state = HRTIMER_PENDING_CALLBACK;
> -			raise_softirq(HRTIMER_SOFTIRQ);
> -			return;
> -		}
> +		if (hrtimer_hres_active && hrtimer_reprogram(timer, base))
> +			return 1;
>  #endif
>  		base->first = &timer->node;
>  	}
> @@ -551,6 +571,7 @@
>  	rb_insert_color(&timer->node, &base->active);
>  
>  	timer->state = HRTIMER_PENDING;
> +	return 0;
>  }
>  
>  /*
> @@ -598,10 +619,11 @@
>   *
>   * Returns:
>   *  0 on success
> - *  1 when the timer was active
> + *  1 if the time has already past
>   */
> -int
> -hrtimer_start(struct hrtimer *timer, ktime_t tim, const enum hrtimer_mode mode)
> +static int
> +__hrtimer_start(struct hrtimer *timer, ktime_t tim, const enum hrtimer_mode mode,
> +		int queue)
>  {
>  	struct hrtimer_base *base, *new_base;
>  	unsigned long flags;
> @@ -610,7 +632,7 @@
>  	base = lock_hrtimer_base(timer, &flags);
>  
>  	/* Remove an active timer from the queue: */
> -	ret = remove_hrtimer(timer, base);
> +	remove_hrtimer(timer, base);
>  
>  	/* Switch the timer base, if necessary: */
>  	new_base = switch_hrtimer_base(timer, base);
> @@ -619,13 +641,21 @@
>  		tim = ktime_add(tim, new_base->get_time());
>  	timer->expires = tim;
>  
> -	enqueue_hrtimer(timer, new_base);
> +	if ((ret = enqueue_hrtimer(timer, new_base)) && queue)
> +		kick_off_hrtimer(timer, new_base);
>  
>  	unlock_hrtimer_base(timer, &flags);
>  
>  	return ret;
>  }
>  
> +int
> +hrtimer_start(struct hrtimer *timer, ktime_t tim, const enum hrtimer_mode mode)
> +{
> +	return __hrtimer_start(timer, tim, mode, 1);
> +}
> +
> +
>  /**
>   * hrtimer_try_to_cancel - try to deactivate a timer
>   *
> @@ -864,9 +894,10 @@
>  
>  		spin_lock_irq(&base->lock);
>  
> -		if (restart == HRTIMER_RESTART)
> -			enqueue_hrtimer(timer, base);
> -		else
> +		if (restart == HRTIMER_RESTART) {
> +			if (enqueue_hrtimer(timer, base))
> +				kick_off_hrtimer(timer, base);
> +		} else
>  			timer->state = HRTIMER_EXPIRED;
>  		set_curr_timer(base, NULL);
>  	}
> @@ -922,9 +953,10 @@
>  
>  		spin_lock_irq(&base->lock);
>  
> -		if (restart == HRTIMER_RESTART)
> -			enqueue_hrtimer(timer, base);
> -		else
> +		if (restart == HRTIMER_RESTART) {
> +			if (enqueue_hrtimer(timer, base))
> +				kick_off_hrtimer(timer, base);
> +		} else
>  			timer->state = HRTIMER_EXPIRED;
>  		set_curr_timer(base, NULL);
>  	}
> @@ -983,9 +1015,13 @@
>  	/* fn stays NULL, meaning single-shot wakeup: */
>  	timer->data = current;
>  
> -	hrtimer_start(timer, timer->expires, mode);
> +	if (__hrtimer_start(timer, timer->expires, mode, 0)) {
> +		/* time already past */
> +		timer->state = HRTIMER_EXPIRED;
> +		set_current_state(TASK_RUNNING);
> +	} else
> +		schedule();
>  
> -	schedule();
>  	hrtimer_cancel(timer);
>  
>  	/* Return the remaining time: */
> @@ -1128,7 +1164,8 @@
>  		timer = rb_entry(node, struct hrtimer, node);
>  		__remove_hrtimer(timer, old_base);
>  		timer->base = new_base;
> -		enqueue_hrtimer(timer, new_base);
> +		if (enqueue_hrtimer(timer, new_base))
> +			kick_off_hrtimer(timer, base);
>  	}
>  }
>  
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
