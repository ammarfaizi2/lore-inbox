Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132699AbRDCV0c>; Tue, 3 Apr 2001 17:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132698AbRDCV0X>; Tue, 3 Apr 2001 17:26:23 -0400
Received: from tomts8.bellnexxia.net ([209.226.175.52]:22678 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S132693AbRDCV0F>; Tue, 3 Apr 2001 17:26:05 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-mm@kvack.org
Subject: Fwd: Re: [PATCH][RFC] appling preasure to icache and dcache
Date: Tue, 3 Apr 2001 17:25:13 -0400
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org, squash@primary.net
MIME-Version: 1.0
Message-Id: <01040317251303.31476@oscar>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



----------  Forwarded Message  ----------
Subject: Re: [PATCH][RFC] appling preasure to icache and dcache
Date: Tue, 3 Apr 2001 17:22:10 -0400
From: Ed Tomlinson <tomlins@cam.org>
To: bredelin@ucla.edu
Cc: l 


On Tuesday 03 April 2001 11:03, Benjamin Redelings I wrote:
> Hi, I'm glad somebody is working on this!  VM-time seems like a pretty
> useful concept.

Think it might be useful for detecting trashing too.  If vmtime is made
to directly relate to the page allocation rate then you can do something
like this.  Let K be a number intially representing 25% of ram pages.
Because vmtime is directly releated to allocation rates its meanful to
subtract K from the current vmtime.  For each swapped out page, record
the current vmtime.  Now if the recorded vmtime of the page you are
swapping in is greater than vmtime-K increment A otherwise increment B.
If A>B we are thrashing.  We decay A and B via kswapd.  We adjust K
depending on the swapping rate.  Thoughts?

> 	I think you have a bug in your patch here:
>
> +       if (base > pages)       /* If the cache shrunk reset base,  The
> cache
> +               base = pages;    * growing applies preasure as does
> expanding
> +       if (free > old)          * free space - even if later shrinks */
> +               base -= (base>free-old) ? free-old : base;
>
> It looks like you unintentionally commented out two lines of code?

Geez.  That will teach me to add comments _after_ testing the code...
The patch as it stands, will not apply pressure as the caches expands.
Good catch.  Thanks.

> 	I have been successfully running your patch.  But I think it needs
> benchmarks.  At the very least, compile the kernel twice w/o and twice
> w/ your patch and see how it changes the times.  I do not think I will
> have time to do it myself anytime soon unfortunately.
> 	I have a 64Mb RAM machine, and the patch makes the system feel a little
> bit slower when hitting the disk.  BUt that is subjective...

Where I see a difference is with backups.  With the patch applied they take
about 2:20 or so, and use over 60K inodes/dentries, without the patch they
take 2:35 (plus or minus 5 mins) and use over 190K inodes/dentries.  On a box
with lots of memory pressure (ie with 64M) I doubt that the calls to shrink
the caches get triggered often from my code - expect that you are usually
shrinking via do_try_to_free_pages.  What might cause your subjective
 difference may be the change in:

refill_inactive_scan(DEF_PRIORITY, delta);

You might want to try replacing this delta with 0 (in kswapd).  If this
 improves things for you I have to do a little rethinking...

Corrected patch follows:

---
diff -u -r --exclude-from=ex.txt linux.ac28/mm/page_alloc.c
 linux/mm/page_alloc.c --- linux.ac28/mm/page_alloc.c	Sun Apr  1 18:52:22
 2001
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
+	if (base > pages)	/* If the cache shrunk reset base,  The cache */
+		base = pages;	/* growing applies preasure as does expanding */
+	if (free > old)		/* free space - even if later shrinks */
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

Ed Tomlinson <tomlins@cam.org>

-------------------------------------------------------
