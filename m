Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbWEZLw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbWEZLw5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 07:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbWEZLw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 07:52:57 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:60888 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932356AbWEZLw4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 07:52:56 -0400
Message-ID: <348644373.06563@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060526115259.223408850@localhost.localdomain>
References: <20060526113906.084341801@localhost.localdomain>
Date: Fri, 26 May 2006 19:39:08 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>
Subject: [PATCH 02/33] radixtree: introduce __radix_tree_lookup_parent()
Content-Disposition: inline; filename=radixtree-lookup-parent.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a general lookup function to radix tree.

- __radix_tree_lookup_parent(root, index, level)
	Perform partial lookup, return the @level'th parent of the slot at
	@index.

Signed-off-by: Christoph Lameter <clameter@sgi.com>
Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 include/linux/radix-tree.h |   83 +++++++++++++++++++++++++++++++++++
 lib/radix-tree.c           |  104 ++++++++++++++++++++++++++++++++++-----------
 2 files changed, 161 insertions(+), 26 deletions(-)

--- linux-2.6.17-rc4-mm3.orig/include/linux/radix-tree.h
+++ linux-2.6.17-rc4-mm3/include/linux/radix-tree.h
@@ -49,7 +49,8 @@ do {									\
 } while (0)
 
 int radix_tree_insert(struct radix_tree_root *, unsigned long, void *);
-void *radix_tree_lookup(struct radix_tree_root *, unsigned long);
+void *__radix_tree_lookup_parent(struct radix_tree_root *,
+						unsigned long, unsigned int);
 void **radix_tree_lookup_slot(struct radix_tree_root *, unsigned long);
 void *radix_tree_delete(struct radix_tree_root *, unsigned long);
 unsigned int
@@ -74,4 +75,17 @@ static inline void radix_tree_preload_en
 	preempt_enable();
 }
 
+/**
+ *	radix_tree_lookup    -    perform lookup operation on a radix tree
+ *	@root:		radix tree root
+ *	@index:		index key
+ *
+ *	Lookup the item at the position @index in the radix tree @root.
+ */
+static inline void *radix_tree_lookup(struct radix_tree_root *root,
+							unsigned long index)
+{
+	return __radix_tree_lookup_parent(root, index, 0);
+}
+
 #endif /* _LINUX_RADIX_TREE_H */
--- linux-2.6.17-rc4-mm3.orig/lib/radix-tree.c
+++ linux-2.6.17-rc4-mm3/lib/radix-tree.c
@@ -309,36 +309,46 @@ int radix_tree_insert(struct radix_tree_
 }
 EXPORT_SYMBOL(radix_tree_insert);
 
-static inline void **__lookup_slot(struct radix_tree_root *root,
-				   unsigned long index)
+/**
+ *	__radix_tree_lookup_parent    -    low level lookup routine
+ *	@root:		radix tree root
+ *	@index:		index key
+ *	@level:		stop at that many levels from the tree leaf
+ *
+ *	Lookup the @level'th parent of the slot at @index in radix tree @root.
+ *	The return value is:
+ *	@level == 0:      page at @index;
+ *	@level == 1:      the corresponding bottom level tree node;
+ *	@level < height:  (@level-1)th parent node of the bottom node
+ *			  that contains @index;
+ *	@level >= height: the root node.
+ */
+void *__radix_tree_lookup_parent(struct radix_tree_root *root,
+				unsigned long index, unsigned int level)
 {
 	unsigned int height, shift;
-	struct radix_tree_node **slot;
+	struct radix_tree_node *slot;
 
 	height = root->height;
 
 	if (index > radix_tree_maxindex(height))
 		return NULL;
 
-	if (height == 0 && root->rnode)
-		return (void **)&root->rnode;
-
 	shift = (height-1) * RADIX_TREE_MAP_SHIFT;
-	slot = &root->rnode;
+	slot = root->rnode;
 
-	while (height > 0) {
-		if (*slot == NULL)
+	while (height > level) {
+		if (slot == NULL)
 			return NULL;
 
-		slot = (struct radix_tree_node **)
-			((*slot)->slots +
-				((index >> shift) & RADIX_TREE_MAP_MASK));
+		slot = slot->slots[(index >> shift) & RADIX_TREE_MAP_MASK];
 		shift -= RADIX_TREE_MAP_SHIFT;
 		height--;
 	}
 
-	return (void **)slot;
+	return slot;
 }
+EXPORT_SYMBOL(__radix_tree_lookup_parent);
 
 /**
  *	radix_tree_lookup_slot    -    lookup a slot in a radix tree
@@ -350,25 +360,15 @@ static inline void **__lookup_slot(struc
  */
 void **radix_tree_lookup_slot(struct radix_tree_root *root, unsigned long index)
 {
-	return __lookup_slot(root, index);
-}
-EXPORT_SYMBOL(radix_tree_lookup_slot);
+	struct radix_tree_node *node;
 
-/**
- *	radix_tree_lookup    -    perform lookup operation on a radix tree
- *	@root:		radix tree root
- *	@index:		index key
- *
- *	Lookup the item at the position @index in the radix tree @root.
- */
-void *radix_tree_lookup(struct radix_tree_root *root, unsigned long index)
-{
-	void **slot;
+	if (root->height == 0)
+		return &root->rnode;
 
-	slot = __lookup_slot(root, index);
-	return slot != NULL ? *slot : NULL;
+	node = __radix_tree_lookup_parent(root, index, 1);
+	return node ? node->slots + (index & RADIX_TREE_MAP_MASK) : NULL;
 }
-EXPORT_SYMBOL(radix_tree_lookup);
+EXPORT_SYMBOL(radix_tree_lookup_slot);
 
 /**
  *	radix_tree_tag_set - set a tag on a radix tree node

--
