Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750983AbVKARTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbVKARTk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 12:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbVKARTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 12:19:40 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:60114 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1750982AbVKARTj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 12:19:39 -0500
Date: Tue, 1 Nov 2005 17:19:35 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Ingo Molnar <mingo@elte.hu>, Dave Hansen <haveblue@us.ibm.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
In-Reply-To: <43679C69.6050107@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.58.0511011708000.14884@skynet>
References: <4366A8D1.7020507@yahoo.com.au> <Pine.LNX.4.58.0510312333240.29390@skynet>
 <4366C559.5090504@yahoo.com.au> <Pine.LNX.4.58.0511010137020.29390@skynet>
 <4366D469.2010202@yahoo.com.au> <Pine.LNX.4.58.0511011014060.14884@skynet>
 <20051101135651.GA8502@elte.hu> <1130854224.14475.60.camel@localhost>
 <20051101142959.GA9272@elte.hu> <1130856555.14475.77.camel@localhost>
 <20051101150142.GA10636@elte.hu> <43679C69.6050107@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Nov 2005, Kamezawa Hiroyuki wrote:

> Ingo Molnar wrote:
> > so it's all about expectations: _could_ you reasonably remove a piece of
> > RAM? Customer will say: "I have stopped all nonessential services, and free
> > RAM is at 90%, still I cannot remove that piece of faulty RAM, fix the
> > kernel!". No reasonable customer will say: "True, I have all RAM used up in
> > mlock()ed sections, but i want to remove some RAM nevertheless".
> >
> Hi, I'm one of men in -lhms
>
> In my understanding...
> - Memory Hotremove on IBM's LPAR? approach is
>   [remove some amount of memory from somewhere.]
>   For this approach, Mel's patch will work well.
>   But this will not guaranntee a user can remove specified range of
>   memory at any time because how memory range is used is not defined by an
> admin
>   but by the kernel automatically. But to extract some amount of memory,
>   Mel's patch is very important and they need this.
>
> My own target is NUMA node hotplug, what NUMA node hotplug want is
> - [remove the range of memory] For this approach, admin should define
>   *core* node and removable node. Memory on removable node is removable.
>   Dividing area into removable and not-removable is needed, because
>   we cannot allocate any kernel's object on removable area.
>   Removable area should be 100% removable. Customer can know the limitation
> before using.
>

In this case, we would want some mechanism that says "don't put awkward
pages in this NUMA node" in a clear way. One way we could do this is;

1. Move fallback_allocs to be per-node. fallback_allocs is currently
defined as
int fallback_allocs[RCLM_TYPES-1][RCLM_TYPES+1] = {
        {RCLM_NORCLM,   RCLM_FALLBACK, RCLM_KERN,   RCLM_EASY, RCLM_TYPES},
        {RCLM_EASY,     RCLM_FALLBACK, RCLM_NORCLM, RCLM_KERN, RCLM_TYPES},
        {RCLM_KERN,     RCLM_FALLBACK, RCLM_NORCLM, RCLM_EASY, RCLM_TYPES}
};

  The effect is that a RCLM_NORCLM allocation, falls back to
  RCLM_FALLBACK, RCLM_KERN, RCLM_EASY and then gives up.

2. Architectures would need to provide a function that allocates and
populates a fallback_allocs[][] array. If they do not provide one, a
generic function uses array like the one above

3. When adding a node that must be removable, make the array look like
this

int fallback_allocs[RCLM_TYPES-1][RCLM_TYPES+1] = {
        {RCLM_NORCLM,   RCLM_TYPES,    RCLM_TYPES,  RCLM_TYPES, RCLM_TYPES},
        {RCLM_EASY,     RCLM_FALLBACK, RCLM_NORCLM, RCLM_KERN, RCLM_TYPES},
        {RCLM_KERN,     RCLM_TYPES,    RCLM_TYPES,  RCLM_TYPES, RCLM_TYPES},
};

The effect of this is only allocations that are easily reclaimable will
end up in this node. This would be a straight-forward addition to build
upon this set of patches. The difference would only be visible to
architectures that cared.

> What I'm considering now is this:
> - removable area is hot-added area
> - not-removable area is memory which is visible to kernel at boot time.
> (I'd like to achieve this by the limitation : hot-added node goes into only
> ZONE_HIGHMEM)


ZONE_HIGHMEM can still end up with PTE pages if allocating PTE pages from
highmem is configured. This is bad. With the above approach, nodes that
are not hot-added that have a ZONE_HIGHMEM will be able to use it for PTEs
as well. But when a node is hot-added, it will have a ZONE_HIGHMEM that is
not used for PTE allocations because they are not RCLM_EASY allocations.

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
