Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932561AbWGBSou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932561AbWGBSou (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 14:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932641AbWGBSou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 14:44:50 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:20199 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S932561AbWGBSos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 14:44:48 -0400
Subject: [RFC][PATCH] mm: concurrent page-cache
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Nick Piggin <npiggin@suse.de>
Cc: linux-mm <linux-mm@kvack.org>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sun, 02 Jul 2006 20:44:12 +0200
Message-Id: <1151865852.23132.12.camel@taijtu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

here my current attempts at a concurrent page-cache. It applies on top
if Nick's latest lockless page-cache patch. It is very much a
work-in-progress. It may eat your data. I post with the hopes of getting
some feedback.

I've ran it on a SMP qemu and found that it currently live-locks in
find_get_pages_tag(). It seems to be the case that a concurrent
radix_tree_tag_clear()/radix_tree_delete() removed the 'last' entry for
a gang lookup, which makes find_get_pages_tag() loop forever since it
requires progress.

If this is indeed the case, it seems to me the lockless page-cache patch
might be susceptible to this same problem.

I still have to investigate fully, but I might not have time to look
into it until after Ottawa.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

---
 fs/buffer.c                |    4 
 include/linux/page-flags.h |    2 
 include/linux/pagemap.h    |   21 +--
 include/linux/radix-tree.h |    6 
 lib/radix-tree.c           |  314 +++++++++++++++++++++++++++++++++------------
 mm/filemap.c               |   41 +++--
 mm/migrate.c               |   27 ++-
 mm/page-writeback.c        |   22 +--
 mm/swap_state.c            |   17 +-
 mm/swapfile.c              |    5 
 mm/truncate.c              |    7 -
 mm/vmscan.c                |   10 -
 12 files changed, 323 insertions(+), 153 deletions(-)

Index: linux-2.6.17-crt/include/linux/radix-tree.h
===================================================================
--- linux-2.6.17-crt.orig/include/linux/radix-tree.h
+++ linux-2.6.17-crt/include/linux/radix-tree.h
@@ -25,6 +25,7 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/rcupdate.h>
+#include <linux/spinlock.h>
 
 /*** radix-tree API starts here ***/
 
@@ -32,12 +33,14 @@ struct radix_tree_root {
 	unsigned int		height;
 	gfp_t			gfp_mask;
 	struct radix_tree_node	*rnode;
+	spinlock_t		lock;
 };
 
 #define RADIX_TREE_INIT(mask)	{					\
 	.height = 0,							\
 	.gfp_mask = (mask),						\
 	.rnode = NULL,							\
+	.lock = SPIN_LOCK_UNLOCKED,					\
 }
 
 #define RADIX_TREE(name, mask) \
@@ -48,6 +51,7 @@ do {									\
 	(root)->height = 0;						\
 	(root)->gfp_mask = (mask);					\
 	(root)->rnode = NULL;						\
+	spin_lock_init(&(root)->lock);					\
 } while (0)
 
 #define RADIX_TREE_MAX_TAGS 2
@@ -116,7 +120,7 @@ static inline void radix_tree_replace_sl
 
 int radix_tree_insert(struct radix_tree_root *, unsigned long, void *);
 void *radix_tree_lookup(struct radix_tree_root *, unsigned long);
