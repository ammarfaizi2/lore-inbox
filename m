Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262567AbUKXJVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262567AbUKXJVR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 04:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbUKXJUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 04:20:43 -0500
Received: from [220.248.27.114] ([220.248.27.114]:28596 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S262560AbUKXJS7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 04:18:59 -0500
Date: Wed, 24 Nov 2004 17:13:21 +0800
From: hugang@soulinfo.com
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev@lists.linuxppc.org, benh@kernel.crashing.org
Subject: Re: [PATH] 11-24 swsusp update 3/3
Message-ID: <20041124091320.GA6195@hugang.soulinfo.com>
References: <20041119194007.GA1650@hugang.soulinfo.com> <20041122103240.GA11323@hugang.soulinfo.com> <20041122110247.GB1063@elf.ucw.cz> <200411221254.40732.rjw@sisk.pl> <1101160249.7962.52.camel@desktop.cunninghams> <20041123215402.GE25926@elf.ucw.cz> <20041124080459.GC3455@hugang.soulinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041124080459.GC3455@hugang.soulinfo.com>
User-Agent: Mutt/1.3.28i
X-Virus-Checked: Checked
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2004 at 04:04:59PM +0800, hugang@soulinfo.com wrote:
> --ppc.diff--
> 

Slient warnning message when writing page cache to swap device and fix a bug.


diff -ur linux-2.6.9-ppc-g4-peval-11-24/include/linux/suspend.h linux-2.6.9-ppc-g4-peval-hg/include/linux/suspend.h
--- linux-2.6.9-ppc-g4-peval-11-24/include/linux/suspend.h	2004-11-24 16:12:29.000000000 +0800
+++ linux-2.6.9-ppc-g4-peval-hg/include/linux/suspend.h	2004-11-24 16:51:48.000000000 +0800
@@ -1,7 +1,7 @@
 #ifndef _LINUX_SWSUSP_H
 #define _LINUX_SWSUSP_H
 
-#if (definedCONFIG_X86) || (defined CONFIG_PPC32)
+#if (defined(CONFIG_X86)) || (defined (CONFIG_PPC32))
 #include <asm/suspend.h>
 #endif
 #include <linux/swap.h>
diff -ur linux-2.6.9-ppc-g4-peval-11-24/kernel/power/disk.c linux-2.6.9-ppc-g4-peval-hg/kernel/power/disk.c
--- linux-2.6.9-ppc-g4-peval-11-24/kernel/power/disk.c	2004-11-24 16:12:29.000000000 +0800
+++ linux-2.6.9-ppc-g4-peval-hg/kernel/power/disk.c	2004-11-24 15:59:56.000000000 +0800
@@ -123,8 +123,8 @@
 static void finish(void)
 {
 	device_resume();
-	read_page_caches();
 	platform_finish();
+	read_page_caches();
 	enable_nonboot_cpus();
 	thaw_processes();
 	pm_restore_console();
diff -ur linux-2.6.9-ppc-g4-peval-11-24/kernel/power/swsusp.c linux-2.6.9-ppc-g4-peval-hg/kernel/power/swsusp.c
--- linux-2.6.9-ppc-g4-peval-11-24/kernel/power/swsusp.c	2004-11-24 16:12:29.000000000 +0800
+++ linux-2.6.9-ppc-g4-peval-hg/kernel/power/swsusp.c	2004-11-24 17:11:35.000000000 +0800
@@ -221,7 +221,7 @@
 
 #define ONE_PAGE_PBE_NUM	(PAGE_SIZE/sizeof(struct pbe))
 
-/* for each pagdir */
+/* for each pagedir */
 typedef int (*susp_pgdir_t)(suspend_pagedir_t *cur, void *fun, void *arg);
 
 static int inline for_each_pgdir(struct pbe *pbe, susp_pgdir_t fun,
@@ -706,14 +706,14 @@
 int swsusp_pagecache = 0;
 
 /* I'll move this to include/linux/page-flags.h */
-#define PG_pcs (PG_nosave_free + 1)
+#define PG_page_caches (PG_nosave_free + 1)
 
-#define SetPagePcs(page)    set_bit(PG_pcs, &(page)->flags)
-#define ClearPagePcs(page)  clear_bit(PG_pcs, &(page)->flags)
-#define PagePcs(page)   test_bit(PG_pcs, &(page)->flags)
+#define SetPagePcs(page)    set_bit(PG_page_caches, &(page)->flags)
+#define ClearPagePcs(page)  clear_bit(PG_page_caches, &(page)->flags)
+#define PagePcs(page)   test_bit(PG_page_caches, &(page)->flags)
 
 static suspend_pagedir_t *pagedir_cache = NULL;
-static int nr_copy_pcs = 0;
+static int nr_copy_page_caches = 0;
 
 static void lock_pagecaches(void)
 {
@@ -735,7 +735,7 @@
 	}
 }
 
-static int setup_pcs_pe(struct page *page, int setup)
+static int setup_page_caches_pe(struct page *page, int setup)
 {
 	unsigned long pfn = page_to_pfn(page);
 
@@ -757,24 +757,24 @@
 		return 0;
 	}
 	if (setup) {
-		struct pbe *p = find_pbe_by_index(pagedir_cache, nr_copy_pcs, -1);
+		struct pbe *p = find_pbe_by_index(pagedir_cache, nr_copy_page_caches, -1);
 		BUG_ON(p == NULL);
 		p->address = (long)page_address(page);
 		BUG_ON(p->address == 0);
-		/*pr_debug("setup_pcs: cur %p, o{%p}, d{%p}, nr %u\n",
+		/*pr_debug("setup_page_caches: cur %p, o{%p}, d{%p}, nr %u\n",
 				(void*)p, (void*)p->orig_address,
-				(void*)p->address, nr_copy_pcs);*/
-		nr_copy_pcs ++;
+				(void*)p->address, nr_copy_page_caches);*/
+		nr_copy_page_caches ++;
 	}
 	SetPagePcs(page);
 
 	return (1);
 }
 
