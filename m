Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311506AbSCTEAR>; Tue, 19 Mar 2002 23:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311501AbSCTD7W>; Tue, 19 Mar 2002 22:59:22 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:28686 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S311503AbSCTD65>; Tue, 19 Mar 2002 22:58:57 -0500
Message-ID: <3C9808A9.54A5D7AB@zip.com.au>
Date: Tue, 19 Mar 2002 19:57:29 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: aa-093-vm_tunables
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Introduces a bunch of knobs for tuning the VM.  They're described in
the patch.

They are not actually *used* in this patch.  The usage creeps in across
subsequent patches.

It's probable that the default icache shrinkage here is insufficiently
aggressive - Al says we should shrink inode_unused with extreme
prejudice - priority == 1.

It's possible that the default dcache shrinkage is too aggressive. 
We're shrinking the dcache by 1/6th for every 32 pages which are added
to the swapcache.  Restoring those dcache/icache entries will be much,
much more expensive than swapping in 32 pages.  So it's out of whack. 
I've left it as-is at present; choosing a suitable default for the
shrink_dcache_memory priority is on my immediate things-to-do list.


=====================================

--- 2.4.19-pre3/include/linux/swap.h~aa-093-vm_tunables	Tue Mar 19 19:48:54 2002
+++ 2.4.19-pre3-akpm/include/linux/swap.h	Tue Mar 19 19:49:15 2002
@@ -112,6 +112,7 @@ extern void swap_setup(void);
 /* linux/mm/vmscan.c */
 extern wait_queue_head_t kswapd_wait;
 extern int FASTCALL(try_to_free_pages(zone_t *, unsigned int, unsigned int));
+extern int vm_vfs_scan_ratio, vm_cache_scan_ratio, vm_lru_balance_ratio, vm_passes, vm_gfp_debug, vm_mapped_ratio;
 
 /* linux/mm/page_io.c */
 extern void rw_swap_page(int, struct page *);
--- 2.4.19-pre3/include/linux/sysctl.h~aa-093-vm_tunables	Tue Mar 19 19:48:54 2002
+++ 2.4.19-pre3-akpm/include/linux/sysctl.h	Tue Mar 19 19:48:54 2002
@@ -143,6 +143,12 @@ enum
 	VM_MAX_MAP_COUNT=11,	/* int: Maximum number of active map areas */
 	VM_MIN_READAHEAD=12,    /* Min file readahead */
 	VM_MAX_READAHEAD=13,    /* Max file readahead */
+	VM_VFS_SCAN_RATIO=14,	/* part of the inactive vfs lists to scan */
+	VM_LRU_BALANCE_RATIO=15,/* balance active and inactive caches */
+	VM_PASSES=16,		/* number of vm passes before failing */
+	VM_GFP_DEBUG=17,	/* debug GFP failures */
+	VM_CACHE_SCAN_RATIO=18,	/* part of the inactive cache list to scan */
+	VM_MAPPED_RATIO=19,	/* amount of unfreeable pages that triggers swapout */
 };
 
 
--- 2.4.19-pre3/kernel/sysctl.c~aa-093-vm_tunables	Tue Mar 19 19:48:54 2002
+++ 2.4.19-pre3-akpm/kernel/sysctl.c	Tue Mar 19 19:48:54 2002
@@ -30,6 +30,7 @@
 #include <linux/init.h>
 #include <linux/sysrq.h>
 #include <linux/highuid.h>
+#include <linux/swap.h>
 
 #include <asm/uaccess.h>
 