-void **radix_tree_lookup_slot(struct radix_tree_root *, unsigned long);
+void **radix_tree_lookup_slot(struct radix_tree_root *, unsigned long, spinlock_t **);
 void *radix_tree_delete(struct radix_tree_root *, unsigned long);
 unsigned int
 radix_tree_gang_lookup(struct radix_tree_root *root, void **results,
Index: linux-2.6.17-crt/lib/radix-tree.c
===================================================================
--- linux-2.6.17-crt.orig/lib/radix-tree.c
+++ linux-2.6.17-crt/lib/radix-tree.c
@@ -32,6 +32,7 @@
 #include <linux/string.h>
 #include <linux/bitops.h>
 #include <linux/rcupdate.h>
+#include <linux/spinlock.h>
 
 
 #ifdef __KERNEL__
@@ -52,11 +53,33 @@ struct radix_tree_node {
 	struct rcu_head	rcu_head;
 	void		*slots[RADIX_TREE_MAP_SIZE];
 	unsigned long	tags[RADIX_TREE_MAX_TAGS][RADIX_TREE_TAG_LONGS];
+	spinlock_t	lock;
 };
 
+/*
+ * radix_node_lock() - return a pointer to a spinlock or NULL.
+ *
+ * This function allows for alternate node lock mappings.
+ *
+ * The trivial case of returning NULL will reduce the locking to the root lock
+ * only, i.e. mutual exclusion for modifying operations.
+ *
+ * Another possible mapping is one lock per tree level, which would give a
+ * sort of pipelined serialisation.
+ *
+ * The current mapping is one lock per node, gives best concurrency, takes most
+ * memory.
+ */
+static inline spinlock_t * radix_node_lock(struct radix_tree_root *root,
+		struct radix_tree_node *node)
+{
+	return &node->lock;
+}
+
 struct radix_tree_path {
 	struct radix_tree_node *node;
 	int offset;
+	spinlock_t *lock;
 };
 
 #define RADIX_TREE_INDEX_BITS  (8 /* CHAR_BIT */ * sizeof(unsigned long))
@@ -177,6 +200,22 @@ static inline int any_tag_set(struct rad
 	return 0;
 }
 
+static inline int any_tag_set_but(struct radix_tree_node *node,
+		unsigned int tag, int offset)
+{
+	int idx;
+	int offset_idx = offset / BITS_PER_LONG;
+	unsigned long offset_mask = ~(1 << (offset % BITS_PER_LONG));
+	for (idx = 0; idx < RADIX_TREE_TAG_LONGS; idx++) {
+		unsigned long mask = ~0UL;
+		if (idx == offset_idx)
+			mask = offset_mask;
+		if (node->tags[tag][idx] & mask)
+			return 1;
+	}
+	return 0;
+}
+
 /*
  *	Return the maximum key which can be store into a
  *	radix tree with height HEIGHT.
@@ -254,14 +293,19 @@ int radix_tree_insert(struct radix_tree_
 	struct radix_tree_node *node = NULL, *slot;
 	unsigned int height, shift;
 	int offset;
-	int error;
+	int error = 0;
+	spinlock_t *hlock, *llock = &root->lock;
+	int tag;
+	unsigned long flags;
+
+	spin_lock_irqsave(llock, flags);
 
 	/* Make sure the tree is high enough.  */
 	if ((!index && !root->rnode) ||
 			index > radix_tree_maxindex(root->height)) {
 		error = radix_tree_extend(root, index);
 		if (error)
-			return error;
+			goto out;
 	}
 
 	slot = root->rnode;
@@ -272,8 +316,10 @@ int radix_tree_insert(struct radix_tree_
 	do {
 		if (slot == NULL) {
 			/* Have to add a child node.  */
-			if (!(slot = radix_tree_node_alloc(root)))
-				return -ENOMEM;
+			if (!(slot = radix_tree_node_alloc(root))) {
+				error = -ENOMEM;
+				goto out;
+			}
 			slot->height = height;
 			if (node) {
 				rcu_assign_pointer(node->slots[offset], slot);
@@ -285,21 +331,36 @@ int radix_tree_insert(struct radix_tree_
 		/* Go a level down */
 		offset = (index >> shift) & RADIX_TREE_MAP_MASK;
 		node = slot;
+
+		hlock = llock;
+		llock = radix_node_lock(root, node);
+		if (llock) {
+			spin_lock(llock);
+			spin_unlock(hlock);
+		}
+
 		slot = node->slots[offset];
 		shift -= RADIX_TREE_MAP_SHIFT;
 		height--;
 	} while (height > 0);
 
-	if (slot != NULL)
-		return -EEXIST;
+	if (slot != NULL) {
+		error = -EEXIST;
+		goto out;
+	}
 
 	BUG_ON(!node);
 	node->count++;
 	rcu_assign_pointer(node->slots[offset], item);
-	BUG_ON(tag_get(node, 0, offset));
-	BUG_ON(tag_get(node, 1, offset));
+	for (tag = 0; tag < RADIX_TREE_MAX_TAGS; tag++)
+		BUG_ON(tag_get(node, tag, offset));
 
-	return 0;
+out:
+	if (!llock)
+		llock = &root->lock;
+
+	spin_unlock_irqrestore(llock, flags);
+	return error;
 }
 EXPORT_SYMBOL(radix_tree_insert);
 
@@ -314,21 +375,31 @@ EXPORT_SYMBOL(radix_tree_insert);
  *	This function cannot be called under rcu_read_lock, it must be
  *	excluded from writers, as must the returned slot.
  */
-void **radix_tree_lookup_slot(struct radix_tree_root *root, unsigned long index)
+void **radix_tree_lookup_slot(struct radix_tree_root *root, unsigned long index, spinlock_t **lock)
 {
 	unsigned int height, shift;
-	struct radix_tree_node **slot;
+	struct radix_tree_node **slot = NULL;
+	spinlock_t *hlock, *llock = &root->lock;
+
+	spin_lock(llock);
 
 	height = root->height;
 	if (index > radix_tree_maxindex(height))
-		return NULL;
+		goto out;
 
 	shift = (height-1) * RADIX_TREE_MAP_SHIFT;
 	slot = &root->rnode;
 
 	while (height > 0) {
 		if (*slot == NULL)
-			return NULL;
+			goto out;
+
+		hlock = llock;
+		llock = radix_node_lock(root, *slot);
+		if (llock) {
+			spin_lock(llock);
+			spin_unlock(hlock);
+		}
 
 		slot = (struct radix_tree_node **)
 			((*slot)->slots +
@@ -337,6 +408,17 @@ void **radix_tree_lookup_slot(struct rad
 		height--;
 	}
 
+out:
+	if (!llock)
+		llock = &root->lock;
+
+	if (slot && *slot) {
+		*lock = llock;
+	} else {
+		spin_unlock(llock);
+		*lock = NULL;
+		slot = NULL;
+	}
 	return (void **)slot;
 }
 EXPORT_SYMBOL(radix_tree_lookup_slot);
@@ -400,17 +482,27 @@ void *radix_tree_tag_set(struct radix_tr
 			unsigned long index, unsigned int tag)
 {
 	unsigned int height, shift;
-	struct radix_tree_node *slot;
+	struct radix_tree_node *slot = NULL;
+	unsigned long flags;
+	spinlock_t *hlock, *llock = &root->lock;
+
+	spin_lock_irqsave(llock, flags);
 
 	height = root->height;
-	if (index > radix_tree_maxindex(height))
-		return NULL;
+	BUG_ON(index > radix_tree_maxindex(height));
 	shift = (height - 1) * RADIX_TREE_MAP_SHIFT;
 	slot = root->rnode;
 
 	while (height > 0) {
 		int offset;
 
+		hlock = llock;
+		llock = radix_node_lock(root, slot);
+		if (llock) {
+			spin_lock(llock);
+			spin_unlock(hlock);
+		}
+
 		offset = (index >> shift) & RADIX_TREE_MAP_MASK;
 		if (!tag_get(slot, tag, offset))
 			tag_set(slot, tag, offset);
@@ -420,6 +512,9 @@ void *radix_tree_tag_set(struct radix_tr
 		height--;
 	}
 
+	if (!llock)
+		llock = &root->lock;
+	spin_unlock_irqrestore(llock, flags);
 	return slot;
 }
 EXPORT_SYMBOL(radix_tree_tag_set);
@@ -441,48 +536,79 @@ EXPORT_SYMBOL(radix_tree_tag_set);
 void *radix_tree_tag_clear(struct radix_tree_root *root,
 			unsigned long index, unsigned int tag)
 {
-	struct radix_tree_path path[RADIX_TREE_MAX_PATH], *pathp = path;
-	struct radix_tree_node *slot;
+	struct radix_tree_path path[RADIX_TREE_MAX_PATH];
+	struct radix_tree_path *pathp = path, *punlock = path, *piter;
+	struct radix_tree_node *slot = NULL;
 	unsigned int height, shift;
-	void *ret = NULL;
+	unsigned long flags;
+	spinlock_t *lock = &root->lock;
+
+	spin_lock_irqsave(lock, flags);
+
+	pathp->node = NULL;
+	pathp->lock = lock;
 
 	height = root->height;
 	if (index > radix_tree_maxindex(height))
 		goto out;
 
 	shift = (height - 1) * RADIX_TREE_MAP_SHIFT;
-	pathp->node = NULL;
 	slot = root->rnode;
 
 	while (height > 0) {
 		int offset;
+		int parent_tag = 0;
 
 		if (slot == NULL)
 			goto out;
 
+		if (pathp->node)
+			parent_tag = tag_get(pathp->node, tag, pathp->offset);
+
+		lock = radix_node_lock(root, slot);
+		if (lock)
+			spin_lock(lock);
+
 		offset = (index >> shift) & RADIX_TREE_MAP_MASK;
-		pathp[1].offset = offset;
-		pathp[1].node = slot;
-		slot = slot->slots[offset];
 		pathp++;
+		pathp->offset = offset;
+		pathp->node = slot;
+		pathp->lock = lock;
+
+		/*
+		 * If the parent node does not have the tag set or the current
+		 * node has slots with the tag set other than the one we're
+		 * potentially clearing, the change can never propagate upwards
+		 * from here.
+		 */
+		if (lock && (!parent_tag || any_tag_set_but(slot, tag, offset))) {
+			for (; punlock < pathp; punlock++) {
+				BUG_ON(!punlock->lock);
+				spin_unlock(punlock->lock);
+				punlock->lock = NULL;
+			}
+		}
+
+		slot = slot->slots[offset];
 		shift -= RADIX_TREE_MAP_SHIFT;
 		height--;
 	}
 
-	ret = slot;
-	if (ret == NULL)
+	if (slot == NULL)
 		goto out;
 
-	do {
-		if (!tag_get(pathp->node, tag, pathp->offset))
-			goto out;
-		tag_clear(pathp->node, tag, pathp->offset);
-		if (any_tag_set(pathp->node, tag))
-			goto out;
-		pathp--;
-	} while (pathp->node);
+	for (piter = pathp; piter >= punlock; piter--) {
+		BUG_ON(!punlock->lock);
+		if (piter->node)
+			tag_clear(piter->node, tag, piter->offset);
+	}
 out:
-	return ret;
+	for (; punlock <= pathp; punlock++) {
+		if (punlock->lock)
+			spin_unlock(punlock->lock);
+	}
+	local_irq_restore(flags);
+	return slot;
 }
 EXPORT_SYMBOL(radix_tree_tag_clear);
 
@@ -773,6 +899,7 @@ static inline void radix_tree_shrink(str
 			root->rnode->slots[0]) {
 		struct radix_tree_node *to_free = root->rnode;
 		void *newptr;
+		int tag;
 
 		/*
 		 * We don't need rcu_assign_pointer(), since we are simply
@@ -785,11 +912,10 @@ static inline void radix_tree_shrink(str
 		root->rnode = newptr;
 		root->height--;
 		/* must only free zeroed nodes into the slab */
-		tag_clear(to_free, 0, 0);
-		tag_clear(to_free, 1, 0);
+		for (tag = 0; tag < RADIX_TREE_MAX_TAGS; tag++)
+			tag_clear(to_free, tag, 0);
 		to_free->slots[0] = NULL;
 		to_free->count = 0;
-		radix_tree_node_free(to_free);
 	}
 }
 
@@ -804,39 +930,71 @@ static inline void radix_tree_shrink(str
  */
 void *radix_tree_delete(struct radix_tree_root *root, unsigned long index)
 {
-	struct radix_tree_path path[RADIX_TREE_MAX_PATH], *pathp = path;
+	struct radix_tree_path path[RADIX_TREE_MAX_PATH];
+	struct radix_tree_path *pathp = path, *punlock = path, *piter;
 	struct radix_tree_path *orig_pathp;
-	struct radix_tree_node *slot;
-	struct radix_tree_node *to_free;
+	struct radix_tree_node *slot = NULL;
 	unsigned int height, shift;
-	void *ret = NULL;
-	char tags[RADIX_TREE_MAX_TAGS];
-	int nr_cleared_tags;
 	int tag;
-	int offset;
+	int offset = 0;
+	unsigned long flags;
+	spinlock_t *lock = &root->lock;
+
+	spin_lock_irqsave(lock, flags);
 
+	pathp->lock = lock;
+	pathp->node = NULL;
 	height = root->height;
 	if (index > radix_tree_maxindex(height))
 		goto out;
 
 	shift = (height - 1) * RADIX_TREE_MAP_SHIFT;
-	pathp->node = NULL;
 	slot = root->rnode;
 
 	for ( ; height > 0; height--) {
+		int parent_tags = 0;
+		int no_tags = 0;
+
 		if (slot == NULL)
 			goto out;
 
+		lock = radix_node_lock(root, slot);
+		if (lock)
+			spin_lock(lock);
+
+		for (tag = 0; tag < RADIX_TREE_MAX_TAGS; tag++) {
+			if (pathp->node)
+				parent_tags |= tag_get(pathp->node, tag, pathp->offset);
+
+			no_tags |= !any_tag_set_but(slot, tag, offset);
+		}
+
 		pathp++;
 		offset = (index >> shift) & RADIX_TREE_MAP_MASK;
 		pathp->offset = offset;
 		pathp->node = slot;
+		pathp->lock = lock;
+
+		/*
+		 * If the parent node does not have any tag set or the current
+		 * node has slots with the tags set other than the one we're
+		 * potentially clearing AND there are mode children than just us,
+		 * the changes can never propagate upwards from here.
+		 */
+		if (lock && (!parent_tags || !no_tags) &&
+				slot->count > 1+(!pathp->offset)) {
+			for (; punlock < pathp; punlock++) {
+				BUG_ON(!punlock->lock);
+				spin_unlock(punlock->lock);
+				punlock->lock = NULL;
+			}
+		}
+
 		slot = slot->slots[offset];
 		shift -= RADIX_TREE_MAP_SHIFT;
 	}
 
-	ret = slot;
-	if (ret == NULL)
+	if (slot == NULL)
 		goto out;
 
 	orig_pathp = pathp;
@@ -844,54 +1002,45 @@ void *radix_tree_delete(struct radix_tre
 	/*
 	 * Clear all tags associated with the just-deleted item
 	 */
-	nr_cleared_tags = 0;
 	for (tag = 0; tag < RADIX_TREE_MAX_TAGS; tag++) {
-		tags[tag] = 1;
-		if (tag_get(pathp->node, tag, pathp->offset)) {
-			tag_clear(pathp->node, tag, pathp->offset);
-			if (!any_tag_set(pathp->node, tag)) {
-				tags[tag] = 0;
-				nr_cleared_tags++;
+		for (piter = pathp; piter >= punlock; piter--) {
+			if (piter->node) {
+				if (!tag_get(piter->node, tag, piter->offset))
+					break;
+				tag_clear(piter->node, tag, piter->offset);
+				if (any_tag_set(piter->node, tag))
+					break;
 			}
 		}
 	}
 
-	for (pathp--; nr_cleared_tags && pathp->node; pathp--) {
-		for (tag = 0; tag < RADIX_TREE_MAX_TAGS; tag++) {
-			if (tags[tag])
-				continue;
-
-			tag_clear(pathp->node, tag, pathp->offset);
-			if (any_tag_set(pathp->node, tag)) {
-				tags[tag] = 1;
-				nr_cleared_tags--;
-			}
-		}
-	}
-
-	to_free = NULL;
-	/* Now free the nodes we do not need anymore */
-	for (pathp = orig_pathp; pathp->node; pathp--) {
-		pathp->node->slots[pathp->offset] = NULL;
-		pathp->node->count--;
-		if (to_free)
-			radix_tree_node_free(to_free);
+	/*
+	 * Now unhook the nodes we do not need any more.
+	 */
+	for (piter = pathp; piter >= punlock && piter->node; piter--) {
+		piter->node->slots[piter->offset] = NULL;
+		piter->node->count--;
 
-		if (pathp->node->count) {
-			if (pathp->node == root->rnode)
+		if (piter->node->count) {
+			if (piter->node == root->rnode)
 				radix_tree_shrink(root);
 			goto out;
 		}
-
-		/* Node with zero slots in use so free it */
-		to_free = pathp->node;
 	}
+
+	BUG_ON(punlock->node || !punlock->lock);
+
 	root->rnode = NULL;
 	root->height = 0;
-	if (to_free)
-		radix_tree_node_free(to_free);
 out:
-	return ret;
+	for (; punlock <= pathp; punlock++) {
+		if (punlock->lock)
+			spin_unlock(punlock->lock);
+		if (punlock->node && punlock->node->count == 0)
+			radix_tree_node_free(punlock->node);
+	}
+	local_irq_restore(flags);
+	return slot;
 }
 EXPORT_SYMBOL(radix_tree_delete);
 
@@ -914,6 +1063,7 @@ static void
 radix_tree_node_ctor(void *node, kmem_cache_t *cachep, unsigned long flags)
 {
 	memset(node, 0, sizeof(struct radix_tree_node));
+	spin_lock_init(&((struct radix_tree_node *)node)->lock);
 }
 
 static __init unsigned long __maxindex(unsigned int height)
Index: linux-2.6.17-crt/fs/buffer.c
===================================================================
--- linux-2.6.17-crt.orig/fs/buffer.c
+++ linux-2.6.17-crt/fs/buffer.c
@@ -851,7 +851,7 @@ int __set_page_dirty_buffers(struct page
 	spin_unlock(&mapping->private_lock);
 
 	if (!TestSetPageDirty(page)) {
-		spin_lock_irq(&mapping->tree_lock);
+		LockPageNoNewRefs(page);
 		if (page->mapping) {	/* Race with truncate? */
 			if (mapping_cap_account_dirty(mapping))
 				inc_page_state(nr_dirty);
@@ -859,7 +859,7 @@ int __set_page_dirty_buffers(struct page
 						page_index(page),
 						PAGECACHE_TAG_DIRTY);
 		}
-		spin_unlock_irq(&mapping->tree_lock);
+		UnlockPageNoNewRefs(page);
 		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
 		return 1;
 	}
Index: linux-2.6.17-crt/include/linux/page-flags.h
===================================================================
--- linux-2.6.17-crt.orig/include/linux/page-flags.h
+++ linux-2.6.17-crt/include/linux/page-flags.h
@@ -363,6 +363,8 @@ extern void __mod_page_state_offset(unsi
 #define SetPageNoNewRefs(page)	set_bit(PG_nonewrefs, &(page)->flags)
 #define ClearPageNoNewRefs(page) clear_bit(PG_nonewrefs, &(page)->flags)
 #define __ClearPageNoNewRefs(page) __clear_bit(PG_nonewrefs, &(page)->flags)
+#define LockPageNoNewRefs(page)	bit_spin_lock(PG_nonewrefs, &(page)->flags)
+#define UnlockPageNoNewRefs(page) bit_spin_unlock(PG_nonewrefs, &(page)->flags)
 
 struct page;	/* forward declaration */
 
Index: linux-2.6.17-crt/mm/filemap.c
===================================================================
--- linux-2.6.17-crt.orig/mm/filemap.c
+++ linux-2.6.17-crt/mm/filemap.c
@@ -30,6 +30,7 @@
 #include <linux/security.h>
 #include <linux/syscalls.h>
 #include <linux/cpuset.h>
+#include <linux/bit_spinlock.h>
 #include "filemap.h"
 #include "internal.h"
 
@@ -119,19 +120,19 @@ void __remove_from_page_cache(struct pag
 
 	radix_tree_delete(&mapping->page_tree, page->index);
 	page->mapping = NULL;
+	spin_lock_irq(&mapping->tree_lock);
 	mapping->nrpages--;
 	pagecache_acct(-1);
+	spin_unlock_irq(&mapping->tree_lock);
 }
 
 void remove_from_page_cache(struct page *page)
 {
-	struct address_space *mapping = page->mapping;
-
 	BUG_ON(!PageLocked(page));
 
-	spin_lock_irq(&mapping->tree_lock);
+	LockPageNoNewRefs(page);
 	__remove_from_page_cache(page);
-	spin_unlock_irq(&mapping->tree_lock);
+	UnlockPageNoNewRefs(page);
 }
 
 static int sync_page(void *word)
@@ -412,8 +413,10 @@ static int add_to_page_cache_nolock(stru
 	error = radix_tree_insert(&mapping->page_tree, offset, page);
 
 	if (!error) {
+		spin_lock_irq(&mapping->tree_lock);
 		mapping->nrpages++;
 		pagecache_acct(1);
+		spin_unlock_irq(&mapping->tree_lock);
 	} else {
 		page->mapping = NULL;
 		__ClearPageLocked(page);
@@ -436,9 +439,9 @@ int add_to_page_cache(struct page *page,
 	int error = radix_tree_preload(gfp_mask & ~__GFP_HIGHMEM);
 
 	if (error == 0) {
-		spin_lock_irq(&mapping->tree_lock);
+		LockPageNoNewRefs(page);
 		error = add_to_page_cache_nolock(page, mapping, offset);
-		spin_unlock_irq(&mapping->tree_lock);
+		UnlockPageNoNewRefs(page);
 
 		radix_tree_preload_end();
 	}
@@ -456,9 +459,8 @@ int __add_to_page_cache(struct page *pag
 	int error = radix_tree_preload(gfp_mask & ~__GFP_HIGHMEM);
 
 	if (error == 0) {
-		SetPageNoNewRefs(page);
+		LockPageNoNewRefs(page);
 		smp_wmb();
-		spin_lock_irq(&mapping->tree_lock);
 
 		error = radix_tree_insert(&mapping->page_tree, offset, page);
 		if (!error) {
@@ -466,13 +468,15 @@ int __add_to_page_cache(struct page *pag
 			SetPageLocked(page);
 			page->mapping = mapping;
 			page->index = offset;
+
+			spin_lock_irq(&mapping->tree_lock);
 			mapping->nrpages++;
 			pagecache_acct(1);
+			spin_unlock_irq(&mapping->tree_lock);
 		}
 
-		spin_unlock_irq(&mapping->tree_lock);
 		smp_wmb();
-		ClearPageNoNewRefs(page);
+		UnlockPageNoNewRefs(page);
 		radix_tree_preload_end();
 	}
 	return error;
@@ -629,13 +633,20 @@ EXPORT_SYMBOL(find_get_page);
  */
 struct page *find_trylock_page(struct address_space *mapping, unsigned long offset)
 {
-	struct page *page;
-
-	spin_lock_irq(&mapping->tree_lock);
-	page = radix_tree_lookup(&mapping->page_tree, offset);
+	struct page *page = NULL;
+	struct page **radix_pointer;
+	spinlock_t *lock;
+
+	local_irq_disable();
+	radix_pointer = (struct page **)radix_tree_lookup_slot(
+			&mapping->page_tree, offset, &lock);
+	if (radix_pointer)
+		page = radix_tree_deref_slot(radix_pointer);
 	if (page && TestSetPageLocked(page))
 		page = NULL;
-	spin_unlock_irq(&mapping->tree_lock);
+	if (lock)
+		spin_unlock(lock);
+	local_irq_enable();
 	return page;
 }
 
Index: linux-2.6.17-crt/mm/migrate.c
===================================================================
--- linux-2.6.17-crt.orig/mm/migrate.c
+++ linux-2.6.17-crt/mm/migrate.c
@@ -25,6 +25,8 @@
 #include <linux/cpuset.h>
 #include <linux/swapops.h>
 
+#include "internal.h"
+
 /* The maximum number of pages to take off the LRU for migration */
 #define MIGRATE_CHUNK_SIZE 256
 
@@ -181,6 +183,7 @@ int migrate_page_remove_references(struc
 {
 	struct address_space *mapping = page_mapping(page);
 	struct page **radix_pointer;
+	spinlock_t *lock;
 
 	/*
 	 * Avoid doing any of the following work if the page count
@@ -196,7 +199,7 @@ int migrate_page_remove_references(struc
 	 *
 	 * In order to reestablish file backed mappings the fault handlers
 	 * will take the radix tree_lock which may then be used to stop
-  	 * processses from accessing this page until the new page is ready.
+  	 * processes from accessing this page until the new page is ready.
 	 *
 	 * A process accessing via a swap pte (an anonymous page) will take a
 	 * page_lock on the old page which will block the process until the
@@ -219,18 +222,20 @@ int migrate_page_remove_references(struc
 	if (page_mapcount(page))
 		return -EAGAIN;
 
-	SetPageNoNewRefs(page);
+	LockPageNoNewRefs(page);
 	smp_wmb();
-	spin_lock_irq(&mapping->tree_lock);
 
+	local_irq_disable();
 	radix_pointer = (struct page **)radix_tree_lookup_slot(
 						&mapping->page_tree,
-						page_index(page));
+						page_index(page), &lock);
 
 	if (!page_mapping(page) || page_count(page) != nr_refs ||
 			radix_tree_deref_slot(radix_pointer) != page) {
-		spin_unlock_irq(&mapping->tree_lock);
-		ClearPageNoNewRefs(page);
+		if (lock)
+			spin_unlock(lock);
+		local_irq_enable();
+		UnlockPageNoNewRefs(page);
 		return -EAGAIN;
 	}
 
@@ -250,15 +255,15 @@ int migrate_page_remove_references(struc
 		set_page_private(newpage, page_private(page));
 	}
 
-	SetPageNoNewRefs(newpage);
+	LockPageNoNewRefs(newpage);
 	radix_tree_replace_slot(radix_pointer, newpage);
 	page->mapping = NULL;
 
-	spin_unlock_irq(&mapping->tree_lock);
-	__put_page(page);
+	spin_unlock_irq(lock);
 	smp_wmb();
-	ClearPageNoNewRefs(page);
-	ClearPageNoNewRefs(newpage);
+	UnlockPageNoNewRefs(page);
+	UnlockPageNoNewRefs(newpage);
+	__put_page(page);
 
 	return 0;
 }
Index: linux-2.6.17-crt/mm/page-writeback.c
===================================================================
--- linux-2.6.17-crt.orig/mm/page-writeback.c
+++ linux-2.6.17-crt/mm/page-writeback.c
@@ -29,6 +29,7 @@
 #include <linux/sysctl.h>
 #include <linux/cpu.h>
 #include <linux/syscalls.h>
+#include <linux/bit_spinlock.h>
 
 /*
  * The maximum number of pages to writeout in a single bdflush/kupdate
@@ -632,7 +633,7 @@ int __set_page_dirty_nobuffers(struct pa
 		struct address_space *mapping2;
 
 		if (mapping) {
-			spin_lock_irq(&mapping->tree_lock);
+			LockPageNoNewRefs(page);
 			mapping2 = page_mapping(page);
 			if (mapping2) { /* Race with truncate? */
 				BUG_ON(mapping2 != mapping);
@@ -641,7 +642,7 @@ int __set_page_dirty_nobuffers(struct pa
 				radix_tree_tag_set(&mapping->page_tree,
 					page_index(page), PAGECACHE_TAG_DIRTY);
 			}
-			spin_unlock_irq(&mapping->tree_lock);
+			UnlockPageNoNewRefs(page);
 			if (mapping->host) {
 				/* !PageAnon && !swapper_space */
 				__mark_inode_dirty(mapping->host,
@@ -716,20 +717,19 @@ EXPORT_SYMBOL(set_page_dirty_lock);
 int test_clear_page_dirty(struct page *page)
 {
 	struct address_space *mapping = page_mapping(page);
-	unsigned long flags;
 
 	if (mapping) {
-		spin_lock_irqsave(&mapping->tree_lock, flags);
+		LockPageNoNewRefs(page);
 		if (TestClearPageDirty(page)) {
 			radix_tree_tag_clear(&mapping->page_tree,
 						page_index(page),
 						PAGECACHE_TAG_DIRTY);
-			spin_unlock_irqrestore(&mapping->tree_lock, flags);
+			UnlockPageNoNewRefs(page);
 			if (mapping_cap_account_dirty(mapping))
 				dec_page_state(nr_dirty);
 			return 1;
 		}
-		spin_unlock_irqrestore(&mapping->tree_lock, flags);
+		UnlockPageNoNewRefs(page);
 		return 0;
 	}
 	return TestClearPageDirty(page);
@@ -771,16 +771,15 @@ int test_clear_page_writeback(struct pag
 	struct address_space *mapping = page_mapping(page);
 
 	if (mapping) {
-		unsigned long flags;
 		int ret;
 
-		spin_lock_irqsave(&mapping->tree_lock, flags);
+		LockPageNoNewRefs(page);
 		ret = TestClearPageWriteback(page);
 		if (ret)
 			radix_tree_tag_clear(&mapping->page_tree,
 						page_index(page),
 						PAGECACHE_TAG_WRITEBACK);
-		spin_unlock_irqrestore(&mapping->tree_lock, flags);
+		UnlockPageNoNewRefs(page);
 		return ret;
 	}
 	return TestClearPageWriteback(page);
@@ -791,10 +790,9 @@ int test_set_page_writeback(struct page 
 	struct address_space *mapping = page_mapping(page);
 
 	if (mapping) {
-		unsigned long flags;
 		int ret;
 
-		spin_lock_irqsave(&mapping->tree_lock, flags);
+		LockPageNoNewRefs(page);
 		ret = TestSetPageWriteback(page);
 		if (!ret)
 			radix_tree_tag_set(&mapping->page_tree,
@@ -804,7 +802,7 @@ int test_set_page_writeback(struct page 
 			radix_tree_tag_clear(&mapping->page_tree,
 						page_index(page),
 						PAGECACHE_TAG_DIRTY);
-		spin_unlock_irqrestore(&mapping->tree_lock, flags);
+		UnlockPageNoNewRefs(page);
 		return ret;
 	}
 	return TestSetPageWriteback(page);
Index: linux-2.6.17-crt/mm/swap_state.c
===================================================================
--- linux-2.6.17-crt.orig/mm/swap_state.c
+++ linux-2.6.17-crt/mm/swap_state.c
@@ -16,6 +16,7 @@
 #include <linux/backing-dev.h>
 #include <linux/pagevec.h>
 #include <linux/migrate.h>
+#include <linux/bit_spinlock.h>
 
 #include <asm/pgtable.h>
 
@@ -78,9 +79,8 @@ static int __add_to_swap_cache(struct pa
 	BUG_ON(PagePrivate(page));
 	error = radix_tree_preload(gfp_mask);
 	if (!error) {
-		SetPageNoNewRefs(page);
+		LockPageNoNewRefs(page);
 		smp_wmb();
-		spin_lock_irq(&swapper_space.tree_lock);
 		error = radix_tree_insert(&swapper_space.page_tree,
 						entry.val, page);
 		if (!error) {
@@ -88,12 +88,14 @@ static int __add_to_swap_cache(struct pa
 			SetPageLocked(page);
 			SetPageSwapCache(page);
 			set_page_private(page, entry.val);
+
+			spin_lock_irq(&swapper_space.tree_lock);
 			total_swapcache_pages++;
 			pagecache_acct(1);
+			spin_unlock_irq(&swapper_space.tree_lock);
 		}
-		spin_unlock_irq(&swapper_space.tree_lock);
 		smp_wmb();
-		ClearPageNoNewRefs(page);
+		UnlockPageNoNewRefs(page);
 		radix_tree_preload_end();
 	}
 	return error;
@@ -135,9 +137,12 @@ void __delete_from_swap_cache(struct pag
 	radix_tree_delete(&swapper_space.page_tree, page_private(page));
 	set_page_private(page, 0);
 	ClearPageSwapCache(page);
+
+	spin_lock_irq(&swapper_space.tree_lock);
 	total_swapcache_pages--;
 	pagecache_acct(-1);
 	INC_CACHE_INFO(del_total);
+	spin_unlock_irq(&swapper_space.tree_lock);
 }
 
 /**
@@ -204,9 +209,9 @@ void delete_from_swap_cache(struct page 
 
 	entry.val = page_private(page);
 
-	spin_lock_irq(&swapper_space.tree_lock);
+	LockPageNoNewRefs(page);
 	__delete_from_swap_cache(page);
-	spin_unlock_irq(&swapper_space.tree_lock);
+	UnlockPageNoNewRefs(page);
 
 	swap_free(entry);
 	page_cache_release(page);
Index: linux-2.6.17-crt/mm/swapfile.c
===================================================================
--- linux-2.6.17-crt.orig/mm/swapfile.c
+++ linux-2.6.17-crt/mm/swapfile.c
@@ -28,6 +28,7 @@
 #include <linux/mutex.h>
 #include <linux/capability.h>
 #include <linux/syscalls.h>
+#include <linux/bit_spinlock.h>
 
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
@@ -368,13 +369,13 @@ int remove_exclusive_swap_page(struct pa
 	retval = 0;
 	if (p->swap_map[swp_offset(entry)] == 1) {
 		/* Recheck the page count with the swapcache lock held.. */
-		spin_lock_irq(&swapper_space.tree_lock);
+		LockPageNoNewRefs(page);
 		if ((page_count(page) == 2) && !PageWriteback(page)) {
 			__delete_from_swap_cache(page);
 			SetPageDirty(page);
 			retval = 1;
 		}
-		spin_unlock_irq(&swapper_space.tree_lock);
+		UnlockPageNoNewRefs(page);
 	}
 	spin_unlock(&swap_lock);
 
Index: linux-2.6.17-crt/mm/truncate.c
===================================================================
--- linux-2.6.17-crt.orig/mm/truncate.c
+++ linux-2.6.17-crt/mm/truncate.c
@@ -14,6 +14,7 @@
 #include <linux/pagevec.h>
 #include <linux/buffer_head.h>	/* grr. try_to_release_page,
 				   do_invalidatepage */
+#include <linux/bit_spinlock.h>
 
 
 static inline void truncate_partial_page(struct page *page, unsigned partial)
@@ -67,15 +68,15 @@ invalidate_complete_page(struct address_
 	if (PagePrivate(page) && !try_to_release_page(page, 0))
 		return 0;
 
-	spin_lock_irq(&mapping->tree_lock);
+	LockPageNoNewRefs(page);
 	if (PageDirty(page)) {
-		spin_unlock_irq(&mapping->tree_lock);
+		UnlockPageNoNewRefs(page);
 		return 0;
 	}
 
 	BUG_ON(PagePrivate(page));
 	__remove_from_page_cache(page);
-	spin_unlock_irq(&mapping->tree_lock);
+	UnlockPageNoNewRefs(page);
 	ClearPageUptodate(page);
 	page_cache_release(page);	/* pagecache ref */
 	return 1;
Index: linux-2.6.17-crt/mm/vmscan.c
===================================================================
--- linux-2.6.17-crt.orig/mm/vmscan.c
+++ linux-2.6.17-crt/mm/vmscan.c
@@ -34,6 +34,7 @@
 #include <linux/notifier.h>
 #include <linux/rwsem.h>
 #include <linux/delay.h>
+#include <linux/bit_spinlock.h>
 
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -365,9 +366,8 @@ int remove_mapping(struct address_space 
 	if (!mapping)
 		return 0;		/* truncate got there first */
 
-	SetPageNoNewRefs(page);
+	LockPageNoNewRefs(page);
 	smp_wmb();
-	spin_lock_irq(&mapping->tree_lock);
 
 	/*
 	 * The non-racy check for busy page.  It is critical to check
@@ -383,13 +383,12 @@ int remove_mapping(struct address_space 
 	if (PageSwapCache(page)) {
 		swp_entry_t swap = { .val = page_private(page) };
 		__delete_from_swap_cache(page);
-		spin_unlock_irq(&mapping->tree_lock);
 		swap_free(swap);
 		goto free_it;
 	}
 
 	__remove_from_page_cache(page);
-	spin_unlock_irq(&mapping->tree_lock);
+	UnlockPageNoNewRefs(page);
 
 free_it:
 	smp_wmb();
@@ -398,8 +397,7 @@ free_it:
 	return 1;
 
 cannot_free:
-	spin_unlock_irq(&mapping->tree_lock);
-	ClearPageNoNewRefs(page);
+	UnlockPageNoNewRefs(page);
 	return 0;
 }
 
Index: linux-2.6.17-crt/include/linux/pagemap.h
===================================================================
--- linux-2.6.17-crt.orig/include/linux/pagemap.h
+++ linux-2.6.17-crt/include/linux/pagemap.h
@@ -13,6 +13,7 @@
 #include <linux/gfp.h>
 #include <linux/page-flags.h>
 #include <linux/hardirq.h> /* for in_interrupt() */
+#include <linux/bit_spinlock.h>
 
 /*
  * Bits in mapping->flags.  The lower __GFP_BITS_SHIFT bits are the page
@@ -74,23 +75,17 @@ static inline struct page *page_cache_ge
 	atomic_inc(&page->_count);
 
 #else
-	if (unlikely(!get_page_unless_zero(page)))
-		return NULL; /* page has been freed */
-
-	/*
-	 * Note that get_page_unless_zero provides a memory barrier.
-	 * This is needed to ensure PageNoNewRefs is evaluated after the
-	 * page refcount has been raised. See below comment.
-	 */
-
 	/*
 	 * PageNoNewRefs is set in order to prevent new references to the
 	 * page (eg. before it gets removed from pagecache). Wait until it
-	 * becomes clear (and checks below will ensure we still have the
-	 * correct one).
+	 * becomes clear.
 	 */
-	while (unlikely(PageNoNewRefs(page)))
-		cpu_relax();
+	LockPageNoNewRefs(page);
+	if (unlikely(!get_page_unless_zero(page))) {
+		UnlockPageNoNewRefs(page);
+		return NULL; /* page has been freed */
+	}
+	UnlockPageNoNewRefs(page);
 
 	/*
 	 * smp_rmb is to ensure the load of page->flags (for PageNoNewRefs())


