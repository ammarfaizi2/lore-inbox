Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265513AbSJSE4F>; Sat, 19 Oct 2002 00:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265514AbSJSE4F>; Sat, 19 Oct 2002 00:56:05 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:16672 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S265513AbSJSE4D>; Sat, 19 Oct 2002 00:56:03 -0400
Date: Sat, 19 Oct 2002 07:01:39 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andi Kleen <ak@muc.de>
Cc: Jeff Dike <jdike@karaya.com>, john stultz <johnstul@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>,
       george anzinger <george@mvista.com>,
       Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH] linux-2.5.43_vsyscall_A0
Message-ID: <20021019050139.GM23930@dualathlon.random>
References: <20021019031002.GA16404@averell> <200210190450.XAA06161@ccure.karaya.com> <20021019041019.GI23930@dualathlon.random> <20021019044556.GA22201@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021019044556.GA22201@averell>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19, 2002 at 06:45:56AM +0200, Andi Kleen wrote:
> On Sat, Oct 19, 2002 at 06:10:19AM +0200, Andrea Arcangeli wrote:
> > On Fri, Oct 18, 2002 at 11:49:59PM -0500, Jeff Dike wrote:
> > > ak@muc.de said:
> > > > Guess you'll have some problems then with UML on x86-64, which always
> > > > uses vgettimeofday. But it's only used for gettimeofday() currently,
> > > > perhaps it's  not that bad when the UML child runs with the host's
> > > > time.
> > > 
> > > It's not horrible, but it's still broken.  There are people who depend
> > > on UML being able to keep its own time separately from the host.
> > > 
> > > > I guess it would be possible to add some support for UML to map own
> > > > code over the vsyscall reserved locations. UML would need to use the
> > > > syscalls then. But it'll be likely ugly. 
> > > 
> > > Yeah, it would be.
> > > 
> > > My preferred solution would be for libc to ask the kernel where the vsyscall
> > > area is.  That's reasonably clean and virtualizable.  Andrea doesn't like it
> > > because it adds a few instructions to the vsyscall address calculation.
> > 
> > yes, my preferred solution is still a runtime /proc entry that turns off
> > vsyscalls completely by root so you could trap gettimeofday/time via the
> > usual ptrace. That would be zero cost. Of course this would be needed
> 
> Ok, a sysctl that modifies a variable in the vsyscall page and is
> tested by the code. That would be an option, I agree.

the sysctl would replace the vsyscall fixmap fixmap entry for the
current cpu enterely at switch_to time, I certainly don't want to add
not necessary branches in the core vsyscall code.  Doing it globally is
zerocost but it would probably need privilegies as said, per-task could
be more dynamic without privilegies and it would be an unlikely branch
added in switch_to, still a very low cost so still acceptable.

> For the locked TSC code we will need something like that anyways,
> so that locked TSC can force a syscall.

If we use a per-cpu TSC we don't need the syscall, the cpuid encoded in
each 64bit variable will be enough (see my past email of yesterday
evening, I realized a way to hanle per-cpu info with vsyscalls). the
main problem is as usual that the TSC isn't a real time source, it
changes frequency all the time, but as usual all the problems in the
gettimeofday implementation have little to with the vsyscalls details,
in particular now that I realized how to handle per-cpu data, they're
generic issues that needs solving even if vsyscalls would redirect to
the syscalls.

The only thing we definitely can't do in the vsyscalls is to read the
PIT because it's an old I/O mapped device, but who could ever live only
with the PIT anyways these computing days? If you've only the PIT
vsyscalls or not the gettimeofday functionality would suck.

Andrea
