Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263778AbUGLVxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263778AbUGLVxQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 17:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbUGLVxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 17:53:16 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:51765 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263761AbUGLVwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 17:52:22 -0400
Date: Mon, 12 Jul 2004 22:52:07 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Manfred Spraul <manfred@colorfullife.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] rmaplock 2/6 SLAB_DESTROY_BY_RCU
In-Reply-To: <Pine.LNX.4.44.0407122248060.4005-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0407122250390.4005-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With page_map_lock gone, how to stabilize page->mapping's anon_vma while
acquiring anon_vma->lock in page_referenced_anon and try_to_unmap_anon?

The page cannot actually be freed (vmscan holds reference), but however
much we check page_mapped (which guarantees that anon_vma is in use - or
would guarantee that if we added suitable barriers), there's no locking
against page becoming unmapped the instant after, then anon_vma freed.

It's okay to take anon_vma->lock after it's freed, so long as it remains
a struct anon_vma (its list would become empty, or perhaps reused for an
unrelated anon_vma: but no problem since we always check that the page
located is the right one); but corruption if that memory gets reused for
some other purpose.

This is not unique: it's liable to be problem whenever the kernel tries
to approach a structure obliquely.  It's generally solved with an atomic
reference count; but one advantage of anon_vma over anonmm is that it
does not have such a count, and it would be a backward step to add one.

Therefore... implement SLAB_DESTROY_BY_RCU flag, to guarantee that such
a kmem_cache_alloc'ed structure cannot get freed to other use while the
rcu_read_lock is held i.e. preempt disabled; and use that for anon_vma.

I hope SLAB_DESTROY_BY_RCU can be useful elsewhere; but though it's safe
for little anon_vma, I'd hesitate before using it generally, on shrinker
caches or kmem_cache_destroyable caches.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

 include/linux/slab.h |    1 
 mm/rmap.c            |   50 ++++++++++++++++++++++++++++---------------
 mm/slab.c            |   59 +++++++++++++++++++++++++++++++++++++++++++++------
 3 files changed, 87 insertions(+), 23 deletions(-)

--- rmaplock2/include/linux/slab.h	2004-07-09 10:53:44.000000000 +0100
+++ rmaplock3/include/linux/slab.h	2004-07-12 18:20:35.250832360 +0100
@@ -45,6 +45,7 @@ typedef struct kmem_cache_s kmem_cache_t
 #define SLAB_RECLAIM_ACCOUNT	0x00020000UL	/* track pages allocated to indicate
 						   what is reclaimable later*/
 #define SLAB_PANIC		0x00040000UL	/* panic if kmem_cache_create() fails */
+#define SLAB_DESTROY_BY_RCU	0x00080000UL	/* defer freeing pages to RCU */
 
 /* flags passed to a constructor func */
 #define	SLAB_CTOR_CONSTRUCTOR	0x001UL		/* if not set, then deconstructor */
--- rmaplock2/mm/rmap.c	2004-07-12 18:20:22.338795288 +0100
+++ rmaplock3/mm/rmap.c	2004-07-12 18:20:35.274828712 +0100
@@ -30,6 +30,7 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/rmap.h>
+#include <linux/rcupdate.h>
 
 #include <asm/tlbflush.h>
 
