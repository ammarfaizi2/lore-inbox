Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267450AbSLFAD1>; Thu, 5 Dec 2002 19:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267465AbSLFACI>; Thu, 5 Dec 2002 19:02:08 -0500
Received: from dp.samba.org ([66.70.73.150]:43725 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267450AbSLFACB>;
	Thu, 5 Dec 2002 19:02:01 -0500
Date: Fri, 6 Dec 2002 11:01:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] generic device DMA implementation
Message-ID: <20021206000116.GR1500@zax.zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	James Bottomley <James.Bottomley@steeleye.com>,
	linux-kernel@vger.kernel.org
References: <200212041747.gB4HlEF03005@localhost.localdomain> <20021205004744.GB2741@zax.zax> <1039086496.651.65.camel@zion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1039086496.651.65.camel@zion>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2002 at 12:08:16PM +0100, Benjamin Herrenschmidt wrote:
> On Thu, 2002-12-05 at 01:47, David Gibson wrote:
> > Do you have an example of where the second option is useful?  Off hand
> > the only places I can think of where you'd use a consistent_alloc()
> > rather than map_single() and friends is in cases where the hardware's
> > behaviour means you absolutely positively have to have consistent
> > memory.
> 
> Looking at our implementation (ppc32 on non-coherent CPUs like 405) of
> pci_map_single, which just flushes the cache, I still feel we need a
> consistent_alloc, that is an implementation that _disables_ caching for
> the area.

No question there: that's James's first option.  

> A typical example is an USB OHCI driver. You really don't want to play
> cache tricks with the shared area here. That will happen each time you
> have a shared area in memory in which both the CPU and the device may
> read/write in the same cache line.
> 
> For things like ring descriptors of a net driver, I feel it's very much
> simpler (and possibly more efficient too) to also allocate non-cacheable
> space for consistent instead of continuously flushing/invalidating.
> Actually, flush/invalidate here can also have nasty side effects if
> several descriptors fit in the same cache line.
> 
> The data buffers, of course (skbuffs typically) would preferably use
> pci_map_* like APIs (hrm... did we ever make sure skbuffs would _not_
> mix the data buffer with control datas in the same cache line ? This
> have been a problem with non-coherent CPUs in the past).

Indeed - the 405GP ethernet driver, which I've worked on, uses exactly
this approach.  consistent_alloc() is used for the descriptor ring
buffer, and DMA syncs are used for the data buffers.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
