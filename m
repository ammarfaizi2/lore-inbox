Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261362AbUJXC7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbUJXC7j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 22:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261363AbUJXC7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 22:59:39 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:60561 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261362AbUJXC7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 22:59:19 -0400
Message-ID: <417B1A7F.2020607@yahoo.com.au>
Date: Sun, 24 Oct 2004 12:59:11 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Alastair Stevens <alastair@altruxsolutions.co.uk>
CC: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-ck1: swap mayhem under UT2004
References: <200410222346.32823.alastair@altruxsolutions.co.uk> <4179EE45.9080409@kolivas.org> <4179F381.5090200@yahoo.com.au> <200410231722.59362.alastair@altruxsolutions.co.uk>
In-Reply-To: <200410231722.59362.alastair@altruxsolutions.co.uk>
Content-Type: multipart/mixed;
 boundary="------------020202050705070709090000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020202050705070709090000
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Alastair Stevens wrote:
> On Saturday 23 October 2004 7:00, Nick Piggin wrote:
> 
>>Alastair, can you compile sysrq support into the kernel, and
>>press Alt+SysRq+M when kswapd is going crazy. Then send me
>>the output of `dmesg`. That would be very helpful.
> 
> 
> OK, here she is.....
> 
> It certainly doesn't do it _every_ time.  Going into X and straight into 
> UT2004 seems fine; but once other apps are loaded and memory is tighter, 
> off it goes into a frenzy.
> 
> Hope this is useful - thanks for your help!
> 

Yep it's great, thanks.

> SysRq : Show Memory
> Mem-info:
> DMA per-cpu:
> cpu 0 hot: low 2, high 6, batch 1
> cpu 0 cold: low 0, high 2, batch 1
> Normal per-cpu:
> cpu 0 hot: low 32, high 96, batch 16
> cpu 0 cold: low 0, high 32, batch 16
> HighMem per-cpu: empty
> 
> Free pages:        3596kB (0kB HighMem)
> Active:97415 inactive:15328 dirty:2 writeback:0 unstable:0 free:899 
> slab:2384 mapped:90021 pagetables:523
> DMA free:20kB min:20kB low:40kB high:60kB active:2080kB inactive:0kB 
> present:16384kB
> protections[]: 0 0 0
> Normal free:3576kB min:700kB low:1400kB high:2100kB active:387580kB 
> inactive:61312kB present:507888kB
> protections[]: 0 0 0
> HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB 
> present:0kB
> protections[]: 0 0 0
> DMA: 1*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 
> 0*2048kB 0*4096kB = 20kB
> Normal: 2*4kB 56*8kB 51*16kB 40*32kB 6*64kB 1*128kB 0*256kB 1*512kB 
> 0*1024kB 0*2048kB 0*4096kB = 3576kB
> HighMem: empty
> Swap cache: add 697, delete 476, find 139/162, race 0+0
> Free swap:       1660584kB
> 131068 pages of RAM
> 0 pages of HIGHMEM
> 2408 reserved pages
> 86381 pages shared
> 221 pages swap cached
> 

Can you try the following patch to start with, please?
(against 2.6.10-rc1, but should apply to most recent kernels I think)

--------------020202050705070709090000
Content-Type: text/x-patch;
 name="vm-pages_scanned-active_list.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm-pages_scanned-active_list.patch"




---

 linux-2.6-npiggin/mm/vmscan.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN mm/memory.c~vm-pages_scanned-active_list mm/memory.c
diff -puN mm/vmscan.c~vm-pages_scanned-active_list mm/vmscan.c
--- linux-2.6/mm/vmscan.c~vm-pages_scanned-active_list	2004-10-24 12:56:25.000000000 +1000
+++ linux-2.6-npiggin/mm/vmscan.c	2004-10-24 12:57:14.000000000 +1000
@@ -574,7 +574,6 @@ static void shrink_cache(struct zone *zo
 			nr_taken++;
 		}
 		zone->nr_inactive -= nr_taken;
-		zone->pages_scanned += nr_taken;
 		spin_unlock_irq(&zone->lru_lock);
 
 		if (nr_taken == 0)
@@ -675,6 +674,7 @@ refill_inactive_zone(struct zone *zone, 
 		}
 		pgscanned++;
 	}
+	zone->pages_scanned += pgscanned;
 	zone->nr_active -= pgmoved;
 	spin_unlock_irq(&zone->lru_lock);
 

_

--------------020202050705070709090000--
