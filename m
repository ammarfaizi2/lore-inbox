Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265517AbSJSEEY>; Sat, 19 Oct 2002 00:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265516AbSJSEEX>; Sat, 19 Oct 2002 00:04:23 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:17008 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S265517AbSJSEEQ>; Sat, 19 Oct 2002 00:04:16 -0400
Date: Sat, 19 Oct 2002 06:10:19 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jeff Dike <jdike@karaya.com>
Cc: Andi Kleen <ak@muc.de>, john stultz <johnstul@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>,
       george anzinger <george@mvista.com>,
       Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH] linux-2.5.43_vsyscall_A0
Message-ID: <20021019041019.GI23930@dualathlon.random>
References: <20021019031002.GA16404@averell> <200210190450.XAA06161@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210190450.XAA06161@ccure.karaya.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2002 at 11:49:59PM -0500, Jeff Dike wrote:
> ak@muc.de said:
> > Guess you'll have some problems then with UML on x86-64, which always
> > uses vgettimeofday. But it's only used for gettimeofday() currently,
> > perhaps it's  not that bad when the UML child runs with the host's
> > time.
> 
> It's not horrible, but it's still broken.  There are people who depend
> on UML being able to keep its own time separately from the host.
> 
> > I guess it would be possible to add some support for UML to map own
> > code over the vsyscall reserved locations. UML would need to use the
> > syscalls then. But it'll be likely ugly. 
> 
> Yeah, it would be.
> 
> My preferred solution would be for libc to ask the kernel where the vsyscall
> area is.  That's reasonably clean and virtualizable.  Andrea doesn't like it
> because it adds a few instructions to the vsyscall address calculation.

yes, my preferred solution is still a runtime /proc entry that turns off
vsyscalls completely by root so you could trap gettimeofday/time via the
usual ptrace. That would be zero cost. Of course this would be needed
only for the special users needing a revirtualized time. I tend to think
most people don't need a revirtualized time in uml, the exceptions can
run slower [not slower than x86 of course except for an additional
call/ret pair that won't matter compared to the ptrace overhread of
every syscall]. I mean, I would prefer to optimize for the people who
needs fast performance, if you can deal with the ptrace overhead at
every sysenter/sysret most probably you don't need the vsyscalls in the
first place.

My argument is that whatever solution to this problem has a penalty of
some kind, and I prefer to keep the penalty on the side of the most
unlikely case, and as far as I can tell it's the case of people needing
uml running with revirtualized real time. certainly I want to make it
possible, but I don't care to optimize for it, I want it (not the
others) to pay for the additional feature it needs.

If the global sysctl is unacceptable, the next fallback would be to have
a per-task information that defaults to vsyscall to execute the syscall,
a check in switch_to could replace the fixmap entry with the one of the
other vsyscall. That would be an additional single unlikely branch in
switch_to unless I'm overlooking something and I could live with it
despite it's not an absolute zero cost. That should be still *much*
better than glibc asking to kernel the address of the vsyscalls using a
syscall after execve and using pointer to functions later at runtime to
invoke the vsyscalls, I don't really like that solution.

So I would go with:

1) global sysctl to turn off vgettimeofday/vtime
2) if 1) is unacceptable then per-task turnoff of vsyscalls would be the
   next viable solution

Comments?

Andrea
