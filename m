Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbWI3Ii3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWI3Ii3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 04:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWI3Ii3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 04:38:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44960 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750722AbWI3Ii0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 04:38:26 -0400
Date: Sat, 30 Sep 2006 01:37:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: Re: [patch 11/23] hrtimers: state tracking
Message-Id: <20060930013757.71f5f199.akpm@osdl.org>
In-Reply-To: <20060929234440.069571000@cruncher.tec.linutronix.de>
References: <20060929234435.330586000@cruncher.tec.linutronix.de>
	<20060929234440.069571000@cruncher.tec.linutronix.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2006 23:58:30 -0000
Thomas Gleixner <tglx@linutronix.de> wrote:

> From: Thomas Gleixner <tglx@linutronix.de>
> 
> reintroduce ktimers feature "optimized away" by the ktimers
> review process: multiple hrtimer states to enable the running
> of hrtimers without holding the cpu-base-lock.
> 
> (the "optimized" rbtree hack carried only 2 states worth of
> information and we need 3.)
> 

uh, I'll believe you ;)

> -#define HRTIMER_INACTIVE	((void *)1UL)
> +#define HRTIMER_INACTIVE	0x00
> +#define HRTIMER_ACTIVE		0x01
> +#define HRTIMER_CALLBACK	0x02
>  
>  struct hrtimer_clock_base;
>  
> @@ -54,6 +56,7 @@ struct hrtimer {
>  	ktime_t				expires;
>  	int				(*function)(struct hrtimer *);
>  	struct hrtimer_clock_base	*base;
> +	unsigned long			state;

I assume that `state' here takes the above enumerated values HRTIMER_*?

Using an enum would make that explicit, and more understandable.

Does it really need to be a long type?

>  static inline int hrtimer_active(const struct hrtimer *timer)
>  {
> -	return rb_parent(&timer->node) != &timer->node;
> +	return timer->state != HRTIMER_INACTIVE;
>  }

This implies that HRTIMER_CALLBACK is an "active" state, yes?  If so, how
come?  Perhaps a comment here would aid understandability.

> +	timer->state |= HRTIMER_ACTIVE;

No!  It's a bitfield!  The plot thickens.

How come hrtimer_active() tests for equality of all bits if it's a bitfield?

> +	timer->state = newstate;

No, it's not a bitfield.  It's a scalar.

> +	if (!(timer->state & HRTIMER_CALLBACK))

whoop, it's a bitfield again.

>  		ret = remove_hrtimer(timer, base);
>  
>  	unlock_hrtimer_base(timer, &flags);
> @@ -592,7 +594,6 @@ void hrtimer_init(struct hrtimer *timer,
>  		clock_id = CLOCK_MONOTONIC;
>  
>  	timer->base = &cpu_base->clock_base[clock_id];
> -	rb_set_parent(&timer->node, &timer->node);
>  }
>  EXPORT_SYMBOL_GPL(hrtimer_init);
>  
> @@ -643,13 +644,14 @@ static inline void run_hrtimer_queue(str
>  
>  		fn = timer->function;
>  		set_curr_timer(cpu_base, timer);
> -		__remove_hrtimer(timer, base);
> +		__remove_hrtimer(timer, base, HRTIMER_CALLBACK);

How come this was assigned to state, and not or-ed into it?

> +		timer->state &= ~HRTIMER_CALLBACK;

Please document the locking for timer->state.

Please also document its various states.
