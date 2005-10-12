Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932443AbVJLRVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbVJLRVX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 13:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932441AbVJLRVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 13:21:22 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:17858 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932440AbVJLRVV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 13:21:21 -0400
Date: Wed, 12 Oct 2005 18:21:04 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: mike kravetz <kravetz@us.ibm.com>
Cc: akpm@osdl.org, jschopp@austin.ibm.com, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH 5/8] Fragmentation Avoidance V17: 005_fallback
In-Reply-To: <20051012164353.GA9425@w-mikek2.ibm.com>
Message-ID: <Pine.LNX.4.58.0510121806550.9602@skynet>
References: <20051011151221.16178.67130.sendpatchset@skynet.csn.ul.ie>
 <20051011151246.16178.40148.sendpatchset@skynet.csn.ul.ie>
 <20051012164353.GA9425@w-mikek2.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Oct 2005, mike kravetz wrote:

> On Tue, Oct 11, 2005 at 04:12:47PM +0100, Mel Gorman wrote:
> > This patch implements fallback logic. In the event there is no 2^(MAX_ORDER-1)
> > blocks of pages left, this will help the system decide what list to use. The
> > highlights of the patch are;
> >
> > o Define a RCLM_FALLBACK type for fallbacks
> > o Use a percentage of each zone for fallbacks. When a reserved pool of pages
> >   is depleted, it will try and use RCLM_FALLBACK before using anything else.
> >   This greatly reduces the amount of fallbacks causing fragmentation without
> >   needing complex balancing algorithms
>
> I'm having a little trouble seeing how adding a new type (RCLM_FALLBACK)
> helps.

When a pool for allocations is depleted, it has to fallback to somewhere.
It will never be the case that the pools are just the right size and
balancing them would be *very* difficult. The RCLM_FALLBACK acts as a
buffer for fallbacks to give page reclaim a chance to free up pages in the
proper pools.

With stats enabled, you can see the fallback counts. Right now
inc_fallback_count() counts a "real" fallback when the requested pool and
RCLM_FALLBACK are depleted. If you alter inc_fallback_count() to always
count, you'll get an idea of how often RCLM_FALLBACK is used. Without the
fallback area, the strategy suffers pretty badly.

> Seems to me that pages put into the RCLM_FALLBACK area would have
> gone to the global free list and available to anyone.

Not quite, they would have gone to the pool they were first reserved as.
This could mean that the USERRCLM pool could end up with a lot of free
pages that kernel allocations then fallback to. This would make a mess of
the whole strategy.

> I must be missing
> something here.
>
> > +int fallback_allocs[RCLM_TYPES][RCLM_TYPES+1] = {
> > +	{RCLM_NORCLM,	RCLM_FALLBACK, RCLM_KERN,   RCLM_USER, RCLM_TYPES},
> > +	{RCLM_KERN,     RCLM_FALLBACK, RCLM_NORCLM, RCLM_USER, RCLM_TYPES},
> > +	{RCLM_USER,     RCLM_FALLBACK, RCLM_NORCLM, RCLM_KERN, RCLM_TYPES},
> > +	{RCLM_FALLBACK, RCLM_NORCLM,   RCLM_KERN,   RCLM_USER, RCLM_TYPES}
>
> Do you really need that last line?  Can an allocation of type RCLM_FALLBACK
> realy be made?
>

In reality, no and it would only happen if a caller had specified both
__GFP_USER and __GFP_KERNRCLM in the call to alloc_pages() or friends. It
makes *no* sense for someone to do this, but if they did, an oops would be
thrown during an interrupt. The alternative is to get rid of this last
element and put a BUG_ON() check before the spinlock is taken.

This way, a stupid caller will damage the fragmentation strategy (which is
bad). The alternative, the kernel will call BUG() (which is bad). The
question is, which is worse?

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
