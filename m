Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276647AbRJGXts>; Sun, 7 Oct 2001 19:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276650AbRJGXtj>; Sun, 7 Oct 2001 19:49:39 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:65265 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S276647AbRJGXt0>; Sun, 7 Oct 2001 19:49:26 -0400
Message-ID: <3BC0E9FD.4F3921C6@mvista.com>
Date: Sun, 07 Oct 2001 16:49:17 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mika Liljeberg <Mika.Liljeberg@welho.com>
CC: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Benjamin LaHaise <bcrl@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Davide Libenzi <davidel@xmailserver.org>
Subject: Re: Context switch times
In-Reply-To: <E15pWfR-0006g5-00@the-village.bc.nu> <3BC02709.A8E6F999@welho.com> <20011007150358.G30515@nightmaster.csn.tu-chemnitz.de> <3BC05D2E.94F05935@welho.com> <20011007162439.P748@nightmaster.csn.tu-chemnitz.de> <3BC067BB.73AF1EB5@welho.com> <3BC0982A.84ECBE7B@mvista.com> <3BC0D1C9.63C7F218@welho.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mika Liljeberg wrote:
> 
> george anzinger wrote:
> > On the face of it this only seems unfair.  I think what we want to do is
> > to allocate the cpu resources among competing tasks as dictated by their
> > NICE values.  If each task gets its allotted share it should not matter
> > if one of them is monopolizing one cpu.  This is not to say that things
> > will work out this way, but to say that this is not the measure, nor the
> > thing to look at.
> 
> I'm not sure I fully understood what you're driving at, but surely "each
> task getting its allotted share" implies that the tasks are correctly
> balanced across CPUs? 

Actually I am trying to recast your requirement (for fairness) into
something that is clean and easy to code :)  Keeping track of the number
of tasks a cpu executes over a given period of time, while possible,
does not seem to me to give a very good indication of its load.

> I take your point that if you're only interested
> in the total completion time of certain set of tasks, it doesn't matter
> how they are divided among CPUs as long as each CPU is crunching at
> maximum capacity. However, if you're interested in the completion time
> of a particular task (or if the task is mostly CPU bound but with
> occasional interaction with the user), you need to provide fairness all
> the way through the scheduling process. This, IMHO, implies balancing
> the tasks across CPUs.

I don't dispute balance, I am just trying to suggest a way to do it that
IMHO is relatively easy.
> 
> How the balance is determined is another issue, though. I basically
> proposed summing the time slices consumed by tasks executing on a single
> CPU and using that as the comparison value. Davide Libenzi, on the other
> hand, simply proposed using the number of tasks.

In practice, in a given time (say a "recalculate period") a given cpu
with a given set of tasks will end up doing a fixed amount of work
(provided we don't allow idle tasks).  This could be stated as a sum of
time slices or CPU jiffies if you like.  As long as loads are passed
from cpu to cpu to make them all end a "recalculate period" at the same
time, I would contend we have balance.  Counting tasks is problematic as
tasks come and go and present varying loads.  The real trick is in
figuring which task to move, or if none should be moved.
> 
> I would contend that if you can evenly divide a particular load across
> multiple CPUs, you can then run a pre-emptive scheduler on each CPUs run
> queue independently, without regard for the other CPUs, and still come
> out with high CPU utilization and reasonable completion times for all
> tasks. This has the major advantage of limiting spinlock contention to
> the load balancer, instead of risking it at every schedule().

Exactly.
> 
> > I suggest that, using the "recalculate tick" as a measure of time (I
> > know it is not very linear)
> 
> I'll take your word for it as I'm not very familiar with the current
> scheduler. The main thing is to do the rebalancing periodically and to
> have a reliable way of estimating the loading (not utilization) of each
> CPU.

The current schedule periodically calculates new time slices for each
task.  It does this when no task in the run queue has any slice time
left.  The slice size each task gets is related to the NICE value.  In
practice then (other things being equal) each task will get a portion of
the available processing time that is related to its NICE value.  I
think this is fair.  But, of course, other things are not equal.  When a
task is blocked and the recalculation happens, that task gets to keep
1/2 of it remaining slice as well as the new slice.  Since, in addition
to slice time, the remaining slice value is used as a major component of
the task's priority, this means that the blocked task, if it is blocked
during a recalculate, will get a boosted priority.

I think what Alan is suggesting is that the priority boost is needed for
blocked tasks, but not necessarily the increased slice time.
> 
> > when a cpu finds itself with nothing to do
> > (because all its tasks have completed their slices or blocked) and other
> > cpus have tasks in their queues it is time to "shop" for a new task to
> > run.
> 
> This again has the problem that you only look for new tasks if you have
> nothing to do. While this would work if you only look at the total
> completion time of a set of tasks, it does nothing to ensure fair
> scheduling for a particular task.

But doesn't the f(NICE) used as a slice do this.  The point is that we
will not allow a recalculate until all run able tasks with non zero
slice times have run their slice times to zero.  This insures that all
tasks that can use the cpu will get their fair share of time each
"recalculate period".

This is pretty much what is done today across the whole run queue.  The
enhancement we are talking about is separating tasks by cpu and pretty
much keeping them on one cpu.
> 
> >  This would then do load balancing just before each "recalculate
> > tick".
> > Of course, the above assumes that each cpu has its own run queue.
> >
> > George
> 
> Regards,
> 
>         MikaL
