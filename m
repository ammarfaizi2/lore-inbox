Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751801AbWCIK4P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801AbWCIK4P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 05:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751812AbWCIK4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 05:56:15 -0500
Received: from fmr23.intel.com ([143.183.121.15]:35298 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751801AbWCIK4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 05:56:15 -0500
Message-Id: <200603091055.k29AtMg18402@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'David Gibson'" <david@gibson.dropbear.id.au>, <wli@holomorphy.com>,
       "'Andrew Morton'" <akpm@osdl.org>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: [patch] hugetlb strict commit accounting
Date: Thu, 9 Mar 2006 02:55:23 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZDZ/dD/W5zLRBlSKyv3WBA5WMJeA==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a competing implementation of hugetlb strict commit accounting.
A back port of what was done about two years ago by Andy Whitcroft, Ray
Bryant, and myself.

Essentially for the same purpose of this patch currently sit in -mm:

http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm3/broken-out/hugepage-strict-page-reservation-for
-hugepage-inodes.patch

Except it is BETTER and more robust :-)  because:

(1) it does arbitrary variable length and arbitrary variable offset
(2) doesn't need to perform linear traverse of page cache

It is more flexible that it will handle any arbitrary mmap offset
versus the one in -mm that always reserve entire hugetlb file size.
I've heard numerous complains from application developers that
hugetlb is difficult to use in current state of affair. Having
another peculiar behavior like "reservation would only work if
mmap offset is zero" adds another horrendous factor.


Posted here for -mm consideration.

Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>


 fs/hugetlbfs/inode.c    |  188 ++++++++++++++++++++++++++++++++++++++----------
 include/linux/hugetlb.h |    1 
 mm/hugetlb.c            |    3 
 3 files changed, 156 insertions(+), 36 deletions(-)

