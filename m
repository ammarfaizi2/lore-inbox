Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273483AbRIQFMs>; Mon, 17 Sep 2001 01:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273484AbRIQFMi>; Mon, 17 Sep 2001 01:12:38 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:50049 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S273483AbRIQFMa>; Mon, 17 Sep 2001 01:12:30 -0400
Date: Mon, 17 Sep 2001 01:11:58 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org
Subject: Re: broken VM in 2.4.10-pre9
Message-ID: <20010917011157.A22989@cs.cmu.edu>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010917003422Z16197-2757+375@humbolt.nl.linux.org> <Pine.LNX.4.33.0109161738110.1054-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109161738110.1054-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.20i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 16, 2001 at 06:07:34PM -0700, Linus Torvalds wrote:
> See how 2.4.10-pre10 doesn't have any use_once hackery at all, but instead
> has a clear path on references:
> 
>  prefetching: non-referenced page on inactive list
>  after 1st reference: refrenced page on inactive list
>  after 2nd reference: non-referenced page on active list
>  after 3rd and subsequent accesses: referenced page on active list

So it ends up using a 'used_thrice' hack. Yeah, that does solve some of
the used once problems ;)

>  - COW issue mentioned above. Probably trivially fixed by something like

The COW is triggered by a pagefault, so the page will be accessed and
the hardware bits (both accessed and dirty) should get set automatically.

>  - truly anonymous pages (ie before they've been added to the swap cache)
>    are not necessarily going to behave as nicely as other pages. They

I just found a simple example that none of the 2.4.x kernels really like
that much. Create a program that malloc's the available free memory
minus 5-10MB, memset's it to page the memory in as anonymous pages and
then goes to sleep. Then run something like a kernel compile. If there
is enough memory left to catch the allocation spikes to avoid swapping,
the system will be heavily paging with the small amount of "aged memory"
that is left over to work with.

>    but that's a bit too subtle for my taste. If anybody wants to look into
>    this, I'd love to know if it makes a difference in behaviour, though..

pre10 right after booting,
    MemTotal:       127104 kB
    MemFree:         41844 kB
    Active:          11632 kB
    Inact_dirty:     19148 kB
    Inact_clean:         0 kB
    Inact_target:     1004 kB

pre9 with Rik's reverse mapping & delayed swap allocation and my local hacks,
    MemTotal:       126976 kB
    MemFree:         41244 kB
    Active:          80032 kB
    Inact_dirty:         0 kB
    Inact_clean:         0 kB
    Inact_target:      984 kB

Inactive target is interesting, because it is directly related to the
amount of memory pressure we've seen (memory_pressure >> 6). Also as
we're still far from running low on free memory, nothing was pushed into
the inactive lists (yes, there is no used_once, or used_thrice stuff at
all). While pre10 has about 50 MB that is 'lost' to anonymous pages
which don't get aged until we start swapping things out.

Differences are definitely noticeable, but I'm almost sure that is
mostly related to the fact that we have all potentially pageable or
swappable memory on the lists.

>  - I don't like the lack of aging in 'reclaim_page()'. It will walk the
>    whole LRU list if required, which kind of defeats the purpose of having
>    reference bits and LRU on that list. The code _claims_ that it almost
>    always succeeds with the first page, but I don't see why it would. I
>    think that comment assumed that the inactive_clean list cannot have any
>    referenced pages, but that's never been true.

As far as I can understand the _original_ design on which the current VM
is based, aging only occurs to pages on the active 'ring', the inactive
lists are basically LRU-ordered victim caches. Pages are unmapped before
they go to the inactive_dirty list and buffers are flushed before they
can go to inactive_clean.

Ofcourse both the used_once changes and -pre10 sort of flushed these
designs down the toilet by putting mapped pages on the inactive_dirty
list and turning the active list into an LRU.

Jan

