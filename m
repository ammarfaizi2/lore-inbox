Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262175AbUFWXSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbUFWXSa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 19:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbUFWXSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 19:18:30 -0400
Received: from hqemgate00.nvidia.com ([216.228.112.144]:55559 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S262175AbUFWXSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 19:18:05 -0400
Date: Wed, 23 Jun 2004 18:16:18 -0500
From: Terence Ripperda <tripperda@nvidia.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Terence Ripperda <tripperda@nvidia.com>
Subject: [tripperda@nvidia.com: Re: 32-bit dma allocations on 64-bit platforms]
Message-ID: <20040623231618.GD983@hygelac>
Reply-To: Terence Ripperda <tripperda@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Accept-Language: en
X-Operating-System: Linux hrothgar 2.4.23 
X-OriginalArrivalTime: 23 Jun 2004 23:18:04.0033 (UTC) FILETIME=[559A2710:01C45978]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Forwarded message from Terence Ripperda <tripperda@nvidia.com> -----

Date: Wed, 23 Jun 2004 14:36:43 -0700
From: Terence Ripperda <tripperda@nvidia.com>
To: Andi Kleen <ak@muc.de>
Cc: Terence Ripperda <tripperda@nvidia.com>, discuss@x86-64.org, 
	tiwai@suse.de
Subject: Re: 32-bit dma allocations on 64-bit platforms

On Wed, Jun 23, 2004 at 12:22:10PM -0700, ak@muc.de wrote:
> [I would suggest to post x86-64 specific issues to discuss@x86-64.org
> too]

thanks, I'll do that.

> I get from this that your hardware cannot DMA to >32bit.

correct.


> First vmalloc_32 is a rather broken interface and should imho
> just be removed. The function name just gives promises that cannot
> be kept. It was always quite bogus. Please don't use it.

sure. we haven't used this to allocate dma memory in a long time. I was
just using it as an example in showing how difficult it was to allocate
32-bit memory. vmalloc essentially ends up being a
__get_free_page(GFP_*)
call.

> The situation on EM64T is very unfortunate I agree. There was a reason
> we asked AMD to add an IOMMU and it's quite bad that the Intel chipset
> people ignored that wisdom and put us into this compatibility mess.

> Failing that it would be best if the other PCI DMA hardware
> could just address enough memory, but that's less realistic
> than just fixing the chipset.

also note that even if pci express hw was fixed, the machines still have
pci slots, which any old pci card can be plugged into.

> The x86-64 port had decided early to keep the 16MB GFP_DMA zone
> to get maximum driver compatibility and because the AMD IOMMU gave
> us an nice alternative over bounce buffering.

that was a very understandable decision. and I do agree that using the
AMD IOMMU is a very nice architecture. it is unfortunate to have to deal
with this on EM64T. Will AMD's pci-express chipsets still maintain an
IOMMU, even if it's not needed for AGP anymore? (probably not public
information, I'll check via my channels).

> I must say I'm somewhat reluctant to break an working in tree driver.
> Especially for the sake of an out of tree binary driver. Arguably the
> problem is probably not limited to you, but it's quite possible that
> even the in tree DRI drivers have it, so it would be still worth to
> fix it.

agreed. I completely understand that there is no desire to modify the
core kernel to help our driver. that's one of the reasons I looked
through the other drivers, as I suspect that this is a problem for 
many drivers.  I only looked through the code for each briefly, but 
didn't see anything to handle this. I suspect it's more of a case that 
the drivers have not been stress tested on an x86_64 machine w/ 4+ G 
of memory.

also interesting to hear about some of the pci devices with limited
addressing capability. 

> I see two somewhat realistic ways to handle this:

either of those approaches sounds good. keeping compatibility with older
devices/drivers is certainly a good thing.

can the core kernel handle multiple new zones? I haven't looked at the
code, but the zones seem to always be ZONE_DMA and ZONE_NORMAL, with
some architectures adding ZONE_HIMEM at the end. if you add a 
ZONE_DMA_32 (or whatever) between ZONE_DMA and ZONE_NORMAL, will the 
core vm code be able to handle that? I guess one could argue if it 
can't yet, it should be able to, then each architecture could create 
as many zones as they wanted.

another brainstorm: instead of counting on just a large-grained zone and
call to __get_free_pages() returning an allocation within a given
bit-range, perhaps there could be large-grained zones, with a
fine-grained hint used to look for a subset within the zone. for example, 
there could be a DMA32 zone, but a mask w/ 24- or 29- bits enabled could 
be used to scan the DMA32 zone for a valid address. (don't know how well 
that fits into the current architecture).

Thanks,
Terence

----- End forwarded message -----
