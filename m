Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129637AbRBFVAN>; Tue, 6 Feb 2001 16:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130448AbRBFVAE>; Tue, 6 Feb 2001 16:00:04 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:64777 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129618AbRBFU7z>; Tue, 6 Feb 2001 15:59:55 -0500
Date: Tue, 6 Feb 2001 12:59:02 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Hellwig <hch@ns.caldera.de>
cc: Ben LaHaise <bcrl@redhat.com>, Ingo Molnar <mingo@elte.hu>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <20010206212503.A5426@caldera.de>
Message-ID: <Pine.LNX.4.10.10102061235590.1474-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 6 Feb 2001, Christoph Hellwig wrote:
> 
> The second is that bh's are two things:
> 
>  - a cacheing object
>  - an io buffer

Actually, they really aren't.

They kind of _used_ to be, but more and more they've moved away from that
historical use. Check in particular the page cache, and as a really
extreme case the swap cache version of the page cache.

It certainly _used_ to be true that "bh"s were actually first-class memory
management citizens, and actually had a data buffer and a cache associated
with them. And because of that historical baggage, that's how many people
still think of them.

These days, it's really not true any more. A "bh" doesn't really have an
IO buffer intrisically associated with it any more - all memory management
is done on a _page_ level, and it really works the other way around, ie a
page can have one or more bh's associated with it as the IO entity.

This _does_ show up in the bh itself: you find that bh's end up having the
bh->b_page pointer in it, which is really a layering violation these days,
but you'll notice that it's actually not used very much, and it could
probably be largely removed.

The most fundamental use of it (from an IO standpoint) is actually to
handle high memory issues, because high-memory handling is very
fundamentally based on "struct page", and in order to be able to have
high-memory IO buffers you absolutely have to have the "struct page" the
way things are done now.

(all the other uses tend to not be IO-related at all: they are stuff like
the callbacks that want to find the page that should be free'd up)

The other part of "struct bh" is that it _does_ have support for fast
lookups, and the bh hashing. Again, from a pure IO standpoint you can
easily choose to just ignore this. It's often not used at all (in fact,
_most_ bh's aren't hashed, because the only way to find them are through
the page cache).

> This is not really an clean appropeach, and I would really like to
> get away from it.

Trust me, you really _can_ get away from it. It's not designed into the
bh's at all. You can already just allocate a single (or multiple) "struct
buffer_head" and just use them as IO objects, and give them your _own_
pointers to the IO buffer etc.

In fact, if you look at how the page cache is organized, this is what the
page cache already does. The page cache has it's own IO buffer (the page
itself), and it just uses "struct buffer_head" to allocate temporary IO
entities. It _also_ uses the "struct buffer_head" to cache the meta-data
in the sense of having the buffer head also contain the physical address
on disk so that the page cache doesn't have to ask the low-level
filesystem all the time, so in that sense it actually has a double use for
it.

But you can (and _should_) think of that as a "we got the meta-data
address caching for free, and it fit with our historical use, so why not
use it?".

So you can easily do the equivalent of

 - maintain your own buffers (possibly by looking up pages directly from
   user space, if you want to do zero-copy kind of things)

 - allocate a private buffer head ("get_unused_buffer_head()")

 - make that buffer head point into your buffer

 - submit the IO by just calling "submit_bh()", using the b_end_io()
   callback as your way to maintain _your_ IO buffer ownership.

In particular, think of the things that you do NOT have to do:

 - you do NOT have to allocate a bh-private buffer. Just point the bh at
   your own buffer.
 - you do NOT have to "give" your buffer to the bh. You do, of course,

   want to know when the bh is done with _your_ buffer, but that's what
   the b_end_io callback is all about.

 - you do NOT have to hash the bh you allocated and thus expose it to
   anybody else. It is YOUR private bh, and it does not show up on ANY
   other lists. There are various helper functions to insert the bh on
   various global lists ("mark_bh_dirty()" to put it on the dirty list,
   "buffer_insert_inode_queue()" to put it on the inode lists etc, but
   there is nothing in the thing that _forces_ you to expose your bh.

So don't think of "bh->b_data" as being something that the bh owns. It's
just a pointer. Think of "bh->b_data" and "bh->b_size" as _nothing_ more
than a data range in memory. 

In short, you can, and often should, think of "struct buffer_head" as
nothing but an IO entity. It has some support for being more than that,
but that's secondary. That can validly be seen as another layer, that is
just so common that there is little point in splitting it up (and a lot of
purely historical reasons for not splitting it).

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
