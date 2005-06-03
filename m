Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbVFCPsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbVFCPsZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 11:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbVFCPsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 11:48:25 -0400
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35]:56441 "EHLO
	dgate1.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S261338AbVFCPsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 11:48:00 -0400
X-SBRSScore: None
X-IronPort-AV: i="3.93,166,1114984800"; 
   d="diff'?scan'208"; a="10373426:sNHT52139292"
Message-ID: <42A07BAA.4050303@fujitsu-siemens.com>
Date: Fri, 03 Jun 2005 17:47:54 +0200
From: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Organization: Fujitsu Siemens Computers
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: RFC for 2.6: avoid OOM at bounce buffer storm
Content-Type: multipart/mixed;
 boundary="------------010806050509030403030306"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010806050509030403030306
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I have recently seen massive problems with the bounce buffer allocation 
implementation in 2.6. My system got OOM with an ata_piix controller 
(4GB bounce limit), 2 P4 CPUs and 8GB of RAM with a very simple 
copy-compare test: About 800MB worth of data are copied with cp(1) in 7 
synchronous jobs. Each job does a sync(1) after the copy.

All available ZONE_NORMAL memory is filled with bounce buffers in 
fractions of a second after the sync(1) calls are issued.
The system goes OOM (becomes unusable, OOM killer strikes several times 
against innocent processes).

The attached quick-and-dirty patch gives you an idea of what I figured 
could be a useful workaround for that problem. It follows 2 main ideas:

1 When bounce buffer allocations fail, it is wrong to trigger the page
   reclaim mechanism which is likely to genetate even more bounce buffer
   requests. Thus there should be no wakeup_bdflush() call for the
   page_pool.

2 bounce buffer allocations should not simply use alloc_page() because
   there is no limit for allocations that way. Rather, bounce buffer
   allocations should stop if ZONE_NORMAL is full to a certain degree
   (my patch stops at 51% - chosen arbitrarily).

For the case I described, the system behavior is clearly improved with 
the patch. The system remains usable, and the OOM killer isn't triggered.

(The patch is against an RH enterprise kernel, but it applies against 
almost all recent 2.6.kernels except 2.6.12-rcX).

Idea 1) is already implemented in a recent patch by Nick Piggin which 
went into 2.6.12-rc5. I haven't tested yet if that patch alone fixes my 
problem because I couldn't get 2.6.12-rc5 to run on my system. I doubt 
so, though, because I started with idea 1) alone and it didn't help much.

Here is another idea how the bounce buffer behavior could be enhanced:
Introduce a new memory zone ZONE_4G with memory from 896M-4096M
and allocate bounce buffers preferably in that zone. Advantage: Bounce 
buffers would't interfere with valuable ZONE_NORMAL memory. But that may 
be too much effort just for systems which have too much memory for their 
IO controllers...

Regards
Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1        mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy


--------------010806050509030403030306
Content-Type: text/x-patch;
 name="bounce.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bounce.diff"

diff -rupX /root/diff-exludes linux-2.6.9-6.37.EL-orig/arch/i386/mm/pgtable.c linux-2.6.9-6.37.EL/arch/i386/mm/pgtable.c
--- linux-2.6.9-6.37.EL-orig/arch/i386/mm/pgtable.c	2005-04-11 14:19:03.000000000 +0200
+++ linux-2.6.9-6.37.EL/arch/i386/mm/pgtable.c	2005-05-31 10:27:57.000000000 +0200
@@ -24,6 +24,7 @@
 #include <asm/tlbflush.h>
 #include <asm/atomic_kmap.h>
 
+extern atomic_t n_bounce_pages;
 void show_mem(void)
 {
 	int total = 0, reserved = 0;
@@ -55,6 +56,7 @@ void show_mem(void)
 	printk("%d reserved pages\n",reserved);
 	printk("%d pages shared\n",shared);
 	printk("%d pages swap cached\n",cached);
+	printk("%d bounce buffers used\n",atomic_read(&n_bounce_pages));
 }
 
 EXPORT_SYMBOL_GPL(show_mem);
diff -rupX /root/diff-exludes linux-2.6.9-6.37.EL-orig/Makefile linux-2.6.9-6.37.EL/Makefile
--- linux-2.6.9-6.37.EL-orig/mm/highmem.c	2004-10-18 23:54:37.000000000 +0200
+++ linux-2.6.9-6.37.EL/mm/highmem.c	2005-06-03 15:24:03.000000000 +0200
@@ -28,18 +28,45 @@
 #include <linux/highmem.h>
 #include <asm/tlbflush.h>
 
