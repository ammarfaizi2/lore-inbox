Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263580AbUDMQW4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 12:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263627AbUDMQW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 12:22:56 -0400
Received: from hqemgate00.nvidia.com ([216.228.112.144]:55561 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S263580AbUDMQWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 12:22:54 -0400
Date: Tue, 13 Apr 2004 11:21:08 -0500
From: Terence Ripperda <tripperda@nvidia.com>
To: Andi Kleen <ak@muc.de>
Cc: Terence Ripperda <tripperda@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: PAT support
Message-ID: <20040413162108.GA453@hygelac>
Reply-To: Terence Ripperda <tripperda@nvidia.com>
References: <m3n05gu4o2.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3n05gu4o2.fsf@averell.firstfloor.org>
User-Agent: Mutt/1.4i
X-Accept-Language: en
X-Operating-System: Linux hrothgar 2.4.23
X-OriginalArrivalTime: 13 Apr 2004 16:22:10.0320 (UTC) FILETIME=[78B37900:01C42173]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, Apr 12, 2004 at 05:01:33PM -0700, ak@muc.de wrote:
> Looks good for starting. The patch could use some minor cleanup still,
> but it should be good enough for testing.

sure. I don't know all of the kernel style guidelines well enough, so I wouldn't be surprised if some of that was off. Also, I'm not sure if I did the architectural breakdown correctly.


> As for an interface - i still think it would be cleaner to just
> call it from change_page_attr(). Then other users only need to
> call a single function. But that's easily changed.

sure, I'm fine with that. I have a couple of related questions that might be dumb:

we discussed before how change_page_attr takes a struct page *. there are many cases where pci i/o memory is backed by struct pages, but in the majority of x86 desktops, this isn't the case. I'm unclear how these cases would be handled? would change_page_attr be changed to take address/size rather than struct page? would drivers be responsible for recognizing this case and calling a different api in that case (cmap directly)? should x86 be changed such that all memory is covered by struct pages (doubtful)?

a lot of mmaps currently use remap_page_range w/o change_page_attr currently. I had thought that by putting the cmap_request inside of remap_page_range, we would make sure we caught all remappings and didn't miss any potential conflicts. is the preference to have all drivers updated and be responsible for calling change_page_attr before remap_page_range? or perhaps I'm missing the obvious: ioremap calls change_page_attr in the correct cases, so perhaps remap_page_range should call change_page_attr, which would in turn call cmap_request.

the main reason I hadn't added the cmap_request call to change_page_attr was due to us focusing on i/o regions first, then tackling system memory later. I can go ahead and add the call, since cmap_request will currently recognize system memory and skip over it, returning success. I would then still need to figure out how to work change_page_attr and i/o regions, at least on x86.


> To make it really useful I think we need ioremap_wrcomb() and support
> in the bus/pci mmap function (the PCI layer already has ioctls for this,
> they are just ignored on i386 right). Then the X server could
> start using it. 

is this pci_mmap_page_range? I hadn't seen that before (it looks like it was added to i386 in the 2.6 series). it does look like it's plugged into proc_bus_pci_mmap for i386 on 2.6, but perhaps I'm missing something when skimming the code. that should be easy to add (or would be picked up by a change to remap_page_range).

I've added ioremap_wrcomb in my tree, but need to test it still.


> Without any users the testing coverage would be probably not too good,
> but it needs some testing in the real world before it could 
> be merged first. Maybe it could be simply hooked into the AGP
> driver and into some DRM driver. Then people would start testing
> it at least.

sure. I did a quick scan of the code, I see an mmap function in the agpgart code. it looks like some of the drm drivers (ffb/i810/i830) have mmap, but not all of them. I would assume they relied on the agpgart mmap. the agpgart mmap could be updated, based on the decision above (driver vs. change_page_attr/remap_page_range), would that be enough?

Thanks,
Terence
