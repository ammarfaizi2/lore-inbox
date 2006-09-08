Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbWIHLdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbWIHLdu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 07:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbWIHLdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 07:33:50 -0400
Received: from ausmtp05.au.ibm.com ([202.81.18.154]:11668 "EHLO
	ausmtp05.au.ibm.com") by vger.kernel.org with ESMTP
	id S1750818AbWIHLds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 07:33:48 -0400
In-Reply-To: <20060907191434.0682c7e4.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Re: [Problem] System hang when I run pounder and syscall test on kernel
 2.6.18-rc5
X-Mailer: Lotus Notes Release 7.0 August 18, 2005
Message-ID: <OFDEF165C1.4EC97DB2-ON482571E3.003A211D-482571E3.003F7CC6@cn.ibm.com>
From: Shu Qing Yang <yangshuq@cn.ibm.com>
Date: Fri, 8 Sep 2006 19:36:40 +0800
X-MIMETrack: Serialize by Router on D23M0037/23/M/IBM(Release 7.0HF124 | January 12, 2006) at
 09/08/2006 19:36:49,
	Serialize complete at 09/08/2006 19:36:49
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote on 2006-09-08 10:14:34:

> On Thu, 7 Sep 2006 12:35:09 +0800
> Shu Qing Yang <yangshuq@cn.ibm.com> wrote:
> 
> > Problem description:
> >     I run pounder, scsi_debug on a machine. Then start 200 random 
syscall 
> > test 
> > simultaneously. Tens of minutes later, the system hang.
> 
> What is "pounder" and from where can it be obtained?
> 
Thanks for your reply.

Pounder is part of ltp and locate in LTPROOT/testcases/pounder21. 
It is a suit of test cases including mem_alloc, random_syscall, bonnie++, 
etc.

> Running two tests at the same time complicates things.  The next step
> should be to determine whether it is reproducible.  If it is, then see 
if
> it is reproducible with just one test running (presumably pounder?)
> 
Running multiple cases simultaneously is to stress kernel more. And 
because of
lack of machine resource I have no chance to reproduce it.

> It would be helpful to provide sufficient information to give others a
> chance of reproducing it: amount of memory, method for configuring the
> scsi-debug "disks", method for invoking pounder, etc.
> 
The machine belongs to IBM p-Series with power5+ cpu and 2GB memory.
Run LTPROOT/testscript/ltp-scsi_debug.sh and 
LTPROOT/testscript/pounder21/pounder directly.
No extra parameters.   The command to load scsi_debug module is: 
modprobe scsi_debug max_luns=2 num_tgts=2 add_host=2 dev_size_mb=20

> > Hardware Environment
> >     Cpu type :power5+
> > Software Env:
> >     kernel: 2.6.18-rc5
> >     Base system: opensuse10
> > 
> > Is the system (not just the application) hung?
> >     Yes
> > 
> > Did the system produce an OOPS message on the console?
> >     No.
> > 
> > Is the system sitting in a debugger right now?
> >     Yes, xmon and sysrq are on.
> > 
> > Additional information:
> >     I use 'sysrq + t' then force system into xmon. And get following 
> > message:
> 
> Trace is a bit confusing.  Ben (who is being shy) thinks it's this:
> 
> > 0:mon> c1
> > 1:mon> e
> > cpu 0x1: Vector: 501 (Hardware Interrupt) at [c000000059f89ed0]
> >     pc: c0000000000a4780: .release_pages+0xac/0x260
> >     lr: c0000000000a5138: .__pagevec_release+0x28/0x48
> >     sp: c000000059f8a150
> >    msr: 8000000000009032
> >   current = 0xc00000005f2b66b0
> >   paca    = 0xc0000000006b4500
> >     pid   = 16704, comm = shmctl01
> > 1:mon> t
> > [c000000059f8a280] c0000000000a5138 .__pagevec_release+0x28/0x48
> > [c000000059f8a310] c0000000000a7074 .shrink_inactive_list+0x944/0xa0c
> > [c000000059f8a580] c0000000000a7248 .shrink_zone+0x10c/0x168
> > [c000000059f8a620] c0000000000a7fe8 .try_to_free_pages+0x1c8/0x320
> > [c000000059f8a730] c0000000000a1954 .__alloc_pages+0x1ec/0x344
> > [c000000059f8a820] c00000000009de34 .find_or_create_page+0x8c/0x10c
> > [c000000059f8a8d0] c0000000000cba78 .__getblk+0x130/0x2d0
> > [c000000059f8a980] c0000000000ce1e0 .__bread+0x20/0x124
> > [c000000059f8aa10] c000000000166280 .ext3_get_branch+0xa4/0x158
> > [c000000059f8aac0] c000000000166620 .ext3_get_blocks_handle+0xf8/0xcf0
> > [c000000059f8aca0] c0000000001675cc .ext3_get_block+0x104/0x14c
> > [c000000059f8ad50] c0000000000cef64 .block_read_full_page+0x12c/0x390
> > [c000000059f8b220] c0000000000f81bc .do_mpage_readpage+0x5cc/0x63c
> > [c000000059f8b720] c0000000000f882c .mpage_readpages+0xf0/0x1b4
> > [c000000059f8b8c0] c000000000166450 .ext3_readpages+0x28/0x40
> > [c000000059f8b940] c0000000000a3c10 
.__do_page_cache_readahead+0x194/0x2f0
> > [c000000059f8ba90] c00000000009e01c .filemap_nopage+0x168/0x460
> > [c000000059f8bb60] c0000000000ace18 .__handle_mm_fault+0x544/0xee4
> > [c000000059f8bc50] c00000000002db24 .do_page_fault+0x408/0x5e8
> > [c000000059f8be30] c0000000000048e0 .handle_page_fault+0x20/0x54
> 
> Which indicates that a CPU is stuck in page reclaim.
> 
> As a memory management/VM problem is suspected, a sysrq-M trace would be
> useful.  That'll tell us whether the machine has exhausted physical 
memory
> and/or swapspace.
> 
I can not excute sysrq command now. But I can get memory allocation 
information from xmon, 
which indicates your guess may be right.

1:mon> mi
Mem-info:
DMA per-cpu:
cpu 0 hot: high 6, batch 1 used:5
cpu 0 cold: high 2, batch 1 used:1
cpu 1 hot: high 6, batch 1 used:5
cpu 1 cold: high 2, batch 1 used:1
cpu 2 hot: high 6, batch 1 used:5
cpu 2 cold: high 2, batch 1 used:1
cpu 3 hot: high 6, batch 1 used:3
cpu 3 cold: high 2, batch 1 used:1
cpu 4 hot: high 6, batch 1 used:5
cpu 4 cold: high 2, batch 1 used:1
cpu 5 hot: high 6, batch 1 used:4
cpu 5 cold: high 2, batch 1 used:0
DMA32 per-cpu: empty
Normal per-cpu: empty
HighMem per-cpu: empty
Free pages:        6976kB (0kB HighMem)
Active:6141 inactive:11012 dirty:4742 writeback:0 unstable:0 free:109 
slab:11925 mapped:7 pagetables:7061
DMA free:6976kB min:5760kB low:7168kB high:8640kB active:393024kB 
inactive:704768kB present:2097152kB pages_scanned:5172 all_unreclaimable? 
no
lowmem_reserve[]: 0 0 0 0
DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB 
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB 
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
HighMem free:0kB min:2048kB low:2048kB high:2048kB active:0kB inactive:0kB 
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
DMA: 19*64kB 1*128kB 2*256kB 0*512kB 1*1024kB 0*2048kB 1*4096kB 0*8192kB 
0*16384kB = 6976kB
DMA32: empty
Normal: empty
HighMem: empty
Swap cache: add 439156, delete 439156, find 50391/101032, race 26+79
Free swap  = 0kB
Total swap = 855552kB
Free swap:            0kB
32768 pages of RAM
408 reserved pages
6834 pages shared
0 pages swap cached
 

