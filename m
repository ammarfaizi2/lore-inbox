Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267567AbRGNDY2>; Fri, 13 Jul 2001 23:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267569AbRGNDYT>; Fri, 13 Jul 2001 23:24:19 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:57762 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267567AbRGNDYA>;
	Fri, 13 Jul 2001 23:24:00 -0400
Importance: Normal
Subject: Re: CPU affinity & IPI latency
To: Mike Kravetz <mkravetz@sequent.com>
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OFBCDBFC1D.BD7BBF9C-ON85256A89.000F6AC1@pok.ibm.com>
From: "Hubertus Franke" <frankeh@us.ibm.com>
Date: Fri, 13 Jul 2001 23:25:21 -0400
X-MIMETrack: Serialize by Router on D01ML244/01/M/IBM(Release 5.0.8 |June 18, 2001) at
 07/13/2001 11:23:54 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mike, could we utilize the existing mechanism such as has_cpu.

Here is my approach/suggestion.
We introduce in the sched_data[cpu] a resched_task slot;

     struct task *resched_task;

When in reschedule_idle() a target cpu is to be decided for task <p>
we check the resched_task slot. If the slot is pointing
to some task, then this task should be considered running
and we should not consider the preemption goodness to the
currently running task as we know it already got IPI'ed.
See also the schedule() function describe later on.

reschedule_idle(struct task *p)
{
     :
     :

     struct task *rst = sched_data[target_cpu].resched_task;
      struct task *rmt = sched_data[target_cpu].current;
     if (rst != NULL) {
          if (preemption_goodness(p,rst, ...) > 1)
                    p->processor = target_cpu;
                    p->has_cpu   = 1;
               rst->has_cpu = 0; /* reset as we overwrite */
               sched_data[target_cpu].resched_task = p;
               /* so we make old <rst> available for scheduling
                * and temp-bind <p> to target_cpu */
                * don't have to send IPI as this to handles race
                * condition and we are holding scheduling lock
                */
          } else {
               continue;
               /* we know that the current priority won't be
                * larger than the one of <rst> otherwise this
                * would have been picked up in the schedule
                */
          }
     } else {
          /* standard stuff that we always do */
     }
}

In schedule() we need to check whether a reschedule reservation is held.
First we go through the standard <stillrunning> check to compute the
initial
<c> goodness value. Then under

still_running_back:

     <loop through the runqueue>
     /* note that <rst> will be ignored due to <has_cpu=1> flag */

     /* check wether reservation <rst> exists */
     rst = sched_data[this_cpu].resched_task;
     if (rst != NULL) {
          c = goodness(rst,..);
          if (c > best_prio) {
               best_prio = goodness(rst,..);
               next = rst;
               sched_data[this_cpu].resched_task = NULL;
          } else {
               /* need to return rst back to scheduable state */
               rst->has_cpu = 0;
          }
      }


This approach would eliminate the need to check during runqueue scan
to check for each task's saved_cpus_allowed and would also make sure that
only one task reserves running on a particular cpu. Reservations are
preempted through the existing mechanism, namely goodness comparision,
and such "preempted" tasks are returned to general scheduability.
are put back into the

Hubertus Franke
Enterprise Linux Group (Mgr),  Linux Technology Center (Member Scalability)
, OS-PIC (Chair)
email: frankeh@us.ibm.com
(w) 914-945-2003    (fax) 914-945-4425   TL: 862-2003



Mike Kravetz <mkravetz@sequent.com>@vger.kernel.org on 07/13/2001 06:43:05
PM

Sent by:  linux-kernel-owner@vger.kernel.org


To:   David Lang <david.lang@digitalinsight.com>
cc:   Larry McVoy <lm@bitmover.com>, Davide Libenzi
      <davidel@xmailserver.org>, lse-tech@lists.sourceforge.net, Andi Kleen
      <ak@suse.de>, linux-kernel@vger.kernel.org
Subject:  Re: CPU affinity & IPI latency



On Fri, Jul 13, 2001 at 12:51:53PM -0700, David Lang wrote:
> A real-world example of this issue.
>
> I was gzipping a large (~800MB) file on a dual athlon box. the gzip
prcess
> was bouncing back and forth between the two CPUs. I actually was able to
> gzip faster by starting up setiathome to keep one CPU busy and force the
> scheduler to keep the gzip on a single CPU (I ran things several times to
> verify it was actually faster)
>
> David Lang

That does sound like the same behavior I was seeing with lat_ctx.  Like
I said in my previous note, the scheduler does try to take CPU affinity
into account.  reschedule_idle() does a pretty good job of determining
what CPU a task should run on.  In the case of lat_ctx (and I believe
your use of gzip), the 'fast path' in reschedule_idle() is taken because
the CPU associated with the awakened task is idle.  However, before
schedule() is run on the 'target' CPU, schedule() is run on another
CPU and the task is scheduled there.

The root cause of this situation is the delay between the time
reschedule_idle() determines what is the best CPU a task should run
on, and the time schedule() is actually ran on that CPU.

I have toyed with the idea of 'temporarily binding' a task to a CPU
for the duration of the delay between reschedule_idle() and schedule().
It would go something like this,

- Define a new field in the task structure 'saved_cpus_allowed'.
  With a little collapsing of existing fields, there is room to put
  this on the same cache line as 'cpus_allowed'.
- In reschedule_idle() if we determine that the best CPU for a task
  is the CPU it is associated with (p->processor), then temporarily
  bind the task to that CPU.  The task is temporarily bound to the
  CPU by overwriting the 'cpus_allowed' field such that the task can
  only be scheduled on the target CPU.  Of course, the original
  value of 'cpus_allowed' is saved in 'saved_cpus_allowed'.
- In schedule(), the loop which examines all tasks on the runqueue
  will restore the value of 'cpus_allowed'.

This would preserve the 'best CPU' decision made by reschedule_idle().
On the down side, 'temporarily bound' tasks could not be scheduled
until schedule() is run on their associated CPUs.  This could potentially
waste CPU cycles, and delay context switches.  In addition, it is
quite possible that while a task is 'temporarily bound' the state of
the system could change in such a way that the best CPU is no longer
best.

There appears to be a classic tradeoff between CPU affinity and
context switch time.

Comments?

--
Mike Kravetz                                 mkravetz@sequent.com
IBM Linux Technology Center
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



