Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262720AbVAFEzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262720AbVAFEzw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 23:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262721AbVAFEzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 23:55:52 -0500
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:21082 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262720AbVAFEzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 23:55:40 -0500
Message-ID: <41DCC4C6.8000205@yahoo.com.au>
Date: Thu, 06 Jan 2005 15:55:34 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: riel@redhat.com, marcelo.tosatti@cyclades.com, andrea@suse.de,
       linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH][5/?] count writeback pages in nr_scanned
References: <Pine.LNX.4.61.0501031224400.25392@chimarrao.boston.redhat.com>	<20050105020859.3192a298.akpm@osdl.org>	<20050105180651.GD4597@dualathlon.random>	<Pine.LNX.4.61.0501051350150.22969@chimarrao.boston.redhat.com>	<20050105174934.GC15739@logos.cnet>	<20050105134457.03aca488.akpm@osdl.org>	<20050105203217.GB17265@logos.cnet>	<41DC7D86.8050609@yahoo.com.au>	<Pine.LNX.4.61.0501052025450.11550@chimarrao.boston.redhat.com>	<20050105173624.5c3189b9.akpm@osdl.org>	<Pine.LNX.4.61.0501052240250.11550@chimarrao.boston.redhat.com>	<41DCB577.9000205@yahoo.com.au>	<20050105202611.65eb82cf.akpm@osdl.org>	<41DCC014.80007@yahoo.com.au> <20050105204706.0781d672.akpm@osdl.org>
In-Reply-To: <20050105204706.0781d672.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------050208090403080502070400"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050208090403080502070400
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>> > If the queue is not congested, blk_congestion_wait() will still sleep.  See
>> > freed_request().
>> > 
>>
>> Hmm... doesn't look like it to me:
>>
>>          if (rl->count[rw] < queue_congestion_off_threshold(q))
>>                  clear_queue_congested(q, rw);
>>
>> And clear_queue_congested does an unconditional wakeup (if there
>> is someone sleeping on the congestion queue).
> 
> 
> That's my point.  blk_congestion_wait() will always sleep, regardless of
> the queue's congestion state.
> 

Oh yes, but it will return as soon as a single request is finished.
Which is probably a couple of milliseconds, rather than the 100 we
had hoped for. So the allocators will wake up again and go around
the loop and still make no progress.

However, if you had a plain io_schedule_timeout there, at least you
would sleep for the full extend of the specified timeout.

BTW. Jens, now that I look at freed_request, is the memory barrier
required? If so, what is it protecting?


--------------050208090403080502070400
Content-Type: text/plain;
 name="blk-no-mb.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="blk-no-mb.patch"



This memory barrier is not needed because the waitqueue will only get
waiters on it in the following situations:

rq->count has exceeded the threshold - however all manipulations of ->count
are performed under the runqueue lock, and so we will correctly pick up any
waiter.

Memory allocation for the request fails. In this case, there is no additional
help provided by the memory barrier. We are guaranteed to eventually wake
up waiters because the request allocation mempool guarantees that if the mem
allocation for a request fails, there must be some requests in flight. They
will wake up waiters when they are retired.



---

 linux-2.6-npiggin/drivers/block/ll_rw_blk.c |    1 -
 1 files changed, 1 deletion(-)

diff -puN drivers/block/ll_rw_blk.c~blk-no-mb drivers/block/ll_rw_blk.c
--- linux-2.6/drivers/block/ll_rw_blk.c~blk-no-mb	2005-01-06 15:37:05.000000000 +1100
+++ linux-2.6-npiggin/drivers/block/ll_rw_blk.c	2005-01-06 15:37:12.000000000 +1100
@@ -1630,7 +1630,6 @@ static void freed_request(request_queue_
 	if (rl->count[rw] < queue_congestion_off_threshold(q))
 		clear_queue_congested(q, rw);
 	if (rl->count[rw]+1 <= q->nr_requests) {
-		smp_mb();
 		if (waitqueue_active(&rl->wait[rw]))
 			wake_up(&rl->wait[rw]);
 		blk_clear_queue_full(q, rw);

_

--------------050208090403080502070400--
