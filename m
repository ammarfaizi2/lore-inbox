Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319819AbSIMWsT>; Fri, 13 Sep 2002 18:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319822AbSIMWsT>; Fri, 13 Sep 2002 18:48:19 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:1217 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319819AbSIMWsQ>;
	Fri, 13 Sep 2002 18:48:16 -0400
Message-ID: <3D826C25.5050609@us.ibm.com>
Date: Fri, 13 Sep 2002 15:52:21 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: colpatch@us.ibm.com, "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] per-zone^Wnode kswapd process
References: <20020913045938.GG2179@holomorphy.com> <617478427.1031868636@[10.10.2.3]> <3D8232DE.9090000@us.ibm.com> <3D823702.8E29AB4F@digeo.com> <3D8251D6.3060704@us.ibm.com> <3D82566B.EB2939D5@digeo.com>
Content-Type: multipart/mixed;
 boundary="------------030700030600040800090406"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030700030600040800090406
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Here's a per-node kswapd.  It's actually per-pg_data_t, but I guess that they're 
equivalent.  Matt is going to follow up his topology API with something to bind 
these to their respective nodes.

-- 
Dave Hansen
haveblue@us.ibm.com

--------------030700030600040800090406
Content-Type: text/plain;
 name="per-node-kswapd-2.5.34-mm2-0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="per-node-kswapd-2.5.34-mm2-0.patch"

diff -ur linux-2.5.34-mm2-clean/include/linux/mmzone.h linux-2.5.34-mm2-per-node-kswapd/include/linux/mmzone.h
--- linux-2.5.34-mm2-clean/include/linux/mmzone.h	Fri Sep 13 14:32:02 2002
+++ linux-2.5.34-mm2-per-node-kswapd/include/linux/mmzone.h	Fri Sep 13 15:07:02 2002
@@ -168,6 +168,7 @@
 	unsigned long node_size;
 	int node_id;
 	struct pglist_data *pgdat_next;
+	wait_queue_head_t       kswapd_wait;
 } pg_data_t;
 
 extern int numnodes;
diff -ur linux-2.5.34-mm2-clean/include/linux/swap.h linux-2.5.34-mm2-per-node-kswapd/include/linux/swap.h
--- linux-2.5.34-mm2-clean/include/linux/swap.h	Fri Sep 13 14:32:02 2002
+++ linux-2.5.34-mm2-per-node-kswapd/include/linux/swap.h	Fri Sep 13 15:05:32 2002
@@ -162,7 +162,6 @@
 extern void swap_setup(void);
 
 /* linux/mm/vmscan.c */
-extern wait_queue_head_t kswapd_wait;
 extern int try_to_free_pages(struct zone *, unsigned int, unsigned int);
 
 /* linux/mm/page_io.c */
diff -ur linux-2.5.34-mm2-clean/mm/page_alloc.c linux-2.5.34-mm2-per-node-kswapd/mm/page_alloc.c
--- linux-2.5.34-mm2-clean/mm/page_alloc.c	Fri Sep 13 14:32:15 2002
+++ linux-2.5.34-mm2-per-node-kswapd/mm/page_alloc.c	Fri Sep 13 15:09:42 2002
@@ -345,8 +345,12 @@
 	classzone->need_balance = 1;
 	mb();
 	/* we're somewhat low on memory, failed to find what we needed */
-	if (waitqueue_active(&kswapd_wait))
-		wake_up_interruptible(&kswapd_wait);
+	for (i = 0; zones[i] != NULL; i++) {
+		struct zone *z = zones[i];
+		if (z->free_pages <= z->pages_low &&
+		    waitqueue_active(&z->zone_pgdat->kswapd_wait))
+			wake_up_interruptible(&z->zone_pgdat->kswapd_wait);
+	}
 
 	/* Go through the zonelist again, taking __GFP_HIGH into account */
 	min = 1UL << order;
@@ -833,6 +837,8 @@
 	unsigned long zone_start_pfn = pgdat->node_start_pfn;
 
 	pgdat->nr_zones = 0;
