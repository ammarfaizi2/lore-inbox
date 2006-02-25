Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161058AbWBYS6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161058AbWBYS6A (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 13:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161059AbWBYS6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 13:58:00 -0500
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:60587 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP
	id S1161058AbWBYS6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 13:58:00 -0500
X-ORBL: [67.117.73.34]
Date: Sat, 25 Feb 2006 10:57:31 -0800
From: Tony Lindgren <tony@atomide.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: akpm@osdl.org, heiko.carstens@de.ibm.com, johnstul@us.ibm.com,
       rmk@arm.linux.org.uk, schwidefsky@de.ibm.com,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: + fix-next_timer_interrupt-for-hrtimer.patch added to -mm tree
Message-ID: <20060225185731.GA4294@atomide.com>
References: <200602250219.k1P2JLqY018864@shell0.pdx.osdl.net> <1140884243.5237.104.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140884243.5237.104.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Thomas Gleixner <tglx@linutronix.de> [060225 08:16]:
> > +#ifdef CONFIG_NO_IDLE_HZ
> > +/**
> > + * hrtimer_get_next - get next hrtimer to expire
> > + *
> > + * @bases:	ktimer base array
> > + */
> > +static inline struct hrtimer *hrtimer_get_next(struct hrtimer_base *bases)
> > +{
> > +	unsigned long flags;
> > +	struct hrtimer *timer = NULL;
> > +	int i;
> > +
> > +	for (i = 0; i < MAX_HRTIMER_BASES; i++) {
> > +		struct hrtimer_base *base;
> > +		struct hrtimer *cur;
> > +
> > +		base = &bases[i];
> > +		spin_lock_irqsave(&base->lock, flags);
> > +		cur = rb_entry(base->first, struct hrtimer, node);
> > +		spin_unlock_irqrestore(&base->lock, flags);
> > +
> > +		if (cur == NULL)
> > +			continue;
> > +
> > +		if (timer == NULL || cur->expires.tv64 < timer->expires.tv64)
> > +			timer = cur;
> > +	}
> > +
> > +	return timer;
> > +}
> 
> This is racy on SMP. nanosleep hrtimers are on the stack and can go away
> due to a signal. posix timers can be removed and destroyed on another
> CPU.

This should be fixed. But just as a note, we can tolerate some removed
timer values values as it would be just an extra timer interrupt.
 
> Also the expires fields of CLOCK_MONOTONIC and CLOCK_REALTIME based
> tiemrs can not really be compared. Expiry value is absolute time of the
> respective base clock.

OK. How can we get the first event in nanoseconds easily?
 
> > +/**
> > + * ktime_to_jiffies - converts ktime to jiffies
> > + *
> > + * @event:	ktime event to be converted to jiffies
> > + *
> > + * Caller must take care of xtime locking.
> > + */
> > +static inline unsigned long ktime_to_jiffies(const ktime_t event)
> > +{
> > +	ktime_t now, delta;
> > +
> > +	now = timespec_to_ktime(xtime);
> > +	delta = ktime_sub(event, now);
> > +
> > +	return jiffies + (((delta.tv64 * NSEC_CONVERSION) >>
> > +			(NSEC_JIFFIE_SC - SEC_JIFFIE_SC)) >> SEC_JIFFIE_SC);
> > +}
> 
> Only CLOCK_REALTIME based timers are based on xtime. For CLOCK_MONOTONIC
> based timers this calculation is off by wall_to_monotonic.

Needs to be fixed then.
 
> > +/**
> > + * hrtimer_next_jiffie - get next hrtimer event in jiffies
> > + *
> > + * Called from next_timer_interrupt() to get the next hrtimer event.
> > + * Eventually we should change next_timer_interrupt() to return
> > + * results in nanoseconds instead of jiffies. Caller must host xtime_lock.
> 
> S390 does not hold xtime lock when calling next_timer_interrupt !

Good point. Needs to be fixed.
 
> I look for a sane solution.

We really should fix this for 2.6.16. Then maybe after 2.6.16 we can
convert next_timer_interrupt() to return nanosecond instead of jiffies.
And then we can get rid of jiffies again in the hrtimer code :)

Tony
