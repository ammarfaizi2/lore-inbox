Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751235AbWAYVhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbWAYVhQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 16:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWAYVhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 16:37:15 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:25816 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751235AbWAYVhM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 16:37:12 -0500
Subject: [patch 8/9] slab - Add *_mempool slab variants
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: linux-kernel@vger.kernel.org
Cc: sri@us.ibm.com, andrea@suse.de, pavel@suse.cz, linux-mm@kvack.org
References: <20060125161321.647368000@localhost.localdomain>
Content-Type: text/plain
Organization: IBM LTC
Date: Wed, 25 Jan 2006 11:40:20 -0800
Message-Id: <1138218020.2092.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment (critical_mempools)
Support for using a single mempool as a critical pool for all slab allocations.

This patch adds *_mempool variants to the existing slab allocator API functions:
kmalloc_mempool(), kmalloc_node_mempool(), kmem_cache_alloc_mempool() &
kmem_cache_alloc_node_mempool().  These functions behave the same as their
non-mempool cousins, but they take an additional mempool_t argument.

This patch does not actually USE the mempool_t argument, but simply adds the
function calls.  The next patch in the series will add code to use the
mempools.  This patch should have no externally visible changes to existing
users of the slab allocator.

Signed-off-by: Matthew Dobson <colpatch@us.ibm.com>

 include/linux/slab.h |   38 +++++++++++++++++++++++++++++---------
 mm/slab.c            |   39 +++++++++++++++++++++++++++++++--------
 2 files changed, 60 insertions(+), 17 deletions(-)

Index: linux-2.6.16-rc1+critical_mempools/include/linux/slab.h
===================================================================
--- linux-2.6.16-rc1+critical_mempools.orig/include/linux/slab.h
+++ linux-2.6.16-rc1+critical_mempools/include/linux/slab.h
@@ -15,6 +15,7 @@ typedef struct kmem_cache kmem_cache_t;
 #include	<linux/gfp.h>
 #include	<linux/init.h>
 #include	<linux/types.h>
+#include	<linux/mempool.h>
 #include	<asm/page.h>		/* kmalloc_sizes.h needs PAGE_SIZE */
 #include	<asm/cache.h>		/* kmalloc_sizes.h needs L1_CACHE_BYTES */
 
@@ -63,6 +64,7 @@ extern kmem_cache_t *kmem_cache_create(c
 				       void (*)(void *, kmem_cache_t *, unsigned long));
 extern int kmem_cache_destroy(kmem_cache_t *);
 extern int kmem_cache_shrink(kmem_cache_t *);
+extern void *kmem_cache_alloc_mempool(kmem_cache_t *, gfp_t, mempool_t *);
 extern void *kmem_cache_alloc(kmem_cache_t *, gfp_t);
 extern void kmem_cache_free(kmem_cache_t *, void *);
 extern unsigned int kmem_cache_size(kmem_cache_t *);
@@ -76,9 +78,9 @@ struct cache_sizes {
 	kmem_cache_t	*cs_dmacachep;
 };
 extern struct cache_sizes malloc_sizes[];
-extern void *__kmalloc(size_t, gfp_t);
+extern void *__kmalloc(size_t, gfp_t, mempool_t *);
 
-static inline void *kmalloc(size_t size, gfp_t flags)
+static inline void *kmalloc_mempool(size_t size, gfp_t flags, mempool_t *pool)
 {
 	if (__builtin_constant_p(size)) {
 		int i = 0;
@@ -94,11 +96,16 @@ static inline void *kmalloc(size_t size,
 			__you_cannot_kmalloc_that_much();
 		}
 found:
-		return kmem_cache_alloc((flags & GFP_DMA) ?
+		return kmem_cache_alloc_mempool((flags & GFP_DMA) ?
 			malloc_sizes[i].cs_dmacachep :
-			malloc_sizes[i].cs_cachep, flags);
+			malloc_sizes[i].cs_cachep, flags, pool);
 	}
-	return __kmalloc(size, flags);
+	return __kmalloc(size, flags, pool);
+}
+
+static inline void *kmalloc(size_t size, gfp_t flags)
+{
+	return kmalloc_mempool(size, flags, NULL);
 }
 
 extern void *kzalloc_node(size_t, gfp_t, int);
@@ -121,14 +128,27 @@ extern void kfree(const void *);
 extern unsigned int ksize(const void *);
 
 #ifdef CONFIG_NUMA
-extern void *kmem_cache_alloc_node(kmem_cache_t *, gfp_t flags, int node);
-extern void *kmalloc_node(size_t size, gfp_t flags, int node);
+extern void *kmem_cache_alloc_node_mempool(kmem_cache_t *, gfp_t, int, mempool_t *);
+extern void *kmem_cache_alloc_node(kmem_cache_t *, gfp_t, int);
+extern void *kmalloc_node_mempool(size_t, gfp_t, int, mempool_t *);
+extern void *kmalloc_node(size_t, gfp_t, int);
 #else
