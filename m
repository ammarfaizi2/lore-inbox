Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965219AbWILArT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965219AbWILArT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 20:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965220AbWILArT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 20:47:19 -0400
Received: from gate.crashing.org ([63.228.1.57]:32694 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965219AbWILArS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 20:47:18 -0400
Subject: Re: [RFC] MMIO accessors & barriers documentation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "David S. Miller" <davem@davemloft.net>,
       Paul Mackerras <paulus@samba.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <4505F030.3020207@pobox.com>
References: <1157947414.31071.386.camel@localhost.localdomain>
	 <200609111139.35344.jbarnes@virtuousgeek.org>
	 <1158011129.3879.69.camel@localhost.localdomain>
	 <4505DB10.7080807@pobox.com>
	 <1158015394.3879.82.camel@localhost.localdomain>
	 <4505F030.3020207@pobox.com>
Content-Type: text/plain
Date: Tue, 12 Sep 2006 10:46:03 +1000
Message-Id: <1158021964.15465.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> wmb() is often used to make sure a memory store is visible to a 
> busmastering PCI device... before the code proceeds with some more 
> transactions in the memory space shared by the host and PCI device.

Yes and that's a different issue. It's purely memory-to-memory barriers
and we already have these well defined.

The problem _is_ with MMIO :) There, you have some ordering issues
happening with some processors that we need to handle, hence the whole
discussion. See below my discussion of your example

> prepare_to_read_dma_memory() is the operation that an ethernet driver's 
> RX code wants.  And this is _completely_ unrelated to MMIO.  It just 
> wants to make sure that the device and host are looking at the same 
> data.  Often this involves polling a DMA descriptor (or index, stored 
> inside DMA-able memory) looking for changes.

Why would you need a barrier other than a compiler barrier() for that ?

All you need for such operations that do not involve MMIOs are the
standard wmb(), rmb() and mb() with their usual semantics and polling
for something to change isn't something that requires any of these. Only
a compiler barrier (or an ugly volatile maybe). Though having a
subsequent read from memory that must be done after that change happened
is indeed the job of rmb().

This has nothing to do with MMIO and is not what I'm describing in the
document. MMIO has it's own issues especially when it comes to MMIO vs.
memmory coherency. I though I described them well enough, looks like
not.

> flush_my_writes_to_dma_memory() is the operation that an ethernet 
> driver's TX code wants, to precede either an MMIO "poke" or any other 
> non-MMIO operation where the driver needs to be certain that the write 
> is visible to the PCI device, should the PCI device desire to read that 
> area of memory.

That's the problem. You need -different- type of barriers wether the
subsequent operation to "poke" the device is an MMIO or an update in
memory. Again, the whole problem is that on some out of order
architectures, non-cacheable storage is on a completely different domain
than cachaeable storage and ordering between them requires specific
barriers unless you want to ditch performances.

Thus in your 2 above examples, we have:

 1- Descriptor update followed by MMIO poke. That needs ordering rule #2
in my list (memory W + MMIO W), which is today not provided by the
PowerPC writel(), but should be according to the discussions we had and
which would be provided by the barrier memory_to_io_wb() in my list if
you chose to use relaxed ordering __writel() version instead for
performances.

 2- Descriptor update followed by update of an index in memory (so no
MMIO involved). This is a standard memory ordering issue and thus a
simple wmb() is needed there.

Currently, the PowerPC writel(), as I just said, doesn't provide
ordering for your example #1, but the PowerPC wmb() does provide the
semantics of both memory/memory coherency and memory/MMIO coherency
(thus making it more expensive than necessary in the memory/memory
case).

My goal here, is to:

 - remove the problem for people who don't understand the issues by
making writel() etc... fully ordered vs. memory. for the cases that
matter to drivers. Thus the -only- case that drivers writers would have
to care about if using those accessors is the memory-memory case in your
second example.

 - provide relaxed __writel etc... for people who -do- understand those
issues and want to improve preformances of the hot path of their driver.
In order to make this actually optimal and safe, I need to precisely
define in what way it is relaxed, what precise ordering semantics are
provided, and provide specific barriers for each of these.

That's what I documented. If you think my document is not clear enough,
I would be happy to have your input on how to make it clearer. Maybe
some introduction explaining the difference above ? (re-using your
examples).

There are still a few questions that I listed about what we want to
provide. The main one is the ordering of MMIO vs. spin_unlock. Do we
want to provide that in the default writel or do we accept that we still
require a barrier in that case even when using "ordered" versions of the
accessors because the performance cost would be too high.

So far, I tend to prefer being fully ordered (and thus not require the
barrier) but I wanted some feedback there. So far, everybody have
carefuly avoided to voice an firm opinion on that one though :)

Ben.


