Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266730AbRGPKNV>; Mon, 16 Jul 2001 06:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267258AbRGPKND>; Mon, 16 Jul 2001 06:13:03 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:51854 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267159AbRGPKMy>;
	Mon, 16 Jul 2001 06:12:54 -0400
Importance: Normal
Subject: Re: CPU affinity & IPI latency
To: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OFE9275D2B.C8E7F6FC-ON85256A8B.00370192@pok.ibm.com>
From: "Hubertus Franke" <frankeh@us.ibm.com>
Date: Mon, 16 Jul 2001 06:10:47 -0400
X-MIMETrack: Serialize by Router on D01ML244/01/M/IBM(Release 5.0.8 |June 18, 2001) at
 07/16/2001 06:12:41 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David, you are preaching to choir.

One can not have it both ways, at least without "#ifdef"s.
As Mike stated, we made the decision to adhere to current scheduling
semantics
purely for the purspose of comparision and increased adaptation chances.
As shown with the LoadBalancing addition to MQ, there are simple ways to
relax and completely eliminate the feedback between the queues, if one so
desires.

As for the solutions you proposed for the "switching problem", namely the
wakeup
list. I don't think you want a list here. A list would basically mean that
you
would need to walk it and come up with a single decision again. I think
what
I proposed, namely a per-CPU reschedule reservation that can be overwritten
taking
PROC_CHANGE_PENALTY or some form of it into account, seems a better
solution.
Open to discussions...

Hubertus Franke
Enterprise Linux Group (Mgr),  Linux Technology Center (Member Scalability)

email: frankeh@us.ibm.com



Davide Libenzi <davidel@xmailserver.org>@vger.kernel.org on 07/15/2001
04:02:21 PM

Sent by:  linux-kernel-owner@vger.kernel.org


To:   Mike Kravetz <mkravetz@sequent.com>
cc:   linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
      lse-tech@lists.sourceforge.net, Larry McVoy <lm@bitmover.com>, David
      Lang <david.lang@digitalinsight.com>
Subject:  Re: CPU affinity & IPI latency




On 13-Jul-2001 Mike Kravetz wrote:
> On Fri, Jul 13, 2001 at 12:51:53PM -0700, David Lang wrote:
>> A real-world example of this issue.
>>
>> I was gzipping a large (~800MB) file on a dual athlon box. the gzip
prcess
>> was bouncing back and forth between the two CPUs. I actually was able to
>> gzip faster by starting up setiathome to keep one CPU busy and force the
>> scheduler to keep the gzip on a single CPU (I ran things several times
to
>> verify it was actually faster)
>>
>> David Lang
>
> That does sound like the same behavior I was seeing with lat_ctx.  Like
> I said in my previous note, the scheduler does try to take CPU affinity
> into account.  reschedule_idle() does a pretty good job of determining
> what CPU a task should run on.  In the case of lat_ctx (and I believe
> your use of gzip), the 'fast path' in reschedule_idle() is taken because
> the CPU associated with the awakened task is idle.  However, before
> schedule() is run on the 'target' CPU, schedule() is run on another
> CPU and the task is scheduled there.
>
> The root cause of this situation is the delay between the time
> reschedule_idle() determines what is the best CPU a task should run
> on, and the time schedule() is actually ran on that CPU.
>
> I have toyed with the idea of 'temporarily binding' a task to a CPU
> for the duration of the delay between reschedule_idle() and schedule().
> It would go something like this,
>
> - Define a new field in the task structure 'saved_cpus_allowed'.
>   With a little collapsing of existing fields, there is room to put
>   this on the same cache line as 'cpus_allowed'.
> - In reschedule_idle() if we determine that the best CPU for a task
>   is the CPU it is associated with (p->processor), then temporarily
>   bind the task to that CPU.  The task is temporarily bound to the
>   CPU by overwriting the 'cpus_allowed' field such that the task can
>   only be scheduled on the target CPU.  Of course, the original
>   value of 'cpus_allowed' is saved in 'saved_cpus_allowed'.
> - In schedule(), the loop which examines all tasks on the runqueue
>   will restore the value of 'cpus_allowed'.
>
> This would preserve the 'best CPU' decision made by reschedule_idle().
> On the down side, 'temporarily bound' tasks could not be scheduled
> until schedule() is run on their associated CPUs.  This could potentially
> waste CPU cycles, and delay context switches.  In addition, it is
> quite possible that while a task is 'temporarily bound' the state of
> the system could change in such a way that the best CPU is no longer
> best.
>
> There appears to be a classic tradeoff between CPU affinity and
> context switch time.

The problem of the current scheduler is that it acts like an infinite
feedback
system.
When we're going to decide if we've to move a task we analyze the status at
the
current time without taking in account the system status at previous time
values.
But the feedback we send ( IPI to move the task ) take a finite time to hit
the
target CPU and, meanwhile, the system status changes.
So we're going to apply a feedback calculated in time T0 to a time Tn, and
this
will result in system auto-oscillation that we perceive as tasks bouncing
between CPUs.
This is kind of electronic example but it applies to all feedback systems.
The solution to this problem, given that we can't have a zero feedback
delivery
time, is :

1) lower the feedback amount, that means, try to minimize task movements

2) a low pass filter, that means, when we're going to decide the sort (
move )
        of a task, we've to weight the system status with the one that it
had
        at previous time values





- Davide

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



