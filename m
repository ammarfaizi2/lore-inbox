Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289347AbSAJFu7>; Thu, 10 Jan 2002 00:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289348AbSAJFut>; Thu, 10 Jan 2002 00:50:49 -0500
Received: from [202.135.142.196] ([202.135.142.196]:22540 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S289347AbSAJFul>; Thu, 10 Jan 2002 00:50:41 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] minor sched-E1 tweaks and questions 
In-Reply-To: Your message of "Wed, 09 Jan 2002 11:41:19 BST."
             <Pine.LNX.4.33.0201091126520.2276-100000@localhost.localdomain> 
Date: Thu, 10 Jan 2002 14:48:42 +1100
Message-Id: <E16OWCo-0000YO-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.33.0201091126520.2276-100000@localhost.localdomain> you 
write:
> > Q. How can this happen in expire_task():
> > 	if (p->array != rq->active) {
> > 		p->need_resched = 1;
> > 		return;
> > 	}
> 
> if a task gets delayed by some really heavy IRQ load and the timer
> interrupt hits the task twice.

Hmm... still don't see it.  update_process_times() surely doesn't
re-enter?  And another CPU cannot load_balance() p (== current) away
from us.

Another question:

	if (likely(prev != next)) {
		rq->nr_switches++;
		rq->curr = next;
		next->cpu = prev->cpu;
		context_switch(prev, next);
		/*
		 * The runqueue pointer might be from another CPU
		 * if the new task was last running on a different
		 * CPU - thus re-load it.
		 */
		barrier();
		rq = this_rq();
	}
	spin_unlock_irq(&rq->lock);

I do not understand this comment.  How can rq (ie. smp_processor_id())
change?  Nothing sleeps here, and if it DID change, the
spin_unlock_irq() would be wrong...

> i've taken your fixes, please double-check the next patch whether all of
> them are correctly applied.

Um, missed one:

 static struct runqueue {
-	int cpu;
 	spinlock_t lock;
-	unsigned long nr_running, nr_switches, last_rt_event;
+	unsigned long nr_running, nr_switches;
 	task_t *curr, *idle;
 	prio_array_t *active, *expired, arrays[2];
-	char __pad [SMP_CACHE_BYTES];
+	int prev_nr_running[NR_CPUS];
 } runqueues [NR_CPUS] __cacheline_aligned;

You want each entry in the array to be aligned, not the whole array!
You need to define the struct runqueue to be the cacheline aligned
(using ____cacheline_aligned since it's a type), THEN put the
__cacheline_aligned after the array declaration so it gets put in the
aligned section:

 struct runqueue {
 	spinlock_t lock;
	unsigned long nr_running, nr_switches;
 	task_t *curr, *idle;
 	prio_array_t *active, *expired, arrays[2];
	int prev_nr_running[NR_CPUS];
 } ____cacheline_aligned;

 static struct runqueue runqueues [NR_CPUS] __cacheline_aligned;

This is why my __per_cpu patch was invented 8)
Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
