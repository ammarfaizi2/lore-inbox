Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271368AbRHPOm3>; Thu, 16 Aug 2001 10:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271370AbRHPOmU>; Thu, 16 Aug 2001 10:42:20 -0400
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:52380 "EHLO
	alloc.wat.veritas.com") by vger.kernel.org with ESMTP
	id <S271368AbRHPOmK>; Thu, 16 Aug 2001 10:42:10 -0400
Date: Thu, 16 Aug 2001 15:45:37 +0100 (BST)
From: Mark Hemment <markhe@veritas.com>
X-X-Sender: <markhe@alloc.wat.veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm/highmem.c
Message-ID: <Pine.LNX.4.33.0108161530290.3340-100000@alloc.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

mm/highmem.c code tweaks against 2.4.9-pre4;

    o In flush_all_zero_pkmaps(), the atomic fetch-and-clear pte op;
      ptep_get_and_clear(), is overkill - the holding of the
      kmap_lock is sufficient.  Use a lighter pte_clear().

    o In kunmap_high(), the common case is for the count to be 1 which
      causes a call to wake_up().  It is possible to be lighter, as
      the kmap_lock is already held and additions to the wait-queue occur
      under this lock.  Simply test for an "active" wait-queue under
      the kmap_lock, and call wake_up() after dropping the lock.

    o As I've previously pointed out, copy_from_high_bh() cannot
      be called from an interrupt context, so doesn't need to mask
      interrupts.

Thanks,
Mark


diff -ur -X dontdiff linux-2.4.9-pre4/mm/highmem.c high-2.4.9-pre4/mm/highmem.c
--- linux-2.4.9-pre4/mm/highmem.c	Tue Aug  7 08:18:00 2001
+++ high-2.4.9-pre4/mm/highmem.c	Thu Aug 16 16:21:55 2001
@@ -46,7 +46,7 @@

 	for (i = 0; i < LAST_PKMAP; i++) {
 		struct page *page;
-		pte_t pte;
+
 		/*
 		 * zero means we don't have anything to do,
 		 * >1 means that it is still in use. Only
@@ -56,10 +56,21 @@
 		if (pkmap_count[i] != 1)
 			continue;
 		pkmap_count[i] = 0;
-		pte = ptep_get_and_clear(pkmap_page_table+i);
-		if (pte_none(pte))
+
+		/* sanity check */
+		if (pte_none(pkmap_page_table[i]))
 			BUG();
-		page = pte_page(pte);
+
+		/*
+		 * Don't need an atomic fetch-and-clear op here;
+		 * no-one has the page mapped, and cannot get at
+		 * its virtual address (and hence PTE) without first
+		 * getting the kmap_lock (which is held here).
+		 * So no dangers, even with speculative execution.
+		 */
+		page = pte_page(pkmap_page_table[i]);
+		pte_clear(&pkmap_page_table[i]);
+
 		page->virtual = NULL;
 	}
 	flush_tlb_all();
@@ -139,6 +150,7 @@
 {
 	unsigned long vaddr;
 	unsigned long nr;
+	int need_wakeup;

 	spin_lock(&kmap_lock);
 	vaddr = (unsigned long) page->virtual;
@@ -150,13 +162,28 @@
 	 * A count must never go down to zero
 	 * without a TLB flush!
 	 */
+	need_wakeup = 0;
 	switch (--pkmap_count[nr]) {
 	case 0:
 		BUG();
 	case 1:
-		wake_up(&pkmap_map_wait);
+		/*
+		 * Avoid an unnecessary wake_up() function call.
+		 * The common case is pkmap_count[] == 1, but
+		 * no waiters.
+		 * The tasks queued in the wait-queue are guarded
+		 * by both the lock in the wait-queue-head and by
+		 * the kmap_lock.  As the kmap_lock is held here,
+		 * no need for the wait-queue-head's lock.  Simply
+		 * test if the queue is empty.
+		 */
+		need_wakeup = waitqueue_active(&pkmap_map_wait);
 	}
 	spin_unlock(&kmap_lock);
+
+	/* do wake-up, if needed, race-free outside of the spin lock */
+	if (need_wakeup)
+		wake_up(&pkmap_map_wait);
 }

 #define POOL_SIZE 32
@@ -182,20 +209,12 @@
 {
 	struct page *p_from;
 	char *vfrom;
-	unsigned long flags;

 	p_from = from->b_page;

-	/*
-	 * Since this can be executed from IRQ context, reentrance
-	 * on the same CPU must be avoided:
-	 */
-	__save_flags(flags);
-	__cli();
 	vfrom = kmap_atomic(p_from, KM_BOUNCE_WRITE);
 	memcpy(to->b_data, vfrom + bh_offset(from), to->b_size);
 	kunmap_atomic(vfrom, KM_BOUNCE_WRITE);
-	__restore_flags(flags);
 }

 static inline void copy_to_high_bh_irq (struct buffer_head *to,

