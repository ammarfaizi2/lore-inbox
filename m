Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293203AbSHZXnZ>; Mon, 26 Aug 2002 19:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310190AbSHZXnY>; Mon, 26 Aug 2002 19:43:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11027 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293203AbSHZXnY>;
	Mon, 26 Aug 2002 19:43:24 -0400
Message-ID: <3D6AC0BB.FE65D5F7@zip.com.au>
Date: Mon, 26 Aug 2002 16:58:51 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ed Tomlinson <tomlins@cam.org>
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>,
       Daniel Phillips <phillips@arcor.de>
Subject: Re: MM patches against 2.5.31
References: <200208261809.45568.tomlins@cam.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson wrote:
> 
> This seems to have been missed:

Still thinking about it.

> Linus Torvalds wrote:
> 
> > In article <3D6989F7.9ED1948A@zip.com.au>,
> > Andrew Morton  <akpm@zip.com.au> wrote:
> >>
> >>What I'm inclined to do there is to change __page_cache_release()
> >>to not attempt to free the page at all.  Just let it sit on the
> >>LRU until page reclaim encounters it.  With the anon-free-via-pagevec
> >>patch, very, very, very few pages actually get their final release in
> >>__page_cache_release() - zero on uniprocessor, I expect.
> >
> > If you do this, then I would personally suggest a conceptually different
> > approach: make the LRU list count towards the page count.  That will
> > _automatically_ result in what you describe - if a page is on the LRU
> > list, then "freeing" it will always just decrement the count, and the
> > _real_ free comes from walking the LRU list and considering count==1 to
> > be trivially freeable.
> >
> > That way you don't have to have separate functions for releasing
> > different kinds of pages (we've seen how nasty that was from a
> > maintainance standpoint already with the "put_page vs
> > page_cache_release" thing).
> >
> > Ehh?
> 
> If every structure locks before removing its reference (ie before testing and/or
> removing a lru reference we take zone->lru_lock, for slabs take cachep->spinlock
> etc)  Its a bit of an audit task to make sure the various locks are taken (and
> documented) though.
> 
> By leting the actual free be lazy as Linus suggests things should simplify nicely.

Well we wouldn't want to leave tons of free pages on the LRU - the
VM would needlessly reclaim pagecache before finding the free pages.  And
higher-order page allocations could suffer.

If we go for explicit lru removal in truncate and zap_pte_range
then this approach may be best.  Still thinking about it.
