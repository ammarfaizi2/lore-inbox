Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131614AbRDFNQe>; Fri, 6 Apr 2001 09:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131625AbRDFNQX>; Fri, 6 Apr 2001 09:16:23 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:47090 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S131614AbRDFNQH>;
	Fri, 6 Apr 2001 09:16:07 -0400
Importance: Normal
Subject: RE: a quest for a better scheduler
To: Torrey Hoffman <torrey.hoffman@myrio.com>
Cc: "'Timothy D. Witham'" <wookie@osdlab.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF6B3C387C.30C3F790-ON85256A26.0046108B@pok.ibm.com>
From: "Hubertus Franke" <frankeh@us.ibm.com>
Date: Fri, 6 Apr 2001 09:15:02 -0400
X-MIMETrack: Serialize by Router on D01ML244/01/M/IBM(Release 5.0.7 |March 21, 2001) at
 04/06/2001 09:15:25 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Torrey, nothing to worry about (or at least not yet).

The new scheduler only replaces the current SMP scheduler, not the single
cpu scheduler. So the devices that you refer to are not affected at
all by these changes.

The desire for interactivity etc, lead us to stick to the current
proposed MQ scheduler semantics, namely not to completely isolate the
runqueues from each other (e.g. the HP-MQ does so), but do some cross
checking to ensure that high priority tasks are run when they need to.

First you get the same (similar good or bad scheduler semantics as the
current one) but at a significantly lower cost for medium to high end
loads (defined as #runnable tasks > #cpus)

Here is a simple approximate arithmetic. Assume the following:
- Let X be the fixed overhead to get through the scheduler (cur or MQ)
once.
- Let Y the overhead of touching a task to inspect its goodness
- Let N be the number of tasks
- Let C be the number of cpus.

The cost for the current scheduler is: X(cur) + N*Y.
The cost for the MQ scheduler is:     X(MQ)  + (N/C)*Y + C*Y
          I assumed here equal runqueue length.

You can see that this ballpark math shows that if X(cur) ~ X(MQ)
MQ is expected to be better when (N/C) + C < N   or
if (  N  >  C*C/(C-1)  )

C=2 N>4
C=3 N>4
C=4 N>5
C=5 N>6
C=6 N>7
C=7 N>8
C=8 N>9

Turns out that for C>2  this amounts to N > C+1 MQ will do better.
Now this is in the face of lack of runqueue lock contention. When
runqueue lock contention surfaces, then this will shift in favor of MQ.




Hubertus Franke
Enterprise Linux Group (Mgr),  Linux Technology Center (Member Scalability)
, OS-PIC (Chair)
email: frankeh@us.ibm.com
(w) 914-945-2003    (fax) 914-945-4425   TL: 862-2003



Torrey Hoffman <torrey.hoffman@myrio.com>@vger.kernel.org on 04/05/2001
07:53:27 PM

Sent by:  linux-kernel-owner@vger.kernel.org


To:   "'Timothy D. Witham'" <wookie@osdlab.org>, Linux Kernel List
      <linux-kernel@vger.kernel.org>
cc:
Subject:  RE: a quest for a better scheduler



Timothy D. Witham wrote :
[...]
> I propose that we work on setting up a straight forward test harness
> that allows developers to quickly test a kernel patch against
> various performance yardsticks.

[...
(proposed large server testbeds)
...]

I like this idea, but could the testbeds also include some
resource-constrained "embedded" or appliance-style systems, and
include performance yardsticks for latency and responsiveness?

It would be unfortunate if work on a revised scheduler resulted
in Linux being a monster web server on 4-way systems, but having
lousy interactive performance on web pads, hand helds, and set top
boxes.

How about a 120Mhz Pentium with 32MB of RAM and a flash disk, a 200
Mhz PowerPC with 64 MB?  Maybe a Transmeta web pad?

For the process load, something that tests responsiveness and
latency - how about a set of processes doing multicast network
transfers, CPU-intensive MPEG video and audio encode / decode,
and a test app that measures "user response", i.e. if X Windows
was running, would the mouse pointer move smoothly or jerkily?

The "better" scheduler for these applications would make sure that
multicast packets were never dropped, the MPEG decode never dropped
frames, and the "user interface" stayed responsive, etc.

Also, I would not mind a bit if the kernel had tuning options, either
in configuration or through /proc to adjust for these very different
situations.

Torrey Hoffman
Torrey.Hoffman@myrio.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



