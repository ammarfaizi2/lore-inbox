Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261596AbSJTKw7>; Sun, 20 Oct 2002 06:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262062AbSJTKw7>; Sun, 20 Oct 2002 06:52:59 -0400
Received: from mail.eskimo.com ([204.122.16.4]:63499 "EHLO mail.eskimo.com")
	by vger.kernel.org with ESMTP id <S261596AbSJTKw5>;
	Sun, 20 Oct 2002 06:52:57 -0400
Date: Sun, 20 Oct 2002 03:58:41 -0700
To: Andi Kleen <ak@suse.de>
Cc: Elladan <elladan@eskimo.com>, Andi Kleen <ak@muc.de>,
       Andrea Arcangeli <andrea@suse.de>, Jeff Dike <jdike@karaya.com>,
       john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       george anzinger <george@mvista.com>,
       Stephen Hemminger <shemminger@osdl.org>, discuss@x86-64.org, aj@suse.de
Subject: Re: [discuss] Re: [PATCH] linux-2.5.43_vsyscall_A0
Message-ID: <20021020105841.GA1024@eskimo.com>
References: <20021019031002.GA16404@averell> <200210190450.XAA06161@ccure.karaya.com> <20021019040238.GA21914@averell> <20021019041659.GK23930@dualathlon.random> <20021020025914.GB15342@averell> <20021020064433.GA32594@eskimo.com> <20021020112730.A29357@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021020112730.A29357@wotan.suse.de>
User-Agent: Mutt/1.4i
From: Elladan <elladan@eskimo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 20, 2002 at 11:27:30AM +0200, Andi Kleen wrote:
> On Sat, Oct 19, 2002 at 11:44:33PM -0700, Elladan wrote:
> > The problem with modifying the executable code/pages in the vsyscall
> > area is that it's going to be very tricky to implement, if I understand
> > this discussion properly.
> 
> Modifying the pages or variables in the pages from the kernel is no
> problem.  It just would affect all processes on the system
> 
> What's tricky is to give it per process state (which would 
> be needed to make a vsyscall/novsyscall flag process local) 

Not really any more tricky than turning it off globally with a flag.
It's just more expensive, because you have to propagate the flag into
vsyscall space on the context switch.  In the per-process case,
self-modifying code would be a less non-viable approach than it is
globally.

> > There may be any number of user processes idling in these pages on the
> > runqueue (or off it if say one received a SIGSTOP), and if you just go
> > change the instruction code on them, unless you're incredibly careful
> > and come up with some subtly safe machine code sequence, they're going
> > crash when you call this sysctl().
> 
> Nobody proposed to use self modifying code, it would just be a global
> variable located in the vsyscall area that is tested by the vsyscall
> code.

Well, self modifying code certainly looked like what Andrea was talking
about, to avoid the branch overhead on the userspace gettimeofday()
call.

I suspect that outside of a few database apps, it's pretty unlikely that
there will be any vsyscalls in your average time slice, so putting the
overhead into the vsyscall itself seems like a better idea than paying
the price during every context switch.


Of course, if you're really strictly worried about being able to fully
virtualize the vsyscalls, a global flag isn't really enough.  A user app
running under the virtual machine will still be able to manually access
the data on the vsyscall pages, and if it wants, jump into the middle of
a function or something like that.  So eg. a UML instance being used as
a sandbox would still expose the host time and such to its hostile
userspace, which could then execute subsets of vsyscall code at will.

It seems that to fix this with proper data-hiding, it would really need
to be possible to set the vsyscall pages as invalid for the UML process
(so it could manually emulate the vsyscall), which would then either
require expensive contex-switching costs to make it a per-process flag,
or we're back to global self-modifying-code fixups.

Better to just ignore that particular issue.

-J
