Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbUDMXfv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 19:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263814AbUDMXfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 19:35:51 -0400
Received: from fmr04.intel.com ([143.183.121.6]:19119 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S261793AbUDMXfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 19:35:38 -0400
Message-Id: <200404132322.i3DNMuF21215@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
       <lse-tech@lists.sourceforge.net>
Cc: <raybry@sgi.com>, "'Andy Whitcroft'" <apw@shadowen.org>,
       "'Andrew Morton'" <akpm@osdl.org>
Subject: hugetlb demand paging patch part [2/3]
Date: Tue, 13 Apr 2004 16:22:56 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcQhrkCKoQxpiCw3QF6CITndDnpTHg==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Part 2 of 3

2. hugetlb_demand_generic.patch - this handles bulk of hugetlb demand
   paging for generic portion of the kernel.  I've put hugetlb fault
   handler in mm/hugetlbpage.c since the fault handler is *exactly* the
   same for all arch, but that requires opening up huge_pte_alloc() and
   set_huge_pte() functions in each arch.  If people object where it
   should live.  It takes me less than a minute to delete the common
   code and replicate it in each of the 5 arch that supports hugetlb.
   Just let me know if that's the case.


 fs/hugetlbfs/inode.c    |   18 +++------------
 include/linux/hugetlb.h |    9 ++++---
 mm/hugetlb.c            |   56 ++++++++++++++++++++++++++++++++++++++++++++----
 mm/memory.c             |    7 ------
 4 files changed, 62 insertions(+), 28 deletions(-)

diff -Nurp linux-2.6.5/fs/hugetlbfs/inode.c linux-2.6.5.htlb/fs/hugetlbfs/inode.c
--- linux-2.6.5/fs/hugetlbfs/inode.c	2004-04-13 12:56:29.000000000 -0700
+++ linux-2.6.5.htlb/fs/hugetlbfs/inode.c	2004-04-13 12:42:35.000000000 -0700
@@ -218,11 +218,6 @@ static int hugetlb_acct_commit(struct in
 {
 	return region_add(&inode->i_mapping->private_list, from, to);
 }
-static void hugetlb_acct_undo(struct inode *inode, int chg)
-{
-	hugetlb_put_quota(inode->i_mapping, chg);
-	hugetlb_acct_memory(-chg);
-}
 static void hugetlb_acct_release(struct inode *inode, int to)
 {
 	int chg;
@@ -252,9 +247,8 @@ static struct backing_dev_info hugetlbfs
 static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct inode *inode = file->f_dentry->d_inode;
-	struct address_space *mapping = inode->i_mapping;
 	loff_t len, vma_len;
-	int ret;
+	int ret = 0;
 	int chg;

 	if (vma->vm_start & ~HPAGE_MASK)
@@ -281,15 +275,11 @@ static int hugetlbfs_file_mmap(struct fi
 	file_accessed(file);
 	vma->vm_flags |= VM_HUGETLB | VM_RESERVED;
 	vma->vm_ops = &hugetlb_vm_ops;
-	ret = hugetlb_prefault(mapping, vma);
 	len = vma_len +	((loff_t)vma->vm_pgoff << PAGE_SHIFT);
-	if (ret == 0) {
-	       if (inode->i_size < len)
-			inode->i_size = len;
-		hugetlb_acct_commit(inode, VMACCTPG(vma->vm_pgoff),
+	if (inode->i_size < len)
+		inode->i_size = len;
+	hugetlb_acct_commit(inode, VMACCTPG(vma->vm_pgoff),
 			VMACCTPG(vma->vm_pgoff + (vma_len >> PAGE_SHIFT)));
-	} else
-		hugetlb_acct_undo(inode, chg);

 unlock_out:
 	up(&inode->i_sem);
diff -Nurp linux-2.6.5/include/linux/hugetlb.h linux-2.6.5.htlb/include/linux/hugetlb.h
--- linux-2.6.5/include/linux/hugetlb.h	2004-04-13 12:56:29.000000000 -0700
+++ linux-2.6.5.htlb/include/linux/hugetlb.h	2004-04-13 12:02:31.000000000 -0700
@@ -14,10 +14,12 @@ static inline int is_vm_hugetlb_page(str

 int hugetlb_sysctl_handler(struct ctl_table *, int, struct file *, void *, size_t *);
 int copy_hugetlb_page_range(struct mm_struct *, struct mm_struct *, struct vm_area_struct *);
-int follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *, struct page **, struct vm_area_struct **, unsigned long *, int
*, int);
 void zap_hugepage_range(struct vm_area_struct *, unsigned long, unsigned long);
 void unmap_hugepage_range(struct vm_area_struct *, unsigned long, unsigned long);
-int hugetlb_prefault(struct address_space *, struct vm_area_struct *);
+pte_t *huge_pte_alloc(struct mm_struct *, unsigned long);
+void set_huge_pte(struct mm_struct *, struct vm_area_struct *, struct page *, pte_t *, int);
+int handle_hugetlb_mm_fault(struct mm_struct *, struct vm_area_struct *,
+			    unsigned long, int);
 void huge_page_release(struct page *);
 int hugetlb_report_meminfo(char *);
 int is_hugepage_mem_enough(size_t);
@@ -66,10 +68,9 @@ static inline unsigned long hugetlb_tota
 	return 0;
 }

-#define follow_hugetlb_page(m,v,p,vs,a,b,i)	({ BUG(); 0; })
 #define follow_huge_addr(mm, vma, addr, write)	0
 #define copy_hugetlb_page_range(src, dst, vma)	({ BUG(); 0; })
-#define hugetlb_prefault(mapping, vma)		({ BUG(); 0; })
+#define handle_hugetlb_mm_fault(mm, vma, addr, write)	BUG()
 #define zap_hugepage_range(vma, start, len)	BUG()
 #define unmap_hugepage_range(vma, start, end)	BUG()
 #define huge_page_release(page)			BUG()
diff -Nurp linux-2.6.5/mm/hugetlb.c linux-2.6.5.htlb/mm/hugetlb.c
--- linux-2.6.5/mm/hugetlb.c	2004-04-13 12:56:13.000000000 -0700
+++ linux-2.6.5.htlb/mm/hugetlb.c	2004-04-13 12:18:29.000000000 -0700
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/hugetlb.h>
+#include <linux/pagemap.h>
 #include <linux/sysctl.h>

 const unsigned long hugetlb_zero = 0, hugetlb_infinity = ~0UL;
@@ -217,11 +218,58 @@ unsigned long hugetlb_total_pages(void)
 }
 EXPORT_SYMBOL(hugetlb_total_pages);

+int handle_hugetlb_mm_fault(struct mm_struct *mm, struct vm_area_struct * vma,
+	unsigned long addr, int write_access)
+{
+	pte_t *pte;
+	struct page *page;
+	struct address_space *mapping;
+	int idx, ret = VM_FAULT_MINOR;
+
+	spin_lock(&mm->page_table_lock);
+	pte = huge_pte_alloc(mm, addr & HPAGE_MASK);
+	if (!pte) {
+		ret = VM_FAULT_OOM;
+		goto out;
+	}
+	if (!pte_none(*pte))
+		goto out;
+	spin_unlock(&mm->page_table_lock);
+
+	mapping = vma->vm_file->f_dentry->d_inode->i_mapping;
+	idx = ((addr - vma->vm_start) >> HPAGE_SHIFT)
+		+ (vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT));
+retry:
+	page = find_get_page(mapping, idx);
+	if (!page) {
+		page = alloc_huge_page();
+		if (!page)
+			goto retry;
+		ret = add_to_page_cache(page, mapping, idx, GFP_ATOMIC);
+		if (!ret) {
+			unlock_page(page);
+		} else {
+			free_huge_page(page);
+			if (ret == -EEXIST)
+				goto retry;
+			else
+				return VM_FAULT_OOM;
+		}
+	}
+
+	spin_lock(&mm->page_table_lock);
+	if (pte_none(*pte))
+		set_huge_pte(mm, vma, page, pte, vma->vm_flags & VM_WRITE);
+	else
+		page_cache_release(page);
+out:
+	spin_unlock(&mm->page_table_lock);
+	return VM_FAULT_MINOR;
+}
+
 /*
- * We cannot handle pagefaults against hugetlb pages at all.  They cause
- * handle_mm_fault() to try to instantiate regular-sized pages in the
- * hugegpage VMA.  do_page_fault() is supposed to trap this, so BUG is we get
- * this far.
+ * We should not get here because handle_mm_fault() is supposed to trap
+ * hugetlb page fault.  BUG if we get here.
  */
 static struct page *hugetlb_nopage(struct vm_area_struct *vma,
 				unsigned long address, int *unused)
diff -Nurp linux-2.6.5/mm/memory.c linux-2.6.5.htlb/mm/memory.c
--- linux-2.6.5/mm/memory.c	2004-04-13 12:56:13.000000000 -0700
+++ linux-2.6.5.htlb/mm/memory.c	2004-04-13 12:02:31.000000000 -0700
@@ -769,11 +769,6 @@ int get_user_pages(struct task_struct *t
 		if ((pages && vm_io) || !(flags & vma->vm_flags))
 			return i ? : -EFAULT;

-		if (is_vm_hugetlb_page(vma)) {
-			i = follow_hugetlb_page(mm, vma, pages, vmas,
-						&start, &len, i);
-			continue;
-		}
 		spin_lock(&mm->page_table_lock);
 		do {
 			struct page *map = NULL;
@@ -1697,7 +1692,7 @@ int handle_mm_fault(struct mm_struct *mm
 	inc_page_state(pgfault);

 	if (is_vm_hugetlb_page(vma))
-		return VM_FAULT_SIGBUS;	/* mapping truncation does this. */
+		return handle_hugetlb_mm_fault(mm, vma, address, write_access);

 	/*
 	 * We need the page table lock to synchronize with kswapd


