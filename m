Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262081AbREZXtp>; Sat, 26 May 2001 19:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262176AbREZXtg>; Sat, 26 May 2001 19:49:36 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:3335 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S262081AbREZXtZ>; Sat, 26 May 2001 19:49:25 -0400
Date: Sat, 26 May 2001 19:12:39 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rik van Riel <riel@conectiva.com.br>, Andrea Arcangeli <andrea@suse.de>,
        Ben LaHaise <bcrl@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.5
In-Reply-To: <Pine.LNX.4.21.0105260849320.3772-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0105261847000.1533-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 26 May 2001, Linus Torvalds wrote:

> 
> On Sat, 26 May 2001, Rik van Riel wrote:
> > 
> > > Testing is good. But I want to understand how we get into the
> > > situation in the first place, and whether there are ways to alleviate
> > > those problems too.
> > 
> > As I said  create_buffers() -> get_unused_buffer_head()
> > -> __alloc_pages() -> loop infinitely.
> 
> No no no.
> 
> Get outside the small world of where it's looping.

There are two problems here. 

It is senseless to make GFP_BUFFER allocations loop inside
__alloc_pages() (calling try_to_free_pages()) because these allocations
_can't_ block.

If there is no free memory, they are going to loop. 

This is "independant" from the highmem deadlock. 

See? 

Now lets talk about the highmem deadlock. 

> Think more on the problem of "how did we get into such a state that we're
> so low on memory for swapouts in the FIRST PLACE?"
> 
> That's the problem I want to fix. And I suspect part of the equation is
> exactly the fact that we use SLAB_BUFFER for the buffer heads. 
> 
> Example schenario:
>  - we're low on memory, but not disastrously so. We have lots of highmem
>    pages, but not that much NORMAL. But we're not uncomfortable yet.
>  - somebody starts writing out to a file. He nicely allocates HIGHMEM
>    pages for the actual data (no memory pressure on HIGHMEM, so no
>    "try_to_free_pages()" called at all)
>  - the writer _also_ needs the buffer heads for those written pages (ie
>    "generic_block_prepare_write()"), and here he allocates them with
>    SLAB_BUFFER. The NORMAL zone starts getting low, and we start calling
>    "try_to_free_pages()".
>  - we deplete "try_to_free_pages()" and start swapping. Except everybody
>    is calling "try_to_free_pages()" with GFP_BUFFER, so nobody can
>    actually do any IO, and if we're unlucky there's not much to be free'd
>    in the NORMAL zone.
> 
> Now do you start to see a pattern here? 
> 
> You're trying to fix the symptoms, by attacking the final end. And what
> I've been trying to say is that this problem likely has a higher-level
> _cause_, and I want that _cause_ fixed. Not the symptoms.

You are not going to fix the problem by _only_ doing this bh allocation
change.

Even if some bh allocators _can_ block on IO, there is no guarantee that
they are going to free low memory --- they may start more IO on highmem
pages.

We cannot treat highmem as "yet another zone" zone. All highmem data goes
through the lowmem before reaching the disk, so its clear for me that we
should not try to write out highmem pages in case we have a lowmem
shortage.

Well, IMO.


