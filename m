Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286071AbRLHXkz>; Sat, 8 Dec 2001 18:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286073AbRLHXkq>; Sat, 8 Dec 2001 18:40:46 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:46599 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S286072AbRLHXke>; Sat, 8 Dec 2001 18:40:34 -0500
Date: Sat, 8 Dec 2001 15:42:19 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Mike Kravetz <kravetz@us.ibm.com>, Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] 2.5.0 Multi-Queue Scheduler
In-Reply-To: <E16Cg7a-0001CR-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.40.0112081414270.1658-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Dec 2001, Alan Cox wrote:

> > maintain the behavior of the existing scheduler.  This was both
> > good and bad.  The good is that we did not need to be concerned
> > with load balancing like traditional multi-queue schedulers.
>
> Which version of the scheduler do you behave like ?
>
> > balancing.  This is what Davide Libenzi is working on and
> > something I plan to tackle next.  If you have any ideas on
> > areas where our time would be better spent, I would be happy
> > to hear them.
>
> I've played with your code, and some other ideas too. I don't think the
> Linus scheduler is salvagable. Its based upon assumptions about access to
> data and scaling that broke when the pentium came out let alone the quad
> xeon.
>
> I have the core bits of a scheduler that behaves roughly like Linux 2.4 with
> the recent Ingo cache change [in fact that came from working out what the
> Linus scheduler does].
>
> Uniprocessor scheduling is working fine (I've not tackled the RT stuff tho)
> SMP I'm pondering bits still.
>
> Currently I do the following
>
> Two sets of 8 queues per processor, and a bitmask of non empty queues.
>
> Picking a new task to run is as simple as
> 	new = cpu->run_queue[fastffz[cpu->runnable]];

I believe that by simply having a per-cpu runqueue, together with a decent
load balancing, is sufficent to get a good behavior.
I remember when i was working with my old scheduler patch ( the one that
had priority queues, in '98 i think ) that the break point where the cost
of the selection loop matched the main schedule() path ( with rqlen == 1 )
was about 7-8.
And if you look at the scheduler, running a cycle counter, when it does
switch mm and when it does not, you understand what i'm saying.
Looking at the cycle sampling here :

http://www.xmailserver.org/linux-patches/mss.html

you can see that the difference between a warm cache + no-mm-switch and a
real-world is about 1/3.
With this in mind, maybe it will be useful to try higher values of switch
mm penalties ( i did not try ).
The current scheduler is not that bad when working on UP systems but it
becomes critical on SMP systems, for different reasons ( common locking,
long rq selection, etc... ).
I'm currently working at the multi queue scheduler described inside the
above link and i did a number of changes to it.
The first is about RT tasks that now have a separate run queue that is
checked w/out held locks before the std selection :

    /*
     * check global rt queue first without held locks and if it's not empty
     * try to pickup the rt task first. despite to the new "unlikely" feature
     * the code for rt task selection is kept out.
     */
    if (!list_empty(&runqueue_head(RT_QID)))
        goto rt_queue_select;
rt_queue_select_back:

I have two kind of RT tasks, local cpu ones and global ones.
Local cpu ones live inside the cpu runqueue and do not have global
preemption capabilities ( only inside their cpu ) while global one live
inside the special queue RT_QID and have global preemption capabilities,
that means that when one of these guys is woken up, it could preempt tasks
on different cpus.
The local/global selection is done inside setscheduler() by the mean of a
new flag SCHED_RTGLOBAL ( or'ed ) that, when is set, forces the task to be
moved inside the global RT queue RT_QID.
The other change respect to the scheduler described inside the above link
is the partial adoption of the Ingo's idea of counter decay.
For each task i keep the average run time in jiffies by doing :

A(i+1) = (A(i) + T(i+1)) >> 1

and i use this time inside kernel/timer.c :

        if (p->counter > p->avg_jrun)
            --p->counter;
        else if (++p->timer_ticks >= p->counter) {
            p->counter = 0;
            p->timer_ticks = 0;
            p->need_resched = 1;
        }

in this way the counter decay behave like the old scheduler for I/O bound
tasks, while it'll have the desired behavior for CPU bound ones ( this is
what we need, no priority inversion due I/O bound tasks interruption ).
The balance point has been moved from arch/??/kernel/process.c to
kernel/sched.c, to have a more localized scheduler code.
The reschedule_idle() ( for SMP ) has been split to handle global RT tasks
wakeup, since these will have a different wakeup policy compared standard
tasks.
More, reschedule_idle() can now trigger a idle wakeup if the target cpu of
the fresh woken up task has a load() that trigger such behavior.
Another change is a simple way to detect idles by having an idle counter
and a last cpu idle index.
This is light and help deciding what kind of wakeup policy to adopt.
The sys_sched_yield() has been changed to give up a time slice tick for
each invocation :

asmlinkage long sys_sched_yield(void)
{
    struct task_struct *ctsk = current;

    if (qnr_running(ctsk->task_qid) > 1) {
        /*
         * This process can only be rescheduled by us,
         * so this is safe without any locking.
         */
        if (ctsk->policy == SCHED_OTHER)
            ctsk->policy |= SCHED_YIELD;
        local_irq_disable();
        if (ctsk->counter > 0)
            --ctsk->counter;
        local_irq_enable();
        ctsk->need_resched = 1;
    }
    return 0;
}

This way is more effective than the current code that moves tasks at the
end of the run queue because if you've three tasks A, B and C with A and B
yielding and having a dynamic priority great than C ( not yielding ),
we'll have the scheduler to make a HUGE number of switches between A and B
until the priority of A or B reaches the one of C.
If we've even more tasks yielding, the situation is even worse.
With this method, only a very few loops are performed before C will have
the opportunity to execute.
The last part is the more important, that is the cpu balance code.
Right now i've a couple of implementations and i'm trying to have a
tunable ( trimmer like ) value that will enable to select different
balancing policies that will better fit different task move costs (
architecture, cache size, etc... dependent ).
My policy is to have the idle cpus to make the tasks move selections
instead of having that code inside reschedule_idle(), since doing it
inside reschedule_idle() will slow a running cpu.
The current code is working fine with pretty/very good latencies even if
my current focus is more on the balancer code.




PS: Mike, if you're planning to blend into a classical multi queue
scheduler maybe we should meet to have a single implementation.
Obviously IBM should pay the lunch :)
The other reason is that i'll probably spend the next two/three months
between Tokio and Chicago, so i won't have time to work on it :(



- Davide



