Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129114AbRBGO5h>; Wed, 7 Feb 2001 09:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129132AbRBGO53>; Wed, 7 Feb 2001 09:57:29 -0500
Received: from zeus.kernel.org ([209.10.41.242]:43741 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129114AbRBGO5N>;
	Wed, 7 Feb 2001 09:57:13 -0500
Date: Wed, 7 Feb 2001 14:52:15 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Ingo Molnar <mingo@elte.hu>,
        Ben LaHaise <bcrl@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
Message-ID: <20010207145215.D7254@redhat.com>
In-Reply-To: <20010207014928.O1167@redhat.com> <Pine.LNX.4.10.10102061829230.2448-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.10.10102061829230.2448-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Feb 06, 2001 at 06:37:41PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 06, 2001 at 06:37:41PM -0800, Linus Torvalds wrote:
> >
> However, I really _do_ want to have the page cache have a bigger
> granularity than the smallest memory mapping size, and there are always
> special cases that might be able to generate IO in bigger chunks (ie
> in-kernel services etc)

No argument there.

> > Yes.  We still have this fundamental property: if a user sends in a
> > 128kB IO, we end up having to split it up into buffer_heads and doing
> > a separate submit_bh() on each single one.  Given our VM, PAGE_SIZE
> > (*not* PAGE_CACHE_SIZE) is the best granularity we can hope for in
> > this case.
> 
> Absolutely. And this is independent of what kind of interface we end up
> using, whether it be kiobuf of just plain "struct buffer_head". In that
> respect they are equivalent.

Sorry?  I'm not sure where communication is breaking down here, but
we really don't seem to be talking about the same things.  SGI's
kiobuf request patches already let us pass a large IO through the
request layer in a single unit without having to split it up to
squeeze it through the API.

> > THAT is the overhead that I'm talking about: having to split a large
> > IO into small chunks, each of which just ends up having to be merged
> > back again into a single struct request by the *make_request code.
> 
> You could easily just generate the bh then and there, if you wanted to.

In the current 2.4 tree, we already do: brw_kiovec creates the
temporary buffer_heads on demand to feed them to the IO layers.

> Your overhead comes from the fact that you want to gather the IO together. 

> And I'm saying that you _shouldn't_ gather the IO. There's no point.

I don't --- the underlying layer does.  And that is where the overhead
is: for every single large IO being created by the higher layers,
make_request is doing a dozen or more merges because I can only feed
the IO through make_request in tiny pieces.

> The
> gathering is sufficiently done by the low-level code anyway, and I've
> tried to explain why the low-level code _has_ to do that work regardless
> of what upper layers do.

I know.  The problem is the low-level code doing it a hundred times
for a single injected IO.

> You need to generate a separate sg entry for each page anyway. So why not
> just use the existing one? The "struct buffer_head". Which already
> _handles_ all the issues that you have complained are hard to handle.

Two issues here.  First is that the buffer_head is an enormously
heavyweight object for a sg-list fragment.  It contains a ton of
fields of interest only to the buffer cache.  We could mitigate this
to some extent by ensuring that the relevant fields for IO (rsector,
size, req_next, state, data, page etc) were in a single cache line.

Secondly, the cost of adding each single buffer_head to the request
list is O(n) in the number of requests already on the list.  We end up
walking potentially the entire request queue before finding the
request to merge against, and we do that again and again, once for
every single buffer_head in the list.  We do this even if the caller
went in via a multi-bh ll_rw_block() call in which case we know in
advance that all of the buffer_heads are contiguous on disk.


There is a side problem: right now, things like raid remapping occur
during generic_make_request, before we have a request built.  That
means that all of the raid0 remapping or raid1/5 request expanding is
being done on a per-buffer_head, not per-request, basis, so again
we're doing a whole lot of unnecessary duplicate work when an IO
larger than a buffer_head is submitted.


If you really don't mind the size of the buffer_head as a sg fragment
header, then at least I'd like us to be able to submit a pre-built
chain of bh's all at once without having to go through the remap/merge
cost for each single bh.

Cheers,
 Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
