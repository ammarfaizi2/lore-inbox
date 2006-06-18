Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbWFRHjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWFRHjK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 03:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbWFRHeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 03:34:07 -0400
Received: from mail08.syd.optusnet.com.au ([211.29.132.189]:43429 "EHLO
	mail08.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932154AbWFRHeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 03:34:04 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux list <linux-kernel@vger.kernel.org>
Subject: [ckpatch][19/29] mm-convert_swappiness_to_mapped.patch
Date: Sun, 18 Jun 2006 17:34:02 +1000
User-Agent: KMail/1.9.3
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 8535
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200606181734.02267.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Turn the "swappiness" knob into one with well defined semantics. Rename it
"mapped" to correspond directly with the percentage of mapped ram or
"applications" as users think of it. Currently the swappiness algorithm can
easily lead to swapping situations on simple file copies due to the distress
algorithm which too easily overrides the swappiness value. Add a
"hardmaplimit" tunable, on by default, which only allows the vm to override
the "mapped" tunable when distress is at its greatest to prevent false
out-of-memory situations.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

 Documentation/sysctl/vm.txt |   23 +++++++++++++++++++++++
 include/linux/swap.h        |    3 ++-
 include/linux/sysctl.h      |    3 ++-
 kernel/sysctl.c             |   16 ++++++++++++----
 mm/vmscan.c                 |   29 +++++++++++++++++------------
 5 files changed, 56 insertions(+), 18 deletions(-)

Index: linux-ck-dev/include/linux/swap.h
===================================================================
--- linux-ck-dev.orig/include/linux/swap.h	2006-06-18 15:24:48.000000000 +1000
+++ linux-ck-dev/include/linux/swap.h	2006-06-18 15:24:58.000000000 +1000
@@ -176,7 +176,8 @@ extern void swap_setup(void);
 /* linux/mm/vmscan.c */
 extern unsigned long try_to_free_pages(struct zone **, gfp_t);
 extern unsigned long shrink_all_memory(unsigned long nr_pages);
-extern int vm_swappiness;
+extern int vm_mapped;
+extern int vm_hardmaplimit;
 extern int remove_mapping(struct address_space *mapping, struct page *page);
 
 /* possible outcome of pageout() */
Index: linux-ck-dev/include/linux/sysctl.h
===================================================================
--- linux-ck-dev.orig/include/linux/sysctl.h	2006-06-18 15:24:48.000000000 +1000
+++ linux-ck-dev/include/linux/sysctl.h	2006-06-18 15:24:58.000000000 +1000
@@ -175,7 +175,7 @@ enum
 	VM_OVERCOMMIT_RATIO=16, /* percent of RAM to allow overcommit in */
 	VM_PAGEBUF=17,		/* struct: Control pagebuf parameters */
 	VM_HUGETLB_PAGES=18,	/* int: Number of available Huge Pages */
-	VM_SWAPPINESS=19,	/* Tendency to steal mapped memory */
+	VM_MAPPED=19,		/* percent mapped min while evicting cache */
 	VM_LOWMEM_RESERVE_RATIO=20,/* reservation ratio for lower memory zones */
 	VM_MIN_FREE_KBYTES=21,	/* Minimum free kilobytes to maintain */
 	VM_MAX_MAP_COUNT=22,	/* int: Maximum number of mmaps/address-space */
@@ -190,6 +190,7 @@ enum
 	VM_ZONE_RECLAIM_MODE=31, /* reclaim local zone memory before going off node */
 	VM_ZONE_RECLAIM_INTERVAL=32, /* time period to wait after reclaim failure */
 	VM_SWAP_PREFETCH=33,	/* swap prefetch */
+	VM_HARDMAPLIMIT=34,	/* Make mapped a hard limit */
 };
 
 
Index: linux-ck-dev/kernel/sysctl.c
===================================================================
--- linux-ck-dev.orig/kernel/sysctl.c	2006-06-18 15:24:48.000000000 +1000
+++ linux-ck-dev/kernel/sysctl.c	2006-06-18 15:24:58.000000000 +1000
@@ -791,16 +791,24 @@ static ctl_table vm_table[] = {
 		.proc_handler	= &proc_dointvec,
 	},
 	{
-		.ctl_name	= VM_SWAPPINESS,
-		.procname	= "swappiness",
-		.data		= &vm_swappiness,
-		.maxlen		= sizeof(vm_swappiness),
+		.ctl_name	= VM_MAPPED,
+		.procname	= "mapped",
+		.data		= &vm_mapped,
+		.maxlen		= sizeof(vm_mapped),
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec_minmax,
 		.strategy	= &sysctl_intvec,
 		.extra1		= &zero,
 		.extra2		= &one_hundred,
 	},
