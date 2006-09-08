Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbWIHQxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWIHQxi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 12:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbWIHQxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 12:53:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33667 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750719AbWIHQxg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 12:53:36 -0400
Date: Fri, 8 Sep 2006 09:52:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Shu Qing Yang <yangshuq@cn.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Problem] System hang when I run pounder and syscall test on
 kernel 2.6.18-rc5
Message-Id: <20060908095241.cd3cb72d.akpm@osdl.org>
In-Reply-To: <OFDEF165C1.4EC97DB2-ON482571E3.003A211D-482571E3.003F7CC6@cn.ibm.com>
References: <20060907191434.0682c7e4.akpm@osdl.org>
	<OFDEF165C1.4EC97DB2-ON482571E3.003A211D-482571E3.003F7CC6@cn.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Sep 2006 19:36:40 +0800
Shu Qing Yang <yangshuq@cn.ibm.com> wrote:

> Andrew Morton <akpm@osdl.org> wrote on 2006-09-08 10:14:34:
> 
> > On Thu, 7 Sep 2006 12:35:09 +0800
> > Shu Qing Yang <yangshuq@cn.ibm.com> wrote:
> > 
> > > Problem description:
> > >     I run pounder, scsi_debug on a machine. Then start 200 random 
> syscall 
> > > test 
> > > simultaneously. Tens of minutes later, the system hang.
> > 
> > What is "pounder" and from where can it be obtained?
> > 
> Thanks for your reply.
> 
> Pounder is part of ltp and locate in LTPROOT/testcases/pounder21. 
> It is a suit of test cases including mem_alloc, random_syscall, bonnie++, 
> etc.

OK, thanks.

> > Running two tests at the same time complicates things.  The next step
> > should be to determine whether it is reproducible.  If it is, then see 
> if
> > it is reproducible with just one test running (presumably pounder?)
> > 
> Running multiple cases simultaneously is to stress kernel more. And 
> because of
> lack of machine resource I have no chance to reproduce it.
> 
> > It would be helpful to provide sufficient information to give others a
> > chance of reproducing it: amount of memory, method for configuring the
> > scsi-debug "disks", method for invoking pounder, etc.
> > 
> The machine belongs to IBM p-Series with power5+ cpu and 2GB memory.
> Run LTPROOT/testscript/ltp-scsi_debug.sh and 
> LTPROOT/testscript/pounder21/pounder directly.
> No extra parameters.   The command to load scsi_debug module is: 
> modprobe scsi_debug max_luns=2 num_tgts=2 add_host=2 dev_size_mb=20
> 
> ...
>
> I can not excute sysrq command now. But I can get memory allocation 
> information from xmon, 
> which indicates your guess may be right.
> 
> 1:mon> mi
> Mem-info:
> DMA per-cpu:
> cpu 0 hot: high 6, batch 1 used:5
> cpu 0 cold: high 2, batch 1 used:1
> cpu 1 hot: high 6, batch 1 used:5
> cpu 1 cold: high 2, batch 1 used:1
> cpu 2 hot: high 6, batch 1 used:5
> cpu 2 cold: high 2, batch 1 used:1
> cpu 3 hot: high 6, batch 1 used:3
> cpu 3 cold: high 2, batch 1 used:1
> cpu 4 hot: high 6, batch 1 used:5
> cpu 4 cold: high 2, batch 1 used:1
> cpu 5 hot: high 6, batch 1 used:4
> cpu 5 cold: high 2, batch 1 used:0
> DMA32 per-cpu: empty
> Normal per-cpu: empty
> HighMem per-cpu: empty
> Free pages:        6976kB (0kB HighMem)
> Active:6141 inactive:11012 dirty:4742 writeback:0 unstable:0 free:109 
> slab:11925 mapped:7 pagetables:7061
> DMA free:6976kB min:5760kB low:7168kB high:8640kB active:393024kB 
> inactive:704768kB present:2097152kB pages_scanned:5172 all_unreclaimable? 
> no
> lowmem_reserve[]: 0 0 0 0
> DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB 
> present:0kB pages_scanned:0 all_unreclaimable? no
> lowmem_reserve[]: 0 0 0 0
> Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB 
> present:0kB pages_scanned:0 all_unreclaimable? no
> lowmem_reserve[]: 0 0 0 0
> HighMem free:0kB min:2048kB low:2048kB high:2048kB active:0kB inactive:0kB 
> present:0kB pages_scanned:0 all_unreclaimable? no
> lowmem_reserve[]: 0 0 0 0
> DMA: 19*64kB 1*128kB 2*256kB 0*512kB 1*1024kB 0*2048kB 1*4096kB 0*8192kB 
> 0*16384kB = 6976kB
> DMA32: empty
> Normal: empty
> HighMem: empty
> Swap cache: add 439156, delete 439156, find 50391/101032, race 26+79
> Free swap  = 0kB
> Total swap = 855552kB
> Free swap:            0kB
> 32768 pages of RAM
> 408 reserved pages
> 6834 pages shared
> 0 pages swap cached

So we ran out of memory and we ran out of swap.

Possibly what has happened here is that the machine is doing a huge amount
of work scanning pages and pretty soon it will enter the oom-killer to kill
some userspace process.  But before that happened, the softlockup detector
triggered.

But the machine _should_ have recovered.  If it hung for more than a few
seconds then that's bad behaviour.  If it hung for more than a few minutes
then that should be considered a bug.  If it hung for ever then that's
definitely a bug.

Do you recall approximately how long the machine spent in this state?
