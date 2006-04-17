Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751370AbWDQWt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbWDQWt4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 18:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbWDQWt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 18:49:56 -0400
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:30123 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751370AbWDQWt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 18:49:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=50LCR4lRzf9hNXh1zcQiZpOLtGD+JDGQhR51LNQ0Cm6K/BWGif4F1RkJ6waKYWVXYh1nUvh9YvpCzEkpxxjrZI1+bJ1uDs3hXTpq5Kl76cX4pnDgapdq/SIVE2OkHplTODGJOGESEEMAmVtdu3vwyKl8XfsfDalfLxg1RwMtvWI=  ;
Message-ID: <4443DC09.20606@yahoo.com.au>
Date: Tue, 18 Apr 2006 04:18:49 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Brian D. McGrew" <brian@visionpro.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: PCI Device Driver / remap_pfn_range()
References: <14CFC56C96D8554AA0B8969DB825FEA0012B2F38@chicken.machinevisionproducts.com>
In-Reply-To: <14CFC56C96D8554AA0B8969DB825FEA0012B2F38@chicken.machinevisionproducts.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian D. McGrew wrote:
> A few weeks back I posted a cry for help with a PCI device driver which
> maps hardware memory into user/kernel space using what used to be called
> remap_page_range in the 2.6.9 kernel and now I'm trying to use
> remap_pfn_range.
> 
> I'm still struggling with this and I'm hoping that there is an expert
> out there who can point out what I'm doing wrong!!!  My source code is
> attached and I know I'm probably not doing this in the best way; but
> it's the only way I don't know how, since I'm tasked with a job where I
> have no idea what I'm doing!
> 
> When I try and access my device, which should be /dev/ibb[0-3], I get a
> segmentation fault then a core dump and within a few seconds after that,
> the system becomes way unstable and has to be rebooted (if it doesn't
> lock up hard first).
> 

Well, posting source code is a good first step.

What kernel are you attempting to port this to? 2.6.16 / head, I presume?

> static void
> free_ibb_usr_shared(IbbSoftDev *ibb_sp)
> {
>     struct page *page;
> 
>     u_long virt_addr;
>     u_long ushared_addr = (u_long)ibb_sp->ushared;
> 
>     for (virt_addr = ushared_addr; 
> 	    virt_addr < ushared_addr + PAGE_ALIGN(IBB_SHARED_SIZE);
> 	    virt_addr += PAGE_SIZE)
>     {
>     	page = virt_to_page(virt_addr);
> 	ClearPageReserved(page);

PageReserved is deprecated, however it makes sense to leave these in
for the moment so you get a little more sanity checking and easier
backwards compatibility.

> 
> 	atomic_set(&page->_count, 1);

You should never access _count directly. There should be no reason to
do this (except for introducing use-after-free), so just delete it.

> 	vfree((void *)virt_addr);
>     }
> 
>     if (ibb_sp->ushared)
> 	ibb_sp->ushared = NULL;
> }
> 
> static int
> alloc_ibb_usr_shared(IbbSoftDev *ibb_sp)
> {
>     u_long virt_addr;
>     u_long ushared_addr;
>     int order = 0;
> 
>     /* 
>      * From Linux Device Drivers - memory that is going to
>      * be mmaped must be PAGE_SIZE grained.  Since we do mmap
>      * ushared to user space, we need to allocated it in
>      * PAGE_SIZE chunks.
>      */
> 
>     int size = PAGE_ALIGN(IBB_SHARED_SIZE);
> 
>     dcmn_err(1, ("<1>" "ibb::size is %d\n", size));
>     dcmn_err(1, ("<1>" "ibb::order is %d\n", order));
> 
>     do {
> 	dcmn_err(1, ("<1>" "ibb::size is %d\n", size));
> 	dcmn_err(1, ("<1>" "ibb::order is %d\n", order));
> 
>     	order++;
>     } while (size > (PAGE_SIZE * (1 << order)));
> 
> //  ibb_sp->ushared = (IbbUserShared *) __get_free_pages(GFP_KERNEL,
> order);
>     ibb_sp->ushared = (IbbUserShared *) vmalloc(4096 * 1024);

Shouldn't this be vmalloc(size)?

