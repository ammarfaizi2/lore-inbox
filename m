Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263010AbTJPRR1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 13:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263052AbTJPRR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 13:17:27 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:15498
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S263010AbTJPRRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 13:17:23 -0400
Date: Thu, 16 Oct 2003 19:17:43 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] SMP races in the timer code, timer-fix-2.6.0-test7-A0
Message-ID: <20031016171742.GG1663@velociraptor.random>
References: <Pine.LNX.4.56.0310111032250.5373@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0310111032250.5373@earth>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

On Sat, Oct 11, 2003 at 10:55:42AM +0200, Ingo Molnar wrote:
> 
> the patch below fixes two del_timer_sync() races that are still in the
> timer code.
> 
> the first race was actually triggered in a 2.4 backport of the 2.6 timer
> code. The second race was never triggered - it is mostly theoretical on a
> standalone kernel. (it's more likely in any virtualized or otherwise
> preemptable environment.)
> 
> both races happen when self-rearming timers are used. One mainstream
> example is kernel/itimer.c. The effect of the races is that
> del_timer_sync() lets a timer running instead of synchronizing with it,
> causing logic bugs (and crashes) in the affected kernel code. One typical
> incarnation of the race is a double add_timer().
> 
> race #1:
> 
> this code in __run_timers() is running on CPU0:
> 
>                         list_del(&timer->entry);
>                         timer->base = NULL;
> 			[*]
>                         set_running_timer(base, timer);
>                         spin_unlock_irq(&base->lock);
> 			[**]
>                         fn(data);
>                         spin_lock_irq(&base->lock);
> 
> CPU0 gets stuck at the [*] code-point briefly - after the timer->base has
> been set to NULL, but before the base->running_timer pointer has been set
> up. This is a fundamentally volatile scenario, as there's _zero_ knowledge
> in the data structures that this timer is about to be executed!

the 2.4 backport I'm using doesn't clear timer->base in __run_timers (it
actually never clears it).  This mean, del_timer_sync will serialize
against set_running_timers (aka timer_enter) just fine using the
base->lock. And the base can't change under del_timer_sync thanks to the
guarantee provided by the per-timer spinlock that I take in every timer
entry point (add_timer/del_timer/del_timer_sync whatever). I take the
per-timer lock before taking the base->lock of course.

In short I don't think the backported implementation I'm using was
vulnerable. Of course del_timer_sync unlocks both locks if  the timer
was running, before retrying, this allows the fn() callback to complete
(the recursive add_timer executed inside fn() needs to go ahead and take
the timer->lock before the timer can be nuked synchronously).

I find the per-timer spinlock much more relaible. And it's needed
anyways to get mod_timer against mod_timer right (I assume you already
backported that fix). Recently I also added the needed cpu_relax for HT
in the spinlock-by-hand slow paths of the 2.4 backport that I wrote
(this isn't an issue in 2.6 where the timer has a proper spinlock and
not a spinlock by hand).

> race #2
> 
> the checking of del_timer_sync() for 'pending or running timer' is
> fundamentally unrobust. Eg. if CPU0 gets stuck at the [***] point below:
> 
>                 base = &per_cpu(tvec_bases, i);
>                 if (base->running_timer == timer) {
>                         while (base->running_timer == timer) {
>                                 cpu_relax();
>                                 preempt_check_resched();
>                         }
> 			[***]
>                         break;
>                 }
>         }
>         smp_rmb();
>         if (timer_pending(timer))
>                 goto del_again;
> 
> 
> then del_timer_sync() has already decided that this timer is not running
> (we just finished loop-waiting for it), but we have not done the
> timer_pending() check yet.
> 
> if the timer has re-armed itself, and if the timer expires on CPU1 (this
> needs a long delay on CPU0 but that's not hard to achieve eg. in UML or
> with kernel preemption enabled), then CPU1 could start to expire the timer
> and gets to the [**] point in __run_timers (see above), then CPU1 gets
> stalled and CPU0 is unstalled, then the timer_pending() check in
> del_timer_sync() will not notice the running timer, and del_timer_sync()  
> returns - while CPU1 is just about to run the timer!

This also cannot happen with my current implementation. The
del_timer_sync cannot race with code before the unlock of the
base->lock.

I'm not checking all bases, I'm only checking the current
timer->base->running_timer to see if the timer is stull running (the
base cannot change under me anyways), and the check is completely
serialized. Nothing can change under del_timer_sync while I compare
timer->base->running_timer to timer.

My suggestion is to take the timer->lock everywhere, including
del_timer/del_timer_sync/add_timer_on in 2.6 too (and we may have to
stop clearing the base too). Currently in 2.6 add_timer_on is also
unsafe in rearming the timer, the per-timer locking everywhere will make
it safe against del_timer_sync too. Then all races will be automatically
closed like in my 2.4 version. Of course you will need to take the base
lock too in the del_timer_sync synchronous checks, but del_timer has to
take it anyways for removing the timer from the queue, so del_timer_sync
won't be slowed down by it if you do both things at the same time (as in
my current 2.4 implementation incidentally). And the cacheline with the
timer likely will be hot anyways for all the list_del/add, so I doubt
enforcing the full locking like I'm doing in 2.4 can be a significant
hit, and it makes everything so much simpler since you know nothing can
change under you after you get first the timer->lock and then the
base->lock.

I'd appreciate if you could double check I'm not missing something about
this problem.

For the record my latest and greatest implementation I'm talking about
above, is very easy to review and/or apply to any 2.4 tree, it's here:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.23pre6aa3/00_smp-timers-not-deadlocking-6

(the non-deadlocking is because of the numerous anti-deadlock fixes
included into this version)

Comments welcome, thanks.
