Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276477AbRKHQ6N>; Thu, 8 Nov 2001 11:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276591AbRKHQ6H>; Thu, 8 Nov 2001 11:58:07 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:35084 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S276249AbRKHQ5m>; Thu, 8 Nov 2001 11:57:42 -0500
Date: Thu, 8 Nov 2001 08:54:14 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: out_of_memory() heuristic broken for different mem configurations
 (fwd)
In-Reply-To: <Pine.LNX.4.33L.0111081433120.27028-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0111080842080.1489-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 8 Nov 2001, Rik van Riel wrote:
>
> ISTR that you wanted swap_out() changed into something which
> only scans a portion of the ptes and doesn't have any return
> value for a related reason in early 2.4 ... ;)

The fundamental thing is that we can _never_ return early out of
swap_out(). There are no local decisions we can make that make any sense.
The fact that we're out of swap-space is only meaningful _after_ we've
verified that we have no shared mappings.

Now, there _is_ another approach we can take, which is to notice _before_
we call swap_out() that it's not going to help us. With all anonymous
pages on the LRU list, we do have enough information in shrink_caches() to
notice that the pages we want to get rid of require backing store: that's
as easy as seeing "page->mapping == NULL".

But we can not make that decision in swap_out(), and any code that _tries_
to make that decision is clearly bogus.

Which is, indeed, why I feel strongly that swap_out() needs to be "void".
(Well, right now it technically isn't, but we ignore the value it returns,
so it doesn't much matter ;).

But in shrink_cache(), we could add something like

 - increment a count every time we see a page with a mapping, and in the
   right memory zone: all such pages _can_ be dropped and do not need
   swap-space.

 - add logic somewhat like

	if (nr_swap_pages || page_mapping_count > 5%)
		we're not oom

(note that "page_mapping_count" in _theory_ is the same as
"page_cache_size", except that we need to count only pages in the right
zones. It doesn't help us if we have tons of highmem pages free, if we're
unable to get rid of normal pages. There are simply too many things that
can not use the high pages, and we have to consider that to be oom).

		Linus

