Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280663AbRKJNyT>; Sat, 10 Nov 2001 08:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280664AbRKJNyM>; Sat, 10 Nov 2001 08:54:12 -0500
Received: from pizda.ninka.net ([216.101.162.242]:24448 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S280663AbRKJNx6>;
	Sat, 10 Nov 2001 08:53:58 -0500
Date: Sat, 10 Nov 2001 05:52:17 -0800 (PST)
Message-Id: <20011110.055217.85412085.davem@redhat.com>
To: anton@samba.org
Cc: ak@suse.de, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: speed difference between using hard-linked and modular drives?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011110.052917.41199152.davem@redhat.com>
In-Reply-To: <20011109073946.A19373@wotan.suse.de>
	<20011110155603.B767@krispykreme>
	<20011110.052917.41199152.davem@redhat.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, this should be a working patch, try this one :-)

diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/arch/alpha/mm/init.c linux/arch/alpha/mm/init.c
--- vanilla/linux/arch/alpha/mm/init.c	Thu Sep 20 20:02:03 2001
+++ linux/arch/alpha/mm/init.c	Sat Nov 10 01:49:56 2001
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
 
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/arch/alpha/mm/numa.c linux/arch/alpha/mm/numa.c
--- vanilla/linux/arch/alpha/mm/numa.c	Sun Aug 12 10:38:48 2001
+++ linux/arch/alpha/mm/numa.c	Sat Nov 10 01:52:27 2001
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
 
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/arch/arm/mm/init.c linux/arch/arm/mm/init.c
--- vanilla/linux/arch/arm/mm/init.c	Thu Oct 11 09:04:57 2001
+++ linux/arch/arm/mm/init.c	Sat Nov 10 01:52:34 2001
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
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/arch/cris/mm/init.c linux/arch/cris/mm/init.c
--- vanilla/linux/arch/cris/mm/init.c	Thu Jul 26 15:10:06 2001
+++ linux/arch/cris/mm/init.c	Sat Nov 10 01:53:10 2001
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
 
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/arch/i386/mm/init.c linux/arch/i386/mm/init.c
--- vanilla/linux/arch/i386/mm/init.c	Thu Sep 20 19:59:20 2001
+++ linux/arch/i386/mm/init.c	Sat Nov 10 01:53:43 2001
@@ -455,6 +455,8 @@
 #endif
 	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
 
+	page_cache_init(count_free_bootmem());
+
 	/* clear the zero-page */
 	memset(empty_zero_page, 0, PAGE_SIZE);
 
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/arch/ia64/mm/init.c linux/arch/ia64/mm/init.c
--- vanilla/linux/arch/ia64/mm/init.c	Fri Nov  9 18:39:51 2001
+++ linux/arch/ia64/mm/init.c	Sat Nov 10 01:54:20 2001
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
 
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/arch/m68k/mm/init.c linux/arch/m68k/mm/init.c
--- vanilla/linux/arch/m68k/mm/init.c	Thu Sep 20 20:02:03 2001
+++ linux/arch/m68k/mm/init.c	Sat Nov 10 01:54:47 2001
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
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/arch/mips/mm/init.c linux/arch/mips/mm/init.c
--- vanilla/linux/arch/mips/mm/init.c	Wed Jul  4 11:50:39 2001
+++ linux/arch/mips/mm/init.c	Sat Nov 10 01:55:09 2001
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
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/arch/mips64/mm/init.c linux/arch/mips64/mm/init.c
--- vanilla/linux/arch/mips64/mm/init.c	Wed Jul  4 11:50:39 2001
+++ linux/arch/mips64/mm/init.c	Sat Nov 10 01:55:30 2001
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
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/arch/mips64/sgi-ip27/ip27-memory.c linux/arch/mips64/sgi-ip27/ip27-memory.c
--- vanilla/linux/arch/mips64/sgi-ip27/ip27-memory.c	Sun Sep  9 10:43:02 2001
+++ linux/arch/mips64/sgi-ip27/ip27-memory.c	Sat Nov 10 02:02:33 2001
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
 
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/arch/parisc/mm/init.c linux/arch/parisc/mm/init.c
--- vanilla/linux/arch/parisc/mm/init.c	Tue Dec  5 12:29:39 2000
+++ linux/arch/parisc/mm/init.c	Sat Nov 10 01:57:11 2001
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
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/arch/ppc/mm/init.c linux/arch/ppc/mm/init.c
--- vanilla/linux/arch/ppc/mm/init.c	Tue Oct  2 09:12:44 2001
+++ linux/arch/ppc/mm/init.c	Sat Nov 10 01:57:34 2001
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
 
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/arch/s390/mm/init.c linux/arch/s390/mm/init.c
--- vanilla/linux/arch/s390/mm/init.c	Thu Oct 11 09:04:57 2001
+++ linux/arch/s390/mm/init.c	Sat Nov 10 01:57:56 2001
@@ -186,6 +186,8 @@
         /* clear the zero-page */
         memset(empty_zero_page, 0, PAGE_SIZE);
 