@@ -159,8 +160,31 @@ static void anon_vma_ctor(void *data, km
 
 void __init anon_vma_init(void)
 {
-	anon_vma_cachep = kmem_cache_create("anon_vma",
-		sizeof(struct anon_vma), 0, SLAB_PANIC, anon_vma_ctor, NULL);
+	anon_vma_cachep = kmem_cache_create("anon_vma", sizeof(struct anon_vma),
+			0, SLAB_DESTROY_BY_RCU|SLAB_PANIC, anon_vma_ctor, NULL);
+}
+
+/*
+ * Getting a lock on a stable anon_vma from a page off the LRU is
+ * tricky: page_lock_anon_vma rely on RCU to guard against the races.
+ */
+static struct anon_vma *page_lock_anon_vma(struct page *page)
+{
+	struct anon_vma *anon_vma = NULL;
+	unsigned long anon_mapping;
+
+	rcu_read_lock();
+	anon_mapping = (unsigned long) page->mapping;
+	if (!(anon_mapping & PAGE_MAPPING_ANON))
+		goto out;
+	if (!page_mapped(page))
+		goto out;
+
+	anon_vma = (struct anon_vma *) (anon_mapping - PAGE_MAPPING_ANON);
+	spin_lock(&anon_vma->lock);
+out:
+	rcu_read_unlock();
+	return anon_vma;
 }
 
 /*
@@ -235,19 +259,15 @@ out:
 static int page_referenced_anon(struct page *page)
 {
 	unsigned int mapcount;
-	struct anon_vma *anon_vma = (void *) page->mapping - PAGE_MAPPING_ANON;
+	struct anon_vma *anon_vma;
 	struct vm_area_struct *vma;
 	int referenced = 0;
 
-	/*
-	 * Recheck mapcount: it is not safe to take anon_vma->lock after
-	 * last page_remove_rmap, since struct anon_vma might be reused.
-	 */
-	mapcount = page_mapcount(page);
-	if (!mapcount)
+	anon_vma = page_lock_anon_vma(page);
+	if (!anon_vma)
 		return referenced;
 
-	spin_lock(&anon_vma->lock);
+	mapcount = page_mapcount(page);
 	list_for_each_entry(vma, &anon_vma->head, anon_vma_node) {
 		referenced += page_referenced_one(page, vma, &mapcount);
 		if (!mapcount)
@@ -628,18 +648,14 @@ out_unlock:
 
 static int try_to_unmap_anon(struct page *page)
 {
-	struct anon_vma *anon_vma = (void *) page->mapping - PAGE_MAPPING_ANON;
+	struct anon_vma *anon_vma;
 	struct vm_area_struct *vma;
 	int ret = SWAP_AGAIN;
 
-	/*
-	 * Recheck mapped: it is not safe to take anon_vma->lock after
-	 * last page_remove_rmap, since struct anon_vma might be reused.
-	 */
-	if (!page_mapped(page))
+	anon_vma = page_lock_anon_vma(page);
+	if (!anon_vma)
 		return ret;
 
-	spin_lock(&anon_vma->lock);
 	list_for_each_entry(vma, &anon_vma->head, anon_vma_node) {
 		ret = try_to_unmap_one(page, vma);
 		if (ret == SWAP_FAIL || !page_mapped(page))
--- rmaplock2/mm/slab.c	2004-07-09 10:53:46.000000000 +0100
+++ rmaplock3/mm/slab.c	2004-07-12 18:20:35.277828256 +0100
@@ -91,6 +91,7 @@
 #include	<linux/cpu.h>
 #include	<linux/sysctl.h>
 #include	<linux/module.h>
+#include	<linux/rcupdate.h>
 
 #include	<asm/uaccess.h>
 #include	<asm/cacheflush.h>
@@ -139,11 +140,13 @@
 			 SLAB_POISON | SLAB_HWCACHE_ALIGN | \
 			 SLAB_NO_REAP | SLAB_CACHE_DMA | \
 			 SLAB_MUST_HWCACHE_ALIGN | SLAB_STORE_USER | \
-			 SLAB_RECLAIM_ACCOUNT | SLAB_PANIC)
+			 SLAB_RECLAIM_ACCOUNT | SLAB_PANIC | \
+			 SLAB_DESTROY_BY_RCU)
 #else
 # define CREATE_MASK	(SLAB_HWCACHE_ALIGN | SLAB_NO_REAP | \
 			 SLAB_CACHE_DMA | SLAB_MUST_HWCACHE_ALIGN | \
-			 SLAB_RECLAIM_ACCOUNT | SLAB_PANIC)
+			 SLAB_RECLAIM_ACCOUNT | SLAB_PANIC | \
+			 SLAB_DESTROY_BY_RCU)
 #endif
 
 /*
@@ -190,6 +193,29 @@ struct slab {
 };
 
 /*
+ * struct slab_rcu
+ *
+ * slab_destroy on a SLAB_DESTROY_BY_RCU cache uses this structure to
+ * arrange for kmem_freepages to be called via RCU.  This is useful if
+ * we need to approach a kernel structure obliquely, from its address
+ * obtained without the usual locking.  We can lock the structure to
+ * stabilize it and check it's still at the given address, only if we
+ * can be sure that the memory has not been meanwhile reused for some
+ * other kind of object (which our subsystem's lock might corrupt).
+ *
+ * rcu_read_lock before reading the address, then rcu_read_unlock after
+ * taking the spinlock within the structure expected at that address.
+ *
+ * We assume struct slab_rcu can overlay struct slab when destroying.
+ * Care needed to use kmem_cache_destroy on a SLAB_DESTROY_BY_RCU cache.
+ */
+struct slab_rcu {
+	struct rcu_head		head;
+	kmem_cache_t		*cachep;
+	void			*addr;
+};
+
+/*
  * struct array_cache
  *
  * Per cpu structures
@@ -883,6 +909,16 @@ static void kmem_freepages(kmem_cache_t 
 		atomic_sub(1<<cachep->gfporder, &slab_reclaim_pages);
 }
 
+static void kmem_rcu_free(struct rcu_head *head)
+{
+	struct slab_rcu *slab_rcu = (struct slab_rcu *) head;
+	kmem_cache_t *cachep = slab_rcu->cachep;
+
+	kmem_freepages(cachep, slab_rcu->addr);
+	if (OFF_SLAB(cachep))
+		kmem_cache_free(cachep->slabp_cache, slab_rcu);
+}
+
 #if DEBUG
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
@@ -1036,6 +1072,8 @@ static void check_poison_obj(kmem_cache_
  */
 static void slab_destroy (kmem_cache_t *cachep, struct slab *slabp)
 {
+	void *addr = slabp->s_mem - slabp->colouroff;
+
 #if DEBUG
 	int i;
 	for (i = 0; i < cachep->num; i++) {
@@ -1071,10 +1109,19 @@ static void slab_destroy (kmem_cache_t *
 		}
 	}
 #endif
-	
-	kmem_freepages(cachep, slabp->s_mem-slabp->colouroff);
-	if (OFF_SLAB(cachep))
-		kmem_cache_free(cachep->slabp_cache, slabp);
+
+	if (unlikely(cachep->flags & SLAB_DESTROY_BY_RCU)) {
+		struct slab_rcu *slab_rcu;
+
+		slab_rcu = (struct slab_rcu *) slabp;
+		slab_rcu->cachep = cachep;
+		slab_rcu->addr = addr;
+		call_rcu(&slab_rcu->head, kmem_rcu_free);
+	} else {
+		kmem_freepages(cachep, addr);
+		if (OFF_SLAB(cachep))
+			kmem_cache_free(cachep->slabp_cache, slabp);
+	}
 }
 
 /**

