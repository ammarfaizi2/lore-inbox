Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261886AbREMVDI>; Sun, 13 May 2001 17:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261888AbREMVC6>; Sun, 13 May 2001 17:02:58 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:49164 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S261886AbREMVCu>; Sun, 13 May 2001 17:02:50 -0400
Date: Sun, 13 May 2001 23:02:27 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Rik van Riel <riel@conectiva.com.br>
cc: "David S. Miller" <davem@redhat.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Another VM race? (was: page_launder() bug)
In-Reply-To: <Pine.LNX.4.21.0105131322190.5468-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.3.96.1010513224406.18268B-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > +		if (!dead_swap_page &&
> > > +		    (PageTestandClearReferenced(page) || page->age > 0 ||
> > > +		     (!page->buffers && page_count(page) > 1) ||
> > > +		     page_ramdisk(page))) {
> > 		^^^^^^^^^^^^^^^^^^^^^^
> > >  			del_page_from_inactive_dirty_list(page);
> > >  			add_page_to_active_list(page);
> > >  			continue;
> > 
> > #define page_ramdisk(page) \
> >         (page->buffers && (MAJOR(page->buffers->b_dev) == RAMDISK_MAJOR))
> > 
> > Are you sure that no one will release buffers under your hands?
> 
> Two things can happen:
> 
> 1) the page gets ramdisk buffers _after_ we look at it first,
>    in this case the page isn't freeable and will be moved to
>    the active list on the next page_launder() loop
> 
> 2) the page loses its ramdisk buffers after we look at it,
>    now the page is freeable, but we won't see it again until
>    it is moved from the active list to the inactive_dirty
>    list again
> 
> Any side effects harmful enough to warrant complicating this
> test ?

I mean this: Let's have a page with buffers. It does not care whether the
buffers are on ramdisk or not. 

CPU 0				CPU 1
is executing the code marked	is executing try_to_free_buffers on
above with ^^^^^^^:		the same page (it can be, because CPU 0
				did not lock the page)

(page->buffers &&

				page->buffers = NULL

MAJOR(page->buffers->b_dev) == 
	RAMDISK_MAJOR)) ===> Oops, NULL pointer dereference!



Maybe compiler CSE optimization will eliminate the double load of
page->buffers, but we must not rely on it. If the compiler doesn't
optimize it, it can produce random oopses.

Mikulas

