Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137195AbREKRrZ>; Fri, 11 May 2001 13:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137197AbREKRrQ>; Fri, 11 May 2001 13:47:16 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:56075 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S137195AbREKRrC>; Fri, 11 May 2001 13:47:02 -0400
Date: Fri, 11 May 2001 13:08:42 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Rik van Riel <riel@conectiva.com.br>,
        "Stephen C. Tweedie" <sct@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: [PATCH] VM fixes against 2.4.4-ac6
Message-ID: <Pine.LNX.4.21.0105111222330.23350-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

The following patch addresses two issues:


- Buffer cache pages in the inactive lists are not getting their age
increased if they get touched by getblk (which will set the referenced bit
on the page).  page_launder() simply cleans the referenced bit on such
pages and moves them to the active list. To resume: buffercache pages
suffer more pressure from VM than pagecache pages. That is horrible for
performance.


- When there is no memory available on the system for normal allocations
(GFP_KERNEL), the tasks may loop in try_to_free_pages() (which is here
called by __alloc_pages()) without blocking:

	- GFP_BUFFER allocations will _never_ block on IO inside
	try_to_free_pages(). They will keep looping inside __alloc_pages() 
	until they get a free page. 
	
	- __GFP_IO|__GFP_WAIT allocations may not find any way to block on
	IO inside try_to_free_pages() in case we already have other tasks
	inside there (kswapd will be there in such condition, for sure).

To address this issues, I've changed the __alloc_pages() loop to act as
following: 

for normal allocations we sleep on the kswapd wait queue _only_ if not
able to make any progress with try_to_free_pages.

for GFP_BUFFER allocations we fail in case we're not able to make progress
ourselves (try_to_free_pages() returns zero in that case).
create_buffers() is able to deal with that nicely. (it sleeps until there
are "enough" free buffer_head's available)

Comments (especially about the second issue) are welcome.

And here is the patch: 


diff -Nur --exclude-from=exclude linux.orig/include/linux/swap.h linux/include/linux/swap.h
--- linux.orig/include/linux/swap.h	Fri May 11 11:17:25 2001
+++ linux/include/linux/swap.h	Fri May 11 11:21:26 2001
@@ -125,7 +125,7 @@
 extern int page_launder(int, int);
 extern int free_shortage(void);
 extern int inactive_shortage(void);
-extern void wakeup_kswapd(void);
+extern void wakeup_kswapd(int);
 extern int try_to_free_pages(unsigned int gfp_mask);
 
 /* linux/mm/page_io.c */
diff -Nur --exclude-from=exclude linux.orig/mm/page_alloc.c linux/mm/page_alloc.c
--- linux.orig/mm/page_alloc.c	Fri May 11 11:17:19 2001
+++ linux/mm/page_alloc.c	Fri May 11 11:20:31 2001
@@ -364,7 +364,7 @@
 	 * - if we don't have __GFP_IO set, kswapd may be
 	 *   able to free some memory we can't free ourselves
 	 */
-	wakeup_kswapd();
+	wakeup_kswapd(0);
 	if (gfp_mask & __GFP_WAIT) {
 		__set_current_state(TASK_RUNNING);
 		current->policy |= SCHED_YIELD;
@@ -444,9 +444,21 @@
 		 * 	  the inactive clean list. (done by page_launder)
 		 */
 		if (gfp_mask & __GFP_WAIT) {
-			memory_pressure++;
-			try_to_free_pages(gfp_mask);
-			goto try_again;
+			/*
+			 * In case we fail doing any progress freeing pages, 
+			 * wait for kswapd if possible. 
+			 */
+			if (try_to_free_pages(gfp_mask))
+				goto try_again;
+			else if (gfp_mask & __GFP_IO) {
+				wakeup_kswapd(1);
+				memory_pressure++;
+				goto try_again;
+			} else 
+			/*
+			 * This is a GFP_BUFFER allocation. 
+			 */
+				return NULL;
 		}
 	}
 
diff -Nur --exclude-from=exclude linux.orig/mm/vmscan.c linux/mm/vmscan.c
--- linux.orig/mm/vmscan.c	Fri May 11 11:17:19 2001
+++ linux/mm/vmscan.c	Fri May 11 13:21:06 2001
@@ -350,7 +350,7 @@
 		}
 
 		/* Page is or was in use?  Move it to the active list. */
-		if (PageTestandClearReferenced(page) || page->age > 0 ||
+		if (PageReferenced(page) || page->age > 0 ||
 				(!page->buffers && page_count(page) > 1)) {
 			del_page_from_inactive_clean_list(page);
 			add_page_to_active_list(page);
@@ -461,7 +461,7 @@
 		}
 
 		/* Page is or was in use?  Move it to the active list. */
-		if (PageTestandClearReferenced(page) || page->age > 0 ||
+		if (PageReferenced(page) || page->age > 0 ||
 				(!page->buffers && page_count(page) > 1) ||
 				page_ramdisk(page)) {
 			del_page_from_inactive_dirty_list(page);
@@ -1003,6 +1003,7 @@
 			recalculate_vm_stats();
 		}
 
+		wake_up_all(&kswapd_done);
 		run_task_queue(&tq_disk);
 
 		/* 
@@ -1033,10 +1034,33 @@
 	}
 }
 
-void wakeup_kswapd(void)
+void wakeup_kswapd(int block)
 {
-	if (current != kswapd_task)
-		wake_up_process(kswapd_task);
+	DECLARE_WAITQUEUE(wait, current);
+
+	if (current == kswapd_task)
+		return;
+
+	if (!block) {
+		if (waitqueue_active(&kswapd_wait))
+			wake_up(&kswapd_wait);
+		return;
+	}
+
+	/*
+	 * Kswapd could wake us up before we get a chance
+	 * to sleep, so we have to be very careful here to
+	 * prevent SMP races...
+	 */
+	__set_current_state(TASK_UNINTERRUPTIBLE);
+	add_wait_queue(&kswapd_done, &wait);
+
+	if (waitqueue_active(&kswapd_wait))
+		wake_up(&kswapd_wait);
+	schedule();
+
+	remove_wait_queue(&kswapd_done, &wait);
+	__set_current_state(TASK_RUNNING);
 }
 
 /*

