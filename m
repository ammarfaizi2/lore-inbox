Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129115AbRDBM7X>; Mon, 2 Apr 2001 08:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129116AbRDBM7O>; Mon, 2 Apr 2001 08:59:14 -0400
Received: from tomts8.bellnexxia.net ([209.226.175.52]:21397 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S129115AbRDBM7E>; Mon, 2 Apr 2001 08:59:04 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-mm@kvack.org
Subject: Re: [PATCH][RFC] appling preasure to icache and dcache
Date: Mon, 2 Apr 2001 08:58:21 -0400
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01040208425501.20592@oscar>
In-Reply-To: <01040208425501.20592@oscar>
MIME-Version: 1.0
Message-Id: <01040208582103.20592@oscar>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The patch in the last message was scrambled.  The last two lines
belong to the previous fragment.  Here is the correct beast.

Ed Tomlinson <tomlins@cam.org

---
diff -u -r --exclude-from=ex.txt linux.ac28/mm/page_alloc.c linux/mm/page_alloc.c
--- linux.ac28/mm/page_alloc.c	Sun Apr  1 18:52:22 2001
+++ linux/mm/page_alloc.c	Mon Apr  2 07:54:05 2001
@@ -138,11 +138,9 @@
 
 	/*
 	 * We don't want to protect this variable from race conditions
-	 * since it's nothing important, but we do want to make sure
-	 * it never gets negative.
+	 * since it's nothing important.
 	 */
-	if (memory_pressure > NR_CPUS)
-		memory_pressure--;
+	inactivate_pressure++;
 }
 
 #define MARK_USED(index, order, area) \
diff -u -r --exclude-from=ex.txt linux.ac28/mm/swap.c linux/mm/swap.c
--- linux.ac28/mm/swap.c	Mon Jan 22 16:30:21 2001
+++ linux/mm/swap.c	Thu Mar 29 11:37:47 2001
@@ -47,10 +47,12 @@
  * many inactive pages we should have.
  *
  * In reclaim_page and __alloc_pages: memory_pressure++
- * In __free_pages_ok: memory_pressure--
+ * In __free_pages_ok: inactivate_pressure++
+ * In invalidate_pages_scan: inactivate_pressure++
  * In recalculate_vm_stats the value is decayed (once a second)
  */
 int memory_pressure;
+int inactivate_pressure;
 
 /* We track the number of pages currently being asynchronously swapped
    out, so that we don't try to swap TOO many pages out at once */
@@ -287,6 +289,7 @@
 	 * memory_pressure.
 	 */
 	memory_pressure -= (memory_pressure >> INACTIVE_SHIFT);
