Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132840AbRDDPiB>; Wed, 4 Apr 2001 11:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132843AbRDDPhw>; Wed, 4 Apr 2001 11:37:52 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:1717 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S132840AbRDDPhq>;
	Wed, 4 Apr 2001 11:37:46 -0400
Importance: Normal
Subject: Re: a quest for a better scheduler
To: <mingo@elte.hu>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        lse-tech@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF63B30B4E.49FE1F2A-ON85256A24.0050715E@pok.ibm.com>
From: "Hubertus Franke" <frankeh@us.ibm.com>
Date: Wed, 4 Apr 2001 11:36:24 -0400
X-MIMETrack: Serialize by Router on D01ML244/01/M/IBM(Release 5.0.7 |March 21, 2001) at
 04/04/2001 11:37:00 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



You imply that high end means thousands of processes,
simply because we have shown that in our graphs as an
asymptotic end.
No, it could mean 5*#cpus and that is not all that absurd.
This could happen with a spike in demand.

TUX is not the greatest example to use, because it does
static webpage serving and is hence tied into the
file cache. If you move up the food chain, where middleware
is active and things are a bit more complicated than
sending stuff out of the filecache, having a bunch of threads
hanging around to deal with the spike in demand is common
practive, although you think its bad.

Now coming again to MQ (forget about priority list from
now on).

When we scan either the local or the realtime queues we do
use goodness value. So we have the same flexibility as the
current scheduler if it comes to goodness() flexibility and
future improvements.

For remote stealing we do use na_goodness to compare
for a better process to steal. Hence we would loose the "+1"
information here, nevertheless, once a decision
has been made, we still use preemption verification with goodness.
Eitherway, being off by "+1" for regular tasks once in a while
is no big deal, because this problem already exists today.
While walking the runqueue, another processor can either update
the counter value of task (ok that's covered by can_schedule)
or can run recalculate, which makes the decision that one is
about to make wrong from the point of always running the best.
But that's ok, because counter, nice etc. are approximations
anyway. Through in PROC_CHANGE_PENALTY and you have a few knobs
that are used to control interactivity and throughput.

If you look at some of the results with our reflex benchmark.
For the low thread count we basically show improved performance
on the 2,4,5,6,7,8 way system if #threads < #cpus, they all show
improvements. Look at the following numbers running the
reflex benchmark, left most columns are number of threads, with
typically 1/2 of them runnable.
You can clearly see that the priority list suffers from overhead,
but MQ is beating vanilla pretty much everywhere. Again, this
is due because of rapid scheduler invocation and resulting
lock contention.

          2-way
     2.4.1          2.4.1-mq1 2.4.1-prbit
4    6.725          4.691          7.387
8    6.326          4.766          6.421
12   6.838          5.233          6.431
16   7.13      5.415          7.29

          4-way
     2.4.1          2.4.1-mq1 2.4.1-prbit
4    9.42      7.873          10.592
8    8.143          3.799          8.691
12   7.877          3.537          8.101
16   7.688          2.953          7.144

          6-way
     2.4.1          2.4.1-mq1 2.4.1-prbit
4    9.595          7.88      10.358
8    9.703          7.278          10.523
12   10.016    4.652          10.985
16   9.882          3.629          10.525

          8-way
     2.4.1          2.4.1-mq1 2.4.1-prbit
4    9.804          8.033          10.548
8    10.436    5.783          11.475
12   10.925    6.787          11.646
16   11.426    5.048          11.877
20   11.438    3.895          11.633
24   11.457    3.304          11.347
28   11.495    3.073          11.09
32   11.53          2.944          10.898


Hubertus Franke
Enterprise Linux Group (Mgr),  Linux Technology Center (Member Scalability)

email: frankeh@us.ibm.com
(w) 914-945-2003    (fax) 914-945-4425   TL: 862-2003



Ingo Molnar <mingo@elte.hu>@elte.hu> on 04/04/2001 09:23:34 AM

Please respond to <mingo@elte.hu>

Sent by:  <mingo@elte.hu>


To:   Hubertus Franke/Watson/IBM@IBMUS
cc:   Mike Kravetz <mkravetz@sequent.com>, Fabio Riccardi
      <fabio@chromium.com>, Linux Kernel List
      <linux-kernel@vger.kernel.org>
Subject:  Re: a quest for a better scheduler




On Wed, 4 Apr 2001, Hubertus Franke wrote:

> I understand the dilemma that the Linux scheduler is in, namely
> satisfy the low end at all cost. [...]

nope. The goal is to satisfy runnable processes in the range of NR_CPUS.
You are playing word games by suggesting that the current behavior prefers
'low end'. 'thousands of runnable processes' is not 'high end' at all,
it's 'broken end'. Thousands of runnable processes are the sign of a
broken application design, and 'fixing' the scheduler to perform better in
that case is just fixing the symptom. [changing the scheduler to perform
better in such situations is possible too, but all solutions proposed so
far had strings attached.]

     Ingo




