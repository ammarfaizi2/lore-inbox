Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933049AbWKXT5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933049AbWKXT5i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 14:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933061AbWKXT5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 14:57:38 -0500
Received: from extu-mxob-1.symantec.com ([216.10.194.28]:54666 "EHLO
	extu-mxob-1.symantec.com") by vger.kernel.org with ESMTP
	id S933049AbWKXT5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 14:57:37 -0500
X-AuditID: d80ac21c-a1396bb000001069-0b-45674eb16cb7 
Date: Fri, 24 Nov 2006 19:57:59 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Mel Gorman <mel@skynet.ie>
cc: Linus Torvalds <torvalds@osdl.org>, Christoph Lameter <clameter@sgi.com>,
       linux-mm@kvack.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/11] Add __GFP_MOVABLE flag and update callers
In-Reply-To: <20061124104422.GA23426@skynet.ie>
Message-ID: <Pine.LNX.4.64.0611241924110.17508@blonde.wat.veritas.com>
References: <20061121225022.11710.72178.sendpatchset@skynet.skynet.ie>
 <20061121225042.11710.15200.sendpatchset@skynet.skynet.ie>
 <Pine.LNX.4.64.0611211529030.32283@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0611212340480.11982@skynet.skynet.ie>
 <Pine.LNX.4.64.0611211637120.3338@woody.osdl.org> <20061123163613.GA25818@skynet.ie>
 <Pine.LNX.4.64.0611230906110.27596@woody.osdl.org> <20061124104422.GA23426@skynet.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 24 Nov 2006 19:57:36.0695 (UTC) FILETIME=[C9EB0470:01C71002]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2006, Mel Gorman wrote:
> 
> This is what the (compile-tested-only on x86) patch looks like for
> GFP_HIGH_MOVABLE. The remaining in-tree GFP_HIGHUSER users are infiniband,
> kvm, ncpfs, nfs, pipes (possible the most frequent user), m68knommu, hugepages
> and kexec.
> 
> Signed-off-by: Mel Gorman <mel@csn.ul.ie>

You need to add in something like the patch below (mutatis mutandis
for whichever approach you end up taking): tmpfs uses highmem pages
for its swap vector blocks, noting where on swap the data pages are,
and allocates them with mapping_gfp_mask(inode->i_mapping); but we
don't have any mechanism in place for reclaiming or migrating those.

(We could add that; but there might be better things to do instead.
I've often wanted to remove that whole layer from tmpfs, and note
swap entries in the pagecache's radix-tree slots instead - but that
does then lock them into low memory.  Hum, haw, never decided.)

You can certainly be forgiven for missing that, and may well wonder
why it doesn't just use GFP_HIGHUSER explicitly: because the loop
driver may be on top of that tmpfs file, masking off __GFP_IO and
__GFP_FS: the swap vector blocks should be allocated with the same
restrictions as the data pages.

Excuse me for moving the __GFP_ZERO too: I think it's tidier to
do them both within the little helper function.

Hugh

--- 2.6.19-rc5-mm2/mm/shmem.c	2006-11-14 09:58:21.000000000 +0000
+++ linux/mm/shmem.c	2006-11-24 19:22:30.000000000 +0000
@@ -94,7 +94,8 @@ static inline struct page *shmem_dir_all
 	 * BLOCKS_PER_PAGE on indirect pages, assume PAGE_CACHE_SIZE:
 	 * might be reconsidered if it ever diverges from PAGE_SIZE.
 	 */
-	return alloc_pages(gfp_mask, PAGE_CACHE_SHIFT-PAGE_SHIFT);
+	return alloc_pages((gfp_mask & ~__GFP_MOVABLE) | __GFP_ZERO,
+				PAGE_CACHE_SHIFT-PAGE_SHIFT);
 }
 
 static inline void shmem_dir_free(struct page *page)
@@ -372,7 +373,7 @@ static swp_entry_t *shmem_swp_alloc(stru
 		}
 
 		spin_unlock(&info->lock);
-		page = shmem_dir_alloc(mapping_gfp_mask(inode->i_mapping) | __GFP_ZERO);
+		page = shmem_dir_alloc(mapping_gfp_mask(inode->i_mapping));
 		if (page)
 			set_page_private(page, 0);
 		spin_lock(&info->lock);
