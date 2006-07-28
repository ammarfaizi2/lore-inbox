Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750987AbWG1ArZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbWG1ArZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 20:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750972AbWG1ArZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 20:47:25 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:42982 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750729AbWG1ArY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 20:47:24 -0400
Date: Thu, 27 Jul 2006 17:47:56 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Esben Nielsen <nielsen.esben@googlemail.com>
Cc: linux-kernel@vger.kernel.org, compudj@krystal.dyndns.org,
       billh@gnuppy.monkey.org, rostedt@goodmis.org, tglx@linutronix.de,
       mingo@elte.hu, dipankar@in.ibm.com, rusty@au1.ibm.com
Subject: Re: [RFC, PATCH -rt] NMI-safe mb- and atomic-free RT RCU
Message-ID: <20060728004756.GC1288@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060726001733.GA1953@us.ibm.com> <Pine.LNX.4.64.0607262202560.15681@localhost.localdomain> <20060727013943.GE4338@us.ibm.com> <Pine.LNX.4.64.0607270946030.10276@localhost.localdomain> <20060727154637.GA1288@us.ibm.com> <Pine.LNX.4.64.0607280050380.13330@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607280050380.13330@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2006 at 01:22:27AM +0100, Esben Nielsen wrote:
> 
> 
> On Thu, 27 Jul 2006, Paul E. McKenney wrote:
> 
> >On Thu, Jul 27, 2006 at 12:00:13PM +0100, Esben Nielsen wrote:
> >>Hi Paul,
> >> Thanks, for entering a discussion of my idea! Even though you are busy
> >>and are critical towards my idea, you take your time to answer! Thanks.
> >
> >I appreciate the time you took to write down your ideas, and for your
> >taking my comments in the spirit intended.
> 
> Well, I just think it is fun :-)

Hey, it is even more fun if you code it up and test it!  ;-)

