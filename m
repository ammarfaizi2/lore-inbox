Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130092AbRARAzM>; Wed, 17 Jan 2001 19:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130388AbRARAzC>; Wed, 17 Jan 2001 19:55:02 -0500
Received: from ns.caldera.de ([212.34.180.1]:30985 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S130092AbRARAys>;
	Wed, 17 Jan 2001 19:54:48 -0500
Date: Thu, 18 Jan 2001 01:53:33 +0100
From: Christoph Hellwig <hch@ns.caldera.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Christoph Hellwig <hch@ns.caldera.de>,
        Linus Torvalds <torvalds@transmeta.com>, mingo@elte.hu,
        linux-kernel@vger.kernel.org
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
Message-ID: <20010118015333.A20691@caldera.de>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	Christoph Hellwig <hch@ns.caldera.de>,
	Linus Torvalds <torvalds@transmeta.com>, mingo@elte.hu,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010110084235.A365@caldera.de> <Pine.LNX.4.31.0101180104050.31432-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.LNX.4.31.0101180104050.31432-100000@localhost.localdomain>; from riel@conectiva.com.br on Thu, Jan 18, 2001 at 01:05:43AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2001 at 01:05:43AM +1100, Rik van Riel wrote:
> On Wed, 10 Jan 2001, Christoph Hellwig wrote:
> 
> > Simple.  Because I stated before that I DON'T even want the
> > networking to use kiobufs in lower layers.  My whole argument is
> > to pass a kiovec into the fileop instead of a page, because it
> > makes sense for other drivers to use multiple pages,
> 
> Now wouldn't it be great if we had one type of data
> structure that would work for both the network layer
> and the block layer (and v4l, ...)  ?

Sure it would be nice, and IIRC that was what the kiobuf stuff was
designed for.  But it looks like it doesn't do well for the networking
(and maybe other) guys.

That means we have to find something that might be worth paying a little
overhead for in all layers, but that on the other hand is usable evrywhere.

So after the last flame^H^H^H^H^Hthread I've come up in my mind with the
following structures:

/*
 * a simple page,offset,legth tuple like Linus wants it
 */
struct kiobuf2 {
	struct page *   page;   /* The page itself               */
	u_int16_t       offset; /* Offset to start of valid data */
	u_int16_t       length; /* Number of valid bytes of data */
};

/*
 * A container for the tuples - it is actually pretty similar to old
 * kiobuf, but on the other hand allows SG
 */
struct kiovec2 {
	int             nbufs;          /* Kiobufs actually referenced */
	int             array_len;      /* Space in the allocated lists */

	struct kiobuf * bufs;

	unsigned int    locked : 1;     /* If set, pages has been locked */

	/* Always embed enough struct pages for 64k of IO */
	struct kiobuf * buf_array[KIO_STATIC_PAGES];	 

	/* Private data */
	void *          private;
	
	/* Dynamic state for IO completion: */
	atomic_t        io_count;       /* IOs still in progress */
	int             errno;

	/* Status of completed IO */
	void (*end_io)	(struct kiovec *); /* Completion callback */
	wait_queue_head_t wait_queue;
};


We don't need the page-length/offset in the usual block-io path, but on
the other hand, if we get a common interface for it...

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
