Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261578AbSIXGSz>; Tue, 24 Sep 2002 02:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261582AbSIXGSz>; Tue, 24 Sep 2002 02:18:55 -0400
Received: from mx2.elte.hu ([157.181.151.9]:32159 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S261578AbSIXGSy>;
	Tue, 24 Sep 2002 02:18:54 -0400
Date: Tue, 24 Sep 2002 08:32:16 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Andy Isaacson <adi@hexapodia.org>
Cc: Larry McVoy <lm@bitmover.com>,
       =?ISO-8859-1?Q?Peter_W=E4chtler?= <pwaechtler@mac.com>,
       Bill Davidsen <davidsen@tmr.com>, <linux-kernel@vger.kernel.org>
Subject: 1:1 threading vs. scheduler activations (was: Re: [ANNOUNCE] Native
 POSIX Thread Library 0.1)
In-Reply-To: <20020923185756.C13340@hexapodia.org>
Message-ID: <Pine.LNX.4.44.0209240755060.8943-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 23 Sep 2002, Andy Isaacson wrote:

> Excellent points, Ingo.  An alternative that I haven't seen considered
> is the M:N threading model that NetBSD is adopting, called Scheduler
> Activations. [...]

yes, SA's (and KSA's) are an interesting concept, but i personally think
they are way too much complexity - and history has shows that complexity
never leads to anything good, especially not in OS design.

Eg. SA's, like every M:N concept, must have a userspace component of the
scheduler, which gets very funny when you try to implement all the things
the kernel scheduler has had for years: fairness, SMP balancing, RT
scheduling (!), preemption and more.

Eg. 2.0.2 NGPT's current userspace scheduler is still cooperative - a
single userspace thread burning CPU cycles monopolizes the full context.
Obviously this can be fixed, but it gets nastier and nastier as you add
the features - for no good reason, the same functionality is already
present in the kernel's scheduler, which can generally do much better
scheduling decisions - it has direct and reliable access to various
statistics, it knows exactly how much CPU time has been used up. To give
all this information to the userspace scheduler takes alot of effort. I'm
no wimp when it comes to scheduler complexity, but a coupled kernel/user
scheduling concept scares the *hit out of me.

And then i havent mentioned things like upcall costs - what's the point in
upcalling userspace which then has to schedule, instead of doing this
stuff right in the kernel? Scheduler activations concentrate too much on
the 5% of cases that have more userspace<->userspace context switching
than some sort of kernel-provoked context switching. Sure, scheduler
activations can be done, but i cannot see how they can be any better than
'just as fast' as a 1:1 implementation - at a much higher complexity and
robustness cost.

the biggest part of Linux's kernel-space context switching is the cost of
kernel entry - and the cost of kernel entry gets cheaper with every new
generation of CPUs. Basing the whole threading design on the avoidance of
the kernel scheduler is like basing your tent on a glacier, in a hot
summer day.

Plus in an M:N model all the development toolchain suddenly has to
understand the new set of contexts, debuggers, tracers, everything.

Plus there are other issues like security - it's perfectly reasonable in
the 1:1 model for a certain set of server threads to drop all privileges
to do the more dangerous stuff. (while there is no such thing as absolute
security and separation in a threaded app, dropping privileges can avoid
certain classes of exploits.)

generally the whole SA/M:N concept creaks under the huge change that is
introduced by having multiple userspace contexts of execution per a single
kernel-space context of execution. Such detaching of concepts, no matter
which kernel subsystem you look at, causes problems everywhere.

eg. the VM. There's no way you can get an 'upcall' from the VM that you
need to wait for free RAM - most of the related kernel code is simply not
ready and restartable. So VM load can end up blocking kernel contexts
without giving any chance to user contexts to be 'scheduled' by the
userspace scheduler. This happens exactly in the worst moment, when load
increases and stuff starts swapping.

and there are some things that i'm not at all sure can be fixed in any
reasonable way - eg. RT scheduling. [the userspace library would have to
raise/drop the priority of threads in the userspace scheduler, causing an
additional kernel entry/exit, eliminating even the theoretical advantage
it had for pure user<->user context switches.]

plus basic performance issues. If you have a healthy mix of userspace and
kernelspace scheduler activity then you've at least doubled your icache
footprint by having two scheduler - the dcache footprint is higher as
well. A *single* bad cachemiss on a P4 is already almost as expensive as a
kernel entry - and it's not like the growing gap between RAM access
latency and CPU performance will shrink in the future. And we arent even
using SYSENTER/SYSEXIT in the Linux kernel yet, which will shave off
another 40% from the syscall entry (and kernel context switching) cost.

so my current take on threading models is: if you *can* do a really fast
and lightweight kernel based 1:1 threading implementation then you have
won. Anything else is barely more than workarounds for (fixable)  
architectural problems. Concentrate your execution abstraction into the
kernel and make it *really* fast and scalable - that will improve
everything else. OTOH any improvement to the userspace thread scheduler
only improves threaded applications - which are still the minority. Sure,
some of the above problems can be helped, but it's not trivial - and some
problems i dont think can be solved at all.

But we'll see, the FreeBSD folks i think are working on KSA's so we'll
know for sure in a couple of years.

	Ingo

