Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbUDCDv6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 22:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbUDCDv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 22:51:57 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:17539 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261551AbUDCDvJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 22:51:09 -0500
Message-ID: <406E3613.6080609@sgi.com>
Date: Fri, 02 Apr 2004 21:57:07 -0600
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
CC: "'Andy Whitcroft'" <apw@shadowen.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, anton@samba.org, sds@epoch.ncsc.mil,
       ak@suse.de, lse-tech@lists.sourceforge.net, linux-ia64@vger.kernel.org
Subject: Re: [PATCH] HUGETLB memory commitment
References: <200404012309.i31N9MF14696@unix-os.sc.intel.com>
In-Reply-To: <200404012309.i31N9MF14696@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chen, Kenneth W wrote:

> 
> Can we just RIP this whole hugetlb page overcommit?
> 
> - Ken
> 
> 
>

Ken et al,

Perhaps the following patch might be more to your liking.  I'm sorry I haven't
been contributing to this discussion -- I've been off doing this code first
for Altix under 2.4.21 (one's got to eat, after all).  Now I've ported the
changes forward to Linux 2.6.5-rc3 and tested them.  The patch below is
relative to that version of Linux.

A few points to be made about this patch:

(1)  This patch includes "allocate on fault" and "hugetlb memory commit"
changes.  One can argue that this is mixing two changes into a single patch,
but the two changes seem intertwined to me -- one doesn't make sense without
the other.

(2)  I've only done the ia64 version.  I've not yet tackled Andrew's
suggestion that we move the common parts of the arch dependent hugetlbpage.c
up into ./mm.  So, since hugetlbfs_file_mmap() in this patch no longer calls
hugetlb_prefault(), this patch will break hugetlbpage support on architectures
other than ia64 until those architectures are fixed or we move the common code
up into the machine dependent mm directory.  If we can get agreement on this
patch then those that understand the arch components can help get the common
code defined and we can move that common code up to ./mm.

(3)  This code uses a simple implementation of the hugetlb memory commit
stuff.  It only accounts for hugetlb pages since creation of hugetlbpages
effectively moves those pages out of the common memory pool anyway.  It
satisfies the requirement that an mmap() for hugetlbpages get an -ENOMEM if
there are not enough hugetlb pages to (eventually) satisfy the request as
hugetlb pages are faulted in, as per Andew's suggesion that no interface
changes be made due to allocation of hugetlbpages at fault time instead of at
hugetlb_prefault() time.

The hugetlb memory commit code does this with a single global counter:
htlbzone_reserved, and a per inode reserved page count.  The latter is used to
decrement the global reserved page count when the inode is deleted or the file
is truncated.

The code does not change the SysV paths in the kernel.  Instead it implements
the reservation scheme in hugetlbfs_file_mmap() which is common code for
mmap() and shmget().

This is the reason that a separate reserved page counter is needed in the
inode.  (One might think that one could encode the reserved page count in the
size field of the inode, but I was unable to get that to work because the SysV
shared memory code sets inode->i_size before calling hugetlbfs_file_mmap().
So when we get there from the SysV code we are unable to recognize whether or
not this is the first time we have seen this inode, and thus need to reserve
pages, or this is a subsequent remapping of the inode that uses a previously
established reservation.  Using a separate field in the inode for this solves
that problem.)

Suggestions, flames, criticisms or (gasp) even praise gladly accepted by the
undersigned.  :-)

