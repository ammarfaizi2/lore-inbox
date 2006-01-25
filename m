Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbWAYXvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbWAYXvj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 18:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWAYXvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 18:51:38 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:16594 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751240AbWAYXvh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 18:51:37 -0500
Subject: [patch 3/9] mempool - Make mempools NUMA aware
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: linux-kernel@vger.kernel.org
Cc: sri@us.ibm.com, andrea@suse.de, pavel@suse.cz, linux-mm@kvack.org
References: <20060125161321.647368000@localhost.localdomain>
Content-Type: text/plain
Organization: IBM LTC
Date: Wed, 25 Jan 2006 15:51:33 -0800
Message-Id: <1138233093.27293.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment (critical_mempools)
Add NUMA-awareness to the mempool code.  This involves several changes:

1) Update mempool_alloc_t to include a node_id argument.
2) Change mempool_create_node() to pass its node_id argument on to the updated
   pool->alloc() function in an attempt to allocate the memory pool elements on
   the requested node.
3) Change mempool_create() to be a static inline calling mempool_create_node().
4) Add mempool_resize_node() to the mempool API.  This function does the same
   thing as the old mempool_resize() function, but attempts to allocate both
   the internal storage array and the individual memory pool elements on the
   specified node, just like mempool_create_node() does.
5) Change mempool_resize() to be a static inline calling mempool_resize_node().
6) Add mempool_alloc_node() to the mempool API.  This function allows callers
   to request memory from a particular node.  This request is only guaranteed
   to fulfilled with memory from the specified node if the mempool was
   originally created with mempool_create_node().  If not, this is only a hint
   to the allocator, and the request may actually be fulfilled by memory from
   another node, because we don't know from which node the memory pool elements
   were allocated.
7) Change mempool_alloc() to be a static inline calling mempool_alloc_node().
8) Update the two "builtin" mempool allocators. mempool_alloc_slab &
   mempool_alloc_pages, to use the new mempool_alloc_t by adding a nid argument
   and changing them to call kmem_cache_alloc_node() & alloc_pages_node(),
   respectively.
9) Cleanup some minor whitespace and comments.

Signed-off-by: Matthew Dobson <colpatch@us.ibm.com>

 include/linux/mempool.h |   31 ++++++++++++++++++-------
 mm/mempool.c            |   58 ++++++++++++++++++++++++++----------------------
 2 files changed, 54 insertions(+), 35 deletions(-)

Index: linux-2.6.16-rc1+critical_mempools/mm/mempool.c
===================================================================
--- linux-2.6.16-rc1+critical_mempools.orig/mm/mempool.c
+++ linux-2.6.16-rc1+critical_mempools/mm/mempool.c
@@ -38,12 +38,14 @@ static void free_pool(mempool_t *pool)
 }
 
 /**
- * mempool_create - create a memory pool
+ * mempool_create_node - create a memory pool
  * @min_nr:    the minimum number of elements guaranteed to be
  *             allocated for this pool.
  * @alloc_fn:  user-defined element-allocation function.
  * @free_fn:   user-defined element-freeing function.
  * @pool_data: optional private data available to the user-defined functions.
+ * @node_id:   node to allocate this memory pool's control structure, storage
+ *             array and all of its reserved elements on.
  *
  * this function creates and allocates a guaranteed size, preallocated
  * memory pool. The pool can be used from the mempool_alloc and mempool_free
@@ -51,15 +53,9 @@ static void free_pool(mempool_t *pool)
  * functions might sleep - as long as the mempool_alloc function is not called
  * from IRQ contexts.
  */
