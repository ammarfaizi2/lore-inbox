Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751388AbWG2Cut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbWG2Cut (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 22:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752069AbWG2Cus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 22:50:48 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:54700
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S1751388AbWG2Cus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 22:50:48 -0400
Date: Fri, 28 Jul 2006 19:50:37 -0700
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Esben Nielsen <nielsen.esben@googlemail.com>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, rostedt@goodmis.org, dipankar@in.ibm.com,
       mingo@elte.hu, tytso@us.ibm.com, dvhltc@us.ibm.com,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: [RFC, PATCH, -rt] Early prototype RCU priority-boost patch
Message-ID: <20060729025037.GB15392@gnuppy.monkey.org>
References: <20060728001918.GA2634@us.ibm.com> <Pine.LNX.4.64.0607281222580.10047@localhost.localdomain> <20060728155220.GC1289@us.ibm.com> <20060728222716.GA13794@gnuppy.monkey.org> <20060729021829.GN1289@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060729021829.GN1289@us.ibm.com>
User-Agent: Mutt/1.5.11+cvs20060403
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2006 at 07:18:29PM -0700, Paul E. McKenney wrote:
> On Fri, Jul 28, 2006 at 03:27:16PM -0700, Bill Huey wrote:
> > What is that ? like randomly boosting without tracking which thread is
> > inside an RCU critical section ?
> 
> Perhaps a better way to put it would be that a thread preempted in
> an RCU read-side critical section boosts itself, and tracks the fact
> that it boosted itself in its tasks structure.
> 
> The second boost would be from some other task, but if the task had 
> already boosted itself, the de-boosting would already be taken care of
> at the next rcu_read_unlock() -- but as mentioned earlier in this
> thread, you only boost someone else if they are not currently running.

The problem here is that I can't see how it's going to boost the thread
if the things doing the RCU sync can't track the list of readers. It
might be record in the trask struct, now what ?

> > > 2.	RCU reader boosting a lock holder.  This ends up being a
> > > 	combination of #1 (because the act of blocking on a lock implies
> > > 	an "out of nowhere" priority boost) and normal lock boosting.
> > 
> > Lock holder as in mutex held below and RCU critical section ?
> 
> Lock holder as in task 0 holds the lock, perhaps in an RCU read-side
> critical section and perhaps not.  Task 1 is in an RCU read-side
> critical section and attempts to acquire the lock.  Task 1 must block,
> because task 0 still holds the lock.  Task 1 must boost itself before
> blocking, and must donate its boosted priority to task 0.

Ok (thinking...)

> > > 3.	A call_rcu() or synchronize_rcu() boosting all readers.  I am
> > > 	not sure we really need this, but in case we do...  One would
> > > 	need an additional prio_booster for each task to be boosted,
> > > 	right?  This would seem to require an additional prio_booster
> > > 	struct in each task structure.
> >  
> > This needs a notion of RCU read side ownership to boost those preempted
> > threads.
> 
> I am getting the impression that #3 is something to leave aside for now.

... 

> The idea is that none of this stuff ever happens except in cases where
> the RCU read-side critical section blocks, in which case all this is

...

> in the noise compared to the context switch.  The sole exception to
> this is that rcu_read_unlock() must check to see if it has been boosted,
> and deboost itself if so.  I don't particularly like the additional
> comparison, but it should not be too expensive.

Oh, blocks as is gets shoved into a wait queue for a PI enabled lock.
 
> > Don't know what to think about it other than some kind of tracking or
> > boosting logic in the per CPU run queue or the task struct itself during
> > the boost operation. But you're still stuck with the problem of what
> > to boost and how to find that out during an RCU sync side. It's still
> > an ownership problem unless Esben can think of another way of getting
> > around that problem.
> 
> One idea is to put tasks that block in RCU read-side critical sections
> on a list -- again, the hope is that the overhead is in the noise compared
> to the context switch.

Only way to find out is to try it.

> > That's why I suggested a priority ceiling or per CPU priority threshold
> > tracking (+ CPU binding) the priority of the irq-threads and stuff. It's
> > a simple hack to restore the cheesy preempt count stuff without having
> > to revert to invasive ownership tracking for each reader.
> > 
> > It's just an idea. Maybe it'll be useful to you.
> 
> Let me make sure I understand what you are suggesting -- sounds to me
> like a check in preempt_schedule().  If the task to be preempted is
> higher priority than the ceiling, the preemption request is refused.
> 
> Or am I missing part of your proposal?

Something like at all preemption points, cond_resched() and friends (scheduler
tick) to an additional check against a value in a threads own CPU run queue
struct to see if it should permit the preemption or not. I'm thinking about
ways to avoid doing an expensive run queue lock during a task's priority
manipulation and instead have some other kind of logic orthogonal to that so
that it can bypass this overhead.  A value in a run queue that can be checked
against in order to prevent a preemption from happen might be able to side
step the need for a doing a full run queue lock to reorder a tasks priority
ranking.

If a ceiling or threshold was defined for RCU (another somewhat complicated
topic) it could prevent the RCU critical section from preempting other
than with other SCHED_FIFO tasks at and above that priority, if you choose
a threshold at that priority. That'll be apart of the runtime configuratio
of the system. You'd have to cpu_get/put to get that value so that you get
at it safely, read or write to it, and maybe save and restore that value on
entry and exit respectively. You'll also have to set a field in the task
struct to prevent it from migration to another CPU and make sure that's
modifying the right stuff on the right CPU.

It's a possible solution to a rather difficult problem. What do you think ?
too much of a hack ?

(I'm into -rt development again after a good OLS and I'm trying to get my
kernel development up and going so that I can help out)

bill

