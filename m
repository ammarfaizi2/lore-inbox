Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbTIPAmR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 20:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbTIPAlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 20:41:49 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:16112 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261732AbTIPAlF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 20:41:05 -0400
Message-ID: <3F665B5B.3000409@us.ibm.com>
Date: Mon, 15 Sep 2003 17:37:47 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@sgi.com>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk, wli@holomorphy.com
Subject: [PATCH] Clean up MAX_NR_NODES/NUMNODES/etc. [5/5]
References: <20030910153601.36219ed8.akpm@osdl.org> <41000000.1063237600@flay> <20030911000303.GA20329@sgi.com> <3F6659DF.1090508@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------020105000003060905060108"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020105000003060905060108
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Matthew Dobson wrote:
> Ok, I made an attempt to clean up this mess quite a while ago (2.5.47), 
> but that patch is utterly useless now.  At Martin's urging I've created 
> a new series of patches to resolve this.
> 
> 01 - Make sure MAX_NUMNODES is defined in one and only one place. Remove 
> superfluous definitions.  Instead of defining MAX_NUMNODES in 
> asm/numnodes.h, we define NODES_SHIFT there.  Then in linux/mmzone.h we 
> turn that NODES_SHIFT value into MAX_NUMNODES.
> 
> 02 - Remove MAX_NR_NODES.  This value is only used in a couple of 
> places, and it's incorrectly used in all those places as far as I can 
> tell.  Replace with MAX_NUMNODES.  Create MAX_NODES_SHIFT and use this 
> value to check NODES_SHIFT is appropriate.  A possible future patch 
> should make MAX_NODES_SHIFT vary based on 32 vs. 64 bit archs.
> 
> 03 - Fix up the sh arch.  sh defined NR_NODES, change sh to use standard 
> MAX_NUMNODES instead.
> 
> 04 - Fix up the arm arch.  This needs to be reviewed.  Relatively 
> straightforward replacement of NR_NODES with standard MAX_NUMNODES.
> 
> 05 - Fix up the ia64 arch.  This *definitely* needs to be reviewed. This 
> code made my head hurt.  I think I may have gotten it right. Totally 
> untested.

Cheers!

-Matt

--------------020105000003060905060108
Content-Type: text/plain;
 name="05-fix-ia64.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="05-fix-ia64.patch"

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test5-arm/arch/ia64/kernel/acpi.c linux-2.6.0-test5-ia64/arch/ia64/kernel/acpi.c
--- linux-2.6.0-test5-arm/arch/ia64/kernel/acpi.c	Mon Sep  8 12:50:04 2003
+++ linux-2.6.0-test5-ia64/arch/ia64/kernel/acpi.c	Mon Sep 15 14:25:47 2003
@@ -41,6 +41,7 @@
 #include <linux/irq.h>
 #include <linux/acpi.h>
 #include <linux/efi.h>
+#include <linux/mmzone.h>
 #include <asm/io.h>
 #include <asm/iosapic.h>
 #include <asm/machvec.h>
