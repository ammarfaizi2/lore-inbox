Return-Path: <linux-kernel-owner+w=401wt.eu-S1750943AbXAORO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbXAORO3 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 12:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbXAORO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 12:14:29 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:29999 "EHLO
	nommos.sslcatacombnetworking.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750897AbXAORO2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 12:14:28 -0500
In-Reply-To: <45A865F7.3010900@yahoo.com.au>
References: <D7BBB18A-F5D4-4FE0-903F-3683333D957C@kernel.crashing.org> <45A865F7.3010900@yahoo.com.au>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <33B96043-86E4-4A8E-8282-F117524F1CA3@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: tuning/tweaking VM settings for low memory (preventing OOM)
Date: Mon, 15 Jan 2007 11:13:54 -0600
To: Nick Piggin <nickpiggin@yahoo.com.au>
X-Mailer: Apple Mail (2.752.2)
X-PopBeforeSMTPSenders: kumar-chaos@kgala.com,kumar-statements@kgala.com,kumar@kgala.com
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 12, 2007, at 10:54 PM, Nick Piggin wrote:

> Kumar Gala wrote:
>> I'm working on an embedded PPC setup with 64M of memory and no  
>> swap.   I'm trying to figure out how best to tune the VM for an  
>> OOM situation  I'm running into.
>> I'm running a 2.6.16.35 kernel and have a bittorrent app that  
>> appears  to be initializing a large file for it to download into.   
>> What I see  before running the app:
>> /bigfoot/usb_disk # cat /proc/meminfo
>> MemTotal:        62520 kB
>> MemFree:         49192 kB
>> Buffers:          8240 kB
>> Cached:            740 kB
>> SwapCached:          0 kB
>> Active:           8196 kB
>> Inactive:         1236 kB
>> HighTotal:           0 kB
>> HighFree:            0 kB
>> LowTotal:        62520 kB
>> LowFree:         49192 kB
>> SwapTotal:           0 kB
>> SwapFree:            0 kB
>> Dirty:               0 kB
>> Writeback:           0 kB
>> Mapped:            916 kB
>> Slab:             2224 kB
>> CommitLimit:     31260 kB
>> Committed_AS:     1704 kB
>> PageTables:         88 kB
>> VmallocTotal:   933872 kB
>> VmallocUsed:      9416 kB
>> VmallocChunk:   923628 kB
>> after the OOM:
>> /bigfoot/usb_disk # cat /proc/meminfo
>> MemTotal:        62520 kB
>> MemFree:          1608 kB
>> Buffers:          8212 kB
>> Cached:          42780 kB
>> SwapCached:          0 kB
>> Active:           6228 kB
>> Inactive:        45176 kB
>> HighTotal:           0 kB
>> HighFree:            0 kB
>> LowTotal:        62520 kB
>> LowFree:          1608 kB
>> SwapTotal:           0 kB
>> SwapFree:            0 kB
>> Dirty:           35208 kB
>> Writeback:        5616 kB
>> Mapped:            892 kB
>> Slab:             7788 kB
>> CommitLimit:     31260 kB
>> Committed_AS:     1704 kB
>> PageTables:         88 kB
>> VmallocTotal:   933872 kB
>> VmallocUsed:      9416 kB
>> VmallocChunk:   923628 kB
>> Which makes me think that we aren't writing back fast enough.  If  
>> I  mount the drive "sync" the issue clearly goes away.
>> It appears from an strace we are doing ftruncate64(5, 178257920)  
>> when  we OOM.
>> Any ideas on VM parameters to tweak so we throttle this from  
>> occurring?
>
> You don't give us the actual OOM message. In newer kernels, there  
> has been
> quite a bit of work done to improve the OOM situation -- search  
> changelogs
> in mm/oom_kill.c mm/vmscan.c mm/page_alloc.c.

Here's the OOM message:

