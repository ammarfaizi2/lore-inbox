Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275806AbRI1CuQ>; Thu, 27 Sep 2001 22:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275807AbRI1CuH>; Thu, 27 Sep 2001 22:50:07 -0400
Received: from node-209-133-23-217.caravan.ru ([217.23.133.209]:62737 "EHLO
	mail.tv-sign.ru") by vger.kernel.org with ESMTP id <S275806AbRI1Cty>;
	Thu, 27 Sep 2001 22:49:54 -0400
To: andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [patch] softirq performance fixes, cleanups, 2.4.10.
Message-Id: <E15mnjA-0000sW-00@mail.tv-sign.ru>
From: Oleg Nesterov <oleg@tv-sign.ru>
Date: Fri, 28 Sep 2001 06:50:12 +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Thanks a lot for Your response.

On Fri, Sep 28, 2001 at 04:03:39 +0400, Andrea Arcangeli wrote:
> > @@ -381,26 +380,22 @@
> >  #endif
> >  
> >  	current->nice = 19;
> > -	schedule();
> > -	__set_current_state(TASK_INTERRUPTIBLE);
> 
> buggy (check cpus_allowed).

Why? The next three lines is

	for (;;) {
		schedule();
		__set_current_state(TASK_INTERRUPTIBLE);

And if I misunderstand schedule()'s

still_running:
	if (!(prev->cpus_allowed & (1UL << this_cpu)))
		goto still_running_back;

Ingo's patch was buggy as well.

> you dropped Ingo's optimization (but you resurrected the strictier /proc
> statistics).

Again, I can't understand. The new loop

	for (;;) {
		schedule();
		__set_current_state(TASK_INTERRUPTIBLE);

		do {
			do_softirq();
			if (current->need_resched)
				goto preempt;
		} while (softirq_pending(cpu));

		continue;
preempt:
		__set_current_state(TASK_RUNNING);
	}

seems to be _equivalent_ to Ingo's ... 

What i am missed? I apologize in advance, if it is
something obvious.

Oleg
