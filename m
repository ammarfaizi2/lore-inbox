Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319825AbSIMXXD>; Fri, 13 Sep 2002 19:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319826AbSIMXXD>; Fri, 13 Sep 2002 19:23:03 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:43182 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319825AbSIMXW4>;
	Fri, 13 Sep 2002 19:22:56 -0400
Message-ID: <3D8273AD.4000302@us.ibm.com>
Date: Fri, 13 Sep 2002 16:24:29 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Andrew Morton <akpm@digeo.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] per-zone^Wnode kswapd process
References: <20020913045938.GG2179@holomorphy.com> <617478427.1031868636@[10.10.2.3]> <3D8232DE.9090000@us.ibm.com> <3D823702.8E29AB4F@digeo.com> <3D8251D6.3060704@us.ibm.com> <3D82566B.EB2939D5@digeo.com> <3D826C25.5050609@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------050003030208000906010009"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050003030208000906010009
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Dave Hansen wrote:
> Here's a per-node kswapd.  It's actually per-pg_data_t, but I guess that 
> they're equivalent.  Matt is going to follow up his topology API with 
> something to bind these to their respective nodes.
Yep..  Here it is... rolled together with dave's patch..  It is only a 2 
line addition.  It applies cleanly on top of mm3 and topology (which 
I'll be resending momentarily).

Cheers!

-Matt

--------------050003030208000906010009
Content-Type: text/plain;
 name="per_node_kswapd.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="per_node_kswapd.patch"

diff -Nur linux-2.5.34-mm3+topo/include/linux/mmzone.h linux-2.5.34-mm3+topo+kswapd/include/linux/mmzone.h
--- linux-2.5.34-mm3+topo/include/linux/mmzone.h	Fri Sep 13 14:59:21 2002
+++ linux-2.5.34-mm3+topo+kswapd/include/linux/mmzone.h	Fri Sep 13 16:06:50 2002
@@ -168,6 +168,7 @@
 	unsigned long node_size;
 	int node_id;
 	struct pglist_data *pgdat_next;
+	wait_queue_head_t       kswapd_wait;
 } pg_data_t;
 
 extern int numnodes;
diff -Nur linux-2.5.34-mm3+topo/include/linux/swap.h linux-2.5.34-mm3+topo+kswapd/include/linux/swap.h
--- linux-2.5.34-mm3+topo/include/linux/swap.h	Mon Sep  9 10:35:01 2002
+++ linux-2.5.34-mm3+topo+kswapd/include/linux/swap.h	Fri Sep 13 16:06:50 2002
@@ -162,7 +162,6 @@
 extern void swap_setup(void);
 
 /* linux/mm/vmscan.c */
-extern wait_queue_head_t kswapd_wait;
 extern int try_to_free_pages(struct zone *, unsigned int, unsigned int);
 
 /* linux/mm/page_io.c */
diff -Nur linux-2.5.34-mm3+topo/mm/page_alloc.c linux-2.5.34-mm3+topo+kswapd/mm/page_alloc.c
--- linux-2.5.34-mm3+topo/mm/page_alloc.c	Fri Sep 13 14:58:05 2002
+++ linux-2.5.34-mm3+topo+kswapd/mm/page_alloc.c	Fri Sep 13 16:06:50 2002
@@ -346,8 +346,12 @@
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
@@ -845,6 +849,8 @@
 	unsigned long zone_start_pfn = pgdat->node_start_pfn;
 
 	pgdat->nr_zones = 0;
+	init_waitqueue_head(&pgdat->kswapd_wait);
+	
 	local_offset = 0;                /* offset within lmem_map */
 	for (j = 0; j < MAX_NR_ZONES; j++) {
 		struct zone *zone = pgdat->node_zones + j;
diff -Nur linux-2.5.34-mm3+topo/mm/vmscan.c linux-2.5.34-mm3+topo+kswapd/mm/vmscan.c
--- linux-2.5.34-mm3+topo/mm/vmscan.c	Fri Sep 13 14:58:05 2002
+++ linux-2.5.34-mm3+topo+kswapd/mm/vmscan.c	Fri Sep 13 16:11:26 2002
@@ -28,10 +28,11 @@
 #include <linux/pagevec.h>
 #include <linux/backing-dev.h>
 #include <linux/rmap-locking.h>
+#include <linux/swapops.h>
 
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
-#include <linux/swapops.h>
+#include <asm/topology.h>
 
 /*
  * The "priority" of VM scanning is how much of the queues we
@@ -713,8 +714,6 @@
 	return 0;
 }
 
-DECLARE_WAIT_QUEUE_HEAD(kswapd_wait);
-
 static int check_classzone_need_balance(struct zone *classzone)
 {
 	struct zone *first_classzone;
@@ -753,20 +752,6 @@
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
@@ -774,28 +759,13 @@
 
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
@@ -809,13 +779,16 @@
  * If there are applications that are active memory-allocators
  * (most normal use), this basically shouldn't matter.
  */
-int kswapd(void *unused)
+int kswapd(void *p)
 {
+	pg_data_t *pgdat = (pg_data_t*)p;
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
 
+	set_cpus_allowed(tsk, __node_to_cpu_mask(p->node_id));
+
 	daemonize();
-	strcpy(tsk->comm, "kswapd");
+	sprintf(tsk->comm, "kswapd%d", pgdat->node_id);
 	sigfillset(&tsk->blocked);
 	
 	/*
@@ -839,30 +812,34 @@
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
 

--------------050003030208000906010009--

