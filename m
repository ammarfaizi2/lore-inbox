Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272051AbRHWBGu>; Wed, 22 Aug 2001 21:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272067AbRHWBGk>; Wed, 22 Aug 2001 21:06:40 -0400
Received: from eamail1-out.unisys.com ([192.61.61.99]:41875 "EHLO
	eamail1-out.unisys.com") by vger.kernel.org with ESMTP
	id <S272051AbRHWBGZ>; Wed, 22 Aug 2001 21:06:25 -0400
Message-ID: <245F259ABD41D511A07000D0B71C4CBA289F2E@us-slc-exch-3.slc.unisys.com>
From: "Van Maren, Kevin" <kevin.vanmaren@unisys.com>
To: "'gibbs@scsiguy.com'" <gibbs@scsiguy.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: With Daniel Phillips Patch
Date: Wed, 22 Aug 2001 20:06:21 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you enumerate the devices that actually issue a DAC when loaded with
> 64bit address with 0's in the most significant 32bits?

There had better not be any.  It is a violation of the PCI specification
to generate a DAC if the address fits in 32 bits.

DAC is a LOT faster and more efficient than a copy (except perhaps for the
very smallest of transfers, which are already very inefficient).

The problem is that (for most hardware) the 64-bit descriptors take up more
room (and hence more PCI cycles to transfer) than the 32-bit descriptors,
especially with a 32-bit bus.  [Apparently not the case for the 39-bit
AIC7xxx driver, but it is the case for the 64-bit Adaptec.]  So unless
there is the possibility of using 64-bit DMA, you want to use the smaller
descriptors.  So on systems with <= 32bits of memory/dma_addr_t, the driver
should be able to "know" that it should use the smaller descriptors for
efficiency.

I also believe that a dma_addr_t should be determined by the system, not the
driver: the driver should indicate constraints and the OS should ensure that
the dma_addr_t it provides meets the constraints.  Separate 32-bit and
64-bit
DMA routines adds unnecessary complication.  As far as I can tell, the only
reason to have separate APIs is so that 32bit machines with 64 bit DMA
addresses (PAE on ia32) can avoid copying around an "extra" 32bits of
address for the drivers that don't support 64-bit DMA.  I think it makes
more sense to just make the dma_addr_t 64 bits on ia32 if using PAE and
deal with the insignificant "waste" -- you have > 4GB RAM :-)

Kevin Van Maren
