Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131566AbQL1XUS>; Thu, 28 Dec 2000 18:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131547AbQL1XUJ>; Thu, 28 Dec 2000 18:20:09 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:52462 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129828AbQL1XTy>; Thu, 28 Dec 2000 18:19:54 -0500
Date: Thu, 28 Dec 2000 20:48:53 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] VM fixes + RSS limits 2.4.0-test13-pre5
Message-ID: <Pine.LNX.4.21.0012282037580.1403-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I know this is probably not the birthday present you've been
hoping for, but here is a patch agains 2.4.0-test13-pre5 which
does the following - trivial - things:

1. trivially implement RSS ulimit support, with
   p->rlim[RLIMIT_RSS].rlim_max treated as a hard limit
   and .rlim_cur treated as a soft limit

2. fix the return value from try_to_swap_out() to return
   success whenever we make the RSS of a process smaller

3. clean up refill_inactive() ... try_to_swap_out() returns
   the expected result now, so things should be balanced again

4. only call deactivate_page() from generic_file_write() if we
   write "beyond the end of" the page, so partially written
   pages stay active and will remain in memory longer (8% more
   performance for dbench, as tested by Daniel Phillips)

5. (minor) s/unsigned int gfp_mask/int gfp_mask/ in vmscan.c
   ... we had both types used, which is rather inconsistent

Please consider including this patch in the next 2.4 pre-patch,
IMHO all of these things are fairly trivial and it seems to run
very nicely on my test box ;)

regards,

Rik
--
Hollywood goes for world dumbination,
	Trailer at 11.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/


--- linux-2.4.0-test13-pre5/mm/filemap.c.orig	Thu Dec 28 19:11:39 2000
+++ linux-2.4.0-test13-pre5/mm/filemap.c	Thu Dec 28 19:28:06 2000
@@ -1912,7 +1912,7 @@
 
 	/* Make sure this doesn't exceed the process's max rss. */
 	error = -EIO;
-	rlim_rss = current->rlim ?  current->rlim[RLIMIT_RSS].rlim_cur :
+	rlim_rss = current->rlim ?  (current->rlim[RLIMIT_RSS].rlim_cur >> PAGE_SHIFT) :
 				LONG_MAX; /* default: see resource.h */
 	if ((vma->vm_mm->rss + (end - start)) > rlim_rss)
 		return error;
