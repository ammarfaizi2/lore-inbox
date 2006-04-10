Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbWDJNuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWDJNuM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 09:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbWDJNuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 09:50:12 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:27524 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751157AbWDJNuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 09:50:10 -0400
Date: Mon, 10 Apr 2006 16:50:08 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] slab: page mapping cleanup
Message-ID: <Pine.LNX.4.58.0604101648560.13507@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Enberg <penberg@cs.helsinki.fi>

This patch cleans up slab allocator page mapping a bit. The memory allocated
for a slab is physically contiguous so it is okay to assume struct pages are
too so kill the long-standing comment. Furthermore, rename set_slab_attr to
slab_map_pages and add a comment explaining why its needed.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>

---

 mm/slab.c |   27 ++++++++++++++++-----------
 1 files changed, 16 insertions(+), 11 deletions(-)

90c3fdd782a0578e6d60bc915af43b01488a2c64
diff --git a/mm/slab.c b/mm/slab.c
index f055c14..ad60d68 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2436,23 +2436,28 @@ static void slab_put_obj(struct kmem_cac
 	slabp->inuse--;
 }
 
-static void set_slab_attr(struct kmem_cache *cachep, struct slab *slabp,
-			void *objp)
+/*
+ * Map pages beginning at addr to the given cache and slab. This is required
+ * for the slab allocator to be able to lookup the cache and slab of a
+ * virtual address for kfree, ksize, kmem_ptr_validate, and slab debugging.
+ */
+static void slab_map_pages(struct kmem_cache *cache, struct slab *slab,
+			   void *addr)
 {
-	int i;
+	int nr_pages;
 	struct page *page;
 
-	/* Nasty!!!!!! I hope this is OK. */
-	page = virt_to_page(objp);
+	page = virt_to_page(addr);
 
-	i = 1;
+	nr_pages = 1;
 	if (likely(!PageCompound(page)))
-		i <<= cachep->gfporder;
+		nr_pages <<= cache->gfporder;
+
 	do {
-		page_set_cache(page, cachep);
-		page_set_slab(page, slabp);
+		page_set_cache(page, cache);
+		page_set_slab(page, slab);
 		page++;
-	} while (--i);
+	} while (--nr_pages);
 }
 
 /*
@@ -2524,7 +2529,7 @@ static int cache_grow(struct kmem_cache 
 		goto opps1;
 
 	slabp->nodeid = nodeid;
-	set_slab_attr(cachep, slabp, objp);
+	slab_map_pages(cachep, slabp, objp);
 
 	cache_init_objs(cachep, slabp, ctor_flags);
 
-- 
1.2.5

