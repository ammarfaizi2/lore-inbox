Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154300-219>; Sun, 13 Dec 1998 02:51:01 -0500
Received: from hazel.buici.com ([207.108.197.197]:12387 "EHLO hazel.buici.com" ident: "root") by vger.rutgers.edu with ESMTP id <154817-219>; Sat, 12 Dec 1998 23:16:17 -0500
Date: Sat, 12 Dec 1998 20:40:52 -0800
From: Oscar Levi <elf@buici.com>
To: "David S. Miller" <davem@dm.cobaltmicro.com>
Cc: Linux-Kernel <linux-kernel@vger.rutgers.edu>
Subject: Re: linux-kernel-digest V1 #2975
Message-ID: <19981212204051.B9336@hazel.buici.com>
References: <m0zoV6d-0007U1C@the-village.bc.nu> <199812121203.EAA19988@dm.cobaltmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.94.17i
In-Reply-To: <199812121203.EAA19988@dm.cobaltmicro.com>; from David S. Miller on Sat, Dec 12, 1998 at 04:03:54AM -0800
Sender: owner-linux-kernel@vger.rutgers.edu

On Sat, Dec 12, 1998 at 04:03:54AM -0800, David S. Miller wrote:
>    From: alan@lxorguk.ukuu.org.uk (Alan Cox)
>    Date: 	Fri, 11 Dec 1998 16:07:50 +0000 (GMT)
> 
>    One problem with this is that most vendors of kernels ship large
>    complex OS's that will reliably have blasted the last task out of
>    the caches by the time they lumber back around to running it
>    again.
> 
> Going to main memory can be at such a high cost that going there at
> all is to be avoided at all costs.  The Challenge series SGI SMP boxes
> had a huge main memory latency, so they worked like mad on the cache
> warming heuristics in the IRIX scheduler (so much so that their
> scheduler is overly complex, and this complexity only got worse when
> the NUMA support went in).
> 
> Point is, try but not too hard.
> 
> Alpha and Digital Unix took a slightly different approach.  I believe
> from a paper I read (before I get bombed with emails, no I have no
> idea where this paper was nor the title) on their kernel SMP hacks
> that it was:
> 
> 1) Per-cpu run queues
> 2) Fork added new task to parents processor run queue
> 3) Exec pushed the task to another cpu's run queue
> 4) Tasks stayed on the same queue normally
> 5) CPU idleness or overload caused migration of tasks
>    to other cpu run queues if the process load was not
>    equally distributed at such time

One of the same group's papers did some work with this, too.  Their
only interesting result was, IIRC, that the synchronization was more
important than the cache.  They found that a data structure that was
owned by each CPU had a slight edge.  The competition for a single run
queue *did* impose a noticable barrier.

> I get the general effect of 2 and 3 and a little bit of 4 on
> sparc64/SMP with this tiny hack I put into the idler loop:

I am a bit sheepish to say it, but can you show any rigor to your
results?  I ask because my understanding with this level of
optimization is that very little of it has shown to be always
true.  Indeed, intuition does not always grok silicon.

> 		if (current->need_resched != 0 ||
> 		    ((p = init_task.next_run) != NULL &&
> 		     (p->processor == smp_processor_id() ||
> 		      (p->tss.flags & SPARC_FLAG_NEWCHILD) != 0)))
> 			schedule();

> It's a nice cheap heuristic.  And actually I added it so that idlers
> didn't bang into the scheduler (grabbing locks, blowing dirty cache
> lines across the bus ping pong style, etc.) over and over when no new
> work was available.  This nasty behavior is how ix86 SMP behaves
> currently until something equivalent is added to it's idler loop.

Hmm.

> Later,
> David S. Miller
> davem@dm.cobaltmicro.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
