Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132405AbRCaOsz>; Sat, 31 Mar 2001 09:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132409AbRCaOsg>; Sat, 31 Mar 2001 09:48:36 -0500
Received: from bacchus.veritas.com ([204.177.156.37]:39117 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S132405AbRCaOs3>; Sat, 31 Mar 2001 09:48:29 -0500
Date: Sat, 31 Mar 2001 14:56:43 +0100 (BST)
From: Mark Hemment <markhe@veritas.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
   Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kmap performance
Message-ID: <Pine.LNX.4.21.0103311411400.4246-100000@alloc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  Two performance changes against 2.4.3.

  flush_all_zero_pkmaps() is guarding against a race which cannot happen,
and thus hurting performance.

  It uses the atomic fetch-and-clear "ptep_get_and_clear()" operation,
which is much stronger than needed.  No-one has the page mapped, and
cannot get at the page's virtual address without taking the kmap_lock,
which flush_all_zero_pkmaps() holds.  Even with speculative execution,
there are no races which need to be closed via an atomic op.

  On a two-way, Pentium-III system, flush_all_zero_pkmaps() was taking
over 200K CPU cycles (with the flush_tlb_all() only accounting for ~9K of
those cycles).

  This patch replaces ptep_get_and_clear() with a pte_page(), and
pte_clear().  This reduces flush_all_zero_pkmaps() to around 75K cycles.


  The second part of this patch adds a conditional guard to the 
wake_up() call in kunmap_high().

  With most usage patterns, a page will not be simultaneously mapped more
than once, hence the most common case (by far) is for pkmap_count[] to
decrement to 1.  This was causing an unconditional call to wake_up(), when
(again) the common case is to have no tasks in the wait-queue.

  This patches adds a guard to the wake_up() using an inlined
waitqueue_active(), and so avoids unnecessary function calls.
  It also drops the actual wake_up() to be outside of the spinlock.  This
is safe, as any waiters will have placed themselves onto the queue under
the kmap_lock, and kunmap_high() tests the queue under this lock.

Mark



diff -urN -X dontdiff linux-2.4.3/mm/highmem.c markhe-2.4.3/mm/highmem.c
--- linux-2.4.3/mm/highmem.c	Tue Nov 28 20:31:02 2000
+++ markhe-2.4.3/mm/highmem.c	Sat Mar 31 15:03:43 2001
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
@@ -150,13 +162,31 @@
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
+	/*
+	 * Can do wake-up, if needed, race-free outside of
+	 * the spinlock.
+	 */
+	if (need_wakeup)
+		wake_up(&pkmap_map_wait);
 }
 
 /*

