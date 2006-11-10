Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946126AbWKJJUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946126AbWKJJUA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 04:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946134AbWKJJUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 04:20:00 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:23481 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1946126AbWKJJT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 04:19:59 -0500
Subject: Re: [patch 01/19] hrtimers: state tracking
From: Arjan van de Ven <arjan@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Len Brown <lenb@kernel.org>,
       John Stultz <johnstul@us.ibm.com>, Andi Kleen <ak@suse.de>,
       Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <20061109233034.182462000@cruncher.tec.linutronix.de>
References: <20061109233030.915859000@cruncher.tec.linutronix.de>
	 <20061109233034.182462000@cruncher.tec.linutronix.de>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 10 Nov 2006 10:19:48 +0100
Message-Id: <1163150389.3138.608.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +/*
> + * Bit values to track state of the timer
> + *
> + * Possible states:
> + *
> + * 0x00		inactive
> + * 0x01		enqueued into rbtree
> + * 0x02		callback function running
> + * 0x03		callback function running and enqueued
> + *		(was requeued on another CPU)
> + *
> + * The "callback function running and enqueued" status is only possible on
> + * SMP. It happens for example when a posix timer expired and the callback
> + * queued a signal. Between dropping the lock which protects the posix timer
> + * and reacquiring the base lock of the hrtimer, another CPU can deliver the
> + * signal and rearm the timer. We have to preserve the callback running state,
> + * as otherwise the timer could be removed before the softirq code finishes the
> + * the handling of the timer.
> + *
> + * The HRTIMER_STATE_ENQUEUE bit is always or'ed to the current state to
> + * preserve the HRTIMER_STATE_CALLBACK bit in the above scenario.
> + *
> + * All state transitions are protected by cpu_base->lock.
> + */
> +#define HRTIMER_STATE_INACTIVE	0x00
> +#define HRTIMER_STATE_ENQUEUED	0x01
> +#define HRTIMER_STATE_CALLBACK	0x02

where is the define for 0x03?

>  
> +static inline int hrtimer_is_queued(struct hrtimer *timer)
> +{
> +	return timer->state != HRTIMER_STATE_INACTIVE &&
> +		timer->state != HRTIMER_STATE_CALLBACK;
> +}

the state things are either bits or they're not. If they're bits, you
probably want to make this a bitcheck instead...
>  	rb_insert_color(&timer->node, &base->active);
> +	/*
> +	 * HRTIMER_STATE_ENQUEUED is or'ed to the current state to preserve the
> +	 * state of a possibly running callback.
> +	 */
> +	timer->state |= HRTIMER_STATE_ENQUEUED;

ok so it IS a bit thing, see comment about hrtimer_is_queued() not being
a bit check then...



> -	if (base->cpu_base->curr_timer != timer)
> +	if (!(timer->state & HRTIMER_STATE_CALLBACK))
>  		ret = remove_hrtimer(timer, base);

if there is a hrtimer_is_queued() inline, might as well make a
hrtimer_is_running() inline as well


otherwise lookes ok; if you fix these few comments:
Acked-by: Arjan van de Ven <arjan@linux.intel.com>

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

