Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280717AbRKSVTR>; Mon, 19 Nov 2001 16:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280725AbRKSVTJ>; Mon, 19 Nov 2001 16:19:09 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:55314 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S280717AbRKSVTA>; Mon, 19 Nov 2001 16:19:00 -0500
Date: Mon, 19 Nov 2001 18:01:10 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Simon Kirby <sim@netnation.com>, Andrea Arcangeli <andrea@suse.de>,
        lkml <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: VM-related Oops: 2.4.15pre1
In-Reply-To: <Pine.LNX.4.33.0111190958230.8205-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0111191755460.7451-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 19 Nov 2001, Linus Torvalds wrote:

> 
> On Mon, 19 Nov 2001, Simon Kirby wrote:
> >
> > So, uh, any idea why the server is hitting the page->mapping BUG() thing
> > in the first place? :)
> 
> No.
> 
> I suspect that your earlier oopses left something in a stale state - this
> is the same machine that you've reported others oopses for, no?

Linus, 

I was talking with Rik today about 2.5 VM plans and we end up talking
about the order of the pagecache_lock and pagemap_lru_lock. He ended up
showing me add_to_page_cache(), which now looks like:

We ended up talking about the possibility of a reschedule (IRQ) happening
before after the "spin_unlock(pagecache_lock)" but before the
"lru_cache_add()".

I haven't investigated the issue yet... But isn't that possible ? 

void add_to_page_cache(struct page * page, struct address_space * mapping,
unsigned long offset)
{
        spin_lock(&pagecache_lock);
        __add_to_page_cache(page, mapping, offset, page_hash(mapping,
offset));
        spin_unlock(&pagecache_lock);
        lru_cache_add(page);
}


