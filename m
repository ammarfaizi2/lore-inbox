Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263859AbTFJVHY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 17:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbTFJVHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 17:07:00 -0400
Received: from mail.casabyte.com ([209.63.254.226]:52491 "EHLO
	mail.1casabyte.com") by vger.kernel.org with ESMTP id S263859AbTFJVD7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 17:03:59 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "Nick Piggin" <piggin@cyberone.com.au>
Cc: "Chris Mason" <mason@suse.com>, "Andrea Arcangeli" <andrea@suse.de>,
       "Marc-Christian Petersen" <m.c.p@wolk-project.de>,
       "Jens Axboe" <axboe@suse.de>,
       "Marcelo Tosatti" <marcelo@conectiva.com.br>,
       "Georg Nikodym" <georgn@somanetworks.com>,
       "lkml" <linux-kernel@vger.kernel.org>,
       "Matthias Mueller" <matthias.mueller@rz.uni-karlsruhe.de>
Subject: RE: [PATCH] io stalls
Date: Tue, 10 Jun 2003 14:17:11 -0700
Message-ID: <PEEPIDHAKMCGHDBJLHKGCECGCPAA.rwhite@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <3EE54EFD.1050006@cyberone.com.au>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Piggin [mailto:piggin@cyberone.com.au]
Sent: Monday, June 09, 2003 8:23 PM
>
> Actually, there is no priority other than time (ie. FIFO), and
> seek distance in the IO subsystem. I guess this is why your
> arguments fall down ;)

I'll buy that for the most part, though one of the differences I read
elsewhere in the thread was the choice between add_wait_queue() and
add_wait_queue_exclusive().  You will, however, note that one of the factors
that is playing in this patch is process priority.

(If I understand correctly) The wait queue in question becomes your FIFOing
agent, it is kind of a pre-queue on the actual IO queue, once you reach a
"full" condition.

In the later case [add_wait_queue_exclusive()] you are strictly FIFO over
the set of processes, where the moment-of-order is determined by insertion
into the wait queue.

In the former case [add_wait_queue()] when the queue is woken up all the
waiters will be marked executable on the scheduler, and the scheduler will
then (at least tend to) sort the submissions into task priority order.  So
the higher priority tasks will get to butt into line.  Worse, the FIFO is
essentially lost to the vagaries of the scheduler so without the _exclusive
you have no FIFO at all.

I think that is the reason that Chris was saying the
add_wait_queue_exclusive() mode "does seem to scale much better."

So your "original new" batching agent is really order-of-arrival that
becomes anti-sorted by process priority.  Which can lead to scheduler
induced starvation (and the observed "improvements" by using the strict FIFO
created by a_w_q_exclusive).  The problem is that you get a little communist
about the FIFO-ness when you use a_w_q_exclusive() and that can *SERIOUSLY*
harm a task that must approach real-time behavior.

One solution would be to stick with the add_wait_queue() process-priority
influenced never-really-FIFO, but every time a process/task wakes up, and it
then doesn't get its request onto the queue, add a small fixed increment to
its priority before going back into the wait.  This gives you both the
process-priority mechanism and a fairness metric.

Something like (in pure pseudo-code since I don't have my references here):

int priority_delta = 0
while (try_enqueing_io_request() == queue_full) {
  if (current->priority < priority_max) {
    current->priority += priority_increment;
    priority_delta += priority_increment;
  }
  wait_on_queue()
}
current->priority -= priority_delta;

(and still, of course, only wake the wait queue when the "full" queue
reaches empty.)

What that gets you is democratic entry into the io request queue when it is
non-full.  It gets you seniority-based (plutocratic?) access to the io queue
as your request "ages" in the full pool.  If the pool gets so large that all
the requests are making their tasks reach priority_max then you "degrade" to
the fairness of the scheduler, which is an arbitrary but workable metric.

You get all that, but you preserve (or invent) a relationship that lets the
task priority automagically factor in "for free" so that relative starvation
(which is a good thing for deliberately asymmetric task priorities, and
matches user expectations) can be achieved without ever having absolute
starvation.

Further if priority_max isn't priority_system_max you get the
real-time-trumps-all behavior that something like a live audio stream
encoder may need (for any priority >= priority_max).

Rob.

