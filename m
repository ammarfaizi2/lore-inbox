Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129921AbRARRwD>; Thu, 18 Jan 2001 12:52:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130164AbRARRvx>; Thu, 18 Jan 2001 12:51:53 -0500
Received: from ns.caldera.de ([212.34.180.1]:4105 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129921AbRARRvq>;
	Thu, 18 Jan 2001 12:51:46 -0500
Date: Thu, 18 Jan 2001 18:50:23 +0100
From: Christoph Hellwig <hch@ns.caldera.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rik van Riel <riel@conectiva.com.br>, mingo@elte.hu,
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
Message-ID: <20010118185023.A23381@caldera.de>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Rik van Riel <riel@conectiva.com.br>, mingo@elte.hu,
	linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net
In-Reply-To: <20010118015333.A20691@caldera.de> <Pine.LNX.4.10.10101171659160.10878-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.LNX.4.10.10101171659160.10878-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Jan 17, 2001 at 05:13:31PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 17, 2001 at 05:13:31PM -0800, Linus Torvalds wrote:
> 
> 
> On Thu, 18 Jan 2001, Christoph Hellwig wrote:
> > 
> > /*
> >  * a simple page,offset,legth tuple like Linus wants it
> >  */
> > struct kiobuf2 {
> > 	struct page *   page;   /* The page itself               */
> > 	u_int16_t       offset; /* Offset to start of valid data */
> > 	u_int16_t       length; /* Number of valid bytes of data */
> > };
> 
> Please use "u16". Or "__u16" if you want to export it to user space.

Ok.


> 
> > struct kiovec2 {
> > 	int             nbufs;          /* Kiobufs actually referenced */
> > 	int             array_len;      /* Space in the allocated lists */
> > 	struct kiobuf * bufs;
> 
> Any reason for array_len?

It's usefull for the expand function - but with kiobufs as secondary data
structure it may no more be nessesary.

> Why not just 
> 
> 	int nbufs,
> 	struct kiobuf *bufs;
> 
> 
> Remember: simplicity is a virtue. 
> 
> Simplicity is also what makes it usable for people who do NOT want to have
> huge overhead.
> 
> > 	unsigned int    locked : 1;     /* If set, pages has been locked */
> 
> Remove this. I don't think it's valid to lock the pages. Who wants to use
> this anyway?

E.g. in the block IO pathes the pages have to be locked.
It's also used by free_kiovec to see wether to do unlock_kiovec before.

> 
> > 	/* Always embed enough struct pages for 64k of IO */
> > 	struct kiobuf * buf_array[KIO_STATIC_PAGES];	 
> 
> Kill kill kill kill. 
> 
> If somebody wants to embed a kiovec into their own data structure, THEY
> can decide to add their own buffers etc. A fundamental data structure
> should _never_ make assumptions like this.

Ok.

> 
> > 	/* Private data */
> > 	void *          private;
> > 	
> > 	/* Dynamic state for IO completion: */
> > 	atomic_t        io_count;       /* IOs still in progress */
> 
> What is io_count used for?

In the current buffer_head based IO-scheme it is used to determine wether
all bh request are finished.  It's obsolete once we pass kiobufs to the
low-level drivers.

> 
> > 	int             errno;
> > 
> > 	/* Status of completed IO */
> > 	void (*end_io)	(struct kiovec *); /* Completion callback */
> > 	wait_queue_head_t wait_queue;
> 
> I suspect all of the above ("private", "end_io" etc) should be at a higher
> layer. Not everybody will necessarily need them.
> 
> Remember: if this is to be well designed, we want to have the data
> structures to pass down to low-level drivers etc, that may not want or
> need a lot of high-level stuff. You should not pass down more than the
> driver really needs.
> 
> In the end, the only thing you _know_ a driver will need (assuming that it
> wants these kinds of buffers) is just
> 
> 	int nbufs;
> 	struct biobuf *bufs;
> 
> That's kind of the minimal set. That should be one level of abstraction in
> its own right. 

Ok. Then we need an additional more or less generic object that is used for
passing in a rw_kiovec file operation (and we really want that for many kinds
of IO). I thould mostly be used for communicating to the high-level driver.

/*
 * the name is just plain stupid, but that shouldn't matter
 */
struct vfs_kiovec {
	struct kiovec *	iov;

	/* private data, mostly for the callback */
	void * private;

	/* completion callback */
 	void (*end_io)	(struct vfs_kiovec *);
 	wait_queue_head_t wait_queue;
};

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
