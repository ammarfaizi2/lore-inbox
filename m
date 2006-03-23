Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422664AbWCWTDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422664AbWCWTDk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 14:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422667AbWCWTDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 14:03:40 -0500
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:35565 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1422664AbWCWTDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 14:03:39 -0500
Date: Thu, 23 Mar 2006 21:03:34 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@us.ibm.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, discuss@x86-64.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/3] x86-64: Calgary IOMMU - Calgary specific bits
Message-ID: <20060323190334.GD25830@rhun.haifa.ibm.com>
References: <20060320084848.GA21729@granada.merseine.nu> <200603231731.34097.ak@suse.de> <20060323175345.GB2598@granada.merseine.nu> <200603231902.04043.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603231902.04043.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 07:02:03PM +0100, Andi Kleen wrote:

> If you want a real flush you need CLFLUSH if it's cached and
> a read if it's behind a PCI bridge.

Ok, I'll investigate CLFLUSH.

> > the way the chip works is that incoming addresses from the device that
> > land inside these holes will not get translated, so we have to make
> > sure not to give them out to devices. AFAIK these are the only holes
> > in the IO space as far as the chip is concerned. At least empirically
> > it works :-)
> 
> The 640K-1MB is in no way different from the PCI hole below 4GB in
> this regard.

Right - we reserve 3 regions, the 640KB-1MB hole, and the two PCI
holes if they fall within the range covered by the translation table.

> It's still totally unclear why you special case one and not the
> other.

calgary_reserve_regions() reserves the 640KB-1MB hole, and then calls
calgary_reserve_peripheral_mem_1() and
calgary_reserve_peripheral_mem_2() to reserve the two PCI holes. We
get the (start, limit) for each of those two holes from the chip
itself (where the BIOS set them up previously). The start and limit
for the 640KB hole are "well known".

> In general you should probably drive this over e820 and only allow RAM
> (or hotplug memory beyond end_pfn). Or not have this special case at
> all.

All of these reservations are required for proper operation (yes, we
tried without them) and we're getting them from the chip directly. Any
other address is valid for IO addresses. We are not reserving regions
in the system memory space here, we are reserving regions in the IO
address space that don't get translated properly. It doesn't matter if
there's RAM backing them up or not, as long as any translation we
establish points to valid RAM and actually gets translated.

> > we ran into that; we use the bus's sysdata for NUMA, whereas here we
> > use the bus's pci_dev's sysdata, so there isn't any conflict. If you
> > prefer that we allocate a new structure and use that for both NUMA and
> > Calgary, we can certainly do it.
> 
> Ok but needs prominent comments.

Will add.

> > it should, but at the moment swiotlb is tied too intimately to
> > gart and doesn't work with anything else. It's on our TODO list.
> 
> 
> I don't quite buy this. With the gart ops this really shouldn't 
> be a problem anymore.

It was every time I tested it, both with swiotlb alone and with
Calgary+swiotlb (both after dma_ops, of course). I'll investigate more
fully as soon as possible and send patches to fix.

> > > I would like to see a printk and some comments about the full isolation
> > > because it's a big change. How does it interact with the X server
> > > for once?
> > 
> > X works :-) 
> 
> So it's behind a bridge that doesn't have an IOMMU?

No, it's behind a bridge that does have an IOMMU and is running with
translation enabled (it's on PHB 0 on this machine). I guess you are
concerned with userspace access to the graphics controller directly,
without a kernel driver having set up mapping previously? I will look
into it but emprirically X works so either userspace is not triggering
DMAs or the mappings have been set up by a driver.

Cheers,
Muli
