Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932581AbWKJJpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932581AbWKJJpL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 04:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932635AbWKJJpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 04:45:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:49900 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932581AbWKJJpJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 04:45:09 -0500
Date: Fri, 10 Nov 2006 01:40:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Len Brown <lenb@kernel.org>,
       John Stultz <johnstul@us.ibm.com>, Andi Kleen <ak@suse.de>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [patch 01/19] hrtimers: state tracking
Message-Id: <20061110014053.5208f35e.akpm@osdl.org>
In-Reply-To: <1163150389.3138.608.camel@laptopd505.fenrus.org>
References: <20061109233030.915859000@cruncher.tec.linutronix.de>
	<20061109233034.182462000@cruncher.tec.linutronix.de>
	<1163150389.3138.608.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Nov 2006 10:19:48 +0100
Arjan van de Ven <arjan@infradead.org> wrote:

> 
> > +/*
> > + * Bit values to track state of the timer
> > + *
> > + * Possible states:
> > + *
> > + * 0x00		inactive
> > + * 0x01		enqueued into rbtree
> > + * 0x02		callback function running
> > + * 0x03		callback function running and enqueued
> > + *		(was requeued on another CPU)
> > + *
> > + * The "callback function running and enqueued" status is only possible on
> > + * SMP. It happens for example when a posix timer expired and the callback
> > + * queued a signal. Between dropping the lock which protects the posix timer
> > + * and reacquiring the base lock of the hrtimer, another CPU can deliver the
> > + * signal and rearm the timer. We have to preserve the callback running state,
> > + * as otherwise the timer could be removed before the softirq code finishes the
> > + * the handling of the timer.
> > + *
> > + * The HRTIMER_STATE_ENQUEUE bit is always or'ed to the current state to
> > + * preserve the HRTIMER_STATE_CALLBACK bit in the above scenario.
> > + *
> > + * All state transitions are protected by cpu_base->lock.
> > + */
> > +#define HRTIMER_STATE_INACTIVE	0x00
> > +#define HRTIMER_STATE_ENQUEUED	0x01
> > +#define HRTIMER_STATE_CALLBACK	0x02
> 
> where is the define for 0x03?
> 
> >  
> > +static inline int hrtimer_is_queued(struct hrtimer *timer)
> > +{
> > +	return timer->state != HRTIMER_STATE_INACTIVE &&
> > +		timer->state != HRTIMER_STATE_CALLBACK;
> > +}
> 
> the state things are either bits or they're not. If they're bits, you
> probably want to make this a bitcheck instead...
> >  	rb_insert_color(&timer->node, &base->active);
> > +	/*
> > +	 * HRTIMER_STATE_ENQUEUED is or'ed to the current state to preserve the
> > +	 * state of a possibly running callback.
> > +	 */
> > +	timer->state |= HRTIMER_STATE_ENQUEUED;
> 
> ok so it IS a bit thing, see comment about hrtimer_is_queued() not being
> a bit check then...
> 

eek.  I exhaustively went over that confusion in my initial (and lengthy)
review of these patches.

I don't think we ever saw a point-by-point reply.  What got lost?
