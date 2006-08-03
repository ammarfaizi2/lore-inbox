Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbWHCNsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbWHCNsg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 09:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbWHCNsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 09:48:36 -0400
Received: from ms-2.rz.RWTH-Aachen.DE ([134.130.3.131]:33679 "EHLO
	ms-dienst.rz.rwth-aachen.de") by vger.kernel.org with ESMTP
	id S932195AbWHCNsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 09:48:35 -0400
Date: Thu, 03 Aug 2006 15:48:39 +0200
From: Arnd Hannemann <arnd@arndnet.de>
Subject: problems with e1000 and jumboframes
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Message-id: <44D1FEB7.2050703@arndnet.de>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-15
Content-transfer-encoding: 7BIT
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
X-Enigmail-Version: 0.94.0.0
X-Spam-Report: * -2.8 ALL_TRUSTED Did not pass through any untrusted hosts
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

im running vanilla 2.6.17.6 and if i try to set the mtu of my e1000 nic
to 9000 bytes, page allocation failures occur (see below).

However the box is a VIA Epia MII12000 with 1 GB of Ram and 1 GB of swap
enabled, so there should be plenty of memory available. HIGHMEM support
is off. The e1000 nic seems to be an 82540EM, which to my knowledge
should support jumboframes.

However I can't always reproduce this on a freshly booted system, so
someone else may be the culprit and leaking pages?

Any ideas how to debug this?

kernel config and other stuff available:
http://arndnet.de/~arnd/config-2.6.17.6
http://arndnet.de/~arnd/lsmod.txt
http://arndnet.de/~arnd/lspci.txt
http://arndnet.de/~arnd/dmesg.txt
http://arndnet.de/~arnd/slabinfo.txt


> e1000: eth1: e1000_watchdog_task: NIC Link is Up 1000 Mbps Full Duplex
> e:0 free:3308 slab:41895 mapped:119264 pagetables:392
> DMA free:3576kB min:68kB low:84kB high:100kB active:4144kB inactive:0kB present:
> 16384kB pages_scanned:0 all_unreclaimable? no
> lowmem_reserve[]: 0 0 880 880
> DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB page
> s_scanned:0 all_unreclaimable? no
> lowmem_reserve[]: 0 0 880 880
> Normal free:9656kB min:3756kB low:4692kB high:5632kB active:593312kB inactive:11
> 6408kB present:901120kB pages_scanned:37 all_unreclaimable? no
> lowmem_reserve[]: 0 0 0 0
> HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:
> 0kB pages_scanned:0 all_unreclaimable? no
> lowmem_reserve[]: 0 0 0 0
> DMA: 256*4kB 47*8kB 2*16kB 1*32kB 1*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 1*2048 kB 0*4096kB = 3576kB
> DMA32: empty
> Normal: 1910*4kB 106*8kB 61*16kB 0*32kB 1*64kB 1*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 9656kB
> HighMem: empty
> Swap cache: add 333601, delete 331441, find 397667/415025, race 0+0
> Free swap  = 937756kB
> Total swap = 979956kB
> Free swap:       937756kB
> 229376 pages of RAM
> 0 pages of HIGHMEM
> 2731 reserved pages
> 69480 pages shared
> 2160 pages swap cached
> 4 pages dirty
> 0 pages writeback
> 119264 pages mapped
> 41895 pages slab
> 392 pages pagetables
> kswapd0: page allocation failure. order:3, mode:0x20
> <c01369e2> __alloc_pages+0x1f2/0x2d0  <c0149c92> kmem_getpages+0x32/0xa0
> <c014a8fb> cache_grow+0x9b/0x150  <c014aae3> cache_alloc_refill+0x133/0x1b0
> <c014ae7e> __kmalloc+0x5e/0x70  <c024302a> __alloc_skb+0x4a/0x100
> <f8b6d1f7> e1000_alloc_rx_buffers+0x227/0x3a0 [e1000]  <c0113c57> __wake_up_common+0x37/0x70
> <f8b6c807> e1000_clean_rx_irq+0x247/0x520 [e1000]  <c01bfab8> end_that_request_last+0x98/0xd0
> <f8b6c2e0> e1000_intr+0x60/0x100 [e1000]  <c0130f89> handle_IRQ_event+0x29/0x60
> <c0131012> __do_IRQ+0x52/0xa0  <c010567e> do_IRQ+0x3e/0x60
> =======================
> <c0103aea> common_interrupt+0x1a/0x20  <c011b6fe> __do_softirq+0x2e/0x90
> <c0105791> do_softirq+0x41/0x50
> =======================
> <c0105685> do_IRQ+0x45/0x60  <c0103aea> common_interrupt+0x1a/0x20
> <c01c8f52> _atomic_dec_and_lock+0x2/0x10  <c01631de> dput+0x1e/0x120
> <c01635f6> prune_dcache+0xe6/0xf0  <c0163914> shrink_dcache_memory+0x14/0x40
> <c013a09f> shrink_slab+0x16f/0x1d0  <c0137d56> throttle_vm_writeout+0x26/0x70
> <c013b413> balance_pgdat+0x2e3/0x3b0  <c013b5d3> kswapd+0xf3/0x110
> <c0127fb0> autoremove_wake_function+0x0/0x50  <c0127fb0> autoremove_wake_function+0x0/0x50
> <c013b4e0> kswapd+0x0/0x110  <c0100fe5> kernel_thread_helper+0x5/0x10

Thanks,
Arnd Hannemann




