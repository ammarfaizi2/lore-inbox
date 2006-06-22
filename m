Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbWFVSLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWFVSLP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 14:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbWFVSLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 14:11:15 -0400
Received: from ns1.suse.de ([195.135.220.2]:51847 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932096AbWFVSLO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 14:11:14 -0400
Date: Thu, 22 Jun 2006 20:11:12 +0200
From: Nick Piggin <npiggin@suse.de>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul McKenney <Paul.McKenney@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [patch 3/3] radix-tree: RCU lockless readside
Message-ID: <20060622181111.GD23109@wotan.suse.de>
References: <20060408134635.22479.79269.sendpatchset@linux.site> <20060408134707.22479.33814.sendpatchset@linux.site> <20060622014949.GA2202@us.ibm.com> <20060622154518.GA23109@wotan.suse.de> <20060622163032.GC1295@us.ibm.com> <20060622165551.GB23109@wotan.suse.de> <20060622174057.GF1295@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060622174057.GF1295@us.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 10:40:57AM -0700, Paul E. McKenney wrote:
> On Thu, Jun 22, 2006 at 06:55:51PM +0200, Nick Piggin wrote:
> > 
> > No problem, will change.
> 
> Thank you!

OK, and with that I believe I've covered all your concerns.

Attached is the incremental patch (plus a little bit of fuzz
that's gone to Andrew). The big items are:

- documentation, clarification of comments
- tag lookups are now RCU safe (tested with harness)
- cleanups of various misuses of rcu_ API that Paul spotted
- thought I might put in a copyright -- is this OK?

Andrew, please apply.

Index: linux-2.6/include/linux/radix-tree.h
===================================================================
--- linux-2.6.orig/include/linux/radix-tree.h
+++ linux-2.6/include/linux/radix-tree.h
@@ -1,6 +1,7 @@
 /*
  * Copyright (C) 2001 Momchil Velikov
  * Portions Copyright (C) 2001 Christoph Hellwig
+ * Copyright (C) 2006 Nick Piggin
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
@@ -25,6 +26,33 @@
 #include <linux/kernel.h>
 #include <linux/rcupdate.h>
 
+/*
+ * A direct pointer (root->rnode pointing directly to a data item,
+ * rather than another radix_tree_node) is signalled by the low bit
+ * set in the root->rnode pointer.
+ *
+ * In this case root->height is also NULL, but the direct pointer tests are
+ * needed for RCU lookups when root->height is unreliable.
+ */
+#define RADIX_TREE_DIRECT_PTR	1
+
+static inline void *radix_tree_ptr_to_direct(void *ptr)
+{
+	return (void *)((unsigned long)ptr | RADIX_TREE_DIRECT_PTR);
+}
+
+static inline void *radix_tree_direct_to_ptr(void *ptr)
+{
+	return (void *)((unsigned long)ptr & ~RADIX_TREE_DIRECT_PTR);
+}
+
+static inline int radix_tree_is_direct_ptr(void *ptr)
+{
+	return (int)((unsigned long)ptr & RADIX_TREE_DIRECT_PTR);
+}
+
+/*** radix-tree API starts here ***/
+
 #define RADIX_TREE_MAX_TAGS 2
 
 /* root tags are stored in gfp_mask, shifted by __GFP_BITS_SHIFT */
@@ -50,29 +78,62 @@ do {									\
 	(root)->rnode = NULL;						\
 } while (0)
 
-#define RADIX_TREE_DIRECT_PTR	1
-
-static inline void *radix_tree_ptr_to_direct(void *ptr)
-{
-	return (void *)((unsigned long)ptr | RADIX_TREE_DIRECT_PTR);
-}
-
-static inline void *radix_tree_direct_to_ptr(void *ptr)
-{
-	return (void *)((unsigned long)ptr & ~RADIX_TREE_DIRECT_PTR);
-}
-
-static inline int radix_tree_is_direct_ptr(void *ptr)
-{
-	return (int)((unsigned long)ptr & RADIX_TREE_DIRECT_PTR);
-}
+/**
+ * Radix-tree synchronization
+ *
+ * The radix-tree API requires that users provide all synchronisation (with
+ * specific exceptions, noted below).
+ *
+ * Synchronization of access to the data items being stored in the tree, and
+ * management of their lifetimes must be completely managed by API users.
+ *
+ * For API usage, in general,
+ * - any function _modifying_ the the tree or tags (inserting or deleting
+ *   items, setting or clearing tags must exclude other modifications, and
+ *   exclude any functions reading the tree.
+ * - any function _reading_ the the tree or tags (looking up items or tags,
+ *   gang lookups) must exclude modifications to the tree, but may occur
+ *   concurrently with other readers.
+ *
+ * The notable exceptions to this rule are the following functions:
+ * radix_tree_lookup
+ * radix_tree_tag_get
+ * radix_tree_gang_lookup
+ * radix_tree_gang_lookup_tag
+ * radix_tree_tagged
+ *
+ * The first 4 functions are able to be called locklessly, using RCU. The
+ * caller must ensure calls to these functions are made within rcu_read_lock()
+ * regions. Other readers (lock-free or otherwise) and modifications may be
+ * running concurrently.
+ *
+ * It is still required that the caller manage the synchronization and lifetimes
+ * of the items. So if RCU lock-free lookups are used, typically this would mean
+ * that the items have their own locks, or are amenable to lock-free access; and
+ * that the items are freed by RCU (or only freed after having been deleted from
+ * the radix tree *and* a synchronize_rcu() grace period).
+ *
+ * (Note, rcu_assign_pointer and rcu_dereference are not needed to control
+ * access to data items when inserting into or looking up from the radix tree)
+ *
+ * radix_tree_tagged is able to be called without locking or RCU.
+ */
 
+/**
+ * radix_tree_deref_slot	- dereference a slot
+ * @pslot:	pointer to slot, returned by radix_tree_lookup_slot
+ * @returns:	item that was stored in that slot.
+ */
 static inline void *radix_tree_deref_slot(void *pslot)
 {
 	void *slot = *(void **)pslot;
 	return rcu_dereference(radix_tree_direct_to_ptr(slot));
 }
-
+/**
+ * radix_tree_replace_slot	- replace item in a slot
+ * @pslot:	pointer to slot, returned by radix_tree_lookup_slot
+ * @item:	new item to store in the slot.
+ */
 static inline void radix_tree_replace_slot(void *pslot, void *item)
 {
 	void *slot = *(void **)pslot;
Index: linux-2.6/lib/radix-tree.c
===================================================================
--- linux-2.6.orig/lib/radix-tree.c
+++ linux-2.6/lib/radix-tree.c
@@ -2,6 +2,7 @@
  * Copyright (C) 2001 Momchil Velikov
  * Portions Copyright (C) 2001 Christoph Hellwig
  * Copyright (C) 2005 SGI, Christoph Lameter <clameter@sgi.com>
+ * Copyright (C) 2006 Nick Piggin
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
@@ -341,7 +342,7 @@ void **radix_tree_lookup_slot(struct rad
 	unsigned int height, shift;
 	struct radix_tree_node *node, **slot;
 
-	node = rcu_dereference(root->rnode);
+	node = root->rnode;
 	if (node == NULL)
 		return NULL;
 
@@ -360,7 +361,7 @@ void **radix_tree_lookup_slot(struct rad
 	do {
 		slot = (struct radix_tree_node **)
 			(node->slots + ((index>>shift) & RADIX_TREE_MAP_MASK));
-		node = rcu_dereference(*slot);
+		node = *slot;
 		if (node == NULL)
 			return NULL;
 
@@ -547,27 +548,30 @@ int radix_tree_tag_get(struct radix_tree
 			unsigned long index, unsigned int tag)
 {
 	unsigned int height, shift;
-	struct radix_tree_node *slot;
+	struct radix_tree_node *node;
 	int saw_unset_tag = 0;
 
-	height = root->height;
-	if (index > radix_tree_maxindex(height))
-		return 0;
-
 	/* check the root's tag bit */
 	if (!root_tag_get(root, tag))
 		return 0;
 
-	if (height == 0)
-		return 1;
+	node = rcu_dereference(root->rnode);
+	if (node == NULL)
+		return 0;
+
+	if (radix_tree_is_direct_ptr(node))
+		return (index == 0);
+
+	height = node->height;
+	if (index > radix_tree_maxindex(height))
+		return 0;
 
 	shift = (height - 1) * RADIX_TREE_MAP_SHIFT;
-	slot = root->rnode;
 
 	for ( ; ; ) {
 		int offset;
 
-		if (slot == NULL)
+		if (node == NULL)
 			return 0;
 
 		offset = (index >> shift) & RADIX_TREE_MAP_MASK;
@@ -576,15 +580,15 @@ int radix_tree_tag_get(struct radix_tree
 		 * This is just a debug check.  Later, we can bale as soon as
 		 * we see an unset tag.
 		 */
-		if (!tag_get(slot, tag, offset))
+		if (!tag_get(node, tag, offset))
 			saw_unset_tag = 1;
 		if (height == 1) {
-			int ret = tag_get(slot, tag, offset);
+			int ret = tag_get(node, tag, offset);
 
 			BUG_ON(ret && saw_unset_tag);
 			return ret;
 		}
-		slot = slot->slots[offset];
+		node = rcu_dereference(node->slots[offset]);
 		shift -= RADIX_TREE_MAP_SHIFT;
 		height--;
 	}
@@ -606,12 +610,9 @@ __lookup(struct radix_tree_node *slot, v
 	shift = (height-1) * RADIX_TREE_MAP_SHIFT;
 
 	for ( ; height > 1; height--) {
-		struct radix_tree_node *__s;
-
 		i = (index >> shift) & RADIX_TREE_MAP_MASK ;
 		for (;;) {
-			__s = rcu_dereference(slot->slots[i]);
-			if (__s != NULL)
+			if (slot->slots[i] != NULL)
 				break;
 			index &= ~((1UL << shift) - 1);
 			index += 1UL << shift;
@@ -623,7 +624,7 @@ __lookup(struct radix_tree_node *slot, v
 		}
 
 		shift -= RADIX_TREE_MAP_SHIFT;
-		slot = __s;
+		slot = rcu_dereference(slot->slots[i]);
 	}
 
 	/* Bottom level: grab some items */
@@ -632,7 +633,7 @@ __lookup(struct radix_tree_node *slot, v
 		index++;
 		node = slot->slots[i];
 		if (node) {
-			results[nr_found++] = node;
+			results[nr_found++] = rcu_dereference(node);
 			if (nr_found == max_items)
 				goto out;
 		}
@@ -677,9 +678,9 @@ radix_tree_gang_lookup(struct radix_tree
 	if (radix_tree_is_direct_ptr(node)) {
 		if (first_index > 0)
 			return 0;
-		results[0] = radix_tree_direct_to_ptr(node);
-		ret = 1;
-		goto out;
+		node = radix_tree_direct_to_ptr(node);
+		results[0] = rcu_dereference(node);
+		return 1;
 	}
 
 	max_index = radix_tree_maxindex(node->height);
@@ -699,9 +700,6 @@ radix_tree_gang_lookup(struct radix_tree
 		cur_index = next_index;
 	}
 
-out:
-	(void)rcu_dereference(results); /* single barrier for all results */
-
 	return ret;
 }
 EXPORT_SYMBOL(radix_tree_gang_lookup);
@@ -715,26 +713,27 @@ __lookup_tag(struct radix_tree_node *slo
 	unsigned int max_items, unsigned long *next_index, unsigned int tag)
 {
 	unsigned int nr_found = 0;
-	unsigned int shift;
-	unsigned int height = slot->height;
+	unsigned int shift, height;
 
-	shift = (height - 1) * RADIX_TREE_MAP_SHIFT;
+	height = slot->height;
+	if (height == 0)
+		goto out;
+	shift = (height-1) * RADIX_TREE_MAP_SHIFT;
 
 	while (height > 0) {
-		unsigned long i = (index >> shift) & RADIX_TREE_MAP_MASK;
+		unsigned long i = (index >> shift) & RADIX_TREE_MAP_MASK ;
 
-		for ( ; i < RADIX_TREE_MAP_SIZE; i++) {
-			if (tag_get(slot, tag, i)) {
-				BUG_ON(slot->slots[i] == NULL);
+		for (;;) {
+			if (tag_get(slot, tag, i))
 				break;
-			}
 			index &= ~((1UL << shift) - 1);
 			index += 1UL << shift;
 			if (index == 0)
 				goto out;	/* 32-bit wraparound */
+			i++;
+			if (i == RADIX_TREE_MAP_SIZE)
+				goto out;
 		}
-		if (i == RADIX_TREE_MAP_SIZE)
-			goto out;
 		height--;
 		if (height == 0) {	/* Bottom level: grab some items */
 			unsigned long j = index & RADIX_TREE_MAP_MASK;
@@ -742,15 +741,19 @@ __lookup_tag(struct radix_tree_node *slo
 			for ( ; j < RADIX_TREE_MAP_SIZE; j++) {
 				index++;
 				if (tag_get(slot, tag, j)) {
-					BUG_ON(slot->slots[j] == NULL);
-					results[nr_found++] = slot->slots[j];
-					if (nr_found == max_items)
-						goto out;
+					struct radix_tree_node *node = slot->slots[j];
+					if (node) {
+						results[nr_found++] = rcu_dereference(node);
+						if (nr_found == max_items)
+							goto out;
+					}
 				}
 			}
 		}
 		shift -= RADIX_TREE_MAP_SHIFT;
-		slot = slot->slots[i];
+		slot = rcu_dereference(slot->slots[i]);
+		if (slot == NULL);
+			break;
 	}
 out:
 	*next_index = index;
@@ -778,7 +781,7 @@ radix_tree_gang_lookup_tag(struct radix_
 	struct radix_tree_node *node;
 	unsigned long max_index;
 	unsigned long cur_index = first_index;
-	unsigned int ret = 0;
+	unsigned int ret;
 
 	/* check the root's tag bit */
 	if (!root_tag_get(root, tag))
@@ -786,18 +789,19 @@ radix_tree_gang_lookup_tag(struct radix_
 
 	node = rcu_dereference(root->rnode);
 	if (!node)
-		return ret;
+		return 0;
 
 	if (radix_tree_is_direct_ptr(node)) {
 		if (first_index > 0)
 			return 0;
 		node = radix_tree_direct_to_ptr(node);
-		results[0] = node;
+		results[0] = rcu_dereference(node);
 		return 1;
 	}
 
 	max_index = radix_tree_maxindex(node->height);
 
+	ret = 0;
 	while (ret < max_items) {
 		unsigned int nr_found;
 		unsigned long next_index;	/* Index of next search */
@@ -811,6 +815,7 @@ radix_tree_gang_lookup_tag(struct radix_
 			break;
 		cur_index = next_index;
 	}
+
 	return ret;
 }
 EXPORT_SYMBOL(radix_tree_gang_lookup_tag);
@@ -829,9 +834,11 @@ static inline void radix_tree_shrink(str
 		void *newptr;
 
 		/*
-		 * this doesn't need an rcu_assign_pointer, because
-		 * we aren't touching the object that to_free->slots[0]
-		 * points to.
+		 * We don't need rcu_assign_pointer(), since we are simply
+		 * moving the node from one part of the tree to another. If
+		 * it was safe to dereference the old pointer to it
+		 * (to_free->slots[0]), it will be safe to dereference the new
+		 * one (root->rnode).
 		 */
 		newptr = to_free->slots[0];
 		if (root->height == 1)
