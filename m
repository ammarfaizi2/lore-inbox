Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbTFJXBR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 19:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbTFJXBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 19:01:17 -0400
Received: from 216-42-72-151.ppp.netsville.net ([216.42.72.151]:14766 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S261823AbTFJXBL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 19:01:11 -0400
Subject: Re: [PATCH] io stalls (was: -rc7   Re: Linux 2.4.21-rc6)
From: Chris Mason <mason@suse.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Nick Piggin <piggin@cyberone.com.au>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
In-Reply-To: <20030609221950.GF26270@dualathlon.random>
References: <Pine.LNX.4.55L.0305282019160.321@freak.distro.conectiva>
	 <200306041235.07832.m.c.p@wolk-project.de> <20030604104215.GN4853@suse.de>
	 <200306041246.21636.m.c.p@wolk-project.de>
	 <20030604104825.GR3412@x30.school.suse.de>
	 <3EDDDEBB.4080209@cyberone.com.au>
	 <1055194762.23130.370.camel@tiny.suse.com>
	 <20030609221950.GF26270@dualathlon.random>
Content-Type: text/plain
Organization: 
Message-Id: <1055286825.24111.155.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 10 Jun 2003 19:13:45 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-09 at 18:19, Andrea Arcangeli wrote:

> I spent last Saturday working on this too. This is the status of my
> current patches, would be interesting to compare them. they're not very
> well tested yet though.
> 
> They would obsoletes the old fix-pausing and the old elevator-lowlatency
> (I was going to release a new tree today, but I delayed it so I fixed
> uml today too first [tested with skas and w/o skas]).
> 
> those backout the rc7 interactivity changes (the only one that wasn't in
> my tree was the add_wait_queue_exclusive, that IMHO would better stay
> for scalability reasons).
> 
> Of course I would be very interested to know if those two patches (or
> Chris's one, you also retained the exclusive wakeup) are still greatly
> improved by removing the _exclusive weakups and going wake-all (in
> theory they shouldn't).

Ok, I merged these into rc7 along with the __get_request_wait stats
patch.  All numbers below were on ext2...I'm calling your patches -aa,
even though it's just a small part of the real -aa ;-) After a dbench 50
run, the -aa __get_request_wait latencies look like this:

device 08:01: num_req 6029, total jiffies waited 213475
        844 forced to wait
        2 min wait, 806 max wait
        252 average wait
        357 < 100, 29 < 200, 110 < 300, 111 < 400, 82 < 500
        155 waits longer than 500 jiffies

I changed my patch to have q->nr_requests at 1024 like yours, and reran
the dbench 50:

device 08:01: num_req 11122, total jiffies waited 121573
        8782 forced to wait
        1 min wait, 237 max wait
        13 average wait
        8654 < 100, 126 < 200, 2 < 300, 0 < 400, 0 < 500
        0 waits longer than 500 jiffies

So, I had 5000 more requests for the same workload, and 8000 of my
requests were forced to wait (compared to 844 of yours).  But the total
number of jiffies spent waiting on my patch was lower, as were the
average and max waits.  Increasing the number of requests with my patch
make the system feel slower, even though the __get_request_wait latency
numbers didn't change.

On this dbench run, you got a throughput of 118mb/s and I got 90mb/s. 
The __get_request_wait latency numbers were reliable across runs, but I
might as well have thrown a dart to pick throughput numbers.  So, next
tests were done with iozone.

On aa after iozone -s 100M -i 0 -t 20 (20 procs each doing streaming
writes to a private 100M file)

device 08:01: num_req 167133, total jiffies waited 872566
        6424 forced to wait
        4 min wait, 507 max wait
        135 average wait
        2619 < 100, 2020 < 200, 1433 < 300, 325 < 400, 26 < 500
        1 waits longer than 500 jiffies

And the iozone throughput numbers looked like so (again -aa patches)

        Children see throughput for 20 initial writers  =   13824.22 KB/sec
        Parent sees throughput for 20 initial writers   =    6811.29 KB/sec
        Min throughput per process                      =     451.99 KB/sec
        Max throughput per process                      =     904.14 KB/sec
        Avg throughput per process                      =     691.21 KB/sec
        Min xfer                                        =   51136.00 KB

The avg throughput per process with vanilla rc7 is 3MB/s, the best I've
been able to do was with nr_requests at higher levels was 1.3MB/s.  With
smaller of iozone threads (10 and lower so far) I can match rc7 speeds,
but not with 20 procs.

Anyway, my latency numbers for iozone -s 100M -i 0 -t 20:

device 08:01: num_req 146049, total jiffies waited 434025
        130670 forced to wait
        1 min wait, 65 max wait
        3 average wait
        130671 < 100, 0 < 200, 0 < 300, 0 < 400, 0 < 500
        0 waits longer than 500 jiffies

And the iozone reported throughput:

        Children see throughput for 20 initial writers  =   19828.92 KB/sec
        Parent sees throughput for 20 initial writers   =    7003.36 KB/sec
        Min throughput per process                      =     526.61 KB/sec
        Max throughput per process                      =    1353.45 KB/sec
        Avg throughput per process                      =     991.45 KB/sec
        Min xfer                                        =   39968.00 KB

The patch I was working on today was almost the same as the one I posted
yesterday, the only difference being the hunk below and changes to
nr_requests (256 balanced nicely on my box, all numbers above were at
1024).

This hunk against my patch yesterday just avoids an unplug in
__get_request_wait if there are still available requests.  A process
might be waiting in __get_request_wait just because the queue was full,
which has little do to with the queue needing an unplug.  He'll get
woken up later by get_request_wait_wakeup if nobody else manages to wake
him (I think).

diff -u edited/drivers/block/ll_rw_blk.c edited/drivers/block/ll_rw_blk.c
--- edited/drivers/block/ll_rw_blk.c	Mon Jun  9 17:13:16 2003
+++ edited/drivers/block/ll_rw_blk.c	Tue Jun 10 16:46:50 2003
@@ -661,7 +661,8 @@
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		spin_lock_irq(&io_request_lock);
 		if ((!waited && queue_full(q, rw)) || q->rq[rw].count == 0) {
-			__generic_unplug_device(q);
+			if (q->rq[rw].count == 0)
+				__generic_unplug_device(q);
 			spin_unlock_irq(&io_request_lock);
 			schedule();
 			spin_lock_irq(&io_request_lock);




