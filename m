Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312716AbSDKSXX>; Thu, 11 Apr 2002 14:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312718AbSDKSXW>; Thu, 11 Apr 2002 14:23:22 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:43781 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S312716AbSDKSXU>; Thu, 11 Apr 2002 14:23:20 -0400
Date: Thu, 11 Apr 2002 15:23:07 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] for_each_zone / for_each_pgdat
Message-ID: <Pine.LNX.4.44L.0204111522000.31387-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

replace slightly obscure while loops with for_each_zone and
for_each_pgdat macros  (thanks to William Lee Irwin)

-- 
Please apply,

Rik

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.388   -> 1.389
#	include/linux/mmzone.h	1.7     -> 1.8
#	     mm/page_alloc.c	1.43    -> 1.44
#	         mm/vmscan.c	1.59    -> 1.60
#	        mm/bootmem.c	1.6     -> 1.7
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/04/11	riel@duckman.distro.conectiva	1.389
# replace slightly obscure while loops with for_each_zone and
# for_each_pgdat macros  (thanks to William Lee Irwin)
# --------------------------------------------
#
diff -Nru a/include/linux/mmzone.h b/include/linux/mmzone.h
--- a/include/linux/mmzone.h	Thu Apr 11 15:22:01 2002
+++ b/include/linux/mmzone.h	Thu Apr 11 15:22:01 2002
@@ -158,6 +158,59 @@

 extern pg_data_t contig_page_data;

+/**
+ * for_each_pgdat - helper macro to iterate over all nodes
+ * @pgdat - pg_data_t * variable
+ *
+ * Meant to help with common loops of the form
+ * pgdat = pgdat_list;
+ * while(pgdat) {
+ *     ...
+ *     pgdat = pgdat->node_next;
+ * }
+ */
+#define for_each_pgdat(pgdat) \
+	for (pgdat = pgdat_list; pgdat; pgdat = pgdat->node_next)
+
+/*
+ * next_zone - helper magic for for_each_zone()
+ * Thanks to William Lee Irwin III for this piece of ingenuity.
+ */
+static inline zone_t *next_zone(zone_t *zone)
+{
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
+}
+
+/**
+ * for_each_zone - helper macro to iterate over all memory zones
+ * @zone - zone_t * variable
+ *
+ * The user only needs to declare the zone variable, for_each_zone
+ * fills it in. This basically means for_each_zone() is an
+ * easier to read version of this piece of code:
+ *
+ * for(pgdat = pgdat_list; pgdat; pgdat = pgdat->node_next)
+ *     for(i = 0; i < MAX_NR_ZONES; ++i) {
+ *             zone_t * z = pgdat->node_zones + i;
+ *             ...
+ *     }
+ * }
+ */
+#define for_each_zone(zone) \
+	for(zone = pgdat_list->node_zones; zone; zone = next_zone(zone))
+
+
 #ifndef CONFIG_DISCONTIGMEM

 #define NODE_DATA(nid)		(&contig_page_data)
diff -Nru a/mm/bootmem.c b/mm/bootmem.c
--- a/mm/bootmem.c	Thu Apr 11 15:22:02 2002
+++ b/mm/bootmem.c	Thu Apr 11 15:22:02 2002
@@ -326,12 +326,11 @@
 	pg_data_t *pgdat = pgdat_list;
 	void *ptr;

-	while (pgdat) {
+	for_each_pgdat(pgdat)
 		if ((ptr = __alloc_bootmem_core(pgdat->bdata, size,
 						align, goal)))
 			return(ptr);
-		pgdat = pgdat->node_next;
-	}
+
 	/*
 	 * Whoops, we cannot satisfy the allocation request.
 	 */
diff -Nru a/mm/page_alloc.c b/mm/page_alloc.c
--- a/mm/page_alloc.c	Thu Apr 11 15:22:01 2002
+++ b/mm/page_alloc.c	Thu Apr 11 15:22:01 2002
@@ -479,14 +479,10 @@
 {
 	unsigned int sum;
 	zone_t *zone;
-	pg_data_t *pgdat = pgdat_list;

 	sum = 0;
-	while (pgdat) {
-		for (zone = pgdat->node_zones; zone < pgdat->node_zones + MAX_NR_ZONES; zone++)
+	for_each_zone(zone)
 			sum += zone->free_pages;
-		pgdat = pgdat->node_next;
-	}
 	return sum;
 }

@@ -498,7 +494,7 @@
 	pg_data_t *pgdat = pgdat_list;
 	unsigned int sum = 0;

-	do {
+	for_each_pgdat(pgdat) {
 		zonelist_t *zonelist = pgdat->node_zonelists + (GFP_USER & GFP_ZONEMASK);
 		zone_t **zonep = zonelist->zones;
 		zone_t *zone;
@@ -509,9 +505,7 @@
 			if (size > high)
 				sum += size - high;
 		}
-
-		pgdat = pgdat->node_next;
-	} while (pgdat);
+	}

 	return sum;
 }
@@ -519,13 +513,12 @@
 #if CONFIG_HIGHMEM
 unsigned int nr_free_highpages (void)
 {
-	pg_data_t *pgdat = pgdat_list;
+	pg_data_t *pgdat;
 	unsigned int pages = 0;

-	while (pgdat) {
+	for_each_pgdat(pgdat)
 		pages += pgdat->node_zones[ZONE_HIGHMEM].free_pages;
-		pgdat = pgdat->node_next;
-	}
+
 	return pages;
 }
 #endif
diff -Nru a/mm/vmscan.c b/mm/vmscan.c
--- a/mm/vmscan.c	Thu Apr 11 15:22:01 2002
+++ b/mm/vmscan.c	Thu Apr 11 15:22:02 2002
@@ -649,10 +649,8 @@

 	do {
 		need_more_balance = 0;
-		pgdat = pgdat_list;
-		do
+		for_each_pgdat(pgdat)
 			need_more_balance |= kswapd_balance_pgdat(pgdat);
-		while ((pgdat = pgdat->node_next));
 	} while (need_more_balance);
 }

@@ -675,12 +673,11 @@
 {
 	pg_data_t * pgdat;

-	pgdat = pgdat_list;
-	do {
+	for_each_pgdat(pgdat) {
 		if (kswapd_can_sleep_pgdat(pgdat))
 			continue;
 		return 0;
-	} while ((pgdat = pgdat->node_next));
+	}

 	return 1;
 }

