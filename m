Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261520AbVAQXQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbVAQXQw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 18:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbVAQXOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 18:14:35 -0500
Received: from fujitsu0.fna.fujitsu.com ([192.240.0.5]:35488 "EHLO
	fujitsu0.fujitsu.com") by vger.kernel.org with ESMTP
	id S262710AbVAQXJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 18:09:23 -0500
Date: Mon, 17 Jan 2005 15:08:37 -0800
From: Yasunori Goto <ygoto@us.fujitsu.com>
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [RFC] Avoiding fragmentation through different allocator
Cc: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0501161613350.16492@skynet>
References: <20050115172317.3C0F.YGOTO@us.fujitsu.com> <Pine.LNX.4.58.0501161613350.16492@skynet>
Message-Id: <20050117114251.35B5.YGOTO@us.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.11.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > There are 2 types of memory hotplug.
> >
> > a)SMP machine case
> >   A some part of memory will be added and removed.
> >
> > b)NUMA machine case.
> >   Whole of a node will be able to remove and add.
> >   However, if a block of memory like DIMM is broken and disabled,
> >   Its close from a).
> >
> > How to know where is hotpluggable bank is platform/archtecture
> > dependent issue.
> >  ex) Asking to ACPI.
> >      Just node0 become unremovable, and other nodes are removable.
> >      etc...
> >
> 
> Is there an architecture-independant way of finding this out?

  No. At least, I have no idea. :-(


> > In current your patch, first attribute of all pages are NoRclm.
> > But if your patches has interface to decide where will be Rclm for
> > each arch/platform, it might be good.
> >
> 
> It doesn't have an API as such. In page_alloc.c, there is a function
> get_pageblock_type() that returns what type of allocation the block of
> memory is being used for. There is no guarentee there is only those type
> of allocations there though.

OK. I will write a patch of function to set it for some arch/platform.

> What's the current attidute for adding a new zone? I felt there would be
> resistence as a new zone would affect a lot of code paths and be yet
> another zone that needed balancing. For example, is there a HIGHMEM
> version of the ZONE_REMOVABLE or could normal and highmem be in this zone?

Yes. In my current patch of memory hotplug, Removable is like Highmem.
 ( <http://sourceforge.net/mailarchive/forum.php?forum_id=223>
     It is group B of "Hot Add patches for NUMA" )

I tried to make new removable zone which could be with normal and dma
before it. But, it needs too much work as you said. So, I gave up it.
I heard Matt-san has some ideas for it. So, I'm looking forward to 
see it.

> > I agree that dividing per-cpu caches is not good way.
> > But if Kernel-nonreclaimable allocation use its UserRclm pool,
> > its removable memory bank will be harder to remove suddenly.
> > Is it correct? If so, it is not good for memory hotplug.
> > Hmmmm.
> >
> 
> It is correct. However, this will only happen in low-memory conditions.
> For a kernel-nonreclaimable allocation to use the userrclm pool, three
> conditions have to be met;
> 
> 1. Kernel-nonreclaimable pool has no pages
> 2. There are no global 2^MAX_ORDER pages
> 3. Kern-reclaimable pool has no pages

I suppose if this patch have worked for one year,
unlucky case might occur. Probably, enterprise system will not
allow it. So, I will try disabling fallback for KernNoRclm.

Thanks.

-- 
Yasunori Goto <ygoto at us.fujitsu.com>


