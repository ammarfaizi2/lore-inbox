Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932899AbWFWHJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932899AbWFWHJQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 03:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932897AbWFWHJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 03:09:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28298 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932899AbWFWHJP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 03:09:15 -0400
Date: Fri, 23 Jun 2006 00:09:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <npiggin@suse.de>
Cc: paulmck@us.ibm.com, benh@kernel.crashing.org, Paul.McKenney@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch 3/3] radix-tree: RCU lockless readside
Message-Id: <20060623000901.bf8b46c5.akpm@osdl.org>
In-Reply-To: <20060622181111.GD23109@wotan.suse.de>
References: <20060408134635.22479.79269.sendpatchset@linux.site>
	<20060408134707.22479.33814.sendpatchset@linux.site>
	<20060622014949.GA2202@us.ibm.com>
	<20060622154518.GA23109@wotan.suse.de>
	<20060622163032.GC1295@us.ibm.com>
	<20060622165551.GB23109@wotan.suse.de>
	<20060622174057.GF1295@us.ibm.com>
	<20060622181111.GD23109@wotan.suse.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006 20:11:12 +0200
Nick Piggin <npiggin@suse.de> wrote:

> On Thu, Jun 22, 2006 at 10:40:57AM -0700, Paul E. McKenney wrote:
> > On Thu, Jun 22, 2006 at 06:55:51PM +0200, Nick Piggin wrote:
> > > 
> > > No problem, will change.
> > 
> > Thank you!
> 
> OK, and with that I believe I've covered all your concerns.
> 
> Attached is the incremental patch (plus a little bit of fuzz
> that's gone to Andrew). The big items are:
> 
> - documentation, clarification of comments
> - tag lookups are now RCU safe (tested with harness)
> - cleanups of various misuses of rcu_ API that Paul spotted
> - thought I might put in a copyright -- is this OK?
> 
> Andrew, please apply.

Freeing unused kernel memory: 316k freed
Write protecting the kernel read-only data: 384k
No module found in object
No module found in object
No module found in object
No module found in object
input: AT Translated Set 2 keyboard as /class/input/input0
No module found in object
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
BUG: NMI Watchdog detected LOCKUP on CPU0, eip c0264345, registers:
CPU:    0
EIP is at radix_tree_gang_lookup_tag+0x105/0x1a0
eax: ffffffff   ebx: 00000040   ecx: ffffffc0   edx: 00000007
esi: e701e9d8   edi: 000001c0   ebp: e6fbddd8   esp: e6fbdda8
ds: 007b   es: 007b   ss: 0068
Process fsck.ext3 (pid: 1565, ti=e6fbc000 task=c1fbcb90 task.ti=e6fbc000)
Stack: e77f2dc4 e701e9d8 e701e9d8 00000002 00000fff 00000000 e701e8c8 e6fbde60 
       0000000e c1c6c52c e6fbde60 c1c6c538 e6fbde00 c014b68f c1c6c52c e6fbde60 
       00000000 0000000e 00000000 e6fbde58 00000000 00000001 e6fbde20 c0155631 
Call Trace:
Code: 89 fa 8d 4c 09 fa d3 e3 d3 ea 89 d9 83 e2 3f f7 d9 eb 13 8d 76 00 89 f8 89 df 21 c8 01 c7 74 26 42 83 fa 40 74 95 0f a3 16 19 c0 <85> c0 74 e7 83 7d dc 01 74 3a 31 f6 89 75 f0 e9 6e ff ff ff c7 
console shuts up ...


Not sure why, either.  It all looks like an equivalent transformation to
me.

fwiw, here's what I tested:


From: Nick Piggin <npiggin@suse.de>

- documentation, clarification of comments
- tag lookups are now RCU safe (tested with harness)
- cleanups of various misuses of rcu_ API that Paul spotted
- thought I might put in a copyright -- is this OK?

Cc: Nick Piggin <npiggin@suse.de>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 include/linux/radix-tree.h |   95 +++++++++++++++++++++++++++-----
 lib/radix-tree.c           |  101 ++++++++++++++++++-----------------
 2 files changed, 132 insertions(+), 64 deletions(-)

diff -puN include/linux/radix-tree.h~adix-tree-rcu-lockless-readside-update include/linux/radix-tree.h
--- a/include/linux/radix-tree.h~adix-tree-rcu-lockless-readside-update
+++ a/include/linux/radix-tree.h
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
diff -puN lib/radix-tree.c~adix-tree-rcu-lockless-readside-update lib/radix-tree.c
--- a/lib/radix-tree.c~adix-tree-rcu-lockless-readside-update
+++ a/lib/radix-tree.c
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
 
@@ -546,27 +547,30 @@ int radix_tree_tag_get(struct radix_tree
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
@@ -575,15 +579,15 @@ int radix_tree_tag_get(struct radix_tree
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
@@ -605,12 +609,9 @@ __lookup(struct radix_tree_node *slot, v
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
@@ -622,7 +623,7 @@ __lookup(struct radix_tree_node *slot, v
 		}
 
 		shift -= RADIX_TREE_MAP_SHIFT;
-		slot = __s;
+		slot = rcu_dereference(slot->slots[i]);
 	}
 
 	/* Bottom level: grab some items */
@@ -631,7 +632,7 @@ __lookup(struct radix_tree_node *slot, v
 		index++;
 		node = slot->slots[i];
 		if (node) {
-			results[nr_found++] = node;
+			results[nr_found++] = rcu_dereference(node);
 			if (nr_found == max_items)
 				goto out;
 		}
@@ -676,9 +677,9 @@ radix_tree_gang_lookup(struct radix_tree
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
@@ -698,9 +699,6 @@ radix_tree_gang_lookup(struct radix_tree
 		cur_index = next_index;
 	}
 
-out:
-	(void)rcu_dereference(results); /* single barrier for all results */
-
 	return ret;
 }
 EXPORT_SYMBOL(radix_tree_gang_lookup);
@@ -714,26 +712,27 @@ __lookup_tag(struct radix_tree_node *slo
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
@@ -741,15 +740,19 @@ __lookup_tag(struct radix_tree_node *slo
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
@@ -777,7 +780,7 @@ radix_tree_gang_lookup_tag(struct radix_
 	struct radix_tree_node *node;
 	unsigned long max_index;
 	unsigned long cur_index = first_index;
-	unsigned int ret = 0;
+	unsigned int ret;
 
 	/* check the root's tag bit */
 	if (!root_tag_get(root, tag))
@@ -785,18 +788,19 @@ radix_tree_gang_lookup_tag(struct radix_
 
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
@@ -810,6 +814,7 @@ radix_tree_gang_lookup_tag(struct radix_
 			break;
 		cur_index = next_index;
 	}
+
 	return ret;
 }
 EXPORT_SYMBOL(radix_tree_gang_lookup_tag);
@@ -828,9 +833,11 @@ static inline void radix_tree_shrink(str
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
_