> static void
> free_ibb_image_table_mem(IbbSoftDev *ibb_sp)
> {
>     uint32_t *virt_addr;
>     struct page *page;
> 
>     dcmn_err(1, ("<1>" "free_ibb_image_table_mem(%d): Free size %d.\n",
> 	ibb_sp->dev_num,ibb_sp->image_table_size));
> 
>     /* unreserve all pages */
>     for( virt_addr = ibb_sp->image_table; 
> 	   virt_addr < ibb_sp->image_table + ibb_sp->image_table_size;
> 	   virt_addr += PAGE_SIZE)
>     {
>     	page = virt_to_page(virt_addr);
> 	ClearPageReserved(page);
> 
> 	atomic_set(&page->_count, 1);

ditto
> 
> //  ibb_sp->image_table = (uint32_t *) __get_free_pages(GFP_KERNEL,
> order);
>     ibb_sp->ushared = (IbbUserShared *) vmalloc(4096 * 1024);

shouldn't this be ->image_table? and vmalloc(size)?

[...]

> 	if (ibb_sp->image_table != NULL && vsize <=
> ibb_sp->image_table_size) {
> 	    const u_long start = vma->vm_start;
> 	    const u_long size = (vma->vm_end - vma->vm_start);
> 	    const u_long page = (void *)ibb_sp->image_table;
> 
> 	    if (io_remap_pfn_range(vma, start, page, size,
> vma->vm_page_prot)) {

I'm pretty sure you can't remap_pfn_range vmalloced memory because
it doesn't use contiguous page frames.

You'd be better off going through the pages one by one and running
vm_insert_page on each (or remap_pfn_range on each pageframe, if you
need to be compatible with kernels before 2.6.16).

Also, don't use io_remap on vmalloc memory, just remap.

> 		dcmn_err(1, ("<1>" "ibb_mmap(%d): image table remap
> failed\n",
> 		    ibb_sp->dev_num));
> 
> 		return(-EAGAIN);
> 	    }
> 	}
> 
> 	else {
> 	    dcmn_err(1, ("<1>" 
> 		"ibb_mmap(%d): image table params failed vs %d is %d\n",
> 		ibb_sp->dev_num, (int)vsize,
> (int)ibb_sp->image_table_size));
> 
> 	    return(-EAGAIN);
> 	}
>     }
>     else if (offset == IBB_SHARED_ADDR) {
> 	if (ibb_sp->ushared != NULL && vsize <=
> PAGE_ALIGN(IBB_SHARED_SIZE)) {
> 	    const u_long start = vma->vm_start;
> 	    const u_long size = (vma->vm_end - vma->vm_start);
> 	    const u_long page = (void *)ibb_sp->ushared;
> 
> 	    if (io_remap_pfn_range(vma, start, page, size,
> vma->vm_page_prot)) {

ditto

> 		dcmn_err(1, ("<1>" "ibb_mmap(%d): ushared remap
> failed\n",
> 		    ibb_sp->dev_num));
> 
> 		return(-EAGAIN);
> 	    }
> 
> 	    dcmn_err(1, ("<1>" "ibb_mmap(%d): \
> 		ushared remap: ibb_sp->ushared: %lx vma->vm_start:
> %lx\n",
> 		ibb_sp->dev_num,
> 		(u_long)ibb_sp->ushared,
> 		(u_long)vma->vm_start) );
> 	}
> 	else {
> 	    dcmn_err(1, ("<1>" "ibb_mmap(%d): ushared mmap failed\n",
> 		ibb_sp->dev_num));
> 
> 	    return(-EAGAIN);
> 	}
>     }
> 
>     /* 
>      * vsize is PAGE_SIZE at minimum.  For registers and other
>      * small memory areas we need to check for VSIZE.  For large
>      * chunks, vsize should equal the chunk size 
>      */
> 
>     else if (offset == IBB_CONTROL_OFF && vsize == PAGE_SIZE) {
> 	const u_long start = vma->vm_start;
> 	const u_long size = (vma->vm_end - vma->vm_start);
> 	const u_long page = ibb_sp->creg_phys;
> 
> 	if (remap_pfn_range(vma, start, page, size, vma->vm_page_prot))

If creg_phys is io memory, that's when you'd use io_remap, I think.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
