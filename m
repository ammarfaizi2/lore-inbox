Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317495AbSGTUVM>; Sat, 20 Jul 2002 16:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317497AbSGTUUD>; Sat, 20 Jul 2002 16:20:03 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:43764 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317495AbSGTUTW>; Sat, 20 Jul 2002 16:19:22 -0400
Subject: [PATCH] for_each_zone
From: Robert Love <rml@tech9.net>
To: akpm@zip.com.au, torvalds@transmeta.com
Cc: riel@conectiva.com.br, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       wli@holomorphy.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 20 Jul 2002 13:22:23 -0700
Message-Id: <1027196543.1555.775.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

This patch requires the previous for_each_pgdat patch, but only to apply
cleanly.

	Robert Love

diff -urN linux-2.5.27/include/linux/mmzone.h linux/include/linux/mmzone.h
--- linux-2.5.27/include/linux/mmzone.h	Sat Jul 20 12:11:05 2002
+++ linux/include/linux/mmzone.h	Sat Jul 20 13:00:48 2002
@@ -163,6 +163,43 @@
 
 extern pg_data_t contig_page_data;
 
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
diff -urN linux-2.5.27/mm/page_alloc.c linux/mm/page_alloc.c
--- linux-2.5.27/mm/page_alloc.c	Sat Jul 20 12:11:07 2002
+++ linux/mm/page_alloc.c	Sat Jul 20 13:00:48 2002
@@ -477,12 +477,12 @@
  */
 unsigned int nr_free_pages(void)
 {
-	unsigned int i, sum = 0;
-	pg_data_t *pgdat;
+	unsigned int sum;
+	zone_t *zone;
 
-	for (pgdat = pgdat_list; pgdat; pgdat = pgdat->node_next)
-		for (i = 0; i < MAX_NR_ZONES; ++i)
-			sum += pgdat->node_zones[i].free_pages;
+	sum = 0;
+	for_each_zone(zone)
+		sum += zone->free_pages;
 
 	return sum;
 }

