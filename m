Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129595AbRAISSS>; Tue, 9 Jan 2001 13:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130024AbRAISSI>; Tue, 9 Jan 2001 13:18:08 -0500
Received: from zeus.kernel.org ([209.10.41.242]:14795 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129818AbRAISR4>;
	Tue, 9 Jan 2001 13:17:56 -0500
Date: Tue, 9 Jan 2001 18:10:43 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Christoph Hellwig <hch@caldera.de>,
        "David S. Miller" <davem@redhat.com>, riel@conectiva.com.br,
        netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
Message-ID: <20010109181043.L9321@redhat.com>
In-Reply-To: <20010109152702.E9321@redhat.com> <Pine.LNX.4.30.0101091641180.4491-100000@e2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.30.0101091641180.4491-100000@e2>; from mingo@elte.hu on Tue, Jan 09, 2001 at 05:16:40PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 09, 2001 at 05:16:40PM +0100, Ingo Molnar wrote:
> On Tue, 9 Jan 2001, Stephen C. Tweedie wrote:
> 
> i'm talking about kiovecs not kiobufs (because those are equivalent to a
> fragmented packet - every packet fragment can be anywhere). Initializing a
> kiovec involves touching a dozen cachelines. Keeping structures compressed
> is very important.
> 
> i dont know. I dont think it's necesserily bad for a subsystem to have its
> own 'native structure' how it manages data.

For the transmit case, unless the sender needs seriously fragmented
data, the kiovec is just a kiobuf*.

> i do believe that you are wrong here. We did have a multi-page API between
> sendfile and the TCP layer initially, and it made *absolutely no
> performance difference*.

That may be fine for tcp, but tcp explicitly maintains the state of
the caller and can stream things sequentially to a specific file
descriptor.

The block device layer, on the other hand, has to accept requests _in
any order_ and still reorder them to the optimal elevator order.  The
merging in ll_rw_block is _far_ more expensive than adding a request
to the end of a list.  It's not helped by the fact that each such
request has a buffer_head and a struct request associated with it, so
deconstructing the large IO into buffer_heads results in huge amounts
of data being allocated and deleted.

We could streamline this greatly if the block device layer kept
per-caller context in the way that tcp does, but the block device API
just doesn't work that way.

> > We have already shown that the IO-plugging API sucks, I'm afraid.
> 
> it might not be important to others, but we do hold one particular
> SPECweb99 world record: on 2-way, 2 GB RAM, testing a load with a full
> fileset of ~9 GB. It generates insane block-IO load, and we do beat other
> OSs that have multipage support, including SGI. (and no, it's not due to
> kernel-space acceleration alone this time - it's mostly due to very good
> block-IO performance.) We use Jens Axobe's IO-batching fixes that
> dramatically improve the block scheduler's performance under high load.

Perhaps, but we have proven and significant reductions in CPU
utilisation from eliminating the per-buffer_head API to the block
layer.  Next time M$ gets close to our specweb records, maybe this is
the next place to look for those extra few % points!

> > Gig Ethernet, [...]
> 
> we handle gigabit ethernet with 1.5K zero-copy packets just fine. One
> thing people forget is IRQ throttling: when switching from 1500 byte
> packets to 9000 byte packets then the amount of interrupts drops by a
> factor of 6. Now if the tunings of a driver are not changed accordingly,
> 1500 byte MTU can show dramatically lower performance than 9000 byte MTU.
> But if tuned properly, i see little difference between 1500 byte and 9000
> byte MTU. (when using a good protocol such as TCP.)

Maybe you see good throughput numbers, but I still bet the CPU
utilisation could be bettered significantly with jumbograms.

That's one of the problems with benchmarks: our CPU may be fast enough
that we can keep the IO subsystems streaming, and the benchmark will
not show up any OS bottlenecks, but we may still be consuming far too
much CPU time internally.  That's certainly the case with the block IO
measurements made on XFS: sure, ext2 can keep a fast disk loaded to
pretty much 100%, but at the cost of far more system CPU time than
XFS+pagebuf+kiobuf-IO takes on the same disk.

> > The presence of terrible performance in the old ll_rw_block code is
> > NOT a good excuse for perpetuating that model.
> 
> i'd like to measure this performance problem (because i'd like to
> double-check it) - what measurement method was used?

"time" will show it.  A 13MB/sec raw IO dd using 64K blocks uses
something between 5% and 15% of CPU time on the various systems I've
tested on (up to 30% on an old 486 with a 1540, but that's hardly
representative. :)  The kernel profile clearly shows the buffer
management as the biggest cost, with the SCSI code walking those
buffer heads a close second.

On my main scsi server test box, I get raw 32K reads taking about 7%
system time on the cpu, with make_request and __get_request_wait being
the biggest hogs.

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
