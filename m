Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRAIXw7>; Tue, 9 Jan 2001 18:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132117AbRAIXwt>; Tue, 9 Jan 2001 18:52:49 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:50989 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129431AbRAIXws>; Tue, 9 Jan 2001 18:52:48 -0500
Date: Wed, 10 Jan 2001 00:52:41 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Christoph Hellwig <hch@caldera.de>,
        "David S. Miller" <davem@redhat.com>, riel@conectiva.com.br,
        netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
Message-ID: <20010110005241.K29904@athlon.random>
In-Reply-To: <20010109183808.A12128@suse.de> <Pine.LNX.4.30.0101091935461.7155-100000@e2> <20010109205420.H29904@athlon.random> <20010109211204.E12128@suse.de> <20010110002019.I29904@athlon.random> <20010110003435.K12128@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010110003435.K12128@suse.de>; from axboe@suse.de on Wed, Jan 10, 2001 at 12:34:35AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2001 at 12:34:35AM +0100, Jens Axboe wrote:
> Ah I see. It would be nice to base the QUEUE_NR_REQUEST on something else
> than a static number. For example, 3000 per queue translates into 281Kb
> of request slots per queue. On a typical system with a floppy, hard drive,
> and CD-ROM it's getting close to 1Mb of RAM used for this alone. On a
> 32Mb box this is unaccebtable.

Yes of course. Infact 3000 was just the number I choosen when doing the
benchmarks on a 128Mbox. Things needs to be autotuning and that's not yet
implemented. I meant 3000 to tell how such number can grow. Right now if you
use 3000 you will need to lock 1.5G of RAM (more than the normal zone!) before
you can block with the 512K scsi commands.  This was just to show the rest of
the blkdev layer was obviously restructured.  On a 8G box 10000 requests
would probably be a good number.

> Yes I see your point. However memory shortage will fire the queue in due
> time, it won't make the WRITE block however. In this case it would be

That's the performance problem I'm talking about on the lowmem boxes. Infact
this problem will happen in 2.4.x too, just less biased than with the
512K scsi commands and by you increasing the number of requests from 256 to 512.

> bdflush blocking on the WRITE's, which seem exactly what we don't want?

In 2.4.0 Linus fixed wakeup_bdflush not to wait bdflush anymore as I suggested,
now it's the task context that sumbits the requests directly to the I/O queue
so it's the task that must block, not bdflush. And the task will block correctly
_if_ we unplug at the sane time in ll_rw_block.

> So you imposed a MB limit on how much I/O would be outstanding in
> blkdev_release_request? Wouldn't it make more sense to move this to at

No absolutely. Not in blkdev_release_request. The changes there
are because you need to somehow do some accounting at I/O completion.

> get_request time, since with the blkdev_release_request approach you won't

Yes, only ll_rw_block uplugs, not blkdev_release_request.  Obviously since the
latter runs from irqs.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
