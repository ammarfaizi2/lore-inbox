Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbTFJDJs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 23:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbTFJDJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 23:09:48 -0400
Received: from dyn-ctb-210-9-244-230.webone.com.au ([210.9.244.230]:13330 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S262169AbTFJDJp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 23:09:45 -0400
Message-ID: <3EE54EFD.1050006@cyberone.com.au>
Date: Tue, 10 Jun 2003 13:22:37 +1000
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
References: <PEEPIDHAKMCGHDBJLHKGKEACCPAA.rwhite@casabyte.com>
In-Reply-To: <PEEPIDHAKMCGHDBJLHKGKEACCPAA.rwhite@casabyte.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Robert White wrote:

>From: linux-kernel-owner@vger.kernel.org
>[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Nick Piggin
>
>
>>Chris Mason wrote:
>>
>
>>>The major difference from Nick's patch is that once the queue is marked
>>>full, I don't clear the full flag until the wait queue is empty.  This
>>>means new io can't steal available requests until every existing waiter
>>>has been granted a request.
>>>
>
>>Yes, this is probably a good idea.
>>
>
>
>Err... wouldn't this subvert the spirit, if not the warrant, of real time
>scheduling and time-critical applications?
>

No, my patch (plus Chris' modification) change request allocation
from an overloaded queue from semi random (timing dependant mixture
of LIFO and FIFO), to FIFO.

As Chris has shown, can cause a task to be starved for 2.7s (and
theoretically infinite) when it should be woken in < 200ms under
similar situations with the FIFO scheme.

>
>After all we *do* want to all-but-starve lower priority tasks of IO in the
>presence of higher priority tasks.  A select few applications absolutely
>need to be pampered (think ProTools audio mixing suite on the Mac etc.) and
>any solution that doesn't take this into account will have to be re-done by
>the people who want to bring these kinds of tasks to Linux.
>
>I am not most familiar with this body of code, but wouldn't the people
>trying to do audio sampling and gaming get really frosted if they had to
>wait for a list of lower priority IO events to completely drain before they
>could get back to work?  It would certainly produce really bad encoding of
>live data streams (etc).
>
>

Actually, there is no priority other than time (ie. FIFO), and
seek distance in the IO subsystem. I guess this is why your
arguments fall down ;)

>>From a purely queue-theory stand point, I'm not even sure why this queue can
>become "full".  Shouldn't the bounding case come about primarily by lack of
>resources (can't allocate a queue entry or a data block) out where the users
>can see and cope with the problem before all the expensive blocking and
>waiting.
>

In practice, the problems of having a memory size limited queue
outweigh the benefits.

>
>Still from a pure-theory standpoint, it would be "better" to make the wait
>queues priority queues and leave their sizes unbounded.
>
>In practice it is expensive to maintain a fully "proper" priority queue for
>a queue of non-trivial size.  Then again, IO isn't cheap over the domain of
>time anyway.
>

If IO priorities were implemented, you still have the problem of
starvation. It would be better to simply have a per process limit
on request allocation, and implement the priority scheduling in
the io scheduler.

I think you would find that most processes do just fine with
just a couple of requests each, though.

>
>
>The solution proposed, by limiting the queue size sort-of turns the
>scheduler's wakeup behavior into that priority queue sorting mechanism.
>That in turn would (it seems to me) lead to some degenerate behaviors just
>outside the zone of midline stability.  In short several very-high-priority
>tasks could completely starve out the system if they can consistently submit
>enough request to fill the queue.
>
>[That is: consider a bunch of tasks sleeping in the scheduler because they
>are waiting for the queue to empty.  When they are all woken up, they will
>actually be scheduled in priority order.  So higher priority tasks get first
>crack at the "empty" queue.  If there are "enough" such tasks (which are IO
>bound on this device) they will keep getting serviced, and then keep going
>back to sleep on the full queue.  (And god help you if they are runaways
>8-).  The high priority tasks constantly butt in line (because the scheduler
>is now the keeper of the IO queue) and the lower priority tasks could wait
>forever.]
>

No, they will be woken up one at a time as requests
become freed, and in FIFO order. It might be possible
for a higher (CPU) priority task to be woken up
before the previous has a chance to run, but this
scheme is no worse than before (the solution here is
per process request limits, but this is 2.4).


