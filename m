Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263544AbUDQAmU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 20:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263652AbUDQAmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 20:42:20 -0400
Received: from colin2.muc.de ([193.149.48.15]:26130 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S263544AbUDQAmS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 20:42:18 -0400
Date: 17 Apr 2004 02:42:17 +0200
Date: Sat, 17 Apr 2004 02:42:17 +0200
From: Andi Kleen <ak@muc.de>
To: Terence Ripperda <tripperda@nvidia.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org, eich@suse.de
Subject: Re: PAT support
Message-ID: <20040417004217.GC72227@colin2.muc.de>
References: <20040414005834.GA46220@colin2.muc.de> <20040416180738.GF1180@hygelac>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040416180738.GF1180@hygelac>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2004 at 01:07:38PM -0500, Terence Ripperda wrote:
> the first is that change_page_attr is basically a one-way operation that just sets the caching for a range of pages. in contrast, the cmap_ api is more of a push/pop approach, with cmap_request_range and cmap_release_range. all callers of change_page_attr generally use it to set a new attribute, then assume they need to restore the attribute back to PAGE_KERNEL (WB). additionally, when splitting/merging large pages, change_page_attr has similar assumptions (that we flip between a default PAGE_KERNEL caching and some other caching).
> 
> I haven't thought through all the details yet, but would it be acceptable to consider modifying change_page_attr to also use a push/pop approach? it may also make sense to remove the assumptions about initial state and actually save off what the initial state is, so it can be restored to that state.

change_page_attr can change more than just caching attributes,
also read/write (e.g. slab debug uses it for that) 

At least for the later adding another book keeping data structure
may be too expensive. Of course the data structure is only needed
for change that set a non standard caching attribute,but having
an release function would require a handle to release, forcing
it on the others too.

I think I prefer the do/undo model instead of push/pop.
That can work with cmaps too. PAGE_KERNEL means no cmap,
PAGE_KERNEL_WC and PAGE_KERNEL_NOCACHE get a cmap.

> the second is in iounmap. this function only takes an address, we don't get the size until we've retrieved the struct vm_struct* by freeing the mapping via remove_vm_area. once we have this size, we can call change_page_attr. but by then, the virtual mapping was already freed in remove_vm_area, so playing with the page tables in change_page_attr causes problems:

remove_vm_area() needs to just be split into some worker functions 
(__remove_vm_area et.al.)
> 
> this could be fixed multiple ways: change_page_attr could not touch the page tables at all for i/o regions (would ioremap cover everything? are 4M ptes used on i/o regions?), we could check for the PAGE_PRESENT bit (seems like a hack workaround), I could add an api to retrieve the struct vm_struct* so we could call change_page_attr before calling remove_vm_area. I wanted to check and see what the preferred approach was.

The latest sounds cleanest to me.

> (aside: we only call change_page_attr if we're calling a non-standard ioremap, like ioremap_nocache. I need to move this logic into ioremap, so we get a cmap_ for all ioremaps, regardless of caching type. note that iounmap currently has no idea what caching ioremap requested.)

Why? no cmap means write back, no?

It's probably an academic case anyways - ioremaps without _nocache
should be near always from main memory, which it would ignore.

-Andi
