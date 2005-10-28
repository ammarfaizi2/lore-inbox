Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964963AbVJ1KoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964963AbVJ1KoX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 06:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965029AbVJ1KoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 06:44:23 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:40790 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S964963AbVJ1KoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 06:44:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=OlA0ZCkty8XePd3g01P83EQzFprlNo6hdatDLqFVzyKzFRrzdQZUmiOmtIIFNXx+0SxY+/WfIE1svJ3LHJZrP7VWSOOieMfXAXJirnWwFP4G26/h5Cyh08OWtO5QhQEQmFQHfYtDfc8FZ5bWhL8HN3BQDEnR3rDVdmBw9hUN8ZU=  ;
Message-ID: <43620138.6060707@yahoo.com.au>
Date: Fri, 28 Oct 2005 20:45:12 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Robin Holt <holt@sgi.com>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: munmap extremely slow even with untouched mapping.
References: <20051028013738.GA19727@attica.americas.sgi.com>
In-Reply-To: <20051028013738.GA19727@attica.americas.sgi.com>
Content-Type: multipart/mixed;
 boundary="------------020706010701010408040706"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020706010701010408040706
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Robin Holt wrote:
> This is going out without any testing.  I got it to compile but never
> even booted the kernel.
> 
> I noticed that on ia64, the following simple program would take 24
> seconds to complete.  Profiling revealed I was spending all that time
> in unmap_vmas.  Looking over the function, I noticed that I would only
> attempt 8 pages at a time (CONFIG_PREMPT).  I then thought through this
> some more.  My particular application had one large mapping which was
> never touched after being mmaped.
> 
> Without this patch, we would iterate numerous times (256) to get past
> a region of memory that had an empty pmd, 524,288 times to get past an
> empty pud, and 1,073,741,824 to get past an empty pgd.  I had a 4-level
> page table directory patch applied at the time.
> 

Ouch. I wonder why nobody's noticed this before. It really is
horribly inefficient on sparse mappings, as you've noticed :(

I guess I prefer the following (compiled, untested) slight
variant of your patch. Measuring work in terms of address range
is fairly vague.... however, it may be the case that some
architectures take a long time to flush a large range of TLBs?

I don't see how the patch can be made too much cleaner... I guess
the rescheduling could be pushed down, like the copy_ case,
however that isn't particularly brilliant either. What's more, it
would probably get uglier due to the mmu_gather tricks...

Nick

-- 
SUSE Labs, Novell Inc.


--------------020706010701010408040706
Content-Type: text/plain;
 name="mm-zap_block-redundant-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-zap_block-redundant-fix.patch"

Index: linux-2.6/mm/memory.c
===================================================================
--- linux-2.6.orig/mm/memory.c
+++ linux-2.6/mm/memory.c
@@ -525,20 +525,25 @@ int copy_page_range(struct mm_struct *ds
 	return 0;
 }
 