@@ -2438,7 +2438,7 @@
 	}
 
 	while (count) {
-		unsigned long bytes, index, offset;
+		unsigned long bytes, index, offset, partial = 0;
 		char *kaddr;
 
 		/*
@@ -2448,8 +2448,10 @@
 		offset = (pos & (PAGE_CACHE_SIZE -1)); /* Within page */
 		index = pos >> PAGE_CACHE_SHIFT;
 		bytes = PAGE_CACHE_SIZE - offset;
-		if (bytes > count)
+		if (bytes > count) {
 			bytes = count;
+			partial = 1;
+		}
 
 		/*
 		 * Bring in the user page that we will copy from _first_.
@@ -2491,9 +2493,17 @@
 			buf += status;
 		}
 unlock:
-		/* Mark it unlocked again and drop the page.. */
+		/*
+		 * Mark it unlocked again and release the page.
+		 * In order to prevent large (fast) file writes
+		 * from causing too much memory pressure we move
+		 * completely written pages to the inactive list.
+		 * We do, however, try to keep the pages that may
+		 * still be written to (ie. partially written pages).
+		 */
 		UnlockPage(page);
-		deactivate_page(page);
+		if (!partial)
+			deactivate_page(page);
 		page_cache_release(page);
 
 		if (status < 0)
--- linux-2.4.0-test13-pre5/mm/memory.c.orig	Thu Dec 28 19:11:39 2000
+++ linux-2.4.0-test13-pre5/mm/memory.c	Thu Dec 28 19:12:04 2000
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
--- linux-2.4.0-test13-pre5/mm/vmscan.c.orig	Thu Dec 28 19:11:40 2000
+++ linux-2.4.0-test13-pre5/mm/vmscan.c	Thu Dec 28 20:30:10 2000
@@ -49,7 +49,8 @@
 	if ((!VALID_PAGE(page)) || PageReserved(page))
 		goto out_failed;
 
-	if (mm->swap_cnt)
+	/* RSS trimming doesn't change the process' chances wrt. normal swap */
+	if (mm->swap_cnt && !(gfp_mask & __GFP_RSS_LIMIT))
 		mm->swap_cnt--;
 
 	onlist = PageActive(page);
@@ -58,7 +59,13 @@
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
 
@@ -85,8 +92,8 @@
 	 * we can just drop our reference to it without doing
 	 * any IO - it's already up-to-date on disk.
 	 *
-	 * Return 0, as we didn't actually free any real
-	 * memory, and we should just continue our scan.
+	 * Return success, we successfully stole a page from
+	 * this process.
 	 */
 	if (PageSwapCache(page)) {
 		entry.val = page->index;
@@ -101,8 +108,8 @@
 		flush_tlb_page(vma, address);
 		deactivate_page(page);
 		page_cache_release(page);
-out_failed:
-		return 0;
+
+		return 1;
 	}
 
 	/*
@@ -152,6 +159,7 @@
 out_unlock_restore:
 	set_pte(page_table, pte);
 	UnlockPage(page);
+out_failed:
 	return 0;
 }
 
@@ -192,7 +200,7 @@
 		int result;
 		mm->swap_address = address + PAGE_SIZE;
 		result = try_to_swap_out(mm, vma, address, pte, gfp_mask);
-		if (result)
+		if (result && !(gfp_mask & __GFP_RSS_LIMIT))
 			return result;
 		if (!mm->swap_cnt)
 			return 0;
@@ -303,6 +311,63 @@
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
+			/*
+			 * Subtle: swap_out_pmd makes sure we scan the
+			 * whole VMA, that's a lot more efficient than
+			 * a while() loop here would ever be.
+			 */
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
@@ -310,7 +375,7 @@
 #define SWAP_SHIFT 5
 #define SWAP_MIN 8
 
-static int swap_out(unsigned int priority, int gfp_mask, unsigned long idle_time)
+static int swap_out(unsigned int priority, int gfp_mask)
 {
 	struct task_struct * p;
 	int counter;
@@ -350,14 +415,15 @@
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
@@ -497,7 +563,7 @@
 #define MAX_LAUNDER 		(4 * (1 << page_cluster))
 int page_launder(int gfp_mask, int sync)
 {
-	int launder_loop, maxscan, cleaned_pages, maxlaunder;
+	int launder_loop, maxscan, cleaned_pages, maxlaunder, target;
 	int can_get_io_locks;
 	struct list_head * page_lru;
 	struct page * page;
@@ -508,6 +574,8 @@
 	 */
 	can_get_io_locks = gfp_mask & __GFP_IO;
 
+	target = free_shortage();
+
 	launder_loop = 0;
 	maxlaunder = 0;
 	cleaned_pages = 0;
@@ -538,6 +606,12 @@
 		}
 
 		/*
+		 * If we have enough free pages, stop doing (expensive) IO.
+		 */
+		if (cleaned_pages > target && !free_shortage())
+			break;
+
+		/*
 		 * The page is locked. IO in progress?
 		 * Move it to the back of the list.
 		 */
@@ -846,10 +920,9 @@
  * really care about latency. In that case we don't try
  * to free too many pages.
  */
-static int refill_inactive(unsigned int gfp_mask, int user)
+static int refill_inactive(int gfp_mask, int user)
 {
 	int priority, count, start_count, made_progress;
-	unsigned long idle_time;
 
 	count = inactive_shortage() + free_shortage();
 	if (user)
@@ -859,17 +932,6 @@
 	/* Always trim SLAB caches when memory gets low. */
 	kmem_cache_reap(gfp_mask);
 
-	/*
-	 * Calculate the minimum time (in seconds) a process must
-	 * have slept before we consider it for idle swapping.
-	 * This must be the number of seconds it takes to go through
-	 * all of the cache. Doing this idle swapping makes the VM
-	 * smoother once we start hitting swap.
-	 */
-	idle_time = atomic_read(&page_cache_size);
-	idle_time += atomic_read(&buffermem_pages);
-	idle_time /= (inactive_target + 1);
-
 	priority = 6;
 	do {
 		made_progress = 0;
@@ -879,8 +941,11 @@
 			schedule();
 		}
 
-		while (refill_inactive_scan(priority, 1) ||
-				swap_out(priority, gfp_mask, idle_time)) {
+		/*
+		 * Reclaim old pages which aren't mapped into any
+		 * process.
+		 */
+		while (refill_inactive_scan(priority, 1)) {
 			made_progress = 1;
 			if (--count <= 0)
 				goto done;
@@ -895,9 +960,9 @@
 		shrink_icache_memory(priority, gfp_mask);
 
 		/*
-		 * Then, try to page stuff out..
+		 * Steal pages from processes.
 		 */
-		while (swap_out(priority, gfp_mask, 0)) {
+		while (swap_out(priority, gfp_mask)) {
 			made_progress = 1;
 			if (--count <= 0)
 				goto done;
@@ -930,7 +995,7 @@
 	return (count < start_count);
 }
 
-static int do_try_to_free_pages(unsigned int gfp_mask, int user)
+static int do_try_to_free_pages(int gfp_mask, int user)
 {
 	int ret = 0;
 
@@ -1105,7 +1170,7 @@
  * memory but are unable to sleep on kswapd because
  * they might be holding some IO locks ...
  */
-int try_to_free_pages(unsigned int gfp_mask)
+int try_to_free_pages(int gfp_mask)
 {
 	int ret = 1;
 
--- linux-2.4.0-test13-pre5/include/linux/mm.h.orig	Thu Dec 28 19:11:45 2000
+++ linux-2.4.0-test13-pre5/include/linux/mm.h	Thu Dec 28 19:32:22 2000
@@ -460,6 +460,7 @@
 #else
 #define __GFP_HIGHMEM	0x0 /* noop */
 #endif
+#define __GFP_RSS_LIMIT 0x20
 
 
 #define GFP_BUFFER	(__GFP_HIGH | __GFP_WAIT)
--- linux-2.4.0-test13-pre5/include/linux/swap.h.orig	Thu Dec 28 19:11:48 2000
+++ linux-2.4.0-test13-pre5/include/linux/swap.h	Thu Dec 28 19:37:54 2000
@@ -108,7 +108,8 @@
 extern int free_shortage(void);
 extern int inactive_shortage(void);
 extern void wakeup_kswapd(int);
-extern int try_to_free_pages(unsigned int gfp_mask);
+extern int try_to_free_pages(int);
+extern void enforce_rss_limit(struct mm_struct *, int);
 
 /* linux/mm/page_io.c */
 extern void rw_swap_page(int, struct page *, int);

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
