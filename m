Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265738AbSJTC3D>; Sat, 19 Oct 2002 22:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265739AbSJTC3D>; Sat, 19 Oct 2002 22:29:03 -0400
Received: from [195.223.140.120] ([195.223.140.120]:24681 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S265738AbSJTC3B>; Sat, 19 Oct 2002 22:29:01 -0400
Date: Sun, 20 Oct 2002 04:33:21 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jeff Dike <jdike@karaya.com>
Cc: Andi Kleen <ak@muc.de>, john stultz <johnstul@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>,
       george anzinger <george@mvista.com>,
       Stephen Hemminger <shemminger@osdl.org>,
       Bill Davidsen <davidsen@tmr.com>
Subject: Re: [PATCH] linux-2.5.43_vsyscall_A0
Message-ID: <20021020023321.GS23930@dualathlon.random>
References: <20021020001540.GR23930@dualathlon.random> <200210200203.VAA04444@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210200203.VAA04444@ccure.karaya.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19, 2002 at 09:03:09PM -0500, Jeff Dike wrote:
> andrea@suse.de said:
> > What I suggested is an arch specific syscall to shutdown vsyscalls
> > enterely for the current task and its childs, 
> 
> Then I misunderstood.
> 
> > the vsyscall will call
> > into the real syscall with sysenter, and you will be able to
> > revirtualize gettimeofday/time like you do on x86 with ptrace. 
> 
> And the task-specific fixmap entry would point to a page that makes the normal
> system call?

correct.

> 
> > what do you mean that uml needs the vsyscalls more than the other
> > archs? 
> 
> Because its system calls are much slower than the host's.  It would benefit
> more from vsyscalls.

yes, this is true for all the syscalls, if that's a problem uml isn't an
option for the user in the first place.

> > I much prefer you to keep trapping the gettimeofday and time with
> > ptrace after shutting down the vsyscalls for the current task, it's so
> > much cleaner. 
> 
> And so much slower.

so much slower like all other syscalls under uml.

> > The overhead of ptrace cannot be your point, if that
> > overhead is a showstopper uml isn't an option in the first place.
> 
> I don't plan on using ptrace forever.  That overhead is going to shrink, and
> vsyscalls are one way to make it shrink.

what do you plan to do to make all other syscall faster? gettimeofday is
the only thing that can be implemented as a vsyscall.

> I intend to make UML perform by grabbing whatever improvements from wherever
> I can get them, and if I can't get vsyscalls because they're not virtualizable,
> then, from my point of view, their design is broken.

By the same argument you could claim x86 and several other archs broken
because they don't support revirtualization in hardware like s390, not
even vmware is claiming anything like that.

And let's assume you're right, let's declare vsyscall design broken,
let's back them out, so we will force you to take the ptrace hit always,
just like in x86, so even the 99% of uml users like me that are fine to
live with system time being in sync with the host will have to take the
ptrace hit at every gettimeofday.

Your claim is obviously broken, not the vsyscall design.

The fact is that the vsyscalls design is the only way for you to run as
fast as the host kernel for the very big exception of gettimeofday that
is a purerly readonly operation, go figure how much vsyscalls are broken
(yeah, you could optimize getpid too in UP [smp would make it slower by
having to add some code to the scheduler, scheduler run much more
frequently than getpid(2)] like for the host kernel, but that's not
worth the complexity even outside uml).

My problem is that mapping user code into the vsyscall fixmap is complex
and not very clean at all, breaks various concepts in the mm and
last but not the least it is slow, if you want to run fast you must
_NOT_ revirtualize.

Everybody who needs an ultra optimized uml can simply run with the uml system
time in sync with the host, it will run faster than the revirtualization
since you won't get the tlb flush at every switch, you need zero kernel
changes, it will run at full speed like the host kernel. revirtualized
vsyscalls sounds like overdesign, before I will consider adding that
features I want to know _who_ needs this optimization for gettimeofday
that can't live with the system time in sync with the host. vsyscalls
just improves automatically uml at full speed if only you will set the
default to have the system time in sync with the host.  The other 1% of
uml users will be fine to take the usual ptrace hit like on x86
currently and just like for all other syscalls out there. I just want to
make sure not to overdesign, maintainance is just hard enough with
simple concepts.

As far as I can tell the guy using uml to fake the system time for its
preferred evaluation demo will be certainly fine to ptrace around
gettimeofday. And OTOH the production guys using uml for security
reasons to run Oracle or the apache cgi on top of it will want _NOT_ to
pay the tlb flush at switch_to either and they will want uml _not_
revirtualizing the vsyscalls regardless of that feature provided by the
kernel or not. Hence what you ask for is plain overdesign IMHO.

If only you could raise a valid interesting real life scenario where
they can't live with the system time being in sync with the host and
where gettimeofday performance is critical I would love to hear.

In any case the libc option is a no-way, the whole point of the current
vsyscall api is not to deal with pointer to functions so the libc way is
not worth considering IMHO. revirtualized vsyscalls are certainly worth
discussing but I'm not for it.

Andrea
