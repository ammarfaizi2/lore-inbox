Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751349AbVKQPqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbVKQPqx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 10:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbVKQPqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 10:46:53 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:35589 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750982AbVKQPqw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 10:46:52 -0500
Date: Thu, 17 Nov 2005 16:47:54 +0100
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, rohit.seth@intel.com
Subject: 2.6.15-rc1-git crashes in kswapd
Message-ID: <20051117154754.GP7787@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Running some disk tests on a box here (which has always been stable),
crashes in kswapd after the oom killer has triggered. It appears to be
calling wakeup_kswapd() with zone == NULL. Recent __alloc_pages()
"cleanup" perhaps not functionally equivelant?


oom-killer: gfp_mask=0x200d2, order=0
Mem-info:
DMA per-cpu:
cpu 0 hot: low 0, high 12, batch 2 used:0
cpu 0 cold: low 0, high 4, batch 1 used:3
DMA32 per-cpu:
cpu 0 hot: low 0, high 384, batch 64 used:41
cpu 0 cold: low 0, high 128, batch 32 used:63
Normal per-cpu: empty
HighMem per-cpu: empty
Free pages:        5396kB (0kB HighMem)
Active:55783 inactive:61639 dirty:0 writeback:0 unstable:0 free:1349 slab:6009 mapped:117281 pagetables:811
DMA free:2020kB min:56kB low:68kB high:84kB active:8200kB inactive:0kB present:10204kB pages_scanned:8293 all_unreclaimable? yes
lowmem_reserve[]: 0 488 488 488
DMA32 free:3376kB min:2796kB low:3492kB high:4192kB active:214932kB inactive:246556kB present:500140kB pages_scanned:289230 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 1*4kB 0*8kB 0*16kB 1*32kB 1*64kB 1*128kB 1*256kB 1*512kB 1*1024kB 0*2048kB 0*4096kB = 2020kB
DMA32: 0*4kB 0*8kB 5*16kB 1*32kB 1*64kB 1*128kB 0*256kB 0*512kB 1*1024kB 1*2048kB 0*4096kB = 3376kB
Normal: empty
HighMem: empty
Swap cache: add 5310, delete 5278, find 817/1120, race 0+1
Free swap  = 1103376kB
Total swap = 1116476kB
Free swap:       1103376kB
130864 pages of RAM
4182 reserved pages
338330 pages shared
32 pages swap cached
Out of Memory: Killed process 4045 (fio).
Unable to handle kernel NULL pointer dereference at 00000000000006b8 RIP: 
<ffffffff8015a2e1>{wakeup_kswapd+8}
PGD 11fea067 PUD 11b24067 PMD 0 
Oops: 0000 [1] SMP 
CPU 0 
Modules linked in: aic7xxx scsi_transport_spi ide_cd cdrom loop
Pid: 2256, comm: slpd Not tainted 2.6.15-rc1-ga620bc08 #15
RIP: 0010:[<ffffffff8015a2e1>] <ffffffff8015a2e1>{wakeup_kswapd+8}
RSP: 0000:ffff81000f87dca8  EFLAGS: 00010292
RAX: ffffffff804edd60 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff81001cf3e040 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000000001f9 R11: 0000000000000001 R12: 00000000000200d2
R13: 0000000000000000 R14: ffffffff804edd50 R15: 0000000000000000
FS:  00002aaaab4a16e0(0000) GS:ffffffff80624800(0000) knlGS:00000000556e28e0
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00000000000006b8 CR3: 000000001430d000 CR4: 00000000000006e0
Process slpd (pid: 2256, threadinfo ffff81000f87c000, task ffff81001cf3e040)
Stack: 0000000000000000 0000000000000000 ffff81001cf3e040 ffffffff80154e1e 
       ffff810000000000 000000100000008d ffffffff804edd60 000200d200000008 
       0000000000000000 ffffffff8014ff29 
Call Trace:<ffffffff80154e1e>{__alloc_pages+119} <ffffffff8014ff29>{__lock_page+95}
       <ffffffff80166ebe>{read_swap_cache_async+61} <ffffffff8015da45>{swapin_readahead+85}
       <ffffffff8015fe11>{__handle_mm_fault+1758} <ffffffff803dbfd9>{do_page_fault+1049}
       <ffffffff801393bd>{lock_timer_base+27} <ffffffff8013a059>{__mod_timer+177}
       <ffffffff8013a143>{try_to_del_timer_sync+86} <ffffffff80134a8c>{do_setitimer+352}
       <ffffffff8010e955>{error_exit+0} 

Code: 48 83 bf b8 06 00 00 00 74 55 48 8b af 98 06 00 00 48 8b 57 
RIP <ffffffff8015a2e1>{wakeup_kswapd+8} RSP <ffff81000f87dca8>
CR2: 00000000000006b8


-- 
Jens Axboe

