Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262865AbSJWFGs>; Wed, 23 Oct 2002 01:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262868AbSJWFGs>; Wed, 23 Oct 2002 01:06:48 -0400
Received: from mail.eskimo.com ([204.122.16.4]:47878 "EHLO mail.eskimo.com")
	by vger.kernel.org with ESMTP id <S262865AbSJWFGp>;
	Wed, 23 Oct 2002 01:06:45 -0400
Date: Tue, 22 Oct 2002 22:12:08 -0700
To: Andrea Arcangeli <andrea@suse.de>
Cc: Elladan <elladan@eskimo.com>, Jeff Dike <jdike@karaya.com>,
       Andi Kleen <ak@muc.de>, john stultz <johnstul@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>,
       george anzinger <george@mvista.com>,
       Stephen Hemminger <shemminger@osdl.org>,
       Bill Davidsen <davidsen@tmr.com>
Subject: Re: [PATCH] linux-2.5.43_vsyscall_A0
Message-ID: <20021023051208.GA1350@eskimo.com>
References: <20021020023321.GS23930@dualathlon.random> <200210220507.AAA06089@ccure.karaya.com> <20021022052717.GO19337@dualathlon.random> <20021022072438.GA4853@eskimo.com> <20021022074006.GS19337@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021022074006.GS19337@dualathlon.random>
User-Agent: Mutt/1.4i
From: Elladan <elladan@eskimo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2002 at 09:40:06AM +0200, Andrea Arcangeli wrote:
> On Tue, Oct 22, 2002 at 12:24:38AM -0700, Elladan wrote:
> > 
> > This seems somewhat painful all-around, since if I'm reading this right,
> > you take a switch_to hit to find out whether the user redirected the
> > vsyscall, and a vsyscall branch hit as well.
> 
> there's no vsyscall branch hit, and no switch_to hit, just a single
> unlikely branch in switch_to, that's minor overehad, for istance the
> segmentation checks (as well unlikely) are more expensive.

It's still more expensive than nothing, so it's still penalizing the
context switch for an obscure vsyscall UML feature.

> > Just do the global flag test in the vgettimeofday code, and when it does
> 
> I prefer not to have branches in vgettimeoday, it is better to have a
> single branch in switch_to where it is certainly hidden in the scheduler
> and generic context switch noise, infact if we put in the right place it
> could have zero l1 cache impact, gettimeofday call frequency may be very
> high, much higher than the context switch frequency and the size of the
> gettimeofday is much smaller than the one of the scheduler, so there's
> less stuff to hide the branch in the noise.

Both the vgettimeofday and switch_to are fast paths.  So, the right
thing to do, if one of them has to take an unlikely branch penalty, is
to ask which one is entered more often.

gettimeofday() call frequency *can* be very high, but let's test it...

On my system, under a basic desktop user load (eg., browsing the web,
running folding@home), I see numbers like this (sampled every 10
seconds):

initial:
ctx 349728 gett 307946

ctx  21937 gett  11173
ctx  24791 gett  15761
ctx   2715 gett   3714
ctx   6748 gett   3789
ctx   4334 gett   2423
ctx   1575 gett   1002
ctx   4295 gett   2508
ctx  14913 gett   8220
ctx    600 gett    350
ctx   3821 gett   4860
ctx   4948 gett   7601
ctx   4800 gett  10720
ctx   3064 gett   6547
ctx   7716 gett   9592
ctx   3518 gett   4600
ctx   2760 gett   3505
ctx   4892 gett   4349
ctx   6258 gett   6547
ctx   7331 gett   9577
ctx  21701 gett  11674
ctx   3113 gett   1854
ctx   1502 gett   1063
ctx  27841 gett  14406

final:
ctx 536121 gett 454398

So, there were more context switches than calls to gettimeofday.
However, the numbers were close to each other.  Any idea what the
numbers are like for other workloads?

> > This way, the main system just sees vsyscalls degrade to normal system
> > calls, which is ok, and programs that want to virtualize like UML get to
> > bounce execution into some special user-specified vsyscall code of their
> > own, with the cost being just one system call transition for UML as
> > well - a big speedup.
> 
> you're optimizing the system for strace? What's the point of optimizing
> strace and penalizing the normal syscall fast path?

No, I'm penalizing strace to provide UML with a fast(er) syscall
mechanism.  This is totally optional, but may be interesting for
virtualization in general.  strace is not in the normal syscall fast
path, so this is a reasonable place to put optimizations for
virtualizing programs.

I'm also penalizing the vsyscall fast path, but that was just to avoid
the switch_to penalty.  Since both are rather critical, here's another,
even uglier scheme, which should have no overhead on switch_to or
vgettimeofday, but adds a bit of overhead to the page fault handler
(though, with the -ENOSYS fixup mentioned in the comment there, maybe
nothing relevant).

Of course, it hurts systems which run UML with virtualized time.

Try 2:

Create a second mapping of the vsyscall page in some special location
above the normal page.  Make a new sysctl, which globally invalidates
the page that the standard mapping is on.  Basically, this disables
vsyscalls for everyone when turned on.

Now, obviously this won't work without some trick.  What we do now is,
we make the page fault handler path for vsyscalls (to be added anyway)
work like so:

If the pc is within the allocated vsyscall page(s), then:

If the pc is on the entrypoint to a vsyscall function, check whether the
process is being traced.  If so, turn this into a somewhat normal
looking syscall so it can be virtualized (or do something else, if you
want - have userspace jump somewhere, etc).

If not traced, or if the pc is not at the entrypoint, reset the pc to be
on the second vsyscall copy, with the same offset, and return to
userspace.

This lets us do a global vsyscall disable, but (I hope) fixes up the
problem of userspace going to sleep inside a vsyscall.  The process
wakes up, faults, and gets shunted off to identical code in another
location, which should have the same behavior.

Downside: vgettimeofday takes a performance penalty for everyone in the
special case where UML is running with full time virtualization, because
of the page fault.  This is the very unusual case, so who cares?

Downside 2: Would this actually work?  It's a bit scary sounding...

-J
