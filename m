Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263191AbUDVEWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263191AbUDVEWJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 00:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263202AbUDVEWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 00:22:08 -0400
Received: from colin2.muc.de ([193.149.48.15]:19978 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S263191AbUDVEWD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 00:22:03 -0400
Date: 22 Apr 2004 06:21:58 +0200
Date: Thu, 22 Apr 2004 06:21:58 +0200
From: Andi Kleen <ak@muc.de>
To: Terence Ripperda <tripperda@nvidia.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org, eich@suse.de
Subject: Re: PAT support
Message-ID: <20040422042158.GA59207@colin2.muc.de>
References: <20040420185112.GB76023@colin2.muc.de> <20040421231942.GC18735@hygelac>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040421231942.GC18735@hygelac>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2004 at 06:19:42PM -0500, Terence Ripperda wrote:
> 
> ok, got this finished up. modified change_page_attr to take a kernel virtual address instead of a page struct. also introduced restore_page_attr, which releases the cmap_range and assumed a pgprot of type PAGE_KERNEL. tweaked the change_page_attr a little to allow virtual addresses, convert from virtual to physical. if you'd prefer any style changes to what I made, feel free to flame me.

I leave the style wars to others who are more motivated at nitpicking
than me ;-)

actually it doesn't look that bad.

> 
> I also merged the ioremap functions into a single function (which really just means moving change_page_attr into __ioremap) and made ioremap, ioremap_nocache, and ioremap_wrcomb as inline routines that send the appropriate flags into __ioremap.
> 
> fixed an oversight in cmap_convert_flags.
> 
> updated all references to change_page_attr to use the correct arguments, but still need to finish the core function changes for x86_64.
> 
> 
> between finishing this up and making a first pass at the /proc/bus/pci/* changes, I made some "doh!" realizations:
> 
> change_page_attr takes a kernel virtual address currently. this doesn't work well for mmap situations, which have a user virtual address. lookup_address could theoretically be changed to handle this (by switching between kernel & user pgd), but this wouldn't work for 4G/4G kernels.

Yes, change_page_attr is only for the kernel direct mapping, nothing more.

All other mapers (pci, /dev/mem, agp, ioremap_*) must take a cmap 
reference and prevent conflicting maps in the new model. 

> change_page_attr can't take a physical address, since then it couldn't change_page_attr (change the page table attributes).

It can: there is a 1:1 mapping from physical to kernel virtual
address with __va (except highmem, but that's not interesting here because it's
not mapped in the kernel and doesn't need to be changed) 

actually when user space PAT is supported highmem kmap_* may need to take a look
at the PTE or lookup the cmap because it also does a private mapping, but that 
would get quite expensive and kmap is time critical. My gut feeling
would be to just ignore this case for now - it could only happen e.g. when 
someone does write(fd, mmapfromhardware, ...) and that could be 
left undefined. 

> a side effect of having cmap_request_range being part of change_page_attr is that the caller must first setup the page tables for the virtual mapping, then check if the caching is ok. it would seem preferrable to use cmap_request_range to check if the caching is ok, setup the page tables, then modify the page tables via change_page_attr (for kernel pages). 

True. 

> 
> I haven't looked too closely yet, but it would seem like all of this could be encapsulated in remap_page_range and ioremap (ie, driver writers would never call cmap_ routines directly). I'll spend a day or two looking into how well this works.

Yes.

But there should be more low level calls too for the few users who cannot
use these high level functions for some reason.

Quick review: 

set_pat: shouldn't the unknown CPU case error out? 

pageattr: i think it should work with PFNs, otherwise you cannot 
          handle >4GB on i386. while IO mappings are normally <4GB
          this will be needed for memory and in theory some mapping
          could be above 4GB. 

	  i'm not sure what lookup_phys_address is good for. Why don't
  	  you just use __pa ?  Or just pass the physical address ?

+       /* I think this is wrong, i/o region is above highmem? */               
+       if (pfn_valid(pfn) && (pfn_to_page(pfn) >= highmem_start_page))   

	when it doesn't handle cmaps it should just return for any 
	memory >= high_memory

	  +       if ((c_tmp->end + 1) & 0xfff) BUG();                                    
	better use PAGE_MASK instead of hardcoding. 

-Andi

