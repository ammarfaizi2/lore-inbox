Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318118AbSHKHbe>; Sun, 11 Aug 2002 03:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317978AbSHKHaV>; Sun, 11 Aug 2002 03:30:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41478 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318118AbSHKH0R>;
	Sun, 11 Aug 2002 03:26:17 -0400
Message-ID: <3D5614CA.5DDF5576@zip.com.au>
Date: Sun, 11 Aug 2002 00:39:54 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 16/21] remove the zone_t and zonelist_t typedefs
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



- Remove the zonelist_t typedef.  Rename struct zonelist_struct to
  struct zonelist and use that everywhere.

- Remove the zone_t typedef.  Rename struct zone_struct to struct
  zone and use that everywhere.



 fs/buffer.c                |    2 -
 include/linux/dcache.h     |    2 -
 include/linux/gfp.h        |    2 -
 include/linux/mm.h         |    7 ++----
 include/linux/mmzone.h     |   25 ++++++++++++-----------
 include/linux/page-flags.h |    1 
 include/linux/swap.h       |    4 +--
 mm/filemap.c               |    2 -
 mm/page_alloc.c            |   48 +++++++++++++++++++++++----------------------
 mm/vmscan.c                |   20 ++++++++++--------
 10 files changed, 58 insertions(+), 55 deletions(-)