> >>On Wed, 26 Jul 2006, Paul E. McKenney wrote:
> >>
> >>>On Thu, Jul 27, 2006 at 02:39:07AM +0100, Esben Nielsen wrote:
> >>>>
> >>>>
> >>>>On Tue, 25 Jul 2006, Paul E. McKenney wrote:
> >>>>
> >>>>>Not for inclusion, should be viewed with great suspicion.
> >>>>>
> >>>>>This patch provides an NMI-safe realtime RCU.  Hopefully, Mathieu can
> >>>>>make use of synchronize_sched() instead, since I have not yet figured
> >>>>>out a way to make this NMI-safe and still get rid of the interrupt
> >>>>>disabling.  ;-)
> >>>>>
> >>>>>						Thanx, Paul
> >>>>
> >>>>I must say I don't understand all this. It looks very complicated. Is it
> >>>>really needed?
> >>>>
> >>>>I have been thinking about the following design:
> >>>>
> >>>>void rcu_read_lock()
> >>>>{
> >>>>	if (!in_interrupt())
> >>>>		current->rcu_read_lock_count++;
> >>>>}
> >>>>void rcu_read_unlock()
> >>>>{
> >>>>	if (!in_interrupt())
> >>>>		current->rcu_read_lock_count--;
> >>>>}
> >>>>
> >>>>Somewhere in schedule():
> >>>>
> >>>>	rq->rcu_read_lock_count += prev->rcu_read_lock_count;
> >>>>	if (!rq->rcu_read_lock_count)
> >>>>		forward_waiting_rcu_jobs();
> >>>>	rq->rcu_read_lock_count -= next->rcu_read_lock_count;
> >>>
> >>>So rq->rcu_read_lock_count contains the sum of the counts of all
> >>>tasks that were scheduled away from this CPU.
> >>>
> >>>What happens in face of the following sequence of events?
> >>>Assume that all tasks stay on CPU 0 for the moment.
> >>>
> >>>o	Task A does rcu_read_lock().
> >>>
> >>>o	Task A is preempted.  rq->rcu_read_lock_count is nonzero.
> >>>
> >>>o	Task B runs and does rcu_read_lock().
> >>>
> >>>o	Task B is preempted (perhaps because it dropped the lock
> >>>	that was causing it to have high priority).  Regardless of
> >>>	the reason for the preemption, rq->rcu_read_lock_count is
> >>>	nonzero.
> >>>
> >>>o	Task C runs and does rcu_read_lock().
> >>>
> >>>o	Task C is preempted.  rq->rcu_read_lock_count is nonzero.
> >>>
> >>>o	Task A runs again, and does rcu_read_unlock().
> >>>
> >>>o	Task A is preempted.  rq->rcu_read_lock_count is nonzero.
> >>>
> >>>o	Task D runs and does rcu_read_lock().
> >>>
> >>>o	Task D is preempted.  rq->rcu_read_lock_count is nonzero.
> >>>
> >>>And so on.  As long as at least one of the preempted tasks is in an
> >>>RCU critical section, you never do your forward_waiting_rcu_jobs(),
> >>>and the grace period goes on forever.  Or at least until you OOM the
> >>>machine.
> >>>
> >>>So what am I missing here?
> >>
> >>The boosting idea below. Then tasks A-D must be RT tasks for this to
> >>happen. And the machine must anyway run out of RT tasks or it will
> >>effectively lock up.
> >
> >I agree that boosting would drive any particular task out of its
> >RCU read-side critical section, but I do not agree that you have
> >identified a valid induction argument that proves that we run out
> >of tasks (yet, anyway).  For one thing, tasks acquiring locks in
> >the RCU read-side critical sections could be priority boosted,
> >so that a small set of tasks could rise and fall in priority as
> >RT tasks attempted to acquire locks held by this small set of
> >tasks.  The RT tasks need not be running on the same CPU that the
> >non-realtime "victim" tasks running in RCU read-side critical sections,
> >therefore, the RT tasks need not be preempting these non-realtime
> >tasks.
> >
> >To be more specific, imagine a four-CPU system with three RT tasks
> >running on three of the four CPUs and a large number of non-realtime
> >tasks running on all four CPUs.  Consider the code in __d_lookup(), which
> >acquires dentry->d_lock under rcu_read_lock().  Imagine a situation
> >where the three RT tasks are repeatedly traversing pathnames with a
> >long common path prefix, with this same prefix being traversed by the
> >non-realtime tasks.  This could result in the non-realtime tasks being
> >repeatedly priority-boosted and preempted (preempted both by each
> >other and by RT tasks).
> >
> >Over to you!
>
> The PI code will never lower the priority lower than task->normal_prio.
> So if you somewhere in schedule() set normal_prio to something high PI 
> will not destroy it.

How does this interact with other priority boosting that might be going
on due to locks that this task holds?  If we exit the RCU read-side
critical section via rcu_read_unlock(), we need to drop the RCU-based
priority boosting, but still keep any lock-based boosting.

In short, I still don't see how you have eliminated the possibility of
a sequence of boosts, preemptions, and blocking on locks that keeps at
least one RCU read-side critical section alive on the CPU at all times,
even if any given RCU read-side critical section eventually gets done.

For a simpler example than the one I gave above, consider three RT mutexes
m[0], m[1], and m[2].  Suppose that there are a few tens of tasks running on a
given CPU, some of which repeatedly acquire and release these locks
in some random order, and others of which do the following repeatedly:

	rcu_read_lock();
	i = random() % 3;
	spin_lock(m[i]);
	/* do something for about 100 microseconds */
	spin_unlock(m[i]);
	/* do something for about 100 microseconds */
	i = random() % 3;
	spin_lock(m[i]);
	/* do something for about 100 microseconds */
	spin_unlock(m[i]);
	rcu_read_unlock();

This setup would easily give you a situation where your CPU has at least
one blocked task holding rcu_read_lock() at all times.

