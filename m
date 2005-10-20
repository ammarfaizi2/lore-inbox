Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751768AbVJTGS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768AbVJTGS3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 02:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751769AbVJTGS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 02:18:29 -0400
Received: from gold.veritas.com ([143.127.12.110]:37964 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751768AbVJTGS3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 02:18:29 -0400
Date: Thu, 20 Oct 2005 07:17:36 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Rohit Seth <rohit.seth@intel.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Adam Litke <agl@us.ibm.com>
Subject: Re: [PATCH]: Handling spurious page fault for hugetlb region for
 2.6.14-rc4-git5
In-Reply-To: <1129772207.339.152.camel@akash.sc.intel.com>
Message-ID: <Pine.LNX.4.61.0510200704290.2838@goblin.wat.veritas.com>
References: <20051018141512.A26194@unix-os.sc.intel.com> 
 <20051018143438.66d360c4.akpm@osdl.org>  <1129673824.19875.36.camel@akash.sc.intel.com>
  <20051018172549.7f9f31da.akpm@osdl.org>  <1129692330.24309.44.camel@akash.sc.intel.com>
  <20051018210721.4c80a292.akpm@osdl.org>  <Pine.LNX.4.61.0510191623220.7586@goblin.wat.veritas.com>
  <1129748733.339.90.camel@akash.sc.intel.com> 
 <Pine.LNX.4.61.0510192049030.10794@goblin.wat.veritas.com> 
 <20051019131907.05ea7160.akpm@osdl.org>  <Pine.LNX.4.61.0510192126100.11096@goblin.wat.veritas.com>
  <1129765996.339.138.camel@akash.sc.intel.com> <1129772207.339.152.camel@akash.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 20 Oct 2005 06:18:28.0756 (UTC) FILETIME=[163AAD40:01C5D53E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Oct 2005, Rohit Seth wrote:
> On Wed, 2005-10-19 at 16:53 -0700, Rohit Seth wrote:
> > 
> > And I don't know what the right solution should be for this scenario at
> > this point for 2.6.14....may be to actually look at the HUGEPTE
> > corresponding to the hugetlb faulting address or don't allow mmaps to
> > grow the hugetlb file bigger (except the first mmap).  I understand that
> > both of them don't sound too good...
> 
> I would like to keep this patch.  This at least takes care of bad things
> happening behind application's back by OS/HW.  If the scenario that you
> mentioned happens then the application is knowingly doing unsupported
> things (at this point truncate is a broken operation on hugetlb).  The
> application can be killed in this case.
> 
> ...trying to avoid any heavy changes at this time for 2.6.14

I think your first suggestion, actually looking at the hugepte, is the
right one.  I've dived into Adam's forthcoming hugetlb fault-on-demand
patch and extracted the minimum we need (but thought we might as well
take all the arguments to hugetlb_fault, even those not yet used).
This works fine so far as I can test it now, how about for you?

[Adam, if this goes in, your patch shouldn't need to touch memory.c or
hugetlb.h; and we hadn't noticed, yours was missing the hugetlb_fault
definition for the #else config, giving compile warning - fixed here.]

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 include/linux/hugetlb.h |    3 +++
 mm/hugetlb.c            |   22 ++++++++++++++++++++++
 mm/memory.c             |    2 +-
 3 files changed, 26 insertions(+), 1 deletion(-)

--- 2.6.14-rc4-git7/include/linux/hugetlb.h	2005-10-11 12:07:52.000000000 +0100
+++ linux/include/linux/hugetlb.h	2005-10-20 06:27:51.000000000 +0100
@@ -25,6 +25,8 @@ int is_hugepage_mem_enough(size_t);
 unsigned long hugetlb_total_pages(void);
 struct page *alloc_huge_page(void);
 void free_huge_page(struct page *);
+int hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
+			unsigned long address, int write_access);
 
 extern unsigned long max_huge_pages;
 extern const unsigned long hugetlb_zero, hugetlb_infinity;
@@ -99,6 +101,7 @@ static inline unsigned long hugetlb_tota
 						do { } while (0)
 #define alloc_huge_page()			({ NULL; })
 #define free_huge_page(p)			({ (void)(p); BUG(); })
+#define hugetlb_fault(mm, vma, addr, write)	({ BUG(); 0; })
 
 #ifndef HPAGE_MASK
 #define HPAGE_MASK	0		/* Keep the compiler happy */
--- 2.6.14-rc4-git7/mm/hugetlb.c	2005-10-11 12:07:55.000000000 +0100
+++ linux/mm/hugetlb.c	2005-10-20 06:27:51.000000000 +0100
@@ -393,6 +393,28 @@ out:
 	return ret;
 }
 
+/*
+ * On ia64 at least, it is possible to receive a hugetlb fault from a
+ * stale zero entry left in the TLB from earlier hardware prefetching.
+ * Low-level arch code should already have flushed the stale entry as
+ * part of its fault handling, but we do need to accept this minor fault
+ * and return successfully.  Whereas the "normal" case is that this is
+ * an access to a hugetlb page which has been truncated off since mmap.
+ */
+int hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
+			unsigned long address, int write_access)
+{
+	int ret = VM_FAULT_SIGBUS;
+	pte_t *pte;
+
+	spin_lock(&mm->page_table_lock);
+	pte = huge_pte_offset(mm, address);
+	if (pte && !pte_none(*pte))
+		ret = VM_FAULT_MINOR;
+	spin_unlock(&mm->page_table_lock);
+	return ret;
+}
+
 int follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			struct page **pages, struct vm_area_struct **vmas,
 			unsigned long *position, int *length, int i)
--- 2.6.14-rc4-git7/mm/memory.c	2005-10-11 12:07:55.000000000 +0100
+++ linux/mm/memory.c	2005-10-20 06:27:51.000000000 +0100
@@ -2046,7 +2046,7 @@ int __handle_mm_fault(struct mm_struct *
 	inc_page_state(pgfault);
 
 	if (is_vm_hugetlb_page(vma))
-		return VM_FAULT_SIGBUS;	/* mapping truncation does this. */
+		return hugetlb_fault(mm, vma, address, write_access);
 
 	/*
 	 * We need the page table lock to synchronize with kswapd
