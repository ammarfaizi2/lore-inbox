Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129468AbRBAWJv>; Thu, 1 Feb 2001 17:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129489AbRBAWJl>; Thu, 1 Feb 2001 17:09:41 -0500
Received: from zeus.kernel.org ([209.10.41.242]:14025 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129468AbRBAWJg>;
	Thu, 1 Feb 2001 17:09:36 -0500
Date: Thu, 1 Feb 2001 22:07:44 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Christoph Hellwig <hch@caldera.de>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Steve Lord <lord@sgi.com>,
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait /notify + callback chains
Message-ID: <20010201220744.K11607@redhat.com>
In-Reply-To: <20010201174946.B11607@redhat.com> <200102012033.VAA15590@ns.caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200102012033.VAA15590@ns.caldera.de>; from hch@caldera.de on Thu, Feb 01, 2001 at 09:33:27PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 01, 2001 at 09:33:27PM +0100, Christoph Hellwig wrote:

> I think you want the whole kio concept only for disk-like IO.  

No.  I want something good for zero-copy IO in general, but a lot of
that concerns the problem of interacting with the user, and the basic
center of that interaction in 99% of the interesting cases is either a
user VM buffer or the page cache --- all of which are page-aligned.  

If you look at the sorts of models being proposed (even by Linus) for
splice, you get

	len = prepare_read();
	prepare_write();
	pull_fd();
	commit_write();

in which the read is being pulled into a known location in the page
cache -- it's page-aligned, again.  I'm perfectly willing to accept
that there may be a need for scatter-gather boundaries including
non-page-aligned fragments in this model, but I can't see one if
you're using the page cache as a mediator, nor if you're doing it
through a user mmapped buffer.

The only reason you need finer scatter-gather boundaries --- and it
may be a compelling reason --- is if you are merging multiple IOs
together into a single device-level IO.  That makes perfect sense for
the zerocopy tcp case where you're doing MSG_MORE-type coalescing.  It
doesn't help the existing SGI kiobuf block device code, because that
performs its merging in the filesystem layers and the block device
code just squirts the IOs to the wire as-is, but if we want to start
merging those kiobuf-based IOs within make_request() then the block
device layer may want it too.

And Linus is right, the old way of using a *kiobuf[] for that was
painful, but the solution of adding start/length to every entry in
the page vector just doesn't sit right with many components of the
block device environment either.

I may still be persuaded that we need the full scatter-gather list
fields throughout, but for now I tend to think that, at least in the
disk layers, we may get cleaner results by allow linked lists of
page-aligned kiobufs instead.  That allows for merging of kiobufs
without having to copy all of the vector information each time.

The killer, however, is what happens if you want to split such a
merged kiobuf.  Right now, that's something that I can only imagine
happening in the block layers if we start encoding buffer_head chains
as kiobufs, but if we do that in the future, or if we start merging
genuine kiobuf requests requests, then doing that split later on (for
raid0 etc) may require duplicating whole chains of kiobufs.  At that
point, just doing scatter-gather lists is cleaner.

But for now, the way to picture what I'm trying to achieve is that
kiobufs are a bit like buffer_heads --- they represent the physical
pages of some VM object that a higher layer has constructed, such as
the page cache or a user VM buffer.  You can chain these objects
together for IO, but that doesn't stop the individual objects from
being separate entities with independent IO completion callbacks to be
honoured.  

Cheers,
 Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
