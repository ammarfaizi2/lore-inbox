Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132580AbRDWXyF>; Mon, 23 Apr 2001 19:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132584AbRDWXxy>; Mon, 23 Apr 2001 19:53:54 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:25604 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S132580AbRDWXxj>; Mon, 23 Apr 2001 19:53:39 -0400
Date: Mon, 23 Apr 2001 19:13:15 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jonathan Morton <chromi@cyberspace.org>,
        Rik van Riel <riel@conectiva.com.br>, Ingo Molnar <mingo@elte.hu>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Szabolcs Szakacsits <szaka@f-secure.com>
Subject: Re: [patch] swap-speedup-2.4.3-A1, massive swapping speedup
In-Reply-To: <Pine.LNX.4.21.0104231003480.13206-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0104231910090.1179-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 23 Apr 2001, Linus Torvalds wrote:

> 
> On Mon, 23 Apr 2001, Jonathan Morton wrote:
> > >There seems to be one more reason, take a look at the function
> > >read_swap_cache_async() in swap_state.c, around line 240:
> > >
> > >        /*
> > >         * Add it to the swap cache and read its contents.
> > >         */
> > >        lock_page(new_page);
> > >        add_to_swap_cache(new_page, entry);
> > >        rw_swap_page(READ, new_page, wait);
> > >        return new_page;
> > >
> > >Here we add an "empty" page to the swap cache and use the
> > >page lock to protect people from reading this non-up-to-date
> > >page.
> > 
> > How about reversing the order of the calls - ie. add the page to the cache
> > only when it's been filled?  That would fix the race.
> 
> No. The page cache is used as the IO synchronization point, both for
> swapping and for regular IO. You have to add the page in _first_, because
> otherwise you may end up doing multiple IO's from different pages.
> 
> The proper fix is to do the equivalent of this on all the lookup paths
> that want a valid page:
> 
> 	if (!PageUptodate(page)) {
> 		lock_page(page);
> 		if (PageUptodate(page)) {
> 			unlock_page(page);
> 			return 0;
> 		}
> 		rw_swap_page(page, 0);
> 		wait_on_page(page);
> 		if (!PageUptodate(page))
> 			return -EIO;
> 	}
> 	return 0;
> 
> This is the whole point of the "uptodate" flag, and for all I know we may
> already do all of this (it's certainly the normal setup).
> 
> Note how we do NOT block on write-backs in the above: the page will be
> up-to-date from the bery beginning (it had _better_ be, it's hard to write
> back a swap page that isn't up-to-date ;).
> 
> The above is how all the file paths work. 

Please don't forget about swapin readahead. 

If the page is not uptodated and we are doing swapin readahead on it, we
want to fail if the page is already locked (which means its already under
IO).


