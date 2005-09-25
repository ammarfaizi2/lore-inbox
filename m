Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbVIYQE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbVIYQE0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 12:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbVIYQE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 12:04:26 -0400
Received: from gold.veritas.com ([143.127.12.110]:28844 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932239AbVIYQEZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 12:04:25 -0400
Date: Sun, 25 Sep 2005 17:03:58 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: "David S. Miller" <davem@davemloft.net>,
       Russell King <rmk@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>,
       Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 14/21] mm: tlb_finish_mmu forget rss
In-Reply-To: <Pine.LNX.4.61.0509251644100.3490@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0509251702010.3490@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0509251644100.3490@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 25 Sep 2005 16:04:25.0297 (UTC) FILETIME=[CCD55C10:01C5C1EA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

zap_pte_range has been counting the pages it frees in tlb->freed, then
tlb_finish_mmu has used that to update the mm's rss.  That got stranger
when I added anon_rss, yet updated it by a different route; and stranger
when rss and anon_rss became mm_counters with special access macros.
And it would no longer be viable if we're relying on page_table_lock to
stabilize the mm_counter, but calling tlb_finish_mmu outside that lock.

Remove the mmu_gather's freed field, let tlb_finish_mmu stick to its own
business, just decrement the rss mm_counter in zap_pte_range (yes, there
was some point to batching the update, and a subsequent patch restores
that).  And forget the anal paranoia of first reading the counter to
avoid going negative - if rss does go negative, just fix that bug.

Remove the mmu_gather's flushes and avoided_flushes from arm and arm26:
no use was being made of them.  But arm26 alone was actually using the
freed, in the way some others use need_flush: give it a need_flush.
arm26 seems to prefer spaces to tabs here: respect that.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 include/asm-arm/tlb.h     |   15 +--------------
 include/asm-arm26/tlb.h   |   35 +++++++++++++----------------------
 include/asm-generic/tlb.h |    9 ---------
 include/asm-ia64/tlb.h    |    9 ---------
 include/asm-sparc64/tlb.h |   14 ++------------
 mm/memory.c               |    2 +-
 6 files changed, 17 insertions(+), 67 deletions(-)

--- mm13/include/asm-arm/tlb.h	2005-09-24 19:29:10.000000000 +0100
+++ mm14/include/asm-arm/tlb.h	2005-09-24 19:29:25.000000000 +0100
@@ -27,11 +27,7 @@
  */
 struct mmu_gather {
 	struct mm_struct	*mm;
-	unsigned int		freed;
 	unsigned int		fullmm;
-
-	unsigned int		flushes;
-	unsigned int		avoided_flushes;
 };
 
 DECLARE_PER_CPU(struct mmu_gather, mmu_gathers);
@@ -42,7 +38,6 @@ tlb_gather_mmu(struct mm_struct *mm, uns
 	struct mmu_gather *tlb = &get_cpu_var(mmu_gathers);
 
 	tlb->mm = mm;
-	tlb->freed = 0;
 	tlb->fullmm = full_mm_flush;
 
 	return tlb;
@@ -51,16 +46,8 @@ tlb_gather_mmu(struct mm_struct *mm, uns
 static inline void
 tlb_finish_mmu(struct mmu_gather *tlb, unsigned long start, unsigned long end)
 {
-	struct mm_struct *mm = tlb->mm;
-	unsigned long freed = tlb->freed;
-	int rss = get_mm_counter(mm, rss);
-
-	if (rss < freed)
-		freed = rss;
-	add_mm_counter(mm, rss, -freed);
-
 	if (tlb->fullmm)
-		flush_tlb_mm(mm);
+		flush_tlb_mm(tlb->mm);
 
 	/* keep the page table cache within bounds */
 	check_pgt_cache();
--- mm13/include/asm-arm26/tlb.h	2005-09-24 19:29:10.000000000 +0100
+++ mm14/include/asm-arm26/tlb.h	2005-09-24 19:29:25.000000000 +0100
@@ -10,11 +10,8 @@
  */
 struct mmu_gather {
         struct mm_struct        *mm;
-        unsigned int            freed;
-	unsigned int            fullmm;
-
-        unsigned int            flushes;
-        unsigned int            avoided_flushes;
+        unsigned int            need_flush;
+        unsigned int            fullmm;
 };
 
 DECLARE_PER_CPU(struct mmu_gather, mmu_gathers);
@@ -25,8 +22,8 @@ tlb_gather_mmu(struct mm_struct *mm, uns
         struct mmu_gather *tlb = &get_cpu_var(mmu_gathers);
 
         tlb->mm = mm;
-        tlb->freed = 0;
-	tlb->fullmm = full_mm_flush;
+        tlb->need_flush = 0;
+        tlb->fullmm = full_mm_flush;
 
         return tlb;
 }
@@ -34,20 +31,8 @@ tlb_gather_mmu(struct mm_struct *mm, uns
 static inline void
 tlb_finish_mmu(struct mmu_gather *tlb, unsigned long start, unsigned long end)
 {
-        struct mm_struct *mm = tlb->mm;
-        unsigned long freed = tlb->freed;
-        int rss = get_mm_counter(mm, rss);
-
-        if (rss < freed)
-                freed = rss;
-        add_mm_counter(mm, rss, -freed);
-
-        if (freed) {
-                flush_tlb_mm(mm);
-                tlb->flushes++;
-        } else {
-                tlb->avoided_flushes++;
-        }
+        if (tlb->need_flush)
+                flush_tlb_mm(tlb->mm);
 
         /* keep the page table cache within bounds */
         check_pgt_cache();
@@ -65,7 +50,13 @@ tlb_finish_mmu(struct mmu_gather *tlb, u
         } while (0)
 #define tlb_end_vma(tlb,vma)                    do { } while (0)
 
-#define tlb_remove_page(tlb,page)       free_page_and_swap_cache(page)
+static inline void
+tlb_remove_page(struct mmu_gather *tlb, struct page *page)
+{
+        tlb->need_flush = 1;
+        free_page_and_swap_cache(page);
+}
+
 #define pte_free_tlb(tlb,ptep)          pte_free(ptep)
 #define pmd_free_tlb(tlb,pmdp)          pmd_free(pmdp)
 
--- mm13/include/asm-generic/tlb.h	2005-09-24 19:29:10.000000000 +0100
+++ mm14/include/asm-generic/tlb.h	2005-09-24 19:29:25.000000000 +0100
@@ -42,7 +42,6 @@ struct mmu_gather {
 	unsigned int		nr;	/* set to ~0U means fast mode */
 	unsigned int		need_flush;/* Really unmapped some ptes? */
 	unsigned int		fullmm; /* non-zero means full mm flush */
-	unsigned long		freed;
 	struct page *		pages[FREE_PTE_NR];
 };
 
@@ -63,7 +62,6 @@ tlb_gather_mmu(struct mm_struct *mm, uns
 	tlb->nr = num_online_cpus() > 1 ? 0U : ~0U;
 
 	tlb->fullmm = full_mm_flush;
-	tlb->freed = 0;
 
 	return tlb;
 }
@@ -88,13 +86,6 @@ tlb_flush_mmu(struct mmu_gather *tlb, un
 static inline void
 tlb_finish_mmu(struct mmu_gather *tlb, unsigned long start, unsigned long end)
 {
-	int freed = tlb->freed;
-	struct mm_struct *mm = tlb->mm;
-	int rss = get_mm_counter(mm, rss);
-
-	if (rss < freed)
-		freed = rss;
-	add_mm_counter(mm, rss, -freed);
 	tlb_flush_mmu(tlb, start, end);
 
 	/* keep the page table cache within bounds */
--- mm13/include/asm-ia64/tlb.h	2005-09-24 19:29:10.000000000 +0100
+++ mm14/include/asm-ia64/tlb.h	2005-09-24 19:29:25.000000000 +0100
@@ -60,7 +60,6 @@ struct mmu_gather {
 	unsigned int		nr;		/* == ~0U => fast mode */
 	unsigned char		fullmm;		/* non-zero means full mm flush */
 	unsigned char		need_flush;	/* really unmapped some PTEs? */
-	unsigned long		freed;		/* number of pages freed */
 	unsigned long		start_addr;
 	unsigned long		end_addr;
 	struct page 		*pages[FREE_PTE_NR];
@@ -147,7 +146,6 @@ tlb_gather_mmu (struct mm_struct *mm, un
 	 */
 	tlb->nr = (num_online_cpus() == 1) ? ~0U : 0;
 	tlb->fullmm = full_mm_flush;
-	tlb->freed = 0;
 	tlb->start_addr = ~0UL;
 	return tlb;
 }
@@ -159,13 +157,6 @@ tlb_gather_mmu (struct mm_struct *mm, un
 static inline void
 tlb_finish_mmu (struct mmu_gather *tlb, unsigned long start, unsigned long end)
 {
-	unsigned long freed = tlb->freed;
-	struct mm_struct *mm = tlb->mm;
-	unsigned long rss = get_mm_counter(mm, rss);
-
-	if (rss < freed)
-		freed = rss;
-	add_mm_counter(mm, rss, -freed);
 	/*
 	 * Note: tlb->nr may be 0 at this point, so we can't rely on tlb->start_addr and
 	 * tlb->end_addr.
--- mm13/include/asm-sparc64/tlb.h	2005-09-24 19:29:10.000000000 +0100
+++ mm14/include/asm-sparc64/tlb.h	2005-09-24 19:29:25.000000000 +0100
@@ -27,7 +27,6 @@ struct mmu_gather {
 	unsigned int need_flush;
 	unsigned int fullmm;
 	unsigned int tlb_nr;
-	unsigned long freed;
 	unsigned long vaddrs[TLB_BATCH_NR];
 	struct page *pages[FREE_PTE_NR];
 };
@@ -51,7 +50,6 @@ static inline struct mmu_gather *tlb_gat
 	mp->mm = mm;
 	mp->pages_nr = num_online_cpus() > 1 ? 0U : ~0U;
 	mp->fullmm = full_mm_flush;
-	mp->freed = 0;
 
 	return mp;
 }
@@ -78,19 +76,11 @@ extern void smp_flush_tlb_mm(struct mm_s
 
 static inline void tlb_finish_mmu(struct mmu_gather *mp, unsigned long start, unsigned long end)
 {
-	unsigned long freed = mp->freed;
-	struct mm_struct *mm = mp->mm;
-	unsigned long rss = get_mm_counter(mm, rss);
-
-	if (rss < freed)
-		freed = rss;
-	add_mm_counter(mm, rss, -freed);
-
 	tlb_flush_mmu(mp);
 
 	if (mp->fullmm) {
-		if (CTX_VALID(mm->context))
-			do_flush_tlb_mm(mm);
+		if (CTX_VALID(mp->mm->context))
+			do_flush_tlb_mm(mp->mm);
 		mp->fullmm = 0;
 	} else
 		flush_tlb_pending();
--- mm13/mm/memory.c	2005-09-24 19:29:10.000000000 +0100
+++ mm14/mm/memory.c	2005-09-24 19:29:25.000000000 +0100
@@ -582,7 +582,7 @@ static void zap_pte_range(struct mmu_gat
 				if (pte_young(ptent))
 					mark_page_accessed(page);
 			}
-			tlb->freed++;
+			dec_mm_counter(tlb->mm, rss);
 			page_remove_rmap(page);
 			tlb_remove_page(tlb, page);
 			continue;
