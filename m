Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318349AbSGRURJ>; Thu, 18 Jul 2002 16:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318350AbSGRURJ>; Thu, 18 Jul 2002 16:17:09 -0400
Received: from chaos.analogic.com ([204.178.40.224]:51586 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S318349AbSGRURE>; Thu, 18 Jul 2002 16:17:04 -0400
Date: Thu, 18 Jul 2002 16:23:06 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Daniel Gryniewicz <dang@fprintf.net>
cc: Robert Love <rml@tech9.net>, Szakacsits Szabolcs <szaka@sienet.hu>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] strict VM overcommit for stock 2.4
In-Reply-To: <1027021302.3439.8.camel@athena.fprintf.net>
Message-ID: <Pine.LNX.3.95.1020718154521.1555A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Jul 2002, Daniel Gryniewicz wrote:

> On Thu, 2002-07-18 at 15:35, Richard B. Johnson wrote:
> > On 18 Jul 2002, Robert Love wrote:
> > 
> > > I should also mention this is demand paging, not overcommit.
> > > 
> > > Overcommit is the property of succeeded more allocations than their is
> > > memory in the address space.  The idea being that allocations are lazy,
> > > things often do not use their full allocations, etc. etc. as you
> > > mentioned.
> > > 
> > > It is typical a good thing since it lowers VM pressure.
> > > 
> > > It is not always a good thing, for numerous reasons, and it becomes
> > > important in those scenarios to ensure that all allocations can be met
> > > by the backing store and consequently we never find ourselves with more
> > > memory committed than available and thus never OOM.
> > > 
> > > This has nothing to do with paging and resource limits as you say.  Btw,
> > > without this it is possible to OOM any machine.  OOM is a by-product of
> > > allowing overcommit and poor accounting (and perhaps poor
> > > software/users), not an incorrectly configured machine.
> > 
> > It has everything to do with demand-paging. Since on single CPU
> > machines, there is only one task executing at any one time, that
> > single task can own and use every bit of RAM on the whole machine
> > is virtual memory works correctly. For performance reasons, it
> > may not actually use all the RAM but, in principle, it is possible.
> > 
> > If you don't allow that, the single task can use only the RAM that
> > was not allocated to other tasks. At the time an allocation is made,
> > the kernel cannot know what resources may be available when the task
> > requesting the allocation actually starts to use those allocated
> > resources. Instead, the kernel allocates resources based upon what
> > it 'knows' at the present time. Since it can't see the future anymore
> > than you or I, the fact that N processes just called exit() before
> > the requesting task touched a single page can't be known.
> > 
> > FYI multiple CPU machines have compounded the problems because there
> > can be several things happening at the same time. Although the MM
> > is locked so it's single-threaded, you have a before/after resource 
> > history condition that can't be anticipated.
> > 
> > Cheers,
> > Dick Johnson
> > 
> 
> Is it possible that you're confusing "backing store" with "physical
> RAM"?  I was under the impression that strict overcommit used both RAM
> and SWAP when deciding whether an allocation should succeed.  If you've
> exceeded all of RAM and all of swap, you are OOM.  Period.
> 
> Daniel

No. And I'm not confused. Consider Virtual RAM as all the real RAM
and all the backing store. If I consider this an absolute limit,
then I am not able to fully use all the system resources.

Lets say the system has 20 'units' of a resource (virtual RAM).

Example:

Task (1) allocates 10 units, actually uses 1 so far.
Task (2) allocates 10 units, actually uses 2 so far.
Task (3) wants to allocate 7 units. It can't so it exits in error.
Task (1) uses all its units then exits normally.
Task (2) uses 1 more unit then exits normally.

So you forced a task to terminate in error because you established
hard limits on your resource.

What could (should?) have happened, is that all the memory allocations
could have succeeded, even though they exceeded the 20 units of resource.
>From the history, we see that Task (1) actually used 10. Task (2)
actually used 3 units. This means that there were really 20 - 13 = 7 units
available when task 3 requested 7 units. But, the system 'knew' what
its commitment was so it refused.

Now, since the system is dynamic, it is possible that Task (1) and
Task (2) might not even exist by the time Task (3) actually wants to
use its memory. In that case, there would have been 20 units available, 
but we will never know because Task 3 exited in error.

Now, what this should point out is that a complete VM system, although
it can't anticipate the future, can put things off until the future
where things may be better. This is the true 'fix' of OOM (if it
needs fixing.

Let's say I make a fork bomb, as root, no protection. The MM knows
that it can't give me any more RAM right now so I am put to sleep.
Other tasks run fine, at full speed. As they exit, the fork-bomb
may get their memory. Since the MM knows how much resource could ever 
become available, as a single task exceeds this limit, the MM
knows that it cannot get any more in the future so the MM knows it's
a bomb. If the system doesn't kill the bomb, eventually, I may fail the
system because there may be no resource available to log-in and kill the
bomb, but as long as there is one task running, connected to a terminal,
that task can be used to kill the fork-bomb.

The problem with putting memory allocation off to the future, as
I see it, is the existing paging code wasn't designed for it. If
a task that page-faulted could also sleep, the problem could be
solved.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
                 Windows-2000/Professional isn't.

