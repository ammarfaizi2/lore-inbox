Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132820AbRDDNnX>; Wed, 4 Apr 2001 09:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132819AbRDDNnN>; Wed, 4 Apr 2001 09:43:13 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:41147 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S132820AbRDDNm5>;
	Wed, 4 Apr 2001 09:42:57 -0400
Importance: Normal
Subject: Re: a quest for a better scheduler
To: Ingo Molnar <mingo@elte.hu>, Mike Kravetz <mkravetz@sequent.com>
Cc: Fabio Riccardi <fabio@chromium.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        lse-tech@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF401BD38B.CF3B1E9F-ON85256A24.0048543A@pok.ibm.com>
From: "Hubertus Franke" <frankeh@us.ibm.com>
Date: Wed, 4 Apr 2001 09:43:55 -0400
X-MIMETrack: Serialize by Router on D01ML244/01/M/IBM(Release 5.0.7 |March 21, 2001) at
 04/04/2001 09:42:05 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This is an important point that Mike is raising and it also addresses a
critique that Ingo issued yesterday, namely interactivity and fairness.
The HP scheduler completely separates the per-CPU runqueues and does
not take preemption goodness or alike into account. This can lead to
unfair proportionment of CPU cycles, strong priority inversion and a
potential
lack of interactivity.

Our MQ scheduler does yield the same decision in most cases
(other than defined by some race condition on locks and counter members)

It is not clear that yielding the same decision as the current scheduler
is the ultimate goal to shoot for, but it allows comparision.

Another point to raise is that the current scheduler does a exhaustive
search
for the "best" task to run. It touches every process in the runqueue. this
is
ok if the runqueue length is limited to a very small multiple of the #cpus.
But that is not what high end server systems encounter.

With the rising number of processors, lock contention can quickly become
a bottleneck. If we assume that load (#running-task) increases somewhat
linear with #cpus, the problem gets even worth because not only have I
increased the number of clients but also the lock hold time.

Clinging on to the statement that #running-tasks ~ #cpus, ofcourse saves
you from that dilemma, but not everybody is signing on to this limitation.

MQ and priority-list help in 2 ways.

MQ reduces the average lock holdtime because on average it only inspects
#running-tasks/#cpus tasks to make a local decision. It then goes on to
inspect (#cpus-1) datastructures representing the next best to run tasks
on those remote cpus all without holding the lock, thus substantially
reducing lock contention. Note we still search the entire set of runnable
tasks, however we do it in a distributed collaborative manner.
The only time we deviate from the current scheduler decision is in the
case when two cpus have identified the same remote task as a target for
remote stealing. In that case one will win and the other cpu will continue
looking somewhere else, although there might have been another tasks
on that cpu to steal.

priority list schedulers (PRS) only helps in reducing lock hold time,
which can result in some relieve wrt lock contention, but not a whole lot.
PRS can limit the lists it has to search based on the PROC_CHANGE_PENALTY.
It also keeps 0-counter in a list that is never inspected. One can
even go further and put YIELD tasks in a separate list, given that the
sys_sched_yield already does some optimizations.
The older version (12/00) posted on LSE is functionally equivalent to the
current scheduler.
I will put up another version this week that is based on a bitmask and
which is a bit more agressive in that it ignores the MM goodness boost of 1
which in my books is merely a tie breaker between two task of equal
goodness.

Beyond that we have done some work on cpu pooling, which is to identify
a set of cpus that form a scheduling set. We still consider in
reschedule_idle all cpus for preemption but in schedule it is sufficient
to only schedule within the own set. That again can limit lock hold time
with MQ and we have seen some improvements. We also deploy load balacing.

To summarize, we have taken great care of trying to preserve the current
scheduler semantics and have laid out a path to relax some of the semantics
for further improvements.
I don't believe that the HP scheduler is sufficient since it is lacking
load balacing, which naturally occurs in our MQ scheduler, and it lacks
the interactivity requirements that Ingo pointed out.

Most of these things are discussed in great detail in the writeups under
lse.sourceforge.net/scheduling. I also believe we show there that the
MQ performance for low thread counts is also matching the vanilla case.

I further don't understand the obsession of keeping the scheduler simple.
If there are improvements and I don't believe the MQ is all that
complicated
and its well documented, why not put it in.


Hubertus Franke
Enterprise Linux Group (Mgr),  Linux Technology Center (Member Scalability)

email: frankeh@us.ibm.com
(w) 914-945-2003    (fax) 914-945-4425   TL: 862-2003



Mike Kravetz <mkravetz@sequent.com> on 04/03/2001 10:47:00 PM

To:   Fabio Riccardi <fabio@chromium.com>
cc:   Mike Kravetz <mkravetz@sequent.com>, Ingo Molnar <mingo@elte.hu>,
      Hubertus Franke/Watson/IBM@IBMUS, Linux Kernel List
      <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject:  Re: a quest for a better scheduler



On Tue, Apr 03, 2001 at 05:18:03PM -0700, Fabio Riccardi wrote:
>
> I have measured the HP and not the "scalability" patch because the two do
more
> or less the same thing and give me the same performance advantages, but
the
> former is a lot simpler and I could port it with no effort on any recent
> kernel.

Actually, there is a significant difference between the HP patch and
the one I developed.  In the HP patch, if there is a schedulable task
on the 'local' (current CPU) runqueue it will ignore runnable tasks on
other (remote) runqueues.  In the multi-queue patch I developed, the
scheduler always attempts to make the same global scheduling decisions
as the current scheduler.

--
Mike Kravetz                                 mkravetz@sequent.com
IBM Linux Technology Center



