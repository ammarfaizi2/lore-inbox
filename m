Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751219AbWDKBqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbWDKBqg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 21:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbWDKBqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 21:46:36 -0400
Received: from gate.crashing.org ([63.228.1.57]:25059 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751215AbWDKBqf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 21:46:35 -0400
Subject: Re: [RFC/PATCH] remove unneeded check in bcm43xx
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
Cc: Michael Buesch <mb@bu3sch.de>, netdev@vger.kernel.org,
       bcm43xx-dev@lists.berlios.de, linux-kernel@vger.kernel.org,
       linville@tuxdriver.com
In-Reply-To: <20060410042228.GN27596@ens-lyon.fr>
References: <20060410040120.GA4860@ens-lyon.fr>
	 <200604100607.33362.mb@bu3sch.de>  <20060410042228.GN27596@ens-lyon.fr>
Content-Type: text/plain
Date: Tue, 11 Apr 2006 11:46:12 +1000
Message-Id: <1144719972.19353.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Yes, I know they hit the message, that's from a message in some forum
> that i got interested in the issue. It probably comes from an allocation
> from:
> http://www.linux-m32r.org/lxr/http/source/arch/powerpc/kernel/pci_direct_iommu.c#L32
> 
> Either the ppc code is wrong (it doesn't enforce dma_mask) either the
> driver still works without the check.
> 
> Maybe ppc should do the same thing as i386:
> 
> 47         if (dev == NULL || (dev->coherent_dma_mask < 0xffffffff))
> 48                 gfp |= GFP_DMA;

PPC doesn't have a ZONE_DMA... PPC assumes that the whole memory is
DMA'able... What happens here is that it works by "chance" on x86 ;)
ZONE_DMA is a thing of the past that represents ISA DMA (below 16M iirc
or something like that). Thus x86 historically maintained a separate
allocation zone down there for ISA devices. What happens here is that
the x86 code sort-of detects that the DMA mask isn't the full 32 bits
and kicks everything down into ZONE_DMA. Makes things work, though the
pressure on ZONE_DMA can often be high enough that you'll have a lot of
failed allocations ...

PPC doesn't have ZONE_DMA, thus can't provide memory guaranteed to be
below that limit.

Now, for ppc32, it should still sort-of work because all of lowmem is
below 1Gb and people generally don't hack their lowmem size (well, I do
but heh, that doesn't count :) and I don't think you'll get skb's in
highmem. But ppc64 hits the problem and at this point, there is nothing
I can do other than either implementing a split zone allocation mecanism
in the ppc64 architecture for the sole sake of bcm43xx (ick !) or doing
some trick with the iommu...

Ben.


