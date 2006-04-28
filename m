Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965174AbWD1Cqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965174AbWD1Cqf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 22:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965181AbWD1Cqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 22:46:34 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:65216 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S965174AbWD1Cqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 22:46:34 -0400
Date: Fri, 28 Apr 2006 11:47:32 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: LHMS <lhms-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] catch valid mem range at onlining memory
Message-Id: <20060428114732.e889ad2d.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows hot-add memory which is not aligned to section.
Based on linux-2.6.17-rc2-mm1 + memory hotadd ioresource register patch.

iomem resource patch is here.
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0604.3/1188.html

Now, hot-added memory has to be aligned to section size.
Considering big section sized archs, this is not useful.

When hot-added memory is registerd as iomem resoruce by iomem resource patch,
we can make use of that information to detect valid memory range.

Note: With this, not-aligned memory can be registerd. To allow hot-add
      memory with holes, we have to do more work around add_memory().
      (It doesn't allows add memory to already existing mem section.)
      

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>



Index: linux-2.6.17-rc2-mm1/kernel/resource.c
===================================================================
--- linux-2.6.17-rc2-mm1.orig/kernel/resource.c	2006-04-27 18:00:16.000000000 +0900
+++ linux-2.6.17-rc2-mm1/kernel/resource.c	2006-04-28 11:19:25.000000000 +0900
@@ -242,6 +242,45 @@
 
 EXPORT_SYMBOL(release_resource);
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+/*
+ * Finds the lowest memory reosurce exists within [res->start.res->end)
+ * the caller must specify res->start, res->end, res->flags.
+ * If found, returns 0, res is overwritten, if not found, returns -1.
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
+		if (p->flags != res->flags)
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
+		return -1;
+	/* copy data */
+	res->start = p->start;
+	res->end = p->end;
+	return 0;
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
+++ linux-2.6.17-rc2-mm1/mm/memory_hotplug.c	2006-04-28 11:11:43.000000000 +0900
@@ -123,6 +123,9 @@
 	unsigned long i;
 	unsigned long flags;
 	unsigned long onlined_pages = 0;
+	struct resource res;
+	u64 section_end;
+	unsigned long start_pfn;
 	struct zone *zone;
 	int need_zonelists_rebuild = 0;
 
@@ -145,10 +148,27 @@
 	if (!populated_zone(zone))
 		need_zonelists_rebuild = 1;
 
-	for (i = 0; i < nr_pages; i++) {
-		struct page *page = pfn_to_page(pfn + i);
-		online_page(page);
-		onlined_pages++;
+	res.start = (u64)pfn << PAGE_SHIFT;
+	res.end = res.start + ((u64)nr_pages << PAGE_SHIFT) - 1;
+	res.flags = IORESOUECE_MEM; /* we just need system ram */
+	section_end = res.end;
+
+	while (find_next_system_ram(&res) >= 0) {
+		start_pfn = (unsigned long)(res.start >> PAGE_SHIFT);
+		nr_pages = (unsigned long)
+                           ((res.end + 1 - res.start) >> PAGE_SHIFT);
+
+		if (PageReserved(pfn_to_page(start_pfn))) {
+			/* this region's page is not onlined now */
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

