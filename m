Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316574AbSH0RFW>; Tue, 27 Aug 2002 13:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316578AbSH0RFW>; Tue, 27 Aug 2002 13:05:22 -0400
Received: from dsl-213-023-020-028.arcor-ip.net ([213.23.20.28]:64704 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316574AbSH0RFV>;
	Tue, 27 Aug 2002 13:05:21 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: "Christian Ehrhardt" <ehrhardt@mathematik.uni-ulm.de>
Subject: Re: MM patches against 2.5.31
Date: Tue, 27 Aug 2002 18:48:50 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <3D644C70.6D100EA5@zip.com.au> <E17jQB8-0002Zi-00@starship> <20020826205858.6612.qmail@thales.mathematik.uni-ulm.de>
In-Reply-To: <20020826205858.6612.qmail@thales.mathematik.uni-ulm.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17jjWN-0002fo-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 August 2002 22:58, Christian Ehrhardt wrote:
> On Mon, Aug 26, 2002 at 10:09:38PM +0200, Daniel Phillips wrote:
> > On Monday 26 August 2002 22:00, Christian Ehrhardt wrote:
> > > On Mon, Aug 26, 2002 at 07:56:52PM +0200, Daniel Phillips wrote:
> > > > On Monday 26 August 2002 17:29, Christian Ehrhardt wrote:
> > > > > On Mon, Aug 26, 2002 at 04:22:50PM +0200, Daniel Phillips wrote:
> > > > > > On Monday 26 August 2002 11:10, Christian Ehrhardt wrote:
> > > > > > > + * A special Problem is the lru lists. Presence on one of these lists
> > > > > > > + * does not increase the page count.
> > > > > > 
> > > > > > Please remind me... why should it not?
> > > > > 
> > > > > Pages that are only on the lru but not reference by anyone are of no
> > > > > use and we want to free them immediatly. If we leave them on the lru
> > > > > list with a page count of 1, someone else will have to walk the lru
> > > > > list and remove pages that are only on the lru.
> > > > 
> > > > I don't understand this argument.  Suppose lru list membership is worth a 
> > > > page count of one.  Then anyone who finds a page by way of the lru list can 
> > > 
> > > This does fix the double free problem but think of a typical anonymous
> > > page at exit. The page is on the lru list and there is one reference held
> > > by the pte. According to your scheme the pte reference would be freed
> > > (obviously due to the exit) but the page would remain on the lru list.
> > > However, there is no point in leaving the page on the lru list at all.
> > 
> > If you want the page off the lru list at that point (which you probably do)
> > then you take the lru lock and put_page_testzero.
> 
> Could you clarify what you mean with "at that point"? Especially how
> do you plan to test for "this point".  Besides it is illegal to use
> the page after put_page_testzero (unless put_page_testzero returns true).

> > > If you think about who is going to remove the page from the lru you'll
> > > see the problem.
> > 
> > Nope, still don't see it.  Whoever hits put_page_testzero frees the page,
> > secure in the knowlege that there are no other references to it.
> 
> Well yes, but we cannot remove the page from the lru atomatically
> at page_cache_release time if we follow your proposal. If you think we can,
> show me your implementation of page_cache_release and I'll show
> you where the races are (unless you do everything under the lru_lock
> of course).

void page_cache_release(struct page *page)
{
	spin_lock(&pagemap_lru_lock);
	if (PageLRU(page) && page_count(page) == 2) {
		__lru_cache_del(page);
		atomic_dec(&page->count);
	}
	spin_unlock(&pagemap_lru_lock);
	if (put_page_testzero(page))
		__free_pages_ok(page, 0);
}

This allows the following benign race, with initial page count = 3:

spin_lock(&pagemap_lru_lock);
if (PageLRU(page) && page_count(page) == 2) /* false */
spin_unlock(&pagemap_lru_lock);
						spin_lock(&pagemap_lru_lock);
						if (PageLRU(page) && page_count(page) == 2) /* false */
						spin_unlock(&pagemap_lru_lock);
						if (put_page_testzero(page))
							__free_pages_ok(page, 0);
if (put_page_testzero(page))
	__free_pages_ok(page, 0);

Neither holder of a page reference sees the count at 2, and so the page
is left on the lru with count = 1.  This won't happen often and such
pages will be recovered from the cold end of the list in due course.

The important question is: can this code ever remove a page from the lru
erroneously, leaving somebody holding a reference to a non-lru page?  In
other words, can the test PageLRU(page) && page_count(page) == 2 return
a false positive?  Well, when this test is true we can account for both
both references: the one we own, and the one the lru list owns.  Since
we hold the lru lock, the latter won't change.  Nobody else has the
right to increment the page count, since they must inherit that right
from somebody who holds a reference, and there are none.

We could also do this:

void page_cache_release(struct page *page)
{
	if (page_count(page) == 2) {
		spin_lock(&pagemap_lru_lock);
		if (PageLRU(page) && page_count(page) == 2) {
			__lru_cache_del(page);
			atomic_dec(&page->count);
		}
		spin_unlock(&pagemap_lru_lock);
	}
	if (put_page_testzero(page))
		__free_pages_ok(page, 0);
}

Which avoids taking the lru lock sometimes in exchange for widening the
hole through which pages can end up with count = 1 on the lru list.

Let's run this through your race detector and see what happens.

-- 
Daniel
