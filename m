Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266263AbRHYIss>; Sat, 25 Aug 2001 04:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267520AbRHYIsj>; Sat, 25 Aug 2001 04:48:39 -0400
Received: from www.wen-online.de ([212.223.88.39]:40199 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S266263AbRHYIs2>;
	Sat, 25 Aug 2001 04:48:28 -0400
Date: Sat, 25 Aug 2001 10:48:22 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Roger Larsson <roger.larsson@norran.net>
cc: <linux-kernel@vger.kernel.org>, Stephan von Krawczynski <skraw@ithnet.com>
Subject: Re: [PATCH][RFC] simpler __alloc_pages{_limit}
In-Reply-To: <200108250055.f7P0tGh28170@mailg.telia.com>
Message-ID: <Pine.LNX.4.33.0108250946560.540-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Aug 2001, Roger Larsson wrote:

> Hi again,

Howdy,

> [two typos corrected from the version at linux-mm]
>
> I read through __alloc_pages again and found out that allocs with order > 0
> are not treated nicely.

But they shouldn't be treated _too_ nicely ;-)  IMHO, you should never
exaust the entire clean list trying to service a high order allocation.
These allocations can wait.

> To begin with if order > 0 then direct_reclaim will be false even if it is
> allowed to wait...
>
> This version allows "direct_reclaim" with order > 0 !
>
> How?
>
> Like we finally end up doing anyway...
> reclaiming pages and freeing.

Yes, and the way we currently do it endangers other allocations in
that the effect the high order allocation will have upon the zone is
not accounted for.  If we're at that point, servicing a high order
allocation, and you actually succeed in assembling that possibly BIG
chunk, you may deplete the zone and leave yourself in a situation where
you can't service an incoming burst of atomic allocations.  That makes
drivers that try fallback allocations happy, but can hurt like heck.
If the thing continues to fail, you're also in pain, because the entire
time you're reclaiming, you're eating cached data for possibly no gain.

> While adding this I thought why not always do it like this,
> even with order == 0?
> since it will allow for merging of pages to higher orders.
> Before returning a page that was not mergeable...
>
> Doing this - the code started to collaps...
> __alloc_pages_limit could suddenly handle all special cases!
> (with small functional differences)
>
> Comments?

 +        /* Always alloc via rmqueue */

That adds overhead to order 0 allocations.

MHO:

I think the easiest way to handle high order allocations is to do _low_
volume background reclamation if high order allocations might fail.  ie
put a little effort into keeping such allocations available, but don't
do massive effort.  Cache tends to lose it's value over time, so dumping
small quantities over time shouldn't hurt.  This would also have the
benefit of scanning the inactive lists even when there's little activity
so that list information (page accessed _yesterday_?) won't get stale.

I think it's ~fine to reclaim for up to say order 2, but beyond that, it
doesn't have any up side that I can see.. only down.

btw, I wonder why we don't do memory_pressure [+-]= 1 << order.

	-Mike

