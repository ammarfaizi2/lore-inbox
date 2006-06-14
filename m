Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbWFMWtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbWFMWtL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 18:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbWFMWtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 18:49:11 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:43178 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751082AbWFMWtK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 18:49:10 -0400
Date: Wed, 14 Jun 2006 06:49:09 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: john stultz <johnstul@us.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       Roland McGrath <roland@redhat.com>
Subject: Re: [RFC][PATCH] Avoid race w/ posix-cpu-timer and exiting tasks
Message-ID: <20060614024909.GA563@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
>
> Hey Ingo,
> 	We've occasionally come across OOPSes in posix-cpu-timer thread (as
> well as tripping over the BUG_ON(tsk->exit_state there) where it appears
> the task we're processing exits out on us while we're using it. 
>
> Thus this fix tries to avoid running the posix-cpu-timers on a task that
> is exiting.
>
> --- 2.6-rt/kernel/posix-cpu-timers.c	2006-06-11 15:38:58.000000000 -0500
> +++ devrt/kernel/posix-cpu-timers.c	2006-06-12 10:52:20.000000000 -0500
> @@ -1290,12 +1290,15 @@
>
>  #undef	UNEXPIRED
>
> -	BUG_ON(tsk->exit_state);
> -
>  	/*
>  	 * Double-check with locks held.
>  	 */
>  	read_lock(&tasklist_lock);
> +	/* Make sure the task doesn't exit under us. */
> +	if(unlikely(tsk->exit_state)) {
> +		read_unlock(&tasklist_lock);
> +		return;
> +	}
>  	spin_lock(&tsk->sighand->siglock);

I strongly believe this BUG_ON() is indeed wrong, and I did a similar patch
a long ago:

	[PATCH] posix-timers: remove false BUG_ON() from run_posix_cpu_timers()
	Commit 3de463c7d9d58f8cf3395268230cb20a4c15bffa

However it was reverted due to some unclear problems (I think those problems
were not related to this patch).

Instead this patch was added:

	[PATCH] Yet more posix-cpu-timer fixes
	Commit 3de463c7d9d58f8cf3395268230cb20a4c15bffa

and I still think this patch is not correct.

Quoting myself:
>
> Roland McGrath wrote:
> >
> > @@ -566,6 +566,9 @@ static void arm_timer(struct k_itimer *t
> >         struct cpu_timer_list *next;
> >         unsigned long i;
> >
> > +       if (CPUCLOCK_PERTHREAD(timer->it_clock) && (p->flags & PF_EXITING))
> > +               return;
> > +
>
> Why CPUCLOCK_PERTHREAD() ?.
>
> Also, this is racy, no? Why should arm_timer() see PF_EXITING which is
> set on another cpu without any barriers/locking? After all, arm_timer()
> can test PF_EXITING before do_exit() sets this flag, but set ->it_xxx_expires
> after do_exit() resets it.

Oleg.

