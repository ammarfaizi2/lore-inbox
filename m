Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317327AbSFGTNp>; Fri, 7 Jun 2002 15:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317330AbSFGTNY>; Fri, 7 Jun 2002 15:13:24 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:12543 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317327AbSFGTMo>;
	Fri, 7 Jun 2002 15:12:44 -0400
Date: Fri, 7 Jun 2002 12:12:07 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Robert Love <rml@tech9.net>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: Scheduler Bug (set_cpus_allowed)
Message-ID: <20020607121207.B1532@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <20020606162028.E3193@w-mikek2.des.beaverton.ibm.com> <1023475007.1137.62.camel@sinai>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2002 at 11:36:46AM -0700, Robert Love wrote:
> On Thu, 2002-06-06 at 16:20, Mike Kravetz wrote:
> 
> > Consider the case where a task is to give up the CPU
> > and schedule() is called.  In such a case the current
> > task is removed from the runqueue (via deactivate_task).
> > Now, further assume that there are no runnable tasks
> > on the runqueue and we end up calling load_balance().
> > In load_balance, we potentially drop the runqueue lock
> > to obtain multiple runqueue locks in the proper order.
> > Now, when we drop the runqueue lock we will still
> > be running in the context of task p.  However, p does
> > not reside on a runqueue.  It is now possible for
> > set_cpus_allowed() to be called for p.  We can get the
> > runqueue lock and take the fast path to simply update
> > the task's cpu field.  If this happens, bad (very bad)
> > things will happen!
> 
> Ugh I think you are right.  This is an incredibly small race, though!

I agree that the race is small.  I 'found' this while playing
with some experimental code that does the same thing as the
fast path in set_cpus_allowed: it sets the cpu field while
holding the rq lock if the task is not on the rq.  This code
runs as at higher frequency (than would be expected of
set_cpus_allowed) and found this hole.

> > My first thought was to simply add a check to the
> > above code to ensure that p was not currently running
> > (p != rq->curr).  However, even with this change I
> > 'think' the same problem exists later on in schedule()
> > where we drop the runqueue lock before doing a context
> > switch.  At this point, p is not on the runqueue and
> > p != rq->curr, yet we are still runnning in the context
> > of p until we actually do the context switch.  To tell
> > the truth, I'm not exactly sure what 'rq->frozen' lock
> > is for.  Also, the routine 'schedule_tail' does not
> > appear to be used anywhere.
> 
> I agree here, too.
> 
> Fyi, schedule_tail is called from assembly code on SMP machines.  See
> entry.S
> 
> rq->frozen is admittedly a bit confusing.  Dave Miller added it - on
> some architectures mm->page_table_lock is grabbed during switch_mm(). 
> Additionally, swap_out() and others grab page_table_lock during wakeups
> which also grab rq->lock.  Bad locking... Dave's solution was to make
> another lock, the "frozen state lock", which is held around context
> switches.  This way we can protect the "not switched out yet" task
> without grabbing the whole runqueue lock.
> 
> Anyhow, with this issue, I guess we need to fix it... I'll send a patch
> to Linus.

What about the code in schedule before calling context_switch?
Consider the case where the task relinquishing the CPU is still
runnable.  Before dropping the rq lock, we set rq->curr = next
(where next != current).  After dropping the rq lock, can't we
race with the code in load_balance.  load_balance will steal
'runnable' tasks as long as the task is not specified by rq->curr.
Therefore, theoretically load_balance could steal a currently
running task.

Now, the window for this race is only from the time we drop the
rq lock to the time we do the context switch.  During this time
we are running with interrupts disabled, so nothing should delay
us.  In addition, code path on a racing CPU would be much longer:
move task via load balance and schedule it on another CPU.

I believe there is a race, but it is a race we will never lose.
Does that make it a race at all. :)

In the old scheduler both tasks (prev and next) were marked as
'have_cpu' during the context switch.  As such they were 'hands
off' to other CPUs.  Should we implement something like this
here?

-- 
Mike
