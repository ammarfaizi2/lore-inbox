Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317007AbSFALzp>; Sat, 1 Jun 2002 07:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317008AbSFALzo>; Sat, 1 Jun 2002 07:55:44 -0400
Received: from fungus.teststation.com ([212.32.186.211]:55045 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S317007AbSFALzn>; Sat, 1 Jun 2002 07:55:43 -0400
Date: Sat, 1 Jun 2002 13:55:42 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: puw@cola.enlightnet.local
To: Roger Luethi <rl@hellgate.ch>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix VIA Rhine time outs (some)
In-Reply-To: <20020601105745.GA2726@k3.hellgate.ch>
Message-ID: <Pine.LNX.4.44.0206011335300.15719-100000@cola.enlightnet.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Jun 2002, Roger Luethi wrote:

> reset via netdev timeout [1]. The patch addresses that by setting the Tx
> ring buffer pointer to where the driver thinks the chip should continue.

You shouldn't use virt_to_bus().

On x86 it doesn't matter(?) but on other hw it does.
See Documentation/DMA-mapping.txt.


The tx_ring array is allocated with pci_alloc_consistent and the addresses
you are supposed to send to the hardware are the rx_ring_dma and
tx_ring_dma. tx_ring and rx_ring are for the driver.

The initialisation of tx_ring_dma assumes the area allocted by
pci_alloc_consistent is contiguous and that it is ok to use any address
within that area (within any alignment constrinats of the hw). If that
code is correct you could copy it and do:

int entry = np->dirty_tx % TX_RING_SIZE;
writel(np->tx_ring_dma + entry * sizeof(struct tx_desc),
       dev->base_addr + TxRingPtr);

(Or something prettier ...)

/Urban

