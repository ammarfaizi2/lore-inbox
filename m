Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131205AbRAIXf1>; Tue, 9 Jan 2001 18:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131022AbRAIXfR>; Tue, 9 Jan 2001 18:35:17 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:59406 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S131205AbRAIXfI>;
	Tue, 9 Jan 2001 18:35:08 -0500
Date: Wed, 10 Jan 2001 00:34:35 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Christoph Hellwig <hch@caldera.de>,
        "David S. Miller" <davem@redhat.com>, riel@conectiva.com.br,
        netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
Message-ID: <20010110003435.K12128@suse.de>
In-Reply-To: <20010109183808.A12128@suse.de> <Pine.LNX.4.30.0101091935461.7155-100000@e2> <20010109205420.H29904@athlon.random> <20010109211204.E12128@suse.de> <20010110002019.I29904@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010110002019.I29904@athlon.random>; from andrea@suse.de on Wed, Jan 10, 2001 at 12:20:19AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10 2001, Andrea Arcangeli wrote:
> On Tue, Jan 09, 2001 at 09:12:04PM +0100, Jens Axboe wrote:
> > I haven't heard anything beyond the raised QUEUE_NR_REQUEST, so I'd like to
> > see what you have pending so we can merge :-). The tiotest seek increase was
> > mainly due to the elevator having 3000 requests to juggle and thus being able
> > to eliminate a lot of seeks right?
> 
> Raising QUEUE_NR_REQUEST is possible because of the rework of other parts of
> ll_rw_block meant to fix the lowmem boxes.

Ah I see. It would be nice to base the QUEUE_NR_REQUEST on something else
than a static number. For example, 3000 per queue translates into 281Kb
of request slots per queue. On a typical system with a floppy, hard drive,
and CD-ROM it's getting close to 1Mb of RAM used for this alone. On a
32Mb box this is unaccebtable.

I previously had blk_init_queue_nr(q, nr_free_slots) to eg not use that
many free slots on say floppy, which doesn't really make much sense
anyway.

> > I don't see any lowmem problems -- if under pressure, the queue should be
> > fired and thus it won't get as long as if you have lots of memory free.`
> 
> A write(2) shouldn't cause the allocator to wait I/O completion. It's the write
> that should block when it's only polluting the cache or you'll hurt the
> innocent rest of the system that isn't writing.
> 
> At least with my original implementation of the 512K large scsi command
> support that you merged, before a write could block you first had to generate
> at least 128Mbyte of memory _locked_ all queued in the I/O request list waiting
> the driver to process the requests (only locked, without considering
> the dirty part of memory).
> 
> Since you raised from 256 requests per queue to 512 with your patch you
> may have to generate 256Mbyte of locked memory before a write can block.
> 
> This is great on the 8G boxes that runs specweb but this isn't that great on a
> 32Mbyte box connected incidentally to a decent SCSI adapter.

Yes I see your point. However memory shortage will fire the queue in due
time, it won't make the WRITE block however. In this case it would be
bdflush blocking on the WRITE's, which seem exactly what we don't want?

> I say "may" because I didn't checked closely if you introduced any kind of
> logic to avoid this. It seems not though because such a logic needs to touch at
> least blkdev_release_request and that's what I developed in my tree and then I
> could raise the number of I/O request in the queue up to 10000 if I wanted
> without any problem, the max-I/O in flight was controlled properly. (this
> allowed me to optimize away not 256 or in your case 512 seeks but 10000 seeks)
> This is what I meant with exploiting the elevator. No panic, there's no buffer
> overflow there ;)

So you imposed a MB limit on how much I/O would be outstanding in
blkdev_release_request? Wouldn't it make more sense to move this to at
get_request time, since with the blkdev_release_request approach you won't
catch lots of outstanding lock buffers before you start releasing one of
them, at which point it would be too late (it might recover, but still).


-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
