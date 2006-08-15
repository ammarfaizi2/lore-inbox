Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030198AbWHOKtq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030198AbWHOKtq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 06:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030203AbWHOKtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 06:49:46 -0400
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:6390 "EHLO
	mtaout03-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1030198AbWHOKto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 06:49:44 -0400
Message-ID: <44E1A93E.8020701@gentoo.org>
Date: Tue, 15 Aug 2006 12:00:14 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060811)
MIME-Version: 1.0
To: Peter M <peter.mdk@gmail.com>
CC: linux-kernel@vger.kernel.org, Stephen Hemminger <shemminger@osdl.org>,
       Francois Romieu <romieu@fr.zoreil.com>, ansla80@yahoo.com
Subject: Re: Oops in 2.6.17.7 running multiple eth bridges [r8169?]
References: <31296a430608101034v2ecfbf8an66510427da49af4d@mail.gmail.com>
In-Reply-To: <31296a430608101034v2ecfbf8an66510427da49af4d@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter M wrote:
> I have built a multi bridge i386 machine with 8 eth devices which
> keeps crashing on me.
> 
> Kernel 2.6.7.17
> Below crash came when I unplugged a cable on a running bridge. Today I
> have had two crashes without touching the cables but didn't get any
> usable syslog.

There is a similar report of this on the Gentoo bugzilla:

http://bugs.gentoo.org/143867

However the situation is somewhat different: this is a 3ghz system with 
896mb RAM. Only one network interface, no bridging in use. The failure 
occurred while the network switch was being restarted (presumably all 
the buffers filled up during the "downtime"). It seems to me that such a 
system should be able to cope.

The page allocation failure seems to stem from r8169, however the system 
was obviously running low on memory at this point (it was under load), 
so I'm not sure how well we can avoid this. It is not reproducible either.

Also, the kernel was tainted by the nvidia module so take this whole 
report with a pinch of salt...


