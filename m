Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266196AbUIEFtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266196AbUIEFtV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 01:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266208AbUIEFtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 01:49:20 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:23704 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266196AbUIEFrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 01:47:53 -0400
Message-ID: <413AA879.9020105@yahoo.com.au>
Date: Sun, 05 Sep 2004 15:47:37 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
CC: Linux Memory Management <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH 3/3] teach kswapd about watermarks
References: <413AA7B2.4000907@yahoo.com.au> <413AA7F8.3050706@yahoo.com.au> <413AA841.1040003@yahoo.com.au>
In-Reply-To: <413AA841.1040003@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------060508070205010209070803"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060508070205010209070803
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

3/3

--------------060508070205010209070803
Content-Type: text/x-patch;
 name="vm-kswapd-heed-order-watermarks.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm-kswapd-heed-order-watermarks.patch"



Teach kswapd to free memory on behalf of higher order allocators. This could
be important for higher order atomic allocations because they otherwise have
no means to free the memory themselves.

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>


---

 linux-2.6-npiggin/include/linux/mmzone.h |    5 ++--
 linux-2.6-npiggin/mm/page_alloc.c        |    3 +-
 linux-2.6-npiggin/mm/vmscan.c            |   33 ++++++++++++++++++++++---------
 3 files changed, 29 insertions(+), 12 deletions(-)

diff -puN mm/vmscan.c~vm-kswapd-heed-order-watermarks mm/vmscan.c
--- linux-2.6/mm/vmscan.c~vm-kswapd-heed-order-watermarks	2004-09-05 15:12:04.000000000 +1000
+++ linux-2.6-npiggin/mm/vmscan.c	2004-09-05 15:12:04.000000000 +1000
@@ -985,7 +985,7 @@ out:
  * the page allocator fallback scheme to ensure that aging of pages is balanced
  * across the zones.
  */
-static int balance_pgdat(pg_data_t *pgdat, int nr_pages)
+static int balance_pgdat(pg_data_t *pgdat, int nr_pages, int order)
 {
 	int to_free = nr_pages;
 	int priority;
@@ -1023,7 +1023,8 @@ static int balance_pgdat(pg_data_t *pgda
 						priority != DEF_PRIORITY)
 					continue;
 
-				if (zone->free_pages <= zone->pages_high) {
+				if (!zone_watermark_ok(zone, order,
+						zone->pages_high, 0, 0, 0)) {
 					end_zone = i;
 					goto scan;
 				}
@@ -1055,7 +1056,8 @@ scan:
 				continue;
 
 			if (nr_pages == 0) {	/* Not software suspend */
-				if (zone->free_pages <= zone->pages_high)
+				if (!zone_watermark_ok(zone, order,
+						zone->pages_high, end_zone, 0, 0))
 					all_zones_ok = 0;
 			}
 			zone->temp_priority = priority;
@@ -1146,13 +1148,22 @@ int kswapd(void *p)
 	tsk->flags |= PF_MEMALLOC|PF_KSWAPD;
 
 	for ( ; ; ) {
+		unsigned long order = 0, new_order;
 		if (current->flags & PF_FREEZE)
 			refrigerator(PF_FREEZE);
+
 		prepare_to_wait(&pgdat->kswapd_wait, &wait, TASK_INTERRUPTIBLE);
-		schedule();
+		new_order = atomic_read(&pgdat->kswapd_max_order);
+		atomic_set(&pgdat->kswapd_max_order, 0);
+		if (order < new_order) {
+			order = new_order;
+		} else {
+			schedule();
+			order = atomic_read(&pgdat->kswapd_max_order);
+		}
 		finish_wait(&pgdat->kswapd_wait, &wait);
 
-		balance_pgdat(pgdat, 0);
+		balance_pgdat(pgdat, 0, order);
 	}
 	return 0;
 }
@@ -1160,12 +1171,16 @@ int kswapd(void *p)
 /*
  * A zone is low on free memory, so wake its kswapd task to service it.
  */
-void wakeup_kswapd(struct zone *zone)
+void wakeup_kswapd(struct zone *zone, int order)
 {
-	if (zone->free_pages > zone->pages_low)
-		return;
+	pg_data_t *pgdat = zone->zone_pgdat;
+
 	if (!cpuset_zone_allowed(zone))
 		return;
+
+	if (atomic_read(&pgdat->kswapd_max_order) < order)
+		return;
+	atomic_set(&pgdat->kswapd_max_order, order);
 	if (!waitqueue_active(&zone->zone_pgdat->kswapd_wait))
 		return;
 	wake_up_interruptible(&zone->zone_pgdat->kswapd_wait);
@@ -1188,7 +1203,7 @@ int shrink_all_memory(int nr_pages)
 	current->reclaim_state = &reclaim_state;
 	for_each_pgdat(pgdat) {
 		int freed;
-		freed = balance_pgdat(pgdat, nr_to_free);
+		freed = balance_pgdat(pgdat, nr_to_free, 0);
 		ret += freed;
 		nr_to_free -= freed;
 		if (nr_to_free <= 0)
diff -puN mm/page_alloc.c~vm-kswapd-heed-order-watermarks mm/page_alloc.c
--- linux-2.6/mm/page_alloc.c~vm-kswapd-heed-order-watermarks	2004-09-05 15:12:04.000000000 +1000
+++ linux-2.6-npiggin/mm/page_alloc.c	2004-09-05 15:12:04.000000000 +1000
@@ -775,7 +775,7 @@ __alloc_pages(unsigned int gfp_mask, uns
 	}
 
 	for (i = 0; (z = zones[i]) != NULL; i++)
-		wakeup_kswapd(z);
+		wakeup_kswapd(z, order);
 
 	/*
 	 * Go through the zonelist again. Let __GFP_HIGH and allocations
@@ -1613,6 +1613,7 @@ static void __init free_area_init_core(s
 
 	pgdat->nr_zones = 0;
 	init_waitqueue_head(&pgdat->kswapd_wait);
+	atomic_set(&pgdat->kswapd_max_order, 0);
 	
 	for (j = 0; j < MAX_NR_ZONES; j++) {
 		struct zone *zone = pgdat->node_zones + j;
diff -puN include/linux/mmzone.h~vm-kswapd-heed-order-watermarks include/linux/mmzone.h
--- linux-2.6/include/linux/mmzone.h~vm-kswapd-heed-order-watermarks	2004-09-05 15:12:04.000000000 +1000
+++ linux-2.6-npiggin/include/linux/mmzone.h	2004-09-05 15:12:04.000000000 +1000
@@ -263,8 +263,9 @@ typedef struct pglist_data {
 					     range, including holes */
 	int node_id;
 	struct pglist_data *pgdat_next;
-	wait_queue_head_t       kswapd_wait;
+	wait_queue_head_t kswapd_wait;
 	struct task_struct *kswapd;
+	atomic_t kswapd_max_order;
 } pg_data_t;
 
 #define node_present_pages(nid)	(NODE_DATA(nid)->node_present_pages)
@@ -278,7 +279,7 @@ void __get_zone_counts(unsigned long *ac
 void get_zone_counts(unsigned long *active, unsigned long *inactive,
 			unsigned long *free);
 void build_all_zonelists(void);
-void wakeup_kswapd(struct zone *zone);
+void wakeup_kswapd(struct zone *zone, int order);
 int zone_watermark_ok(struct zone *z, int order, unsigned long mark,
 		int alloc_type, int can_try_harder, int gfp_high);
 

_

--------------060508070205010209070803--
