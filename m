Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272712AbRIMDAT>; Wed, 12 Sep 2001 23:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272739AbRIMDAJ>; Wed, 12 Sep 2001 23:00:09 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:17412 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S272712AbRIMC74>; Wed, 12 Sep 2001 22:59:56 -0400
Date: Wed, 12 Sep 2001 22:35:35 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Hugh Dickins <hugh@veritas.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.10pre VM changes: Potential race condition on swap code
In-Reply-To: <Pine.LNX.4.21.0109110059390.1420-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0109122227040.3414-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 11 Sep 2001, Hugh Dickins wrote:

> On Tue, 11 Sep 2001, Marcelo Tosatti wrote:
> > 
> > - swapin_readahead() finds used entry on swap map. (valid_swaphandles)
> > - user of this entry deletes the swap map entry, so it becomes free. Then:
> > 
> > CPU0					CPU1
> > read_swap_cache_async()			try_to_swap_out()
> > Second __find_get_page() fails
> > 					get_swap_page() returns swap
> > 					entry which CPU0 is trying to read
> > 					from.
> > swap_duplicate() for the entry
> > succeeds: CPU1 just allocated it.
> > 					
> > add_to_swap_cache()			add_to_swap_cache()
> 
> Yes, well spotted, you are right that there's a malign race here.
> 
> It may be made more likely by my swapoff changes (not bumping swap
> count in valid_swaphandles), but it's not been introduced by those
> changes.  Though usually swapin_readahead/valid_swaphandles covers
> (includes) the particular swap entry which do_swap_page actually
> wants to bring in, under pressure that's not always so, and then
> the race you outline can occur with the "bare" read_swap_cache_async
> for which there was no bumping.  Furthermore, you can play your
> scenario with valid_swaphandles through to add_to_swap_cache on CPU0
> interposed between the get_swap_page and add_to_swap_cache on CPU1
> (if interrupt on CPU1 diverts it).

I don't think so. A "bare" read_swap_cache_async() call only happens on
swap entries which already have additional references. That is, its
guaranteed that a "bare" read_swap_cache_async() call only happens for
swap map entries which already have a reference, so we're guaranteed that
it cannot be reused.

See? 

> So it doesn't look like the solution will be to reintroduce bumping
> the swap count in valid_swaphandles.  It needs the locking here to
> be properly sorted out, probably without deceptive recourse to BKL.
> I'll try to think this through this evening (but won't be surprised
> if someone beats me to it).
> 
> Valuable find, thank you!
> Hugh
> 