+	{
+		.ctl_name	= VM_HARDMAPLIMIT,
+		.procname	= "hardmaplimit",
+		.data		= &vm_hardmaplimit,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
 #ifdef CONFIG_HUGETLB_PAGE
 	 {
 		.ctl_name	= VM_HUGETLB_PAGES,
Index: linux-ck-dev/mm/vmscan.c
===================================================================
--- linux-ck-dev.orig/mm/vmscan.c	2006-06-18 15:24:52.000000000 +1000
+++ linux-ck-dev/mm/vmscan.c	2006-06-18 15:24:58.000000000 +1000
@@ -63,7 +63,7 @@ struct scan_control {
 	 * whole list at once. */
 	int swap_cluster_max;
 
-	int swappiness;
+	int mapped;
 };
 
 /*
@@ -108,10 +108,11 @@ struct shrinker {
 #endif
 
 /*
- * From 0 .. 100.  Higher means more swappy.
+ * From 0 .. 100.  Lower means more swappy.
  */
-int vm_swappiness = 60;
-static long total_memory;
+int vm_mapped __read_mostly = 66;
+int vm_hardmaplimit __read_mostly = 1;
+static long total_memory __read_mostly;
 
 static LIST_HEAD(shrinker_list);
 static DECLARE_RWSEM(shrinker_rwsem);
@@ -742,10 +743,14 @@ static void shrink_active_list(unsigned 
 		 * The distress ratio is important - we don't want to start
 		 * going oom.
 		 *
-		 * A 100% value of vm_swappiness overrides this algorithm
-		 * altogether.
+		 * This distress value is ignored if we apply a hardmaplimit except
+		 * in extreme distress.
+		 *
+		 * A 0% value of vm_mapped overrides this algorithm altogether.
 		 */
-		swap_tendency = mapped_ratio / 2 + distress + sc->swappiness;
+		swap_tendency = mapped_ratio * 100 / (sc->mapped + 1);
+		if (!vm_hardmaplimit || distress == 100)
+			swap_tendency += distress;
 
 		/*
 		 * Now use this metric to decide whether to start moving mapped
@@ -961,7 +966,7 @@ unsigned long try_to_free_pages(struct z
 		.may_writepage = !laptop_mode,
 		.swap_cluster_max = SWAP_CLUSTER_MAX,
 		.may_swap = 1,
-		.swappiness = vm_swappiness,
+		.mapped = vm_mapped,
 	};
 
 	delay_swap_prefetch();
@@ -1057,7 +1062,7 @@ static unsigned long balance_pgdat(pg_da
 		.gfp_mask = GFP_KERNEL,
 		.may_swap = 1,
 		.swap_cluster_max = SWAP_CLUSTER_MAX,
-		.swappiness = vm_swappiness,
+		.mapped = vm_mapped,
 	};
 
 loop_again:
@@ -1346,7 +1351,7 @@ unsigned long shrink_all_memory(unsigned
 		.may_swap = 0,
 		.swap_cluster_max = nr_pages,
 		.may_writepage = 1,
-		.swappiness = vm_swappiness,
+		.mapped = vm_mapped,
 	};
 
 	current->reclaim_state = &reclaim_state;
@@ -1391,7 +1396,7 @@ unsigned long shrink_all_memory(unsigned
 		/* Force reclaiming mapped pages in the passes #3 and #4 */
 		if (pass > 2) {
 			sc.may_swap = 1;
-			sc.swappiness = 100;
+			sc.mapped = 0;
 		}
 
 		for (prio = DEF_PRIORITY; prio >= 0; prio--) {
@@ -1528,7 +1533,7 @@ static int __zone_reclaim(struct zone *z
 		.swap_cluster_max = max_t(unsigned long, nr_pages,
 					SWAP_CLUSTER_MAX),
 		.gfp_mask = gfp_mask,
-		.swappiness = vm_swappiness,
+		.mapped = vm_mapped,
 	};
 
 	disable_swap_token();
Index: linux-ck-dev/Documentation/sysctl/vm.txt
===================================================================
--- linux-ck-dev.orig/Documentation/sysctl/vm.txt	2006-06-18 15:24:48.000000000 +1000
+++ linux-ck-dev/Documentation/sysctl/vm.txt	2006-06-18 15:24:58.000000000 +1000
@@ -22,6 +22,8 @@ Currently, these files are in /proc/sys/
 - dirty_background_ratio
 - dirty_expire_centisecs
 - dirty_writeback_centisecs
+- hardmaplimit
+- mapped
 - max_map_count
 - min_free_kbytes
 - laptop_mode
@@ -85,6 +87,27 @@ for swap because we only cluster swap da
 
 ==============================================================
 
+hardmaplimit:
+
+This flag makes the vm adhere to the mapped value as closely as possible
+except in the most extreme vm stress where doing so would provoke an out
+of memory condition (see mapped below).
+
+Enabled by default.
+
+==============================================================
+
+mapped:
+
+This is the percentage ram that is filled with mapped pages (applications)
+before the vm will start reclaiming mapped pages by moving them to swap.
+It is altered by the relative stress of the vm at the time so is not
+strictly adhered to to prevent provoking out of memory kills.
+
+Set to 66 by default.
+
+==============================================================
+
 max_map_count:
 
 This file contains the maximum number of memory map areas a process

-- 
-ck
