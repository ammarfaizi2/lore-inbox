Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266457AbUG0QWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266457AbUG0QWY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 12:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266461AbUG0QWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 12:22:24 -0400
Received: from fujitsu2.fujitsu.com ([192.240.0.2]:18338 "EHLO
	fujitsu2.fujitsu.com") by vger.kernel.org with ESMTP
	id S266457AbUG0QVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 12:21:53 -0400
Message-ID: <41068115.5020202@us.fujitsu.com>
Date: Tue, 27 Jul 2004 09:21:41 -0700
From: Fumitake ABE <fabe@us.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: ja
MIME-Version: 1.0
To: lhms-devel <lhms-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memory hotplug for ia64 (linux-2.6.7) [0/2]
References: <20040720181135.12B6.TERASAWA@pst.fujitsu.com> <40FF0BDD.9050500@us.fujitsu.com>
In-Reply-To: <40FF0BDD.9050500@us.fujitsu.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The patch which I sent on July 21 was invalid because a linefeed was
inserted in the 72nd character. So, I resend my correct patch.

Thanks,
Fumitake Abe

-------- Original Message --------
Subject: Re: [PATCH] memory hotplug for ia64 (linux-2.6.7) [0/2]
Date: Wed, 21 Jul 2004 17:35:41 -0700
From: Fumitake ABE <fabe@us.fujitsu.com>
To: lhms-devel <lhms-devel@lists.sourceforge.net>,  linux-kernel <linux-kernel@vger.kernel.org>
References: <20040720181135.12B6.TERASAWA@pst.fujitsu.com>

Hi,

The following patch complements ones that Terasawa-san posted.
(http://marc.theaimsgroup.com/?l=linux-kernel&m=109031522707608&w=2)
This enables IPF machine to plug nodes.

If you want to know the details about how to plug, please refer to
Iwamoto-san's web page.
http://people.valinux.co.jp/~iwamoto/mh.html

Known issues / TODO items:
- This patch can only plug a unpluged node again. In other words,
   it cannot plug a new node.
- Plug and unplug are unrepeatable.
- After plugging a node, a memory usage statistics per zone displayed
   by "/proc/memhotplug" becomes invalid.

How to apply:
1) First of all, apply patches which Takahashi-san posted on July 14
   without [15-16/16].
    *If patches of [15-16/16] are applied, compile error will occur
    on ia64.
2) Apply patches which Terasawa-san posted on July 20.
3) Apply patches which Yoshida-san posted on July 20.
4) And, apply my patch.

Thanks,
Fumitake ABE


diff -dupr linux-2.6.7/arch/ia64/mm/discontig.c linux-2.6.7-mhp/arch/ia64/mm/discontig.c
--- linux-2.6.7/arch/ia64/mm/discontig.c    2004-07-14 16:01:25.779107830 -0700
+++ linux-2.6.7-mhp/arch/ia64/mm/discontig.c    2004-07-14 15:59:50.686335557 -0700
@@ -38,7 +38,11 @@ struct early_node_data {
      unsigned long max_pfn;
  };

+#ifndef CONFIG_MEMHOTPLUG
  static struct early_node_data mem_data[NR_NODES] __initdata;
+#else
+static struct early_node_data mem_data[NR_NODES];
+#endif

  /**
   * reassign_cpu_only_nodes - called from find_memory to move CPU-only nodes to a memory node
@@ -179,8 +183,12 @@ static void __init reassign_cpu_only_nod
   * memmap.  We also update min_low_pfn and max_low_pfn here as we receive
   * memory ranges from the caller.
   */
+#ifdef CONFIG_MEMHOTPLUG
+static int build_node_maps(unsigned long start, unsigned long len, int node)
+#else
  static int __init build_node_maps(unsigned long start, unsigned long len,
                    int node)
