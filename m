Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946105AbWBDQeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946105AbWBDQeE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 11:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946144AbWBDQeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 11:34:04 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:35900 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1946124AbWBDQeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 11:34:01 -0500
X-IronPort-AV: i="4.02,88,1139212800"; 
   d="scan'208"; a="253543321:sNHT32267870"
Subject: [git patch review 2/2] IB: Don't doublefree pages from scatterlist
From: Roland Dreier <rolandd@cisco.com>
Date: Sat, 04 Feb 2006 16:33:57 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1139070837112-3fe13a3288c20f5c@cisco.com>
In-Reply-To: <1139070837111-02eec52639fd6aed@cisco.com>
X-OriginalArrivalTime: 04 Feb 2006 16:33:58.0240 (UTC) FILETIME=[CC1DFE00:01C629A8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On some architectures, mapping the scatterlist may coalesce entries:
if that coalesced list is then used for freeing the pages afterwards,
there's a danger that pages may be doubly freed (and others leaked).

Fix Infiniband's __ib_umem_release by freeing from a separate array
beyond the scatterlist: IB_UMEM_MAX_PAGE_CHUNK lowered to fit one page.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/core/uverbs_mem.c |   22 ++++++++++++++++------
 include/rdma/ib_verbs.h              |    3 +--
 2 files changed, 17 insertions(+), 8 deletions(-)

46fc99a4a1429f843e3b6df8ed1f571944bef4e2
diff --git a/drivers/infiniband/core/uverbs_mem.c b/drivers/infiniband/core/uverbs_mem.c
index 36a32c3..87a363e 100644
--- a/drivers/infiniband/core/uverbs_mem.c
+++ b/drivers/infiniband/core/uverbs_mem.c
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
+				sg_pages[i]                = page_list[i + off];
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
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 22fc886..239c11d 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -696,8 +696,7 @@ struct ib_udata {
 
 #define IB_UMEM_MAX_PAGE_CHUNK						\
 	((PAGE_SIZE - offsetof(struct ib_umem_chunk, page_list)) /	\
-	 ((void *) &((struct ib_umem_chunk *) 0)->page_list[1] -	\
-	  (void *) &((struct ib_umem_chunk *) 0)->page_list[0]))
+	 (sizeof (struct scatterlist) + sizeof (struct page *)))
 
 struct ib_umem_object {
 	struct ib_uobject	uobject;
-- 
1.1.3
