Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261513AbVAMKLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbVAMKLl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 05:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbVAMKLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 05:11:41 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:4057 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261513AbVAMKLb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 05:11:31 -0500
Date: Thu, 13 Jan 2005 10:11:30 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Avoiding fragmentation through different allocator
In-Reply-To: <20050113073146.GB1226@holomorphy.com>
Message-ID: <Pine.LNX.4.58.0501131002430.31154@skynet>
References: <Pine.LNX.4.58.0501122101420.13738@skynet> <20050113073146.GB1226@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jan 2005, William Lee Irwin III wrote:

> On Wed, Jan 12, 2005 at 09:09:24PM +0000, Mel Gorman wrote:
> > So... What the patch does. Allocations are divided up into three different
> > types of allocations;
> > UserReclaimable - These are userspace pages that are easily reclaimable. Right
> > 	now, I'm putting all allocations of GFP_USER and GFP_HIGHUSER as
> > 	well as disk-buffer pages into this category. These pages are trivially
> > 	reclaimed by writing the page out to swap or syncing with backing
> > 	storage
> > KernelReclaimable - These are pages allocated by the kernel that are easily
> > 	reclaimed. This is stuff like inode caches, dcache, buffer_heads etc.
> > 	These type of pages potentially could be reclaimed by dumping the
> > 	caches and reaping the slabs (drastic, but you get the idea). We could
> > 	also add pages into this category that are known to be only required
> > 	for a short time like buffers used with DMA
> > KernelNonReclaimable - These are pages that are allocated by the kernel that
> > 	are not trivially reclaimed. For example, the memory allocated for a
> > 	loaded module would be in this category. By default, allocations are
> > 	considered to be of this type
>
> I'd expect to do better with kernel/user discrimination only, having
> address-ordering biases in opposite directions for each case.
>

I thought about this and was not 100% sure. I'll explain how I see it
before I go redo large portions of the patch.

1. Discriminating kernel/user will leave the kernel area fragmented much
worse than my approach. On my systems I tested, I found that a significant
portion of kernel memory was taken up by slabs like buffer_head,
ext3_inode_cache, ntfs_inode_cache, ntfs_big_inode_cache and
radix_tree_node. I did not want to mix these allocations, which
potentially are easy to get rid of, with allocations that are incredibly
difficult.  (Totally aside, I also found that slab caches suffer from
terrible internal fragmentation, sometimes wasting up to 60% of their
memory but thats a separate problem)

2. Address-ordering biases was also something I looked at early on, but
then figured it didn't matter. If I don't reserve a 2^MAX_ORDER blocks,
the system will just get terribly fragmented under memory presure when
they meet in the middle. If I do reserve, I just end up with a similar
layout to what I have now.

-- 
Mel Gorman
