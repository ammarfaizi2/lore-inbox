Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263129AbTGAR2c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 13:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263176AbTGAR2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 13:28:31 -0400
Received: from ns.suse.de ([213.95.15.193]:12 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263129AbTGAR2X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 13:28:23 -0400
Date: Tue, 1 Jul 2003 19:42:41 +0200
From: Andi Kleen <ak@suse.de>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: axboe@suse.de, grundler@parisc-linux.org, davem@redhat.com,
       suparna@in.ibm.com, linux-kernel@vger.kernel.org,
       alex_williamson@hp.com, bjorn_helgaas@hp.com
Subject: Re: [RFC] block layer support for DMA IOMMU bypass mode
Message-Id: <20030701194241.368a6a9c.ak@suse.de>
In-Reply-To: <1057080529.2003.62.camel@mulgrave>
References: <1057077975.2135.54.camel@mulgrave>
	<20030701190938.2332f0a8.ak@suse.de>
	<1057080529.2003.62.camel@mulgrave>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01 Jul 2003 12:28:47 -0500
James Bottomley <James.Bottomley@steeleye.com> wrote:


> Could you elaborate more on the amd64 IOMMU window.  Is this a window
> where IOMMU mapping always takes place?

Yes.

K8 doesn't have a real IOMMU. Instead it extended the AGP aperture to work
for PCI devices too.  The AGP aperture is a hole in memory configured 
at boot, normally mapped directly below 4GB, but it can be elsewhere
(it's actually an BIOS option on machines without AGP chip and when 
the BIOS option is off Linux allocates some memory and puts the hole
on top of it. This allocated hole can be anywhere in the first 4GB) 
Inside the AGP aperture memory is always remapped, you get a bus abort
when you access an area in there that is not mapped.

In short to detect it it needs to test against an address range, 
a mask is not enough.

> 
> I'm a bit reluctant to put a function like this in because the block
> layer does a very good job of being separate from the dma layer. 
> Maintaining this separation is one of the reasons I added a dma_mask to
> the request_queue, not a generic device pointer.

Not sure I understand why you want to do this in the block layer.
It's a generic extension of the PCI DMA API. The block devices/layer itself
has no business knowing such intimate details about the pci dma 
implementation, it should just ask.

-Andi

