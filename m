Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129538AbQL1UyI>; Thu, 28 Dec 2000 15:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129913AbQL1Ux7>; Thu, 28 Dec 2000 15:53:59 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:20733 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129538AbQL1Uxu>; Thu, 28 Dec 2000 15:53:50 -0500
Date: Thu, 28 Dec 2000 18:22:56 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: linux-mm@kvack.org
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Stephen C. Tweedie" <sct@redhat.com>
Subject: [PATCH] ulimit RSS enforcement for 2.4.0-test13-pre4
Message-ID: <Pine.LNX.4.21.0012281804430.1403-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Alan, Stephen,

the patch below implements trivial RSS ulimit enforcement
for the 2.4 kernel.

The hard limit (rlim_max) is enforced as a true hard limit,
both at page fault time and again from kswapd. The soft
limit is "enforced" by simply scanning and swapping the
process more agressively from kswapd ...

This behaviour is "comperable" to disk quotas and allows
the sysadmin to set the limits such that the user can have
the memory if it's available but that the processes will
be swapped out first if the memory is needed.

Due to the fact that swapout IO is moved from try_to_swap_out
to page_launder, the enforcement of even the hard limit doesn't
give *ANY* disk IO at all ... the "extra" pages will just sit
in the inactive_dirty list doing nothing; this makes RSS ulimit
enforcement possible without the performance problems we would
have had some time ago.

Since this patch is both trivial and has a very often requested
feature, would you consider adding this to the next pre-patch ?

regards,

Rik
--
Hollywood goes for world dumbination,
	Trailer at 11.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/


--- linux-2.4.0-test13-pre4/mm/filemap.c.orig	Wed Dec 27 16:48:23 2000
+++ linux-2.4.0-test13-pre4/mm/filemap.c	Thu Dec 28 17:12:42 2000
@@ -1900,7 +1900,7 @@
 
 	/* Make sure this doesn't exceed the process's max rss. */
 	error = -EIO;
-	rlim_rss = current->rlim ?  current->rlim[RLIMIT_RSS].rlim_cur :
+	rlim_rss = current->rlim ?  (current->rlim[RLIMIT_RSS].rlim_cur >> PAGE_SHIFT) :
 				LONG_MAX; /* default: see resource.h */
 	if ((vma->vm_mm->rss + (end - start)) > rlim_rss)
 		return error;
--- linux-2.4.0-test13-pre4/mm/memory.c.orig	Wed Dec 27 16:48:23 2000
+++ linux-2.4.0-test13-pre4/mm/memory.c	Thu Dec 28 17:12:19 2000
@@ -1198,6 +1198,12 @@
 	pgd = pgd_offset(mm, address);
 	pmd = pmd_alloc(pgd, address);
 
+	if (mm->rss >= (current->rlim[RLIMIT_RSS].rlim_max >> PAGE_SHIFT)) {
+		lock_kernel();
+		enforce_rss_limit(mm, GFP_HIGHUSER);
+		unlock_kernel();
+	}
+
 	if (pmd) {
 		pte_t * pte = pte_alloc(pmd, address);
 		if (pte)
--- linux-2.4.0-test13-pre4/mm/vmscan.c.orig	Wed Dec 27 16:48:24 2000
+++ linux-2.4.0-test13-pre4/mm/vmscan.c	Thu Dec 28 18:01:24 2000
@@ -50,7 +50,8 @@
 	if ((!VALID_PAGE(page)) || PageReserved(page))
 		goto out_failed;
 
-	if (mm->swap_cnt)
+	/* RSS trimming doesn't change the process' chances wrt. normal swap */
+	if (mm->swap_cnt && ! (gfp_mask & __GFP_RSS_LIMIT))
 		mm->swap_cnt--;
 
 	onlist = PageActive(page);
@@ -59,7 +60,13 @@
 		age_page_up(page);
 		goto out_failed;
 	}
-	if (!onlist)
+	/*
+	 * SUBTLE: if the page is on the active list and we're not doing
+	 * RSS ulimit trimming, then we let refill_inactive_scan() take
+	 * care of the down aging. Always aging down here would severely
+	 * disadvantage shared mappings (of eg libc.so).
+	 */
+	if (!onlist || (gfp_mask & __GFP_RSS_LIMIT))
 		/* The page is still mapped, so it can't be freeable... */
 		age_page_down_ageonly(page);
 
