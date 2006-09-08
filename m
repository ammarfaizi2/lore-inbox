Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752034AbWIHCOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752034AbWIHCOs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 22:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752035AbWIHCOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 22:14:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25558 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752034AbWIHCOr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 22:14:47 -0400
Date: Thu, 7 Sep 2006 19:14:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Shu Qing Yang <yangshuq@cn.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Problem] System hang when I run pounder and syscall test on
 kernel 2.6.18-rc5
Message-Id: <20060907191434.0682c7e4.akpm@osdl.org>
In-Reply-To: <OF9B5F5146.C2CBBAE0-ON482571E2.001911F0-482571E2.0018E74C@cn.ibm.com>
References: <OF9B5F5146.C2CBBAE0-ON482571E2.001911F0-482571E2.0018E74C@cn.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Sep 2006 12:35:09 +0800
Shu Qing Yang <yangshuq@cn.ibm.com> wrote:

> Problem description:
>     I run pounder, scsi_debug on a machine. Then start 200 random syscall 
> test 
> simultaneously. Tens of minutes later, the system hang.

What is "pounder" and from where can it be obtained?

Running two tests at the same time complicates things.  The next step
should be to determine whether it is reproducible.  If it is, then see if
it is reproducible with just one test running (presumably pounder?)

It would be helpful to provide sufficient information to give others a
chance of reproducing it: amount of memory, method for configuring the
scsi-debug "disks", method for invoking pounder, etc.

> Hardware Environment
>     Cpu type :power5+
> Software Env:
>     kernel: 2.6.18-rc5
>     Base system: opensuse10
> 
> Is the system (not just the application) hung?
>     Yes
> 
> Did the system produce an OOPS message on the console?
>     No.
> 
> Is the system sitting in a debugger right now?
>     Yes, xmon and sysrq are on.
> 
> Additional information:
>     I use 'sysrq + t' then force system into xmon. And get following 
> message:

Trace is a bit confusing.  Ben (who is being shy) thinks it's this:

> 0:mon> c1
> 1:mon> e
> cpu 0x1: Vector: 501 (Hardware Interrupt) at [c000000059f89ed0]
>     pc: c0000000000a4780: .release_pages+0xac/0x260
>     lr: c0000000000a5138: .__pagevec_release+0x28/0x48
>     sp: c000000059f8a150
>    msr: 8000000000009032
>   current = 0xc00000005f2b66b0
>   paca    = 0xc0000000006b4500
>     pid   = 16704, comm = shmctl01
> 1:mon> t
> [c000000059f8a280] c0000000000a5138 .__pagevec_release+0x28/0x48
> [c000000059f8a310] c0000000000a7074 .shrink_inactive_list+0x944/0xa0c
> [c000000059f8a580] c0000000000a7248 .shrink_zone+0x10c/0x168
> [c000000059f8a620] c0000000000a7fe8 .try_to_free_pages+0x1c8/0x320
> [c000000059f8a730] c0000000000a1954 .__alloc_pages+0x1ec/0x344
> [c000000059f8a820] c00000000009de34 .find_or_create_page+0x8c/0x10c
> [c000000059f8a8d0] c0000000000cba78 .__getblk+0x130/0x2d0
> [c000000059f8a980] c0000000000ce1e0 .__bread+0x20/0x124
> [c000000059f8aa10] c000000000166280 .ext3_get_branch+0xa4/0x158
> [c000000059f8aac0] c000000000166620 .ext3_get_blocks_handle+0xf8/0xcf0
> [c000000059f8aca0] c0000000001675cc .ext3_get_block+0x104/0x14c
> [c000000059f8ad50] c0000000000cef64 .block_read_full_page+0x12c/0x390
> [c000000059f8b220] c0000000000f81bc .do_mpage_readpage+0x5cc/0x63c
> [c000000059f8b720] c0000000000f882c .mpage_readpages+0xf0/0x1b4
> [c000000059f8b8c0] c000000000166450 .ext3_readpages+0x28/0x40
> [c000000059f8b940] c0000000000a3c10 .__do_page_cache_readahead+0x194/0x2f0
> [c000000059f8ba90] c00000000009e01c .filemap_nopage+0x168/0x460
> [c000000059f8bb60] c0000000000ace18 .__handle_mm_fault+0x544/0xee4
> [c000000059f8bc50] c00000000002db24 .do_page_fault+0x408/0x5e8
> [c000000059f8be30] c0000000000048e0 .handle_page_fault+0x20/0x54

Which indicates that a CPU is stuck in page reclaim.

As a memory management/VM problem is suspected, a sysrq-M trace would be
useful.  That'll tell us whether the machine has exhausted physical memory
and/or swapspace.