@@ -260,6 +261,18 @@ static ctl_table kern_table[] = {
 };
 
 static ctl_table vm_table[] = {
+	{VM_GFP_DEBUG, "vm_gfp_debug", 
+	 &vm_gfp_debug, sizeof(int), 0644, NULL, &proc_dointvec},
+	{VM_VFS_SCAN_RATIO, "vm_vfs_scan_ratio", 
+	 &vm_vfs_scan_ratio, sizeof(int), 0644, NULL, &proc_dointvec},
+	{VM_CACHE_SCAN_RATIO, "vm_cache_scan_ratio", 
+	 &vm_cache_scan_ratio, sizeof(int), 0644, NULL, &proc_dointvec},
+	{VM_MAPPED_RATIO, "vm_mapped_ratio", 
+	 &vm_mapped_ratio, sizeof(int), 0644, NULL, &proc_dointvec},
+	{VM_LRU_BALANCE_RATIO, "vm_lru_balance_ratio", 
+	 &vm_lru_balance_ratio, sizeof(int), 0644, NULL, &proc_dointvec},
+	{VM_PASSES, "vm_passes", 
+	 &vm_passes, sizeof(int), 0644, NULL, &proc_dointvec},
 	{VM_BDFLUSH, "bdflush", &bdf_prm, 9*sizeof(int), 0644, NULL,
 	 &proc_dointvec_minmax, &sysctl_intvec, NULL,
 	 &bdflush_min, &bdflush_max},
--- 2.4.19-pre3/mm/vmscan.c~aa-093-vm_tunables	Tue Mar 19 19:48:54 2002
+++ 2.4.19-pre3-akpm/mm/vmscan.c	Tue Mar 19 19:49:16 2002
@@ -25,12 +25,42 @@
 #include <asm/pgalloc.h>
 
 /*
- * The "priority" of VM scanning is how much of the queues we
- * will scan in one go. A value of 6 for DEF_PRIORITY implies
- * that we'll scan 1/64th of the queues ("queue_length >> 6")
- * during a normal aging round.
+ * "vm_passes" is the number of vm passes before failing the
+ * memory balancing. Take into account 3 passes are needed
+ * for a flush/wait/free cycle and that we only scan 1/vm_cache_scan_ratio
+ * of the inactive list at each pass.
  */
-#define DEF_PRIORITY (6)
+int vm_passes = 60;
+
+/*
+ * "vm_cache_scan_ratio" is how much of the inactive LRU queue we will scan
+ * in one go. A value of 6 for vm_cache_scan_ratio implies that we'll
+ * scan 1/6 of the inactive lists during a normal aging round.
+ */
+int vm_cache_scan_ratio = 6;
+
+/*
+ * "vm_mapped_ratio" controls the pageout rate, the smaller, the earlier
+ * we'll start to pageout.
+ */
+int vm_mapped_ratio = 100;
+
+/*
+ * "vm_lru_balance_ratio" controls the balance between active and
+ * inactive cache. The bigger vm_balance is, the easier the
+ * active cache will grow, because we'll rotate the active list
+ * slowly. A value of 2 means we'll go towards a balance of
+ * 1/3 of the cache being inactive.
+ */
+int vm_lru_balance_ratio = 2;
+
+/*
+ * "vm_vfs_scan_ratio" is what proportion of the VFS queues we will scan
+ * in one go. A value of 6 for vm_vfs_scan_ratio implies that 1/6th of
+ * the unused-inode, dentry and dquot caches will be freed during a normal
+ * aging round.
+ */
+int vm_vfs_scan_ratio = 6;
 
 /*
  * The swap-out function returns 1 if it successfully
@@ -579,7 +609,7 @@ static int shrink_caches(zone_t * classz
 	shrink_dcache_memory(priority, gfp_mask);
 	shrink_icache_memory(priority, gfp_mask);
 #ifdef CONFIG_QUOTA
-	shrink_dqcache_memory(DEF_PRIORITY, gfp_mask);
+	shrink_dqcache_memory(priority, gfp_mask);
 #endif
 
 	return nr_pages;
@@ -587,7 +617,7 @@ static int shrink_caches(zone_t * classz
 
 int try_to_free_pages(zone_t *classzone, unsigned int gfp_mask, unsigned int order)
 {
-	int priority = DEF_PRIORITY;
+	int priority = 6;
 	int nr_pages = SWAP_CLUSTER_MAX;
 
 	gfp_mask = pf_gfp_mask(gfp_mask);
--- 2.4.19-pre3/mm/page_alloc.c~aa-093-vm_tunables	Tue Mar 19 19:48:54 2002
+++ 2.4.19-pre3-akpm/mm/page_alloc.c	Tue Mar 19 19:49:15 2002
@@ -39,6 +39,8 @@ static int zone_balance_ratio[MAX_NR_ZON
 static int zone_balance_min[MAX_NR_ZONES] __initdata = { 20 , 20, 20, };
 static int zone_balance_max[MAX_NR_ZONES] __initdata = { 255 , 255, 255, };
 
+int vm_gfp_debug = 0;
+
 /*
  * Free_page() adds the page to the free lists. This is optimized for
  * fast normal cases (no error jumps taken normally).

-
