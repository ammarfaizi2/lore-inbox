Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262368AbUKKVpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262368AbUKKVpA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 16:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262367AbUKKVpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 16:45:00 -0500
Received: from hell.sks3.muni.cz ([147.251.210.30]:60570 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S262368AbUKKVoz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 16:44:55 -0500
Date: Thu, 11 Nov 2004 22:44:35 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Andrew Morton <akpm@osdl.org>, zaphodb@zaphods.net,
       linux-kernel@vger.kernel.org, piggin@cyberone.com.au
Subject: Re: Kernel 2.6.9 Multiple Page Allocation Failures
Message-ID: <20041111214435.GB29112@mail.muni.cz>
References: <20041103222447.GD28163@zaphods.net> <20041104121722.GB8537@logos.cnet> <20041104181856.GE28163@zaphods.net> <20041109164113.GD7632@logos.cnet> <20041109223558.GR1309@mail.muni.cz> <20041109144607.2950a41a.akpm@osdl.org> <20041109224423.GC18366@mail.muni.cz> <20041109203348.GD8414@logos.cnet> <20041110212818.GC25410@mail.muni.cz> <20041110181148.GA12867@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041110181148.GA12867@logos.cnet>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2004 at 04:11:48PM -0200, Marcelo Tosatti wrote:
> OK, do you have Nick watermark fixes in? 
> 
> They increase the GFP_ATOMIC buffer (memory reserved for GFP_ATOMIC allocations)
> significantly, which is exactly the case here.
> 
> Its in Andrew's -mm tree already (the last -mm-bk contains it).
> 
> Its attached just in case - hope it ends this story.

Well today it reported page allocation failure again. I remind that I have
increased socket buffers:
/sbin/sysctl -w net/core/rmem_max=8388608
/sbin/sysctl -w net/core/wmem_max=8388608
/sbin/sysctl -w net/core/rmem_default=1048576
/sbin/sysctl -w net/core/wmem_default=1048576
/sbin/sysctl -w net/ipv4/tcp_window_scaling=1
/sbin/sysctl -w net/ipv4/tcp_rmem="4096 1048576 8388608"
/sbin/sysctl -w net/ipv4/tcp_wmem="4096 1048576 8388608"
/sbin/ifconfig eth0 txqueuelen 1000

I've tried to incdease min_free_kbytes to 10240 and it did not help :(

Nov 11 21:51:32 undomiel1 kernel: swapper: page allocation failure. order:0, mode:0x20
Nov 11 21:51:32 undomiel1 kernel:  [<c0137f28>] __alloc_pages+0x242/0x40e
Nov 11 21:51:32 undomiel1 kernel:  [<c0138119>] __get_free_pages+0x25/0x3f
Nov 11 21:51:32 undomiel1 kernel:  [<c032ed61>] tcp_v4_rcv+0x69a/0x9b5
Nov 11 21:51:32 undomiel1 kernel:  [<c013b195>] kmem_getpages+0x21/0xc9
Nov 11 21:51:32 undomiel1 kernel:  [<c013be46>] cache_grow+0xab/0x14d
Nov 11 21:51:32 undomiel1 kernel:  [<c013c06a>] cache_alloc_refill+0x182/0x244
Nov 11 21:51:32 undomiel1 kernel:  [<c013c3f8>] __kmalloc+0x85/0x8c
Nov 11 21:51:32 undomiel1 kernel:  [<c02fac95>] alloc_skb+0x47/0xe0
Nov 11 21:51:32 undomiel1 kernel:  [<c02997d6>] e1000_alloc_rx_buffers+0x44/0xe3
Nov 11 21:51:32 undomiel1 kernel:  [<c0299457>] e1000_clean_rx_irq+0x17c/0x4b7
....
Nov 11 21:51:32 undomiel1 kernel: DMA per-cpu:
Nov 11 21:51:32 undomiel1 kernel: cpu 0 hot: low 2, high 6, batch 1
Nov 11 21:51:32 undomiel1 kernel: cpu 0 cold: low 0, high 2, batch 1
Nov 11 21:51:32 undomiel1 kernel: cpu 1 hot: low 2, high 6, batch 1
Nov 11 21:51:32 undomiel1 kernel: cpu 1 cold: low 0, high 2, batch 1
Nov 11 21:51:32 undomiel1 kernel: Normal per-cpu:
Nov 11 21:51:32 undomiel1 kernel: cpu 0 hot: low 32, high 96, batch 16
Nov 11 21:51:32 undomiel1 kernel: cpu 0 cold: low 0, high 32, batch 16
Nov 11 21:51:32 undomiel1 kernel: cpu 1 hot: low 32, high 96, batch 16
Nov 11 21:51:32 undomiel1 kernel: cpu 1 cold: low 0, high 32, batch 16
Nov 11 21:51:32 undomiel1 kernel: HighMem per-cpu:
Nov 11 21:51:32 undomiel1 kernel: cpu 0 hot: low 14, high 42, batch 7
Nov 11 21:51:32 undomiel1 kernel: cpu 0 cold: low 0, high 14, batch 7
Nov 11 21:51:32 undomiel1 kernel: cpu 1 hot: low 14, high 42, batch 7
Nov 11 21:51:32 undomiel1 kernel: cpu 1 cold: low 0, high 14, batch 7
Nov 11 21:51:32 undomiel1 kernel:
Nov 11 21:51:32 undomiel1 kernel: Free pages:        1604kB (112kB HighMem)
Nov 11 21:51:32 undomiel1 kernel: Active:28524 inactive:219608 dirty:102206 writeback:2906 unstable:0 free:401 slab:8164 mapped:16804 pagetables:430
Nov 11 21:51:32 undomiel1 kernel: DMA free:28kB min:72kB low:88kB high:108kB active:1048kB inactive:10324kB present:16384kB pages_scanned:0 all_unreclaimable? no
Nov 11 21:51:32 undomiel1 kernel: protections[]: 0 0 0
Nov 11 21:51:32 undomiel1 kernel: Normal free:1464kB min:4020kB low:5024kB high:6028kB active:81152kB inactive:771468kB present:901120kB pages_scanned:0 all_unreclaimable? no
Nov 11 21:51:32 undomiel1 kernel: protections[]: 0 0 0
Nov 11 21:51:32 undomiel1 kernel: HighMem free:112kB min:128kB low:160kB high:192kB active:31896kB inactive:96640kB present:131008kB pages_scanned:0 all_unreclaimable? no
Nov 11 21:51:32 undomiel1 kernel: protections[]: 0 0 0
Nov 11 21:51:32 undomiel1 kernel: DMA: 1*4kB 1*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 28kB
Nov 11 21:51:32 undomiel1 kernel: Normal: 0*4kB 1*8kB 1*16kB 1*32kB 0*64kB 1*128kB 1*256kB 0*512kB 1*1024kB 0*2048kB 0*4096kB = 1464kB
Nov 11 21:51:32 undomiel1 kernel: HighMem: 0*4kB 0*8kB 1*16kB 1*32kB 1*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 112kB
Nov 11 21:51:32 undomiel1 kernel: Swap cache: add 10, delete 10, find 0/0, race 0+0

-- 
Luká¹ Hejtmánek
