Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316427AbSEZUvg>; Sun, 26 May 2002 16:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316404AbSEZUuT>; Sun, 26 May 2002 16:50:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58128 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316383AbSEZUor>;
	Sun, 26 May 2002 16:44:47 -0400
Message-ID: <3CF149FB.50827E16@zip.com.au>
Date: Sun, 26 May 2002 13:47:55 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 17/18] move nr_active and nr_inactive into per-CPU page 
 accounting
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It might reduce pagemap_lru_lock hold times a little, and is more
consistent.  I think all global page accounting is now inside
page_states[].


--- 2.5.18/include/linux/page-flags.h~page-accounting	Sun May 26 12:38:12 2002
+++ 2.5.18-akpm/include/linux/page-flags.h	Sun May 26 12:38:12 2002
@@ -73,6 +73,8 @@ extern struct page_state {
 	unsigned long nr_dirty;
 	unsigned long nr_writeback;
 	unsigned long nr_pagecache;
+	unsigned long nr_active;	/* on active_list LRU */
+	unsigned long nr_inactive;	/* on inactive_list LRU */
 } ____cacheline_aligned_in_smp page_states[NR_CPUS];
 
 extern void get_page_state(struct page_state *ret);
--- 2.5.18/include/linux/swap.h~page-accounting	Sun May 26 12:38:12 2002
+++ 2.5.18-akpm/include/linux/swap.h	Sun May 26 12:38:12 2002
@@ -102,8 +102,6 @@ extern unsigned long totalhigh_pages;
 extern unsigned int nr_free_pages(void);
 extern unsigned int nr_free_buffer_pages(void);
 extern unsigned int nr_free_pagecache_pages(void);
-extern int nr_active_pages;
-extern int nr_inactive_pages;
 extern void __remove_inode_page(struct page *);
 
 /* Incomplete types for prototype declarations: */
@@ -191,27 +189,27 @@ do {						\
 	DEBUG_LRU_PAGE(page);			\
 	SetPageActive(page);			\
 	list_add(&(page)->lru, &active_list);	\
-	nr_active_pages++;			\
+	inc_page_state(nr_active);		\
 } while (0)
 
 #define add_page_to_inactive_list(page)		\
 do {						\
 	DEBUG_LRU_PAGE(page);			\
 	list_add(&(page)->lru, &inactive_list);	\
-	nr_inactive_pages++;			\
+	inc_page_state(nr_inactive);		\
 } while (0)
 
 #define del_page_from_active_list(page)		\
 do {						\
 	list_del(&(page)->lru);			\
 	ClearPageActive(page);			\
-	nr_active_pages--;			\
+	dec_page_state(nr_active);		\
 } while (0)
 
 #define del_page_from_inactive_list(page)	\
 do {						\
 	list_del(&(page)->lru);			\
-	nr_inactive_pages--;			\
+	dec_page_state(nr_inactive);		\
 } while (0)
 
 extern spinlock_t swaplock;
