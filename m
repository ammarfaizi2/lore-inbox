Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131198AbRBAUrK>; Thu, 1 Feb 2001 15:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131476AbRBAUrB>; Thu, 1 Feb 2001 15:47:01 -0500
Received: from ns.caldera.de ([212.34.180.1]:4616 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S131198AbRBAUqr>;
	Thu, 1 Feb 2001 15:46:47 -0500
Date: Thu, 1 Feb 2001 21:46:27 +0100
Message-Id: <200102012046.VAA16746@ns.caldera.de>
From: Christoph Hellwig <hch@caldera.de>
To: sct@redhat.com ("Stephen C. Tweedie")
Cc: bsuparna@in.ibm.com, linux-kernel@vger.kernel.org,
        kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait /notify + callback chains
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <20010201193221.D11607@redhat.com>
User-Agent: tin/1.4.1-19991201 ("Polish") (UNIX) (Linux/2.2.14 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010201193221.D11607@redhat.com> you wrote:
> Buffer_heads are _sometimes_ used for caching data.

Actually they are mostly used, but that should have any value for the
discussion...

> That's one of the
> big problems with them, they are too overloaded, being both IO
> descriptors _and_ cache descriptors.

Agreed.

> If you've got 128k of data to
> write out from user space, do you want to set up one kiobuf or 256
> buffer_heads?  Buffer_heads become really very heavy indeed once you
> start doing non-trivial IO.

Sure - I was never arguing in favor of buffer_head's ...

>> > What is so heavyweight in the current kiobuf (other than the embedded
>> > vector, which I've already noted I'm willing to cut)?
>> 
>> array_len

> kiobufs can be reused after IO.  You can depopulate a kiobuf,
> repopulate it with new pages and submit new IO without having to
> deallocate the kiobuf.  You can't do this without knowing how big the
> data vector is.  Removing that functionality will prevent reuse,
> making them _more_ heavyweight.

>> io_count,

> Right now we can take a kiobuf and turn it into a bunch of
> buffer_heads for IO.  The io_count lets us track all of those sub-IOs
> so that we know when all submitted IO has completed, so that we can
> pass the completion callback back up the chain without having to
> allocate yet more descriptor structs for the IO.

> Again, remove this and the IO becomes more heavyweight because we need
> to create a separate struct for the info.

No.  Just allow passing the multiple of the devices blocksize over
ll_rw_block.  XFS is doing that and it just needs an audit of the lesser
used block drivers.

>> and the lack of
>> scatter gather in one kiobuf struct (you always need an array)

> Again, _all_ data being sent down through the block device layer is
> either in buffer heads or is page aligned.

That's the point.  You are always talking about the block-layer only.
And I think it should be generic instead.
Looks like that is the major point.

> You want us to triple the
> size of the "heavyweight" kiobuf's data vector for what gain, exactly?

double.

> Obviously, extra code will be needed to scan kiobufs if we do that,
> and unless we have both per-page _and_ per-kiobuf start/offset pairs
> (adding even further to the complexity), those scatter-gather lists
> would prevent us from carving up a kiobuf into smaller sub-ios without
> copying the whole (expanded) vector.

No.  I think I explained that in my last mail.

> That's a _lot_ of extra complexity in the disk IO layers.

> Possibly, but I remain to be convinced, because you may end up with a
> mechanism which is generic but is not well-tuned for any specific
> case, so everything goes slower.

As kiobufs are widely used for real IO, just as containers, this is
better then nothing.
And IMHO a nice generic concepts that lets different subsystems work
toegther is a _lot_ better then a bunch of over-optimized, rather isolated
subsytems.  The IO-Lite people have done a nice research of the effect of
an unified IO-Caching system vs. the typical isolated systems.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
