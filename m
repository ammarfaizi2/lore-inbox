Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129700AbRBBEUA>; Thu, 1 Feb 2001 23:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130001AbRBBETu>; Thu, 1 Feb 2001 23:19:50 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:62514 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129700AbRBBETg>; Thu, 1 Feb 2001 23:19:36 -0500
Date: Thu, 1 Feb 2001 23:18:56 -0500 (EST)
From: <bcrl@redhat.com>
To: Christoph Hellwig <hch@caldera.de>
cc: "Stephen C. Tweedie" <sct@redhat.com>, <bsuparna@in.ibm.com>,
        <linux-kernel@vger.kernel.org>,
        <kiobuf-io-devel@lists.sourceforge.net>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
 /notify + callback chains
In-Reply-To: <20010201191403.B448@caldera.de>
Message-ID: <Pine.LNX.4.30.0102012311400.4607-100000@today.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Feb 2001, Christoph Hellwig wrote:

> A kiobuf is 124 bytes, a buffer_head 96.  And a buffer_head is additionally
> used for caching data, a kiobuf not.

Go measure the cost of a distant cache miss, then complain about having
everything in one structure.  Also, 1 kiobuf maps 16-128 times as much
data as a single buffer head.

> enum kio_flags {
> 	KIO_LOANED,     /* the calling subsystem wants this buf back    */
> 	KIO_GIFTED,     /* thanks for the buffer, man!                  */
> 	KIO_COW         /* copy on write (XXX: not yet)                 */
> };

This is a Really Bad Idea.  Having semantics depend on a subtle flag
determined by a caller is a sure way to

>
>
> struct kio {
> 	struct kiovec *         kio_data;       /* our kiovecs          */
> 	int                     kio_ndata;      /* # of kiovecs         */
> 	int                     kio_flags;      /* loaned or giftet?    */
> 	void *                  kio_priv;       /* caller private data  */
> 	wait_queue_head_t       kio_wait;	/* wait queue           */
> };
>
> makes it a lot simpler for the subsytems to integrate.

Keep in mind that using distant memory allocations for kio_data will incur
additional cache misses.  The atomic count is probably going to be widely
used; I see it being applicable to the network stack, block io layers and
others.  Also, how is information about io completion status passed back
to the caller?  That information is required across layers so that io can
be properly aborted or proceed with the partial amount of io.  Add those
back in and we're right back to the original kiobuf structure.

		-ben

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
