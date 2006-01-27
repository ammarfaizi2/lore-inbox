Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751556AbWA0Wj6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556AbWA0Wj6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 17:39:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751576AbWA0Wj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 17:39:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:29930 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751556AbWA0Wj6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 17:39:58 -0500
Subject: Re: iommu_alloc failure and panic
From: Mark Haverkamp <markh@osdl.org>
To: Olof Johansson <olof@lixom.net>
Cc: "linuxppc64-dev@ozlabs.org" <linuxppc64-dev@ozlabs.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060127204022.GA26653@pb15.lixom.net>
References: <1138381060.11796.22.camel@markh3.pdx.osdl.net>
	 <20060127204022.GA26653@pb15.lixom.net>
Content-Type: text/plain
Date: Fri, 27 Jan 2006 14:39:50 -0800
Message-Id: <1138401590.11796.26.camel@markh3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-01-28 at 09:40 +1300, Olof Johansson wrote:
> Hi,
> 
> On Fri, Jan 27, 2006 at 08:57:40AM -0800, Mark Haverkamp wrote:
> > While running a disk test (bonnie++) I have been seeing iommu_alloc
> > failed messages in the syslog leading to a panic.   The machine that I
> 
> Hmm. The IOMMU code tries to be clever and not write on a cacheline
> that's already in use, to avoid invalidating cached entries on the I/O
> bridges.
> 
> Since a cache line is 128 bytes (16 entries), this means it advances
> that much on each allocation, and tries to allocate a new entry in the
> next block of 16. Essentially it is fragmenting the allocation space on
> purpose.
> 
> So far I haven't seen anyone else have problems with this. I'm
> suspecting that the SCSI probe code might map something per disk (or
> similar), such that there's alot of small allocations being done, each
> using up part of a line. once the end of the allocation space is
> reached, the allocator wraps to the beginning and starts walking again.
> 
> Since this greatly reduces the chance of allocating anything 16 pages or
> more, a part of the table (25%) is set aside and used for the large
> allocations. If an allocation in one section of the table (large/small)
> doesn't succeed, the other half is also searched.
> 
> Each allocation in your report is 10 entries, so that means that at
> least 7 must be taken on each line, since the allocation won't go to the
> large area by default.
> 
> Can you try this, just to confirm that this is what we're seeing?
> 
> 1. In iommu_setparms_lpar() in arch/powerpc/platforms/pseries/iommu.c,
> can you try changing it_blocksize from 16 to 1?

I tried this but I still see the iommu_alloc failures:

Jan 27 14:19:41 linux kernel: iommu_alloc failed, tbl c00000000263c480 vaddr c000000133b00000 npages 10
Jan 27 14:19:41 linux kernel: iommu_alloc failed, tbl c00000000263c480 vaddr c00000016e9ef000 npages 10
Jan 27 14:19:41 linux kernel: iommu_alloc failed, tbl c00000000263c480 vaddr c000000133b00000 npages 10
Jan 27 14:19:41 linux kernel: iommu_alloc failed, tbl c00000000263c480 vaddr c00000016e9ef000 npages 10
Jan 27 14:19:41 linux kernel: iommu_alloc failed, tbl c00000000263c480 vaddr c0000000f7970000 npages 10
Jan 27 14:19:41 linux kernel: iommu_alloc failed, tbl c00000000263c480 vaddr c00000013304f000 npages 10
Jan 27 14:19:41 linux kernel: iommu_alloc failed, tbl c00000000263c480 vaddr c00000016eb4a000 npages 10
Jan 27 14:19:41 linux kernel: iommu_alloc failed, tbl c00000000263c480 vaddr c00000017105b000 npages 10
Jan 27 14:19:41 linux kernel: iommu_alloc failed, tbl c00000000263c480 vaddr c00000016ec21000 npages 10
Jan 27 14:19:41 linux kernel: iommu_alloc failed, tbl c00000000263c480 vaddr c0000000b96c2000 npages 10
Jan 27 14:19:48 linux kernel: printk: 415 messages suppressed.
Jan 27 14:19:48 linux kernel: iommu_alloc failed, tbl c00000000263c480 vaddr c00000016d350000 npages 10
Jan 27 14:19:53 linux kernel: printk: 430 messages suppressed.
Jan 27 14:19:53 linux kernel: iommu_alloc failed, tbl c00000000263c480 vaddr c00000010a940000 npages 10
Jan 27 14:19:56 linux kernel: printk: 481 messages suppressed.
Jan 27 14:19:56 linux kernel: iommu_alloc failed, tbl c00000000263c480 vaddr c0000000a74d0000 npages 10
Jan 27 14:20:03 linux kernel: printk: 530 messages suppressed.
Jan 27 14:20:03 linux kernel: iommu_alloc failed, tbl c00000000263c480 vaddr c00000016036a000 npages 10
Jan 27 14:20:07 linux kernel: printk: 510 messages suppressed.
Jan 27 14:20:07 linux kernel: iommu_alloc failed, tbl c00000000263c480 vaddr c0000000971cc000 npages 10
Jan 27 14:20:11 linux kernel: printk: 482 messages suppressed.
Jan 27 14:20:11 linux kernel: iommu_alloc failed, tbl c00000000263c480 vaddr c000000167cae000 npages 10
Jan 27 14:20:16 linux kernel: printk: 381 messages suppressed.
Jan 27 14:20:16 linux kernel: iommu_alloc failed, tbl c00000000263c480 vaddr c00000011d384000 npages 10
Jan 27 14:20:21 linux kernel: printk: 776 messages suppressed.
Jan 27 14:20:21 linux kernel: iommu_alloc failed, tbl c00000000263c480 vaddr c00000015c942000 npages 10
Jan 27 14:20:26 linux kernel: printk: 643 messages suppressed.
Jan 27 14:20:26 linux kernel: iommu_alloc failed, tbl c00000000263c480 vaddr c000000148e22000 npages 10
Jan 27 14:20:31 linux kernel: printk: 455 messages suppressed.
Jan 27 14:20:31 linux kernel: iommu_alloc failed, tbl c00000000263c480 vaddr c000000128527000 npages 10
Jan 27 14:20:48 linux kernel: printk: 542 messages suppressed.
Jan 27 14:20:48 linux kernel: iommu_alloc failed, tbl c00000000263c480 vaddr c00000002f380000 npages 10
Jan 27 14:20:49 linux kernel: iommu_alloc failed, tbl c00000000263c480 vaddr c00000006ffad000 npages 10
Jan 27 14:20:49 linux kernel: iommu_alloc failed, tbl c00000000263c480 vaddr c00000006ffad000 npages 10
Jan 27 14:20:51 linux kernel: printk: 359 messages suppressed.
Jan 27 14:20:51 linux kernel: iommu_alloc failed, tbl c00000000263c480 vaddr c000000068db1000 npages 10

