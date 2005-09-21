Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbVIULQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbVIULQG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 07:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbVIULQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 07:16:06 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:4741 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1750810AbVIULQF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 07:16:05 -0400
Message-ID: <433143C1.8D1C6F9C@tv-sign.ru>
Date: Wed, 21 Sep 2005 15:28:01 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       George Anzinger <george@mvista.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: [PATCH] ktimers subsystem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:
>
> +static int internal_restart_ktimer(struct ktimer *timer, nsec_t *tim,
> +				   int mode)
> +{
> +	struct ktimer_base *base, *new_base;
> +  	unsigned long flags;
> +	int ret;
> +
> +	BUG_ON(!timer->function);
> +
> + retry:
> +	base = lock_ktimer_base(timer, &flags);
> +
> +	/* Remove an active timer from the queue */
> +	ret = remove_ktimer(timer, base);
> +
> +	/* Switch the timer base, if necessary */
> +	new_base = switch_ktimer_base(timer, base);
> +
> +	/* SMP  */
> +	if (ktimer_base_can_change && unlikely(!new_base)){
> +		spin_unlock_irqrestore(&base->lock, flags);
> +		wait_for_ktimer(timer);
> +		goto retry;
> +	}

This is deadlockable.

The caller of modify_ktimer()->internal_restart_ktimer() can hold locks
which would prevent the completion of the ktimer->function().

Also, I don't understand why the timer is deleted _before_ checking that
new_base != NULL. This way you can delete the timer (ret == 1), then goto
retry, then get ret == 0.

Oleg.