@@ -341,7 +342,7 @@ static u32 __initdata pxm_flag[PXM_FLAG_
 #define pxm_bit_test(bit)	(test_bit(bit,(void *)pxm_flag))
 /* maps to convert between proximity domain and logical node ID */
 int __initdata pxm_to_nid_map[MAX_PXM_DOMAINS];
-int __initdata nid_to_pxm_map[NR_NODES];
+int __initdata nid_to_pxm_map[MAX_NUMNODES];
 static struct acpi_table_slit __initdata *slit_table;
 
 /*
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test5-arm/arch/ia64/mm/discontig.c linux-2.6.0-test5-ia64/arch/ia64/mm/discontig.c
--- linux-2.6.0-test5-arm/arch/ia64/mm/discontig.c	Mon Sep  8 12:50:22 2003
+++ linux-2.6.0-test5-ia64/arch/ia64/mm/discontig.c	Mon Sep 15 14:26:52 2003
@@ -13,7 +13,6 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/bootmem.h>
-#include <linux/mmzone.h>
 #include <linux/acpi.h>
 #include <linux/efi.h>
 
@@ -23,10 +22,10 @@
  */
 #define GRANULEROUNDUP(n) (((n)+IA64_GRANULE_SIZE-1) & ~(IA64_GRANULE_SIZE-1))
 
-static struct ia64_node_data	*node_data[NR_NODES];
-static long			boot_pg_data[8*NR_NODES+sizeof(pg_data_t)]  __initdata;
-static pg_data_t		*pg_data_ptr[NR_NODES] __initdata;
-static bootmem_data_t		bdata[NR_NODES][NR_BANKS_PER_NODE+1] __initdata;
+static struct ia64_node_data	*node_data[MAX_NUMNODES];
+static long			boot_pg_data[8*MAX_NUMNODES+sizeof(pg_data_t)]  __initdata;
+static pg_data_t		*pg_data_ptr[MAX_NUMNODES] __initdata;
+static bootmem_data_t		bdata[MAX_NUMNODES][NR_BANKS_PER_NODE+1] __initdata;
 
 extern int  filter_rsvd_memory (unsigned long start, unsigned long end, void *arg);
 
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test5-arm/arch/ia64/mm/numa.c linux-2.6.0-test5-ia64/arch/ia64/mm/numa.c
--- linux-2.6.0-test5-arm/arch/ia64/mm/numa.c	Mon Sep  8 12:49:58 2003
+++ linux-2.6.0-test5-ia64/arch/ia64/mm/numa.c	Mon Sep 15 14:27:39 2003
@@ -15,7 +15,6 @@
 #include <linux/mm.h>
 #include <linux/init.h>
 #include <linux/bootmem.h>
-#include <linux/mmzone.h>
 #include <asm/numa.h>
 
 /*
@@ -29,7 +28,7 @@ struct node_cpuid_s node_cpuid[NR_CPUS];
  * This is a matrix with "distances" between nodes, they should be
  * proportional to the memory access latency ratios.
  */
-u8 numa_slit[NR_NODES * NR_NODES];
+u8 numa_slit[MAX_NUMNODES * MAX_NUMNODES];
 
 /* Identify which cnode a physical address resides on */
 int
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test5-arm/include/asm-ia64/acpi.h linux-2.6.0-test5-ia64/include/asm-ia64/acpi.h
--- linux-2.6.0-test5-arm/include/asm-ia64/acpi.h	Mon Sep  8 12:50:23 2003
+++ linux-2.6.0-test5-ia64/include/asm-ia64/acpi.h	Mon Sep 15 16:09:52 2003
@@ -109,7 +109,7 @@ int acpi_get_addr_space (void *obj, u8 t
 /* Proximity bitmap length; _PXM is at most 255 (8 bit)*/
 #define MAX_PXM_DOMAINS (256)
 extern int __initdata pxm_to_nid_map[MAX_PXM_DOMAINS];
-extern int __initdata nid_to_pxm_map[NR_NODES];
+extern int __initdata nid_to_pxm_map[MAX_NUMNODES];
 #endif
 
 #endif /*__KERNEL__*/
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test5-arm/include/asm-ia64/mmzone.h linux-2.6.0-test5-ia64/include/asm-ia64/mmzone.h
--- linux-2.6.0-test5-arm/include/asm-ia64/mmzone.h	Mon Sep  8 12:50:59 2003
+++ linux-2.6.0-test5-ia64/include/asm-ia64/mmzone.h	Mon Sep 15 16:24:33 2003
@@ -92,14 +92,12 @@
 extern unsigned long max_low_pfn;
 
 
-#ifdef CONFIG_IA64_DIG
+#if defined(CONFIG_IA64_DIG)
 
 /*
  * Platform definitions for DIG platform with contiguous memory.
  */
-#define MAX_PHYSNODE_ID	8	/* Maximum node number +1 */
-#define NR_NODES	8	/* Maximum number of nodes in SSI */
-
+#define MAX_PHYSNODE_ID	8		/* Maximum node number +1 */
 #define MAX_PHYS_MEMORY	(1UL << 40)	/* 1 TB */
 
 /*
@@ -119,37 +117,34 @@ extern unsigned long max_low_pfn;
 # error Unsupported bank and nodesize!
 #endif
 #define BANKSIZE		(1UL << BANKSHIFT)
-#define BANK_OFFSET(addr)	((unsigned long)(addr) & (BANKSIZE-1))
-#define NR_BANKS		(NR_BANKS_PER_NODE * NR_NODES)
-
-/*
- * VALID_MEM_KADDR returns a boolean to indicate if a kaddr is
- * potentially a valid cacheable identity mapped RAM memory address.
- * Note that the RAM may or may not actually be present!!
- */
-#define VALID_MEM_KADDR(kaddr)	1
-
-/*
- * Given a nodeid & a bank number, find the address of the mem_map
- * entry for the first page of the bank.
- */
-#define BANK_MEM_MAP_INDEX(kaddr) \
-	(((unsigned long)(kaddr) & (MAX_PHYS_MEMORY-1)) >> BANKSHIFT)
 
 #elif defined(CONFIG_IA64_SGI_SN2)
+
 /*
  * SGI SN2 discontig definitions
  */
 #define MAX_PHYSNODE_ID	2048	/* 2048 node ids (also called nasid) */
-#define NR_NODES	128	/* Maximum number of nodes in SSI */
 #define MAX_PHYS_MEMORY	(1UL << 49)
 
-#define BANKSHIFT		38
 #define NR_BANKS_PER_NODE	4
+#define BANKSHIFT		38
 #define SN2_NODE_SIZE		(64UL*1024*1024*1024)	/* 64GB per node */
 #define BANKSIZE		(SN2_NODE_SIZE/NR_BANKS_PER_NODE)
+
+#endif /* CONFIG_IA64_DIG */
+
+#if defined(CONFIG_IA64_DIG) || defined (CONFIG_IA64_SGI_SN2)
+/* Common defines for both platforms */
+#include <asm/numnodes.h>
 #define BANK_OFFSET(addr)	((unsigned long)(addr) & (BANKSIZE-1))
-#define NR_BANKS		(NR_BANKS_PER_NODE * NR_NODES)
+#define NR_BANKS		(NR_BANKS_PER_NODE * (1 << NODES_SHIFT))
+#define NR_MEMBLKS		(NR_BANKS)
+
+/*
+ * VALID_MEM_KADDR returns a boolean to indicate if a kaddr is
+ * potentially a valid cacheable identity mapped RAM memory address.
+ * Note that the RAM may or may not actually be present!!
+ */
 #define VALID_MEM_KADDR(kaddr)	1
 
 /*
@@ -159,5 +154,6 @@ extern unsigned long max_low_pfn;
 #define BANK_MEM_MAP_INDEX(kaddr) \
 	(((unsigned long)(kaddr) & (MAX_PHYS_MEMORY-1)) >> BANKSHIFT)
 
-#endif /* CONFIG_IA64_DIG */
+#endif /* CONFIG_IA64_DIG || CONFIG_IA64_SGI_SN2 */
+
 #endif /* _ASM_IA64_MMZONE_H */
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test5-arm/include/asm-ia64/nodedata.h linux-2.6.0-test5-ia64/include/asm-ia64/nodedata.h
--- linux-2.6.0-test5-arm/include/asm-ia64/nodedata.h	Mon Sep  8 12:50:18 2003
+++ linux-2.6.0-test5-ia64/include/asm-ia64/nodedata.h	Mon Sep 15 16:07:59 2003
@@ -14,7 +14,7 @@
 #define _ASM_IA64_NODEDATA_H
 
 
-#include <asm/mmzone.h>
+#include <linux/mmzone.h>
 
 /*
  * Node Data. One of these structures is located on each node of a NUMA system.
@@ -24,9 +24,9 @@ struct pglist_data;
 struct ia64_node_data {
 	short			active_cpu_count;
 	short			node;
-        struct pglist_data	*pg_data_ptrs[NR_NODES];
+        struct pglist_data	*pg_data_ptrs[MAX_NUMNODES];
 	struct page		*bank_mem_map_base[NR_BANKS];
-	struct ia64_node_data	*node_data_ptrs[NR_NODES];
+	struct ia64_node_data	*node_data_ptrs[MAX_NUMNODES];
 	short			node_id_map[NR_BANKS];
 };
 
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test5-arm/include/asm-ia64/numa.h linux-2.6.0-test5-ia64/include/asm-ia64/numa.h
--- linux-2.6.0-test5-arm/include/asm-ia64/numa.h	Mon Sep  8 12:50:01 2003
+++ linux-2.6.0-test5-ia64/include/asm-ia64/numa.h	Mon Sep 15 16:07:24 2003
@@ -13,17 +13,11 @@
 
 #ifdef CONFIG_NUMA
 
-#ifdef CONFIG_DISCONTIGMEM
-# include <asm/mmzone.h>
-# define NR_MEMBLKS   (NR_BANKS)
-#else
-# define NR_NODES     (8)
-# define NR_MEMBLKS   (NR_NODES * 8)
-#endif
+#include <linux/mmzone.h>
 
 #include <linux/cache.h>
 extern volatile char cpu_to_node_map[NR_CPUS] __cacheline_aligned;
-extern volatile unsigned long node_to_cpu_mask[NR_NODES] __cacheline_aligned;
+extern volatile unsigned long node_to_cpu_mask[MAX_NUMNODES] __cacheline_aligned;
 
 /* Stuff below this line could be architecture independent */
 
@@ -57,7 +51,7 @@ extern struct node_cpuid_s node_cpuid[NR
  * proportional to the memory access latency ratios.
  */
 
-extern u8 numa_slit[NR_NODES * NR_NODES];
+extern u8 numa_slit[MAX_NUMNODES * MAX_NUMNODES];
 #define node_distance(from,to) (numa_slit[from * numnodes + to])
 
 extern int paddr_to_nid(unsigned long paddr);
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test5-arm/include/asm-ia64/numnodes.h linux-2.6.0-test5-ia64/include/asm-ia64/numnodes.h
--- linux-2.6.0-test5-arm/include/asm-ia64/numnodes.h	Mon Sep  8 12:50:58 2003
+++ linux-2.6.0-test5-ia64/include/asm-ia64/numnodes.h	Mon Sep 15 14:37:20 2003
@@ -1,7 +1,12 @@
 #ifndef _ASM_MAX_NUMNODES_H
 #define _ASM_MAX_NUMNODES_H
 
-#include <asm/mmzone.h>
-#define MAX_NUMNODES	NR_NODES
+#ifdef CONFIG_IA64_DIG
+/* Max 8 Nodes */
+#define NODES_SHIFT	3
+#elif defined(CONFIG_IA64_SGI_SN2)
+/* Max 128 Nodes */
+#define NODES_SHIFT	7
+#endif
 
 #endif /* _ASM_MAX_NUMNODES_H */
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test5-arm/include/asm-ia64/sn/pda.h linux-2.6.0-test5-ia64/include/asm-ia64/sn/pda.h
--- linux-2.6.0-test5-arm/include/asm-ia64/sn/pda.h	Mon Sep  8 12:50:28 2003
+++ linux-2.6.0-test5-ia64/include/asm-ia64/sn/pda.h	Mon Sep 15 16:10:47 2003
@@ -10,6 +10,7 @@
 
 #include <linux/config.h>
 #include <linux/cache.h>
+#include <linux/mmzone.h>
 #include <asm/percpu.h>
 #include <asm/system.h>
 #include <asm/processor.h>
@@ -56,7 +57,7 @@ typedef struct pda_s {
 
 	unsigned long	sn_soft_irr[4];
 	unsigned long	sn_in_service_ivecs[4];
-	short		cnodeid_to_nasid_table[NR_NODES];	
+	short		cnodeid_to_nasid_table[MAX_NUMNODES];	
 	int		sn_lb_int_war_ticks;
 	int		sn_last_irq;
 	int		sn_first_irq;

--------------020105000003060905060108--

