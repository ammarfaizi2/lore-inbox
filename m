Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314194AbSDMG7T>; Sat, 13 Apr 2002 02:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314195AbSDMG7S>; Sat, 13 Apr 2002 02:59:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54799 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314194AbSDMG7R>;
	Sat, 13 Apr 2002 02:59:17 -0400
Message-ID: <3CB7D75F.FEE95D28@zip.com.au>
Date: Fri, 12 Apr 2002 23:59:43 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] don't allocate ratnodes under PF_MEMALLOC
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On the swap_out() path, the radix-tree pagecache is allocating its
nodes with PF_MEMALLOC set, which allows it to completely exhaust the
free page lists(*).  This is fairly easy to trigger with swap-intensive
loads.

It would be better to make those node allocations fail at an earlier
time.  When this happens, the radix-tree can still obtain nodes from its
mempool, and we leave some memory available for the I/O layer. 
(Assuming that the I/O is being performed under PF_MEMALLOC, which it
is).

So the patch simply drops PF_MEMALLOC while adding nodes to the
swapcache's tree.

We're still performing atomic allocations, so the rat is still biting
pretty deeply into the page reserves - under heavy load the amount of
free memory is less than half of what it was pre-rat.

It is unfortunate that the page allocator overloads !__GFP_WAIT to also
mean "try harder".  It would be better to separate these concepts, and
to allow the radix-tree code (at least) to perform atomic allocations,
but to not go below pages_min.  It seems that __GFP_TRY_HARDER will be
pretty straightforward to implement.  Later.

The patch also impements a workaround for the mempool list_head
problem, until that is sorted out.



(*) The usual result is that the SCSI layer dies at scsi_merge.c:82. 
It would be nice to have a fix for that - it's going BUG if 1-order
allocations fail at interrupt time.  That happens pretty easily.


--- 2.5.8-pre3/mm/vmscan.c~ratcache-pf_memalloc	Fri Apr 12 23:40:35 2002
+++ 2.5.8-pre3-akpm/mm/vmscan.c	Fri Apr 12 23:40:35 2002
@@ -36,6 +36,29 @@
 #define DEF_PRIORITY (6)
 
 /*
+ * On the swap_out path, the radix-tree node allocations are performing
+ * GFP_ATOMIC allocations under PF_MEMALLOC.  They can completely
+ * exhaust the page allocator.  This is bad; some pages should be left
+ * available for the I/O system to start sending the swapcache contents
+ * to disk.
+ *
+ * So PF_MEMALLOC is dropped here.  This causes the slab allocations to fail
+ * earlier, so radix-tree nodes will then be allocated from the mempool
+ * reserves.
+ */
+static inline int
+swap_out_add_to_swap_cache(struct page *page, swp_entry_t entry)
+{
+	int flags = current->flags;
+	int ret;
+
+	current->flags &= ~PF_MEMALLOC;
+	ret = add_to_swap_cache(page, entry);
+	current->flags = flags;
+	return ret;
+}
+
+/*
  * The swap-out function returns 1 if it successfully
  * scanned all the pages it was asked to (`count').
  * It returns zero if it couldn't do anything,
@@ -140,7 +163,7 @@ drop_pte:
 		 * (adding to the page cache will clear the dirty
 		 * and uptodate bits, so we need to do it again)
 		 */
-		switch (add_to_swap_cache(page, entry)) {
+		switch (swap_out_add_to_swap_cache(page, entry)) {
 		case 0:				/* Success */
 			SetPageUptodate(page);
 			set_page_dirty(page);
--- 2.5.8-pre3/lib/radix-tree.c~ratcache-pf_memalloc	Fri Apr 12 23:40:35 2002
+++ 2.5.8-pre3-akpm/lib/radix-tree.c	Fri Apr 12 23:54:49 2002
@@ -49,11 +49,27 @@ struct radix_tree_path {
 static kmem_cache_t *radix_tree_node_cachep;
 static mempool_t *radix_tree_node_pool;
 
-#define radix_tree_node_alloc(root) \
-	mempool_alloc(radix_tree_node_pool, (root)->gfp_mask)
-#define radix_tree_node_free(node) \
-	mempool_free((node), radix_tree_node_pool);
+/*
+ * mempool scribbles on the first eight bytes of the managed
+ * memory.  Here we implement a temp workaround for that.
+ */
+#include <linux/list.h>
+static inline struct radix_tree_node *
+radix_tree_node_alloc(struct radix_tree_root *root)
+{
+	struct radix_tree_node *ret;
+
+	ret = mempool_alloc(radix_tree_node_pool, root->gfp_mask);
+	if (ret)
+		memset(ret, 0, sizeof(struct list_head));
+	return ret;
+}
 
+static inline void
+radix_tree_node_free(struct radix_tree_node *node)
+{
+	mempool_free(node, radix_tree_node_pool);
+}
 
 /*
  *	Return the maximum key which can be store into a

-
