Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261365AbUKBU1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbUKBU1V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 15:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbUKBU1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 15:27:20 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:47088 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261361AbUKBUXH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 15:23:07 -0500
Message-ID: <4187ECA3.4010406@mvista.com>
Date: Tue, 02 Nov 2004 12:22:59 -0800
From: Steve Longerbeam <stevel@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: lse-tech <lse-tech@lists.sourceforge.net>
Subject: [PATCH 2.6.9] NUMA policies for file mappings + MPOL_MF_MOVE
Content-Type: multipart/mixed;
 boundary="------------030805040709080109040006"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------030805040709080109040006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This is a patch against 2.6.9 that is an update to an earlier patch
I posted on 10/13/2004 ("NUMA policy support for file mappings").

The patch allows NUMA policies for file mappings. Page cache pages are
allocated using a policy located in a shared_policy Red-Black tree attached
to the mapping object (address_space). This involves:

1. add a shared_policy tree to the address_space object in fs.h.

2. modify page_cache_alloc() in pagemap.h to take a page index in
   addition to a mapping object, and use those to locate the correct policy
   in the mapping->policy tree when allocating the page.

3. modify filemap.c to pass the additional page offset to 
page_cache_alloc().

4. Also in filemap.c, implement generic file {set|get}_policy() methods and
   add those to generic_file_vm_ops.

5. Init the file's shared policy in alloc_inode(), and free the shared 
policy in
  destroy_inode().

In addition, the patch adds a new flag to the mbind() syscall, MPOL_MF_MOVE.
If this flag is set, any existing mapped anonymous or filemap pagecache 
pages
that are/can be used for the given virtual memory region, that do not 
satisfy the
NUMA policy, are moved to a new page that satisfies the policy. Here's how
the new flag works with the existing MPOL_MF_STRICT flag (in the following
discussion, "invalid page" means a page that does not satisfy the NUMA 
policy):

MOVE and STRICT both set:
attempt to move invalid pages, and if any move fails, return mbind()
syscall failure.

MOVE set:
attempt to move invalid pages, but do not return error if any move fails.

STRICT set:
do not attempt to move invalid pages, returning mbind() failure (same
behavior as before).

neither MOVE or STRICT set:
ignore invalid pages.


Steve

--------------030805040709080109040006
Content-Type: text/plain;
 name="mempol-2.6.9.filemap-policy.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mempol-2.6.9.filemap-policy.patch"

Source: MontaVista Software, Inc., Steve Longerbeam <stevel@mvista.com>
Type: Enhancement
Disposition: merge to kernel.org
Acked-by: Andi Kleen <ak@suse.de>
Description:
    Patches NUMA mempolicy to allow policies for file mappings. Also adds
    a new mbind() flag that attempts to move existing anonymous and
    filemap pages that do not satisfy a mapping's policy (MPOL_MF_MOVE).

Index: linux-2.6.9/fs/inode.c
===================================================================
--- linux-2.6.9.orig/fs/inode.c
+++ linux-2.6.9/fs/inode.c
@@ -150,6 +150,7 @@
 		mapping_set_gfp_mask(mapping, GFP_HIGHUSER);
 		mapping->assoc_mapping = NULL;
 		mapping->backing_dev_info = &default_backing_dev_info;
+ 		mpol_shared_policy_init(&mapping->policy);
 
 		/*
 		 * If the block_device provides a backing_dev_info for client
@@ -177,8 +178,10 @@
 	security_inode_free(inode);
 	if (inode->i_sb->s_op->destroy_inode)
 		inode->i_sb->s_op->destroy_inode(inode);
-	else
+	else {
+		mpol_free_shared_policy(&inode->i_mapping->policy);
 		kmem_cache_free(inode_cachep, (inode));
+	}
 }
 
 
Index: linux-2.6.9/include/linux/fs.h
===================================================================
--- linux-2.6.9.orig/include/linux/fs.h
+++ linux-2.6.9/include/linux/fs.h
@@ -18,6 +18,7 @@
 #include <linux/cache.h>
 #include <linux/prio_tree.h>
 #include <linux/kobject.h>
+#include <linux/mempolicy.h>
 #include <asm/atomic.h>
 
 struct iovec;
@@ -345,6 +346,7 @@
 	struct address_space_operations *a_ops;	/* methods */
 	unsigned long		flags;		/* error bits/gfp mask */
 	struct backing_dev_info *backing_dev_info; /* device readahead, etc */
