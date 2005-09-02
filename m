Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161002AbVIBGa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161002AbVIBGa5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 02:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161003AbVIBGa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 02:30:57 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:44174 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1161004AbVIBGa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 02:30:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:References:In-Reply-To:Content-Type;
  b=ortyrlWxlfnPqITAq8V4MIXg4yg4GO01F0AzCu47eA3gqhDDzPPGEoGmgonbCZ5Tkj5hGDESmYFGP4Fkl5jLnbiBN55BHnpQbLIWoETHMnptYhwKwNuzLtXMNmre37bXEpsvN66lDWpFga7dPQEHMvsS/sf6C8vbe84YQdkXteE=  ;
Message-ID: <4317F1BD.8060808@yahoo.com.au>
Date: Fri, 02 Sep 2005 16:31:25 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Memory Management <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.13] lockless pagecache 5/7
References: <4317F071.1070403@yahoo.com.au> <4317F0F9.1080602@yahoo.com.au> <4317F136.4040601@yahoo.com.au> <4317F17F.5050306@yahoo.com.au> <4317F1A2.8030605@yahoo.com.au>
In-Reply-To: <4317F1A2.8030605@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------060101080407090206090103"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060101080407090206090103
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

5/7

-- 
SUSE Labs, Novell Inc.

--------------060101080407090206090103
Content-Type: text/plain;
 name="radix-tree-lockless-readside.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="radix-tree-lockless-readside.patch"

Make radix tree lookups safe to be performed without locks.
Readers are protected against nodes being deleted by using RCU
based freeing. Readers are protected against new node insertion
by using memory barriers to ensure the node itself will be
properly written before it is visible in the radix tree.

Also introduce a lockfree gang_lookup_slot which will be used
by a future patch.

Index: linux-2.6/lib/radix-tree.c
===================================================================
--- linux-2.6.orig/lib/radix-tree.c
+++ linux-2.6/lib/radix-tree.c
@@ -29,6 +29,7 @@
 #include <linux/gfp.h>
 #include <linux/string.h>
 #include <linux/bitops.h>
+#include <linux/rcupdate.h>
 
 
 #ifdef __KERNEL__
@@ -45,7 +46,9 @@
 	((RADIX_TREE_MAP_SIZE + BITS_PER_LONG - 1) / BITS_PER_LONG)
 
 struct radix_tree_node {
+	unsigned int	height;		/* Height from the bottom */
 	unsigned int	count;
+	struct rcu_head	rcu_head;
 	void		*slots[RADIX_TREE_MAP_SIZE];
 	unsigned long	tags[RADIX_TREE_TAGS][RADIX_TREE_TAG_LONGS];
 };
@@ -97,10 +100,17 @@ radix_tree_node_alloc(struct radix_tree_
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
@@ -196,6 +206,7 @@ static int radix_tree_extend(struct radi
 	}
 
 	do {
+		unsigned int newheight;
 		if (!(node = radix_tree_node_alloc(root)))
 			return -ENOMEM;
 
@@ -208,9 +219,11 @@ static int radix_tree_extend(struct radi
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
@@ -250,9 +263,10 @@ int radix_tree_insert(struct radix_tree_
 			/* Have to add a child node.  */
 			if (!(tmp = radix_tree_node_alloc(root)))
 				return -ENOMEM;
-			*slot = tmp;
+			tmp->height = height;
 			if (node)
 				node->count++;
+			rcu_assign_pointer(*slot, tmp);
 		}
 
 		/* Go a level down */
@@ -282,12 +296,14 @@ static inline void **__lookup_slot(struc
 	unsigned int height, shift;
 	struct radix_tree_node **slot;
 
-	height = root->height;
+	if (root->rnode == NULL)
+		return NULL;
+	slot = &root->rnode;
+	height = (*slot)->height;
 	if (index > radix_tree_maxindex(height))
 		return NULL;
 
 	shift = (height-1) * RADIX_TREE_MAP_SHIFT;
-	slot = &root->rnode;
 
 	while (height > 0) {
 		if (*slot == NULL)
@@ -491,21 +507,24 @@ EXPORT_SYMBOL(radix_tree_tag_get);
 #endif
 
 static unsigned int
-__lookup(struct radix_tree_root *root, void **results, unsigned long index,
+__lookup(struct radix_tree_root *root, void ***results, unsigned long index,
 	unsigned int max_items, unsigned long *next_index)
 {
+	unsigned long i;
 	unsigned int nr_found = 0;
 	unsigned int shift;
-	unsigned int height = root->height;
+	unsigned int height;
 	struct radix_tree_node *slot;
 
-	shift = (height-1) * RADIX_TREE_MAP_SHIFT;
 	slot = root->rnode;
+	if (!slot)
+		goto out;
+	height = slot->height;
+	shift = (height-1) * RADIX_TREE_MAP_SHIFT;
 
-	while (height > 0) {
-		unsigned long i = (index >> shift) & RADIX_TREE_MAP_MASK;
-
-		for ( ; i < RADIX_TREE_MAP_SIZE; i++) {
+	for (;;) {
+		for (i = (index >> shift) & RADIX_TREE_MAP_MASK;
+						i < RADIX_TREE_MAP_SIZE; i++) {
 			if (slot->slots[i] != NULL)
 				break;
 			index &= ~((1UL << shift) - 1);
@@ -516,21 +535,23 @@ __lookup(struct radix_tree_root *root, v
 		if (i == RADIX_TREE_MAP_SIZE)
 			goto out;
 		height--;
-		if (height == 0) {	/* Bottom level: grab some items */
-			unsigned long j = index & RADIX_TREE_MAP_MASK;
-
-			for ( ; j < RADIX_TREE_MAP_SIZE; j++) {
-				index++;
-				if (slot->slots[j]) {
-					results[nr_found++] = slot->slots[j];
-					if (nr_found == max_items)
-						goto out;
-				}
-			}
+		if (height == 0) {
+			/* Bottom level: grab some items */
+			break;
 		}
 		shift -= RADIX_TREE_MAP_SHIFT;
 		slot = slot->slots[i];
 	}
+
+	for (i = index & RADIX_TREE_MAP_MASK; i < RADIX_TREE_MAP_SIZE; i++) {
+		index++;
+		if (slot->slots[i]) {
+			results[nr_found++] = &(slot->slots[i]);
+			if (nr_found == max_items)
+				goto out;
+		}
+	}
+
 out:
 	*next_index = index;
 	return nr_found;
@@ -558,6 +579,43 @@ radix_tree_gang_lookup(struct radix_tree
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
 
@@ -572,7 +630,8 @@ radix_tree_gang_lookup(struct radix_tree
 	}
 	return ret;
 }
-EXPORT_SYMBOL(radix_tree_gang_lookup);
+EXPORT_SYMBOL(radix_tree_gang_lookup_slot);
+
 
 /*
  * FIXME: the two tag_get()s here should use find_next_bit() instead of
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
 int radix_tree_preload(int gfp_mask);
 void radix_tree_init(void);
 void *radix_tree_tag_set(struct radix_tree_root *root,

--------------060101080407090206090103--
Send instant messages to your online friends http://au.messenger.yahoo.com 