-static void zap_pte_range(struct mmu_gather *tlb, pmd_t *pmd,
-				unsigned long addr, unsigned long end,
-				struct zap_details *details)
+static unsigned long zap_pte_range(struct mmu_gather *tlb, pmd_t *pmd,
+			unsigned long addr, unsigned long end,
+			unsigned long *zap_work, struct zap_details *details)
 {
 	pte_t *pte;
 
 	pte = pte_offset_map(pmd, addr);
 	do {
 		pte_t ptent = *pte;
-		if (pte_none(ptent))
+		if (pte_none(ptent)) {
+			(*zap_work)--;
 			continue;
+		}
 		if (pte_present(ptent)) {
 			struct page *page = NULL;
 			unsigned long pfn = pte_pfn(ptent);
+
+			(*zap_work) -= PAGE_SIZE;
+
 			if (pfn_valid(pfn)) {
 				page = pfn_to_page(pfn);
 				if (PageReserved(page))
@@ -592,13 +597,15 @@ static void zap_pte_range(struct mmu_gat
 		if (!pte_file(ptent))
 			free_swap_and_cache(pte_to_swp_entry(ptent));
 		pte_clear_full(tlb->mm, addr, pte, tlb->fullmm);
-	} while (pte++, addr += PAGE_SIZE, addr != end);
+	} while (pte++, addr += PAGE_SIZE, (addr != end && (long)*zap_work >0));
 	pte_unmap(pte - 1);
+
+	return addr;
 }
 
-static inline void zap_pmd_range(struct mmu_gather *tlb, pud_t *pud,
-				unsigned long addr, unsigned long end,
-				struct zap_details *details)
+static inline unsigned long zap_pmd_range(struct mmu_gather *tlb, pud_t *pud,
+			unsigned long addr, unsigned long end,
+			unsigned long *zap_work, struct zap_details *details)
 {
 	pmd_t *pmd;
 	unsigned long next;
@@ -606,15 +613,19 @@ static inline void zap_pmd_range(struct 
 	pmd = pmd_offset(pud, addr);
 	do {
 		next = pmd_addr_end(addr, end);
-		if (pmd_none_or_clear_bad(pmd))
+		if (pmd_none_or_clear_bad(pmd)) {
+			(*zap_work)--;
 			continue;
-		zap_pte_range(tlb, pmd, addr, next, details);
-	} while (pmd++, addr = next, addr != end);
+		}
+		next = zap_pte_range(tlb, pmd, addr, next, zap_work, details);
+	} while (pmd++, addr = next, (addr != end && (long)*zap_work > 0));
+
+	return addr;
 }
 
-static inline void zap_pud_range(struct mmu_gather *tlb, pgd_t *pgd,
-				unsigned long addr, unsigned long end,
-				struct zap_details *details)
+static inline unsigned long zap_pud_range(struct mmu_gather *tlb, pgd_t *pgd,
+			unsigned long addr, unsigned long end,
+			unsigned long *zap_work, struct zap_details *details)
 {
 	pud_t *pud;
 	unsigned long next;
@@ -622,14 +633,17 @@ static inline void zap_pud_range(struct 
 	pud = pud_offset(pgd, addr);
 	do {
 		next = pud_addr_end(addr, end);
-		if (pud_none_or_clear_bad(pud))
+		if (pud_none_or_clear_bad(pud)) {
+			(*zap_work)--;
 			continue;
-		zap_pmd_range(tlb, pud, addr, next, details);
-	} while (pud++, addr = next, addr != end);
+		}
+		next = zap_pmd_range(tlb, pud, addr, next, zap_work, details);
+	} while (pud++, addr = next, (addr != end && (long)*zap_work > 0));
 }
 
-static void unmap_page_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
-				unsigned long addr, unsigned long end,
+static unsigned long unmap_page_range(struct mmu_gather *tlb,
+			struct vm_area_struct *vma, unsigned long addr,
+			unsigned long end, unsigned long *zap_work,
 				struct zap_details *details)
 {
 	pgd_t *pgd;
@@ -643,10 +657,12 @@ static void unmap_page_range(struct mmu_
 	pgd = pgd_offset(vma->vm_mm, addr);
 	do {
 		next = pgd_addr_end(addr, end);
-		if (pgd_none_or_clear_bad(pgd))
+		if (pgd_none_or_clear_bad(pgd)) {
+			(*zap_work)--;
 			continue;
-		zap_pud_range(tlb, pgd, addr, next, details);
-	} while (pgd++, addr = next, addr != end);
+		}
+		next = zap_pud_range(tlb, pgd, addr, next, zap_work, details);
+	} while (pgd++, addr = next, (addr != end && (long)*zap_work > 0));
 	tlb_end_vma(tlb, vma);
 }
 
@@ -689,7 +705,7 @@ unsigned long unmap_vmas(struct mmu_gath
 		unsigned long end_addr, unsigned long *nr_accounted,
 		struct zap_details *details)
 {
-	unsigned long zap_bytes = ZAP_BLOCK_SIZE;
+	unsigned long zap_work = ZAP_BLOCK_SIZE;
 	unsigned long tlb_start = 0;	/* For tlb_finish_mmu */
 	int tlb_start_valid = 0;
 	unsigned long start = start_addr;
@@ -710,25 +726,20 @@ unsigned long unmap_vmas(struct mmu_gath
 			*nr_accounted += (end - start) >> PAGE_SHIFT;
 
 		while (start != end) {
-			unsigned long block;
-
 			if (!tlb_start_valid) {
 				tlb_start = start;
 				tlb_start_valid = 1;
 			}
 
-			if (is_vm_hugetlb_page(vma)) {
-				block = end - start;
+			if (unlikely(is_vm_hugetlb_page(vma))) {
 				unmap_hugepage_range(vma, start, end);
-			} else {
-				block = min(zap_bytes, end - start);
-				unmap_page_range(*tlbp, vma, start,
-						start + block, details);
-			}
+				zap_work -= (end - start) /
+						(HPAGE_SIZE / PAGE_SIZE);
+			} else
+				start += unmap_page_range(*tlbp, vma,
+						start, end, &zap_work, details);
 
-			start += block;
-			zap_bytes -= block;
-			if ((long)zap_bytes > 0)
+			if ((long)zap_work > 0)
 				continue;
 
 			tlb_finish_mmu(*tlbp, tlb_start, start);
@@ -748,7 +759,7 @@ unsigned long unmap_vmas(struct mmu_gath
 
 			*tlbp = tlb_gather_mmu(mm, fullmm);
 			tlb_start_valid = 0;
-			zap_bytes = ZAP_BLOCK_SIZE;
+			zap_work = ZAP_BLOCK_SIZE;
 		}
 	}
 out:

--------------020706010701010408040706--
Send instant messages to your online friends http://au.messenger.yahoo.com 
