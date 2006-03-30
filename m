Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbWC3PsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWC3PsA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 10:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWC3PsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 10:48:00 -0500
Received: from corky.net ([212.150.53.130]:54167 "EHLO zebday.corky.net")
	by vger.kernel.org with ESMTP id S1751162AbWC3PsA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 10:48:00 -0500
Message-ID: <442C0BA3.1050603@corky.net>
Date: Thu, 30 Mar 2006 17:47:31 +0100
From: Just Marc <marc@corky.net>
User-Agent: Mail/News 1.5 (X11/20060228)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Crash soon after an alloc_skb failure in 2.6.16 and previous, swap
 disabled
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Checked: ClamAV using ClamSMTP on CorKy.NeT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm running a few machines with swap turned off and am experiencing 
crashes when the system is extremely low on kernel memory.   So far the 
crashes observed are always inside the recv function of the Ethernet 
module, below is the trace for the tg3 module but a similar result is 
also seen with the e1000 module.   Th crash is not necessarily related 
to the Ethernet modules but may happen at a later stage deeper in the 
networking code.

I don't have console access to the machine so I can't know what the 
final oops/crash message is (if any) but this can be reproduced on any 
machine quite easily by consuming all of the available memory,  I guess 
that if done at userspace the OOM killer will prevent this from 
happening but a simple LKM can allocate all this memory and this issue 
should surface quickly.

Some commercial unices have tunable kernel parameters for randomly 
denying allocations within the kernel to help QA-abuse code within the 
kernel which relies on memory allocation, this kind of feature helps 
locate crash cases similar to this one.  Maybe it should be introduced 
to the kernel as well and be tested from time to time prior to major 
releases?

The benefits of running a system without swap are arguable, but in my 
particular scenario I prefer to have connections dropped rather than 
experience the overheads and latencies of a heavily swapping system.   
Nonetheless, the kernel should handle most of the OOM cases as elegantly 
and gently as possible.

I tried tuning vm.min_free_kbytes and vm.lowmem_reserve_ratio with 
fairly high values but it didn't seem to help.   Are there other 
parameters I should look at?

Thanks!

