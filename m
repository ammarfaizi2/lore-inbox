Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317361AbSFLW4K>; Wed, 12 Jun 2002 18:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317367AbSFLW4H>; Wed, 12 Jun 2002 18:56:07 -0400
Received: from pizda.ninka.net ([216.101.162.242]:59093 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317361AbSFLWzA>;
	Wed, 12 Jun 2002 18:55:00 -0400
Date: Wed, 12 Jun 2002 15:50:28 -0700 (PDT)
Message-Id: <20020612.155028.112077227.davem@redhat.com>
To: david-b@pacbell.net
Cc: roland@topspin.com, benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D079D44.4000701@pacbell.net>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Brownell <david-b@pacbell.net>
   Date: Wed, 12 Jun 2002 12:13:08 -0700

   >  In general I certainly support
   > the idea of making the DMA mapping stuff device generic instead of
   > tied to PCI.  
   
   PCI was a good place to start (focus ... :) but clearly it shouldn't
   be the only bus architecture with such support.  Note that there are
   actually two related approaches in the DMA-mapping.txt APIs ... one is
   DMA mapping, the other is "consistent memory".  Both should be made
   generic rather than PCI-specific, not just mapping APIs.
   
I tried to imply this, if I didn't it is my error.

The intention is that every interface in DMA-mapping.txt will have
a dev_* counterpart when we move away from pci_dev to the generic
device struct.

One idea I want people to avoid is that we end up trying to do DMA
operations from a USB generic device struct.  This will lead to
multiple levels of indirection to do the PCI dma operation (USB device
--> USB bus --> PCI bus --> PCI bus DMA ops) and that will be ugly as
hell.
   
   Based on the discussion, I think the answer for now is to go with
   the (b) variant you had originally started with, using kmalloc for
   the buffers.  The __dma_buffer style macro didn't seem popular;
   though I agree that it's not clear kmalloc() really solves it
   today.  (Given DaveM's SPARC example, the minimum size value it
   returns would need to be 128 bytes ... which clearly isn't so.)
   
Let's ignore the sparc64 issue for now.  It's really a red herring
because as Pavel mentioned I could just use the largest size.

In actuality the "sparc64 issue" was partially a straw-man.  Sparc64
has none of the DMA alignment issues as the PCI controller provides
coherency of partial cacheline transfers, we just need to flush
pending writes and prefetched reads out of the PCI controllers around
non-consistent DMA transfers.
   
Franks a lot,
David S. Miller
davem@redhat.com