-static int count_pcs(struct zone *zone, int p)
+static int count_page_caches(struct zone *zone, int p)
 {
 	if (swsusp_pagecache)
-		return foreach_zone_page(zone, setup_pcs_pe, p);
+		return foreach_zone_page(zone, setup_page_caches_pe, p);
 	return 0;
 }
 
@@ -898,6 +898,8 @@
 	return (-ENOMEM);
 }
 
+static char *page_cache_buf = NULL;
+
 static int bio_read_page(pgoff_t page_off, void * page);
 
 static int pagecache_read_pbe(struct pbe *p, void *tmp, int cur)
@@ -911,8 +913,9 @@
 			p, (void *)p->orig_address, (void *)p->address, 
 			swp_offset(p->swap_address));
 
-	error = bio_read_page(swp_offset(p->swap_address), (void *)p->address);
+	error = bio_read_page(swp_offset(p->swap_address), page_cache_buf);
 	if (error) return error;
+	memcpy((void*)p->address, (void*)page_cache_buf, PAGE_SIZE);
 
 	entry = p->swap_address;
 	if (entry.val)
@@ -927,15 +930,16 @@
 
 	if (swsusp_pagecache == 0) return 0;
 
-	mod_progress = nr_copy_pcs / 100;
+	mod_progress = nr_copy_page_caches / 100;
 
-	printk( "Reading PageCaches from swap (%d pages)...     ", nr_copy_pcs);
+	printk( "Reading PageCaches from swap (%d pages)...     ", nr_copy_page_caches);
 	error = for_each_pbe(pagedir_cache, pagecache_read_pbe, NULL,
-			nr_copy_pcs);
+			nr_copy_page_caches);
 	printk("\b\b\b\bdone\n");
 
 	unlock_pagecaches();
 	for_each_pgdir(pagedir_cache, free_one_pagedir, NULL, NULL);
+	free_page((unsigned long)page_cache_buf);
 
 	return error;
 }
@@ -949,7 +953,8 @@
 	pr_debug("pagecache_write_pbe: %p, o{%p} c{%p} %d ",
 			p, (void *)p->orig_address, (void *)p->address, cur);
 	BUG_ON(p->address == 0);
-	error = write_page(p->address, &p->swap_address);
+	memcpy((void *)page_cache_buf, (void*)p->address, PAGE_SIZE);
+	error = write_page((unsigned long)page_cache_buf, &p->swap_address);
 	if (error) return error;
 
 	pr_debug("%lu\n", swp_offset(p->swap_address));
@@ -961,12 +966,12 @@
 {
 	int error;
 	
-	mod_progress = nr_copy_pcs / 100;
+	mod_progress = nr_copy_page_caches / 100;
 
 	lock_pagecaches();
-	printk( "Writing PageCaches to swap (%d pages)...     ", nr_copy_pcs);
+	printk( "Writing PageCaches to swap (%d pages)...     ", nr_copy_page_caches);
 	error = for_each_pbe(pagedir_cache, pagecache_write_pbe, NULL, 
-			nr_copy_pcs);
+			nr_copy_page_caches);
 	printk("\b\b\b\bdone\n");
 
 	return error;
