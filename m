Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267818AbUIFMEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267818AbUIFMEI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 08:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267819AbUIFMEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 08:04:07 -0400
Received: from ozlabs.org ([203.10.76.45]:11491 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267818AbUIFMDt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 08:03:49 -0400
Date: Mon, 6 Sep 2004 22:03:29 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [ppc64] Fix boot memory reporting
Message-ID: <20040906120328.GS7716@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

The memory reporting line was completely broken on NUMA:

Memory: 481600k available (0k kernel code, 0k data, 0k init) [c000000000000000,c000000020000000]

Replace it with something that works with NUMA both enabled and
disabled:

Memory: 485888k/524288k available (4068k kernel code, 38104k reserved, 2348k data, 712k bss, 320k init)

Also just use the section symbols like x86 does.

Anton

Signed-off-by: Anton Blanchard <anton@samba.org>

diff -puN arch/ppc64/mm/init.c~fix_freemem_reporting arch/ppc64/mm/init.c
--- foobar2/arch/ppc64/mm/init.c~fix_freemem_reporting	2004-09-06 21:48:29.823161198 +1000
+++ foobar2-anton/arch/ppc64/mm/init.c	2004-09-06 21:48:29.856158661 +1000
@@ -654,20 +654,18 @@ module_init(setup_kcore);
 
 void __init mem_init(void)
 {
-#ifndef CONFIG_DISCONTIGMEM
-	unsigned long addr;
+#ifdef CONFIG_DISCONTIGMEM
+	int nid;
 #endif
-	int codepages = 0;
-	int datapages = 0;
-	int initpages = 0;
+	pg_data_t *pgdat;
+	unsigned long i;
+	struct page *page;
+	unsigned long reservedpages = 0, codesize, initsize, datasize, bsssize;
 
 	num_physpages = max_low_pfn;	/* RAM is assumed contiguous */
 	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
 
 #ifdef CONFIG_DISCONTIGMEM
-{
-	int nid;
-
         for (nid = 0; nid < numnodes; nid++) {
 		if (NODE_DATA(nid)->node_spanned_pages != 0) {
 			printk("freeing bootmem node %x\n", nid);
@@ -675,38 +673,34 @@ void __init mem_init(void)
 				free_all_bootmem_node(NODE_DATA(nid));
 		}
 	}
-
-	printk("Memory: %luk available (%dk kernel code, %dk data, %dk init) [%08lx,%08lx]\n",
-	       (unsigned long)nr_free_pages()<< (PAGE_SHIFT-10),
-	       codepages<< (PAGE_SHIFT-10), datapages<< (PAGE_SHIFT-10),
-	       initpages<< (PAGE_SHIFT-10),
-	       PAGE_OFFSET, (unsigned long)__va(lmb_end_of_DRAM()));
-}
 #else
 	max_mapnr = num_physpages;
-
 	totalram_pages += free_all_bootmem();
+#endif
 
-	for (addr = KERNELBASE; addr < (unsigned long)__va(lmb_end_of_DRAM());
-	     addr += PAGE_SIZE) {
-		if (!PageReserved(virt_to_page(addr)))
-			continue;
-		if (addr < (unsigned long)_etext)
-			codepages++;
-
-		else if (addr >= (unsigned long)__init_begin
-			 && addr < (unsigned long)__init_end)
-			initpages++;
-		else if (addr < klimit)
-			datapages++;
+	for_each_pgdat(pgdat) {
+		for (i = 0; i < pgdat->node_spanned_pages; i++) {
+			page = pgdat->node_mem_map + i;
+			if (PageReserved(page))
+				reservedpages++;
+		}
 	}
 
-	printk("Memory: %luk available (%dk kernel code, %dk data, %dk init) [%08lx,%08lx]\n",
-	       (unsigned long)nr_free_pages()<< (PAGE_SHIFT-10),
-	       codepages<< (PAGE_SHIFT-10), datapages<< (PAGE_SHIFT-10),
-	       initpages<< (PAGE_SHIFT-10),
-	       PAGE_OFFSET, (unsigned long)__va(lmb_end_of_DRAM()));
-#endif
+	codesize = (unsigned long)&_etext - (unsigned long)&_stext;
+	initsize = (unsigned long)&__init_end - (unsigned long)&__init_begin;
+	datasize = (unsigned long)&_edata - (unsigned long)&__init_end;
+	bsssize = (unsigned long)&__bss_stop - (unsigned long)&__bss_start;
+
+	printk(KERN_INFO "Memory: %luk/%luk available (%luk kernel code, "
+	       "%luk reserved, %luk data, %luk bss, %luk init)\n",
+		(unsigned long)nr_free_pages() << (PAGE_SHIFT-10),
+		num_physpages << (PAGE_SHIFT-10),
+		codesize >> 10,
+		reservedpages << (PAGE_SHIFT-10),
+		datasize >> 10,
+		bsssize >> 10,
+		initsize >> 10);
+
 	mem_init_done = 1;
 
 #ifdef CONFIG_PPC_ISERIES
_
