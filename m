Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263380AbTGATmp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 15:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263459AbTGATmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 15:42:45 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:59908 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263380AbTGATmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 15:42:42 -0400
Subject: Re: [RFC] block layer support for DMA IOMMU bypass mode
From: James Bottomley <James.Bottomley@steeleye.com>
To: Andi Kleen <ak@suse.de>
Cc: Jens Axboe <axboe@suse.de>, Grant Grundler <grundler@parisc-linux.org>,
       davem@redhat.com, suparna@in.ibm.com,
       Linux Kernel <linux-kernel@vger.kernel.org>, alex_williamson@hp.com,
       bjorn_helgaas@hp.com
In-Reply-To: <20030701194241.368a6a9c.ak@suse.de>
References: <1057077975.2135.54.camel@mulgrave>
	<20030701190938.2332f0a8.ak@suse.de> <1057080529.2003.62.camel@mulgrave> 
	<20030701194241.368a6a9c.ak@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 01 Jul 2003 14:56:49 -0500
Message-Id: <1057089411.1775.104.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-07-01 at 12:42, Andi Kleen wrote:
> K8 doesn't have a real IOMMU. Instead it extended the AGP aperture to work
> for PCI devices too.  The AGP aperture is a hole in memory configured 
> at boot, normally mapped directly below 4GB, but it can be elsewhere
> (it's actually an BIOS option on machines without AGP chip and when 
> the BIOS option is off Linux allocates some memory and puts the hole
> on top of it. This allocated hole can be anywhere in the first 4GB) 
> Inside the AGP aperture memory is always remapped, you get a bus abort
> when you access an area in there that is not mapped.
> 
> In short to detect it it needs to test against an address range, 
> a mask is not enough.

It sounds like basically anything not physically in the window is
bypassable, so you just set BIO_VMERGE_BYPASS_MASK to 1.  Thus, any
segment within the device's dma_mask gets bypassed, and anything that's
not has to be remapped within the window.

I don't see where you need to put extra information into the virtual
merging process.

> > I'm a bit reluctant to put a function like this in because the block
> > layer does a very good job of being separate from the dma layer. 
> > Maintaining this separation is one of the reasons I added a dma_mask to
> > the request_queue, not a generic device pointer.
> 
> Not sure I understand why you want to do this in the block layer.
> It's a generic extension of the PCI DMA API. The block devices/layer itself
> has no business knowing such intimate details about the pci dma 
> implementation, it should just ask.

Virtual merging is already part of the block layer.  It actually
interferes with the ability to bypass the IOMMU because you can't merge
virtually if you want to do a bypass.

James