I would have thought that the npages would be 1 now.


Here is the console output.


Welcome to SUSE LINUX 10.0 (PPC) - Kernel 2.6.16-rc1-ppc64 (hvc0).


dev2-002 login: Oops: Kernel access of bad area, sig: 11 [#1]
SMP NR_CPUS=128 NUMA PSERIES LPAR 
Modules linked in: dm_round_robin dm_multipath lpfc scsi_transport_fc ipv6 parport_pc lp parport dm_mod sg st ipr firmware_class sd_mod scsi_mod
NIP: C00000000000F7D0 LR: C00000000000FA2C CTR: 0000000000000000
REGS: c0000001e7bb3940 TRAP: 0300   Not tainted  (2.6.16-rc1-ppc64)
MSR: 8000000000009032 <EE,ME,IR,DR>  CR: 24002048  XER: 00000018
DAR: C000000600711718, DSISR: 0000000040010000
TASK = c00000000764f040[179] 'kblockd/0' THREAD: c0000001e7bb0000 CPU: 0
GPR00: 0000000600000008 C0000001E7BB3BC0 C00000000070EE68 C0000001E7BB3DE0 
GPR04: C00000000764F040 00000000000002F0 0000000000080000 C00000000058C720 
GPR08: 0000000000000001 C0000001E7BB3D10 C000000000711710 C0000001E7BB0000 
GPR12: C0000001E7BB3720 C00000000055EB00 0000000000000000 0000000000000000 
GPR16: 0000000000000000 000000000197FD90 4000000001C00000 000000000197FD88 
GPR20: 000000000197FD98 C000000000503290 0000000000000060 0000000002103728 
GPR24: C00000000055EB00 0000000000000001 0000000000000000 C0000001E7BB3EE0 
GPR28: 0000000000000002 C0000001E7BB3DE0 C00000000764F040 C000000000079FC0 
NIP [C00000000000F7D0] .validate_sp+0x30/0xc0
LR [C00000000000FA2C] .show_stack+0xec/0x1d0
Call Trace:
[C0000001E7BB3BC0] [C00000000000FA18] .show_stack+0xd8/0x1d0 (unreliable)
[C0000001E7BB3C60] [C000000000433838] .schedule+0xd78/0xfb0
[C0000001E7BB3DE0] [C000000000079FC0] .worker_thread+0x1b0/0x1c0
Unable to handle kernel paging request for data at address 0xc000000600711718
Faulting instruction address: 0xc00000000000f7d0
Unable to handle kernel paging request for data at address 0xc00001800055ed30
Faulting instruction address: 0xc000000000056ec4


-- 
Mark Haverkamp <markh@osdl.org>