+	struct shared_policy    policy;         /* page alloc policy */
 	spinlock_t		private_lock;	/* for use by the address_space */
 	struct list_head	private_list;	/* ditto */
 	struct address_space	*assoc_mapping;	/* ditto */
Index: linux-2.6.9/include/linux/mempolicy.h
===================================================================
--- linux-2.6.9.orig/include/linux/mempolicy.h
+++ linux-2.6.9/include/linux/mempolicy.h
@@ -22,6 +22,8 @@
 
 /* Flags for mbind */
 #define MPOL_MF_STRICT	(1<<0)	/* Verify existing pages in the mapping */
+#define MPOL_MF_MOVE	(1<<1)	/* Attempt to move pages in mapping that do
+				   not satisfy policy */
 
 #ifdef __KERNEL__
 
@@ -149,7 +151,8 @@
 void mpol_free_shared_policy(struct shared_policy *p);
 struct mempolicy *mpol_shared_policy_lookup(struct shared_policy *sp,
 					    unsigned long idx);
-
+struct page *alloc_page_shared_policy(unsigned gfp, struct shared_policy *sp,
+				      unsigned long idx);
 extern void numa_default_policy(void);
 extern void numa_policy_init(void);
 
@@ -215,6 +218,13 @@
 #define vma_policy(vma) NULL
 #define vma_set_policy(vma, pol) do {} while(0)
 
+static inline struct page *
+alloc_page_shared_policy(unsigned gfp, struct shared_policy *sp,
+			 unsigned long idx)
+{
+	return alloc_pages(gfp, 0);
+}
+
 static inline void numa_policy_init(void)
 {
 }
Index: linux-2.6.9/include/linux/page-flags.h
===================================================================
--- linux-2.6.9.orig/include/linux/page-flags.h
+++ linux-2.6.9/include/linux/page-flags.h
@@ -74,6 +74,8 @@
 #define PG_swapcache		16	/* Swap page: swp_entry_t in private */
 #define PG_mappedtodisk		17	/* Has blocks allocated on-disk */
 #define PG_reclaim		18	/* To be reclaimed asap */
