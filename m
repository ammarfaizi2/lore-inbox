Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130651AbRARBPj>; Wed, 17 Jan 2001 20:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130664AbRARBP3>; Wed, 17 Jan 2001 20:15:29 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:22289 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130651AbRARBPT>; Wed, 17 Jan 2001 20:15:19 -0500
Date: Wed, 17 Jan 2001 17:13:31 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Hellwig <hch@ns.caldera.de>
cc: Rik van Riel <riel@conectiva.com.br>, mingo@elte.hu,
        linux-kernel@vger.kernel.org
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <20010118015333.A20691@caldera.de>
Message-ID: <Pine.LNX.4.10.10101171659160.10878-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 18 Jan 2001, Christoph Hellwig wrote:
> 
> /*
>  * a simple page,offset,legth tuple like Linus wants it
>  */
> struct kiobuf2 {
> 	struct page *   page;   /* The page itself               */
> 	u_int16_t       offset; /* Offset to start of valid data */
> 	u_int16_t       length; /* Number of valid bytes of data */
> };

Please use "u16". Or "__u16" if you want to export it to user space.

> struct kiovec2 {
> 	int             nbufs;          /* Kiobufs actually referenced */
> 	int             array_len;      /* Space in the allocated lists */
> 	struct kiobuf * bufs;

Any reason for array_len?

Why not just 

	int nbufs,
	struct kiobuf *bufs;


Remember: simplicity is a virtue. 

Simplicity is also what makes it usable for people who do NOT want to have
huge overhead.

> 	unsigned int    locked : 1;     /* If set, pages has been locked */

Remove this. I don't think it's valid to lock the pages. Who wants to use
this anyway?

> 	/* Always embed enough struct pages for 64k of IO */
> 	struct kiobuf * buf_array[KIO_STATIC_PAGES];	 

Kill kill kill kill. 

If somebody wants to embed a kiovec into their own data structure, THEY
can decide to add their own buffers etc. A fundamental data structure
should _never_ make assumptions like this.

> 	/* Private data */
> 	void *          private;
> 	
> 	/* Dynamic state for IO completion: */
> 	atomic_t        io_count;       /* IOs still in progress */

What is io_count used for?

> 	int             errno;
> 
> 	/* Status of completed IO */
> 	void (*end_io)	(struct kiovec *); /* Completion callback */
> 	wait_queue_head_t wait_queue;

I suspect all of the above ("private", "end_io" etc) should be at a higher
layer. Not everybody will necessarily need them.

Remember: if this is to be well designed, we want to have the data
structures to pass down to low-level drivers etc, that may not want or
need a lot of high-level stuff. You should not pass down more than the
driver really needs.

In the end, the only thing you _know_ a driver will need (assuming that it
wants these kinds of buffers) is just

	int nbufs;
	struct biobuf *bufs;

That's kind of the minimal set. That should be one level of abstraction in
its own right. 

Never over-design. Never think "Hmm, maybe somebody would find this
useful". Start from what you know people _have_ to have, and try to make
that set smaller. When you can make it no smaller, you've reached one
point. That's a good point to start from - use that for some real
implementation.

Once you've gotten that far, you can see how well you can embed the lower
layers into higher layers. That does _not_ mean that the lower layers
should know about the high-level data structures. Try to avoid pushing
down abstractions too far. Maybe you'll want to push down the error code.
But maybe not. And you should NOT link the callback with the vector of
IO's: you may find (in fact, I bet you _will_ find), that the lowest level
will want a callback to call up to when it is ready, and that layer may
want _another_ callback to call up to higher levels.

Imagine, for example, the network driver telling the IP layer that "ok,
packet sent". That's _NOT_ the same callback as the TCP layer telling the
upper layers that the packet data has been sent and successfully
acknowledged, and that the data structures can be free'd now. They are at
two completely different levels of abstraction, and one level needing
something doesn't need that the other level should necessarily even care.

Don't imagine that everybody wants the same data structure, and that that
data structure should thus be very generic. Genericity kills good ideas.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
