Return-Path: <linux-kernel-owner+w=401wt.eu-S1750786AbXACORR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbXACORR (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 09:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbXACORQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 09:17:16 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:4725 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786AbXACORQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 09:17:16 -0500
Date: Wed, 3 Jan 2007 14:16:55 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David Miller <davem@davemloft.net>
Cc: James.Bottomley@SteelEye.com, miklos@szeredi.hu, arjan@infradead.org,
       torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, akpm@osdl.org
Subject: Re: fuse, get_user_pages, flush_anon_page, aliasing caches and all that again
Message-ID: <20070103141655.GA25434@flint.arm.linux.org.uk>
Mail-Followup-To: David Miller <davem@davemloft.net>,
	James.Bottomley@SteelEye.com, miklos@szeredi.hu,
	arjan@infradead.org, torvalds@osdl.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	akpm@osdl.org
References: <1167778403.3687.1.camel@mulgrave.il.steeleye.com> <20070102.151906.21595863.davem@davemloft.net> <1167780858.3687.13.camel@mulgrave.il.steeleye.com> <20070102.162058.55482337.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070102.162058.55482337.davem@davemloft.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 02, 2007 at 04:20:58PM -0800, David Miller wrote:
> From: James Bottomley <James.Bottomley@SteelEye.com>
> Date: Tue, 02 Jan 2007 17:34:18 -0600
> 
> > Erm ... for a device driver, if we're preparing to do I/O on the page
> > something must have made the user caches coherent ... that can't be
> > kmap, because the driver might elect to DMA on the page ... unless
> > another component of this API is going to be to make dma_map_... also
> > flush the user cache?
> 
> The DMA map/unmap/sync performs the necessary cache flushes.

Even on ARM, we doesn't do that - we rely on flush_dcache_page() to catch
those where necessary.

The locking to walk the shared VMA list is already rather disgusting.
Trying to do that in IRQ context is not going to be fun.  The locking
to walk the anon_vma list is not public outside of mm/rmap.c - in my
ARM flushing-anonymous-caches v2 patch I'm duplicating a couple of
functions from mm/rmap.c (page_lock_anon_vma() and vma_address()) to
be able to sanely walk the anonymous vma list.

I'd rather avoid fiddling around in VMA lists from within the DMA API;
the DMA API implementation is already fairly complex on ARM what with
this silly DMA bounce buffer implementation (which exists because the
Linux VM is unable to properly honor dma_masks).  (Incidentally, I
don't like this, but because of that problem it's required to get
various ARM platforms working.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
