Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317223AbSEXRpf>; Fri, 24 May 2002 13:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317228AbSEXRpc>; Fri, 24 May 2002 13:45:32 -0400
Received: from 64-166-72-142.ayrnetworks.com ([64.166.72.142]:25992 "EHLO 
	ayrnetworks.com") by vger.kernel.org with ESMTP id <S317223AbSEXRpM>;
	Fri, 24 May 2002 13:45:12 -0400
Date: Fri, 24 May 2002 10:43:46 -0700
From: William Jhun <wjhun@ayrnetworks.com>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible discrepancy regarding streaming DMA mappings in DMA-mapping.txt?
Message-ID: <20020524104345.J7205@ayrnetworks.com>
In-Reply-To: <20020523162425.G7205@ayrnetworks.com> <20020523.225927.132611174.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2002 at 10:59:27PM -0700, David S. Miller wrote:
>    However, shouldn't pci_dma_sync_*() be called *before* each
>    PCI_DMA_TODEVICE DMA transfer (after the CPU write, of course) and
>    *after* each PCI_DMA_FROMDEVICE DMA transfer (before CPU access)? And,
>    of course, before and after a "bidirectional" DMA, if appropriate.
>    
> CPU owns the data before pci_map_{sg,single}(), afterwards device
> owns the data.  If CPU wants ownership again, it must wait for
> device to finish with the data when do a pci_sync_{sg,single}().

Ok, that's a fine way to think about it. On my architecture, there is no
DMA "mapping" issue, so I'm selfishly thinking about the cache coherency
issue. :o)

> You are thinking about CPU cache flushing, and that is a detail
> handled transparently to the DMA apis.  If you follow the rules
> described in the documentation and in my previous paragraph,
> the ARCH specific code does the right thing for you.

So in my case, I have a pool of buffers that are being used to DMA data
to a device. Since I keep these buffers for the life of the driver, I
only want to map at the beginning and unmap at the end. Yet, I have to
change the content of these buffers from the CPU side before DMAing. So,
I do the following process:

1) Allocate the buffers
2) Call pci_map_single() (PCI_DMA_TODEVICE) for all buffers
3) Take a buffer, write into it from CPU
4) Call pci_dma_sync_single() on modified buffer to write back modified
   cache lines
5) Initiate DMA
6) Put the buffer back into the pool
7) goto 3)

I'm developing my driver on MIPS, so I don't have any pci "mapping"
issues, bounce buffers or the like. I know how to maintain cache
coherency throughout this process, but I'm not sure how to write it such
that it fits the PCI-DMA mapping API and will work with other
architectures as well. It'd be nice to solve this now and not deal with
it later. :o)

So, if I'm not mistaken, you are saying that I need to call
pci_dma_sync_single() *after* the DMA so that the CPU reclaims ownership
to the buffer? That's fine and probably serves a good purpose on other
architectures, but wouldn't I also need to do one before the DMA (after
the CPU write) operation to flush write buffers/writeback any cachelines
I've modified for non-cache-coherent architectures? Also, the cache
operations are fairly expensive, and performing another
writeback-invalidate (pci_dma_sync_single()) after the DMA doesn't serve
any purpose on my architecture - so I get a performance penalty for the
sake of compatibility. (Unless I #ifndef it out by architecture.
Ughhhh...)

Thanks,
William