-static inline void *kmem_cache_alloc_node(kmem_cache_t *cachep, gfp_t flags, int node)
+static inline void *kmem_cache_alloc_node_mempool(kmem_cache_t *cachep, gfp_t flags,
+						  int node_id, mempool_t *pool)
+{
+	return kmem_cache_alloc_mempool(cachep, flags, pool);
+}
+static inline void *kmem_cache_alloc_node(kmem_cache_t *cachep, gfp_t flags,
+					  int node_id)
 {
 	return kmem_cache_alloc(cachep, flags);
 }
-static inline void *kmalloc_node(size_t size, gfp_t flags, int node)
+static inline void *kmalloc_node_mempool(size_t size, gfp_t flags, int node_id,
+					 mempool_t *pool)
+{
+	return kmalloc_mempool(size, flags, pool);
+}
+static inline void *kmalloc_node(size_t size, gfp_t flags, int node_id)
 {
 	return kmalloc(size, flags);
 }
Index: linux-2.6.16-rc1+critical_mempools/mm/slab.c
===================================================================
--- linux-2.6.16-rc1+critical_mempools.orig/mm/slab.c
+++ linux-2.6.16-rc1+critical_mempools/mm/slab.c
@@ -2837,17 +2837,25 @@ static inline void __cache_free(kmem_cac
 }
 
 /**
- * kmem_cache_alloc - Allocate an object
+ * kmem_cache_alloc_mempool - Allocate an object
  * @cachep: The cache to allocate from.
  * @flags: See kmalloc().
+ * @pool: mempool to allocate pages from if we need to refill a slab
  *
  * Allocate an object from this cache.  The flags are only relevant
  * if the cache has no available objects.
  */
-void *kmem_cache_alloc(kmem_cache_t *cachep, gfp_t flags)
+void *kmem_cache_alloc_mempool(kmem_cache_t *cachep, gfp_t flags,
+			       mempool_t *pool)
 {
 	return __cache_alloc(cachep, flags);
 }
+EXPORT_SYMBOL(kmem_cache_alloc_mempool);
+
+void *kmem_cache_alloc(kmem_cache_t *cachep, gfp_t flags)
+{
+	return kmem_cache_alloc_mempool(cachep, flags, NULL);
+}
 EXPORT_SYMBOL(kmem_cache_alloc);
 
 /**
@@ -2894,18 +2902,20 @@ int fastcall kmem_ptr_validate(kmem_cach
 
 #ifdef CONFIG_NUMA
 /**
- * kmem_cache_alloc_node - Allocate an object on the specified node
+ * kmem_cache_alloc_node_mempool - Allocate an object on the specified node
  * @cachep: The cache to allocate from.
  * @flags: See kmalloc().
  * @nodeid: node number of the target node.
+ * @pool: mempool to allocate pages from if we need to refill a slab
  *
- * Identical to kmem_cache_alloc, except that this function is slow
+ * Identical to kmem_cache_alloc_mempool, except that this function is slow
  * and can sleep. And it will allocate memory on the given node, which
  * can improve the performance for cpu bound structures.
  * New and improved: it will now make sure that the object gets
  * put on the correct node list so that there is no false sharing.
  */
-void *kmem_cache_alloc_node(kmem_cache_t *cachep, gfp_t flags, int nodeid)
+void *kmem_cache_alloc_node_mempool(kmem_cache_t *cachep, gfp_t flags,
+				    int nodeid, mempool_t *pool)
 {
 	unsigned long save_flags;
 	void *ptr;
@@ -2934,16 +2944,29 @@ void *kmem_cache_alloc_node(kmem_cache_t
 
 	return ptr;
 }
+EXPORT_SYMBOL(kmem_cache_alloc_node_mempool);
+
+void *kmem_cache_alloc_node(kmem_cache_t *cachep, gfp_t flags, int nodeid)
+{
+	return kmem_cache_alloc_node_mempool(cachep, flags, nodeid, NULL);
+}
 EXPORT_SYMBOL(kmem_cache_alloc_node);
 
-void *kmalloc_node(size_t size, gfp_t flags, int node)
+void *kmalloc_node_mempool(size_t size, gfp_t flags, int nodeid,
+			   mempool_t *pool)
 {
 	kmem_cache_t *cachep;
 
 	cachep = kmem_find_general_cachep(size, flags);
 	if (unlikely(cachep == NULL))
 		return NULL;
-	return kmem_cache_alloc_node(cachep, flags, node);
+	return kmem_cache_alloc_node_mempool(cachep, flags, nodeid, pool);
+}
+EXPORT_SYMBOL(kmalloc_node_mempool);
+
+void *kmalloc_node(size_t size, gfp_t flags, int nodeid)
+{
+	return kmalloc_node_mempool(size, flags, nodeid, NULL);
 }
 EXPORT_SYMBOL(kmalloc_node);
 #endif
@@ -2969,7 +2992,7 @@ EXPORT_SYMBOL(kmalloc_node);
  * platforms.  For example, on i386, it means that the memory must come
  * from the first 16MB.
  */
-void *__kmalloc(size_t size, gfp_t flags)
+void *__kmalloc(size_t size, gfp_t flags, mempool_t *pool)
 {
 	kmem_cache_t *cachep;
 

--

