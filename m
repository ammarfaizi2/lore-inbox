Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317819AbSFSLPY>; Wed, 19 Jun 2002 07:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317847AbSFSLPX>; Wed, 19 Jun 2002 07:15:23 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:60680 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S317819AbSFSLPW>; Wed, 19 Jun 2002 07:15:22 -0400
Date: Wed, 19 Jun 2002 07:10:53 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Robert Love <rml@tech9.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: Question about sched_yield()
In-Reply-To: <1024428314.3090.223.camel@sinai>
Message-ID: <Pine.LNX.3.96.1020619065011.1119B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Jun 2002, Robert Love wrote:

> the second bunch should _not_ receive has much CPU time as the first. 
> This has nothing to do with intelligent work or blocking or picking your
> nose.  It has everything to do with the fact that yielding means
> "relinquish my timeslice" and "put me at the end of the runqueue".

I have put some ideas below, I agree with "relinquish" but not end of
queue.
 
> If we are doing this, then why does the sched_yield'ing task monopolize
> the CPU?  BECAUSE IT IS BROKEN.

Consider the case where a threaded application and a CPU hog are running.
In sum the threaded process is also a hog, although any one thread is not.

I find I can figure out problems like this if I start at the desired
result and work back, and what I believe is the desired result is that the
pure hog gets half the CPU and the threaded application, in aggregate, get
the other. So to provide this, I would think that the desired action at
sched_yeild() would look somewhat like this: 

If there is less than {sched overhead} on the timeslice
  add to end of queue
  do accounting to reflect the time used
  run the next thread
else
  if there is another thread of this process
    queue this thread following the last thread of this process
    give the remaining time slice to the top thread of this process
  else
    put the yeild thread at the end of the queue
  .
.

One question which arises is cpu affinity, and I confess that I can't
predict the better of process affinity or contested resource affinity (run
the next thread now). But for uni machines, I think what I outline above
does result in the behaviour I find most intuitive and desirable.

On your comment about leaving the yeilded thread at the top of the queue,
putting the yeilded thread at the end of the queue effectively forces the
context switch time to be the sum of all the timeslices given in one pass
through the queue. In a system with a contested resource and at least one
hog, I think that would make the threaded task starve for CPU. As noted by
several people, queue back at the head also can behave badly for some
cases, although the demo program provided is probably not typical.

I think what I suggest will avoid both problems, although it might have
other drawbacks, like sched overhead if the queue was very long and didn't
have other threads. Atypical, but a max "scan for another thread" count
could be provided, or even a per-process count of runable threads in the
queue, which is probably more overhead than just scanning for light load.
At least under light load you can afford it.

Your comments?

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