@@ -135,10 +142,13 @@
 	/*
 	 * Don't do any of the expensive stuff if
 	 * we're not really interested in this zone.
+	 * Note that RSS limit enforcement should succeed
+	 * regardless.
 	 */
 	if (page->zone->free_pages + page->zone->inactive_clean_pages
 					+ page->zone->inactive_dirty_pages
-		      	> page->zone->pages_high + inactive_target)
+		      	> page->zone->pages_high + inactive_target &&
+			!(gfp_mask & __GFP_RSS_LIMIT))
 		goto out_unlock_restore;
 
 	/*
@@ -348,6 +358,58 @@
 }
 
 /*
+ * This function is used to enforce RSS ulimits for a process. When a
+ * process gets an RSS larger than p->rlim[RLIMIT_RSS].rlim_max, this
+ * function will get called.
+ *
+ * The function is pretty similar to swap_out_mm, except for the fact
+ * that it scans the whole process regardless of return value and it
+ * keeps the swapout statistics intact to not disturb normal swapout.
+ *
+ * XXX: the caller must hold the kernel lock; this function cannot loop
+ *      because mlock()ed memory could be bigger than the RSS limit.
+ */
+void enforce_rss_limit(struct mm_struct * mm, int gfp_mask)
+{
+	unsigned long address, old_swap_address;
+	struct vm_area_struct* vma;
+
+	/*
+	 * Go through process' page directory.
+	 */
+	old_swap_address = mm->swap_address;
+	address = mm->swap_address = 0;
+
+	/* Don't decrement mm->swap_cnt in try_to_swap_out */
+	gfp_mask |= __GFP_RSS_LIMIT;
+	if (!mm->swap_cnt)
+		mm->swap_cnt = 1;
+
+	/*
+	 * Find the proper vm-area after freezing the vma chain 
+	 * and ptes.
+	 */
+	spin_lock(&mm->page_table_lock);
+	vma = find_vma(mm, address);
+	if (vma) {
+		if (address < vma->vm_start)
+			address = vma->vm_start;
+
+		for (;;) {
+			swap_out_vma(mm, vma, address, gfp_mask);
+			vma = vma->vm_next;
+			if (!vma)
+				break;
+			address = vma->vm_start;
+		}
+	}
+	/* Reset swap_address, RSS enforcement shouldn't disturb normal swap */
+	mm->swap_address = old_swap_address;
+
+	spin_unlock(&mm->page_table_lock);
+}
+
+/*
  * Select the task with maximal swap_cnt and try to swap out a page.
  * N.B. This function returns only 0 or 1.  Return values != 1 from
  * the lower level routines result in continued processing.
@@ -395,14 +457,15 @@
 				continue;
 	 		if (mm->rss <= 0)
 				continue;
-			/* Skip tasks which haven't slept long enough yet when idle-swapping. */
-			if (idle_time && !assign && (!(p->state & TASK_INTERRUPTIBLE) ||
-					time_after(p->sleep_time + idle_time * HZ, jiffies)))
-				continue;
 			found_task++;
+			/* If the process' RSS is too big, make it smaller ;) */
+			if (mm->rss > (p->rlim[RLIMIT_RSS].rlim_max >> PAGE_SHIFT))
+				enforce_rss_limit(mm, gfp_mask);
 			/* Refresh swap_cnt? */
 			if (assign == 1) {
 				mm->swap_cnt = (mm->rss >> SWAP_SHIFT);
+				if (mm->rss > (p->rlim[RLIMIT_RSS].rlim_cur >> PAGE_SHIFT))
+					mm->swap_cnt = mm->rss;
 				if (mm->swap_cnt < SWAP_MIN)
 					mm->swap_cnt = SWAP_MIN;
 			}
@@ -896,7 +959,7 @@
  * really care about latency. In that case we don't try
  * to free too many pages.
  */
-static int refill_inactive(unsigned int gfp_mask, int user)
+static int refill_inactive(int gfp_mask, int user)
 {
 	int priority, count, start_count, made_progress;
 	unsigned long idle_time;
@@ -980,7 +1043,7 @@
 	return (count < start_count);
 }
 
-static int do_try_to_free_pages(unsigned int gfp_mask, int user)
+static int do_try_to_free_pages(int gfp_mask, int user)
 {
 	int ret = 0;
 
@@ -1155,7 +1218,7 @@
  * memory but are unable to sleep on kswapd because
  * they might be holding some IO locks ...
  */
-int try_to_free_pages(unsigned int gfp_mask)
+int try_to_free_pages(int gfp_mask)
 {
 	int ret = 1;
 
--- linux-2.4.0-test13-pre4/include/linux/mm.h.orig	Thu Dec 28 16:50:12 2000
+++ linux-2.4.0-test13-pre4/include/linux/mm.h	Thu Dec 28 16:50:32 2000
@@ -463,6 +463,7 @@
 #else
 #define __GFP_HIGHMEM	0x0 /* noop */
 #endif
+#define __GFP_RSS_LIMIT 0x20
 
 
 #define GFP_BUFFER	(__GFP_HIGH | __GFP_WAIT)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
