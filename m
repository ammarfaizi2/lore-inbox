Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135372AbRDWPeN>; Mon, 23 Apr 2001 11:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135353AbRDWPeC>; Mon, 23 Apr 2001 11:34:02 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:30724 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S135364AbRDWPd1>;
	Mon, 23 Apr 2001 11:33:27 -0400
Date: Mon, 23 Apr 2001 12:33:06 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Szabolcs Szakacsits <szaka@f-secure.com>
Subject: Re: [patch] swap-speedup-2.4.3-A1, massive swapping speedup
In-Reply-To: <Pine.LNX.4.30.0104231039050.3540-200000@elte.hu>
Message-ID: <Pine.LNX.4.21.0104231218000.1685-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Apr 2001, Ingo Molnar wrote:

> the reason why lookup_swap_cache() locks the page is due to a valid race,
> but the solution excessive: it tries to keep the lookup atomic against
> destroyers of the page, page_launder() and reclaim_page(). But it does not
> really need the page lock for this - what it needs is atomicity against
> swapcache updates. The same atomicity can be achieved by taking the LRU
> and pagecache locks, the PageSwapCache() check is now embedded in a new
> function: __find_get_swapcache_page().

There seems to be one more reason, take a look at the function
read_swap_cache_async() in swap_state.c, around line 240:

        /*
         * Add it to the swap cache and read its contents.
         */
        lock_page(new_page);
        add_to_swap_cache(new_page, entry);
        rw_swap_page(READ, new_page, wait);
        return new_page;

Here we add an "empty" page to the swap cache and use the
page lock to protect people from reading this non-up-to-date
page.

Your patch looks like it could occasionally let a process
map in such a page before the IO is done. We really need to
fix read_swap_cache_async() and your __find_get_swapcache_page()
to make sure that only pages which are up to date can be given
to processes.

> the patch dramatically improves swapping performance in the tests i've
> tried:

> Swap-in latency of swapped-out processes has decreased significantly,
> and overall swapping throughput has increased and stabilized.

Cool, this really sounds like a patch we need, once the correctness
issue is resolved.

> I'd really like to ask all MM developers to take some time to lean back
> and verify current code to find similar performance bugs, instead of
> trying to hack up new functionality to hide symptoms of bad design or bad
> implementation. (for example there are some plans to add "avoid trashing
> via process suspension" heuristics, which just work around real problems
> like this one. With such code in place i'd probably never have found this
> problem.) I believe we have most of the VM functionality in place to have
> a world-class VM (most of which is new), what we now need is reliable and
> verified behavior, not more complexity.

Agreed, we need to look for all the gotchas in the current code.

OTOH, no matter how fast we make the current functionality, there
will always be some point at which the system is so overloaded that
no paging system can help save it from thrashing. At this point we
need load control ... IMHO it is unacceptable to have Linux fall
over under heavy overload when we could stop this from happening by
simple load control code.


Btw, to test this ... try running 10 copies of gnuchess playing
against itself on a machine with 64 MB of RAM. You'll go under
thrashing pretty quickly.

This same situation is possible in real-life scenarios, like a
website getting slashdotted or a mail server getting bombed. We
really want some form of load control to save a machine from
thrashing itself to death in such a situation.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/


