Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266094AbUBKTJE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 14:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266099AbUBKTJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 14:09:04 -0500
Received: from mx1.redhat.com ([66.187.233.31]:10981 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266094AbUBKTI7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 14:08:59 -0500
Date: Wed, 11 Feb 2004 11:08:53 -0800
From: "David S. Miller" <davem@redhat.com>
To: dsaxena@plexity.net
Cc: mporter@kernel.crashing.org, lists@mdiehl.de, linux-kernel@vger.kernel.org
Subject: Re: [Patch] dma_sync_to_device
Message-Id: <20040211110853.492f479b.davem@redhat.com>
In-Reply-To: <20040211185725.GA25179@plexity.net>
References: <20040211061753.GA22167@plexity.net>
	<Pine.LNX.4.44.0402110729510.2349-100000@notebook.home.mdiehl.de>
	<20040211111800.A5618@home.com>
	<20040211103056.69e4660e.davem@redhat.com>
	<20040211185725.GA25179@plexity.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Feb 2004 11:57:25 -0700
Deepak Saxena <dsaxena@plexity.net> wrote:

> > 1) pci_map_single(), device DMA's from the buffer.
> > 
> > 2) pci_dma_sync_single().  Cpu writes some new command or
> >    status flag into the buffer.
> > 
> > 3) pci_dma_sync_to_device_single(), now device is asked to DMA from the buffer
> >    again.
> > 
> > Cache flushes are needed on MIPS for both step #2 and #3, and different kinds of
> > flushes in fact.
> > 
> > Do you understand the need for this now?
> 
> Not really. Steps 2 and 3 can be done by simply calling pci_dma_sync_single()
> with the appropriate direction flag.

No, direction says what device did or is going to do with the buffer.

> I don't understand why a 
> pci_dma_sync_single() is needed after the device does a DMA from the 
> buffer and before the CPU writes a command.

To flush PCI controller caches.

> After the CPU writes data to the
> buffer, it can do a pci_dma_sync_single(..., DMA_TO_DEVICE), which causes
> a cache flush. Isn't this what we're already doing today?

It is different.  pci_dma_sync_single(..., DMA_TO_DEVICE), on MIPS for example,
would do absolutely nothing.  At mapping time, the local cpu cache was flushed,
and assuming the MIPS pci controllers don't have caches of their own there is
nothing to flush there either.

Whereas pci_dma_sync_device_single() would flush the dirty lines from the cpu
caches.  In fact, it will perform the same CPU cache flushes as pci_map_single()
did, using MIPS as the example again.

New sequence:

1) pci_map_single(..., DMA_TO_DEVICE).  Flush dirty data from cpu caches to memory,
   so device may see it.

2) device reads buffer

3) pci_dma_sync_single(... DMA_TO_DEVICE).  If PCI controller has caches, flush them.

4) CPU writes new buffer data.

5) pci_dma_sync_device_single(... DMA_TO_DEVICE).  Like #1, flush dirty data from cpu
   caches to memory.

6) Device reads buffer.

Still disagree? :-)
