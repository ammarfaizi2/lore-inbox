Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbWFFH3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWFFH3S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 03:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbWFFH3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 03:29:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56538 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750794AbWFFH3R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 03:29:17 -0400
Date: Tue, 6 Jun 2006 00:27:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: kamezawa.hiroyu@jp.fujitsu.com, mbligh@google.com, apw@shadowen.org,
       linux-kernel@vger.kernel.org, 76306.1226@compuserve.com
Subject: Re: sparsemem panic in 2.6.17-rc5-mm1 and -mm2
Message-Id: <20060606002758.631118da.akpm@osdl.org>
In-Reply-To: <20060606142347.2AF2.Y-GOTO@jp.fujitsu.com>
References: <20060605200727.374cbf05.akpm@osdl.org>
	<20060606141922.c5fb16ad.kamezawa.hiroyu@jp.fujitsu.com>
	<20060606142347.2AF2.Y-GOTO@jp.fujitsu.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Jun 2006 14:36:14 +0900
Yasunori Goto <y-goto@jp.fujitsu.com> wrote:

> 
> > I looked back into 2.6.15, 2.6.16. 
> > It looks -mm's time of initialization of "total_memory" is not changed from them.
> > (yes, Andrew's fix looks sane.)
> > 
> > I'm intersted in the following texts in the log.
> > ==
> > Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 0kB
> > Node 0 DMA32: empty
> > Node 0 Normal: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 0kB
> > Node 0 HighMem: 1*4kB 1*8kB 1*16kB 1*32kB 1*64kB 1*128kB 0*256kB 0*512kB 1*1024kB 2*2048kB 3962*4096kB = 16233724kB
> > Node 1 DMA: empty
> > Node 1 DMA32: empty
> > Node 1 Normal: empty
> > Node 1 HighMem: 1*4kB 1*8kB 0*16kB 0*32kB 0*64kB 1*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 4065*4096kB = 16651916kB
> > Node 2 DMA: empty
> > Node 2 DMA32: empty
> > Node 2 Normal: empty
> > Node 2 HighMem: 1*4kB 1*8kB 0*16kB 0*32kB 0*64kB 1*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 4065*4096kB = 16651916kB
> > Node 3 DMA: empty
> > Node 3 DMA32: empty
> > Node 3 Normal: empty
> > Node 3 HighMem: 1*4kB 1*8kB 0*16kB 0*32kB 0*64kB 1*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 3811*4096kB = 15611532kB
> > ==
> > Looks 64GB memory. but there are only HIGHMEM, no NORMAL, DMA. so, shrink_zone() worked.
> 
> Its log shows there are some memory in DMA and NORMAL just immediately
> before that.....
> 
> > Active:2 inactive:15 dirty:0 writeback:0 unstable:0 free:16287272 slab:1823 mapped:0 pagetables:0
> > Node 0 DMA free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:16384kB pages_scanned:0 all_unreclaimable? no
> lowmem_reserve[]: 0 0 0 0
> > Node 0 DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
> lowmem_reserve[]: 0 0 0 0
> > Node 0 Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:385024kB pages_scanned:0 all_unreclaimable? no
> lowmem_reserve[]: 0 0 0 0
> 
> It looks like that something wasted all of DMA(16MB) and NORMAL(385MB)
> zone suddenly. Hmmm...
> 

I tried sparsemem on my little x86 box here.  Boots OK, after fixing up the
kswapd_init() patch (below).

I'm wondering why I have 4k of highmem:

MemTotal:       898200 kB
MemFree:        832936 kB
Buffers:          8824 kB
Cached:          30140 kB
SwapCached:          0 kB
Active:          25052 kB
Inactive:        20800 kB
HighTotal:           4 kB
HighFree:            4 kB
LowTotal:       898196 kB
LowFree:        832932 kB
SwapTotal:     1020116 kB
SwapFree:      1020116 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:          10340 kB
Slab:            10252 kB
CommitLimit:   1469216 kB
Committed_AS:    15496 kB
PageTables:        528 kB
VmallocTotal:   114680 kB
VmallocUsed:       648 kB
VmallocChunk:   113980 kB
HugePages_Total:     0
HugePages_Free:      0
HugePages_Rsvd:      0
Hugepagesize:     4096 kB

The dmesg is at http://www.zip.com.au/~akpm/linux/patches/stuff/log-vmm. 
The machine has 900MB of memory (9*128M).


<enables UNALIGNED_ZONE_BOUNDARIES like the nice message says>
<http://www.zip.com.au/~akpm/linux/patches/stuff/log-vmm-2>

Nope, I still have a 4k highmem zone.



btw Andy, that UNALIGNED_ZONE_BOUNDARIES message is useless.  Only 0.1% of
users even have the knowledge how to recompile their kernel, let alone the
inclination.  Can we do something smarter here?

<goes off to use his one-page highmem zone for something>



--- devel/mm/vmscan.c~initialise-total_memory-earlier	2006-06-05 23:59:50.000000000 -0700
+++ devel-akpm/mm/vmscan.c	2006-06-06 00:00:59.000000000 -0700
@@ -111,7 +111,7 @@ struct shrinker {
  * From 0 .. 100.  Higher means more swappy.
  */
 int vm_swappiness = 60;
-static long total_memory;
+long total_memory;
 
 static LIST_HEAD(shrinker_list);
 static DECLARE_RWSEM(shrinker_rwsem);
@@ -1499,7 +1499,6 @@ static int __init kswapd_init(void)
 	for_each_online_node(nid)
  		kswapd_run(nid);
 
-	total_memory = nr_free_pagecache_pages();
 	hotcpu_notifier(cpu_callback, 0);
 	return 0;
 }
diff -puN mm/page_alloc.c~initialise-total_memory-earlier mm/page_alloc.c
--- devel/mm/page_alloc.c~initialise-total_memory-earlier	2006-06-06 00:00:13.000000000 -0700
+++ devel-akpm/mm/page_alloc.c	2006-06-06 00:01:28.000000000 -0700
@@ -1725,9 +1725,9 @@ void __meminit build_all_zonelists(void)
 		stop_machine_run(__build_all_zonelists, NULL, NR_CPUS);
 		/* cpuset refresh routine should be here */
 	}
-
-	printk("Built %i zonelists\n", num_online_nodes());
-
+	total_memory = nr_free_pagecache_pages();
+	printk("Built %i zonelists.  Total memory: %ld pages\n",
+			num_online_nodes(), total_memory);
 }
 
 /*
diff -puN include/linux/swap.h~initialise-total_memory-earlier include/linux/swap.h
--- devel/include/linux/swap.h~initialise-total_memory-earlier	2006-06-06 00:00:44.000000000 -0700
+++ devel-akpm/include/linux/swap.h	2006-06-06 00:00:56.000000000 -0700
@@ -185,6 +185,7 @@ extern unsigned long try_to_free_pages(s
 extern unsigned long shrink_all_memory(unsigned long nr_pages);
 extern int vm_swappiness;
 extern int remove_mapping(struct address_space *mapping, struct page *page);
+extern long total_memory;
 
 #ifdef CONFIG_NUMA
 extern int zone_reclaim_mode;
_

