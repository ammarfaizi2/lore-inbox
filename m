Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932763AbVLIAQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932763AbVLIAQj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 19:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932765AbVLIAQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 19:16:39 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:7138 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932763AbVLIAQi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 19:16:38 -0500
Subject: Re: 2.6.15-rc4 panic in __nr_to_section() with CONFIG_SPARSEMEM
From: Dave Hansen <haveblue@us.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, Andy Whitcroft <andyw@uk.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>,
       "ADAM G. LITKE [imap]" <agl@us.ibm.com>
In-Reply-To: <20051208234841.GA30254@localhost.localdomain>
References: <1133995060.21841.56.camel@localhost.localdomain>
	 <43976AA4.2060606@uk.ibm.com>
	 <1133997772.21841.62.camel@localhost.localdomain>
	 <1134002888.30387.82.camel@localhost>
	 <1134058055.21841.70.camel@localhost.localdomain>
	 <1134069335.6159.21.camel@localhost>
	 <20051208234841.GA30254@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 08 Dec 2005 16:16:29 -0800
Message-Id: <1134087389.18179.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-09 at 10:48 +1100, David Gibson wrote:
> On Thu, Dec 08, 2005 at 11:15:35AM -0800, Dave Hansen wrote:
> > On Thu, 2005-12-08 at 08:07 -0800, Badari Pulavarty wrote:
> > > No. It doesn't help. It looks like ppc pmd_huge() always returns 0.
> > > Don't know why ? :(
> > 
> > The ppc64 hugetlb pages don't line up on PMD boundaries like they do on
> > i386.  The entries are stored in regular old PTEs.  
> > 
> > I really don't like coding the two different hugetlb cases, but I can't
> > think of a better way to do it.  Anyone care to test on ppc64?
> 
> > -		mss->resident += PAGE_SIZE;
> > +		page_size = PAGE_SIZE;
> > +		if (is_hugepage_only_range(vma->vm_mm, addr, end - addr))
> > +			page_size = HPAGE_SIZE;
> 
> This is an incorrect usage of is_hugepage_only_range().  Although it
> will get the right answer by accident here, that function should
> *only* be used for testing whether a range is suitable for normal
> pages, never for determining if hugepages are actually in use here.
> You have the VMA here, so test its flag instead here.

Sounds good to me.  The flag should be faster to test as well.  Updated
patch attached.  Shall I cook another one up to comment
is_hugepage_only_range() so poor suckers like me don't make the mistake
again?

-- Dave

 proc-dups-dave/fs/proc/task_mmu.c |   53 +++++++++++++++++++++++++++-----------
 2 files changed, 39 insertions(+), 14 deletions(-)

diff -puN fs/proc/task_mmu.c~task_mmu_fix fs/proc/task_mmu.c
--- proc-dups/fs/proc/task_mmu.c~task_mmu_fix	2005-12-07 16:34:38.000000000 -0800
+++ proc-dups-dave/fs/proc/task_mmu.c	2005-12-08 16:13:55.000000000 -0800
@@ -198,6 +198,24 @@ static int show_map(struct seq_file *m, 
 	return show_map_internal(m, v, NULL);
 }
 
+static void smaps_account_for_page(pte_t ptent, struct page *page,
+					unsigned long page_size,
+					struct mem_size_stats *mss)
+{
+	mss->resident += page_size;
+	if (page_count(page) >= 2) {
+		if (pte_dirty(ptent))
+			mss->shared_dirty += page_size;
+		else
+			mss->shared_clean += page_size;
+	} else {
+		if (pte_dirty(ptent))
+			mss->private_dirty += page_size;
+		else
+			mss->private_clean += page_size;
+	}
+}
+
 static void smaps_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 				unsigned long addr, unsigned long end,
 				struct mem_size_stats *mss)
@@ -205,32 +223,38 @@ static void smaps_pte_range(struct vm_ar
 	pte_t *pte, ptent;
 	spinlock_t *ptl;
 	unsigned long pfn;
+	unsigned long page_size;
 	struct page *page;
 
+	if (pmd_huge(*pmd)) {
+		struct page *page;
+
+		page = follow_huge_pmd(vma->vm_mm, addr, pmd, 0);
+		if (!page)
+			return;
+
+		ptent = *(pte_t *)pmd;
+		smaps_account_for_page(ptent, page, HPAGE_SIZE, mss);
+		return;
+	}
 	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
 	do {
 		ptent = *pte;
 		if (!pte_present(ptent))
 			continue;
 
-		mss->resident += PAGE_SIZE;
+		page_size = PAGE_SIZE;
+		if (is_vm_hugetlb_page(vma))
+			page_size = HPAGE_SIZE;
+
+		mss->resident += page_size;
 		pfn = pte_pfn(ptent);
 		if (!pfn_valid(pfn))
 			continue;
 
 		page = pfn_to_page(pfn);
-		if (page_count(page) >= 2) {
-			if (pte_dirty(ptent))
-				mss->shared_dirty += PAGE_SIZE;
-			else
-				mss->shared_clean += PAGE_SIZE;
-		} else {
-			if (pte_dirty(ptent))
-				mss->private_dirty += PAGE_SIZE;
-			else
-				mss->private_clean += PAGE_SIZE;
-		}
-	} while (pte++, addr += PAGE_SIZE, addr != end);
+		smaps_account_for_page(ptent, page, page_size, mss);
+	} while (pte++, addr += page_size, addr != end);
 	pte_unmap_unlock(pte - 1, ptl);
 	cond_resched();
 }
@@ -245,7 +269,8 @@ static inline void smaps_pmd_range(struc
 	pmd = pmd_offset(pud, addr);
 	do {
 		next = pmd_addr_end(addr, end);
-		if (pmd_none_or_clear_bad(pmd))
+
+		if (!pmd_huge(*pmd) && pmd_none_or_clear_bad(pmd))
 			continue;
 		smaps_pte_range(vma, pmd, addr, next, mss);
 	} while (pmd++, addr = next, addr != end);
diff -puN include/linux/hugetlb.h~task_mmu_fix include/linux/hugetlb.h
_


