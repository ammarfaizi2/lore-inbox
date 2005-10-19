Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbVJSEIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbVJSEIH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 00:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbVJSEIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 00:08:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20445 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750727AbVJSEIF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 00:08:05 -0400
Date: Tue, 18 Oct 2005 21:07:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Rohit Seth <rohit.seth@intel.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Adam Litke <agl@us.ibm.com>
Subject: Re: [PATCH]: Handling spurious page fault for hugetlb region for
 2.6.14-rc4-git5
Message-Id: <20051018210721.4c80a292.akpm@osdl.org>
In-Reply-To: <1129692330.24309.44.camel@akash.sc.intel.com>
References: <20051018141512.A26194@unix-os.sc.intel.com>
	<20051018143438.66d360c4.akpm@osdl.org>
	<1129673824.19875.36.camel@akash.sc.intel.com>
	<20051018172549.7f9f31da.akpm@osdl.org>
	<1129692330.24309.44.camel@akash.sc.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rohit Seth <rohit.seth@intel.com> wrote:
>
> The prefetching problem is handled OK for regular pages because we can
>  handle page faults corresponding to those pages.  That is currently not
>  true for hugepages.  Currently the kernel assumes that PAGE_FAULT
>  happening against a hugetlb page is caused by truncate and returns
>  SIGBUS.

Doh.  No fault handler.  The penny finally drops.

Adam, I think this patch is temporary?


From: "Seth, Rohit" <rohit.seth@intel.com>

We prefault hugepages at mmap() time, but hardware TLB prefetching may mean
that the TLB has NULL pagetable entries in the places where the pagetable
in fact has the desired virtual->physical translation.

For regular pages this problem is resolved via the resulting pagefault, in
the pagefault handler.  But hugepages don't support pagefaults - they're
supposed to be prefaulted.

So we need minimal pagefault handling for these stale hugepage TLB entries.

An alternative is to invalidate the relevant TLB entries at hugepage
mmap()-time, but this is apparently too expensive.

Note: Adam Litke <agl@us.ibm.com>'s demand-paging-for-hugepages patches are
now in -mm.  If/when these are merged up, this fix should probably be
reverted.

Signed-off-by: Rohit Seth <rohit.seth@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 include/linux/hugetlb.h |   13 +++++++++++++
 mm/memory.c             |   14 ++++++++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)

diff -puN include/linux/hugetlb.h~handling-spurious-page-fault-for-hugetlb-region include/linux/hugetlb.h
--- devel/include/linux/hugetlb.h~handling-spurious-page-fault-for-hugetlb-region	2005-10-18 21:04:34.000000000 -0700
+++ devel-akpm/include/linux/hugetlb.h	2005-10-18 21:04:34.000000000 -0700
@@ -155,11 +155,24 @@ static inline void set_file_hugepages(st
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
 
diff -puN mm/memory.c~handling-spurious-page-fault-for-hugetlb-region mm/memory.c
--- devel/mm/memory.c~handling-spurious-page-fault-for-hugetlb-region	2005-10-18 21:04:34.000000000 -0700
+++ devel-akpm/mm/memory.c	2005-10-18 21:04:34.000000000 -0700
@@ -2045,8 +2045,18 @@ int __handle_mm_fault(struct mm_struct *
 
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
_

