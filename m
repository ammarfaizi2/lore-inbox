Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264023AbTGAVwy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 17:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264052AbTGAVwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 17:52:54 -0400
Received: from franka.aracnet.com ([216.99.193.44]:39395 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264023AbTGAVww
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 17:52:52 -0400
Date: Tue, 01 Jul 2003 15:06:52 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Mel Gorman <mel@csn.ul.ie>, William Lee Irwin III <wli@holomorphy.com>
cc: Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What to expect with the 2.6 VM
Message-ID: <4860000.1057097211@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.53.0307012243030.16265@skynet>
References: <Pine.LNX.4.53.0307010238210.22576@skynet><20030701022516.GL3040@dualathlon.random> <20030701032531.GC20413@holomorphy.com> <Pine.LNX.4.53.0307012243030.16265@skynet>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On delayed coalescing, I was seeing things that weren't there. I've this
> section removed and changed to;

Heh. I was wondering about that ...
 
> --Begin Extract--
>    Per-CPU Page Lists
>    ==================
> 
>    The most frequent type of allocation or free is an order-0 (i.e. one page)
>    allocation or free. In 2.4, each page allocation or free requires the
>    acquisition of an interrupt safe spinlock to protect the lists of free
>    pages which is an expensive operation. To reduce lock contention, kernel
>    2.6 has per-cpu page lists of order-0 pages called pagesets.
> 
>    These pagesets contain two lists for hot and cold pages where hot pages
>    have been recently used and can still be expected to be present in the CPU
>    cache. For an allocation, the pageset for the running CPU will be first
>    checked and if pages are available, they will be allocated. To determine
>    when the pageset should be emptied or filled, two watermarks are in place.
>    When the low watermark is reached, a batch of pages will be allocated and
>    placed on the list. When the high watermark is reached, a batch of pages
>    will be freed at the same time. Higher order allocations still require the
>    interrupt safe spinlock to be held and there is no delay in the splits or
>    coalescing.
> 
>    While coalescing of order-0 pages is delayed, this is not a lazy buddy
>    algorithm [BL89]. While pagesets introduce a merging delay for order-0
>    allocations, it is a side-effect rather than an intended feature and there
>    is no method available to drain the pagesets and merge the buddies. In
>    other words, despite the per-cpu and new accounting code bulking up the
>    amount of code in mm/page_alloc.c, the core of the buddy algorithm remains
>    the same as it was in 2.4.
> 
>    The implication of this change is straight forward; the number of times
>    the spinlock protecting the buddy lists must be acquired is reduced.
>    Higher order allocations are relatively rare in Linux so the optimisation
>    is for the common case. This change will be noticeable on large number of
>    CPU machines but will make little difference to single CPUs. There is some
>    issues with the idea though although they are not considered a serious
>    problem. The first item of note is that high order allocations may fail of
>    many of the pagesets are just below the high watermark. The second is that
>    when memory is low and the current CPU pageset is empty, an allocation may
>    fail as there is no means of draining remote pagesets. The last problem is
>    that buddies of newly freed pages may exist in other pagesets leading to
>    possible fragmentation problems.


Looks good. Might be useful to distinguish more carefully between the hot
and cold lists - what you've described is basically just the cold list.

The hot list is similar, except it's also used as a LIFO stack, so the
the most recently freed page is assumed to be cache-warm, and is reallocated
first. This reduces the overall number of cacheline misses in the system,
by reusing cachelines that are already present in that CPU's cache.

Moreover, the cold list tries to use pages that are NOT in another CPUs
cache. The main thing that allocates from the cold list is DMA operations,
and the main thing that populates it is page-reclaim. Other things are
generally assumed to be hot (this is one of the areas where more work
could probably be done ...)

M.


M.
