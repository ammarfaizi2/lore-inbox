Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964793AbWACU0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbWACU0H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 15:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964776AbWACUZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 15:25:55 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:38311 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S964783AbWACUZw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 15:25:52 -0500
Subject: [patch 5/9] slab: extract slab_destroy_objs()
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com,
       colpatch@us.ibm.com, rostedt@goodmis.org, clameter@sgi.com,
       penberg@cs.helsinki.fi
Date: Tue, 03 Jan 2006 22:25:50 +0200
Message-Id: <1136319951.8629.20.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Dobson <colpatch@us.ibm.com>

This patch creates a helper function, slab_destroy_objs() which called from
slab_destroy(). This makes slab_destroy() smaller and more readable, and moves
ifdefs outside the function body.

Signed-off-by: Matthew Dobson <colpatch@us.ibm.com>
Acked-by: Manfred Spraul <manfred@colorfullife.com>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 mm/slab.c |   26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

Index: 2.6/mm/slab.c
===================================================================
--- 2.6.orig/mm/slab.c
+++ 2.6/mm/slab.c
@@ -1445,15 +1445,13 @@ static void check_poison_obj(kmem_cache_
 }
 #endif
 
-/* Destroy all the objs in a slab, and release the mem back to the system.
- * Before calling the slab must have been unlinked from the cache.
- * The cache-lock is not held/needed.
+#if DEBUG
+/**
+ * slab_destroy_objs - call the registered destructor for each object in
+ *      a slab that is to be destroyed.
  */
-static void slab_destroy (kmem_cache_t *cachep, struct slab *slabp)
+static void slab_destroy_objs(kmem_cache_t *cachep, struct slab *slabp)
 {
-	void *addr = slabp->s_mem - slabp->colouroff;
-
-#if DEBUG
 	int i;
 	for (i = 0; i < cachep->num; i++) {
 		void *objp = slabp->s_mem + cachep->buffer_size * i;
@@ -1479,7 +1477,10 @@ static void slab_destroy (kmem_cache_t *
 		if (cachep->dtor && !(cachep->flags & SLAB_POISON))
 			(cachep->dtor)(objp+obj_offset(cachep), cachep, 0);
 	}
+}
 #else
+static void slab_destroy_objs(kmem_cache_t *cachep, struct slab *slabp)
+{
 	if (cachep->dtor) {
 		int i;
 		for (i = 0; i < cachep->num; i++) {
@@ -1487,8 +1488,19 @@ static void slab_destroy (kmem_cache_t *
 			(cachep->dtor)(objp, cachep, 0);
 		}
 	}
+}
 #endif
 
+/**
+ * Destroy all the objs in a slab, and release the mem back to the system.
+ * Before calling the slab must have been unlinked from the cache.
+ * The cache-lock is not held/needed.
+ */
+static void slab_destroy(kmem_cache_t *cachep, struct slab *slabp)
+{
+	void *addr = slabp->s_mem - slabp->colouroff;
+
+	slab_destroy_objs(cachep, slabp);
 	if (unlikely(cachep->flags & SLAB_DESTROY_BY_RCU)) {
 		struct slab_rcu *slab_rcu;
 

--


