Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318928AbSG1HaB>; Sun, 28 Jul 2002 03:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318922AbSG1HWy>; Sun, 28 Jul 2002 03:22:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57349 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318923AbSG1HVV>;
	Sun, 28 Jul 2002 03:21:21 -0400
Message-ID: <3D439E33.9130FFA5@zip.com.au>
Date: Sun, 28 Jul 2002 00:33:07 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 8/13] for_each_zone macro
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Patch from Robert Love.

Attached patch implements for_each_zone(zont_t *) which is a helper
macro to cleanup code of the form:

        for (pgdat = pgdat_list; pgdat; pgdat = pgdat->node_next) { 
                for (i = 0; i < MAX_NR_ZONES; ++i) { 
                        zone_t * z = pgdat->node_zones + i; 
                        /* ... */ 
                } 
        } 

and replace it with:

        for_each_zone(zone) {
                /* ... */
        }

This patch only replaces one use of the above loop with the new macro. 
Pending code, however, currently in the full rmap patch uses
for_each_zone more extensively.

This is from Rik's 2.4-rmap patch and by William Irwin.



 include/linux/mmzone.h |   37 +++++++++++++++++++++++++++++++++++++
 mm/page_alloc.c        |    9 ++++-----
 2 files changed, 41 insertions(+), 5 deletions(-)

--- 2.5.29/include/linux/mmzone.h~for_each_zone	Sat Jul 27 23:39:08 2002
+++ 2.5.29-akpm/include/linux/mmzone.h	Sat Jul 27 23:39:08 2002
@@ -177,6 +177,43 @@ extern pg_data_t contig_page_data;
 #define for_each_pgdat(pgdat) \
 	for (pgdat = pgdat_list; pgdat; pgdat = pgdat->pgdat_next)
 
+/*
+ * next_zone - helper magic for for_each_zone()
+ * Thanks to William Lee Irwin III for this piece of ingenuity.
+ */
+static inline zone_t * next_zone(zone_t * zone)
+{
+	pg_data_t *pgdat = zone->zone_pgdat;
+
+	if (zone - pgdat->node_zones < MAX_NR_ZONES - 1)
+		zone++;
+	else if (pgdat->pgdat_next) {
+		pgdat = pgdat->pgdat_next;
+		zone = pgdat->node_zones;
+	} else
+		zone = NULL;
+
+	return zone;
+}
+
+/**
+ * for_each_zone - helper macro to iterate over all memory zones
+ * @zone - pointer to zone_t variable
+ *
+ * The user only needs to declare the zone variable, for_each_zone
+ * fills it in. This basically means for_each_zone() is an
+ * easier to read version of this piece of code:
+ *
+ * for (pgdat = pgdat_list; pgdat; pgdat = pgdat->node_next)
+ * 	for (i = 0; i < MAX_NR_ZONES; ++i) {
+ * 		zone_t * z = pgdat->node_zones + i;
+ * 		...
+ * 	}
+ * }
+ */
+#define for_each_zone(zone) \
+	for (zone = pgdat_list->node_zones; zone; zone = next_zone(zone))
+
 #ifndef CONFIG_DISCONTIGMEM
 
 #define NODE_DATA(nid)		(&contig_page_data)
--- 2.5.29/mm/page_alloc.c~for_each_zone	Sat Jul 27 23:39:08 2002
+++ 2.5.29-akpm/mm/page_alloc.c	Sat Jul 27 23:39:08 2002
@@ -478,12 +478,11 @@ void free_pages(unsigned long addr, unsi
  */
 unsigned int nr_free_pages(void)
 {
-	unsigned int i, sum = 0;
-	pg_data_t *pgdat;
+	unsigned int sum = 0;
+	zone_t *zone;
 
-	for (pgdat = pgdat_list; pgdat; pgdat = pgdat->pgdat_next)
-		for (i = 0; i < MAX_NR_ZONES; ++i)
-			sum += pgdat->node_zones[i].free_pages;
+	for_each_zone(zone)
+		sum += zone->free_pages;
 
 	return sum;
 }

.
