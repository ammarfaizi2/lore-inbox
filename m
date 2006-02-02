Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbWBBPNA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbWBBPNA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 10:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWBBPNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 10:13:00 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:50908 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751129AbWBBPM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 10:12:59 -0500
Date: Thu, 2 Feb 2006 17:12:57 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: [PATCH] slab: object to index mapping cleanup
Message-ID: <Pine.LNX.4.58.0602021712090.20620@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Enberg <penberg@cs.helsinki.fi>

This patch cleans up the object to index mapping that has been spread around
mm/slab.c.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 mm/slab.c |   34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

Index: 2.6-git/mm/slab.c
===================================================================
--- 2.6-git.orig/mm/slab.c
+++ 2.6-git/mm/slab.c
@@ -608,6 +608,18 @@ static inline struct slab *virt_to_slab(
 	return page_get_slab(page);
 }
 
+static inline void *index_to_obj(struct kmem_cache *cache, struct slab *slab,
+				 unsigned int idx)
+{
+	return slab->s_mem + cache->buffer_size * idx;
+}
+
+static inline unsigned int obj_to_index(struct kmem_cache *cache,
+					struct slab *slab, void *obj)
+{
+	return (unsigned)(obj - slab->s_mem) / cache->buffer_size;
+}
+
 /* These are the default caches for kmalloc. Custom caches can have other sizes. */
 struct cache_sizes malloc_sizes[] = {
 #define CACHE(x) { .cs_size = (x) },
@@ -1450,18 +1462,18 @@ static void check_poison_obj(struct kmem
 		 * exist:
 		 */
 		struct slab *slabp = virt_to_slab(objp);
-		int objnr;
+		unsigned int objnr;
 
-		objnr = (unsigned)(objp - slabp->s_mem) / cachep->buffer_size;
+		objnr = obj_to_index(cachep, slabp, objp);
 		if (objnr) {
-			objp = slabp->s_mem + (objnr - 1) * cachep->buffer_size;
+			objp = index_to_obj(cachep, slabp, objnr - 1);
 			realobj = (char *)objp + obj_offset(cachep);
 			printk(KERN_ERR "Prev obj: start=%p, len=%d\n",
 			       realobj, size);
 			print_objinfo(cachep, objp, 2);
 		}
 		if (objnr + 1 < cachep->num) {
-			objp = slabp->s_mem + (objnr + 1) * cachep->buffer_size;
+			objp = index_to_obj(cachep, slabp, objnr + 1);
 			realobj = (char *)objp + obj_offset(cachep);
 			printk(KERN_ERR "Next obj: start=%p, len=%d\n",
 			       realobj, size);
@@ -1480,7 +1492,7 @@ static void slab_destroy_objs(struct kme
 {
 	int i;
 	for (i = 0; i < cachep->num; i++) {
-		void *objp = slabp->s_mem + cachep->buffer_size * i;
+		void *objp = index_to_obj(cachep, slabp, i);
 
 		if (cachep->flags & SLAB_POISON) {
 #ifdef CONFIG_DEBUG_PAGEALLOC
@@ -1513,7 +1525,7 @@ static void slab_destroy_objs(struct kme
 	if (cachep->dtor) {
 		int i;
 		for (i = 0; i < cachep->num; i++) {
-			void *objp = slabp->s_mem + cachep->buffer_size * i;
+			void *objp = index_to_obj(cachep, slabp, i);
 			(cachep->dtor) (objp, cachep, 0);
 		}
 	}
@@ -2189,7 +2201,7 @@ static void cache_init_objs(struct kmem_
 	int i;
 
 	for (i = 0; i < cachep->num; i++) {
-		void *objp = slabp->s_mem + cachep->buffer_size * i;
+		void *objp = index_to_obj(cachep, slabp, i);
 #if DEBUG
 		/* need to poison the objs? */
 		if (cachep->flags & SLAB_POISON)
@@ -2245,7 +2257,7 @@ static void kmem_flagcheck(struct kmem_c
 
 static void *slab_get_obj(struct kmem_cache *cachep, struct slab *slabp, int nodeid)
 {
-	void *objp = slabp->s_mem + (slabp->free * cachep->buffer_size);
+	void *objp = index_to_obj(cachep, slabp, slabp->free);
 	kmem_bufctl_t next;
 
 	slabp->inuse++;
@@ -2262,7 +2274,7 @@ static void *slab_get_obj(struct kmem_ca
 static void slab_put_obj(struct kmem_cache *cachep, struct slab *slabp, void *objp,
 			  int nodeid)
 {
-	unsigned int objnr = (unsigned)(objp-slabp->s_mem) / cachep->buffer_size;
+	unsigned int objnr = obj_to_index(cachep, slabp, objp);
 
 #if DEBUG
 	/* Verify that the slab belongs to the intended node */
@@ -2448,10 +2460,10 @@ static void *cache_free_debugcheck(struc
 	if (cachep->flags & SLAB_STORE_USER)
 		*dbg_userword(cachep, objp) = caller;
 
-	objnr = (unsigned)(objp - slabp->s_mem) / cachep->buffer_size;
+	objnr = obj_to_index(cachep, slabp, objp);
 
 	BUG_ON(objnr >= cachep->num);
-	BUG_ON(objp != slabp->s_mem + objnr * cachep->buffer_size);
+	BUG_ON(objp != index_to_obj(cachep, slabp, objnr));
 
 	if (cachep->flags & SLAB_DEBUG_INITIAL) {
 		/* Need to call the slab's constructor so the
