Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265692AbUBKTa2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 14:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265693AbUBKTa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 14:30:28 -0500
Received: from mx1.redhat.com ([66.187.233.31]:32146 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265692AbUBKTaV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 14:30:21 -0500
Date: Wed, 11 Feb 2004 11:30:15 -0800
From: "David S. Miller" <davem@redhat.com>
To: Matt Porter <mporter@kernel.crashing.org>
Cc: mporter@kernel.crashing.org, lists@mdiehl.de, dsaxena@plexity.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] dma_sync_to_device
Message-Id: <20040211113015.2b91bd89.davem@redhat.com>
In-Reply-To: <20040211122319.B5618@home.com>
References: <20040211061753.GA22167@plexity.net>
	<Pine.LNX.4.44.0402110729510.2349-100000@notebook.home.mdiehl.de>
	<20040211111800.A5618@home.com>
	<20040211103056.69e4660e.davem@redhat.com>
	<20040211122319.B5618@home.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Feb 2004 12:23:19 -0700
Matt Porter <mporter@kernel.crashing.org> wrote:

> On Wed, Feb 11, 2004 at 10:30:56AM -0800, David S. Miller wrote:
> > 1) pci_map_single(), device DMA's from the buffer.
> > 
> > 2) pci_dma_sync_single().  Cpu writes some new command or
> >    status flag into the buffer.
> > 
> > 3) pci_dma_sync_to_device_single(), now device is asked to DMA from the buffer
> >    again.
> 
> Actually, not yet.  Is it not possible for MIPS to determine the correct
> cache operation to use if step #3 used a pci_dma_sync_single() with a
> TO_DEVICE direction?  

It should do a writeback of dirty data from the cpu cache, so that the device
may see it after pci_dma_sync_to_device_single() completes.

> I'm guessing that MIPS must have some kind of bridge cache in order to
> require the pci_dma_sync_to_device_single() if I'm starting to follow
> this.

Some platforms do, some don't.  Sparc64 has PCI controller DMA caches but it's
cpu caches are fully coherent, for example.  On such a platform this new interface
is going to be a NOP, but on things like MIPS it will not be.

