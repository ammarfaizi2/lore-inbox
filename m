Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154324AbQA3FwC>; Sun, 30 Jan 2000 00:52:02 -0500
Received: by vger.rutgers.edu id <S153955AbQA3Fvk>; Sun, 30 Jan 2000 00:51:40 -0500
Received: from dyn-225.linux.theplanet.co.uk ([195.92.192.225]:2110 "EHLO caramon.arm.linux.org.uk") by vger.rutgers.edu with ESMTP id <S154163AbQA3Fv0>; Sun, 30 Jan 2000 00:51:26 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200001300948.JAA02530@flint.arm.linux.org.uk>
Subject: Re: DMA changes in 2.3.41 - how the f* do I get this working on ARM?
To: jakub@redhat.com (Jakub Jelinek)
Date: Sun, 30 Jan 2000 09:48:11 +0000 (GMT)
Cc: davem@redhat.com (David S. Miller), linux-kernel@vger.rutgers.edu
In-Reply-To: <20000130070126.C948@mff.cuni.cz> from "Jakub Jelinek" at Jan 30, 2000 07:01:26 AM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

Jakub Jelinek writes:
> With the pci_map_single/pci_map_sg/pci_unmap_single/pci_unmap_sg
> you can sync caches in those routines as required (plus there are
> pci_dma_sync_single/pci_dma_sync_sg which should sync as well).

Unfortunately, that is not sufficient.  Those pci_* functions have no
knowledge of what the memory is going to be used for, and they need to
know.  I am assuming that a particular usage of this interface may be:

CPU writes to block		(some time in the past)
pci_map_single			(cleans and flushes cache)
dma operation			(dma writes to block)
CPU reads from block
pci_unmap_single

You have expended possibly a lot of CPU cycles writing out data to the
memory, which then get immediately overwritten by the DMA operation when
instead you could just flush the cache to discard the data.

[ Note: clean means write back the data to memory, flush means remove data
  from cache here.  These are two distinctly different operations ].

> With pci_alloc_consistant, on DMA non-coherent systems the trick is to
> allocate a non-cacheable memory (or make it uncacheable after allocating).

This is one point that I keep on making over and over again whenever the
DMA cache discussion comes up.  People think "oh, page tables, one entry
per page, you can turn off the cache on a per-page basis".

I'm sure people are aware of the 4MB pages on the Intel architecture?  Well,
believe it or not, other architectures have them.  In this specific case,
the ARM has 1MB large pages.  We use them to map in the kernel memory, and
IO, and they save TLB lookups etc.

With this scheme that's being advocated, not only does it hit us with
inefficiency in cache handling, but it also hits us on the TLB as well.
Double wammy.

> The interface was lined out e.g. during the
> Alpha: virt_to_bus/GFP_DMA problem
> thread on l-k in december.

Err, this pci_* interface wasn't.  I still have a record of the DMA coherency
discussion sitting in my l-k mailbox.  The discussion was between Pete, Ingo,
Roman, Jes, Ralf and myself.
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | |   http://www.arm.linux.org.uk/~rmk/aboutme.html    /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
