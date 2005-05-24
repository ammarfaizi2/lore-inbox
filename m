Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262089AbVEXJwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262089AbVEXJwT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 05:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbVEXJun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 05:50:43 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:56259 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261768AbVEXJaS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 05:30:18 -0400
Message-ID: <4292F5FF.1A92086C@tv-sign.ru>
Date: Tue, 24 May 2005 13:38:07 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: george@mvista.com
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH rc4-mm2 2/2] posix-timers: use try_to_del_timer_sync()
References: <42909DC2.7922E05D@tv-sign.ru> <42926F83.9050608@mvista.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Anzinger wrote:
>
> Oleg Nesterov wrote:
> >
> > This patch removes timer_active/set_timer_inactive which plays with
> > timer_list's internals in favour of using try_to_del_timer_sync(),
> > which was introduced in the previous patch.
>
> Is there a particular reason for this, like it does not work, for example, or
> are you just trying to clean up code?

It's a cleanup, I think that current code is correct.

> If this currently works, please leave it alone.

Ok.

> We also note that this code is the subject of a patch to the RT patch to cover
> the same issue when softirqs are run from threads and therefor allow
> posix_timer_fn to be preempted.  (That fix being mainly to expand usage from
> just SMP to SMP || SOFTIRQ_PREEMPT.)

I guess you are talking about this patch:
http://marc.theaimsgroup.com/?l=linux-kernel&m=111566867218576

> Also, I think that del_timer_sync and friends need to be turned on if soft_irq
> is preemptable.

I agree completely.

> + * For RT the timer call backs are preemptable.  This means that folks
> + * trying to delete timers may run into timers that are "active" for
> + * long times.  To help out with this we provide a wake up function to
> + * wake up a caller who wants waking when a timer clears the call back.
> + * This is the same sort of thing that the del_timer_sync does, but we
> + * need (in the HRT case) to cover two lists and not just the one.
> + */
> +#ifdef CONFIG_PREEMPT_SOFTIRQS
> +#include <linux/wait.h>
> +static DECLARE_WAIT_QUEUE_HEAD(timer_wake_queue);
> +#define wake_timer_waiters() wake_up(&timer_wake_queue)
> +#define wait_for_timer(timer) wait_event(timer_wake_queue, !timer_active(timer))

I'm not an expert at all, so I may be wrong, but I don't think
it's a good idea.

I think it is bad if __run_timers() could be preempted while
->running_timer != NULL. This will interact badly with __mod_timer,
del_timer_sync. I think that __run_timers() should do:

	set_running_timer(base, timer);
	preempt_disable();
	spin_unlock_irq(&base->lock);

	timer->function();

	set_running_timer(base, NULL);
	preempt_enable();
	spin_lock_irq(&base->lock);

What do you think?

Oleg.
