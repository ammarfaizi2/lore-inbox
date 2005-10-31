Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbVJaJJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbVJaJJM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 04:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbVJaJJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 04:09:11 -0500
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:53921 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932284AbVJaJJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 04:09:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=O5Fsw1LIf7kbtult8A3jEyeCeR/GrA7PNiR3QTgmjYRW/TEPjSKFc/WP91LHPrYsj+3DQmdTeqrGm1LQxo04fVLht7LSWxPuRH8S1Vp1MkNNtP0qnkJGIRPieifQQVMc4K0BN/BppF/k5Qr4cEgopxLjUChRivTahCRNRar/sbE=  ;
Message-ID: <4365DF9A.5040101@yahoo.com.au>
Date: Mon, 31 Oct 2005 20:10:50 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Robin Holt <holt@sgi.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: munmap extremely slow even with untouched mapping.
References: <20051028013738.GA19727@attica.americas.sgi.com> <43620138.6060707@yahoo.com.au> <Pine.LNX.4.61.0510281557440.3229@goblin.wat.veritas.com> <43644C22.8050501@yahoo.com.au> <Pine.LNX.4.61.0510301631360.2848@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0510301631360.2848@goblin.wat.veritas.com>
Content-Type: multipart/mixed;
 boundary="------------070300020007090802080903"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070300020007090802080903
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hugh Dickins wrote:
> On Sun, 30 Oct 2005, Nick Piggin wrote:

>>I wonder if we should go with Robin's fix (+/- my variation)
>>as a temporary measure for 2.6.15?
> 
> 
> You're right, I was too dismissive.  I've now spent a day looking into
> the larger rework, and it's a bigger job than I'd thought - partly the
> architecture variations, partly the fast/slow paths and other "tlb" cruft,
> partly the truncation case's i_mmap_lock (and danger of making no progress
> whenever we drop it).  I'll have to set all that aside for now.
> 

Yep, I took a quick look before adding my bugs to Robin's patch, and
basically came to the same conclusion.

> I've taken another look at the two patches.  The main reason I preferred
> yours was that I misread Robin's!  But yes, yours takes it a bit further,
> and I think that is worthwhile.
> 

Sure - the nice method to solve it reasonably neatly is Robin's of
course. I just preferred to change accounting slightly so we wouldn't,
for example, retry the call stack after each empty pgd.

> But a built and tested version would be better.  Aren't you trying to
> return addr from each level (that's what I liked, and what I'll want to
> do in the end)?  But some levels are returning nothing,

Hmph, seem to have got half a patch there :P

> and unmap_vmas
> does start +=, and the huge case leaves start unchanged, and

Dang, thanks.

> zap_work
> should be a long so it doesn't need casting almost everywhere, and...
> given all that, I bet there's more!
> 

Yep, good idea. New tested patch attached. Robin, if you agree with the
changes I made, would you sign this one and send it on to Linus and/or
Andrew, please?

> As to whether p??_none should count for 1 where !pte_none counts for
> PAGE_SIZE, well, they say a picture is worth a thousand words, and I'm
> sure that's entered your calculation ;-)  I'd probably make the p??_none

That didn't, but it confirms my theory. I was working on the basis
that a *page* is worth a thousand words - but I think we can assume
any picture worth looking at will be given its own page.

I don't know if we should worry about increasing p??_none case - they
are going to be largely operating on contiguous memory, free of atomic
ops. And the cost for pages must also include the TLB and possible
freeing work too.

Trivial to change once the patch is in though.

> count for a little more.  Perhaps we should get everyone involved in a
> great profiling effort across the architectures to determine it.
> Config option.  Sys tunable.  I'll shut up.
> 

I was going to make it a tunable, but then I realised someone already
has - /dev/kmem ;)

-- 
SUSE Labs, Novell Inc.

--------------070300020007090802080903
Content-Type: text/plain;
 name="mm-zap_block-redundant-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-zap_block-redundant-fix.patch"

