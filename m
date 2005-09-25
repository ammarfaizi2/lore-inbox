Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932238AbVIYQCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbVIYQCX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 12:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbVIYQCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 12:02:23 -0400
Received: from gold.veritas.com ([143.127.12.110]:15532 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932238AbVIYQCX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 12:02:23 -0400
Date: Sun, 25 Sep 2005 17:01:56 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: "David S. Miller" <davem@davemloft.net>,
       Russell King <rmk@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>,
       Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 13/21] mm: tlb_is_full_mm was obscure
In-Reply-To: <Pine.LNX.4.61.0509251644100.3490@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0509251700020.3490@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0509251644100.3490@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 25 Sep 2005 16:02:22.0556 (UTC) FILETIME=[83AC91C0:01C5C1EA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tlb_is_full_mm?  What does that mean?  The TLB is full?  No, it means
that the mm's last user has gone and the whole mm is being torn down.
And it's an inline function because sparc64 uses a different (slightly
better) "tlb_frozen" name for the flag others call "fullmm".

And now the ptep_get_and_clear_full macro used in zap_pte_range refers
directly to tlb->fullmm, which would be wrong for sparc64.  Rather than
correct that, I'd prefer to scrap tlb_is_full_mm altogether, and change
sparc64 to just use the same poor name as everyone else - is that okay?

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 arch/sparc64/mm/tlb.c     |    4 ++--
 include/asm-arm/tlb.h     |    5 -----
 include/asm-arm26/tlb.h   |    7 -------
 include/asm-generic/tlb.h |    6 ------
 include/asm-ia64/tlb.h    |    6 ------
 include/asm-sparc64/tlb.h |   13 ++++---------
 mm/memory.c               |    4 ++--
 7 files changed, 8 insertions(+), 37 deletions(-)

