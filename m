Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbVCVMRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVCVMRg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 07:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbVCVMRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 07:17:33 -0500
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:12381 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261151AbVCVMR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 07:17:26 -0500
Message-ID: <42400CD1.10101@yahoo.com.au>
Date: Tue, 22 Mar 2005 23:17:21 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Hugh Dickins <hugh@veritas.com>, davem@davemloft.net, tony.luck@intel.com,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] freepgt: free_pgtables use vma list
References: <Pine.LNX.4.61.0503212048040.1970@goblin.wat.veritas.com> <20050322034053.311b10e6.akpm@osdl.org>
In-Reply-To: <20050322034053.311b10e6.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------080307000902020709060504"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080307000902020709060504
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> With these six patches the ppc64 is hitting the BUG in exit_mmap():
> 
>         BUG_ON(mm->nr_ptes);    /* This is just debugging */
> 
> fairly early in boot.
> 

No doubt Hugh will have this fixed before long... but if you
have time to spare, you may just try hitting it on the head
and making it a bit dumber. It might help show where the problem
is.

- don't span multiple vmas
- don't be so smart about avoiding unfreeable regions

I dunno. Maybe it won't help at all. Maybe it will make things
worse :P



--------------080307000902020709060504
Content-Type: text/plain;
 name="ptclr-nosmart.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ptclr-nosmart.patch"

Index: linux-2.6/mm/memory.c
===================================================================
--- linux-2.6.orig/mm/memory.c	2005-03-22 23:04:34.000000000 +1100
+++ linux-2.6/mm/memory.c	2005-03-22 23:11:31.000000000 +1100
@@ -110,13 +110,18 @@ void pmd_clear_bad(pmd_t *pmd)
  * Note: this doesn't free the actual pages themselves. That
  * has been handled earlier when unmapping all the memory regions.
  */
-static void free_pte_range(struct mmu_gather *tlb, pmd_t *pmd)
+static void free_pte_range(struct mmu_gather *tlb, pmd_t *pmd,
+				unsigned long addr, unsigned long end,
+				unsigned long floor, unsigned long ceiling)
 {
-	struct page *page = pmd_page(*pmd);
-	pmd_clear(pmd);
-	pte_free_tlb(tlb, page);
-	dec_page_state(nr_page_table_pages);
-	tlb->mm->nr_ptes--;
+	if (((addr & PMD_MASK) >= floor)
+			&& (end - 1 <= (ceiling & PMD_MASK) - 1)) {
+		struct page *page = pmd_page(*pmd);
+		pmd_clear(pmd);
+		pte_free_tlb(tlb, page);
+		dec_page_state(nr_page_table_pages);
+		tlb->mm->nr_ptes--;
+	}
 }
 
 static inline void free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
@@ -133,7 +138,7 @@ static inline void free_pmd_range(struct
 		next = pmd_addr_end(addr, end);
 		if (pmd_none_or_clear_bad(pmd))
 			continue;
-		free_pte_range(tlb, pmd);
+		free_pte_range(tlb, pmd, addr, end, floor, ceiling);
 	} while (pmd++, addr = next, addr != end);
 
 	start &= PUD_MASK;
@@ -190,18 +195,6 @@ void free_pgd_range(struct mmu_gather **
 	unsigned long next;
 	unsigned long start;
 
-	addr &= PMD_MASK;
-	if (addr < floor) {
-		addr += PMD_SIZE;
-		if (!addr)
-			return;
-	}
-	ceiling &= PMD_MASK;
-	if (end - 1 > ceiling - 1)
-		end -= PMD_SIZE;
-	if (addr > end - 1)
-		return;
-
 	start = addr;
 	pgd = pgd_offset((*tlb)->mm, addr);
 	do {
@@ -226,14 +219,6 @@ void free_pgtables(struct mmu_gather **t
 			hugetlb_free_pgd_range(tlb, addr, vma->vm_end,
 				floor, next? next->vm_start: ceiling);
 		} else {
-			/*
-			 * Optimization: gather nearby vmas into one call down
-			 */
-			while (next && next->vm_start <= vma->vm_end + PMD_SIZE
-			&& !is_hugepage_only_range(next->vm_start, HPAGE_SIZE)){
-				vma = next;
-				next = vma->vm_next;
-			}
 			free_pgd_range(tlb, addr, vma->vm_end,
 				floor, next? next->vm_start: ceiling);
 		}

--------------080307000902020709060504--

