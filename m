Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269130AbUHYCGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269130AbUHYCGe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 22:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269137AbUHYCGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 22:06:34 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12744 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269130AbUHYCF1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 22:05:27 -0400
Date: Tue, 24 Aug 2004 21:27:09 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrew Morton <akpm@osdl.org>
Cc: nickpiggin@yahoo.com.au, us15@os.inf.tu-dresden.de, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Message-ID: <20040825002709.GB11484@logos.cnet>
References: <Pine.LNX.4.58.0408121813190.1839@ppc970.osdl.org> <20040820000238.55e22081@laptop.delusion.de> <20040820001154.0a5cf331.akpm@osdl.org> <20040820001905.27a9ff8f@laptop.delusion.de> <4125AD23.4000705@yahoo.com.au> <20040823230824.3c937d88@laptop.delusion.de> <412AF113.6000804@yahoo.com.au> <20040824182036.GB8806@logos.cnet> <20040824130027.77b7b0f9.akpm@osdl.org> <20040824184015.GD8806@logos.cnet>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <20040824184015.GD8806@logos.cnet>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

 I suppose your question is not "_why_ all_unreclaimable is getting set?" but 
> "maybe it should not be getting set?". 

Now I realize both are the same. Doh.

> Anyway, will RTFS.

Done some tests and I can only get zone->all_unreclaimable to be set near
OOM condition, as expected. 

Udo, can you please confirm you are not hitting lack of swap space by applying
the attached patch (which contains Nick's patch) on top of 2.6.9-rc1. 

I've found a different bug, however: On a 512MB box with 512MB swap running 2.6.9-rc1, 
the OOM kill triggers killing a task with swap space available (the task in case is quintela's 
fillmem). I can only make it happen after having the OOM killer trigger for real. ie:

- run fillmem 1024

setting all_unreclaimable!!
setting all_unreclaimable!!
setting all_unreclaimable!!

oom-killer: gfp_mask=0x1d2
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
HighMem per-cpu: empty
 
Free pages:        2808kB (0kB HighMem)
Active:63316 inactive:62992 dirty:0 writeback:0 unstable:0 free:702 slab:1051 mapped:126279 pagetables:287
DMA free:1440kB min:20kB low:40kB high:60kB active:5428kB inactive:5076kB present:16384kB pages_scanned:8416 all_unreclaimable? yes
protections[]: 10 360 360
Normal free:1368kB min:700kB low:1400kB high:2100kB active:247836kB inactive:246892kB present:507888kB pages_scanned:950688 all_unreclaimable? yes
protections[]: 0 350 350
protections[]: 0 350 350
HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
DMA: 0*4kB 0*8kB 0*16kB 1*32kB 2*64kB 0*128kB 1*256kB 0*512kB 1*1024kB 0*2048kB 0*4096kB = 1440kB
Normal: 0*4kB 1*8kB 1*16kB 0*32kB 1*64kB 0*128kB 1*256kB 0*512kB 1*1024kB 0*2048kB 0*4096kB = 1368kB
HighMem: empty
nr_free_swap_pages: 0
Swap cache: add 131105, delete 131105, find 16/28, race 0+0
Out of Memory: Killed process 933 (fillmem).

Perfect. Everything as expected.

- run fillmem 800:

setting all_unreclaimable!!
oom-killer: gfp_mask=0x1d2
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
HighMem per-cpu: empty
                                                                                
Free pages:        2808kB (0kB HighMem)
Active:126301 inactive:17 dirty:0 writeback:0 unstable:0 free:702 slab:1024 mapped:126333 pagetables:280
DMA free:1440kB min:20kB low:40kB high:60kB active:10508kB inactive:0kB present:16384kB pages_scanned:1000 all_unreclaimable? no
protections[]: 10 360 360
Normal free:1368kB min:700kB low:1400kB high:2100kB active:494696kB inactive:68kB present:507888kB pages_scanned:123 all_unreclaimable? no
protections[]: 0 350 350
HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
DMA: 0*4kB 2*8kB 3*16kB 3*32kB 0*64kB 0*128kB 1*256kB 0*512kB 1*1024kB 0*2048kB 0*4096kB = 1440kB
Normal: 0*4kB 1*8kB 1*16kB 0*32kB 1*64kB 0*128kB 1*256kB 0*512kB 1*1024kB 0*2048kB 0*4096kB = 1368kB
HighMem: empty
nr_free_swap_pages: 12167
Swap cache: add 1320161, delete 1319682, find 291280/333316, race 0+0
Out of Memory: Killed process 1010 (fillmem).

Oops. Thats really bad.

Will see if I discover something while trying to understand the
fine source tomorrow morning. Maybe someone can figure out whats
wrong before I try to... 

Bed time.

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="vm-reclaim2.patch"

--- mm/page_alloc.c.orig	2004-08-24 20:37:53.000000000 -0300
+++ mm/page_alloc.c	2004-08-24 22:51:49.498375608 -0300
@@ -1021,11 +1021,12 @@
 void show_free_areas(void)
 {
 	struct page_state ps;
-	int cpu, temperature;
+	int cpu, temperature, i;
 	unsigned long active;
 	unsigned long inactive;
 	unsigned long free;
 	struct zone *zone;
+	unsigned int swap_pages = 0;
 
 	for_each_zone(zone) {
 		show_node(zone);
@@ -1086,6 +1087,8 @@
 			" active:%lukB"
 			" inactive:%lukB"
 			" present:%lukB"
+			" pages_scanned:%lu"
+			" all_unreclaimable? %s"
 			"\n",
 			zone->name,
 			K(zone->free_pages),
@@ -1094,7 +1097,9 @@
 			K(zone->pages_high),
 			K(zone->nr_active),
 			K(zone->nr_inactive),
-			K(zone->present_pages)
+			K(zone->present_pages),
+			zone->pages_scanned,
+			(zone->all_unreclaimable ? "yes" : "no")
 			);
 		printk("protections[]:");
 		for (i = 0; i < MAX_NR_ZONES; i++)
@@ -1125,6 +1130,18 @@
 		printk("= %lukB\n", K(total));
 	}
 
+	swap_list_lock();
+	for (i = 0; i < nr_swapfiles; i++) {
+		if (!(swap_info[i].flags & SWP_USED) ||
+		     (swap_info[i].flags & SWP_WRITEOK))
+                       continue;
+		swap_pages += swap_info[i].inuse_pages;
+	}
+	swap_pages += nr_swap_pages;
+	swap_list_unlock();
+
+	printk("nr_free_swap_pages: %u\n", swap_pages);
+
 	show_swap_cache_info();
 }
 

--SLDf9lqlvOQaIe6s--
