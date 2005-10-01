Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbVJABDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbVJABDx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 21:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbVJABDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 21:03:53 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:59789 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750706AbVJABDw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 21:03:52 -0400
Date: Sat, 1 Oct 2005 03:03:19 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: tglx@linutronix.de
cc: linux-kernel@vger.kernel.org, mingo@elte.hu, Andrew Morton <akpm@osdl.org>,
       george@mvista.com, johnstul@us.ibm.com, paulmck@us.ibm.com,
       Christoph Hellwig <hch@infradead.org>, oleg@tv-sign.ru,
       tim.bird@am.sony.com
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
In-Reply-To: <20050928224419.1.patchmail@tglx.tec.linutronix.de>
Message-ID: <Pine.LNX.4.61.0509301825290.3728@scrub.home>
References: <20050928224419.1.patchmail@tglx.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 28 Sep 2005 tglx@linutronix.de wrote:

Your patch introduces some whitespace damage, search for "^\+  " in your 
patch.

> ktimers seperate the "timer API" from the "timeout API". 

I'm not really happy with these names, timeouts are what timers do, so 
these names don't tell at all, what the difference is.
Calling them "process timer" and "kernel timer" would include their main 
usage, although that also means ptimer were the more correct abbreviation.

> +#ifndef KTIME_IS_SCALAR
> +typedef union {
> +	s64	tv64;
> +	struct {
> +#ifdef __BIG_ENDIAN
> +	s32	sec, nsec;
> +#else
> +	s32	nsec, sec;
> +#endif
> +	} tv;
> +} ktime_t;
> +
> +#else
> +
> +typedef s64 ktime_t;
> +
> +#endif

Making the union unconditional, would make tv64 always available and a lot 
of macros unnessary.

> +struct ktimer {
> +	struct rb_node		node;
> +	struct list_head	list;
> +	ktime_t			expires;
> +	ktime_t			expired;
> +	ktime_t			interval;
> +	int 	 	 	overrun;
> +	unsigned long		status;
> +	void 			(*function)(void *);
> +	void			*data;
> +	struct ktimer_base 	*base;
> +};

This structure is rather large and I think a lot can be avoided.
- list: AFAICT it's only used by run_ktimer_queue() to get the first 
pending entry. This can also be done by keeping track of the first entry 
in the base structure (useful in other places as well).
- expired: can be replaced by base->last_expired (may also be useful in 
other places)
- status: only user is ktimer_active(), the same test can be done by 
testing node.rb_parent.
- interval/overrun: this is only needed by itimers and I think it's 
possible to leave it there. Main change would be to let 'function' return 
a value indicating whether to rearm the timer or not (this includes 
expires is updated).

> +#define DEFINE_KTIME(k) ktime_t k = {.tv64 = 0LL }
> +
> +#define ktime_cmp(a,op,b) ((a).tv64 op (b).tv64)
> +#define ktime_cmp_val(a, op, b) ((a).tv64 op b)

A union ktime would especially avoid this.

> +static inline ktime_t ktime_sub(ktime_t a, ktime_t b)
> +{
> +	ktime_t res;
> +
> +	res.tv64 = a.tv64 - b.tv64;
> +	if (res.tv.nsec < 0)
> +		res.tv.nsec += NSEC_PER_SEC;
> +
> +	return res;
> +}
> +
> +static inline ktime_t ktime_add(ktime_t a, ktime_t b)
> +{
> +	ktime_t res;
> +
> +	res.tv64 = a.tv64 + b.tv64;
> +	if (res.tv.nsec >= NSEC_PER_SEC) {
> +		res.tv.nsec -= NSEC_PER_SEC;
> +		res.tv.sec++;
> +	}
> +	return res;
> +}

Not using 64bit math here allows gcc to generate better code, e.g. gcc 
has to add another test for "nsec < 0" because the condition code is 
already used for the overflow, adding the "sec--" instead is IMO faster 
(i.e. less likely).

> +/* The time bases */
> +#define MAX_KTIMER_BASES	2
> +static DEFINE_PER_CPU(struct ktimer_base, ktimer_bases[MAX_KTIMER_BASES]) =

Do you have any numbers (besides maybe microbenchmarks) that show a real 
advantage by using per cpu data? What kind of usage do you expect here?

The other thing is that this assumes, that all time sources are 
programmable per cpu, otherwise it will be more complicated for a time 
source to run the timers for every cpu, I don't know how safe that 
assumption is.
Changing the array of structures into an array of pointers to the 
structures would allow to switch between percpu bases and a single base.

> +ktime_t ktimer_convert_timespec(struct ktimer *timer, struct timespec *ts)
> +{
> +	struct ktimer_base *base = get_ktimer_base_unlocked(timer);
> +	ktime_t t;
> +	long rem = ts->tv_nsec % base->resolution;
> +
> +	t = ktime_set(ts->tv_sec, ts->tv_nsec);
> +
> +	/* Check, if the value has to be rounded */
> +	if (rem)
> +		t = ktime_add_ns(t, base->resolution - rem);
> +	return t;
> +}

Could you explain a little the resolution handling behind in your patch?
If I read SUS correctly clock resolution and timer resolution don't have 
to be the same, the first is returned by clock_getres() and the latter 
only documented somewhere (and AFAICT our implementation always returned 
the wrong value).
IMO this also means we can don't have to make the rounding that 
complicated. Actually it could be done automatically by the timer, e.g. 
interval timer are reprogrammed at (now + interval) and the timer 
resolution will automatically round it up.

> +static int enqueue_ktimer(struct ktimer *timer, struct ktimer_base *base,
> +			   ktime_t *tim, int mode)
> +{
> +	struct rb_node **link = &base->active.rb_node;
> +	struct rb_node *parent = NULL;
> +	struct ktimer *entry;
> +	struct list_head *prev = &base->pending;
> +	ktime_t now;
> +
> +	/* Get current time */
> +	now = base->get_time();

As get_time() is not necessarily cheap, it can be avoided for nonrelative 
timers by comparing it with the first pending timer. Maintaining a pointer 
to the first timer here, avoids the timer list and is a simple check 
whether the time source needs any reprogramming later.

> +	if ktime_cmp(timer->expires, <=, now) {
> +		timer->expired = now;
> +		/* The caller takes care of expiry */
> +		if (!(mode & KTIMER_NOCHECK))
> +			return -1;

I think KTIMER_NOFAIL would be better name, for a while that had me 
confused, as you actually do check the value, but you don't fail it and 
enqueue it anyway.

bye, Roman
