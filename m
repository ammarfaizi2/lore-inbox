Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262993AbTIRHNU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 03:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262994AbTIRHNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 03:13:20 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:34202 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262993AbTIRHNP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 03:13:15 -0400
Date: Thu, 18 Sep 2003 09:12:49 +0200
From: Jens Axboe <axboe@suse.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Olivier Galibert <galibert@limsi.fr>,
       Stephan von Krawczynski <skraw@ithnet.com>, neilb@cse.unsw.edu.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: experiences beyond 4 GB RAM with 2.4.22
Message-ID: <20030918071249.GT906@suse.de>
References: <20030917191946.GQ906@suse.de> <Pine.LNX.4.44.0309171629520.3994-100000@logos.cnet> <20030918070845.GS906@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030918070845.GS906@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 18 2003, Jens Axboe wrote:
> On Wed, Sep 17 2003, Marcelo Tosatti wrote:
> > 
> > 
> > On Wed, 17 Sep 2003, Jens Axboe wrote:
> > 
> > > On Wed, Sep 17 2003, Alan Cox wrote:
> > > > On Maw, 2003-09-16 at 20:58, Olivier Galibert wrote:
> > > > > On Tue, Sep 16, 2003 at 04:29:02PM +0100, Alan Cox wrote:
> > > > > > The kernel has no idea what you will do with given ram. It does try to
> > > > > > make some guesses but you are basically trying to paper over hardware
> > > > > > limits.
> > > > > 
> > > > > Is there a way to specifically turn that ram into a tmpfs though?
> > > > 
> > > > 
> > > > Something like z2ram copied and hacked a little to kmap the blocks it
> > > > wants would give you a block device you could use for swap or for /tmp.
> > > > Im not sure tmpfs would work here
> > > 
> > > Aditionally, you need GFP_DMA32 or similar. Would also alleviate the
> > > nasty pressure on ZONE_NORMAL which is often quite stressed.
> > 
> > IMO such GFP_DMA32 flag is a bit intrusive for 2.4, isnt it?
> 
> Not really, it's just an extra zone. Maybe I can dig such a patch up, I
> had one for 2.4.2-pre something...

This is the latest I had, for 2.4.5. Pretty simple and nonintrusive at
that time.

diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.5/arch/i386/mm/init.c linux/arch/i386/mm/init.c
--- /opt/kernel/linux-2.4.5/arch/i386/mm/init.c	Sat Apr 21 01:15:20 2001
+++ linux/arch/i386/mm/init.c	Sun May 27 17:50:26 2001
@@ -25,6 +25,7 @@
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
 #include <linux/bootmem.h>
+#include <linux/pci.h>
 
 #include <asm/processor.h>
 #include <asm/system.h>
@@ -348,12 +349,15 @@
 	kmap_init();
 #endif
 	{
-		unsigned long zones_size[MAX_NR_ZONES] = {0, 0, 0};
-		unsigned int max_dma, high, low;
+		unsigned long zones_size[MAX_NR_ZONES] = {0, 0, 0, 0};
+		unsigned int max_dma, max_dma32, high, low, high32;
 
 		max_dma = virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT;
+		max_dma32 = PCI_MAX_DMA32 >> PAGE_SHIFT;
 		low = max_low_pfn;
-		high = highend_pfn;
+		high32 = high = highend_pfn;
+		if (high32 > max_dma32)
+			high32 = max_dma32 + 1;	/* first map in HIGHMEM */
 
 		if (low < max_dma)
 			zones_size[ZONE_DMA] = low;
@@ -361,12 +365,12 @@
 			zones_size[ZONE_DMA] = max_dma;
 			zones_size[ZONE_NORMAL] = low - max_dma;
 #ifdef CONFIG_HIGHMEM
-			zones_size[ZONE_HIGHMEM] = high - low;
+			zones_size[ZONE_DMA32] = high32 - low;
+			zones_size[ZONE_HIGHMEM] = high - high32;
 #endif
 		}
 		free_area_init(zones_size);
 	}
