Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317169AbSHZTJ1>; Mon, 26 Aug 2002 15:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317355AbSHZTJ1>; Mon, 26 Aug 2002 15:09:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28944 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317169AbSHZTJZ>;
	Mon, 26 Aug 2002 15:09:25 -0400
Message-ID: <3D6A8082.3775C5AB@zip.com.au>
Date: Mon, 26 Aug 2002 12:24:50 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>,
       lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: MM patches against 2.5.31
References: <3D644C70.6D100EA5@zip.com.au> <E17jKlX-0001i0-00@starship> <20020826152950.9929.qmail@thales.mathematik.uni-ulm.de> <E17jO6g-0002XU-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> On Monday 26 August 2002 17:29, Christian Ehrhardt wrote:
> > On Mon, Aug 26, 2002 at 04:22:50PM +0200, Daniel Phillips wrote:
> > > On Monday 26 August 2002 11:10, Christian Ehrhardt wrote:
> > > > + * A special Problem is the lru lists. Presence on one of these lists
> > > > + * does not increase the page count.
> > >
> > > Please remind me... why should it not?
> >
> > Pages that are only on the lru but not reference by anyone are of no
> > use and we want to free them immediatly. If we leave them on the lru
> > list with a page count of 1, someone else will have to walk the lru
> > list and remove pages that are only on the lru.
> 
> I don't understand this argument.  Suppose lru list membership is worth a
> page count of one.  Then anyone who finds a page by way of the lru list can
> safely put_page_testzero and remove the page from the lru list.  Anyone who
> finds a page by way of a page table can likewise put_page_testzero and clear
> the pte, or remove the mapping and pass the page to Andrew's pagevec
> machinery, which will eventually do the put_page_testzero.  Anyone who
> removes a page from a radix tree will also do a put_page_testzero.  Exactly
> one of those paths will result in the page count reaching zero, which tells
> us nobody else holds a reference and it's time for __free_pages_ok.  The page
> is thus freed immediately as soon as there are no more references to it, and
> does not hang around on the lru list.
> 
> Nobody has to lock against the page count.  Each put_page_testzero caller
> only locks the data structure from which it's removing the reference.
> 
> This seems so simple, what is the flaw?

The flaw is in doing the put_page_testzero() outside of any locking
which would prevent other CPUs from finding and "rescuing" the zero-recount
page.

CPUA:
	if (put_page_testzero()) {
		/* Here's the window */
		spin_lock(lru_lock);
		list_del(page->lru);

CPUB:

	spin_lock(lru_lock);
	page = list_entry(lru);
	page_cache_get(page);	/* If this goes from 0->1, we die */
	...
	page_cache_release(page);	/* double free */


2.5.31-mm1 has tests which make this race enormously improbable [1],
but it's still there.

It's that `put' outside the lock which is the culprit.  Normally, we
handle that with atomic_dec_and_lock() (inodes) or by manipulating
the refcount inside an area which has exclusion (page presence in
pagecache).

The sane, sensible and sucky way is to always take the lock:

page_cache_release(page)
{
	spin_lock(lru_lock);
	if (put_page_testzero(page)) {
		lru_cache_del(page);
		__free_pages_ok(page, 0);
	}
	spin_unlock(lru_lock);
}

Because this provides exclusion from another CPU discovering the page
via the LRU.

So taking the above as the design principle, how can we speed it up?
How to avoid taking the lock in every page_cache_release()?  Maybe:

page_cache_release(page)
{
	if (page_count(page) == 1) {
		spin_lock(lru_lock);
		if (put_page_testzero(page)) {
			if (PageLRU(page))
				__lru_cache_del(page);
			__free_pages_ok(page);
		}
		spin_unlock(lru_lock);
	} else {
		atomic_dec(&page->count);
	}
}

This is nice and quick, but racy.  Two concurrent page_cache_releases
will create a zero-ref unfreed page which is on the LRU.  These are
rare, and can be mopped up in page reclaim.

The above code will also work for pages which aren't on the LRU.  It will
take the lock unnecessarily for (say) slab pages.  But if we put slab pages
on the LRU then I suspect there are so few non-LRU pages left that it isn't
worth bothering about this.


[1] The race requires that the CPU running page_cache_release find a
    five instruction window against the CPU running shrink_cache.  And
    that they be operating against the same page.  And that the CPU
    running __page_cache_release() then take an interrupt in a 3-4
    instruction window.  And that the interrupt take longer than the
    runtime for shrink_list.  And that the page be the first page in
    the pagevec.

    It's a heat-death-of-the-universe-race, but even if it were to be
    ignored, the current code is too complex.
