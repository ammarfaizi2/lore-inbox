Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317467AbSFHXHF>; Sat, 8 Jun 2002 19:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317469AbSFHXHE>; Sat, 8 Jun 2002 19:07:04 -0400
Received: from pizda.ninka.net ([216.101.162.242]:63401 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317467AbSFHXHE>;
	Sat, 8 Jun 2002 19:07:04 -0400
Date: Sat, 08 Jun 2002 16:03:00 -0700 (PDT)
Message-Id: <20020608.160300.37239939.davem@redhat.com>
To: roland@topspin.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <52vg8ta4ki.fsf@topspin.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Roland Dreier <roland@topspin.com>
   Date: 08 Jun 2002 13:38:53 -0700

   The USB stack was doing PCI DMA into buffers that were
   allocated on the stack

This is illegal.

   which causes stack corruption: on the PPC
   440GP, pci_map_single() with PCI_DMA_FROMDEVICE just invalidates the
   cache for the region being mapped.  However, if a buffer is smaller
   than a cache line, then two bad things can happen.
   
There is no allocation scheme legal for PCI DMA which gives you
smaller than a cacheline of data, this includes SLAB.  This is why
stack buffers and the like are illegal for PCI DMA.

   The solution to this was simply to use kmalloc() to allocate buffers
   instead of using automatic variables.

Right.

   However, this leads to my first question: is this safe on all
   architectures?

It must be.  If the architecture allows SLAB to give smaller than
cacheline sized data, it must handle PCI DMA map/unmap flushing
in an appropriate fashion (ie. handle sub-cacheline buffers).
   
   DMA-mapping.txt says kmalloc()'ed memory is OK for DMAs and does not
   mention cache alignment.

It doesn't mention cache alignment because that is an implementation
specific issue.  The user of the interfaces need not be concerned
about any of this.

There need be no changes to the documentation.  If you do as the
documentation states (use kmalloc or get_free_page to get your
buffers) then it will just work.

Franks a lot,
David S. Miller
davem@redhat.com