+#endif
  {
      unsigned long cstart, epfn, end = start + len;
      struct bootmem_data *bdp = &mem_data[node].bootmem_data;
@@ -249,8 +257,13 @@ static int early_nr_cpus_node(int node)
   * outside of this function and use alloc_bootmem_node(), but doing it here
   * is straightforward and we get the alignments we want so...
   */
+#ifdef CONFIG_MEMHOTPLUG
+static int find_pernode_space(unsigned long start, unsigned long len,
+                  int node)
+#else
  static int __init find_pernode_space(unsigned long start, unsigned long len,
                       int node)
+#endif
  {
      unsigned long epfn, cpu, cpus;
      unsigned long pernodesize = 0, pernode, pages, mapsize;
@@ -332,14 +345,40 @@ static int __init find_pernode_space(uns
   * for all the entries in the EFI memory map, the bootmem allocator will
   * be ready to service allocation requests.
   */
+#ifdef CONFIG_MEMHOTPLUG
+static int free_node_bootmem(unsigned long start, unsigned long len,
+                 int node)
+#else
  static int __init free_node_bootmem(unsigned long start, unsigned long len,
                      int node)
+#endif
  {
      free_bootmem_node(mem_data[node].pgdat, start, len);

      return 0;
  }

+static void reserve_pernode_space_core(int node)
+{
+    unsigned long base, size, pages;
+    struct bootmem_data *bdp;
+    pg_data_t *pdp;
+
+    pdp = mem_data[node].pgdat;
+    bdp = pdp->bdata;
+
+    /* First the bootmem_map itself */
+    pages = bdp->node_low_pfn - (bdp->node_boot_start>>PAGE_SHIFT);
+    size = bootmem_bootmap_pages(pages) << PAGE_SHIFT;
+    base = __pa(bdp->node_bootmem_map);
+    reserve_bootmem_node(pdp, base, size);
+
+    /* Now the per-node space */
+    size = mem_data[node].pernode_size;
+    base = __pa(mem_data[node].pernode_addr);
+    reserve_bootmem_node(pdp, base, size);
+}
+
  /**
   * reserve_pernode_space - reserve memory for per-node space
   *
@@ -349,26 +388,10 @@ static int __init free_node_bootmem(unsi
   */
  static void __init reserve_pernode_space(void)
  {
-    unsigned long base, size, pages;
-    struct bootmem_data *bdp;
      int node;

-    for (node = 0; node < numnodes; node++) {
-        pg_data_t *pdp = mem_data[node].pgdat;
-
-        bdp = pdp->bdata;
-
-        /* First the bootmem_map itself */
-        pages = bdp->node_low_pfn - (bdp->node_boot_start>>PAGE_SHIFT);
-        size = bootmem_bootmap_pages(pages) << PAGE_SHIFT;
-        base = __pa(bdp->node_bootmem_map);
-        reserve_bootmem_node(pdp, base, size);
-
-        /* Now the per-node space */
-        size = mem_data[node].pernode_size;
-        base = __pa(mem_data[node].pernode_addr);
-        reserve_bootmem_node(pdp, base, size);
-    }
+    for (node = 0; node < numnodes; node++)
+        reserve_pernode_space_core(node);
  }

  /**
@@ -674,10 +697,150 @@ void paging_init(void)
      zero_page_memmap_ptr = virt_to_page(ia64_imva(empty_zero_page));
  }

-/* Not support HotAdd memory */
+/* for hotplug */
+
+void
+paging_init_for_new_node(unsigned long start, unsigned long len, int nid)
+{
+    unsigned long max_dma;
+    unsigned long zones_size[MAX_NR_ZONES];
+    unsigned long zholes_size[MAX_NR_ZONES];
+    unsigned long max_gap;
+    unsigned long vstart, vend;
+
+    max_dma = virt_to_phys((void *) MAX_DMA_ADDRESS) >> PAGE_SHIFT;
+    max_gap = 0;
+
+    mem_data[nid].min_pfn = ~0UL;
+
+    count_node_pages(start, len, nid);
+
+    memset(zones_size, 0, sizeof(zones_size));
+    memset(zholes_size, 0, sizeof(zholes_size));
+
+    num_physpages += mem_data[nid].num_physpages;
+
+    zones_size[ZONE_NORMAL] = mem_data[nid].max_pfn -
+        mem_data[nid].min_pfn;
+    zholes_size[ZONE_NORMAL] = mem_data[nid].max_pfn -
+        mem_data[nid].min_pfn -
+        mem_data[nid].num_physpages;  /* <- Is this valid? */
+
+    vstart = PAGE_ALIGN(PAGE_OFFSET + start);
+    vend = (vstart + len) & PAGE_MASK;
+    create_mem_map_page_table(vstart, vend, 0);
+
+    free_area_init_node(nid, NODE_DATA(nid),
+                vmem_map + mem_data[nid].min_pfn,
+                zones_size, mem_data[nid].min_pfn, zholes_size);
+}
+
+/* Temporary */
+void
+get_new_node_memory_info(int nid, unsigned long *start, unsigned long *end)
+{
+    *start = mem_data[nid].min_pfn << PAGE_SHIFT;
+    *end = mem_data[nid].max_pfn << PAGE_SHIFT;
+    printk("%s: start = %016lx, end = %016lx\n",
+        __FUNCTION__, *start, *end);
+}
+
  void
  plug_node(int nid)
-{}
+{
+    int i, j;
+    int cpu;
+    unsigned long start, end;
+    unsigned long prev_min_low_pfn, prev_max_low_pfn;
+    unsigned long pernode, pernodesize, map;
+    struct bootmem_data *bdp;
+    pg_data_t **pgdat;
+
+    /* TBD: Validness of nid is needed to check here. */
+
+    prev_min_low_pfn = min_low_pfn;
+    prev_max_low_pfn = max_low_pfn;
+
+    /* 1: check memory range */
+    get_new_node_memory_info(nid, &start, &end);
+
+    memset(&mem_data[nid], 0, sizeof(struct early_node_data));
+
+    build_node_maps(start, end - start, nid);
+    find_pernode_space(start, end - start, nid);
+
+    bdp = &mem_data[nid].bootmem_data;
+    pernode = mem_data[nid].pernode_addr;
+    pernodesize = mem_data[nid].pernode_size;
+    map = pernode + pernodesize;
+
+    if (!pernode) {
+        printk("space for the new node %d could not be allocated!",
+            nid);
+        min_low_pfn = prev_min_low_pfn;
+        max_low_pfn = prev_max_low_pfn;
+        return;
+    }
+
+    init_bootmem_node(mem_data[nid].pgdat,
+            map>>PAGE_SHIFT,
+            bdp->node_boot_start>>PAGE_SHIFT,
+            bdp->node_low_pfn);
+
+            free_node_bootmem(start, end - start, nid);
+
+    reserve_pernode_space_core(nid);
+
+    /* initialize_pernode_data() for pluged node */
+    for(cpu = 0; cpu < NR_CPUS; cpu++) {
+        per_cpu(cpu_info, cpu).node_data->pg_data_ptrs[nid]
+            = mem_data[nid].pgdat;
+    }
+
+    max_pfn = max_low_pfn;
+
+    paging_init_for_new_node(start, end - start, nid);
+
+    NODE_DATA(nid)->removable = 1;
+
+    for(pgdat = &pgdat_list; *pgdat; pgdat = &(*pgdat)->pgdat_next)
+        if ((*pgdat)->node_id > nid) {
+            NODE_DATA(nid)->pgdat_next = *pgdat;
+            *pgdat = NODE_DATA(nid);
+            break;
+        }
+
+    if (*pgdat == NULL)
+        *pgdat = NODE_DATA(nid);
+    {
+        struct zone *z;
+        int lim=0;
+        printk("%s: zone = ", __FUNCTION__);
+        for_each_zone (z) {
+            printk("%p ", z);
+            if(lim++ > 10)
+                break;
+        }
+        printk("\n");
+    }
+
+    for (i = 0; i < MAX_NR_ZONES; i++) {
+        struct zone *z;
+        struct page *p;
+
+        z = &NODE_DATA(nid)->node_zones[i];
+
+        for (j = 0; j < z->spanned_pages; j++) {
+            p = &z->zone_mem_map[j];
+            ClearPageReserved(p);
+            set_page_count(p, 1);
+            __free_page(p);
+        }
+    }
+    kswapd_start_one(NODE_DATA(nid));
+    setup_per_zone_pages_min();
+}
+

  void
  enable_node(int node)
diff -dupr linux-2.6.7/arch/ia64/mm/init.c linux-2.6.7-mhp/arch/ia64/mm/init.c
--- linux-2.6.7/arch/ia64/mm/init.c    2004-07-14 16:01:25.781060955 -0700
+++ linux-2.6.7-mhp/arch/ia64/mm/init.c    2004-07-14 15:45:48.293767752 -0700
@@ -446,6 +446,15 @@ memmap_init (struct page *start, unsigne
          args.nid = nid;
          args.zone = zone;

+#ifdef CONFIG_MEMHOTPLUG
+        if(system_state == SYSTEM_RUNNING) {
+            unsigned long pstart, pend;
+            get_new_node_memory_info(nid, &pstart, &pend);
+            pstart = PAGE_ALIGN(pstart + PAGE_OFFSET);
+            pend = (pend + PAGE_OFFSET) & PAGE_MASK;
+            virtual_memmap_init(pstart, pend, &args);
+        } else
+#endif
          efi_memmap_walk(virtual_memmap_init, &args);
      }
  }
diff -dupr linux-2.6.7/include/linux/bootmem.h linux-2.6.7-mhp/include/linux/bootmem.h
--- linux-2.6.7/include/linux/bootmem.h    2004-06-15 22:19:52.000000000 -0700
+++ linux-2.6.7-mhp/include/linux/bootmem.h    2004-07-14 15:45:48.294744314 -0700
@@ -36,7 +36,11 @@ typedef struct bootmem_data {
                       * up searching */
  } bootmem_data_t;

+#ifndef CONFIG_MEMHOTPLUG
  extern unsigned long __init bootmem_bootmap_pages (unsigned long);
+#else /* CONFIG_MEMHOTPLUG */
+extern unsigned long bootmem_bootmap_pages (unsigned long);
+#endif
  extern unsigned long __init init_bootmem (unsigned long addr, unsigned long memend);
  extern void __init free_bootmem (unsigned long addr, unsigned long size);
  extern void * __init __alloc_bootmem (unsigned long size, unsigned long align, unsigned long goal);
@@ -53,11 +57,18 @@ extern void __init reserve_bootmem (unsi
  #endif /* !CONFIG_HAVE_ARCH_BOOTMEM_NODE */
  extern unsigned long __init free_all_bootmem (void);

+#ifndef CONFIG_MEMHOTPLUG
  extern unsigned long __init init_bootmem_node (pg_data_t *pgdat, unsigned long freepfn, unsigned long startpfn, unsigned long endpfn);
  extern void __init reserve_bootmem_node (pg_data_t *pgdat, unsigned long physaddr, unsigned long size);
  extern void __init free_bootmem_node (pg_data_t *pgdat, unsigned long addr, unsigned long size);
-extern unsigned long __init free_all_bootmem_node (pg_data_t *pgdat);
  extern void * __init __alloc_bootmem_node (pg_data_t *pgdat, unsigned long size, unsigned long align, unsigned long goal);
+#else /* CONFIG_MEMHOTPLUG */
+extern unsigned long init_bootmem_node (pg_data_t *pgdat, unsigned long freepfn, unsigned long startpfn, unsigned long endpfn);
+extern void reserve_bootmem_node (pg_data_t *pgdat, unsigned long physaddr, unsigned long size);
+extern void free_bootmem_node (pg_data_t *pgdat, unsigned long addr, unsigned long size);
+extern void * __alloc_bootmem_node (pg_data_t *pgdat, unsigned long size, unsigned long align, unsigned long goal);
+#endif
+extern unsigned long __init free_all_bootmem_node (pg_data_t *pgdat);
  #ifndef CONFIG_HAVE_ARCH_BOOTMEM_NODE
  #define alloc_bootmem_node(pgdat, x) \
      __alloc_bootmem_node((pgdat), (x), SMP_CACHE_BYTES, __pa(MAX_DMA_ADDRESS))
diff -dupr linux-2.6.7/mm/bootmem.c linux-2.6.7-mhp/mm/bootmem.c
--- linux-2.6.7/mm/bootmem.c    2004-06-15 22:19:09.000000000 -0700
+++ linux-2.6.7-mhp/mm/bootmem.c    2004-07-14 15:45:48.295720876 -0700
@@ -28,7 +28,11 @@ unsigned long min_low_pfn;
  unsigned long max_pfn;

  /* return the number of _pages_ that will be allocated for the boot bitmap */
+#ifdef CONFIG_MEMHOTPLUG
+unsigned long bootmem_bootmap_pages (unsigned long pages)
+#else
  unsigned long __init bootmem_bootmap_pages (unsigned long pages)
+#endif
  {
      unsigned long mapsize;

@@ -42,14 +46,26 @@ unsigned long __init bootmem_bootmap_pag
  /*
   * Called once to set up the allocator itself.
   */
+#ifdef CONFIG_MEMHOTPLUG
+static unsigned long init_bootmem_core (pg_data_t *pgdat,
+    unsigned long mapstart, unsigned long start, unsigned long end)
+#else
  static unsigned long __init init_bootmem_core (pg_data_t *pgdat,
      unsigned long mapstart, unsigned long start, unsigned long end)
+#endif
  {
      bootmem_data_t *bdata = pgdat->bdata;
      unsigned long mapsize = ((end - start)+7)/8;

-    pgdat->pgdat_next = pgdat_list;
-    pgdat_list = pgdat;
+#ifdef CONFIG_MEMHOTPLUG
+    if (system_state != SYSTEM_RUNNING) {
+#endif
+        pgdat->pgdat_next = pgdat_list;
+        pgdat_list = pgdat;
+#ifdef CONFIG_MEMHOTPLUG
+    } else
+        pgdat->pgdat_next = NULL;
+#endif

      mapsize = (mapsize + (sizeof(long) - 1UL)) & ~(sizeof(long) - 1UL);
      bdata->node_bootmem_map = phys_to_virt(mapstart << PAGE_SHIFT);
@@ -70,7 +86,11 @@ static unsigned long __init init_bootmem
   * might be used for boot-time allocations - or it might get added
   * to the free page pool later on.
   */
+#ifdef CONFIG_MEMHOTPLUG
+static void reserve_bootmem_core(bootmem_data_t *bdata, unsigned long addr, unsigned long size)
+#else
  static void __init reserve_bootmem_core(bootmem_data_t *bdata, unsigned long addr, unsigned long size)
+#endif
  {
      unsigned long i;
      /*
@@ -95,7 +115,11 @@ static void __init reserve_bootmem_core(
          }
  }

+#ifdef CONFIG_MEMHOTPLUG
+static void free_bootmem_core(bootmem_data_t *bdata, unsigned long addr, unsigned long size)
+#else
  static void __init free_bootmem_core(bootmem_data_t *bdata, unsigned long addr, unsigned long size)
+#endif
  {
      unsigned long i;
      unsigned long start;
@@ -138,7 +162,11 @@ static void __init free_bootmem_core(boo
   *
   * NOTE:  This function is _not_ reentrant.
   */
+#ifdef CONFIG_MEMHOTPLUG
+static void *
+#else
  static void * __init
+#endif
  __alloc_bootmem_core(struct bootmem_data *bdata, unsigned long size,
          unsigned long align, unsigned long goal)
  {
@@ -299,17 +327,29 @@ static unsigned long __init free_all_boo
      return total;
  }

+#ifdef CONFIG_MEMHOTPLUG
+unsigned long init_bootmem_node (pg_data_t *pgdat, unsigned long freepfn, unsigned long startpfn, unsigned long endpfn)
+#else
  unsigned long __init init_bootmem_node (pg_data_t *pgdat, unsigned long freepfn, unsigned long startpfn, unsigned long endpfn)
+#endif
  {
      return(init_bootmem_core(pgdat, freepfn, startpfn, endpfn));
  }

+#ifdef CONFIG_MEMHOTPLUG
+void reserve_bootmem_node (pg_data_t *pgdat, unsigned long physaddr, unsigned long size)
+#else
  void __init reserve_bootmem_node (pg_data_t *pgdat, unsigned long physaddr, unsigned long size)
+#endif
  {
      reserve_bootmem_core(pgdat->bdata, physaddr, size);
  }

+#ifdef CONFIG_MEMHOTPLUG
+void free_bootmem_node (pg_data_t *pgdat, unsigned long physaddr, unsigned long size)
+#else
  void __init free_bootmem_node (pg_data_t *pgdat, unsigned long physaddr, unsigned long size)
+#endif
  {
      free_bootmem_core(pgdat->bdata, physaddr, size);
  }
@@ -363,7 +403,11 @@ void * __init __alloc_bootmem (unsigned
      return NULL;
  }

+#ifdef CONFIG_MEMHOTPLUG
+void * __alloc_bootmem_node (pg_data_t *pgdat, unsigned long size, unsigned long align, unsigned long goal)
+#else
  void * __init __alloc_bootmem_node (pg_data_t *pgdat, unsigned long size, unsigned long align, unsigned long goal)
+#endif
  {
      void *ptr;

diff -dupr linux-2.6.7/mm/page_alloc.c linux-2.6.7-mhp/mm/page_alloc.c
--- linux-2.6.7/mm/page_alloc.c    2004-07-14 16:01:25.783990642 -0700
+++ linux-2.6.7-mhp/mm/page_alloc.c    2004-07-14 15:45:48.298650564 -0700
@@ -991,7 +991,11 @@ EXPORT_SYMBOL(__alloc_pages);
  /* Early boot: Everything is done by one cpu, but the data structures will be
   * used by all cpus - spread them on all nodes.
   */
+#ifdef CONFIG_MEMHOTPLUG
+static unsigned long get_boot_pages(unsigned int gfp_mask, unsigned int order)
+#else
  static __init unsigned long get_boot_pages(unsigned int gfp_mask, unsigned int order)
+#endif
  {
  static int nodenr;
      int i = nodenr;




