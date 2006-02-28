Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751909AbWB1HMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909AbWB1HMc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 02:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751910AbWB1HMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 02:12:32 -0500
Received: from ozlabs.org ([203.10.76.45]:8383 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751909AbWB1HMb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 02:12:31 -0500
Date: Tue, 28 Feb 2006 18:11:54 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: William Lee Irwin <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: hugepage: Strict page reservation for hugepage inodes
Message-ID: <20060228071154.GA20963@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>,
	William Lee Irwin <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This applies on top of my patch
hugepage-serialize-hugepage-allocation-and-instantiation.patch from
-mm, and akpm's associated tidying patches.

These days, hugepages are demand-allocated at first fault time.
There's a somewhat dubious (and racy) heuristic when making a new
mmap() to check if there are enough available hugepages to fully
satisfy that mapping.

A particularly obvious case where the heuristic breaks down is where a
process maps its hugepages not as a single chunk, but as a bunch of
individually mmap()ed (or shmat()ed) blocks without touching and
instantiating the pages in between allocations.  In this case the size
of each block is compared against the total number of available
hugepages.  It's thus easy for the process to become overcommitted,
because each block mapping will succeed, although the total number of
hugepages required by all blocks exceeds the number available.  In
particular, this defeats such a program which will detect a mapping
failure and adjust its hugepage usage downward accordingly.

The patch below addresses this problem, by strictly reserving a number
of physical hugepages for hugepage inodes which have been mapped, but
not instatiated.  MAP_SHARED mappings are thus "safe" - they will fail
on mmap(), not later with an OOM SIGKILL.  MAP_PRIVATE mappings can
still trigger an OOM.  (Actually SHARED mappings can technically still
OOM, but only if the sysadmin explicitly reduces the hugepage pool
between mapping and instantiation)

This patch appears to address the problem at hand - it allows DB2 to
start correctly, for instance, which previously suffered the failure
described above.

This patch causes no regressions on the libhugetblfs testsuite, and
makes a test (designed to catch this problem) pass which previously
failed (ppc64, POWER5).

Signed-off-by: David Gibson <dwg@au1.ibm.com>

Index: working-2.6/mm/hugetlb.c
===================================================================
--- working-2.6.orig/mm/hugetlb.c	2006-02-28 18:03:25.000000000 +1100
+++ working-2.6/mm/hugetlb.c	2006-02-28 18:03:37.000000000 +1100
@@ -21,7 +21,7 @@
 #include <linux/hugetlb.h>
 
 const unsigned long hugetlb_zero = 0, hugetlb_infinity = ~0UL;
-static unsigned long nr_huge_pages, free_huge_pages;
+static unsigned long nr_huge_pages, free_huge_pages, reserved_huge_pages;
 unsigned long max_huge_pages;
 static struct list_head hugepage_freelists[MAX_NUMNODES];
 static unsigned int nr_huge_pages_node[MAX_NUMNODES];
@@ -119,17 +119,146 @@ void free_huge_page(struct page *page)
 
 struct page *alloc_huge_page(struct vm_area_struct *vma, unsigned long addr)
 {
+	struct inode *inode = vma->vm_file->f_dentry->d_inode;
 	struct page *page;
+	int use_reserve = 0;
+	unsigned long idx;
 
 	spin_lock(&hugetlb_lock);
-	page = dequeue_huge_page(vma, addr);
-	if (!page) {
-		spin_unlock(&hugetlb_lock);
-		return NULL;
+
+	if (vma->vm_flags & VM_MAYSHARE) {
+
+		/* idx = radix tree index, i.e. offset into file in
+		 * HPAGE_SIZE units */
+		idx = ((addr - vma->vm_start) >> HPAGE_SHIFT)
+			+ (vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT));
+
+		/* The hugetlbfs specific inode info stores the number
+		 * of "guaranteed available" (huge) pages.  That is,
+		 * the first 'prereserved_hpages' pages of the inode
+		 * are either already instantiated, or have been
+		 * pre-reserved (by hugetlb_reserve_for_inode()). Here
+		 * we're in the process of instantiating the page, so
+		 * we use this to determine whether to draw from the
+		 * pre-reserved pool or the truly free pool. */
+		if (idx < HUGETLBFS_I(inode)->prereserved_hpages)
+			use_reserve = 1;
+	}
+
+	if (!use_reserve) {
+		if (free_huge_pages <= reserved_huge_pages)
+			goto fail;
+	} else {
+		BUG_ON(reserved_huge_pages == 0);
+		reserved_huge_pages--;
 	}
+
+	page = dequeue_huge_page(vma, addr);
+	if (!page)
+		goto fail;
+
 	spin_unlock(&hugetlb_lock);
 	set_page_count(page, 1);
 	return page;
+
+ fail:
+	WARN_ON(use_reserve); /* reserved allocations shouldn't fail */
+	spin_unlock(&hugetlb_lock);
+	return NULL;
+}
+
+/* hugetlb_extend_reservation()
+ *
+ * Ensure that at least 'atleast' hugepages are, and will remain,
+ * available to instantiate the first 'atleast' pages of the given
+ * inode.  If the inode doesn't already have this many pages reserved
+ * or instantiated, set aside some hugepages in the reserved pool to
+ * satisfy later faults (or fail now if there aren't enough, rather
+ * than getting the SIGBUS later).
+ */
+int hugetlb_extend_reservation(struct hugetlbfs_inode_info *info,
+			       unsigned long atleast)
+{
+	struct inode *inode = &info->vfs_inode;
+	struct address_space *mapping = inode->i_mapping;
+	unsigned long idx;
+	unsigned long change_in_reserve = 0;
+	struct page *page;
+	int ret = 0;
+
+	spin_lock(&hugetlb_lock);
+	read_lock_irq(&inode->i_mapping->tree_lock);
+
+	if (info->prereserved_hpages >= atleast)
+		goto out;
+
+	/* prereserved_hpages stores the number of pages already
+	 * guaranteed (reserved or instantiated) for this inode.
+	 * Count how many extra pages we need to reserve. */
+	for (idx = info->prereserved_hpages; idx < atleast; idx++) {
+		page = radix_tree_lookup(&mapping->page_tree, idx);
+		if (!page)
+			/* Pages which are already instantiated don't
+			 * need to be reserved */
+			change_in_reserve++;
+	}
+
+	BUG_ON(reserved_huge_pages > free_huge_pages);
+	if (change_in_reserve > (free_huge_pages-reserved_huge_pages)) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	reserved_huge_pages += change_in_reserve;
+	info->prereserved_hpages = atleast;
+
+ out:
+	read_unlock_irq(&inode->i_mapping->tree_lock);
+	spin_unlock(&hugetlb_lock);
+
+	return ret;
+}
+
+/* hugetlb_truncate_reservation()
+ *
+ * This returns pages reserved for the given inode to the general free
+ * hugepage pool.  If the inode has any pages prereserved, but not
+ * instantiated, beyond offset (atmost << HPAGE_SIZE), then release
+ * them.
+ */
+void hugetlb_truncate_reservation(struct hugetlbfs_inode_info *info,
+				  unsigned long atmost)
+{
+	struct inode *inode = &info->vfs_inode;
+	struct address_space *mapping = inode->i_mapping;
+	unsigned long idx;
+	unsigned long change_in_reserve = 0;
+	struct page *page;
+
+	spin_lock(&hugetlb_lock);
+	read_lock_irq(&inode->i_mapping->tree_lock);
+
+	if (info->prereserved_hpages <= atmost)
+		goto out;
+
+	/* Count pages which were reserved, but not instantiated, and
+	 * which we can now release. */
+	for (idx = atmost; idx < info->prereserved_hpages; idx++) {
+		page = radix_tree_lookup(&mapping->page_tree, idx);
+		if (!page)
+			/* Pages which are already instantiated can't
+			 * be unreserved (and in fact have already
+			 * been removed from the reserved pool) */
+			change_in_reserve++;
+	}
+
+	BUG_ON(reserved_huge_pages < change_in_reserve);
+	reserved_huge_pages -= change_in_reserve;
+	info->prereserved_hpages = atmost;
+
+ out:
+	read_unlock_irq(&inode->i_mapping->tree_lock);
+	spin_unlock(&hugetlb_lock);
 }
 
 static int __init hugetlb_init(void)
@@ -237,9 +366,11 @@ int hugetlb_report_meminfo(char *buf)
 	return sprintf(buf,
 			"HugePages_Total: %5lu\n"
 			"HugePages_Free:  %5lu\n"
+		        "HugePages_Rsvd:  %5lu\n"
 			"Hugepagesize:    %5lu kB\n",
 			nr_huge_pages,
 			free_huge_pages,
+		        reserved_huge_pages,
 			HPAGE_SIZE/1024);
 }
 
