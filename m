Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161342AbWG2CR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161342AbWG2CR5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 22:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161235AbWG2CR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 22:17:57 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:35981 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161342AbWG2CR4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 22:17:56 -0400
Date: Fri, 28 Jul 2006 19:18:29 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Bill Huey <billh@gnuppy.monkey.org>
Cc: Esben Nielsen <nielsen.esben@googlemail.com>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, rostedt@goodmis.org, dipankar@in.ibm.com,
       mingo@elte.hu, tytso@us.ibm.com, dvhltc@us.ibm.com
Subject: Re: [RFC, PATCH, -rt] Early prototype RCU priority-boost patch
Message-ID: <20060729021829.GN1289@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060728001918.GA2634@us.ibm.com> <Pine.LNX.4.64.0607281222580.10047@localhost.localdomain> <20060728155220.GC1289@us.ibm.com> <20060728222716.GA13794@gnuppy.monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060728222716.GA13794@gnuppy.monkey.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2006 at 03:27:16PM -0700, Bill Huey wrote:
> On Fri, Jul 28, 2006 at 08:52:20AM -0700, Paul E. McKenney wrote:
> > I must defer to Ingo, Thomas, and Steve Rostedt on what the right thing
> > to do is here, but I do much appreciate the pointers!
> > 
> > If I understand what you are getting at, this is what I would need to
> > do to in order to have a synchronize_rcu() priority-boost RCU readers?
> > Or is this what I need to legitimately priority-boost RCU readers in
> > any case (for example, to properly account for other boosting and
> > deboosting that might happen while the RCU reader is priority boosted)?
> > 
> > Here are the RCU priority-boost situations I see:
> > 
> > 1.	"Out of nowhere" RCU-reader priority boost.  This is what
> > 	the patch I submitted was intended to cover.  If I need your
> > 	prio_booster struct in this case, then I would need to put
> > 	one in the task structure, right?
> > 
> > 	Would another be needed to handle a second boost?  My guess
> > 	is that the first could be reused.
> 
> What is that ? like randomly boosting without tracking which thread is
> inside an RCU critical section ?

Perhaps a better way to put it would be that a thread preempted in
an RCU read-side critical section boosts itself, and tracks the fact
that it boosted itself in its tasks structure.

The second boost would be from some other task, but if the task had 
already boosted itself, the de-boosting would already be taken care of
at the next rcu_read_unlock() -- but as mentioned earlier in this
thread, you only boost someone else if they are not currently running.

> > 2.	RCU reader boosting a lock holder.  This ends up being a
> > 	combination of #1 (because the act of blocking on a lock implies
> > 	an "out of nowhere" priority boost) and normal lock boosting.
> 
> Lock holder as in mutex held below and RCU critical section ?

Lock holder as in task 0 holds the lock, perhaps in an RCU read-side
critical section and perhaps not.  Task 1 is in an RCU read-side
critical section and attempts to acquire the lock.  Task 1 must block,
because task 0 still holds the lock.  Task 1 must boost itself before
blocking, and must donate its boosted priority to task 0.

> > 3.	A call_rcu() or synchronize_rcu() boosting all readers.  I am
> > 	not sure we really need this, but in case we do...  One would
> > 	need an additional prio_booster for each task to be boosted,
> > 	right?  This would seem to require an additional prio_booster
> > 	struct in each task structure.
>  
> This needs a notion of RCU read side ownership to boost those preempted
> threads.

I am getting the impression that #3 is something to leave aside for now.

> > Or am I off the mark here?
> 
> The scary thing about what you're doing is that all of the techniques
> you've named (assuming that I understand you correctly) requires a
> notion of an owner and ownership tracking. That's just going to kill
> RCU read side performance if you do that whether it be a list per reader
> or something else like that. It's a tough problem.

The idea is that none of this stuff ever happens except in cases where
the RCU read-side critical section blocks, in which case all this is
in the noise compared to the context switch.  The sole exception to
this is that rcu_read_unlock() must check to see if it has been boosted,
and deboost itself if so.  I don't particularly like the additional
comparison, but it should not be too expensive.

> Don't know what to think about it other than some kind of tracking or
> boosting logic in the per CPU run queue or the task struct itself during
> the boost operation. But you're still stuck with the problem of what
> to boost and how to find that out during an RCU sync side. It's still
> an ownership problem unless Esben can think of another way of getting
> around that problem.

One idea is to put tasks that block in RCU read-side critical sections
on a list -- again, the hope is that the overhead is in the noise compared
to the context switch.

> That's why I suggested a priority ceiling or per CPU priority threshold
> tracking (+ CPU binding) the priority of the irq-threads and stuff. It's
> a simple hack to restore the cheesy preempt count stuff without having
> to revert to invasive ownership tracking for each reader.
> 
> It's just an idea. Maybe it'll be useful to you.

Let me make sure I understand what you are suggesting -- sounds to me
like a check in preempt_schedule().  If the task to be preempted is
higher priority than the ceiling, the preemption request is refused.

Or am I missing part of your proposal?

							Thanx, Paul
