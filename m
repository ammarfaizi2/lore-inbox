Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289400AbSAJLLG>; Thu, 10 Jan 2002 06:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289398AbSAJLKo>; Thu, 10 Jan 2002 06:10:44 -0500
Received: from mx2.elte.hu ([157.181.151.9]:17860 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S289397AbSAJLKX>;
	Thu, 10 Jan 2002 06:10:23 -0500
Date: Thu, 10 Jan 2002 14:07:42 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] minor sched-E1 tweaks and questions
In-Reply-To: <E16OWCo-0000YO-00@wagner.rustcorp.com.au>
Message-ID: <Pine.LNX.4.33.0201101403060.2371-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 10 Jan 2002, Rusty Russell wrote:

> > > Q. How can this happen in expire_task():
> > > 	if (p->array != rq->active) {
> > > 		p->need_resched = 1;
> > > 		return;
> > > 	}
> >
> > if a task gets delayed by some really heavy IRQ load and the timer
> > interrupt hits the task twice.
>
> Hmm... still don't see it.  update_process_times() surely doesn't
> re-enter?  And another CPU cannot load_balance() p (== current) away
> from us.

the issue is when a task has not rescheduled yet even though the previous
timer tick has has told it to do so. Then we'll have the p->array !=
rq->active condition. If some other event (like a heavy SCSI irq or
something else) delays the task from getting into the scheduler for more
than a jiffy, we can get an expire_task() call again - and hit the
condition.

this situation is especially likely to happen with HZ=1024 or higher.

> Another question:
>
> 		context_switch(prev, next);
> 		/*
> 		 * The runqueue pointer might be from another CPU
> 		 * if the new task was last running on a different
> 		 * CPU - thus re-load it.
> 		 */
> 		barrier();
> 		rq = this_rq();
> 	}
> 	spin_unlock_irq(&rq->lock);
>
> I do not understand this comment.  How can rq (ie. smp_processor_id())
> change?  Nothing sleeps here, and if it DID change, the
> spin_unlock_irq() would be wrong...

the 'rq' variable is not 'constant' across context-switch if you look at
what happens on the CPU - we switch away from a task into some other task.
That other task might have a much older 'rq' variable on its kernel stack,
which might be invalid, if the (now executing) task was load-balanced over
to this CPU.

>  } runqueues [NR_CPUS] __cacheline_aligned;
>
> You want each entry in the array to be aligned, not the whole array!

hm, right you are. Will be in my next patch.

	Ingo