============================================================================
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1767  -> 1.1769
#	  include/linux/fs.h	1.295   -> 1.296
#	         mm/memory.c	1.154   -> 1.155
#	include/linux/hugetlb.h	1.23    -> 1.24
#	arch/ia64/mm/hugetlbpage.c	1.19    -> 1.21
#	fs/hugetlbfs/inode.c	1.40    -> 1.41
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/04/02	raybry@tomahawk.engr.sgi.com	1.1768
# memory.c:
#   Change handle_mm_fault() to call hugetlb_do_no_page() if this the fault
#   is for a hugetlb vma.  Change call to follow_hugetlb_page() to match the new
#   definition of same in hugetlbpage.c
# hugetlb.h:
#   Header changes related to hugetlbpage.c allocate on fault changes.
# fs.h:
#   Add union member "data" to union "u" in inode struct.  This overlays
#   void *generic_ip.  Used to hold reservation of hugetlbpages assigned
#   to this inode.
# inode.c:
#   Rewrite hugetlbfs_file_mmap() to eliminate hugetlb_prefault() and to
#   handle reservation of hugetlbpages via htlb_reserve()/unreserve()
# hugetlbpage.c:
#   Eliminate hugetlb_prefault(), replace with hugetlb_do_no_page.
#   Hugetlb pages now allocated at page fault time rather than mmap() time.
#   Move zeroing of hugetlbpage out of alloc_hugetlb_page().
#   Introduce htlbpage_reserved, htlb_reserve(), hugetlb_unreserve() to manage
#   reservation of hugetlbpages, so we can return -ENOMEM if there will not be
#   enough pages to (eventually) be allocated to satisfy this request.
# --------------------------------------------
# 04/04/02	raybry@tomahawk.engr.sgi.com	1.1769
# hugetlbpage.c:
#   Put check into decrease nr_hugepages loop in set_hugetlb_mem_size()
#   to make sure we don't reduce the number of hugetlbpages below number
#   of reserved hugetlbpages.
# --------------------------------------------
#
diff -Nru a/arch/ia64/mm/hugetlbpage.c b/arch/ia64/mm/hugetlbpage.c
--- a/arch/ia64/mm/hugetlbpage.c	Fri Apr  2 19:31:56 2004
+++ b/arch/ia64/mm/hugetlbpage.c	Fri Apr  2 19:31:56 2004
@@ -26,6 +26,7 @@
  int		htlbpage_max;
  static long	htlbzone_pages;
  unsigned int	hpage_shift=HPAGE_SHIFT_DEFAULT;
+static long     htlbzone_reserved;

  static struct list_head hugepage_freelists[MAX_NUMNODES];
  static spinlock_t htlbpage_lock = SPIN_LOCK_UNLOCKED;
@@ -65,9 +66,17 @@

  void free_huge_page(struct page *page);

-static struct page *alloc_hugetlb_page(void)
+static inline void zero_hugetlb_page(struct page *page)
  {
  	int i;
+
+	for (i = 0; i < (HPAGE_SIZE/PAGE_SIZE); ++i) {
+		clear_highpage(&page[i]);
+	}
+}
+
+static struct page *alloc_hugetlb_page(void)
+{
  	struct page *page;

  	spin_lock(&htlbpage_lock);
@@ -80,8 +89,6 @@
  	spin_unlock(&htlbpage_lock);
  	set_page_count(page, 1);
  	page->lru.prev = (void *)free_huge_page;
-	for (i = 0; i < (HPAGE_SIZE/PAGE_SIZE); ++i)
-		clear_highpage(&page[i]);
  	return page;
  }