-	return;
 }
 
 /*
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.5/include/linux/mm.h linux/include/linux/mm.h
--- /opt/kernel/linux-2.4.5/include/linux/mm.h	Sat May 26 13:30:50 2001
+++ linux/include/linux/mm.h	Tue May 29 15:46:02 2001
@@ -476,8 +476,10 @@
 #define __GFP_IO	0x04
 #define __GFP_DMA	0x08
 #ifdef CONFIG_HIGHMEM
-#define __GFP_HIGHMEM	0x10
+#define __GFP_DMA32	0x10
+#define __GFP_HIGHMEM	0x20
 #else
+#define __GFP_DMA32	0x0 /* noop */
 #define __GFP_HIGHMEM	0x0 /* noop */
 #endif
 
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.5/include/linux/mmzone.h linux/include/linux/mmzone.h
--- /opt/kernel/linux-2.4.5/include/linux/mmzone.h	Sat May 26 13:30:50 2001
+++ linux/include/linux/mmzone.h	Sun May 27 18:26:59 2001
@@ -27,7 +27,8 @@
  *
  * ZONE_DMA	  < 16 MB	ISA DMA capable memory
  * ZONE_NORMAL	16-896 MB	direct mapped by the kernel
- * ZONE_HIGHMEM	 > 896 MB	only page cache and user processes
+ * ZONE_DMA32	> 892MB < 4GB	For 32-bit DMA
+ * ZONE_HIGHMEM	> 4GB		only page cache and user processes
  */
 typedef struct zone_struct {
 	/*
@@ -62,8 +63,9 @@
 
 #define ZONE_DMA		0
 #define ZONE_NORMAL		1
-#define ZONE_HIGHMEM		2
-#define MAX_NR_ZONES		3
+#define ZONE_DMA32		2
+#define ZONE_HIGHMEM		3
+#define MAX_NR_ZONES		4
 
 /*
  * One allocation request operates on a zonelist. A zonelist
@@ -81,7 +83,7 @@
 	int gfp_mask;
 } zonelist_t;
 
-#define NR_GFPINDEX		0x20
+#define NR_GFPINDEX		0x40
 
 /*
  * The pg_data_t structure is used in machines with CONFIG_DISCONTIGMEM
diff -ur --exclude-from /home/axboe/exclude /opt/kernel/linux-2.4.5/mm/page_alloc.c linux/mm/page_alloc.c
--- /opt/kernel/linux-2.4.5/mm/page_alloc.c	Sat May 26 13:30:50 2001
+++ linux/mm/page_alloc.c	Sun May 27 23:47:22 2001
@@ -598,6 +598,7 @@
 
 	while (pgdat) {
 		pages += pgdat->node_zones[ZONE_HIGHMEM].free_pages;
+		pages += pgdat->node_zones[ZONE_DMA32].free_pages;
 		pgdat = pgdat->node_next;
 	}
 	return pages;
@@ -683,6 +684,8 @@
 		k = ZONE_NORMAL;
 		if (i & __GFP_HIGHMEM)
 			k = ZONE_HIGHMEM;
+		if (i & __GFP_DMA32)
+			k = ZONE_DMA32;
 		if (i & __GFP_DMA)
 			k = ZONE_DMA;
 
@@ -700,6 +703,14 @@
 #endif
 					zonelist->zones[j++] = zone;
 				}
+			case ZONE_DMA32:
+				zone = pgdat->node_zones + ZONE_DMA32;
+				if (zone->size) {
+#ifndef CONFIG_HIGHMEM
+					BUG();
+#endif
+					zonelist->zones[j++] = zone;
+				}
 			case ZONE_NORMAL:
 				zone = pgdat->node_zones + ZONE_NORMAL;
 				if (zone->size)
@@ -833,8 +844,11 @@
 		for (i = 0; i < size; i++) {
 			struct page *page = mem_map + offset + i;
 			page->zone = zone;
-			if (j != ZONE_HIGHMEM)
+			if (j != ZONE_HIGHMEM && j != ZONE_DMA32) {
 				page->virtual = __va(zone_start_paddr);
+			} else
+				page->virtual = NULL;
+
 			zone_start_paddr += PAGE_SIZE;
 		}
 

-- 
Jens Axboe

