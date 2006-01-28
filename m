Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbWA1LaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbWA1LaU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 06:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbWA1LaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 06:30:19 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:32654 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932316AbWA1LaS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 06:30:18 -0500
Subject: [RFC/PATCH 2/2] slab: mempool-backed object caches
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: Paul Jackson <pj@sgi.com>, bcrl@kvack.org, clameter@engr.sgi.com,
       linux-kernel@vger.kernel.org, sri@us.ibm.com, andrea@suse.de,
       pavel@suse.cz, linux-mm@kvack.org
Date: Sat, 28 Jan 2006 13:30:16 +0200
Message-Id: <1138447816.8657.31.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

This completely untested patch adds kmem_cache_create_mempool which
creates a mempool-backed object cache. It wont work as-is (we're not
checking page order, for example) but you should get the idea.

The good part is that now you can create object caches for many critical
allocations which can share the same subsystem-specific mempool.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 include/linux/slab.h |   15 ++++++++++++---
 mm/slab.c            |   44 ++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 52 insertions(+), 7 deletions(-)

Index: 2.6-mm/include/linux/slab.h
===================================================================
--- 2.6-mm.orig/include/linux/slab.h
+++ 2.6-mm/include/linux/slab.h
@@ -15,6 +15,7 @@ typedef struct kmem_cache kmem_cache_t;
 #include	<linux/gfp.h>
 #include	<linux/init.h>
 #include	<linux/types.h>
+#include	<linux/mempool.h>
 #include	<asm/page.h>		/* kmalloc_sizes.h needs PAGE_SIZE */
 #include	<asm/cache.h>		/* kmalloc_sizes.h needs L1_CACHE_BYTES */
 
@@ -58,9 +59,17 @@ typedef struct kmem_cache kmem_cache_t;
 /* prototypes */
 extern void __init kmem_cache_init(void);
 
-extern kmem_cache_t *kmem_cache_create(const char *, size_t, size_t, unsigned long,
-				       void (*)(void *, kmem_cache_t *, unsigned long),
-				       void (*)(void *, kmem_cache_t *, unsigned long));
+typedef void (*kmem_ctor_fn)(void *, kmem_cache_t *, unsigned long);
+typedef void (*kmem_dtor_fn)(void *, kmem_cache_t *, unsigned long);
+
+extern struct kmem_cache *kmem_cache_create(const char *, size_t, size_t,
+					    unsigned long, kmem_ctor_fn,
+					    kmem_dtor_fn);
+
+extern struct kmem_cache *kmem_cache_create_mempool(const char *, size_t,
+						    size_t, unsigned long,
+						    kmem_ctor_fn,
+						    kmem_dtor_fn, mempool_t *);
 extern int kmem_cache_destroy(kmem_cache_t *);
 extern int kmem_cache_shrink(kmem_cache_t *);
 extern void *kmem_cache_alloc(kmem_cache_t *, gfp_t);
Index: 2.6-mm/mm/slab.c
===================================================================
--- 2.6-mm.orig/mm/slab.c
+++ 2.6-mm/mm/slab.c
@@ -406,6 +406,7 @@ struct kmem_cache {
 	/* de-constructor func */
 	void (*dtor) (void *, struct kmem_cache *, unsigned long);
 
+	mempool_t *mempool;
 	struct kmem_cache_operations *ops;
 
 	/* shrinker data for this cache */
@@ -1346,6 +1347,22 @@ static struct kmem_cache_operations page
 	.freepages = pagealloc_freepages
 };
 
+static void *mempool_getpages(struct kmem_cache *cache, gfp_t flags,
+			      int nodeid)
+{
+	return mempool_alloc(cache->mempool, flags);
+}
+
+static void mempool_freepages(struct kmem_cache *cache, void *addr)
+{
+	mempool_free(addr, cache->mempool);
+}
+
+static struct kmem_cache_operations mempool_ops = {
+	.getpages = mempool_getpages,
+	.freepages = mempool_freepages
+};
+
 static void kmem_rcu_free(struct rcu_head *head)
 {
 	struct slab_rcu *slab_rcu = (struct slab_rcu *)head;
@@ -1678,9 +1695,9 @@ static inline size_t calculate_slab_orde
  * as davem.
  */
 struct kmem_cache *
-kmem_cache_create (const char *name, size_t size, size_t align,
-	unsigned long flags, void (*ctor)(void*, struct kmem_cache *, unsigned long),
-	void (*dtor)(void*, struct kmem_cache *, unsigned long))
+__kmem_cache_create(const char *name, size_t size, size_t align,
+		    unsigned long flags, kmem_ctor_fn ctor, kmem_dtor_fn dtor,
+		    mempool_t *mempool, struct kmem_cache_operations *ops)
 {
 	size_t left_over, slab_size, ralign;
 	struct kmem_cache *cachep = NULL;
@@ -1810,7 +1827,8 @@ kmem_cache_create (const char *name, siz
 		goto oops;
 	memset(cachep, 0, sizeof(struct kmem_cache));
 
-	cachep->ops = &pagealloc_ops;
+	cachep->mempool = mempool;
+	cachep->ops = ops;
 #if DEBUG
 	cachep->obj_size = size;
 
@@ -1970,8 +1988,26 @@ kmem_cache_create (const char *name, siz
 
 	return cachep;
 }
+
+struct kmem_cache *
+kmem_cache_create(const char *name, size_t size, size_t align,
+		  unsigned long flags, kmem_ctor_fn ctor, kmem_dtor_fn dtor)
+{
+	return __kmem_cache_create(name, size, align, flags, ctor, dtor,
+				   NULL, &pagealloc_ops);
+}
 EXPORT_SYMBOL(kmem_cache_create);
 
+struct kmem_cache *
+kmem_cache_create_mempool(const char *name, size_t size, size_t align,
+			  unsigned long flags, kmem_ctor_fn ctor,
+			  kmem_dtor_fn dtor, mempool_t *mempool)
+{
+	return __kmem_cache_create(name, size, align, flags, ctor, dtor,
+				   mempool, &mempool_ops);
+}
+EXPORT_SYMBOL(kmem_cache_create_mempool);
+
 #if DEBUG
 static void check_irq_off(void)
 {


