Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317856AbSGVSZZ>; Mon, 22 Jul 2002 14:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317857AbSGVSZZ>; Mon, 22 Jul 2002 14:25:25 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:59900 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317856AbSGVSZX>; Mon, 22 Jul 2002 14:25:23 -0400
Subject: Re: [PATCH] low-latency zap_page_range
From: Robert Love <rml@tech9.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@zip.com.au>, riel@conectiva.com.br,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <Pine.LNX.4.44.0207221103430.2928-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0207221103430.2928-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 22 Jul 2002 11:28:21 -0700
Message-Id: <1027362501.932.56.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-22 at 11:05, Linus Torvalds wrote:

> On 22 Jul 2002, Robert Love wrote:
> >
> > Sure.  What do you think of this?
> 
> How about adding an "cond_resched_lock()" primitive?

And this patch is an updated zap_page_range() now using the new approach
I posted and Linus's suggested cond_resched_lock method (previous
patch).

Personally I still prefer the simpler loop method... note that the
cond_resched_lock() assumes that the lock depth is ALWAYS 1 - e.g., we
explicitly call schedule.  A safer alternative would be break_spin_lock
which will preemptively reschedule automatically, but only if
preempt_count==0 (and only with the preemptible kernel enabled).

This patch also has the other cleanups/optimizations from the original
zap_page_range patch - same patch as before but with the new method. 
Patch is against 2.5 BK.

	Robert Love

diff -urN linux-2.5.27/mm/memory.c linux/mm/memory.c
--- linux-2.5.27/mm/memory.c	Sat Jul 20 12:11:17 2002
+++ linux/mm/memory.c	Mon Jul 22 11:18:10 2002
@@ -390,8 +390,8 @@
 {
 	pgd_t * dir;
 
-	if (address >= end)
-		BUG();
+	BUG_ON(address >= end);
+
 	dir = pgd_offset(vma->vm_mm, address);
 	tlb_start_vma(tlb, vma);
 	do {
@@ -402,33 +402,43 @@
 	tlb_end_vma(tlb, vma);
 }
 
-/*
- * remove user pages in a given range.
+#define ZAP_BLOCK_SIZE	(256 * PAGE_SIZE) /* how big a chunk we loop over */
+
+/**
+ * zap_page_range - remove user pages in a given range
+ * @vma: vm_area_struct holding the applicable pages
+ * @address: starting address of pages to zap
+ * @size: number of bytes to zap
  */
 void zap_page_range(struct vm_area_struct *vma, unsigned long address, unsigned long size)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	mmu_gather_t *tlb;
-	pgd_t * dir;
-	unsigned long start = address, end = address + size;
+	unsigned long end, block;
 
-	dir = pgd_offset(mm, address);
+	spin_lock(&mm->page_table_lock);
 
 	/*
-	 * This is a long-lived spinlock. That's fine.
-	 * There's no contention, because the page table
-	 * lock only protects against kswapd anyway, and
-	 * even if kswapd happened to be looking at this
-	 * process we _want_ it to get stuck.
+	 * This was once a long-held spinlock.  Now we break the
+	 * work up into ZAP_BLOCK_SIZE units and relinquish the
+	 * lock after each interation.  This drastically lowers
+	 * lock contention and allows for a preemption point.
 	 */
-	if (address >= end)
-		BUG();
-	spin_lock(&mm->page_table_lock);
-	flush_cache_range(vma, address, end);
+	while (size) {
+		block = (size > ZAP_BLOCK_SIZE) ? ZAP_BLOCK_SIZE : size;
+		end = address + block;
+
+		flush_cache_range(vma, address, end);
+		tlb = tlb_gather_mmu(mm, 0);
+		unmap_page_range(tlb, vma, address, end);
+		tlb_finish_mmu(tlb, address, end);
+
+		cond_resched_lock(&mm->page_table_lock);
+
+		address += block;
+		size -= block;
+	}
 
-	tlb = tlb_gather_mmu(mm, 0);
-	unmap_page_range(tlb, vma, address, end);
-	tlb_finish_mmu(tlb, start, end);
 	spin_unlock(&mm->page_table_lock);
 }
 

