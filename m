Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750841AbWFGE3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbWFGE3l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 00:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbWFGE3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 00:29:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44973 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750841AbWFGE3l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 00:29:41 -0400
Date: Tue, 6 Jun 2006 21:29:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: mutex vs. local irqs (Was: 2.6.18 -mm merge plans)
Message-Id: <20060606212930.364b43fa.akpm@osdl.org>
In-Reply-To: <1149652378.27572.109.camel@localhost.localdomain>
References: <20060604135011.decdc7c9.akpm@osdl.org>
	<1149652378.27572.109.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Jun 2006 13:52:58 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> > work-around-ppc64-bootup-bug-by-making-mutex-debugging-save-restore-irqs.patch
> > kernel-kernel-cpuc-to-mutexes.patch
> > 
> >  ug.  We cannot convert the cpu.c semaphore into a mutex until we work out
> >  why power4 goes titsup if you enable local interrupts during boot.
> 
> What is the exact problem ? Some mutex is forcing local irqs enabled
> before init_IRQ() ? (Before the normal enabling of IRQ done by
> init/main.c just after init_IRQ() more precisely ?)

Any code which does mutex_lock() will have interrupts reenabled if the
mutex code was compiled in debug mode.

> This is bad for any architecture. Basically, at this point, the
> interrupt controller can be in _any_ state, with possible pending
> interrupts for whatever sources, etc...
> 
> As we discussed before, that problem should really be fixed in the mutex
> code by not hard-enabling.
> 
> There is an incredible amount of crap that could be cleaned up for
> example by re-ordering a bit the init code and making things like slab
> available before init_IRQ/time_init etc... but all of those will break
> because of that.
> 
> In addition, even without that re-ordering, I'm pretty sure we are
> hitting semaphores/mutexes early, before init_IRQ(), already and if not
> in generic code, in arch code somewhere down the call stacks.
> 
> I don't think that whole pile of problems lurking around the corner is
> worth the couple of cycles saved by hard-enabling irq in the mutex
> instead of doing a save/restore.

A couple of cycles repeated a zillion times per second for the entire
uptime, just because we cannot get our act together in the first few
seconds of booting.  How much does that suck?

And how much does it suck that we require that an attempt to take a
sleeping lock must keep local interrupts disabled if the lock wasn't
contended?

Fortunately, it only happens (or at least, is only _known_ to happen) when
mutex debugging is enabled, so the performance loss is moot.

I do not know where the offending mutex_lock()s are occuring (although it
would be super-simple to find out).

By far the best solution to this would be to remove this requirement that
local interrupts remain disabled for impractical amounts of time during boot.
Either whack the PIC in setup_arch() or reorganise start_kernel() in some
appropriate manner.

But I'll be merging
work-around-ppc64-bootup-bug-by-making-mutex-debugging-save-restore-irqs.patch
so we'll just continue to suck I guess.