[ 3639.341858] oom-killer: gfp_mask=0xd0, order=0
[ 3639.341879] Call Trace:
[ 3639.341891] [C3D65CC0] [C0007644] show_stack+0x48/0x194 (unreliable)
[ 3639.341931] [C3D65CF0] [C00418D4] out_of_memory+0x210/0x244
[ 3639.341962] [C3D65D30] [C0042A54] __alloc_pages+0x254/0x2b0
[ 3639.341988] [C3D65D70] [C0042B34] __get_free_pages+0x84/0xa0
[ 3639.342012] [C3D65D80] [C007368C] __pollwait+0x48/0xe4
[ 3639.342042] [C3D65DA0] [C015D758] datagram_poll+0x128/0x154
[ 3639.342075] [C3D65DB0] [C01A33C4] udp_poll+0x24/0x178
[ 3639.342111] [C3D65DD0] [C015526C] sock_poll+0x28/0x38
[ 3639.342134] [C3D65DE0] [C0074850] do_sys_poll+0x328/0x460
[ 3639.342159] [C3D65E50] [C00749CC] sys_poll+0x44/0x7c
[ 3639.342181] [C3D65E60] [C000D698] ret_from_syscall+0x0/0x38
[ 3639.342206] --- Exception: c01 at netb_zero_receive_thread_proc 
+0x5a0/0xa78 [netb_driver]
[ 3639.342331]     LR = netb_zero_receive_thread_proc+0x928/0xa78  
[netb_driver]
[ 3639.342350] [C3D65FC0] [C003193C] kthread+0xf4/0x130
[ 3639.342374] [C3D65FF0] [C000E778] kernel_thread+0x44/0x60
[ 3639.342397] Mem-info:
[ 3639.342406] DMA per-cpu:
[ 3639.342419] cpu 0 hot: high 18, batch 3 used:2
[ 3639.342434] cpu 0 cold: high 6, batch 1 used:5
[ 3639.342445] DMA32 per-cpu: empty
[ 3639.342456] Normal per-cpu: empty
[ 3639.342467] HighMem per-cpu: empty
[ 3639.342485] Free pages:        1420kB (0kB HighMem)
[ 3639.342507] Active:1268 inactive:11572 dirty:8693 writeback:1888  
unstable:0 free:355 slab:1967 mapped:184 pagetables:26
[ 3639.342540] DMA free:1420kB min:1024kB low:1280kB high:1536kB  
active:5072kB inactive:46288kB present:65536kB pages_scanned:26684  
all_unreclaimable? no
[ 3639.342564] lowmem_reserve[]: 0 0 0 0
[ 3639.342588] DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB  
inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
[ 3639.342609] lowmem_reserve[]: 0 0 0 0
[ 3639.342633] Normal free:0kB min:0kB low:0kB high:0kB active:0kB  
inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
[ 3639.342655] lowmem_reserve[]: 0 0 0 0
[ 3639.342680] HighMem free:0kB min:128kB low:128kB high:128kB active: 
0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
[ 3639.342702] lowmem_reserve[]: 0 0 0 0
[ 3639.342719] DMA: 73*4kB 7*8kB 3*16kB 8*32kB 0*64kB 2*128kB 0*256kB  
1*512kB 0*1024kB 0*2048kB 0*4096kB = 1420kB
[ 3639.342768] DMA32: empty
[ 3639.342778] Normal: empty
[ 3639.342788] HighMem: empty
[ 3639.342799] Free swap:            0kB
[ 3639.345716] 16384 pages of RAM
[ 3639.345728] 752 reserved pages
[ 3639.345738] 10652 pages shared
[ 3639.345748] 0 pages swap cached
[ 3639.345811] Out of Memory: Kill process 742 (sh) score 45 and  
children.
[ 3639.352458] Out of memory: Killed process 863 (killerbt-standa).
[ 3639.372795] oom-killer: gfp_mask=0x200d2, order=0
[ 3639.373137] Call Trace:
[ 3639.373426] [C3777D10] [C0007644] show_stack+0x48/0x194 (unreliable)
[ 3639.373894] [C3777D40] [C00418D4] out_of_memory+0x210/0x244
[ 3639.374298] [C3777D80] [C0042A54] __alloc_pages+0x254/0x2b0
[ 3639.374686] [C3777DC0] [C003D834] find_or_create_page+0x98/0xf0
[ 3639.375114] [C3777DE0] [C0061D40] cont_prepare_write+0xa8/0x2cc
[ 3639.375511] [C3777E20] [C00CACE0] fat_prepare_write+0x30/0x40
[ 3639.375929] [C3777E30] [C005F69C] __generic_cont_expand+0xa4/0x158
[ 3639.376330] [C3777E50] [C00CA4F8] fat_notify_change+0xf4/0x208
[ 3639.376718] [C3777E80] [C007D528] notify_change+0x220/0x23c
[ 3639.377142] [C3777EB0] [C005A318] do_truncate+0x58/0x88
[ 3639.377536] [C3777F10] [C005A6C4] do_sys_ftruncate+0x180/0x1a8
[ 3639.377972] [C3777F40] [C000D698] ret_from_syscall+0x0/0x38
[ 3639.378373] --- Exception: c01 at 0x3013d7ec
[ 3639.378709]     LR = 0x1001c304
[ 3639.379186] Mem-info:
[ 3639.379482] DMA per-cpu:
[ 3639.379800] cpu 0 hot: high 18, batch 3 used:1
[ 3639.380613] cpu 0 cold: high 6, batch 1 used:0
[ 3639.380949] DMA32 per-cpu: empty
[ 3639.381280] Normal per-cpu: empty
[ 3639.381602] HighMem per-cpu: empty
[ 3639.382041] Free pages:        1300kB (0kB HighMem)
[ 3639.382356] Active:1303 inactive:11592 dirty:8662 writeback:1889  
unstable:0 free:325 slab:1973 mapped:229 pagetables:26
[ 3639.382692] DMA free:1300kB min:1024kB low:1280kB high:1536kB  
active:5212kB inactive:46368kB present:65536kB pages_scanned:33  
all_unreclaimable? no
[ 3639.383054] lowmem_reserve[]: 0 0 0 0
[ 3639.383570] DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB  
inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
[ 3639.383915] lowmem_reserve[]: 0 0 0 0
[ 3639.384494] Normal free:0kB min:0kB low:0kB high:0kB active:0kB  
inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
[ 3639.384810] lowmem_reserve[]: 0 0 0 0
[ 3639.385691] HighMem free:0kB min:128kB low:128kB high:128kB active: 
0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
[ 3639.386053] lowmem_reserve[]: 0 0 0 0
[ 3639.386558] DMA: 35*4kB 11*8kB 3*16kB 8*32kB 0*64kB 2*128kB  
0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 1300kB
[ 3639.387016] DMA32: empty
[ 3639.387341] Normal: empty
[ 3639.387659] HighMem: empty
[ 3639.388029] Free swap:            0kB
[ 3639.391280] 16384 pages of RAM
[ 3639.391627] 752 reserved pages
[ 3639.391961] 10670 pages shared
[ 3639.392268] 0 pages swap cached
[ 3639.931258] killerbt-standa: page allocation failure. order:0,  
mode:0x200d2
[ 3639.931765] Call Trace:
[ 3639.932005] [C3777D50] [C0007644] show_stack+0x48/0x194 (unreliable)
[ 3639.932334] [C3777D80] [C0042A88] __alloc_pages+0x288/0x2b0
[ 3639.932604] [C3777DC0] [C003D834] find_or_create_page+0x98/0xf0
[ 3639.932894] [C3777DE0] [C0061D40] cont_prepare_write+0xa8/0x2cc
[ 3639.933181] [C3777E20] [C00CACE0] fat_prepare_write+0x30/0x40
[ 3639.933455] [C3777E30] [C005F69C] __generic_cont_expand+0xa4/0x158
[ 3639.933721] [C3777E50] [C00CA4F8] fat_notify_change+0xf4/0x208
[ 3639.934017] [C3777E80] [C007D528] notify_change+0x220/0x23c
[ 3639.934283] [C3777EB0] [C005A318] do_truncate+0x58/0x88
[ 3639.934554] [C3777F10] [C005A6C4] do_sys_ftruncate+0x180/0x1a8
[ 3639.934821] [C3777F40] [C000D698] ret_from_syscall+0x0/0x38
[ 3639.935076] --- Exception: c01 at 0x3013d7ec
[ 3639.935099]     LR = 0x1001c304
[ 3639.935109] Mem-info:
[ 3639.935118] DMA per-cpu:
[ 3639.935132] cpu 0 hot: high 18, batch 3 used:1
[ 3639.935147] cpu 0 cold: high 6, batch 1 used:5
[ 3639.935158] DMA32 per-cpu: empty
[ 3639.935169] Normal per-cpu: empty
[ 3639.935180] HighMem per-cpu: empty
[ 3639.935197] Free pages:           0kB (0kB HighMem)
[ 3639.935219] Active:1532 inactive:11664 dirty:8919 writeback:1839  
unstable:0 free:0 slab:1999 mapped:230 pagetables:26
[ 3639.935251] DMA free:0kB min:1024kB low:1280kB high:1536kB active: 
6128kB inactive:46656kB present:65536kB pages_scanned:168  
all_unreclaimable? no
[ 3639.935274] lowmem_reserve[]: 0 0 0 0
[ 3639.935298] DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB  
inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
[ 3639.935319] lowmem_reserve[]: 0 0 0 0
[ 3639.935344] Normal free:0kB min:0kB low:0kB high:0kB active:0kB  
inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
[ 3639.935365] lowmem_reserve[]: 0 0 0 0
[ 3639.935390] HighMem free:0kB min:128kB low:128kB high:128kB active: 
0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
[ 3639.935412] lowmem_reserve[]: 0 0 0 0
[ 3639.935429] DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB  
0*512kB 0*1024kB 0*2048kB 0*4096kB = 0kB
[ 3639.935477] DMA32: empty
[ 3639.935486] Normal: empty
[ 3639.935496] HighMem: empty
[ 3639.935507] Free swap:            0kB
[ 3639.938491] 16384 pages of RAM
[ 3639.938502] 752 reserved pages
[ 3639.938513] 10960 pages shared
[ 3639.938522] 0 pages swap cached

Any ideas?  The amount in dirty & writeback doesn't seem as bad  
compared to /proc/meminfo.

- k




