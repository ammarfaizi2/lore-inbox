Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314640AbSDTQFh>; Sat, 20 Apr 2002 12:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314641AbSDTQFg>; Sat, 20 Apr 2002 12:05:36 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:53518 "HELO holly.csn.ul.ie")
	by vger.kernel.org with SMTP id <S314640AbSDTQFe>;
	Sat, 20 Apr 2002 12:05:34 -0400
Date: Sat, 20 Apr 2002 17:05:27 +0100 (IST)
From: Mel <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documenation/vm/numa
In-Reply-To: <1972720000.1019252264@flay>
Message-ID: <Pine.LNX.4.44.0204201703320.3995-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for the clarification. I've the patch attached below again with the
corrections you made. Does it look ok?




--- linux-2.4.19pre7.orig/Documentation/vm/numa	Fri Aug  4 19:23:37 2000
+++ linux-2.4.19pre7.mel/Documentation/vm/numa	Sat Apr 20 16:58:52 2002
@@ -1,4 +1,6 @@
 Started Nov 1999 by Kanoj Sarcar <kanoj@sgi.com>
+        Apr 2002 by Mel Gorman   <melcsn.ul.ie>
+Additional credit to Martin J. Bligh <Martin.Bligh@us.ibm.com>

 The intent of this file is to have an uptodate, running commentary
 from different people about NUMA specific code in the Linux vm.
@@ -39,3 +41,129 @@
 NUMA port achieves more maturity. The call alloc_pages_node has been
 added, so that drivers can make the call and not worry about whether
 it is running on a NUMA or UMA platform.
+
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
+		    work really well as an unsigned long as it breaks for
+                   ia32 with PAE for example. A more suitable solution would be
+                   to record this as a Page Frame Number (pfn) . This could be
+                   trivially defined as (page_phys_addr >> PAGE\_SHIFT).
+                   Alternatively, it could be the struct page * index inside
+                   mem_map.
+
+ node_start_mapnr  This gives the offside within the lmem_map . This is
+		    contained within the global mem_map. lmem_map is the
+		    mapping of page frames for this node
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
+                  a synchronuous fashion
+ pages_high       Once kswapd is woken, it won't sleep until pages_high pages
+                  are free
+ need_balance     A flag kswapd uses to determine if it needs to balance
+ free_area        Used by the buddy algorithm
+ zone_pgdat       Points to the parent pg_data_t
+ zone_mem_map     The first page in mem_map this zone refers to
+ zone_start_paddr Same note for node_start_paddr
+ zone_start_mapnr Same note for node_start_mapnr
+ name             The string name of the zone
+ size             Self explanatory
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

