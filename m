Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280450AbRKSRlQ>; Mon, 19 Nov 2001 12:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280457AbRKSRlH>; Mon, 19 Nov 2001 12:41:07 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:31249 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S280450AbRKSRkj>; Mon, 19 Nov 2001 12:40:39 -0500
Date: Mon, 19 Nov 2001 18:40:27 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Cc: ben@google.com, brownfld@irridia.com, phillips@bonn-fries.net,
        Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.4.15pre6aa1 (fixes google VM problem)
Message-ID: <20011119184027.Q1331@athlon.random>
In-Reply-To: <20011118092434.A1331@athlon.random>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Md/poaVZ8hnGTzuv"
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011118092434.A1331@athlon.random>; from andrea@suse.de on Sun, Nov 18, 2001 at 09:24:34AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Md/poaVZ8hnGTzuv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 18, 2001 at 09:24:34AM +0100, Andrea Arcangeli wrote:
> If all works right on Monday I will port the fix to mainline (it's

Ok here it is against 2.4.15pre6:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.15pre6/zone-watermarks-1

(also attached to the email). Untested on top of mainline but should be
safe to apply. also avoids GFP_ATOMIC from interrupts to eat the
PF_MEMALLOC (longstanding fix from Manfred).

Andrea

--Md/poaVZ8hnGTzuv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=zone-watermarks-1

diff -urN 2.4.15pre6/include/linux/mmzone.h google/include/linux/mmzone.h
--- 2.4.15pre6/include/linux/mmzone.h	Tue Nov 13 05:18:58 2001
+++ google/include/linux/mmzone.h	Mon Nov 19 18:19:00 2001
@@ -18,6 +18,11 @@
 #define MAX_ORDER CONFIG_FORCE_MAX_ZONEORDER
 #endif
 
+#define ZONE_DMA		0
+#define ZONE_NORMAL		1
+#define ZONE_HIGHMEM		2
+#define MAX_NR_ZONES		3
+
 typedef struct free_area_struct {
 	struct list_head	free_list;
 	unsigned long		*map;
@@ -25,6 +30,10 @@
 
 struct pglist_data;
 
+typedef struct zone_watermarks_s {
+	unsigned long min, low, high;
+} zone_watermarks_t;
+
 /*
  * On machines where it is needed (eg PCs) we divide physical memory
  * into multiple physical zones. On a PC we have 3 zones:
@@ -39,8 +48,17 @@
 	 */
 	spinlock_t		lock;
 	unsigned long		free_pages;
-	unsigned long		pages_min, pages_low, pages_high;
-	int			need_balance;
+
+	/*
+	 * We don't know if the memory that we're going to allocate will be freeable
+	 * or/and it will be released eventually, so to avoid totally wasting several
+	 * GB of ram we must reserve some of the lower zone memory (otherwise we risk
+	 * to run OOM on the lower zones despite there's tons of freeable ram
+	 * on the higher zones).
+	 */
+	zone_watermarks_t	watermarks[MAX_NR_ZONES];
+
+	unsigned long		need_balance;
 
 	/*
 	 * free areas of different sizes
@@ -60,6 +78,7 @@
 	 */
 	char			*name;
 	unsigned long		size;
+	unsigned long		realsize;
 } zone_t;
 
 #define ZONE_DMA		0
@@ -113,8 +132,8 @@
 extern int numnodes;
 extern pg_data_t *pgdat_list;
 
-#define memclass(pgzone, classzone)	(((pgzone)->zone_pgdat == (classzone)->zone_pgdat) \
-			&& ((pgzone) <= (classzone)))
+#define zone_idx(zone)			((zone) - (zone)->zone_pgdat->node_zones)
+#define memclass(pgzone, classzone)	(zone_idx(pgzone) <= zone_idx(classzone))
 
 /*
  * The following two are not meant for general usage. They are here as
diff -urN 2.4.15pre6/mm/page_alloc.c google/mm/page_alloc.c
--- 2.4.15pre6/mm/page_alloc.c	Sun Nov 18 06:04:47 2001
+++ google/mm/page_alloc.c	Mon Nov 19 18:09:15 2001
@@ -27,9 +27,10 @@
 pg_data_t *pgdat_list;
 
 static char *zone_names[MAX_NR_ZONES] = { "DMA", "Normal", "HighMem" };
-static int zone_balance_ratio[MAX_NR_ZONES] __initdata = { 32, 128, 128, };
+static int zone_balance_ratio[MAX_NR_ZONES] __initdata = { 128, 128, 128, };
 static int zone_balance_min[MAX_NR_ZONES] __initdata = { 20 , 20, 20, };
 static int zone_balance_max[MAX_NR_ZONES] __initdata = { 255 , 255, 255, };
+static int lower_zone_reserve_ratio[MAX_NR_ZONES-1] = { 128, 8 };
 
 /*
  * Free_page() adds the page to the free lists. This is optimized for
@@ -312,16 +313,18 @@
 {
 	zone_t **zone, * classzone;
 	struct page * page;
-	int freed;
+	int freed, class_idx;
 
 	zone = zonelist->zones;
 	classzone = *zone;
+	class_idx = zone_idx(classzone);
+
 	for (;;) {
 		zone_t *z = *(zone++);
 		if (!z)
 			break;
 
-		if (zone_free_pages(z, order) > z->pages_low) {
+		if (zone_free_pages(z, order) > z->watermarks[class_idx].low) {
 			page = rmqueue(z, order);
 			if (page)
 				return page;
@@ -340,7 +343,7 @@
 		if (!z)
 			break;
 
-		min = z->pages_min;
+		min = z->watermarks[class_idx].min;
 		if (!(gfp_mask & __GFP_WAIT))
 			min >>= 2;
 		if (zone_free_pages(z, order) > min) {
@@ -353,7 +356,7 @@
 	/* here we're in the low on memory slow path */
 
 rebalance:
