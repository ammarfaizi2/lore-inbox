Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318155AbSHZTuH>; Mon, 26 Aug 2002 15:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318221AbSHZTuH>; Mon, 26 Aug 2002 15:50:07 -0400
Received: from dsl-213-023-020-192.arcor-ip.net ([213.23.20.192]:20411 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318155AbSHZTuG>;
	Mon, 26 Aug 2002 15:50:06 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: MM patches against 2.5.31
Date: Mon, 26 Aug 2002 21:34:19 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>,
       lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <3D644C70.6D100EA5@zip.com.au> <E17jO6g-0002XU-00@starship> <3D6A8082.3775C5AB@zip.com.au>
In-Reply-To: <3D6A8082.3775C5AB@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17jPcx-0002Yp-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 August 2002 21:24, Andrew Morton wrote:
> Daniel Phillips wrote:
> > On Monday 26 August 2002 17:29, Christian Ehrhardt wrote:
> > > On Mon, Aug 26, 2002 at 04:22:50PM +0200, Daniel Phillips wrote:
> > > > On Monday 26 August 2002 11:10, Christian Ehrhardt wrote:
> > > > > + * A special Problem is the lru lists. Presence on one of these lists
> > > > > + * does not increase the page count.
> > > >
> > > > Please remind me... why should it not?
> > >
> > > Pages that are only on the lru but not reference by anyone are of no
> > > use and we want to free them immediatly. If we leave them on the lru
> > > list with a page count of 1, someone else will have to walk the lru
> > > list and remove pages that are only on the lru.
> > 
> > I don't understand this argument.  Suppose lru list membership is worth a
> > page count of one.  Then anyone who finds a page by way of the lru list can
> > safely put_page_testzero and remove the page from the lru list.  Anyone who
> > finds a page by way of a page table can likewise put_page_testzero and clear
> > the pte, or remove the mapping and pass the page to Andrew's pagevec
> > machinery, which will eventually do the put_page_testzero.  Anyone who
> > removes a page from a radix tree will also do a put_page_testzero.  Exactly
> > one of those paths will result in the page count reaching zero, which tells
> > us nobody else holds a reference and it's time for __free_pages_ok.  The page
> > is thus freed immediately as soon as there are no more references to it, and
> > does not hang around on the lru list.
> > 
> > Nobody has to lock against the page count.  Each put_page_testzero caller
> > only locks the data structure from which it's removing the reference.
> > 
> > This seems so simple, what is the flaw?
> 
> The flaw is in doing the put_page_testzero() outside of any locking
> which would prevent other CPUs from finding and "rescuing" the zero-recount
> page.
> 
> CPUA:
> 	if (put_page_testzero()) {
> 		/* Here's the window */
> 		spin_lock(lru_lock);
> 		list_del(page->lru);

According to my assumption that lru list membership is (should be) worth one 
page count, if testzero triggers here the page is not on the lru.

> CPUB:
> 
> 	spin_lock(lru_lock);
> 	page = list_entry(lru);
> 	page_cache_get(page);	/* If this goes from 0->1, we die */

It can't.  You know that because you found the page on the lru, its count
must be at least one (again, according to assumption above).

> 	...
> 	page_cache_release(page);	/* double free */

I'd like to jump in and chase more solutions with you, but the above doesn't 
prove your point, so I'm not ready to reject this one yet.

-- 
Daniel
