Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbTFKA1W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 20:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbTFKA1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 20:27:22 -0400
Received: from dyn-ctb-210-9-246-243.webone.com.au ([210.9.246.243]:49671 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S262011AbTFKA1U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 20:27:20 -0400
Message-ID: <3EE67A63.1080806@cyberone.com.au>
Date: Wed, 11 Jun 2003 10:40:03 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Robert White <rwhite@casabyte.com>
CC: Chris Mason <mason@suse.com>, Andrea Arcangeli <andrea@suse.de>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
Subject: Re: [PATCH] io stalls
References: <PEEPIDHAKMCGHDBJLHKGCECGCPAA.rwhite@casabyte.com>
In-Reply-To: <PEEPIDHAKMCGHDBJLHKGCECGCPAA.rwhite@casabyte.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Robert White wrote:

>From: Nick Piggin [mailto:piggin@cyberone.com.au]
>Sent: Monday, June 09, 2003 8:23 PM
>
>>Actually, there is no priority other than time (ie. FIFO), and
>>seek distance in the IO subsystem. I guess this is why your
>>arguments fall down ;)
>>
>
>I'll buy that for the most part, though one of the differences I read
>elsewhere in the thread was the choice between add_wait_queue() and
>add_wait_queue_exclusive().  You will, however, note that one of the factors
>that is playing in this patch is process priority.
>
>(If I understand correctly) The wait queue in question becomes your FIFOing
>agent, it is kind of a pre-queue on the actual IO queue, once you reach a
>"full" condition.
>

Right.

>
>In the later case [add_wait_queue_exclusive()] you are strictly FIFO over
>the set of processes, where the moment-of-order is determined by insertion
>into the wait queue.
>
>In the former case [add_wait_queue()] when the queue is woken up all the
>waiters will be marked executable on the scheduler, and the scheduler will
>then (at least tend to) sort the submissions into task priority order.  So
>the higher priority tasks will get to butt into line.  Worse, the FIFO is
>essentially lost to the vagaries of the scheduler so without the _exclusive
>you have no FIFO at all.
>
>I think that is the reason that Chris was saying the
>add_wait_queue_exclusive() mode "does seem to scale much better."
>

Yep

>
>So your "original new" batching agent is really order-of-arrival that
>becomes anti-sorted by process priority.  Which can lead to scheduler
>induced starvation (and the observed "improvements" by using the strict FIFO
>created by a_w_q_exclusive).  The problem is that you get a little communist
>about the FIFO-ness when you use a_w_q_exclusive() and that can *SERIOUSLY*
>harm a task that must approach real-time behavior.
>

I think it had better be FIFO for now. If its not, you're
making the worst case latency worse. It requires a lot of
careful testing to get something like that working right.

You have some good ideas, and quite possibly they would be
worth implementing, but the behaviour of the code is quite
complex, especially when you take into account its affect
on the io scheduler.