+	init_waitqueue_head(&pgdat->kswapd_wait);
+	
 	local_offset = 0;                /* offset within lmem_map */
 	for (j = 0; j < MAX_NR_ZONES; j++) {
 		struct zone *zone = pgdat->node_zones + j;
diff -ur linux-2.5.34-mm2-clean/mm/vmscan.c linux-2.5.34-mm2-per-node-kswapd/mm/vmscan.c
--- linux-2.5.34-mm2-clean/mm/vmscan.c	Fri Sep 13 14:32:15 2002
+++ linux-2.5.34-mm2-per-node-kswapd/mm/vmscan.c	Fri Sep 13 15:06:18 2002
@@ -713,8 +713,6 @@
 	return 0;
 }
 
-DECLARE_WAIT_QUEUE_HEAD(kswapd_wait);
-
 static int check_classzone_need_balance(struct zone *classzone)
 {
 	struct zone *first_classzone;
@@ -753,20 +751,6 @@
 	return need_more_balance;
 }
 
-static void kswapd_balance(void)
-{
-	int need_more_balance;
-	pg_data_t * pgdat;
-
-	do {
-		need_more_balance = 0;
-		pgdat = pgdat_list;
-		do
-			need_more_balance |= kswapd_balance_pgdat(pgdat);
-		while ((pgdat = pgdat->pgdat_next));
-	} while (need_more_balance);
-}
-
 static int kswapd_can_sleep_pgdat(pg_data_t * pgdat)
 {
 	struct zone *zone;
@@ -774,28 +758,13 @@
 
 	for (i = pgdat->nr_zones-1; i >= 0; i--) {
 		zone = pgdat->node_zones + i;
-		if (!zone->need_balance)
-			continue;
-		return 0;
+		if (zone->need_balance)
+			return 0;
 	}
 
 	return 1;
 }
 
-static int kswapd_can_sleep(void)
-{
-	pg_data_t * pgdat;
-
-	pgdat = pgdat_list;
-	do {
-		if (kswapd_can_sleep_pgdat(pgdat))
-			continue;
-		return 0;
-	} while ((pgdat = pgdat->pgdat_next));
-
-	return 1;
-}
-
 /*
  * The background pageout daemon, started as a kernel thread
  * from the init process. 
@@ -809,13 +778,14 @@
  * If there are applications that are active memory-allocators
  * (most normal use), this basically shouldn't matter.
  */
-int kswapd(void *unused)
+int kswapd(void *p)
 {
+	pg_data_t *pgdat = (pg_data_t*)p;
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
 
 	daemonize();
-	strcpy(tsk->comm, "kswapd");
+	sprintf(tsk->comm, "kswapd%d", pgdat->node_id);
 	sigfillset(&tsk->blocked);
 	
 	/*
@@ -839,30 +809,34 @@
 		if (current->flags & PF_FREEZE)
 			refrigerator(PF_IOTHREAD);
 		__set_current_state(TASK_INTERRUPTIBLE);
-		add_wait_queue(&kswapd_wait, &wait);
+		add_wait_queue(&pgdat->kswapd_wait, &wait);
 
 		mb();
-		if (kswapd_can_sleep())
+		if (kswapd_can_sleep_pgdat(pgdat))
 			schedule();
 
 		__set_current_state(TASK_RUNNING);
-		remove_wait_queue(&kswapd_wait, &wait);
+		remove_wait_queue(&pgdat->kswapd_wait, &wait);
 
 		/*
 		 * If we actually get into a low-memory situation,
 		 * the processes needing more memory will wake us
 		 * up on a more timely basis.
 		 */
-		kswapd_balance();
+		kswapd_balance_pgdat(pgdat);
 		blk_run_queues();
 	}
 }
 
 static int __init kswapd_init(void)
 {
+	pg_data_t *pgdat;
 	printk("Starting kswapd\n");
 	swap_setup();
-	kernel_thread(kswapd, NULL, CLONE_FS | CLONE_FILES | CLONE_SIGNAL);
+	for_each_pgdat(pgdat)
+		kernel_thread(kswapd, 
+			      pgdat, 
+			      CLONE_FS | CLONE_FILES | CLONE_SIGNAL);
 	return 0;
 }
 

--------------030700030600040800090406--

