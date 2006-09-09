Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbWIIHXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbWIIHXs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 03:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWIIHXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 03:23:48 -0400
Received: from gate.crashing.org ([63.228.1.57]:24462 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751345AbWIIHXr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 03:23:47 -0400
Subject: Re: Opinion on ordering of writel vs. stores to RAM
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, segher@kernel.crashing.org, davem@davemloft.net
In-Reply-To: <Pine.LNX.4.64.0609081928570.27779@g5.osdl.org>
References: <17666.8433.533221.866510@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.64.0609081928570.27779@g5.osdl.org>
Content-Type: text/plain
Date: Sat, 09 Sep 2006 17:23:20 +1000
Message-Id: <1157786600.31071.166.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-08 at 19:42 -0700, Linus Torvalds wrote:
> 
> On Sat, 9 Sep 2006, Paul Mackerras wrote:
> > 
> > Do you have an opinion about whether the MMIO write in writel() should
> > be ordered with respect to preceding writes to normal memory?
> 
> It shouldn't. It's too expensive.

That's a releif ! I was worried we would have to add a second sync in
there... In fact, we might even be able to remove the one we have right
now (replace it with a more lighweight eieio) if we start using mmiowb
(see below)

>  The fact that PC's have nice memory 
> consistency models means that most of the testing is going to be with the 
> PC memory ordering, but the same way we have "smp_wmb()" (which is also a 
> no-op on x86) we should probably have a "mmiowb()" there.
> 
> Gaah. Right now, mmiowb() is actually broken on x86 (it's an empty define, 
> so it may cause compiler warnings about statements with no effects or 
> something).
> 
> I don't think anyting but a few SCSI drivers that are used on some ia64 
> boxes use mmiowb(). And it's currently a no-op not only on x86 but also on 
> powerpc. Probably because it's defined to be a barrier between _two_ MMIO 
> operations, while we should probably have things like

The problem is that very few people have any clear idea of what mmiowb
is :) In fact, what you described is not the definition of mmiowb
according to Jesse (who, iirc, added it in the first place on ia64). It
was defined as a way to order MMIO vs. MMIO from 2 different nodes. In
fact, it's actually a barrier between MMIO and spin_unlock, preventing
MMIO's from leaking outside of the lock, and thus MMIOs from 2 locked
sections on 2 CPUs from getting mixed together.

However, I'm very happy to define mmiowb() as an almighty barrier for
all sort of stores between all domains (it would be the same instruction
in both case on powerpc anyway, a sync).

If we start requiring mmiowb() to prevent MMIO writes from leaking out
of locks, then we can even remove the sync we have in our MMIO stores
(writel etc...) and replace it with a more lightweight eieio that will
only order vs. other MMIO operations (especially loads). That would need
quite a bit of driver auditing... but we would get back a few nice
percent of performance on heavy IO traffic that we lost due to those
barriers.

>  a)
> 	.. regular mem store ..
> 	mem_to_io_barrier();
> 	.. IOMEM store ..
> 
>  b)
> 	.. IOMEM store ..
> 	io_to_mem_barrier();
> 	.. regular mem store ..
> 
> although it's quite possible that (a) never makes any sense at all.

I quite like mem_to_io_* (barrier/rb/wb) and io_to_mem_* in fact :) That
is probably more talkative to device driver writers and would allow more
fine grained barriers. As Segher mentioned in another thread on this
issue (see his mail titled "A modest proposal" (Ho hum) [was: Re: TG3
data corruption (TSO ?)]" sent to lkml earlier today), the naming of
barrier could be improved based on when to use them to make things
clearer to device writers, while providing archs a more fine grained
approach.

> That said, it's also entirely possible that what you _should_ do is to 
> just make sure that the	"sync" is always _before_ the IO op. But that 
> would require that you have one before an IO load too. Do you? I'm too 
> lazy to check.

We need a sync after the store to prevent them from leaking out of
spinlocks. The problem is locks are in the coherent domain, MMIO isn't,
and on PowerPC, only strong barriers can order between those two. So
either we have a sync after the store (performance hit on IOs), in the
spin_unlock() (performance hit on anybody using spinlocks) ... or we
move the problem to mmiowb() but that means fixing the load of drivers
that don't use it properly and better document it.

> (Keeping it inside a spinlock, I don't know. Spinlocks aren't _supposed_ 
> to order IO, so I don't _think_ that's necessarily an argument for doing 
> so. So your rationale seems strange. Even on x86, a spinlock release by 
> _no_ means would mean that an IO write would be "done").

No, but they should guarantee that stores done within the lock remain
ordered between processors. Example:

Processor A     Processor B

 lock           lock
 write A        write C
 write B        write D
 unlock         unlock

It's important that on the target bus, what is emited is ABCD or CDAB,
that is the 2 locked pairs remain consistent, and not ACBD or something
like that.

Ben.


