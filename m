Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318227AbSIMDaB>; Thu, 12 Sep 2002 23:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319224AbSIMDaB>; Thu, 12 Sep 2002 23:30:01 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:41102 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318227AbSIMD35>;
	Thu, 12 Sep 2002 23:29:57 -0400
Message-ID: <3D815C8C.4050000@us.ibm.com>
Date: Thu, 12 Sep 2002 20:33:32 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] per-zone kswapd process
Content-Type: multipart/mixed;
 boundary="------------070205010205080502080900"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070205010205080502080900
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch implements a kswapd process for each memory zone.  The original code 
came from Bill Irwin, but the current VM is quite a bit different from the one 
that he wrote it for, so not much remains.  The current kswapd interface is much 
more simple than before because there is a single waitqueue and there is a 
single place where it is emptied.

kswapd_can_sleep() and kswapd_balance() are simpler now that the extra pgdat 
level of indirection is gone.

Tested on 8-way PIII with highmem off and then 4GB support.  With 4GB support, I 
did 20 parallel greps through a 10GB fileset while some other processes 
allocated and freed 1-2GB chunks of memory.  That gave kswapd a good workout, 
and I observed it running the zone Highmem and zone Normal kswapd threads.  So, 
it survives my torture test.  It also removes more code than it adds.

include/linux/mmzone.h |    2 +
include/linux/swap.h   |    1
mm/page_alloc.c        |   11 +++++-
mm/vmscan.c            |   88 +++++++++++++++++--------------------------------
4 files changed, 42 insertions(+), 60 deletions(-)

-- 
Dave Hansen
haveblue@us.ibm.com




--------------070205010205080502080900
Content-Type: text/plain;
 name="per-zone-kswapd-2.5.34-mm2-3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="per-zone-kswapd-2.5.34-mm2-3.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.625   -> 1.628  
#	include/linux/mmzone.h	1.19    -> 1.20   
#	include/linux/swap.h	1.57    -> 1.58   
#	     mm/page_alloc.c	1.98    -> 1.101  
#	         mm/vmscan.c	1.102   -> 1.105  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/12	haveblue@elm3b96.(none)	1.626
# add per-zone kswapd
# --------------------------------------------
# 02/09/12	haveblue@elm3b96.(none)	1.627
# fix some wli-indicated formatting bits
# --------------------------------------------
# 02/09/12	haveblue@elm3b96.(none)	1.628
# move waitqueue init to a more appropriate place 
# --------------------------------------------
#
diff -Nru a/include/linux/mmzone.h b/include/linux/mmzone.h
--- a/include/linux/mmzone.h	Thu Sep 12 20:24:39 2002
+++ b/include/linux/mmzone.h	Thu Sep 12 20:24:39 2002
@@ -108,6 +108,8 @@
 	unsigned long		wait_table_size;
 	unsigned long		wait_table_bits;
 
+	wait_queue_head_t       kswapd_wait;	
+	
 	/*
 	 * Discontig memory support fields.
 	 */
diff -Nru a/include/linux/swap.h b/include/linux/swap.h
--- a/include/linux/swap.h	Thu Sep 12 20:24:39 2002
+++ b/include/linux/swap.h	Thu Sep 12 20:24:39 2002
@@ -162,7 +162,6 @@
 extern void swap_setup(void);
 
 /* linux/mm/vmscan.c */
-extern wait_queue_head_t kswapd_wait;
 extern int try_to_free_pages(struct zone *, unsigned int, unsigned int);
 
 /* linux/mm/page_io.c */
diff -Nru a/mm/page_alloc.c b/mm/page_alloc.c
--- a/mm/page_alloc.c	Thu Sep 12 20:24:39 2002
+++ b/mm/page_alloc.c	Thu Sep 12 20:24:39 2002
@@ -345,8 +345,15 @@
 	classzone->need_balance = 1;
 	mb();
 	/* we're somewhat low on memory, failed to find what we needed */
-	if (waitqueue_active(&kswapd_wait))
-		wake_up_interruptible(&kswapd_wait);
+	for (i = 0; zones[i] != NULL; i++) {
+		struct zone *z = zones[i];
+
+		/* We don't want to go swapping on zones that aren't actually
+		 * low.  This accounts for "incremental min" from last loop */
+		if (z->free_pages <= z->pages_low &&
+		    waitqueue_active(&z->kswapd_wait)) 
+			wake_up_interruptible(&z->kswapd_wait);
+	}
 
 	/* Go through the zonelist again, taking __GFP_HIGH into account */
 	min = 1UL << order;
@@ -874,6 +881,8 @@
 		for(i = 0; i < zone->wait_table_size; ++i)
 			init_waitqueue_head(zone->wait_table + i);
 
