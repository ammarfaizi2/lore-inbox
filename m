Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286779AbRL1IUl>; Fri, 28 Dec 2001 03:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286782AbRL1IUa>; Fri, 28 Dec 2001 03:20:30 -0500
Received: from dsl-213-023-039-026.arcor-ip.net ([213.23.39.26]:47370 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S286779AbRL1IUP>;
	Fri, 28 Dec 2001 03:20:15 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Shaya Potter <spotter@cs.columbia.edu>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: replacing the page replacement algo.
Date: Fri, 28 Dec 2001 09:23:21 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0111190037550.4079-100000@imladris.surriel.com> <1006138361.605.12.camel@zaphod>
In-Reply-To: <1006138361.605.12.camel@zaphod>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16JsIX-00009S-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 19, 2001 03:51 am, Shaya Potter wrote:
> ok, but if what I'm interested in playing with right now is playing
> around with which pages get swapped out, and not with the actual
> reclamation procedure, is it ok to just play with swap_out and having it
> do the thing it does, and let the rest of the kernel behave as is, or
> will this cause problems?

No, it's quite a bit more complex than you imagine.  I'll do a *very quick* 
trip through it.

Swap_out and shrink_caches work together to decide which pages to evict.  The 
interaction is quite subtle.  Basically, swap_out scans through virtual 
memory doing one of two things to each page:

  - If the page was referenced, set the reference bit in the struct page
  - Otherwise unmap the page so that it can eventually be evicted

The rest of the work is done by shrink_caches.  It is concerned with two 
lists: an 'active' LRU list and a 'inactive' FIFO list, each of which is a 
list of struct page, i.e., descriptors of physical pages.  It also has to 
worry about some caches that aren't simple, replaceable pages.  All the 
following things are being done, more or less at the same time:

  - Move referenced pages from the tail of the active list to the head of the 
    active list (implements 'LRU' policy)

  - Move unreferenced pages from the tail of the active list to the head of 
    the inactive list (queue for eviction)

  - Move referenced pages from the tail of the inactive list to the head of
    the inactive list

  - Schedule dirty pages at the tail of the inactive list for writeout

  - Recover clean pages from the tail of the inactive list

  - Explicitly shrink the dcache, icache and dqcache as necessary by
    evicting objects from those caches in the hope of recovering pages
    from them.

You can think of the whole process as being roughly divided into two parts: 
virtual scanning (swap_out) and physical scanning (refill_inactive, 
shrink_cache).  The reason for dividing it this way is simple: the only way 
we can associate the hardware page-referenced bit with a physical page is by 
scanning all the page tables (the virtual scan).  I.e, there is no way to 
find that hardware bit, starting from a struct page, and we do need the 
information in that bit to decide which process pages should be evicted.

Some non-scanning events can occur that affect the page replacement process:

  - A page may be explicitly touched by file IO, which is another way for
    a page to move from the inactive to active list.

  - A process page that has been unmapped may be faulted back in before
    shrink_caches gets around to evicting it

These are two different kinds of 'rescue'.  The efficient operation of the 
replacement policy relies on such rescuing.

I hope you can see now that tweaking the page replacement policy is not a 
simple matter of playing with any single function.  All the parts I described 
work together in a complex dance.  I glossed over many important details as 
well, particularly the fact that you can't consider page eviction in 
isolation from page allocation.  I didn't even touch on zone balancing.

Good luck, have fun reading the code.  If you're ready to do serious work on 
the page replacement policy in less than 6 months you'll be doing very well.
You might want to head on over to www.kernelnewbies.org and have a read 
through some of the excellent background material there.

--
Daniel