Yes, this is contrived.  If you don't like the fact that it is contrived,
please revisit my earlier dcache example, which has a not-dissimilar
structure, but with a lot more code to look at.  In fact, if anything,
the dcache example is more painful than my contrived example!

Your choice.  But if you want me to take your suggested algorithm
seriously, you need to take one of these two examples seriously.

> >>>I could imagine introducing a pair of counters per runqueue, but then
> >>>we end up with the same issues with counter-flip that we have now.
> >>>
> >>>Another question -- what happens if a given CPU stays idle?  Wouldn't
> >>>the callbacks then just start piling up on that CPU?
> >>
> >>How can a CPU stay idle? There is a tick every 2.5 ms. Even without that
> >>the previous CPU can make it schedule if it sees the jobs piling up. Or if
> >>that is considered too expensive, it can take over and forward the
> >>jobs to the next CPU.
> >
> >Tickless idle, prized by embedded systems.  Here an idle CPU gets shut
> >down if there is nothing in particular for it to do.  Classic RCU does a
> >dance with CPUs entering tickless idle state in order to avoid expecting
> >those CPUs to participate in future grace periods.
> >
> >This had its challenges for the bitmask-based Classic RCU, and would
> >have a few additional challenges for your circular linked-list setup.
> 
> Can't the previous CPU just see that when it wants to send the RCU-jobs 
> along to it and send it to the next CPU instead?
> Or when a CPU goes idle it can take itself out of the circle to avoid the 
> extra load on the previous CPU.

My concern is what happens when the previous CPU is trying to hand off
callbacks just when the next CPU is pulling itself out of the list.
It would be bad form to strand the callbacks on the now-hot-unplugged
runqueue.  It would be even worse form to skip over the CPU before it
got done with the last RCU read-side critical section in kernel code
just before hot-unplugging.

> >Current -rt RCU avoids this problem by dint of being too stupid to
> >need to know what CPUs are alive or not.  My recent patch needs something
> >similar to the tickless-idle change to Classic RCU.
> >
> >>>>Now what should forward_waiting_rcu_jobs() do?
> >>>>
> >>>>I imagine a circular datastructur of all the CPUs. When a call_rcu() is
> >>>>run on a CPU it is first added a list of jobs for that CPU. When
> >>>>forward_waiting_rcu_jobs() is called all the pending jobs are forwarded 
> >>>>to
> >>>>the next CPU. The next CPU will bring it along the next CPU in the 
> >>>>circle
> >>>>along with it's own jobs. When jobs hit the original CPU they will be
> >>>>executed. Or rather, when the CPU just before calls
> >>>>forward_waiting_rcu_jobs(), it sends the jobs belonging to the next CPU 
> >>>>to
> >>>>the RCU-task of the next CPU, where they will be executed, instead of to
> >>>>the scheduler (runqueue) of the next CPU, where it will just be send out
> >>>>on
> >>>>a
> >>>>new roundtrip along the circle.
> >>>>
> >>>>If you use a structure like the plist then the forwarding procedure can 
> >>>>be
> >>>>done in O(number of online CPUs) time worst case - much less in the 
> >>>>usual
> >>>>case where the lists are almost empty.
> >>>>
> >>>>Now the problem is: What happens if a task in a rcu read-side lock is
> >>>>migrated? Then the rcu_read_lock_count on the source CPU will stay in 
> >>>>plus
> >>>>while on the target CPU it will go in minus. This ought to be simply
> >>>>fixeable by adding task->rcu_read_lock_count to the target runqueue 
> >>>>before
> >>>>migrating and subtracting it from the old runqueue after migrating. But
> >>>>there is another problem: RCU-jobs refering to data used by the task 
> >>>>being
> >>>>migrated might have been forwarded from the target CPU. Thus the 
> >>>>migration
> >>>>task have to go back along the circle of CPUs and move all the relevant
> >>>>RCU-jobs back to the target CPU to be forwarded again. This is also 
> >>>>doable
> >>>>in
> >>>>number of CPUs between source and target times O(<number of online 
> >>>>CPUs>)
> >>>>(see above) time.
> >>>
> >>>So if I have the right (or wrong) pattern of task migrations, the RCU
> >>>callbacks never get to their originating CPU?
> >>
> >>In principle, yes. But if the machine starts to migrate tasks that wildly
> >>it wont get any work done anyway, because all it's time is done doing
> >>migration.
> >
> >Since you are waiting for a context switch to move the RCU callbacks,
> >the migration does not have to be all that wild.  In an eight-CPU system,
> >if I migrate a preempted task a couple of times in the course of the
> >eight context switches required for the callbacks to circle the loop
> >of CPUs, we are in trouble, right?
> 
> Could be. The other idea I came up with below doesn't have that problem.

