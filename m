Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132804AbRDDPbb>; Wed, 4 Apr 2001 11:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132840AbRDDPbP>; Wed, 4 Apr 2001 11:31:15 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:40365 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S132804AbRDDPaw>;
	Wed, 4 Apr 2001 11:30:52 -0400
Importance: Normal
Subject: Re: a quest for a better scheduler
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        lse-tech@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF44F2A6FB.BD0D4064-ON85256A24.00543C9D@pok.ibm.com>
From: "Hubertus Franke" <frankeh@us.ibm.com>
Date: Wed, 4 Apr 2001 11:28:14 -0400
X-MIMETrack: Serialize by Router on D01ML244/01/M/IBM(Release 5.0.7 |March 21, 2001) at
 04/04/2001 11:30:01 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yes, Andrea.

We actually already went a step further. We treat the scheduler
as a single entity, rather than splitting it up.

Based on the MQ scheduler we do the balancing across all nodes
at reschedule_idle time. We experimented to see whether only looking
for idle tasks remotely is a good idea, but it bloats the code.
Local scheduling decisions are limited to a set of cpus, which
could coincide with the cpus of one node, or if desirable on
smaller granularities.

In addition we implemented a global load balancing scheme that
ensures that load is equally distributed across all run queues.
This is made a loadable module, so you can plug in what ever
you want.

I grant in NUMA it might actually be desirable to separate
schedulers completely (we can do that trivially in reschedule_idle),
but you need loadbalancing at some point.

Here is the list of patches:

MultiQueue Scheduler: http://lse.sourceforge.net/scheduling/2.4.1.mq1-sched
Pooling Extension:    http://lse.sourceforge.net/scheduling/LB/2.4.1-MQpool
LoadBalancing:
http://lse.sourceforge.net/scheduling/LB/loadbalance.c


Hubertus Franke
Enterprise Linux Group (Mgr),  Linux Technology Center (Member Scalability)
, OS-PIC (Chair)
email: frankeh@us.ibm.com
(w) 914-945-2003    (fax) 914-945-4425   TL: 862-2003



Andrea Arcangeli <andrea@suse.de> on 04/04/2001 11:08:47 AM

To:   Ingo Molnar <mingo@elte.hu>
cc:   Hubertus Franke/Watson/IBM@IBMUS, Mike Kravetz
      <mkravetz@sequent.com>, Fabio Riccardi <fabio@chromium.com>, Linux
      Kernel List <linux-kernel@vger.kernel.org>,
      lse-tech@lists.sourceforge.net
Subject:  Re: a quest for a better scheduler



On Wed, Apr 04, 2001 at 03:34:22PM +0200, Ingo Molnar wrote:
>
> On Wed, 4 Apr 2001, Hubertus Franke wrote:
>
> > Another point to raise is that the current scheduler does a exhaustive
> > search for the "best" task to run. It touches every process in the
> > runqueue. this is ok if the runqueue length is limited to a very small
> > multiple of the #cpus. [...]
>
> indeed. The current scheduler handles UP and SMP systems, up to 32
> (perhaps 64) CPUs efficiently. Agressively NUMA systems need a different
> approach anyway in many other subsystems too, Kanoj is doing some
> scheduler work in that area.

I didn't seen anything from Kanoj but I did something myself for the
wildfire:


ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.3aa1/10_numa-sched-1


this is mostly an userspace issue, not really intended as a kernel
optimization
(however it's also partly a kernel optimization). Basically it splits the
load
of the numa machine into per-node load, there can be unbalanced load across
the
nodes but fairness is guaranteed inside each node. It's not extremely well
tested but benchmarks were ok and it is at least certainly stable.

However Ingo consider that in a 32-way if you don't have at least 32 tasks
running all the time _always_ you're really stupid paying such big money
for
nothing ;). So the fact the scheduler is optimized for 1/2 tasks running
all
the time is not nearly enough for those machines (and of course also the
scheduling rate automatically increases linearly with the increase of the
number of cpus). Now it's perfectly fine that we don't ask the embedded and
desktop guys to pay for that, but a kernel configuration option to select
an
algorithm that scales would be a good idea IMHO. The above patch just adds
a
CONFIG_NUMA_SCHED. The scalable algorithm can fit into it and nobody will
be
hurted by that (CONFIG_NUMA_SCHED cannot even be selected by x86 compiles).

Andrea