@@ -153,20 +160,22 @@
  {
  	pte_t *src_pte, *dst_pte, entry;
  	struct page *ptepage;
-	unsigned long addr = vma->vm_start;
-	unsigned long end = vma->vm_end;
+	unsigned long addr;

-	while (addr < end) {
+	for (addr=vma->vm_start; addr<vma->vm_end; addr += HPAGE_SIZE) {
  		dst_pte = huge_pte_alloc(dst, addr);
  		if (!dst_pte)
  			goto nomem;
  		src_pte = huge_pte_offset(src, addr);
+		if (!src_pte)
+		        continue;
  		entry = *src_pte;
-		ptepage = pte_page(entry);
-		get_page(ptepage);
+		if (pte_present(entry)) {
+			ptepage = pte_page(entry);
+			get_page(ptepage);
+			dst->rss += (HPAGE_SIZE / PAGE_SIZE);
+		}
  		set_pte(dst_pte, entry);
-		dst->rss += (HPAGE_SIZE / PAGE_SIZE);
-		addr += HPAGE_SIZE;
  	}
  	return 0;
  nomem:
@@ -174,9 +183,9 @@
  }

  int
-follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
+follow_hugetlb_page(struct task_struct *tsk, struct mm_struct *mm, struct vm_area_struct *vma,
  		    struct page **pages, struct vm_area_struct **vmas,
-		    unsigned long *st, int *length, int i)
+		    unsigned long *st, int *length, int i, int write)
  {
  	pte_t *ptep, pte;
  	unsigned long start = *st;
@@ -187,6 +196,18 @@
  	do {
  		pstart = start & HPAGE_MASK;
  		ptep = huge_pte_offset(mm, start);
+
+		/*
+		 * the page was reserved, we should get it with a minor fault
+		 * since hugetlb pages are never swapped out
+		 */
+		if (!ptep || !pte_present(*ptep)) {
+			if (handle_mm_fault(mm, vma, start, write) != 1)
+				BUG();
+			tsk->min_flt++;
+			ptep = huge_pte_offset(mm, start);
+		}
+
  		pte = *ptep;

  back1:
@@ -228,6 +249,12 @@
  	pte_t *ptep;

  	ptep = huge_pte_offset(mm, addr);
+	if (!ptep || !pte_present(*ptep)) {
+		if (handle_mm_fault(mm, vma, addr, write) != 1)
+			BUG();
+		current->min_flt++;
+		ptep = huge_pte_offset(mm, addr);
+	}
  	page = pte_page(*ptep);
  	page += ((addr & ~HPAGE_MASK) >> PAGE_SHIFT);
  	get_page(page);
@@ -347,6 +374,7 @@
  	spin_unlock(&mm->page_table_lock);
  }

+#ifdef NOTDEF
  int hugetlb_prefault(struct address_space *mapping, struct vm_area_struct *vma)
  {
  	struct mm_struct *mm = current->mm;
@@ -398,6 +426,32 @@
  	spin_unlock(&mm->page_table_lock);
  	return ret;
  }
+#endif
+
+int hugetlb_reserve(int nr_hugepages)
+{
+	int rc;
+
+	spin_lock(&htlbpage_lock);
+	if ((htlbzone_reserved + nr_hugepages) <= htlbzone_pages) {
+		htlbzone_reserved += nr_hugepages;
+		rc = nr_hugepages;
+		goto out_unlock;
+	}
+	rc = -ENOMEM;
+
+out_unlock:
+	spin_unlock(&htlbpage_lock);
+	return rc;
+}
+
+void hugetlb_unreserve(int nr_hugepages)
+{
+	spin_lock(&htlbpage_lock);
+	htlbzone_reserved -= nr_hugepages;
+	spin_unlock(&htlbpage_lock);
+	return;
+}

  unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
  		unsigned long pgoff, unsigned long flags)
@@ -422,6 +476,8 @@
  		addr = ALIGN(vmm->vm_end, HPAGE_SIZE);
  	}
  }
