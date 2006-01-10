Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932729AbWAJX7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932729AbWAJX7k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 18:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932739AbWAJX7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 18:59:40 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:3498 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932729AbWAJX7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 18:59:39 -0500
Subject: Re: [ANNOUNCE] 2.6.15-rc5-hrt2 - hrtimers based high resolution
	patches
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: George Anzinger <george@mvista.com>, tglx@linutronix.de,
       john stultz <johnstul@us.ibm.com>, Roman Zippel <zippel@linux-m68k.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20051214084333.GA20284@elte.hu>
References: <1134385343.4205.72.camel@tglx.tec.linutronix.de>
	 <1134507927.18921.26.camel@localhost.localdomain>
	 <20051214084019.GA18708@elte.hu>  <20051214084333.GA20284@elte.hu>
Content-Type: text/plain
Date: Tue, 10 Jan 2006 18:59:07 -0500
Message-Id: <1136937547.6197.73.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-14 at 09:43 +0100, Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > hm, in that case it should be base->running that protects against this 
> > case. Did you run an UP PREEMPT_RT kernel? In that case could you 
> > check whether the fix below resolves the crash too?
> 
> try the patch below instead. (Thomas pointed out that the correct 
> dependency in this case is PREEMPT_SOFTIRQS)
> 
> 	Ingo
> 
> Index: linux/kernel/hrtimer.c
> ===================================================================
> --- linux.orig/kernel/hrtimer.c
> +++ linux/kernel/hrtimer.c
> @@ -118,7 +118,7 @@ static DEFINE_PER_CPU(struct hrtimer_bas
>   * Functions and macros which are different for UP/SMP systems are kept in a
>   * single place
>   */
> -#ifdef CONFIG_SMP
> +#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_SOFTIRQS)
>  
>  #define set_curr_timer(b, t)		do { (b)->curr_timer = (t); } while (0)
>  

OK Thomas and Ingo, I hit the bug again! And this time I found the other
race. Again let me explain where in the code I have a problem, and I
feel really uncomfortable with the "implied logic" to protect the race.

In __remove_hrtimer we have:

#ifdef CONFIG_HIGH_RES_TIMERS
	if (timer->state == HRTIMER_PENDING_CALLBACK) {
		list_del(&timer->list);
		return;
	}
#endif

And in run_hrtimer_hres_queue (and something similar with
run_hrtimer_queue) we have:

		set_curr_timer(base, timer);
		list_del(&timer->list);
		spin_unlock_irq(&base->lock);

__remove_hrtimer is protected with the base-lock, so in this case we
have the logic of set_curr_timer to protect against
hrtimer_try_to_cancel which has:

	if (base->curr_timer != timer)
		ret = remove_hrtimer(timer, base);

And this _is_ protected, but I just discovered that this does _not_
protect against hrtimer_start!

In hrtimer_start we have:

	base = lock_hrtimer_base(timer, &flags);

	/* Remove an active timer from the queue: */
	remove_hrtimer(timer, base);

Which can be called after that spin_unlock_irq is done by the
run_hrtimer_queue, and we will hit a bug (as I did).  This is not an
easy race to hit.  Here's an example of a race for this problem:

In posix-timers.c: commen_timer_set:

   If we get preempted between hrtimer_try_to_cancel and
   hrtimer_restart.

   Then a new thread adds the timer back (by a threaded program).

   Now the timer goes off for the softirq, and the softirq runs
   and just after it removes the timer and unlocks the base spinlock, it
   gets preempted by some high prio task that blocks on the original
   thread and boosts it's priority higher than the softirq.

   Now the first thread runs and then calls hrtimer_start, and the timer
   is now in the state PENDING_CALLBACK but is _not_ on the list. So
   this will error when it tries to delete the timer again.

This is a really hard race to hit. But it is possible, and I hit it with
my kernel because I have some crazy dynamic scheduling going on.

Now the question is what's the right solution?  Can hrtimer_start
schedule?  Probably not, maybe we should add something to check this and
have hrtimer_start return -1 if it is running, and let who ever called
it figure out what to do?  Maybe have a hrtimer_cancel_start atomic
operation? As well as a hrtimer_try_to_cancel_start?

-- Steve

