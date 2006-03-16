Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752026AbWCPBvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752026AbWCPBvK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 20:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752127AbWCPBvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 20:51:09 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:41400 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S1752026AbWCPBvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 20:51:08 -0500
X-IronPort-AV: i="4.02,196,1139212800"; 
   d="scan'208"; a="314722027:sNHT26322248"
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core driver
X-Message-Flag: Warning: May contain useful information
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain>
	<ada4q27fban.fsf@cisco.com>
	<1141948516.10693.55.camel@serpentine.pathscale.com>
	<ada1wxbdv7a.fsf@cisco.com>
	<1141949262.10693.69.camel@serpentine.pathscale.com>
	<20060309163740.0b589ea4.akpm@osdl.org>
	<1142470579.6994.78.camel@localhost.localdomain>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 15 Mar 2006 17:51:05 -0800
In-Reply-To: <1142470579.6994.78.camel@localhost.localdomain> (Bryan O'Sullivan's message of "Wed, 15 Mar 2006 16:56:19 -0800")
Message-ID: <ada3bhjuph2.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 16 Mar 2006 01:51:06.0935 (UTC) FILETIME=[17484C70:01C6489C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > The first two are windows onto the chip's MMIO space; we create mappings
 > for userspace in our mmap code using io_remap_pfn_range.
 > 
 > - General user-oriented chip registers.
 > 
 > - Chip PIO buffers.
 > 
 > We don't do any funnies with get_page/SetPageReserved (or the new
 > vm_insert_page) on these.  However, we turn on the VM_* flag christmas
 > tree, in a frenzied effort to make the kernel pay no attention:
 > VM_DONTCOPY | VM_DONTEXPAND | VM_IO | VM_SHM | VM_LOCKED.

I don't think you need to do anything beyond io_remap_pfn_range().
Look at the comment inside remap_pfn_range() in mm/memory.c.
You may want VM_DONTCOPY for fork() handling I guess.

 > The next three kinds or memory are allocated with dma_alloc_coherent
 > (first two) or pci_alloc_consistent (last).  We have a nopage handler
 > that knows how to deal with them.  We set the low two bits of
 > vma->vm_private_data to tell the nopage handler what kind of memory it
 > is dealing with.

As a side note, why do you use both dma_alloc_coherent() and
pci_alloc_consistent()?  Presumably all the allocations are for the
same underlying device, so why not just pick one interface (probably
dma_alloc_coherent(), since it lets you specify the GFP mask).

 > Once again, we sprinkle heaps of VM_* flags all over the freshly baked
 > mapping: VM_DONTEXPAND | VM_DONTCOPY | VM_RESERVED | VM_IO | VM_SHM

You probably want VM_RESERVED.  I don't think you want VM_IO (these
pages are in RAM), and there's not much point to VM_SHM, since it's
currently defined as:

#define VM_SHM          0x00000000      /* Means nothing: delete it later */

VM_DONTEXPAND is fine, although you could handle it in your NOPAGE
method too.  And VM_DONTCOPY is just as above -- it might make fork()
work better for you.

 > The nopage handler looks very normal, except it does a get_page on
 > pages marked with IPATH_VM_PIOAVAILREGS, but not on others.  Presumably
 > this is because they've had SetPageReserved set on them.

I think you should always be doing a get_page().  As far as I know,
there's always a put_page() when the userspace mapping is torn down,
and things are going to get pretty bad if a page count goes below 0.

 - R.
