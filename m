Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbWAIKjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWAIKjH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 05:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbWAIKjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 05:39:07 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:27660 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932099AbWAIKjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 05:39:06 -0500
Date: Mon, 9 Jan 2006 10:38:54 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel@vger.kernel.org, bzolnier@gmail.com,
       james.steward@dynamicratings.com, Jeff Garzik <jgarzik@pobox.com>,
       axboe@suse.de
Subject: Re: [MM, HELP] PIO to and from user-mapped page caches
Message-ID: <20060109103853.GA9918@flint.arm.linux.org.uk>
Mail-Followup-To: Tejun Heo <htejun@gmail.com>,
	linux-kernel@vger.kernel.org, bzolnier@gmail.com,
	james.steward@dynamicratings.com, Jeff Garzik <jgarzik@pobox.com>,
	axboe@suse.de
References: <20051222055507.GA19446@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051222055507.GA19446@htj.dyndns.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2005 at 02:55:07PM +0900, Tejun Heo wrote:
> The question is what kind of flushing is required where.  AFAIK, DMA
> API does the following flushing operations.
> 
> * On READ (DMA_FROM_DEVICE)
> 
> 	Invalidate all cpu caches of the target memory area before IO.
> 	There's no need for flushing after IO as DMA transfers don't
> 	affect cpu caches.
> 
> * On WRITE (DMA_TO_DEVICE)
> 
> 	Writeback (but don't invalidate) all cpu caches of the target
> 	memory area before IO.  There's no need for flushing after IO
> 	as DMA write transfers don't dirty cpu caches.
> 
> PIO READs are different from DMA READs in that read operation creates
> (on write-allocate caches) or dirties cache lines and they need to be
> flushed before the page is mapped to user space.

This is correct.

> As the ramdisk driver (driver/block/rd.c) deals with similar problem
> and it performs flush_dcache_page after READ operation, there's no
> question that flush_dcache_page is needed after READ, but we're not
> sure...
> 
> * Is flush_dcache_page needed before PIO READ?  IOW, is it guaranteed
>   that there's no dirty user-mapped cache lines on entry to block
>   layer for READ?

That's a slightly different problem, one which is handled by the mm
layer.  Basically, whenever a page is unmapped from userspace on
aliasing caches, user cache lines need to be invalidated.  Consider
this case:

- A page is mapped into userspace, and is subsequently removed and
  freed without invalidating the cache lines.
- The kernel allocates this page for it's own purposes and writes data
  to the kernel mapping of the page (eg, a slab page).
- At some time later, the cache lines corresponding with the old
  userspace mapping are evicted from the cache and written back to
  the page.

The result is that corruption occurs to this re-used page - and no
device driver has been involved.  So this isn't a problem that
device driver authors need to care about.

> * Is flush_dcache_page needed before PIO WRITE?  IOW, is it guaranteed
>   that there's no dirty user-mapped cache lines on entry to block
>   layer for WRITE?

For msync(), it uses flush_cache_range() prior to marking the pages
dirty (and therefore candidates for being written to devices.)

In the case of swapping pages out, flush_cache_page() is used to
ensure that user data is written to the page.

The final case is write(), where the standard rule is followed -
if the kernel mapping of a page cache page is written by the CPU,
flush_dcache_page() is used after the page has been written.

There's probably other cases as well (I'm not a mm hacker so it's an
area of the kernel I'm not familiar with.)

> * Is there any better (lighter) function to call to flush dirty
>   kernel-mapped cachelines?  flush_dcache_page seems quite heavy for
>   that purpose.

That depends.  The common case for reads from device drivers is
that a page has just been allocated, but not mapped into user
space.  It has been submitted to the block layer to have the
required data placed into the page.

Given that, and a read of Documentation/cachetlb.txt, if an
architecture implements the idea given there, flush_dcache_page()
should just set the PG_arch_1 bit for this case.

So it should be rather light.

> And, I think it would be a good idea to have kmap/unmap wrappers in
> block layer, say, kmap/unmap_for_pio(page, rw) which deal with above
> cache coherency issues.  How does it sound?

That's something I can't comment on.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
