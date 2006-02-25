Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161024AbWBYQQD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161024AbWBYQQD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 11:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161026AbWBYQQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 11:16:03 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:6112
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1161024AbWBYQQB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 11:16:01 -0500
Subject: Re: + fix-next_timer_interrupt-for-hrtimer.patch added to -mm tree
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: akpm@osdl.org
Cc: tony@atomide.com, heiko.carstens@de.ibm.com, johnstul@us.ibm.com,
       rmk@arm.linux.org.uk, schwidefsky@de.ibm.com,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200602250219.k1P2JLqY018864@shell0.pdx.osdl.net>
References: <200602250219.k1P2JLqY018864@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Sat, 25 Feb 2006 17:17:22 +0100
Message-Id: <1140884243.5237.104.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.5 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#ifdef CONFIG_NO_IDLE_HZ
> +/**
> + * hrtimer_get_next - get next hrtimer to expire
> + *
> + * @bases:	ktimer base array
> + */
> +static inline struct hrtimer *hrtimer_get_next(struct hrtimer_base *bases)
> +{
> +	unsigned long flags;
> +	struct hrtimer *timer = NULL;
> +	int i;
> +
> +	for (i = 0; i < MAX_HRTIMER_BASES; i++) {
> +		struct hrtimer_base *base;
> +		struct hrtimer *cur;
> +
> +		base = &bases[i];
> +		spin_lock_irqsave(&base->lock, flags);
> +		cur = rb_entry(base->first, struct hrtimer, node);
> +		spin_unlock_irqrestore(&base->lock, flags);
> +
> +		if (cur == NULL)
> +			continue;
> +
> +		if (timer == NULL || cur->expires.tv64 < timer->expires.tv64)
> +			timer = cur;
> +	}
> +
> +	return timer;
> +}

This is racy on SMP. nanosleep hrtimers are on the stack and can go away
due to a signal. posix timers can be removed and destroyed on another
CPU.

Also the expires fields of CLOCK_MONOTONIC and CLOCK_REALTIME based
tiemrs can not really be compared. Expiry value is absolute time of the
respective base clock.

> +/**
> + * ktime_to_jiffies - converts ktime to jiffies
> + *
> + * @event:	ktime event to be converted to jiffies
> + *
> + * Caller must take care of xtime locking.
> + */
> +static inline unsigned long ktime_to_jiffies(const ktime_t event)
> +{
> +	ktime_t now, delta;
> +
> +	now = timespec_to_ktime(xtime);
> +	delta = ktime_sub(event, now);
> +
> +	return jiffies + (((delta.tv64 * NSEC_CONVERSION) >>
> +			(NSEC_JIFFIE_SC - SEC_JIFFIE_SC)) >> SEC_JIFFIE_SC);
> +}

Only CLOCK_REALTIME based timers are based on xtime. For CLOCK_MONOTONIC
based timers this calculation is off by wall_to_monotonic.

> +/**
> + * hrtimer_next_jiffie - get next hrtimer event in jiffies
> + *
> + * Called from next_timer_interrupt() to get the next hrtimer event.
> + * Eventually we should change next_timer_interrupt() to return
> + * results in nanoseconds instead of jiffies. Caller must host xtime_lock.

S390 does not hold xtime lock when calling next_timer_interrupt !

I look for a sane solution.

	tglx


