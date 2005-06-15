Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261536AbVFOUY5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbVFOUY5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 16:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbVFOUY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 16:24:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22470 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261536AbVFOUYw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 16:24:52 -0400
Date: Wed, 15 Jun 2005 13:25:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu,
       Roland McGrath <roland@redhat.com>
Subject: Re: [BUG] Race condition with it_real_fn in kernel/itimer.c
Message-Id: <20050615132522.3b6a857c.akpm@osdl.org>
In-Reply-To: <1118852632.4508.48.camel@localhost.localdomain>
References: <1118852632.4508.48.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> wrote:
>
> OK, I found this bug on an older version of Ingo's RT kernel with my own
> customizations. This is a very hard to get race condition but my logging
> traced it pretty good and this looks like it may also be a bug for both
> Ingo's RT kernel and the vanilla kernel. This was on an SMP machine.
> 
> Here's the race (since this was initiated with XFree86, I'll use it as
> the userland process that started this):
> 
> XFree86: calls sys_call 
>     -> sys_setitimer
>        -> do_setitimer 
>            (grabs tsk->sighand->siglock)
>            -> del_timer_sync
>      which has the following code:
> 
> 	for_each_online_cpu(i) {
> 		base = &per_cpu(tvec_bases, i);
> 		if (base->running_timer == timer) {
> 			while (base->running_timer == timer) {
> 				cpu_relax();
> 				preempt_check_resched();
> 			}
> 			break;
> 		}
> 	}
> 
> If the timer hasn't gone off yet on another cpu, it will spin until it
> is finished. Now here's the problem:
> 
> ksoftirqd: calls do_softirq -> ... -> run_timer_softirq
>       -> __run_timers
>         -> it_real_fn
>             -> send_group_sig_info
>               -> group_send_sig_info
>                   (grabs p->sighand->siglock)
> 
> Now, since the ksoftirqd is what changes running_timer, we have a
> deadlock! 

Yes, that's a deadlock.

> What would be the harm in doing something like:
> 
> --- linux-2.6.12-rc6/kernel/itimer.c.orig	2005-06-15 12:14:13.000000000 -0400
> +++ linux-2.6.12-rc6/kernel/itimer.c	2005-06-15 12:18:31.000000000 -0400
> @@ -153,11 +153,15 @@
>  
>  	switch (which) {
>  	case ITIMER_REAL:
> +	try_again:
>  		spin_lock_irq(&tsk->sighand->siglock);
>  		interval = tsk->signal->it_real_incr;
>  		val = it_real_value(tsk->signal);
> -		if (val)
> +		if (val) {
> +			spin_unlock_irq(&tsk->sighand->siglock);
>  			del_timer_sync(&tsk->signal->real_timer);
> +			goto try_again;
> +		}
>  		tsk->signal->it_real_incr =
>  			timeval_to_jiffies(&value->it_interval);
>  		it_real_arm(tsk, timeval_to_jiffies(&value->it_value));
> 
> 

And that will fix it.  (Labels start in column zero, and a comment is
needed here).

However I wonder if it would be sufficient to remove the del_timer_sync()
call altogether and just do mod_timer() in it_real_arm().

If the handler happens to be running on another CPU and if the handler
tries to run mod_timer() _after_ the do_setitimer() has run mod_timer(),
the handler will use the desired value of it_real_incr anyway.


