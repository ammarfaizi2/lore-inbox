Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318523AbSGSOnU>; Fri, 19 Jul 2002 10:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318526AbSGSOnU>; Fri, 19 Jul 2002 10:43:20 -0400
Received: from holomorphy.com ([66.224.33.161]:27791 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318523AbSGSOnR>;
	Fri, 19 Jul 2002 10:43:17 -0400
Date: Fri, 19 Jul 2002 07:46:17 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: kernel-janitor-discuss@lists.sourceforge.net
Subject: clean up show_free_areas()
Message-ID: <20020719144617.GG1022@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org,
	kernel-janitor-discuss@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

show_free_areas() and show_free_areas_core() is a mess.
(1) it uses a bizarre and ugly form of list iteration to walk buddy lists
	use standard list functions instead
(2) it prints the same information repeatedly once per-node
	rationalize the braindamaged iteration logic
(3) show_free_areas_node() is useless and not called anywhere
	remove it entirely
(4) show_free_areas() itself just calls show_free_areas_core()
	remove show_free_areas_core() and do the stuff directly
(5) SWAP_CACHE_INFO is always #defined, remove it
(6) INC_CACHE_INFO() doesn't use the do { } while (0) construct

$ diffstat ../00_show_free_areas_core-4 
 include/linux/mm.h   |    1 
 include/linux/swap.h |    3 --
 mm/numa.c            |    9 ------
 mm/page_alloc.c      |   73 ++++++++++++++++++++-------------------------------
 mm/swap_state.c      |    6 ----
 5 files changed, 31 insertions(+), 61 deletions(-)


===== include/linux/mm.h 1.56 vs edited =====
--- 1.56/include/linux/mm.h	Thu Jul  4 09:17:35 2002
+++ edited/include/linux/mm.h	Fri Jul 19 09:25:30 2002
@@ -319,7 +319,6 @@
 extern struct page *mem_map;
 
 extern void show_free_areas(void);
-extern void show_free_areas_node(pg_data_t *pgdat);
 
 extern int fail_writepage(struct page *);
 struct page * shmem_nopage(struct vm_area_struct * vma, unsigned long address, int unused);
===== include/linux/swap.h 1.47 vs edited =====
--- 1.47/include/linux/swap.h	Sun Jun 16 15:50:18 2002
+++ edited/include/linux/swap.h	Fri Jul 19 09:54:41 2002
@@ -163,10 +163,7 @@
 /* linux/mm/page_alloc.c */
 
 /* linux/mm/swap_state.c */
-#define SWAP_CACHE_INFO
-#ifdef SWAP_CACHE_INFO
 extern void show_swap_cache_info(void);
-#endif
 extern int add_to_swap_cache(struct page *, swp_entry_t);
 extern void __delete_from_swap_cache(struct page *page);
 extern void delete_from_swap_cache(struct page *page);
===== mm/numa.c 1.5 vs edited =====
--- 1.5/mm/numa.c	Sat May 25 16:25:47 2002
+++ edited/mm/numa.c	Fri Jul 19 09:25:19 2002
@@ -46,15 +46,6 @@
 
 static spinlock_t node_lock = SPIN_LOCK_UNLOCKED;
 
-void show_free_areas_node(pg_data_t *pgdat)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&node_lock, flags);
-	show_free_areas_core(pgdat);
-	spin_unlock_irqrestore(&node_lock, flags);
-}
-
 /*
  * Nodes can be initialized parallely, in no particular order.
  */
===== mm/page_alloc.c 1.78 vs edited =====
--- 1.78/mm/page_alloc.c	Thu Jul  4 09:17:33 2002
+++ edited/mm/page_alloc.c	Fri Jul 19 09:55:35 2002
@@ -596,12 +596,11 @@
  * We also calculate the percentage fragmentation. We do this by counting the
  * memory on each free list with the exception of the first item on the list.
  */
-void show_free_areas_core(pg_data_t *pgdat)
+void show_free_areas(void)
 {
- 	unsigned int order;
-	unsigned type;
-	pg_data_t *tmpdat = pgdat;
+	pg_data_t *pgdat;
 	struct page_state ps;
+	int type;
 
 	get_page_state(&ps);
 
@@ -609,20 +608,20 @@
 		K(nr_free_pages()),
 		K(nr_free_highpages()));
 
