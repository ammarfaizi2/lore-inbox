Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266274AbUGAUs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266274AbUGAUs7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 16:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266284AbUGAUs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 16:48:59 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:47056 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S266274AbUGAUs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 16:48:57 -0400
Subject: Re: [RFC] on-chip coherent memory API for DMA
From: James Bottomley <James.Bottomley@steeleye.com>
To: David Brownell <david-b@pacbell.net>
Cc: Ian Molton <spyro@f2s.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       tony@atomide.com, jamey.hicks@hp.com, joshua@joshuawise.com,
       Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <40E470A9.3000908@pacbell.net>
References: <1088518868.1862.18.camel@mulgrave>		<40E41BE1.1010003@pacbell.net>
	<1088692004.1887.8.camel@mulgrave> 	<40E42374.8060407@pacbell.net>
	<1088705063.1919.16.camel@mulgrave>  <40E470A9.3000908@pacbell.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 01 Jul 2004 15:48:40 -0500
Message-Id: <1088714925.2039.20.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-07-01 at 15:14, David Brownell wrote:
> That can work when the scope of "DMA" knowledge is just
> one driver ... but when that driver is plugging into a
> framework, it's as likely to be some other code (maybe
> a higher level driver) that just wants RAM address space
> which, for whatever reasons, is DMA-coherent.  And hey,
> the way to get this is dma_alloc_coherent ... or in some
> cases, pci_alloc_consistent.

If the driver can't cope then you *only* use DMA_MEMORY_MAPPED.

> Which is why my comment was that the new feature of
> returning some kind of memory cookie usable on that one
> IBM box (etc) should just use a different allocator API.
> It doesn't allocate RAM "similarly to __get_free_pages";
> it'd be returning something drivers can't treat as RAM.

Well, I don't believe it will be necessary.  However, when an actual
user comes along, we'll find out.

> This isn't I/O address space, needing PIO I/O accessors,
> and as returned by the new DMA_MEMORY_IO mode.  (And why
> wouldn't ioremap already handle that?)

The purpose of the API is to allow a mode of operation on all platforms
linux supports.

> This is how to allocate DMA-ready buffers that have certain
> characteristics aren't useful only to the lowest level
> drivers in the stack.  Drivers depend on alloc_coherent to
> behave in the way you (originally) said DMA_MEMORY_MAP works.
> The more detailed API specs (DMA-mapping.txt not DMA-API.txt)
> are very clear that the behavior is like RAM.

It is no-longer real memory once you use this API.  Even if the
processor can treat DMA_MEMORY_MAP memory as "real", you'll probably
find that a device off on another bus cannot even see it.  However, as
long as you keep the memory between the processor and the device then
you can treat it identical to RAM.

> > It can *only* happen if you specify DMA_MEMORY_EXCLUSIVE; that preempts
> > the GFP_ flags and the application must be coded with this in mind. 
> > Otherwise it will respect the GFP_ flags.
> 
> You'd have to change the spec to allow that.  Wouldn't it be
> a lot simpler to just pass the GFP flags down to that lowlevel
> code, so it can eventually start doing what the highlevel code
> told it to do?  :)
> 
> Special cases make for fragile systems.

The intention of the flags option for dma_alloc_coherent() was only for
memory allocation instructions; the allocation can fail for other
reasons that unavailability of memory depending on how the API is
implemented, so __GFP_NOFAIL doesn't actually work now in every case. 
Thus this doesn't actually represent a departure.

James


