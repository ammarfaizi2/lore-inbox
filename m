Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964840AbWIKAMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbWIKAMr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 20:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964842AbWIKAMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 20:12:47 -0400
Received: from gate.crashing.org ([63.228.1.57]:49313 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964840AbWIKAMq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 20:12:46 -0400
Subject: Re: Opinion on ordering of writel vs. stores to RAM
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jesse Barnes <jbarnes@virtuousgeek.org>,
       David Miller <davem@davemloft.net>, jeff@garzik.org, paulus@samba.org,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <0F623199-9152-46B3-8CC3-6FFCDD8AF705@kernel.crashing.org>
References: <17666.11971.416250.857749@cargo.ozlabs.ibm.com>
	 <45028F87.7040603@garzik.org>
	 <20060909.030854.78720744.davem@davemloft.net>
	 <200609101018.06930.jbarnes@virtuousgeek.org>
	 <1157916919.23085.24.camel@localhost.localdomain>
	 <1157923513.31071.256.camel@localhost.localdomain>
	 <0F623199-9152-46B3-8CC3-6FFCDD8AF705@kernel.crashing.org>
Content-Type: text/plain
Date: Mon, 11 Sep 2006 10:12:11 +1000
Message-Id: <1157933531.31071.274.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, so we have two different proposals here...

Maybe we should cast a vote ? :)

 * Option A:

 - writel/readl are fully synchronous (minus mmiowb for spinlocks)
 - we provide __writel/__readl with some barriers with relaxed ordering
between memory and MMIO (though still _precise_ semantics, not arch
specific)

 * Option B:

 - The driver decides at ioremap time wether it wants a fully ordered
mapping or not using
   a "special" version of ioremap (with flags ?)
 - writel/readl() behave differently depending on the mapping
 - __writel/__readl might exist but are architecture specific (ahem...
still to be debated)

The former seems easier to me to implement. The later might indeed be a
bit easier for drivers writers, I'm not 100% convinced tho. The later
means stuffing special tokens in the returned address from ioremap and
testing for them in writel. However, the later is also what we need for
write combining (at least for PowerPC, maybe for other archs, wether a
mapping can write combine has to be decided by using flags in the page
table, thus has to be done at ioremap time. (*) 

Votes ?

(*) Unrelated note about write combine: Due to weird implementation
issues, one cannot guarantee to prevent write combine on a write-combine
enabled mapping using barriers. This doesn't work due to CPUs combining
stores between threads on such mappings. I know of at least one CPU
doing that (Cell), there might be a lot more though. Thus a driver using
write combine might want to create two mappings for it's IOs, one with
combine enabled, one ordered, and use the "right" one depending on the
requirements of a given IO access.

> The tg3 bug actually seems not to be because of the missing wmb()'s,
> [the driver and all net traffic survive just fine in the case of non- 
> TSO],
> but just because of a plain-and-simple programming bug in the driver.
> I'll run some tests tomorrow to confirm.  If I'm right, this fix should
> go into .18 and into .17-stable at least.

Interesting :) I didn't actually verify the barrier problem theory
(though the driver does indeed seem to lack them, so there _is_ a
problem there too), I trusted Michael Chan who seemed to know about the
bug :) Anyway, that doesn't change anything to the fact that there is a
problem with barriers and we are on a good path to finally do something
sane about it.
 
> Of course the problems that the PowerPC port currently has with the
> missing wmb()'s are still there, but in the non-TSO case they almost
> always result in 100% garbage sent on the actual ethernet line, and
> that doesn't impede correctness (and it has been there since about
> forever; even the TSO case that _does_ corrupt data was in the released
> 2.6.17, it's very hard to hit).  There's no reason to delay 2.6.18
> release or change the PowerPC I/O accessors because of this single
> issue, knowing it was in 2.6.17 already.

We can add the missing barriers to tg3 for 2.6.18 nontheless.

> That "trick" to avoid I/O accesses to "leak out" of protected regions
> is just fine, and should be done no matter what -- if it is decreed that
> spinlocks order I/O accesses at all, which is not a bad idea at all (in
> my opinion anyway).

Or we rely on an explicit barrier for that, which is what mmiowb() has
been defined for. We can use the "trick" to detect the missing ones
though, as a debugging aid.

Ben.


