Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129090AbRBBMD0>; Fri, 2 Feb 2001 07:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129031AbRBBMDH>; Fri, 2 Feb 2001 07:03:07 -0500
Received: from ns.caldera.de ([212.34.180.1]:21261 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129090AbRBBMC4>;
	Fri, 2 Feb 2001 07:02:56 -0500
Date: Fri, 2 Feb 2001 13:02:28 +0100
From: Christoph Hellwig <hch@caldera.de>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Christoph Hellwig <hch@caldera.de>, Steve Lord <lord@sgi.com>,
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait /notify + callback chains
Message-ID: <20010202130228.B12245@caldera.de>
Mail-Followup-To: "Stephen C. Tweedie" <sct@redhat.com>,
	Steve Lord <lord@sgi.com>, linux-kernel@vger.kernel.org,
	kiobuf-io-devel@lists.sourceforge.net,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20010201174946.B11607@redhat.com> <200102012033.VAA15590@ns.caldera.de> <20010201220744.K11607@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <20010201220744.K11607@redhat.com>; from sct@redhat.com on Thu, Feb 01, 2001 at 10:07:44PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2001 at 10:07:44PM +0000, Stephen C. Tweedie wrote:
> No.  I want something good for zero-copy IO in general, but a lot of
> that concerns the problem of interacting with the user, and the basic
> center of that interaction in 99% of the interesting cases is either a
> user VM buffer or the page cache --- all of which are page-aligned.

Yes.

> If you look at the sorts of models being proposed (even by Linus) for
> splice, you get
> 
> 	len = prepare_read();
> 	prepare_write();
> 	pull_fd();
> 	commit_write();

Yepp.

> in which the read is being pulled into a known location in the page
> cache -- it's page-aligned, again.  I'm perfectly willing to accept
> that there may be a need for scatter-gather boundaries including
> non-page-aligned fragments in this model, but I can't see one if
> you're using the page cache as a mediator, nor if you're doing it
> through a user mmapped buffer.

True.

> The only reason you need finer scatter-gather boundaries --- and it
> may be a compelling reason --- is if you are merging multiple IOs
> together into a single device-level IO.  That makes perfect sense for
> the zerocopy tcp case where you're doing MSG_MORE-type coalescing.  It
> doesn't help the existing SGI kiobuf block device code, because that
> performs its merging in the filesystem layers and the block device
> code just squirts the IOs to the wire as-is,

Yes - but that is no soloution for a generic model.  AFAICS even XFS
falls back to buffer_head's for small requests.

> but if we want to start
> merging those kiobuf-based IOs within make_request() then the block
> device layer may want it too.

Yes.

> And Linus is right, the old way of using a *kiobuf[] for that was
> painful, but the solution of adding start/length to every entry in
> the page vector just doesn't sit right with many components of the
> block device environment either.

What do you thing is the alternative?

> I may still be persuaded that we need the full scatter-gather list
> fields throughout, but for now I tend to think that, at least in the
> disk layers, we may get cleaner results by allow linked lists of
> page-aligned kiobufs instead.  That allows for merging of kiobufs
> without having to copy all of the vector information each time.

But it will have the same problems as the array soloution: there will
be one complete kio structure for each kiobuf, with it's own end_io
callback, etc.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
