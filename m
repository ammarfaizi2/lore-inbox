Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261719AbVASNps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbVASNps (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 08:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbVASNps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 08:45:48 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:17889 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261719AbVASNpe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 08:45:34 -0500
Date: Wed, 19 Jan 2005 13:45:30 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Yasunori Goto <ygoto@us.fujitsu.com>
Cc: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Avoiding fragmentation through different allocator
In-Reply-To: <20050117114251.35B5.YGOTO@us.fujitsu.com>
Message-ID: <Pine.LNX.4.58.0501191336510.8296@skynet>
References: <20050115172317.3C0F.YGOTO@us.fujitsu.com>
 <Pine.LNX.4.58.0501161613350.16492@skynet> <20050117114251.35B5.YGOTO@us.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jan 2005, Yasunori Goto wrote:

> > Is there an architecture-independant way of finding this out?
>
>   No. At least, I have no idea. :-(
>

In another mail to Matthew, I suggested that the zone->free_area_usemap
could be used to track hotplug blocks of pages by either using a
bit-pattern of 11 for hotplug pages or adding a third bit.

get_pageblock_type() could then be taught to identify a hotplug region
within page_alloc.c at least. If the information is needed outside the
allocator, it will need more work though.

> > What's the current attidute for adding a new zone? I felt there would be
> > resistence as a new zone would affect a lot of code paths and be yet
> > another zone that needed balancing. For example, is there a HIGHMEM
> > version of the ZONE_REMOVABLE or could normal and highmem be in this zone?
>
> Yes. In my current patch of memory hotplug, Removable is like Highmem.
>  ( <http://sourceforge.net/mailarchive/forum.php?forum_id=223>
>      It is group B of "Hot Add patches for NUMA" )
>
> I tried to make new removable zone which could be with normal and dma
> before it. But, it needs too much work as you said. So, I gave up it.
> I heard Matt-san has some ideas for it. So, I'm looking forward to
> see it.
>

I'm taking a look through these patches just so I know what the other
approaches were.

> > > I agree that dividing per-cpu caches is not good way.
> > > But if Kernel-nonreclaimable allocation use its UserRclm pool,
> > > its removable memory bank will be harder to remove suddenly.
> > > Is it correct? If so, it is not good for memory hotplug.
> > > Hmmmm.
> > >
> >
> > It is correct. However, this will only happen in low-memory conditions.
> > For a kernel-nonreclaimable allocation to use the userrclm pool, three
> > conditions have to be met;
> >
> > 1. Kernel-nonreclaimable pool has no pages
> > 2. There are no global 2^MAX_ORDER pages
> > 3. Kern-reclaimable pool has no pages
>
> I suppose if this patch have worked for one year,
> unlucky case might occur. Probably, enterprise system will not
> allow it. So, I will try disabling fallback for KernNoRclm.
>

I can almost guarentee that will fail in low-memory conditions. Before I
implemented proper fallback logic, I used to get oopses in low-memory
conditions. I found it was because KernNoRclm had nowhere to fallback but
there was loads of free memory so kswapd was not taking place.

So, just disabling fallback is not the right answer.

-- 
Mel Gorman
