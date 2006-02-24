Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbWBXAaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbWBXAaI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 19:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWBXAaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 19:30:08 -0500
Received: from ozlabs.org ([203.10.76.45]:6016 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932264AbWBXAaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 19:30:06 -0500
Date: Fri, 24 Feb 2006 11:29:29 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>, William Lee Irwin <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Strict page reservation for hugepage inodes
Message-ID: <20060224002929.GB27750@localhost.localdomain>
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

The patch below is a draft attempt to address this problem, by
strictly reserving a number of physical hugepages for hugepages inodes
which have been mapped, but not instatiated.  MAP_SHARED mappings are
thus "safe" - they will fail on mmap(), not later with a SIGBUS.
MAP_PRIVATE mappings can still SIGBUS.  (Actually SHARED mappings can
technically still SIGBUS, but only if the sysadmin explicitly reduces
the hugepage pool between mapping and instantiation)

This patch appears to address the problem at hand - it allows DB2 to
start correctly, for instance, which previously suffered the failure
described above.

I'm not terribly convinced that I don't need some more locking, but if
so it's far from obvious what.  VFS synchronization baffles me.

Signed-off-by: David Gibson <dwg@au1.ibm.com>

Index: working-2.6/mm/hugetlb.c
===================================================================
--- working-2.6.orig/mm/hugetlb.c	2006-02-17 14:44:04.000000000 +1100
+++ working-2.6/mm/hugetlb.c	2006-02-20 14:10:24.000000000 +1100
@@ -20,7 +20,7 @@
 #include <linux/hugetlb.h>
 
 const unsigned long hugetlb_zero = 0, hugetlb_infinity = ~0UL;
-static unsigned long nr_huge_pages, free_huge_pages;
+static unsigned long nr_huge_pages, free_huge_pages, reserved_huge_pages;
 unsigned long max_huge_pages;
 static struct list_head hugepage_freelists[MAX_NUMNODES];
 static unsigned int nr_huge_pages_node[MAX_NUMNODES];
@@ -94,21 +94,87 @@ void free_huge_page(struct page *page)
 
 struct page *alloc_huge_page(struct vm_area_struct *vma, unsigned long addr)
 {
+	struct inode *inode = vma->vm_file->f_dentry->d_inode;
 	struct page *page;
 	int i;
+	int use_reserve = 0;
+
+	if (vma->vm_flags & VM_MAYSHARE) {
+		unsigned long idx;
+
+		idx = ((addr - vma->vm_start) >> HPAGE_SHIFT)
+			+ (vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT));
+
+		if (idx < inode->i_blocks)
+			use_reserve = 1;
+	}
 
 	spin_lock(&hugetlb_lock);
-	page = dequeue_huge_page(vma, addr);
-	if (!page) {
-		spin_unlock(&hugetlb_lock);
-		return NULL;
+	if (! use_reserve) {
+		if (free_huge_pages <= reserved_huge_pages)
+			goto fail;
+	} else {
+		reserved_huge_pages--;
 	}
+
+	page = dequeue_huge_page(vma, addr);
+	if (!page)
+		goto fail;
+
 	spin_unlock(&hugetlb_lock);
+
 	set_page_count(page, 1);
 	page[1].lru.next = (void *)free_huge_page;	/* set dtor */
 	for (i = 0; i < (HPAGE_SIZE/PAGE_SIZE); ++i)
 		clear_user_highpage(&page[i], addr);
 	return page;
+
+ fail:
+	WARN_ON(use_reserve); /* reserved allocations shouldn't fail */
+	spin_unlock(&hugetlb_lock);
+	return NULL;
+}
+
+int hugetlb_reserve_for_inode(struct inode *inode, unsigned long npages)
+{
+	struct address_space *mapping = inode->i_mapping;
+	unsigned long pg;
+	long change_in_reserve = 0;
+	struct page *page;
+	int ret = -ENOMEM;
+
+	read_lock_irq(&inode->i_mapping->tree_lock);
+	for (pg = inode->i_blocks; pg < npages; pg++) {
+		page = radix_tree_lookup(&mapping->page_tree, pg);
+		if (! page)
+			change_in_reserve++;
+	}
+
+	for (pg = npages; pg < inode->i_blocks; pg++) {
+		page = radix_tree_lookup(&mapping->page_tree, pg);
+		if (! page)
+			change_in_reserve--;
+	}
+	spin_lock(&hugetlb_lock);
+	if ((change_in_reserve > 0)
+	    && (change_in_reserve > (free_huge_pages-reserved_huge_pages))) {
+		printk("Failing:  change=%ld   free=%lu\n",
+		       change_in_reserve, free_huge_pages - reserved_huge_pages);
+		goto out;
+	}
+
+	reserved_huge_pages += change_in_reserve;
+	inode->i_blocks = npages;
+
+	ret = 0;
+
+ out:
+	spin_unlock(&hugetlb_lock);
+	read_unlock_irq(&inode->i_mapping->tree_lock);
+
+/* 	printk("hugetlb_reserve_for_inode(.., %lu) = %d   delta = %ld\n", */
+/* 	       npages, ret, change_in_reserve); */
+	return ret;
 }
 
 static int __init hugetlb_init(void)
@@ -225,9 +291,11 @@ int hugetlb_report_meminfo(char *buf)
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
 
Index: working-2.6/fs/hugetlbfs/inode.c
===================================================================
--- working-2.6.orig/fs/hugetlbfs/inode.c	2006-02-02 10:08:13.000000000 +1100
+++ working-2.6/fs/hugetlbfs/inode.c	2006-02-20 14:10:24.000000000 +1100
@@ -56,48 +56,9 @@ static void huge_pagevec_release(struct 
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
 	loff_t len, vma_len;
 	int ret;
 
@@ -113,13 +74,8 @@ static int hugetlbfs_file_mmap(struct fi
 	if (vma->vm_end - vma->vm_start < HPAGE_SIZE)
 		return -EINVAL;
 
-	bytes = huge_pages_needed(mapping, vma);
-	if (!is_hugepage_mem_enough(bytes))
-		return -ENOMEM;
-
 	vma_len = (loff_t)(vma->vm_end - vma->vm_start);
 
-	mutex_lock(&inode->i_mutex);
 	file_accessed(file);
 	vma->vm_flags |= VM_HUGETLB | VM_RESERVED;
 	vma->vm_ops = &hugetlb_vm_ops;
@@ -129,13 +85,22 @@ static int hugetlbfs_file_mmap(struct fi
 	if (!(vma->vm_flags & VM_WRITE) && len > inode->i_size)
 		goto out;
 
-	ret = 0;
+	if (inode->i_blocks < (len >> HPAGE_SHIFT)) {
+		ret = hugetlb_reserve_for_inode(inode, len >> HPAGE_SHIFT);
+		if (ret) {
+			printk("Reservation failed: %lu pages\n",
+			       (unsigned long)(len >> HPAGE_SHIFT));
+			goto out;
+		}
+	}
+
 	hugetlb_prefault_arch_hook(vma->vm_mm);
 	if (inode->i_size < len)
 		inode->i_size = len;
-out:
-	mutex_unlock(&inode->i_mutex);
 
+	ret = 0;
+
+out:
 	return ret;
 }
 
@@ -227,12 +192,17 @@ static void truncate_huge_page(struct pa
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
+	int ret;
+
+	ret = hugetlb_reserve_for_inode(inode, lstart >> HPAGE_SHIFT);
+	WARN_ON(ret); /* truncation should never cause a reservation failure */
 
 	pagevec_init(&pvec, 0);
 	next = start;
@@ -262,8 +232,7 @@ static void truncate_hugepages(struct ad
 
 static void hugetlbfs_delete_inode(struct inode *inode)
 {
-	if (inode->i_data.nrpages)
-		truncate_hugepages(&inode->i_data, 0);
+	truncate_hugepages(inode, 0);
 	clear_inode(inode);
 }
 
@@ -296,8 +265,7 @@ static void hugetlbfs_forget_inode(struc
 	inode->i_state |= I_FREEING;
 	inodes_stat.nr_inodes--;
 	spin_unlock(&inode_lock);
-	if (inode->i_data.nrpages)
-		truncate_hugepages(&inode->i_data, 0);
+	truncate_hugepages(inode, 0);
 	clear_inode(inode);
 	destroy_inode(inode);
 }
@@ -356,7 +324,7 @@ static int hugetlb_vmtruncate(struct ino
 	if (!prio_tree_empty(&mapping->i_mmap))
 		hugetlb_vmtruncate_list(&mapping->i_mmap, pgoff);
 	spin_unlock(&mapping->i_mmap_lock);
-	truncate_hugepages(mapping, offset);
+	truncate_hugepages(inode, offset);
 	return 0;
 }
 
Index: working-2.6/include/linux/hugetlb.h
===================================================================
--- working-2.6.orig/include/linux/hugetlb.h	2006-01-16 13:02:29.000000000 +1100
+++ working-2.6/include/linux/hugetlb.h	2006-02-20 14:10:24.000000000 +1100
@@ -22,6 +22,7 @@ int hugetlb_report_meminfo(char *);
 int hugetlb_report_node_meminfo(int, char *);
 int is_hugepage_mem_enough(size_t);
 unsigned long hugetlb_total_pages(void);
+int hugetlb_reserve_for_inode(struct inode *inode, unsigned long npages);
 struct page *alloc_huge_page(struct vm_area_struct *, unsigned long);
 void free_huge_page(struct page *);
 int hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