What problem does it have instead?  (Sorry, couldn't resist!)

> >>>Alternatively, if the task residing in the RCU read-side critical section
> >>>is forwarded around the loop of CPUs, callbacks circulating around this
> >>>loop might execute before the RCU read-side critical section completes.
> >>
> >>That is why some of the callbacks (those which has parsed the target CPU
> >>but not yet the source CPU) have to be moved back to the target CPU.
> >
> >Yep.  Leaving them to follow their planned circuit indeed does not cut it.
> >
> >>I just came up with an even simpler solution:
> >>Delay the subtraction of the task->rcu_read_lock_count from
> >>srcrq->rcu_read_lock_count until the task calls rcu_read_unlock(). That
> >>can be done by flagging the task (do task->rcu_read_lock_count |=
> >>0x80000000) and do a simple
> >>	if (unlickely(current->rcu_read_lock_count == 0x80000000))
> >>		fix_rcu_read_lock_count_on_old_cpu();
> >>in rcu_read_unlock(). Now the task can be migrated again before calloing
> >>fix_rcu_read_lock_count_on_old_cpu(). The relevant RCU jobs still can't
> >>get past the original CPU before the task have called
> >>fix_rcu_read_lock_count_on_old_cpu(), so all subsequent migrations can 
> >>just
> >>do the count down on the intermediate CPUs right away.
> >
> >But now you need atomic instructions in all rcu_read_lock() and
> >rcu_read_unlock() invocations to handle the possibility that some
> >migrated task will decrement the counter at the same time we are
> >incrementing it?  I cannot tell for sure because you have not supplied
> >sample code for fix_rcu_read_lock_count_on_old_cpu().
> 
> Now the atomic part is only kicking in if the task was actually migrated 
> while under RCU readside section so it is rare.

How do the other concurrently executing tasks know that a migration is
about to kick in, so that they should switch to atomic operations?

>                                                 But consider this code:
> 
> void fix_rcu_read_lock_count_on_old_cpu()
> {
> 	int cpuid = current->old_cpuid;
> 	int count = current->old_rcu_read_lock_count;
> 
> 	runqueue_t *rq = cpu_rq(cpuid);
>         spin_lock_irqsave(&rq->lock, flags);
> 	rq->rcu_read_lock_count -= count;
>         spin_unlock_irqrestore(&rq->lock, flags);
> }
> 
> Then there can be something about if the CPU was taken out meanwhile. If 
> the rq->rcu_read_lock is 0 after this, then it can go completely out 
> of the RCU CPU circle now (see below).

But then when we pull the runqueue out of the circle, we need to grab
the locks of its neighbors?

> >>>>To avoid a task in a read-side lock being starved for too long the
> >>>>following line can be added to normal_prio():
> >>>> if (p->rcu_read_lock_count)
> >>>>	p->prio = MAX_RT_PRIO;
> >>>
> >>>But doesn't this have the same impact on latency as disabling preemption
> >>>in rcu_read_lock() and then re-enabling it in rcu_read_unlock()?
> >>
> >>No, RT tasks can still preempt the RCU read side lock. But SCHED_OTHER and
> >>SCHED_BATCH can't. You can also the RCU read side boosting prioritiy
> >>dynamic and let the system adjust it or just let the admin adjust it.
> >
> >Fair enough -- I misread MAX_RT_PRIO as MAX_PRIO.
> >
> >This approach I can get behind -- my thought has been to boost to
> >either MAX_RT_PRIO or MAX_RT_PRIO-1 when preempt_schedule() sees that
> >it is preempting an RCU read-side critical section.
> >
> >So I agree with you on at least one point!  ;-)
> >
> >A possible elaboration would be to keep a linked list of tasks preempted
> >in their RCU read-side critical sections so that they can be further
> >boosted to the highest possible priority (numerical value of zero,
> >not sure what the proper symbol is) if the grace period takes too many
> >jiffies to complete.  Another piece is priority boosting when blocking
> >on a mutex from within an RCU read-side critical section.
> >
> >>>Also, doesn't this circular data structure need to handle CPU hotplug?
> >>
> >>Ofcourse. I don't know about hotplug though. But it sounds simple to
> >>migrate the tasks away, take the CPU out of the circle and then forward
> >>the last RCU jobs from that CPU.
> >
> >Doing it efficiently is the difficulty, particularly for tickless-idle
> >systems where CPUs need to be added and removed on a regular basis.
> >Also, what locking design would you use in order to avoid deadlock?
> >There is a hotplug mutex, but seems like you might need to acquire some
> >number of rq mutexes as well.
> 
> I think it can be done very effectively. When taking a CPU out: If, after 
> migrating all the tasks off the CPU, the rq->rcu_read_lock_count is 0, 
> alter the previous CPUs next CPU to this CPUs next CPU. Then forward the 
> pending RCU jobs. If some of the migrated task where in an RCU read side 
> section rq->rcu_read_lock_count > 0. Then the CPU has to be keeped in the 
> RCU circle until all are done. Either an event can be set up or the 
> previous CPU can check on it everytime it tries to forward jobs to the 
> CPU.

