Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbTISWEv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 18:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbTISWEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 18:04:50 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:45050 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261736AbTISWEp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 18:04:45 -0400
Message-ID: <3F6B7CCA.5040702@us.ibm.com>
Date: Fri, 19 Sep 2003 15:01:46 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jesse Barnes <jbarnes@sgi.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk, wli@holomorphy.com
Subject: Re: [PATCH] you have how many nodes??
References: <20030910153601.36219ed8.akpm@osdl.org> <41000000.1063237600@flay> <20030911000303.GA20329@sgi.com> <3F6659DF.1090508@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------090103070806030807000000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090103070806030807000000
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew,
	Here's a small update to the numnodes fix that went into -mm3.  The 
biggest changes are:
	1) move the actual NODES_SHIFT and MAX_NUMNODES definitions into 
linux/numa.h and include this in linux/mmzone.h, instead of being 
directly in linux/mmzone.h.  This allows other files to include *just* 
the NUMNODES stuff w/out grabbing all of mmzone.h.
	2) pull NODE_SHIFT out of linux/mm.h.  This isn't used anywhere in the 
kernel, and it will only get confused with NODES_SHIFT.
	3) Fix the IA64 patch.  The original patch I had sent out hadn't been 
tested on IA64.  It was mostly right, but there were circular 
dependencies.  All better now, and acked by Jesse.
	4) In linux/mmzone.h, insert code to define MAX_NODES_SHIFT based on 
the size of unsigned long.  For 64-bit arches, we can have a much larger 
value.  This allows IA64 to have 100's or 1000's of nodes. 
MAX_NODES_SHIFT is defined as 10 (ie: 1024 nodes) for 64-bit for now, 
although it could likely be much larger.  For 32-bit it is 6 (ie: 64 nodes).
	5) Small cleanup in include/asm-arm/memory.h.  Mostly the result of the 
new linux/numa.h file.  Much cleaner and more readable now.

Russell, if you get a chance, I'd really appreciate a sanity check on 
the arm code.  It really hasn't been tested, but the changes are pretty 
small.

Cheers!

-Matt

