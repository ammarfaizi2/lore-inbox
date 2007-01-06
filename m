Return-Path: <linux-kernel-owner+w=401wt.eu-S1751044AbXAFBKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbXAFBKM (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 20:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbXAFBKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 20:10:12 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:44817 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044AbXAFBKJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 20:10:09 -0500
Subject: [PATCH] Fix sparsemem on Cell (take 3)
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linuxppc-dev@ozlabs.org,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Andrew Morton <akpm@osdl.org>, kmannth@us.ibm.com,
       linux-kernel@vger.kernel.org, hch@infradead.org, linux-mm@kvack.org,
       paulus@samba.org, mkravetz@us.ibm.com, gone@us.ibm.com,
       cbe-oss-dev@ozlabs.org, Keith Mannthey <kmannth@us.ibm.com>,
       John Rose <johnrose@austin.ibm.com>, Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200612190959.47344.arnd@arndb.de>
References: <20061215165335.61D9F775@localhost.localdomain>
	 <200612182354.47685.arnd@arndb.de>
	 <1166483780.8648.26.camel@localhost.localdomain>
	 <200612190959.47344.arnd@arndb.de>
Content-Type: text/plain
Date: Fri, 05 Jan 2007 17:10:03 -0800
Message-Id: <1168045803.8945.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I dropped this on the floor over Christmas.  This has had a few smoke
tests on ppc64 and i386 and is ready for -mm.  Against 2.6.20-rc2-mm1.

The following patch fixes an oops experienced on the Cell architecture
when init-time functions, early_*(), are called at runtime.  It alters
the call paths to make sure that the callers explicitly say whether the
call is being made on behalf of a hotplug even, or happening at
boot-time. 

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>

---

 lxc-dave/arch/s390/mm/vmem.c    |    3 ++-
 lxc-dave/include/linux/mm.h     |    7 ++++++-
 lxc-dave/include/linux/mmzone.h |    3 ++-
 lxc-dave/mm/memory_hotplug.c    |    6 ++++--
 lxc-dave/mm/page_alloc.c        |   25 +++++++++++++++++--------
 5 files changed, 31 insertions(+), 13 deletions(-)

diff -puN mm/page_alloc.c~sparsemem-enum1 mm/page_alloc.c
--- lxc/mm/page_alloc.c~sparsemem-enum1	2006-12-19 09:38:34.000000000 -0800
+++ lxc-dave/mm/page_alloc.c	2006-12-19 11:18:24.000000000 -0800
@@ -2062,17 +2062,24 @@ static inline unsigned long wait_table_b
  * done. Non-atomic initialization, single-pass.
  */
 void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
-		unsigned long start_pfn)
+		unsigned long start_pfn, enum memmap_context context)
 {
 	struct page *page;
 	unsigned long end_pfn = start_pfn + size;
 	unsigned long pfn;
 
 	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
-		if (!early_pfn_valid(pfn))
-			continue;
-		if (!early_pfn_in_nid(pfn, nid))
-			continue;
+		/*
+		 * There can be holes in boot-time mem_map[]s
+		 * handed to this function.  They do not
+		 * exist on hotplugged memory.
+		 */
+		if (context == MEMMAP_EARLY) {
+			if (!early_pfn_valid(pfn))
+				continue;
+			if (!early_pfn_in_nid(pfn, nid))
+				continue;
+		}
 		page = pfn_to_page(pfn);
 		set_page_links(page, zone, nid, pfn);
 		init_page_count(page);
@@ -2102,7 +2109,7 @@ void zone_init_free_lists(struct pglist_
 
 #ifndef __HAVE_ARCH_MEMMAP_INIT
 #define memmap_init(size, nid, zone, start_pfn) \
-	memmap_init_zone((size), (nid), (zone), (start_pfn))
+	memmap_init_zone((size), (nid), (zone), (start_pfn), MEMMAP_EARLY)
 #endif
 
 static int __cpuinit zone_batchsize(struct zone *zone)
@@ -2348,7 +2355,8 @@ static __meminit void zone_pcp_init(stru
 
 __meminit int init_currently_empty_zone(struct zone *zone,
 					unsigned long zone_start_pfn,
-					unsigned long size)
+					unsigned long size,
+					enum memmap_context context)
 {
 	struct pglist_data *pgdat = zone->zone_pgdat;
 	int ret;
@@ -2792,7 +2800,8 @@ static void __meminit free_area_init_cor
 		if (!size)
 			continue;
 
-		ret = init_currently_empty_zone(zone, zone_start_pfn, size);
+		ret = init_currently_empty_zone(zone, zone_start_pfn,
+						size, MEMMAP_EARLY);
 		BUG_ON(ret);
 		zone_start_pfn += size;
 	}
diff -puN include/linux/mm.h~sparsemem-enum1 include/linux/mm.h
--- lxc/include/linux/mm.h~sparsemem-enum1	2006-12-19 09:38:45.000000000 -0800
+++ lxc-dave/include/linux/mm.h	2006-12-19 09:50:47.000000000 -0800
@@ -979,7 +979,12 @@ extern int early_pfn_to_nid(unsigned lon
 #endif /* CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID */
 #endif /* CONFIG_ARCH_POPULATES_NODE_MAP */
 extern void set_dma_reserve(unsigned long new_dma_reserve);
-extern void memmap_init_zone(unsigned long, int, unsigned long, unsigned long);
+enum memmap_context {
+	MEMMAP_EARLY,
+	MEMMAP_HOTPLUG,
+};
+extern void memmap_init_zone(unsigned long, int, unsigned long,
+				unsigned long, enum memmap_context);
 extern void setup_per_zone_pages_min(void);
 extern void mem_init(void);
 extern void show_mem(void);
diff -puN mm/memory_hotplug.c~sparsemem-enum1 mm/memory_hotplug.c
--- lxc/mm/memory_hotplug.c~sparsemem-enum1	2006-12-19 09:39:19.000000000 -0800
+++ lxc-dave/mm/memory_hotplug.c	2006-12-19 09:50:24.000000000 -0800
@@ -67,11 +67,13 @@ static int __add_zone(struct zone *zone,
 	zone_type = zone - pgdat->node_zones;
 	if (!populated_zone(zone)) {
 		int ret = 0;
-		ret = init_currently_empty_zone(zone, phys_start_pfn, nr_pages);
+		ret = init_currently_empty_zone(zone, phys_start_pfn,
+						nr_pages, MEMMAP_HOTPLUG);
 		if (ret < 0)
 			return ret;
 	}
-	memmap_init_zone(nr_pages, nid, zone_type, phys_start_pfn);
+	memmap_init_zone(nr_pages, nid, zone_type,
+			 phys_start_pfn, MEMMAP_HOTPLUG);
 	return 0;
 }
 
diff -puN arch/s390/mm/vmem.c~sparsemem-enum1 arch/s390/mm/vmem.c
--- lxc/arch/s390/mm/vmem.c~sparsemem-enum1	2006-12-19 09:42:26.000000000 -0800
+++ lxc-dave/arch/s390/mm/vmem.c	2006-12-19 11:17:49.000000000 -0800
@@ -61,7 +61,8 @@ void memmap_init(unsigned long size, int
 
 		if (map_start < map_end)
 			memmap_init_zone((unsigned long)(map_end - map_start),
-					 nid, zone, page_to_pfn(map_start));
+					 nid, zone, page_to_pfn(map_start),
+					 context);
 	}
 }
 
diff -puN include/linux/mmzone.h~sparsemem-enum1 include/linux/mmzone.h
--- lxc/include/linux/mmzone.h~sparsemem-enum1	2006-12-19 09:48:58.000000000 -0800
+++ lxc-dave/include/linux/mmzone.h	2006-12-19 09:53:42.000000000 -0800
@@ -474,7 +474,8 @@ int zone_watermark_ok(struct zone *z, in
 		int classzone_idx, int alloc_flags);
 
 extern int init_currently_empty_zone(struct zone *zone, unsigned long start_pfn,
-				     unsigned long size);
+				     unsigned long size,
+				     enum memmap_context context);
 
 #ifdef CONFIG_HAVE_MEMORY_PRESENT
 void memory_present(int nid, unsigned long start, unsigned long end);
_


-- Dave

