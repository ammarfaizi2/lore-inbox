Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315406AbSHFT3o>; Tue, 6 Aug 2002 15:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315414AbSHFT3o>; Tue, 6 Aug 2002 15:29:44 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:19980 "HELO holly.csn.ul.ie")
	by vger.kernel.org with SMTP id <S315406AbSHFT3l>;
	Tue, 6 Aug 2002 15:29:41 -0400
Date: Tue, 6 Aug 2002 20:33:13 +0100 (IST)
From: Mel <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [patch 2/5] NUMA document update
Message-ID: <Pine.LNX.4.44.0208062017160.14917-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is an update to the Documentation/vm/numa file. Please apply

Mel Gorman
MSc Student, University of Limerick
http://www.csn.ul.ie/~mel

--- linux-2.4.19/Documentation/vm/numa	Fri Aug  4 19:23:37 2000
+++ linux-2.4.19-mel/Documentation/vm/numa	Tue Aug  6 15:04:16 2002
@@ -1,6 +1,8 @@
 Started Nov 1999 by Kanoj Sarcar <kanoj@sgi.com>
+        Aug 2002 by Mel Gorman   <melcsn.ul.ie>
+Additional credit to Martin J. Bligh <Martin.Bligh@us.ibm.com>

-The intent of this file is to have an uptodate, running commentary
+The intent of this file is to have an up to date, running commentary
 from different people about NUMA specific code in the Linux vm.

 What is NUMA? It is an architecture where the memory access times
@@ -39,3 +41,137 @@
 NUMA port achieves more maturity. The call alloc_pages_node has been
 added, so that drivers can make the call and not worry about whether
 it is running on a NUMA or UMA platform.
+
+Nodes
+=====
+
+A node is described by the pg\_data\_t struct. Each can have one or more
+of the three zone types ZONE\_HIGHMEM, ZONE\_NORMAL and ZONE\_DMA. It can
+only have one zone of each type. It is the responsibility of the buddy
+allocator to make sure pages are allocated from the proper nodes.
+
+It is declared as
+
+typedef struct pglist_data {
+        zone_t node_zones[MAX_NR_ZONES];
+        zonelist_t node_zonelists[GFP_ZONEMASK+1];
+        int nr_zones;
+        struct page *node_mem_map;
+        unsigned long *valid_addr_bitmap;
+        struct bootmem_data *bdata;
+        unsigned long node_start_paddr;
+        unsigned long node_start_mapnr;
+        unsigned long node_size;
+        int node_id;
+        struct pglist_data *node_next;
+} pg_data_t;
+
+ node_zones        The zones for this node. Currently ZONE_HIGHMEM,
+                   ZONE_NORMAL, ZONE_DMA.
+
+ node_zonelists    This is the order of zones that allocations are
+		   preferred  from. build_zonelists() in page_alloc.c does
+		   the work when called by free_area_init_core(). So a failed
+		   allocation ZONE_HIGHMEM may fall back to ZONE_NORMAL
+		   or back to ZONE_DMA . See the buddy algorithm for details.
+
+ nr_zones          Number of zones in this node,  between 1 and 3
+
+ node_mem_map      The first page of the physical block this node represents
+
+ valid_addr_bitmap Not positive, a bitmap that shows where holes are in memory?
+
+ bdata             Used only when starting up the node. Mainly confined
+                   to bootmem.c
+
+ node_start_paddr  The starting physical address of the node. This doesn't
+		   work really well as an unsigned long as it breaks for
+                   ia32 with PAE for example. A more suitable solution would be
+                   to record this as a Page Frame Number (pfn) . This could be
+                   trivially defined as (page_phys_addr >> PAGE\_SHIFT).
+
+ node_start_mapnr  This gives the offset within the lmem_map . This is
+		   contained within the global mem_map. lmem_map is the
+		   mapping of page frames for this node. The global
+		   mem_map is treated as an array but it is some arbitrary
+		   constant set to point to some value like PAGE_OFFSET. The
+		   lmem_map's are offsets within this imaginary mem_map
+		   array.
+
+ node_size         The total number of pages in this zone
+
+ node_id           The ID of the node, starts at 0
+
+ node_next         Pointer to next node in a linear list. NULL terminated
+
+1.2   Zones
+===========
+  Each pg_data_t node will be aware of one or more zones that it can
+allocate pages from. The possible zones are ZONE_HIGHMEM, ZONE_NORMAL
+and ZONE_DMA. There can only be one zone of each type per pg_data_t.
+Each zone is suitable for a particular use but there is not necessarily
+a penalty for usage of the wrong zone like there is with the wrong
+pg_data_t
+
+  typedef struct zone_struct {
+          /*
+           * Commonly accessed fields:
+           */
+          spinlock_t              lock;
+          unsigned long           free_pages;
+          unsigned long           pages_min, pages_low, pages_high;
+          int                     need_balance;
+
+          /*
+           * free areas of different sizes
+           */
+          free_area_t             free_area[MAX_ORDER];
+
+          wait_queue_head_t       * wait_table;
+	  unsigned long           wait_table_size;
+	  unsigned long           wait_table_shift;
+
+          /*
+           * Discontig memory support fields.
+           */
+          struct pglist_data      *zone_pgdat;
+          struct page             *zone_mem_map;
+          unsigned long           zone_start_paddr;
+          unsigned long           zone_start_mapnr;
+
+          /*
+           * rarely used fields:
+           */
+          char                    *name;
+          unsigned long           size;
+  } zone_t;
+
+ lock             A lock to protect the zone
+ free_pages       Total number of free pages in the zone
+ pages_min        When pages_min is reached, kswapd is woken up
+ pages_low        When reached, the allocator will do the kswapd work in
+                  a synchronous fashion
+ pages_high       Once kswapd is woken, it won't sleep until pages_high pages
+                  are free
+ need_balance     A flag kswapd uses to determine if it needs to balance
+ free_area        Used by the buddy algorithm
+ wait_table       Heavily commented in mmzone.h
+ wait_table_size  Heavily commented in mmzone.h
+ wait_table_shift Heavily commented in mmzone.h
+ zone_pgdat       Points to the parent pg_data_t
+ zone_mem_map     The first page in mem_map this zone refers to
+ zone_start_paddr Same note for node_start_paddr
+ zone_start_mapnr Same note for node_start_mapnr
+ name             The string name of the zone
+ size             Size of the zone in pages
+
+1.3   Relationship
+==================
+
+        pg_data_t ------->  pg_data_t ------->      pgdata_t ------->NULL
+           / | \               / | \                 / | \
+      -----  |  -----     -----  |  -----       -----  |  -----
+      |      |      |     |      |      |       |      |      |
+  zone_t  zone_t  zone_t zone_t zone_t zone_t zone_t zone_t zone_t
+
+Note that there is not necessarily three zones per pg_data_t node.


