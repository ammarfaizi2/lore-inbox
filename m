Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161012AbWASJoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161012AbWASJoX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 04:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161039AbWASJoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 04:44:22 -0500
Received: from smtp.osdl.org ([65.172.181.4]:43665 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161012AbWASJoW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 04:44:22 -0500
Date: Thu, 19 Jan 2006 01:44:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Andy Chittenden" <AChittenden@bluearc.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Out of Memory: Killed process 16498 (java).
Message-Id: <20060119014405.7a0619c5.akpm@osdl.org>
In-Reply-To: <89E85E0168AD994693B574C80EDB9C2703555F8E@uk-email.terastack.bluearc.com>
References: <89E85E0168AD994693B574C80EDB9C2703555F8E@uk-email.terastack.bluearc.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Andy Chittenden" <AChittenden@bluearc.com> wrote:
>
> > It'd be useful to see the dmesg output from that oom event.
> 
> Well, I've just run it again and loads of processes got killed (at least
> 3). Here's the output from dmesg:
>
> ...
>

> oom-killer: gfp_mask=0xd1, order=0
> Mem-info:
> DMA per-cpu:
> cpu 0 hot: low 0, high 0, batch 1 used:0
> cpu 0 cold: low 0, high 0, batch 1 used:0
> DMA32 per-cpu:
> cpu 0 hot: low 0, high 186, batch 31 used:162
> cpu 0 cold: low 0, high 62, batch 15 used:51
> Normal per-cpu:
> cpu 0 hot: low 0, high 186, batch 31 used:21
> cpu 0 cold: low 0, high 62, batch 15 used:41
> HighMem per-cpu: empty
> Free pages:     3116636kB (0kB HighMem)
> Active:52119 inactive:158700 dirty:108550 writeback:9545 unstable:0
> free:779159 slab:10643 mapped:44283 pagetables:1750
> DMA free:20kB min:24kB low:28kB high:36kB active:0kB inactive:0kB
> present:12740kB pages_scanned:18 all_unreclaimable? yes
> lowmem_reserve[]: 0 2999 4009 4009
> DMA32 free:2528816kB min:6052kB low:7564kB high:9076kB active:18312kB
> inactive:422164kB present:3071904kB pages_scanned:0 all_unreclaimable?
> no
> lowmem_reserve[]: 0 0 1010 1010
> Normal free:587800kB min:2036kB low:2544kB high:3052kB active:190164kB
> inactive:212636kB present:1034240kB pages_scanned:0 all_unreclaimable?
> no
> lowmem_reserve[]: 0 0 0 0
> HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB
> present:0kB pages_scanned:0 all_unreclaimable? no
> lowmem_reserve[]: 0 0 0 0
> DMA: 1*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB
> 0*2048kB 0*4096kB = 20kB
> DMA32: 3630*4kB 3233*8kB 3673*16kB 3553*32kB 2973*64kB 1729*128kB
> 763*256kB 418*512kB 458*1024kB 221*2048kB 140*4096kB = 2528816kB
> Normal: 17422*4kB 12118*8kB 7607*16kB 3846*32kB 1606*64kB 449*128kB
> 57*256kB 1*512kB 1*1024kB 0*2048kB 0*4096kB = 587800kB
> HighMem: empty
> Swap cache: add 38, delete 38, find 0/0, race 0+0
> Free swap  = 9686816kB
> Total swap = 9686968kB
> Free swap:       9686816kB
> 1310720 pages of RAM
> 299467 reserved pages
> 213833 pages shared
> 0 pages swap cached

You have 3G of free memory, 2.5G in the DMA32 zone, 0.5G in the NORMAL
zone.

> Out of Memory: Killed process 6179 (nautilus).
> oom-killer: gfp_mask=0xd1, order=0

What we've run out of is the old ZONE_DMA memory.

Can you please add this patch, retest?

--- devel/mm/oom_kill.c~a	2006-01-19 01:43:31.000000000 -0800
+++ devel-akpm/mm/oom_kill.c	2006-01-19 01:43:39.000000000 -0800
@@ -271,6 +271,7 @@ void out_of_memory(gfp_t gfp_mask, int o
 	if (printk_ratelimit()) {
 		printk("oom-killer: gfp_mask=0x%x, order=%d\n",
 			gfp_mask, order);
+		dump_stack();
 		show_mem();
 	}
 
_

