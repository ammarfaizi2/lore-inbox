Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317482AbSGTUR2>; Sat, 20 Jul 2002 16:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317483AbSGTUR2>; Sat, 20 Jul 2002 16:17:28 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:36596 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317482AbSGTUR1>; Sat, 20 Jul 2002 16:17:27 -0400
Subject: [PATCH] low-latency zap_page_range
From: Robert Love <rml@tech9.net>
To: akpm@zip.com.au, torvalds@transmeta.com
Cc: riel@conectiva.com.br, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 20 Jul 2002 13:20:26 -0700
Message-Id: <1027196427.1116.753.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The lock hold time in zap_page_range is horrid.  This patch breaks the
work up into chunks and relinquishes the lock after each iteration. 
This drastically lowers latency by creating a preemption point, as well
as lowering lock contention. 

The chunk size is ZAP_BLOCK_SIZE and currently 256*PAGE_SIZE. 

This lowers the maximum latency in zap_page_range from 10~20ms (on a
dual Athlon - one of the worst latencies recorded) to unmeasurable. 

I made a couple other cleanups and optimizations: 

	- remove unneeded dir variable and call to pgd_offset - nothing 
	  uses this anymore as the code was pushed to unmap_page_range 

	- removed duplicated start variable - it is the same as address 

	- BUG -> BUG_ON in unmap_page_range 

	- remove redundant BUG from zap_page_range - the same check is 
	  done in unmap_page_range 

	- better comments 

Patch is against 2.5.27, please apply. 

	Robert Love

diff -urN linux-2.5.27/mm/memory.c linux/mm/memory.c
--- linux-2.5.27/mm/memory.c	Sat Jul 20 12:11:17 2002
+++ linux/mm/memory.c	Sat Jul 20 12:56:18 2002
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
@@ -402,34 +402,42 @@
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
-
-	dir = pgd_offset(mm, address);
+	unsigned long end, block;
 
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
-
-	tlb = tlb_gather_mmu(mm, 0);
-	unmap_page_range(tlb, vma, address, end);
-	tlb_finish_mmu(tlb, start, end);
-	spin_unlock(&mm->page_table_lock);
+	while (size) {
+		block = (size > ZAP_BLOCK_SIZE) ? ZAP_BLOCK_SIZE : size;
+		end = address + block;
+
+		spin_lock(&mm->page_table_lock);
+
+		flush_cache_range(vma, address, end);
+		tlb = tlb_gather_mmu(mm, 0);
+		unmap_page_range(tlb, vma, address, end);
+		tlb_finish_mmu(tlb, address, end);
+
+		spin_unlock(&mm->page_table_lock);
+
+		address += block;
+		size -= block;
+	}
 }
 
 /*

