Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261935AbVCaDu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261935AbVCaDu4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 22:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262484AbVCaDuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 22:50:55 -0500
Received: from graphe.net ([209.204.138.32]:5138 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261935AbVCaDuf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 22:50:35 -0500
Date: Wed, 30 Mar 2005 19:50:22 -0800 (PST)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@server.graphe.net
To: Matthew Wilcox <matthew@wil.cx>
cc: Manfred Spraul <manfred@colorfullife.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       linux-mm@kvack.org, shai@scalex86.org,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] Pageset Localization V2
In-Reply-To: <20050330134049.GA21986@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0503301947450.26235@server.graphe.net>
References: <Pine.LNX.4.58.0503292147200.32571@server.graphe.net>
 <20050330134049.GA21986@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch to fix the issues mentioned so far. The MAKE_LIST macro would also
not be good to some things that I have planned so lets drop it.

Index: linux-2.6.11/mm/page_alloc.c
===================================================================
--- linux-2.6.11.orig/mm/page_alloc.c	2005-03-30 19:45:23.000000000 -0800
+++ linux-2.6.11/mm/page_alloc.c	2005-03-30 19:46:23.000000000 -0800
@@ -1613,15 +1613,6 @@ void zone_init_free_lists(struct pglist_
 	memmap_init_zone((size), (nid), (zone), (start_pfn))
 #endif

-#define MAKE_LIST(list, nlist)  \
-	do {    \
-		if(list_empty(&list))      \
-			INIT_LIST_HEAD(nlist);          \
-		else {  nlist->next->prev = nlist;      \
-			nlist->prev->next = nlist;      \
-		}                                       \
-	}while(0)
-
 /*
  * Dynamicaly allocate memory for the
  * per cpu pageset array in struct zone.
@@ -1629,6 +1620,7 @@ void zone_init_free_lists(struct pglist_
 static inline int __devinit process_zones(int cpu)
 {
 	struct zone *zone, *dzone;
+	int i;

 	for_each_zone(zone) {
 		struct per_cpu_pageset *npageset = NULL;
@@ -1642,9 +1634,17 @@ static inline int __devinit process_zone

 		if(zone->pageset[cpu]) {
 			memcpy(npageset, zone->pageset[cpu], sizeof(struct per_cpu_pageset));
-			MAKE_LIST(zone->pageset[cpu]->pcp[0].list, (&npageset->pcp[0].list));
-			MAKE_LIST(zone->pageset[cpu]->pcp[1].list, (&npageset->pcp[1].list));
-		}
+
+			/* Fix up the list pointers */
+			for(i = 0; i<2; i++) {
+				if (list_empty(&zone->pageset[cpu]->pcp[i].list))
+					INIT_LIST_HEAD(&npageset->pcp[i].list);
+				else {
+					npageset->pcp[i].list.next->prev = &npageset->pcp[i].list;
+					npageset->pcp[i].list.prev->next = &npageset->pcp[i].list;
+				}
+			}
+ 		}
 		else {
 			struct per_cpu_pages *pcp;
 			unsigned long batch;
@@ -1721,11 +1721,14 @@ struct notifier_block pageset_notifier =

 void __init setup_per_cpu_pageset()
 {
-	/*Iintialize per_cpu_pageset for cpu 0.
-	  A cpuup callback will do this for every cpu
-	  as it comes online
+	int err;
+
+	/* Initialize per_cpu_pageset for cpu 0.
+	 * A cpuup callback will do this for every cpu
+	 * as it comes online
 	 */
-	BUG_ON(process_zones(smp_processor_id()));
+	err = process_zones(smp_processor_id());
+	BUG_ON(err);
 	register_cpu_notifier(&pageset_notifier);
 }

