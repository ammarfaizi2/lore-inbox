Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbWA1LaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbWA1LaP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 06:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbWA1LaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 06:30:15 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:32654 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932134AbWA1LaN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 06:30:13 -0500
Subject: [RFC/PATCH 1/2] slab: allow different page allocation back-ends
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: Paul Jackson <pj@sgi.com>, bcrl@kvack.org, clameter@engr.sgi.com,
       linux-kernel@vger.kernel.org, sri@us.ibm.com, andrea@suse.de,
       pavel@suse.cz, linux-mm@kvack.org
Date: Sat, 28 Jan 2006 13:30:11 +0200
Message-Id: <1138447811.8657.29.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

This untested patch adds kmem_cache_operations so we can have different
page allocation back-ends. The next patch uses this infrastructure to
implement mempool-backed object caches.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 mm/slab.c |   31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

Index: 2.6-mm/mm/slab.c
===================================================================
--- 2.6-mm.orig/mm/slab.c
+++ 2.6-mm/mm/slab.c
@@ -362,6 +362,11 @@ static void kmem_list3_init(struct kmem_
 	MAKE_LIST((cachep), (&(ptr)->slabs_free), slabs_free, nodeid);	\
 	} while (0)
 
+struct kmem_cache_operations {
+	void* (*getpages)(struct kmem_cache *, gfp_t, int);
+	void (*freepages)(struct kmem_cache *, void *);
+};
+
 /*
  * struct kmem_cache
  *
@@ -401,6 +406,8 @@ struct kmem_cache {
 	/* de-constructor func */
 	void (*dtor) (void *, struct kmem_cache *, unsigned long);
 
+	struct kmem_cache_operations *ops;
+
 	/* shrinker data for this cache */
 	struct shrinker *shrinker;
 
@@ -638,6 +645,8 @@ static struct arraycache_init initarray_
 static struct arraycache_init initarray_generic =
     { {0, BOOT_CPUCACHE_ENTRIES, 1, 0} };
 
+static struct kmem_cache_operations pagealloc_ops;
+
 /* internal cache of cache description objs */
 static struct kmem_cache cache_cache = {
 	.batchcount = 1,
@@ -647,6 +656,7 @@ static struct kmem_cache cache_cache = {
 	.flags = SLAB_NO_REAP,
 	.spinlock = SPIN_LOCK_UNLOCKED,
 	.name = "kmem_cache",
+	.ops = &pagealloc_ops,
 #if DEBUG
 	.obj_size = sizeof(struct kmem_cache),
 #endif
@@ -1282,7 +1292,7 @@ static void *kmem_getpages(struct kmem_c
 	int i;
 
 	flags |= cachep->gfpflags;
-	page = alloc_pages_node(nodeid, flags, cachep->gfporder);
+	page = cachep->ops->getpages(cachep, flags, nodeid);
 	if (!page)
 		return NULL;
 	addr = page_address(page);
@@ -1315,11 +1325,27 @@ static void kmem_freepages(struct kmem_c
 	sub_page_state(nr_slab, nr_freed);
 	if (current->reclaim_state)
 		current->reclaim_state->reclaimed_slab += nr_freed;
-	free_pages((unsigned long)addr, cachep->gfporder);
+	cachep->ops->freepages(cachep, addr);
 	if (cachep->flags & SLAB_RECLAIM_ACCOUNT)
 		atomic_sub(1 << cachep->gfporder, &slab_reclaim_pages);
 }
 
+static void *pagealloc_getpages(struct kmem_cache *cache, gfp_t flags,
+				int nodeid)
+{
+	return alloc_pages_node(nodeid, flags, cache->gfporder);
+}
+
+static void pagealloc_freepages(struct kmem_cache *cache, void *addr)
+{
+	free_pages((unsigned long)addr, cache->gfporder);
+}
+
+static struct kmem_cache_operations pagealloc_ops = {
+	.getpages = pagealloc_getpages,
+	.freepages = pagealloc_freepages
+};
+
 static void kmem_rcu_free(struct rcu_head *head)
 {
 	struct slab_rcu *slab_rcu = (struct slab_rcu *)head;
@@ -1784,6 +1810,7 @@ kmem_cache_create (const char *name, siz
 		goto oops;
 	memset(cachep, 0, sizeof(struct kmem_cache));
 
+	cachep->ops = &pagealloc_ops;
 #if DEBUG
 	cachep->obj_size = size;
 


