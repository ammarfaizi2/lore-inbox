Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291226AbSBHAhu>; Thu, 7 Feb 2002 19:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291248AbSBHAhk>; Thu, 7 Feb 2002 19:37:40 -0500
Received: from holomorphy.com ([216.36.33.161]:54415 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S291226AbSBHAh2>;
	Thu, 7 Feb 2002 19:37:28 -0500
Date: Thu, 7 Feb 2002 16:37:11 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: riel@surriel.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: for_each_zone cleanup
Message-ID: <20020208003711.GE11971@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	riel@surriel.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, this has been floating around for a while, but here it is.
Others will shortly follow.

Cheers,
Bill

# This is a BitKeeper generated patch for the following project:
# Project Name: Long-term Linux VM development
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.190   -> 1.191  
#	include/linux/mm_inline.h	1.13    -> 1.14   
#	include/linux/mmzone.h	1.12    -> 1.13   
#	         mm/vmscan.c	1.93    -> 1.94   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/02/07	wli@tisifone.holomorphy.com	1.191
# Cleanup of for_each_zone() specifically addressing
# (1) call by reference instead of returning a value in __next_zone()
# (2) the use of an unnecessary pg_data_t state variable in for_each_zone()
# -- wli
# --------------------------------------------
#
diff --minimal -Nru a/include/linux/mm_inline.h b/include/linux/mm_inline.h
--- a/include/linux/mm_inline.h	Thu Feb  7 16:30:27 2002
+++ b/include/linux/mm_inline.h	Thu Feb  7 16:30:27 2002
@@ -126,13 +126,12 @@
 static inline int free_limit(struct zone_struct * zone, int limit)
 {
 	int shortage = 0, local;
-	pg_data_t * pgdat;
 
 	if (zone == ALL_ZONES) {
-		for_each_zone(pgdat, zone)
+		for_each_zone(zone)
 			shortage += zone_free_limit(zone, limit);
 	} else if (zone == ANY_ZONE) {
-		for_each_zone(pgdat, zone) {
+		for_each_zone(zone) {
 			local = zone_free_limit(zone, limit);
 			shortage += max(local, 0);
 		}
@@ -222,13 +221,12 @@
 static inline int inactive_limit(struct zone_struct * zone, int limit)
 {
 	int shortage = 0, local;
-	pg_data_t * pgdat;
 
 	if (zone == ALL_ZONES) {
-		for_each_zone(pgdat, zone)
+		for_each_zone(zone)
 			shortage += zone_inactive_limit(zone, limit);
 	} else if (zone == ANY_ZONE) {
-		for_each_zone(pgdat, zone) {
+		for_each_zone(zone) {
 			local = zone_inactive_limit(zone, limit);
 			shortage += max(local, 0);
 		}
diff --minimal -Nru a/include/linux/mmzone.h b/include/linux/mmzone.h
--- a/include/linux/mmzone.h	Thu Feb  7 16:30:27 2002
+++ b/include/linux/mmzone.h	Thu Feb  7 16:30:27 2002
@@ -162,28 +162,31 @@
 extern pg_data_t contig_page_data;
 
 /*
- * __next_zone - helper magic for for_each_zone()
+ * next_zone - helper magic for for_each_zone()
  * Thanks to William Lee Irwin III for this piece of ingenuity.
  */
-static inline void __next_zone(pg_data_t **pgdat, zone_t **zone)
+static inline zone_t *next_zone(zone_t *zone)
 {
-	(*zone)++;
-	if(*zone - (*pgdat)->node_zones >= MAX_NR_ZONES) {
-		*pgdat = (*pgdat)->node_next;
-		if(*pgdat)
-			*zone = (*pgdat)->node_zones;
-		else
-			*zone = NULL;
-	}
+	pg_data_t *pgdat = zone->zone_pgdat;
+
+	if (zone - pgdat->node_zones < MAX_NR_ZONES - 1)
+		zone++;
+
+	else if (pgdat->node_next) {
+		pgdat = pgdat->node_next;
+		zone = pgdat->node_zones;
+	} else
+		zone = NULL;
+
+	return zone;
 }
 
 /**
  * for_each_zone - helper macro to iterate over all memory zones
- * @pgdat - pg_data_t * variable
  * @zone - zone_t * variable
  *
- * The user only needs to declare both variables, for_each_zone
- * fills them in. This basically means for_each_zone() is an
+ * The user only needs to declare the zone variable, for_each_zone
+ * fills it in. This basically means for_each_zone() is an
  * easier to read version of this piece of code:
  *
  * for(pgdat = pgdat_list; pgdat; pgdat = pgdat->node_next)
@@ -193,10 +196,8 @@
  * 	}
  * }
  */
-#define for_each_zone(pgdat, zone)				\
-	for(pgdat = pgdat_list, zone = pgdat->node_zones;	\
-			pgdat && zone;				\
-			__next_zone(&pgdat, &zone))
+#define for_each_zone(zone) \
+	for(zone = pgdat_list->node_zones; zone; zone = next_zone(zone))
 
 
 #ifndef CONFIG_DISCONTIGMEM
diff --minimal -Nru a/mm/vmscan.c b/mm/vmscan.c
--- a/mm/vmscan.c	Thu Feb  7 16:30:27 2002
+++ b/mm/vmscan.c	Thu Feb  7 16:30:27 2002
@@ -421,18 +421,17 @@
 {
 	int maxtry = 1 << DEF_PRIORITY;
 	struct zone_struct * zone;
-	pg_data_t * pgdat;
 	int freed = 0;
 
 	/* Global balancing while we have a global shortage. */
 	while (maxtry-- && free_high(ALL_ZONES) >= 0) {
-		for_each_zone(pgdat, zone)
+		for_each_zone(zone)
 			if (free_plenty(zone) >= 0)
 				freed += page_launder_zone(zone, gfp_mask, 6);
 	}
 	
 	/* Clean up the remaining zones with a serious shortage, if any. */
-	for_each_zone(pgdat, zone)
+	for_each_zone(zone)
 		if (free_min(zone) >= 0)
 			freed += page_launder_zone(zone, gfp_mask, 0);
 
@@ -524,20 +523,19 @@
 int refill_inactive(void)
 {
 	int maxtry = 1 << DEF_PRIORITY;
-	pg_data_t * pgdat;
 	zone_t * zone;
 	int ret = 0;
 
 	/* Global balancing while we have a global shortage. */
 	while (maxtry-- && inactive_low(ALL_ZONES) >= 0) {
-		for_each_zone(pgdat, zone) {
+		for_each_zone(zone) {
 			if (inactive_high(zone) >= 0)
 				ret += refill_inactive_zone(zone, DEF_PRIORITY);
 		}
 	}
 
 	/* Local balancing for zones which really need it. */
-	for_each_zone(pgdat, zone) {
+	for_each_zone(zone) {
 		if (inactive_min(zone) >= 0)
 			ret += refill_inactive_zone(zone, 0);
 	}
@@ -558,9 +556,8 @@
 static inline void background_aging(int priority)
 {
 	struct zone_struct * zone;
-	pg_data_t * pgdat;
 
-	for_each_zone(pgdat, zone)
+	for_each_zone(zone)
 		if (inactive_high(zone) > 0)
 			refill_inactive_zone(zone, priority);
 }
@@ -624,10 +621,9 @@
 static void refill_freelist(void)
 {
 	struct page * page;
-	pg_data_t * pgdat;
 	zone_t * zone;
 
-	for_each_zone(pgdat, zone) {
+	for_each_zone(zone) {
 		if (!zone->size || zone->free_pages >= zone->pages_min)
 			continue;
 
