Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261826AbUKJBnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbUKJBnU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 20:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261828AbUKJBnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 20:43:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:4833 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261826AbUKJBjp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 20:39:45 -0500
Date: Tue, 9 Nov 2004 17:39:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: Stefan Schmidt <zaphodb@zaphods.net>
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org,
       piggin@cyberone.com.au, netdev@oss.sgi.com
Subject: Re: 2.6.10-rc1-mm4 -1 EAGAIN after allocation failure was: Re:
 Kernel 2.6.9 Multiple Page Allocation Failures
Message-Id: <20041109173920.08746dbd.akpm@osdl.org>
In-Reply-To: <20041110012733.GD20754@zaphods.net>
References: <20041103222447.GD28163@zaphods.net>
	<20041104121722.GB8537@logos.cnet>
	<20041104181856.GE28163@zaphods.net>
	<20041109164113.GD7632@logos.cnet>
	<20041109223558.GR1309@mail.muni.cz>
	<20041109144607.2950a41a.akpm@osdl.org>
	<20041109235201.GC20754@zaphods.net>
	<20041110012733.GD20754@zaphods.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Added netdev to Cc.  Full cite.

Stefan Schmidt <zaphodb@zaphods.net> wrote:
>
> Alright, i got a funny thing here that i suspect to be an(other?) vm issue:
> 
> We are running a third-party closed source software which handles many tcp
> sessions and reads and writes that to/from several disks/partitions.
> With 2.6.10-rc1-mm4 it is the first time we notice that, right after the kernel
> throws a swapper: page allocation error thread (just like the ones you already
> know), the interrupt rate, connection count and traffic decreases subsequently.
> 
> Here is part of a vmstat 10:
> procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
>  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
>  1  0  11312  19404    268 1896896    0    0  1091 17578 25463  1225  7 38 37 18
>  0  0  11312  26372    180 1892836    0    0  1182 21433 25576  1216  7 38 31 24
>  1  2  11308  23784    608 1890168    0    0  1252 20667 25532  1243  7 40 24 29
>  0  2  11308  23304    428 1890552    0    0  1174 20363 25948  1332  7 40 32 21
>  1  1  11304  18496    444 1893328    0    0  1630 20506 25840  1322  7 38 30 26
>  1  1  11304   8712    232 1905508    0    0  1528 19662 26245  1305  7 40 25 28
>  1  0  11304  18952    180 1894000    0    0  1595 19680 26275  1215  7 38 27 28
>  1  0  11304  22404    132 1896632    0    0   369 17724 24072  1045  7 37 49  7
>  1  0  11304  23956    492 1899876    0    0   504 19609 20829  1151  9 34 49  7
>  1  0  11304  25380    460 1908340    0    0   424 17983 16964   927  9 28 55  8
>  1  0  11304  18244    464 1922140    0    0   309 14431 13417   836 10 27 60  3
>  0  0  11304  17720    472 1928388    0    0   224 11868 9933   607 11 23 63  3
>  1  0  11304  25720    476 1924440    0    0   133  7663 6780   504 10 20 68  2
>  1  0  11304  24156    488 1928168    0    0   107  6244 5011   315  8 18 73  1
>  0  0  11304  19544    712 1934268    0    0    76  3191 4464   299  8 18 73  1
>  0  0  11304  19248    728 1936564    0    0    23  1802 4002   249  7 17 76  0
>  1  0  11304  27092    736 1929892    0    0    16  1336 3655   284  6 16 78  0
>  0  0  11304  26472    752 1931984    0    0    19  1508 3408   248  5 16 78  1
>  0  0  11304  19000    768 1940944    0    0    20  1398 3195   226  5 14 81  0
>  1  0  11304  21460    776 1938896    0    0    14  1084 3057   241  5 14 82  0
>  0  0  11304  26268    848 1934608    0    0    12   927 2906   218  5 13 82  0
>  1  1  11304  22076    900 1939860    0    0    18   679 2897   215  5 11 84  1
>  0  0  11304  25880    952 1936748    0    0    17   653 2713   251  4 13 82  1
>  0  0  11304  20436    976 1942368    0    0     8  1117 2703   229  5 11 83  1
> ...
> 
> strace shows:
> 01:38:50.316041 gettimeofday({1100047130, 316054}, NULL) = 0
> 01:38:50.316188 poll([{fd=5671, events=POLLIN}, {fd=2727, events=POLLIN}, {fd=6663, events=POLLIN}, {fd=197, events=POLLIN}, {fd=3978, events=POLLIN}, {fd=779, events=POLLIN}, ...{line continues like this}...
> ...
> 01:38:50.328056 accept(5, 0xbffd4ab8, [16]) = -1 EAGAIN (Resource temporarily unavailable) ...{an awful lot of these}...
> ...
> 01:38:50.329585 futex(0xaf1a698, FUTEX_WAIT, 92828, {0, 9964000}) = -1 ETIMEDOUT (Connection timed out) ...{some of these}...
> ...
> Application says:
> "n.n.n.n:p Client closed connection in body read"
> 
> To me it seems like suddently all those open sockets are suddenly 'temporarily
> unavailable' to the application and so the connections time out.
> I have not (yet?) seen this behaviour on 2.6.9, 2.6.9-mm1, 2.6.10-rc1-bk12 or
> 2.6.10-rc1-mm3.
> I am able to reproduce the behaviour if under the same load iptraf or
> tethereal are started. (First thought it might be because of the promisc mode.)
> 
> This seems to be what _might_ have triggered this although it was logged
> happened 5m earlier than the traffic decay:
> 
>  printk: 36 messages suppressed.
>  swapper: page allocation failure. order:0, mode:0x20
>   [__alloc_pages+525/912] __alloc_pages+0x20d/0x390
>   [__get_free_pages+24/48] __get_free_pages+0x18/0x30
>   [kmem_getpages+24/192] kmem_getpages+0x18/0xc0
>   [cache_grow+157/304] cache_grow+0x9d/0x130
>   [cache_alloc_refill+380/576] cache_alloc_refill+0x17c/0x240
>   [__kmalloc+122/144] __kmalloc+0x7a/0x90
>   [alloc_skb+50/208] alloc_skb+0x32/0xd0
>   [tg3_alloc_rx_skb+112/304] tg3_alloc_rx_skb+0x70/0x130
>   [tg3_rx+518/944] tg3_rx+0x206/0x3b0
>   [tg3_poll+139/336] tg3_poll+0x8b/0x150
>   [net_rx_action+125/288] net_rx_action+0x7d/0x120
>   [__do_softirq+184/208] __do_softirq+0xb8/0xd0
>   [do_softirq+45/48] do_softirq+0x2d/0x30
>   [do_IRQ+30/48] do_IRQ+0x1e/0x30
>   [common_interrupt+26/32] common_interrupt+0x1a/0x20
>   [default_idle+0/64] default_idle+0x0/0x40
>   [default_idle+44/64] default_idle+0x2c/0x40
>   [cpu_idle+51/64] cpu_idle+0x33/0x40
>   [start_kernel+331/368] start_kernel+0x14b/0x170
>   [unknown_bootoption+0/432] unknown_bootoption+0x0/0x1b0
>  DMA per-cpu:
>  cpu 0 hot: low 2, high 6, batch 1
>  cpu 0 cold: low 0, high 2, batch 1
>  cpu 1 hot: low 2, high 6, batch 1
>  cpu 1 cold: low 0, high 2, batch 1
>  Normal per-cpu:
>  cpu 0 hot: low 32, high 96, batch 16
>  cpu 0 cold: low 0, high 32, batch 16
>  cpu 1 hot: low 32, high 96, batch 16
>  cpu 1 cold: low 0, high 32, batch 16
>  HighMem per-cpu:
>  cpu 0 hot: low 32, high 96, batch 16
>  cpu 0 cold: low 0, high 32, batch 16
>  cpu 1 hot: low 32, high 96, batch 16
>  cpu 1 cold: low 0, high 32, batch 16
>  
>  Free pages:        4616kB (1600kB HighMem)
>  Active:504159 inactive:454759 dirty:20020 writeback:115 unstable:0 free:1154 slab:50758 mapped:489095 pagetables:1222
>  DMA free:56kB min:144kB low:288kB high:432kB active:1936kB inactive:4932kB present:16384kB pages_scanned:32 all_unreclaimable? no
>  protections[]: 0 0 0
>  Normal free:2960kB min:8044kB low:16088kB high:24132kB active:492320kB inactive:166992kB present:901120kB pages_scanned:62 all_unreclaimable? no
>  protections[]: 0 0 0
>  HighMem free:1600kB min:512kB low:1024kB high:1536kB active:1522380kB inactive:1647112kB present:3178432kB pages_scanned:0 all_unreclaimable? no
>  protections[]: 0 0 0
>  DMA: 0*4kB 1*8kB 1*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 56kB
>  Normal: 0*4kB 0*8kB 1*16kB 0*32kB 2*64kB 0*128kB 1*256kB 1*512kB 0*1024kB 1*2048kB 0*4096kB = 2960kB
>  HighMem: 6*4kB 3*8kB 41*16kB 0*32kB 6*64kB 0*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 1600kB
>  Swap cache: add 154147, delete 151810, find 29532/39794, race 0+0
> 

Well you've definitely used up all the memory which is available for atomic
allocations.  Are you using an increased /proc/sys/vm/min_free_kbytes there?

As for the application collapse: dunno.  Maybe networking broke.  It would
be interesting to test Linus's current tree, at
ftp://ftp.kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.10-rc1-bk19.gz

