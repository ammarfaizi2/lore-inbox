Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135369AbRBETMI>; Mon, 5 Feb 2001 14:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135294AbRBETLs>; Mon, 5 Feb 2001 14:11:48 -0500
Received: from zeus.kernel.org ([209.10.41.242]:29910 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130646AbRBETLi>;
	Mon, 5 Feb 2001 14:11:38 -0500
Date: Mon, 5 Feb 2001 19:08:48 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Christoph Hellwig <hch@caldera.de>,
        Steve Lord <lord@sgi.com>, linux-kernel@vger.kernel.org,
        kiobuf-io-devel@lists.sourceforge.net,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait /notify + callback chains
Message-ID: <20010205190848.P1167@redhat.com>
In-Reply-To: <20010205110336.A1167@redhat.com> <Pine.LNX.4.10.10102050826440.30798-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.10.10102050826440.30798-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Feb 05, 2001 at 08:36:31AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 05, 2001 at 08:36:31AM -0800, Linus Torvalds wrote:

> Have you ever thought about other things, like networking, special
> devices, stuff like that? They can (and do) have packet boundaries that
> have nothing to do with pages what-so-ever. They can have such notions as
> packets that contain multiple streams in one packet, where it ends up
> being split up into several pieces. Where neither the original packet
> _nor_ the final pieces have _anything_ to do with "pages".
> 
> THERE IS NO PAGE ALIGNMENT.

And kiobufs don't require IO to be page aligned, and they have never
done.  The only page alignment they assume is that if a *single*
scatter-gather element spans multiple pages, then the joins between
those pages occur on page boundaries.

Remember, a kiobuf is only designed to represent one scatter-gather
fragment, not a full sg list.  That was the whole reason for having a
kiovec as a separate concept: if you have more than one independent
fragment in the sg-list, you need more than one kiobuf.

And the reason why we created sg fragments which can span pages was so
that we can encode IOs which interact with the VM: any arbitrary
virtually-contiguous user data buffer can be mapped into a *single*
kiobuf for a write() call, so it's a generic way of supporting things
like O_DIRECT without the IO layers having to know anything about VM
(and Ben's async IO patches also use kiobufs in this way to allow
read()s to write to the user's data buffer once the IO completes,
without having to have a context switch back into that user's
context.)  Similarly, any extent of a file in the page cache can be
encoded in a single kiobuf.

And no, the simpler networking-style sg-list does not cut it for block
device IO, because for block devices, we want to have separate
completion status made available for each individual sg fragment in
the IO.  *That* is why the kiobuf is more heavyweight than the
networking variant: each fragment [kiobuf] in the scatter-gather list
[kiovec] has its own completion information.  

If we have a bunch of separate data buffers queued for sequential disk
IO as a single request, then we still want things like readahead and
error handling to work.  That means that we want the first kiobuf in
the chain to get its completion wakeup as soon as that segment of the
IO is complete, without having to wait for the remaining sectors of
the IO to be transferred.  It also means that if we've done something
like split the IO over a raid stripe, then when an error occurs, we
still want to know which of the callers' buffers succeeded and which
failed.

Yes, I agree that the original kiovec mechanism of using a *kiobuf[]
array to assemble the scatter-gather fragments sucked.  But I don't
believe that just throwing away the concept of kiobuf as a sc-fragment
will work either when it comes to disk IOs: the need for per-fragment
completion is too compelling.  I'd rather shift to allowing kiobufs to
be assembled into linked lists for IO to avoid *kiobuf[] vectors, in
just the same way that we currently chain buffer_heads for IO.  

Cheers,
 Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
