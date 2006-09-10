Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964822AbWIJXgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbWIJXgO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 19:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbWIJXgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 19:36:14 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:227 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S964822AbWIJXgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 19:36:13 -0400
In-Reply-To: <1157923513.31071.256.camel@localhost.localdomain>
References: <17666.11971.416250.857749@cargo.ozlabs.ibm.com> <45028F87.7040603@garzik.org> <20060909.030854.78720744.davem@davemloft.net> <200609101018.06930.jbarnes@virtuousgeek.org> <1157916919.23085.24.camel@localhost.localdomain> <1157923513.31071.256.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0F623199-9152-46B3-8CC3-6FFCDD8AF705@kernel.crashing.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jesse Barnes <jbarnes@virtuousgeek.org>,
       David Miller <davem@davemloft.net>, jeff@garzik.org, paulus@samba.org,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Opinion on ordering of writel vs. stores to RAM
Date: Mon, 11 Sep 2006 01:35:18 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
X-Mailer: Apple Mail (2.750)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  - __writel/__readl are totally relaxed between mem and IO, though  
> they
> still guarantee ordering between MMIO and MMIO.

__write/read should be architecture specific no matter what, no
device driver has any business using them (except right now, some
_have_ to use-em because everything else hurts performance way too
much -- not a good situation to be in).

>  - In order to provide explicit ordering with memory for the above, we
> introduce mem_to_io_barrier() and io_to_mem_barrier().

These should be bus-specific.  Device drivers know what kind of bus
they are on, they have to know anyway, and it's not exactly a bad
thing if they can take advantage of this knowledge.

> It's still unclear
> wether to include mmiowb() as an equivalent here, that is wether the
> spinlock
> case has to be special cased vs. io_to_mem_barrier(). I need to get
> Jesse input on that one.

C, and most assembly languages fwiw, presume a "single thread of
execution", a single execution context.  Which is a fine and quite
performant enough model for most things.  It's not how the real
world works though, so we need a barrier.  I believe calling this
barrier "pci_cpu_to_cpu_barrier()" and having its semantics be,
any PCI access (by this driver) before the barrier on this CPU will
be seen by any agent in the system, before any access (again by this
driver) after the barrier (perhaps on a different CPU), will a) be
not too hard on driver authors to understand and get right; and b)
will not sacrifice a lot of performance on any system.

>  - We start removing those wmb()'s that have been added to drivers to
> handle the ia64 & powerpc case, and possibly convert the "hot" code  
> path
> of such drivers to use the relaxed variants with explicit ordering.

Not remove the wmb()'s, but replace them by something sane.

> Now, this is definitely not 2.6.18 material. For 2.6.18, we can either
> ignore the problem and apply a band-aid to tg3 by adding some missing
> barriers,

The tg3 bug actually seems not to be because of the missing wmb()'s,
[the driver and all net traffic survive just fine in the case of non- 
TSO],
but just because of a plain-and-simple programming bug in the driver.
I'll run some tests tomorrow to confirm.  If I'm right, this fix should
go into .18 and into .17-stable at least.

Of course the problems that the PowerPC port currently has with the
missing wmb()'s are still there, but in the non-TSO case they almost
always result in 100% garbage sent on the actual ethernet line, and
that doesn't impede correctness (and it has been there since about
forever; even the TSO case that _does_ corrupt data was in the released
2.6.17, it's very hard to hit).  There's no reason to delay 2.6.18
release or change the PowerPC I/O accessors because of this single
issue, knowing it was in 2.6.17 already.

> or we can tweak the powerpc writel to become ordered vs.
> previous memory writes. In that later case, though, to avoid a too big
> performance hit, we'll also remove it's previous barrier that was used
> to prevent leaking out of locks, and implement the "trick" described
> above with a per-cpu variable, so that spin_unlock() does the barrier
> whenever it was preceded by a writel.

That "trick" to avoid I/O accesses to "leak out" of protected regions
is just fine, and should be done no matter what -- if it is decreed that
spinlocks order I/O accesses at all, which is not a bad idea at all (in
my opinion anyway).


Segher

