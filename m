Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261475AbTCMAeY>; Wed, 12 Mar 2003 19:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261477AbTCMAeY>; Wed, 12 Mar 2003 19:34:24 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:6337 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id <S261475AbTCMAeM>; Wed, 12 Mar 2003 19:34:12 -0500
Date: Thu, 13 Mar 2003 09:45:19 +0900
From: Indoh Takao <indou.takao@jp.fujitsu.com>
Subject: [PATCH]Tuning parameters for inode, dcache, and pagecache
To: linux-kernel@vger.kernel.org
Message-id: <18C2E8F9D2A6B8indou.takao@jp.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 2.44 (WinNT,501)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Linux doesn't have parameters which control the resources, such as
page-cache, dentry-cache. Therefore, these resources waste free area of
memory. Especially, page-cache grows until all memory is used.
So, I made a patch to add new tunable parameters as follows.

- /proc/sys/fs/inode-max   : maximum number of inode in the memory
- /proc/sys/fs/dentry-max  : maximum number of dentry-cache
- /proc/sys/vm/pgcache-max : maximum number of pages used as pagecache

The attached patch is for 2.5.64. If you don't set a value to these
parameters, these resources are not limited. (The default of each
parameter is INT_MAX or ULONG_MAX)

Please comment.

Thanks.
--------------------------------------------------
Takao Indoh
 E-Mail : indou.takao@jp.fujitsu.com


diff -Nur linux-2.5.64/fs/dcache.c linux-2.5.64-new/fs/dcache.c
--- linux-2.5.64/fs/dcache.c	Wed Mar  5 12:28:59 2003
+++ linux-2.5.64-new/fs/dcache.c	Wed Mar  5 16:48:02 2003
@@ -53,6 +53,7 @@
 /* Statistics gathering. */
 struct dentry_stat_t dentry_stat = {
 	.age_limit = 45,
+	.max_dentry = INT_MAX,
 };
 
 static void d_callback(void *arg)
@@ -395,6 +396,60 @@
 	spin_unlock(&dcache_lock);
 }
 
+
+/**
+ * purne_nr_dcache - Try to free `nr_dcache' dcaches
+ * @nr_dcache: number of dcache to free
+ * @forced: If not 0, free dcache forcibly
+ *
+ * This function tries to free dcache until all entry are scanned
+ * or `nr_dcache' entry are freed.
+ *
+ * This frees dcache forcibly if needed.
+ */
+
+void prune_nr_dcache(int nr_dcache, int forced)
+{
+	int nr_freed;
+	int nr_to_scan = dentry_stat.nr_unused;
+
+	spin_lock(&dcache_lock);
+	for(nr_freed = 0; nr_to_scan&&(nr_freed < nr_dcache); nr_to_scan--) {
+		struct dentry *dentry;
+		struct list_head *tmp;
+
+		tmp = dentry_unused.prev;
+		if (tmp == &dentry_unused)
+			break;
+		list_del_init(tmp);
+		dentry_stat.nr_unused--;
+		dentry = list_entry(tmp, struct dentry, d_lru);
+
+		spin_lock(&dentry->d_lock);
+		if (!forced) {
+			/* If the dentry was recently referenced,
+			    don't free it. */
+			if (dentry->d_vfs_flags & DCACHE_REFERENCED) {
+				dentry->d_vfs_flags &= ~DCACHE_REFERENCED;
+
+				/* don't add non zero d_count dentries
+				 * back to d_lru list
+				 */
+				if (!atomic_read(&dentry->d_count)) {
+					list_add(&dentry->d_lru, &dentry_unused);
+					dentry_stat.nr_unused++;
+				}
+				spin_unlock(&dentry->d_lock);
+				continue;
+			}
+		}
+		prune_one_dentry(dentry);
+		nr_freed++;
+	}
+	spin_unlock(&dcache_lock);
+	return;
+}
+
 /*
  * Shrink the dcache for the specified super block.
  * This allows us to unmount a device without disturbing
@@ -664,6 +719,9 @@
 }
 
 #define NAME_ALLOC_LEN(len)	((len+16) & ~15)
+#define NR_DENTRY_TO_FREE \
+	max((dentry_stat.nr_dentry - dentry_stat.max_dentry + 1), \
+	    (dentry_stat.nr_unused >> 3))
 
 /**
  * d_alloc	-	allocate a dcache entry
@@ -681,6 +739,27 @@
 	struct dentry *dentry;
 	struct qstr * qstr;
 
+	/*
+	 * Check the number of dentry.
+	 * If it exceeds maximum, shrink dentry.
+	 */
+	if (dentry_stat.nr_dentry < dentry_stat.max_dentry)
+		goto start_alloc;
+
+	/* STEP1: just shrinking dentry */
+	prune_nr_dcache(NR_DENTRY_TO_FREE, 0);
+	if (dentry_stat.nr_dentry < dentry_stat.max_dentry)
+		goto start_alloc;
+
+	/* STEP2: shrinking dentry forcibly */
+	prune_nr_dcache(NR_DENTRY_TO_FREE, 1);
+	if (dentry_stat.nr_dentry < dentry_stat.max_dentry)
+		goto start_alloc;
+
+	printk(KERN_ERR "The number of dentry exceeded maximum.\n");
+	return NULL;
+
+start_alloc:
 	dentry = kmem_cache_alloc(dentry_cache, GFP_KERNEL); 
 	if (!dentry)
 		return NULL;
