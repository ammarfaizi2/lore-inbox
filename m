Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317850AbSFSL3I>; Wed, 19 Jun 2002 07:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317852AbSFSL3H>; Wed, 19 Jun 2002 07:29:07 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:61192 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S317850AbSFSL3G>; Wed, 19 Jun 2002 07:29:06 -0400
Date: Wed, 19 Jun 2002 07:24:41 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Question about sched_yield()
In-Reply-To: <Pine.LNX.4.44.0206180650001.2834-100000@e2>
Message-ID: <Pine.LNX.3.96.1020619071221.1119C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2002, Ingo Molnar wrote:

> 
> On Mon, 17 Jun 2002, David Schwartz wrote:
> 
> > >I am seeing some strange linux scheduler behaviours,
> > >and I thought this'd be the best place to ask.
> > >
> > >I have two processes, one that loops forever and
> > >does nothing but calling sched_yield(), and the other
> > >is basically benchmarking how fast it can compute
> > >some long math calculation.
> 
> > [...] It is not a replacement for blocking or a scheduling priority
> > adjustment. It simply lets other ready-to-run tasks be scheduled before
> > returning to the current task.
> 
> and this is what the scheduler didnt do properly, it actually didnt
> schedule valid ready-to-run processes for long milliseconds, it switched
> between two sched_yield processes, starving the CPU-intensive process. I
> posted a patch for 2.5 that fixes this, and the 2.4.19-pre10-ac2 backport
> i did includes this fix as well:
> 
>     http://redhat.com/~mingo/O(1)-scheduler/sched-2.4.19-pre10-ac2-A4
> 
> a good sched_yield() implementation should give *all* other tasks a chance
> to run, instead of switching between multiple sched_yield()-ing tasks. I
> don think this is specified anywhere, but it's a quality of implementation
> issue.

Clearly your fix is subtle enough that a quick reading, at least by me,
can't follow all the nuances, but it looks on first reading as if your
patch fixes this too well, and will now starve the threaded process by
only giving one turn at the CPU per full pass through the queue, rather
than sharing the timeslice between threads of a process.

I posted some thoughts on this to Robert, if you would comment I would
appreciate. My thought is that if you have N processes and one is
threaded, the aggregate of all threads should be 1/N of the CPU(s), not
vastly more or less. I think with your change it will be less if they are
sharing a resource. Feel free to tell me I misread what it does, or my
desired behaviour is not correct.

I do run 15 machines with long running a threaded server application and
periodic CPU hog things like log roll and compress, stats generation,
certain database cleanup, etc, and I have more than intelectual curiousity
on this behaviour.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

