Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262312AbREZXAC>; Sat, 26 May 2001 19:00:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261843AbREZW7H>; Sat, 26 May 2001 18:59:07 -0400
Received: from zeus.kernel.org ([209.10.41.242]:20647 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262583AbREZW64>;
	Sat, 26 May 2001 18:58:56 -0400
Date: Sat, 26 May 2001 08:59:48 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Andrea Arcangeli <andrea@suse.de>, Ben LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.5
In-Reply-To: <Pine.LNX.4.21.0105261226400.30264-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.21.0105260849320.3772-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 26 May 2001, Rik van Riel wrote:
> 
> > Testing is good. But I want to understand how we get into the
> > situation in the first place, and whether there are ways to alleviate
> > those problems too.
> 
> As I said  create_buffers() -> get_unused_buffer_head()
> -> __alloc_pages() -> loop infinitely.

No no no.

Get outside the small world of where it's looping.

Think more on the problem of "how did we get into such a state that we're
so low on memory for swapouts in the FIRST PLACE?"

That's the problem I want to fix. And I suspect part of the equation is
exactly the fact that we use SLAB_BUFFER for the buffer heads. 

Example schenario:
 - we're low on memory, but not disastrously so. We have lots of highmem
   pages, but not that much NORMAL. But we're not uncomfortable yet.
 - somebody starts writing out to a file. He nicely allocates HIGHMEM
   pages for the actual data (no memory pressure on HIGHMEM, so no
   "try_to_free_pages()" called at all)
 - the writer _also_ needs the buffer heads for those written pages (ie
   "generic_block_prepare_write()"), and here he allocates them with
   SLAB_BUFFER. The NORMAL zone starts getting low, and we start calling
   "try_to_free_pages()".
 - we deplete "try_to_free_pages()" and start swapping. Except everybody
   is calling "try_to_free_pages()" with GFP_BUFFER, so nobody can
   actually do any IO, and if we're unlucky there's not much to be free'd
   in the NORMAL zone.

Now do you start to see a pattern here? 

You're trying to fix the symptoms, by attacking the final end. And what
I've been trying to say is that this problem likely has a higher-level
_cause_, and I want that _cause_ fixed. Not the symptoms.

Now, I suspect that part of the cause for this is the fact that we're
using GFP_BUFFER where we shouldn't, which is why we cannot free stuff up
properly in the NORMAL zone.

Now, there could be other things going on too. I'm not saying that it is
necessarily _just_ the experimental silly test-patch I sent out
yesterday. But I _am_ saying that we should try to fix the root cause
first, and then apply the page_alloc.c thing as a last-ditch effort (but
I'd like that "last effort" to be something that nobody can trigger under
any reasonable load).

Do you NOW see my argument? The argument of "we shouldn't have gotten us
into this situation in the first place". See?

		Linus

