Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278722AbRJZQFu>; Fri, 26 Oct 2001 12:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278723AbRJZQFh>; Fri, 26 Oct 2001 12:05:37 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34321 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278722AbRJZQF1>; Fri, 26 Oct 2001 12:05:27 -0400
Date: Fri, 26 Oct 2001 09:04:04 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Zlatko Calusic <zlatko.calusic@iskon.hr>
cc: Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
        <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: xmm2 - monitor Linux MM active/inactive lists graphically
In-Reply-To: <dnpu7asb37.fsf@magla.zg.iskon.hr>
Message-ID: <Pine.LNX.4.33.0110260834540.2054-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 26 Oct 2001, Zlatko Calusic wrote:
>
> OK. Anyway, neither configuration works well, so the problem might be
> somewhere else.
>
> While at it, could you give short explanation of those two parameters?

Did you try the ones 2.4.14-2 does?

Basically, the "queue_nr_requests" means how many requests there can be
for this queue. Half of them are allocated to reads, half of them are
allocated to writes.

The "batch_requests" thing is something that kicks in when the queue has
emptied - we don't want to "trickle" requests to users, because if we do
that means that a new large write will not be able to merge its new
requests sanely because it basically has to do them one at a time. So when
we run out of requests (ie "queue_nr_requests" isn't enough), we start
putting the freed-up requests on a "pending" list, and we release them
only when the pending list is bigger than "batch_requests".

Now, one thing to remember is that "queue_nr_requests" is for the whole
queue (half of them for reads, half for writes), and "batch_requests" is a
per-type thing (ie we batch reads and writes separately). So
"batch_requests" must be less than half of "queue_nr_requests", or we will
never release anything at all.

Now, in Alan's tree, there is a separate tuning thing, which is the "max
nr of _sectors_ in flight", which in my opinion is pretty bogus. It's
really a memory-management thing, but it also does something else: it has
low-and-high water-marks, and those might well be a good idea. It is
possible that we should just ditch the "batch_requests" thing, and use the
watermarks instead.

Side note: all of this is relevant really only for writes - reads pretty
much only care about the maximum queue-size, and it's very hard to get a
_huge_ queue-size with reads unless you do tons of read-ahead.

Now, the "batching" is technically equivalent with water-marking if there
is _one_ writer. But if there are multiple writers, water-marking may
actually has some advantages: it might allow the other writer to make some
progress when the first one has stopped, while the batching will stop
everybody until the batch is released. Who knows.

Anyway, the reason I think Alan's "max nr of sectors" is bogus is because:

 - it's a global count, and if you have 10 controllers and want to write
   to all 10, you _should_ be able to - you can write 10 times as many
   requests in the same latency, so there is nothing "global" with it.

   (It turns out that one advantage of the globalism is that it ends up
   limiting MM write-outs, but I personally think that is a _MM_ thing, ie
   we might want to have a "we have half of all our pages in flight, we
   have to throttle now" thing in "writepage()", not in the queue)

 - "nr of sectors" has very little to do with request latency on most
   hardware. You can do 255 sectors (ie one request) almost as fast as you
   can do just one, if you do them in one request. While just _two_
   sectors might be much slower than the 255, if they are in separate
   requests and cause seeking.

   So from a latency standpoint, the "request" is a much better number.

So Alan almost never throttles on requests (on big machines, the -ac tree
allows thousands of requests in flight per queue), while he _does_ have
this water-marking for sectors.

So I have two suspicions:

 - 128 requests (ie 64 for writes) like the default kernel should be
   _plenty_ enough to keep the disks busy, especially for streaming
   writes. It's small enough that you don't get the absolutely _huge_
   spikes you get with thousands of requests, while being large enough for
   fast writers that even if they _do_ block for 32 of the 64 requests,
   they'll have time to refill the next 32 long before the 32 pending one
   have finished.

   Also: limiting the write queue to 128 requests means that you can
   pretty much guarantee that you can get at least a few read requests
   per second, even if the write queue is constantly full, and even if
   your reader is serialized.

BUT:

 - the hard "batch" count is too harsh. It works as a watermark in the
   degenerate case, but doesn't allow a second writer to use up _some_ of
   the requests while the first writer is blocked due to watermarking.

   So with batching, when the queue is full and another process wants
   memory, that _OTHER_ process will also always block untilt he queue has
   emptied.

   With watermarks, when the writer has filled up the queue and starts
   waiting, other processes can still do some writing as long as they
   don't fill up the queue again. So if you have MM pressure but the
   writer is blocked (and some requests _have_ completed, but the writer
   waits for the low-water-mark), you can still push out requests.

   That's also likely to be a lot more fair - batching tends to give the
   whole batch to the big writer, while watermarking automatically allows
   others to get a look at the queue.

I'll whip up a patch for testing (2.4.14-2 made the batching slightly
saner, but the same "hard" behaviour is pretty much unavoidable with
batching)

			Linus

