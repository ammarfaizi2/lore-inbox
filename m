Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261710AbSI0OZh>; Fri, 27 Sep 2002 10:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261711AbSI0OZh>; Fri, 27 Sep 2002 10:25:37 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:61383 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261708AbSI0OZe>;
	Fri, 27 Sep 2002 10:25:34 -0400
Date: Fri, 27 Sep 2002 16:30:40 +0200
From: Jens Axboe <axboe@suse.de>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Matthew Jacob <mjacob@feral.com>,
       "Pedro M. Rodrigues" <pmanuel@myrealbox.com>,
       Mathieu Chouquet-Stringer <mathieu@newview.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Warning - running *really* short on DMA buffers while doing file transfers
Message-ID: <20020927143040.GF23468@suse.de>
References: <20020927074509.GA860@suse.de> <Pine.BSF.4.21.0209270055290.18408-100000@beppo> <20020927102503.GA15101@suse.de> <389902704.1033133455@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <389902704.1033133455@aslan.scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27 2002, Justin T. Gibbs wrote:
> > The starvation I'm talking about is the drive starving requests. Just
> > keep it moderately busy (10-30 outstanding tags), and a read can take a
> > long time to complete.
> 
> As I tried to explain to Andrew just the other day, this is neither a
> drive nor HBA problem.  You've essentially constructed a benchmark where
> a single process can get so far ahead of the I/O subsystem in terms of
> buffered writes that there is no choice but for there to be a long delay
> for the device to handle your read.  Consider that because you are queuing,
> the drive will completely fill its cache with write data that is pending
> to hit the platters.  The number of transactions in the cache is marginally
> dependant on the number of tags in use since that will affect the ability
> of the controller to saturate the drive cache with write data.  Depending
> on your drive, mode page settings, etc, the drive may allow your read to
> pass the write, but many do not.  So you have to wait for the cache to
> at least have space to handle your read and perhaps have even additional
> write data flush before your read can even be started.  If you don't like
> this behavior, which actually maximizes the throughput of the device, have
> the I/O scheduler hold back a single processes from creating such a large
> backlog.  You can also read the SCSI spec and tune your disk to behave
> differently.

If the above is what has been observed in the real world, then there
would be no problem. Lets say I have 32 tags pending, all writes. Now I
issue a read. Then I go ahead and through my writes at the drive,
basically keeping it at 32 tags all the time. When will this read
complete? The answer is, well it might not within any reasonable time,
because the drive happily starves the read to get the best write
throughput.

The size of the dirty cache back log, or whatever you want to call it,
does not matter _at all_. I don't know why both you and Matt keep
bringing that point up. The 'back log' is just that, it will be
processed in due time. If a read comes in, the io scheduler will decide
it's the most important thing on earth. So I may have 1 gig of dirty
cache waiting to be flushed to disk, that _does not_ mean that the read
that now comes in has to wait for the 1 gig to be flushed first.

> Now consider the read case.  I maintain that any reasonable drive will
> *always* outperform the OS's transaction reordering/elevator algorithms
> for seek reduction.  This is the whole point of having high tag depths.

Well given that the drive has intimate knowledge of itself, then yes of
course it is the only one that can order any number of pending requests
most optimally. So the drive might provide the best layout of requests
when it comes to total number of seek time spent, and throughput. But
often at the cost of increased (some times much, see the trivial
examples given) latency.

However, I maintain that going beyond any reasonable number of tags for
a standard drive is *stupid*. The Linux io scheduler gets very good
performance without any queueing at all. Going from 4 to 64 tags gets
you very very little increase in performance, if any at all.

> In all I/O studies that have been performed todate, reads far outnumber
> writes *unless* you are creating an ISO image on your disk.  In my opinion

Well it's my experience that it's pretty balanced, at least for my own
workload. atime updates and compiles etc put a nice load on writes.

> it is much more important to optimize for the more common, concurrent
> read case, than it is for the sequential write case with intermittent
> reads.  Of course, you can fix the latter case too without any change to
> the driver's queue depth as outlined above.  Why not have your cake and
> eat it too?

If you care to show me this cake, I'd be happy to devour it. I see
nothing even resembling a solution to this problem in your email, except
from you above saying I should ignore it and optimize for 'the common'
concurrent read case.

It's pointless to argue that tagging is oh so great and always
outperforms the os io scheduler, and that we should just use 253 tags
because the drive knwos best, when several examples have shown that this
is _not the case_.

-- 
Jens Axboe