--------------090103070806030807000000
Content-Type: text/plain;
 name="numnodes_update.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="numnodes_update.patch"

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test5-mm3/include/asm-arm/memory.h linux-2.6.0-test5-numnodes_update/include/asm-arm/memory.h
--- linux-2.6.0-test5-mm3/include/asm-arm/memory.h	Fri Sep 19 14:05:33 2003
+++ linux-2.6.0-test5-numnodes_update/include/asm-arm/memory.h	Fri Sep 19 14:52:11 2003
@@ -84,27 +84,24 @@ static inline void *phys_to_virt(unsigne
 
 #define PHYS_TO_NID(addr)	(0)
 
-#else
+#else /* CONFIG_DISCONTIGMEM */
+
 /*
  * This is more complex.  We have a set of mem_map arrays spread
  * around in memory.
  */
-#include <asm/numnodes.h>
-#define NUM_NODES	(1 << NODES_SHIFT)
+#include <linux/numa.h>
 
 #define page_to_pfn(page)					\
 	(( (page) - page_zone(page)->zone_mem_map)		\
 	  + page_zone(page)->zone_start_pfn)
-
 #define pfn_to_page(pfn)					\
 	(PFN_TO_MAPBASE(pfn) + LOCAL_MAP_NR((pfn) << PAGE_SHIFT))
-
-#define pfn_valid(pfn)		(PFN_TO_NID(pfn) < NUM_NODES)
+#define pfn_valid(pfn)		(PFN_TO_NID(pfn) < MAX_NUMNODES)
 
 #define virt_to_page(kaddr)					\
 	(ADDR_TO_MAPBASE(kaddr) + LOCAL_MAP_NR(kaddr))
-
-#define virt_addr_valid(kaddr)	(KVADDR_TO_NID(kaddr) < NUM_NODES)
+#define virt_addr_valid(kaddr)	(KVADDR_TO_NID(kaddr) < MAX_NUMNODES)
 
 /*
  * Common discontigmem stuff.
@@ -112,9 +109,7 @@ static inline void *phys_to_virt(unsigne
  */
 #define PHYS_TO_NID(addr)	PFN_TO_NID((addr) >> PAGE_SHIFT)
 
-#undef NUM_NODES
-
-#endif
+#endif /* !CONFIG_DISCONTIGMEM */
 
 /*
  * For BIO.  "will die".  Kill me when bio_to_phys() and bvec_to_phys() die.
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test5-mm3/include/asm-ia64/nodedata.h linux-2.6.0-test5-numnodes_update/include/asm-ia64/nodedata.h
--- linux-2.6.0-test5-mm3/include/asm-ia64/nodedata.h	Fri Sep 19 14:05:33 2003
+++ linux-2.6.0-test5-numnodes_update/include/asm-ia64/nodedata.h	Fri Sep 19 14:52:13 2003
@@ -8,13 +8,11 @@
  * Copyright (c) 2002 Erich Focht <efocht@ess.nec.de>
  * Copyright (c) 2002 Kimio Suganuma <k-suganuma@da.jp.nec.com>
  */
-
-
 #ifndef _ASM_IA64_NODEDATA_H
 #define _ASM_IA64_NODEDATA_H
 
-
-#include <linux/mmzone.h>
+#include <linux/numa.h>
+#include <asm/mmzone.h>
 
 /*
  * Node Data. One of these structures is located on each node of a NUMA system.
@@ -24,7 +22,7 @@ struct pglist_data;
 struct ia64_node_data {
 	short			active_cpu_count;
 	short			node;
-        struct pglist_data	*pg_data_ptrs[MAX_NUMNODES];
+	struct pglist_data	*pg_data_ptrs[MAX_NUMNODES];
 	struct page		*bank_mem_map_base[NR_BANKS];
 	struct ia64_node_data	*node_data_ptrs[MAX_NUMNODES];
 	short			node_id_map[NR_BANKS];
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test5-mm3/include/asm-ia64/numa.h linux-2.6.0-test5-numnodes_update/include/asm-ia64/numa.h
--- linux-2.6.0-test5-mm3/include/asm-ia64/numa.h	Fri Sep 19 14:05:33 2003
+++ linux-2.6.0-test5-numnodes_update/include/asm-ia64/numa.h	Fri Sep 19 14:52:13 2003
@@ -13,9 +13,9 @@
 
 #ifdef CONFIG_NUMA
 
-#include <linux/mmzone.h>
-
+#include <linux/numa.h>
 #include <linux/cache.h>
+
 extern volatile char cpu_to_node_map[NR_CPUS] __cacheline_aligned;
 extern volatile unsigned long node_to_cpu_mask[MAX_NUMNODES] __cacheline_aligned;
 
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test5-mm3/include/asm-ia64/sn/pda.h linux-2.6.0-test5-numnodes_update/include/asm-ia64/sn/pda.h
--- linux-2.6.0-test5-mm3/include/asm-ia64/sn/pda.h	Fri Sep 19 14:05:33 2003
+++ linux-2.6.0-test5-numnodes_update/include/asm-ia64/sn/pda.h	Fri Sep 19 14:52:13 2003
@@ -10,7 +10,7 @@
 
 #include <linux/config.h>
 #include <linux/cache.h>
-#include <linux/mmzone.h>
+#include <linux/numa.h>
 #include <asm/percpu.h>
 #include <asm/system.h>
 #include <asm/processor.h>
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test5-mm3/include/linux/mm.h linux-2.6.0-test5-numnodes_update/include/linux/mm.h
--- linux-2.6.0-test5-mm3/include/linux/mm.h	Fri Sep 19 14:05:37 2003
+++ linux-2.6.0-test5-numnodes_update/include/linux/mm.h	Fri Sep 19 14:52:04 2003
@@ -323,7 +323,6 @@ static inline void put_page(struct page 
  * The zone field is never updated after free_area_init_core()
  * sets it, so none of the operations on it need to be atomic.
  */
-#define NODE_SHIFT 4
 #define ZONE_SHIFT (BITS_PER_LONG - 8)
 
 struct zone;
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test5-mm3/include/linux/mmzone.h linux-2.6.0-test5-numnodes_update/include/linux/mmzone.h
--- linux-2.6.0-test5-mm3/include/linux/mmzone.h	Fri Sep 19 14:05:37 2003
+++ linux-2.6.0-test5-numnodes_update/include/linux/mmzone.h	Fri Sep 19 14:52:06 2003
@@ -10,14 +10,8 @@
 #include <linux/wait.h>
 #include <linux/cache.h>
 #include <linux/threads.h>
+#include <linux/numa.h>
 #include <asm/atomic.h>
-#ifdef CONFIG_DISCONTIGMEM
-#include <asm/numnodes.h>
-#endif
-#ifndef NODES_SHIFT
-#define NODES_SHIFT	0
-#endif
-#define MAX_NUMNODES	(1 << NODES_SHIFT)
 
 /* Free memory management - zoned buddy allocator.  */
 #ifndef CONFIG_FORCE_MAX_ZONEORDER
@@ -313,12 +307,19 @@ extern struct pglist_data contig_page_da
 #else /* CONFIG_DISCONTIGMEM */
 
 #include <asm/mmzone.h>
+
+#if BITS_PER_LONG == 32
 /*
- * page->zone is currently 8 bits
- * there are 3 zones (2 bits)
- * this leaves 8-2=6 bits for nodes
+ * with 32 bit flags field, page->zone is currently 8 bits.
+ * there are 3 zones (2 bits) and this leaves 8-2=6 bits for nodes.
  */
 #define MAX_NODES_SHIFT		6
+#elif BITS_PER_LONG == 64
+/*
+ * with 64 bit flags field, there's plenty of room.
+ */
+#define MAX_NODES_SHIFT		10
+#endif
 
 #endif /* !CONFIG_DISCONTIGMEM */
 
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test5-mm3/include/linux/numa.h linux-2.6.0-test5-numnodes_update/include/linux/numa.h
--- linux-2.6.0-test5-mm3/include/linux/numa.h	Wed Dec 31 16:00:00 1969
+++ linux-2.6.0-test5-numnodes_update/include/linux/numa.h	Fri Sep 19 14:52:04 2003
@@ -0,0 +1,16 @@
+#ifndef _LINUX_NUMA_H
+#define _LINUX_NUMA_H
+
+#include <linux/config.h>
+
+#ifdef CONFIG_DISCONTIGMEM
+#include <asm/numnodes.h>
+#endif
+
+#ifndef NODES_SHIFT
+#define NODES_SHIFT     0
+#endif
+
+#define MAX_NUMNODES    (1 << NODES_SHIFT)
+
+#endif /* _LINUX_NUMA_H */

--------------090103070806030807000000--

