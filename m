Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262215AbSJVFWy>; Tue, 22 Oct 2002 01:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262218AbSJVFWy>; Tue, 22 Oct 2002 01:22:54 -0400
Received: from [195.223.140.120] ([195.223.140.120]:42825 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262215AbSJVFWx>; Tue, 22 Oct 2002 01:22:53 -0400
Date: Tue, 22 Oct 2002 07:27:17 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jeff Dike <jdike@karaya.com>
Cc: Andi Kleen <ak@muc.de>, john stultz <johnstul@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>,
       george anzinger <george@mvista.com>,
       Stephen Hemminger <shemminger@osdl.org>,
       Bill Davidsen <davidsen@tmr.com>
Subject: Re: [PATCH] linux-2.5.43_vsyscall_A0
Message-ID: <20021022052717.GO19337@dualathlon.random>
References: <20021020023321.GS23930@dualathlon.random> <200210220507.AAA06089@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210220507.AAA06089@ccure.karaya.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2002 at 12:07:16AM -0500, Jeff Dike wrote:
> andrea@suse.de said:
> > yes, this is true for all the syscalls, if that's a problem uml isn't
> > an option for the user in the first place. 
> 
> Not true.  Any marginal increase in performance will make a number of 
> applications fast enough that they become practical in UML.  Since there
> are apps which, to a first order approximation, do nothing but call 
> gettimeofday, they are not usable in UML today, but could become usable if
> UML had vgettimeofday.  I've had complaints about this, so the need is
> definitely there.

This is not the point. You just have vsyscalls at full speed (completely
equivalent to the host speed, so only a few nanoseconds or more
depending on the hardware used) and the user code won't even notice to
be running inside uml, the user will get the full total host-speedup by
default inside uml, you don't need to change one single line of uml
codebase while porting to x86-64.

The point is that such a full total speedup cames with a feature-loss
from the uml point of view, that means uml programs will be in sync with
the real time of the host, and the time won't be revirtualized anymore
(unless we make some change to both kernel and uml).

So in short the problem is:

	without any change uml runs too fast ;), exactly as fast as the host

You want to slow it down a bit (invplg and branch in switch_to) to
resurrect the time revirtualization somehow.

See this sentence in my last email that you didn't answer to:

	If only you could raise a valid interesting real life scenario where
	they can't live with the system time being in sync with the host and
	where gettimeofday performance is critical I would love to hear.

This is the *key* point. I would prefer to avoid  moving pinned user
pages into the end of the kernel address space unless you provide a
valid real world case where tons of users will benefit from it at large.

> > what do you plan to do to make all other syscall faster? 
> 
> Right now, a UML syscall involves four host context switches and a host
> signal delivery and return.  I'm merging some changes which will reduce
> that to two host context switches and no signals.  Once that's done, I'm
> going to look for more improvements.

Sounds good.

> > My problem is that mapping user code into the vsyscall fixmap is
> > complex and not very clean at all, breaks various concepts in the mm
> > and last but not the least it is slow
> 
> Can you explain, in small words, why mapping user code is so horrible?

Mapping user code above PAGE_OFFSET is messy yes. We could
use get_user_pages, pin the page set the fixmap to point to it, set the
old vsyscall code in some other kernel space, tell userspace the new
location of the native vsyscalls, keep track of the whole thing in the
task struct and switch both old vsyscall and new vsyscall during
switch_to, and cleanup the mess when the task exits tell us nothing.

Actually the second copy of the vsyscalls could stay mapped all the
time, we only return to userspace its fixed address so we don't waste
address space. Plus it would be simpler and cleaner to have the vsyscall
calling into an user specified address, that sounds a much more usable
API too infact, you pass an pointer to function rather than a user page
address to remap, it would be more handy from your part too so you don't
need to build a magic vsyscall page to remap but you only care about the
callee.

So with these new ideas (to keep the second copy constantly mapped above
the last -ENOSYS and to have userspace specifying the address to call)
it sounds much simpler than the idea of mapping user code in kernel
space and not much more complicated than just redirecting the vsyscalls
to kernel.

Andrea
