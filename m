Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264653AbTFLAxu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 20:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264655AbTFLAxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 20:53:49 -0400
Received: from dyn-ctb-210-9-241-68.webone.com.au ([210.9.241.68]:13572 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S264653AbTFLAxs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 20:53:48 -0400
Message-ID: <3EE7D1AA.30701@cyberone.com.au>
Date: Thu, 12 Jun 2003 11:04:42 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Chris Mason <mason@suse.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
Subject: Re: [PATCH] io stalls
References: <3EDDDEBB.4080209@cyberone.com.au> <1055194762.23130.370.camel@tiny.suse.com> <20030611003356.GN26270@dualathlon.random> <1055292839.24111.180.camel@tiny.suse.com> <20030611010628.GO26270@dualathlon.random> <1055296630.23697.195.camel@tiny.suse.com> <20030611021030.GQ26270@dualathlon.random> <1055353360.23697.235.camel@tiny.suse.com> <20030611181217.GX26270@dualathlon.random> <1055356032.24111.240.camel@tiny.suse.com> <20030611183503.GY26270@dualathlon.random>
In-Reply-To: <20030611183503.GY26270@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrea Arcangeli wrote:

>On Wed, Jun 11, 2003 at 02:27:13PM -0400, Chris Mason wrote:
>
>>On Wed, 2003-06-11 at 14:12, Andrea Arcangeli wrote:
>>
>>>On Wed, Jun 11, 2003 at 01:42:41PM -0400, Chris Mason wrote:
>>>
>>>>+		if (q->rq[rw].count >= q->batch_requests) {
>>>>+			smp_mb();
>>>>+			if (waitqueue_active(&q->wait_for_requests[rw]))
>>>>+				wake_up(&q->wait_for_requests[rw]);
>>>>
>>>in my tree I also changed this to:
>>>
>>>				wake_up_nr(&q->wait_for_requests[rw], q->rq[rw].count);
>>>
>>>otherwise only one waiter will eat the requests, while multiple waiters
>>>can eat requests in parallel instead because we freed not just 1 request
>>>but many of them.
>>>
>>I tried a few variations of this yesterday and they all led to horrible
>>latencies, but I couldn't really explain why.  I had a bunch of other
>>
>
>the I/O latency in theory shouldn't change, we're not reordering the
>queue at all, they'll go to sleep immediatly again if __get_request
>returns null.
>

And go to the end of the queue?

>
>>stuff in at the time to try and improve throughput though, so I'll try
>>it again.
>>
>>I think part of the problem is the cascading wakeups from
>>get_request_wait_wakeup().  So if we wakeup 32 procs they in turn wakeup
>>another 32, etc.
>>
>
>so maybe it's enough to wakeup count / 2 to account for the double
>wakeup? that will avoid some overscheduling indeed.
>
>

Andrea, this isn't needed because when the queue falls below
the batch limit, every retiring request will do a wake up and
another request will be put on (as long as the waitqueue is
active).


