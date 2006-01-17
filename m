Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbWAQRem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbWAQRem (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 12:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbWAQRel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 12:34:41 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:50890
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932230AbWAQRel
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 12:34:41 -0500
Subject: Re: [ANNOUNCE] 2.6.15-rc5-hrt2 - hrtimers based high resolution
	patches
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, George Anzinger <george@mvista.com>,
       john stultz <johnstul@us.ibm.com>, Roman Zippel <zippel@linux-m68k.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1136937547.6197.73.camel@localhost.localdomain>
References: <1134385343.4205.72.camel@tglx.tec.linutronix.de>
	 <1134507927.18921.26.camel@localhost.localdomain>
	 <20051214084019.GA18708@elte.hu>  <20051214084333.GA20284@elte.hu>
	 <1136937547.6197.73.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 17 Jan 2006 18:35:05 +0100
Message-Id: <1137519305.17609.48.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-10 at 18:59 -0500, Steven Rostedt wrote:
> And this _is_ protected, but I just discovered that this does _not_
> protect against hrtimer_start!
> 
> In hrtimer_start we have:
> 
> 	base = lock_hrtimer_base(timer, &flags);
> 
> 	/* Remove an active timer from the queue: */
> 	remove_hrtimer(timer, base);
> 
> Which can be called after that spin_unlock_irq is done by the
> run_hrtimer_queue, and we will hit a bug (as I did).  This is not an
> easy race to hit. 

Right, but there should be actually no use case where this happens.

For now I prefer to add a 

BUG_ON(base->curr_timer == timer); 

into hrtimer_start to find the real reason.

> Here's an example of a race for this problem:
> In posix-timers.c: commen_timer_set:
> 
>    If we get preempted between hrtimer_try_to_cancel and
>    hrtimer_restart.
> 
>    Then a new thread adds the timer back (by a threaded program).

I don't see how this should happen.

sys_timer_settime()
	timr = lock_timer(timer_id, flag);

Now the k_itimer, which is the container of the hrtimer is locked.

common_timer_set()
	if (hrtimer_try_to_cancel() < 0)
		return TIMER_RETRY;
	....
	hrtimer_start();
	return;

back in sys_timer_settime()

	unlock_timer(timr);

So how gets this timer added back, when the container lock is held
across the complete operation ?

> Now the question is what's the right solution?  Can hrtimer_start
> schedule?  Probably not, maybe we should add something to check this and
> have hrtimer_start return -1 if it is running, and let who ever called
> it figure out what to do?  Maybe have a hrtimer_cancel_start atomic
> operation? As well as a hrtimer_try_to_cancel_start?

The posix timer code does already the Right Thing, as it uses
hrtimer_try_to_cancel() and reacts on the return value. This is
necessary to prevent a dead lock with the k_itimer lock. 

I try to reproduce this with your test program on my test boxes.

	tglx


