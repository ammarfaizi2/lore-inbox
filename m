Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263861AbTGAVbK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 17:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263897AbTGAVbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 17:31:10 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:26517 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S263861AbTGAVbG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 17:31:06 -0400
Date: Tue, 1 Jul 2003 22:45:29 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What to expect with the 2.6 VM
In-Reply-To: <20030701032531.GC20413@holomorphy.com>
Message-ID: <Pine.LNX.4.53.0307012243030.16265@skynet>
References: <Pine.LNX.4.53.0307010238210.22576@skynet>
 <20030701022516.GL3040@dualathlon.random> <20030701032531.GC20413@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jun 2003, William Lee Irwin III wrote:

> On Tue, Jul 01, 2003 at 02:39:47AM +0100, Mel Gorman wrote:
> >>    Delayed Coalescing
> >>    ==================
> >>    2.6 extends the buddy algorithm to resemble a lazy buddy algorithm [BL89]
> >>    which delays the splitting and coalescing of buddies until it is
> >>    necessary. The delay is implemented only for 0 order allocations with the
>

On delayed coalescing, I was seeing things that weren't there. I've this
section removed and changed to;

--Begin Extract--
   Per-CPU Page Lists
   ==================

   The most frequent type of allocation or free is an order-0 (i.e. one page)
   allocation or free. In 2.4, each page allocation or free requires the
   acquisition of an interrupt safe spinlock to protect the lists of free
   pages which is an expensive operation. To reduce lock contention, kernel
   2.6 has per-cpu page lists of order-0 pages called pagesets.

   These pagesets contain two lists for hot and cold pages where hot pages
   have been recently used and can still be expected to be present in the CPU
   cache. For an allocation, the pageset for the running CPU will be first
   checked and if pages are available, they will be allocated. To determine
   when the pageset should be emptied or filled, two watermarks are in place.
   When the low watermark is reached, a batch of pages will be allocated and
   placed on the list. When the high watermark is reached, a batch of pages
   will be freed at the same time. Higher order allocations still require the
   interrupt safe spinlock to be held and there is no delay in the splits or
   coalescing.

   While coalescing of order-0 pages is delayed, this is not a lazy buddy
   algorithm [BL89]. While pagesets introduce a merging delay for order-0
   allocations, it is a side-effect rather than an intended feature and there
   is no method available to drain the pagesets and merge the buddies. In
   other words, despite the per-cpu and new accounting code bulking up the
   amount of code in mm/page_alloc.c, the core of the buddy algorithm remains
   the same as it was in 2.4.

   The implication of this change is straight forward; the number of times
   the spinlock protecting the buddy lists must be acquired is reduced.
   Higher order allocations are relatively rare in Linux so the optimisation
   is for the common case. This change will be noticeable on large number of
   CPU machines but will make little difference to single CPUs. There is some
   issues with the idea though although they are not considered a serious
   problem. The first item of note is that high order allocations may fail of
   many of the pagesets are just below the high watermark. The second is that
   when memory is low and the current CPU pageset is empty, an allocation may
   fail as there is no means of draining remote pagesets. The last problem is
   that buddies of newly freed pages may exist in other pagesets leading to
   possible fragmentation problems.
--End Extract
