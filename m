Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbWACU0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbWACU0G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 15:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbWACU0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 15:26:05 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:38311 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S964786AbWACU0A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 15:26:00 -0500
Subject: [patch 8/9] slab: extract virt_to_{cache|slab}
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com,
       colpatch@us.ibm.com, rostedt@goodmis.org, clameter@sgi.com,
       penberg@cs.helsinki.fi
Date: Tue, 03 Jan 2006 22:25:58 +0200
Message-Id: <1136319959.8629.23.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Enberg <penberg@cs.helsinki.fi>

This patch introduces virt_to_cache() and virt_to_slab() functions
to reduce duplicate code and introduce a proper abstraction should
we want to support other kind of mapping for address to slab and
cache (eg. for vmalloc() or I/O memory).

Acked-by: Manfred Spraul <manfred@colorfullife.com>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 mm/slab.c |   22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

Index: 2.6/mm/slab.c
===================================================================
--- 2.6.orig/mm/slab.c
+++ 2.6/mm/slab.c
@@ -594,6 +594,18 @@ static inline struct slab *page_get_slab
 	return (struct slab *)page->lru.prev;
 }
 
+static inline struct kmem_cache *virt_to_cache(const void *obj)
+{
+	struct page *page = virt_to_page(obj);
+	return page_get_cache(page);
+}
+
+static inline struct slab *virt_to_slab(const void *obj)
+{
+	struct page *page = virt_to_page(obj);
+	return page_get_slab(page);
+}
+
 /* These are the default caches for kmalloc. Custom caches can have other sizes. */
 struct cache_sizes malloc_sizes[] = {
 #define CACHE(x) { .cs_size = (x) },
@@ -1423,7 +1435,7 @@ static void check_poison_obj(kmem_cache_
 		/* Print some data about the neighboring objects, if they
 		 * exist:
 		 */
-		struct slab *slabp = page_get_slab(virt_to_page(objp));
+		struct slab *slabp = virt_to_slab(objp);
 		int objnr;
 
 		objnr = (objp-slabp->s_mem)/cachep->buffer_size;
@@ -2712,7 +2724,7 @@ static void free_block(kmem_cache_t *cac
 		void *objp = objpp[i];
 		struct slab *slabp;
 
-		slabp = page_get_slab(virt_to_page(objp));
+		slabp = virt_to_slab(objp);
 		l3 = cachep->nodelists[node];
 		list_del(&slabp->list);
 		check_spinlock_acquired_node(cachep, node);
@@ -2814,7 +2826,7 @@ static inline void __cache_free(kmem_cac
 #ifdef CONFIG_NUMA
 	{
 		struct slab *slabp;
-		slabp = page_get_slab(virt_to_page(objp));
+		slabp = virt_to_slab(objp);
 		if (unlikely(slabp->nodeid != numa_node_id())) {
 			struct array_cache *alien = NULL;
 			int nodeid = slabp->nodeid;
@@ -3089,7 +3101,7 @@ void kfree(const void *objp)
 		return;
 	local_irq_save(flags);
 	kfree_debugcheck(objp);
-	c = page_get_cache(virt_to_page(objp));
+	c = virt_to_cache(objp);
 	__cache_free(c, (void*)objp);
 	local_irq_restore(flags);
 }
@@ -3659,7 +3671,7 @@ unsigned int ksize(const void *objp)
 	if (unlikely(objp == NULL))
 		return 0;
 
-	return obj_size(page_get_cache(virt_to_page(objp)));
+	return obj_size(virt_to_cache(objp));
 }
 


--


