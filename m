Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266073AbRF1SCZ>; Thu, 28 Jun 2001 14:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266072AbRF1SCP>; Thu, 28 Jun 2001 14:02:15 -0400
Received: from Morgoth.esiway.net ([193.194.16.157]:23301 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S266071AbRF1SCB>; Thu, 28 Jun 2001 14:02:01 -0400
Date: Thu, 28 Jun 2001 20:01:58 +0200 (CEST)
From: Marco Colombo <marco@esi.it>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: <mike_phillips@urscorp.com>, <linux-kernel@vger.kernel.org>
Subject: Re: VM Requirement Document - v0.0
In-Reply-To: <01062816393503.00419@starship>
Message-ID: <Pine.LNX.4.33.0106281723490.4236-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jun 2001, Daniel Phillips wrote:

> On Thursday 28 June 2001 14:20, mike_phillips@urscorp.com wrote:
> > > If individual pages could be classified as code (text segments),
> > > data, file cache, and so on, I would specify costs to the paging
> > > of such pages in or out.  This way I can make the system perfer
> > > to drop a file cache page that has not been accessed for five
> > > minutes, over a program text page that has not been acccessed
> > > for one hour (or much more).
> >
> > This would be extremely useful. My laptop has 256mb of ram, but every day
> > it runs the updatedb for locate. This fills the memory with the file
> > cache. Interactivity is then terrible, and swap is unnecessarily used. On
> > the laptop all this hard drive thrashing is bad news for battery life
> > (plus the fact that laptop hard drives are not the fastest around). I
> > purposely do not run more applications than can comfortably fit in the
> > 256mb of memory.
> >
> > If fact, to get interactivity back, I've got a small 10 liner that mallocs
> > memory to *force* stuff into swap purely so I can have a large block of
> > memory back for interactivity.
> >
> > Something simple that did "you haven't used this file for 30mins, flush it
> > out of the cache would be sufficient"
>
> Updatedb fills memory full of clean file pages so there's nothing to flush.
> Did you mean "evict"?

Well, I believe all inodes get dirtied for access time update, unless the
FS is mounted no_atime. And it does write its database file...

> Roughly speaking we treat clean pages as "instantly relaimable".  Eviction
> and reclaiming are done in the same step (look at reclaim_page).  The key to
> efficient mm is nothing more or less than choosing the best victim for
> reclaiming and we aren't doing a spectacularly good job of that right now.
>
> There is a simple change in strategy that will fix up the updatedb case quite
> nicely, it goes something like this: a single access to a page (e.g., reading
> it) isn't enough to bring it to the front of the LRU queue, but accessing it
> twice or more is.  This is being looked at.

You mean that pages that belong to interactive applications (working sets)
won't be evicted to make room for the cache? And that pages just filled
with data read by updatedb will be chosen instead (a kind of drop-behind)?

There's nothing really wrong in the kernel "swapping out" interactive
applications at 4 a.m., their pages have the property of both not being
accessed recently and (the kernel doesn't know, of course) not going to
be useful in the near future (say for another 4 hours). In the end they
*are* good canditates for eviction.

> Note that we don't actually use a LRU queue, we use a more efficient
> approximation called aging, so the above is not a recipe for implementation.

I'm not sure that, in general, recent pages with only one access are
still better eviction candidates compared to 8 hours old pages. Here we
need either another way to detect one-shot activity (like the one
performed by updatedb), or to keep pages that belong to the working set
of interactive processes somewhat "warm", and never let them age too much.
A page with one one (read) access can be "cold". A page with more than one
access becomes "hot". Aging moves page towards the "cold" state, and of
course "cold" pages are the best candidates for eviction. Pages belonging
to interactive processes are never moved from the "warm" state into
the "cold" state by the background aging. Maybe this can be implemented
just leaving such pages on the active list, and deactivating them
only on pressure. Or not leaving their age reach 0. (Well, i'm not really
into current VM implementation. I guess that those single access pages
will be placed on the end of the active list with age 0, or something
like that).

If I understand the current VM code, after 8 hours of idle time, all
pages of interactive applications will be on the inactive(_clean?) list,
ready for eviction. Even if you place new pages (the updatedb activity)
at the *end* of the active list, (instead of the front), it won't be
enough to prevent application pages from being evicted. It won't solve
Mike's problem, that is.

>
> --
> Daniel
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

.TM.
-- 
      ____/  ____/   /
     /      /       /			Marco Colombo
    ___/  ___  /   /		      Technical Manager
   /          /   /			 ESI s.r.l.
 _____/ _____/  _/		       Colombo@ESI.it



