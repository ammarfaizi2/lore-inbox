Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261913AbREMUms>; Sun, 13 May 2001 16:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261911AbREMUmi>; Sun, 13 May 2001 16:42:38 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:65033 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261917AbREMUm2>; Sun, 13 May 2001 16:42:28 -0400
Date: Sun, 13 May 2001 13:42:18 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: "David S. Miller" <davem@redhat.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: page_launder() bug
In-Reply-To: <Pine.LNX.4.21.0105131637060.5468-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.21.0105131330350.20613-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 13 May 2001, Rik van Riel wrote:
> > 
> > The high-level VM layer simply doesn't have that kind of information.
> 
> Agreed.  I'd like to make sure, however, that we keep the
> high-level VM cleanly separated from the lower layers so
> we can keep the VM maintainable and predictable...

This is by far my biggest issue.

This is also why I much prefer to not have page_launder() know about swap
counts and issues like that - adding logic to page_launder() to find and
dismiss dead swap pages would have been the straightforward approach, but
would have made swap more special than I think it is.

Right now I'm _fairly_ happy with how generic the page cache handling is,
and how swapping and shared memory are much better integrated in the
overall design than they used to be. Swapping (and especially shared
memory) used to be a ratsnest of special cases, with magic function calls
and innate knowledge of how things worked by the core VM code.

These days, the page cache and the notion of "address spaces" have taken
up a lot of the special case logic, and most of it is gone. I'm looking
forward to the day when we could drop the "PG_swapcache" bit in the page
flags structure, and not have any special logic for swapping at
all.

Already some of these special cases are really unnecessary, and could
validly be replaced with checking for mapping matches instead. See for
example the lonely use in mm/filemap.c - it would make more sense to
verify that "page->mapping == mapping" instead of testing a
special-purpose bit: suddenly __find_get_swapcache_page and
__find_get_page actually end up doing pretty much the same thing.

It's not worth doing those kinds of small details now, but what I want to
have in the long run is to have _less_ special cases for swapping etc -
we've already pretty clearly shown that swapping isn't really anything
different from shared mappings, it's just a different allocation strategy.

And that's why I'd rather have generic support for _any_ page mapping that
wants to drop pages early than have specific logic for swapping.
Historically, we've always had very good results from trying to avoid
having special cases and instead trying to find what the common rules
might be.

			Linus