-mempool_t *mempool_create(int min_nr, mempool_alloc_t *alloc_fn,
-				mempool_free_t *free_fn, void *pool_data)
-{
-	return  mempool_create_node(min_nr,alloc_fn,free_fn, pool_data,-1);
-}
-EXPORT_SYMBOL(mempool_create);
-
 mempool_t *mempool_create_node(int min_nr, mempool_alloc_t *alloc_fn,
-			mempool_free_t *free_fn, void *pool_data, int node_id)
+			       mempool_free_t *free_fn, void *pool_data,
+			       int node_id)
 {
 	mempool_t *pool;
 	pool = kmalloc_node(sizeof(*pool), GFP_KERNEL, node_id);
@@ -85,7 +81,7 @@ mempool_t *mempool_create_node(int min_n
 	while (pool->curr_nr < pool->min_nr) {
 		void *element;
 
-		element = pool->alloc(GFP_KERNEL, pool->pool_data);
+		element = pool->alloc(GFP_KERNEL, node_id, pool->pool_data);
 		if (unlikely(!element)) {
 			free_pool(pool);
 			return NULL;
@@ -97,12 +93,14 @@ mempool_t *mempool_create_node(int min_n
 EXPORT_SYMBOL(mempool_create_node);
 
 /**
- * mempool_resize - resize an existing memory pool
+ * mempool_resize_node - resize an existing memory pool
  * @pool:       pointer to the memory pool which was allocated via
  *              mempool_create().
  * @new_min_nr: the new minimum number of elements guaranteed to be
  *              allocated for this pool.
  * @gfp_mask:   the usual allocation bitmask.
+ * @node_id:    node to allocate this memory pool's new storage array
+ *              and all of its reserved elements on.
  *
  * This function shrinks/grows the pool. In the case of growing,
  * it cannot be guaranteed that the pool will be grown to the new
@@ -112,7 +110,8 @@ EXPORT_SYMBOL(mempool_create_node);
  * while this function is running. mempool_alloc() & mempool_free()
  * might be called (eg. from IRQ contexts) while this function executes.
  */
-int mempool_resize(mempool_t *pool, int new_min_nr, gfp_t gfp_mask)
+int mempool_resize_node(mempool_t *pool, int new_min_nr, gfp_t gfp_mask,
+			int node_id)
 {
 	void *element;
 	void **new_elements;
@@ -134,7 +133,8 @@ int mempool_resize(mempool_t *pool, int 
 	spin_unlock_irqrestore(&pool->lock, flags);
 
 	/* Grow the pool */
-	new_elements = kmalloc(new_min_nr * sizeof(*new_elements), gfp_mask);
+	new_elements = kmalloc_node(new_min_nr * sizeof(*new_elements),
+				    gfp_mask, node_id);
 	if (!new_elements)
 		return -ENOMEM;
 
@@ -153,7 +153,7 @@ int mempool_resize(mempool_t *pool, int 
 
 	while (pool->curr_nr < pool->min_nr) {
 		spin_unlock_irqrestore(&pool->lock, flags);
-		element = pool->alloc(gfp_mask, pool->pool_data);
+		element = pool->alloc(gfp_mask, node_id, pool->pool_data);
 		if (!element)
 			goto out;
 		spin_lock_irqsave(&pool->lock, flags);
@@ -170,14 +170,14 @@ out_unlock:
 out:
 	return 0;
 }
-EXPORT_SYMBOL(mempool_resize);
+EXPORT_SYMBOL(mempool_resize_node);
 
 /**
  * mempool_destroy - deallocate a memory pool
  * @pool:      pointer to the memory pool which was allocated via
  *             mempool_create().
  *
- * this function only sleeps if the free_fn() function sleeps. The caller
+ * this function only sleeps if the ->free() function sleeps. The caller
  * has to guarantee that all elements have been returned to the pool (ie:
  * freed) prior to calling mempool_destroy().
  */
@@ -190,17 +190,22 @@ void mempool_destroy(mempool_t *pool)
 EXPORT_SYMBOL(mempool_destroy);
 
 /**
- * mempool_alloc - allocate an element from a specific memory pool
+ * mempool_alloc_node - allocate an element from a specific memory pool
  * @pool:      pointer to the memory pool which was allocated via
  *             mempool_create().
  * @gfp_mask:  the usual allocation bitmask.
+ * @node_id:   node to _attempt_ to allocate from.  This request is only
+ *             guaranteed to fulfilled with memory from the specified node if
+ *             the mempool was originally created with mempool_create_node().
+ *             If not, this is only a hint to the allocator, and the request
+ *             may actually be fulfilled by memory from another node.
  *
- * this function only sleeps if the alloc_fn function sleeps or
+ * this function only sleeps if the ->alloc() function sleeps or
  * returns NULL. Note that due to preallocation, this function
  * *never* fails when called from process contexts. (it might
  * fail if called from an IRQ context.)
  */
-void * mempool_alloc(mempool_t *pool, gfp_t gfp_mask)
+void *mempool_alloc_node(mempool_t *pool, gfp_t gfp_mask, int node_id)
 {
 	void *element;
 	unsigned long flags;
@@ -217,7 +222,7 @@ void * mempool_alloc(mempool_t *pool, gf
 
 repeat_alloc:
 
-	element = pool->alloc(gfp_temp, pool->pool_data);
+	element = pool->alloc(gfp_temp, node_id, pool->pool_data);
 	if (likely(element != NULL))
 		return element;
 
@@ -244,7 +249,7 @@ repeat_alloc:
 
 	goto repeat_alloc;
 }
-EXPORT_SYMBOL(mempool_alloc);
+EXPORT_SYMBOL(mempool_alloc_node);
 
 /**
  * mempool_free - return an element to the pool.
@@ -252,7 +257,7 @@ EXPORT_SYMBOL(mempool_alloc);
  * @pool:      pointer to the memory pool which was allocated via
  *             mempool_create().
  *
- * this function only sleeps if the free_fn() function sleeps.
+ * this function only sleeps if the ->free() function sleeps.
  */
 void mempool_free(void *element, mempool_t *pool)
 {
@@ -276,10 +281,10 @@ EXPORT_SYMBOL(mempool_free);
 /*
  * A commonly used alloc and free fn.
  */
-void *mempool_alloc_slab(gfp_t gfp_mask, void *pool_data)
+void *mempool_alloc_slab(gfp_t gfp_mask, int node_id, void *pool_data)
 {
 	kmem_cache_t *mem = (kmem_cache_t *) pool_data;
-	return kmem_cache_alloc(mem, gfp_mask);
+	return kmem_cache_alloc_node(mem, gfp_mask, node_id);
 }
 EXPORT_SYMBOL(mempool_alloc_slab);
 
@@ -293,10 +298,11 @@ EXPORT_SYMBOL(mempool_free_slab);
 /*
  * A simple mempool-backed page allocator
  */
-void *mempool_alloc_pages(gfp_t gfp_mask, void *pool_data)
+void *mempool_alloc_pages(gfp_t gfp_mask, int node_id, void *pool_data)
 {
 	int order = (int)pool_data;
-	return alloc_pages(gfp_mask, order);
+	return alloc_pages_node(node_id >= 0 ? node_id : numa_node_id(),
+				gfp_mask, order);
 }
 EXPORT_SYMBOL(mempool_alloc_pages);
 
Index: linux-2.6.16-rc1+critical_mempools/include/linux/mempool.h
===================================================================
--- linux-2.6.16-rc1+critical_mempools.orig/include/linux/mempool.h
+++ linux-2.6.16-rc1+critical_mempools/include/linux/mempool.h
@@ -6,7 +6,7 @@
 
 #include <linux/wait.h>
 
-typedef void * (mempool_alloc_t)(gfp_t gfp_mask, void *pool_data);
+typedef void * (mempool_alloc_t)(gfp_t gfp_mask, int node_id, void *pool_data);
 typedef void (mempool_free_t)(void *element, void *pool_data);
 
 typedef struct mempool_s {
@@ -21,27 +21,40 @@ typedef struct mempool_s {
 	wait_queue_head_t wait;
 } mempool_t;
 
-extern mempool_t *mempool_create(int min_nr, mempool_alloc_t *alloc_fn,
-			mempool_free_t *free_fn, void *pool_data);
 extern mempool_t *mempool_create_node(int min_nr, mempool_alloc_t *alloc_fn,
-			mempool_free_t *free_fn, void *pool_data, int nid);
-
-extern int mempool_resize(mempool_t *pool, int new_min_nr, gfp_t gfp_mask);
+			mempool_free_t *free_fn, void *pool_data, int node_id);
+static inline mempool_t *mempool_create(int min_nr, mempool_alloc_t *alloc_fn,
+			mempool_free_t *free_fn, void *pool_data)
+{
+	return mempool_create_node(min_nr, alloc_fn, free_fn, pool_data, -1);
+}
 extern void mempool_destroy(mempool_t *pool);
-extern void * mempool_alloc(mempool_t *pool, gfp_t gfp_mask);
+
+extern int mempool_resize_node(mempool_t *pool, int new_min_nr, gfp_t gfp_mask,
+			       int node_id);
+static inline int mempool_resize(mempool_t *pool, int new_min_nr, gfp_t gfp_mask)
+{
+	return mempool_resize_node(pool, new_min_nr, gfp_mask, -1);
+}
+
+extern void *mempool_alloc_node(mempool_t *pool, gfp_t gfp_mask, int node_id);
+static inline void *mempool_alloc(mempool_t *pool, gfp_t gfp_mask)
+{
+	return mempool_alloc_node(pool, gfp_mask, -1);
+}
 extern void mempool_free(void *element, mempool_t *pool);
 
 /*
  * A mempool_alloc_t and mempool_free_t that get the memory from
  * a slab that is passed in through pool_data.
  */
-void *mempool_alloc_slab(gfp_t gfp_mask, void *pool_data);
+void *mempool_alloc_slab(gfp_t gfp_mask, int node_id, void *pool_data);
 void mempool_free_slab(void *element, void *pool_data);
 
 /*
  * A mempool_alloc_t and mempool_free_t for a simple page allocator
  */
-void *mempool_alloc_pages(gfp_t gfp_mask, void *pool_data);
+void *mempool_alloc_pages(gfp_t gfp_mask, int node_id, void *pool_data);
 void mempool_free_pages(void *element, void *pool_data);
 
 #endif /* _LINUX_MEMPOOL_H */

--

