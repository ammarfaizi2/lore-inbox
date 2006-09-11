Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbWIKBg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWIKBg2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 21:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWIKBg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 21:36:28 -0400
Received: from gate.crashing.org ([63.228.1.57]:39842 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932172AbWIKBg1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 21:36:27 -0400
Subject: Re: Opinion on ordering of writel vs. stores to RAM
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, David Miller <davem@davemloft.net>,
       jeff@garzik.org, paulus@samba.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <2486D031-097B-45C6-AC47-D8745844C5A3@kernel.crashing.org>
References: <17666.11971.416250.857749@cargo.ozlabs.ibm.com>
	 <0F623199-9152-46B3-8CC3-6FFCDD8AF705@kernel.crashing.org>
	 <1157933531.31071.274.camel@localhost.localdomain>
	 <200609101734.06839.jbarnes@virtuousgeek.org>
	 <2486D031-097B-45C6-AC47-D8745844C5A3@kernel.crashing.org>
Content-Type: text/plain
Date: Mon, 11 Sep 2006 11:35:54 +1000
Message-Id: <1157938555.31071.300.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What exactly will "weak" mean?  If it's weak enough to please all
> architectures and busses, it'll be so weak that you'll need 2**N
> (with a big N) different barriers.

Which is why I proposed a precise semantic: weak MMIO vs. main meory but
strong between MMIOs on the same CPU. Which, in PowerPC language
translates into no barrier in __writel and eieio,load,twi,isync on
__readl (maybe even a second eieio, I have think about it)
 
> >   - flags argument to ioremap
> 
> ioremap is a bad name anyway, if we'll change the API, change the
> name as well (and it's a bad idea to keep the same name but make it
> mean something different, anyway).

We already have a new API with a nicer name, pci_iomap, to use with the
new "ioread/iowrite" accessors that Linus defined a while ago. Problem:

 - It's a unifed PIO/MMIO interface, thus there is some added overhead
to calls compared to a simple MMIO-only writel/readl. Though your
proposal would add a similar overhead to writel/readl, so maybe we can
consolidate all of these ...

 - It doesn't have a flags arguemnt. But then, there are few enough
users that this can be easily fixed (at least more easily than ioremap)

 - It has few users :) Thus lots of drivers will need heavy conversion.

But that's a good point to remember about the existence of this "other"
MMIO/PIO access API. Because adding a whole lot of __* version of those
calls in addition to the MMIO only readX/writeX will be a mess and tend
to favor your option of just having a flag passed at map time for the
sake of simplicity.

> > Oh, and all MMIO accessors are *documented* with strongly defined
> > semantics. :)
> 
> Not sure what this means?  Document them in all-caps?  :-)
> 
> > If we go this route though, can I request that we don't introduce any
> > performance regressions in drivers currently using mmiowb()?  I.e.
> > they'll be converted over to the new accessor routines when they  
> > become
> > available along with the new barrier macros?
> 
> In my proposal at least, those drivers won't lose any performance
> (except for a conditional on their I/O cookie, which is a trivial
> performance loss compared to the cost of the I/O /an sich/); they
> won't need any changes either, except for some renaming.  Drivers
> _not_ using it might get a performance loss though, because they
> will be forced to run with every-I/O-ordered semantics; they will
> suddenly start to work *correctly* though.

As I wrote in my "vote" email, I have no strong preference at this
point, though I must admit that the fact that your proposal makes the
driver conversion trivial and ends up, imho, easier for driver writers
(and possibly more flexible for archs) makes it appealing. The "only"
problem is the possibly added overhead of a test in readl/writel. I
don't know wether that's relevant enough to justify not going your way
though. Only platforms like ia64 and powerpc will need that test (thus
no performance regression on x86), it might be worth a bit of
benchmarking here to see wether the added test has any real impact on
performances.

Note that nothing prevents us from adding _both_ proposals. It may sound
a bit weird but at the end of the day, if writel/readl are defined as
being strongly ordered, as per Option A, adding a test to make them
optionally -not- strongly ordered based on a cooke in the address won't
hurt much.

In which case, we end up with those 3 cases:

 - slow case: normal ioremap, readl/writel strongly ordered
 - faster case : "special" ioremap, readl/writel faster
 - even faster case : __readl/__writel (save a test from the above)

I mean that having both options at once is possible. Wether it's
something we want to do is a different matter as it might be considered
as adding confusion.
 
Ben.


