Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263748AbRGOT7T>; Sun, 15 Jul 2001 15:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266909AbRGOT7J>; Sun, 15 Jul 2001 15:59:09 -0400
Received: from sncgw.nai.com ([161.69.248.229]:52390 "EHLO mcafee-labs.nai.com")
	by vger.kernel.org with ESMTP id <S263748AbRGOT6z>;
	Sun, 15 Jul 2001 15:58:55 -0400
Message-ID: <XFMail.20010715130221.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20010713154305.G1137@w-mikek2.des.beaverton.ibm.com>
Date: Sun, 15 Jul 2001 13:02:21 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: Mike Kravetz <mkravetz@sequent.com>
Subject: Re: CPU affinity & IPI latency
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
        lse-tech@lists.sourceforge.net, Larry McVoy <lm@bitmover.com>,
        David Lang <david.lang@digitalinsight.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 13-Jul-2001 Mike Kravetz wrote:
> On Fri, Jul 13, 2001 at 12:51:53PM -0700, David Lang wrote:
>> A real-world example of this issue.
>> 
>> I was gzipping a large (~800MB) file on a dual athlon box. the gzip prcess
>> was bouncing back and forth between the two CPUs. I actually was able to
>> gzip faster by starting up setiathome to keep one CPU busy and force the
>> scheduler to keep the gzip on a single CPU (I ran things several times to
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

The problem of the current scheduler is that it acts like an infinite feedback
system.
When we're going to decide if we've to move a task we analyze the status at the
current time without taking in account the system status at previous time
values.
But the feedback we send ( IPI to move the task ) take a finite time to hit the
target CPU and, meanwhile, the system status changes.
So we're going to apply a feedback calculated in time T0 to a time Tn, and this
will result in system auto-oscillation that we perceive as tasks bouncing
between CPUs.
This is kind of electronic example but it applies to all feedback systems.
The solution to this problem, given that we can't have a zero feedback delivery
time, is :

1) lower the feedback amount, that means, try to minimize task movements

2) a low pass filter, that means, when we're going to decide the sort ( move )
        of a task, we've to weight the system status with the one that it had
        at previous time values





- Davide

