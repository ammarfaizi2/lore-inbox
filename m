Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751062AbWIJVZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbWIJVZq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 17:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbWIJVZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 17:25:46 -0400
Received: from gate.crashing.org ([63.228.1.57]:59039 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751061AbWIJVZp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 17:25:45 -0400
Subject: Re: Opinion on ordering of writel vs. stores to RAM
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>,
       David Miller <davem@davemloft.net>, jeff@garzik.org, paulus@samba.org,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       segher@kernel.crashing.org
In-Reply-To: <1157916919.23085.24.camel@localhost.localdomain>
References: <17666.11971.416250.857749@cargo.ozlabs.ibm.com>
	 <45028F87.7040603@garzik.org>
	 <20060909.030854.78720744.davem@davemloft.net>
	 <200609101018.06930.jbarnes@virtuousgeek.org>
	 <1157916919.23085.24.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 11 Sep 2006 07:25:13 +1000
Message-Id: <1157923513.31071.256.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm copying that from a private discussion I had. Please let me know if
you have comments. This proposal includes some questions too so please
answer :)


 - writel/readl become totally ordered (including vs. memory). Basically
x86-like. Expensive (very expensive even on some architectures) but also
very safe. There might be room for one exception here: ordering vs
locks, in which case we either still require mmiowb() or use a "trick"
consisting of having writel() set a flag in some per-cpu area and
spin_unlock() do a barrier when this flag is set. Thus Q: Should it have
ordered semantics vs. locks too or do we require mmiowb() still, though
maybe
a renamed version of it ? (That is, does it provide MMIO + memory
ordering
instead of just memory + MMIO and MMIO + MMIO ?). Remember that
providing the
second is already expensive, providing both is -very- expensive on some
architectures. Or do we do neither (that is no MMIO + memory ordering)
but
also alleviate the need for mmiowb() with the trick I described in
locks ?

 - __writel/__readl are totally relaxed between mem and IO, though they
still guarantee ordering between MMIO and MMIO. That guaranteed, on
powerpc, can be acheived by putting most of the burden in __readl(),
thus letting __writel() alone to still allow for write combining. We
still need to verify wether those semantics are realistic on other
out-of-order platforms. Jesse ?
Or do you guys prefer it to be -also- relaxed for MMIO + MMIO ? That
would
make thing a bit harder for platforms like PowerPC to use them as we
would
need to defined a specific mmio_to_mmio_barrier() for use with them. I
don't
think that's useful if we can always implement ordering between MMIO and
MMIO
and still allow for write combining on all plaforms. 

 - In order to provide explicit ordering with memory for the above, we
introduce mem_to_io_barrier() and io_to_mem_barrier(). It's still
unclear
wether to include mmiowb() as an equivalent here, that is wether the
spinlock
case has to be special cased vs. io_to_mem_barrier(). I need to get
Jesse input
on that one.

 - We start removing those wmb()'s that have been added to drivers to
handle the ia64 & powerpc case, and possibly convert the "hot" code path
of such drivers to use the relaxed variants with explicit ordering.

Now, this is definitely not 2.6.18 material. For 2.6.18, we can either
ignore the problem and apply a band-aid to tg3 by adding some missing
barriers, or we can tweak the powerpc writel to become ordered vs.
previous memory writes. In that later case, though, to avoid a too big
performance hit, we'll also remove it's previous barrier that was used
to prevent leaking out of locks, and implement the "trick" described
above with a per-cpu variable, so that spin_unlock() does the barrier
whenever it was preceded by a writel.

Cheers,
Ben.


