Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbWFGJ0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWFGJ0h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 05:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbWFGJ0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 05:26:37 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:22033 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S932092AbWFGJ0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 05:26:36 -0400
Message-ID: <44869BAB.6070100@shadowen.org>
Date: Wed, 07 Jun 2006 10:26:03 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Yasunori Goto <y-goto@jp.fujitsu.com>, kamezawa.hiroyu@jp.fujitsu.com,
       mbligh@google.com, linux-kernel@vger.kernel.org,
       76306.1226@compuserve.com
Subject: Re: sparsemem panic in 2.6.17-rc5-mm1 and -mm2
References: <20060605200727.374cbf05.akpm@osdl.org>	<20060606141922.c5fb16ad.kamezawa.hiroyu@jp.fujitsu.com>	<20060606142347.2AF2.Y-GOTO@jp.fujitsu.com> <20060606002758.631118da.akpm@osdl.org>
In-Reply-To: <20060606002758.631118da.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Tue, 06 Jun 2006 14:36:14 +0900
> Yasunori Goto <y-goto@jp.fujitsu.com> wrote:
> 
> 
>>>I looked back into 2.6.15, 2.6.16. 
>>>It looks -mm's time of initialization of "total_memory" is not changed from them.
>>>(yes, Andrew's fix looks sane.)
>>>
>>>I'm intersted in the following texts in the log.
>>>==
>>>Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 0kB
>>>Node 0 DMA32: empty
>>>Node 0 Normal: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 0kB
>>>Node 0 HighMem: 1*4kB 1*8kB 1*16kB 1*32kB 1*64kB 1*128kB 0*256kB 0*512kB 1*1024kB 2*2048kB 3962*4096kB = 16233724kB
>>>Node 1 DMA: empty
>>>Node 1 DMA32: empty
>>>Node 1 Normal: empty
>>>Node 1 HighMem: 1*4kB 1*8kB 0*16kB 0*32kB 0*64kB 1*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 4065*4096kB = 16651916kB
>>>Node 2 DMA: empty
>>>Node 2 DMA32: empty
>>>Node 2 Normal: empty
>>>Node 2 HighMem: 1*4kB 1*8kB 0*16kB 0*32kB 0*64kB 1*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 4065*4096kB = 16651916kB
>>>Node 3 DMA: empty
>>>Node 3 DMA32: empty
>>>Node 3 Normal: empty
>>>Node 3 HighMem: 1*4kB 1*8kB 0*16kB 0*32kB 0*64kB 1*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 3811*4096kB = 15611532kB
>>>==
>>>Looks 64GB memory. but there are only HIGHMEM, no NORMAL, DMA. so, shrink_zone() worked.
>>
>>Its log shows there are some memory in DMA and NORMAL just immediately
>>before that.....
>>
>>
>>>Active:2 inactive:15 dirty:0 writeback:0 unstable:0 free:16287272 slab:1823 mapped:0 pagetables:0
>>>Node 0 DMA free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:16384kB pages_scanned:0 all_unreclaimable? no
>>
>>lowmem_reserve[]: 0 0 0 0
>>
>>>Node 0 DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
>>
>>lowmem_reserve[]: 0 0 0 0
>>
>>>Node 0 Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:385024kB pages_scanned:0 all_unreclaimable? no
>>
>>lowmem_reserve[]: 0 0 0 0
>>
>>It looks like that something wasted all of DMA(16MB) and NORMAL(385MB)
>>zone suddenly. Hmmm...
>>
> 
> 
> I tried sparsemem on my little x86 box here.  Boots OK, after fixing up the
> kswapd_init() patch (below).
> 
> I'm wondering why I have 4k of highmem:
> 
> MemTotal:       898200 kB
> MemFree:        832936 kB
> Buffers:          8824 kB
> Cached:          30140 kB
> SwapCached:          0 kB
> Active:          25052 kB
> Inactive:        20800 kB
> HighTotal:           4 kB
> HighFree:            4 kB
> LowTotal:       898196 kB
> LowFree:        832932 kB
> SwapTotal:     1020116 kB
> SwapFree:      1020116 kB
> Dirty:               0 kB
> Writeback:           0 kB
> Mapped:          10340 kB
> Slab:            10252 kB
> CommitLimit:   1469216 kB
> Committed_AS:    15496 kB
> PageTables:        528 kB
> VmallocTotal:   114680 kB
> VmallocUsed:       648 kB
> VmallocChunk:   113980 kB
> HugePages_Total:     0
> HugePages_Free:      0
> HugePages_Rsvd:      0
> Hugepagesize:     4096 kB
> 
> The dmesg is at http://www.zip.com.au/~akpm/linux/patches/stuff/log-vmm. 
> The machine has 900MB of memory (9*128M).
> 
> 
> <enables UNALIGNED_ZONE_BOUNDARIES like the nice message says>
> <http://www.zip.com.au/~akpm/linux/patches/stuff/log-vmm-2>
> 
> Nope, I still have a 4k highmem zone.
> 
> 
> 
> btw Andy, that UNALIGNED_ZONE_BOUNDARIES message is useless.  Only 0.1% of
> users even have the knowledge how to recompile their kernel, let alone the
> inclination.  Can we do something smarter here?

Yes, valid point there.  The overall plan is that this should never come
out as the option should be on unless the architecture is ensuring
alignment.  Right now the only architecture which is so marked is x86.
I wonder if we should also be tainting the kernel at that point so its
obvious to 'us' that a kernel has this problem?

The other option is to just turn the check on all the time.  It is two
shift and mask + a compare on two cache lines that we definatly are
examining anyhow to make the merge checks.

Hmmmm.

-apw
