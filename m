Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317624AbSHaQKZ>; Sat, 31 Aug 2002 12:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317623AbSHaQKY>; Sat, 31 Aug 2002 12:10:24 -0400
Received: from thales.mathematik.uni-ulm.de ([134.60.66.5]:13982 "HELO
	thales.mathematik.uni-ulm.de") by vger.kernel.org with SMTP
	id <S317624AbSHaQKW>; Sat, 31 Aug 2002 12:10:22 -0400
Message-ID: <20020831161448.12564.qmail@thales.mathematik.uni-ulm.de>
From: "Christian Ehrhardt" <ehrhardt@mathematik.uni-ulm.de>
Date: Sat, 31 Aug 2002 18:14:48 +0200
To: Daniel Phillips <phillips@arcor.de>
Cc: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] Include LRU in page count
References: <3D644C70.6D100EA5@zip.com.au> <3D6989F7.9ED1948A@zip.com.au> <akdq8h$fqn$1@penguin.transmeta.com> <E17kunE-0003IO-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17kunE-0003IO-00@starship>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 31, 2002 at 01:03:07AM +0200, Daniel Phillips wrote:
> This rare race happened to become not so rare in 2.5 recently, and was 
> analyzed by Christian Ehrhardt, who also proposed a solution based on a new 
> approach to locking, essentially put_page_testone.  We went on to check 2.4 

Just a little correction: The key function implemented in my solution
is an atomic GET_page_testone which is called if the page might have
a zero refcount. The idea I had in mind is to distinguish heavy and weak
references to pages. Your solution is probably the better way to go.

> I proposed an alternate solution using the traditional put_page_testzero 
> primitive, which relies on assigning a page count of one for membership on 
> the lru list.  A slightly racy heuristic is used for efficient lru list 
> removal.  The resulting incarnation of lru_cache_release is:
> 
> static inline void page_cache_release(struct page *page)
> {
> 	if (page_count(page) == 2 && spin_trylock(&pagemap_lru_lock)) {
> 		if (PageLRU(page) && page_count(page) == 2)
> 			__lru_cache_del(page);
> 		spin_unlock(&pagemap_lru_lock);
> 	}
> 	put_page(page);
> }

Just saw that this can still race e.g. with lru_cache_add (not
hard to fix though):

| void lru_cache_add(struct page * page)
| {
|        if (!TestSetPageLRU(page)) {

Window is here: Once we set the PageLRU bit page_cache_release
assumes that there is a reference held by the lru cache.

|                spin_lock(&pagemap_lru_lock);
|                add_page_to_inactive_list(page);
|#if LRU_PLUS_CACHE==2
|                get_page(page);
|#endif

But only starting at this point the reference actually exists.

|                spin_unlock(&pagemap_lru_lock);
|        }
|}

Solution: Change the PageLRU bit inside the lock. Looks like
lru_cache_add is the only place that doesn't hold the lru lock to
change the LRU flag and it's probably not a good idea even without
the patch.

Two more comments: I don't think it is a good idea to use
put_page_nofree in __lru_cache_del. This is probably safe now but
it adds an additional rule that lru_cache_del can't be called without
holding a second reference to the page.
Also there may be lru only pages on the active list, i.e. refill
inactive should have this hunk as well:

> +#if LRU_PLUS_CACHE==2
> +             BUG_ON(!page_count(page));
> +             if (unlikely(page_count(page) == 1)) {
> +                     mmstat(vmscan_free_page);
> +                     BUG_ON(!TestClearPageLRU(page)); // side effect abuse!!
> +                     put_page(page);
> +                     continue;
> +             }
> +#endif

     regards   Christian Ehrhardt

-- 
THAT'S ALL FOLKS!
