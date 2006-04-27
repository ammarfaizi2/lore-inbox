Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965049AbWD0NgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965049AbWD0NgD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 09:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965048AbWD0NgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 09:36:03 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:22252 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S965049AbWD0NgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 09:36:00 -0400
Date: Thu, 27 Apr 2006 22:37:05 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: LHMS <lhms-devel@lists.sourceforge.net>
Subject: [RFC][PATCH] hot add memory which is not aligned to section
Message-Id: <20060427223705.e99bb194.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows hot-add memory region which is not aligned to section.
Based on linux-2.6.17-rc2-mm1 + memory hotadd ioresource register patch.
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0604.3/1188.html

Now, hot-added memory has to be aligned to section size. Considering big section
sized archs, this is not useful.They sometimes have not aligned memory.
For example, fujitsu's NUMA machine has 64MB firmware area at the lowest address
of each node.

If hot-added memory is registerd to iomem resoruce, we can make use
of that information to detect valid memory range.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>



Index: linux-2.6.17-rc2-mm1/kernel/resource.c
===================================================================
--- linux-2.6.17-rc2-mm1.orig/kernel/resource.c	2006-04-27 18:00:16.000000000 +0900
+++ linux-2.6.17-rc2-mm1/kernel/resource.c	2006-04-27 21:52:51.000000000 +0900
@@ -242,6 +242,44 @@
 
 EXPORT_SYMBOL(release_resource);
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+/*
+ * Finds memory reosurce exists higher than  specified address.
+ * real_lock(&resource_lock) must be held before calling this.
+ */
+int find_next_system_ram(struct resource *res)
+{
+	u64 start, end;
+	struct resource *p;
+
+	BUG_ON(!res);
+
+	start = res->start;
+	end = res->end;
+
+	read_lock(&resource_lock);
+	for( p = iomem_resource.child; p ; p = p->sibling) {
+		/* system ram is just marked as IORESOURCE_MEM */
+		if (p->flags != IORESOURCE_MEM)
+			continue;
+		if (p->start > end) {
+			p = NULL;
+			break;
+		}
+		if (p->start >= start)
+			break;
+	}
+	read_unlock(&resource_lock);
+	if (!p)
+		return 0;
+	/* copy data */
+	res->start = p->start;
+	res->end = p->end;
+	return 1;
+}
+
+#endif
+
 /*
  * Find empty slot in the resource tree given range and alignment.
  */
Index: linux-2.6.17-rc2-mm1/include/linux/ioport.h
===================================================================
--- linux-2.6.17-rc2-mm1.orig/include/linux/ioport.h	2006-04-27 18:00:16.000000000 +0900
+++ linux-2.6.17-rc2-mm1/include/linux/ioport.h	2006-04-27 21:47:25.000000000 +0900
@@ -105,6 +105,10 @@
 			     void *alignf_data);
 int adjust_resource(struct resource *res, u64 start,
 		    u64 size);
+#ifdef CONFIG_MEMORY_HOTPLUG
+/* get registered SYSTEM_RAM resources in specified area */
+extern int find_next_system_ram(struct resource *res);
+#endif
 
 /* Convenience shorthand with allocation */
 #define request_region(start,n,name)	__request_region(&ioport_resource, (start), (n), (name))
Index: linux-2.6.17-rc2-mm1/mm/memory_hotplug.c
===================================================================
--- linux-2.6.17-rc2-mm1.orig/mm/memory_hotplug.c	2006-04-27 20:21:32.000000000 +0900
+++ linux-2.6.17-rc2-mm1/mm/memory_hotplug.c	2006-04-27 21:57:17.000000000 +0900
@@ -123,6 +123,9 @@
 	unsigned long i;
 	unsigned long flags;
 	unsigned long onlined_pages = 0;
+	struct resource res;
+	u64 section_end;
+	unsigned long start_pfn;
 	struct zone *zone;
 	int need_zonelists_rebuild = 0;
 
@@ -145,10 +148,26 @@
 	if (!populated_zone(zone))
 		need_zonelists_rebuild = 1;
 
-	for (i = 0; i < nr_pages; i++) {
-		struct page *page = pfn_to_page(pfn + i);
-		online_page(page);
-		onlined_pages++;
+	res.start = (u64)pfn << PAGE_SHIFT;
+	res.end = res.start + ((u64)nr_pages << PAGE_SHIFT) - 1;
+	section_end = res.end;
+
+	while (find_next_system_ram(&res)) {
+		start_pfn = (unsigned long)(res.start >> PAGE_SHIFT);
+		nr_pages = (unsigned long)
+                           ((res.end + 1 - res.start) >> PAGE_SHIFT);
+
+		if (PageReserved(pfn_to_page(start_pfn))) {
+			/* this region's page is not populated now */
+			for (i = 0; i < nr_pages; i++) {
+				struct page *page = pfn_to_page(start_pfn + i);
+				online_page(page);
+				onlined_pages++;
+			}
+		}
+
+		res.start = res.end + 1;
+		res.end = section_end;
 	}
 	zone->present_pages += onlined_pages;
 	zone->zone_pgdat->node_present_pages += onlined_pages;

