Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317552AbSGTWkN>; Sat, 20 Jul 2002 18:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317559AbSGTWkM>; Sat, 20 Jul 2002 18:40:12 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:65273 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317552AbSGTWkL>; Sat, 20 Jul 2002 18:40:11 -0400
Subject: [PATCH] for_each_zone, updated
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: riel@conectiva.com.br, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       wli@holomorphy.com
In-Reply-To: <1027196543.1555.775.camel@sinai>
References: <1027196543.1555.775.camel@sinai>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 20 Jul 2002 15:43:13 -0700
Message-Id: <1027204993.1086.826.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-07-20 at 13:22, Robert Love wrote:
> Attached patch implements for_each_zone(zont_t *) which is a helper
> macro to cleanup code of the form:

Attached patch implements for_each_zone, now using Martin Bligh's newly
renamed pgdat_next.

This patch applies on top of the updated for_each_pgdat patch.

Please, apply.

	Robert Love

diff -urN linux-2.5.27-rml/include/linux/mmzone.h linux/include/linux/mmzone.h
--- linux-2.5.27-rml/include/linux/mmzone.h	Sat Jul 20 15:31:06 2002
+++ linux/include/linux/mmzone.h	Sat Jul 20 15:31:38 2002
@@ -177,6 +177,43 @@
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
+ * for (pgdat = pgdat_list; pgdat; pgdat = pgdat->pgdat_next)
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
diff -urN linux-2.5.27-rml/mm/page_alloc.c linux/mm/page_alloc.c
--- linux-2.5.27-rml/mm/page_alloc.c	Sat Jul 20 15:31:29 2002
+++ linux/mm/page_alloc.c	Sat Jul 20 15:31:38 2002
@@ -477,12 +477,12 @@
  */
 unsigned int nr_free_pages(void)
 {
-	unsigned int i, sum = 0;
-	pg_data_t *pgdat;
+	unsigned int sum;
+	zone_t *zone;
 
-	for (pgdat = pgdat_list; pgdat; pgdat = pgdat->pgdat_next)
-		for (i = 0; i < MAX_NR_ZONES; ++i)
-			sum += pgdat->node_zones[i].free_pages;
+	sum = 0;
+	for_each_zone(zone)
+		sum += zone->free_pages;
 
 	return sum;
 }

