Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964905AbVLFBlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964905AbVLFBlD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 20:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964906AbVLFBlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 20:41:03 -0500
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:62045 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S964905AbVLFBlB (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Mon, 5 Dec 2005 20:41:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:Content-Type;
  b=fNhT1Yrj8kXi+a45+e8uB2BJ4u1O33lVRgbGIvEXJGI/qvV2vdZMhCjudT7qtrYCbipc1XSf2M49Cf4BCI2yhlpA/KqEDCpJ1kI85nQrTxt+yCQzqTQ5ygf20KRufWvXOh8RlC+Dnj+kH1ymAFgt5L7RVPzi1uslW9LIv8niRoY=  ;
Message-ID: <4394EC28.8050304@yahoo.com.au>
Date: Tue, 06 Dec 2005 12:40:56 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Paul McKenney <paul.mckenney@us.ibm.com>,
       WU Fengguang <wfg@mail.ustc.edu.cn>
Subject: [RFC] lockless radix tree readside
Content-Type: multipart/mixed;
 boundary="------------000302020504040305060906"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000302020504040305060906
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The following patch against recent -mm kernels implements lockless
radix tree lookups using RCU. No users of this new facility yet,
but it is a requirement for lockless pagecache.

I have recently added (what I think are) the missing rcu_dereference
calls needed on Alpha, and the implementation now has no known bugs.
(actually that's wrong: the new capabilities in the lookup APIs need
commenting)

I realise that radix-tree.c isn't a trivial bit of code so I don't
expect reviews to be forthcoming, but if anyone had some spare time
to glance over it that would be great.

Is my given detail of the implementation clear? Sufficient? Would
diagrams be helpful?

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.


--------------000302020504040305060906
Content-Type: text/plain;
 name="radix-tree-lockless-readside.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="radix-tree-lockless-readside.patch"

Make radix tree lookups safe to be performed without locks. Readers
are protected against nodes being deleted by using RCU based freeing.
Readers are protected against new node insertion by using memory
barriers to ensure the node itself will be properly written before it
is visible in the radix tree.

Each radix tree node keeps a record of their height (above leaf
nodes). This height does not change after insertion -- when the radix
tree is extended, higher nodes are only inserted in the top. So a
lookup can take the pointer to what is *now* the root node, and
traverse down it even if the tree is concurrently extended and this
node becomes a subtree of a new root.

When a reader wants to traverse the next branch, they will take a
copy of the pointer. This pointer will be either NULL (and the branch
is empty) or non-NULL (and will point to a valid node).

Also introduce a lockfree gang_lookup_slot which will be used by a
future patch.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/lib/radix-tree.c
===================================================================
--- linux-2.6.orig/lib/radix-tree.c
+++ linux-2.6/lib/radix-tree.c
@@ -30,6 +30,7 @@
 #include <linux/gfp.h>
 #include <linux/string.h>
 #include <linux/bitops.h>
+#include <linux/rcupdate.h>
 
 
 #ifdef __KERNEL__
@@ -46,7 +47,9 @@
 	((RADIX_TREE_MAP_SIZE + BITS_PER_LONG - 1) / BITS_PER_LONG)
 
 struct radix_tree_node {
+	unsigned int	height;		/* Height from the bottom */
 	unsigned int	count;
+	struct rcu_head	rcu_head;
 	void		*slots[RADIX_TREE_MAP_SIZE];
 	unsigned long	tags[RADIX_TREE_TAGS][RADIX_TREE_TAG_LONGS];
 };
@@ -98,10 +101,17 @@ radix_tree_node_alloc(struct radix_tree_
 	return ret;
 }
 
+static void radix_tree_node_rcu_free(struct rcu_head *head)
+{
+	struct radix_tree_node *node =
+			container_of(head, struct radix_tree_node, rcu_head);
+	kmem_cache_free(radix_tree_node_cachep, node);
+}
+
 static inline void
 radix_tree_node_free(struct radix_tree_node *node)
 {
-	kmem_cache_free(radix_tree_node_cachep, node);
+	call_rcu(&node->rcu_head, radix_tree_node_rcu_free);
 }
 
 /*
@@ -204,6 +214,7 @@ static int radix_tree_extend(struct radi
 	}
 
 	do {
+		unsigned int newheight;
 		if (!(node = radix_tree_node_alloc(root)))
 			return -ENOMEM;
 
@@ -216,9 +227,11 @@ static int radix_tree_extend(struct radi
 				tag_set(node, tag, 0);
 		}
 
+		newheight = root->height+1;
+		node->height = newheight;
 		node->count = 1;
-		root->rnode = node;
-		root->height++;
+		rcu_assign_pointer(root->rnode, node);
+		root->height = newheight;
 	} while (height > root->height);
 out:
 	return 0;
@@ -258,11 +271,12 @@ int radix_tree_insert(struct radix_tree_
 			/* Have to add a child node.  */
 			if (!(slot = radix_tree_node_alloc(root)))
 				return -ENOMEM;
+			slot->height = height;
 			if (node) {
-				node->slots[offset] = slot;
+				rcu_assign_pointer(node->slots[offset], slot);
 				node->count++;
 			} else
-				root->rnode = slot;
+				rcu_assign_pointer(root->rnode, slot);
 		}
 
 		/* Go a level down */
