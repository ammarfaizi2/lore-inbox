Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262823AbSJTOpv>; Sun, 20 Oct 2002 10:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262824AbSJTOpv>; Sun, 20 Oct 2002 10:45:51 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:34594 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262823AbSJTOpt>; Sun, 20 Oct 2002 10:45:49 -0400
Date: Sun, 20 Oct 2002 16:51:49 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andi Kleen <ak@muc.de>
Cc: Jeff Dike <jdike@karaya.com>, john stultz <johnstul@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>,
       george anzinger <george@mvista.com>,
       Stephen Hemminger <shemminger@osdl.org>, discuss@x86-64.org, aj@suse.de
Subject: Re: [PATCH] linux-2.5.43_vsyscall_A0
Message-ID: <20021020145149.GT23930@dualathlon.random>
References: <20021019031002.GA16404@averell> <200210190450.XAA06161@ccure.karaya.com> <20021019040238.GA21914@averell> <20021019041659.GK23930@dualathlon.random> <20021020025914.GB15342@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021020025914.GB15342@averell>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 20, 2002 at 04:59:14AM +0200, Andi Kleen wrote:
> On Sat, Oct 19, 2002 at 06:16:59AM +0200, Andrea Arcangeli wrote:
> > see my last email. And I think he needed it as an additional syscall
> > after execve that he could trap and revirtualize with ptrace as usual
> > and that would return variable addresses of pointer to functions (that
> > would be revirtualized inside the uml kernel of course), not an ELF
> > information that should be valid for both UML and host kernel.
> 
> Implementing it per process is tricky. How do you access the per process
> state in the vsyscall area ?  To do it properly you would need one dedicated

you don't need to access the per-process state of course.

the code will do:

	switch_to() {
		[..]
		if (prev->vsyscall_disabled != next->vsyscall_disabled) {
			set the right fixmap page and invlpg
		}
		[..]
	}

the vsyscall code itself will not need to know anything about the
current->vsyscall_disabled. The only overhead is such above branch.

> page per mm_struct that is mapped in there. But it could not be in the
> normal vsyscall area (otherwise you couldn't share the kernel pagetables
> anymore), but somewhere else in the address space.
> 
> I think a global sysctl that just modifies the global vsyscall pages is more
> suitable here. It avoids the overhead of needing a per process page.

I don't see the need of a per-process page. We only need a per-cpu
first level pagetable at the very end of the address space, but that's
not a problem at all, it's one more page _per_cpu_ only (not per task).
It's much less overhead of per-cpu keventd etc...

> I see no real need anyways to do it per process. When you have one process
> that cannot deal with vsyscalls the whole system will get a bit slower,
> but the slowdown shouldn't be noticeable anyways. If you run your highend
> database which does thousands of gettimeofday each second just don't set
> the sysctl.

yep. Having the per-task switch was only a way to make the host system
more efficient for the 1% uml users that has to fake the time and that
cannot live with the max possible perormance of having uml running with
the system time in sync with the host. the per-task switch is meant to
give uml the possibility of being fully revirtualized without hurting
the host too much, in the unlikely case you need it.

Andrea
