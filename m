Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315050AbSEXUio>; Fri, 24 May 2002 16:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315198AbSEXUin>; Fri, 24 May 2002 16:38:43 -0400
Received: from 64-166-72-142.ayrnetworks.com ([64.166.72.142]:28040 "EHLO 
	ayrnetworks.com") by vger.kernel.org with ESMTP id <S315050AbSEXUij>;
	Fri, 24 May 2002 16:38:39 -0400
Date: Fri, 24 May 2002 13:37:12 -0700
From: William Jhun <wjhun@ayrnetworks.com>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible discrepancy regarding streaming DMA mappings in DMA-mapping.txt?
Message-ID: <20020524133711.K7205@ayrnetworks.com>
In-Reply-To: <20020523162425.G7205@ayrnetworks.com> <20020523.225927.132611174.davem@redhat.com> <20020524104345.J7205@ayrnetworks.com> <20020524.104209.31440798.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 10:42:09AM -0700, David S. Miller wrote:
> I see what your problem is, the interfaces were designed such
> that the CPU could read the data.  It did not consider writes.
> 
> It was designed to handle a case like a networking driver where
> a receive packet is inspected before we decide whether we accept the
> packet or just give it back to the card.

I was thinking about whether we could keep the same API but change the
semantics such that, for a cpu-writes-and-gives-to-driver operation, a
pci_dma_sync_*() called with PCI_DMA_TODEVICE would occur between the
write and the DMA:

	1) driver gets buffer from pool and writes into it
	2) driver calls pci_dma_sync_single(..., PCI_DMA_TODEVICE) which
	   in turn copies to a bounce buffer, flushes cache and write
	   buffers (whichever are relevant per architecture)
	3) driver sets up DMA
	4) controller DMAs the packet
	5) driver acknowledges DMA completion, implicitly "takes back"
	   buffer and puts into pool
	6) goto 1)

The problem concerns the meaning of the driver or controller "owning" a
buffer. Should there be a call between steps 4) and 5) where the driver
"reclaims" the buffer? Yet, by this point, nothing should have changed
in the buffer, so there's no reason to copy from the bounce-buffer or
write-back/invalidate cache lines.

So the question is: After having written to a buffer, called
pci_dma_sync_*(), and DMAed the buffer, is there anything left to do
(for certain architectures) before the driver can re-claim it and begin
writing into the buffer again? If the answer is no, then I propose we
keep the API the way it is and change the semantics such that, for
writing streaming buffers to a driver, pci_dma_sync_*() must be called
after all driver writes have completed and before the DMA occurs, thus
transferring "ownership" to the driver.

But to contradict myself and say how I think the API should change...

The pci_(un)map_*() routines provide a convenient model for maintaining
cache coherency in situations where one maps a buffer, does DMA, and
unmaps it once again. For streaming DMA where a set of buffers stay
mapped, however, using pci_dma_sync_*() to handle two different problems
(providing a mapping that the controller can view and maintaining
cache/write-buffer coherency) is, IMHO, somewhat confusing.  Having an
API where separate calls are used for these problems allows the driver
writer to more explicitly say things such as:

[write into buffer]
pci_dma_sync(buffer, TO_DEVICE)            // -Does writeback and wbflush
pci_dma_controller_owns(buffer, TO_DEVICE) // -Bounce-buffer copy, etc
[dma to controller]
pci_dma_driver_owns(buffer, TO_DEVICE)     // -Prepare for CPU write...
(no need to sync - the buffer couldn't have changed)

I have a more complex example that could affect this design, but I'm
going to sit on it for a short while instead of making this e-mail even
longer. :o)

Thanks,
William