What sort of state is the CPU in while it is waiting for all the relevant
RCU callbacks to make their way around the loop?  If it is still active,
it is probably generating more callbacks.  If not, what kind of special
state is it in, and what other parts of the system need to know about that
special state?  Ditto for the runqueue.

> When putting the CPU in again: Simply add it to the circle when it is up 
> running.

Agreed, adding CPUs is -much- easier than removing them.

> >>>>I don't have time to code this nor a SMP machine to test it on. But I 
> >>>>can
> >>>>give the idea to you anyways in the hope you might code it :-)
> >>>
> >>>I am beginning to think that it will not be at all simple by the time I
> >>>code up all the required fixups.  Or am I missing something?
> >>
> >>Ofcourse, implementing something is always a lot harder than writing the
> >>idea down. Anyway, we already worked out some of the hardest details :-)
> >
> >I certainly agree with your first sentence.  On your second sentence,
> >I would s/worked out/mentioned/  ;-)
> >
> >Another approach I am looking at does not permit rcu_read_lock() in
> >NMI/SMI/hardirq, but is much simpler.  Its downside is that it cannot
> >serve as common code between CONFIG_PREEMPT_RT and CONFIG_PREEMPT.
> >
> Iack :-( That is not good. :-(

You can't always get what you want.  ;-)

You might want to look at the OLS 2002 read-copy update paper.  It
describes an algorithm (rcu-sched, due to Rusty, but similar to earlier
algorithms used in the Tornado and K42 research operating systems) that
maintains a circle of CPUs.  However, this was before both tickless idle
and CPU hotplug, and also before realtime RCU.  One major difference
is that Rusty's approach circulates a count rather than the callbacks
themselves.  Rusty's approach should avoid the need to gather callbacks --
though it still would have some challenges handling CPU hotplug.

							Thanx, Paul