@@ -741,6 +820,8 @@
 
 	return dentry;
 }
+
+#undef NR_DENTRY_TO_FREE
 
 /**
  * d_instantiate - fill in inode information for a dentry
diff -Nur linux-2.5.64/fs/inode.c linux-2.5.64-new/fs/inode.c
--- linux-2.5.64/fs/inode.c	Wed Mar  5 12:29:54 2003
+++ linux-2.5.64-new/fs/inode.c	Wed Mar  5 16:09:30 2003
@@ -93,10 +93,22 @@
 /*
  * Statistics gathering..
  */
-struct inodes_stat_t inodes_stat;
+struct inodes_stat_t inodes_stat = {
+	.max_inodes = INT_MAX,
+};
 
 static kmem_cache_t * inode_cachep;
 
+extern void prune_nr_dcache(int nr_dcache, int forced);
+extern struct dentry_stat_t dentry_stat;
+static void prune_nr_icache(int nr_inode);
+#define NR_INODE_TO_FREE \
+	max((inodes_stat.nr_inodes - inodes_stat.max_inodes + 1), \
+	    (inodes_stat.nr_unused >> 3))
+#define NR_DENTRY_TO_FREE \
+	max((dentry_stat.nr_dentry - dentry_stat.max_dentry + 1), \
+	    (dentry_stat.nr_unused >> 3))
+
 static struct inode *alloc_inode(struct super_block *sb)
 {
 	static struct address_space_operations empty_aops;
@@ -104,6 +116,34 @@
 	static struct file_operations empty_fops;
 	struct inode *inode;
 
+	/*
+	 * Check the number of inode.
+	 * If it exceeds maximum, shrink inode.
+	 */
+	if (inodes_stat.nr_inodes < inodes_stat.max_inodes)
+		goto start_alloc;
+
+	/* STEP1: just shrinking icache */
+	prune_nr_icache(NR_INODE_TO_FREE);
+	if (inodes_stat.nr_inodes < inodes_stat.max_inodes)
+		goto start_alloc;
+
+	/* STEP2: shrinking dcache */
+	prune_nr_dcache(NR_DENTRY_TO_FREE, 0);
+	prune_nr_icache(NR_INODE_TO_FREE);
+	if (inodes_stat.nr_inodes < inodes_stat.max_inodes)
+		goto start_alloc;
+
+	/* STEP3: shrinking dcache forcibly */
+	prune_nr_dcache(NR_DENTRY_TO_FREE, 1);
+	prune_nr_icache(NR_INODE_TO_FREE);
+	if (inodes_stat.nr_inodes < inodes_stat.max_inodes)
+		goto start_alloc;
+
+	printk(KERN_ERR "The number of inode exceeded maximum.\n");
+	return NULL;
+
+start_alloc:
 	if (sb->s_op->alloc_inode)
 		inode = sb->s_op->alloc_inode(sb);
 	else
@@ -152,6 +192,9 @@
 	return inode;
 }
 
