Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267233AbRHDRMl>; Sat, 4 Aug 2001 13:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269162AbRHDRMb>; Sat, 4 Aug 2001 13:12:31 -0400
Received: from [63.209.4.196] ([63.209.4.196]:3343 "EHLO neon-gw.transmeta.com")
	by vger.kernel.org with ESMTP id <S267233AbRHDRMT>;
	Sat, 4 Aug 2001 13:12:19 -0400
Date: Sat, 4 Aug 2001 10:08:56 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Mike Black <mblack@csihq.com>
cc: Ben LaHaise <bcrl@redhat.com>, Daniel Phillips <phillips@bonn-fries.net>,
        Rik van Riel <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Andrew Morton <andrewm@uow.edu.au>
Subject: Re: [RFC][DATA] re "ongoing vm suckage"
In-Reply-To: <028001c11cf0$e5becca0$b6562341@cfl.rr.com>
Message-ID: <Pine.LNX.4.33.0108040952460.1203-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 4 Aug 2001, Mike Black wrote:
>
> I'm testing 2.4.8-pre4 -- MUCH better interactivity behavior now.

Good.. However..

> I've been testing ext3/raid5 for several weeks now and this is usable now.
> My system is Dual 1Ghz/2GRam/4GSwap fibrechannel.
> But...the single thread i/o performance is down.

Bad. And before we get too happy about the interactive thing, let's
remember that sometimes interactivity comes at the expense of throughput,
and maybe if we fix the throughput we'll be back where we started.

Now, you basically have a rather fast disk subsystem, and it's entirely
possible that with that kind of oomph you really want a longer queue. So
in blk_dev_init() in drivers/block/ll_rw_blk.c, try changing

	/*
         * Free request slots per queue.
         * (Half for reads, half for writes)
         */
        queue_nr_requests = 64;
        if (total_ram > MB(32))
                queue_nr_requests = 128;

to something more like

	/*
         * Free request slots per queue.
         * (Half for reads, half for writes)
         */
        queue_nr_requests = 64;
        if (total_ram > MB(32)) {
                queue_nr_requests = 128;
		if (total_ram > MB(128))
			queue_nr_requests = 256;
	}

and tell me if interactivity is still fine, and whether performance goes
up?

And please feel free to play with different values - but remember that
big values do tend to mean bad latency.

Rule of thumb: even on fast disks, the average seek time (and between
requests you almost always have to seek) is on the order of a few
milliseconds. With a large write-queue (256 total requests means 128 write
requests) you can basically get single-request latencies of up to a
second. Which is really bad.

One partial solution may be the just make the read queue deeper than the
write queue. That's a bit more complicated than just changing a single
value, though - you'd need to make the batching threshold be dependent on
read-write too etc. But it would probably not be a bad idea to change the
"split requests evenly" to do even "split requests 2:1 to read:write".

All the logic is in drivers/block/ll_rw_block.c, and it's fairly easy to
just search for queue_nr_requests/batch_requests to see what it's doing.

> I"m seeing a lot more CPU Usage for the 1st thread than previous tests --
> perhaps we've shortened the queue too much and it's throttling the read?
> Why would CPU usage go up and I/O go down?

I'd guess it's calling the scheduler more. With fast disks and a queue
that runs out, you'd probably go into a series of extremely short
stop-start behaviour. Or something similar.

		Linus

