Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319226AbSHUWT1>; Wed, 21 Aug 2002 18:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319227AbSHUWT1>; Wed, 21 Aug 2002 18:19:27 -0400
Received: from thales.mathematik.uni-ulm.de ([134.60.66.5]:64195 "HELO
	thales.mathematik.uni-ulm.de") by vger.kernel.org with SMTP
	id <S319226AbSHUWT0>; Wed, 21 Aug 2002 18:19:26 -0400
Message-ID: <20020821222333.21552.qmail@thales.mathematik.uni-ulm.de>
From: "Christian Ehrhardt" <ehrhardt@mathematik.uni-ulm.de>
Date: Thu, 22 Aug 2002 00:23:33 +0200
To: Andrew Morton <akpm@zip.com.au>
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
       Thomas Molina <tmolina@cox.net>
Subject: Re: Race in pagevec code
References: <20020821154535.11432.qmail@thales.mathematik.uni-ulm.de> <3D63D0DC.271B6130@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D63D0DC.271B6130@zip.com.au>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2002 at 10:41:48AM -0700, Andrew Morton wrote:
> Christian Ehrhardt wrote:
> > 
> > ...
> >       Both processors succeeded in bringing the page_count to zero,
> >       i.e. both processors will add the page to their own
> >       pages_to_free_list.
> 
> This is why __pagevec_release() has the refcount check inside the lock.
> If someone else grabbed a ref to the page (also inside the lock) via
> the LRU, __pagevec_release doesn't free it.

I saw this check but this doesn't help. There is no guarantee that this
other reference that someone grabbed is still beeing held at the time
where we do the check:
The problem is if this newly grabbed reference is again dropped BEFORE
the check for page_count == 0 but AFTER put_page_test_zero. In this
case there can be TWO execution paths the BOTH think that they dropped
the last reference, i.e. both call __free_pages_ok for the same page.
See?

> So the rule could be stated as: the page gets freed when there are
> no references to it, presence on the LRU counts as a reference,
> serialisation is via pagemap_lru_lock.

I assume you mean zone->lru_lock here, pagemap_lru_lock is gone
in 2.5.31+everything.gz. Besides this would possibly help if all accesses
to the page_count were protected by the lru_lock (I know we don't want
this). Relying on the lru_lock to protect certain "critical" accesses to
page_count against each other sounds dangerous to me.

> > I don't have a fix but I think the only real solution is to
> > increment the page count if a page is on a lru list. After all
> > this is a reference to the page.
> 
> One would think so, but that doesn't really change anything.

We'd need yet another kernel thread that removes pages with no other
references from the lru_list. I agree that this is probably not an
option. What we really want is to make the lru_cache reference a weak
reference to the page.

    regards   Christian

-- 
THAT'S ALL FOLKS!
