Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271399AbRIGG3A>; Fri, 7 Sep 2001 02:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271520AbRIGG2v>; Fri, 7 Sep 2001 02:28:51 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:21002 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S271399AbRIGG2f>; Fri, 7 Sep 2001 02:28:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        riel@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Defragmentation proposal: preventative maintenance and cleanup [LONG]
Date: Fri, 7 Sep 2001 08:35:55 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
In-Reply-To: <20010906174422Z16127-26184+6@humbolt.nl.linux.org> <1383771457.999813677@[169.254.198.40]>
In-Reply-To: <1383771457.999813677@[169.254.198.40]>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010907062851Z16136-26184+30@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 6, 2001 11:01 pm, Alex Bligh - linux-kernel wrote:
> I thought I'd try coding this, then I thought better of it and so am asking
> people's opinions first. The following describes a mechanism to change the
> zone/buddy allocation system to minimize fragmentation before it happens,
> and then defragment post-facto.

Nice exposition and analysis, but see my wet-blanket comments below...

> [...]
>
> Causes of fragmentation
> =======================
> 
> Linux adopts a largely requestor-anonymous form of page allocation. Memory
> is divided into 3 zones, and page requesters can specify a list of suitable
> zones from which pages may be allocated, but beyond that, pages are
> allocated in a manner which does not distinguish between users of given
> pages.

It's a conscious goal to try to unify all sources of memory.  The three
zones that are there now are only there because they absolutely have to be.

> Thus pages allocated for packets in flight are likely to be intermingled
> with buffer pages, cache pages, code pages and data pages. Each of these
> different types of allocation has a different persistence over time. Some
> (for instance pages on the InactiveDirty list in an idle system) will
> persist indefinitely.
> 
> The buddy allocator will attempt (by looking at lowest order lists first)
> to allocate pages from fragmented areas first. Assuming pages are freed at
> random, this would act as a defragmentation process. However, if a system
> is taken to high utilization and back again to idle, the dispersion of
> persistent pages (for instance InactiveDirty pages) becomes great, and the
> buddy allocator performs poorly at coalescing blocks.

It becomes effectively useless.  The probability of all 8 pages of a given
8 page unit being free when only 1% of memory is free is (1/100)**8 =
1/(10**16).

> The situation is worsened by the understandable desire for simplicity in
> the VM system, which measures solely the number of pages free in different
> zones, as opposed their respective locations. It is possible (and has been
> observed) to have a system in a state with hardly any high order buddies on
> free area lists (thus where it would be impossible to make many atomic high
> order allocations), but copious easilly freeable RAM. This is in essence
> because no attempt is made to balance for different order free-lists, and
> shortage of entries on high-order free lists does not in itself cause
> memory pressure.
> 
> It is probably undesirable for the normal VM system to react to
> fragmentation in the same way it does to normal memory pressure. This would
> result in an unselective paging out / discarding of data, whereas an
> approach which selected pages to free which would be most likely to cause
> coalescence would be more useful. Further, it would be possible, by moving
> the data in physical pages, to move many types of page, without loss of
> in-memory data at all.

Moving pages sounds scary.  We already know how to evict pages, but moving
pages is a whole new mechanism.  We probably would not care about the "good"
data lost through eviction as opposed to moving fraction of pages we'd have
to evict to do the required defragmentation is tiny.

> Approaches to solution
> ======================

I'm going to confess that I don't understand your solution in detail yet,
however, I can see this complaint coming: the changes are too intrusive on
the existing kernel, and if that's what we had to do it would probably be
easier to just eliminate all high order allocations from the kernel.  I
already have heard some sentiment that the 0 order allocation failure
problems do not have to be solved, that they are really the fault of those
coders that used the feature in the first place.  I don't know about that,
I'd like to hear from the maintainers.  But I'm pretty sure that whatever
solution we come up with, it has to be very simple in implementation, and
have roughly zero impact on the rest of the kernel.

--
Daniel
