Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbWEYUVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWEYUVQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 16:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbWEYUVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 16:21:15 -0400
Received: from 216-54-166-5.static.twtelecom.net ([216.54.166.5]:53431 "EHLO
	mx1.compro.net") by vger.kernel.org with ESMTP id S1751231AbWEYUVP
	(ORCPT <rfc822;linux-kerneL@vger.kernel.org>);
	Thu, 25 May 2006 16:21:15 -0400
Message-ID: <447611B6.9030807@compro.net>
Date: Thu, 25 May 2006 16:21:10 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: linux-kerneL@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       dmarkh@cfl.rr.com
Subject: possible 2.6.16-rt23 OOM problem
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm seeing the following OOM on a number of machines. The machines are SMP P4s
(non hyper threaded) with a GB of memory. I have intentionally turned off swap
and clipped the memory to 512mb to cause this OOM to occur sooner. It takes
hours otherwise. It only takes a few minutes this way.

/proc/meminfo before starting the task that is triggering this OOM

Thu May 25 14:43:32 EDT 2006

MemTotal:       496216 kB
MemFree:         60756 kB
Buffers:         20012 kB
Cached:         288088 kB
SwapCached:          0 kB
Active:         141308 kB
Inactive:       245444 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       496216 kB
LowFree:         60756 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:             156 kB
Writeback:           0 kB
Mapped:         108248 kB
Slab:            34960 kB
CommitLimit:    248108 kB
Committed_AS:   148160 kB
PageTables:       1516 kB
VmallocTotal:   770040 kB
VmallocUsed:      8108 kB
VmallocChunk:   761252 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     4096 kB



oom-killer: gfp_mask=0x201d2, order=0
 [<b0104239>] show_trace+0xd/0xf (8)
 [<b0104252>] dump_stack+0x17/0x19 (12)
 [<b01468eb>] out_of_memory+0x13a/0x15f (48)
 [<b0148ae3>] __alloc_pages+0x257/0x2b9 (68)
 [<b0149c9b>] __do_page_cache_readahead+0x1f2/0x27e (116)
 [<b0149e2a>] do_page_cache_readahead+0x3d/0x51 (24)
 [<b0144dbf>] filemap_nopage+0x141/0x3a0 (60)
 [<b0150786>] __handle_mm_fault+0x128/0x8c4 (112)
 [<b011379a>] do_page_fault+0x358/0x55e (76)
 [<b010397b>] error_code+0x4f/0x54 (-465652988)
DMA per-cpu:
cpu 0 hot: high 0, batch 1 used:0
cpu 0 cold: high 0, batch 1 used:0
cpu 1 hot: high 0, batch 1 used:0
cpu 1 cold: high 0, batch 1 used:0
DMA32 per-cpu: empty
Normal per-cpu:
cpu 0 hot: high 186, batch 31 used:0
cpu 0 cold: high 62, batch 15 used:0
cpu 1 hot: high 186, batch 31 used:0
cpu 1 cold: high 62, batch 15 used:0
HighMem per-cpu: empty
Free pages:        5256kB (0kB HighMem)
Active:78861 inactive:3016 dirty:0 writeback:0 unstable:0 free:1314 slab:36397
mapped:75422 pagetables:1231
DMA free:2072kB min:88kB low:108kB high:132kB active:10564kB inactive:0kB
present:16384kB pages_scanned:13500 all_unreclaimable? yes
lowmem_reserve[]: 0 0 496 496
DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB
pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 496 496
Normal free:3184kB min:2804kB low:3504kB high:4204kB active:304880kB
inactive:12064kB present:507904kB pages_scanned:37909 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 2*4kB 0*8kB 1*16kB 0*32kB 2*64kB 1*128kB 1*256kB 1*512kB 1*1024kB 0*2048kB
0*4096kB = 2072kB
DMA32: empty
Normal: 98*4kB 19*8kB 5*16kB 0*32kB 0*64kB 0*128kB 2*256kB 0*512kB 0*1024kB
1*2048kB 0*4096kB = 3184kB
HighMem: empty
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 0kB
Total swap = 0kB
Out of Memory: Kill process 8041 (bash) score 83591 and children.
Out of memory: Killed process 8154 (vrsx)

/proc/meminfo a second or so before vrsx is killed.

Thu May 25 14:48:55 EDT 2006

MemTotal:       496216 kB
MemFree:          4892 kB
Buffers:           340 kB
Cached:          50880 kB
SwapCached:          0 kB
Active:         313284 kB
Inactive:        15344 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       496216 kB
LowFree:          4892 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:         302736 kB
Slab:           144656 kB
CommitLimit:    248108 kB
Committed_AS:   499920 kB
PageTables:       4952 kB
VmallocTotal:   770040 kB
VmallocUsed:      8188 kB
VmallocChunk:   761252 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     4096 kB



The offending task allocates a large SHM up front and uses mlockall with CURRENT
| FUTURE flags. After that allocates no more memory. Not using mlockall doesn't
change the outcome BTW.

This same task running on a vanilla 2.6.16.18 kernel does not OOM. I am fairly
confident the application is not at fault.

Also, I have noticed that while in single user mode

watch -n1 cat /proc/meminfo

shows free memory slowly disappearing at ~100kb per minute. Over night 133mb
disappeared. I believe this is related to the OOM above. I would imagine this
symptom is easily reproducible as long as you have an SMP machine. Again doing
the same thing while running a vanilla 2.6.16.18 kernel shows little to no
fluctuation in memory.

I have also one UMP machine running the same kernel but do not see memory
disappearing as on the SMP machines.

I'm running in complete preempt mode BTW.

Regards
Mark