-	while (tmpdat) {
-		zone_t *zone;
-		for (zone = tmpdat->node_zones;
-			       	zone < tmpdat->node_zones + MAX_NR_ZONES; zone++)
-			printk("Zone:%s freepages:%6lukB min:%6lukB low:%6lukB " 
-				       "high:%6lukB\n", 
-					zone->name,
-					K(zone->free_pages),
-					K(zone->pages_min),
-					K(zone->pages_low),
-					K(zone->pages_high));
-			
-		tmpdat = tmpdat->node_next;
-	}
+	for (pgdat = pgdat_list; pgdat; pgdat = pgdat->node_next)
+		for (type = 0; type < MAX_NR_ZONES; ++type) {
+			zone_t *zone = &pgdat->node_zones[type];
+			printk("Zone:%s "
+				"freepages:%6lukB "
+				"min:%6lukB "
+				"low:%6lukB " 
+				"high:%6lukB\n", 
+				zone->name,
+				K(zone->free_pages),
+				K(zone->pages_min),
+				K(zone->pages_low),
+				K(zone->pages_high));
+		}
 
 	printk("( Active:%lu inactive:%lu dirty:%lu writeback:%lu free:%u )\n",
 		ps.nr_active,
@@ -631,40 +630,28 @@
 		ps.nr_writeback,
 		nr_free_pages());
 
-	for (type = 0; type < MAX_NR_ZONES; type++) {
-		struct list_head *head, *curr;
-		zone_t *zone = pgdat->node_zones + type;
- 		unsigned long nr, total, flags;
+	for (pgdat = pgdat_list; pgdat; pgdat = pgdat->node_next)
+		for (type = 0; type < MAX_NR_ZONES; type++) {
+			list_t *elem;
+			zone_t *zone = &pgdat->node_zones[type];
+ 			unsigned long nr, flags, order, total = 0;
+
+			if (!zone->size)
+				continue;
 
-		total = 0;
-		if (zone->size) {
 			spin_lock_irqsave(&zone->lock, flags);
-		 	for (order = 0; order < MAX_ORDER; order++) {
-				head = &(zone->free_area + order)->free_list;
-				curr = head;
+			for (order = 0; order < MAX_ORDER; order++) {
 				nr = 0;
-				for (;;) {
-					curr = curr->next;
-					if (curr == head)
-						break;
-					nr++;
-				}
-				total += nr * (1 << order);
+				list_for_each(elem, &zone->free_area[order].free_list)
+					++nr;
+				total += nr << order;
 				printk("%lu*%lukB ", nr, K(1UL) << order);
 			}
 			spin_unlock_irqrestore(&zone->lock, flags);
+			printk("= %lukB)\n", K(total));
 		}
-		printk("= %lukB)\n", K(total));
-	}
 
-#ifdef SWAP_CACHE_INFO
 	show_swap_cache_info();
-#endif	
-}
-
-void show_free_areas(void)
-{
-	show_free_areas_core(pgdat_list);
 }
 
 /*
===== mm/swap_state.c 1.33 vs edited =====
--- 1.33/mm/swap_state.c	Thu Jul  4 09:17:26 2002
+++ edited/mm/swap_state.c	Fri Jul 19 09:58:00 2002
@@ -42,8 +42,7 @@
 	private_list:	LIST_HEAD_INIT(swapper_space.private_list),
 };
 
-#ifdef SWAP_CACHE_INFO
-#define INC_CACHE_INFO(x)	(swap_cache_info.x++)
+#define INC_CACHE_INFO(x)	do { swap_cache_info.x++; } while (0)
 
 static struct {
 	unsigned long add_total;
@@ -61,9 +60,6 @@
 		swap_cache_info.find_success, swap_cache_info.find_total,
 		swap_cache_info.noent_race, swap_cache_info.exist_race);
 }
-#else
-#define INC_CACHE_INFO(x)	do { } while (0)
-#endif
 
 int add_to_swap_cache(struct page *page, swp_entry_t entry)
 {
