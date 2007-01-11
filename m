Return-Path: <linux-kernel-owner+w=401wt.eu-S1750821AbXAKQTs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbXAKQTs (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 11:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbXAKQTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 11:19:48 -0500
Received: from wr-out-0506.google.com ([64.233.184.238]:64203 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821AbXAKQTr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 11:19:47 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s1mUP9qXVOnbSaTbFi7/aSca47OHHfecyDuuhg0qnSB2XZKsIApQECWuwTEyCHBSwIoYqINkqGA2Dx1NF52XTxHv+ItpDlwGkJUcH+s7utlb6IdWvjrHgJKlYLx4mVdwlrxXM3cUrQM4PLyDb/QmkRwBw8qV9CDAc5JZ2Ir+3zU=
Message-ID: <6d6a94c50701110819nf78a90eg3ff06f85c75e8b50@mail.gmail.com>
Date: Fri, 12 Jan 2007 00:19:45 +0800
From: Aubrey <aubreylee@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: O_DIRECT question
Cc: "Nick Piggin" <nickpiggin@yahoo.com.au>, "Hua Zhong" <hzhong@gmail.com>,
       "Hugh Dickins" <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       hch@infradead.org, kenneth.w.chen@intel.com, akpm@osdl.org,
       mjt@tls.msk.ru
In-Reply-To: <Pine.LNX.4.64.0701110746360.3594@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com>
	 <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org>
	 <Pine.LNX.4.64.0701101910110.3594@woody.osdl.org>
	 <45A5D4A7.7020202@yahoo.com.au>
	 <Pine.LNX.4.64.0701110746360.3594@woody.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/07, Linus Torvalds <torvalds@osdl.org> wrote:
>
> The "good" news is that CPU really is outperforming disk more and more, so
> the extra cost of managing the page cache keeps on getting smaller and
> smaller, and (fingers crossed) some day we can hopefully just drop
> O_DIRECT and nobody will care.
>
>                 Linus
>
Yes for desktop, server, but maybe not for embedded system, specially
for no-mmu linux. In many embedded system cases, the whole system is
running in the ram, including file system. So it's not necessary using
page cache anymore. Page cache can't improve performance on these
cases, but only fragment memory.
Maybe O_DIRECT is not a right way to fix this issue. But I think file
system need an option for un-buffered access, that means don't use
page cache at all.

-Aubrey

P.S. The following is the test case and crash info. I think it will
help what exactly I encountered.
------------------------------------
#include <stdio.h>
#include <stdlib.h>
#define N 8

int main (void){
       void *p[N];
       int i;

       printf("Alloc %d MB !\n", N);

       for (i = 0; i < N; i++) {
               p[i] = malloc(1024 * 1024);
               if (p[i] == NULL)
                       printf("alloc failed\n");
       }

               printf("alloc successful \n");
       for (i = 0; i < N; i++)
               free(p[i]);
}
--------------------------------------------------------------

When there is not enough free memory to allocate:
==============================
root:/mnt> cat /proc/meminfo
MemTotal:        54196 kB
MemFree:          5520 kB <== only 5M free
Buffers:            76 kB
Cached:          44696 kB <== cache eat 40MB
SwapCached:          0 kB
Active:          21092 kB
Inactive:        23680 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:        54196 kB
LowFree:          5520 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               0 kB
Writeback:           0 kB
AnonPages:           0 kB
Mapped:              0 kB
Slab:             3720 kB
PageTables:          0 kB
NFS_Unstable:        0 kB
Bounce:              0 kB
CommitLimit:     27096 kB
Committed_AS:        0 kB
VmallocTotal:        0 kB
VmallocUsed:         0 kB
VmallocChunk:        0 kB
==========================================


I got failure after run the test program.
---------------------------------------
root:/mnt> ./t
Alloc 8 MB !
t: page allocation failure. order:9, mode:0x40d0
Hardware Trace:
 0 Target : <0x00004de0> { _dump_stack + 0x0 }
  Source : <0x0003054a> { ___alloc_pages + 0x17e }
 1 Target : <0x0003054a> { ___alloc_pages + 0x17e }
  Source : <0x0000dbc2> { _printk + 0x16 }
 2 Target : <0x0000dbbe> { _printk + 0x12 }
  Source : <0x0000da4e> { _vprintk + 0x1a2 }
 3 Target : <0x0000da42> { _vprintk + 0x196 }
  Source : <0xffa001ea> { __common_int_entry + 0xd8 }
 4 Target : <0xffa00188> { __common_int_entry + 0x76 }
  Source : <0x000089bc> { _return_from_int + 0x58 }
 5 Target : <0x000089bc> { _return_from_int + 0x58 }
  Source : <0x00008992> { _return_from_int + 0x2e }
 6 Target : <0x00008964> { _return_from_int + 0x0 }
  Source : <0xffa00184> { __common_int_entry + 0x72 }
 7 Target : <0xffa00182> { __common_int_entry + 0x70 }
  Source : <0x00012682> { __local_bh_enable + 0x56 }
 8 Target : <0x0001266c> { __local_bh_enable + 0x40 }
  Source : <0x0001265c> { __local_bh_enable + 0x30 }
 9 Target : <0x00012654> { __local_bh_enable + 0x28 }
  Source : <0x00012644> { __local_bh_enable + 0x18 }
10 Target : <0x0001262c> { __local_bh_enable + 0x0 }
  Source : <0x000128e0> { ___do_softirq + 0x94 }
11 Target : <0x000128d8> { ___do_softirq + 0x8c }
  Source : <0x000128b8> { ___do_softirq + 0x6c }
12 Target : <0x000128aa> { ___do_softirq + 0x5e }
  Source : <0x0001666a> { _run_timer_softirq + 0x82 }
13 Target : <0x000165fc> { _run_timer_softirq + 0x14 }
  Source : <0x00023eb8> { _hrtimer_run_queues + 0xe8 }
14 Target : <0x00023ea6> { _hrtimer_run_queues + 0xd6 }
  Source : <0x00023e70> { _hrtimer_run_queues + 0xa0 }
15 Target : <0x00023e68> { _hrtimer_run_queues + 0x98 }
  Source : <0x00023eae> { _hrtimer_run_queues + 0xde }
Stack from 015a7dcc:
       00000001 0003054e 00000000 00000001 000040d0 0013c70c 00000009 000040d0
       00000000 00000080 00000000 000240d0 00000000 015a6000 015a6000 015a6000
       00000010 00000000 00000001 00036e12 00000000 0023f8e0 00000073 00191e40
       00000020 0023e9a0 000040d0 015afea9 015afe94 00101fff 000040d0 0023e9a0
       00000010 00101fff 000370de 00000000 0363d3e0 00000073 0000ffff 04000021
       00000000 00101000 00187af0 00035b44 00000000 00035e40 00000000 00000000
Call Trace:
Call Trace:
[<0000fffe>] _do_exit+0x12e/0x7cc
[<00004118>] _sys_mmap+0x54/0x98
[<00101000>] _fib_create_info+0x670/0x780
[<00008828>] _system_call+0x68/0xba
[<000040c4>] _sys_mmap+0x0/0x98
[<0000fffe>] _do_exit+0x12e/0x7cc
[<00008000>] _cplb_mgr+0x8/0x2e8
[<00101000>] _fib_create_info+0x670/0x780
[<00101000>] _fib_create_info+0x670/0x780

Mem-info:
DMA per-cpu:
cpu 0 hot: high 18, batch 3 used:5
cpu 0 cold: high 6, batch 1 used:5
DMA32 per-cpu: empty
Normal per-cpu: empty
HighMem per-cpu: empty
Free pages:       21028kB (0kB HighMem)
Active:2549 inactive:3856 dirty:0 writeback:0 unstable:0 free:5257
slab:1833 mapped:0 pagetables:0
DMA free:21028kB min:948kB low:1184kB high:1420kB active:10196kB
inactive:15424kB present:56320kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB
inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 43*4kB 35*8kB 28*16kB 17*32kB 18*64kB 20*128kB 16*256kB 11*512kB
6*1024kB 0*2048kB 0*4096kB 0*8192kB 0*16384kB 0*32768kB = 21028kB
DMA32: empty
Normal: empty
HighMem: empty
14080 pages of RAM
5285 free pages
531 reserved pages
11 pages shared
0 pages swap cached
Allocation of length 1052672 from process 57 failed
DMA per-cpu:
cpu 0 hot: high 18, batch 3 used:5
cpu 0 cold: high 6, batch 1 used:5
DMA32 per-cpu: empty
Normal per-cpu: empty
HighMem per-cpu: empty
Free pages:       21028kB (0kB HighMem)
Active:2549 inactive:3856 dirty:0 writeback:0 unstable:0 free:5257
slab:1833 mapped:0 pagetables:0
DMA free:21028kB min:948kB low:1184kB high:1420kB active:10196kB
inactive:15424kB present:56320kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:128kB low:128kB high:128kB active:0kB
inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 43*4kB 35*8kB 28*16kB 17*32kB 18*64kB 20*128kB 16*256kB 11*512kB
6*1024kB 0*2048kB 0*4096kB 0*8192kB 0*16384kB 0*32768kB = 21028kB
DMA32: empty
Normal: empty
HighMem: empty
-----------------------------

If there is no page cache, I have another 40Mb to run the test
program. I'm pretty sure the program can work properly at the first
time.
