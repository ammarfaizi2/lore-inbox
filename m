Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbTKVAw7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 19:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbTKVAw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 19:52:59 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:35205 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261820AbTKVAwx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 19:52:53 -0500
Message-ID: <3FBEB283.9020206@us.ibm.com>
Date: Fri, 21 Nov 2003 16:49:07 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, mbligh@aracnet.com,
       Andrew Morton <akpm@digeo.com>
Subject: [RFC] Make balance_dirty_pages zone aware (2/2)
Content-Type: multipart/mixed;
 boundary="------------030303050608010604020402"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030303050608010604020402
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Currently the VM decides to start doing background writeback of pages if 
10% of the systems pages are dirty, and starts doing synchronous 
writeback of pages if 40% are dirty.  This is great for smaller memory 
systems, but in larger memory systems (>2GB or so), a process can dirty 
ALL of lowmem (ZONE_NORMAL, 896MB) without hitting the 40% dirty page 
ratio needed to force the process to do writeback.  For this and other 
reasons, it'd be nice to have a zone aware dirty page balancer.  That is 
precisely what these 2 patches try to achieve.

Patch 2/2 - numafy_balance_dirty_pages.patch:

This patch does the following things:
	1) Modify balance_dirty_pages_ratelimited() to take a pointer to a 
struct page.  Use this to determine which zone is being dirtied.
	2) Change balance_dirty_pages() to balance_dirty_pages_zone(), which 
now takes a reference to a struct zone to (potentially) balance, rather 
than balancing the whole system.
	3) Finally, create get_dirty_limits_zone(), which takes a reference to 
a struct zone and returns the dirty limits for that specific zone.  The 
old behavior of get_dirty_limits() is still available by passing a NULL 
pointer to get_dirty_limits_zone() (background_writeout() uses this).

Comments/criticism requested! :)

Cheers!

-Matt

--------------030303050608010604020402
Content-Type: text/plain;
 name="numafy_balance_dirty_pages.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="numafy_balance_dirty_pages.patch"

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test9-setup_perzone_counters/include/linux/writeback.h linux-2.6.0-test9-numafy_balance_dirty_pages/include/linux/writeback.h
--- linux-2.6.0-test9-setup_perzone_counters/include/linux/writeback.h	Wed Nov 19 15:22:48 2003
+++ linux-2.6.0-test9-numafy_balance_dirty_pages/include/linux/writeback.h	Fri Nov 21 11:16:09 2003
@@ -84,7 +84,7 @@ int dirty_writeback_centisecs_handler(st
 				      void __user *, size_t *);
 
 void page_writeback_init(void);
