Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265776AbUBCV11 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 16:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265899AbUBCV10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 16:27:26 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:14515 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265776AbUBCV1W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 16:27:22 -0500
Subject: Re: Active Memory Defragmentation: Our implementation & problems
From: Dave Hansen <haveblue@us.ibm.com>
To: Alok Mooley <rangdi@yahoo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
In-Reply-To: <20040203044651.47686.qmail@web9705.mail.yahoo.com>
References: <20040203044651.47686.qmail@web9705.mail.yahoo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1075843615.28252.17.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 03 Feb 2004 13:26:55 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Your patch looks whitespace-munged.  You might want to check your
mailer.  Also, you should probably take a look at
Documentation/CodingStyle.  There are quite a few deviations here from
regular kernel coding standards.  You should also make an effort to
integrate these functions into the appropriate places.  For instance,
the pte functions need to go into things like pgtable.h and the buddy
allocator functions need to end up in mm/page_alloc.c.  Then you can
post your work as a patch, which is how we usually do it.


On Mon, 2004-02-02 at 20:46, Alok Mooley wrote:
> 	/*
> 	 * See that page is not file backed & flags are as desired.
> 	 * PG_lru , PG_direct (currently) must be set
> 	 */
> 	if(!page->mapping && (flags==0x10020 || flags==0x10024 || 
> flags==0x10060 || 
> flags==0x10064) && page_count(page))
> 		return 1;
> 	/*Page is not movable*/
> 	return 0;

Why are these flags hard-coded?  

> static void update_to_ptes(struct page *to)
> ...
>         pgprot.pgprot = (pte->pte_low) & (PAGE_SIZE-1);

You probably want to wrap this up in a macro for each arch.  I couldn't
find an analagous one that exists.  

> static void free_allocated_page(struct page *page)
> {
> 	unsigned long page_idx,index,mask,order = 0;
> 	struct zone *zone = page_zone(page);
> 	struct page *base = zone->zone_mem_map;
> 	struct free_area *area = zone->free_area;
> 	mask = ~0;
> 
> 	page_idx = page - base;
> 
> 	/*
> 	 * The bitmap offset is given by index
> 	 */
> 	index = page_idx >> (1 + order);
> 	cnt_order = 0;
> 
> 	while (mask + (1 << (MAX_ORDER-1))) {
> 
> 		struct page *buddy1, *buddy2;
> 		if (!__test_and_change_bit(index, area->map)) {						/*
> 			 * the buddy page is still allocated.
> 			 */
> 			break;
> 		}
> 
> 		/*
> 		 * Move the buddy up one level.
> 		 * This code is taking advantage of the identity:
> 		 * 	-mask = 1+~mask
> 		 */
> 		cnt_order++;
> 		buddy1 = base + (page_idx ^ -mask);
> 		buddy2 = base + page_idx;
> 		list_del(&buddy1->list);
> 		/* Mask for the immediate upper order*/
> 		mask <<= 1;
> 		area++;
> 		/*Bit offset at level n is offset at level (n-1) >> 1 */
> 		index >>= 1;
> 		page_idx &= mask;
> 	}
> 	list_add(&(base + page_idx)->list, &area->free_list);
> }

Is this really necessary?  Why don't the regular buddy allocator
functions work?

> /*
> * Flush the cache and tlb entries corresponding to the pte for the
> * 'from' page
> * Flush the tlb entries corresponding to the given page and not the 
> whole
> * tlb.
> */
> static void flush_from_caches(pte_addr_t paddr)
> {

How does this function compare to try_to_unmap_one()?  Can you use that
instead?  It looked like you cut and pasted some code from there.

I'll stop there for now.  There seems to be a lot of code in the file
that's one-off from current kernel code.  I think a close examination of
currently available kernel functions could drasticly reduce the size of
your module.  

--dave