--- 2.5.31/fs/buffer.c~zone-rename	Sat Aug 10 23:45:33 2002
+++ 2.5.31-akpm/fs/buffer.c	Sat Aug 10 23:45:33 2002
@@ -469,7 +469,7 @@ void __invalidate_buffers(kdev_t dev, in
  */
 static void free_more_memory(void)
 {
-	zone_t *zone;
+	struct zone *zone;
 
 	zone = contig_page_data.node_zonelists[GFP_NOFS & GFP_ZONEMASK].zones[0];
 
--- 2.5.31/include/linux/dcache.h~zone-rename	Sat Aug 10 23:45:33 2002
+++ 2.5.31-akpm/include/linux/dcache.h	Sat Aug 10 23:45:33 2002
@@ -181,8 +181,6 @@ extern void shrink_dcache_parent(struct 
 extern void shrink_dcache_anon(struct list_head *);
 extern int d_invalidate(struct dentry *);
 
-#define shrink_dcache() prune_dcache(0)
-struct zone_struct;
 /* dcache memory management */
 extern int shrink_dcache_memory(int, unsigned int);
 extern void prune_dcache(int);
--- 2.5.31/include/linux/gfp.h~zone-rename	Sat Aug 10 23:45:33 2002
+++ 2.5.31-akpm/include/linux/gfp.h	Sat Aug 10 23:45:33 2002
@@ -40,7 +40,7 @@
  * virtual kernel addresses to the allocated page(s).
  */
 extern struct page * FASTCALL(_alloc_pages(unsigned int gfp_mask, unsigned int order));
-extern struct page * FASTCALL(__alloc_pages(unsigned int gfp_mask, unsigned int order, zonelist_t *zonelist));
+extern struct page * FASTCALL(__alloc_pages(unsigned int gfp_mask, unsigned int order, struct zonelist *zonelist));
 extern struct page * alloc_pages_node(int nid, unsigned int gfp_mask, unsigned int order);
 
 static inline struct page * alloc_pages(unsigned int gfp_mask, unsigned int order)
--- 2.5.31/include/linux/mm.h~zone-rename	Sat Aug 10 23:45:33 2002
+++ 2.5.31-akpm/include/linux/mm.h	Sat Aug 10 23:45:33 2002
@@ -267,10 +267,10 @@ extern void FASTCALL(__page_cache_releas
 #define NODE_SHIFT 4
 #define ZONE_SHIFT (BITS_PER_LONG - 8)
 
-struct zone_struct;
-extern struct zone_struct *zone_table[];
+struct zone;
+extern struct zone *zone_table[];
 
-static inline zone_t *page_zone(struct page *page)
+static inline struct zone *page_zone(struct page *page)
 {
 	return zone_table[page->flags >> ZONE_SHIFT];
 }
@@ -454,7 +454,6 @@ static inline int can_vma_merge(struct v
 		return 0;
 }
 
-struct zone_t;
 /* filemap.c */
 extern unsigned long page_unuse(struct page *);
 extern void truncate_inode_pages(struct address_space *, loff_t);
--- 2.5.31/include/linux/mmzone.h~zone-rename	Sat Aug 10 23:45:33 2002
+++ 2.5.31-akpm/include/linux/mmzone.h	Sat Aug 10 23:45:33 2002
@@ -34,7 +34,7 @@ struct pglist_data;
  * ZONE_NORMAL	16-896 MB	direct mapped by the kernel
  * ZONE_HIGHMEM	 > 896 MB	only page cache and user processes
  */
-typedef struct zone_struct {
+struct zone {
 	/*
 	 * Commonly accessed fields:
 	 */
@@ -89,7 +89,7 @@ typedef struct zone_struct {
 	 */
 	char			*name;
 	unsigned long		size;
-} zone_t;
+};
 
 #define ZONE_DMA		0
 #define ZONE_NORMAL		1
@@ -107,16 +107,16 @@ typedef struct zone_struct {
  * so despite the zonelist table being relatively big, the cache
  * footprint of this construct is very small.
  */
-typedef struct zonelist_struct {
-	zone_t * zones [MAX_NR_ZONES+1]; // NULL delimited
-} zonelist_t;
+struct zonelist {
+	struct zone *zones[MAX_NR_ZONES+1]; // NULL delimited
+};
 
 #define GFP_ZONEMASK	0x0f
 
 /*
  * The pg_data_t structure is used in machines with CONFIG_DISCONTIGMEM
  * (mostly NUMA machines?) to denote a higher-level memory zone than the
- * zone_struct denotes.
+ * zone denotes.
  *
  * On NUMA machines, each NUMA node would have a pg_data_t to describe
  * it's memory layout.
@@ -126,8 +126,8 @@ typedef struct zonelist_struct {
  */
 struct bootmem_data;
 typedef struct pglist_data {
-	zone_t node_zones[MAX_NR_ZONES];
-	zonelist_t node_zonelists[GFP_ZONEMASK+1];
+	struct zone node_zones[MAX_NR_ZONES];
+	struct zonelist node_zonelists[GFP_ZONEMASK+1];
 	int nr_zones;
 	struct page *node_mem_map;
 	unsigned long *valid_addr_bitmap;
@@ -142,7 +142,8 @@ typedef struct pglist_data {
 extern int numnodes;
 extern pg_data_t *pgdat_list;
 
-static inline int memclass(zone_t *pgzone, zone_t *classzone)
+static inline int
+memclass(struct zone *pgzone, struct zone *classzone)
 {
 	if (pgzone->zone_pgdat != classzone->zone_pgdat)
 		return 0;
@@ -181,7 +182,7 @@ extern pg_data_t contig_page_data;
  * next_zone - helper magic for for_each_zone()
  * Thanks to William Lee Irwin III for this piece of ingenuity.
  */
-static inline zone_t * next_zone(zone_t * zone)
+static inline struct zone *next_zone(struct zone *zone)
 {
 	pg_data_t *pgdat = zone->zone_pgdat;
 
@@ -198,7 +199,7 @@ static inline zone_t * next_zone(zone_t 
 
 /**
  * for_each_zone - helper macro to iterate over all memory zones
- * @zone - pointer to zone_t variable
+ * @zone - pointer to struct zone variable
  *
  * The user only needs to declare the zone variable, for_each_zone
  * fills it in. This basically means for_each_zone() is an
@@ -206,7 +207,7 @@ static inline zone_t * next_zone(zone_t 
  *
  * for (pgdat = pgdat_list; pgdat; pgdat = pgdat->node_next)
  * 	for (i = 0; i < MAX_NR_ZONES; ++i) {
- * 		zone_t * z = pgdat->node_zones + i;
+ * 		struct zone * z = pgdat->node_zones + i;
  * 		...
  * 	}
  * }
--- 2.5.31/include/linux/page-flags.h~zone-rename	Sat Aug 10 23:45:33 2002
+++ 2.5.31-akpm/include/linux/page-flags.h	Sat Aug 10 23:45:33 2002
@@ -161,6 +161,7 @@ extern void get_page_state(struct page_s
 #define SetPageActive(page)	set_bit(PG_active, &(page)->flags)
 #define ClearPageActive(page)	clear_bit(PG_active, &(page)->flags)
 #define TestClearPageActive(page) test_and_clear_bit(PG_active, &(page)->flags)
+#define TestSetPageActive(page) test_and_set_bit(PG_active, &(page)->flags)
 
 #define PageSlab(page)		test_bit(PG_slab, &(page)->flags)
 #define SetPageSlab(page)	set_bit(PG_slab, &(page)->flags)
--- 2.5.31/include/linux/swap.h~zone-rename	Sat Aug 10 23:45:33 2002
+++ 2.5.31-akpm/include/linux/swap.h	Sat Aug 10 23:45:33 2002
@@ -139,7 +139,7 @@ struct task_struct;
 struct vm_area_struct;
 struct sysinfo;
 struct address_space;
-struct zone_t;
+struct zone;
 struct pagevec;
 
 /* linux/mm/rmap.c */
@@ -166,7 +166,7 @@ extern void swap_setup(void);
 
 /* linux/mm/vmscan.c */
 extern wait_queue_head_t kswapd_wait;
-extern int FASTCALL(try_to_free_pages(zone_t *, unsigned int, unsigned int));
+extern int try_to_free_pages(struct zone *, unsigned int, unsigned int);
 
 /* linux/mm/page_io.c */
 int swap_readpage(struct file *file, struct page *page);
--- 2.5.31/mm/filemap.c~zone-rename	Sat Aug 10 23:45:33 2002
+++ 2.5.31-akpm/mm/filemap.c	Sat Aug 10 23:45:33 2002
@@ -618,7 +618,7 @@ static int page_cache_read(struct file *
  */
 static inline wait_queue_head_t *page_waitqueue(struct page *page)
 {
-	const zone_t *zone = page_zone(page);
+	const struct zone *zone = page_zone(page);
 
 	return &zone->wait_table[hash_ptr(page, zone->wait_table_bits)];
 }
--- 2.5.31/mm/page_alloc.c~zone-rename	Sat Aug 10 23:45:33 2002
+++ 2.5.31-akpm/mm/page_alloc.c	Sat Aug 10 23:45:33 2002
@@ -35,7 +35,7 @@ pg_data_t *pgdat_list;
  * Used by page_zone() to look up the address of the struct zone whose
  * id is encoded in the upper bits of page->flags
  */
-zone_t *zone_table[MAX_NR_ZONES*MAX_NR_NODES];
+struct zone *zone_table[MAX_NR_ZONES*MAX_NR_NODES];
 EXPORT_SYMBOL(zone_table);
 
 static char *zone_names[MAX_NR_ZONES] = { "DMA", "Normal", "HighMem" };
@@ -46,7 +46,7 @@ static int zone_balance_max[MAX_NR_ZONES
 /*
  * Temporary debugging check for pages not lying within a given zone.
  */
-static inline int bad_range(zone_t *zone, struct page *page)
+static inline int bad_range(struct zone *zone, struct page *page)
 {
 	if (page - mem_map >= zone->zone_start_mapnr + zone->size)
 		return 1;
@@ -86,7 +86,7 @@ static void __free_pages_ok (struct page
 	unsigned long index, page_idx, mask, flags;
 	free_area_t *area;
 	struct page *base;
-	zone_t *zone;
+	struct zone *zone;
 
 	KERNEL_STAT_ADD(pgfree, 1<<order);
 
@@ -156,7 +156,8 @@ out:
 #define MARK_USED(index, order, area) \
 	__change_bit((index) >> (1+(order)), (area)->map)
 
-static inline struct page * expand (zone_t *zone, struct page *page,
+static inline struct page *
+expand(struct zone *zone, struct page *page,
 	 unsigned long index, int low, int high, free_area_t * area)
 {
 	unsigned long size = 1 << high;
@@ -193,8 +194,7 @@ static inline void prep_new_page(struct 
 	set_page_count(page, 1);
 }
 
-static FASTCALL(struct page * rmqueue(zone_t *zone, unsigned int order));
-static struct page * rmqueue(zone_t *zone, unsigned int order)
+static struct page *rmqueue(struct zone *zone, unsigned int order)
 {
 	free_area_t * area = zone->free_area + order;
 	unsigned int curr_order = order;
@@ -237,7 +237,7 @@ static struct page * rmqueue(zone_t *zon
 #ifdef CONFIG_SOFTWARE_SUSPEND
 int is_head_of_free_region(struct page *page)
 {
-        zone_t *zone = page_zone(page);
+        struct zone *zone = page_zone(page);
         unsigned long flags;
 	int order;
 	list_t *curr;
@@ -267,7 +267,7 @@ struct page *_alloc_pages(unsigned int g
 #endif
 
 static /* inline */ struct page *
-balance_classzone(zone_t * classzone, unsigned int gfp_mask,
+balance_classzone(struct zone *classzone, unsigned int gfp_mask,
 			unsigned int order, int * freed)
 {
 	struct page * page = NULL;
@@ -322,10 +322,12 @@ balance_classzone(zone_t * classzone, un
 /*
  * This is the 'heart' of the zoned buddy allocator:
  */
-struct page * __alloc_pages(unsigned int gfp_mask, unsigned int order, zonelist_t *zonelist)
+struct page *
+__alloc_pages(unsigned int gfp_mask, unsigned int order,
+		struct zonelist *zonelist)
 {
 	unsigned long min;
-	zone_t **zones, *classzone;
+	struct zone **zones, *classzone;
 	struct page * page;
 	int freed, i;
 
@@ -339,7 +341,7 @@ struct page * __alloc_pages(unsigned int
 	/* Go through the zonelist once, looking for a zone with enough free */
 	min = 1UL << order;
 	for (i = 0; zones[i] != NULL; i++) {
-		zone_t *z = zones[i];
+		struct zone *z = zones[i];
 
 		/* the incremental min is allegedly to discourage fallback */
 		min += z->pages_low;
@@ -360,7 +362,7 @@ struct page * __alloc_pages(unsigned int
 	min = 1UL << order;
 	for (i = 0; zones[i] != NULL; i++) {
 		unsigned long local_min;
-		zone_t *z = zones[i];
+		struct zone *z = zones[i];
 
 		local_min = z->pages_min;
 		if (gfp_mask & __GFP_HIGH)
@@ -379,7 +381,7 @@ rebalance:
 	if (current->flags & (PF_MEMALLOC | PF_MEMDIE)) {
 		/* go through the zonelist yet again, ignoring mins */
 		for (i = 0; zones[i] != NULL; i++) {
-			zone_t *z = zones[i];
+			struct zone *z = zones[i];
 
 			page = rmqueue(z, order);
 			if (page)
@@ -406,7 +408,7 @@ nopage:
 	/* go through the zonelist yet one more time */
 	min = 1UL << order;
 	for (i = 0; zones[i] != NULL; i++) {
-		zone_t *z = zones[i];
+		struct zone *z = zones[i];
 
 		min += z->pages_min;
 		if (z->free_pages > min) {
@@ -479,7 +481,7 @@ void free_pages(unsigned long addr, unsi
 unsigned int nr_free_pages(void)
 {
 	unsigned int sum = 0;
-	zone_t *zone;
+	struct zone *zone;
 
 	for_each_zone(zone)
 		sum += zone->free_pages;
@@ -493,9 +495,9 @@ static unsigned int nr_free_zone_pages(i
 	unsigned int sum = 0;
 
 	for_each_pgdat(pgdat) {
-		zonelist_t *zonelist = pgdat->node_zonelists + offset;
-		zone_t **zonep = zonelist->zones;
-		zone_t *zone;
+		struct zonelist *zonelist = pgdat->node_zonelists + offset;
+		struct zone **zonep = zonelist->zones;
+		struct zone *zone;
 
 		for (zone = *zonep++; zone; zone = *zonep++) {
 			unsigned long size = zone->size;
@@ -612,7 +614,7 @@ void show_free_areas(void)
 
 	for (pgdat = pgdat_list; pgdat; pgdat = pgdat->pgdat_next)
 		for (type = 0; type < MAX_NR_ZONES; ++type) {
-			zone_t *zone = &pgdat->node_zones[type];
+			struct zone *zone = &pgdat->node_zones[type];
 			printk("Zone:%s "
 				"freepages:%6lukB "
 				"min:%6lukB "
@@ -635,7 +637,7 @@ void show_free_areas(void)
 	for (pgdat = pgdat_list; pgdat; pgdat = pgdat->pgdat_next)
 		for (type = 0; type < MAX_NR_ZONES; type++) {
 			list_t *elem;
-			zone_t *zone = &pgdat->node_zones[type];
+			struct zone *zone = &pgdat->node_zones[type];
  			unsigned long nr, flags, order, total = 0;
 
 			if (!zone->size)
@@ -664,8 +666,8 @@ static inline void build_zonelists(pg_da
 	int i, j, k;
 
 	for (i = 0; i <= GFP_ZONEMASK; i++) {
-		zonelist_t *zonelist;
-		zone_t *zone;
+		struct zonelist *zonelist;
+		struct zone *zone;
 
 		zonelist = pgdat->node_zonelists + i;
 		memset(zonelist, 0, sizeof(*zonelist));
@@ -798,7 +800,7 @@ void __init free_area_init_core(int nid,
 
 	offset = lmem_map - mem_map;	
 	for (j = 0; j < MAX_NR_ZONES; j++) {
-		zone_t *zone = pgdat->node_zones + j;
+		struct zone *zone = pgdat->node_zones + j;
 		unsigned long mask;
 		unsigned long size, realsize;
 
--- 2.5.31/mm/vmscan.c~zone-rename	Sat Aug 10 23:45:33 2002
+++ 2.5.31-akpm/mm/vmscan.c	Sat Aug 10 23:45:33 2002
@@ -94,8 +94,9 @@ static inline int is_page_cache_freeable
 }
 
 static /* inline */ int
-shrink_list(struct list_head *page_list, int nr_pages, zone_t *classzone,
-		unsigned int gfp_mask, int priority, int *max_scan)
+shrink_list(struct list_head *page_list, int nr_pages,
+		struct zone *classzone, unsigned int gfp_mask,
+		int priority, int *max_scan)
 {
 	struct address_space *mapping;
 	LIST_HEAD(ret_pages);
@@ -276,7 +277,7 @@ keep:
  * in the kernel (apart from the copy_*_user functions).
  */
 static /* inline */ int
-shrink_cache(int nr_pages, zone_t *classzone,
+shrink_cache(int nr_pages, struct zone *classzone,
 		unsigned int gfp_mask, int priority, int max_scan)
 {
 	LIST_HEAD(page_list);
@@ -452,7 +453,7 @@ static /* inline */ void refill_inactive
 }
 
 static /* inline */ int
-shrink_caches(zone_t *classzone, int priority,
+shrink_caches(struct zone *classzone, int priority,
 		unsigned int gfp_mask, int nr_pages)
 {
 	unsigned long ratio;
@@ -502,7 +503,8 @@ shrink_caches(zone_t *classzone, int pri
 	return nr_pages;
 }
 
-int try_to_free_pages(zone_t *classzone, unsigned int gfp_mask, unsigned int order)
+int try_to_free_pages(struct zone *classzone,
+		unsigned int gfp_mask, unsigned int order)
 {
 	int priority = DEF_PRIORITY;
 	int nr_pages = SWAP_CLUSTER_MAX;
@@ -525,9 +527,9 @@ int try_to_free_pages(zone_t *classzone,
 
 DECLARE_WAIT_QUEUE_HEAD(kswapd_wait);
 
-static int check_classzone_need_balance(zone_t * classzone)
+static int check_classzone_need_balance(struct zone *classzone)
 {
-	zone_t * first_classzone;
+	struct zone *first_classzone;
 
 	first_classzone = classzone->zone_pgdat->node_zones;
 	while (classzone >= first_classzone) {
@@ -541,7 +543,7 @@ static int check_classzone_need_balance(
 static int kswapd_balance_pgdat(pg_data_t * pgdat)
 {
 	int need_more_balance = 0, i;
-	zone_t * zone;
+	struct zone *zone;
 
 	for (i = pgdat->nr_zones-1; i >= 0; i--) {
 		zone = pgdat->node_zones + i;
@@ -579,7 +581,7 @@ static void kswapd_balance(void)
 
 static int kswapd_can_sleep_pgdat(pg_data_t * pgdat)
 {
-	zone_t * zone;
+	struct zone *zone;
 	int i;
 
 	for (i = pgdat->nr_zones-1; i >= 0; i--) {

.
