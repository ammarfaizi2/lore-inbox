Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280635AbRKJNbJ>; Sat, 10 Nov 2001 08:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280637AbRKJNbC>; Sat, 10 Nov 2001 08:31:02 -0500
Received: from pizda.ninka.net ([216.101.162.242]:5760 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S280635AbRKJNaz>;
	Sat, 10 Nov 2001 08:30:55 -0500
Date: Sat, 10 Nov 2001 05:29:17 -0800 (PST)
Message-Id: <20011110.052917.41199152.davem@redhat.com>
To: anton@samba.org
Cc: ak@suse.de, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: speed difference between using hard-linked and modular drives?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011110155603.B767@krispykreme>
In-Reply-To: <20011108.220444.95062095.davem@redhat.com>
	<20011109073946.A19373@wotan.suse.de>
	<20011110155603.B767@krispykreme>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Anton Blanchard <anton@samba.org>
   Date: Sat, 10 Nov 2001 15:56:03 +1100
   
   You can see the average depth of the get_free_page hash is way too deep.
   I agree there are a lot of pagecache pages (17GB in the gfp test and 21GB
   in the vmalloc test), but we have to make use of the 32GB of RAM :)

Anton, are you bored?  :-) If so, could you test out the patch
below on your ppc64 box?  It does the "page hash table via bootmem"
thing.  It is against 2.4.15-pre2

The ppc64 specific bits you'll need to do, but they should
be very straight forward.

It also fixes a really stupid bug in the bootmem allocator.
If the bootmem area starts in some unaligned address, the
"align" argument to the bootmem allocator isn't honored.

--- ./arch/alpha/mm/init.c.~1~	Sun Oct 21 02:47:53 2001
+++ ./arch/alpha/mm/init.c	Sat Nov 10 01:49:56 2001
@@ -23,6 +23,7 @@
 #ifdef CONFIG_BLK_DEV_INITRD
 #include <linux/blk.h>
 #endif
