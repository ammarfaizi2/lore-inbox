Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266163AbUBKS5i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 13:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266164AbUBKS5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 13:57:38 -0500
Received: from fed1mtao01.cox.net ([68.6.19.244]:62435 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP id S266163AbUBKS5d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 13:57:33 -0500
Date: Wed, 11 Feb 2004 11:57:25 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: "David S. Miller" <davem@redhat.com>
Cc: Matt Porter <mporter@kernel.crashing.org>, lists@mdiehl.de,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] dma_sync_to_device
Message-ID: <20040211185725.GA25179@plexity.net>
Reply-To: dsaxena@plexity.net
References: <20040211061753.GA22167@plexity.net> <Pine.LNX.4.44.0402110729510.2349-100000@notebook.home.mdiehl.de> <20040211111800.A5618@home.com> <20040211103056.69e4660e.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040211103056.69e4660e.davem@redhat.com>
User-Agent: Mutt/1.3.28i
Organization: Plexity Networks
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 11 2004, at 10:30, David S. Miller was caught saying:
> On Wed, 11 Feb 2004 11:18:00 -0700
> Matt Porter <mporter@kernel.crashing.org> wrote:
> 
> > Sure, other non cache coherent arch's that I'm aware of (PPC, ARM, etc.)
> > already implement the least expensive cache operations based on the
> > direction parameter in pci_dma_sync_single(). On PPC, we do the right
> > thing based on each of three valid directions, I don't yet see what
> > additional information pci_dma_sync_to_device_single() provides. 
> 
> There are two points in time where you want to sync:
> 
> 1) Right after the device has done a DMA transaction, and the cpu
>    wishes to read/write the datum.
> 
> 2) Right after the cpu has read/write the datum, and we like to let the
>    device DMA to/from the thing again.
> 
> That is the distinction provided by the two interfaces.
> 
> Consider something like MIPS, cache flushes needed for both of the above
> operations:
> 
> 1) pci_map_single(), device DMA's from the buffer.
> 
> 2) pci_dma_sync_single().  Cpu writes some new command or
>    status flag into the buffer.
> 
> 3) pci_dma_sync_to_device_single(), now device is asked to DMA from the buffer
>    again.
> 
> Cache flushes are needed on MIPS for both step #2 and #3, and different kinds of
> flushes in fact.
> 
> Do you understand the need for this now?

Not really. Steps 2 and 3 can be done by simply calling pci_dma_sync_single()
with the appropriate direction flag.  I don't understand why a 
pci_dma_sync_single() is needed after the device does a DMA from the 
buffer and before the CPU writes a command.  After the CPU writes data to the
buffer, it can do a pci_dma_sync_single(..., DMA_TO_DEVICE), which causes
a cache flush. Isn't this what we're already doing today?  Why do we need 
to do a cache flush before the CPU writes data into the buffer which is
then immediatelly going to be flushed?

~Deepak

-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/
