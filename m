Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261774AbULBVIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbULBVIB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 16:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261771AbULBVHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 16:07:49 -0500
Received: from hell.sks3.muni.cz ([147.251.210.30]:61624 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S261768AbULBVET
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 16:04:19 -0500
Date: Thu, 2 Dec 2004 22:03:48 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: zaphodb@zaphods.net, marcelo.tosatti@cyclades.com, piggin@cyberone.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.9 Multiple Page Allocation Failures
Message-ID: <20041202210348.GD20771@mail.muni.cz>
References: <20041110181148.GA12867@logos.cnet> <20041111214435.GB29112@mail.muni.cz> <4194A7F9.5080503@cyberone.com.au> <20041113144743.GL20754@zaphods.net> <20041116093311.GD11482@logos.cnet> <20041116170527.GA3525@mail.muni.cz> <20041121014350.GJ4999@zaphods.net> <20041121024226.GK4999@zaphods.net> <20041202195422.GA20771@mail.muni.cz> <20041202122546.59ff814f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041202122546.59ff814f.akpm@osdl.org>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2004 at 12:25:46PM -0800, Andrew Morton wrote:
> Lukas Hejtmanek <xhejtman@mail.muni.cz> wrote:
> >
> > I found out that 2.6.6-bk4 kernel is OK. 
> 
> That kernel didn't have the TSO thing.  Pretty much all of these reports
> have been against e1000_alloc_rx_buffers() since the TSO changes went in.
> 
> I may have been asleep at the time.  Could someone pleeeeze explain to me
> why the introduction of TSO has thrown this additional pressure onto the
> atomic memory allocations?
> 
> Did you try disabling TSO, btw?

I did it. Allocation failure is still there :(

ethtool -k eth0
Offload parameters for eth0:
rx-checksumming: on
tx-checksumming: on
scatter-gather: on
tcp segmentation offload: off

kernel: swapper: page allocation failure. order:0, mode:0x20
kernel:  [__alloc_pages+441/862] __alloc_pages+0x1b9/0x363
kernel:  [__get_free_pages+42/63] __get_free_pages+0x25/0x3f
kernel:  [kmem_getpages+37/201] kmem_getpages+0x21/0xc9
kernel:  [cache_grow+175/333] cache_grow+0xab/0x14d
kernel:  [cache_alloc_refill+376/537] cache_alloc_refill+0x174/0x219
kernel:  [kmem_ptr_validate+2/73] kmem_cache_alloc+0x4b/0x4d
kernel:  [alloc_skb+41/224] alloc_skb+0x25/0xe0
kernel:  [e1000_alloc_rx_buffers+72/227] e1000_alloc_rx_buffers+0x44/0xe3
kernel:  [e1000_clean_rx_irq+402/1095] e1000_clean_rx_irq+0x18e/0x447
kernel:  [__kfree_skb+135/253] __kfree_skb+0x83/0xfd
kernel:  [e1000_clean+85/202] e1000_clean+0x51/0xca

This is failure really related to e1000. But there is another one:
kernel: swapper: page allocation failure. order:0, mode:0x20
kernel:  [__alloc_pages+441/862] __alloc_pages+0x1b9/0x363
kernel:  [__get_free_pages+42/63] __get_free_pages+0x25/0x3f
kernel:  [kmem_getpages+37/201] kmem_getpages+0x21/0xc9
kernel:  [cache_grow+175/333] cache_grow+0xab/0x14d
kernel:  [cache_alloc_refill+376/537] cache_alloc_refill+0x174/0x219
kernel:  [kmem_ptr_validate+2/73] kmem_cache_alloc+0x4b/0x4d
kernel:  [alloc_skb+41/224] alloc_skb+0x25/0xe0
kernel:  [tcp_send_ack+57/223] tcp_send_ack+0x35/0xdf
kernel:  [tcp_delack_timer+247/447] tcp_delack_timer+0xf3/0x1bf
kernel:  [i8042_controller_init+0/315] i8042_timer_func+0x1f/0x23
kernel:  [tcp_delack_timer+4/447] tcp_delack_timer+0x0/0x1bf
kernel:  [run_timer_softirq+207/392] run_timer_softirq+0xcf/0x188
kernel:  [net_rx_action+123/246] net_rx_action+0x77/0xf6
kernel:  [__do_softirq+183/198] __do_softirq+0xb7/0xc6
kernel:  [do_softirq+45/47] do_softirq+0x2d/0x2f
kernel:  [do_IRQ+274/304] do_IRQ+0x112/0x130

I still suspect XFS and it's page buffer as order 0 allocation shoud be
successful when:
kernel: Free pages:         500kB (140kB HighMem)
kernel: Active:22289 inactive:223140 dirty:102306 writeback:2663 unstable:0 free:125 slab:11088 mapped:18036 pagetables:428
kernel: DMA free:8kB min:16kB low:32kB high:48kB active:1132kB inactive:9912kB present:16384kB
kernel: protections[]: 0 0 0
kernel: Normal free:352kB min:936kB low:1872kB high:2808kB active:53460kB inactive:788652kB present:901120kB
kernel: protections[]: 0 0 0
kernel: HighMem free:140kB min:128kB low:256kB high:384kB active:34564kB inactive:93996kB present:131008kB
kernel: protections[]: 0 0 0
kernel: DMA: 0*4kB 1*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 8kB
kernel: Normal: 0*4kB 0*8kB 0*16kB 1*32kB 1*64kB 0*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 352kB
kernel: HighMem: 1*4kB 1*8kB 2*16kB 1*32kB 1*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 140kB

I can see in each zone at least one page free.

min_free_kbytes is set to 957

-- 
Luká¹ Hejtmánek
