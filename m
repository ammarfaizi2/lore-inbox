Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129031AbRBBMM6>; Fri, 2 Feb 2001 07:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129103AbRBBMMt>; Fri, 2 Feb 2001 07:12:49 -0500
Received: from ns.caldera.de ([212.34.180.1]:25357 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129031AbRBBMMe>;
	Fri, 2 Feb 2001 07:12:34 -0500
Date: Fri, 2 Feb 2001 13:12:16 +0100
From: Christoph Hellwig <hch@caldera.de>
To: bcrl@redhat.com
Cc: Christoph Hellwig <hch@caldera.de>, "Stephen C. Tweedie" <sct@redhat.com>,
        bsuparna@in.ibm.com, linux-kernel@vger.kernel.org,
        kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait /notify + callback chains
Message-ID: <20010202131216.A13791@caldera.de>
Mail-Followup-To: bcrl@redhat.com, "Stephen C. Tweedie" <sct@redhat.com>,
	bsuparna@in.ibm.com, linux-kernel@vger.kernel.org,
	kiobuf-io-devel@lists.sourceforge.net
In-Reply-To: <20010201191403.B448@caldera.de> <Pine.LNX.4.30.0102012311400.4607-100000@today.toronto.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.LNX.4.30.0102012311400.4607-100000@today.toronto.redhat.com>; from bcrl@redhat.com on Thu, Feb 01, 2001 at 11:18:56PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2001 at 11:18:56PM -0500, bcrl@redhat.com wrote:
> On Thu, 1 Feb 2001, Christoph Hellwig wrote:
> 
> > A kiobuf is 124 bytes, a buffer_head 96.  And a buffer_head is additionally
> > used for caching data, a kiobuf not.
> 
> Go measure the cost of a distant cache miss, then complain about having
> everything in one structure.  Also, 1 kiobuf maps 16-128 times as much
> data as a single buffer head.

I'd never dipute that.  It was just an answers to Stephen's "a kiobuf is
already smaller".

> > enum kio_flags {
> > 	KIO_LOANED,     /* the calling subsystem wants this buf back    */
> > 	KIO_GIFTED,     /* thanks for the buffer, man!                  */
> > 	KIO_COW         /* copy on write (XXX: not yet)                 */
> > };
> 
> This is a Really Bad Idea.  Having semantics depend on a subtle flag
> determined by a caller is a sure way to

The semantics aren't different for the using subsystem.  LOANED vs GIFTED
is an issue for the free function, COW will probably be a page-level mm
thing - though I haven't thought a lot about it yet an am not sure wether
it actually makes sense.

> 
> >
> >
> > struct kio {
> > 	struct kiovec *         kio_data;       /* our kiovecs          */
> > 	int                     kio_ndata;      /* # of kiovecs         */
> > 	int                     kio_flags;      /* loaned or giftet?    */
> > 	void *                  kio_priv;       /* caller private data  */
> > 	wait_queue_head_t       kio_wait;	/* wait queue           */
> > };
> >
> > makes it a lot simpler for the subsytems to integrate.
> 
> Keep in mind that using distant memory allocations for kio_data will incur
> additional cache misses.

It could also be a [0] array at the end, allowing for a single allocation,
but that looks more like a implementation detail then a design problem to me.

> The atomic count is probably going to be widely
> used; I see it being applicable to the network stack, block io layers and
> others.

Hmm.  Currently it is used only for the multiple buffer_head's per iobuf
cruft, and I don't see why multiple outstanding IOs should be noted in a
kiobuf.

> Also, how is information about io completion status passed back
> to the caller?

Yes, there needs to be an kio_errno field - though I wanted to get rid of
it I had to readd in in later versions of my design.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
