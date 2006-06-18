Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWFRHgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWFRHgt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 03:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbWFRHgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 03:36:20 -0400
Received: from mail30.syd.optusnet.com.au ([211.29.133.193]:24201 "EHLO
	mail30.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932156AbWFRHf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 03:35:26 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux list <linux-kernel@vger.kernel.org>
Subject: [ckpatch][27/29] mm-filesize_dependant_lru_cache_add.patch
Date: Sun, 18 Jun 2006 17:35:23 +1000
User-Agent: KMail/1.9.3
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 8511
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200606181735.23265.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When reading from large files through the generic file read functions into
page cache we can detect when a file is so large that it is unlikely to be
fully cached in ram.

Add a tunable /proc/sys/vm/tail_largefiles that puts them at the tail of the
inactive list to minimise their harm on present mapped pages and pagecache
and enable it by default.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

---
 Documentation/filesystems/proc.txt |    8 ++++++
 Documentation/sysctl/vm.txt        |    2 -
 include/linux/sysctl.h             |    1 
 include/linux/writeback.h          |    2 +
 kernel/sysctl.c                    |    9 +++++++
 mm/filemap.c                       |   47 +++++++++++++++++++++++++++++++++++--
 mm/page-writeback.c                |    2 -
 mm/swap.c                          |    3 --
 8 files changed, 68 insertions(+), 6 deletions(-)

Index: linux-ck-dev/include/linux/writeback.h
===================================================================
--- linux-ck-dev.orig/include/linux/writeback.h	2006-06-18 15:20:10.000000000 +1000
+++ linux-ck-dev/include/linux/writeback.h	2006-06-18 15:25:25.000000000 +1000
@@ -85,6 +85,8 @@ void laptop_io_completion(void);
 void laptop_sync_completion(void);
 void throttle_vm_writeout(void);
 
+extern long total_pages;
+
 /* These are exported to sysctl. */
 extern int dirty_background_ratio;
 extern int vm_dirty_ratio;
Index: linux-ck-dev/mm/filemap.c
===================================================================
--- linux-ck-dev.orig/mm/filemap.c	2006-06-18 15:20:10.000000000 +1000
+++ linux-ck-dev/mm/filemap.c	2006-06-18 15:25:25.000000000 +1000
@@ -434,6 +434,16 @@ int add_to_page_cache_lru(struct page *p
 	return ret;
 }
 
+int add_to_page_cache_lru_tail(struct page *page,
+	struct address_space *mapping, pgoff_t offset, gfp_t gfp_mask)
+{
+	int ret = add_to_page_cache(page, mapping, offset, gfp_mask);
+
+	if (ret == 0)
+		lru_cache_add_tail(page);
+	return ret;
+}
+
 #ifdef CONFIG_NUMA
 struct page *page_cache_alloc(struct address_space *x)
 {
@@ -783,6 +793,28 @@ grab_cache_page_nowait(struct address_sp
 EXPORT_SYMBOL(grab_cache_page_nowait);
 
 /*
+ * Sysctl which determines whether we should read from large files to the
+ * tail of the inactive lru list.
+ */
+int vm_tail_largefiles __read_mostly = 1;
+
+/*
+ * This examines how large in pages a file size is and returns 1 if it is
+ * more than half the unmapped ram. Avoid doing read_page_state which is
+ * expensive unless we already know it is likely to be large enough.
+ */
+static int large_isize(unsigned long nr_pages)
+{
+	if (nr_pages * 6 > total_pages) {
+		 unsigned long unmapped_ram = total_pages - read_page_state(nr_mapped);
+
+		if (nr_pages * 2 > unmapped_ram)
+			return 1;
+	}
+	return 0;
+}
+
+/*
  * This is a generic file read routine, and uses the
  * mapping->a_ops->readpage() function for the actual low-level
  * stuff.
@@ -982,8 +1014,19 @@ no_cached_page:
 				goto out;
 			}
 		}
-		error = add_to_page_cache_lru(cached_page, mapping,
-						index, GFP_KERNEL);
+
+		/*
+		 * If we know the file is large we add the pages read to the
+		 * end of the lru as we're unlikely to be able to cache the
+		 * whole file in ram so make those pages the first to be
+		 * dropped if not referenced soon.
+		 */
+		if (vm_tail_largefiles && large_isize(end_index))
+			error = add_to_page_cache_lru_tail(cached_page,
+						mapping, index, GFP_KERNEL);
+		else
+			error = add_to_page_cache_lru(cached_page, mapping,
+							index, GFP_KERNEL);
 		if (error) {
 			if (error == -EEXIST)
 				goto find_page;
Index: linux-ck-dev/mm/page-writeback.c
===================================================================
--- linux-ck-dev.orig/mm/page-writeback.c	2006-06-18 15:25:22.000000000 +1000
+++ linux-ck-dev/mm/page-writeback.c	2006-06-18 15:25:25.000000000 +1000
@@ -45,7 +45,7 @@
  */
 static long ratelimit_pages = 32;
 
-static long total_pages;	/* The total number of pages in the machine. */
+long total_pages __read_mostly;	/* The total number of pages in the machine. */
 static int dirty_exceeded __cacheline_aligned_in_smp;	/* Dirty mem may be over limit */
 
 /*
Index: linux-ck-dev/mm/swap.c
===================================================================
--- linux-ck-dev.orig/mm/swap.c	2006-06-18 15:24:48.000000000 +1000
+++ linux-ck-dev/mm/swap.c	2006-06-18 15:25:25.000000000 +1000
@@ -416,8 +416,7 @@ void __pagevec_lru_add_active(struct pag
 
 /*
  * Function used uniquely to put pages back to the lru at the end of the
- * inactive list to preserve the lru order. Currently only used by swap
- * prefetch.
+ * inactive list to preserve the lru order.
  */
 void fastcall lru_cache_add_tail(struct page *page)
 {
Index: linux-ck-dev/include/linux/sysctl.h
===================================================================
--- linux-ck-dev.orig/include/linux/sysctl.h	2006-06-18 15:24:58.000000000 +1000
+++ linux-ck-dev/include/linux/sysctl.h	2006-06-18 15:25:25.000000000 +1000
@@ -191,6 +191,7 @@ enum
 	VM_ZONE_RECLAIM_INTERVAL=32, /* time period to wait after reclaim failure */
 	VM_SWAP_PREFETCH=33,	/* swap prefetch */
 	VM_HARDMAPLIMIT=34,	/* Make mapped a hard limit */
+	VM_TAIL_LARGEFILES=35,	/* Read large files to lru tail */
 };
 
 
Index: linux-ck-dev/kernel/sysctl.c
===================================================================
--- linux-ck-dev.orig/kernel/sysctl.c	2006-06-18 15:24:58.000000000 +1000
+++ linux-ck-dev/kernel/sysctl.c	2006-06-18 15:25:25.000000000 +1000
@@ -73,6 +73,7 @@ extern int printk_ratelimit_burst;
 extern int pid_max_min, pid_max_max;
 extern int sysctl_drop_caches;
 extern int percpu_pagelist_fraction;
+extern int vm_tail_largefiles;
 
 #if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86)
 int unknown_nmi_panic;
@@ -809,6 +810,14 @@ static ctl_table vm_table[] = {
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
 	},
+	{
+		.ctl_name	= VM_TAIL_LARGEFILES,
+		.procname	= "tail_largefiles",
+		.data		= &vm_tail_largefiles,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
 #ifdef CONFIG_HUGETLB_PAGE
 	 {
 		.ctl_name	= VM_HUGETLB_PAGES,
Index: linux-ck-dev/Documentation/filesystems/proc.txt
===================================================================
--- linux-ck-dev.orig/Documentation/filesystems/proc.txt	2006-06-18 15:20:10.000000000 +1000
+++ linux-ck-dev/Documentation/filesystems/proc.txt	2006-06-18 15:25:25.000000000 +1000
@@ -1318,6 +1318,14 @@ To free pagecache, dentries and inodes:
 As this is a non-destructive operation and dirty objects are not freeable, the
 user should run `sync' first.
 
+tail_largefiles
+---------------
+
+When enabled reads from large files to the tail end of the inactive lru list.
+This means that any cache from reading large files is dropped very quickly,
+preventing loss of mapped ram and useful pagecache when large files are read.
+This does, however, make caching less effective when working with large files.
+
 
 2.5 /proc/sys/dev - Device specific parameters
 ----------------------------------------------
Index: linux-ck-dev/Documentation/sysctl/vm.txt
===================================================================
--- linux-ck-dev.orig/Documentation/sysctl/vm.txt	2006-06-18 15:24:58.000000000 +1000
+++ linux-ck-dev/Documentation/sysctl/vm.txt	2006-06-18 15:25:25.000000000 +1000
@@ -37,7 +37,7 @@ Currently, these files are in /proc/sys/
 
 dirty_ratio, dirty_background_ratio, dirty_expire_centisecs,
 dirty_writeback_centisecs, vfs_cache_pressure, laptop_mode,
-block_dump, swap_token_timeout, drop-caches:
+block_dump, swap_token_timeout, drop-caches, tail_largefiles:
 
 See Documentation/filesystems/proc.txt
 

-- 
-ck
