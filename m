Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263103AbVBDANU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263103AbVBDANU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 19:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263100AbVBDANU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 19:13:20 -0500
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:15230 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263337AbVBDANB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 19:13:01 -0500
Message-ID: <4202BE05.9090901@yahoo.com.au>
Date: Fri, 04 Feb 2005 11:12:53 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: =?UTF-8?B?77+9?= <terje_fb@yahoo.no>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.10: kswapd spins like crazy
References: <20050203195033.29314.qmail@web51608.mail.yahoo.com>
In-Reply-To: <20050203195033.29314.qmail@web51608.mail.yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Terje Fåberg wrote:
> Terje Fåberg <terje_fb@yahoo.no> skrev: 
> 
> 
>>The kernel is compiling right now, but I cannot 
>>reboot this machine until six or seven o'clock
>>tonight (CET). I will report then.
> 
> 
> Well, well, I rebooted the same kernel, now with
> MAGIC-SYSRQ enabled.  At first the kswapd-effect
> wouldn't show up, but now the image is much clearer
> than before. kswapd eats constantly 95% cpu time while
> the system is "idle".
> 
> The System is quite sluggish. Switching between
> applications needs ages. After Eclipse has been active
> for a few minutes, I it lasts 45 seconds until enough
> of Mozilla is swapped back in, and Mozilla has redrawn
> its window. 
> 
> Complete info including SysRq-Meminfo is attached.
> 

Thanks very much, this is a good help.

> galileo:~# cat /proc/vmstat > pre ; sleep 10 ; cat /proc/vmstat > post
> 
> galileo:~# cat pre
...
> pgscan_kswapd_high 0
> pgscan_kswapd_normal 2504667
> pgscan_kswapd_dma 615532032
...
> 
> galileo:~# cat post
...
> pgscan_kswapd_high 0
> pgscan_kswapd_normal 2504667
> pgscan_kswapd_dma 649881006
...

So we can see it is trying to scan the DMA zone.

> galileo:~# dmesg 
> [...]
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
> Free pages:        7872kB (0kB HighMem)
> Active:48698 inactive:86241 dirty:0 writeback:0 unstable:0 free:1968 slab:4509 mapped:50560 pagetables:1717
> DMA free:80kB min:80kB low:100kB high:120kB active:0kB inactive:11716kB present:16384kB pages_scanned:123 all_unreclaimable? no
> protections[]: 0 0 0

This is the reason why: DMA only has 80K free, and kswapd won't stop until either 120K
is free, or all_unreclaimable gets switched on.

Now clearly all_unreclaimable should be getting set if nothing can be reclaimed (although
it is possible that non pagecache allocating and freeing can mess it up, that's unlikely).

Hmm, your DMA zone has no active pages, and pages_scanned (which triggers all_unreclaimable)
is only incremented when scanning the active list. But I wonder, if the pages can't be
freed, why aren't they being put on the active list?

Nick

PS. let's not release 2.6.11 just yet :\

