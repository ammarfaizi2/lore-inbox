Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267292AbUG1QOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267292AbUG1QOF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 12:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267287AbUG1QM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 12:12:59 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:23746 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S267275AbUG1QJt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 12:09:49 -0400
Message-ID: <4107D0CC.DAD982A6@tv-sign.ru>
Date: Wed, 28 Jul 2004 20:14:04 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Rajesh Venkatasubramanian <vrajesh@umich.edu>
Subject: [PATCH] prio_tree 2/3: iterator cleanup
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Currently we have:

	while ((vma = vma_prio_tree_next(vma, root, &iter,
                                        begin, end)) != NULL)
		do_something_with(vma);

Then iter,root,begin,end are all transfered unchanged to various
functions. This patch hides them in struct iter instead.

It slightly lessens source, code size, and stack usage.

Oleg.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

diff -urp prio_init/arch/arm/mm/fault-armv.c prio_iter/arch/arm/mm/fault-armv.c
--- prio_init/arch/arm/mm/fault-armv.c	2004-06-08 13:44:08.000000000 +0400
+++ prio_iter/arch/arm/mm/fault-armv.c	2004-07-27 21:00:09.000000000 +0400
@@ -80,7 +80,7 @@ static void __flush_dcache_page(struct p
 {
 	struct address_space *mapping = page_mapping(page);
 	struct mm_struct *mm = current->active_mm;
-	struct vm_area_struct *mpnt = NULL;
+	struct vm_area_struct *mpnt;
 	struct prio_tree_iter iter;
 	unsigned long offset;
 	pgoff_t pgoff;
@@ -97,8 +97,7 @@ static void __flush_dcache_page(struct p
 	pgoff = page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
 
 	flush_dcache_mmap_lock(mapping);
-	while ((mpnt = vma_prio_tree_next(mpnt, &mapping->i_mmap,
-					&iter, pgoff, pgoff)) != NULL) {
+	vma_prio_tree_foreach(mpnt, &iter, &mapping->i_mmap, pgoff, pgoff) {
 		/*
 		 * If this VMA is not in our MM, we can ignore it.
 		 */
@@ -128,7 +127,7 @@ make_coherent(struct vm_area_struct *vma
 {
 	struct address_space *mapping = page_mapping(page);
 	struct mm_struct *mm = vma->vm_mm;
-	struct vm_area_struct *mpnt = NULL;
+	struct vm_area_struct *mpnt;
 	struct prio_tree_iter iter;
 	unsigned long offset;
 	pgoff_t pgoff;
@@ -145,8 +144,7 @@ make_coherent(struct vm_area_struct *vma
 	 * cache coherency.
 	 */
 	flush_dcache_mmap_lock(mapping);
-	while ((mpnt = vma_prio_tree_next(mpnt, &mapping->i_mmap,
-					&iter, pgoff, pgoff)) != NULL) {
+	vma_prio_tree_foreach(mpnt, &iter, &mapping->i_mmap, pgoff, pgoff) {
 		/*
 		 * If this VMA is not in our MM, we can ignore it.
 		 * Note that we intentionally mask out the VMA
diff -urp prio_init/arch/parisc/kernel/cache.c prio_iter/arch/parisc/kernel/cache.c
--- prio_init/arch/parisc/kernel/cache.c	2004-05-24 14:16:00.000000000 +0400
+++ prio_iter/arch/parisc/kernel/cache.c	2004-07-27 21:03:38.000000000 +0400
@@ -231,7 +231,7 @@ void disable_sr_hashing(void)
 void __flush_dcache_page(struct page *page)
 {
 	struct address_space *mapping = page_mapping(page);
-	struct vm_area_struct *mpnt = NULL;
+	struct vm_area_struct *mpnt;
 	struct prio_tree_iter iter;
 	unsigned long offset;
 	unsigned long addr;
@@ -250,8 +250,7 @@ void __flush_dcache_page(struct page *pa
 	 * to flush one address here for them all to become coherent */
 
 	flush_dcache_mmap_lock(mapping);
-	while ((mpnt = vma_prio_tree_next(mpnt, &mapping->i_mmap,
-					&iter, pgoff, pgoff)) != NULL) {
+	vma_prio_tree_foreach(mpnt, &iter, &mapping->i_mmap, pgoff, pgoff) {
 		offset = (pgoff - mpnt->vm_pgoff) << PAGE_SHIFT;
 		addr = mpnt->vm_start + offset;
 
diff -urp prio_init/fs/hugetlbfs/inode.c prio_iter/fs/hugetlbfs/inode.c
--- prio_init/fs/hugetlbfs/inode.c	2004-07-13 17:52:41.000000000 +0400
+++ prio_iter/fs/hugetlbfs/inode.c	2004-07-27 20:46:03.000000000 +0400
@@ -269,11 +269,10 @@ static void hugetlbfs_drop_inode(struct 
 static inline void
 hugetlb_vmtruncate_list(struct prio_tree_root *root, unsigned long h_pgoff)
 {
-	struct vm_area_struct *vma = NULL;
+	struct vm_area_struct *vma;
 	struct prio_tree_iter iter;
 
-	while ((vma = vma_prio_tree_next(vma, root, &iter,
-					h_pgoff, ULONG_MAX)) != NULL) {
+	vma_prio_tree_foreach(vma, &iter, root, h_pgoff, ULONG_MAX) {
 		unsigned long h_vm_pgoff;
 		unsigned long v_length;
 		unsigned long v_offset;
diff -urp prio_init/include/linux/mm.h prio_iter/include/linux/mm.h
--- prio_init/include/linux/mm.h	2004-07-28 14:07:07.000000000 +0400
+++ prio_iter/include/linux/mm.h	2004-07-28 14:07:48.000000000 +0400
@@ -602,9 +602,12 @@ extern void si_meminfo_node(struct sysin
 void vma_prio_tree_add(struct vm_area_struct *, struct vm_area_struct *old);
 void vma_prio_tree_insert(struct vm_area_struct *, struct prio_tree_root *);
 void vma_prio_tree_remove(struct vm_area_struct *, struct prio_tree_root *);
-struct vm_area_struct *vma_prio_tree_next(
-	struct vm_area_struct *, struct prio_tree_root *,
-	struct prio_tree_iter *, pgoff_t begin, pgoff_t end);
+struct vm_area_struct *vma_prio_tree_next(struct vm_area_struct *vma,
+	struct prio_tree_iter *iter);
+
+#define vma_prio_tree_foreach(vma, iter, root, begin, end)	\
+	for (prio_tree_iter_init(iter, root, begin, end), vma = NULL;	\
+		(vma = vma_prio_tree_next(vma, iter)); )
 
 static inline void vma_nonlinear_insert(struct vm_area_struct *vma,
 					struct list_head *list)
diff -urp prio_init/include/linux/prio_tree.h prio_iter/include/linux/prio_tree.h
--- prio_init/include/linux/prio_tree.h	2004-05-24 14:16:15.000000000 +0400
+++ prio_iter/include/linux/prio_tree.h	2004-07-27 20:29:59.000000000 +0400
@@ -17,8 +17,20 @@ struct prio_tree_iter {
 	unsigned long		mask;
 	unsigned long		value;
 	int			size_level;
+
+	struct prio_tree_root	*root;
+	pgoff_t			r_index;
+	pgoff_t			h_index;
 };
 
+static inline void prio_tree_iter_init(struct prio_tree_iter *iter,
+		struct prio_tree_root *root, pgoff_t r_index, pgoff_t h_index)
+{
+	iter->root = root;
+	iter->r_index = r_index;
+	iter->h_index = h_index;
+}
+
 #define INIT_PRIO_TREE_ROOT(ptr)	\
 do {					\
 	(ptr)->prio_tree_node = NULL;	\
diff -urp prio_init/mm/memory.c prio_iter/mm/memory.c
--- prio_init/mm/memory.c	2004-07-13 17:52:49.000000000 +0400
+++ prio_iter/mm/memory.c	2004-07-27 20:47:10.000000000 +0400
@@ -1123,12 +1123,12 @@ no_new_page:
 static inline void unmap_mapping_range_list(struct prio_tree_root *root,
 					    struct zap_details *details)
 {
-	struct vm_area_struct *vma = NULL;
+	struct vm_area_struct *vma;
 	struct prio_tree_iter iter;
 	pgoff_t vba, vea, zba, zea;
 
-	while ((vma = vma_prio_tree_next(vma, root, &iter,
-			details->first_index, details->last_index)) != NULL) {
+	vma_prio_tree_foreach(vma, &iter, root,
+			details->first_index, details->last_index) {
 		vba = vma->vm_pgoff;
 		vea = vba + ((vma->vm_end - vma->vm_start) >> PAGE_SHIFT) - 1;
 		/* Assume for now that PAGE_CACHE_SHIFT == PAGE_SHIFT */
diff -urp prio_init/mm/prio_tree.c prio_iter/mm/prio_tree.c
--- prio_init/mm/prio_tree.c	2004-07-27 19:16:21.000000000 +0400
+++ prio_iter/mm/prio_tree.c	2004-07-27 20:29:59.000000000 +0400
@@ -312,9 +312,7 @@ static void prio_tree_remove(struct prio
  * 'm' is the number of prio_tree_nodes that overlap the interval X.
  */
 
-static struct prio_tree_node *prio_tree_left(
-		struct prio_tree_root *root, struct prio_tree_iter *iter,
-		unsigned long radix_index, unsigned long heap_index,
+static struct prio_tree_node *prio_tree_left(struct prio_tree_iter *iter,
 		unsigned long *r_index, unsigned long *h_index)
 {
 	if (prio_tree_left_empty(iter->cur))
@@ -322,7 +320,7 @@ static struct prio_tree_node *prio_tree_
 
 	GET_INDEX(iter->cur->left, *r_index, *h_index);
 
-	if (radix_index <= *h_index) {
+	if (iter->r_index <= *h_index) {
 		iter->cur = iter->cur->left;
 		iter->mask >>= 1;
 		if (iter->mask) {
@@ -336,7 +334,7 @@ static struct prio_tree_node *prio_tree_
 				iter->mask = ULONG_MAX;
 			} else {
 				iter->size_level = 1;
-				iter->mask = 1UL << (root->index_bits - 1);
+				iter->mask = 1UL << (iter->root->index_bits - 1);
 			}
 		}
 		return iter->cur;
@@ -345,9 +343,7 @@ static struct prio_tree_node *prio_tree_
 	return NULL;
 }
 
-static struct prio_tree_node *prio_tree_right(
-		struct prio_tree_root *root, struct prio_tree_iter *iter,
-		unsigned long radix_index, unsigned long heap_index,
+static struct prio_tree_node *prio_tree_right(struct prio_tree_iter *iter,
 		unsigned long *r_index, unsigned long *h_index)
 {
 	unsigned long value;
@@ -360,12 +356,12 @@ static struct prio_tree_node *prio_tree_
 	else
 		value = iter->value | iter->mask;
 
-	if (heap_index < value)
+	if (iter->h_index < value)
 		return NULL;
 
 	GET_INDEX(iter->cur->right, *r_index, *h_index);
 
-	if (radix_index <= *h_index) {
+	if (iter->r_index <= *h_index) {
 		iter->cur = iter->cur->right;
 		iter->mask >>= 1;
 		iter->value = value;
@@ -380,7 +376,7 @@ static struct prio_tree_node *prio_tree_
 				iter->mask = ULONG_MAX;
 			} else {
 				iter->size_level = 1;
-				iter->mask = 1UL << (root->index_bits - 1);
+				iter->mask = 1UL << (iter->root->index_bits - 1);
 			}
 		}
 		return iter->cur;
@@ -405,10 +401,10 @@ static struct prio_tree_node *prio_tree_
 	return iter->cur;
 }
 
-static inline int overlap(unsigned long radix_index, unsigned long heap_index,
+static inline int overlap(struct prio_tree_iter *iter,
 		unsigned long r_index, unsigned long h_index)
 {
-	return heap_index >= r_index && radix_index <= h_index;
+	return iter->h_index >= r_index && iter->r_index <= h_index;
 }
 
 /*
@@ -418,35 +414,33 @@ static inline int overlap(unsigned long 
  * heap_index]. Note that always radix_index <= heap_index. We do a pre-order
  * traversal of the tree.
  */
-static struct prio_tree_node *prio_tree_first(struct prio_tree_root *root,
-		struct prio_tree_iter *iter, unsigned long radix_index,
-		unsigned long heap_index)
+static struct prio_tree_node *prio_tree_first(struct prio_tree_iter *iter)
 {
+	struct prio_tree_root *root;
 	unsigned long r_index, h_index;
 
 	INIT_PRIO_TREE_ITER(iter);
 
+	root = iter->root;
 	if (prio_tree_empty(root))
 		return NULL;
 
 	GET_INDEX(root->prio_tree_node, r_index, h_index);
 
-	if (radix_index > h_index)
+	if (iter->r_index > h_index)
 		return NULL;
 
 	iter->mask = 1UL << (root->index_bits - 1);
 	iter->cur = root->prio_tree_node;
 
 	while (1) {
-		if (overlap(radix_index, heap_index, r_index, h_index))
+		if (overlap(iter, r_index, h_index))
 			return iter->cur;
 
-		if (prio_tree_left(root, iter, radix_index, heap_index,
-					&r_index, &h_index))
+		if (prio_tree_left(iter, &r_index, &h_index))
 			continue;
 
-		if (prio_tree_right(root, iter, radix_index, heap_index,
-					&r_index, &h_index))
+		if (prio_tree_right(iter, &r_index, &h_index))
 			continue;
 
 		break;
@@ -459,21 +453,16 @@ static struct prio_tree_node *prio_tree_
  *
  * Get the next prio_tree_node that overlaps with the input interval in iter
  */
-static struct prio_tree_node *prio_tree_next(struct prio_tree_root *root,
-		struct prio_tree_iter *iter, unsigned long radix_index,
-		unsigned long heap_index)
+static struct prio_tree_node *prio_tree_next(struct prio_tree_iter *iter)
 {
 	unsigned long r_index, h_index;
 
 repeat:
-	while (prio_tree_left(root, iter, radix_index,
-				heap_index, &r_index, &h_index)) {
-		if (overlap(radix_index, heap_index, r_index, h_index))
+	while (prio_tree_left(iter, &r_index, &h_index))
+		if (overlap(iter, r_index, h_index))
 			return iter->cur;
-	}
 
-	while (!prio_tree_right(root, iter, radix_index,
-				heap_index, &r_index, &h_index)) {
+	while (!prio_tree_right(iter, &r_index, &h_index)) {
 	    	while (!prio_tree_root(iter->cur) &&
 				iter->cur->parent->right == iter->cur)
 			prio_tree_parent(iter);
@@ -484,7 +473,7 @@ repeat:
 		prio_tree_parent(iter);
 	}
 
-	if (overlap(radix_index, heap_index, r_index, h_index))
+	if (overlap(iter, r_index, h_index))
 		return iter->cur;
 
 	goto repeat;
@@ -622,8 +611,7 @@ void vma_prio_tree_remove(struct vm_area
  * page in the given range of contiguous file pages.
  */
 struct vm_area_struct *vma_prio_tree_next(struct vm_area_struct *vma,
-		struct prio_tree_root *root, struct prio_tree_iter *iter,
-		pgoff_t begin, pgoff_t end)
+					struct prio_tree_iter *iter)
 {
 	struct prio_tree_node *ptr;
 	struct vm_area_struct *next;
@@ -632,7 +620,7 @@ struct vm_area_struct *vma_prio_tree_nex
 		/*
 		 * First call is with NULL vma
 		 */
-		ptr = prio_tree_first(root, iter, begin, end);
+		ptr = prio_tree_first(iter);
 		if (ptr) {
 			next = prio_tree_entry(ptr, struct vm_area_struct,
 						shared.prio_tree_node);
@@ -657,7 +645,7 @@ struct vm_area_struct *vma_prio_tree_nex
 		}
 	}
 
-	ptr = prio_tree_next(root, iter, begin, end);
+	ptr = prio_tree_next(iter);
 	if (ptr) {
 		next = prio_tree_entry(ptr, struct vm_area_struct,
 					shared.prio_tree_node);
diff -urp prio_init/mm/rmap.c prio_iter/mm/rmap.c
--- prio_init/mm/rmap.c	2004-07-13 17:52:49.000000000 +0400
+++ prio_iter/mm/rmap.c	2004-07-27 20:49:01.000000000 +0400
@@ -277,15 +277,14 @@ static inline int page_referenced_file(s
 	unsigned int mapcount = page->mapcount;
 	struct address_space *mapping = page->mapping;
 	pgoff_t pgoff = page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
-	struct vm_area_struct *vma = NULL;
+	struct vm_area_struct *vma;
 	struct prio_tree_iter iter;
 	int referenced = 0;
 
 	if (!spin_trylock(&mapping->i_mmap_lock))
 		return 0;
 
-	while ((vma = vma_prio_tree_next(vma, &mapping->i_mmap,
-					&iter, pgoff, pgoff)) != NULL) {
+	vma_prio_tree_foreach(vma, &iter, &mapping->i_mmap, pgoff, pgoff) {
 		if ((vma->vm_flags & (VM_LOCKED|VM_MAYSHARE))
 				  == (VM_LOCKED|VM_MAYSHARE)) {
 			referenced++;
@@ -654,7 +653,7 @@ static inline int try_to_unmap_file(stru
 {
 	struct address_space *mapping = page->mapping;
 	pgoff_t pgoff = page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
-	struct vm_area_struct *vma = NULL;
+	struct vm_area_struct *vma;
 	struct prio_tree_iter iter;
 	int ret = SWAP_AGAIN;
 	unsigned long cursor;
@@ -665,8 +664,7 @@ static inline int try_to_unmap_file(stru
 	if (!spin_trylock(&mapping->i_mmap_lock))
 		return ret;
 
-	while ((vma = vma_prio_tree_next(vma, &mapping->i_mmap,
-					&iter, pgoff, pgoff)) != NULL) {
+	vma_prio_tree_foreach(vma, &iter, &mapping->i_mmap, pgoff, pgoff) {
 		ret = try_to_unmap_one(page, vma);
 		if (ret == SWAP_FAIL || !page->mapcount)
 			goto out;
