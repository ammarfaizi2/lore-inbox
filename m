Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267437AbTCERMz>; Wed, 5 Mar 2003 12:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267439AbTCERMz>; Wed, 5 Mar 2003 12:12:55 -0500
Received: from franka.aracnet.com ([216.99.193.44]:12953 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267437AbTCERMq>; Wed, 5 Mar 2003 12:12:46 -0500
Date: Wed, 05 Mar 2003 09:23:10 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 1/6 Share common physnode_map code between NUMA-Q and Summit
Message-ID: <157940000.1046884990@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Andy Whitcroft

Share a common physnode_map structure between NUMA-Q and Summit.

diff -urpN -X /home/fletch/.diff.exclude 000-virgin/arch/i386/kernel/i386_ksyms.c 010-common_physmap/arch/i386/kernel/i386_ksyms.c
--- 000-virgin/arch/i386/kernel/i386_ksyms.c	Wed Mar  5 07:36:57 2003
+++ 010-common_physmap/arch/i386/kernel/i386_ksyms.c	Wed Mar  5 08:44:17 2003
@@ -68,6 +68,7 @@ EXPORT_SYMBOL(EISA_bus);
 EXPORT_SYMBOL(MCA_bus);
 #ifdef CONFIG_DISCONTIGMEM
 EXPORT_SYMBOL(node_data);
+EXPORT_SYMBOL(physnode_map);
 #endif
 #ifdef CONFIG_X86_NUMAQ
 EXPORT_SYMBOL(xquad_portio);
diff -urpN -X /home/fletch/.diff.exclude 000-virgin/arch/i386/kernel/numaq.c 010-common_physmap/arch/i386/kernel/numaq.c
--- 000-virgin/arch/i386/kernel/numaq.c	Wed Mar  5 07:36:57 2003
+++ 010-common_physmap/arch/i386/kernel/numaq.c	Wed Mar  5 08:44:17 2003
@@ -31,8 +31,7 @@
 #include <asm/numaq.h>
 
 /* These are needed before the pgdat's are created */
-unsigned long node_start_pfn[MAX_NUMNODES];
-unsigned long node_end_pfn[MAX_NUMNODES];
+extern long node_start_pfn[], node_end_pfn[];
 
 #define	MB_TO_PAGES(addr) ((addr) << (20 - PAGE_SHIFT))
 
@@ -65,25 +64,7 @@ static void __init smp_dump_qct(void)
 	}
 }
 
