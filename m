Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132042AbQKSAek>; Sat, 18 Nov 2000 19:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132064AbQKSAea>; Sat, 18 Nov 2000 19:34:30 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:37878 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S132042AbQKSAeY>; Sat, 18 Nov 2000 19:34:24 -0500
Date: Sat, 18 Nov 2000 22:04:02 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: [PATCH] blindingly stupid 2.2 VM bug
Message-ID: <Pine.LNX.4.21.0011182201250.11745-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

here's a fix for a blindingly stupid bug that's been in
2.2 for ages (and which I've warned you about a few times
in the last 6 months, and which I've even sent some patches
for).

This patch should make 2.2 VM a bit more stable and should
also fix the complaints from people who's system gets
flooded by "VM: do_try_to_free_pages failed for process XXX"

It's against something suspiciously like 2.2.18-pre15, so
chances are it'll apply cleanly.

regards,

Rik
--
Hollywood goes for world dumbination,
	Trailer at 11.

http://www.conectiva.com/		http://www.surriel.com/



--- ../rpm/BUILD/linux/mm/vmscan.c	Sat Nov 18 21:56:50 2000
+++ linux/mm/vmscan.c	Sun Nov  5 19:36:23 2000
@@ -17,7 +17,6 @@
 #include <linux/smp_lock.h>
 #include <linux/pagemap.h>
 #include <linux/init.h>
-#include <linux/bigmem.h>
 
 #include <asm/pgtable.h>
 
@@ -61,8 +60,7 @@
 
 	if (PageReserved(page_map)
 	    || PageLocked(page_map)
-	    || ((gfp_mask & __GFP_DMA) && !PageDMA(page_map))
-	    || (!(gfp_mask & __GFP_BIGMEM) && PageBIGMEM(page_map)))
+	    || ((gfp_mask & __GFP_DMA) && !PageDMA(page_map)))
 		return 0;
 
 	/*
@@ -156,9 +154,6 @@
 	if (!entry)
 		return 0; /* No swap space left */
 		
-	if (!(page_map = prepare_bigmem_swapout(page_map)))
-		goto out_swap_free;
-
 	vma->vm_mm->rss--;
 	tsk->nswap++;
 	set_pte(page_table, __pte(entry));
@@ -170,14 +165,10 @@
 	set_bit(PG_locked, &page_map->flags);
 
 	/* OK, do a physical asynchronous write to swap.  */
-	rw_swap_page(WRITE, entry, (char *) page_address(page_map), 0);
+	rw_swap_page(WRITE, entry, (char *) page, 0);
 
 	__free_page(page_map);
 	return 1;
-
- out_swap_free:
-	swap_free(entry);
-	return 0;
 }
 
 /*
@@ -400,13 +391,14 @@
 {
 	int priority;
 	int count = SWAP_CLUSTER_MAX;
+	int loopcount = count;
 
 	lock_kernel();
 
 	/* Always trim SLAB caches when memory gets low. */
 	kmem_cache_reap(gfp_mask);
 
-	priority = 5;
+	priority = 6;
 	do {
 		while (shrink_mmap(priority, gfp_mask)) {
 			if (!--count)
@@ -428,12 +420,21 @@
 		}
 
 		shrink_dcache_memory(priority, gfp_mask);
-	} while (--priority > 0);
+
+		/* Only lower priority if we didn't make progress. */
+		if (count == loopcount) {
+			priority--;
+		}
+		loopcount = count;
+	} while (priority > 0);
 done:
 	unlock_kernel();
 
-	/* Return success if we freed a page. */
-	return priority > 0;
+	/* Return success if we have enough free memory or we freed a page. */
+	if (nr_free_pages > freepages.low)
+		return 1;
+
+	return count < SWAP_CLUSTER_MAX;
 }
 
 /*
@@ -505,22 +506,23 @@
 		 * the processes needing more memory will wake us
 		 * up on a more timely basis.
 		 */
-		interruptible_sleep_on(&kswapd_wait);
+		interruptible_sleep_on_timeout(&kswapd_wait, HZ);
 
-		/*
-		 * In 2.2.x-bigmem kswapd is critical to provide GFP_ATOMIC
-		 * allocations (not GFP_BIGMEM ones).
-		 */
-		while (nr_free_pages - nr_free_bigpages < freepages.high)
-		{
-			if (try_to_free_pages(GFP_KSWAPD))
+		if (nr_free_pages < freepages.low) {
+			while (nr_free_pages < freepages.high)
 			{
-				if (tsk->need_resched)
-					schedule();
-				continue;
+				if (try_to_free_pages(GFP_KSWAPD))
+				{
+					if (tsk->need_resched)
+						schedule();
+					continue;
+				}
+				tsk->state = TASK_INTERRUPTIBLE;
+				schedule_timeout(10*HZ);
 			}
-			tsk->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(10*HZ);
+		} else if (nr_free_pages < freepages.high) {
+			/* Background scanning. */
+			try_to_free_pages(GFP_KSWAPD);
 		}
 	}
 }

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
