Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313091AbSDLAZo>; Thu, 11 Apr 2002 20:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313096AbSDLAZn>; Thu, 11 Apr 2002 20:25:43 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:54030 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S313091AbSDLAZm>; Thu, 11 Apr 2002 20:25:42 -0400
Date: Thu, 11 Apr 2002 21:25:31 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] for_each_zone / for_each_pgdat
Message-ID: <Pine.LNX.4.44L.0204112123480.31387-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

replace slightly obscure while loops with for_each_zone and
for_each_pgdat macros, this version has the added optimisation
of skipping empty zones       (thanks to William Lee Irwin)

-- 
Hi Linus,

this patch cleans up the VM a little bit and has a microoptimisation
to skip zones of size zero.  You can apply this mail or pull the
changes from:

	bk://linuxvm.bkbits.net/linux-2.5-for-linus/

please apply,

thanks,

Rik


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.456   -> 1.457
#	include/linux/mmzone.h	1.8     -> 1.9
#	     mm/page_alloc.c	1.44    -> 1.45
#	         mm/vmscan.c	1.59    -> 1.60
#	        mm/bootmem.c	1.8     -> 1.9
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/04/11	riel@duckman.distro.conectiva	1.457
# replace slightly obscure while loops with for_each_zone and
# for_each_pgdat macros, this version has the added optimisation
# of skipping empty zones       (thanks to William Lee Irwin)
# --------------------------------------------
#
diff -Nru a/include/linux/mmzone.h b/include/linux/mmzone.h
--- a/include/linux/mmzone.h	Thu Apr 11 21:23:50 2002
+++ b/include/linux/mmzone.h	Thu Apr 11 21:23:50 2002
@@ -157,6 +157,62 @@

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
+	do {
+		if (zone - pgdat->node_zones < MAX_NR_ZONES - 1)
+			zone++;
+
+		else if (pgdat->node_next) {
+			pgdat = pgdat->node_next;
+			zone = pgdat->node_zones;
+		} else
+			zone = NULL;
+	/* Skip zones of size 0 ... */
+	} while (zone && !zone->size);
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
--- a/mm/bootmem.c	Thu Apr 11 21:23:50 2002
+++ b/mm/bootmem.c	Thu Apr 11 21:23:50 2002
@@ -338,12 +338,11 @@
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
--- a/mm/page_alloc.c	Thu Apr 11 21:23:50 2002
+++ b/mm/page_alloc.c	Thu Apr 11 21:23:50 2002
@@ -482,14 +482,10 @@
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

@@ -501,7 +497,7 @@
 	pg_data_t *pgdat = pgdat_list;
 	unsigned int sum = 0;

-	do {
+	for_each_pgdat(pgdat) {
 		zonelist_t *zonelist = pgdat->node_zonelists + (GFP_USER & GFP_ZONEMASK);
 		zone_t **zonep = zonelist->zones;
 		zone_t *zone;
@@ -512,9 +508,7 @@
 			if (size > high)
 				sum += size - high;
 		}
-
-		pgdat = pgdat->node_next;
-	} while (pgdat);
+	}

 	return sum;
 }
@@ -522,13 +516,12 @@
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
--- a/mm/vmscan.c	Thu Apr 11 21:23:50 2002
+++ b/mm/vmscan.c	Thu Apr 11 21:23:50 2002
@@ -655,10 +655,8 @@

 	do {
 		need_more_balance = 0;
-		pgdat = pgdat_list;
-		do
+		for_each_pgdat(pgdat)
 			need_more_balance |= kswapd_balance_pgdat(pgdat);
-		while ((pgdat = pgdat->node_next));
 	} while (need_more_balance);
 }

@@ -681,12 +679,11 @@
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

