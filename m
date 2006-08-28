Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWH1Fd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWH1Fd5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 01:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbWH1Fd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 01:33:57 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:65453 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750763AbWH1Fd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 01:33:56 -0400
Date: Sun, 27 Aug 2006 22:33:28 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
cc: Marcelo Tosatti <marcelo@kvack.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Andi Kleen <ak@suse.de>, mpm@selenic.com,
       Manfred Spraul <manfred@colorfullife.com>, Dave Chinner <dgc@sgi.com>
Subject: Re: [MODSLAB 2/4] A slab allocator: SLABIFIER
In-Reply-To: <20060827023256.14731.24569.sendpatchset@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.64.0608272232130.24179@schroedinger.engr.sgi.com>
References: <20060827023245.14731.23294.sendpatchset@schroedinger.engr.sgi.com>
 <20060827023256.14731.24569.sendpatchset@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some fixups. Clean up #ifdefs and use the right list function to go 
through the slabs:

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.18-rc4-mm3/mm/slabifier.c
===================================================================
--- linux-2.6.18-rc4-mm3.orig/mm/slabifier.c	2006-08-26 19:10:49.594764694 -0700
+++ linux-2.6.18-rc4-mm3/mm/slabifier.c	2006-08-27 22:31:24.188711553 -0700
@@ -112,12 +112,12 @@ static __always_inline void dec_object_c
 static __always_inline void set_object_counter(struct page *page,
 							int counter)
 {
-	(*object_counter(page))= counter;
+	*object_counter(page) = counter;
 }
 
 static __always_inline int get_object_counter(struct page *page)
 {
-	return (*object_counter(page));
+	return *object_counter(page);
 }
 
 /*
@@ -168,60 +168,58 @@ static __always_inline int lock_and_del_
 	return 0;
 }
 
-struct page *numa_search(struct slab *s, int node)
-{
+/*
+ * Get a partial page, lock it and return it.
+ */
 #ifdef CONFIG_NUMA
-	struct list_head *h;
+static struct page *get_partial(struct slab *s, int node)
+{
 	struct page *page;
+	int searchnode = (node == -1) ? numa_node_id() : node;
 
+	spin_lock(&s->list_lock);
 	/*
 	 * Search for slab on the right node
 	 */
-
-	if (node == -1)
-		node =  numa_node_id();
-
-	list_for_each(h, &s->partial) {
-		page = container_of(h, struct page, lru);
-
-		if (likely(page_to_nid(page) == node) &&
+	list_for_each_entry(page, &s->partial, lru)
+		if (likely(page_to_nid(page) == searchnode) &&
 			lock_and_del_slab(s, page))
-				return page;
+				goto out;
+
+	if (likely(node == -1)) {
+		/*
+		 * We can fall back to any other node in order to
+		 * reduce the size of the partial list.
+		 */
+		list_for_each_entry(page, &s->partial, lru)
+			if (likely(lock_and_del_slab(s, page)))
+				goto out;
 	}
-#endif
-	return NULL;
-}
 
-/*
- * Get a partial page, lock it and return it.
- */
+	/* Nothing found */
+	page = NULL;
+out:
+	spin_unlock(&s->list_lock);
+	return page;
+}
+#else
 static struct page *get_partial(struct slab *s, int node)
 {
 	struct page *page;
-	struct list_head *h;
 
 	spin_lock(&s->list_lock);
-
-	page = numa_search(s, node);
-	if (page)
-		goto out;
-#ifdef CONFIG_NUMA
-	if (node >= 0)
-		goto fail;
-#endif
-
-	list_for_each(h, &s->partial) {
-		page = container_of(h, struct page, lru);
-
+	list_for_each_entry(page, &s->partial, lru)
 		if (likely(lock_and_del_slab(s, page)))
 			goto out;
-	}
-fail:
+
+	/* No slab or all slabs busy */
 	page = NULL;
 out:
 	spin_unlock(&s->list_lock);
 	return page;
 }
+#endif
+
 
 /*
  * Debugging checks
@@ -758,8 +756,7 @@ dumpret:
 		goto out_unlock;
 
 	if (unlikely(get_object_counter(page) == 0)) {
-		if (s->objects > 1)
-			remove_partial(s, page);
+		remove_partial(s, page);
 		check_free_chain(s, page);
 		slab_unlock(page);
 		discard_slab(s, page);
@@ -908,6 +905,7 @@ static int slab_shrink(struct slab_cache
 		 * This will put the slab on the front of the partial
 		 * list, the used list or free it.
 		 */
+		ClearPageActive(page);
 		putback_slab(s, page);
 	}
 	local_irq_restore(flags);
@@ -957,15 +955,12 @@ static int slab_destroy(struct slab_cach
 static unsigned long count_objects(struct slab *s, struct list_head *list)
 {
 	int count = 0;
-	struct list_head *h;
+	struct page *page;
 	unsigned long flags;
 
 	spin_lock_irqsave(&s->list_lock, flags);
-	list_for_each(h, list) {
-		struct page *page = lru_to_first_page(h);
-
+	list_for_each_entry(page, list, lru)
 		count += get_object_counter(page);
-	}
 	spin_unlock_irqrestore(&s->list_lock, flags);
 	return count;
 }
@@ -975,23 +970,21 @@ static unsigned long slab_objects(struct
 	unsigned long *p_partial)
 {
 	struct slab *s = (void *)sc;
-	int partial;
+	int partial = count_objects(s, &s->partial);
+	int nr_slabs = atomic_read(&s->nr_slabs);
 	int active = 0;		/* Active slabs */
 	int nr_active = 0;	/* Objects in active slabs */
 	int cpu;
-	int nr_slabs = atomic_read(&s->nr_slabs);
 
 	for_each_possible_cpu(cpu) {
 		struct page *page = s->active[cpu];
 
-		if (s->active[cpu]) {
+		if (page) {
 			nr_active++;
 			active += get_object_counter(page);
 		}
 	}
 
-	partial = count_objects(s, &s->partial);
-
 	if (p_partial)
 		*p_partial = s->nr_partial;
 