+	inactivate_pressure -= (inactivate_pressure >> INACTIVE_SHIFT);
 }
 
 /*
diff -u -r --exclude-from=ex.txt linux.ac28/mm/vmscan.c linux/mm/vmscan.c
--- linux.ac28/mm/vmscan.c	Sun Apr  1 18:52:22 2001
+++ linux/mm/vmscan.c	Mon Apr  2 07:42:55 2001
@@ -759,6 +791,8 @@
 	}
 	spin_unlock(&pagemap_lru_lock);
 
+	inactivate_pressure += nr_deactivated;
+
 	return nr_deactivated;
 }
 
@@ -937,6 +971,76 @@
 	return ret;
 }
 
+/*
+ * Try to shrink the dcache if either its size or free space
+ * has grown, and it looks like we might get the required pages.
+ * This function would simplify if the caches tracked how
+ * many _pages_ were freeable.
+ */
+int try_shrinking_dcache(int goal, unsigned int gfp_mask)
+{
+
+	/* base - projects the threshold above which we can free pages */
+	
+	static int base, free = 0;
+	int pages, old, ret;
+
+	old = free;			/* save old free space size */
+
+	pages = (dentry_stat.nr_dentry * sizeof(struct dentry)) >> PAGE_SHIFT;
+	free = (dentry_stat.nr_unused * sizeof(struct dentry)) >> PAGE_SHIFT;
+
+	if (base > pages)	/* If the cache shrunk reset base,  The cache
+		base = pages;	 * growing applies preasure as does expanding
+	if (free > old)		 * free space - even if later shrinks */
+		base -= (base>free-old) ? free-old : base;
+
+	/* try free pages...  Note that the using inactive_pressure _is_
+	 * racy.  It does not matter, a bad guess will not hurt us.
+	 * Testing free here does not work effectivily.
+	 */
+	
+	if (pages-base >= goal) { 
+		ret = inactivate_pressure;
+       		shrink_dcache_memory(DEF_PRIORITY, gfp_mask);
+		ret = inactivate_pressure - ret; 
+		base += (!ret) ? pages-base : (ret>goal) ? ret : goal; 
+	} else
+		ret = 0;
+
+	return ret;
+}
+
+/*
+ * Same logic as above but for the icache.
+ */
+int try_shrinking_icache(int goal, unsigned int gfp_mask)
+{
+	static int base, free = 0;
+	int pages, old, ret;
+	
+	old = free;
+
+	pages = (inodes_stat.nr_inodes * sizeof(struct inode)) >> PAGE_SHIFT;
+	free = (inodes_stat.nr_unused * sizeof(struct inode)) >> PAGE_SHIFT;
+	
+	if (base > pages)
+		base = pages;
+	if (free > old)
+		base -= (base>free-old) ? free-old : base;
+
+	if (pages-base >= goal) { 
+		ret = inactivate_pressure;
+       		shrink_icache_memory(DEF_PRIORITY, gfp_mask);
+		ret = inactivate_pressure - ret; 
+		base += (!ret) ? pages-base : (ret>goal) ? ret : goal; 
+	} else
+		ret = 0;
+
+	return ret;
+}
+
+
 DECLARE_WAIT_QUEUE_HEAD(kswapd_wait);
 DECLARE_WAIT_QUEUE_HEAD(kswapd_done);
 struct task_struct *kswapd_task;
@@ -984,18 +1088,28 @@
 	 */
 	for (;;) {
 		static int recalc = 0;
+		int delta = 0;
 
 		/* If needed, try to free some memory. */
 		if (inactive_shortage() || free_shortage()) 
 			do_try_to_free_pages(GFP_KSWAPD, 0);
 
 		/*
-		 * Do some (very minimal) background scanning. This
-		 * will scan all pages on the active list once
-		 * every minute. This clears old referenced bits
-		 * and moves unused pages to the inactive list.
+		 * Try to keep the rate of pages inactivations 
+		 * similar to the rate of pages allocations.  This
+		 * also perform background page aging, but only
+		 * when there is preasure on the vm.  We get the
+		 * pages from the dcache and icache if its likely
+		 * there are enought freeable pages there.
 		 */
-		refill_inactive_scan(DEF_PRIORITY, 0);
+		delta = (memory_pressure >> INACTIVE_SHIFT) \
+			- (inactivate_pressure >> INACTIVE_SHIFT);
+		if (delta > 0)
+			delta -= try_shrinking_dcache(delta,GFP_KSWAPD);
+		if (delta > 0)
+			delta -= try_shrinking_icache(delta,GFP_KSWAPD);
+		if (delta > 0)
+			refill_inactive_scan(DEF_PRIORITY, delta);
 
 		/* Once a second, recalculate some VM stats. */
 		if (time_after(jiffies, recalc + HZ)) {
--- linux.ac28/include/linux/swap.h	Sun Apr  1 18:52:22 2001
+++ linux/include/linux/swap.h	Thu Mar 29 11:31:09 2001
@@ -102,6 +102,7 @@
 
 /* linux/mm/swap.c */
 extern int memory_pressure;
+extern int inactivate_pressure;
 extern void age_page_up(struct page *);
 extern void age_page_up_nolock(struct page *);
 extern void age_page_down(struct page *);
---
