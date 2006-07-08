Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbWGHAIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbWGHAIT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 20:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbWGHAHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 20:07:53 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:12994 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932426AbWGHAF2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 20:05:28 -0400
Date: Fri, 7 Jul 2006 17:05:17 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Martin Bligh <mbligh@google.com>, Christoph Hellwig <hch@infradead.org>,
       Marcelo Tosatti <marcelo@kvack.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>, Andi Kleen <ak@suse.de>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Message-Id: <20060708000517.3829.30693.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060708000501.3829.25578.sendpatchset@schroedinger.engr.sgi.com>
References: <20060708000501.3829.25578.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC 3/8] eventcounters: Optional ZONE_DMA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vmstat: Make ZONE_DMA support configurable

Do not display ZONE_DMA counters if no DMA zone is available.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-mm6/include/linux/vmstat.h
===================================================================
--- linux-2.6.17-mm6.orig/include/linux/vmstat.h	2006-07-06 18:44:59.763286559 -0700
+++ linux-2.6.17-mm6/include/linux/vmstat.h	2006-07-06 19:59:53.254972797 -0700
@@ -18,6 +18,12 @@
  * generated will simply be the increment of a global address.
  */
 
+#ifdef CONFIG_ZONE_DMA
+#define DMA_ZONE(xx) xx##_DMA,
+#else
+#define DMA_ZONE(xx)
+#endif
+
 #ifdef CONFIG_ZONE_DMA32
 #define DMA32_ZONE(xx) xx##_DMA32,
 #else
@@ -30,7 +36,7 @@
 #define HIGHMEM_ZONE(xx)
 #endif
 
-#define FOR_ALL_ZONES(xx) xx##_DMA, DMA32_ZONE(xx) xx##_NORMAL HIGHMEM_ZONE(xx)
+#define FOR_ALL_ZONES(xx) DMA_ZONE(xx) DMA32_ZONE(xx) xx##_NORMAL HIGHMEM_ZONE(xx)
 
 enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		FOR_ALL_ZONES(PGALLOC),
@@ -88,9 +94,13 @@ extern void vm_events_fold_cpu(int cpu);
 
 #endif /* CONFIG_VM_EVENT_COUNTERS */
 
+#ifdef CONFIG_ZONE_DMA
 #define __count_zone_vm_events(item, zone, delta) \
 			__count_vm_events(item##_DMA + zone_idx(zone), delta)
-
+#else
+#define __count_zone_vm_events(item, zone, delta) \
+			__count_vm_events(item##_NORMAL + zone_idx(zone), delta)
+#endif
 /*
  * Zone based page accounting with per cpu differentials.
  */
@@ -136,14 +146,16 @@ static inline unsigned long node_page_st
 	struct zone *zones = NODE_DATA(node)->node_zones;
 
 	return
+#ifdef CONFIG_ZONE_DMA
+		zone_page_state(&zones[ZONE_DMA], item) +
+#endif
 #ifdef CONFIG_ZONE_DMA32
 		zone_page_state(&zones[ZONE_DMA32], item) +
 #endif
-		zone_page_state(&zones[ZONE_NORMAL], item) +
 #ifdef CONFIG_HIGHMEM
 		zone_page_state(&zones[ZONE_HIGHMEM], item) +
 #endif
-		zone_page_state(&zones[ZONE_DMA], item);
+		zone_page_state(&zones[ZONE_NORMAL], item);
 }
 
 extern void zone_statistics(struct zonelist *, struct zone *);
Index: linux-2.6.17-mm6/mm/vmstat.c
===================================================================
--- linux-2.6.17-mm6.orig/mm/vmstat.c	2006-07-06 18:44:59.764263061 -0700
+++ linux-2.6.17-mm6/mm/vmstat.c	2006-07-06 22:32:29.382408873 -0700
@@ -381,6 +381,12 @@ struct seq_operations fragmentation_op =
 	.show	= frag_show,
 };
 
+#ifdef CONFIG_ZONE_DMA
+#define TEXT_FOR_DMA(xx) xx "_dma",
+#else
+#define TEXT_FOR_DMA(xx)
+#endif
+
 #ifdef CONFIG_ZONE_DMA32
 #define TEXT_FOR_DMA32(xx) xx "_dma32",
 #else
@@ -393,7 +399,7 @@ struct seq_operations fragmentation_op =
 #define TEXT_FOR_HIGHMEM(xx)
 #endif
 
-#define TEXTS_FOR_ZONES(xx) xx "_dma", TEXT_FOR_DMA32(xx) xx "_normal", \
+#define TEXTS_FOR_ZONES(xx) TEXT_FOR_DMA(xx) TEXT_FOR_DMA32(xx) xx "_normal", \
 					TEXT_FOR_HIGHMEM(xx)
 
 static char *vmstat_text[] = {
