Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129525AbRBASO7>; Thu, 1 Feb 2001 13:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130203AbRBASOk>; Thu, 1 Feb 2001 13:14:40 -0500
Received: from ns.caldera.de ([212.34.180.1]:64518 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129525AbRBASO1>;
	Thu, 1 Feb 2001 13:14:27 -0500
Date: Thu, 1 Feb 2001 19:14:03 +0100
From: Christoph Hellwig <hch@caldera.de>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: bsuparna@in.ibm.com, linux-kernel@vger.kernel.org,
        kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait /notify + callback chains
Message-ID: <20010201191403.B448@caldera.de>
Mail-Followup-To: "Stephen C. Tweedie" <sct@redhat.com>,
	bsuparna@in.ibm.com, linux-kernel@vger.kernel.org,
	kiobuf-io-devel@lists.sourceforge.net
In-Reply-To: <CA2569E6.0051970D.00@d73mta03.au.ibm.com> <20010201160953.A17058@caldera.de> <20010201161615.T11607@redhat.com> <20010201180515.B28007@caldera.de> <20010201174120.A11607@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <20010201174120.A11607@redhat.com>; from sct@redhat.com on Thu, Feb 01, 2001 at 05:41:20PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2001 at 05:41:20PM +0000, Stephen C. Tweedie wrote:
> Hi,
> 
> On Thu, Feb 01, 2001 at 06:05:15PM +0100, Christoph Hellwig wrote:
> > On Thu, Feb 01, 2001 at 04:16:15PM +0000, Stephen C. Tweedie wrote:
> > > > 
> > > > No, and with the current kiobufs it would not make sense, because they
> > > > are to heavy-weight.
> > > 
> > > Really?  In what way?  
> > 
> > We can't allocate a huge kiobuf structure just for requesting one page of
> > IO.  It might get better with VM-level IO clustering though.
> 
> A kiobuf is *much* smaller than, say, a buffer_head, and we currently
> allocate a buffer_head per block for all IO.

A kiobuf is 124 bytes, a buffer_head 96.  And a buffer_head is additionally
used for caching data, a kiobuf not.

> 
> A kiobuf contains enough embedded page vector space for 16 pages by
> default, but I'm happy enough to remove that if people want.  However,
> note that that memory is not initialised, so there is no memory access
> cost at all for that empty space.  Remove that space and instead of
> one memory allocation per kiobuf, you get two, so the cost goes *UP*
> for small IOs.

You could still embed it into a surrounding structure, even if there are cases
where an additional memory allocation is needed, yes.

> 
> > > > With page,length,offsett iobufs this makes sense
> > > > and is IMHO the way to go.
> > > 
> > > What, you mean adding *extra* stuff to the heavyweight kiobuf makes it
> > > lean enough to do the job??
> > 
> > No.  I was speaking abou the light-weight kiobuf Linux & Me discussed on
> > lkml some time ago (though I'd much more like to call it kiovec analogous
> > to BSD iovecs).
> 
> What is so heavyweight in the current kiobuf (other than the embedded
> vector, which I've already noted I'm willing to cut)?

array_len, io_count, the presence of wait_queue AND end_io, and the lack of
scatter gather in one kiobuf struct (you always need an array), and AFAICS
that is what the networking guys dislike.

They often just want multiple buffers in one physical page, and and array of
those.

Now one could say: just let the networkers use their own kind of buffers
(and that's exactly what is done in the zerocopy patches), but that again leds
to inefficient buffer passing and ungeneric IO handling.

S.th. like:

struct kiovec {
	struct page *           kv_page;        /* physical page        */
	u_short                 kv_offset;      /* offset into page     */
	u_short                 kv_length;      /* data length          */
};
			 
enum kio_flags {
	KIO_LOANED,     /* the calling subsystem wants this buf back    */
	KIO_GIFTED,     /* thanks for the buffer, man!                  */
	KIO_COW         /* copy on write (XXX: not yet)                 */
};


struct kio {
	struct kiovec *         kio_data;       /* our kiovecs          */
	int                     kio_ndata;      /* # of kiovecs         */
	int                     kio_flags;      /* loaned or giftet?    */
	void *                  kio_priv;       /* caller private data  */
	wait_queue_head_t       kio_wait;	/* wait queue           */
};

makes it a lot simpler for the subsytems to integrate.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