> Aug  8 09:54:04 analyzeTHIS kernel: do_IRQ+0x19/0x24  <c0103976>
> common_interrupt+0x1a/0x20
> Aug  8 09:54:11 analyzeTHIS kernel:  <c014358a> __kmalloc+0x5a/0x61
> <c020992c> __alloc_skb+0x4c/0xf2
> Aug  8 09:54:54 analyzeTHIS kernel:  <c88dc759>
> rtl8169_alloc_rx_skb+0x19/0xb0 [r8169]  <c88dc878>
> rtl8169_rx_fill+0x45/0x5a [r8169]
> Aug  8 09:55:26 analyzeTHIS kernel:  <c88dd38b>
> rtl8169_rx_interrupt+0x2af/0x304 [r8169]  <c88dd81c>
> pci_unmap_single+0x0/0x10 [r8169]
> Aug  8 09:56:07 analyzeTHIS kernel:  <c88dd486>
> rtl8169_interrupt+0xa6/0x103 [r8169]  <c012d943>
> handle_IRQ_event+0x20/0x4c
> Aug  8 09:56:22 analyzeTHIS kernel:  <c012d9c2> __do_IRQ+0x53/0x91
> <c0104e59> do_IRQ+0x19/0x24
> Aug  8 09:56:22 analyzeTHIS kernel:  <c0103976>
> common_interrupt+0x1a/0x20  <c010b146> get_offset_pmtmr+0x44/0xefe
> Aug  8 09:56:22 analyzeTHIS kernel:  <c0105a89>
> do_gettimeofday+0x16/0x9d  <c020defa> __net_timestamp+0xf/0x22
> Aug  8 09:56:22 analyzeTHIS kernel:  <c020df28>
> dev_queue_xmit_nit+0x1b/0xec  <c02195bb> qdisc_restart+0x7b/0xee
> Aug  8 09:56:22 analyzeTHIS kernel:  <c020e3f2>
> dev_queue_xmit+0xbe/0x186  <c8a73cb2> br_dev_queue_push_xmit+0xc2/0xc9
> [bridge]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c8a7890f>
> br_nf_post_routing+0x14b/0x158 [bridge]  <c8a73bf0>
> br_dev_queue_push_xmit+0x0/0xc9 [bridge]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c021f894> nf_iterate+0x3f/0x6d
> <c8a73bf0> br_dev_queue_push_xmit+0x0/0xc9 [bridge]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c021f909> nf_hook_slow+0x47/0x9d
> <c8a73bf0> br_dekB 0*4096kB = 476kB
> Aug  8 09:56:22 analyzeTHIS kernel: HighMem: empty
> Aug  8 09:56:22 analyzeTHIS kernel: Swap cache: add 0, delete 0, find
> 0/0, race 0+0
> Aug  8 09:56:22 analyzeTHIS kernel: Free swap  = 506036kB
> Aug  8 09:56:22 analyzeTHIS kernel: Total swap = 506036kB
> Aug  8 09:56:22 analyzeTHIS kernel: Free swap:       506036kB
> Aug  8 09:56:22 analyzeTHIS kernel: 32752 pages of RAM
> Aug  8 09:56:22 analyzeTHIS kernel: 0 pages of HIGHMEM
> Aug  8 09:56:22 analyzeTHIS kernel: 932 reserved pages
> Aug  8 09:56:22 analyzeTHIS kernel: 17487 pages shared
> Aug  8 09:56:22 analyzeTHIS kernel: 0 pages swap cached
> Aug  8 09:56:22 analyzeTHIS kernel: 0 pages dirty
> Aug  8 09:56:22 analyzeTHIS kernel: 0 pages writeback
> Aug  8 09:56:22 analyzeTHIS kernel: 1477 pages mapped
> Aug  8 09:56:22 analyzeTHIS kernel: 11826 pages slab
> Aug  8 09:56:22 analyzeTHIS kernel: 54 pages pagetables
> Aug  8 09:56:22 analyzeTHIS kernel: kswapd0: page allocation failure.
> order:0, mode:0x20
> Aug  8 09:56:22 analyzeTHIS kernel:  <c0132552>
> __alloc_pages+0x254/0x266  <c010f04a>
> smp_local_timer_interrupt+0xb/0x11
> Aug  8 09:56:22 analyzeTHIS kernel:  <c0142688>
> kmem_getpages+0x39/0x91  <c0143127> cache_grow+0x93/0x122
> Aug  8 09:56:22 analyzeTHIS kernel:  <c01432db>
> cache_alloc_refill+0x125/0x15e  <c0143586> __kmalloc+0x56/0x61
> Aug  8 09:56:22 analyzeTHIS kernel:  <c020992c> __alloc_skb+0x4c/0xf2
> <c88dc759> rtl8169_alloc_rx_skb+0x19/0xb0 [r8169]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c88dc878>
> rtl8169_rx_fill+0x45/0x5a [r8169]  <c88dd38b>
> rtl8169_rx_interrupt+0x2af/0x304 [r8169]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c88dd81c>
> pci_unmap_single+0x0/0x10 [r8169]  <c88dd486>
> rtl8169_interrupt+0xa6/0x103 [r8169]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c012d943>
> handle_IRQ_event+0x20/0x4c  <c012d9c2> __do_IRQ+0x53/0x91
> Aug  8 09:56:22 analyzeTHIS kernel:  <c0104e59> do_IRQ+0x19/0x24
> <c0103976> common_interrupt+0x1a/0x20
> Aug  8 09:56:22 analyzeTHIS kernel:  <c014358a> __kmalloc+0x5a/0x61
> <c020992c> __alloc_skb+0x4c/0xf2
> Aug  8 09:56:22 analyzeTHIS kernel:  <c88dc759>
> rtl8169_alloc_rx_skb+0x19/0xb0 [r8169]  <c88dc878>
> rtl8169_rx_fill+0x45/0x5a [r8169]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c88dd38b>
> rtl8169_rx_interrupt+0x2af/0x304 [r8169]  <c88dd81c>
> pci_unmap_single+0x0/0x10 [r8169]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c88dd486>
> rtl8169_interrupt+0xa6/0x103 [r8169]  <c012d943>
> handle_IRQ_event+0x20/0x4c
> Aug  8 09:56:22 analyzeTHIS kernel:  <c012d9c2> __do_IRQ+0x53/0x91
> <c0104e59> do_IRQ+0x19/0x24
> Aug  8 09:56:22 analyzeTHIS kernel:  <c0103976>
> common_interrupt+0x1a/0x20  <c010b146> get_offset_pmtmr+0x44/0xefe
> Aug  8 09:56:22 analyzeTHIS kernel:  <c0105a89>
> do_gettimeofday+0x16/0x9d  <c020defa> __net_timestamp+0xf/0x22
> Aug  8 09:56:22 analyzeTHIS kernel:  <c020df28>
> dev_queue_xmit_nit+0x1b/0xec  <c02195bb> qdisc_restart+0x7b/0xee
> Aug  8 09:56:22 analyzeTHIS kernel:  <c020e3f2>
> dev_queue_xmit+0xbe/0x186  <c8a73cb2> br_dev_queue_push_xmit+0xc2/0xc9
> [bridge]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c8a7890f>
> br_nf_post_routing+0x14b/0x158 [bridge]  <c8a73bf0>
> br_dev_queue_push_xmit+0x0/0xc9 [bridge]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c021f894> nf_iterate+0x3f/0x6d
> <c8a73bf0> br_dev_queue_push_xmit+0x0/0xc9 [bridge]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c021f909> nf_hook_slow+0x47/0x9d
> <c8a73bf0> br_dev_queue_push_xmit+0x0/0xc9 [bridge]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c8a73cb9>
> br_forward_finish+0x0/0x41 [bridge]  <c8a73ce7>
> br_forward_finish+0x2e/0x41 [bridge]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c8a73bf0>
> br_dev_queue_push_xmit+0x0/0xc9 [bridge]  <c8a782bd>
> br_nf_forward_finish+0xc6/0xcb [bridge]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c8a783e2>
> br_nf_forward_ip+0x120/0x12b [bridge]  <c021f894> nf_iterate+0x3f/0x6d
> Aug  8 09:56:22 analyzeTHIS kernel:  <c8a73cb9>
> br_forward_finish+0x0/0x41 [bridge]  <c021f909> nf_hook_slow+0x47/0x9d
> Aug  8 09:56:22 analyzeTHIS kernel:  <c8a73cb9>
> br_forward_finish+0x0/0x41 [bridge]  <c8a73d8d> __br_forward+0x46/0x57
> [bridge]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c8a73cb9>
> br_forward_finish+0x0/0x41 [bridge]  <c8a73e84> br_flood+0x8e/0xa6
> [bridge]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c8a73d47> __br_forward+0x0/0x57
> [bridge]  <c8a73ecc> br_flood_forward+0x16/0x1a [bridge]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c8a73d47> __br_forward+0x0/0x57
> [bridge]  <c8a747db> br_handle_frame_finish+0x89/0xe0 [bridge]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c8a77bae>
> br_nf_pre_routing_finish+0x29b/0x2a9 [bridge]  <c8a8165f>
> ip_conntrack_in+0x192/0x21c [ip_conntrer-cpu:
> Aug  8 09:56:22 analyzeTHIS kernel: cpu 0 hot: high 42, batch 7 used:30
> Aug  8 09:56:22 analyzeTHIS kernel: cpu 0 cold: high 14, batch 3 used:11
> Aug  8 09:56:22 analyzeTHIS kernel: HighMem per-cpu: empty
> Aug  8 09:56:22 analyzeTHIS kernel: Free pages:         976kB (0kB HighMem)
> Aug  8 09:56:22 analyzeTHIS kernel: Active:12345 inactive:6399 dirty:1
> writeback:0 unstable:0 free:244 slab:11918 mapped:1477 pagetables:54
> Aug  8 09:56:22 analyzeTHIS kernel: DMA free:516kB min:180kB low:224kB
> high:268kB active:3500kB inactive:2724kB present:16384kB
> pages_scanned:0 all_unreclaimable? no
> Aug  8 09:56:22 analyzeTHIS kernel: lowmem_reserve[]: 0 0 111 111
> Aug  8 09:56:22 analyzeTHIS kernel: DMA32 free:0kB min:0kB low:0kB
> high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0
> all_unreclaimable? no
> Aug  8 09:56:22 analyzeTHIS kernel: lowmem_reserve[]: 0 0 111 111
> Aug  8 09:56:22 analyzeTHIS kernel: Normal free:460kB min:1260kB
> low:1572kB high:1888kB active:45880kB inactive:22872kB
> present:114624kB pages_scanned:0 all_unreclaimable? no
> Aug  8 09:56:22 analyzeTHIS kernel: lowmem_reserve[]: 0 0 0 0
> Aug  8 09:56:22 analyzeTHIS kernel: HighMem free:0kB min:128kB
> low:128kB high:128kB active:0kB inactive:0kB present:0kB
> pages_scanned:0 all_unreclaimable? no
> Aug  8 09:56:22 analyzeTHIS kernel: lowmem_reserve[]: 0 0 0 0
> Aug  8 09:56:22 analyzeTHIS kernel: DMA: 1*4kB 0*8kB 0*16kB 0*32kB
> 0*64kB 0*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 516kB
> Aug  8 09:56:22 analyzeTHIS kernel: DMA32: empty
> Aug  8 09:56:22 analyzeTHIS kernel: Normal: 3*4kB 0*8kB 0*16kB 0*32kB
> 1*64kB 1*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 460kB
> Aug  8 09:56:22 analyzeTHIS kernel: HighMem: empty
> Aug  8 09:56:22 analyzeTHIS kernel: Swap cache: add 0, delete 0, find
> 0/0, race 0+0
> Aug  8 09:56:22 analyzeTHIS kernel: Free swap  = 506036kB
> Aug  8 09:56:22 analyzeTHIS kernel: Total swap = 506036kB
> Aug  8 09:56:22 analyzeTHIS kernel: Free swap:       506036kB
> Aug  8 09:56:22 analyzeTHIS kernel: 32752 pages of RAM
> Aug  8 09:56:22 analyzeTHIS kernel: 0 pages of HIGHMEM
> Aug  8 09:56:22 analyzeTHIS kernel: 932 reserved pages
> Aug  8 09:56:22 analyzeTHIS kernel: 17391 pages shared
> Aug  8 09:56:22 analyzeTHIS kernel: 0 pages swap cached
> Aug  8 09:56:22 analyzeTHIS kernel: 1 pages dirty
> Aug  8 09:56:22 analyzeTHIS kernel: 0 pages writeback
> Aug  8 09:56:22 analyzeTHIS kernel: 1477 pages mapped
> Aug  8 09:56:22 analyzeTHIS kernel: 11918 pages slab
> Aug  8 09:56:22 analyzeTHIS kernel: 54 pages pagetables
> Aug  8 09:56:22 analyzeTHIS kernel: printk: 1908 messages suppressed.
> Aug  8 09:56:22 analyzeTHIS kernel: events/0: page allocation failure.
> order:0, mode:0x20
> Aug  8 09:56:22 analyzeTHIS kernel:  <c0132552>
> __alloc_pages+0x254/0x266  <c0142688> kmem_getpages+0x39/0x91
> Aug  8 09:56:22 analyzeTHIS kernel:  <c0143127> cache_grow+0x93/0x122
> <c01432db> cache_alloc_refill+0x125/0x15e
> Aug  8 09:56:22 analyzeTHIS kernel:  <c0143586> __kmalloc+0x56/0x61
> <c020992c> __alloc_skb+0x4c/0xf2
> Aug  8 09:56:22 analyzeTHIS kernel:  <c88dc759>
> rtl8169_alloc_rx_skb+0x19/0xb0 [r8169]  <c88dc878>
> rtl8169_rx_fill+0x45/0x5a [r8169]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c88dd38b>
> rtl8169_rx_interrupt+0x2af/0x304 [r8169]  <c88dd81c>
> pci_unmap_single+0x0/0x10 [r8169]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c88dd486>
> rtl8169_interrupt+0xa6/0x103 [r8169]  <c012d943>
> handle_IRQ_event+0x20/0x4c
> Aug  8 09:56:22 analyzeTHIS kernel:  <c012d9c2> __do_IRQ+0x53/0x91
> <c0104e59> do_IRQ+0x19/0x24
> Aug  8 09:56:22 analyzeTHIS kernel:  <c0103976>
> common_interrupt+0x1a/0x20  <c012d93d> handle_IRQ_event+0x1a/0x4c
> Aug  8 09:56:22 analyzeTHIS kernel:  <c012d9c2> __do_IRQ+0x53/0x91
> <c0104e59> do_IRQ+0x19/0x24
> Aug  8 09:56:22 analyzeTHIS kernel:  <c0103976>
> common_interrupt+0x1a/0x20  <c8a788b4> br_nf_post_routing+0xf0/0x158
> [bridge]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c8a73bf0>
> br_dev_queue_push_xmit+0x0/0xc9 [bridge]  <c021f894>
> nf_iterate+0x3f/0x6d
> Aug  8 09:56:22 analyzeTHIS kernel:  <c8a73bf0>
> br_dev_queue_push_xmit+0x0/0xc9 [bridge]  <c021f909>
> nf_hook_slow+0x47/0x9d
> Aug  8 09:56:22 analyzeTHIS kernel:  <c8a73bf0>
> br_dev_queue_push_xmit+0x0/0xc9 [bridge]  <c8a73cb9>
> br_forward_finish+0x0/0x41 [bridge]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c8a73ce7>
> br_forward_finish+0x2e/0x41 [bridge]  <c8a73bf0>
> br_dev_queue_push_xmit+0x0/0xc9 [bridge]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c8a782bd>
> br_nf_forward_finish+0xc6/0xcb [bridge]  <c8a783e2>
> br_nf_forward_ip+0x120/0x12b [bridge]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c021f894> nf_iterate+0x3f/0x6d
> <c8a73cb9> br_forward_finish+0x0/0x41 [bridge]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c021f909> nf_hook_slow+0x47/0x9d
> <c8a73cb9> br_forward_finish+0x0/0x41 [bridge]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c8a73d8d> __br_forward+0x46/0x57
> [bridge]  <c8a73cb9> br_forward_finish+0x0/0x41 [bridge]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c8a73e84> br_flood+0x8e/0xa6
> [bridge]  <c8a73d47> __br_forward+0x0/0x57 [bridge]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c8a73ecc>
> br_flood_forward+0x16/0x1a [bridge]  <c8a73d47> __br_forward+0x0/0x57
> [bridge]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c8a747db>
> br_handle_frame_finish+0x89/0xe0 [bridge]  <c8a77bae>
> br_nf_pre_routing_finish+0x29b/0x2a9 [bridge]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c8a8165f>
> ip_conntrack_in+0x192/0x21c [ip_conntrack]  <c8a77913>
> br_nf_pre_routing_finish+0x0/0x2a9 [bridge]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c021f894> nf_iterate+0x3f/0x6d
> <c8a77913> br_nf_pre_routing_finish+0x0/0x2a9 [bridge]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c021f909> nf_hook_slow+0x47/0x9d
> <c8a77913> br_nf_pre_routing_finish+0x0/0x2a9 [bridge]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c8a74752>
> br_handle_frame_finish+0x0/0xe0 [bridge]  <c8a78186>
> br_nf_pre_routing+0x2e7/0x305 [bridge]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c8a74752>
> br_handle_frame_finish+0x0/0xe0 [bridge]  <c8a78194>
> br_nf_pre_routing+0x2f5/0x305 [bridge]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c021f894> nf_iterate+0x3f/0x6d
> <c8a74752> br_handle_frame_finish+0x0/0xe0 [bridge]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c021f909> nf_hook_slow+0x47/0x9d
> <c8a74752> br_handle_frame_finish+0x0/0xe0 [bridge]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c8a749a4>
> br_handle_frame+0x146/0x172 [bridge]  <c8a74752>
> br_handle_frame_finish+0x0/0xe0 [bridge]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c020e815>
> netif_receive_skb+0x1b3/0x25d  <c020e92d> process_backlog+0x6e/0xd7
> Aug  8 09:56:22 analyzeTHIS kernel:  <c020ea0b>
> net_rx_action+0x75/0x105  <c011a42c> __do_softirq+0x34/0x7d
> Aug  8 09:56:22 analyzeTHIS kernel:  <c011a497> do_softirq+0x22/0x26
> <c0104e5e> do_IRQ+0x1e/0x24
> Aug  8 09:56:22 analyzeTHIS kernel:  <c0103976>
> common_interrupt+0x1a/0x20  <c01438f6> drain_array+0x12/0x7f
> Aug  8 09:56:22 analyzeTHIS kernel:  <c01439a6> cache_reap+0x43/0x11b
> <c01228c9> run_workqueue+0x6e/0xa2
> Aug  8 09:56:22 analyzeTHIS kernel:  <c0143963> cache_reap+0x0/0x11b
> <c01229f5> worker_thread+0xf8/0x12a
> Aug  8 09:56:22 analyzeTHIS kernel:  <c01136aa>
> default_wake_function+0x0/0x12  <c025da4e> schedule+0x460/0x4c5
> Aug  8 09:56:22 analyzeTHIS kernel:  <c01136aa>
> default_wake_function+0x0/0x12  <c01228fd> worker_thread+0x0/0x12a
> Aug  8 09:56:22 analyzeTHIS kernel:  <c0124f42> kthread+0x79/0xa3
> <c0124ec9> kthread+0x0/0xa3
> Aug  8 09:56:22 analyzeTHIS kernel:  <c01012d5> 
> kernel_thread_helper+0x5/0xb
> Aug  8 09:56:22 analyzeTHIS kernel: Mem-info:
> Aug  8 09:56:22 analyzeTHIS kernel: DMA per-cpu:
> Aug  8 09:56:22 analyzeTHIS kernel: cpu 0 hot: high 0, batch 1 used:0
> Aug  8 09:56:22 analyzeTHIS kernel: cpu 0 cold: high 0, batch 1 used:0
> Aug  8 09:56:22 analyzeTHIS kernel: DMA32 per-cpu: empty
> Aug  8 09:56:22 analyzeTHIS kernel: Normal per-cpu:
> Aug  8 09:56:22 analyzeTHIS kernel: cpu 0 hot: high 42, batch 7 used:32
> Aug  8 09:56:22 analyzeTHIS kernel: cpu 0 cold: high 14, batch 3 used:11
> Aug  8 09:56:22 analyzeTHIS kernel: HighMem per-cpu: empty
> Aug  8 09:56:22 analyzeTHIS kernel: Free pages:         976kB (0kB HighMem)
> Aug  8 09:56:22 analyzeTHIS kernel: Active:12345 inactive:6399 dirty:1
> writeback:0 unstable:0 free:244 slab:11916 mapped:1477 pagetables:54
> Aug  8 09:56:22 analyzeTHIS kernel: DMA free:516kB min:180kB low:224kB
> high:268kB active:3500kB inactive:2724kB present:16384kB
> pages_scanned:0 all_unreclaimable? no
> Aug  8 09:56:22 analyzeTHIS kernel: lowmem_reserve[]: 0 0 111 111
> Aug  8 09:56:22 analyzeTHIS kernel: DMA32 free:0kB min:0kB low:0kB
> high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0
> all_unreclaimable? no
> Aug  8 09:56:22 analyzeTHIS kernel: lowmem_reserve[]: 0 0 111 111
> Aug  8 09:56:22 analyzeTHIS kernel: Normal free:460kB min:1260kB
> low:1572kB high:1888kB active:45880kB inactive:22872kB
> present:114624kB pages_scanned:0 all_unreclaimable? no
> Aug  8 09:56:22 analyzeTHIS kernel: lowmem_reserve[]: 0 0 0 0
> Aug  8 09:56:22 analyzeTHIS kernel: HighMem free:0kB min:128kB
> low:128kB high:128kB active:0kB inactive:0kB present:0kB
> pages_scanned:0 all_unreclaimable? no
> Aug  8 09:56:22 analyzeTHIS kernel: lowmem_reserve[]: 0 0 0 0
> Aug  8 09:56:22 analyzeTHIS kernel: DMA: 1*4kB 0*8kB 0*16kB 0*32kB
> 0*64kB 0*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 516kB
> Aug  8 09:56:22 analyzeTHIS kernel: DMA32: empty
> Aug  8 09:56:22 analyzeTHIS kernel: Normal: 3*4kB 0*8kB 0*16kB 0*32kB
> 1*64kB 1*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 460kB
> Aug  8 09:56:22 analyzeTHIS kernel: HighMem: empty
> Aug  8 09:56:22 analyzeTHIS kernel: Swap cache: add 0, delete 0, find
> 0/0, race 0+0
> Aug  8 09:56:22 analyzeTHIS kernel: Free swap  = 506036kB
> Aug  8 09:56:22 analyzeTHIS kernel: Total swap = 506036kB
> Aug  8 09:56:22 analyzeTHIS kernel: Free swap:       506036kB
> Aug  8 09:56:22 analyzeTHIS kernel: 32752 pages of RAM
> Aug  8 09:56:22 analyzeTHIS kernel: 0 pages of HIGHMEM
> Aug  8 09:56:22 analyzeTHIS kernel: 932 reserved pages
> Aug  8 09:56:22 analyzeTHIS kernel: 17391 pages shared
> Aug  8 09:56:22 analyzeTHIS kernel: 0 pages swap cached
> Aug  8 09:56:22 analyzeTHIS kernel: 1 pages dirty
> Aug  8 09:56:22 analyzeTHIS kernel: 0 pages writeback
> Aug  8 09:56:22 analyzeTHIS kernel: 1477 pages mapped
> Aug  8 09:56:22 analyzeTHIS kernel: 11916 pages slab
> Aug  8 09:56:22 analyzeTHIS kernel: 54 pages pagetables
> Aug  8 09:56:22 analyzeTHIS kernel: printk: 1684 messages suppressed.
> Aug  8 09:56:22 analyzeTHIS kernel: cron: page allocation failure.
> order:0, mode:0x20
> Aug  8 09:56:22 analyzeTHIS kernel:  <c0132552>
> __alloc_pages+0x254/0x266  <c01323bb> __alloc_pages+0xbd/0x266
> Aug  8 09:56:22 analyzeTHIS kernel:  <c0142688>
> kmem_getpages+0x39/0x91  <c0143127> cache_grow+0x93/0x122
> Aug  8 09:56:22 analyzeTHIS kernel:  <c01432db>
> cache_alloc_refill+0x125/0x15e  <c0143586> __kmalloc+0x56/0x61
> Aug  8 09:56:22 analyzeTHIS kernel:  <c020992c> __alloc_skb+0x4c/0xf2
> <c88dc759> rtl8169_alloc_rx_skb+0x19/0xb0 [r8169]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c88dc878>
> rtl8169_rx_fill+0x45/0x5a [r8169]  <c88dd38b>
> rtl8169_rx_interrupt+0x2af/0x304 [r8169]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c88dd81c>
> pci_unmap_single+0x0/0x10 [r8169]  <c88dd486>
> rtl8169_interrupt+0xa6/0x103 [r8169]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c012d943>
> handle_IRQ_event+0x20/0x4c  <c012d9c2> __do_IRQ+0x53/0x91
> Aug  8 09:56:22 analyzeTHIS kernel:  <c0104e59> do_IRQ+0x19/0x24
> <c0103976> common_interrupt+0x1a/0x20
> Aug  8 09:56:22 analyzeTHIS kernel:  <c88dd409>
> rtl8169_interrupt+0x29/0x103 [r8169]  <c012d943>
> handle_IRQ_event+0x20/0x4c
> Aug  8 09:56:22 analyzeTHIS kernel:  <c012d9c2> __do_IRQ+0x53/0x91
> <c0104e59> do_IRQ+0x19/0x24
> Aug  8 09:56:22 analyzeTHIS kernel:  <c0103976>
> common_interrupt+0x1a/0x20  <c010b146> get_offset_pmtmr+0x44/0xefe
> Aug  8 09:56:22 analyzeTHIS kernel:  <c0105a89>
> do_gettimeofday+0x16/0x9d  <c020defa> __net_timestamp+0xf/0x22
> Aug  8 09:56:22 analyzeTHIS kernel:  <c020df28>
> dev_queue_xmit_nit+0x1b/0xec  <c02195bb> qdisc_restart+0x7b/0xee
> Aug  8 09:56:22 analyzeTHIS kernel:  <c020e3f2>
> dev_queue_xmit+0xbe/0x186  <c8a73cb2> br_dev_queue_push_xmit+0xc2/0xc9
> [bridge]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c8a7890f>
> br_nf_post_routing+0x14b/0x158 [bridge]  <c8a73bf0>
> br_dev_queue_push_xmit+0x0/0xc9 [bridge]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c021f894> nf_iterate+0x3f/0x6d
> <c8a73bf0> br_dev_queue_push_xmit+0x0/0xc9 [bridge]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c021f909> nf_hook_slow+0x47/0x9d
> <c8a73bf0> br_dev_queue_push_xmit+0x0/0xc9 [bridge]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c8a73cb9>
> br_forward_finish+0x0/0x41 [bridge]  <c8a73ce7>
> br_forward_finish+0x2e/0x41 [bridge]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c8a73bf0>
> br_dev_queue_push_xmit+0x0/0xc9 [bridge]  <c8a782bd>
> br_nf_forward_finish+0xc6/0xcb [bridge]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c8a783e2>
> br_nf_forward_ip+0x120/0x12b [bridge]  <c021f894> nf_iterate+0x3f/0x6d
> Aug  8 09:56:22 analyzeTHIS kernel:  <c8a73cb9>
> br_forward_finish+0x0/0x41 [bridge]  <c021f909> nf_hook_slow+0x47/0x9d
> Aug  8 09:56:22 analyzeTHIS kernel:  <c8a73cb9>
> br_forward_finish+0x0/0x41 [bridge]  <c8a73d8d> __br_forward+0x46/0x57
> [bridge]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c8a73cb9>
> br_forward_finish+0x0/0x41 [bridge]  <c8a73e84> br_flood+0x8e/0xa6
> [bridge]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c8a73d47> __br_forward+0x0/0x57
> [bridge]  <c8a73ecc> br_flood_forward+0x16/0x1a [bridge]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c8a73d47> __br_forward+0x0/0x57
> [bridge]  <c8a747db> br_handle_frame_finish+0x89/0xe0 [bridge]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c8a77bae>
> br_nf_pre_routing_finish+0x29b/0x2a9 [bridge]  <c8a8165f>
> ip_conntrack_in+0x192/0x21c [ip_conntrack]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c8a77913>
> br_nf_pre_routing_finish+0x0/0x2a9 [bridge]  <c021f894>
> nf_iterate+0x3f/0x6d
> Aug  8 09:56:22 analyzeTHIS kernel:  <c8a77913>
> br_nf_pre_routing_finish+0x0/0x2a9 [bridge]  <c021f909>
> nf_hook_slow+0x47/0x9d
> Aug  8 09:56:22 analyzeTHIS kernel:  <c8a77913>
> br_nf_pre_routing_finish+0x0/0x2a9 [bridge]  <c8a74752>
> br_handle_frame_finish+0x0/0xe0 [bridge]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c8a78186>
> br_nf_pre_routing+0x2e7/0x305 [bridge]  <c8a74752>
> br_handle_frame_finish+0x0/0xe0 [bridge]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c8a78194>
> br_nf_pre_routing+0x2f5/0x305 [bridge]  <c021f894>
> nf_iterate+0x3f/0x6d
> Aug  8 09:56:22 analyzeTHIS kernel:  <c8a74752>
> br_handle_frame_finish+0x0/0xe0 [bridge]  <c021f909>
> nf_hook_slow+0x47/0x9d
> Aug  8 09:56:22 analyzeTHIS kernel:  <c8a74752>
> br_handle_frame_finish+0x0/0xe0 [bridge]  <c8a749a4>
> br_handle_frame+0x146/0x172 [bridge]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c8a74752>
> br_handle_frame_finish+0x0/0xe0 [bridge]  <c020e815>
> netif_receive_skb+0x1b3/0x25d
> Aug  8 09:56:22 analyzeTHIS kernel:  <c020e92d>
> process_backlog+0x6e/0xd7  <c020ea0b> net_rx_action+0x75/0x105
> Aug  8 09:56:22 analyzeTHIS kernel:  <c011a42c> __do_softirq+0x34/0x7d
> <c011a497> do_softirq+0x22/0x26
> Aug  8 09:56:22 analyzeTHIS kernel:  <c0104e5e> do_IRQ+0x1e/0x24
> <c0103976> common_interrupt+0x1a/0x20
> Aug  8 09:56:22 analyzeTHIS kernel:  <c015872c> prune_dcache+0x2e/0xf1
> <c0158a85> shrink_dcache_memory+0x18/0x30
> Aug  8 09:56:22 analyzeTHIS kernel:  <c01350b8>
> shrink_slab+0x12a/0x190  <c0135eed> try_to_free_pages+0xee/0x19a
> Aug  8 09:56:22 analyzeTHIS kernel:  <c0132464>
> __alloc_pages+0x166/0x266  <c0142688> kmem_getpages+0x39/0x91
> Aug  8 09:56:22 analyzeTHIS kernel:  <c0143127> cache_grow+0x93/0x122
> <c01432db> cache_alloc_refill+0x125/0x15e
> Aug  8 09:56:22 analyzeTHIS kernel:  <c0143475>
> kmem_cache_alloc+0x2a/0x34  <c014ff89> getname+0x13/0x4a
> Aug  8 09:56:22 analyzeTHIS kernel:  <c0151624>
> __user_walk_fd+0xe/0x42  <c014ceb7> vfs_stat_fd+0x1a/0x45
> Aug  8 09:56:22 analyzeTHIS kernel:  <c01275b5>
> hrtimer_try_to_cancel+0xb/0x32  <c01275e7> hrtimer_cancel+0xb/0x16
> Aug  8 09:56:22 analyzeTHIS kernel:  <c025e972> do_nanosleep+0x43/0x66
> <c01277b0> hrtimer_nanosleep+0x4c/0x103
> Aug  8 09:56:22 analyzeTHIS kernel:  <c014cef1> vfs_stat+0xf/0x13
> <c014d4af> sys_stat64+0x10/0x27
> Aug  8 09:56:22 analyzeTHIS kernel:  <c025da4e> schedule+0x460/0x4c5
> <c0105a89> do_gettimeofday+0x16/0x9d
> Aug  8 09:56:22 analyzeTHIS kernel:  <c0119bcb> sys_time+0x13/0x40
> <c0102f33> syscall_call+0x7/0xb
> Aug  8 09:56:22 analyzeTHIS kernel: Mem-info:
> Aug  8 09:56:22 analyzeTHIS kernel: DMA per-cpu:
> Aug  8 09:56:22 analyzeTHIS kernel: cpu 0 hot: high 0, batch 1 used:0
> Aug  8 09:56:22 analyzeTHIS kernel: cpu 0 cold: high 0, batch 1 used:0
> Aug  8 09:56:22 analyzeTHIS kernel: DMA32 per-cpu: empty
> Aug  8 09:56:22 analyzeTHIS kernel: Normal per-cpu:
> Aug  8 09:56:22 analyzeTHIS kernel: cpu 0 hot: high 42, batch 7 used:31
> Aug  8 09:56:22 analyzeTHIS kernel: cpu 0 cold: high 14, batch 3 used:11
> Aug  8 09:56:22 analyzeTHIS kernel: HighMem per-cpu: empty
> Aug  8 09:56:22 analyzeTHIS kernel: Free pages:         976kB (0kB HighMem)
> Aug  8 09:56:22 analyzeTHIS kernel: Active:12277 inactive:6435 dirty:1
> writeback:0 unstable:0 free:244 slab:11917 mapped:1477 pagetables:54
> Aug  8 09:56:22 analyzeTHIS kernel: DMA free:516kB min:180kB low:224kB
> high:268kB active:3500kB inactive:2724kB present:16384kB
> pages_scanned:0 all_unreclaimable? no
> Aug  8 09:56:22 analyzeTHIS kernel: lowmem_reserve[]: 0 0 111 111
> Aug  8 09:56:22 analyzeTHIS kernel: DMA32 free:0kB min:0kB low:0kB
> high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0
> all_unreclaimable? no
> Aug  8 09:56:22 analyzeTHIS kernel: lowmem_reserve[]: 0 0 111 111
> Aug  8 09:56:22 analyzeTHIS kernel: Normal free:460kB min:1260kB
> low:1572kB high:1888kB active:45608kB inactive:23016kB
> present:114624kB pages_scanned:0 all_unreclaimable? no
> Aug  8 09:56:22 analyzeTHIS kernel: lowmem_reserve[]: 0 0 0 0
> Aug  8 09:56:22 analyzeTHIS kernel: HighMem free:0kB min:128kB
> low:128kB high:128kB active:0kB inactive:0kB present:0kB
> pages_scanned:0 all_unreclaimable? no
> Aug  8 09:56:22 analyzeTHIS kernel: lowmem_reserve[]: 0 0 0 0
> Aug  8 09:56:22 analyzeTHIS kernel: DMA: 1*4kB 0*8kB 0*16kB 0*32kB
> 0*64kB 0*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 516kB
> Aug  8 09:56:22 analyzeTHIS kernel: DMA32: empty
> Aug  8 09:56:22 analyzeTHIS kernel: Normal: 3*4kB 0*8kB 0*16kB 0*32kB
> 1*64kB 1*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 460kB
> Aug  8 09:56:22 analyzeTHIS kernel: HighMem: empty
> Aug  8 09:56:22 analyzeTHIS kernel: Swap cache: add 0, delete 0, find
> 0/0, race 0+0
> Aug  8 09:56:22 analyzeTHIS kernel: Free swap  = 506036kB
> Aug  8 09:56:22 analyzeTHIS kernel: Total swap = 506036kB
> Aug  8 09:56:22 analyzeTHIS kernel: Free swap:       506036kB
> Aug  8 09:56:22 analyzeTHIS kernel: 32752 pages of RAM
> Aug  8 09:56:22 analyzeTHIS kernel: 0 pages of HIGHMEM
> Aug  8 09:56:22 analyzeTHIS kernel: 932 reserved pages
> Aug  8 09:56:22 analyzeTHIS kernel: 17423 pages shared
> Aug  8 09:56:22 analyzeTHIS kernel: 0 pages swap cached
> Aug  8 09:56:22 analyzeTHIS kernel: 1 pages dirty
> Aug  8 09:56:22 analyzeTHIS kernel: 0 pages writeback
> Aug  8 09:56:22 analyzeTHIS kernel: 1477 pages mapped
> Aug  8 09:56:22 analyzeTHIS kernel: 11917 pages slab
> Aug  8 09:56:22 analyzeTHIS kernel: 54 pages pagetables
> Aug  8 09:56:22 analyzeTHIS kernel: printk: 1262 messages suppressed.
> Aug  8 09:56:22 analyzeTHIS kernel: init: page allocation failure.
> order:0, mode:0x20
> Aug  8 09:56:22 analyzeTHIS kernel:  <c0132552>
> __alloc_pages+0x254/0x266  <c0142688> kmem_getpages+0x39/0x91
> Aug  8 09:56:22 analyzeTHIS kernel:  <c0143127> cache_grow+0x93/0x122
> <c01432db> cache_alloc_refill+0x125/0x15e
> Aug  8 09:56:22 analyzeTHIS kernel:  <c0143586> __kmalloc+0x56/0x61
> <c020992c> __alloc_skb+0x4c/0xf2
> Aug  8 09:56:22 analyzeTHIS kernel:  <c88dc759>
> rtl8169_alloc_rx_skb+0x19/0xb0 [r8169]  <c88dc878>
> rtl8169_rx_fill+0x45/0x5a [r8169]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c88dd38b>
> rtl8169_rx_interrupt+0x2af/0x304 [r8169]  <c88dd81c>
> pci_unmap_single+0x0/0x10 [r8169]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c88dd486>
> rtl8169_interrupt+0xa6/0x103 [r8169]  <c012d943>
> handle_IRQ_event+0x20/0x4c
> Aug  8 09:56:22 analyzeTHIS kernel:  <c012d9c2> __do_IRQ+0x53/0x91
> <c0104e59> do_IRQ+0x19/0x24
> Aug  8 09:56:22 analyzeTHIS kernel:  <c0103976>
> common_interrupt+0x1a/0x20  <c01a0693> ioread32+0x22/0x26
> Aug  8 09:56:22 analyzeTHIS kernel:  <c8906a37>
> tulip_interrupt+0x47/0x798 [tulip]  <c012d943>
> handle_IRQ_event+0x20/0x4c
> Aug  8 09:56:22 analyzeTHIS kernel:  <c012d9c2> __do_IRQ+0x53/0x91
> <c0104e59> do_IRQ+0x19/0x24
> Aug  8 09:56:22 analyzeTHIS kernel:  <c0103976>
> common_interrupt+0x1a/0x20  <c012d93d> handle_IRQ_event+0x1a/0x4c
> Aug  8 09:56:22 analyzeTHIS kernel:  <c012d9c2> __do_IRQ+0x53/0x91
> <c0104e59> do_IRQ+0x19/0x24
> Aug  8 09:56:22 analyzeTHIS kernel:  <c0103976>
> common_interrupt+0x1a/0x20  <c0143616> kfree+0x56/0x5b
> Aug  8 09:56:22 analyzeTHIS kernel:  <c0209ba2> kfree_skbmem+0xb/0x6d
> <c022468b> ip_rcv+0x3a7/0x3b1
> Aug  8 09:56:22 analyzeTHIS kernel:  <c020e8a1>
> netif_receive_skb+0x23f/0x25d  <c020e92d> process_backlog+0x6e/0xd7
> Aug  8 09:56:22 analyzeTHIS kernel:  <c020ea0b>
> net_rx_action+0x75/0x105  <c011a42c> __do_softirq+0x34/0x7d
> Aug  8 09:56:22 analyzeTHIS kernel:  <c011a497> do_softirq+0x22/0x26
> <c0104e5e> do_IRQ+0x1e/0x24
> Aug  8 09:56:22 analyzeTHIS kernel:  <c0103976>
> common_interrupt+0x1a/0x20  <c8951090> reiserfs_clear_inode+0x0/0x56
> [reiserfs]
> Aug  8 09:56:22 analyzeTHIS kernel:  <c0159b48> clear_inode+0xb6/0xe4
> <c0159bc6> dispose_list+0x50/0xaa
> Aug  8 09:56:22 analyzeTHIS kernel:  <c0159e87>
> prune_icache+0x11d/0x152  <c0159ed4> shrink_icache_memory+0x18/0x30
> Aug  8 09:56:22 analyzeTHIS kernel:  <c01350b8>
> shrink_slab+0x12a/0x190  <c0135eed> try_to_free_pages+0xee/0x19a
> Aug  8 09:56:22 analyzeTHIS kernel:  <c0132464>
> __alloc_pages+0x166/0x266  <c0142688> kmem_getpages+0x39/0x91
> Aug  8 09:56:22 analyzeTHIS kernel:  <c0143127> cache_grow+0x93/0x122
> <c01432db> cache_alloc_refill+0x125/0x15e
> Aug  8 09:56:22 analyzeTHIS kernel:  <c0143475>
> kmem_cache_alloc+0x2a/0x34  <c014ff89> getname+0x13/0x4a
> Aug  8 09:56:22 analyzeTHIS kernel:  <c0151624>
> __user_walk_fd+0xe/0x42  <c014ceb7> vfs_stat_fd+0x1a/0x45
> Aug  8 09:56:22 analyzeTHIS kernel:  <c01435f7> kfree+0x37/0x5b
> <c0209c00> kfree_skbmem+0x69/0x6d
> Aug  8 09:56:22 analyzeTHIS kernel:  <c022468b> ip_rcv+0x3a7/0x3b1
> <c020e8a1> netif_receive_skb+0x23f/0x25d
> Aug  8 09:56:22 analyzeTHIS kernel:  <c014cef1> vfs_stat+0xf/0x13
> <c014d4af> sys_stat64+0x10/0x27
> Aug  8 09:56:22 analyzeTHIS kernel:  <c025da4e> schedule+0x460/0x4c5
> <c0102f33> syscall_call+0x7/0xb
> Aug  8 09:56:22 analyzeTHIS kernel: Mem-info:
> Aug  8 09:56:22 analyzeTHIS kernel: DMA per-cpu:
> Aug  8 09:56:22 analyzeTHIS kernel: cpu 0 hot: high 0, batch 1 used:0
> Aug  8 09:56:22 analyzeTHIS kernel: cpu 0 cold: high 0, batch 1 used:0
> Aug  8 09:56:22 analyzeTHIS kernel: DMA32 per-cpu: empty
> Aug  8 09:56:22 analyzeTHIS kernel: Normal per-cpu:
> Aug  8 09:56:22 analyzeTHIS kernel: cpu 0 hot: high 42, batch 7 used:34
> Aug  8 09:56:22 analyzeTHIS kernel: cpu 0 cold: high 14, batch 3 used:13
> Aug  8 09:56:22 analyzeTHIS kernel: HighMem per-cpu: empty
> Aug  8 09:56:22 analyzeTHIS kernel: Free pages:         968kB (0kB HighMem)
> Aug  8 09:56:22 analyzeTHIS kernel: Active:12277 inactive:6435 dirty:1
> writeback:0 unstable:0 free:242 slab:11928 mapped:1477 pagetables:54
> Aug  8 09:56:22 analyzeTHIS kernel: DMA free:516kB min:180kB low:224kB
> high:268kB active:3500kB inactive:2724kB present:16384kB
> pages_scanned:0 all_unreclaimable? no
> Aug  8 09:56:22 analyzeTHIS kernel: lowmem_reserve[]: 0 0 111 111
> Aug  8 09:56:22 analyzeTHIS kernel: DMA32 free:0kB min:0kB low:0kB
> high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0
> all_unreclaimable? no
> Aug  8 09:56:22 analyzeTHIS kernel: lowmem_reserve[]: 0 0 111 111
> Aug  8 09:56:22 analyzeTHIS kernel: Normal free:452kB min:1260kB
> low:1572kB high:1888kB active:45608kB inactive:23016kB
> present:114624kB pages_scanned:0 all_unreclaimable? no
> Aug  8 09:56:22 analyzeTHIS kernel: lowmem_reserve[]: 0 0 0 0
> Aug  8 09:56:22 analyzeTHIS kernel: HighMem free:0kB min:128kB
> low:128kB high:128kB active:0kB inactive:0kB present:0kB
> pages_scanned:0 all_unreclaimable? no
> Aug  8 09:56:22 analyzeTHIS kernel: lowmem_reserve[]: 0 0 0 0
> Aug  8 09:56:22 analyzeTHIS kernel: DMA: 1*4kB 0*8kB 0*16kB 0*32kB
> 0*64kB 0*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 516kB
> Aug  8 09:56:22 analyzeTHIS kernel: DMA32: empty
> Aug  8 09:56:22 analyzeTHIS kernel: Normal: 1*4kB 0*8kB 0*16kB 0*32kB
> 1*64kB 1*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 452kB
> Aug  8 09:56:22 analyzeTHIS kernel: HighMem: empty
> Aug  8 09:56:22 analyzeTHIS kernel: Swap cache: add 0, delete 0, find
> 0/0, race 0+0
> Aug  8 09:56:22 analyzeTHIS kernel: Free swap  = 506036kB
> Aug  8 09:56:22 analyzeTHIS kernel: Total swap = 506036kB
> Aug  8 09:56:22 analyzeTHIS kernel: Free swap:       506036kB
> Aug  8 09:56:22 analyzeTHIS kernel: 32752 pages of RAM
> Aug  8 09:56:22 analyzeTHIS kernel: 0 pages of HIGHMEM
> Aug  8 09:56:22 analyzeTHIS kernel: 932 reserved pages
> Aug  8 09:56:22 analyzeTHIS kernel: 17395 pages shared
> Aug  8 09:56:22 analyzeTHIS kernel: 0 pages swap cached
> Aug  8 09:56:22 analyzeTHIS kernel: 1 pages dirty
> Aug  8 09:56:22 analyzeTHIS kernel: 0 pages writeback
> Aug  8 09:56:22 analyzeTHIS kernel: 1477 pages mapped
> Aug  8 09:56:22 analyzeTHIS kernel: 11928 pages slab
> Aug  8 09:56:22 analyzeTHIS kernel: 54 pages pagetables

