Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129729AbRAIUND>; Tue, 9 Jan 2001 15:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131936AbRAIUMx>; Tue, 9 Jan 2001 15:12:53 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:28429 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129729AbRAIUMp>;
	Tue, 9 Jan 2001 15:12:45 -0500
Date: Tue, 9 Jan 2001 21:12:04 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Christoph Hellwig <hch@caldera.de>,
        "David S. Miller" <davem@redhat.com>, riel@conectiva.com.br,
        netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
Message-ID: <20010109211204.E12128@suse.de>
In-Reply-To: <20010109183808.A12128@suse.de> <Pine.LNX.4.30.0101091935461.7155-100000@e2> <20010109205420.H29904@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010109205420.H29904@athlon.random>; from andrea@suse.de on Tue, Jan 09, 2001 at 08:54:20PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09 2001, Andrea Arcangeli wrote:
> > > > Thats fine. Get me 128K-512K chunks nicely streaming into my raid controller
> > > > and I'll be a happy man
> > >
> > > No problem, apply blk-13B and you'll get 512K chunks for SCSI and RAID.
> > 
> > i cannot agree more - Jens' patch did wonders to IO performance here. It
> 
> BTW, I noticed what is left in blk-13B seems to be my work (Jens's fixes for
> merging when the I/O queue is full are just been integrated in test1x). The
> 512K SCSI command, wake_up_nr, elevator fixes and cleanups and removal of the
> bogus 64 max_segment limit in scsi.c that matters only with the IOMMU to allow
> devices with sg_tablesize <64 to do SG with 64 segments were all thought and
> implemented by me. My last public patch with most of the blk-13B stuff in it
> was here:
> 
> 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/2.4.0-test7/blkdev-3
> 
> I sumbitted a later revision of the above blkdev-3 to Jens and he kept nicely
> maintaining it in sync with 2.4.x-latest.

There are several parts that have been merged beyond recognition at this
point :-). The wake_up_nr was actually partially redone by Ingo, I suspect
he can fill in the gaps there. Then there are the general cleanups and cruft
removal done by you (elevator->nr_segments stuff). The bogus 64 max segments
from SCSI was there before merge too, I think I've actually had that in my
tree for ages!

The request free batching and pending queues were done by me, and Ingo
helped tweak it during the spec runs to find a sweet spot of how much to
batch etc.

The elevator received lots of massaging beyond blkdev-3. For one, there
are now only one complete queue scan for merge and insert of request where
we before did one for each of them. The merger also does correct
accounting and aging.

In addition there are a bunch other small fixes in there, I'm too lazy
to list them all now :)

> My blkdev tree is even more advanced but I didn't had time to update with 2.4.0
> and marge it with Jens yet (I just described to Jens what "more advanced"
> means though, in practice it means something like a x2 speedup in tiotest seek

I haven't heard anything beyond the raised QUEUE_NR_REQUEST, so I'd like to
see what you have pending so we can merge :-). The tiotest seek increase was
mainly due to the elevator having 3000 requests to juggle and thus being able
to eliminate a lot of seeks right?

> write numbers, streaming I/O doesn't change on highmem boxes but it doesn't
> hurt lowmem boxes anymore). Current blk-13B isn't ok for integration yet
> because it hurts with lowmem (try with mem=32m with your scsi array that gets
> 512K*512 requests in flight :) and it's not able to exploit the elevator as

I don't see any lowmem problems -- if under pressure, the queue should be
fired and thus it won't get as long as if you have lots of memory free.`

> well as my tree even on highmemory machines. So I'd wait until I merge the last
> bits with Jens (I raised the QUEUE_NR_REQUESTS to 3000) before inclusion.

?? What do you mean exploit the elevator?

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