+#undef NR_INODE_TO_FREE
+#undef NR_DENTRY_TO_FREE
+
 void destroy_inode(struct inode *inode) 
 {
 	if (inode_has_buffers(inode))
@@ -450,6 +493,35 @@
 		mod_page_state(kswapd_inodesteal, reap);
 	else
 		mod_page_state(pginodesteal, reap);
+}
+
+/**
+ * prune_nr_icache - Try to free `nr_inode' inodes
+ * @nr_inode: number of inode to free
+ *
+ * This function tries to free inodes until all inodes are scanned
+ * or `nr_inode' inodes are freed.
+ */
+
+static void prune_nr_icache(int nr_inode)
+{
+	int nr_to_scan = inodes_stat.nr_unused;
+	int nr_freed = 0, prev_nr_inode, scan;
+
+	if(nr_inode <= 0)
+		return;
+
+	while(nr_to_scan && (nr_freed < nr_inode)) {
+		prev_nr_inode = inodes_stat.nr_unused;
+		scan = nr_inode - nr_freed;
+		prune_icache(scan);
+
+		if (list_empty(&inode_unused))
+			break;
+
+		nr_freed += (prev_nr_inode - inodes_stat.nr_unused);
+		nr_to_scan -= scan;
+	}
 }
 
 /*
diff -Nur linux-2.5.64/include/linux/dcache.h linux-2.5.64-new/include/linux/dcache.h
--- linux-2.5.64/include/linux/dcache.h	Wed Mar  5 12:29:54 2003
+++ linux-2.5.64-new/include/linux/dcache.h	Wed Mar  5 15:26:40 2003
@@ -39,7 +39,8 @@
 	int nr_unused;
 	int age_limit;          /* age in seconds */
 	int want_pages;         /* pages requested by system */
-	int dummy[2];
+	int max_dentry;
+	int dummy[1];
 };
 extern struct dentry_stat_t dentry_stat;
 
diff -Nur linux-2.5.64/include/linux/fs.h linux-2.5.64-new/include/linux/fs.h
--- linux-2.5.64/include/linux/fs.h	Wed Mar  5 12:29:03 2003
+++ linux-2.5.64-new/include/linux/fs.h	Wed Mar  5 15:26:40 2003
@@ -58,7 +58,8 @@
 struct inodes_stat_t {
 	int nr_inodes;
 	int nr_unused;
-	int dummy[5];
+	int max_inodes;
+	int dummy[4];
 };
 extern struct inodes_stat_t inodes_stat;
 
diff -Nur linux-2.5.64/include/linux/gfp.h linux-2.5.64-new/include/linux/gfp.h
--- linux-2.5.64/include/linux/gfp.h	Wed Mar  5 12:29:03 2003
+++ linux-2.5.64-new/include/linux/gfp.h	Wed Mar  5 15:26:40 2003
@@ -18,6 +18,7 @@
 #define __GFP_FS	0x80	/* Can call down to low-level FS? */
 #define __GFP_COLD	0x100	/* Cache-cold page required */
 #define __GFP_NOWARN	0x200	/* Suppress page allocation failure warning */
+#define __GFP_PGCACHE   0x400   /* Page-cache required */
 
 #define GFP_ATOMIC	(__GFP_HIGH)
 #define GFP_NOIO	(__GFP_WAIT)
diff -Nur linux-2.5.64/include/linux/mm.h linux-2.5.64-new/include/linux/mm.h
--- linux-2.5.64/include/linux/mm.h	Wed Mar  5 12:28:56 2003
+++ linux-2.5.64-new/include/linux/mm.h	Wed Mar  5 15:26:40 2003
@@ -22,6 +22,7 @@
 extern unsigned long num_physpages;
 extern void * high_memory;
 extern int page_cluster;
+extern unsigned long max_pgcache;
 
 #include <asm/page.h>
 #include <asm/pgtable.h>