-/*
- * -----------------------------------------
- *
- * functions related to physnode_map
- *
- * -----------------------------------------
- */
-/*
- * physnode_map keeps track of the physical memory layout of the
- * numaq nodes on a 256Mb break (each element of the array will
- * represent 256Mb of memory and will be marked by the node id.  so,
- * if the first gig is on node 0, and the second gig is on node 1
- * physnode_map will contain:
- * physnode_map[0-3] = 0;
- * physnode_map[4-7] = 1;
- * physnode_map[8- ] = -1;
- */
-int physnode_map[MAX_ELEMENTS] = { [0 ... (MAX_ELEMENTS - 1)] = -1};
-EXPORT_SYMBOL(physnode_map);
+extern int physnode_map[];
 
 /*
  * for each node mark the regions
diff -urpN -X /home/fletch/.diff.exclude 000-virgin/arch/i386/kernel/srat.c 010-common_physmap/arch/i386/kernel/srat.c
--- 000-virgin/arch/i386/kernel/srat.c	Wed Mar  5 07:36:57 2003
+++ 010-common_physmap/arch/i386/kernel/srat.c	Wed Mar  5 08:44:17 2003
@@ -57,8 +57,7 @@ static int num_memory_chunks;		/* total 
 static int zholes_size_init;
 static unsigned long zholes_size[MAX_NUMNODES * MAX_NR_ZONES];
 
-unsigned long node_start_pfn[MAX_NUMNODES];
-unsigned long node_end_pfn[MAX_NUMNODES];
+extern unsigned long node_start_pfn[], node_end_pfn[];
 
 extern void * boot_ioremap(unsigned long, unsigned long);
 
@@ -182,30 +181,19 @@ static __init void chunk_to_zones(unsign
 	}
 }
 
-/*
- * physnode_map keeps track of the physical memory layout of the
- * numaq nodes on a 256Mb break (each element of the array will
- * represent 256Mb of memory and will be marked by the node id.  so,
- * if the first gig is on node 0, and the second gig is on node 1
- * physnode_map will contain:
- * physnode_map[0-3] = 0;
- * physnode_map[4-7] = 1;
- * physnode_map[8- ] = -1;
- */
-int pfnnode_map[MAX_ELEMENTS] = { [0 ... (MAX_ELEMENTS - 1)] = -1};
-EXPORT_SYMBOL(pfnnode_map);
-
-static void __init initialize_pfnnode_map(void)
+static void __init initialize_physnode_map(void)
 {
-	unsigned long topofchunk, cur = 0;
 	int i;
-	
-	for (i = 0; i < num_memory_chunks; i++) {
-		cur = node_memory_chunk[i].start_pfn;
-		topofchunk = node_memory_chunk[i].end_pfn;
-		while (cur < topofchunk) {
-			pfnnode_map[PFN_TO_ELEMENT(cur)] = node_memory_chunk[i].nid;
-			cur ++;
+	unsigned long pfn;
+	struct node_memory_chunk_s *nmcp;
+
+	/* Run the list of memory chunks and fill in the phymap. */
+	nmcp = node_memory_chunk;
+	for (i = num_memory_chunks; --i >= 0; nmcp++) {
+		for (pfn = nmcp->start_pfn; pfn <= nmcp->end_pfn;
+						pfn += PAGES_PER_ELEMENT)
+		{
+			physnode_map[pfn / PAGES_PER_ELEMENT] = (int)nmcp->nid;
 		}
 	}
 }
@@ -272,7 +260,7 @@ static int __init acpi20_parse_srat(stru
 	for (i = 0; i < num_memory_chunks; i++)
 		node_memory_chunk[i].nid = pxm_to_nid_map[node_memory_chunk[i].pxm];
 
-	initialize_pfnnode_map();
+	initialize_physnode_map();
 	
 	printk("pxm bitmap: ");
 	for (i = 0; i < sizeof(pxm_bitmap); i++) {
diff -urpN -X /home/fletch/.diff.exclude 000-virgin/arch/i386/mm/discontig.c 010-common_physmap/arch/i386/mm/discontig.c
--- 000-virgin/arch/i386/mm/discontig.c	Wed Mar  5 07:36:57 2003
+++ 010-common_physmap/arch/i386/mm/discontig.c	Wed Mar  5 08:44:17 2003
@@ -36,11 +36,36 @@
 struct pglist_data *node_data[MAX_NUMNODES];
 bootmem_data_t node0_bdata;
 
+/*
+ * numa interface - we expect the numa architecture specfic code to have
+ *                  populated the following initialisation.
+ *
+ * 1) numnodes         - the total number of nodes configured in the system
+ * 2) physnode_map     - the mapping between a pfn and owning node
+ * 3) node_start_pfn   - the starting page frame number for a node
+ * 3) node_end_pfn     - the ending page fram number for a node
+ */
+
+/*
+ * physnode_map keeps track of the physical memory layout of a generic
+ * numa node on a 256Mb break (each element of the array will
+ * represent 256Mb of memory and will be marked by the node id.  so,
+ * if the first gig is on node 0, and the second gig is on node 1
+ * physnode_map will contain:
+ *
+ *     physnode_map[0-3] = 0;
+ *     physnode_map[4-7] = 1;
+ *     physnode_map[8- ] = -1;
+ */
+int physnode_map[MAX_ELEMENTS] = { [0 ... (MAX_ELEMENTS - 1)] = -1};
+
+unsigned long node_start_pfn[MAX_NUMNODES];
+unsigned long node_end_pfn[MAX_NUMNODES];
+
 extern unsigned long find_max_low_pfn(void);
 extern void find_max_pfn(void);
 extern void one_highpage_init(struct page *, int, int);
 
-extern unsigned long node_start_pfn[], node_end_pfn[];
 extern struct e820map e820;
 extern char _end;
 extern unsigned long highend_pfn, highstart_pfn;
diff -urpN -X /home/fletch/.diff.exclude 000-virgin/include/asm-i386/mmzone.h 010-common_physmap/include/asm-i386/mmzone.h
--- 000-virgin/include/asm-i386/mmzone.h	Wed Mar  5 08:23:16 2003
+++ 010-common_physmap/include/asm-i386/mmzone.h	Wed Mar  5 08:44:27 2003
@@ -10,14 +10,6 @@
 
 #ifdef CONFIG_DISCONTIGMEM
 
-#ifdef CONFIG_X86_NUMAQ
-#include <asm/numaq.h>
-#elif CONFIG_X86_SUMMIT
-#include <asm/srat.h>
-#else
-#define pfn_to_nid(pfn)		(0)
-#endif /* CONFIG_X86_NUMAQ */
-
 extern struct pglist_data *node_data[];
 
 /*
@@ -101,5 +93,38 @@ extern struct pglist_data *node_data[];
  * ( pfn_to_pgdat(pfn) && ((pfn) < node_end_pfn(pfn_to_nid(pfn))) ) 
  */ 
 #define pfn_valid(pfn)          ((pfn) < num_physpages)
+
+/*
+ * generic node memory support, the following assumptions apply:
+ *
+ * 1) memory comes in 256Mb contigious chunks which are either present or not
+ * 2) we will not have more than 64Gb in total
+ *
+ * for now assume that 64Gb is max amount of RAM for whole system
+ *    64Gb / 4096bytes/page = 16777216 pages
+ */
+#define MAX_NR_PAGES 16777216
+#define MAX_ELEMENTS 256
+#define PAGES_PER_ELEMENT (MAX_NR_PAGES/MAX_ELEMENTS)
+
+extern int physnode_map[];
+
+static inline int pfn_to_nid(unsigned long pfn)
+{
+	return(physnode_map[(pfn) / PAGES_PER_ELEMENT]);
+}
+static inline struct pglist_data *pfn_to_pgdat(unsigned long pfn)
+{
+	return(NODE_DATA(pfn_to_nid(pfn)));
+}
+
+#ifdef CONFIG_X86_NUMAQ
+#include <asm/numaq.h>
+#elif CONFIG_X86_SUMMIT
+#include <asm/srat.h>
+#else
+#define pfn_to_nid(pfn)		(0)
+#endif /* CONFIG_X86_NUMAQ */
+
 #endif /* CONFIG_DISCONTIGMEM */
 #endif /* _ASM_MMZONE_H_ */
diff -urpN -X /home/fletch/.diff.exclude 000-virgin/include/asm-i386/numaq.h 010-common_physmap/include/asm-i386/numaq.h
--- 000-virgin/include/asm-i386/numaq.h	Wed Mar  5 07:37:06 2003
+++ 010-common_physmap/include/asm-i386/numaq.h	Wed Mar  5 08:44:17 2003
@@ -28,18 +28,8 @@
 
 #ifdef CONFIG_X86_NUMAQ
 
-/*
- * for now assume that 64Gb is max amount of RAM for whole system
- *    64Gb / 4096bytes/page = 16777216 pages
- */
-#define MAX_NR_PAGES 16777216
-#define MAX_ELEMENTS 256
-#define PAGES_PER_ELEMENT (16777216/256)
-
 extern int physnode_map[];
-#define pfn_to_nid(pfn)	({ physnode_map[(pfn) / PAGES_PER_ELEMENT]; })
-#define pfn_to_pgdat(pfn) NODE_DATA(pfn_to_nid(pfn))
-#define PHYSADDR_TO_NID(pa) pfn_to_nid(pa >> PAGE_SHIFT)
+
 #define MAX_NUMNODES		8
 extern void get_memcfg_numaq(void);
 #define get_memcfg_numa() get_memcfg_numaq()
diff -urpN -X /home/fletch/.diff.exclude 000-virgin/include/asm-i386/srat.h 010-common_physmap/include/asm-i386/srat.h
--- 000-virgin/include/asm-i386/srat.h	Wed Mar  5 07:37:06 2003
+++ 010-common_physmap/include/asm-i386/srat.h	Wed Mar  5 08:44:17 2003
@@ -27,17 +27,7 @@
 #ifndef _ASM_SRAT_H_
 #define _ASM_SRAT_H_
 
-/*
- * each element in pfnnode_map represents 256 MB (2^28) of pages.
- * so, to represent 64GB we need 256 elements.
- */
-#define MAX_ELEMENTS 256
-#define PFN_TO_ELEMENT(pfn) ((pfn)>>(28 - PAGE_SHIFT))
-
-extern int pfnnode_map[];
-#define pfn_to_nid(pfn) ({ pfnnode_map[PFN_TO_ELEMENT(pfn)]; })
-#define pfn_to_pgdat(pfn) NODE_DATA(pfn_to_nid(pfn))
-#define PHYSADDR_TO_NID(pa) pfn_to_nid(pa >> PAGE_SHIFT)
+extern int physnode_map[];
 #define MAX_NUMNODES		8
 extern void get_memcfg_from_srat(void);
 extern unsigned long *get_zholes_size(int);

