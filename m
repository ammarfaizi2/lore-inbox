Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318514AbSIKIMY>; Wed, 11 Sep 2002 04:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318526AbSIKIL5>; Wed, 11 Sep 2002 04:11:57 -0400
Received: from packet.digeo.com ([12.110.80.53]:3472 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S318514AbSIKIL2>;
	Wed, 11 Sep 2002 04:11:28 -0400
Message-ID: <3D7EFF5A.94B1A938@digeo.com>
Date: Wed, 11 Sep 2002 01:31:22 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] radix_tree_gang_lookup
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Sep 2002 08:16:10.0198 (UTC) FILETIME=[7C52F760:01C2596B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Adds a gang lookup facility to radix trees.  It provides an efficient
means of locating a bunch of pages starting at a particular offset.

The implementation is a bit dumb, but is efficient enough.  And it is
amenable to the `tagged lookup' extension which is proving tricky to
write, but which will allow the dirty pages within a mapping to be
located in pgoff_t order.



 fs/inode.c                 |    6 +-
 include/linux/radix-tree.h |    3 +
 lib/radix-tree.c           |  101 ++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 106 insertions(+), 4 deletions(-)

--- 2.5.34/lib/radix-tree.c~radix_tree_gang_lookup	Wed Sep 11 01:16:33 2002
+++ 2.5.34-akpm/lib/radix-tree.c	Wed Sep 11 01:16:38 2002
@@ -43,6 +43,7 @@ struct radix_tree_path {
 };
 
 #define RADIX_TREE_INDEX_BITS  (8 /* CHAR_BIT */ * sizeof(unsigned long))
+#define RADIX_TREE_MAX_PATH (RADIX_TREE_INDEX_BITS/RADIX_TREE_MAP_SHIFT + 2)
 
 /*
  * Radix tree node cache.
@@ -218,9 +219,105 @@ void *radix_tree_lookup(struct radix_tre
 
 	return (void *) *slot;
 }
-
 EXPORT_SYMBOL(radix_tree_lookup);
 
+static /* inline */ unsigned int
+__lookup(struct radix_tree_root *root, void **results, unsigned long index,
+	unsigned int max_items, unsigned long *next_index,
+	unsigned long max_index)
+{
+	unsigned int nr_found = 0;
+	unsigned int shift;
+	unsigned int height = root->height;
+	struct radix_tree_node *slot;
+
+	if (index > max_index)
+		return 0;
+	shift = (height-1) * RADIX_TREE_MAP_SHIFT;
+	slot = root->rnode;
+
+	while (height > 0) {
+		unsigned long i = (index >> shift) & RADIX_TREE_MAP_MASK;
+		for ( ; i < RADIX_TREE_MAP_SIZE; i++) {
+			if (slot->slots[i] != NULL)
+				break;
+			index &= ~((1 << shift) - 1);
+			index += 1 << shift;
+		}
+		if (i == RADIX_TREE_MAP_SIZE)
+			goto out;
+		height--;
+		shift -= RADIX_TREE_MAP_SHIFT;
+		if (height == 0) {
+			/* Bottom level: grab some items */
+			unsigned long j;
+
+			BUG_ON((shift + RADIX_TREE_MAP_SHIFT) != 0);
+			
+			j = index & RADIX_TREE_MAP_MASK;
+			for ( ; j < RADIX_TREE_MAP_SIZE; j++) {
+				index++;
+				if (slot->slots[j]) {
+					results[nr_found++] = slot->slots[j];
+					if (nr_found == max_items)
+						goto out;
+				}
+			}
+		}
+		slot = slot->slots[i];
+	}
+out:
+	*next_index = index;
+	return nr_found;
+	
+}
+/**
+ *	radix_tree_gang_lookup - perform multiple lookup on a radix tree
+ *	@root:		radix tree root
+ *	@results:	where the results of the lookup are placed
+ *	@first_index:	start the lookup from this key
+ *	@max_items:	place up to this many items at *results
+ *
+ *	Performs an index-ascending scan of the tree for present items.  Places
+ *	them at *@results and returns the number of items which were placed at
+ *	*@results.
+ *
+ *	The implementation is naive.
+ */
+unsigned int
+radix_tree_gang_lookup(struct radix_tree_root *root, void **results,
+			unsigned long first_index, unsigned int max_items)
+{
+	const unsigned long max_index = radix_tree_maxindex(root->height);
+	unsigned long cur_index = first_index;
+	unsigned int ret = 0;
+
+	if (root->rnode == NULL)
+		goto out;
+	if (max_index == 0) {			/* Bah.  Special case */
+		if (first_index == 0) {
+			if (max_items > 0) {
+				*results = root->rnode;
+				ret = 1;
+			}
+		}
+		goto out;
+	}
+	while (ret < max_items) {
+		unsigned int nr_found;
+		unsigned long next_index;	/* Index of next search */
+
+		nr_found = __lookup(root, results + ret, cur_index,
+				max_items - ret, &next_index, max_index);
+		if (nr_found == 0)
+			break;
+		ret += nr_found;
+		cur_index = next_index;
+	}
+out:
+	return ret;
+}
+EXPORT_SYMBOL(radix_tree_gang_lookup);
 
 /**
  *	radix_tree_delete    -    delete an item from a radix tree
@@ -231,7 +328,7 @@ EXPORT_SYMBOL(radix_tree_lookup);
  */
 int radix_tree_delete(struct radix_tree_root *root, unsigned long index)
 {
-	struct radix_tree_path path[RADIX_TREE_INDEX_BITS/RADIX_TREE_MAP_SHIFT + 2], *pathp = path;
+	struct radix_tree_path path[RADIX_TREE_MAX_PATH], *pathp = path;
 	unsigned int height, shift;
 
 	height = root->height;
--- 2.5.34/include/linux/radix-tree.h~radix_tree_gang_lookup	Wed Sep 11 01:16:33 2002
+++ 2.5.34-akpm/include/linux/radix-tree.h	Wed Sep 11 01:16:38 2002
@@ -45,5 +45,8 @@ extern int radix_tree_reserve(struct rad
 extern int radix_tree_insert(struct radix_tree_root *, unsigned long, void *);
 extern void *radix_tree_lookup(struct radix_tree_root *, unsigned long);
 extern int radix_tree_delete(struct radix_tree_root *, unsigned long);
+extern unsigned int
+radix_tree_gang_lookup(struct radix_tree_root *root, void **results,
+			unsigned long first_index, unsigned int max_items);
 
 #endif /* _LINUX_RADIX_TREE_H */
--- 2.5.34/fs/inode.c~radix_tree_gang_lookup	Wed Sep 11 01:16:33 2002
+++ 2.5.34-akpm/fs/inode.c	Wed Sep 11 01:16:33 2002
@@ -147,10 +147,12 @@ static void destroy_inode(struct inode *
 	if (inode_has_buffers(inode))
 		BUG();
 	security_ops->inode_free_security(inode);
-	if (inode->i_sb->s_op->destroy_inode)
+	if (inode->i_sb->s_op->destroy_inode) {
 		inode->i_sb->s_op->destroy_inode(inode);
-	else
+	} else {
+		BUG_ON(inode->i_data.page_tree.rnode != NULL);
 		kmem_cache_free(inode_cachep, (inode));
+	}
 }
 
 

.