--- mm12/arch/sparc64/mm/tlb.c	2005-06-17 20:48:29.000000000 +0100
+++ mm13/arch/sparc64/mm/tlb.c	2005-09-24 19:29:10.000000000 +0100
@@ -72,7 +72,7 @@ void tlb_batch_add(struct mm_struct *mm,
 
 no_cache_flush:
 
-	if (mp->tlb_frozen)
+	if (mp->fullmm)
 		return;
 
 	nr = mp->tlb_nr;
@@ -97,7 +97,7 @@ void flush_tlb_pgtables(struct mm_struct
 	unsigned long nr = mp->tlb_nr;
 	long s = start, e = end, vpte_base;
 
-	if (mp->tlb_frozen)
+	if (mp->fullmm)
 		return;
 
 	/* If start is greater than end, that is a real problem.  */
--- mm12/include/asm-arm/tlb.h	2005-09-24 19:28:56.000000000 +0100
+++ mm13/include/asm-arm/tlb.h	2005-09-24 19:29:10.000000000 +0100
@@ -68,11 +68,6 @@ tlb_finish_mmu(struct mmu_gather *tlb, u
 	put_cpu_var(mmu_gathers);
 }
 
-static inline unsigned int tlb_is_full_mm(struct mmu_gather *tlb)
-{
-	return tlb->fullmm;
-}
-
 #define tlb_remove_tlb_entry(tlb,ptep,address)	do { } while (0)
 
 /*
--- mm12/include/asm-arm26/tlb.h	2005-09-24 19:28:56.000000000 +0100
+++ mm13/include/asm-arm26/tlb.h	2005-09-24 19:29:10.000000000 +0100
@@ -55,13 +55,6 @@ tlb_finish_mmu(struct mmu_gather *tlb, u
         put_cpu_var(mmu_gathers);
 }
 
-
-static inline unsigned int
-tlb_is_full_mm(struct mmu_gather *tlb)
-{
-     return tlb->fullmm;
-}
-
 #define tlb_remove_tlb_entry(tlb,ptep,address)  do { } while (0)
 //#define tlb_start_vma(tlb,vma)                  do { } while (0)
 //FIXME - ARM32 uses this now that things changed in the kernel. seems like it may be pointless on arm26, however to get things compiling...
--- mm12/include/asm-generic/tlb.h	2005-09-24 19:28:56.000000000 +0100
+++ mm13/include/asm-generic/tlb.h	2005-09-24 19:29:10.000000000 +0100
@@ -103,12 +103,6 @@ tlb_finish_mmu(struct mmu_gather *tlb, u
 	put_cpu_var(mmu_gathers);
 }
 
-static inline unsigned int
-tlb_is_full_mm(struct mmu_gather *tlb)
-{
-	return tlb->fullmm;
-}
-
 /* tlb_remove_page
  *	Must perform the equivalent to __free_pte(pte_get_and_clear(ptep)), while
  *	handling the additional races in SMP caused by other CPUs caching valid
--- mm12/include/asm-ia64/tlb.h	2005-09-24 19:28:56.000000000 +0100
+++ mm13/include/asm-ia64/tlb.h	2005-09-24 19:29:10.000000000 +0100
@@ -178,12 +178,6 @@ tlb_finish_mmu (struct mmu_gather *tlb, 
 	put_cpu_var(mmu_gathers);
 }
 
-static inline unsigned int
-tlb_is_full_mm(struct mmu_gather *tlb)
-{
-     return tlb->fullmm;
-}
-
 /*
  * Logically, this routine frees PAGE.  On MP machines, the actual freeing of the page
  * must be delayed until after the TLB has been flushed (see comments at the beginning of
--- mm12/include/asm-sparc64/tlb.h	2005-09-24 19:28:56.000000000 +0100
+++ mm13/include/asm-sparc64/tlb.h	2005-09-24 19:29:10.000000000 +0100
@@ -25,7 +25,7 @@ struct mmu_gather {
 	struct mm_struct *mm;
 	unsigned int pages_nr;
 	unsigned int need_flush;
-	unsigned int tlb_frozen;
+	unsigned int fullmm;
 	unsigned int tlb_nr;
 	unsigned long freed;
 	unsigned long vaddrs[TLB_BATCH_NR];
@@ -50,7 +50,7 @@ static inline struct mmu_gather *tlb_gat
 
 	mp->mm = mm;
 	mp->pages_nr = num_online_cpus() > 1 ? 0U : ~0U;
-	mp->tlb_frozen = full_mm_flush;
+	mp->fullmm = full_mm_flush;
 	mp->freed = 0;
 
 	return mp;
@@ -88,10 +88,10 @@ static inline void tlb_finish_mmu(struct
 
 	tlb_flush_mmu(mp);
 
-	if (mp->tlb_frozen) {
+	if (mp->fullmm) {
 		if (CTX_VALID(mm->context))
 			do_flush_tlb_mm(mm);
-		mp->tlb_frozen = 0;
+		mp->fullmm = 0;
 	} else
 		flush_tlb_pending();
 
@@ -101,11 +101,6 @@ static inline void tlb_finish_mmu(struct
 	put_cpu_var(mmu_gathers);
 }
 
-static inline unsigned int tlb_is_full_mm(struct mmu_gather *mp)
-{
-	return mp->tlb_frozen;
-}
-
 static inline void tlb_remove_page(struct mmu_gather *mp, struct page *page)
 {
 	mp->need_flush = 1;
--- mm12/mm/memory.c	2005-09-24 19:28:28.000000000 +0100
+++ mm13/mm/memory.c	2005-09-24 19:29:10.000000000 +0100
@@ -249,7 +249,7 @@ void free_pgd_range(struct mmu_gather **
 		free_pud_range(*tlb, pgd, addr, next, floor, ceiling);
 	} while (pgd++, addr = next, addr != end);
 
-	if (!tlb_is_full_mm(*tlb))
+	if (!(*tlb)->fullmm)
 		flush_tlb_pgtables((*tlb)->mm, start, end);
 }
 
@@ -698,7 +698,7 @@ unsigned long unmap_vmas(struct mmu_gath
 	int tlb_start_valid = 0;
 	unsigned long start = start_addr;
 	spinlock_t *i_mmap_lock = details? details->i_mmap_lock: NULL;
-	int fullmm = tlb_is_full_mm(*tlbp);
+	int fullmm = (*tlbp)->fullmm;
 
 	for ( ; vma && vma->vm_start < end_addr; vma = vma->vm_next) {
 		unsigned long end;
