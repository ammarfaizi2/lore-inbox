Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318812AbSH1NK2>; Wed, 28 Aug 2002 09:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318814AbSH1NK1>; Wed, 28 Aug 2002 09:10:27 -0400
Received: from thales.mathematik.uni-ulm.de ([134.60.66.5]:52874 "HELO
	thales.mathematik.uni-ulm.de") by vger.kernel.org with SMTP
	id <S318812AbSH1NKZ>; Wed, 28 Aug 2002 09:10:25 -0400
Message-ID: <20020828131445.25959.qmail@thales.mathematik.uni-ulm.de>
From: "Christian Ehrhardt" <ehrhardt@mathematik.uni-ulm.de>
Date: Wed, 28 Aug 2002 15:14:45 +0200
To: Daniel Phillips <phillips@arcor.de>
Cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: MM patches against 2.5.31
References: <3D644C70.6D100EA5@zip.com.au> <E17jQB8-0002Zi-00@starship> <20020826205858.6612.qmail@thales.mathematik.uni-ulm.de> <E17jjWN-0002fo-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17jjWN-0002fo-00@starship>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2002 at 06:48:50PM +0200, Daniel Phillips wrote:
> On Monday 26 August 2002 22:58, Christian Ehrhardt wrote:
> > > Nope, still don't see it.  Whoever hits put_page_testzero frees the page,
> > > secure in the knowlege that there are no other references to it.
> > 
> > Well yes, but we cannot remove the page from the lru atomatically
> > at page_cache_release time if we follow your proposal. If you think we can,
> > show me your implementation of page_cache_release and I'll show
> > you where the races are (unless you do everything under the lru_lock
> > of course).
> 
> void page_cache_release(struct page *page)
> {
> 	spin_lock(&pagemap_lru_lock);
> 	if (PageLRU(page) && page_count(page) == 2) {
> 		__lru_cache_del(page);
> 		atomic_dec(&page->count);
> 	}
> 	spin_unlock(&pagemap_lru_lock);
> 	if (put_page_testzero(page))
> 		__free_pages_ok(page, 0);
> }
>
> This allows the following benign race, with initial page count = 3:
> [ ...]
> Neither holder of a page reference sees the count at 2, and so the page
> is left on the lru with count = 1.  This won't happen often and such
> pages will be recovered from the cold end of the list in due course.

Ok, agreed. I think this will work but taking the lru lock each time
is probably not a good idea.

> We could also do this:
> 
> void page_cache_release(struct page *page)
> {
> 	if (page_count(page) == 2) {
> 		spin_lock(&pagemap_lru_lock);
> 		if (PageLRU(page) && page_count(page) == 2) {
> 			__lru_cache_del(page);
> 			atomic_dec(&page->count);
> 		}
> 		spin_unlock(&pagemap_lru_lock);
> 	}
> 	if (put_page_testzero(page))
> 		__free_pages_ok(page, 0);
> }
> 
> Which avoids taking the lru lock sometimes in exchange for widening the
> hole through which pages can end up with count = 1 on the lru list.

This sounds like something that is worth trying. I missed that one.


Side note: The BUG in __pagevec_lru_del seems strange. refill_inactive
or shrink_cache could have removed the page from the lru before
__pagevec_lru_del acquired the lru lock.

     regards   Christian

-- 
THAT'S ALL FOLKS!
