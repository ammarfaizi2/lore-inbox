Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262460AbSJTGjF>; Sun, 20 Oct 2002 02:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262495AbSJTGjF>; Sun, 20 Oct 2002 02:39:05 -0400
Received: from mail.eskimo.com ([204.122.16.4]:40452 "EHLO mail.eskimo.com")
	by vger.kernel.org with ESMTP id <S262460AbSJTGjE>;
	Sun, 20 Oct 2002 02:39:04 -0400
Date: Sat, 19 Oct 2002 23:44:33 -0700
To: Andi Kleen <ak@muc.de>
Cc: Andrea Arcangeli <andrea@suse.de>, Jeff Dike <jdike@karaya.com>,
       john stultz <johnstul@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>,
       george anzinger <george@mvista.com>,
       Stephen Hemminger <shemminger@osdl.org>, discuss@x86-64.org, aj@suse.de
Subject: Re: [PATCH] linux-2.5.43_vsyscall_A0
Message-ID: <20021020064433.GA32594@eskimo.com>
References: <20021019031002.GA16404@averell> <200210190450.XAA06161@ccure.karaya.com> <20021019040238.GA21914@averell> <20021019041659.GK23930@dualathlon.random> <20021020025914.GB15342@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021020025914.GB15342@averell>
User-Agent: Mutt/1.4i
From: Elladan <elladan@eskimo.com>
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
> page per mm_struct that is mapped in there. But it could not be in the
> normal vsyscall area (otherwise you couldn't share the kernel pagetables
> anymore), but somewhere else in the address space.
> 
> I think a global sysctl that just modifies the global vsyscall pages is more
> suitable here. It avoids the overhead of needing a per process page.
> I see no real need anyways to do it per process. When you have one process
> that cannot deal with vsyscalls the whole system will get a bit slower,
> but the slowdown shouldn't be noticeable anyways. If you run your highend
> database which does thousands of gettimeofday each second just don't set
> the sysctl.

The problem with modifying the executable code/pages in the vsyscall
area is that it's going to be very tricky to implement, if I understand
this discussion properly.

There may be any number of user processes idling in these pages on the
runqueue (or off it if say one received a SIGSTOP), and if you just go
change the instruction code on them, unless you're incredibly careful
and come up with some subtly safe machine code sequence, they're going
crash when you call this sysctl().

It seems like this indicates that you have to start getting crazy at
that point.  That is, what you need to do is scan through all processes
on the runqueue (and also any that might be eg. frozen) and examine
their pc.  If it's in the vsyscall area, either complete the system call
for them, or somehow roll-back their register state and reset their PC
to the start of the vsyscall function.

Just using a test in the vsyscall to check a variable seems like a much
cleaner global approach.  It has its own problem though, since processes
that are idling in the vsyscall pages may wake up after vsyscalls have
been disabled.  It seems like they could then be prone to return the
wrong result, if say the offset data was no longer being updated
properly by the kernel because of the mode change.

Making it per-process should avoid these problems nicely, at least, so
long as the process disabling vsyscalls knows what it's doing and
doesn't try to call the sysctl from a signal handler or something.

-J
