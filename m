Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280323AbRKSXAK>; Mon, 19 Nov 2001 18:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280203AbRKSW77>; Mon, 19 Nov 2001 17:59:59 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:61202 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S280410AbRKSW7u>;
	Mon, 19 Nov 2001 17:59:50 -0500
Date: Mon, 19 Nov 2001 20:59:27 -0200 (BRST)
From: Rik van Riel <riel@marcelothewonderpenguin.com>
X-X-Sender: <riel@imladris.surriel.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Simon Kirby <sim@netnation.com>, Andrea Arcangeli <andrea@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: VM-related Oops: 2.4.15pre1
In-Reply-To: <Pine.LNX.4.33.0111191437370.8727-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0111192056310.4079-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Nov 2001, Linus Torvalds wrote:
> On Mon, 19 Nov 2001, Rik van Riel wrote:
> >
> > I wonder if the following scenario is possible:
>
> Hmm.. It looks valid, but for the fact that the page lock is held. So
> there's no way truncate_list_pages() can call "remove_inode_page()" on the
> page, regardless of whether the page is on the LRU list or not.
>
> That said, it might be cleaner to move the "lru_cache_add(page);" up to
> before adding the page into the page cache - that way we add a new
> invariant that just says "all pages in the page cache are on the LRU
> list", which could be used for a few extra sanity checks, for example.

Oh dear, that's an interesting case, too.

__add_to_page_cache() blindly sets the PG_locked bit, but
it's possible for other functions to acquire the page lock
before that.

This means 2 CPUs could think they're holding the page
lock for this page at the same time.

I don't see anything preventing this from happening,
except the absence of code paths trying to directly
grab hold of physical pages ;)

regards,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

