Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422887AbWBCTuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422887AbWBCTuk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 14:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422888AbWBCTuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 14:50:40 -0500
Received: from silver.veritas.com ([143.127.12.111]:21842 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1422887AbWBCTuj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 14:50:39 -0500
Date: Fri, 3 Feb 2006 19:51:18 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Roland Dreier <rdreier@cisco.com>
cc: Andrew Morton <akpm@osdl.org>, "Michael S. Tsirkin" <mst@mellanox.co.il>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] ib: don't doublefree pages from scatterlist
In-Reply-To: <Pine.LNX.4.61.0602031842290.14065@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0602031948100.14829@goblin.wat.veritas.com>
References: <Pine.LNX.4.63.0512271807130.4955@kai.makisara.local>
 <20060104172727.GA320@tau.solarneutrino.net> <Pine.LNX.4.63.0601042334310.5087@kai.makisara.local>
 <20060105201249.GB1795@tau.solarneutrino.net> <Pine.LNX.4.64.0601051312380.3169@g5.osdl.org>
 <20060109033149.GC283@tau.solarneutrino.net> <Pine.LNX.4.64.0601082000450.3169@g5.osdl.org>
 <Pine.LNX.4.61.0601090933160.7632@goblin.wat.veritas.com>
 <20060109185350.GG283@tau.solarneutrino.net> <Pine.LNX.4.61.0601091922550.15426@goblin.wat.veritas.com>
 <20060118001252.GB821@tau.solarneutrino.net> <Pine.LNX.4.61.0601181556050.9110@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0602031842290.14065@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 03 Feb 2006 19:50:38.0651 (UTC) FILETIME=[1B4C10B0:01C628FB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On some architectures, mapping the scatterlist may coalesce entries:
if that coalesced list is then used for freeing the pages afterwards,
there's a danger that pages may be doubly freed (and others leaked).

Fix Infiniband's __ib_umem_release by freeing from a separate array
beyond the scatterlist: IB_UMEM_MAX_PAGE_CHUNK lowered to fit one page.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---
Warning: untested!  And please double-check the adjusted definition of
IB_UMEM_MAX_PAGE_CHUNK - the old definition was avoiding "sizeof"s, but
I don't understand why.

 drivers/infiniband/core/uverbs_mem.c |   22 ++++++++++++++++------
 include/rdma/ib_verbs.h              |    3 +--
 2 files changed, 17 insertions(+), 8 deletions(-)

--- 2.6.16-rc2/drivers/infiniband/core/uverbs_mem.c	2005-10-28 01:02:08.000000000 +0100
+++ linux/drivers/infiniband/core/uverbs_mem.c	2006-02-03 09:59:37.000000000 +0000
@@ -49,15 +49,18 @@ struct ib_umem_account_work {
 static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem, int dirty)
 {
 	struct ib_umem_chunk *chunk, *tmp;
+	struct page **sg_pages;
 	int i;
 
 	list_for_each_entry_safe(chunk, tmp, &umem->chunk_list, list) {
 		dma_unmap_sg(dev->dma_device, chunk->page_list,
 			     chunk->nents, DMA_BIDIRECTIONAL);
+		/* Scatterlist may have been coalesced: free saved pagelist */
+		sg_pages = (struct page **) (chunk->page_list + chunk->nents);
 		for (i = 0; i < chunk->nents; ++i) {
 			if (umem->writable && dirty)
-				set_page_dirty_lock(chunk->page_list[i].page);
-			put_page(chunk->page_list[i].page);
+				set_page_dirty_lock(sg_pages[i]);
+			put_page(sg_pages[i]);
 		}
 
 		kfree(chunk);
@@ -69,11 +72,13 @@ int ib_umem_get(struct ib_device *dev, s
 {
 	struct page **page_list;
 	struct ib_umem_chunk *chunk;
+	struct page **sg_pages;
 	unsigned long locked;
 	unsigned long lock_limit;
 	unsigned long cur_base;
 	unsigned long npages;
 	int ret = 0;
+	int nents;
 	int off;
 	int i;
 
@@ -121,16 +126,21 @@ int ib_umem_get(struct ib_device *dev, s
 		off = 0;
 
 		while (ret) {
-			chunk = kmalloc(sizeof *chunk + sizeof (struct scatterlist) *
-					min_t(int, ret, IB_UMEM_MAX_PAGE_CHUNK),
+			nents = min_t(int, ret, IB_UMEM_MAX_PAGE_CHUNK);
+			chunk = kmalloc(sizeof *chunk +
+					sizeof (struct scatterlist) * nents +
+					sizeof (struct page *) * nents,
 					GFP_KERNEL);
 			if (!chunk) {
 				ret = -ENOMEM;
 				goto out;
 			}
+			/* Save pages to be freed in array beyond scatterlist */
+			sg_pages = (struct page **) (chunk->page_list + nents);
 
-			chunk->nents = min_t(int, ret, IB_UMEM_MAX_PAGE_CHUNK);
+			chunk->nents = nents;
 			for (i = 0; i < chunk->nents; ++i) {
+				sg_pages[i] =
 				chunk->page_list[i].page   = page_list[i + off];
 				chunk->page_list[i].offset = 0;
 				chunk->page_list[i].length = PAGE_SIZE;
@@ -142,7 +152,7 @@ int ib_umem_get(struct ib_device *dev, s
 						 DMA_BIDIRECTIONAL);
 			if (chunk->nmap <= 0) {
 				for (i = 0; i < chunk->nents; ++i)
-					put_page(chunk->page_list[i].page);
+					put_page(sg_pages[i]);
 				kfree(chunk);
 
 				ret = -ENOMEM;
--- 2.6.16-rc2/include/rdma/ib_verbs.h	2006-02-03 09:32:50.000000000 +0000
+++ linux/include/rdma/ib_verbs.h	2006-02-03 09:59:37.000000000 +0000
@@ -696,8 +696,7 @@ struct ib_udata {
 
 #define IB_UMEM_MAX_PAGE_CHUNK						\
 	((PAGE_SIZE - offsetof(struct ib_umem_chunk, page_list)) /	\
-	 ((void *) &((struct ib_umem_chunk *) 0)->page_list[1] -	\
-	  (void *) &((struct ib_umem_chunk *) 0)->page_list[0]))
+	 (sizeof(struct scatterlist) + sizeof(struct page *)))
 
 struct ib_umem_object {
 	struct ib_uobject	uobject;
