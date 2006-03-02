Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbWCBKAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbWCBKAY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 05:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWCBKAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 05:00:24 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:25102 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932302AbWCBKAX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 05:00:23 -0500
Date: Thu, 2 Mar 2006 10:59:59 +0100
From: Jens Axboe <axboe@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Michael Monnerie <m.monnerie@zmi.at>, linux-kernel@vger.kernel.org,
       suse-linux-e@suse.com, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: PCI-DMA: Out of IOMMU space on x86-64 (Athlon64x2), with solution
Message-ID: <20060302095959.GD4329@suse.de>
References: <200603020023.21916@zmi.at> <200603020203.49128.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603020203.49128.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02 2006, Andi Kleen wrote:
> On Thursday 02 March 2006 00:23, Michael Monnerie wrote:
> > Hello, I use SUSE 10.0 with all updates and actual kernel 2.6.13-15.8 as
> > provided from SUSE (just self compiled to optimize for Athlon64, SMP,
> > and HZ=100), with an Asus A8N-E motherboard, and an Athlon64x2 CPU.
> > This host is used with VMware GSX server running 6 Linux client and one
> > Windows client host. There's a SW-RAID1 using 2 SATA HDs.
> 
> Nvidia hardware SATA cannot directly DMA to > 4GB, so it 
> has to go through the IOMMU. And in that kernel the Nforce
> ethernet driver also didn't do >4GB access, although the ethernet HW 
> is theoretically capable.
> 
> Maybe VMware pins unusually much IO memory in flight (e.g. by using
> a lot of O_DIRECT). That could potentially cause the IOMMU to fill up.
> The RAID-1 probably also makes it worse because it will double the IO
> mapping requirements.
> 
> Or you have a leak in some driver, but if the problem goes away
> after enlarging the IOMMU that's unlikely.
> 
> What would probably help is to get a new SATA controller that can 
> access >4GB natively and at some point update to a newer kernel
> with newer forcedeth driver. Or just run with the enlarged IOMMU.

libata should also handle this case better. Usually we just need to
defer command handling if the dma_map_sg() fails. Changing
ata_qc_issue() to return nsegments for success, 0 for defer failure, and
-1 for permanent failure should be enough. The SCSI path is easy at
least, as we can just ask for a defer there. The internal qc_issue is a
little more tricky.

The NCQ patches have logic to handle this, although for other reasons
(to avoid overlap between NCQ and non-NCQ commands). It could easily be
reused for this as well.

-- 
Jens Axboe

