Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129520AbQKUNbx>; Tue, 21 Nov 2000 08:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129735AbQKUNbd>; Tue, 21 Nov 2000 08:31:33 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:10248 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129520AbQKUNb0>;
	Tue, 21 Nov 2000 08:31:26 -0500
Date: Tue, 21 Nov 2000 14:01:22 +0100
From: Jens Axboe <axboe@suse.de>
To: kumon@flab.fujitsu.co.jp
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@suse.de>,
        Andrea Arcangeli <andrea@suse.de>
Subject: Re: [PATCH] livelock in elevator scheduling
Message-ID: <20001121140122.H10007@suse.de>
In-Reply-To: <200011210838.RAA27382@asami.proc.flab.fujitsu.co.jp> <20001121112836.B10007@suse.de> <200011211130.UAA27961@asami.proc.flab.fujitsu.co.jp> <20001121123608.F10007@suse.de> <200011211239.VAA28311@asami.proc.flab.fujitsu.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200011211239.VAA28311@asami.proc.flab.fujitsu.co.jp>; from kumon@flab.fujitsu.co.jp on Tue, Nov 21, 2000 at 09:39:07PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21 2000, kumon@flab.fujitsu.co.jp wrote:
>  > The problem is caused by the too high sequence numbers in stock
>  > kernel, as I said. Plus, the sequence decrementing doesn't take
>  > request/buffer size into account. So the starvation _is_ limited,
>  > the limit is just too high.
> 
> Yes, current limit is 1000000 and if I/O can manage 200req/s, then it
> will expire 5000 sec after. So, I said "infinite (more than 1hour)".
> Why do you add extreme priotity to lower sector accesses, which breaks
> elevator scheduling idea?

Look at how it works in my blk-11 patch. It's not adding extreme
priority to low sector requests, it's always trying to sort sector
wise ascendingly (which of course then tends to put lower sectors
at the front of the queue). blk-11 does it a bit differently though,
the sequence number is in sector size units. And the queue scan
will apply simple aging to requests just sitting there.

>  > If performance is down, then that problem is most likely elsewhere.
>  > I/O limited benchmarking typically thrives on lots of request
>  > latency -- with that comes better throughput for individual threads.
> 
> No, the performance down caused from this point.  Server benchmark has
> a standard configuration workload which consists from several kind of
> task, such as, CPU interntional, disk seq-read, seq-write, random-read,
> random-write.
> 
> The benchmark invokes lots of processes, each corresponds to a client,
> and each accesses different portion of few large files.  We have
> enough memory to hold all dirty data at onece (1GB without himem), so
> if no I/O blocking occur, all process can be run simultaneously with
> limited amount of dirty flush I/O stream.

Flushing that much dirty data will always end up blocking waiting
for request slots.

> If some processes eagerly access relatively lower blocks, and other
> process unfortunately requests higher block read, then the process is
> blocked. Eventually this happens to large portion of processes, the
> performance goes extremely down.
>  During the measurement of test10 or test11, the performance is very
> fluctuated and lots of idle time observed by vmstat. Such instability
> is not observed on test1 or test2.

So check why there's much idle time -- the test2 elevator is identical
to the one in test11... Or check where it breaks exactly, what kernel
revision. Comparing test8 and test9 would be interesting.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