@@ -252,11 +383,6 @@ int hugetlb_report_node_meminfo(int nid,
 		nid, free_huge_pages_node[nid]);
 }
 
-int is_hugepage_mem_enough(size_t size)
-{
-	return (size + ~HPAGE_MASK)/HPAGE_SIZE <= free_huge_pages;
-}
-
 /* Return the number pages of memory we physically have, in PAGE_SIZE units. */
 unsigned long hugetlb_total_pages(void)
 {
Index: working-2.6/fs/hugetlbfs/inode.c
===================================================================
--- working-2.6.orig/fs/hugetlbfs/inode.c	2006-02-28 18:03:03.000000000 +1100
+++ working-2.6/fs/hugetlbfs/inode.c	2006-02-28 18:03:37.000000000 +1100
@@ -56,48 +56,10 @@ static void huge_pagevec_release(struct 
 	pagevec_reinit(pvec);
 }
 
-/*
- * huge_pages_needed tries to determine the number of new huge pages that
- * will be required to fully populate this VMA.  This will be equal to
- * the size of the VMA in huge pages minus the number of huge pages
- * (covered by this VMA) that are found in the page cache.
- *
- * Result is in bytes to be compatible with is_hugepage_mem_enough()
- */
-static unsigned long
-huge_pages_needed(struct address_space *mapping, struct vm_area_struct *vma)
-{
-	int i;
-	struct pagevec pvec;
-	unsigned long start = vma->vm_start;
-	unsigned long end = vma->vm_end;
-	unsigned long hugepages = (end - start) >> HPAGE_SHIFT;
-	pgoff_t next = vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT);
-	pgoff_t endpg = next + hugepages;
-
-	pagevec_init(&pvec, 0);
-	while (next < endpg) {
-		if (!pagevec_lookup(&pvec, mapping, next, PAGEVEC_SIZE))
-			break;
-		for (i = 0; i < pagevec_count(&pvec); i++) {
-			struct page *page = pvec.pages[i];
-			if (page->index > next)
-				next = page->index;
-			if (page->index >= endpg)
-				break;
-			next++;
-			hugepages--;
-		}
-		huge_pagevec_release(&pvec);
-	}
-	return hugepages << HPAGE_SHIFT;
-}
-
 static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct inode *inode = file->f_dentry->d_inode;
