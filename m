Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbUCJGlZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 01:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbUCJGlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 01:41:24 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:60099 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262238AbUCJGlH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 01:41:07 -0500
Message-ID: <404EABD5.4060607@cyberone.com.au>
Date: Wed, 10 Mar 2004 16:47:01 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: blk_congestion_wait racy?
References: <OFAAC6B1AC.5886C5F2-ONC1256E52.0061A30B-C1256E52.0062656E@de.ibm.com>	<404EA645.8010900@cyberone.com.au> <20040309213518.44adb33d.akpm@osdl.org>
In-Reply-To: <20040309213518.44adb33d.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------040106000208080107020606"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040106000208080107020606
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



Andrew Morton wrote:

>Nick Piggin <piggin@cyberone.com.au> wrote:
>
>>But I'm guessing that you have no requests in flight by the time
>> blk_congestion_wait gets called, so nothing ever gets kicked.
>>
>
>That's why blk_congestion_wait() in -mm propagates the schedule_timeout()
>return value.   You can do:
>
>	if (blk_congestion_wait(...))
>		printk("ouch\n");
>
>If your kernel says ouch much, we have a problem.
>
>

Martin, have you tried adding this printk?

Andrew, could you take the following patch (even though it didn't fix
the problem).

I think the smp_mb isn't needed because the rl waitqueue stuff is
serialised by the queue spinlocks.

The addition of the smp_mb and the other change is to try to close the
window for races a bit. Obviously they can still happen, it's a racy
interface and it doesn't matter much.


--------------040106000208080107020606
Content-Type: text/x-patch;
 name="blk-congestion-races.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="blk-congestion-races.patch"

 linux-2.6-npiggin/drivers/block/ll_rw_blk.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff -puN drivers/block/ll_rw_blk.c~blk-congestion-races drivers/block/ll_rw_blk.c
--- linux-2.6/drivers/block/ll_rw_blk.c~blk-congestion-races	2004-03-10 16:38:33.000000000 +1100
+++ linux-2.6-npiggin/drivers/block/ll_rw_blk.c	2004-03-10 16:41:29.000000000 +1100
@@ -110,6 +110,9 @@ static void clear_queue_congested(reques
 
 	bit = (rw == WRITE) ? BDI_write_congested : BDI_read_congested;
 	clear_bit(bit, &q->backing_dev_info.state);
+
+	smp_mb(); /* congestion_wqh is not synchronised. This is still racy,
+		   * but better. It isn't a big deal */
 	if (waitqueue_active(wqh))
 		wake_up(wqh);
 }
@@ -1543,7 +1546,6 @@ static void freed_request(request_queue_
 	if (rl->count[rw] < queue_congestion_off_threshold(q))
 		clear_queue_congested(q, rw);
 	if (rl->count[rw]+1 <= q->nr_requests) {
-		smp_mb();
 		if (waitqueue_active(&rl->wait[rw]))
 			wake_up(&rl->wait[rw]);
 		if (!waitqueue_active(&rl->wait[rw]))
@@ -2036,8 +2038,8 @@ long blk_congestion_wait(int rw, long ti
 	DEFINE_WAIT(wait);
 	wait_queue_head_t *wqh = &congestion_wqh[rw];
 
-	blk_run_queues();
 	prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
+	blk_run_queues();
 	ret = io_schedule_timeout(timeout);
 	finish_wait(wqh, &wait);
 	return ret;

_

--------------040106000208080107020606--