Mar 28 18:03:47 t06 kernel: swapper: page allocation failure. order:1, 
mode:0x20
Mar 28 18:03:47 t06 kernel:
Mar 28 18:03:47 t06 kernel: Call Trace: <IRQ> 
<ffffffff8015d501>{__alloc_pages+705}
Mar 28 18:03:47 t06 kernel:        <ffffffff8017be67>{cache_grow+359} 
<ffffffff8017c362>{cache_alloc_refill+450}
Mar 28 18:03:47 t06 kernel:        <ffffffff8017c4c2>{__kmalloc+226} 
<ffffffff8044f45b>{__alloc_skb+107}
Mar 28 18:03:47 t06 kernel:        <ffffffff8048423b>{tcp_collapse+331} 
<ffffffff80484670>{tcp_prune_queue+448}
Mar 28 18:03:47 t06 kernel:        
<ffffffff8048743c>{tcp_data_queue+540} 
<ffffffff80488e99>{tcp_rcv_established+1849}
Mar 28 18:03:47 t06 kernel:        <ffffffff8048fcbf>{tcp_v4_do_rcv+63} 
<ffffffff8046dc5c>{nf_iterate+92}
Mar 28 18:03:47 t06 kernel:        <ffffffff8049102e>{tcp_v4_rcv+2478} 
<ffffffff80474180>{ip_local_deliver_finish+0}
Mar 28 18:03:47 t06 kernel:        
<ffffffff804744d2>{ip_local_deliver+370} <ffffffff80474aa7>{ip_rcv+1255}
Mar 28 18:03:47 t06 kernel:        <ffffffff8044f476>{__alloc_skb+134} 
<ffffffff80456d90>{netif_receive_skb+976}
Mar 28 18:03:47 t06 kernel:        <ffffffff803855fd>{tg3_poll+1901} 
<ffffffff80455618>{net_rx_action+184}
Mar 28 18:03:47 t06 kernel:        <ffffffff80133743>{__do_softirq+99} 
<ffffffff8010bdc2>{call_softirq+30}
Mar 28 18:03:47 t06 kernel:        <ffffffff8010ceac>{do_softirq+44} 
<ffffffff8010cf07>{do_IRQ+71}
Mar 28 18:03:47 t06 kernel:        <ffffffff801096f0>{default_idle+0} 
<ffffffff8010b120>{ret_from_intr+0} <EOI>
Mar 28 18:03:47 t06 kernel:        <ffffffff804be41f>{thread_return+0} 
<ffffffff8010971d>{default_idle+45}
Mar 28 18:03:47 t06 kernel:        <ffffffff801097bb>{cpu_idle+107} 
<ffffffff807c543f>{start_secondary+1247}
Mar 28 18:03:47 t06 kernel: Mem-info:
Mar 28 18:03:47 t06 kernel: Node 1 DMA per-cpu: empty
Mar 28 18:03:47 t06 kernel: Node 1 DMA32 per-cpu: empty
Mar 28 18:03:47 t06 kernel: Node 1 Normal per-cpu:
Mar 28 18:03:47 t06 kernel: cpu 0 hot: high 186, batch 31 used:0
Mar 28 18:03:47 t06 kernel: cpu 0 cold: high 62, batch 15 used:0
Mar 28 18:03:47 t06 kernel: cpu 1 hot: high 186, batch 31 used:11
Mar 28 18:03:47 t06 kernel: cpu 1 cold: high 62, batch 15 used:57
Mar 28 18:03:47 t06 kernel: Node 1 HighMem per-cpu: empty
Mar 28 18:03:47 t06 kernel: Node 0 DMA per-cpu:
Mar 28 18:03:47 t06 kernel: cpu 0 hot: high 0, batch 1 used:0
Mar 28 18:03:47 t06 kernel: cpu 0 cold: high 0, batch 1 used:0
Mar 28 18:03:47 t06 kernel: cpu 1 hot: high 0, batch 1 used:0
Mar 28 18:03:47 t06 kernel: cpu 1 cold: high 0, batch 1 used:0
Mar 28 18:03:47 t06 kernel: Node 0 DMA32 per-cpu:
Mar 28 18:03:47 t06 kernel: cpu 0 hot: high 186, batch 31 used:80
Mar 28 18:03:47 t06 kernel: cpu 0 cold: high 62, batch 15 used:50
Mar 28 18:03:47 t06 kernel: cpu 1 hot: high 186, batch 31 used:69
Mar 28 18:03:47 t06 kernel: cpu 1 cold: high 62, batch 15 used:57
Mar 28 18:03:47 t06 kernel: Node 0 Normal per-cpu: empty
Mar 28 18:03:47 t06 kernel: Node 0 HighMem per-cpu: empty
Mar 28 18:03:47 t06 kernel: Free pages:      310220kB (0kB HighMem)
Mar 28 18:03:47 t06 kernel: Active:897229 inactive:1864947 dirty:1200746 
writeback:315 unstable:0 free:77555 slab:167046 mapped:644593 
pagetables:23124
Mar 28 18:03:47 t06 kernel: Node 1 DMA free:0kB min:0kB low:0kB high:0kB 
active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Mar 28 18:03:47 t06 kernel: lowmem_reserve[]: 0 0 8080 8080
Mar 28 18:03:47 t06 kernel: Node 1 DMA32 free:0kB min:0kB low:0kB 
high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 
all_unreclaimable? no
Mar 28 18:03:47 t06 kernel: lowmem_reserve[]: 0 0 8080 8080
Mar 28 18:03:47 t06 kernel: Node 1 Normal free:184796kB min:9444kB 
low:11804kB high:14164kB active:2372304kB inactive:5198104kB 
present:8273920kB
pages_scanned:33 all_unreclaimable? no
Mar 28 18:03:47 t06 kernel: lowmem_reserve[]: 0 0 0 0
Mar 28 18:03:47 t06 kernel: Node 1 HighMem free:0kB min:128kB low:128kB 
high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 
all_unreclaimable? no
Mar 28 18:03:47 t06 kernel: lowmem_reserve[]: 0 0 0 0
Mar 28 18:03:47 t06 kernel: Node 0 DMA free:8996kB min:8kB low:8kB 
high:12kB active:0kB inactive:0kB present:8564kB pages_scanned:10 
all_unreclaimable? yes
Mar 28 18:03:47 t06 kernel: lowmem_reserve[]: 0 3896 3896 3896
Mar 28 18:03:47 t06 kernel: Node 0 DMA32 free:116428kB min:4552kB 
low:5688kB high:6828kB active:1216612kB inactive:2261684kB 
present:3989664kB pages_scanned:33 all_unreclaimable? no
Mar 28 18:03:47 t06 kernel: lowmem_reserve[]: 0 0 0 0
Mar 28 18:03:47 t06 kernel: Node 0 Normal free:0kB min:0kB low:0kB 
high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 
all_unreclaimable? no
Mar 28 18:03:47 t06 kernel: lowmem_reserve[]: 0 0 0 0
Mar 28 18:03:47 t06 kernel: Node 0 HighMem free:0kB min:128kB low:128kB 
high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 
all_unreclaimable? no
Mar 28 18:03:47 t06 kernel: lowmem_reserve[]: 0 0 0 0
Mar 28 18:03:47 t06 kernel: Node 1 DMA: empty
Mar 28 18:03:47 t06 kernel: Node 1 DMA32: empty
Mar 28 18:03:47 t06 kernel: Node 1 Normal: 45755*4kB 0*8kB 1*16kB 1*32kB 
1*64kB 1*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 0*4096kB = 184796kB
Mar 28 18:03:47 t06 kernel: Node 1 HighMem: empty
Mar 28 18:03:47 t06 kernel: Node 0 DMA: 5*4kB 4*8kB 3*16kB 4*32kB 1*64kB 
2*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 2*4096kB = 8996kB
Mar 28 18:03:47 t06 kernel: Node 0 DMA32: 28893*4kB 1*8kB 1*16kB 0*32kB 
1*64kB 0*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 116428kB
Mar 28 18:03:47 t06 kernel: Node 0 Normal: empty
Mar 28 18:03:47 t06 kernel: Node 0 HighMem: empty
Mar 28 18:03:47 t06 kernel: Swap cache: add 0, delete 0, find 0/0, race 0+0
Mar 28 18:03:47 t06 kernel: Free swap  = 0kB
Mar 28 18:03:47 t06 kernel: Total swap = 0kB
Mar 28 18:03:47 t06 kernel: Free swap:            0kB
Mar 28 18:03:47 t06 kernel: 3145728 pages of RAM
Mar 28 18:03:47 t06 kernel: 100273 reserved pages
Mar 28 18:03:47 t06 kernel: 2717673 pages shared
Mar 28 18:03:47 t06 kernel: 0 pages swap cached

