Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263935AbRFEJRT>; Tue, 5 Jun 2001 05:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263936AbRFEJRK>; Tue, 5 Jun 2001 05:17:10 -0400
Received: from krynn.axis.se ([193.13.178.10]:24524 "EHLO krynn.axis.se")
	by vger.kernel.org with ESMTP id <S263935AbRFEJQx>;
	Tue, 5 Jun 2001 05:16:53 -0400
Date: Tue, 5 Jun 2001 11:17:48 +0200 (CEST)
From: Bjorn Wesen <bjorn.wesen@axis.com>
To: David Woodhouse <dwmw2@infradead.org>
cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: Missing cache flush.
In-Reply-To: <13942.991696607@redhat.com>
Message-ID: <Pine.LNX.4.21.0106051105110.1078-100000@godzilla.axis.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jun 2001, David Woodhouse wrote:
> The flash mapping driver arch/cris/drivers/axisflashmap.c uses a cached
> mapping of the flash chips for bulk reads, but obviously an uncached mapping
> for sending commands and reading status when we're actually writing to or
> erasing parts of the chip.
> 
> However, it fails to flush the dcache for the range used when the flash is 
> accessed through the uncached mapping. So after an erase or write, we may 
> read old data from the cache for the changed area.

I'll start by saying that axisflashmap.c was not meant to be used by any
other archs, that's why it's in arch/cris. But if anyone find it useful,
that's great. Just be aware that it's not _designed_ for general use and
something like this might be just what that might mean.

CRIS is cache coherent just like the x86 cache and does not need any
explicit cache flushes for the write case. Even when doing cache bypass
writing, if a cacheline already exist with the referenced memory, the
cacheline is updated.

In the erase case though, yes there should be a flush. However during the
1-2 seconds it takes to erase a sector, you can with very high certainity
guarantee that the direct-mapped unified 8 kB cache on the CRIS is
flushed from any flash references at all.. I mean, it's one-way
associative, during 1-2 seconds it executes potentially 200 million
instructions. So we haven't really bothered to think about the problem..

For other CPU's it might be more dangerous, although I don't hold my
breath.. 1-2 seconds is a long time when talking about L1 caches.

> However, I can't see a cache operation which performs this function.
> flush_dcache_page() is defined as a NOP on CRIS as, it seems, it is on most
> architectures. On other architectures, there's dma_cache_wback_inv(), but
> that also seems to be a NOP on i386, to pick a random example.

I'd agree that to be really certain, a "flush_dcache()" function
should be implemented and used when an erase finishes. Like David Miller
wrote somewhere in the thread, one way is to use your knowledge of the
arch's cache and do suitable dummy accesses to flush it, if there is no
explicit command to do it. But that's just up to the arch coders..

-bw

