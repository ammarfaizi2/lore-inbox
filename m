Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262443AbUCHJ7i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 04:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262436AbUCHJ7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 04:59:38 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:40878 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S262443AbUCHJ7d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 04:59:33 -0500
Date: Mon, 8 Mar 2004 10:59:19 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: blk_congestion_wait racy?
Message-ID: <20040308095919.GA1117@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
we have a stupid little program that linearly allocates and touches
memory. We use this to see how fast s390 can swap. If this is combined
with the fastest block device we have (xpram) we see a very strange
effect:

2.6.4-rc2 with 1 cpu
# time ./mempig 600
Count (1Meg blocks) = 600
600  of 600
Done.

real    0m2.516s
user    0m0.150s
sys     0m0.570s
#

2.6.4-rc2 with 2 cpus
# time ./mempig 600
Count (1Meg blocks) = 600
600  of 600
Done.

real    0m56.086s
user    0m0.110s
sys     0m0.630s
#

I have the suspicion that the call to blk_congestion_wait in
try_to_free_pages is part of the problem. It initiates a wait for
a queue to exit congestion but this could already have happened
on another cpu before blk_congestion_wait has setup the wait
queue. In this case the process sleeps for 0.1 seconds. With
the swap test setup this happens all the time. If I "fix"
blk_congestion_wait not to wait:

diff -urN linux-2.6/drivers/block/ll_rw_blk.c linux-2.6-fix/drivers/block/ll_rw_blk.c
--- linux-2.6/drivers/block/ll_rw_blk.c	Fri Mar  5 14:50:28 2004
+++ linux-2.6-fix/drivers/block/ll_rw_blk.c	Fri Mar  5 14:51:05 2004
@@ -1892,7 +1892,9 @@
 
 	blk_run_queues();
 	prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
+#if 0
 	io_schedule_timeout(timeout);
+#endif
 	finish_wait(wqh, &wait);
 }
 
then the system reacts normal again:

2.6.4-rc2 + "fix" with 1 cpu
# time ./mempig 600
Count (1Meg blocks) = 600
600  of 600
Done.

real    0m2.523s
user    0m0.200s
sys     0m0.880s
#

2.6.4-rc2 + "fix" with 2 cpu
# time ./mempig 600
Count (1Meg blocks) = 600
600  of 600
Done.

real    0m2.029s
user    0m0.250s
sys     0m1.560s
#

2.6.4-rc2 + "fix" with 2 cpus


Since it isn't a solution to remove the call to io_schedule_timeout
I tried to understand what the event is, that blk_congestion_wait
is waiting for. The comment says it waits for a queue to exit congestion.
That is starting from prepare_to_wait it waits for a call to
clear_queue_congested. In my test scenario NO queue is congested on
enter to blk_congestion_wait. I'd like to see a proper wait_event
there but it is non-trivial to define the event to wait for.
Any useful hints ?

blue skies,
   Martin