diff -Nur linux-2.5.64/include/linux/page-flags.h linux-2.5.64-new/include/linux/page-flags.h
--- linux-2.5.64/include/linux/page-flags.h	Wed Mar  5 12:29:31 2003
+++ linux-2.5.64-new/include/linux/page-flags.h	Wed Mar  5 15:26:40 2003
@@ -74,6 +74,7 @@
 #define PG_mappedtodisk		17	/* Has blocks allocated on-disk */
 #define PG_reclaim		18	/* To be reclaimed asap */
 #define PG_compound		19	/* Part of a compound page */
+#define PG_pgcache		20	/* Page is used as pagecache */
 
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
@@ -255,6 +256,10 @@
 #define PageCompound(page)	test_bit(PG_compound, &(page)->flags)
 #define SetPageCompound(page)	set_bit(PG_compound, &(page)->flags)
 #define ClearPageCompound(page)	clear_bit(PG_compound, &(page)->flags)
+
+#define PagePgcache(page)      test_bit(PG_pgcache, &(page)->flags)
+#define SetPagePgcache(page)   set_bit(PG_pgcache, &(page)->flags)
+#define ClearPagePgcache(page) clear_bit(PG_pgcache, &(page)->flags)
 
 /*
  * The PageSwapCache predicate doesn't use a PG_flag at this time,
diff -Nur linux-2.5.64/include/linux/pagemap.h linux-2.5.64-new/include/linux/pagemap.h
--- linux-2.5.64/include/linux/pagemap.h	Wed Mar  5 12:28:53 2003
+++ linux-2.5.64-new/include/linux/pagemap.h	Wed Mar  5 15:26:40 2003
@@ -29,12 +29,12 @@
 
 static inline struct page *page_cache_alloc(struct address_space *x)
 {
-	return alloc_pages(x->gfp_mask, 0);
+	return alloc_pages(x->gfp_mask|__GFP_PGCACHE, 0);
 }
 
 static inline struct page *page_cache_alloc_cold(struct address_space *x)
 {
-	return alloc_pages(x->gfp_mask|__GFP_COLD, 0);
+	return alloc_pages(x->gfp_mask|__GFP_COLD|__GFP_PGCACHE, 0);
 }
 
 typedef int filler_t(void *, struct page *);
@@ -80,6 +80,7 @@
 	list_add(&page->list, &mapping->clean_pages);
 	page->mapping = mapping;
 	page->index = index;
+	SetPagePgcache(page);
 
 	mapping->nrpages++;
 	inc_page_state(nr_pagecache);
diff -Nur linux-2.5.64/include/linux/sysctl.h linux-2.5.64-new/include/linux/sysctl.h
--- linux-2.5.64/include/linux/sysctl.h	Wed Mar  5 12:29:21 2003
+++ linux-2.5.64-new/include/linux/sysctl.h	Wed Mar  5 15:26:40 2003
@@ -155,6 +155,7 @@
 	VM_HUGETLB_PAGES=18,	/* int: Number of available Huge Pages */
 	VM_SWAPPINESS=19,	/* Tendency to steal mapped memory */
 	VM_LOWER_ZONE_PROTECTION=20,/* Amount of protection of lower zones */
+	VM_MAXPGCACHE=21,/* maximum number of page used as pagecache */
 };
 
 
@@ -576,6 +577,7 @@
 	FS_LEASE_TIME=15,	/* int: maximum time to wait for a lease break */
 	FS_DQSTATS=16,	/* disc quota usage statistics */
 	FS_XFS=17,	/* struct: control xfs parameters */
+	FS_MAXDENTRY=18,	/* int:maximum number of dcache that can be allocated */
 };
 
 /* /proc/sys/fs/quota/ */
diff -Nur linux-2.5.64/kernel/sysctl.c linux-2.5.64-new/kernel/sysctl.c
--- linux-2.5.64/kernel/sysctl.c	Wed Mar  5 12:28:58 2003
+++ linux-2.5.64-new/kernel/sysctl.c	Wed Mar  5 15:26:40 2003
@@ -319,6 +319,8 @@
 	 &sysctl_lower_zone_protection, sizeof(sysctl_lower_zone_protection),
 	 0644, NULL, &proc_dointvec_minmax, &sysctl_intvec, NULL, &zero,
 	 NULL, },
