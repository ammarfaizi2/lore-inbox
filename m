Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbWDKLb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWDKLb5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 07:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbWDKLba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 07:31:30 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:59534 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750766AbWDKLbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 07:31:21 -0400
Date: Tue, 11 Apr 2006 20:30:44 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [Patch:005/005] wait_table and zonelist initializing for memory hotadd (update zonelists)
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
In-Reply-To: <20060411202031.5643.Y-GOTO@jp.fujitsu.com>
References: <20060411202031.5643.Y-GOTO@jp.fujitsu.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060411202836.564D.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In current code, zonelist is considered to be build once, no modification.
But MemoryHotplug can add new zone/pgdat. It must be updated.

This patch modifies build_all_zonelists(). 
By this, build_all_zonelist() can reconfig pgdat's zonelists.

To update them safety, this patch use stop_machine_run().
Other cpus don't touch among updating them by using it.

In old version (V2 of node hotadd), kernel updated them after zone
initialization.
But present_page of its new zone is still 0, because online_page()
is not called yet at this time. 
Build_zonelists() checks present_pages to find present zone.
It was too early. So, I changed it after online_pages().

Signed-off-by: Yasunori Goto     <y-goto@jp.fujitsu.com>
Signed-off-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

 mm/memory_hotplug.c |   12 ++++++++++++
 mm/page_alloc.c     |   26 +++++++++++++++++++++-----
 2 files changed, 33 insertions(+), 5 deletions(-)

Index: pgdat10/mm/page_alloc.c
===================================================================
--- pgdat10.orig/mm/page_alloc.c	2006-04-10 14:15:24.000000000 +0900
+++ pgdat10/mm/page_alloc.c	2006-04-10 14:15:34.000000000 +0900
@@ -37,6 +37,7 @@
 #include <linux/nodemask.h>
 #include <linux/vmalloc.h>
 #include <linux/mempolicy.h>
+#include <linux/stop_machine.h>
 
 #include <asm/tlbflush.h>
 #include "internal.h"
@@ -1763,14 +1764,29 @@ static void __meminit build_zonelists(pg
 
 #endif	/* CONFIG_NUMA */
 
-void __init build_all_zonelists(void)
+/* return values int ....just for stop_machine_run() */
+static int __meminit __build_all_zonelists(void *dummy)
 {
-	int i;
+	int nid;
+	for_each_online_node(nid)
+		build_zonelists(NODE_DATA(nid));
+	return 0;
+}
+
+void __meminit build_all_zonelists(void)
+{
+	if (system_state == SYSTEM_BOOTING) {
+		__build_all_zonelists(0);
+		cpuset_init_current_mems_allowed();
+	} else {
+		/* we have to stop all cpus to guaranntee there is no user
+		   of zonelist */
+		stop_machine_run(__build_all_zonelists, NULL, NR_CPUS);
+		/* cpuset refresh routine should be here */
+	}
 
-	for_each_online_node(i)
-		build_zonelists(NODE_DATA(i));
 	printk("Built %i zonelists\n", num_online_nodes());
-	cpuset_init_current_mems_allowed();
+
 }
 
 /*
Index: pgdat10/mm/memory_hotplug.c
===================================================================
--- pgdat10.orig/mm/memory_hotplug.c	2006-04-10 14:15:13.000000000 +0900
+++ pgdat10/mm/memory_hotplug.c	2006-04-10 14:15:34.000000000 +0900
@@ -123,6 +123,7 @@ int online_pages(unsigned long pfn, unsi
 	unsigned long flags;
 	unsigned long onlined_pages = 0;
 	struct zone *zone;
+	int need_zonelists_rebuild = 0;
 
 	/*
 	 * This doesn't need a lock to do pfn_to_page().
@@ -135,6 +136,14 @@ int online_pages(unsigned long pfn, unsi
 	grow_pgdat_span(zone->zone_pgdat, pfn, pfn + nr_pages);
 	pgdat_resize_unlock(zone->zone_pgdat, &flags);
 
+	/*
+	 * If this zone is not populated, then it is not in zonelist.
+	 * This means the page allocator ignores this zone.
+	 * So, zonelist must be updated after online.
+	 */
+	if (!populated_zone(zone))
+		need_zonelists_rebuild = 1;
+
 	for (i = 0; i < nr_pages; i++) {
 		struct page *page = pfn_to_page(pfn + i);
 		online_page(page);
@@ -145,5 +154,8 @@ int online_pages(unsigned long pfn, unsi
 
 	setup_per_zone_pages_min();
 
+	if (need_zonelists_rebuild)
+		build_all_zonelists();
+
 	return 0;
 }

-- 
Yasunori Goto 


