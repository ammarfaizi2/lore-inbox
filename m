Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318919AbSG1HWY>; Sun, 28 Jul 2002 03:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318930AbSG1HWX>; Sun, 28 Jul 2002 03:22:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53253 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318919AbSG1HU7>;
	Sun, 28 Jul 2002 03:20:59 -0400
Message-ID: <3D439E1C.5B5BC34B@zip.com.au>
Date: Sun, 28 Jul 2002 00:32:44 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 4/13] show_free_areas() cleanup
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Cleanup to show_free_areas() from Bill Irwin:

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

This patch also includes Matthew Dobson's patch which removes
mm/numa.c:node_lock.  The consensus is that it doesn't do anything now
that show_free_areas_node() isn't there.



 include/linux/mm.h   |    1 
 include/linux/swap.h |    3 --
 mm/numa.c            |   16 +----------
 mm/page_alloc.c      |   73 ++++++++++++++++++++-------------------------------
 mm/swap_state.c      |    6 ----
 5 files changed, 33 insertions(+), 66 deletions(-)

--- 2.5.29/include/linux/mm.h~show_free_areas	Sat Jul 27 23:39:03 2002
+++ 2.5.29-akpm/include/linux/mm.h	Sat Jul 27 23:49:02 2002
@@ -327,7 +327,6 @@ static inline void set_page_zone(struct 
 extern struct page *mem_map;
 
 extern void show_free_areas(void);
-extern void show_free_areas_node(pg_data_t *pgdat);
 
 extern int fail_writepage(struct page *);
 struct page * shmem_nopage(struct vm_area_struct * vma, unsigned long address, int unused);
--- 2.5.29/include/linux/swap.h~show_free_areas	Sat Jul 27 23:39:03 2002
+++ 2.5.29-akpm/include/linux/swap.h	Sat Jul 27 23:39:03 2002
@@ -176,10 +176,7 @@ int rw_swap_page_sync(int rw, swp_entry_
 /* linux/mm/page_alloc.c */
 
 /* linux/mm/swap_state.c */
-#define SWAP_CACHE_INFO
-#ifdef SWAP_CACHE_INFO
 extern void show_swap_cache_info(void);
-#endif
 extern int add_to_swap_cache(struct page *, swp_entry_t);
 extern int add_to_swap(struct page *);
 extern void __delete_from_swap_cache(struct page *page);
--- 2.5.29/mm/numa.c~show_free_areas	Sat Jul 27 23:39:03 2002
+++ 2.5.29-akpm/mm/numa.c	Sat Jul 27 23:49:01 2002
@@ -44,17 +44,6 @@ struct page * alloc_pages_node(int nid, 
 
 #define LONG_ALIGN(x) (((x)+(sizeof(long))-1)&~((sizeof(long))-1))
 
-static spinlock_t node_lock = SPIN_LOCK_UNLOCKED;
-
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
@@ -106,11 +95,10 @@ struct page * _alloc_pages(unsigned int 
 #ifdef CONFIG_NUMA
 	temp = NODE_DATA(numa_node_id());
 #else
-	spin_lock_irqsave(&node_lock, flags);
-	if (!next) next = pgdat_list;
+	if (!next)
+		next = pgdat_list;
 	temp = next;
 	next = next->node_next;
-	spin_unlock_irqrestore(&node_lock, flags);
 #endif
 	start = temp;
 	while (temp) {
--- 2.5.29/mm/page_alloc.c~show_free_areas	Sat Jul 27 23:39:03 2002
+++ 2.5.29-akpm/mm/page_alloc.c	Sat Jul 27 23:49:01 2002
@@ -602,12 +602,11 @@ void si_meminfo(struct sysinfo *val)
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
 
@@ -615,20 +614,20 @@ void show_free_areas_core(pg_data_t *pgd
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
@@ -637,40 +636,28 @@ void show_free_areas_core(pg_data_t *pgd
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
--- 2.5.29/mm/swap_state.c~show_free_areas	Sat Jul 27 23:39:03 2002
+++ 2.5.29-akpm/mm/swap_state.c	Sat Jul 27 23:39:03 2002
@@ -42,8 +42,7 @@ struct address_space swapper_space = {
 	private_list:	LIST_HEAD_INIT(swapper_space.private_list),
 };
 
-#ifdef SWAP_CACHE_INFO
-#define INC_CACHE_INFO(x)	(swap_cache_info.x++)
+#define INC_CACHE_INFO(x)	do { swap_cache_info.x++; } while (0)
 
 static struct {
 	unsigned long add_total;
@@ -61,9 +60,6 @@ void show_swap_cache_info(void)
 		swap_cache_info.find_success, swap_cache_info.find_total,
 		swap_cache_info.noent_race, swap_cache_info.exist_race);
 }
-#else
-#define INC_CACHE_INFO(x)	do { } while (0)
-#endif
 
 int add_to_swap_cache(struct page *page, swp_entry_t entry)
 {

.