@@ -278,7 +292,7 @@ int radix_tree_insert(struct radix_tree_
 
 	BUG_ON(!node);
 	node->count++;
-	node->slots[offset] = item;
+	rcu_assign_pointer(node->slots[offset], item);
 	BUG_ON(tag_get(node, 0, offset));
 	BUG_ON(tag_get(node, 1, offset));
 
@@ -290,25 +304,29 @@ static inline void **__lookup_slot(struc
 				   unsigned long index)
 {
 	unsigned int height, shift;
-	struct radix_tree_node **slot;
+	struct radix_tree_node *node, **slot;
 
-	height = root->height;
+	/* Must take a copy now because root->rnode may change */
+	node = rcu_dereference(root->rnode);
+	if (node == NULL)
+		return NULL;
+
+	height = node->height;
 	if (index > radix_tree_maxindex(height))
 		return NULL;
 
 	shift = (height-1) * RADIX_TREE_MAP_SHIFT;
-	slot = &root->rnode;
 
-	while (height > 0) {
-		if (*slot == NULL)
+	do {
+		slot = (struct radix_tree_node **)
+			(node->slots + ((index>>shift) & RADIX_TREE_MAP_MASK));
+		node = rcu_dereference(*slot);
+		if (node == NULL)
 			return NULL;
 
-		slot = (struct radix_tree_node **)
-			((*slot)->slots +
-				((index >> shift) & RADIX_TREE_MAP_MASK));
 		shift -= RADIX_TREE_MAP_SHIFT;
 		height--;
-	}
+	} while (height > 0);
 
 	return (void **)slot;
 }
@@ -339,7 +357,7 @@ void *radix_tree_lookup(struct radix_tre
 	void **slot;
 
 	slot = __lookup_slot(root, index);
-	return slot != NULL ? *slot : NULL;
+	return slot != NULL ? rcu_dereference(*slot) : NULL;
 }
 EXPORT_SYMBOL(radix_tree_lookup);
 
@@ -501,26 +519,27 @@ EXPORT_SYMBOL(radix_tree_tag_get);
 #endif
 
 static unsigned int
-__lookup(struct radix_tree_root *root, void **results, unsigned long index,
+__lookup(struct radix_tree_root *root, void ***results, unsigned long index,
 	unsigned int max_items, unsigned long *next_index)
 {
 	unsigned int nr_found = 0;
 	unsigned int shift, height;
-	struct radix_tree_node *slot;
+	struct radix_tree_node *slot, *__s;
 	unsigned long i;
 
-	height = root->height;
-	if (height == 0)
+	slot = rcu_dereference(root->rnode);
+	if (!slot || slot->height == 0)
 		goto out;
 
+	height = slot->height;
 	shift = (height-1) * RADIX_TREE_MAP_SHIFT;
-	slot = root->rnode;
 
 	for ( ; height > 1; height--) {
 
 		for (i = (index >> shift) & RADIX_TREE_MAP_MASK ;
 				i < RADIX_TREE_MAP_SIZE; i++) {
-			if (slot->slots[i] != NULL)
+			__s = rcu_dereference(slot->slots[i]);
+			if (__s != NULL)
 				break;
 			index &= ~((1UL << shift) - 1);
 			index += 1UL << shift;
@@ -531,14 +550,14 @@ __lookup(struct radix_tree_root *root, v
 			goto out;
 
 		shift -= RADIX_TREE_MAP_SHIFT;
-		slot = slot->slots[i];
+		slot = __s;
 	}
 
 	/* Bottom level: grab some items */
 	for (i = index & RADIX_TREE_MAP_MASK; i < RADIX_TREE_MAP_SIZE; i++) {
 		index++;
 		if (slot->slots[i]) {
-			results[nr_found++] = slot->slots[i];
+			results[nr_found++] = &slot->slots[i];
 			if (nr_found == max_items)
 				goto out;
 		}
@@ -570,6 +589,43 @@ radix_tree_gang_lookup(struct radix_tree
 	unsigned int ret = 0;
 
 	while (ret < max_items) {
+		unsigned int nr_found, i;
+		unsigned long next_index;	/* Index of next search */
+
+		if (cur_index > max_index)
+			break;
+		nr_found = __lookup(root, (void ***)results + ret, cur_index,
+					max_items - ret, &next_index);
+		for (i = 0; i < nr_found; i++)
+			results[ret + i] = *(((void ***)results)[ret + i]);
+		ret += nr_found;
+		if (next_index == 0)
+			break;
+		cur_index = next_index;
+	}
+	return ret;
+}
+EXPORT_SYMBOL(radix_tree_gang_lookup);
+
+/**
+ *	radix_tree_gang_lookup_slot - perform multiple lookup on a radix tree
+ *	@root:		radix tree root
+ *	@results:	where the results of the lookup are placed
+ *	@first_index:	start the lookup from this key
+ *	@max_items:	place up to this many items at *results
+ *
+ *	Same as radix_tree_gang_lookup, but returns an array of pointers
+ *	(slots) to the stored items instead of the items themselves.
+ */
+unsigned int
+radix_tree_gang_lookup_slot(struct radix_tree_root *root, void ***results,
+			unsigned long first_index, unsigned int max_items)
+{
+	const unsigned long max_index = radix_tree_maxindex(root->height);
+	unsigned long cur_index = first_index;
+	unsigned int ret = 0;
+
+	while (ret < max_items) {
 		unsigned int nr_found;
 		unsigned long next_index;	/* Index of next search */
 
@@ -584,7 +640,8 @@ radix_tree_gang_lookup(struct radix_tree
 	}
 	return ret;
 }
-EXPORT_SYMBOL(radix_tree_gang_lookup);
+EXPORT_SYMBOL(radix_tree_gang_lookup_slot);
+
 
 /*
  * FIXME: the two tag_get()s here should use find_next_bit() instead of
@@ -689,6 +746,11 @@ static inline void radix_tree_shrink(str
 			root->rnode->slots[0]) {
 		struct radix_tree_node *to_free = root->rnode;
 
+		/*
+		 * this doesn't need an rcu_assign_pointer, because
+		 * we aren't touching the object that to_free->slots[0]
+		 * points to.
+		 */
 		root->rnode = to_free->slots[0];
 		root->height--;
 		/* must only free zeroed nodes into the slab */
@@ -802,7 +864,7 @@ EXPORT_SYMBOL(radix_tree_delete);
 int radix_tree_tagged(struct radix_tree_root *root, int tag)
 {
   	struct radix_tree_node *rnode;
-  	rnode = root->rnode;
+  	rnode = rcu_dereference(root->rnode);
   	if (!rnode)
   		return 0;
 	return tag_get_any_node(rnode, tag);
Index: linux-2.6/include/linux/radix-tree.h
===================================================================
--- linux-2.6.orig/include/linux/radix-tree.h
+++ linux-2.6/include/linux/radix-tree.h
@@ -51,6 +51,9 @@ void *radix_tree_delete(struct radix_tre
 unsigned int
 radix_tree_gang_lookup(struct radix_tree_root *root, void **results,
 			unsigned long first_index, unsigned int max_items);
+unsigned int
+radix_tree_gang_lookup_slot(struct radix_tree_root *root, void ***results,
+			unsigned long first_index, unsigned int max_items);
 int radix_tree_preload(gfp_t gfp_mask);
 void radix_tree_init(void);
 void *radix_tree_tag_set(struct radix_tree_root *root,

--------------000302020504040305060906--
Send instant messages to your online friends http://au.messenger.yahoo.com 
