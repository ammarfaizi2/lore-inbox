Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbWIKJYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbWIKJYi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 05:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWIKJYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 05:24:38 -0400
Received: from gate.crashing.org ([63.228.1.57]:42151 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751308AbWIKJYh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 05:24:37 -0400
Subject: Re: Opinion on ordering of writel vs. stores to RAM
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Segher Boessenkool <segher@kernel.crashing.org>,
       Jesse Barnes <jbarnes@virtuousgeek.org>,
       David Miller <davem@davemloft.net>, jeff@garzik.org, paulus@samba.org,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <1157965372.23085.87.camel@localhost.localdomain>
References: <17666.11971.416250.857749@cargo.ozlabs.ibm.com>
	 <45028F87.7040603@garzik.org>
	 <20060909.030854.78720744.davem@davemloft.net>
	 <200609101018.06930.jbarnes@virtuousgeek.org>
	 <1157916919.23085.24.camel@localhost.localdomain>
	 <1157923513.31071.256.camel@localhost.localdomain>
	 <0F623199-9152-46B3-8CC3-6FFCDD8AF705@kernel.crashing.org>
	 <1157933531.31071.274.camel@localhost.localdomain>
	 <1157965372.23085.87.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 11 Sep 2006 19:23:58 +1000
Message-Id: <1157966638.3879.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-11 at 10:02 +0100, Alan Cox wrote:
> Ar Llu, 2006-09-11 am 10:12 +1000, ysgrifennodd Benjamin Herrenschmidt:
> >  - writel/readl are fully synchronous (minus mmiowb for spinlocks)
> >  - we provide __writel/__readl with some barriers with relaxed ordering
> > between memory and MMIO (though still _precise_ semantics, not arch
> > specific)
> 
> I'd rather they were less precise than your later proposal but that
> reflects the uses I'm considering perhaps.

My latest proposal basically defines the rules that I think are useful
for drivers in practice and leaves anything else undefined on purpose
(which means cannot be relied on).

For example, Rule #1, MMIO vs. MMIO has to be strongly defined. Drivers
have to know they can rely on MMIOs staying in order as issued on a
given CPU (and thus read to flush posted writes works etc...). Rule #2
and #3 cover the common cases of mixing up DMA and MMIO, and rule #4 the
special case of MMIOs leaking out of spinlocks. I purposefully didn't
define rules for MMIO W + memory W, or memory R + MMIO R for example.
That would constraint arch implementations too much and I don't see such
rules being useful in practice.

> >  * Option B:
> > 
> >  - The driver decides at ioremap time wether it wants a fully ordered
> > mapping or not using
> 
> That is expensive because writel/readl end up full of if() while at the
> moment they are often 1 instruction.

Yup. I agree. It also has another drawback, which is to make it
non-obvious when reading driver code wether a given writel() is ordered
or not, and thus wether it needs a barrier or not. So it makes auditing
drivers to find such ordering bugs harder for us. It does make porting
of drivers to relaxed semantics easier tho. In any case, it's not
fundamentally incompatible with my proposal in that we can have
readl/writel do the test thing (thus be either Class 1 or Class 2 as per
defined in my proposal) based on a map-time flag, and have the
__readl/__writel versions always be Class 2 (that is relaxed ordering
and fast). But I'd rather not mix up the problems right now and thus
leave that aside until I'm sure we have an agreement on the semantics
and the __* accessors semantics.

Cheers,
Ben.


