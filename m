Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313114AbSDSWGc>; Fri, 19 Apr 2002 18:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313115AbSDSWGb>; Fri, 19 Apr 2002 18:06:31 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:41627 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S313114AbSDSWG2>; Fri, 19 Apr 2002 18:06:28 -0400
Date: Fri, 19 Apr 2002 16:04:53 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [RFC] / [CFT] convert node_start_paddr to node_start_pfn
Message-ID: <1985660000.1019257493@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At present we store node_start_paddr as an unsigned long, which is
not correct - it may work for some architectures, but not for others
(eg ia32 with PAE, where a paddr is 36 bits and a ulong is 32).

Below is a (untested) patch to convert the paddr to a pfn. A similar
patch for zone_start_paddr will follow shortly.

node_start_pfn == node_start_paddr >> PAGE_SHIFT

M.

diff -urN virgin-2.5.8/arch/alpha/mm/numa.c
linux-2.5.8-node_start_paddr/arch/alpha/mm/numa.c
--- virgin-2.5.8/arch/alpha/mm/numa.c	Sun Apr 14 12:18:43 2002
+++ linux-2.5.8-node_start_paddr/arch/alpha/mm/numa.c	Fri Apr 19 15:24:11
2002
@@ -372,7 +372,7 @@
 		totalram_pages += free_all_bootmem_node(NODE_DATA(nid));
 
 		lmem_map = NODE_MEM_MAP(nid);
-		pfn = NODE_DATA(nid)->node_start_paddr >> PAGE_SHIFT;
+		pfn = NODE_DATA(nid)->node_start_pfn;
 		for (i = 0; i < PLAT_NODE_DATA_SIZE(nid); i++, pfn++)
 			if (page_is_ram(pfn) && PageReserved(lmem_map+i))
 				reservedpages++;
diff -urN virgin-2.5.8/include/asm-alpha/mmzone.h
linux-2.5.8-node_start_paddr/include/asm-alpha/mmzone.h
--- virgin-2.5.8/include/asm-alpha/mmzone.h	Sun Apr 14 12:18:50 2002
+++ linux-2.5.8-node_start_paddr/include/asm-alpha/mmzone.h	Fri Apr 19
15:28:34 2002
@@ -52,14 +52,15 @@
 
 #if 1
 #define PLAT_NODE_DATA_LOCALNR(p, n)	\
-	(((p) - PLAT_NODE_DATA(n)->gendata.node_start_paddr) >> PAGE_SHIFT)
+	(((p) >> PAGE_SHIFT) - PLAT_NODE_DATA(n)->gendata.node_start_pfn)
 #else
 static inline unsigned long
 PLAT_NODE_DATA_LOCALNR(unsigned long p, int n)
 {
 	unsigned long temp;
-	temp = p - PLAT_NODE_DATA(n)->gendata.node_start_paddr;
-	return (temp >> PAGE_SHIFT);
+	temp = p >> PAGE_SHIFT;
+	temp -= PLAT_NODE_DATA(n)->gendata.node_start_pfn;
+	return (temp);
 }
 #endif
 
@@ -96,7 +97,7 @@
  * and returns the kaddr corresponding to first physical page in the
  * node's mem_map.
  */
-#define LOCAL_BASE_ADDR(kaddr)	((unsigned
long)__va(NODE_DATA(KVADDR_TO_NID(kaddr))->node_start_paddr))
+#define LOCAL_BASE_ADDR(kaddr)	( (unsigned long)
__va(NODE_DATA(KVADDR_TO_NID(kaddr))->node_start_pfn << PAGE_SHIFT) )
 
 #define LOCAL_MAP_NR(kvaddr) \
 	(((unsigned long)(kvaddr)-LOCAL_BASE_ADDR(kvaddr)) >> PAGE_SHIFT)
diff -urN virgin-2.5.8/include/asm-mips64/mmzone.h
linux-2.5.8-node_start_paddr/include/asm-mips64/mmzone.h
--- virgin-2.5.8/include/asm-mips64/mmzone.h	Sun Apr 14 12:18:44 2002
+++ linux-2.5.8-node_start_paddr/include/asm-mips64/mmzone.h	Fri Apr 19
15:30:59 2002
@@ -27,7 +27,7 @@
 #define PLAT_NODE_DATA_STARTNR(n)
(PLAT_NODE_DATA(n)->gendata.node_start_mapnr)
 #define PLAT_NODE_DATA_SIZE(n)	     (PLAT_NODE_DATA(n)->gendata.node_size)
 #define PLAT_NODE_DATA_LOCALNR(p, n) \
-		(((p) - PLAT_NODE_DATA(n)->gendata.node_start_paddr) >> PAGE_SHIFT)
+	(((p) >> PAGE_SHIFT) - PLAT_NODE_DATA(n)->gendata.node_start_pfn)
 
 #define numa_node_id()	cputocnode(current->processor)
 
Binary files virgin-2.5.8/include/linux/.mmzone.h.foreachnode.swp and
linux-2.5.8-node_start_paddr/include/linux/.mmzone.h.foreachnode.swp differ
diff -urN virgin-2.5.8/include/linux/mmzone.h
linux-2.5.8-node_start_paddr/include/linux/mmzone.h
--- virgin-2.5.8/include/linux/mmzone.h	Sun Apr 14 12:18:43 2002
+++ linux-2.5.8-node_start_paddr/include/linux/mmzone.h	Fri Apr 19 15:23:28
2002
@@ -132,7 +132,7 @@
 	struct page *node_mem_map;
 	unsigned long *valid_addr_bitmap;
 	struct bootmem_data *bdata;
-	unsigned long node_start_paddr;
+	unsigned long node_start_pfn;
 	unsigned long node_start_mapnr;
 	unsigned long node_size;
 	int node_id;
diff -urN virgin-2.5.8/mm/page_alloc.c
linux-2.5.8-node_start_paddr/mm/page_alloc.c
--- virgin-2.5.8/mm/page_alloc.c	Sun Apr 14 12:18:44 2002
+++ linux-2.5.8-node_start_paddr/mm/page_alloc.c	Fri Apr 19 15:32:01 2002
@@ -746,7 +746,7 @@
 	}
 	*gmap = pgdat->node_mem_map = lmem_map;
 	pgdat->node_size = totalpages;
-	pgdat->node_start_paddr = zone_start_paddr;
+	pgdat->node_start_pfn = zone_start_paddr >> PAGE_SHIFT;
 	pgdat->node_start_mapnr = (lmem_map - mem_map);
 	pgdat->nr_zones = 0;
 

