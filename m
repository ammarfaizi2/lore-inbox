Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131370AbRBATgK>; Thu, 1 Feb 2001 14:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131365AbRBATgA>; Thu, 1 Feb 2001 14:36:00 -0500
Received: from zeus.kernel.org ([209.10.41.242]:31430 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131359AbRBATfp>;
	Thu, 1 Feb 2001 14:35:45 -0500
Date: Thu, 1 Feb 2001 19:32:21 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: "Stephen C. Tweedie" <sct@redhat.com>, bsuparna@in.ibm.com,
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait /notify + callback chains
Message-ID: <20010201193221.D11607@redhat.com>
In-Reply-To: <CA2569E6.0051970D.00@d73mta03.au.ibm.com> <20010201160953.A17058@caldera.de> <20010201161615.T11607@redhat.com> <20010201180515.B28007@caldera.de> <20010201174120.A11607@redhat.com> <20010201191403.B448@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010201191403.B448@caldera.de>; from hch@caldera.de on Thu, Feb 01, 2001 at 07:14:03PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 01, 2001 at 07:14:03PM +0100, Christoph Hellwig wrote:
> On Thu, Feb 01, 2001 at 05:41:20PM +0000, Stephen C. Tweedie wrote:
> > > 
> > > We can't allocate a huge kiobuf structure just for requesting one page of
> > > IO.  It might get better with VM-level IO clustering though.
> > 
> > A kiobuf is *much* smaller than, say, a buffer_head, and we currently
> > allocate a buffer_head per block for all IO.
> 
> A kiobuf is 124 bytes,

... the vast majority of which is room for the page vector to expand
without having to be copied.  You don't touch that in the normal case.

> a buffer_head 96.  And a buffer_head is additionally
> used for caching data, a kiobuf not.

Buffer_heads are _sometimes_ used for caching data.  That's one of the
big problems with them, they are too overloaded, being both IO
descriptors _and_ cache descriptors.  If you've got 128k of data to
write out from user space, do you want to set up one kiobuf or 256
buffer_heads?  Buffer_heads become really very heavy indeed once you
start doing non-trivial IO.

> > What is so heavyweight in the current kiobuf (other than the embedded
> > vector, which I've already noted I'm willing to cut)?
> 
> array_len

kiobufs can be reused after IO.  You can depopulate a kiobuf,
repopulate it with new pages and submit new IO without having to
deallocate the kiobuf.  You can't do this without knowing how big the
data vector is.  Removing that functionality will prevent reuse,
making them _more_ heavyweight.

> io_count,

Right now we can take a kiobuf and turn it into a bunch of
buffer_heads for IO.  The io_count lets us track all of those sub-IOs
so that we know when all submitted IO has completed, so that we can
pass the completion callback back up the chain without having to
allocate yet more descriptor structs for the IO.

Again, remove this and the IO becomes more heavyweight because we need
to create a separate struct for the info.

> the presence of wait_queue AND end_io,

That's fine, I'm happy scrapping the wait queue: people can always use
the kiobuf private data field to refer to a wait queue if they want
to.

> and the lack of
> scatter gather in one kiobuf struct (you always need an array)

Again, _all_ data being sent down through the block device layer is
either in buffer heads or is page aligned.  You want us to triple the
size of the "heavyweight" kiobuf's data vector for what gain, exactly?
Obviously, extra code will be needed to scan kiobufs if we do that,
and unless we have both per-page _and_ per-kiobuf start/offset pairs
(adding even further to the complexity), those scatter-gather lists
would prevent us from carving up a kiobuf into smaller sub-ios without
copying the whole (expanded) vector.

That's a _lot_ of extra complexity in the disk IO layers.

I'm all for a fast kiobuf_to_sglist converter.  But I haven't seen any
evidence that such scatter-gather lists will do anything in the block
device case except complicate the code and decrease performance.

> S.th. like:
...
> makes it a lot simpler for the subsytems to integrate.

Possibly, but I remain to be convinced, because you may end up with a
mechanism which is generic but is not well-tuned for any specific
case, so everything goes slower.

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
