Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbVJRVPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbVJRVPV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 17:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbVJRVPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 17:15:21 -0400
Received: from fmr21.intel.com ([143.183.121.13]:32191 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751224AbVJRVPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 17:15:20 -0400
Date: Tue, 18 Oct 2005 14:15:12 -0700
From: "Seth, Rohit" <rohit.seth@intel.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH]: Handling spurious page fault for hugetlb region for 2.6.14-rc4-git5
Message-ID: <20051018141512.A26194@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

[PATCH]: Handle spurious page fault for hugetlb region

The hugetlb pages are currently pre-faulted.  At the time of mmap of
hugepages, we populate the new PTEs.  It is possible that HW has already cached
some of the unused PTEs internally.  These stale entries never get a chance to
be purged in existing control flow.

This patch extends the check in page fault code for hugepages.  Check if
a faulted address falls with in size for the hugetlb file backing it.  We
return VM_FAULT_MINOR for these cases (assuming that the arch specific
page-faulting code purges the stale entry for the archs that need it).

Thanks,
-rohit

Signed-off-by: Rohit Seth <rohit.seth@intel.com>


--- linux-2.6.14-rc4-git5-x86/include/linux/hugetlb.h	2005-10-18 13:14:24.879947360 -0700
+++ b/include/linux/hugetlb.h	2005-10-18 13:13:55.711381656 -0700
@@ -155,11 +155,24 @@
 {
 	file->f_op = &hugetlbfs_file_operations;
 }
+
+static inline int valid_hugetlb_file_off(struct vm_area_struct *vma, 
+					  unsigned long address) 
+{
+	struct inode *inode = vma->vm_file->f_dentry->d_inode;
+	loff_t file_off = address - vma->vm_start;
+	
+	file_off += (vma->vm_pgoff << PAGE_SHIFT);
+	
+	return (file_off < inode->i_size);
+}
+
 #else /* !CONFIG_HUGETLBFS */
 
 #define is_file_hugepages(file)		0
 #define set_file_hugepages(file)	BUG()
 #define hugetlb_zero_setup(size)	ERR_PTR(-ENOSYS)
+#define valid_hugetlb_file_off(vma, address) 	0
 
 #endif /* !CONFIG_HUGETLBFS */
 
--- linux-2.6.14-rc4-git5-x86/mm/memory.c	2005-10-18 12:24:14.153647328 -0700
+++ b/mm/memory.c	2005-10-18 10:39:41.980162632 -0700
@@ -2045,8 +2045,18 @@
 
 	inc_page_state(pgfault);
 
-	if (is_vm_hugetlb_page(vma))
-		return VM_FAULT_SIGBUS;	/* mapping truncation does this. */
+	if (unlikely(is_vm_hugetlb_page(vma))) {
+		if (valid_hugetlb_file_off(vma, address))
+			/* We get here only if there was a stale(zero) TLB entry 
+			 * (because of  HW prefetching). 
+			 * Low-level arch code (if needed) should have already
+			 * purged the stale entry as part of this fault handling.  
+			 * Here we just return.
+			 */
+			return VM_FAULT_MINOR; 
+		else
+			return VM_FAULT_SIGBUS;	/* mapping truncation does this. */
+	}
 
 	/*
 	 * We need the page table lock to synchronize with kswapd
