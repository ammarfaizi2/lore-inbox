Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267446AbSLFACF>; Thu, 5 Dec 2002 19:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267465AbSLFACF>; Thu, 5 Dec 2002 19:02:05 -0500
Received: from dp.samba.org ([66.70.73.150]:43469 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267446AbSLFACB>;
	Thu, 5 Dec 2002 19:02:01 -0500
Date: Fri, 6 Dec 2002 10:54:41 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] generic device DMA implementation
Message-ID: <20021205235441.GP1500@zax.zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	James Bottomley <James.Bottomley@steeleye.com>,
	"Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
References: <20021205050536.GE1500@zax.zax> <200212051503.gB5F3Q601998@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212051503.gB5F3Q601998@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2002 at 09:03:24AM -0600, James Bottomley wrote:
> david@gibson.dropbear.id.au said:
> > But if you have the sync points, you don't need a special allocater
> > for the memory at all - any old RAM will do.  So why not just use
> > kmalloc() to get it. 
> 
> Because with kmalloc, you have to be aware of platform
> implementations.  Most notably that cache flush/invalidate
> instructions only operate at the level of certain block of memory
> (called the cache line width).  If kmalloc returns less than a cache
> line width you have the potential for severe cockups because of the
> possibility of interfering cache operations on adjacent kmalloc
> regions that share the same cache line.

Having debugged a stack corruption problem when attempting to use USB
on a PPC 4xx machine, which was due to improperly aligned DMA buffers,
I am well aware of this issue.

> the dma_alloc... function guarantees to avoid this for you by passing the 
> allocation to the platform layer which knows the cache characteristics and 
> requirements for the machine (and dma controller) you're using.

Ok - now I begin to see the point of this: I was being misled by the
emphasis on a preference for consistent allocation and the original
"alloc_consistent" name you suggested.  When consistent memory isn't
strictly required it's as likely as not that it won't be preferred
either.

Given this, and Miles example, I can see the point of a DMA mallocater
that applies DMA constraints that are not to do with consistency.
Then consistency could also be specified, but that's a separate issue.

So, to remove the misleading emphasis on the point of the allocated
being consistent memory (your name change was a start, this goes
further), I'd prefer to see something like:

void *dma_malloc(struct device *bus, unsigned long size, int flags,
		 dma_addr_t *dma_addr);

Which returns virtual and DMA pointers for a chunk of memory
satisfying any DMA conditions for the specified bus.  Then if flags
includes DMA_CONSISTENT (or some such) the memory will be allocated
consistent in addition to those constraints.

If DMA_CONSISTENT is not specified, the memory might be consistent,
and there would be a preference for consistent only on platforms where
consistent memory is actually preferable (I haven't yet heard of one).

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