-static mempool_t *page_pool, *isa_page_pool;
+mempool_t *page_pool, *isa_page_pool;
+atomic_t n_bounce_pages = ATOMIC_INIT(0);
+static unsigned int min_free_pages[MAX_NR_ZONES];
+
+static unsigned int zone_free_pages(int type)
+{
+	pg_data_t *pgdat;
+	unsigned int pages = 0;
+	for_each_pgdat(pgdat)
+		pages += pgdat->node_zones[type].free_pages;
+	return pages;
+}
+
+static int sufficient_lowpages(int gfp)
+{
+	int type = (gfp & __GFP_DMA ? ZONE_DMA : ZONE_NORMAL);
+
+	return (zone_free_pages(type) >= min_free_pages[type]);
+}
 
 static void *page_pool_alloc(int gfp_mask, void *data)
 {
 	int gfp = gfp_mask | (int) (long) data;
+	void *page;
+
+	if (!sufficient_lowpages(gfp))
+		return NULL;
 
-	return alloc_page(gfp);
+	page = alloc_page(gfp);
+
+	if (page)
+		atomic_inc(&n_bounce_pages);
+	return page;
 }
 
 static void page_pool_free(void *page, void *data)
 {
 	__free_page(page);
+	atomic_dec(&n_bounce_pages);
 }
 
 /*
@@ -212,20 +239,25 @@ void fastcall kunmap_high(struct page *p
 EXPORT_SYMBOL(kunmap_high);
 
 #define POOL_SIZE	64
+#define POOL_FRAC(x) ((x)/2)
+#define SMALL_POOL_FRAC(x) ((x)/100)
 
 static __init int init_emergency_pool(void)
 {
+	unsigned int n = zone_free_pages(ZONE_NORMAL);
 	struct sysinfo i;
 	si_meminfo(&i);
 	si_swapinfo(&i);
         
+	min_free_pages[ZONE_NORMAL] = POOL_FRAC(n);
 	if (!i.totalhigh)
 		return 0;
-
-	page_pool = mempool_create(POOL_SIZE, page_pool_alloc, page_pool_free, NULL);
+	n = SMALL_POOL_FRAC(n);
+	n = (n > POOL_SIZE ? n : POOL_SIZE);
+	page_pool = mempool_create(n, page_pool_alloc, page_pool_free, NULL);
 	if (!page_pool)
 		BUG();
-	printk("highmem bounce pool size: %d pages\n", POOL_SIZE);
+	printk("highmem bounce pool size: %d pages, min: %u\n", n, min_free_pages[ZONE_NORMAL]);
 
 	return 0;
 }
@@ -265,11 +297,12 @@ int init_emergency_isa_pool(void)
 	if (isa_page_pool)
 		return 0;
 
+	min_free_pages[ZONE_DMA] = POOL_FRAC(zone_free_pages(ZONE_DMA));
 	isa_page_pool = mempool_create(ISA_POOL_SIZE, page_pool_alloc, page_pool_free, (void *) __GFP_DMA);
 	if (!isa_page_pool)
 		BUG();
 
-	printk("isa bounce pool size: %d pages\n", ISA_POOL_SIZE);
+	printk("isa bounce pool size: %d pages, min: %u\n", ISA_POOL_SIZE, min_free_pages[ZONE_DMA]);
 	return 0;
 }
 
diff -rupX /root/diff-exludes linux-2.6.9-6.37.EL-orig/mm/mempool.c linux-2.6.9-6.37.EL/mm/mempool.c
--- linux-2.6.9-6.37.EL-orig/mm/mempool.c	2004-10-18 23:54:37.000000000 +0200
+++ linux-2.6.9-6.37.EL/mm/mempool.c	2005-06-03 15:35:01.000000000 +0200
@@ -15,6 +15,8 @@
 #include <linux/blkdev.h>
 #include <linux/writeback.h>
 
+extern mempool_t *page_pool, *isa_page_pool;
+
 static void add_element(mempool_t *pool, void *element)
 {
 	BUG_ON(pool->curr_nr >= pool->min_nr);
@@ -211,11 +213,12 @@ repeat_alloc:
 		if (likely(element != NULL))
 			return element;
 	}
-
+	
 	/*
 	 * Kick the VM at this point.
 	 */
-	wakeup_bdflush(0);
+	if (pool != page_pool && pool != isa_page_pool)
+		wakeup_bdflush(0);
 
 	spin_lock_irqsave(&pool->lock, flags);
 	if (likely(pool->curr_nr)) {

--------------010806050509030403030306--
