Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261804AbUKIXzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbUKIXzz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 18:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbUKIXyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 18:54:17 -0500
Received: from shinjuku.zaphods.net ([194.97.108.52]:50401 "EHLO
	shinjuku.zaphods.net") by vger.kernel.org with ESMTP
	id S261797AbUKIXwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 18:52:22 -0500
Date: Wed, 10 Nov 2004 00:52:01 +0100
From: Stefan Schmidt <zaphodb@zaphods.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Lukas Hejtmanek <xhejtman@mail.muni.cz>, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org, piggin@cyberone.com.au
Subject: Re: Kernel 2.6.9 Multiple Page Allocation Failures
Message-ID: <20041109235201.GC20754@zaphods.net>
References: <20041103222447.GD28163@zaphods.net> <20041104121722.GB8537@logos.cnet> <20041104181856.GE28163@zaphods.net> <20041109164113.GD7632@logos.cnet> <20041109223558.GR1309@mail.muni.cz> <20041109144607.2950a41a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041109144607.2950a41a.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
X-SA-Exim-Connect-IP: 194.97.1.3
X-SA-Exim-Mail-From: zaphodb@boombox.zaphods.net
X-SA-Exim-Scanned: No (on shinjuku.zaphods.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2004 at 02:46:07PM -0800, Andrew Morton wrote:
> > here is the trace:
> >  klogd: page allocation failure. order:0, mode: 0x20
...
> >   [alloc_skb+75/224] alloc_skb+0x47/0xe0
> >   [e1000_alloc_rx_buffers+72/227] e1000_alloc_rx_buffers+0x44/0xe3
> >   [e1000_clean_rx_irq+402/1095] e1000_clean_rx_irq+0x18e/0x447
> >   [e1000_clean+85/202] e1000_clean+0x51/0xca
> There was a problem related to e1000 and TSO which was leading to these
> over-aggressive atomic allocations.  That was fixed (within ./net/)
> post-2.6.9.
I got the following with 2.6.10-rc1-mm4:

swapper: page allocation failure. order:0, mode:0x20
 [<c013edfd>] __alloc_pages+0x20d/0x390
 [<c013ef98>] __get_free_pages+0x18/0x30
 [<c0141728>] kmem_getpages+0x18/0xc0
 [<c01423ad>] cache_grow+0x9d/0x130
 [<c01425bc>] cache_alloc_refill+0x17c/0x240
 [<c0142874>] kmem_cache_alloc+0x44/0x50
 [<c02e429e>] skb_clone+0xe/0x190
 [<c031082e>] tcp_retransmit_skb+0x21e/0x300
 [<c0308c96>] tcp_enter_loss+0x66/0x230
 [<c031258f>] tcp_retransmit_timer+0xdf/0x400
 [<c02ada31>] scsi_io_completion+0x111/0x480
 [<c0127b52>] del_timer+0x62/0x80
 [<c0312979>] tcp_write_timer+0xc9/0x100
 [<c03128b0>] tcp_write_timer+0x0/0x100
 [<c01281e2>] run_timer_softirq+0xe2/0x1c0
 [<c02a8fe1>] scsi_finish_command+0x81/0xd0
 [<c0124038>] __do_softirq+0xb8/0xd0
 [<c012407d>] do_softirq+0x2d/0x30
 [<c011324f>] smp_apic_timer_interrupt+0x5f/0xd0
 [<c010498c>] apic_timer_interrupt+0x1c/0x24
 [<c0102030>] default_idle+0x0/0x40
 [<c010205c>] default_idle+0x2c/0x40
 [<c01020e3>] cpu_idle+0x33/0x40
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
cpu 1 hot: low 2, high 6, batch 1
cpu 1 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
HighMem per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16

Free pages:        4664kB (1600kB HighMem)
Active:489259 inactive:478496 dirty:105435 writeback:796 unstable:0 free:1166 slab:41902 mapped:481292 pagetables:1211
DMA free:56kB min:144kB low:288kB high:432kB active:4600kB inactive:3156kB present:16384kB pages_scanned:32 all_unreclaimable? no
protections[]: 0 0 0
Normal free:3008kB min:8044kB low:16088kB high:24132kB active:323776kB inactive:370488kB present:901120kB pages_scanned:64 all_unreclaimable? no
protections[]: 0 0 0
HighMem free:1600kB min:512kB low:1024kB high:1536kB active:1628660kB inactive:1540340kB present:3178432kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
DMA: 0*4kB 1*8kB 1*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 56kB
Normal: 0*4kB 0*8kB 0*16kB 0*32kB 1*64kB 1*128kB 1*256kB 1*512kB 0*1024kB 1*2048kB 0*4096kB = 3008kB
HighMem: 24*4kB 24*8kB 14*16kB 8*32kB 5*64kB 0*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 1600kB
Swap cache: add 494, delete 439, find 171/197, race 0+0

Dual Opteron, 4GB, 3ware 9508, tg3 for BCM5704.
Offload parameters for eth0:
rx-checksumming: on
tx-checksumming: on
scatter-gather: on
tcp segmentation offload: off

	Stefan