+	page_cache_init(count_free_bootmem());
+
 	/* this will put all low memory onto the freelists */
 	totalram_pages += free_all_bootmem();
 
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/arch/s390x/mm/init.c linux/arch/s390x/mm/init.c
--- vanilla/linux/arch/s390x/mm/init.c	Fri Nov  9 18:39:51 2001
+++ linux/arch/s390x/mm/init.c	Sat Nov 10 01:58:14 2001
@@ -198,6 +198,8 @@
         /* clear the zero-page */
         memset(empty_zero_page, 0, PAGE_SIZE);
 
+        page_cache_init(count_free_bootmem());
+
 	/* this will put all low memory onto the freelists */
 	totalram_pages += free_all_bootmem();
 
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/arch/sh/mm/init.c linux/arch/sh/mm/init.c
--- vanilla/linux/arch/sh/mm/init.c	Mon Oct 15 13:36:48 2001
+++ linux/arch/sh/mm/init.c	Sat Nov 10 01:59:56 2001
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
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/arch/sparc/mm/init.c linux/arch/sparc/mm/init.c
--- vanilla/linux/arch/sparc/mm/init.c	Mon Oct  1 09:19:56 2001
+++ linux/arch/sparc/mm/init.c	Sat Nov 10 05:30:31 2001
@@ -1,4 +1,4 @@
-/*  $Id: init.c,v 1.100 2001/09/21 22:51:47 davem Exp $
+/*  $Id: init.c,v 1.101 2001/11/10 13:30:31 davem Exp $
  *  linux/arch/sparc/mm/init.c
  *
  *  Copyright (C) 1995 David S. Miller (davem@caip.rutgers.edu)
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
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/arch/sparc64/mm/init.c linux/arch/sparc64/mm/init.c
--- vanilla/linux/arch/sparc64/mm/init.c	Tue Oct 30 15:08:11 2001
+++ linux/arch/sparc64/mm/init.c	Sat Nov 10 05:30:31 2001
@@ -1,4 +1,4 @@
-/*  $Id: init.c,v 1.199 2001/10/25 18:48:03 davem Exp $
+/*  $Id: init.c,v 1.201 2001/11/10 13:30:31 davem Exp $
  *  arch/sparc64/mm/init.c
  *
  *  Copyright (C) 1996-1999 David S. Miller (davem@caip.rutgers.edu)
@@ -16,6 +16,7 @@
 #include <linux/blk.h>
 #include <linux/swap.h>
 #include <linux/swapctl.h>
+#include <linux/pagemap.h>
 
 #include <asm/head.h>
 #include <asm/system.h>
@@ -1400,7 +1401,7 @@
 	if (second_alias_page)
 		spitfire_flush_dtlb_nucleus_page(second_alias_page);
 
-	flush_tlb_all();
+	__flush_tlb_all();
 
 	{
 		unsigned long zones_size[MAX_NR_ZONES];
@@ -1584,6 +1585,8 @@
 
 	max_mapnr = last_valid_pfn - (phys_base >> PAGE_SHIFT);
 	high_memory = __va(last_valid_pfn << PAGE_SHIFT);
+
+	page_cache_init(count_free_bootmem());
 
 	num_physpages = free_all_bootmem() - 1;
 
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/include/linux/bootmem.h linux/include/linux/bootmem.h
--- vanilla/linux/include/linux/bootmem.h	Mon Nov  5 12:43:18 2001
+++ linux/include/linux/bootmem.h	Sat Nov 10 02:33:45 2001
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
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/init/main.c linux/init/main.c
--- vanilla/linux/init/main.c	Fri Nov  9 18:40:00 2001
+++ linux/init/main.c	Sat Nov 10 04:58:16 2001
@@ -597,7 +597,6 @@
 	proc_caches_init();
 	vfs_caches_init(mempages);
 	buffer_init(mempages);
-	page_cache_init(mempages);
 #if defined(CONFIG_ARCH_S390)
 	ccwcache_init();
 #endif
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/mm/bootmem.c linux/mm/bootmem.c
--- vanilla/linux/mm/bootmem.c	Tue Sep 18 14:10:43 2001
+++ linux/mm/bootmem.c	Sat Nov 10 05:18:53 2001
@@ -154,6 +154,9 @@
 	if (align & (align-1))
 		BUG();
 
+	offset = (bdata->node_boot_start & (align - 1));
+	offset >>= PAGE_SHIFT;
+
 	/*
 	 * We try to allocate bootmem pages above 'goal'
 	 * first, then we try to allocate lower pages.
@@ -165,6 +168,7 @@
 		preferred = 0;
 
 	preferred = ((preferred + align - 1) & ~(align - 1)) >> PAGE_SHIFT;
+	preferred += offset;
 	areasize = (size+PAGE_SIZE-1)/PAGE_SIZE;
 	incr = align >> PAGE_SHIFT ? : 1;
 
@@ -184,7 +188,7 @@
 	fail_block:;
 	}
 	if (preferred) {
-		preferred = 0;
+		preferred = offset;
 		goto restart_scan;
 	}
 	return NULL;
@@ -272,6 +276,28 @@
 	return total;
 }
 
+static unsigned long __init count_free_bootmem_core(pg_data_t *pgdat)
+{
+	bootmem_data_t *bdata = pgdat->bdata;
+	unsigned long i, idx, total;
+
+	if (!bdata->node_bootmem_map) BUG();
+
+	total = 0;
+	idx = bdata->node_low_pfn - (bdata->node_boot_start >> PAGE_SHIFT);
+	for (i = 0; i < idx; i++) {
+		if (!test_bit(i, bdata->node_bootmem_map))
+			total++;
+	}
+
+	/*
+	 * Count the allocator bitmap itself.
+	 */
+	total += ((bdata->node_low_pfn-(bdata->node_boot_start >> PAGE_SHIFT))/8 + PAGE_SIZE-1)/PAGE_SIZE;
+
+	return total;
+}
+
 unsigned long __init init_bootmem_node (pg_data_t *pgdat, unsigned long freepfn, unsigned long startpfn, unsigned long endpfn)
 {
 	return(init_bootmem_core(pgdat, freepfn, startpfn, endpfn));
@@ -292,6 +318,11 @@
 	return(free_all_bootmem_core(pgdat));
 }
 
+unsigned long __init count_free_bootmem_node (pg_data_t *pgdat)
+{
+	return(count_free_bootmem_core(pgdat));
+}
+
 unsigned long __init init_bootmem (unsigned long start, unsigned long pages)
 {
 	max_low_pfn = pages;
@@ -312,6 +343,11 @@
 unsigned long __init free_all_bootmem (void)
 {
 	return(free_all_bootmem_core(&contig_page_data));
+}
+
+unsigned long __init count_free_bootmem (void)
+{
+	return(count_free_bootmem_core(&contig_page_data));
 }
 
 void * __init __alloc_bootmem (unsigned long size, unsigned long align, unsigned long goal)
diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/mm/filemap.c linux/mm/filemap.c
--- vanilla/linux/mm/filemap.c	Fri Nov  9 18:40:00 2001
+++ linux/mm/filemap.c	Sat Nov 10 05:15:16 2001
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
