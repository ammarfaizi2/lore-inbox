Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319234AbSHUWum>; Wed, 21 Aug 2002 18:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319235AbSHUWum>; Wed, 21 Aug 2002 18:50:42 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:64523 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S319234AbSHUWul>; Wed, 21 Aug 2002 18:50:41 -0400
Message-ID: <3D6419B3.50356B8E@zip.com.au>
Date: Wed, 21 Aug 2002 15:52:35 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>
CC: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
       Thomas Molina <tmolina@cox.net>
Subject: Re: Race in pagevec code
References: <20020821154535.11432.qmail@thales.mathematik.uni-ulm.de> <3D63D0DC.271B6130@zip.com.au> <20020821222333.21552.qmail@thales.mathematik.uni-ulm.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Ehrhardt wrote:
> 
> On Wed, Aug 21, 2002 at 10:41:48AM -0700, Andrew Morton wrote:
> > Christian Ehrhardt wrote:
> > >
> > > ...
> > >       Both processors succeeded in bringing the page_count to zero,
> > >       i.e. both processors will add the page to their own
> > >       pages_to_free_list.
> >
> > This is why __pagevec_release() has the refcount check inside the lock.
> > If someone else grabbed a ref to the page (also inside the lock) via
> > the LRU, __pagevec_release doesn't free it.
> 
> I saw this check but this doesn't help. There is no guarantee that this
> other reference that someone grabbed is still beeing held at the time
> where we do the check:
> The problem is if this newly grabbed reference is again dropped BEFORE
> the check for page_count == 0 but AFTER put_page_test_zero. In this
> case there can be TWO execution paths the BOTH think that they dropped
> the last reference, i.e. both call __free_pages_ok for the same page.
> See?

shrink_cache() detects that, inside the lock, and puts the page back
if it has a zero refcount.

refill_inactive doesn't need to do that, because it calls page_cache_release(),
which should look like this:

void __page_cache_release(struct page *page)
{
        unsigned long flags;

        spin_lock_irqsave(&_pagemap_lru_lock, flags);
        if (TestClearPageLRU(page)) {
                if (PageActive(page))
                        del_page_from_active_list(page);
                else
                        del_page_from_inactive_list(page);
        }
        if (page_count(page) != 0)
                page = NULL;
        spin_unlock_irqrestore(&_pagemap_lru_lock, flags);
        if (page)
                __free_pages_ok(page, 0);
}

If the page count and non-LRUness are both seen inside the lock,
the page is freeable.

We do a similar thing with inodes, via atomic_dec_and_lock.

Despite the transformations, it's based on the 2.4 approach.  But you've
successfully worried me, and I'm not really sure it's right, and I'm
dead sure it's too hairy.  Something simpler-but-not-sucky is needed.
