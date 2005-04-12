Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262501AbVDLRKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262501AbVDLRKA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 13:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262496AbVDLRJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 13:09:13 -0400
Received: from lanshark.nersc.gov ([128.55.16.114]:11146 "EHLO
	lanshark.nersc.gov") by vger.kernel.org with ESMTP id S262492AbVDLRHl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 13:07:41 -0400
Message-ID: <425C0038.5030809@lbl.gov>
Date: Tue, 12 Apr 2005 10:07:04 -0700
From: Thomas Davis <tadavis@lbl.gov>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "'Jens Axboe'" <axboe@suse.de>, Claudio Martins <ctpm@rnl.ist.utl.pt>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: Processes stuck on D state on Dual Opteron
References: <200504120803.j3C83tg06634@unix-os.sc.intel.com> <425BAC55.7020506@yahoo.com.au> <425BB073.8050308@yahoo.com.au> <425BB958.3080308@yahoo.com.au>
In-Reply-To: <425BB958.3080308@yahoo.com.au>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> 
> It is a bit subtle: get_request may only drop the lock and return NULL
> (after retaking the lock), if we fail on a memory allocation. If we
> just fail due to unavailable queue slots, then the lock is never
> dropped. And the mem allocation can't fail because it is a mempool
> alloc with GFP_NOIO.
> 

I'm jumping in here, because we have seen this problem on a X86-64 system, with 4gb of ram, and SLES9 (2.6.5-7.141)

You can drive the node into this state:

Mem-info:
Node 1 DMA per-cpu: empty
Node 1 Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
Node 1 HighMem per-cpu: empty
Node 0 DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
cpu 1 hot: low 2, high 6, batch 1
cpu 1 cold: low 0, high 2, batch 1
Node 0 Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
Node 0 HighMem per-cpu: empty

Free pages:       10360kB (0kB HighMem)
Active:485853 inactive:421820 dirty:0 writeback:0 unstable:0 free:2590 slab:10816 mapped:903444 pagetables:2097
Node 1 DMA free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB
lowmem_reserve[]: 0 1664 1664
Node 1 Normal free:2464kB min:2468kB low:4936kB high:7404kB active:918440kB inactive:710360kB present:1703936kB
lowmem_reserve[]: 0 0 0
Node 1 HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB
lowmem_reserve[]: 0 0 0
Node 0 DMA free:4928kB min:20kB low:40kB high:60kB active:0kB inactive:0kB present:16384kB
lowmem_reserve[]: 0 2031 2031
Node 0 Normal free:2968kB min:3016kB low:6032kB high:9048kB active:1024968kB inactive:976924kB present:2080764kB
lowmem_reserve[]: 0 0 0
Node 0 HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB
lowmem_reserve[]: 0 0 0
Node 1 DMA: empty
Node 1 Normal: 46*4kB 19*8kB 9*16kB 4*32kB 1*64kB 0*128kB 1*256kB 1*512kB 1*1024kB 0*2048kB 0*4096kB = 2464kB
Node 1 HighMem: empty
Node 0 DMA: 4*4kB 4*8kB 1*16kB 2*32kB 3*64kB 4*128kB 2*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 4928kB
Node 0 Normal: 0*4kB 1*8kB 1*16kB 0*32kB 0*64kB 1*128kB 1*256kB 3*512kB 1*1024kB 0*2048kB 0*4096kB = 2968kB
Node 0 HighMem: empty
Swap cache: add 1009224, delete 106245, find 179674/181478, race 0+2
Free swap:       4739812kB
950271 pages of RAM
17513 reserved pages
2788 pages shared
902980 pages swap cached

with processes doing this:

SysRq : Show State

                                                       sibling
  task                 PC          pid father child younger older
init          D 000001000000e810     0     1      0     2               (NOTLB)
000001007ff81be8 0000000000000006 0000000000000000 0000000000000000
       0000000000000000 0000000000000000 0000000000000000 0000000000000000
       0000000000000000 0000010002c1d6e0
Call Trace:<ffffffff8017338b>{try_to_free_pages+283} <ffffffff80147d0d>{schedule_timeout+173}
       <ffffffff80147c50>{process_timeout+0} <ffffffff8013a292>{io_schedule_timeout+82}
       <ffffffff80280efd>{blk_congestion_wait+141} <ffffffff8013c530>{autoremove_wake_function+0}
       <ffffffff8013c530>{autoremove_wake_function+0} <ffffffff8016ab68>{__alloc_pages+776}
       <ffffffff8018573f>{read_swap_cache_async+63} <ffffffff801781b1>{swapin_readahead+97}
       <ffffffff8017834e>{do_swap_page+142} <ffffffff801796a1>{handle_mm_fault+337}
       <ffffffff80123ebb>{do_page_fault+411} <ffffffff801a3259>{sys_select+1097}
       <ffffffff801a332f>{sys_select+1311} <ffffffff801122a9>{error_exit+0}

mg.C.2        D 000001000000e810     0  1971   1955  1972               (NOTLB)
00000100e236bc68 0000000000000006 0000000000000000 0000000000000000
       0000000000000000 0000000000000000 0000000000000000 0000000000000000
       0000000100000000 00000100816ed360
Call Trace:<ffffffff8017338b>{try_to_free_pages+283} <ffffffff80147d0d>{schedule_timeout+173}
       <ffffffff80147c50>{process_timeout+0} <ffffffff8013a292>{io_schedule_timeout+82}
       <ffffffff80280efd>{blk_congestion_wait+141} <ffffffff8013c530>{autoremove_wake_function+0}
       <ffffffff8013c530>{autoremove_wake_function+0} <ffffffff8016ab68>{__alloc_pages+776}
       <ffffffff801778ad>{do_wp_page+285} <ffffffff801796c5>{handle_mm_fault+373}
       <ffffffff80123ebb>{do_page_fault+411} <ffffffff801122a9>{error_exit+0}
mg.C.2        S 000001007b0a06a0     0  1972   1971          1974       (NOTLB)
00000100bc1c1ca0 0000000000000006 0000000000000010 0000000000010246
       000000000004c7c0 00000100816ec280 0000007680000780 0000010081f23390
       0000000180000780 00000100816ed360
Call Trace:<ffffffff8016abb4>{__alloc_pages+852} <ffffffff80110ac8>{__down_interruptible+216}
       <ffffffff80139280>{default_wake_function+0} <ffffffff8013531c>{recalc_task_prio+940}
       <ffffffff80230d91>{__down_failed_interruptible+53}
       <ffffffffa01cc47e>{:mosal:.text.lock.mosal_sync+5}
       <ffffffffa0291daf>{:mod_vipkl:VIPKL_EQ_poll+607} <ffffffffa029bb01>{:mod_vipkl:VIPKL_EQ_poll_stat+529}
       <ffffffffa029e658>{:mod_vipkl:VIPKL_ioctl+5144} <ffffffffa0294e21>{:mod_vipkl:vipkl_wrap_kernel_ioctl+417}
       <ffffffff8018c00e>{filp_close+126} <ffffffff801a1fb4>{sys_ioctl+612}
       <ffffffff801118d4>{system_call+124}
mg.C.2        S 000001007b0a18c0     0  1974   1971                1972 (NOTLB)
00000100a3955ca0 0000000000000006 00000001e7d422e8 000001002c9ca550
       000000000005f138 00000100816ec280 0000007680000780 0000010081f23390
       0000000180000780 00000100816ed360
Call Trace:<ffffffff8016abb4>{__alloc_pages+852} <ffffffff80110ac8>{__down_interruptible+216}
       <ffffffff80139280>{default_wake_function+0} <ffffffff8013531c>{recalc_task_prio+940}
       <ffffffff80230d91>{__down_failed_interruptible+53}
       <ffffffffa01cc47e>{:mosal:.text.lock.mosal_sync+5}
       <ffffffffa0291daf>{:mod_vipkl:VIPKL_EQ_poll+607} <ffffffff8011db9d>{smp_send_reschedule+29}
       <ffffffffa029bb01>{:mod_vipkl:VIPKL_EQ_poll_stat+529}
       <ffffffffa029e658>{:mod_vipkl:VIPKL_ioctl+5144} <ffffffffa0294e21>{:mod_vipkl:vipkl_wrap_kernel_ioctl+417}
       <ffffffff8018c00e>{filp_close+126} <ffffffff801a1fb4>{sys_ioctl+612}
       <ffffffff801118d4>{system_call+124}

and it will never, ever recover from it.

Note - this is a cluster of AMD x86_64's, running IB with 4gb of ram.  We have limited the amount of memory that IB can pin down, and limited process size to 1.5gb (on a 4gb machine!) just to maintain stability.

We do not use md; it's a compute node with only a single local drive.

We have been told, the 2.6 memory allocator goes into an infinite loop, and never recovers from it.

thomas
