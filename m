Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752422AbWCPRI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752422AbWCPRI2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 12:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752425AbWCPRI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 12:08:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:14045 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752421AbWCPRI1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 12:08:27 -0500
Date: Thu, 16 Mar 2006 09:08:08 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Bryan O'Sullivan" <bos@pathscale.com>
cc: Roland Dreier <rdreier@cisco.com>, Andrew Morton <akpm@osdl.org>,
       Hugh@veritas.com, hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core
 driver
In-Reply-To: <1142521943.25297.42.camel@camp4.serpentine.com>
Message-ID: <Pine.LNX.4.64.0603160849490.3618@g5.osdl.org>
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain> 
 <ada4q27fban.fsf@cisco.com>  <1141948516.10693.55.camel@serpentine.pathscale.com>
  <ada1wxbdv7a.fsf@cisco.com>  <1141949262.10693.69.camel@serpentine.pathscale.com>
  <20060309163740.0b589ea4.akpm@osdl.org>  <1142470579.6994.78.camel@localhost.localdomain>
  <ada3bhjuph2.fsf@cisco.com>  <1142475069.6994.114.camel@localhost.localdomain>
  <adaslpjt8rg.fsf@cisco.com>  <1142477579.6994.124.camel@localhost.localdomain>
  <20060315192813.71a5d31a.akpm@osdl.org>  <1142485103.25297.13.camel@camp4.serpentine.com>
  <20060315213813.747b5967.akpm@osdl.org>  <ada8xrbszmx.fsf@cisco.com>
 <1142521943.25297.42.camel@camp4.serpentine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 16 Mar 2006, Bryan O'Sullivan wrote:
> 
> This is precisely our case, btw.  The pages in question are allocated
> during fops->open (some during dev->probe).  mmap and nopage never
> allocate anything.

If the mapping isn't actually dynamic, then you really should use either:

 - remap_pfn_range() (for when you have a physically consecutive page 
   mapping)
 - vm_insert_page() (for when you have individual pages).

at mmap time. Either of those will then do the right thing at unmap.

The rules are:

 - remap_pfn_range() doesn't muck around with "struct page" AT ALL, so you 
   can pass it damn well anything you want these days. It doesn't care, 
   the VM doesn't care, there's no ref-counting or page flag checking 
   either on the mmap or the munmap parh.

   So with remap_pfn_range(), you can literally do just

	remap_pfn_range(vma,
		vma->vm_start, 
		device->phys_dma_address >> PAGE_SHIFT,
		device->phys_dma_size,
		vma->vm_page_prot);

   and the VM will not care what that DMA region is (it might, for 
   example, be actual device memory, not real RAM at all). But this should 
   only be used on memory that will be guaranteed to be around for as long 
   as the mapping exists (which you can guarantee by doing refcounting of 
   your own "struct file"s, of course).

   Normally, you'd use remap_pfn_range() only for special allocations. 
   Most commonly, it's not RAM at all, but the PCI MMIO memory window to 
   the hardware itself.

 - vm_insert_page() wants _individual_ pages that have been allocated as 
   such by the page allocator. You can't pass it a kmalloc'ed area or 
   anything like that, but you _can_ pass it anything that works with the 
   page allocator. It will increment the page count appropriately for the 
   mapping, so you should think of it as a no-op: you can do

	...
	page = get_free_page(..);
	if (!page)
		return -ENOMEM;
	vm_insert_page(mm, addr, page, prot);
	...

	.. and then in your close/module_exit routine ..
	free_page(page);

   ie you should do the freeing of _your_ references (you got one when you 
   allocated the page, so you should free it), and the VM layer will track 
   _its_ references (ie vm_insert_page() will do whatever is correct so 
   that when the VM gets unmapped, the page really gets freed)

   As a special case (it's not actually a special case in the VM, but as 
   far as _usage_ is concerned, it's different from the "allocate 
   individual pages" case), if you allocate a single large _compound_ page 
   with __GFP_COMP, you can then use vm_insert_page() to insert the 
   sub-pages individually in the mapping. IOW, you can do

	/* Get a compound page of order 4 (16 pages) */
	bigpage = __get_free_pages(GFP_USER | __GFP_COMP, 4);
	for (i = 0; i < 15; i++)
		vm_insert_page(mm, addr + (i << PAGE_SHIFT), bigpage + i, prot);


	.. in close/module-exit ..
	free_page(bigpage);

Hope this clarifies.

		Linus