@@ -976,10 +981,10 @@
 {
 	struct zone *zone;
 
-	nr_copy_pcs = 0;
+	nr_copy_page_caches = 0;
 	for_each_zone(zone) {
 		if (!is_highmem(zone)) {
-			count_pcs(zone, 1);
+			count_page_caches(zone, 1);
 		}
 	}
 
@@ -997,11 +1002,11 @@
 	for (i = 0; i < max_mapnr; i++)
 		ClearPagePcs(mem_map+i);
 
-	nr_copy_pcs = 0;
+	nr_copy_page_caches = 0;
 	drain_local_pages();
 	for_each_zone(zone) {
 		if (!is_highmem(zone)) {
-			nr_copy_pcs += count_pcs(zone, 0);
+			nr_copy_page_caches += count_pcs(zone, 0);
 		}
 	}
 }
@@ -1017,43 +1022,36 @@
 	}
 
 	if (swsusp_pagecache) {
+		page_cache_buf = (char *)__get_free_pages(GFP_ATOMIC | __GFP_COLD, 0);
+		if (!page_cache_buf) {
+			return -ENOMEM;
+		}
+
 		page_caches_recal();
 
-		if (nr_copy_pcs == 0) {
+		if (nr_copy_page_caches == 0) {
 			return 0;
 		}
-		printk("swsusp: Need to copy %u pcs\n", nr_copy_pcs);
-		if (alloc_pagedir(&pagedir_cache, nr_copy_pcs, NULL, 0) < 0) {
+		if (alloc_pagedir(&pagedir_cache, nr_copy_page_caches, NULL, 0) < 0) {
 			return -ENOMEM;
 		}
 	}
 
 	drain_local_pages();
 	count_data_pages();
-	printk("swsusp(1/2): Need to copy %u pages, %u pcs\n",
-			nr_copy_pages, nr_copy_pcs);
 
-	while (nr_free_pages() < nr_copy_pages + PAGES_FOR_IO) {
-		if (recal == 0) {
-			printk("swsusp: try shrink memory ");
+	if (nr_free_pages() < nr_copy_pages + PAGES_FOR_IO) {
+		printk("swsusp: shrink memory:...     ");
+		while (nr_free_pages() < nr_copy_pages + PAGES_FOR_IO) {
+			shrink_all_memory(nr_copy_pages + PAGES_FOR_IO);
+			recal ++;
+			printk("\b\b\b\b%4d", recal);
 		}
-		shrink_all_memory(nr_copy_pages + PAGES_FOR_IO + recal);
-		recal += PAGES_FOR_IO;
-	}
-
-	if (recal) {
-		printk("done\n");
+		printk("   done\n");
 		page_caches_recal();
 		drain_local_pages();
 		count_data_pages();
-		printk("swsusp(1/2): Need to copy %u pages, %u pcs\n",
-				nr_copy_pages, nr_copy_pcs);
 	}
-	
-	drain_local_pages();
-	count_data_pages();
-	printk("swsusp(2/2): Need to copy %u pages, %u pcs\n",
-			nr_copy_pages, nr_copy_pcs);
 
 	error = swsusp_alloc();
 	if (error) {
@@ -1063,8 +1061,8 @@
 
 	drain_local_pages();
 	count_data_pages();
-	printk("swsusp(final): Need to copy %u pages, %u pcs\n",
-			nr_copy_pages, nr_copy_pcs);
+	printk("swsusp: Need to copy %u pages, %u page_caches, %d freed\n",
+			nr_copy_pages, nr_copy_page_caches, nr_free_pages());
 
 	if (swsusp_pagecache) {
 		setup_pagedir_pbe();
@@ -1125,12 +1123,12 @@
 	unsigned long zone_pfn;
 
 	nr_copy_pages = 0;
-	nr_copy_pcs = 0;
+	nr_copy_page_caches = 0;
 
 	for_each_zone(zone) {
 		if (is_highmem(zone))
 			continue;
-		nr_copy_pcs += count_pcs(zone, 0);
+		nr_copy_page_caches += count_pcs(zone, 0);
 		mark_free_pages(zone);
 		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
 			nr_copy_pages += saveable(zone, &zone_pfn);
@@ -1243,7 +1241,7 @@
 	struct sysinfo i;
 
 	si_swapinfo(&i);
-	if (i.freeswap < (nr_copy_pages + nr_copy_pcs + PAGES_FOR_IO))  {
+	if (i.freeswap < (nr_copy_pages + nr_copy_page_caches + PAGES_FOR_IO))  {
 		pr_debug("swsusp: Not enough swap. Need %ld\n",i.freeswap);
 		return 0;
 	}

-- 
--
Hu Gang / Steve
Linux Registered User 204016
GPG Public Key: http://soulinfo.com/~hugang/hugang.asc
