Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267285AbSLEK42>; Thu, 5 Dec 2002 05:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267278AbSLEK42>; Thu, 5 Dec 2002 05:56:28 -0500
Received: from [217.167.51.129] ([217.167.51.129]:7878 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S267285AbSLEK4V>;
	Thu, 5 Dec 2002 05:56:21 -0500
Subject: Re: [RFC] generic device DMA implementation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20021205004744.GB2741@zax.zax>
References: <200212041747.gB4HlEF03005@localhost.localdomain> 
	<20021205004744.GB2741@zax.zax>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 05 Dec 2002 12:08:16 +0100
Message-Id: <1039086496.651.65.camel@zion>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-12-05 at 01:47, David Gibson wrote:
> Do you have an example of where the second option is useful?  Off hand
> the only places I can think of where you'd use a consistent_alloc()
> rather than map_single() and friends is in cases where the hardware's
> behaviour means you absolutely positively have to have consistent
> memory.

Looking at our implementation (ppc32 on non-coherent CPUs like 405) of
pci_map_single, which just flushes the cache, I still feel we need a
consistent_alloc, that is an implementation that _disables_ caching for
the area.

A typical example is an USB OHCI driver. You really don't want to play
cache tricks with the shared area here. That will happen each time you
have a shared area in memory in which both the CPU and the device may
read/write in the same cache line.

For things like ring descriptors of a net driver, I feel it's very much
simpler (and possibly more efficient too) to also allocate non-cacheable
space for consistent instead of continuously flushing/invalidating.
Actually, flush/invalidate here can also have nasty side effects if
several descriptors fit in the same cache line.

The data buffers, of course (skbuffs typically) would preferably use
pci_map_* like APIs (hrm... did we ever make sure skbuffs would _not_
mix the data buffer with control datas in the same cache line ? This
have been a problem with non-coherent CPUs in the past).

Ben.