+		init_waitqueue_head(&zone->kswapd_wait);
+		
 		pgdat->nr_zones = j+1;
 
 		mask = (realsize / zone_balance_ratio[j]);
diff -Nru a/mm/vmscan.c b/mm/vmscan.c
--- a/mm/vmscan.c	Thu Sep 12 20:24:39 2002
+++ b/mm/vmscan.c	Thu Sep 12 20:24:39 2002
@@ -713,8 +713,6 @@
 	return 0;
 }
 
-DECLARE_WAIT_QUEUE_HEAD(kswapd_wait);
-
 static int check_classzone_need_balance(struct zone *classzone)
 {
 	struct zone *first_classzone;
@@ -728,71 +726,33 @@
 	return 1;
 }
 
-static int kswapd_balance_pgdat(pg_data_t * pgdat)
+static int kswapd_balance_zone(struct zone *zone)
 {
-	int need_more_balance = 0, i;
-	struct zone *zone;
-
-	for (i = pgdat->nr_zones-1; i >= 0; i--) {
-		zone = pgdat->node_zones + i;
+	int need_more_balance = 0;
+	
+	do {
 		cond_resched();
 		if (!zone->need_balance)
-			continue;
+			break;
 		if (!try_to_free_pages(zone, GFP_KSWAPD, 0)) {
 			zone->need_balance = 0;
 			__set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(HZ);
-			continue;
+			break;
 		}
 		if (check_classzone_need_balance(zone))
 			need_more_balance = 1;
 		else
 			zone->need_balance = 0;
-	}
-
-	return need_more_balance;
-}
-
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
 	} while (need_more_balance);
-}
 
-static int kswapd_can_sleep_pgdat(pg_data_t * pgdat)
-{
-	struct zone *zone;
-	int i;
-
-	for (i = pgdat->nr_zones-1; i >= 0; i--) {
-		zone = pgdat->node_zones + i;
-		if (!zone->need_balance)
-			continue;
-		return 0;
-	}
-
-	return 1;
+	return 0;
 }
 
-static int kswapd_can_sleep(void)
+static int kswapd_can_sleep_zone(struct zone *zone)
 {
-	pg_data_t * pgdat;
-
-	pgdat = pgdat_list;
-	do {
-		if (kswapd_can_sleep_pgdat(pgdat))
-			continue;
-		return 0;
-	} while ((pgdat = pgdat->pgdat_next));
-
+	if (zone->need_balance)
+		return 0;	
 	return 1;
 }
 
@@ -809,13 +769,18 @@
  * If there are applications that are active memory-allocators
  * (most normal use), this basically shouldn't matter.
  */
-int kswapd(void *unused)
+int kswapd_zone(void *p)
 {
+	struct zone *zone = (struct zone *)p;
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
+	
+	printk( "kswapd%d starting for %s\n", 
+			zone - zone->zone_pgdat->node_zones, 
+			zone->name);
 
 	daemonize();
-	strcpy(tsk->comm, "kswapd");
+	sprintf(tsk->comm, "kswapd%d", zone - zone->zone_pgdat->node_zones);
 	sigfillset(&tsk->blocked);
 	
 	/*
@@ -839,30 +804,37 @@
 		if (current->flags & PF_FREEZE)
 			refrigerator(PF_IOTHREAD);
 		__set_current_state(TASK_INTERRUPTIBLE);
-		add_wait_queue(&kswapd_wait, &wait);
+		add_wait_queue(&zone->kswapd_wait, &wait);
 
 		mb();
-		if (kswapd_can_sleep())
+		if (kswapd_can_sleep_zone(zone))
 			schedule();
 
 		__set_current_state(TASK_RUNNING);
-		remove_wait_queue(&kswapd_wait, &wait);
+		remove_wait_queue(&zone->kswapd_wait, &wait);
 
 		/*
 		 * If we actually get into a low-memory situation,
 		 * the processes needing more memory will wake us
 		 * up on a more timely basis.
 		 */
-		kswapd_balance();
+		kswapd_balance_zone(zone);
 		blk_run_queues();
 	}
 }
 
 static int __init kswapd_init(void)
 {
+	struct zone* zone;
+
 	printk("Starting kswapd\n");
 	swap_setup();
-	kernel_thread(kswapd, NULL, CLONE_FS | CLONE_FILES | CLONE_SIGNAL);
+	for_each_zone(zone)
+		if (zone->size)
+			kernel_thread(kswapd_zone, 
+				      zone, 
+				      CLONE_FS | CLONE_FILES | CLONE_SIGNAL);
+	
 	return 0;
 }
 

--------------070205010205080502080900--

