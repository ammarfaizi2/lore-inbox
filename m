Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129884AbRAIQRW>; Tue, 9 Jan 2001 11:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131088AbRAIQRM>; Tue, 9 Jan 2001 11:17:12 -0500
Received: from chiara.elte.hu ([157.181.150.200]:18188 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129884AbRAIQRF>;
	Tue, 9 Jan 2001 11:17:05 -0500
Date: Tue, 9 Jan 2001 17:16:40 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Christoph Hellwig <hch@caldera.de>, "David S. Miller" <davem@redhat.com>,
        <riel@conectiva.com.br>, <netdev@oss.sgi.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <20010109152702.E9321@redhat.com>
Message-ID: <Pine.LNX.4.30.0101091641180.4491-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 9 Jan 2001, Stephen C. Tweedie wrote:

> > we do have SLAB [which essentially caches structures, on a per-CPU basis]
> > which i did take into account, but still, initializing a 600+ byte kiovec
> > is probably more work than the rest of sending a packet! I mean i'd love
> > to eliminate the 200+ bytes skb initialization as well, it shows up.
>
> Reusing a kiobuf for a request involves setting up the length, offset
> and maybe errno fields, and writing the struct page *'s into the
> maplist[].  Nothing more.

i'm talking about kiovecs not kiobufs (because those are equivalent to a
fragmented packet - every packet fragment can be anywhere). Initializing a
kiovec involves touching a dozen cachelines. Keeping structures compressed
is very important.

i dont know. I dont think it's necesserily bad for a subsystem to have its
own 'native structure' how it manages data.

> We've already got measurements showing how insane this is.  Raw IO
> requests, plus internal pagebuf contiguous requests from XFS, have to
> get broken down into page-sized chunks by the current ll_rw_block()
> API, only to get reassembled by the make_request code.  It's
> *enormous* overhead, and the kiobuf-based disk IO code demonstrates
> this clearly.

i do believe that you are wrong here. We did have a multi-page API between
sendfile and the TCP layer initially, and it made *absolutely no
performance difference*. But it was more complex, and harder to fix. And
we had to keep intelligent buffering/clustering/merging in any case,
because some native Linux interfaces such as write() and read() have byte
granularity.

so unless there is some fundamental difference between the two approaches,
i dont buy this argument. I dont necesserily say that your measurements
are wrong, i'm saying that the performance analysis is wrong.

> We have already shown that the IO-plugging API sucks, I'm afraid.

it might not be important to others, but we do hold one particular
SPECweb99 world record: on 2-way, 2 GB RAM, testing a load with a full
fileset of ~9 GB. It generates insane block-IO load, and we do beat other
OSs that have multipage support, including SGI. (and no, it's not due to
kernel-space acceleration alone this time - it's mostly due to very good
block-IO performance.) We use Jens Axobe's IO-batching fixes that
dramatically improve the block scheduler's performance under high load.

> > > and even in networking the 1.5K packet limit kills us in some cases
> > > and we need an interface capable of generating jumbograms.
> >
> > which cases?
>
> Gig Ethernet, [...]

we handle gigabit ethernet with 1.5K zero-copy packets just fine. One
thing people forget is IRQ throttling: when switching from 1500 byte
packets to 9000 byte packets then the amount of interrupts drops by a
factor of 6. Now if the tunings of a driver are not changed accordingly,
1500 byte MTU can show dramatically lower performance than 9000 byte MTU.
But if tuned properly, i see little difference between 1500 byte and 9000
byte MTU. (when using a good protocol such as TCP.)

> > nothing prevents the introduction of specialized interfaces - if they feel
> > like they can get enough traction.
>
> So you mean we'll introduce two separate APIs for general zero-copy,
> just to get around the problems in the single-page-based on?

no. But i think that none of the mainstream protocols or APIs mandate a
multi-page interface - i do think that the performance problems mentioned
were mis-analyzed. I'd call the multi-page API thing an urban legend.
Nobody in their right mind can claim that a series of function calls shows
any difference in *block IO* performance, compared to a multi-page API
(which has an additional vector-setup cost). Only functional differences
can explain any measured performance difference - and for those
merging/clustering bugs, multipage support is only a workaround.

> > I was talking about the normal Linux IO
> > APIs, read()/write()/sendfile(), which are byte granularity and invoke an
> > almost mandatory buffering/clustering mechanizm in every kernel subsystem
> > they deal with.
>
> Only tcp and ll_rw_block.  ll_rw_block has already been fixed in the
> SGI patches, and gets _much_ better performance as a result. [...]

as mentioned above, i think this is not due to going multipage.

> The presence of terrible performance in the old ll_rw_block code is
> NOT a good excuse for perpetuating that model.

i'd like to measure this performance problem (because i'd like to
double-check it) - what measurement method was used?

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
