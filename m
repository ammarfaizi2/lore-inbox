Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751406AbWFTQjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbWFTQjv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 12:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbWFTQjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 12:39:51 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:27014 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751406AbWFTQju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 12:39:50 -0400
Date: Tue, 20 Jun 2006 12:39:38 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Esben Nielsen <nielsen.esben@googlemail.com>
cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: Why can't I set the priority of softirq-hrt? (Re: 2.6.17-rt1)
In-Reply-To: <Pine.LNX.4.64.0606201725550.11643@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0606201229310.729@gandalf.stny.rr.com>
References: <20060618070641.GA6759@elte.hu>  <Pine.LNX.4.64.0606201656230.11643@localhost.localdomain>
 <1150816429.6780.222.camel@localhost.localdomain>
 <Pine.LNX.4.64.0606201725550.11643@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 20 Jun 2006, Esben Nielsen wrote:

> I am sorry. I should have read some more of the code before asking.
>
> The only question I have is why the priority of the callback is set to
> priority of the task calling hrtimer_start() (current->normal_prio). That
> seems like an odd binding to me. Shouldn't the finding of the priority be moved over to the
> posix-timer code, where it is needed, and be given as a parameter to
> hrtimer_start()?
> In rtmutex.c, where a hrtimer is used as a timeout on a mutex, wouldn't it
> make more sense to use current->prio than current->normal_prio if the task
> is boosted when it starts to wait on a mutex.

That seems reasonable.  It probably is a bug to use normal_prio, since we
really do care what prio is at that time.

>
>
> But I am not sure I like the design at all:
>
> Let say you have a bunch of callback running at priority 1 and then the
> next hrt timer with priority 99 expires. Then the callback which
> is running will be boosted to priority 99. So the overall latency at
> priority 99 will at least the latency of the worst hrtimer callback.

You mean for those that expire at the same time?

I don't think this is a problem, because the run_hrtimer_hres_queue runs
the hightest priorty callback first, then it adjusts its prio to the next
priority callback.  See hrtimer_adjust_softirq_prio.

> And worse: What if the callback running is blocked on a mutex? Will the
> owner of the mutex be boosted as well? Not according to the code in
> sched.c. Therefore you get priority inversion to priority 1. That is the
> worst case hrtimer latency is that of priority 1.

I don't see this.

>
> Therefore, a simpler and more robust design would be to give the thread
> priority 99 as a default - just as the posix_cpu_timer thread. Then the
> system designer can move it around with chrt when needed.
> In fact you can say the current design have both the worst cases of having
> it running as priority 99 and at priority 1!

I still don't see this happening.

>
> Another complicated design would be to make a task for each priority.
> Then the interrupt wakes the highest priority one, which handles the first
> callback and awakes the next one etc.

Don't think that is necessary.

-- Steve

