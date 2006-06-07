Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751084AbWFGAq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbWFGAq3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 20:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWFGAq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 20:46:29 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:64468 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751084AbWFGAq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 20:46:28 -0400
Date: Wed, 7 Jun 2006 09:43:55 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Cc: y-goto@jp.fujitsu.com, mbligh@google.com, apw@shadowen.org,
       linux-kernel@vger.kernel.org, 76306.1226@compuserve.com
Subject: Re: sparsemem panic in 2.6.17-rc5-mm1 and -mm2
Message-Id: <20060607094355.b77ed883.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060606002758.631118da.akpm@osdl.org>
References: <20060605200727.374cbf05.akpm@osdl.org>
	<20060606141922.c5fb16ad.kamezawa.hiroyu@jp.fujitsu.com>
	<20060606142347.2AF2.Y-GOTO@jp.fujitsu.com>
	<20060606002758.631118da.akpm@osdl.org>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jun 2006 00:27:58 -0700
Andrew Morton <akpm@osdl.org> wrote:

> 
> I tried sparsemem on my little x86 box here.  Boots OK, after fixing up the
> kswapd_init() patch (below).
> 
> I'm wondering why I have 4k of highmem:
> 

Could you show /proc/iomem of your 4k HIGHMEM box ?
Does 4k HIGHMEM exist only when SPARSEMEM is selected ?

Thanks,
-Kame






> MemTotal:       898200 kB
> MemFree:        832936 kB
> Buffers:          8824 kB
> Cached:          30140 kB
> SwapCached:          0 kB
> Active:          25052 kB
> Inactive:        20800 kB
> HighTotal:           4 kB
> HighFree:            4 kB
> LowTotal:       898196 kB
> LowFree:        832932 kB
> SwapTotal:     1020116 kB
> SwapFree:      1020116 kB
> Dirty:               0 kB
> Writeback:           0 kB
> Mapped:          10340 kB
> Slab:            10252 kB
> CommitLimit:   1469216 kB
> Committed_AS:    15496 kB
> PageTables:        528 kB
> VmallocTotal:   114680 kB
> VmallocUsed:       648 kB
> VmallocChunk:   113980 kB
> HugePages_Total:     0
> HugePages_Free:      0
> HugePages_Rsvd:      0
> Hugepagesize:     4096 kB
> 
> The dmesg is at http://www.zip.com.au/~akpm/linux/patches/stuff/log-vmm. 
> The machine has 900MB of memory (9*128M).
> 
> 
> <enables UNALIGNED_ZONE_BOUNDARIES like the nice message says>
> <http://www.zip.com.au/~akpm/linux/patches/stuff/log-vmm-2>
> 
> Nope, I still have a 4k highmem zone.
> 
> 
> 
> btw Andy, that UNALIGNED_ZONE_BOUNDARIES message is useless.  Only 0.1% of
> users even have the knowledge how to recompile their kernel, let alone the
> inclination.  Can we do something smarter here?
> 
> <goes off to use his one-page highmem zone for something>
> 
> 
> 
> --- devel/mm/vmscan.c~initialise-total_memory-earlier	2006-06-05 23:59:50.000000000 -0700
> +++ devel-akpm/mm/vmscan.c	2006-06-06 00:00:59.000000000 -0700
> @@ -111,7 +111,7 @@ struct shrinker {
>   * From 0 .. 100.  Higher means more swappy.
>   */
>  int vm_swappiness = 60;
> -static long total_memory;
> +long total_memory;
>  
>  static LIST_HEAD(shrinker_list);
>  static DECLARE_RWSEM(shrinker_rwsem);
> @@ -1499,7 +1499,6 @@ static int __init kswapd_init(void)
>  	for_each_online_node(nid)
>   		kswapd_run(nid);
>  
> -	total_memory = nr_free_pagecache_pages();
>  	hotcpu_notifier(cpu_callback, 0);
>  	return 0;
>  }
> diff -puN mm/page_alloc.c~initialise-total_memory-earlier mm/page_alloc.c
> --- devel/mm/page_alloc.c~initialise-total_memory-earlier	2006-06-06 00:00:13.000000000 -0700
> +++ devel-akpm/mm/page_alloc.c	2006-06-06 00:01:28.000000000 -0700
> @@ -1725,9 +1725,9 @@ void __meminit build_all_zonelists(void)
>  		stop_machine_run(__build_all_zonelists, NULL, NR_CPUS);
>  		/* cpuset refresh routine should be here */
>  	}
> -
> -	printk("Built %i zonelists\n", num_online_nodes());
> -
> +	total_memory = nr_free_pagecache_pages();
> +	printk("Built %i zonelists.  Total memory: %ld pages\n",
> +			num_online_nodes(), total_memory);
>  }
>  
>  /*
> diff -puN include/linux/swap.h~initialise-total_memory-earlier include/linux/swap.h
> --- devel/include/linux/swap.h~initialise-total_memory-earlier	2006-06-06 00:00:44.000000000 -0700
> +++ devel-akpm/include/linux/swap.h	2006-06-06 00:00:56.000000000 -0700
> @@ -185,6 +185,7 @@ extern unsigned long try_to_free_pages(s
>  extern unsigned long shrink_all_memory(unsigned long nr_pages);
>  extern int vm_swappiness;
>  extern int remove_mapping(struct address_space *mapping, struct page *page);
> +extern long total_memory;
>  
>  #ifdef CONFIG_NUMA
>  extern int zone_reclaim_mode;
> _
> 
> 

