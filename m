Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbVI2BKG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbVI2BKG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 21:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932073AbVI2BKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 21:10:06 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:58543 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932071AbVI2BKE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 21:10:04 -0400
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
From: john stultz <johnstul@us.ibm.com>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, akpm@osdl.org,
       george@mvista.com, paulmck@us.ibm.com, hch@infradead.org,
       oleg@tv-sign.ru, zippel@linux-m68k.org, tim.bird@am.sony.com
In-Reply-To: <20050928224419.1.patchmail@tglx.tec.linutronix.de>
References: <20050928224419.1.patchmail@tglx.tec.linutronix.de>
Content-Type: text/plain
Date: Wed, 28 Sep 2005 18:10:00 -0700
Message-Id: <1127956200.8195.260.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-28 at 22:43 +0200, tglx@linutronix.de wrote:
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
> +
> +	/* Timer expiry mode */
> +	switch (mode & ~KTIMER_NOCHECK) {
> +	case KTIMER_ABS:
> +		timer->expires = *tim;
> +		break;
> +	case KTIMER_REL:
> +		timer->expires = ktime_add(now, *tim);
> +		break;
> +	case KTIMER_INCR:
> +		timer->expires = ktime_add(timer->expires, *tim);
> +		break;

...



> +static inline void do_remove_ktimer(struct ktimer *timer,
> +				    struct ktimer_base *base, int rearm)
> +{
> +	list_del(&timer->list);
> +	rb_erase(&timer->node, &base->active);
> +	timer->node.rb_parent = KTIMER_POISON;
> +	timer->status = KTIMER_INACTIVE;
> +	base->count--;
> +	BUG_ON(base->count < 0);
> +	/* Auto rearm the timer ? */
> +	if (rearm && ktime_cmp_val(timer->interval, !=, KTIME_ZERO))
> +		enqueue_ktimer(timer, base, NULL, KTIMER_REARM);
> +}


There's a couple of places like this where you pass NULL as the ktime_t
pointer tim to enqueue_ktimer(). However in enqueue_ktimer, you
dereference tim in a few spots w/o checking for NULL.

I'm guessing this is what Frank is seeing.

thanks
-john


