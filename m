Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261521AbSIYDDo>; Tue, 24 Sep 2002 23:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261884AbSIYDDo>; Tue, 24 Sep 2002 23:03:44 -0400
Received: from wsip68-15-8-100.sd.sd.cox.net ([68.15.8.100]:11908 "EHLO
	gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id <S261521AbSIYDDn>; Tue, 24 Sep 2002 23:03:43 -0400
Date: Tue, 24 Sep 2002 20:08:39 -0700
To: Ingo Molnar <mingo@elte.hu>
Cc: Andy Isaacson <adi@hexapodia.org>, Larry McVoy <lm@bitmover.com>,
       Peter W?chtler <pwaechtler@mac.com>, Bill Davidsen <davidsen@tmr.com>,
       linux-kernel@vger.kernel.org,
       "Bill Huey (Hui)" <billh@gnuppy.monkey.org>
Subject: Re: 1:1 threading vs. scheduler activations (was: Re: [ANNOUNCE] Native POSIX Thread Library 0.1)
Message-ID: <20020925030839.GA4746@gnuppy.monkey.org>
References: <20020923185756.C13340@hexapodia.org> <Pine.LNX.4.44.0209240755060.8943-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209240755060.8943-100000@localhost.localdomain>
User-Agent: Mutt/1.4i
From: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2002 at 08:32:16AM +0200, Ingo Molnar wrote:
> yes, SA's (and KSA's) are an interesting concept, but i personally think
> they are way too much complexity - and history has shows that complexity
> never leads to anything good, especially not in OS design.

FreeBSD's KSEs .;)

> Eg. SA's, like every M:N concept, must have a userspace component of the
> scheduler, which gets very funny when you try to implement all the things
> the kernel scheduler has had for years: fairness, SMP balancing, RT
> scheduling (!), preemption and more.

Yeah, I understand. These folks are doing some interesting stuff and
might provide some answers for you:

	http://www.research.ibm.com/K42/

This paper specifically:

	http://www.research.ibm.com/K42/white-papers/Scheduling.pdf

Their stuff isn't too much different than FreeBSD's KSE project, different
names for the primitives, different communication, etc...

> And then i havent mentioned things like upcall costs - what's the point in
> upcalling userspace which then has to schedule, instead of doing this
> stuff right in the kernel? Scheduler activations concentrate too much on
> the 5% of cases that have more userspace<->userspace context switching
> than some sort of kernel-provoked context switching. Sure, scheduler
> activations can be done, but i cannot see how they can be any better than
> 'just as fast' as a 1:1 implementation - at a much higher complexity and
> robustness cost.

Folks have been experimenting with other means of kernel/userspace using
a chunk of shared memory, notification and polling when the UTS gets entered
by a block on a mutex or other operation. Upcalls are what was used in
the original Topaz OS paper that implemented SAs, Mach was the other.
It doesn't mean that it's used universally for all implementations.

> the biggest part of Linux's kernel-space context switching is the cost of
> kernel entry - and the cost of kernel entry gets cheaper with every new
> generation of CPUs. Basing the whole threading design on the avoidance of
> the kernel scheduler is like basing your tent on a glacier, in a hot
> summer day.
> 
> Plus in an M:N model all the development toolchain suddenly has to
> understand the new set of contexts, debuggers, tracers, everything.

That's not an issue. Folks expect that to be so when working with any
new threading system.

> Plus there are other issues like security - it's perfectly reasonable in
> the 1:1 model for a certain set of server threads to drop all privileges
> to do the more dangerous stuff. (while there is no such thing as absolute
> security and separation in a threaded app, dropping privileges can avoid
> certain classes of exploits.)

> generally the whole SA/M:N concept creaks under the huge change that is
> introduced by having multiple userspace contexts of execution per a single
> kernel-space context of execution. Such detaching of concepts, no matter
> which kernel subsystem you look at, causes problems everywhere.

Maybe, it's probably implementation specific. I'm curious as to how K42
performs.

> eg. the VM. There's no way you can get an 'upcall' from the VM that you
> need to wait for free RAM - most of the related kernel code is simply not
> ready and restartable. So VM load can end up blocking kernel contexts
> without giving any chance to user contexts to be 'scheduled' by the
> userspace scheduler. This happens exactly in the worst moment, when load
> increases and stuff starts swapping.

That's solved by refashioning the kernel to pump out a blocking notification
to the UTS for that backing kernel thread. It's expected out of an SA style
system.

> and there are some things that i'm not at all sure can be fixed in any
> reasonable way - eg. RT scheduling. [the userspace library would have to
> raise/drop the priority of threads in the userspace scheduler, causing an
> additional kernel entry/exit, eliminating even the theoretical advantage
> it had for pure user<->user context switches.]

KSEs have a RT scheduling category, but the issue of preemption is not clearly
understood by me just yet so can't comment on it. I was in the process of trying
to understand this stuff at one time since I was thinking about work on that
project.

> plus basic performance issues. If you have a healthy mix of userspace and
> kernelspace scheduler activity then you've at least doubled your icache
> footprint by having two scheduler - the dcache footprint is higher as
> well. A *single* bad cachemiss on a P4 is already almost as expensive as a
> kernel entry - and it's not like the growing gap between RAM access
> latency and CPU performance will shrink in the future. And we arent even
> using SYSENTER/SYSEXIT in the Linux kernel yet, which will shave off
> another 40% from the syscall entry (and kernel context switching) cost.

It'll be localized to the UTS, while threads that blocked in the kernel
are mostly going to be IO driven. Don't know about the situation where
you might have a a mixture of those activities.

The infrastructure for the upcalls might incur significant overhead.

> so my current take on threading models is: if you *can* do a really fast
> and lightweight kernel based 1:1 threading implementation then you have
> won. Anything else is barely more than workarounds for (fixable)  
> architectural problems. Concentrate your execution abstraction into the
> kernel and make it *really* fast and scalable - that will improve
> everything else. OTOH any improvement to the userspace thread scheduler
> only improves threaded applications - which are still the minority. Sure,
> some of the above problems can be helped, but it's not trivial - and some
> problems i dont think can be solved at all.

> But we'll see, the FreeBSD folks i think are working on KSA's so we'll
> know for sure in a couple of years.

There's a lot of ways folks can do this kind of stuff. Who knows ? The current
method you folks are doing could very well be the best for Linux.

I don't have much more to say about this topic.

bill

