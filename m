Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269767AbRHDDB4>; Fri, 3 Aug 2001 23:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269769AbRHDDBq>; Fri, 3 Aug 2001 23:01:46 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:30980 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S269767AbRHDDBa>; Fri, 3 Aug 2001 23:01:30 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>, Ben LaHaise <bcrl@redhat.com>
Subject: Re: [RFC][DATA] re "ongoing vm suckage"
Date: Sat, 4 Aug 2001 05:06:57 +0200
X-Mailer: KMail [version 1.2]
Cc: <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
In-Reply-To: <Pine.LNX.4.33L.0108032144310.11893-100000@imladris.rielhome.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0108032144310.11893-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Message-Id: <0108040506570N.01827@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 04 August 2001 03:29, Rik van Riel wrote:
> On Fri, 3 Aug 2001, Ben LaHaise wrote:
> > --- vm-2.4.7/drivers/block/ll_rw_blk.c.2	Fri Aug  3 19:06:46 2001
> > +++ vm-2.4.7/drivers/block/ll_rw_blk.c	Fri Aug  3 19:32:46 2001
> > @@ -1037,9 +1037,16 @@
> >  		 * water mark. instead start I/O on the queued stuff.
> >  		 */
> >  		if (atomic_read(&queued_sectors) >= high_queued_sectors) {
> > -			run_task_queue(&tq_disk);
> > -			wait_event(blk_buffers_wait,
> > -			 atomic_read(&queued_sectors) < low_queued_sectors);
>
> ... OUCH ...
>
> > bah.  Doesn't fix it.  Still waiting indefinately in ll_rw_blk().
>
> And it's obvious why.
>
> The code above, as well as your replacement, are have a
> VERY serious "fairness issue".
>
> 	task 1			task 2
>
>  queued_sectors > high
>    ==> waits for
>    queued_sectors < low
>
>                              write stuff, submits IO
>                              queued_sectors < high  (but > low)
>                              ....
>                              queued sectors still < high, > low
>                              happily submits more IO
>                              ...
>                              etc..
>
> It is quite obvious that the second task can easily starve
> the first task as long as it keeps submitting IO at a rate
> where queued_sectors will stay above low_queued_sectors,
> but under high_queued sectors.

Nice shooting, this could explain the effect I noticed where
writing a linker file takes 8 times longer when competing with
a simultaneous grep.

> There are two possible solutions to the starvation scenario:
>
> 1) have one threshold
> 2) if one task is sleeping, let ALL tasks sleep
>    until we reach the lower threshold

Umm.... Hmm, there are lots more solutions than that, but those two
are nice and simple.  A quick test for (1) I hope Ben will try is
just to set high_queued_sectors = low_queued_sectors.

Currently, IO scheduling relies on the "random" algorithm for fairness
where the randomness is supplied by the processes.  This breaks down
sometimes, spectacularly, for some distinctly non-random access
patterns as you demonstrated.

Algorithm (2) above would have some potentially strange interactions
with the scheduler, it looks scary.  (E.g., change the scheduler, IO
on some people's machines suddenly goes to hell.)

Come to think of it (1) will also suffer in some cases from nonrandom
scheduling.

Now let me see, why do we even have the high+low thresholds?  I
suppose it is to avoid taking two context switches on every submitted
block, so it seems like a good idea.

For IO fairness I think we need something a little more deterministic.
I'm thinking about an IO quantum right now - when a task has used up
its quantum it yields to the next task, if any, waiting on the IO
queue.  How to preserve the effect of the high+low thresholds... it
needs more thinking, though I've already thought of several ways of
doing it badly :-)

--
Daniel
