Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129111AbRBAV1Y>; Thu, 1 Feb 2001 16:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129154AbRBAV1O>; Thu, 1 Feb 2001 16:27:14 -0500
Received: from zeus.kernel.org ([209.10.41.242]:46563 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129111AbRBAV0y>;
	Thu, 1 Feb 2001 16:26:54 -0500
Date: Thu, 1 Feb 2001 21:25:08 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Christoph Hellwig <hch@caldera.de>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, bsuparna@in.ibm.com,
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait /notify + callback chains
Message-ID: <20010201212508.G11607@redhat.com>
In-Reply-To: <20010201193221.D11607@redhat.com> <200102012046.VAA16746@ns.caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200102012046.VAA16746@ns.caldera.de>; from hch@caldera.de on Thu, Feb 01, 2001 at 09:46:27PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 01, 2001 at 09:46:27PM +0100, Christoph Hellwig wrote:

> > Right now we can take a kiobuf and turn it into a bunch of
> > buffer_heads for IO.  The io_count lets us track all of those sub-IOs
> > so that we know when all submitted IO has completed, so that we can
> > pass the completion callback back up the chain without having to
> > allocate yet more descriptor structs for the IO.
> 
> > Again, remove this and the IO becomes more heavyweight because we need
> > to create a separate struct for the info.
> 
> No.  Just allow passing the multiple of the devices blocksize over
> ll_rw_block.

That was just one example: you need the sub-ios just as much when
you split up an IO over stripe boundaries in LVM or raid0, for
example.  Secondly, ll_rw_block needs to die anyway: you can expand
the blocksize up to PAGE_SIZE but not beyond, whereas something like
ll_rw_kiobuf can submit a much larger IO atomically (and we have
devices which don't start to deliver good throughput until you use
IO sizes of 1MB or more).

> >> and the lack of
> >> scatter gather in one kiobuf struct (you always need an array)
> 
> > Again, _all_ data being sent down through the block device layer is
> > either in buffer heads or is page aligned.
> 
> That's the point.  You are always talking about the block-layer only.

I'm talking about why the minimal, generic solution doesn't provide
what the block layer needs.


> > Obviously, extra code will be needed to scan kiobufs if we do that,
> > and unless we have both per-page _and_ per-kiobuf start/offset pairs
> > (adding even further to the complexity), those scatter-gather lists
> > would prevent us from carving up a kiobuf into smaller sub-ios without
> > copying the whole (expanded) vector.
> 
> No.  I think I explained that in my last mail.

How?

If I've got a vector (page X, offset 0, length PAGE_SIZE) and I want
to split it in two, I have to make two new vectors (page X, offset 0,
length n) and (page X, offset n, length PAGE_SIZE-n).  That implies
copying both vectors.

If I have a page vector with a single offset/length pair, I can build
a new header with the same vector and modified offset/length to split
the vector in two without copying it.

> > Possibly, but I remain to be convinced, because you may end up with a
> > mechanism which is generic but is not well-tuned for any specific
> > case, so everything goes slower.
> 
> As kiobufs are widely used for real IO, just as containers, this is
> better then nothing.

Surely having all of the subsystems working fast is better still?

> And IMHO a nice generic concepts that lets different subsystems work
> toegther is a _lot_ better then a bunch of over-optimized, rather isolated
> subsytems.  The IO-Lite people have done a nice research of the effect of
> an unified IO-Caching system vs. the typical isolated systems.

I know, and IO-Lite has some major problems (the close integration of
that code into the cache, for example, makes it harder to expose the
zero-copy to user-land).

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
