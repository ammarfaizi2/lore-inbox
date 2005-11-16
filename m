Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030270AbVKPKmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030270AbVKPKmt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 05:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030271AbVKPKmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 05:42:49 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:33502 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1030270AbVKPKms (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 05:42:48 -0500
Date: Wed, 16 Nov 2005 10:42:31 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-mm@kvack.org, mingo@elte.hu, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au, lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH 3/5] Light Fragmentation Avoidance V20: 003_fragcore
In-Reply-To: <437A9AE5.8070001@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.58.0511161035010.29156@skynet>
References: <20051115164946.21980.2026.sendpatchset@skynet.csn.ul.ie>
 <20051115165002.21980.14423.sendpatchset@skynet.csn.ul.ie>
 <437A9AE5.8070001@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Nov 2005, KAMEZAWA Hiroyuki wrote:

> > +/* Remove an element from the buddy allocator from the fallback list */
> > +static struct page *__rmqueue_fallback(struct zone *zone, int order,
> > +    int alloctype)
>
> Should we avoid this fallback as much as possible ?

Avoiding fallback as much as possible is something I would push into a
zone approach that can be developer separetly to this. I want to give hard
guarantees in special zones about fallbacks and best effort everywhere
else with this. Taking complex steps to avoid tough fallbacks here hurts
the general path on a typical machine.

> I think this is a weak point of this approach.
>
> > +    /*
> > +     * If breaking a large block of pages, place the buddies
> > +     * on the preferred allocation list
> > +     */
> > +    if (unlikely(current_order >= MAX_ORDER / 2)) {
> > +    alloctype = !alloctype;
> > +    change_pageblock_type(zone, page);
> > +    area = &zone->free_area_lists[alloctype][current_order];
> > +    }
> Changing RCLM_NORCLM to RLCM_EASY is okay ??

Yes. If anything, it's the other way around one would be concerned about.
The anti-defrag approach just groups related allocations together as much
as possible. If the grouping is not possible without taking expensive
steps like balancing or reclaiming, it tries to steal the largest
possible block from the other list to reduce the chances that fallbacks
will occur in the near future.

> If so, I think adding similar code to free_pages_bulk() is better.
>

It's at allocation time if you know whether fallbacks are needed or not.
To do something similar at free, you are entering the realm of watermarks,
balances and tunables. As it is, the usemap tells __free_pages_bulk() what
free list pages should be going back to.

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