-	struct address_space *mapping = inode->i_mapping;
-	unsigned long bytes;
+	struct hugetlbfs_inode_info *info = HUGETLBFS_I(inode);
 	loff_t len, vma_len;
 	int ret;
 
@@ -113,10 +75,6 @@ static int hugetlbfs_file_mmap(struct fi
 	if (vma->vm_end - vma->vm_start < HPAGE_SIZE)
 		return -EINVAL;
 
-	bytes = huge_pages_needed(mapping, vma);
-	if (!is_hugepage_mem_enough(bytes))
-		return -ENOMEM;
-
 	vma_len = (loff_t)(vma->vm_end - vma->vm_start);
 
 	mutex_lock(&inode->i_mutex);
@@ -129,6 +87,10 @@ static int hugetlbfs_file_mmap(struct fi
 	if (!(vma->vm_flags & VM_WRITE) && len > inode->i_size)
 		goto out;
 
+	if (vma->vm_flags & VM_MAYSHARE)
+		if (hugetlb_extend_reservation(info, len >> HPAGE_SHIFT) != 0)
+			goto out;
+
 	ret = 0;
 	hugetlb_prefault_arch_hook(vma->vm_mm);
 	if (inode->i_size < len)
@@ -227,13 +189,18 @@ static void truncate_huge_page(struct pa
 	put_page(page);
 }
 
-static void truncate_hugepages(struct address_space *mapping, loff_t lstart)
+static void truncate_hugepages(struct inode *inode, loff_t lstart)
 {
+	struct address_space *mapping = &inode->i_data;
 	const pgoff_t start = lstart >> HPAGE_SHIFT;
 	struct pagevec pvec;
 	pgoff_t next;
 	int i;
 
+	hugetlb_truncate_reservation(HUGETLBFS_I(inode),
+				     lstart >> HPAGE_SHIFT);
+	if (! mapping->nrpages)
+		return;
 	pagevec_init(&pvec, 0);
 	next = start;
 	while (1) {
@@ -262,8 +229,7 @@ static void truncate_hugepages(struct ad
 
 static void hugetlbfs_delete_inode(struct inode *inode)
 {
-	if (inode->i_data.nrpages)
-		truncate_hugepages(&inode->i_data, 0);
+	truncate_hugepages(inode, 0);
 	clear_inode(inode);
 }
 
@@ -296,8 +262,7 @@ static void hugetlbfs_forget_inode(struc
 	inode->i_state |= I_FREEING;
 	inodes_stat.nr_inodes--;
 	spin_unlock(&inode_lock);
-	if (inode->i_data.nrpages)
-		truncate_hugepages(&inode->i_data, 0);
+	truncate_hugepages(inode, 0);
 	clear_inode(inode);
 	destroy_inode(inode);
 }
@@ -356,7 +321,7 @@ static int hugetlb_vmtruncate(struct ino
 	if (!prio_tree_empty(&mapping->i_mmap))
 		hugetlb_vmtruncate_list(&mapping->i_mmap, pgoff);
 	spin_unlock(&mapping->i_mmap_lock);
-	truncate_hugepages(mapping, offset);
+	truncate_hugepages(inode, offset);
 	return 0;
 }
 
@@ -573,6 +538,7 @@ static struct inode *hugetlbfs_alloc_ino
 		hugetlbfs_inc_free_inodes(sbinfo);
 		return NULL;
 	}
+	p->prereserved_hpages = 0;
 	return &p->vfs_inode;
 }
 
@@ -805,9 +771,6 @@ struct file *hugetlb_zero_setup(size_t s
 	if (!can_do_hugetlb_shm())
 		return ERR_PTR(-EPERM);
 
-	if (!is_hugepage_mem_enough(size))
-		return ERR_PTR(-ENOMEM);
-
 	if (!user_shm_lock(size, current->user))
 		return ERR_PTR(-ENOMEM);
 
@@ -831,6 +794,11 @@ struct file *hugetlb_zero_setup(size_t s
 	if (!inode)
 		goto out_file;
 
+	error = -ENOMEM;
+	if (hugetlb_extend_reservation(HUGETLBFS_I(inode),
+				       size >> HPAGE_SHIFT) != 0)
+		goto out_inode;
+
 	d_instantiate(dentry, inode);
 	inode->i_size = size;
 	inode->i_nlink = 0;
@@ -841,6 +809,8 @@ struct file *hugetlb_zero_setup(size_t s
 	file->f_mode = FMODE_WRITE | FMODE_READ;
 	return file;
 
+out_inode:
+	iput(inode);
 out_file:
 	put_filp(file);
 out_dentry:
Index: working-2.6/include/linux/hugetlb.h
===================================================================
--- working-2.6.orig/include/linux/hugetlb.h	2006-02-28 18:03:03.000000000 +1100
+++ working-2.6/include/linux/hugetlb.h	2006-02-28 18:03:37.000000000 +1100
@@ -20,7 +20,6 @@ void unmap_hugepage_range(struct vm_area
 int hugetlb_prefault(struct address_space *, struct vm_area_struct *);
 int hugetlb_report_meminfo(char *);
 int hugetlb_report_node_meminfo(int, char *);
-int is_hugepage_mem_enough(size_t);
 unsigned long hugetlb_total_pages(void);
 struct page *alloc_huge_page(struct vm_area_struct *, unsigned long);
 void free_huge_page(struct page *);
@@ -89,7 +88,6 @@ static inline unsigned long hugetlb_tota
 #define copy_hugetlb_page_range(src, dst, vma)	({ BUG(); 0; })
 #define hugetlb_prefault(mapping, vma)		({ BUG(); 0; })
 #define unmap_hugepage_range(vma, start, end)	BUG()
-#define is_hugepage_mem_enough(size)		0
 #define hugetlb_report_meminfo(buf)		0
 #define hugetlb_report_node_meminfo(n, buf)	0
 #define follow_huge_pmd(mm, addr, pmd, write)	NULL
@@ -132,6 +130,8 @@ struct hugetlbfs_sb_info {
 
 struct hugetlbfs_inode_info {
 	struct shared_policy policy;
+	/* Protected by the (global) hugetlb_lock */
+	unsigned long prereserved_hpages;
 	struct inode vfs_inode;
 };
 
@@ -148,6 +148,10 @@ static inline struct hugetlbfs_sb_info *
 extern struct file_operations hugetlbfs_file_operations;
 extern struct vm_operations_struct hugetlb_vm_ops;
 struct file *hugetlb_zero_setup(size_t);
+int hugetlb_extend_reservation(struct hugetlbfs_inode_info *info,
+			       unsigned long atleast_hpages);
+void hugetlb_truncate_reservation(struct hugetlbfs_inode_info *info,
+				  unsigned long atmost_hpages);
 int hugetlb_get_quota(struct address_space *mapping);
 void hugetlb_put_quota(struct address_space *mapping);
 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
