Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964783AbWACU0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbWACU0f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 15:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964780AbWACU0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 15:26:11 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:38311 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S964783AbWACUZ4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 15:25:56 -0500
Subject: [patch 6/9] slab: extract slab_{put|get}_obj
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com,
       colpatch@us.ibm.com, rostedt@goodmis.org, clameter@sgi.com,
       penberg@cs.helsinki.fi
Date: Tue, 03 Jan 2006 22:25:54 +0200
Message-Id: <1136319955.8629.21.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Dobson <colpatch@us.ibm.com>

This patch create two helper functions slab_get_obj() and
slab_put_obj() to replace duplicated code in mm/slab.c

Signed-off-by: Matthew Dobson <colpatch@us.ibm.com>
Acked-by: Manfred Spraul <manfred@colorfullife.com>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 mm/slab.c |   77 ++++++++++++++++++++++++++++++++------------------------------
 1 file changed, 40 insertions(+), 37 deletions(-)

Index: 2.6/mm/slab.c
===================================================================
--- 2.6.orig/mm/slab.c
+++ 2.6/mm/slab.c
@@ -2196,6 +2196,42 @@ static void kmem_flagcheck(kmem_cache_t 
 	}
 }
 
+static void *slab_get_obj(kmem_cache_t *cachep, struct slab *slabp, int nodeid)
+{
+	void *objp = slabp->s_mem + (slabp->free * cachep->buffer_size);
+	kmem_bufctl_t next;
+
+	slabp->inuse++;
+	next = slab_bufctl(slabp)[slabp->free];
+#if DEBUG
+	slab_bufctl(slabp)[slabp->free] = BUFCTL_FREE;
+	WARN_ON(slabp->nodeid != nodeid);
+#endif
+	slabp->free = next;
+
+	return objp;
+}
+
+static void slab_put_obj(kmem_cache_t *cachep, struct slab *slabp, void *objp,
+			  int nodeid)
+{
+	unsigned int objnr = (objp - slabp->s_mem) / cachep->buffer_size;
+
+#if DEBUG
+	/* Verify that the slab belongs to the intended node */
+	WARN_ON(slabp->nodeid != nodeid);
+
+	if (slab_bufctl(slabp)[objnr] != BUFCTL_FREE) {
+		printk(KERN_ERR "slab: double free detected in cache "
+		       "'%s', objp %p\n", cachep->name, objp);
+		BUG();
+	}
+#endif
+	slab_bufctl(slabp)[objnr] = slabp->free;
+	slabp->free = objnr;
+	slabp->inuse--;
+}
+
 static void set_slab_attr(kmem_cache_t *cachep, struct slab *slabp, void *objp)
 {
 	int i;
@@ -2474,22 +2510,12 @@ retry:
 		check_slabp(cachep, slabp);
 		check_spinlock_acquired(cachep);
 		while (slabp->inuse < cachep->num && batchcount--) {
-			kmem_bufctl_t next;
 			STATS_INC_ALLOCED(cachep);
 			STATS_INC_ACTIVE(cachep);
 			STATS_SET_HIGH(cachep);
 
-			/* get obj pointer */
-			ac->entry[ac->avail++] = slabp->s_mem +
-				slabp->free*cachep->buffer_size;
-
-			slabp->inuse++;
-			next = slab_bufctl(slabp)[slabp->free];
-#if DEBUG
-			slab_bufctl(slabp)[slabp->free] = BUFCTL_FREE;
-			WARN_ON(numa_node_id() != slabp->nodeid);
-#endif
-		       	slabp->free = next;
+			ac->entry[ac->avail++] = slab_get_obj(cachep, slabp,
+							    numa_node_id());
 		}
 		check_slabp(cachep, slabp);
 
@@ -2621,7 +2647,6 @@ static void *__cache_alloc_node(kmem_cac
  	struct slab *slabp;
  	struct kmem_list3 *l3;
  	void *obj;
- 	kmem_bufctl_t next;
  	int x;
 
  	l3 = cachep->nodelists[nodeid];
@@ -2647,14 +2672,7 @@ retry:
 
  	BUG_ON(slabp->inuse == cachep->num);
 
- 	/* get obj pointer */
- 	obj =  slabp->s_mem + slabp->free*cachep->buffer_size;
- 	slabp->inuse++;
- 	next = slab_bufctl(slabp)[slabp->free];
-#if DEBUG
- 	slab_bufctl(slabp)[slabp->free] = BUFCTL_FREE;
-#endif
- 	slabp->free = next;
+	obj = slab_get_obj(cachep, slabp, nodeid);
  	check_slabp(cachep, slabp);
  	l3->free_objects--;
  	/* move slabp to correct slabp list: */
@@ -2693,29 +2711,14 @@ static void free_block(kmem_cache_t *cac
 	for (i = 0; i < nr_objects; i++) {
 		void *objp = objpp[i];
 		struct slab *slabp;
-		unsigned int objnr;
 
 		slabp = page_get_slab(virt_to_page(objp));
 		l3 = cachep->nodelists[node];
 		list_del(&slabp->list);
-		objnr = (objp - slabp->s_mem) / cachep->buffer_size;
 		check_spinlock_acquired_node(cachep, node);
 		check_slabp(cachep, slabp);
-
-#if DEBUG
-		/* Verify that the slab belongs to the intended node */
-		WARN_ON(slabp->nodeid != node);
-
-		if (slab_bufctl(slabp)[objnr] != BUFCTL_FREE) {
-			printk(KERN_ERR "slab: double free detected in cache "
-					"'%s', objp %p\n", cachep->name, objp);
-			BUG();
-		}
-#endif
-		slab_bufctl(slabp)[objnr] = slabp->free;
-		slabp->free = objnr;
+		slab_put_obj(cachep, slabp, objp, node);
 		STATS_DEC_ACTIVE(cachep);
-		slabp->inuse--;
 		l3->free_objects++;
 		check_slabp(cachep, slabp);
 

--


