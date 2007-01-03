Return-Path: <linux-kernel-owner+w=401wt.eu-S1750831AbXACPB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbXACPB2 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 10:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbXACPB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 10:01:28 -0500
Received: from hancock.steeleye.com ([71.30.118.248]:49093 "EHLO
	hancock.sc.steeleye.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750781AbXACPB1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 10:01:27 -0500
Subject: Re: fuse, get_user_pages, flush_anon_page, aliasing caches and all
	that again
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: David Miller <davem@davemloft.net>, miklos@szeredi.hu, arjan@infradead.org,
       torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, akpm@osdl.org
In-Reply-To: <20070103141655.GA25434@flint.arm.linux.org.uk>
References: <1167778403.3687.1.camel@mulgrave.il.steeleye.com>
	 <20070102.151906.21595863.davem@davemloft.net>
	 <1167780858.3687.13.camel@mulgrave.il.steeleye.com>
	 <20070102.162058.55482337.davem@davemloft.net>
	 <20070103141655.GA25434@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Wed, 03 Jan 2007 09:00:58 -0600
Message-Id: <1167836458.2789.6.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2007-01-03 at 14:16 +0000, Russell King wrote:
> On Tue, Jan 02, 2007 at 04:20:58PM -0800, David Miller wrote:
> > From: James Bottomley <James.Bottomley@SteelEye.com>
> > Date: Tue, 02 Jan 2007 17:34:18 -0600
> > 
> > > Erm ... for a device driver, if we're preparing to do I/O on the page
> > > something must have made the user caches coherent ... that can't be
> > > kmap, because the driver might elect to DMA on the page ... unless
> > > another component of this API is going to be to make dma_map_... also
> > > flush the user cache?
> > 
> > The DMA map/unmap/sync performs the necessary cache flushes.
> 
> Even on ARM, we doesn't do that - we rely on flush_dcache_page() to catch
> those where necessary.
> 
> The locking to walk the shared VMA list is already rather disgusting.
> Trying to do that in IRQ context is not going to be fun.  The locking
> to walk the anon_vma list is not public outside of mm/rmap.c - in my
> ARM flushing-anonymous-caches v2 patch I'm duplicating a couple of
> functions from mm/rmap.c (page_lock_anon_vma() and vma_address()) to
> be able to sanely walk the anonymous vma list.
> 
> I'd rather avoid fiddling around in VMA lists from within the DMA API;
> the DMA API implementation is already fairly complex on ARM what with
> this silly DMA bounce buffer implementation (which exists because the
> Linux VM is unable to properly honor dma_masks).  (Incidentally, I
> don't like this, but because of that problem it's required to get
> various ARM platforms working.)

Yes, this mirrors my concern on parisc too.  We had awful problems with
the locking in flush_dcache_page() as well.

However, I was wondering if there might be a different way around this.
We can't really walk all the user mappings because of the locks, but
could we store the user flush hints in the page (or a related
structure)?  On parisc we don't care about the process id (called space
in our architecture) because we've turned off the pieces of the cache
that match on space id.  Thus, all we care about is flushing with the
physical address and virtual address (and only about 10 bits of this are
significant for matching).  We go to great lengths to ensure that every
mapping in user space all has the same 10 bits of virtual address, so if
we just new what they were we could flush the whole of the user spaces
for the page without having to walk any VMA lists.  Could arm do this as
well?

James


James


