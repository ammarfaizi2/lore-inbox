Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261514AbVCaPyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbVCaPyY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 10:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbVCaPyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 10:54:24 -0500
Received: from graphe.net ([209.204.138.32]:47365 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261407AbVCaPyK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 10:54:10 -0500
Date: Thu, 31 Mar 2005 07:53:54 -0800 (PST)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@server.graphe.net
To: Matthew Wilcox <matthew@wil.cx>
cc: Christoph Hellwig <hch@infradead.org>,
       shobhit dayal <shobhit@calsoftinc.com>, manfred@colorfullife.com,
       akpm@osdl.org, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       linux-mm@kvack.org, Shai Fultheim <shai@scalex86.org>
Subject: Re: Fwd: [PATCH] Pageset Localization V2
In-Reply-To: <20050331144740.GB21986@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0503310753140.7711@server.graphe.net>
References: <Pine.LNX.4.58.0503292147200.32571@server.graphe.net>
 <20050330111439.GA13110@infradead.org> <bab4333005033003295f487e3d@mail.gmail.com>
 <1112187977.9773.15.camel@kuber> <20050331143235.GA18058@infradead.org>
 <20050331144740.GB21986@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Mar 2005, Matthew Wilcox wrote:

> On Thu, Mar 31, 2005 at 03:32:35PM +0100, Christoph Hellwig wrote:
> > Which would be much nicer done using INIT_LIST_HEAD on the new head
> > always and then calling list_replace (of which currently only a _rcu variant
> > exists).
>
> INIT_LIST_HEAD followed by list_splice() should do the trick, I think.
> BTW, is it a problem that the list head which the list was copied from
> still points into the list?

New patch replacing the old fix patch following your recipe:

Index: linux-2.6.11/mm/page_alloc.c
===================================================================
--- linux-2.6.11.orig/mm/page_alloc.c	2005-03-30 19:45:23.000000000 -0800
+++ linux-2.6.11/mm/page_alloc.c	2005-03-31 07:52:10.000000000 -0800
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
@@ -1642,10 +1634,13 @@ static inline int __devinit process_zone

 		if(zone->pageset[cpu]) {
 			memcpy(npageset, zone->pageset[cpu], sizeof(struct per_cpu_pageset));
-			MAKE_LIST(zone->pageset[cpu]->pcp[0].list, (&npageset->pcp[0].list));
-			MAKE_LIST(zone->pageset[cpu]->pcp[1].list, (&npageset->pcp[1].list));
-		}
-		else {
+
+			/* Relocate lists */
+			for(i = 0; i<2; i++) {
+				INIT_LIST_HEAD(&npageset->pcp[i].list);
+				list_splice(&zone->pageset[cpu]->pcp[i].list, &npageset->pcp[i].list);
+			}
+ 		} else {
 			struct per_cpu_pages *pcp;
 			unsigned long batch;

@@ -1721,11 +1716,14 @@ struct notifier_block pageset_notifier =

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

