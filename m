Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264901AbTLWCDn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 21:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264902AbTLWCDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 21:03:43 -0500
Received: from fujitsu1.fujitsu.com ([192.240.0.1]:26022 "EHLO
	fujitsu1.fujitsu.com") by vger.kernel.org with ESMTP
	id S264901AbTLWCCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 21:02:48 -0500
Date: Mon, 22 Dec 2003 18:02:23 -0800
From: Yasunori Goto <ygoto@fsw.fujitsu.com>
To: mbligh@aracnet.com,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Memory Hot add prototye patch v0.1
Message-Id: <20031222160030.1286.YGOTO@fsw.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.07.04 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

This is a Memory hot-add prototype patch against linux-2.6.0.

My target is a machine which has multi-node like NUMA.
So, I assume a situation that a node which has memory is hot-added.
I use the idea of multi-node emulation from Iwamoto-san's 
hot-remove patch. 
(http://marc.theaimsgroup.com/?l=linux-kernel&m=107025023221904&w=2)

  - Hot-added memory is used for highmem in this patch.
  - A node has only 1 contiguous memory block.
  - kswapd should be executed for added node, but not yet.

To hot-add memory, please execute following command.
$  echo "enable <number of node>" > /proc/memhotplug


TODO list is followings.
  - Port to IA64. (It is real target for me.
    But IA32 code is good for investigation of generic way, and
    many person can try to use it.)
  - Using SRAT table of ACPI to recognize multinode.
  - There might be some useful parts in memory hotadd project's patch.
    (http://sourceforge.net/projects/linux-memhotadd/)
  - The case that node has some discontiguous memory block.
    ( Should I use CONFIG_NONLINEAR? But, I don't have idea
     how to map the hole address of hot-removed memory
     by this configuration yet. If you have good idea, 
     I'm glad.)
  - etc. (it's a lot. ;-) )

Thanks.

-- 
Yasunori Goto <ygoto at fsw.fujitsu.com>

----------------------------------------------------------
diff -dupr linux-2.6.0/Makefile hotplugtest/Makefile
--- linux-2.6.0/Makefile	Thu Dec 18 11:04:31 2003
+++ hotplugtest/Makefile	Mon Dec 22 14:25:14 2003
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 0
-EXTRAVERSION =
+EXTRAVERSION = mem-hotplug
 
 # *DOCUMENTATION*
 # To see a list of typical targets execute "make help"
diff -dupr linux-2.6.0/arch/i386/Kconfig hotplugtest/arch/i386/Kconfig
--- linux-2.6.0/arch/i386/Kconfig	Thu Dec 18 11:02:25 2003
+++ hotplugtest/arch/i386/Kconfig	Mon Dec 22 14:25:14 2003
@@ -706,14 +706,18 @@ comment "NUMA (NUMA-Q) requires SMP, 64G
 comment "NUMA (Summit) requires SMP, 64GB highmem support, full ACPI"
 	depends on X86_SUMMIT && (!HIGHMEM64G || !ACPI || ACPI_HT_ONLY)
 
+config MEMHOTPLUGTEST
+	bool "Memory hotplug test"
+	default n
+
 config DISCONTIGMEM
 	bool
-	depends on NUMA
+	depends on NUMA || MEMHOTPLUGTEST
 	default y
 
 config HAVE_ARCH_BOOTMEM_NODE
 	bool
-	depends on NUMA
+	depends on NUMA || MEMHOTPLUGTEST
 	default y
 
 config HIGHPTE
diff -dupr linux-2.6.0/arch/i386/kernel/setup.c hotplugtest/arch/i386/kernel/setup.c
--- linux-2.6.0/arch/i386/kernel/setup.c	Thu Dec 18 11:02:25 2003
+++ hotplugtest/arch/i386/kernel/setup.c	Mon Dec 22 14:25:14 2003
@@ -114,6 +114,8 @@ extern void generic_apic_probe(char *);
 extern int root_mountflags;
 extern char _end[];
 
+extern unsigned long node_end_pfn[MAX_NUMNODES];
+
 unsigned long saved_videomode;
 
 #define RAMDISK_IMAGE_START_MASK  	0x07FF
@@ -612,7 +614,11 @@ unsigned long __init find_max_low_pfn(vo
 {
 	unsigned long max_low_pfn;
 
+#if CONFIG_MEMHOTPLUGTEST
+	max_low_pfn = node_end_pfn[0];
+#else
 	max_low_pfn = max_pfn;
+#endif
 	if (max_low_pfn > MAXMEM_PFN) {
 		if (highmem_pages == -1)
 			highmem_pages = max_pfn - MAXMEM_PFN;
diff -dupr linux-2.6.0/arch/i386/mm/discontig.c hotplugtest/arch/i386/mm/discontig.c
--- linux-2.6.0/arch/i386/mm/discontig.c	Thu Dec 18 11:02:25 2003
+++ hotplugtest/arch/i386/mm/discontig.c	Mon Dec 22 14:25:14 2003
@@ -28,6 +28,7 @@
 #include <linux/mmzone.h>
 #include <linux/highmem.h>
 #include <linux/initrd.h>
+#include <linux/proc_fs.h>
 #include <asm/e820.h>
 #include <asm/setup.h>
 #include <asm/mmzone.h>
@@ -111,6 +112,44 @@ int __init get_memcfg_numa_flat(void)
 	return 1;
 }
 
+int __init get_memcfg_numa_blks(void)
+{
+	int i, pfn;
+
+	printk("NUMA - single node, flat memory mode, but broken in several blocks\n");
+
+	/* Run the memory configuration and find the top of memory. */
+	find_max_pfn();
+	max_pfn = max_pfn & ~(PTRS_PER_PTE - 1);
+	for (i = 0; i < MAX_NUMNODES; i++) {
+		pfn = PFN_DOWN(256 << 20) * i;
+		node_start_pfn[i] = pfn;
+		pfn += PFN_DOWN(256 << 20);
+		if (pfn < max_pfn)
+			node_end_pfn[i] = pfn;
+		else {
+			node_end_pfn[i] = max_pfn;
+			i++;
+			printk("total %d blocks, max %d\n", i, (int)max_pfn);
+			break;
+		}
+	}
+
+	/* Fill in the physnode_map with our simplistic memory model,
+	   * all memory is in node 0.
+	 */
+	for (pfn = node_start_pfn[0]; pfn <= max_pfn;
+		pfn += PAGES_PER_ELEMENT) {
+		physnode_map[pfn / PAGES_PER_ELEMENT] = pfn / PFN_DOWN(256 << 20);
+	}
+
+	/* Indicate there is one node available. */
+	node_set_online(0);
+	numnodes = i;
+
+	return 1;
+}
+
 /*
  * Find the highest page frame number we have available for the node
  */
@@ -134,6 +173,12 @@ static void __init find_max_pfn_node(int
  */
 static void __init allocate_pgdat(int nid)
 {
+#if CONFIG_MEMHOTPLUGTEST
+	/* pg_dat allocate Node 0 statically */
+	NODE_DATA(nid) = (pg_data_t *)(__va(min_low_pfn << PAGE_SHIFT));
+	min_low_pfn += PFN_UP(sizeof(pg_data_t));
+	memset(NODE_DATA(nid), 0, sizeof(pg_data_t));
+#else
 	if (nid)
 		NODE_DATA(nid) = (pg_data_t *)node_remap_start_vaddr[nid];
 	else {
@@ -141,6 +186,7 @@ static void __init allocate_pgdat(int ni
 		min_low_pfn += PFN_UP(sizeof(pg_data_t));
 		memset(NODE_DATA(nid), 0, sizeof(pg_data_t));
 	}
+#endif
 }
 
 /*
@@ -183,20 +229,34 @@ static void __init register_bootmem_low_
 	}
 }
 
-void __init remap_numa_kva(void)
+static struct kcore_list numa_kc;
+
+int remap_one_node_kva(int node)
 {
 	void *vaddr;
 	unsigned long pfn;
-	int node;
 
-	for (node = 1; node < numnodes; ++node) {
 		for (pfn=0; pfn < node_remap_size[node]; pfn += PTRS_PER_PTE) {
 			vaddr = node_remap_start_vaddr[node]+(pfn<<PAGE_SHIFT);
 			set_pmd_pfn((ulong) vaddr, 
 				node_remap_start_pfn[node] + pfn, 
 				PAGE_KERNEL_LARGE);
 		}
+
+	/*	memset(node_remap_start_vaddr[node], 0,node_remap_size[node] * PAGE_SIZE); */
+
+	return 1;
 	}
+
+void __init remap_numa_kva(void)
+{
+	int node;
+
+	for (node = 1; node < numnodes; ++node)
+		remap_one_node_kva(node);
+
+	kclist_add(&numa_kc, node_remap_start_vaddr[numnodes - 1],
+		   node_remap_offset[numnodes - 1] << PAGE_SHIFT);
 }
 
 static unsigned long calculate_numa_remap_pages(void)
@@ -206,8 +266,13 @@ static unsigned long calculate_numa_rema
 
 	for (nid = 1; nid < numnodes; nid++) {
 		/* calculate the size of the mem_map needed in bytes */
+#if CONFIG_MEMHOTPLUGTEST
+		size = (node_end_pfn[nid] - node_start_pfn[nid] + 1)
+			* sizeof(struct page);
+#else
 		size = (node_end_pfn[nid] - node_start_pfn[nid] + 1) 
 			* sizeof(struct page) + sizeof(pg_data_t);
+#endif
 		/* convert size to large (pmd size) pages, rounding up */
 		size = (size + LARGE_PAGE_BYTES - 1) / LARGE_PAGE_BYTES;
 		/* now the roundup is correct, convert to PAGE_SIZE pages */
@@ -390,7 +455,11 @@ void __init zone_sizes_init(void)
 		else {
 			unsigned long lmem_map;
 			lmem_map = (unsigned long)node_remap_start_vaddr[nid];
+#ifdef CONFIG_MEMHOTPLUGTEST
+			lmem_map += PAGE_SIZE - 1;
+#else
 			lmem_map += sizeof(pg_data_t) + PAGE_SIZE - 1;
+#endif
 			lmem_map &= PAGE_MASK;
 			free_area_init_node(nid, NODE_DATA(nid), 
 				(struct page *)lmem_map, zones_size, 
@@ -400,12 +469,9 @@ void __init zone_sizes_init(void)
 	return;
 }
 
-void __init set_highmem_pages_init(int bad_ppro) 
-{
 #ifdef CONFIG_HIGHMEM
-	int nid;
-
-	for (nid = 0; nid < numnodes; nid++) {
+void set_highmem_pages_init_core(int nid, int bad_ppro)
+{
 		unsigned long node_pfn, node_high_size, zone_start_pfn;
 		struct page * zone_mem_map;
 		
@@ -419,6 +485,15 @@ void __init set_highmem_pages_init(int b
 					  zone_start_pfn + node_pfn, bad_ppro);
 		}
 	}
+#endif
+
+void __init set_highmem_pages_init(int bad_ppro)
+{
+#ifdef CONFIG_HIGHMEM
+	int nid;
+
+	for (nid = 0; nid < numnodes; nid++)
+		set_highmem_pages_init_core( nid, bad_ppro);
 	totalram_pages += totalhigh_pages;
 #endif
 }
diff -dupr linux-2.6.0/arch/i386/mm/init.c hotplugtest/arch/i386/mm/init.c
--- linux-2.6.0/arch/i386/mm/init.c	Thu Dec 18 11:02:25 2003
+++ hotplugtest/arch/i386/mm/init.c	Mon Dec 22 14:25:14 2003
@@ -224,7 +224,11 @@ void __init permanent_kmaps_init(pgd_t *
 	pkmap_page_table = pte;	
 }
 
+#ifdef CONFIG_MEMHOTPLUGTEST
+void one_highpage_init(struct page *page, int pfn, int bad_ppro)
+#else
 void __init one_highpage_init(struct page *page, int pfn, int bad_ppro)
+#endif
 {
 	if (page_is_ram(pfn) && !(bad_ppro && page_kills_ppro(pfn))) {
 		ClearPageReserved(page);
diff -dupr linux-2.6.0/fs/proc/kcore.c hotplugtest/fs/proc/kcore.c
--- linux-2.6.0/fs/proc/kcore.c	Thu Dec 18 11:02:43 2003
+++ hotplugtest/fs/proc/kcore.c	Mon Dec 22 14:25:14 2003
@@ -387,7 +387,7 @@ read_kcore(struct file *file, char __use
 			}
 			kfree(elf_buf);
 		} else {
-			if (kern_addr_valid(start)) {
+			if (1 /*kern_addr_valid(start)*/) {
 				unsigned long n;
 
 				n = copy_to_user(buffer, (char *)start, tsz);
diff -dupr linux-2.6.0/include/asm-i386/mmzone.h hotplugtest/include/asm-i386/mmzone.h
--- linux-2.6.0/include/asm-i386/mmzone.h	Thu Dec 18 11:02:40 2003
+++ hotplugtest/include/asm-i386/mmzone.h	Mon Dec 22 14:25:14 2003
@@ -128,6 +128,7 @@ static inline struct pglist_data *pfn_to
 #endif /* CONFIG_X86_NUMAQ */
 
 extern int get_memcfg_numa_flat(void );
+extern int get_memcfg_numa_blks(void );
 /*
  * This allows any one NUMA architecture to be compiled
  * for, and still fall back to the flat function if it
@@ -140,6 +141,9 @@ static inline void get_memcfg_numa(void)
 		return;
 #elif CONFIG_ACPI_SRAT
 	if (get_memcfg_from_srat())
+		return;
+#elif CONFIG_MEMHOTPLUGTEST
+	if (get_memcfg_numa_blks())
 		return;
 #endif
 
diff -dupr linux-2.6.0/include/asm-i386/numnodes.h hotplugtest/include/asm-i386/numnodes.h
--- linux-2.6.0/include/asm-i386/numnodes.h	Thu Dec 18 11:02:40 2003
+++ hotplugtest/include/asm-i386/numnodes.h	Mon Dec 22 14:25:14 2003
@@ -13,6 +13,10 @@
 /* Max 8 Nodes */
 #define NODES_SHIFT	3
 
+#elif defined(CONFIG_MEMHOTPLUGTEST)
+
+#define NODES_SHIFT	3
+
 #endif /* CONFIG_X86_NUMAQ */
 
 #endif /* _ASM_MAX_NUMNODES_H */
diff -dupr linux-2.6.0/include/linux/mm.h hotplugtest/include/linux/mm.h
--- linux-2.6.0/include/linux/mm.h	Thu Dec 18 11:02:34 2003
+++ hotplugtest/include/linux/mm.h	Mon Dec 22 14:25:14 2003
@@ -219,7 +219,14 @@ struct page {
  */
 #define put_page_testzero(p)				\
 	({						\
-		BUG_ON(page_count(p) == 0);		\
+		if (page_count(p) == 0) {		\
+			int i;						\
+			printk("Page: %lx ", (long)p);			\
+			for(i = 0; i < sizeof(struct page); i++)	\
+				printk(" %02x", ((unsigned char *)p)[i]); \
+			printk("\n");					\
+			BUG();				\
+		}					\
 		atomic_dec_and_test(&(p)->count);	\
 	})
 
@@ -622,5 +629,17 @@ kernel_map_pages(struct page *page, int 
 }
 #endif
 
+#ifdef CONFIG_MEMHOTPLUGTEST
+#define	page_trace(p)	page_trace_func(p, __FUNCTION__, __LINE__)
+extern void page_trace_func(const struct page *, const char *, int);
+#else
+#define	page_trace(p)	do { } while(0)
+#endif
+#ifdef CONFIG_MEMHOTPLUGTEST
+#define	page_trace(p)	page_trace_func(p, __FUNCTION__, __LINE__)
+extern void page_trace_func(const struct page *, const char *, int);
+#else
+#define	page_trace(p)	do { } while(0)
+#endif /* CONFIG_MEMHOTPLUGTEST */ 
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_H */
diff -dupr linux-2.6.0/include/linux/mmzone.h hotplugtest/include/linux/mmzone.h
--- linux-2.6.0/include/linux/mmzone.h	Thu Dec 18 11:02:35 2003
+++ hotplugtest/include/linux/mmzone.h	Mon Dec 22 14:44:17 2003
@@ -231,25 +231,6 @@ void wakeup_kswapd(struct zone *zone);
 #define for_each_pgdat(pgdat) \
 	for (pgdat = pgdat_list; pgdat; pgdat = pgdat->pgdat_next)
 
-/*
- * next_zone - helper magic for for_each_zone()
- * Thanks to William Lee Irwin III for this piece of ingenuity.
- */
-static inline struct zone *next_zone(struct zone *zone)
-{
-	pg_data_t *pgdat = zone->zone_pgdat;
-
-	if (zone - pgdat->node_zones < MAX_NR_ZONES - 1)
-		zone++;
-	else if (pgdat->pgdat_next) {
-		pgdat = pgdat->pgdat_next;
-		zone = pgdat->node_zones;
-	} else
-		zone = NULL;
-
-	return zone;
-}
-
 /**
  * for_each_zone - helper macro to iterate over all memory zones
  * @zone - pointer to struct zone variable
@@ -286,6 +267,9 @@ int min_free_kbytes_sysctl_handler(struc
 					  void *, size_t *);
 extern void setup_per_zone_pages_min(void);
 
+#ifdef CONFIG_MEMHOTPLUG
+extern void setup_per_zone_pages_min_add_node(int);
+#endif
 
 #ifdef CONFIG_NUMA
 #define MAX_NR_MEMBLKS	BITS_PER_LONG /* Max number of Memory Blocks */
@@ -360,6 +344,14 @@ static inline unsigned int num_online_me
 	return num;
 }
 
+#ifdef CONFIG_MEMHOTPLUGTEST
+#define zone_to_nid(zone)	\
+	((zone)->zone_pgdat->node_id)
+#define zone_to_memblk(zone)	\
+	node_to_memblk( zone_to_nid(zone) )
+#endif
+
+
 #else /* !CONFIG_DISCONTIGMEM && !CONFIG_NUMA */
 
 #define node_online(node) \
@@ -379,6 +371,39 @@ static inline unsigned int num_online_me
 #define num_online_memblks()		1
 
 #endif /* CONFIG_DISCONTIGMEM || CONFIG_NUMA */
+
+/*
+ * next_zone - helper magic for for_each_zone()
+ * Thanks to William Lee Irwin III for this piece of ingenuity.
+ */
+
+static inline struct zone *next_zone(struct zone *zone)
+{
+	pg_data_t *pgdat = zone->zone_pgdat;
+
+	if (zone - pgdat->node_zones < MAX_NR_ZONES - 1)
+		zone++;
+#ifdef CONFIG_MEMHOTPLUGTEST
+	else {
+		zone = NULL;
+		while ( pgdat->pgdat_next ) {
+			pgdat = pgdat->pgdat_next;
+			if ( node_online(pgdat->node_id) ){
+				zone = pgdat->node_zones;
+				break;
+			}
+		}
+	}
+#else
+	else if (pgdat->pgdat_next) {
+		pgdat = pgdat->pgdat_next;
+		zone = pgdat->node_zones;
+	} else
+		zone = NULL;
+#endif
+	return zone;
+}
+
 #endif /* !__ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MMZONE_H */
diff -dupr linux-2.6.0/mm/page_alloc.c hotplugtest/mm/page_alloc.c
--- linux-2.6.0/mm/page_alloc.c	Thu Dec 18 11:02:47 2003
+++ hotplugtest/mm/page_alloc.c	Mon Dec 22 14:25:14 2003
@@ -31,6 +31,7 @@
 #include <linux/topology.h>
 #include <linux/sysctl.h>
 #include <linux/cpu.h>
+#include <linux/proc_fs.h>
 
 #include <asm/tlbflush.h>
 
@@ -53,6 +54,10 @@ EXPORT_SYMBOL(nr_swap_pages);
 struct zone *zone_table[MAX_NR_ZONES*MAX_NUMNODES];
 EXPORT_SYMBOL(zone_table);
 
+#ifdef CONFIG_MEMHOTPLUGTEST
+static const struct page *page_trace_list[10];
+#endif
+
 static char *zone_names[MAX_NR_ZONES] = { "DMA", "Normal", "HighMem" };
 int min_free_kbytes = 1024;
 
@@ -676,6 +681,17 @@ nopage:
 	return NULL;
 got_pg:
 	kernel_map_pages(page, 1 << order, 1);
+#if 1 // debug
+	/* Validate page */
+	{
+		struct zone *z = page_zone(page);
+		int idx = page - z->zone_mem_map;
+		if (idx < 0 || idx >= z->spanned_pages) {
+			printk("0x%08x %d\n", (int)(page->flags >> ZONE_SHIFT), idx);
+			BUG();
+		}
+	}
+#endif
 	return page;
 }
 
@@ -1046,7 +1062,11 @@ void show_free_areas(void)
 /*
  * Builds allocation fallback zone lists.
  */
+#ifdef CONFIG_MEMHOTPLUGTEST
+static int build_zonelists_node(pg_data_t *pgdat, struct zonelist *zonelist, int j, int k)
+#else
 static int __init build_zonelists_node(pg_data_t *pgdat, struct zonelist *zonelist, int j, int k)
+#endif
 {
 	switch (k) {
 		struct zone *zone;
@@ -1076,6 +1096,9 @@ static int __init build_zonelists_node(p
 static void __init build_zonelists(pg_data_t *pgdat)
 {
 	int i, j, k, node, local_node;
+#ifdef CONFIG_MEMHOTPLUGTEST
+	struct zone *zone;
+#endif
 
 	local_node = pgdat->node_id;
 	printk("Building zonelist for node : %d\n", local_node);
@@ -1092,6 +1115,7 @@ static void __init build_zonelists(pg_da
 		if (i & __GFP_DMA)
 			k = ZONE_DMA;
 
+#ifndef CONFIG_MEMHOTPLUGTEST
  		j = build_zonelists_node(pgdat, zonelist, j, k);
  		/*
  		 * Now we build the zonelist so that it contains the zones
@@ -1107,6 +1131,27 @@ static void __init build_zonelists(pg_da
  			j = build_zonelists_node(NODE_DATA(node), zonelist, j, k);
  
 		zonelist->zones[j++] = NULL;
+#else
+		for(; k >= 0; k--) {
+			zone = pgdat->node_zones + k;
+			if ( !node_online(zone_to_nid(zone)) )
+				continue;
+			if (zone->present_pages)
+				zonelist->zones[j++] = zone;
+			for (node = local_node + 1; node < numnodes; node++) {
+				zone = NODE_DATA(node)->node_zones + k;
+				if ( node_online( zone_to_nid(zone) ) &&
+				     zone->present_pages )
+					zonelist->zones[j++] = zone;
+			}
+			for (node = 0; node < local_node; node++) {
+				zone = NODE_DATA(node)->node_zones + k;
+				if ( node_online( zone_to_nid(zone) ) &&
+				     zone->present_pages )
+					zonelist->zones[j++] = zone;
+			}
+		}
+#endif
 	} 
 }
 
@@ -1162,8 +1207,13 @@ static inline unsigned long wait_table_b
 
 #define LONG_ALIGN(x) (((x)+(sizeof(long))-1)&~((sizeof(long))-1))
 
+#if CONFIG_MEMHOTPLUGTEST
+static void calculate_zone_totalpages(struct pglist_data *pgdat,
+		unsigned long *zones_size, unsigned long *zholes_size)
+#else
 static void __init calculate_zone_totalpages(struct pglist_data *pgdat,
 		unsigned long *zones_size, unsigned long *zholes_size)
+#endif
 {
 	unsigned long realtotalpages, totalpages = 0;
 	int i;
@@ -1199,13 +1249,32 @@ static void __init calculate_zone_bitmap
 	}
 }
 
+#if CONFIG_MEMHOTPLUGTEST
+static void calculate_addzone_bitmap(struct pglist_data *pgdat, unsigned long *zones_size)
+{
+	unsigned long size = zones_size[ZONE_HIGHMEM];
+
+	size = LONG_ALIGN((size + 7) >> 3);
+	if (size) {
+		pgdat->valid_addr_bitmap = (unsigned long *)kmalloc(size,GFP_KERNEL);
+		memset(pgdat->valid_addr_bitmap, 0, size);
+	}
+}
+
+#endif
+
 /*
  * Initially all pages are reserved - free ones are freed
  * up by free_all_bootmem() once the early boot process is
  * done. Non-atomic initialization, single-pass.
  */
+#if CONFIG_MEMHOTPLUGTEST
+void memmap_init_zone(struct page *start, unsigned long size, int nid,
+		unsigned long zone, unsigned long start_pfn)
+#else
 void __init memmap_init_zone(struct page *start, unsigned long size, int nid,
 		unsigned long zone, unsigned long start_pfn)
+#endif
 {
 	struct page *page;
 
@@ -1252,6 +1321,43 @@ static void __init free_area_init_core(s
 		unsigned long batch;
 
 		zone_table[nid * MAX_NR_ZONES + j] = zone;
+#ifdef CONFIG_MEMHOTPLUGTEST
+										/* only node 0 is active */
+		if ( nid ){ 							/*  node 1-... are node active */
+										/* XXX : This should be changed. */
+			zone->spanned_pages = 0;
+			zone->present_pages = 0;
+			zone->name = zone_names[j];
+			spin_lock_init(&zone->lock);
+			spin_lock_init(&zone->lru_lock);
+			zone->zone_pgdat = pgdat;
+			zone->free_pages = 0;
+			for (cpu = 0; cpu < NR_CPUS; cpu++) {
+				struct per_cpu_pages *pcp;
+
+				pcp = &zone->pageset[cpu].pcp[0];	/* hot */
+				pcp->count = 0;
+				pcp->low = 0;
+				pcp->high = 0;
+				pcp->batch = 0;
+				INIT_LIST_HEAD(&pcp->list);
+
+				pcp = &zone->pageset[cpu].pcp[1];	/* cold */
+				pcp->count = 0;
+				pcp->low = 0;
+				pcp->high = 0;
+				pcp->batch = 0;
+				INIT_LIST_HEAD(&pcp->list);
+			}
+			INIT_LIST_HEAD(&zone->active_list);
+			INIT_LIST_HEAD(&zone->inactive_list);
+			atomic_set(&zone->refill_counter, 0);
+			zone->nr_active = 0;
+			zone->nr_inactive = 0;
+
+			continue;
+		}
+#endif
 		realsize = size = zones_size[j];
 		if (zholes_size)
 			realsize -= zholes_size[j];
@@ -1295,8 +1401,8 @@ static void __init free_area_init_core(s
 			pcp->batch = 1 * batch;
 			INIT_LIST_HEAD(&pcp->list);
 		}
-		printk("  %s zone: %lu pages, LIFO batch:%lu\n",
-				zone_names[j], realsize, batch);
+		printk("  %s zone: %lu pages, LIFO batch:%lu start:%lu\n",
+				zone_names[j], realsize, batch, zone_start_pfn);
 		INIT_LIST_HEAD(&zone->active_list);
 		INIT_LIST_HEAD(&zone->inactive_list);
 		atomic_set(&zone->refill_counter, 0);
@@ -1381,14 +1487,22 @@ void __init free_area_init_node(int nid,
 	pgdat->node_id = nid;
 	pgdat->node_start_pfn = node_start_pfn;
 	calculate_zone_totalpages(pgdat, zones_size, zholes_size);
+#ifdef CONFIG_MEMHOTPLUGTEST
+	if (!node_mem_map && !nid) {
+#else
 	if (!node_mem_map) {
+#endif
 		size = (pgdat->node_spanned_pages + 1) * sizeof(struct page);
 		node_mem_map = alloc_bootmem_node(pgdat, size);
 	}
 	pgdat->node_mem_map = node_mem_map;
 
 	free_area_init_core(pgdat, zones_size, zholes_size);
+#ifdef CONFIG_MEMHOTPLUGTEST
+	if(!nid)memblk_set_online(node_to_memblk(nid));		/* only node 0 is online */
+#else
 	memblk_set_online(node_to_memblk(nid));
+#endif
 
 	calculate_zone_bitmap(pgdat, zones_size);
 }
@@ -1632,6 +1746,36 @@ void setup_per_zone_pages_min(void)
 	}
 }
 
+#ifdef CONFIG_MEMHOTPLUGTEST
+void setup_per_zone_pages_min_add_node(int nid)
+{
+	struct zone *zone;
+	unsigned long flags;
+	int min_pages;
+
+	zone = &NODE_DATA(nid)->node_zones[ZONE_HIGHMEM];
+
+	spin_lock_irqsave(&zone->lru_lock, flags);
+	/*
+	 * Often, highmem doesn't need to reserve any pages.
+	 * But the pages_min/low/high values are also used for
+	 * batching up page reclaim activity so we need a
+	 * decent value here.
+	 */
+
+	min_pages = zone->present_pages / 1024;
+	if (min_pages < SWAP_CLUSTER_MAX)
+		min_pages = SWAP_CLUSTER_MAX;
+	if (min_pages > 128)
+		min_pages = 128;
+	zone->pages_min = min_pages;
+
+	zone->pages_low = zone->pages_min * 2;
+	zone->pages_high = zone->pages_min * 3;
+	spin_unlock_irqrestore(&zone->lru_lock, flags);
+}
+#endif
+
 /*
  * min_free_kbytes_sysctl_handler - just a wrapper around proc_dointvec() so 
  *	that we can call setup_per_zone_pages_min() whenever min_free_kbytes 
@@ -1644,3 +1788,406 @@ int min_free_kbytes_sysctl_handler(ctl_t
 	setup_per_zone_pages_min();
 	return 0;
 }
+
+#ifdef CONFIG_MEMHOTPLUGTEST
+static unsigned long search_insert_zonelist(struct zonelist *zonelist, unsigned long nid)
+{
+	/* XXX: This function assume that nid is sequential value,
+                and added node ID is next of last ID.
+                But, node ID might be skippable for hotplug */
+	unsigned long i;
+	struct zone *zone;
+
+	for( i = numnodes * MAX_NR_ZONES ;  i>=1 ;  i--){
+		zone=zonelist->zones[i-1];
+		if( !zone )
+			continue;
+		if( zone_to_nid(zone) == nid -1 )
+			break;
+	}
+	return i;
+
+}
+
+static void rebuild_all_zonelist(unsigned long nid)
+{
+	struct zonelist *zonelist;
+	unsigned long node, p_node, q, j=0;
+
+	zonelist = NODE_DATA(nid)->node_zonelists + ZONE_HIGHMEM;
+	memset(zonelist, 0, sizeof(*zonelist));
+
+	/* build zonelist for added zone */
+	j= build_zonelists_node( NODE_DATA(nid), zonelist, j, ZONE_HIGHMEM);
+
+	for ( node = nid + 1; node < numnodes; node++)
+		j = build_zonelists_node( NODE_DATA(node), zonelist, j, ZONE_HIGHMEM);
+	for (node = 0; node < nid ; node++)
+		j = build_zonelists_node( NODE_DATA(node), zonelist, j, ZONE_HIGHMEM);
+
+	/* rebuild zonelist for other node */
+	for( p_node = 0; p_node < numnodes ; p_node++){
+		if( p_node == nid ) continue;   /* already set */
+
+		zonelist = NODE_DATA(p_node)->node_zonelists + ZONE_HIGHMEM;
+		q = search_insert_zonelist( zonelist, nid);
+
+		for ( j = numnodes * MAX_NR_ZONES ; j > q ; j -- )
+			zonelist->zones[j] = zonelist->zones[j-1];
+		zonelist->zones[q] = NODE_DATA(nid)->node_zones + ZONE_HIGHMEM;
+	}
+}
+
+static void free_area_add_core(struct pglist_data *pgdat,
+		unsigned long *zones_size, unsigned long *zholes_size)
+{
+	unsigned long i;
+	const unsigned long zone_required_alignment = 1UL << (MAX_ORDER-1);
+	int cpu, nid = pgdat->node_id;
+	struct page *lmem_map = pgdat->node_mem_map;
+	unsigned long zone_start_pfn = pgdat->node_start_pfn;
+
+	pgdat->nr_zones = 0;
+	init_waitqueue_head(&pgdat->kswapd_wait);
+
+	{
+		struct zone *zone = pgdat->node_zones + ZONE_HIGHMEM;
+		unsigned long size, realsize;
+		unsigned long batch;
+
+		zone_table[nid * MAX_NR_ZONES + ZONE_HIGHMEM] = zone;
+
+		realsize = size = zones_size[ZONE_HIGHMEM];
+		if (zholes_size)
+			realsize -= zholes_size[ZONE_HIGHMEM];
+
+		zone->spanned_pages = size;
+		zone->present_pages = realsize;
+		zone->name = zone_names[ZONE_HIGHMEM];
+		spin_lock_init(&zone->lock);
+		spin_lock_init(&zone->lru_lock);
+		zone->zone_pgdat = pgdat;
+		zone->free_pages = 0;
+
+		/*
+		 * The per-cpu-pages pools are set to around 1000th of the
+		 * size of the zone.  But no more than 1/4 of a meg - there's
+		 * no point in going beyond the size of L2 cache.
+		 *
+		 * OK, so we don't know how big the cache is.  So guess.
+		 */
+		batch = zone->present_pages / 1024;
+		if (batch * PAGE_SIZE > 256 * 1024)
+			batch = (256 * 1024) / PAGE_SIZE;
+		batch /= 4;		/* We effectively *= 4 below */
+		if (batch < 1)
+			batch = 1;
+
+		for (cpu = 0; cpu < NR_CPUS; cpu++) {
+			struct per_cpu_pages *pcp;
+
+			pcp = &zone->pageset[cpu].pcp[0];	/* hot */
+			pcp->count = 0;
+			pcp->low = 2 * batch;
+			pcp->high = 6 * batch;
+			pcp->batch = 1 * batch;
+			INIT_LIST_HEAD(&pcp->list);
+
+			pcp = &zone->pageset[cpu].pcp[1];	/* cold */
+			pcp->count = 0;
+			pcp->low = 0;
+			pcp->high = 2 * batch;
+			pcp->batch = 1 * batch;
+			INIT_LIST_HEAD(&pcp->list);
+		}
+		printk("  %s zone: %lu pages, LIFO batch:%lu start:%lu\n",
+				zone_names[ZONE_HIGHMEM], realsize, batch, zone_start_pfn);
+		INIT_LIST_HEAD(&zone->active_list);
+		INIT_LIST_HEAD(&zone->inactive_list);
+		atomic_set(&zone->refill_counter, 0);
+		zone->nr_active = 0;
+		zone->nr_inactive = 0;
+
+		/*
+		 * The per-page waitqueue mechanism uses hashed waitqueues
+		 * per zone.
+		 */
+		zone->wait_table_size = wait_table_size(size);
+		zone->wait_table_bits =
+			wait_table_bits(zone->wait_table_size);
+		zone->wait_table = (wait_queue_head_t *)kmalloc(zone->wait_table_size
+						* sizeof(wait_queue_head_t), GFP_KERNEL);
+				/* XXX: wait_table might have to be allocate own node. */
+		memset(zone->wait_table, 0, zone->wait_table_size * sizeof(wait_queue_head_t));
+
+		for(i = 0; i < zone->wait_table_size; ++i)
+			init_waitqueue_head(zone->wait_table + i);
+
+		pgdat->nr_zones = ZONE_HIGHMEM+1;
+
+		zone->zone_mem_map = lmem_map;
+		zone->zone_start_pfn = zone_start_pfn;
+
+		if ((zone_start_pfn) & (zone_required_alignment-1))
+			printk("BUG: wrong zone alignment, it will crash\n");
+
+		memset( lmem_map, 0, sizeof(struct page)*size);
+		memmap_init_zone(lmem_map, size, nid, ZONE_HIGHMEM, zone_start_pfn);
+
+		for (i = 0; ; i++) {
+			unsigned long bitmap_size;
+
+			INIT_LIST_HEAD(&zone->free_area[i].free_list);
+			if (i == MAX_ORDER-1) {
+				zone->free_area[i].map = NULL;
+				break;
+			}
+
+			/*
+			 * Page buddy system uses "index >> (i+1)",
+			 * where "index" is at most "size-1".
+			 *
+			 * The extra "+3" is to round down to byte
+			 * size (8 bits per byte assumption). Thus
+			 * we get "(size-1) >> (i+4)" as the last byte
+			 * we can access.
+			 *
+			 * The "+1" is because we want to round the
+			 * byte allocation up rather than down. So
+			 * we should have had a "+7" before we shifted
+			 * down by three. Also, we have to add one as
+			 * we actually _use_ the last bit (it's [0,n]
+			 * inclusive, not [0,n[).
+			 *
+			 * So we actually had +7+1 before we shift
+			 * down by 3. But (n+8) >> 3 == (n >> 3) + 1
+			 * (modulo overflows, which we do not have).
+			 *
+			 * Finally, we LONG_ALIGN because all bitmap
+			 * operations are on longs.
+			 */
+			bitmap_size = (size-1) >> (i+4);
+			bitmap_size = LONG_ALIGN(bitmap_size+1);
+			zone->free_area[i].map =
+			  (unsigned long *) kmalloc(bitmap_size, GFP_KERNEL);
+				/* XXX: bitmap might have to be allocate own node too. */
+			memset( zone->free_area[i].map, 0, bitmap_size);
+		}
+	}
+}
+
+extern void *node_remap_start_vaddr[];
+extern int remap_one_node_kva(int);
+
+int free_area_add_node(int nid, struct pglist_data *pgdat,unsigned long *zones_size,
+		unsigned long node_start_pfn, unsigned long *zholes_size)
+{
+	unsigned long size;
+
+	calculate_zone_totalpages(pgdat, zones_size, zholes_size);
+
+	size = (pgdat->node_spanned_pages + 1) * sizeof(struct page);
+	if(remap_one_node_kva(nid)){
+
+		free_area_add_core(pgdat, zones_size, zholes_size);
+		calculate_addzone_bitmap(pgdat, zones_size);
+		return 1;
+	}
+	return 0;
+
+}
+
+extern unsigned long node_start_pfn[];
+extern unsigned long node_end_pfn[];
+extern void set_highmem_pages_init_core(int, int);
+
+static void node_enable(unsigned long nid)
+{
+	unsigned long zones_size[MAX_NR_ZONES] =  {0, 0, 0};
+	unsigned long *zholes_size;
+
+	if (nid > numnodes){		/* XXX : nid should has continuity now */
+					/*       but it should be changed */
+		printk("nid=%d isn&t possible to enable \n",nid);
+		return;
+	}
+
+	if (node_online(nid)){
+		printk("nid=%d is already enable \n", nid);
+		return;
+	}
+
+	zones_size[ZONE_HIGHMEM] = node_end_pfn[nid] - node_start_pfn[nid];
+					/* XXX: This information should be got from firmware.
+					        However, this is emulation. */
+	if( !zones_size[ZONE_HIGHMEM] ){
+		printk("nid=%d is size 0\n",nid);
+		return;
+ 	}
+
+	zholes_size = get_zholes_size(nid);
+
+	if (!free_area_add_node(nid, NODE_DATA(nid), zones_size, node_start_pfn[nid], zholes_size))
+		return;
+
+	setup_per_zone_pages_min_add_node(nid);	/* set up again */
+
+	set_highmem_pages_init_core(nid, 0);	/* XXX: bad_ppro should be used. */
+
+	rebuild_all_zonelist( nid);
+	memblk_set_online(node_to_memblk(nid));
+	node_set_online(nid);
+
+}
+
+static int mhtest_read(char *page, char **start, off_t off, int count,
+    int *eof, void *data)
+{
+	char *p;
+	int i, len;
+	const struct zone *z;
+
+	p = page;
+	for(i = 0; ; i++) {
+		z = zone_table[i];
+		if (z == NULL)
+			break;
+		if (! z->present_pages)
+			/* skip empty zone */
+			continue;
+		len = sprintf(p, "Zone %d: free %d, active %d, present %d\n", i,
+				 (int)z->free_pages, (int)z->nr_active, (int)z->present_pages);
+		p += len;
+	}
+	len = p - page;
+
+	if (len <= off + count)
+		*eof = 1;
+	*start = page + off;
+	len -= off;
+	if (len < 0)
+		len = 0;
+	if (len > count)
+		len = count;
+
+	return len;
+}
+
+static int mhtest_write(struct file *file, const char *buffer,
+    unsigned long count, void *data)
+{
+	unsigned long idx;
+	char buf[64], *p;
+	int i;
+
+	if (count > sizeof(buf) - 1)
+		count = sizeof(buf) - 1;
+	if (copy_from_user(buf, buffer, count))
+		return -EFAULT;
+
+	buf[count] = 0;
+
+	p = strchr(buf, ' ');
+	if (p == NULL)
+		goto out;
+
+	*p++ = '\0';
+	idx = simple_strtoul(p, NULL, 0);
+
+	if (strcmp(buf, "trace") == 0) {
+		for(i = 0; i < sizeof(page_trace_list) /
+		    sizeof(page_trace_list[0]); i++)
+			if (page_trace_list[i] == NULL) {
+				page_trace_list[i] = (struct page *)idx;
+				printk("add trace %lx\n", (unsigned long)idx);
+				goto out;
+			}
+		printk("page_trace_list is full (not added)\n");
+		goto out;
+	} else if (strcmp(buf, "untrace") == 0) {
+		for(i = 0; i < sizeof(page_trace_list) /
+		    sizeof(page_trace_list[0]); i++)
+			if (page_trace_list[i] == (struct page *)idx)
+				break;
+		if (i == sizeof(page_trace_list) / sizeof(page_trace_list[0])) {
+			printk("not registered\n");
+			goto out;
+		}
+		for(; i < sizeof(page_trace_list) /
+		    sizeof(page_trace_list[0]) - 1; i++)
+			page_trace_list[i] = page_trace_list[i + 1];
+		page_trace_list[i] = NULL;
+		goto out;
+	}
+	if (idx > MAX_NUMNODES) {
+		printk("Argument out of range\n");
+		goto out;
+	}
+	if (strcmp(buf, "disable") == 0) {
+		printk("disable node = %d\n", (int)idx);	/* XXX */
+		goto out;
+	} else if (strcmp(buf, "purge") == 0) {
+		/* XXX */
+	} else if (strcmp(buf, "enable") == 0) {
+		printk("enable node = %d\n", (int)idx);
+		node_enable(idx);
+	} else if (strcmp(buf, "active") == 0) {
+		/*
+		if (zone_table[idx] == NULL)
+			goto out;
+		spin_lock_irq(&zone_table[idx]->lru_lock);
+		i = 0;
+		list_for_each(l, &zone_table[idx]->active_list) {
+			printk(" %lx", (unsigned long)list_entry(l, struct page, lru));
+			i++;
+			if (i == 10)
+				break;
+		}
+		spin_unlock_irq(&zone_table[idx]->lru_lock);
+		printk("\n");
+		*/
+	} else if (strcmp(buf, "inuse") == 0) {
+		/*
+		if (zone_table[idx] == NULL)
+			goto out;
+		for(i = 0; i < zone_table[idx]->spanned_pages; i++)
+			if (page_count(&zone_table[idx]->zone_mem_map[i]))
+				printk(" %lx", (unsigned long)&zone_table[idx]->zone_mem_map[i]);
+		printk("\n");
+		*/
+	}
+out:
+	return count;
+}
+
+static int __init procmhtest_init(void)
+{
+	struct proc_dir_entry *entry;
+
+	entry = create_proc_entry("memhotplug", 0, NULL);
+	if (entry == NULL)
+		return -1;
+
+	entry->read_proc = &mhtest_read;
+	entry->write_proc = &mhtest_write;
+	return 0;
+}
+__initcall(procmhtest_init);
+
+void
+page_trace_func(const struct page *p, const char *func, int line) {
+	int i;
+
+	for(i = 0; i < sizeof(page_trace_list) /
+	    sizeof(page_trace_list[0]); i++) {
+		if (page_trace_list[i] == NULL)
+			return;
+		if (page_trace_list[i] == p)
+			break;
+	}
+	if (i == sizeof(page_trace_list) / sizeof(page_trace_list[0]))
+		return;
+
+	printk("Page %lx, %s %d\n", (unsigned long)p, func, line);
+}
+#endif