--- 2.5.18/fs/proc/proc_misc.c~page-accounting	Sun May 26 12:38:12 2002
+++ 2.5.18-akpm/fs/proc/proc_misc.c	Sun May 26 12:38:12 2002
@@ -149,8 +149,8 @@ static int meminfo_read_proc(char *page,
 		"MemShared:    %8lu kB\n"
 		"Cached:       %8lu kB\n"
 		"SwapCached:   %8lu kB\n"
-		"Active:       %8u kB\n"
-		"Inactive:     %8u kB\n"
+		"Active:       %8lu kB\n"
+		"Inactive:     %8lu kB\n"
 		"HighTotal:    %8lu kB\n"
 		"HighFree:     %8lu kB\n"
 		"LowTotal:     %8lu kB\n"
@@ -164,8 +164,8 @@ static int meminfo_read_proc(char *page,
 		K(i.sharedram),
 		K(ps.nr_pagecache-swapper_space.nrpages),
 		K(swapper_space.nrpages),
-		K(nr_active_pages),
-		K(nr_inactive_pages),
+		K(ps.nr_active),
+		K(ps.nr_inactive),
 		K(i.totalhigh),
 		K(i.freehigh),
 		K(i.totalram-i.totalhigh),
--- 2.5.18/mm/page_alloc.c~page-accounting	Sun May 26 12:38:12 2002
+++ 2.5.18-akpm/mm/page_alloc.c	Sun May 26 12:38:12 2002
@@ -27,8 +27,6 @@
 unsigned long totalram_pages;
 unsigned long totalhigh_pages;
 int nr_swap_pages;
-int nr_active_pages;
-int nr_inactive_pages;
 struct list_head inactive_list;
 struct list_head active_list;
 pg_data_t *pgdat_list;
@@ -528,7 +526,7 @@ void free_pages(unsigned long addr, unsi
 /*
  * Total amount of free (allocatable) RAM:
  */
-unsigned int nr_free_pages (void)
+unsigned int nr_free_pages(void)
 {
 	unsigned int sum;
 	zone_t *zone;
@@ -608,10 +606,7 @@ void get_page_state(struct page_state *r
 {
 	int pcpu;
 
-	ret->nr_dirty = 0;
-	ret->nr_writeback = 0;
-	ret->nr_pagecache = 0;
-
+	memset(ret, 0, sizeof(*ret));
 	for (pcpu = 0; pcpu < smp_num_cpus; pcpu++) {
 		struct page_state *ps;
 
@@ -619,6 +614,8 @@ void get_page_state(struct page_state *r
 		ret->nr_dirty += ps->nr_dirty;
 		ret->nr_writeback += ps->nr_writeback;
 		ret->nr_pagecache += ps->nr_pagecache;
+		ret->nr_active += ps->nr_active;
+		ret->nr_inactive += ps->nr_inactive;
 	}
 }
 
@@ -658,6 +655,9 @@ void show_free_areas_core(pg_data_t *pgd
  	unsigned int order;
 	unsigned type;
 	pg_data_t *tmpdat = pgdat;
+	struct page_state ps;
+
+	get_page_state(&ps);
 
 	printk("Free pages:      %6dkB (%6dkB HighMem)\n",
 		K(nr_free_pages()),
@@ -678,10 +678,12 @@ void show_free_areas_core(pg_data_t *pgd
 		tmpdat = tmpdat->node_next;
 	}
 
-	printk("( Active: %d, inactive: %d, free: %d )\n",
-	       nr_active_pages,
-	       nr_inactive_pages,
-	       nr_free_pages());
+	printk("( Active:%lu inactive:%lu dirty:%lu writeback:%lu free:%u )\n",
+		ps.nr_active,
+		ps.nr_inactive,
+		ps.nr_dirty,
+		ps.nr_writeback,
+		nr_free_pages());
 
 	for (type = 0; type < MAX_NR_ZONES; type++) {
 		struct list_head *head, *curr;
--- 2.5.18/mm/vmscan.c~page-accounting	Sun May 26 12:38:12 2002
+++ 2.5.18-akpm/mm/vmscan.c	Sun May 26 12:38:12 2002
@@ -380,16 +380,17 @@ empty:
 	return 0;
 }
 
-static int FASTCALL(shrink_cache(int nr_pages, zone_t * classzone, unsigned int gfp_mask, int priority));
-static int shrink_cache(int nr_pages, zone_t * classzone, unsigned int gfp_mask, int priority)
+static int
+shrink_cache(int nr_pages, zone_t *classzone,
+		unsigned int gfp_mask, int priority, int max_scan)
 {
 	struct list_head * entry;
 	struct address_space *mapping;
-	int max_scan = nr_inactive_pages / priority;
 	int max_mapped = nr_pages << (9 - priority);
 
 	spin_lock(&pagemap_lru_lock);
-	while (--max_scan >= 0 && (entry = inactive_list.prev) != &inactive_list) {
+	while (--max_scan >= 0 &&
+			(entry = inactive_list.prev) != &inactive_list) {
 		struct page * page;
 
 		if (need_resched()) {
@@ -619,17 +620,25 @@ static int shrink_caches(zone_t * classz
 {
 	int chunk_size = nr_pages;
 	unsigned long ratio;
+	struct page_state ps;
+	int max_scan;
 
 	nr_pages -= kmem_cache_reap(gfp_mask);
 	if (nr_pages <= 0)
 		return 0;
 
 	nr_pages = chunk_size;
-	/* try to keep the active list 2/3 of the size of the cache */
-	ratio = (unsigned long) nr_pages * nr_active_pages / ((nr_inactive_pages + 1) * 2);
-	refill_inactive(ratio);
 
-	nr_pages = shrink_cache(nr_pages, classzone, gfp_mask, priority);
+	/*
+	 * Try to keep the active list 2/3 of the size of the cache
+	 */
+	get_page_state(&ps);
+	ratio = (unsigned long)nr_pages * ps.nr_active /
+				((ps.nr_inactive | 1) * 2);
+	refill_inactive(ratio);
+	max_scan = ps.nr_inactive / priority;
+	nr_pages = shrink_cache(nr_pages, classzone,
+				gfp_mask, priority, max_scan);
 	if (nr_pages <= 0)
 		return 0;
 
--- 2.5.18/mm/filemap.c~page-accounting	Sun May 26 12:38:12 2002
+++ 2.5.18-akpm/mm/filemap.c	Sun May 26 12:38:12 2002
@@ -1415,16 +1415,19 @@ asmlinkage ssize_t sys_sendfile64(int ou
 	return ret;
 }
 
-static ssize_t do_readahead(struct file *file, unsigned long index, unsigned long nr)
+static ssize_t
+do_readahead(struct file *file, unsigned long index, unsigned long nr)
 {
 	struct address_space *mapping = file->f_dentry->d_inode->i_mapping;
 	unsigned long max;
+	struct page_state ps;
 
 	if (!mapping || !mapping->a_ops || !mapping->a_ops->readpage)
 		return -EINVAL;
 
 	/* Limit it to a sane percentage of the inactive list.. */
-	max = nr_inactive_pages / 2;
+	get_page_state(&ps);
+	max = ps.nr_inactive / 2;
 	if (nr > max)
 		nr = max;
 

-
