Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135206AbRDWRSF>; Mon, 23 Apr 2001 13:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135293AbRDWRRz>; Mon, 23 Apr 2001 13:17:55 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:19462 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135206AbRDWRRk>; Mon, 23 Apr 2001 13:17:40 -0400
Date: Mon, 23 Apr 2001 10:17:07 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Rik van Riel <riel@conectiva.com.br>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Szabolcs Szakacsits <szaka@f-secure.com>
Subject: Re: [patch] swap-speedup-2.4.3-A2
In-Reply-To: <Pine.LNX.4.30.0104231707350.31693-200000@elte.hu>
Message-ID: <Pine.LNX.4.21.0104231011070.13206-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 23 Apr 2001, Ingo Molnar wrote:
> 
> you are right - i thought about that issue too and assumed it works like
> the pagecache (which first reads the page without hashing it, then tries
> to add the result to the pagecache and throws away the page if anyone else
> finished it already), but that was incorrect.

The above is NOT how the page cache works. Or if some part of the page
cache works that way, then it is a BUG. You must NEVER allow multiple
outstanding reads from the same location - that implies that you're doing
something wrong, and the system is doing too much IO.

The way _all_ parts of the page cache should work is:

Create new page:
 - look up page. If found, return it
 - allocate new page.
 - look up page again, in case somebody else added it while we allocated
   it.
 - add the page atomically with the lookup if the lookup failed, otherwise
   just free the page without doing anything.
 - return the looked-up / allocated page.

return up-to-date page:
 - call the above to get a page cache page.
 - if uptodate, return
 - lock_page()
 - if now uptodate (ie somebody else filled it and held the lock), unlock
   and return.
 - start the IO
 - wait on IO by waiting on the page (modulo other work that you could do
   in the background).
 - if the page is still not up-to-date after we tried to read it, we got
   an IO error. Return error.

The above is how it is always meant to work. The above works for both new
allocations and for old. It works even if an earlier read had failed (due
to wrong permissions for example - think about NFS page caches where some
people may be unable to actually fill a page, so that you need to re-try
on failure). The above is how the regular read/write paths work (modulo
bugs). And it's also how the swap cache should work.

		Linus