--- ./fs/hugetlbfs/inode.c.orig	2006-03-09 02:29:28.166820138 -0800
+++ ./fs/hugetlbfs/inode.c	2006-03-09 03:20:29.311313889 -0800
@@ -56,48 +56,160 @@ static void huge_pagevec_release(struct 
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
+struct file_region {
+	struct list_head link;
+	int from;
+	int to;
+};
+
+static int region_add(struct list_head *head, int f, int t)
 {
-	int i;
-	struct pagevec pvec;
-	unsigned long start = vma->vm_start;
-	unsigned long end = vma->vm_end;
-	unsigned long hugepages = (end - start) >> HPAGE_SHIFT;
-	pgoff_t next = vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT);
-	pgoff_t endpg = next + hugepages;
+	struct file_region *rg;
+	struct file_region *nrg;
+	struct file_region *trg;
+
+	/* Locate the region we are either in or before. */
+	list_for_each_entry(rg, head, link)
+		if (f <= rg->to)
+			break;
 
-	pagevec_init(&pvec, 0);
-	while (next < endpg) {
-		if (!pagevec_lookup(&pvec, mapping, next, PAGEVEC_SIZE))
+	/* Round our left edge to the current segment if it encloses us. */
+	if (f > rg->from)
+		f = rg->from;
+
+	/* Check for and consume any regions we now overlap with. */
+	nrg = rg;
+	list_for_each_entry_safe(rg, trg, rg->link.prev, link) {
+		if (&rg->link == head)
 			break;
-		for (i = 0; i < pagevec_count(&pvec); i++) {
-			struct page *page = pvec.pages[i];
-			if (page->index > next)
-				next = page->index;
-			if (page->index >= endpg)
-				break;
-			next++;
-			hugepages--;
+		if (rg->from > t)
+			break;
+
+		/* If this area reaches higher then extend our area to
+		 * include it completely.  If this is not the first area
+		 * which we intend to reuse, free it. */
+		if (rg->to > t)
+			t = rg->to;
+		if (rg != nrg) {
+			list_del(&rg->link);
+			kfree(rg);
 		}
-		huge_pagevec_release(&pvec);
 	}
-	return hugepages << HPAGE_SHIFT;
+	nrg->from = f;
+	nrg->to = t;
+	return 0;
+}
+
+static int region_chg(struct list_head *head, int f, int t)
+{
+	struct file_region *rg;
+	struct file_region *nrg;
+	loff_t chg = 0;
+
+	/* Locate the region we are before or in. */
+	list_for_each_entry(rg, head, link)
+		if (f <= rg->to)
+			break;
+
+	/* If we are below the current region then a new region is required.
+	 * Subtle, allocate a new region at the position but make it zero
+	 * size such that we can guarentee to record the reservation. */
+	if (&rg->link == head || t < rg->from) {
+		nrg = kmalloc(sizeof(*nrg), GFP_KERNEL);
+		if (nrg == 0)
+			return -ENOMEM;
+		nrg->from = f;
+		nrg->to   = f;
+		INIT_LIST_HEAD(&nrg->link);
+		list_add(&nrg->link, rg->link.prev);
+
+		return t - f;
+	}
+
+	/* Round our left edge to the current segment if it encloses us. */
+	if (f > rg->from)
+		f = rg->from;
+	chg = t - f;
+
+	/* Check for and consume any regions we now overlap with. */
+	list_for_each_entry(rg, rg->link.prev, link) {
+		if (&rg->link == head)
+			break;
+		if (rg->from > t)
+			return chg;
+
+		/* We overlap with this area, if it extends futher than
+		 * us then we must extend ourselves.  Account for its
+		 * existing reservation. */
+		if (rg->to > t) {
+			chg += rg->to - t;
+			t = rg->to;
+		}
+		chg -= rg->to - rg->from;
+	}
+	return chg;
+}
+
+static int region_truncate(struct list_head *head, int end)
+{
+	struct file_region *rg;
+	struct file_region *trg;
+	int chg = 0;
+
+	/* Locate the region we are either in or before. */
+	list_for_each_entry(rg, head, link)
+		if (end <= rg->to)
+			break;
+	if (&rg->link == head)
+		return 0;
+
+	/* If we are in the middle of a region then adjust it. */
+	if (end > rg->from) {
+		chg = rg->to - end;
+		rg->to = end;
+		rg = list_entry(rg->link.next, typeof(*rg), link);
+	}
+
+	/* Drop any remaining regions. */
+	list_for_each_entry_safe(rg, trg, rg->link.prev, link) {
+		if (&rg->link == head)
+			break;
+		chg += rg->to - rg->from;
+		list_del(&rg->link);
+		kfree(rg);
+	}
+	return chg;
+}
+
+#define VMACCTPG(x) ((x) >> (HPAGE_SHIFT - PAGE_SHIFT))
+int hugetlb_acct_memory(long delta)
+{
+	atomic_add(delta, &resv_huge_pages);
+	if (delta > 0 && atomic_read(&resv_huge_pages) >
+			VMACCTPG(hugetlb_total_pages())) {
+		atomic_add(-delta, &resv_huge_pages);
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+static int hugetlb_reserve_pages(struct inode *inode, int from, int to)
+{
+	int ret, chg;
+
+	chg = region_chg(&inode->i_mapping->private_list, from, to);
+	if (chg < 0)
+		return chg;
+	ret = hugetlb_acct_memory(chg);
+	if (ret < 0)
+		return ret;
+	region_add(&inode->i_mapping->private_list, from, to);
+	return 0;
 }
 
 static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct inode *inode = file->f_dentry->d_inode;
-	struct address_space *mapping = inode->i_mapping;
-	unsigned long bytes;
 	loff_t len, vma_len;
 	int ret;
 
@@ -113,10 +225,6 @@ static int hugetlbfs_file_mmap(struct fi
 	if (vma->vm_end - vma->vm_start < HPAGE_SIZE)
 		return -EINVAL;
 
-	bytes = huge_pages_needed(mapping, vma);
-	if (!is_hugepage_mem_enough(bytes))
-		return -ENOMEM;
-
 	vma_len = (loff_t)(vma->vm_end - vma->vm_start);
 
 	mutex_lock(&inode->i_mutex);
@@ -129,6 +237,11 @@ static int hugetlbfs_file_mmap(struct fi
 	if (!(vma->vm_flags & VM_WRITE) && len > inode->i_size)
 		goto out;
 
+	if (vma->vm_flags & VM_MAYSHARE)
+		if (hugetlb_reserve_pages(inode, VMACCTPG(vma->vm_pgoff),
+			VMACCTPG(vma->vm_pgoff + (vma_len >> PAGE_SHIFT))))
+			goto out;
+
 	ret = 0;
 	hugetlb_prefault_arch_hook(vma->vm_mm);
 	if (inode->i_size < len)
@@ -258,6 +371,8 @@ static void truncate_hugepages(struct ad
 		huge_pagevec_release(&pvec);
 	}
 	BUG_ON(!lstart && mapping->nrpages);
+	i = region_truncate(&mapping->private_list, start);
+	hugetlb_acct_memory(-i);
 }
 
 static void hugetlbfs_delete_inode(struct inode *inode)
@@ -401,6 +516,7 @@ static struct inode *hugetlbfs_get_inode
 		inode->i_mapping->a_ops = &hugetlbfs_aops;
 		inode->i_mapping->backing_dev_info =&hugetlbfs_backing_dev_info;
 		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+		INIT_LIST_HEAD(&inode->i_mapping->private_list);
 		info = HUGETLBFS_I(inode);
 		mpol_shared_policy_init(&info->policy, MPOL_DEFAULT, NULL);
 		switch (mode & S_IFMT) {
--- ./include/linux/hugetlb.h.orig	2006-03-09 02:29:28.943187316 -0800
+++ ./include/linux/hugetlb.h	2006-03-09 03:11:45.820109364 -0800
@@ -30,6 +30,7 @@ int hugetlb_fault(struct mm_struct *mm, 
 extern unsigned long max_huge_pages;
 extern const unsigned long hugetlb_zero, hugetlb_infinity;
 extern int sysctl_hugetlb_shm_group;
+extern atomic_t resv_huge_pages;
 
 /* arch callbacks */
 
--- ./mm/hugetlb.c.orig	2006-03-09 02:29:29.314281061 -0800
+++ ./mm/hugetlb.c	2006-03-09 03:24:34.546662447 -0800
@@ -21,6 +21,7 @@
 
 const unsigned long hugetlb_zero = 0, hugetlb_infinity = ~0UL;
 static unsigned long nr_huge_pages, free_huge_pages;
+atomic_t resv_huge_pages;
 unsigned long max_huge_pages;
 static struct list_head hugepage_freelists[MAX_NUMNODES];
 static unsigned int nr_huge_pages_node[MAX_NUMNODES];
@@ -225,9 +226,11 @@ int hugetlb_report_meminfo(char *buf)
 	return sprintf(buf,
 			"HugePages_Total: %5lu\n"
 			"HugePages_Free:  %5lu\n"
+			"HugePages_Resv:  %5u\n"
 			"Hugepagesize:    %5lu kB\n",
 			nr_huge_pages,
 			free_huge_pages,
+			atomic_read(&resv_huge_pages),
 			HPAGE_SIZE/1024);
 }
 

