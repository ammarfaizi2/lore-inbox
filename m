Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263854AbUDNA6j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 20:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263855AbUDNA6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 20:58:39 -0400
Received: from colin2.muc.de ([193.149.48.15]:1540 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S263854AbUDNA6f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 20:58:35 -0400
Date: 14 Apr 2004 02:58:34 +0200
Date: Wed, 14 Apr 2004 02:58:34 +0200
From: Andi Kleen <ak@muc.de>
To: Terence Ripperda <tripperda@nvidia.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org, eich@suse.de
Subject: Re: PAT support
Message-ID: <20040414005834.GA46220@colin2.muc.de>
References: <m3n05gu4o2.fsf@averell.firstfloor.org> <20040413162108.GA453@hygelac>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040413162108.GA453@hygelac>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[I put Egbert Eich in cc who may be interested in the X server
side of this]

On Tue, Apr 13, 2004 at 11:21:08AM -0500, Terence Ripperda wrote:
> 
> 
> On Mon, Apr 12, 2004 at 05:01:33PM -0700, ak@muc.de wrote:
> > Looks good for starting. The patch could use some minor cleanup still,
> > but it should be good enough for testing.
> 
> sure. I don't know all of the kernel style guidelines well enough, so I wouldn't be surprised if some of that was off. Also, I'm not sure if I did the architectural breakdown correctly.
> 
> 
> > As for an interface - i still think it would be cleaner to just
> > call it from change_page_attr(). Then other users only need to
> > call a single function. But that's easily changed.
> 
> sure, I'm fine with that. I have a couple of related questions that might be dumb:
> 
> we discussed before how change_page_attr takes a struct page *. there are many cases where pci i/o memory is backed by struct pages, but in the majority of x86 desktops, this isn't the case. I'm unclear how these cases would be handled? would change_page_attr be changed to take address/size rather than struct page? would drivers be responsible for recognizing this case and calling a different api in that case (cmap directly)? should x86 be changed such that all memory is covered by struct pages (doubtful)?

Covering everything with struct page * would be a waste of memory
(the mappings tend to be at the end of 4GB and just covering 4GB 
with struct page costs considerable memory) 

I would just change change_page_attr() back to use physical addresses.
In fact the original version did that, but someone complained that
it may get used for highmem too - but that was never handled 
(it BUGs right now) and doesn't make sense because highmem is not
in the direct mapping.


> a lot of mmaps currently use remap_page_range w/o change_page_attr currently. I had thought that by putting the cmap_request inside of remap_page_range, we would make sure we caught all remappings and didn't miss any potential conflicts. is the preference to have all drivers updated and be responsible for calling change_page_attr before remap_page_range? or perhaps I'm missing the obvious: ioremap calls change_page_attr in the correct cases, so perhaps remap_page_range should call change_page_attr, which would in turn call cmap_request.

Normally it's not needed on i386 because the mappings remapped by
 remap_page_range are not in the direct mapping (which only maps the first 
~900MB) on i386.  On x86-64 it is buggy when you have enough memory,
because the PCI IO regions below 4GB will be in the direct mapping then.
Then it should call change_page_attr when it uses a non caching 
attribute, agreed.

It could be a problem on x86 too if someone remaps a mapping in the
 640k-1MB hole, but that's probably unlikely.


> 
> the main reason I hadn't added the cmap_request call to change_page_attr was due to us focusing on i/o regions first, then tackling system memory later. I can go ahead and add the call, since cmap_request will currently recognize system memory and skip over it, returning success. I would then still need to figure out how to work change_page_attr and i/o regions, at least on x86.

For x86 it's not needed, only for x86-64, but it would be nice to use
common behaviour between the two. 

> 
> 
> > To make it really useful I think we need ioremap_wrcomb() and support
> > in the bus/pci mmap function (the PCI layer already has ioctls for this,
> > they are just ignored on i386 right). Then the X server could
> > start using it. 
> 
> is this pci_mmap_page_range? I hadn't seen that before (it looks like it was added to i386 in the 2.6 series). it does look like it's plugged into proc_bus_pci_mmap for i386 on 2.6, but perhaps I'm missing something when skimming the code. that should be easy to add (or would be picked up by a change to remap_page_range).
> 
> I've added ioremap_wrcomb in my tree, but need to test it still.

Yes.  I thought it was already in 2.4? 

The pci mmap also has an ioctl - see drivers/pci/proc.c:proc_bus_pci_ioctl -
to set write combining. It would be nice if that was just hooked up.



> > Without any users the testing coverage would be probably not too good,
> > but it needs some testing in the real world before it could 
> > be merged first. Maybe it could be simply hooked into the AGP
> > driver and into some DRM driver. Then people would start testing
> > it at least.
> 
> sure. I did a quick scan of the code, I see an mmap function in the agpgart code. it looks like some of the drm drivers (ffb/i810/i830) have mmap, but not all of them. I would assume they relied on the agpgart mmap. the agpgart mmap could be updated, based on the decision above (driver vs. change_page_attr/remap_page_range), would that be enough?

Yes.

And possible the X server to use /proc/bus/pci/* instead of /dev/mem
and then use the wrcombining ioctl instead of /proc/mtrr. 

-Andi