The address based work estimate for unmapping (for lockbreak) is and
always was horribly inefficient for sparse mappings. The problem is most
simply explained with an example:

If we find a pgd is clear, we still have to call into unmap_page_range
PGDIR_SIZE / ZAP_BLOCK_SIZE times, each time checking the clear pgd, in
order to progress the working address to the next pgd.

The fundamental way to solve the problem is to keep track of the end address
we've processed and pass it back to the higher layers.

From: Robin Holt <holt@sgi.com>

Modification to completely get away from address based work estimate and
instead use an abstract count, with a very small cost for empty entries as
opposed to present pages.

On 2.6.14-git2, ppc64, and CONFIG_PREEMPT=y, mapping and unmapping 1TB of
virtual address space takes 1.69s; with the following patch applied, this
operation can be done 1000 times in less than 0.01s

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/mm/memory.c
===================================================================
--- linux-2.6.orig/mm/memory.c
+++ linux-2.6/mm/memory.c
@@ -549,10 +549,10 @@ int copy_page_range(struct mm_struct *ds
 	return 0;
 }
 
-static void zap_pte_range(struct mmu_gather *tlb,
+static unsigned long zap_pte_range(struct mmu_gather *tlb,
 				struct vm_area_struct *vma, pmd_t *pmd,
 				unsigned long addr, unsigned long end,
-				struct zap_details *details)
+				long *zap_work, struct zap_details *details)
 {
 	struct mm_struct *mm = tlb->mm;
 	pte_t *pte;
@@ -563,10 +563,15 @@ static void zap_pte_range(struct mmu_gat
 	pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
 	do {
 		pte_t ptent = *pte;
-		if (pte_none(ptent))
+		if (pte_none(ptent)) {
+			(*zap_work)--;
 			continue;
+		}
 		if (pte_present(ptent)) {
 			struct page *page = NULL;
+
+			(*zap_work) -= PAGE_SIZE;
+
 			if (!(vma->vm_flags & VM_RESERVED)) {
 				unsigned long pfn = pte_pfn(ptent);
 				if (unlikely(!pfn_valid(pfn)))
@@ -624,16 +629,18 @@ static void zap_pte_range(struct mmu_gat
 		if (!pte_file(ptent))
 			free_swap_and_cache(pte_to_swp_entry(ptent));
 		pte_clear_full(mm, addr, pte, tlb->fullmm);
-	} while (pte++, addr += PAGE_SIZE, addr != end);
+	} while (pte++, addr += PAGE_SIZE, (addr != end && *zap_work > 0));
 
 	add_mm_rss(mm, file_rss, anon_rss);
 	pte_unmap_unlock(pte - 1, ptl);
+
+	return addr;
 }
 
-static inline void zap_pmd_range(struct mmu_gather *tlb,
+static inline unsigned long zap_pmd_range(struct mmu_gather *tlb,
 				struct vm_area_struct *vma, pud_t *pud,
 				unsigned long addr, unsigned long end,
-				struct zap_details *details)
+				long *zap_work, struct zap_details *details)
 {
 	pmd_t *pmd;
 	unsigned long next;
@@ -641,16 +648,21 @@ static inline void zap_pmd_range(struct 
 	pmd = pmd_offset(pud, addr);
 	do {
 		next = pmd_addr_end(addr, end);
-		if (pmd_none_or_clear_bad(pmd))
+		if (pmd_none_or_clear_bad(pmd)) {
+			(*zap_work)--;
 			continue;
-		zap_pte_range(tlb, vma, pmd, addr, next, details);
-	} while (pmd++, addr = next, addr != end);
+		}
+		next = zap_pte_range(tlb, vma, pmd, addr, next,
+						zap_work, details);
+	} while (pmd++, addr = next, (addr != end && *zap_work > 0));
+
+	return addr;
 }
 
-static inline void zap_pud_range(struct mmu_gather *tlb,
+static inline unsigned long zap_pud_range(struct mmu_gather *tlb,
 				struct vm_area_struct *vma, pgd_t *pgd,
 				unsigned long addr, unsigned long end,
-				struct zap_details *details)
+				long *zap_work, struct zap_details *details)
 {
 	pud_t *pud;
 	unsigned long next;
@@ -658,15 +670,21 @@ static inline void zap_pud_range(struct 
 	pud = pud_offset(pgd, addr);
 	do {
 		next = pud_addr_end(addr, end);
-		if (pud_none_or_clear_bad(pud))
+		if (pud_none_or_clear_bad(pud)) {
+			(*zap_work)--;
 			continue;
-		zap_pmd_range(tlb, vma, pud, addr, next, details);
-	} while (pud++, addr = next, addr != end);
+		}
+		next = zap_pmd_range(tlb, vma, pud, addr, next,
+						zap_work, details);
+	} while (pud++, addr = next, (addr != end && *zap_work > 0));
+
+	return addr;
 }
 
-static void unmap_page_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
+static unsigned long unmap_page_range(struct mmu_gather *tlb,
+				struct vm_area_struct *vma,
 				unsigned long addr, unsigned long end,
-				struct zap_details *details)
+				long *zap_work, struct zap_details *details)
 {
 	pgd_t *pgd;
 	unsigned long next;
@@ -679,11 +697,16 @@ static void unmap_page_range(struct mmu_
 	pgd = pgd_offset(vma->vm_mm, addr);
 	do {
 		next = pgd_addr_end(addr, end);
-		if (pgd_none_or_clear_bad(pgd))
+		if (pgd_none_or_clear_bad(pgd)) {
+			(*zap_work)--;
 			continue;
-		zap_pud_range(tlb, vma, pgd, addr, next, details);
-	} while (pgd++, addr = next, addr != end);
+		}
+		next = zap_pud_range(tlb, vma, pgd, addr, next,
+						zap_work, details);
+	} while (pgd++, addr = next, (addr != end && *zap_work > 0));
 	tlb_end_vma(tlb, vma);
+
+	return addr;
 }
 
 #ifdef CONFIG_PREEMPT
@@ -724,7 +747,7 @@ unsigned long unmap_vmas(struct mmu_gath
 		unsigned long end_addr, unsigned long *nr_accounted,
 		struct zap_details *details)
 {
-	unsigned long zap_bytes = ZAP_BLOCK_SIZE;
+	long zap_work = ZAP_BLOCK_SIZE;
 	unsigned long tlb_start = 0;	/* For tlb_finish_mmu */
 	int tlb_start_valid = 0;
 	unsigned long start = start_addr;
@@ -745,27 +768,25 @@ unsigned long unmap_vmas(struct mmu_gath
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
+				zap_work -= (end - start) /
+						(HPAGE_SIZE / PAGE_SIZE);
+				start = end;
+			} else
+				start = unmap_page_range(*tlbp, vma,
+						start, end, &zap_work, details);
+
+			if (zap_work > 0) {
+				BUG_ON(start != end);
+				break;
 			}
 
-			start += block;
-			zap_bytes -= block;
-			if ((long)zap_bytes > 0)
-				continue;
-
 			tlb_finish_mmu(*tlbp, tlb_start, start);
 
 			if (need_resched() ||
@@ -779,7 +800,7 @@ unsigned long unmap_vmas(struct mmu_gath
 
 			*tlbp = tlb_gather_mmu(vma->vm_mm, fullmm);
 			tlb_start_valid = 0;
-			zap_bytes = ZAP_BLOCK_SIZE;
+			zap_work = ZAP_BLOCK_SIZE;
 		}
 	}
 out:

--------------070300020007090802080903--
Send instant messages to your online friends http://au.messenger.yahoo.com 
