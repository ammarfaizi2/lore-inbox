Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266055AbUBGUjN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 15:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266048AbUBGUhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 15:37:54 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:61117 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S266018AbUBGUhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 15:37:41 -0500
From: Michael Frank <mhf@linuxmail.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] 2.6.2: Shutdown kernel on zone-alignment failure
Date: Sun, 8 Feb 2004 04:36:14 +0800
User-Agent: KMail/1.5.4
References: <200402080430.52947.mhf@linuxmail.org>
In-Reply-To: <200402080430.52947.mhf@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402080436.14366.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The last msg repeated the alignment patch. Here is it.

diff -uN -r -X /home/mhf/sys/dont/dontdiff linux-2.6.2-Vanilla/include/linux/kernel.h linux-2.6.2-mhf177/include/linux/kernel.h
--- linux-2.6.2-Vanilla/include/linux/kernel.h	2004-02-06 19:37:44.000000000 +0800
+++ linux-2.6.2-mhf177/include/linux/kernel.h	2004-02-08 02:12:17.000000000 +0800
@@ -104,6 +104,15 @@
 
 extern void bust_spinlocks(int yes);
 extern int oops_in_progress;		/* If set, an oops, panic(), BUG() or die() is in progress */
+
+/* If force_bug set, a BUG() will be forced when bug handler/console initialized.
+ * This is useful when something fatal happens very early during kernel init.
+ * To use:
+ *   printk("FATAL ERROR: my error message - will force kernel BUG\n");
+ *   force_bug = 1;
+ */
+extern int force_bug;
+
 extern int panic_on_oops;
 extern int system_running;
 extern int tainted;
diff -uN -r -X /home/mhf/sys/dont/dontdiff linux-2.6.2-Vanilla/init/main.c linux-2.6.2-mhf177/init/main.c
--- linux-2.6.2-Vanilla/init/main.c	2004-02-06 19:37:45.000000000 +0800
+++ linux-2.6.2-mhf177/init/main.c	2004-02-08 02:19:15.000000000 +0800
@@ -96,6 +96,7 @@
  * set up)
  */
 int system_running;
+int force_bug;
 
 /*
  * Boot command-line arguments
@@ -454,6 +455,13 @@
 	vfs_caches_init(num_physpages);
 	radix_tree_init();
 	signals_init();
+	/*
+	 * Something went badly wrong during the early initialisation process,
+	 * so lets die before doing any damage or wasting people's time 
+	 * running a half dead kernel.
+	 */
+	if (force_bug)
+		BUG();
 	/* rootfs populating might need page-writeback */
 	page_writeback_init();
 	populate_rootfs();
diff -uN -r -X /home/mhf/sys/dont/dontdiff linux-2.6.2-Vanilla/mm/page_alloc.c linux-2.6.2-mhf177/mm/page_alloc.c
--- linux-2.6.2-Vanilla/mm/page_alloc.c	2004-02-06 19:37:45.000000000 +0800
+++ linux-2.6.2-mhf177/mm/page_alloc.c	2004-02-08 04:14:06.000000000 +0800
@@ -1179,7 +1179,9 @@
 		for (i = 0; i < MAX_NR_ZONES; i++)
 			realtotalpages -= zholes_size[i];
 	pgdat->node_present_pages = realtotalpages;
-	printk("On node %d totalpages: %lu\n", pgdat->node_id, realtotalpages);
+	printk("On node %d totalpages: %lu, zones aligned at: 0x%lx\n",
+	       pgdat->node_id, realtotalpages,
+	       1UL << (MAX_ORDER-1 + PAGE_SHIFT));
 }
 
 /*
@@ -1240,14 +1242,14 @@
 		unsigned long *zones_size, unsigned long *zholes_size)
 {
 	unsigned long i, j;
-	const unsigned long zone_required_alignment = 1UL << (MAX_ORDER-1);
 	int cpu, nid = pgdat->node_id;
 	struct page *lmem_map = pgdat->node_mem_map;
 	unsigned long zone_start_pfn = pgdat->node_start_pfn;
+	unsigned long zone_bad_alignment;
 
 	pgdat->nr_zones = 0;
 	init_waitqueue_head(&pgdat->kswapd_wait);
-	
+
 	for (j = 0; j < MAX_NR_ZONES; j++) {
 		struct zone *zone = pgdat->node_zones + j;
 		unsigned long size, realsize;
@@ -1299,8 +1301,11 @@
 			pcp->batch = 1 * batch;
 			INIT_LIST_HEAD(&pcp->list);
 		}
-		printk("  %s zone: %lu pages, LIFO batch:%lu\n",
-				zone_names[j], realsize, batch);
+		if (realsize)
+			printk("  %s zone: %lu pages, LIFO batch:%lu, "
+			       "physical start address at: 0x%lx\n",
+			       zone_names[j], realsize, batch,
+			       zone_start_pfn << PAGE_SHIFT);
 		INIT_LIST_HEAD(&zone->active_list);
 		INIT_LIST_HEAD(&zone->inactive_list);
 		atomic_set(&zone->refill_counter, 0);
@@ -1328,8 +1333,17 @@
 		zone->zone_mem_map = lmem_map;
 		zone->zone_start_pfn = zone_start_pfn;
 
-		if ((zone_start_pfn) & (zone_required_alignment-1))
-			printk("BUG: wrong zone alignment, it will crash\n");
+		/*
+		 * Here the alignment of a zone is checked. Should alignment
+		 * be wrong, all that can be done is to print an error message
+		 * and defer the the BUG handler as it is not yet initialized.
+		 */
+		if ((zone_bad_alignment = zone_start_pfn & ((1UL << (MAX_ORDER-1))-1))) {
+			printk("  %s zone: FATAL ERROR invalid zone alignment at: 0x%lx"
+			       " - will force kernel BUG\n",
+			       zone_names[j],zone_bad_alignment << PAGE_SHIFT);
+			force_bug = 1;
+		}
 
 		memmap_init(lmem_map, size, nid, j, zone_start_pfn);
 

