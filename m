Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261831AbSJVHfu>; Tue, 22 Oct 2002 03:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261631AbSJVHfu>; Tue, 22 Oct 2002 03:35:50 -0400
Received: from [195.223.140.120] ([195.223.140.120]:42337 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S261831AbSJVHfs>; Tue, 22 Oct 2002 03:35:48 -0400
Date: Tue, 22 Oct 2002 09:40:06 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Elladan <elladan@eskimo.com>
Cc: Jeff Dike <jdike@karaya.com>, Andi Kleen <ak@muc.de>,
       john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       george anzinger <george@mvista.com>,
       Stephen Hemminger <shemminger@osdl.org>,
       Bill Davidsen <davidsen@tmr.com>
Subject: Re: [PATCH] linux-2.5.43_vsyscall_A0
Message-ID: <20021022074006.GS19337@dualathlon.random>
References: <20021020023321.GS23930@dualathlon.random> <200210220507.AAA06089@ccure.karaya.com> <20021022052717.GO19337@dualathlon.random> <20021022072438.GA4853@eskimo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021022072438.GA4853@eskimo.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2002 at 12:24:38AM -0700, Elladan wrote:
> On Tue, Oct 22, 2002 at 07:27:17AM +0200, Andrea Arcangeli wrote:
> > On Tue, Oct 22, 2002 at 12:07:16AM -0500, Jeff Dike wrote:
> > 
> > > > My problem is that mapping user code into the vsyscall fixmap is
> > > > complex and not very clean at all, breaks various concepts in the mm
> > > > and last but not the least it is slow
> > > 
> > > Can you explain, in small words, why mapping user code is so horrible?
> > 
> > Mapping user code above PAGE_OFFSET is messy yes. We could
> > use get_user_pages, pin the page set the fixmap to point to it, set the
> > old vsyscall code in some other kernel space, tell userspace the new
> > location of the native vsyscalls, keep track of the whole thing in the
> > task struct and switch both old vsyscall and new vsyscall during
> > switch_to, and cleanup the mess when the task exits tell us nothing.
> > 
> > Actually the second copy of the vsyscalls could stay mapped all the
> > time, we only return to userspace its fixed address so we don't waste
> > address space. Plus it would be simpler and cleaner to have the vsyscall
> > calling into an user specified address, that sounds a much more usable
> > API too infact, you pass an pointer to function rather than a user page
> > address to remap, it would be more handy from your part too so you don't
> > need to build a magic vsyscall page to remap but you only care about the
> > callee.
> > 
> > So with these new ideas (to keep the second copy constantly mapped above
> > the last -ENOSYS and to have userspace specifying the address to call)
> > it sounds much simpler than the idea of mapping user code in kernel
> > space and not much more complicated than just redirecting the vsyscalls
> > to kernel.
> 
> This seems somewhat painful all-around, since if I'm reading this right,
> you take a switch_to hit to find out whether the user redirected the
> vsyscall, and a vsyscall branch hit as well.

there's no vsyscall branch hit, and no switch_to hit, just a single
unlikely branch in switch_to, that's minor overehad, for istance the
segmentation checks (as well unlikely) are more expensive.

> A switch_to seems like something to avoid, since it slows down the
> system at all times, even when vgettimeofday is not being used very
> often.  Does the average system call gettimeofday() more than once per

switch_to only gets an additional check, the real hit it takes is when
Jeff revirtualizes the vsyscalls, not when you run in production w/o uml
or with uml in speed-mode without vsyscall revirtualization.

> context switch?  If not, don't change switch_to...
> 
> If you don't mind a somewhat nasty looking tactic, another way you could
> implement something like this and give a boost to virtualizing programs
> would be to do a special case in the syscall_trace handler for
> gettimeofday.  
> 
> Just do the global flag test in the vgettimeofday code, and when it does

I prefer not to have branches in vgettimeoday, it is better to have a
single branch in switch_to where it is certainly hidden in the scheduler
and generic context switch noise, infact if we put in the right place it
could have zero l1 cache impact, gettimeofday call frequency may be very
high, much higher than the context switch frequency and the size of the
gettimeofday is much smaller than the one of the scheduler, so there's
less stuff to hide the branch in the noise.

> the fallback system call, if the process is being traced, we check to
> see if the control process requested some special handling for the
> syscall (obviously very easy to do in kernel mode).  If so, do a special
> fixup which, say, returns execution back to user space in a
> user-specified location without notifying the tracing task of the system
> call event.
> 
> This way, the main system just sees vsyscalls degrade to normal system
> calls, which is ok, and programs that want to virtualize like UML get to
> bounce execution into some special user-specified vsyscall code of their
> own, with the cost being just one system call transition for UML as
> well - a big speedup.

you're optimizing the system for strace? What's the point of optimizing
strace and penalizing the normal syscall fast path?

> 
> This sort of tactic might be interesting in general for a virtualizing
> program, since you could bounce many of the system calls in the traced
> process into user-specified code pages (especially if security in the
> virtualized program isn't too big a concern).
> 
> It also would have the advantage of only mangling the trace path in the
> kernel, which isn't the most performance-critical one around, without
> overly complicating the vsyscalls in the average case.
> 
> Of course, it's kind of... ugly.
> 
> -J


Andrea
