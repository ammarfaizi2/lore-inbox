Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262208AbSIZGjv>; Thu, 26 Sep 2002 02:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262210AbSIZGjv>; Thu, 26 Sep 2002 02:39:51 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:51904 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262208AbSIZGjs>;
	Thu, 26 Sep 2002 02:39:48 -0400
Date: Thu, 26 Sep 2002 08:44:55 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] deadline io scheduler
Message-ID: <20020926064455.GC12862@suse.de>
References: <20020925172024.GH15479@suse.de> <3D92A61E.40BFF2D0@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D92A61E.40BFF2D0@digeo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25 2002, Andrew Morton wrote:
> 
> This is looking good.   With a little more tuning and tweaking
> this problem is solved.
> 
> The horror test was:
> 
> 	cd /usr/src/linux
> 	dd if=/dev/zero of=foo bs=1M count=4000
> 	sleep 5
> 	time cat kernel/*.c > /dev/null
> 
> Testing on IDE (this matters - SCSI is very different)

Yes, SCSI specific stuff comes next.

> - On 2.5.38 + souped-up VM it was taking 25 seconds.
> 
> - My read-latency patch took 1 second-odd.
> 
> - Linus' rework yesterday was taking 0.3 seconds.
> 
> - With Linus' current tree (with the deadline scheduler) it now takes
>   5 seconds.
> 
> Let's see what happens as we vary read_expire:
> 
> 	read_expire (ms)	time cat kernel/*.c (secs)
> 		500			5.2
> 		400			3.8
> 		300			4.5
> 		200			3.9
> 		100			5.1
> 		 50			5.0
> 
> well that was a bit of a placebo ;)

For this work load, more on that later.

> Let's leave read_expire at 500ms and diddle writes_starved:
> 
> 	writes_starved (units)	time cat kernel/*.c (secs)
> 		 1			4.8
> 		 2			4.4
> 		 4			4.0
> 		 8			4.9
> 		16			4.9

Interesting

> Now alter fifo_batch, everything else default:
> 
> 	fifo_batch (units)	time cat kernel/*.c (secs)
> 		64			5.0
> 		32			2.0
> 		16			0.2
> 		 8			0.17
> 
> OK, that's a winner.

Cool, I'm resting benchmarks with 16 as the default now. I fear this
might be too agressive, and that 32 will be a decent value.

> Here's something really nice with the deadline scheduler.  I was
> madly catting five separate kernel trees (five reading processes)
> and then started a big `dd', tunables at default:
> 
>    procs                      memory      swap          io     system      cpu
>  r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
>  0  9  0   6008   2460   8304 324716    0    0  2048     0 1102   254 13 88  0
>  0  7  0   6008   2600   8288 324480    0    0  1800     0 1114   266  0 100  0
>  0  6  0   6008   2452   8292 324520    0    0  2432     0 1126   287 29 71  0
>  0  6  0   6008   3160   8292 323952    0    0  3568     0 1132   312  0 100  0
>  0  6  0   6008   2860   8296 324148  128    0  2984     0 1119   281 17 83  0
>  1  6  0   5984   2856   8264 323816  352    0  5240     0 1162   479  0 100  0
>  0  7  1   5984   4152   7876 324068    0    0  1648 28192 1215  1572  1 99  0
>  0  9  2   6016   3136   7300 328568    0  180  1232 37248 1324  1201  3 97  0
>  0  9  2   6020   5260   5628 329212    0    4  1112 29488 1296   560  0 100  0
>  0  9  3   6020   3548   5596 330944    0    0  1064 35240 1302   629  6 94  0
>  0  9  3   6020   3412   5572 331352    0    0   744 31744 1298   452  6 94  0
>  0  9  2   6020   1516   5576 333352    0    0   888 31488 1283   467  0 100  0
>  0  9  2   6020   3528   5580 331396    0    0  1312 20768 1251   385  0 100  0
> 
> Note how the read rate maybe halved, and we sustained a high
> volume of writeback.  This is excellent.

Yep

> Let's try it again with fifo_batch at 16:
> 
>  0  5  0     80 303936   3960  49288    0    0  2520     0 1092   174  0 100  0
>  0  5  0     80 302400   3996  50776    0    0  3040     0 1094   172 20 80  0
>  0  5  0     80 301164   4032  51988    0    0  2504     0 1082   150  0 100  0
>  0  5  0     80 299708   4060  53412    0    0  2904     0 1084   149  0 100  0
>  1  5  1     80 164640   4060 186784    0    0  1344 26720 1104   891  1 99  0
>  0  6  2     80 138900   4060 212088    0    0   280  7928 1039   226  0 100  0
>  0  6  2     80 134992   4064 215928    0    0  1512  7704 1100   226  0 100  0
>  0  6  2     80 130880   4068 219976    0    0  1928  9688 1124   245 17 83  0
>  0  6  2     80 123316   4084 227432    0    0  2664  8200 1125   283 11 89  0
> 
> That looks acceptable.  Writes took quite a bit of punishment, but
> the VM should cope with that OK.
> 
> It'd be interesting to know why read_expire and writes_starved have
> no effect, while fifo_batch has a huge effect.
> 
> I'd like to gain a solid understanding of what these three knobs do.
> Could you explain that a little more?

Sure. The reason you are not seeing a big change with read expire, is
that you basically only have one thread issuing reads. Once you start
flooding the queue with more threads doing reads, then read expire just
puts a lid on the max latency that will incur. So you are probably not
hitting the read expire logic at all, or just slightly.

The three tunables are:

read_expire. This one controls how old a request can be, before we
attempt to move it to the dispatch queue. This is the starvation logic
for the read list. When a read expires, the other nobs control what the
behaviour is.

fifo_batch. This one controls how big a batch of requests we move from
the sort lists to the dispatch queue. The idea was that we don't want to
move single requests, since that might cause seek storms. Instead we
move a batch of request, starting at the expire head for reads if
necessary, along the sorted list to the dispatch queue. fifo_batch is
the total cost that can be endured, a total of seeks and non-seeky
requests. With you fifo_batch at 16, we can only move on seeky request
to the dispatch queue. Or we can move 16 non-seeky requests. Or a few
non-seeky request, and a seeky one. You get the idea.

writes_starved. This controls how many times reads get preferred over
writes. The default is 2, which means that we can serve two batches of
reads over one write batch. A value of 4 would mean that reads could
skip ahead of writes 4 times. A value of 1 would give you 1:1
read:write, ie no read preference. A silly value of 0 would give you
write preference, always.

Hope this helps?

> During development I'd suggest the below patch, to add
> /proc/sys/vm/read_expire, fifo_batch and writes_starved - it beats
> recompiling each time.

It sure does, I either want to talk Al into making the ioschedfs (better
name will be selected :-) or try and do it myself so we can do this
properly.

> I'll test scsi now.

Cool. I found a buglet that causes incorrect accounting when moving
request if the dispatch queue is not empty. Attached.

===== drivers/block/deadline-iosched.c 1.1 vs edited =====
--- 1.1/drivers/block/deadline-iosched.c	Wed Sep 25 21:16:26 2002
+++ edited/drivers/block/deadline-iosched.c	Thu Sep 26 08:33:35 2002
@@ -254,6 +254,15 @@
 	struct list_head *sort_head = &dd->sort_list[rq_data_dir(rq)];
 	sector_t last_sec = dd->last_sector;
 	int batch_count = dd->fifo_batch;
+
+	/*
+	 * if dispatch is non-empty, disregard last_sector and check last one
+	 */
+	if (!list_empty(dd->dispatch)) {
+		struct request *__rq = list_entry_rq(dd->dispatch->prev);
+
+		last_sec = __rq->sector + __rq->nr_sectors;
+	}
 
 	do {
 		struct list_head *nxt = rq->queuelist.next;

-- 
Jens Axboe