-int balance_dirty_pages_ratelimited(struct address_space *mapping);
+int balance_dirty_pages_ratelimited(struct address_space *mapping, struct page *page);
 int pdflush_operation(void (*fn)(unsigned long), unsigned long arg0);
 int do_writepages(struct address_space *mapping, struct writeback_control *wbc);
 ssize_t sync_page_range(struct inode *inode, struct address_space *mapping,
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test9-setup_perzone_counters/mm/filemap.c linux-2.6.0-test9-numafy_balance_dirty_pages/mm/filemap.c
--- linux-2.6.0-test9-setup_perzone_counters/mm/filemap.c	Thu Nov 20 13:40:18 2003
+++ linux-2.6.0-test9-numafy_balance_dirty_pages/mm/filemap.c	Fri Nov 21 11:16:48 2003
@@ -1991,7 +1991,7 @@ __generic_file_aio_write_nolock(struct k
 		page_cache_release(page);
 		if (status < 0)
 			break;
-		status = balance_dirty_pages_ratelimited(mapping);
+		status = balance_dirty_pages_ratelimited(mapping, page);
 		if (status < 0) {
 			pr_debug("async balance_dirty_pages\n");
 			break;
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test9-setup_perzone_counters/mm/page-writeback.c linux-2.6.0-test9-numafy_balance_dirty_pages/mm/page-writeback.c
--- linux-2.6.0-test9-setup_perzone_counters/mm/page-writeback.c	Wed Nov 19 15:26:22 2003
+++ linux-2.6.0-test9-numafy_balance_dirty_pages/mm/page-writeback.c	Fri Nov 21 15:15:30 2003
@@ -105,18 +105,34 @@ static void background_writeout(unsigned
  * clamping level.
  */
 static void
-get_dirty_limits(struct page_state *ps, long *pbackground, long *pdirty)
+get_dirty_limits_zone(struct page_state *ps, long *pbackground, long *pdirty, struct zone *zone)
 {
 	int background_ratio;		/* Percentages */
 	int dirty_ratio;
 	int unmapped_ratio;
 	long background;
 	long dirty;
+	long zone_total_pages;
 	struct task_struct *tsk;
 
-	get_page_state(ps);
+	if (!zone) {
+		/* Getting system-wide dirty limits */
+		get_page_state(ps);
+		zone_total_pages = total_pages;
+	} else {
+		/* Getting dirty limits for a specific zone */
+		memset(ps, 0, sizeof(*ps));
+		get_page_state_zone(ps, zone);
+		zone_total_pages = zone->present_pages - zone->pages_high;
+		if (zone_total_pages <= 0)
+			/* Not sure about this.  We really shouldn't be using
+			 * any zones that don't have at least pages_high pages
+			 * present...  At least it won't blow up this way?
+			 */
+			zone_total_pages = zone->present_pages;
+	}
 
-	unmapped_ratio = 100 - (ps->nr_mapped * 100) / total_pages;
+	unmapped_ratio = 100 - (ps->nr_mapped * 100) / zone_total_pages;
 
 	dirty_ratio = vm_dirty_ratio;
 	if (dirty_ratio > unmapped_ratio / 2)
@@ -129,8 +145,8 @@ get_dirty_limits(struct page_state *ps, 
 	if (background_ratio >= dirty_ratio)
 		background_ratio = dirty_ratio / 2;
 
-	background = (background_ratio * total_pages) / 100;
-	dirty = (dirty_ratio * total_pages) / 100;
+	background = (background_ratio * zone_total_pages) / 100;
+	dirty = (dirty_ratio * zone_total_pages) / 100;
 	tsk = current;
 	if (tsk->flags & PF_LESS_THROTTLE || rt_task(tsk)) {
 		background += background / 4;
@@ -140,14 +156,20 @@ get_dirty_limits(struct page_state *ps, 
 	*pdirty = dirty;
 }
 
+static inline void
+get_dirty_limits(struct page_state *ps, long *pbackground, long *pdirty)
+{
+	get_dirty_limits_zone(ps, pbackground, pdirty, NULL);
+}
+
 /*
- * balance_dirty_pages() must be called by processes which are generating dirty
- * data.  It looks at the number of dirty pages in the machine and will force
- * the caller to perform writeback if the system is over `vm_dirty_ratio'.
- * If we're over `background_thresh' then pdflush is woken to perform some
- * writeout.
+ * balance_dirty_pages_zone() must be called by processes which are generating 
+ * dirty data.  It looks at the number of dirty pages in the specified zone 
+ * and will force the caller to perform writeback if the zone is over 
+ * `vm_dirty_ratio'.  If we're over `background_thresh' then pdflush is woken 
+ * to perform some writeout.
  */
-static int balance_dirty_pages(struct address_space *mapping)
+static int balance_dirty_pages_zone(struct address_space *mapping, struct zone *zone)
 {
 	struct page_state ps;
 	long nr_reclaimable;
@@ -167,7 +189,7 @@ static int balance_dirty_pages(struct ad
 			.nonblocking	= !is_sync_wait(current->io_wait)
 		};
 
-		get_dirty_limits(&ps, &background_thresh, &dirty_thresh);
+		get_dirty_limits_zone(&ps, &background_thresh, &dirty_thresh, zone);
 		nr_reclaimable = ps.nr_dirty + ps.nr_unstable;
 		if (nr_reclaimable + ps.nr_writeback <= dirty_thresh)
 			break;
@@ -182,8 +204,8 @@ static int balance_dirty_pages(struct ad
 		 */
 		if (nr_reclaimable) {
 			writeback_inodes(&wbc);
-			get_dirty_limits(&ps, &background_thresh,
-					&dirty_thresh);
+			get_dirty_limits_zone(&ps, &background_thresh,
+					&dirty_thresh, zone);
 			nr_reclaimable = ps.nr_dirty + ps.nr_unstable;
 			if (nr_reclaimable + ps.nr_writeback <= dirty_thresh)
 				break;
@@ -210,6 +232,7 @@ static int balance_dirty_pages(struct ad
 /**
  * balance_dirty_pages_ratelimited - balance dirty memory state
  * @mapping - address_space which was dirtied
+ * @page - page which was dirtied
  *
  * Processes which are dirtying memory should call in here once for each page
  * which was newly dirtied.  The function will periodically check the system's
@@ -220,14 +243,12 @@ static int balance_dirty_pages(struct ad
  * decrease the ratelimiting by a lot, to prevent individual processes from
  * overshooting the limit by (ratelimit_pages) each.
  */
-int balance_dirty_pages_ratelimited(struct address_space *mapping)
+int balance_dirty_pages_ratelimited(struct address_space *mapping, struct page *page)
 {
 	static DEFINE_PER_CPU(int, ratelimits) = 0;
 	long ratelimit;
 
-	ratelimit = ratelimit_pages;
-	if (dirty_exceeded)
-		ratelimit = 8;
+	ratelimit = dirty_exceeded ? 8 : ratelimit_pages;
 
 	/*
 	 * Check the rate limiting. Also, we do not want to throttle real-time
@@ -236,7 +257,7 @@ int balance_dirty_pages_ratelimited(stru
 	if (get_cpu_var(ratelimits)++ >= ratelimit) {
 		__get_cpu_var(ratelimits) = 0;
 		put_cpu_var(ratelimits);
-		return balance_dirty_pages(mapping);
+		return balance_dirty_pages_zone(mapping, page_zone(page));
 	}
 	put_cpu_var(ratelimits);
 	return 0;

--------------030303050608010604020402--