+	{VM_MAXPGCACHE, "pgcache-max", &max_pgcache, sizeof(unsigned long),
+	 0644, NULL,&proc_dointvec_minmax, &sysctl_intvec, NULL,&zero,NULL},
 	{0}
 };
 
@@ -331,6 +333,9 @@
 	 0444, NULL, &proc_dointvec},
 	{FS_STATINODE, "inode-state", &inodes_stat, 7*sizeof(int),
 	 0444, NULL, &proc_dointvec},
+	{FS_MAXINODE, "inode-max", &inodes_stat.max_inodes, sizeof(int), 0644, NULL,
+	 &proc_dointvec_minmax, &sysctl_intvec, NULL,
+	 &zero, NULL},
 	{FS_NRFILE, "file-nr", &files_stat, 3*sizeof(int),
 	 0444, NULL, &proc_dointvec},
 	{FS_MAXFILE, "file-max", &files_stat.max_files, sizeof(int),
@@ -349,6 +354,8 @@
 	 sizeof(int), 0644, NULL, &proc_dointvec},
 	{FS_LEASE_TIME, "lease-break-time", &lease_break_time, sizeof(int),
 	 0644, NULL, &proc_dointvec},
+	{FS_MAXDENTRY, "dentry-max", &dentry_stat.max_dentry, sizeof(int),
+	 0644, NULL,&proc_dointvec_minmax, &sysctl_intvec, NULL,&zero,NULL},
 	{0}
 };
 
diff -Nur linux-2.5.64/mm/filemap.c linux-2.5.64-new/mm/filemap.c
--- linux-2.5.64/mm/filemap.c	Wed Mar  5 12:29:15 2003
+++ linux-2.5.64-new/mm/filemap.c	Wed Mar  5 15:26:40 2003
@@ -86,6 +86,7 @@
 	radix_tree_delete(&mapping->page_tree, page->index);
 	list_del(&page->list);
 	page->mapping = NULL;
+	ClearPagePgcache(page);
 
 	mapping->nrpages--;
 	dec_page_state(nr_pagecache);
@@ -437,7 +438,7 @@
 	page = find_lock_page(mapping, index);
 	if (!page) {
 		if (!cached_page) {
-			cached_page = alloc_page(gfp_mask);
+			cached_page = alloc_page(gfp_mask|__GFP_PGCACHE);
 			if (!cached_page)
 				return NULL;
 		}
@@ -507,7 +508,7 @@
 		return NULL;
 	}
 	gfp_mask = mapping->gfp_mask & ~__GFP_FS;
