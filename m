Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbULYC2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbULYC2I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 21:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbULYC2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 21:28:08 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:44975 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S261474AbULYC2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 21:28:02 -0500
Date: Sat, 25 Dec 2004 03:27:21 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, akpm@osdl.org
Subject: Re: VM fixes [4/4]
Message-ID: <20041225022721.GR13747@dualathlon.random>
References: <20041224174156.GE13747@dualathlon.random> <20041224100147.32ad4268.davem@davemloft.net> <20041224182219.GH13747@dualathlon.random> <Pine.LNX.4.58.0412241533170.2353@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0412241533170.2353@ppc970.osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2004 at 03:41:37PM -0800, Linus Torvalds wrote:
> 
> 
> On Fri, 24 Dec 2004, Andrea Arcangeli wrote:
> > 
> > If those old cpus really supported smp in linux, then fixing this bit is
> > trivial, just change it to short. Do they support short at least?
> 
> It's not even about SMP. "byte" and "short" are not IRQ-safe or even 
> preemption-safe (although I guess alpha doesn't support CONFIG_PREEMPT 
> right now anyway) on pre-byte-access alphas.

What I meant in this specific case being UP w/o preempt is enough to be
safe, because irq cannot modify memdie/used_math/oomadj. Only normal
kernel context can (or at most used_math can be modified by an exception
running on top of normal kernel context that we know doesn't touch
memdie/oomadj).

If these variables were to be modified from irqs then of course being UP
w/o preempt wouldn't be enough. But it was enough in this specific case.

So the only trouble here is SMP or PREEMPT.

> Just don't do it. Maybe we'll never see another chip try what alpha did 
> (it was arguably the single biggest mistake the early alphas had, and 
> caused tons of system design trouble), but just use an "int".
> 
> That said, I'd suggest putting it in the thread structure instead. We 
> already have thread-safe flags there, just use one of the bits. Yes, 
> you'll need to use locked accesses to set it, but hey, how often does 
> something like this get set anyway? And then you just do ti _right_, using 
> set_thread_flag/clear_thread_flag etc..

Actually I wonder if used_math should really become a PF_USED_MATH and
not the set_thread_flag/clear_thread_flag type of bitflag. The PF_ flags
have the property that they can only be modified by the "current" task.
But the current "short used_math" has the same requirement of the
PF_USED_MATH in this respect. So unless used_math is already racy (since
it's not being modified by locked ins), it should be correct to convert
it to a PF_ bitflag, which is not using locks.

memdie instead really should become a
set_thread_flags/clear_thread_flag (curently it's racy, while we set the
bitflag, the other cpu may be exiting already and we may be preventing
PF_EXITING or PF_DEAD to be set on a exited task with this current
race).

Note also that used_math is currently a short, it might not be a bug but
that's already misleading, it really shall be an int at the light of
your suggestions. I take the blame for making it worse (i.e. a char ;)

So my current plan is to make used_math a PF_USED_MATH, and memdie a
TIF_MEMDIE. And of course oomtaskadj an int (that one requires more than
1 bit of info ;). This change should be optimal for all archs and it
will fix the alpha arch with smp or preempt enabled on older cpus too.

I'd like to make those changes incrementally to the other patches I
already posted, so I avoid rejects fixing work (more than one patch
modified that code).
