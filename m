Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266043AbUBKSSH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 13:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266045AbUBKSSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 13:18:07 -0500
Received: from fed1mtao02.cox.net ([68.6.19.243]:14319 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP id S266043AbUBKSSD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 13:18:03 -0500
Date: Wed, 11 Feb 2004 11:18:00 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Martin Diehl <lists@mdiehl.de>
Cc: Deepak Saxena <dsaxena@plexity.net>, "David S. Miller" <davem@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] dma_sync_to_device
Message-ID: <20040211111800.A5618@home.com>
References: <20040211061753.GA22167@plexity.net> <Pine.LNX.4.44.0402110729510.2349-100000@notebook.home.mdiehl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0402110729510.2349-100000@notebook.home.mdiehl.de>; from lists@mdiehl.de on Wed, Feb 11, 2004 at 07:51:48AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 11, 2004 at 07:51:48AM +0100, Martin Diehl wrote:
> On Tue, 10 Feb 2004, Deepak Saxena wrote:
> 
> > > +	pci_dma_sync_to_device_single(dev, dma_handle, size, direction);
> > 
> > Maybe I am missunderstanding something, but how is this
> > any different than simply doing:
> > 
> > 	pci_dma_sync_single(dev, dma_handle, size, DMA_TO_DEVICE);
> 
> For i386 you are right: the implementation of pci_dma_sync_single and 
> pci_dma_sync_to_device_single happen to be identical. This is because this 
> arch is cache-coherent so all we have to do to achieve consistency is 
> flushing the buffers. However, for other arch's there might be significant 
> dependency on the direction.

Sure, other non cache coherent arch's that I'm aware of (PPC, ARM, etc.)
already implement the least expensive cache operations based on the
direction parameter in pci_dma_sync_single(). On PPC, we do the right
thing based on each of three valid directions, I don't yet see what
additional information pci_dma_sync_to_device_single() provides. 

> The existing pci_dma_sync_single was meant for the FROM_DEVICE direction 
> only. I agree it's not entirely obvious currently. But making it 

It's definitely not obvious since DMA-mapping.txt shows it as having
a direction parameter and makes no claim that it is only for the
FROM_DEVICE direction.  In addition, all the non-coherent arches I've
worked on implement all the directions.

> BIDIRECTIONAL would be pretty expensive on some none cache-coherent archs 
> and the whole point of having separate streaming mappings with dedicated 
> TO or FROM direction would be void.

BIDIRECTIONAL would be expensive, yes, that's why pci_dma_sync_single()
implementation use the already present directional information to do
the right thing.

Maybe we need a clear example.

-Matt