-	page = alloc_pages(gfp_mask, 0);
+	page = alloc_pages(gfp_mask|__GFP_PGCACHE, 0);
 	if (page && add_to_page_cache_lru(page, mapping, index, gfp_mask)) {
 		page_cache_release(page);
 		page = NULL;
diff -Nur linux-2.5.64/mm/page_alloc.c linux-2.5.64-new/mm/page_alloc.c
--- linux-2.5.64/mm/page_alloc.c	Wed Mar  5 12:28:58 2003
+++ linux-2.5.64-new/mm/page_alloc.c	Wed Mar  5 15:26:40 2003
@@ -39,6 +39,7 @@
 int nr_swap_pages;
 int numnodes = 1;
 int sysctl_lower_zone_protection = 0;
+unsigned long max_pgcache = ULONG_MAX;
 
 /*
  * Used by page_zone() to look up the address of the struct zone whose
@@ -52,6 +53,9 @@
 static int zone_balance_min[MAX_NR_ZONES] __initdata = { 20 , 20, 20, };
 static int zone_balance_max[MAX_NR_ZONES] __initdata = { 255 , 255, 255, };
 
+extern int shrink_pgcache(struct zonelist *zonelist, unsigned int gfp_mask,
+	unsigned int max_nrpage, struct page_state *ps);
+
 /*
  * Temporary debugging check for pages not lying within a given zone.
  */
@@ -548,6 +552,45 @@
 	classzone = zones[0]; 
 	if (classzone == NULL)    /* no zones in the zonelist */
 		return NULL;
+
+	if (gfp_mask & __GFP_PGCACHE) {
+		struct page_state ps;
+		int counter = 0, nr_page;
+
+		min = 1UL << order;
+		get_page_state(&ps);
+		if(ps.nr_pagecache + min < max_pgcache)
+			goto start_alloc;
+
+		/* try to shrink pagecache */
+		nr_page = ps.nr_pagecache + min - max_pgcache;
+		shrink_pgcache(zonelist, gfp_mask, nr_page, &ps);
+		get_page_state(&ps);
+		if(ps.nr_pagecache + min < max_pgcache)
+			goto start_alloc;
+
+		if (wait) {
+			/* Can't free enough memory. Start try_to_free_pages. */
+			while(ps.nr_pagecache + min > max_pgcache) {
+				counter++;
+				current->flags |= PF_MEMALLOC;
+				try_to_free_pages(classzone, gfp_mask, order);
+				current->flags &= ~PF_MEMALLOC;
+
+				get_page_state(&ps);
+				if (counter >= 1000)
+					break;
+			}
+		}
+
+		if(ps.nr_pagecache + min < max_pgcache)
+			goto start_alloc;
+
+		printk(KERN_ERR "The number of pagecache exceeded maximum.\n");
+		return NULL;
+
+start_alloc:
+	}
 
 	/* Go through the zonelist once, looking for a zone with enough free */
 	min = 1UL << order;
diff -Nur linux-2.5.64/mm/swap_state.c linux-2.5.64-new/mm/swap_state.c
--- linux-2.5.64/mm/swap_state.c	Wed Mar  5 12:29:17 2003
+++ linux-2.5.64-new/mm/swap_state.c	Wed Mar  5 15:26:40 2003
@@ -360,7 +360,7 @@
 		 * Get a new page to read into from swap.
 		 */
 		if (!new_page) {
-			new_page = alloc_page(GFP_HIGHUSER);
+			new_page = alloc_page(GFP_HIGHUSER|__GFP_PGCACHE);
 			if (!new_page)
 				break;		/* Out of memory */
 		}
diff -Nur linux-2.5.64/mm/vmscan.c linux-2.5.64-new/mm/vmscan.c
--- linux-2.5.64/mm/vmscan.c	Wed Mar  5 12:28:59 2003
+++ linux-2.5.64-new/mm/vmscan.c	Wed Mar  5 15:26:40 2003
@@ -493,6 +493,13 @@
 				list_add(&page->lru, &zone->inactive_list);
 				continue;
 			}
+			if (gfp_mask & __GFP_PGCACHE) {
+				if (!PagePgcache(page)) {
+					SetPageLRU(page);
+					list_add(&page->lru, &zone->inactive_list);
+					continue;
+				}
+			}
 			list_add(&page->lru, &page_list);
 			page_cache_get(page);
 			nr_taken++;
@@ -737,6 +744,40 @@
 	}
 	return shrink_cache(nr_pages, zone, gfp_mask,
 				max_scan, nr_mapped);
+}
+
+/*
+ * Try to reclaim `nr_pages' from pagecache of this zone.
+ * Returns the number of reclaimed pages.
+ */
+int shrink_pgcache(struct zonelist *zonelist, unsigned int gfp_mask,
+	unsigned int nr_pages, struct page_state *ps)
+{
+	struct zone **zones;
+	struct zone *first_classzone;
+	struct zone *zone;
+	unsigned int ret = 0, reclaim;
+	unsigned long rest_nr_page;
+	int dummy, i;
+
+	zones = zonelist->zones;
+	for (i = 0; zones[i] != NULL; i++) {
+		zone = zones[i];
+		first_classzone = zone->zone_pgdat->node_zones;
+		for (; zone >= first_classzone; zone--) {
+			if (zone->all_unreclaimable) /* all pages pinned */
+				continue;
+
+			rest_nr_page = nr_pages - ret;
+			reclaim = max(((zone->nr_inactive)>>2)+1, rest_nr_page);
+			ret += shrink_zone(zone, zone->nr_inactive,
+					   gfp_mask|__GFP_PGCACHE,
+					   reclaim, &dummy, ps, DEF_PRIORITY);
+			if (ret >= nr_pages)
+				return ret;
+		}
+	}
+	return ret;
 }
 
 /*