+#include <linux/pagemap.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -360,6 +361,7 @@
 mem_init(void)
 {
 	max_mapnr = num_physpages = max_low_pfn;
+	page_cache_init(count_free_bootmem());
 	totalram_pages += free_all_bootmem();
 	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
 
--- ./arch/alpha/mm/numa.c.~1~	Sun Oct 21 02:47:53 2001
+++ ./arch/alpha/mm/numa.c	Sat Nov 10 01:52:27 2001
@@ -15,6 +15,7 @@
 #ifdef CONFIG_BLK_DEV_INITRD
 #include <linux/blk.h>
 #endif
+#include <linux/pagemap.h>
 
 #include <asm/hwrpb.h>
 #include <asm/pgalloc.h>
@@ -359,8 +360,13 @@
 	extern char _text, _etext, _data, _edata;
 	extern char __init_begin, __init_end;
 	extern unsigned long totalram_pages;
-	unsigned long nid, i;
+	unsigned long nid, i, num_free_bootmem_pages;
 	mem_map_t * lmem_map;
+
+	num_free_bootmem_pages = 0;
+	for (nid = 0; nid < numnodes; nid++)
+		num_free_bootmem_pages += count_free_bootmem_node(NODE_DATA(nid));
+	page_cache_init(num_free_bootmem_pages);
 
 	high_memory = (void *) __va(max_mapnr <<PAGE_SHIFT);
 
--- ./arch/arm/mm/init.c.~1~	Sun Oct 21 02:47:53 2001
+++ ./arch/arm/mm/init.c	Sat Nov 10 01:52:34 2001
@@ -23,6 +23,7 @@
 #include <linux/init.h>
 #include <linux/bootmem.h>
 #include <linux/blk.h>
+#include <linux/pagemap.h>
 
 #include <asm/segment.h>
 #include <asm/mach-types.h>
@@ -594,6 +595,7 @@
 void __init mem_init(void)
 {
 	unsigned int codepages, datapages, initpages;
+	unsigned long num_free_bootmem_pages;
 	int i, node;
 
 	codepages = &_etext - &_text;
@@ -608,6 +610,11 @@
 	 */
 	if (meminfo.nr_banks != 1)
 		create_memmap_holes(&meminfo);
+
+	num_free_bootmem_pages = 0;
+	for (node = 0; node < numnodes; node++)
+		num_free_bootmem_pages += count_free_bootmem_node(NODE_DATA(node));
+	page_cache_init(num_free_bootmem_pages);
 
 	/* this will put all unused low memory onto the freelists */
 	for (node = 0; node < numnodes; node++) {
--- ./arch/i386/mm/init.c.~1~	Sun Oct 21 02:47:53 2001
+++ ./arch/i386/mm/init.c	Sat Nov 10 01:53:43 2001
@@ -455,6 +455,8 @@
 #endif
 	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
 
+	page_cache_init(count_free_bootmem());
+
 	/* clear the zero-page */
 	memset(empty_zero_page, 0, PAGE_SIZE);
 
--- ./arch/m68k/mm/init.c.~1~	Sun Oct 21 02:47:53 2001
+++ ./arch/m68k/mm/init.c	Sat Nov 10 01:54:47 2001
@@ -20,6 +20,7 @@
 #ifdef CONFIG_BLK_DEV_RAM
 #include <linux/blk.h>
 #endif
+#include <linux/pagemap.h>
 
 #include <asm/setup.h>
 #include <asm/uaccess.h>
@@ -135,6 +136,8 @@
 	if (MACH_IS_ATARI)
 		atari_stram_mem_init_hook();
 #endif
+
+	page_cache_init(count_free_bootmem());
 
 	/* this will put all memory onto the freelists */
 	totalram_pages = free_all_bootmem();
--- ./arch/mips/mm/init.c.~1~	Sun Oct 21 02:47:53 2001
+++ ./arch/mips/mm/init.c	Sat Nov 10 01:55:09 2001
@@ -28,6 +28,7 @@
 #ifdef CONFIG_BLK_DEV_INITRD
 #include <linux/blk.h>
 #endif
+#include <linux/pagemap.h>
 
 #include <asm/bootinfo.h>
 #include <asm/cachectl.h>
@@ -203,6 +204,8 @@
 
 	max_mapnr = num_physpages = max_low_pfn;
 	high_memory = (void *) __va(max_mapnr << PAGE_SHIFT);
+
+	page_cache_init(count_free_bootmem());
 
 	totalram_pages += free_all_bootmem();
 	totalram_pages -= setup_zero_pages();	/* Setup zeroed pages.  */
--- ./arch/ppc/mm/init.c.~1~	Sun Oct 21 02:47:53 2001
+++ ./arch/ppc/mm/init.c	Sat Nov 10 01:57:34 2001
@@ -34,6 +34,7 @@
 #ifdef CONFIG_BLK_DEV_INITRD
 #include <linux/blk.h>		/* for initrd_* */
 #endif
+#include <linux/pagemap.h>
 
 #include <asm/pgalloc.h>
 #include <asm/prom.h>
@@ -462,6 +463,8 @@
 
 	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
 	num_physpages = max_mapnr;	/* RAM is assumed contiguous */
+
+	page_cache_init(count_free_bootmem());
 
 	totalram_pages += free_all_bootmem();
 
--- ./arch/sparc/mm/init.c.~1~	Sun Oct 21 02:47:53 2001
+++ ./arch/sparc/mm/init.c	Sat Nov 10 01:59:48 2001
@@ -25,6 +25,7 @@
 #include <linux/init.h>
 #include <linux/highmem.h>
 #include <linux/bootmem.h>
+#include <linux/pagemap.h>
 
 #include <asm/system.h>
 #include <asm/segment.h>
@@ -434,6 +435,8 @@
 
 	max_mapnr = last_valid_pfn - (phys_base >> PAGE_SHIFT);
 	high_memory = __va(max_low_pfn << PAGE_SHIFT);
+
+	page_cache_init(count_free_bootmem());
 
 #ifdef DEBUG_BOOTMEM
 	prom_printf("mem_init: Calling free_all_bootmem().\n");
--- ./arch/sparc64/mm/init.c.~1~	Fri Nov  9 18:42:08 2001
+++ ./arch/sparc64/mm/init.c	Sat Nov 10 02:00:23 2001
@@ -16,6 +16,7 @@
 #include <linux/blk.h>
 #include <linux/swap.h>
 #include <linux/swapctl.h>
+#include <linux/pagemap.h>
 
 #include <asm/head.h>
 #include <asm/system.h>
@@ -1584,6 +1585,8 @@
 
 	max_mapnr = last_valid_pfn - (phys_base >> PAGE_SHIFT);
 	high_memory = __va(last_valid_pfn << PAGE_SHIFT);
+
+	page_cache_init(count_free_bootmem());
 
 	num_physpages = free_all_bootmem() - 1;
 
--- ./arch/sh/mm/init.c.~1~	Sun Oct 21 02:47:53 2001
+++ ./arch/sh/mm/init.c	Sat Nov 10 01:59:56 2001
@@ -26,6 +26,7 @@
 #endif
 #include <linux/highmem.h>
 #include <linux/bootmem.h>
+#include <linux/pagemap.h>
 
 #include <asm/processor.h>
 #include <asm/system.h>
@@ -139,6 +140,7 @@
 void __init mem_init(void)
 {
 	extern unsigned long empty_zero_page[1024];
+	unsigned long num_free_bootmem_pages;
 	int codesize, reservedpages, datasize, initsize;
 	int tmp;
 
@@ -148,6 +150,12 @@
 	/* clear the zero-page */
 	memset(empty_zero_page, 0, PAGE_SIZE);
 	__flush_wback_region(empty_zero_page, PAGE_SIZE);
+
+	num_free_bootmem_pages = count_free_bootmem_node(NODE_DATA(0));
+#ifdef CONFIG_DISCONTIGMEM
+	num_free_bootmem_pages += count_free_bootmem_node(NODE_DATA(1));
+#endif
+	page_cache_init(num_free_bootmem_pages);
 
 	/* this will put all low memory onto the freelists */
 	totalram_pages += free_all_bootmem_node(NODE_DATA(0));
--- ./arch/s390/mm/init.c.~1~	Sun Oct 21 02:47:53 2001
+++ ./arch/s390/mm/init.c	Sat Nov 10 01:57:56 2001
@@ -186,6 +186,8 @@
         /* clear the zero-page */
         memset(empty_zero_page, 0, PAGE_SIZE);
 
+	page_cache_init(count_free_bootmem());
+
 	/* this will put all low memory onto the freelists */
 	totalram_pages += free_all_bootmem();
 
--- ./arch/ia64/mm/init.c.~1~	Fri Nov  9 19:08:02 2001
+++ ./arch/ia64/mm/init.c	Sat Nov 10 01:54:20 2001
@@ -13,6 +13,7 @@
 #include <linux/reboot.h>
 #include <linux/slab.h>
 #include <linux/swap.h>
+#include <linux/pagemap.h>
 
 #include <asm/bitops.h>
 #include <asm/dma.h>
@@ -406,6 +407,8 @@
 
 	max_mapnr = max_low_pfn;
 	high_memory = __va(max_low_pfn * PAGE_SIZE);
+
+	page_cache_init(count_free_bootmem());
 
 	totalram_pages += free_all_bootmem();
 
--- ./arch/mips64/mm/init.c.~1~	Sun Oct 21 02:47:53 2001
+++ ./arch/mips64/mm/init.c	Sat Nov 10 01:55:30 2001
@@ -25,6 +25,7 @@
 #ifdef CONFIG_BLK_DEV_INITRD
 #include <linux/blk.h>
 #endif
+#include <linux/pagemap.h>
 
 #include <asm/bootinfo.h>
 #include <asm/cachectl.h>
@@ -396,6 +397,8 @@
 
 	max_mapnr = num_physpages = max_low_pfn;
 	high_memory = (void *) __va(max_mapnr << PAGE_SHIFT);
+
+	page_cache_init(count_free_bootmem());
 
 	totalram_pages += free_all_bootmem();
 	totalram_pages -= setup_zero_pages();	/* Setup zeroed pages.  */
--- ./arch/mips64/sgi-ip27/ip27-memory.c.~1~	Sun Oct 21 02:47:53 2001
+++ ./arch/mips64/sgi-ip27/ip27-memory.c	Sat Nov 10 02:02:33 2001
@@ -15,6 +15,7 @@
 #include <linux/mm.h>
 #include <linux/bootmem.h>
 #include <linux/swap.h>
+#include <linux/pagemap.h>
 
 #include <asm/page.h>
 #include <asm/bootinfo.h>
@@ -277,6 +278,11 @@
 	num_physpages = numpages;	/* memory already sized by szmem */
 	max_mapnr = pagenr;		/* already found during paging_init */
 	high_memory = (void *) __va(max_mapnr << PAGE_SHIFT);
+
+	tmp = 0;
+	for (nid = 0; nid < numnodes; nid++)
+		tmp += count_free_bootmem_node(NODE_DATA(nid));
+	page_cache_init(tmp);
 
 	for (nid = 0; nid < numnodes; nid++) {
 
--- ./arch/parisc/mm/init.c.~1~	Sun Oct 21 02:47:53 2001
+++ ./arch/parisc/mm/init.c	Sat Nov 10 01:57:11 2001
@@ -17,6 +17,7 @@
 #include <linux/pci.h>		/* for hppa_dma_ops and pcxl_dma_ops */
 #include <linux/swap.h>
 #include <linux/unistd.h>
+#include <linux/pagemap.h>
 
 #include <asm/pgalloc.h>
 
@@ -48,6 +49,8 @@
 {
 	max_mapnr = num_physpages = max_low_pfn;
 	high_memory = __va(max_low_pfn * PAGE_SIZE);
+
+	page_cache_init(count_free_bootmem());
 
 	totalram_pages += free_all_bootmem();
 	printk("Memory: %luk available\n", totalram_pages << (PAGE_SHIFT-10));
--- ./arch/cris/mm/init.c.~1~	Sun Oct 21 02:47:53 2001
+++ ./arch/cris/mm/init.c	Sat Nov 10 01:53:10 2001
@@ -95,6 +95,7 @@
 #include <linux/swap.h>
 #include <linux/smp.h>
 #include <linux/bootmem.h>
+#include <linux/pagemap.h>
 
 #include <asm/system.h>
 #include <asm/segment.h>
@@ -366,6 +367,8 @@
 
 	max_mapnr = num_physpages = max_low_pfn - min_low_pfn;
  
+	page_cache_init(count_free_bootmem());
+
 	/* this will put all memory onto the freelists */
         totalram_pages = free_all_bootmem();
 
--- ./arch/s390x/mm/init.c.~1~	Fri Nov  9 19:08:02 2001
+++ ./arch/s390x/mm/init.c	Sat Nov 10 01:58:14 2001
@@ -198,6 +198,8 @@
         /* clear the zero-page */
         memset(empty_zero_page, 0, PAGE_SIZE);
 
+        page_cache_init(count_free_bootmem());
+
 	/* this will put all low memory onto the freelists */
 	totalram_pages += free_all_bootmem();
 
--- ./include/linux/bootmem.h.~1~	Fri Nov  9 19:35:08 2001
+++ ./include/linux/bootmem.h	Sat Nov 10 02:33:45 2001
@@ -43,11 +43,13 @@
 #define alloc_bootmem_low_pages(x) \
 	__alloc_bootmem((x), PAGE_SIZE, 0)
 extern unsigned long __init free_all_bootmem (void);
+extern unsigned long __init count_free_bootmem (void);
 
 extern unsigned long __init init_bootmem_node (pg_data_t *pgdat, unsigned long freepfn, unsigned long startpfn, unsigned long endpfn);
 extern void __init reserve_bootmem_node (pg_data_t *pgdat, unsigned long physaddr, unsigned long size);
 extern void __init free_bootmem_node (pg_data_t *pgdat, unsigned long addr, unsigned long size);
 extern unsigned long __init free_all_bootmem_node (pg_data_t *pgdat);
+extern unsigned long __init count_free_bootmem_node (pg_data_t *pgdat);
 extern void * __init __alloc_bootmem_node (pg_data_t *pgdat, unsigned long size, unsigned long align, unsigned long goal);
 #define alloc_bootmem_node(pgdat, x) \
 	__alloc_bootmem_node((pgdat), (x), SMP_CACHE_BYTES, __pa(MAX_DMA_ADDRESS))
--- ./init/main.c.~1~	Fri Nov  9 19:08:11 2001
+++ ./init/main.c	Sat Nov 10 04:58:16 2001
@@ -597,7 +597,6 @@
 	proc_caches_init();
 	vfs_caches_init(mempages);
 	buffer_init(mempages);
-	page_cache_init(mempages);
 #if defined(CONFIG_ARCH_S390)
 	ccwcache_init();
 #endif
--- ./mm/filemap.c.~1~	Fri Nov  9 19:08:11 2001
+++ ./mm/filemap.c	Sat Nov 10 05:15:16 2001
@@ -24,6 +24,7 @@
 #include <linux/mm.h>
 #include <linux/iobuf.h>
 #include <linux/compiler.h>
+#include <linux/bootmem.h>
 
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
@@ -2929,28 +2930,48 @@
 	goto unlock;
 }
 
+/* This is called from the arch specific mem_init routine.
+ * It is done right before free_all_bootmem (or NUMA equivalent).
+ *
+ * The mempages arg is the number of pages free_all_bootmem is
+ * going to liberate, or a close approximation.
+ *
+ * We have to use bootmem because on huge systems (ie. 16GB ram)
+ * get_free_pages cannot give us a large enough allocation.
+ */
 void __init page_cache_init(unsigned long mempages)
 {
-	unsigned long htable_size, order;
+	unsigned long htable_size, real_size;
 
 	htable_size = mempages;
 	htable_size *= sizeof(struct page *);
-	for(order = 0; (PAGE_SIZE << order) < htable_size; order++)
+
+	for (real_size = 1UL; real_size < htable_size; real_size <<= 1UL)
 		;
 
 	do {
-		unsigned long tmp = (PAGE_SIZE << order) / sizeof(struct page *);
+		unsigned long tmp = (real_size / sizeof(struct page *));
+		unsigned long align;
 
 		page_hash_bits = 0;
 		while((tmp >>= 1UL) != 0UL)
 			page_hash_bits++;
+		
+		align = real_size;
+		if (align > (4UL * 1024UL * 1024UL))
+			align = (4UL * 1024UL * 1024UL);
+
+		page_hash_table = __alloc_bootmem(real_size, align,
+						  __pa(MAX_DMA_ADDRESS));
+
+		/* Perhaps the alignment was too strict. */
+		if (page_hash_table == NULL)
+			page_hash_table = alloc_bootmem(real_size);
+	} while (page_hash_table == NULL &&
+		 (real_size >>= 1UL) >= PAGE_SIZE);
 
-		page_hash_table = (struct page **)
-			__get_free_pages(GFP_ATOMIC, order);
-	} while(page_hash_table == NULL && --order > 0);
-
-	printk("Page-cache hash table entries: %d (order: %ld, %ld bytes)\n",
-	       (1 << page_hash_bits), order, (PAGE_SIZE << order));
+	printk("Page-cache hash table entries: %d (%ld bytes)\n",
+	       (1 << page_hash_bits), real_size);
 	if (!page_hash_table)
 		panic("Failed to allocate page hash table\n");
 	memset((void *)page_hash_table, 0, PAGE_HASH_SIZE * sizeof(struct page *));
