Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbTFJBey (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 21:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262366AbTFJBey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 21:34:54 -0400
Received: from mail.casabyte.com ([209.63.254.226]:24339 "EHLO
	mail.1casabyte.com") by vger.kernel.org with ESMTP id S262008AbTFJBew
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 21:34:52 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "Nick Piggin" <piggin@cyberone.com.au>, "Chris Mason" <mason@suse.com>
Cc: "Andrea Arcangeli" <andrea@suse.de>,
       "Marc-Christian Petersen" <m.c.p@wolk-project.de>,
       "Jens Axboe" <axboe@suse.de>,
       "Marcelo Tosatti" <marcelo@conectiva.com.br>,
       "Georg Nikodym" <georgn@somanetworks.com>,
       "lkml" <linux-kernel@vger.kernel.org>,
       "Matthias Mueller" <matthias.mueller@rz.uni-karlsruhe.de>
Subject: RE: [PATCH] io stalls
Date: Mon, 9 Jun 2003 18:48:07 -0700
Message-ID: <PEEPIDHAKMCGHDBJLHKGKEACCPAA.rwhite@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <3EE51D99.2080604@cyberone.com.au>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Nick Piggin

> Chris Mason wrote:

> >The major difference from Nick's patch is that once the queue is marked
> >full, I don't clear the full flag until the wait queue is empty.  This
> >means new io can't steal available requests until every existing waiter
> >has been granted a request.

> Yes, this is probably a good idea.


Err... wouldn't this subvert the spirit, if not the warrant, of real time
scheduling and time-critical applications?

After all we *do* want to all-but-starve lower priority tasks of IO in the
presence of higher priority tasks.  A select few applications absolutely
need to be pampered (think ProTools audio mixing suite on the Mac etc.) and
any solution that doesn't take this into account will have to be re-done by
the people who want to bring these kinds of tasks to Linux.

I am not most familiar with this body of code, but wouldn't the people
trying to do audio sampling and gaming get really frosted if they had to
wait for a list of lower priority IO events to completely drain before they
could get back to work?  It would certainly produce really bad encoding of
live data streams (etc).

>From a purely queue-theory stand point, I'm not even sure why this queue can
become "full".  Shouldn't the bounding case come about primarily by lack of
resources (can't allocate a queue entry or a data block) out where the users
can see and cope with the problem before all the expensive blocking and
waiting.

Still from a pure-theory standpoint, it would be "better" to make the wait
queues priority queues and leave their sizes unbounded.

In practice it is expensive to maintain a fully "proper" priority queue for
a queue of non-trivial size.  Then again, IO isn't cheap over the domain of
time anyway.

The solution proposed, by limiting the queue size sort-of turns the
scheduler's wakeup behavior into that priority queue sorting mechanism.
That in turn would (it seems to me) lead to some degenerate behaviors just
outside the zone of midline stability.  In short several very-high-priority
tasks could completely starve out the system if they can consistently submit
enough request to fill the queue.

[That is: consider a bunch of tasks sleeping in the scheduler because they
are waiting for the queue to empty.  When they are all woken up, they will
actually be scheduled in priority order.  So higher priority tasks get first
crack at the "empty" queue.  If there are "enough" such tasks (which are IO
bound on this device) they will keep getting serviced, and then keep going
back to sleep on the full queue.  (And god help you if they are runaways
8-).  The high priority tasks constantly butt in line (because the scheduler
is now the keeper of the IO queue) and the lower priority tasks could wait
forever.]

{please note; I write some fairly massively-threaded applications, it would
only take one such application running at a high priority to produce "a
substantial number" of high priority processes submitting IO requests, so
the scenario, while not common, is potentially real.}

(so just off the top of my head...)

I would think that the best theoretical solution would be a priority heap.
(ignoring heap storage requirements for a moment) you keep the highest
priority items in the front of the heap and any time a heap reorg passes a
node by you jack that nodes priority by one.  For an extremely busy queue
nothing is starved, but the incline remains high enough to make sure that
the truly desperate priorities (of which there should be few in a real world
system) will "never" wait behind some dd(1) of vanishingly close to no
import.

Clearly doing a full heap with only pointers is ugly almost beyond
comprehension, and doing a heap in an array would tend to be impractical for
a large list under variable conditions.  A red-black tree gets too expensive
if you use them that many times throughout a system.  (and so on)

While several possible sort-of-heapish or sort-of-priority-queueish data str
uctures come to mind, I don't have a replacement concept that I can really
promote just now...

I would say that at a MINIMUM there needs to be some threshold of priority
for requests that get to go on a "full list" no matter what.  There really
"ought to be" a way for requests from higher priority tasks to get  closer
to the front of the list.  There "should be" a priority floor where tasks
with lower priorities get their requests queued up with the current
first-come-first-served mentality (as we don't need to spend a lot of time
thinking about things that have been nice(d) into the noise floor).  And
then there should be a promotion mechanism to prevent complete starvation.

Anything simpler and it is safer from a system stability standpoint to keep
with the current high-latency-on-occasion simple queue solution.

Rob.

