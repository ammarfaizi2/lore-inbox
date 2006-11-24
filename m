Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935038AbWKXUNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935038AbWKXUNt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 15:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935036AbWKXUNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 15:13:48 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:57790 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S935034AbWKXUNr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 15:13:47 -0500
Date: Fri, 24 Nov 2006 20:13:44 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Hugh Dickins <hugh@veritas.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Christoph Lameter <clameter@sgi.com>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/11] Add __GFP_MOVABLE flag and update callers
In-Reply-To: <Pine.LNX.4.64.0611241924110.17508@blonde.wat.veritas.com>
Message-ID: <Pine.LNX.4.64.0611242004520.3938@skynet.skynet.ie>
References: <20061121225022.11710.72178.sendpatchset@skynet.skynet.ie>
 <20061121225042.11710.15200.sendpatchset@skynet.skynet.ie>
 <Pine.LNX.4.64.0611211529030.32283@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0611212340480.11982@skynet.skynet.ie>
 <Pine.LNX.4.64.0611211637120.3338@woody.osdl.org> <20061123163613.GA25818@skynet.ie>
 <Pine.LNX.4.64.0611230906110.27596@woody.osdl.org> <20061124104422.GA23426@skynet.ie>
 <Pine.LNX.4.64.0611241924110.17508@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2006, Hugh Dickins wrote:

> On Fri, 24 Nov 2006, Mel Gorman wrote:
>>
>> This is what the (compile-tested-only on x86) patch looks like for
>> GFP_HIGH_MOVABLE. The remaining in-tree GFP_HIGHUSER users are infiniband,
>> kvm, ncpfs, nfs, pipes (possible the most frequent user), m68knommu, hugepages
>> and kexec.
>>
>> Signed-off-by: Mel Gorman <mel@csn.ul.ie>
>
> You need to add in something like the patch below (mutatis mutandis
> for whichever approach you end up taking): tmpfs uses highmem pages
> for its swap vector blocks, noting where on swap the data pages are,
> and allocates them with mapping_gfp_mask(inode->i_mapping); but we
> don't have any mechanism in place for reclaiming or migrating those.
>

Good catch. In the page clustering patches I work on, I am doing this;

-       page = alloc_page_vma(gfp | __GFP_ZERO, &pvma, 0);
+       page = alloc_page_vma(
+                       set_migrateflags(gfp | __GFP_ZERO, __GFP_RECLAIMABLE),
+                                                               &pvma, 0);

to get rid of the MOVABLE flag and replace it with __GFP_RECLAIMABLE. This 
clustered the allocations together with allocations like inode cache. In 
retrospect, this was not a good idea because it assumes that tmpfs and 
shmem pages are short-lived. That may not be the case at all.

> (We could add that; but there might be better things to do instead.

Indeed. I believe that making page tables movable would gain more.

> I've often wanted to remove that whole layer from tmpfs, and note
> swap entries in the pagecache's radix-tree slots instead - but that
> does then lock them into low memory.  Hum, haw, never decided.)
>
> You can certainly be forgiven for missing that, and may well wonder
> why it doesn't just use GFP_HIGHUSER explicitly: because the loop
> driver may be on top of that tmpfs file, masking off __GFP_IO and
> __GFP_FS: the swap vector blocks should be allocated with the same
> restrictions as the data pages.
>

Thanks for that clarification. I suspected that something like this was 
the case when I removed the MOVABLE flag and used RECLAIMABLE but I wasn't 
100% certain. In the tests I was running, tmpfs pages weren't a major 
problem so I didn't chase it down.

> Excuse me for moving the __GFP_ZERO too: I think it's tidier to
> do them both within the little helper function.
>

Agreed.

> Hugh
>
> --- 2.6.19-rc5-mm2/mm/shmem.c	2006-11-14 09:58:21.000000000 +0000
> +++ linux/mm/shmem.c	2006-11-24 19:22:30.000000000 +0000
> @@ -94,7 +94,8 @@ static inline struct page *shmem_dir_all
> 	 * BLOCKS_PER_PAGE on indirect pages, assume PAGE_CACHE_SIZE:
> 	 * might be reconsidered if it ever diverges from PAGE_SIZE.
> 	 */
> -	return alloc_pages(gfp_mask, PAGE_CACHE_SHIFT-PAGE_SHIFT);
> +	return alloc_pages((gfp_mask & ~__GFP_MOVABLE) | __GFP_ZERO,
> +				PAGE_CACHE_SHIFT-PAGE_SHIFT);
> }
>
> static inline void shmem_dir_free(struct page *page)
> @@ -372,7 +373,7 @@ static swp_entry_t *shmem_swp_alloc(stru
> 		}
>
> 		spin_unlock(&info->lock);
> -		page = shmem_dir_alloc(mapping_gfp_mask(inode->i_mapping) | __GFP_ZERO);
> +		page = shmem_dir_alloc(mapping_gfp_mask(inode->i_mapping));
> 		if (page)
> 			set_page_private(page, 0);
> 		spin_lock(&info->lock);
>

I'll roll this into the movable patch, run a proper test and post a new 
patch Monday.

Thanks

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
