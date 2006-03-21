Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751793AbWCUPxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793AbWCUPxm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 10:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbWCUPxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 10:53:42 -0500
Received: from uproxy.gmail.com ([66.249.92.199]:36453 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751793AbWCUPxm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 10:53:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qej9yeUpHRbhqgr6RQ/pBjlVy2a+8T94MSRLwGNCMNxQb0U375alL9E8YzyY/96Bd+W80ZDY9dRv5R48PCA60ymQ/6f7bL2Js2oRGWTr6VwrE2TS6eK/fhW/6v3wPnVscHrOfG6Aiu91KQMmrWmDhIcIq6cNx+ufmCTA7OC3eUE=
Message-ID: <bc56f2f0603210753k758ebf6dq@mail.gmail.com>
Date: Tue, 21 Mar 2006 10:53:40 -0500
From: "Stone Wang" <pwstone@gmail.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH][8/8] mm: lru interface change
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <441FF007.6020901@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <bc56f2f0603200538g3d6aa712i@mail.gmail.com>
	 <441FF007.6020901@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I may have missed something very trivial, but... why are they on a
> list at all if they don't get scanned

Get the locked pages on a list is necessary for page management,
scatter the locked pages around isnt a good idea.

Also, we could add some kinds of scan to the locked pages,
if we find that it's necessary.


Shaoping Wang

2006/3/21, Nick Piggin <nickpiggin@yahoo.com.au>:
> Stone Wang wrote:
> > Add Wired list to LRU.
> > Add PG_Wired bit to page.
> >
>
> I may have missed something very trivial, but... why are they on a
> list at all if they don't get scanned?
>
>
> > diff -urN  linux-2.6.15.orig/mm/swap.c linux-2.6.15/mm/swap.c
> > --- linux-2.6.15.orig/mm/swap.c       2006-01-02 22:21:10.000000000 -0500
> > +++ linux-2.6.15/mm/swap.c    2006-03-07 11:45:37.000000000 -0500
> > @@ -110,6 +110,44 @@
> >       spin_unlock_irq(&zone->lru_lock);
> >  }
> >
> > +/* Wire the page; if the page is in LRU,
> > + * try move it to Wired list.
> > + */
> > +void fastcall wire_page(struct page *page)
>
> Ahh, here's the elusive beast.
>
> > +{
> > +     struct zone *zone = page_zone(page);
> > +
> > +     spin_lock_irq(&zone->lru_lock);
>
> This is a fairly heavy lock for something which is going into page fault
> fastpaths and such. You might be better off making wired_count atomic and
> not using a lock in the common case if possible (even if it is only for
> mlocked pages, I'm sure someone will complain).
>
> > +     page->wired_count ++;
>
> Oh dear, I missed this change you made to struct page, tucked away in 5/8.
> This alone pretty much makes it a showstopper, I'm afraid. You'll have to
> work out some other way to do it so as not to penalise 99.999% of machines
> which don't need this.
>
> (Oh, and making the field a short usually won't help either, because of
> alignment constraints).
>
> > +     if(!PageWired(page)){
> > +             if(PageLRU(page)){
> > +                     del_page_from_lru(zone, page);
> > +                     add_page_to_wired_list(zone,page);
> > +                     SetPageWired(page);
> > +             }
> > +     }
> > +     spin_unlock_irq(&zone->lru_lock);
> > +}
> > +
> > +/* Unwire the page.
> > + * If it isnt wired by any process, try move it to active list.
> > + */
> > +void fastcall unwire_page(struct page *page)
> > +{
> > +     struct zone *zone = page_zone(page);
> > +
> > +     spin_lock_irq(&zone->lru_lock);
> > +     page->wired_count --;
> > +     if(!page->wired_count){
> > +             if(PageLRU(page) && TestClearPageWired(page)){
> > +                     del_page_from_wired_list(zone,page);
> > +                     add_page_to_active_list(zone,page);
> > +                     SetPageActive(page);
> > +             }
> > +     }
> > +     spin_unlock_irq(&zone->lru_lock);
> > +}
> > +
> >  /*
> >   * Mark a page as having seen activity.
> >   *
> > @@ -119,11 +157,13 @@
> >   */
> >  void fastcall mark_page_accessed(struct page *page)
> >  {
> > -     if (!PageActive(page) && PageReferenced(page) && PageLRU(page)) {
> > -             activate_page(page);
> > -             ClearPageReferenced(page);
> > -     } else if (!PageReferenced(page)) {
> > -             SetPageReferenced(page);
> > +     if(!PageWired(page)) {
> > +             if (!PageActive(page) && PageReferenced(page) && PageLRU(page)) {
> > +                     activate_page(page);
> > +                     ClearPageReferenced(page);
> > +             } else if (!PageReferenced(page)) {
> > +                     SetPageReferenced(page);
> > +             }
> >       }
> >  }
> >
>
> So, umm... what happens when the page gets wired before activate_page()?
>
> > @@ -178,13 +218,15 @@
> >       struct zone *zone = page_zone(page);
> >
> >       spin_lock_irqsave(&zone->lru_lock, flags);
> > -     if (TestClearPageLRU(page))
> > -             del_page_from_lru(zone, page);
> > -     if (page_count(page) != 0)
> > -             page = NULL;
> > +     if(!PageWired(page)) {
> > +             if (TestClearPageLRU(page))
> > +                     del_page_from_lru(zone, page);
> > +             if (page_count(page) != 0)
> > +                     page = NULL;
> > +             if (page)
> > +                     free_hot_page(page);
> > +     }
> >       spin_unlock_irqrestore(&zone->lru_lock, flags);
> > -     if (page)
> > -             free_hot_page(page);
> >  }
> >
>
> Hmm... how do PageWired pages get freed, then?
>
> >  EXPORT_SYMBOL(__page_cache_release);
> > @@ -214,7 +256,8 @@
> >
> >               if (!put_page_testzero(page))
> >                       continue;
> > -
> > +             if(PageWired(page))
> > +                     continue;
> >               pagezone = page_zone(page);
> >               if (pagezone != zone) {
> >                       if (zone)
>
> Ditto.
>
> --
> SUSE Labs, Novell Inc.
>
>
> Send instant messages to your online friends http://au.messenger.yahoo.com
>
>
