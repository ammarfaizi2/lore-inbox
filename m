Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133019AbRDZNIy>; Thu, 26 Apr 2001 09:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133073AbRDZNIn>; Thu, 26 Apr 2001 09:08:43 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:23045 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S133019AbRDZNIg>; Thu, 26 Apr 2001 09:08:36 -0400
Date: Thu, 26 Apr 2001 06:08:25 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Mike Galbraith <mikeg@wen-online.de>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] swap-speedup-2.4.3-B3 (fwd)
In-Reply-To: <Pine.LNX.4.33.0104261043330.292-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.21.0104260526020.2416-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 26 Apr 2001, Mike Galbraith wrote:
> 
> 2.4.4.pre7.virgin
> real    11m33.589s
> user    7m57.790s
> sys     0m38.730s
> 
> 2.4.4.pre7.sillyness
> real    9m30.336s
> user    7m55.270s
> sys     0m38.510s

Well, I actually like parts of this. The "always swap out current mm" one
looks rather dangerous, and the lastscan jiffy thing is too ugly for
words, but refill_inactive() looks much nicer. There is beauty in
simplicity. 

The page aging in drop_pte feels pretty harsh, though.

Have you looked at "free_pte()"? I don't like that function, and it might
make a difference. There are several small nits with it:

 - it should probably try to deactivate the page. If drop_pte does that
   when it deacctivates a page involuntarily, why not do it for a real "we
   just free'd the page voluntarily"?

 - swap-cache pages should probably not just be de-activated, but actively
   aged down. Right now, they are neither, so we have to work all the 
   way through refill_inactive() and then page_launder() to clear them
   out. Even though the page may be entirely useless by now (we had a
   complex special case that caught and short-circuited some of the pages,
   and maybe it was worth it. But maybe the right thing is to just age
   them down and naturally deactivate them?)

   After all, we aged them up for references to this virtual
   mapping, and free_pte() just made it go away. Unlike normal page cache
   pages, we don't get any advantage from trying to cache the things
   across multiple VM's.

 - we're dropping the accessed bit on the floor. In the vmscan case the
   accessed bit would have aged the page up. 

On the other hand, to offset some of these, we actually count the page
accessed _twice_ sometimes: we count it on lookup, and we count it when we
see the accessed bit in vmscan.c. Which results in some pages getting aged
up twice for just one access if we go through the vmscan logic, while if
we just map and unmap them they get counted just once.

Obviously the page aging logic seems to be making a noticeable difference
to you. So looking at page aging logic issues in the bigger picture migth
be worthwhile - not just staring at the actual swap-out code. The fact is,
the swap-out-code cannot get the aging right if the rest of the system
ignores it or does it only for some cases.

I _think_ the logic should be something along the lines of: "freeing the
page amounts to a implied down-aging of the page, but the 'accessed' bit
would have aged it up, so the two take each other out". But if so, the
free_pte() logic should have something like

	if (page->mapping) {
		if (!pte_young(pte) || PageSwapCache(page))
			age_page_down_ageonly(page);
		if (!page->age)
			deactivate_page(page);
	}

instead of just ignoring these issues completely.

Comments? 

		Linus