-	if (current->flags & (PF_MEMALLOC | PF_MEMDIE)) {
+	if (current->flags & (PF_MEMALLOC | PF_MEMDIE) && !in_interrupt()) {
 		zone = zonelist->zones;
 		for (;;) {
 			zone_t *z = *(zone++);
@@ -381,7 +384,7 @@
 		if (!z)
 			break;
 
-		if (zone_free_pages(z, order) > z->pages_min) {
+		if (zone_free_pages(z, order) > z->watermarks[class_idx].min) {
 			page = rmqueue(z, order);
 			if (page)
 				return page;
@@ -473,13 +476,15 @@
 	unsigned int sum = 0;
 
 	do {
+		int class_idx;
 		zonelist_t *zonelist = pgdat->node_zonelists + (GFP_USER & GFP_ZONEMASK);
 		zone_t **zonep = zonelist->zones;
 		zone_t *zone;
 
+		class_idx = zone_idx(*zonep);
 		for (zone = *zonep++; zone; zone = *zonep++) {
 			unsigned long size = zone->size;
-			unsigned long high = zone->pages_high;
+			unsigned long high = zone->watermarks[class_idx].high;
 			if (size > high)
 				sum += size - high;
 		}
@@ -525,13 +530,9 @@
 		zone_t *zone;
 		for (zone = tmpdat->node_zones;
 			       	zone < tmpdat->node_zones + MAX_NR_ZONES; zone++)
-			printk("Zone:%s freepages:%6lukB min:%6lukB low:%6lukB " 
-				       "high:%6lukB\n", 
+			printk("Zone:%s freepages:%6lukB\n", 
 					zone->name,
-					K(zone->free_pages),
-					K(zone->pages_min),
-					K(zone->pages_low),
-					K(zone->pages_high));
+					K(zone->free_pages));
 			
 		tmpdat = tmpdat->node_next;
 	}
@@ -697,6 +698,7 @@
 		zone_t *zone = pgdat->node_zones + j;
 		unsigned long mask;
 		unsigned long size, realsize;
+		int idx;
 
 		realsize = size = zones_size[j];
 		if (zholes_size)
@@ -704,6 +706,7 @@
 
 		printk("zone(%lu): %lu pages.\n", j, size);
 		zone->size = size;
+		zone->realsize = realsize;
 		zone->name = zone_names[j];
 		zone->lock = SPIN_LOCK_UNLOCKED;
 		zone->zone_pgdat = pgdat;
@@ -719,9 +722,29 @@
 			mask = zone_balance_min[j];
 		else if (mask > zone_balance_max[j])
 			mask = zone_balance_max[j];
-		zone->pages_min = mask;
-		zone->pages_low = mask*2;
-		zone->pages_high = mask*3;
+		zone->watermarks[j].min = mask;
+		zone->watermarks[j].low = mask*2;
+		zone->watermarks[j].high = mask*3;
+		/* now set the watermarks of the lower zones in the "j" classzone */
+		for (idx = j-1; idx >= 0; idx--) {
+			zone_t * lower_zone = pgdat->node_zones + idx;
+			unsigned long lower_zone_reserve;
+			if (!lower_zone->size)
+				continue;
+
+			mask = lower_zone->watermarks[idx].min;
+			lower_zone->watermarks[j].min = mask;
+			lower_zone->watermarks[j].low = mask*2;
+			lower_zone->watermarks[j].high = mask*3;
+
+			/* now the brainer part */
+			lower_zone_reserve = realsize / lower_zone_reserve_ratio[idx];
+			lower_zone->watermarks[j].min += lower_zone_reserve;
+			lower_zone->watermarks[j].low += lower_zone_reserve;
+			lower_zone->watermarks[j].high += lower_zone_reserve;
+
+			realsize += lower_zone->realsize;
+		}
 
 		zone->zone_mem_map = mem_map + offset;
 		zone->zone_start_mapnr = offset;
@@ -797,3 +820,16 @@
 }
 
 __setup("memfrac=", setup_mem_frac);
+
+static int __init setup_lower_zone_reserve(char *str)
+{
+	int j = 0;
+
+	while (get_option(&str, &lower_zone_reserve_ratio[j++]) == 2);
+	printk("setup_lower_zone_reserve: ");
+	for (j = 0; j < MAX_NR_ZONES-1; j++) printk("%d  ", lower_zone_reserve_ratio[j]);
+	printk("\n");
+	return 1;
+}
+
+__setup("lower_zone_reserve=", setup_lower_zone_reserve);
diff -urN 2.4.15pre6/mm/vmscan.c google/mm/vmscan.c
--- 2.4.15pre6/mm/vmscan.c	Sun Nov 18 06:04:47 2001
+++ google/mm/vmscan.c	Mon Nov 19 18:10:19 2001
@@ -606,11 +606,12 @@
 
 static int check_classzone_need_balance(zone_t * classzone)
 {
-	zone_t * first_classzone;
+	zone_t * first_zone;
+	int class_idx = zone_idx(classzone);
 
-	first_classzone = classzone->zone_pgdat->node_zones;
-	while (classzone >= first_classzone) {
-		if (classzone->free_pages > classzone->pages_high)
+	first_zone = classzone->zone_pgdat->node_zones;
+	while (classzone >= first_zone) {
+		if (classzone->free_pages > classzone->watermarks[class_idx].high)
 			return 0;
 		classzone--;
 	}

--Md/poaVZ8hnGTzuv--