+#define PG_sharedpolicy         19      /* Page was allocated for a file
+					   mapping using a shared_policy */
 
 
 /*
@@ -290,6 +292,10 @@
 #define SetPageCompound(page)	set_bit(PG_compound, &(page)->flags)
 #define ClearPageCompound(page)	clear_bit(PG_compound, &(page)->flags)
 
+#define PageSharedPolicy(page)      test_bit(PG_sharedpolicy, &(page)->flags)
+#define SetPageSharedPolicy(page)   set_bit(PG_sharedpolicy, &(page)->flags)
+#define ClearPageSharedPolicy(page) clear_bit(PG_sharedpolicy, &(page)->flags)
+
 #ifdef CONFIG_SWAP
 #define PageSwapCache(page)	test_bit(PG_swapcache, &(page)->flags)
 #define SetPageSwapCache(page)	set_bit(PG_swapcache, &(page)->flags)
Index: linux-2.6.9/include/linux/pagemap.h
===================================================================
--- linux-2.6.9.orig/include/linux/pagemap.h
+++ linux-2.6.9/include/linux/pagemap.h
@@ -50,14 +50,24 @@
 #define page_cache_release(page)	put_page(page)
 void release_pages(struct page **pages, int nr, int cold);
 
-static inline struct page *page_cache_alloc(struct address_space *x)
+
+static inline struct page *__page_cache_alloc(struct address_space *x,
+					      unsigned long idx,
+					      unsigned int gfp_mask)
+{
+	return alloc_page_shared_policy(gfp_mask, &x->policy, idx);
+}
+
+static inline struct page *page_cache_alloc(struct address_space *x,
+					    unsigned long idx)
 {
-	return alloc_pages(mapping_gfp_mask(x), 0);
+	return __page_cache_alloc(x, idx, mapping_gfp_mask(x));
 }
 
-static inline struct page *page_cache_alloc_cold(struct address_space *x)
+static inline struct page *page_cache_alloc_cold(struct address_space *x,
+						 unsigned long idx)
 {
-	return alloc_pages(mapping_gfp_mask(x)|__GFP_COLD, 0);
+	return __page_cache_alloc(x, idx, mapping_gfp_mask(x)|__GFP_COLD);
 }
 
 typedef int filler_t(void *, struct page *);
Index: linux-2.6.9/mm/filemap.c
===================================================================
--- linux-2.6.9.orig/mm/filemap.c
+++ linux-2.6.9/mm/filemap.c
@@ -595,7 +595,8 @@
 	page = find_lock_page(mapping, index);
 	if (!page) {
 		if (!cached_page) {
-			cached_page = alloc_page(gfp_mask);
+			cached_page = __page_cache_alloc(mapping, index,
+							 gfp_mask);
 			if (!cached_page)
 				return NULL;
 		}
@@ -688,7 +689,7 @@
 		return NULL;
 	}
 	gfp_mask = mapping_gfp_mask(mapping) & ~__GFP_FS;
-	page = alloc_pages(gfp_mask, 0);
+	page = __page_cache_alloc(mapping, index, gfp_mask);
 	if (page && add_to_page_cache_lru(page, mapping, index, gfp_mask)) {
 		page_cache_release(page);
 		page = NULL;
@@ -865,7 +866,7 @@
 		 * page..
 		 */
 		if (!cached_page) {
-			cached_page = page_cache_alloc_cold(mapping);
+			cached_page = page_cache_alloc_cold(mapping, index);
 			if (!cached_page) {
 				desc->error = -ENOMEM;
 				goto out;
@@ -1128,7 +1129,7 @@
 	struct page *page; 
 	int error;
 
-	page = page_cache_alloc_cold(mapping);
+	page = page_cache_alloc_cold(mapping, offset);
 	if (!page)
 		return -ENOMEM;
 
@@ -1510,9 +1511,35 @@
 	return 0;
 }
 
+
+#ifdef CONFIG_NUMA
+int generic_file_set_policy(struct vm_area_struct *vma,
+			    struct mempolicy *new)
+{
+	struct address_space *mapping = vma->vm_file->f_mapping;
+	return mpol_set_shared_policy(&mapping->policy, vma, new);
+}
+
+struct mempolicy *
+generic_file_get_policy(struct vm_area_struct *vma,
+			unsigned long addr)
+{
+	struct address_space *mapping = vma->vm_file->f_mapping;
+	unsigned long idx;
+
+	idx = ((addr - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff;
+	return mpol_shared_policy_lookup(&mapping->policy, idx);
+}
+#endif
+
+
 struct vm_operations_struct generic_file_vm_ops = {
 	.nopage		= filemap_nopage,
 	.populate	= filemap_populate,
+#ifdef CONFIG_NUMA
+	.set_policy     = generic_file_set_policy,
+	.get_policy     = generic_file_get_policy,
+#endif
 };
 
 /* This is used for a general mmap of a disk file */
@@ -1562,7 +1589,7 @@
 	page = find_get_page(mapping, index);
 	if (!page) {
 		if (!cached_page) {
-			cached_page = page_cache_alloc_cold(mapping);
+			cached_page = page_cache_alloc_cold(mapping, index);
 			if (!cached_page)
 				return ERR_PTR(-ENOMEM);
 		}
@@ -1644,7 +1671,7 @@
 	page = find_lock_page(mapping, index);
 	if (!page) {
 		if (!*cached_page) {
-			*cached_page = page_cache_alloc(mapping);
+			*cached_page = page_cache_alloc(mapping, index);
 			if (!*cached_page)
 				return NULL;
 		}
Index: linux-2.6.9/mm/mempolicy.c
===================================================================
--- linux-2.6.9.orig/mm/mempolicy.c
+++ linux-2.6.9/mm/mempolicy.c
@@ -66,6 +66,7 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
+#include <linux/pagemap.h>
 #include <linux/gfp.h>
 #include <linux/slab.h>
 #include <linux/string.h>
@@ -74,6 +75,9 @@
 #include <linux/init.h>
 #include <linux/compat.h>
 #include <linux/mempolicy.h>
+#include <linux/rmap.h>
+#include <linux/swap.h>
+#include <asm/pgalloc.h>
 #include <asm/uaccess.h>
 
 static kmem_cache_t *policy_cache;
@@ -230,22 +234,220 @@
 	return policy;
 }
 
-/* Ensure all existing pages follow the policy. */
+
+/* Return effective policy for a VMA */
+static struct mempolicy *
+get_vma_policy(struct vm_area_struct *vma, unsigned long addr)
+{
+	struct mempolicy *pol = current->mempolicy;
+
+	if (vma) {
+		if (vma->vm_ops && vma->vm_ops->get_policy)
+		        pol = vma->vm_ops->get_policy(vma, addr);
+		else if (vma->vm_policy &&
+				vma->vm_policy->policy != MPOL_DEFAULT)
+			pol = vma->vm_policy;
+	}
+	if (!pol)
+		pol = &default_policy;
+	return pol;
+}
+
+
+/* Find secondary valid nodes for an allocation */
+static int __mpol_node_valid(int nid, struct mempolicy *pol)
+{
+	switch (pol->policy) {
+	case MPOL_PREFERRED:
+	case MPOL_DEFAULT:
+	case MPOL_INTERLEAVE:
+		return 1;
+	case MPOL_BIND: {
+		struct zone **z;
+		for (z = pol->v.zonelist->zones; *z; z++)
+			if ((*z)->zone_pgdat->node_id == nid)
+				return 1;
+		return 0;
+	}
+	default:
+		BUG();
+		return 0;
+	}
+}
+
+int mpol_node_valid(int nid, struct vm_area_struct *vma, unsigned long addr)
+{
+	return __mpol_node_valid(nid, get_vma_policy(vma, addr));
+}
+
+/*
+ * The given page doesn't match a file mapped VMA's policy. If the
+ * page is unused, remove it from the page cache, so that a new page
+ * can be later reallocated to the cache using the correct policy.
+ * Returns 0 if the page was removed from the cache, < 0 if failed.
+ *
+ * We use invalidate_mapping_pages(), which doesn't try very hard.
+ * It won't remove pages which are locked (won't wait for a lock),
+ * dirty, under writeback, or mapped by pte's. All the latter are
+ * valid checks for us, but we might be able to improve our success
+ * by waiting for a lock.
+ */
 static int
-verify_pages(unsigned long addr, unsigned long end, unsigned long *nodes)
+remove_invalid_filemap_page(struct page * page,
+			    struct vm_area_struct *vma,
+			    pgoff_t pgoff)
+{
+	/*
+	 * the page in the cache is not in any of the nodes this
+	 * VMA's policy wants it to be in. Can we remove it?
+	 */
+	if (!PageSharedPolicy(page) &&
+	    invalidate_mapping_pages(vma->vm_file->f_mapping,
+				     pgoff, pgoff) > 0) {
+		PDprintk("removed cache page in node %ld, "
+			 "pgoff=%lu, for %s\n",
+			 page_to_nid(page), pgoff,
+			 vma->vm_file->f_dentry->d_name.name);
+		return 0;
+	}
+
+	/*
+	 * the page is being used by other pagetable mappings,
+	 * or is currently locked, dirty, or under writeback.
+	 */
+	PDprintk("could not remove cache page in node %ld, "
+		 "pgoff=%lu, for %s\n",
+		 page_to_nid(page), pgoff,
+		 vma->vm_file->f_dentry->d_name.name);
+	return -EIO;
+}
+
+/*
+ * The given page doesn't match a VMA's policy. Allocate a new
+ * page using the policy, copy contents from old to new, free
+ * the old page, map in the new page. This looks a lot like a COW.
+ */
+static int
+move_invalid_page(struct page * page, struct mempolicy *pol,
+		  struct vm_area_struct *vma, unsigned long addr,
+		  pmd_t *pmd)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	struct page * new_page;
+	struct vm_area_struct pvma;
+	pte_t *page_table;
+	pte_t entry;
+	
+	PDprintk("moving anon page in node %ld, address=%08lx\n",
+		 page_to_nid(page), addr);
+	
+	if (!PageReserved(page))
+		page_cache_get(page);
+	spin_unlock(&mm->page_table_lock);
+	if (unlikely(anon_vma_prepare(vma)))
+		goto err_no_mem;
+
+	/* Create a pseudo vma that just contains the policy */
+	memset(&pvma, 0, sizeof(struct vm_area_struct));
+	pvma.vm_end = PAGE_SIZE;
+	pvma.vm_pgoff = vma->vm_pgoff;
+	pvma.vm_policy = pol;
+	new_page = alloc_page_vma(GFP_HIGHUSER, &pvma, addr);
+	if (!new_page)
+		goto err_no_mem;
+
+	copy_user_highpage(new_page, page, addr);
+
+	spin_lock(&mm->page_table_lock);
+	page_table = pte_offset_map(pmd, addr);
+	if (PageReserved(page))
+		++mm->rss;
+	else
+		page_remove_rmap(page);
+
+	flush_cache_page(vma, addr);
+	entry = pte_mkdirty(mk_pte(new_page, vma->vm_page_prot));
+	if (likely(vma->vm_flags & VM_WRITE))
+		entry = pte_mkwrite(entry);
+	ptep_establish(vma, addr, page_table, entry);
+	update_mmu_cache(vma, addr, entry);
+	lru_cache_add_active(new_page);
+	page_add_anon_rmap(new_page, vma, addr);
+
+	pte_unmap(page_table);
+	page_cache_release(page); /* release our ref on the old page */
+	page_cache_release(page); /* release our pte ref on the old page */
+	return 0;
+
+ err_no_mem:
+	spin_lock(&mm->page_table_lock);
+	return -ENOMEM;
+}
+
+/* Ensure all existing pages in a VMA follow the policy. */
+static int
+move_verify_pages(struct vm_area_struct *vma, struct mempolicy *pol,
+		  unsigned long flags)
 {
-	while (addr < end) {
+	struct mm_struct *mm = vma->vm_mm;
+	unsigned long addr;
+	unsigned long start = vma->vm_start;
+	unsigned long end = vma->vm_end;
+	
+	if (!(flags & (MPOL_MF_MOVE | MPOL_MF_STRICT)))
+		return 0;
+
+	for (addr = start; addr < end; addr += PAGE_SIZE) {
 		struct page *p;
 		pte_t *pte;
 		pmd_t *pmd;
-		pgd_t *pgd = pgd_offset_k(addr);
+		pgd_t *pgd;
+		int err;
+		
+		/*
+		 * first, if this is a file mapping and we are moving pages,
+		 * check for invalid page cache pages, and if they are unused,
+		 * remove.
+		 */
+		if (vma->vm_ops && vma->vm_ops->nopage) {
+			struct address_space *mapping =
+				vma->vm_file->f_mapping;
+			unsigned long pgoff =
+				((addr - vma->vm_start) >> PAGE_CACHE_SHIFT) +
+				vma->vm_pgoff;
+			
+			p = find_get_page(mapping, pgoff);
+			if (p) {
+				err = 0;
+				if (!__mpol_node_valid(page_to_nid(p), pol)) {
+					if (!(flags & MPOL_MF_MOVE))
+						err = -EIO;
+					else
+						err = remove_invalid_filemap_page(
+							p,vma,pgoff);
+				}
+				page_cache_release(p);  /* find_get_page */
+				if (err && (flags & MPOL_MF_STRICT))
+					return err;
+			}
+		}
+		
+		/*
+		 * Now let's see if there is a pte-mapped page that doesn't
+		 * satisfy the policy. Because of the above, we can be sure
+		 * from here that, if there is a VMA page that's pte-mapped
+		 * and it belongs to the page cache, it either satisfies the
+		 * policy, or we don't mind if it doesn't (MF_STRICT not set).
+		 */
+		spin_lock(&mm->page_table_lock);
+		pgd = pgd_offset(mm, addr);
 		if (pgd_none(*pgd)) {
-			addr = (addr + PGDIR_SIZE) & PGDIR_MASK;
+			spin_unlock(&mm->page_table_lock);
 			continue;
 		}
 		pmd = pmd_offset(pgd, addr);
 		if (pmd_none(*pmd)) {
-			addr = (addr + PMD_SIZE) & PMD_MASK;
+			spin_unlock(&mm->page_table_lock);
 			continue;
 		}
 		p = NULL;
@@ -254,19 +456,29 @@
 			p = pte_page(*pte);
 		pte_unmap(pte);
 		if (p) {
-			unsigned nid = page_to_nid(p);
-			if (!test_bit(nid, nodes))
-				return -EIO;
+			err = 0;
+			if (!__mpol_node_valid(page_to_nid(p), pol)) {
+				if (!(flags & MPOL_MF_MOVE))
+					err = -EIO;
+				else
+					err = move_invalid_page(p, pol, vma,
+								addr, pmd);
+			}
+			if (err && (flags & MPOL_MF_STRICT)) {
+				spin_unlock(&mm->page_table_lock);
+				return err;
+			}
 		}
-		addr += PAGE_SIZE;
+		spin_unlock(&mm->page_table_lock);
 	}
+
 	return 0;
 }
 
 /* Step 1: check the range */
 static struct vm_area_struct *
 check_range(struct mm_struct *mm, unsigned long start, unsigned long end,
-	    unsigned long *nodes, unsigned long flags)
+	    struct mempolicy *policy, unsigned long flags)
 {
 	int err;
 	struct vm_area_struct *first, *vma, *prev;
@@ -280,8 +492,8 @@
 			return ERR_PTR(-EFAULT);
 		if (prev && prev->vm_end < vma->vm_start)
 			return ERR_PTR(-EFAULT);
-		if ((flags & MPOL_MF_STRICT) && !is_vm_hugetlb_page(vma)) {
-			err = verify_pages(vma->vm_start, vma->vm_end, nodes);
+		if (flags & (MPOL_MF_MOVE | MPOL_MF_STRICT)) {
+			err = move_verify_pages(vma, policy, flags);
 			if (err) {
 				first = ERR_PTR(err);
 				break;
@@ -348,12 +560,13 @@
 	DECLARE_BITMAP(nodes, MAX_NUMNODES);
 	int err;
 
-	if ((flags & ~(unsigned long)(MPOL_MF_STRICT)) || mode > MPOL_MAX)
+	if ((flags & ~(unsigned long)(MPOL_MF_STRICT | MPOL_MF_MOVE)) ||
+	    mode > MPOL_MAX)
 		return -EINVAL;
 	if (start & ~PAGE_MASK)
 		return -EINVAL;
 	if (mode == MPOL_DEFAULT)
-		flags &= ~MPOL_MF_STRICT;
+		flags &= ~(MPOL_MF_STRICT | MPOL_MF_MOVE);
 	len = (len + PAGE_SIZE - 1) & PAGE_MASK;
 	end = start + len;
 	if (end < start)
@@ -373,7 +586,7 @@
 			mode,nodes[0]);
 
 	down_write(&mm->mmap_sem);
-	vma = check_range(mm, start, end, nodes, flags);
+	vma = check_range(mm, start, end, new, flags);
 	err = PTR_ERR(vma);
 	if (!IS_ERR(vma))
 		err = mbind_range(vma, start, end, new);
@@ -606,24 +819,6 @@
 
 #endif
 
-/* Return effective policy for a VMA */
-static struct mempolicy *
-get_vma_policy(struct vm_area_struct *vma, unsigned long addr)
-{
-	struct mempolicy *pol = current->mempolicy;
-
-	if (vma) {
-		if (vma->vm_ops && vma->vm_ops->get_policy)
-		        pol = vma->vm_ops->get_policy(vma, addr);
-		else if (vma->vm_policy &&
-				vma->vm_policy->policy != MPOL_DEFAULT)
-			pol = vma->vm_policy;
-	}
-	if (!pol)
-		pol = &default_policy;
-	return pol;
-}
-
 /* Return a zonelist representing a mempolicy */
 static struct zonelist *zonelist_policy(unsigned gfp, struct mempolicy *policy)
 {
@@ -858,28 +1053,6 @@
 	return 0;
 }
 
-/* Find secondary valid nodes for an allocation */
-int mpol_node_valid(int nid, struct vm_area_struct *vma, unsigned long addr)
-{
-	struct mempolicy *pol = get_vma_policy(vma, addr);
-
-	switch (pol->policy) {
-	case MPOL_PREFERRED:
-	case MPOL_DEFAULT:
-	case MPOL_INTERLEAVE:
-		return 1;
-	case MPOL_BIND: {
-		struct zone **z;
-		for (z = pol->v.zonelist->zones; *z; z++)
-			if ((*z)->zone_pgdat->node_id == nid)
-				return 1;
-		return 0;
-	}
-	default:
-		BUG();
-		return 0;
-	}
-}
 
 /*
  * Shared memory backing store policy support.
@@ -996,10 +1169,14 @@
 	/* Take care of old policies in the same range. */
 	while (n && n->start < end) {
 		struct rb_node *next = rb_next(&n->nd);
-		if (n->start >= start) {
-			if (n->end <= end)
+		if (n->start == start && n->end == end &&
+		    mpol_equal(n->policy, new->policy)) {
+			/* the same shared policy already exists, just exit */
+			goto out;
+		} else if (n->start >= start) {
+			if (n->end <= end) {
 				sp_delete(sp, n);
-			else
+			} else
 				n->start = end;
 		} else {
 			/* Old policy spanning whole new range. */
@@ -1022,6 +1199,7 @@
 	}
 	if (new)
 		sp_insert(sp, new);
+ out:
 	up(&sp->sem);
 	return 0;
 }
@@ -1067,6 +1245,37 @@
 	up(&p->sem);
 }
 
+struct page *
+alloc_page_shared_policy(unsigned gfp, struct shared_policy *sp,
+			 unsigned long idx)
+{
+	struct page *page;
+	struct mempolicy * shared_pol = NULL;
+
+	if (sp->root.rb_node) {
+		struct vm_area_struct pvma;
+		/* Create a pseudo vma that just contains the policy */
+		memset(&pvma, 0, sizeof(struct vm_area_struct));
+		pvma.vm_end = PAGE_SIZE;
+		pvma.vm_pgoff = idx;
+		shared_pol = mpol_shared_policy_lookup(sp, idx);
+		pvma.vm_policy = shared_pol;
+		page = alloc_page_vma(gfp, &pvma, 0);
+		mpol_free(pvma.vm_policy);
+	} else {
+		page = alloc_pages(gfp, 0);
+	}
+
+	if (page) {
+		if (shared_pol)
+			SetPageSharedPolicy(page);
+		else
+			ClearPageSharedPolicy(page);
+	}
+	
+	return page;
+}
+
 /* assumes fs == KERNEL_DS */
 void __init numa_policy_init(void)
 {
Index: linux-2.6.9/mm/readahead.c
===================================================================
--- linux-2.6.9.orig/mm/readahead.c
+++ linux-2.6.9/mm/readahead.c
@@ -245,7 +245,7 @@
 			continue;
 
 		spin_unlock_irq(&mapping->tree_lock);
-		page = page_cache_alloc_cold(mapping);
+		page = page_cache_alloc_cold(mapping, page_offset);
 		spin_lock_irq(&mapping->tree_lock);
 		if (!page)
 			break;
Index: linux-2.6.9/mm/shmem.c
===================================================================
--- linux-2.6.9.orig/mm/shmem.c
+++ linux-2.6.9/mm/shmem.c
@@ -841,16 +841,7 @@
 shmem_alloc_page(unsigned long gfp, struct shmem_inode_info *info,
 		 unsigned long idx)
 {
-	struct vm_area_struct pvma;
-	struct page *page;
-
-	memset(&pvma, 0, sizeof(struct vm_area_struct));
-	pvma.vm_policy = mpol_shared_policy_lookup(&info->policy, idx);
-	pvma.vm_pgoff = idx;
-	pvma.vm_end = PAGE_SIZE;
-	page = alloc_page_vma(gfp, &pvma, 0);
-	mpol_free(pvma.vm_policy);
-	return page;
+	return alloc_page_shared_policy(gfp, &info->policy, idx);
 }
 #else
 static inline struct page *

--------------030805040709080109040006--
