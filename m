Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129114AbRBGCih>; Tue, 6 Feb 2001 21:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129127AbRBGCi1>; Tue, 6 Feb 2001 21:38:27 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:15883 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129114AbRBGCiT>; Tue, 6 Feb 2001 21:38:19 -0500
Date: Tue, 6 Feb 2001 18:37:41 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Ingo Molnar <mingo@elte.hu>, Ben LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <20010207014928.O1167@redhat.com>
Message-ID: <Pine.LNX.4.10.10102061829230.2448-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 7 Feb 2001, Stephen C. Tweedie wrote:
>
> > "struct buffer_head" can deal with pretty much any size: the only thing it
> > cares about is bh->b_size.
> 
> Right now, anything larger than a page is physically non-contiguous,
> and sorry if I didn't make that explicit, but I thought that was
> obvious enough that I didn't need to.  We were talking about raw IO,
> and as long as we're doing IO out of user anonymous data allocated
> from individual pages, buffer_heads are limited to that page size in
> this context.

Sure. That's obviously also one of the reasons why the IO layer has never
seen bigger requests anyway - the data _does_ tend to be fundamentally
broken up into page-size entities, if for no other reason that that is how
user-space sees memory.

However, I really _do_ want to have the page cache have a bigger
granularity than the smallest memory mapping size, and there are always
special cases that might be able to generate IO in bigger chunks (ie
in-kernel services etc)

> Yes.  We still have this fundamental property: if a user sends in a
> 128kB IO, we end up having to split it up into buffer_heads and doing
> a separate submit_bh() on each single one.  Given our VM, PAGE_SIZE
> (*not* PAGE_CACHE_SIZE) is the best granularity we can hope for in
> this case.

Absolutely. And this is independent of what kind of interface we end up
using, whether it be kiobuf of just plain "struct buffer_head". In that
respect they are equivalent.

> THAT is the overhead that I'm talking about: having to split a large
> IO into small chunks, each of which just ends up having to be merged
> back again into a single struct request by the *make_request code.

You could easily just generate the bh then and there, if you wanted to.

Your overhead comes from the fact that you want to gather the IO together. 

And I'm saying that you _shouldn't_ gather the IO. There's no point. The
gathering is sufficiently done by the low-level code anyway, and I've
tried to explain why the low-level code _has_ to do that work regardless
of what upper layers do.

You need to generate a separate sg entry for each page anyway. So why not
just use the existing one? The "struct buffer_head". Which already
_handles_ all the issues that you have complained are hard to handle.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
