Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278634AbRJ1SsT>; Sun, 28 Oct 2001 13:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278636AbRJ1SsA>; Sun, 28 Oct 2001 13:48:00 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:54537 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278634AbRJ1Sru>; Sun, 28 Oct 2001 13:47:50 -0500
Date: Sun, 28 Oct 2001 10:46:19 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Zlatko Calusic <zlatko.calusic@iskon.hr>, Jens Axboe <axboe@suse.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>, <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: xmm2 - monitor Linux MM active/inactive lists graphically
In-Reply-To: <E15xuZM-0008W5-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0110281014300.7438-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 28 Oct 2001, Alan Cox wrote:
>
> > In contrast, the -ac logic says roughly "Who the hell cares if the driver
> > can merge requests or not, we can just give it thousands of small requests
> > instead, and cap the total number of _sectors_ instead of capping the
> > total number of requests earlier"
>
> If you think about it the major resource constraint is sectors - or another
> way to think of it "number of pinned pages the VM cannot rescue until the
> I/O is done".

Yes. But that's a VM decision, and that's a decision the VM _can_ and does
make. At least in newer VM's.

So counting sectors is only hiding problems at a higher level, and it's
hiding problems that the higher level can know about.

In contrast, one thing that the higher level _cannot_ know about is the
latency of the request queue, because that latency depends on the layout
of the requests. Contiguous requests are fast, seeks are slow. So the
number of requests (as long as they aren't infinitely sized) fairly well
approximates the latency.

Note that you are certainly right that the Linux VM system did not use to
be very good at throttling, and you could make it try to write out all of
memory on small machines. But that's really a VM issue.

(And have we have VM's that tried to push all of memory onto the disk, and
then returned Out-of-Memory when all pages were locked? Sure we have. But
I know mine doesn't, don't know about yours).

>		 We also have many devices where the latency is horribly
> important - IDE is one because it lacks sensible overlapping I/O. I'm less
> sure what the latency trade offs are. Less commands means less turnarounds
> so there is counterbalance.

Note that from a latency standpoint, you only need to have enough requests
to fill the queue - and right now we have a total of 128 requests, of
which half a for reads, and half are for the watermarking, so you end up
having 32 requests "in flight" while you refill the queue.

Which is _plenty_. Because each request can be 255 sectors (or 128,
depending on where the limit is today ;), which means that if you actually
have something throughput-limited, you can certainly keep the disk busy.

(And if the requests aren't localized enough to coalesce well, you cannot
keep the disk at platter-speed _anyway_, plus the requests will take
longer to process, so you'll have even more time to fill the queue).

The important part for real throughput is not to have thousands of
requests in flight, but to have _big_enough_ requests in flight. You can
keep even a fast disk busy with just a few requests, if you just keep
refilling them quickly enough and if they are _big_ enough.

> In the case of IDE the -ac tree will do basically the same merging - the
> limitations on IDE DMA are pretty reasonable. DMA IDE has scatter gather
> tables and is actually smarter than many older scsi controllers. The IDE
> layer supports up to 128 chunks of up to just under 64Kb (should be 64K
> but some chipsets get 64K = 0 wrong and its not pretty)

Yes. My question is more: does the dpt366 thing limit the queueing some
way?

> Well I'm all for making dumb hardware go as fast as smart stuff but that
> wasn't the original goal - the original goal was to fix the bad behaviour
> with the base kernel and large I/O queues to slow devices like M/O disks.

Now, that's a _latency_ issue, and should be fixed by having the max
number of requests (and the max _size_ of a request too) be a per-queue
thing.

But notice how that actually doesn't have anything to do with memory size,
and makes your "scale by max memory" thing illogical.

		Linus