+
+/* caller must hold htlbpage_lock */
  void update_and_free_page(struct page *page)
  {
  	int j;
@@ -498,6 +554,8 @@
  	/* Shrink the memory size. */
  	lcount = try_to_free_low(lcount);
  	while (lcount++) {
+		if (htlbzone_pages <= htlbzone_reserved)
+			break;
  		page = alloc_hugetlb_page();
  		if (page == NULL)
  			break;
@@ -541,6 +599,7 @@
  		printk(KERN_WARNING "Invalid huge page size specified\n");
  		return 1;
  	}
+	htlbzone_reserved = 0;

  	hpage_shift = __ffs(size);
  	/*
@@ -577,12 +636,14 @@
  int hugetlb_report_meminfo(char *buf)
  {
  	return sprintf(buf,
-			"HugePages_Total: %5lu\n"
-			"HugePages_Free:  %5lu\n"
-			"Hugepagesize:    %5lu kB\n",
+			"HugePages_Total:    %5lu\n"
+			"HugePages_Free:     %5lu\n"
+			"Hugepagesize:       %5lu kB\n"
+			"HugePages_Reserved: %5lu\n",
  			htlbzone_pages,
  			htlbpagemem,
-			HPAGE_SIZE/1024);
+			HPAGE_SIZE/1024,
+			htlbzone_reserved);
  }

  int is_hugepage_mem_enough(size_t size)
@@ -602,6 +663,72 @@
  {
  	BUG();
  	return NULL;
+}
+
+/*
+ * enter with mm->mmap_sem held in read mode and mm->page_table_lock held
+ * drops mm->page_table_lock before returning
+ */
+int hugetlb_do_no_page(struct mm_struct * mm, struct vm_area_struct * vma,
+	unsigned long address, int write_access)
+{
+	struct file *file = vma->vm_file;
+	struct address_space *mapping = file->f_dentry->d_inode->i_mapping;
+	pte_t *pte;
+	unsigned long idx;
+	struct page *page;
+	int rc;
+
+	address &= ~(HPAGE_SIZE-1);
+
+	pte = huge_pte_alloc(mm, address);
+
+	if (!pte) {
+		rc = 0;
+		goto unlock_and_return;
+	}
+
+	/*
+	 * we don't drop the page_table_lock before here, so if we find the
+	 * pte valid now, then a previous lock holder handled the fault
+	 */
+	if (!pte_none(*pte)) {
+		rc = 1;
+		goto unlock_and_return;
+	}
+
+	mm->rss += HPAGE_SIZE / PAGE_SIZE;
+
+	idx = ((address - vma->vm_start) >> HPAGE_SHIFT)
+		+ (vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT));
+	page = find_get_page(mapping, idx);
+
+	if (!page) {
+
+		page = alloc_hugetlb_page();
+
+		/* we reserved the page in hugetlbfs_file_mmap() */
+		BUG_ON(!page);
+
+		add_to_page_cache(page, mapping, idx, GFP_ATOMIC);
+		unlock_page(page);
+
+		set_huge_pte(mm, vma, page, pte, vma->vm_flags & VM_WRITE);
+		mark_page_accessed(page);
+		update_mmu_cache(vma, address, *pte);
+		spin_unlock(&mm->page_table_lock);
+		zero_hugetlb_page(page);
+		return 1;
+
+	}
+	mark_page_accessed(page);
+	update_mmu_cache(vma, address, *pte);
+	set_huge_pte(mm, vma, page, pte, vma->vm_flags & VM_WRITE);
+	rc = 1;
+
+unlock_and_return:
+	spin_unlock(&mm->page_table_lock);
+	return rc;
  }

  struct vm_operations_struct hugetlb_vm_ops = {
diff -Nru a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
--- a/fs/hugetlbfs/inode.c	Fri Apr  2 19:31:56 2004
+++ b/fs/hugetlbfs/inode.c	Fri Apr  2 19:31:56 2004
@@ -47,8 +47,7 @@
  {
  	struct inode *inode = file->f_dentry->d_inode;
  	struct address_space *mapping = inode->i_mapping;
-	loff_t len, vma_len;
-	int ret;
+	unsigned long reserved_pages, prev_reserved_pages, new_reservation;

  	if (vma->vm_start & ~HPAGE_MASK)
  		return -EINVAL;
@@ -59,19 +58,34 @@
  	if (vma->vm_end - vma->vm_start < HPAGE_SIZE)
  		return -EINVAL;

-	vma_len = (loff_t)(vma->vm_end - vma->vm_start);
+ 	reserved_pages = (vma->vm_end - vma->vm_start) >> HPAGE_SHIFT;

  	down(&inode->i_sem);
  	file_accessed(file);
+
+ 	/* a second mmap() (or a rmap()) can change the reservation */
+ 	prev_reserved_pages = inode->u.data;
+
+ 	/*
+ 	 * if current mmap() is smaller than previous reservation,
+ 	 * we don't change reservation or quota
+ 	 */
+ 	if (reserved_pages >= prev_reserved_pages) {
+ 		new_reservation = reserved_pages - prev_reserved_pages;
+ 		if ((hugetlb_get_quota(mapping, new_reservation) < 0) ||
+ 			(hugetlb_reserve(new_reservation) < 0)) {
+ 				up(&inode->i_sem);
+ 				return -ENOMEM;
+ 		}
+ 		inode->i_size = reserved_pages << HPAGE_SHIFT;
+ 		inode->u.data = reserved_pages;
+ 	}
+	up(&inode->i_sem);
+
  	vma->vm_flags |= VM_HUGETLB | VM_RESERVED;
  	vma->vm_ops = &hugetlb_vm_ops;
-	ret = hugetlb_prefault(mapping, vma);
-	len = vma_len +	((loff_t)vma->vm_pgoff << PAGE_SHIFT);
-	if (ret == 0 && inode->i_size < len)
-		inode->i_size = len;
-	up(&inode->i_sem);

-	return ret;
+	return 0;
  }

  /*
@@ -158,6 +172,7 @@
  void truncate_hugepages(struct address_space *mapping, loff_t lstart)
  {
  	const pgoff_t start = lstart >> HPAGE_SHIFT;
+	struct inode *inode = mapping->host;
  	struct pagevec pvec;
  	pgoff_t next;
  	int i;
@@ -181,10 +196,11 @@
  			++next;
  			truncate_huge_page(page);
  			unlock_page(page);
-			hugetlb_put_quota(mapping);
  		}
  		huge_pagevec_release(&pvec);
  	}
+	hugetlb_put_quota(mapping, inode->u.data-start);
+	hugetlb_unreserve(inode->u.data-start);
  	BUG_ON(!lstart && mapping->nrpages);
  }

@@ -198,8 +214,11 @@
  	inodes_stat.nr_inodes--;
  	spin_unlock(&inode_lock);

-	if (inode->i_data.nrpages)
-		truncate_hugepages(&inode->i_data, 0);
+	/*
+	 * we need to call this even if inode->i_data.nrpages == 0 to
+	 * update the file system quota and hugetlb page reservation
+	 */
+	truncate_hugepages(&inode->i_data, 0);

  	security_inode_delete(inode);

@@ -239,8 +258,11 @@
  	inode->i_state |= I_FREEING;
  	inodes_stat.nr_inodes--;
  	spin_unlock(&inode_lock);
-	if (inode->i_data.nrpages)
-		truncate_hugepages(&inode->i_data, 0);
+	/*
+	 * we need to call this even if inode->i_data.nrpages == 0 to
+	 * update the file system quota and hugetlb page reservation
+	 */
+	truncate_hugepages(&inode->i_data, 0);

  	if (sbinfo->free_inodes >= 0) {
  		spin_lock(&sbinfo->stat_lock);
@@ -383,6 +405,7 @@
  		inode->i_mapping->a_ops = &hugetlbfs_aops;
  		inode->i_mapping->backing_dev_info =&hugetlbfs_backing_dev_info;
  		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+		inode->u.data = 0;
  		switch (mode & S_IFMT) {
  		default:
  			init_special_inode(inode, mode, dev);
@@ -641,15 +664,15 @@
  	return -ENOMEM;
  }

-int hugetlb_get_quota(struct address_space *mapping)
+int hugetlb_get_quota(struct address_space *mapping, unsigned long nr_pages)
  {
  	int ret = 0;
  	struct hugetlbfs_sb_info *sbinfo = HUGETLBFS_SB(mapping->host->i_sb);

  	if (sbinfo->free_blocks > -1) {
  		spin_lock(&sbinfo->stat_lock);
-		if (sbinfo->free_blocks > 0)
-			sbinfo->free_blocks--;
+		if (sbinfo->free_blocks >= nr_pages)
+			sbinfo->free_blocks -= nr_pages;
  		else
  			ret = -ENOMEM;
  		spin_unlock(&sbinfo->stat_lock);
@@ -658,13 +681,13 @@
  	return ret;
  }

-void hugetlb_put_quota(struct address_space *mapping)
+void hugetlb_put_quota(struct address_space *mapping, unsigned long nr_pages)
  {
  	struct hugetlbfs_sb_info *sbinfo = HUGETLBFS_SB(mapping->host->i_sb);

  	if (sbinfo->free_blocks > -1) {
  		spin_lock(&sbinfo->stat_lock);
-		sbinfo->free_blocks++;
+		sbinfo->free_blocks += nr_pages;
  		spin_unlock(&sbinfo->stat_lock);
  	}
  }
diff -Nru a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	Fri Apr  2 19:31:56 2004
+++ b/include/linux/fs.h	Fri Apr  2 19:31:56 2004
@@ -425,6 +425,7 @@
  	__u32			i_generation;
  	union {
  		void		*generic_ip;
+		long		data;
  	} u;
  #ifdef __NEED_I_SIZE_ORDERED
  	seqcount_t		i_size_seqcount;
diff -Nru a/include/linux/hugetlb.h b/include/linux/hugetlb.h
--- a/include/linux/hugetlb.h	Fri Apr  2 19:31:56 2004
+++ b/include/linux/hugetlb.h	Fri Apr  2 19:31:56 2004
@@ -12,10 +12,12 @@

  int hugetlb_sysctl_handler(struct ctl_table *, int, struct file *, void *, size_t *);
  int copy_hugetlb_page_range(struct mm_struct *, struct mm_struct *, struct vm_area_struct *);
-int follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *, struct page **, struct vm_area_struct **, unsigned long *, int *, int);
+int follow_hugetlb_page(struct task_struct *, struct mm_struct *, struct vm_area_struct *,
+	struct page **, struct vm_area_struct **, unsigned long *, int *, int, int);
  void zap_hugepage_range(struct vm_area_struct *, unsigned long, unsigned long);
  void unmap_hugepage_range(struct vm_area_struct *, unsigned long, unsigned long);
-int hugetlb_prefault(struct address_space *, struct vm_area_struct *);
+int hugetlb_reserve(int);
+void hugetlb_unreserve(int);
  void huge_page_release(struct page *);
  int hugetlb_report_meminfo(char *);
  int is_hugepage_mem_enough(size_t);
@@ -111,8 +113,10 @@
  extern struct file_operations hugetlbfs_file_operations;
  extern struct vm_operations_struct hugetlb_vm_ops;
  struct file *hugetlb_zero_setup(size_t);
-int hugetlb_get_quota(struct address_space *mapping);
-void hugetlb_put_quota(struct address_space *mapping);
+int hugetlb_get_quota(struct address_space *mapping, unsigned long nr_pages);
+void hugetlb_put_quota(struct address_space *mapping, unsigned long nr_pages);
+extern int hugetlb_do_no_page(struct mm_struct * mm, struct vm_area_struct * vma,
+	unsigned long address, int write_access);

  static inline int is_file_hugepages(struct file *file)
  {
diff -Nru a/mm/memory.c b/mm/memory.c
--- a/mm/memory.c	Fri Apr  2 19:31:56 2004
+++ b/mm/memory.c	Fri Apr  2 19:31:56 2004
@@ -741,8 +741,8 @@
  			return i ? : -EFAULT;

  		if (is_vm_hugetlb_page(vma)) {
-			i = follow_hugetlb_page(mm, vma, pages, vmas,
-						&start, &len, i);
+			i = follow_hugetlb_page(tsk, mm, vma, pages, vmas,
+						&start, &len, i, write);
  			continue;
  		}
  		spin_lock(&mm->page_table_lock);
@@ -1619,7 +1619,7 @@
  	inc_page_state(pgfault);

  	if (is_vm_hugetlb_page(vma))
-		return VM_FAULT_SIGBUS;	/* mapping truncation does this. */
+		return hugetlb_do_no_page(mm, vma, address, write_access);

  	/*
  	 * We need the page table lock to synchronize with kswapd

============================================================================


-- 
Best Regards,
Ray
-----------------------------------------------
                   Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
            so I installed Linux.
-----------------------------------------------


