Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132648AbRAIXUr>; Tue, 9 Jan 2001 18:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132278AbRAIXUh>; Tue, 9 Jan 2001 18:20:37 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:3880 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132648AbRAIXUb>; Tue, 9 Jan 2001 18:20:31 -0500
Date: Wed, 10 Jan 2001 00:20:19 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Christoph Hellwig <hch@caldera.de>,
        "David S. Miller" <davem@redhat.com>, riel@conectiva.com.br,
        netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
Message-ID: <20010110002019.I29904@athlon.random>
In-Reply-To: <20010109183808.A12128@suse.de> <Pine.LNX.4.30.0101091935461.7155-100000@e2> <20010109205420.H29904@athlon.random> <20010109211204.E12128@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010109211204.E12128@suse.de>; from axboe@suse.de on Tue, Jan 09, 2001 at 09:12:04PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2001 at 09:12:04PM +0100, Jens Axboe wrote:
> I haven't heard anything beyond the raised QUEUE_NR_REQUEST, so I'd like to
> see what you have pending so we can merge :-). The tiotest seek increase was
> mainly due to the elevator having 3000 requests to juggle and thus being able
> to eliminate a lot of seeks right?

Raising QUEUE_NR_REQUEST is possible because of the rework of other parts of
ll_rw_block meant to fix the lowmem boxes.

> > write numbers, streaming I/O doesn't change on highmem boxes but it doesn't
> > hurt lowmem boxes anymore). Current blk-13B isn't ok for integration yet
> > because it hurts with lowmem (try with mem=32m with your scsi array that gets
> > 512K*512 requests in flight :) and it's not able to exploit the elevator as
> 
> I don't see any lowmem problems -- if under pressure, the queue should be
> fired and thus it won't get as long as if you have lots of memory free.`

A write(2) shouldn't cause the allocator to wait I/O completion. It's the write
that should block when it's only polluting the cache or you'll hurt the
innocent rest of the system that isn't writing.

At least with my original implementation of the 512K large scsi command
support that you merged, before a write could block you first had to generate
at least 128Mbyte of memory _locked_ all queued in the I/O request list waiting
the driver to process the requests (only locked, without considering
the dirty part of memory).

Since you raised from 256 requests per queue to 512 with your patch you
may have to generate 256Mbyte of locked memory before a write can block.

This is great on the 8G boxes that runs specweb but this isn't that great on a
32Mbyte box connected incidentally to a decent SCSI adapter.

I say "may" because I didn't checked closely if you introduced any kind of
logic to avoid this. It seems not though because such a logic needs to touch at
least blkdev_release_request and that's what I developed in my tree and then I
could raise the number of I/O request in the queue up to 10000 if I wanted
without any problem, the max-I/O in flight was controlled properly. (this
allowed me to optimize away not 256 or in your case 512 seeks but 10000 seeks)
This is what I meant with exploiting the elevator. No panic, there's no buffer
overflow there ;)

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
