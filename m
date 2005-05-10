Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261593AbVEJLAC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261593AbVEJLAC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 07:00:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbVEJLAC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 07:00:02 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:33938 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261593AbVEJKzx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 06:55:53 -0400
Date: Tue, 10 May 2005 12:55:31 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, dipankar@in.ibm.com
Subject: Re: [RFC] RCU and CONFIG_PREEMPT_RT progress
In-Reply-To: <20050510012444.GA3011@us.ibm.com>
Message-Id: <Pine.OSF.4.05.10505101042420.4889-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 May 2005, Paul E. McKenney wrote:

> Hello!
> 
> Making some progress on CONFIG_PREEMPT_RT-compatible RCU.  Am exploring
> two approaches, the lock-based approach discussed earlier and a
> counter-flip approach, with the latter very likely being the method
> of choice.  The reason for working the former is to get myself up to
> speed on details of CONFIG_PREEMPT_RT with something relatively simple.
> 
> I am basing my work off of:
> 
> 	http://people.redhat.com/mingo/realtime-preempt/older/realtime-preempt-2.6.12-rc1-V0.7.41-14
> 
> since it works well on a four-CPU x86 system.  I will port forward when
> I have something worth considering for inclusion.  To reiterate, the
> patches referenced below are playtoys, for experimental and educational
> use only.
> 
> 
> Lock-Based Approach
> 
> 1.	Trivial working patch:
> 
> 	http://www.rdrop.com/users/paulmck/RCU/patches/lbdf-2a.patch
> 
> 	This one uses a single rwlock and a single global callback
> 	list.  This of course means that only one task may be in
> 	an RCU read-side critical section at a time.  Even so,
> 	I had to split synchronize_kernel() into synchronize_rcu()
> 	and synchronize_sched() -- I get infrequent hangs otherwise.
> 	The implementation of synchronize_sched() is probably not what
> 	it eventually needs to be, since it simply forces each CPU to
> 	context switch, whether voluntary or preemption.  Will be looking
> 	into this later on.
> 
*shiver* A single rwlock is bad in all respects, both regarding
scaling and real-time behaviour.


> 2.	Slightly less trivial working patch:
> 
> 	http://www.rdrop.com/users/paulmck/RCU/patches/lbdf-3a.patch
> 
> 	This one uses a per-CPU rwlock, but keeps the single global
> 	callback list.  It is otherwise identical to #1.
> 
Again, a single rwlock is very bad for RT behaviour.

> Next step is to go to per-CPU callback lists.  If I was taking this
> approach seriously, I would also experiment with multiple RCU read-side
> locks per CPU, but I don't believe I would learn anything from that
> exercise.
> 
> The reason that I am not taking this approach seriously is that it
> can impose high latencies on RCU read-side critical sections, as
> discussed earlier on LKML.  It also has high rcu_read_lock() and
> rcu_read_unlock() overhead.
> 
> 
> Counter-Based Approach
> 
> The current implementation in Ingo's CONFIG_PREEMPT_RT patch uses a
> counter-based approach, which seems to work, but which can result in
> indefinite-duration grace periods.
Is that really a problem in practise? For RCU updates should happen
rarely.

>  The following are very hazy thoughts
> on how to get the benefits of this approach, but with short grace periods.
> 
> 1.	The basic trick is to maintain a pair of counters per CPU.
> 	There would also be a global boolean variable that would select
> 	one or the other of each pair.  The rcu_read_lock() primitive
> 	would then increment the counter indicated by the boolean
> 	corresponding to the CPU that it is currently running on.
> 	It would also keep a pointer to that particular counter in
> 	the task structure.  The rcu_read_unlock() primitive would
> 	decrement this counter.  

(And, yes, you would also have a
> 	counter in the task structure so that only the outermost of
> 	a set of nested rcu_read_lock()/rcu_read_unlock() pairs would
> 	actually increment/decrement the per-CPU counter pairs.)
Why bother? What is the overhead of checking relative to just doing the
increment/decrement?
I had another idea: Do it in the scheduler:
  per_cpu_rcu_count += prev->rcu_read_count;
  if(per_cpu_rcu_count==0) {
     /* grace period encountered */
  }
  (do the task switch)
  
  per_cpu_rcu_count -= count->rcu_read_count;

Then per_cpu_rcu_count is the rcu-read-count for all tasks except the
current. During schedule there is no current and therefore it is the total
count.

> 
> 	To force a grace period, one would invert the value of the
> 	global boolean variable.  Once all the counters indicated
> 	by the old value of the global boolean variable hit zero,
> 	the corresponding set of RCU callbacks can be safely invoked.
> 
> 	The big problem with this approach is that a pair of inversions
> 	of the global boolean variable could be spaced arbitrarily 
> 	closely, especially when you consider that the read side code
> 	can be preempted.  This could cause RCU callbacks to be invoked
> 	prematurely, which could greatly reduce the life expectancy
> 	of your kernel.
> 
> 2.	#1 above, but use a seqlock to guard the counter selection in
> 	rcu_read_lock().  One potential disadvantage of this approach
> 	is that an extremely unlucky instance of rcu_read_lock() might
> 	be indefinitely delayed by a series of counter flips.  I am
> 	concerned that this might actually happen under low-memory
> 	conditions.  Also requires memory barriers on the read side,
> 	which we might be stuck with, but still hope to be able to
> 	get rid of.  And the per-CPU counter manipulation must use
> 	atomic instructions.
Why not just use 
 preempt_disable(); 
 manipulate counters; 
 preempt_enable();
??
> 
> 3.	#1 above, but use per-CPU locks to guard the counter selection.
> 	I don't like this any better than #2, worse, in fact, since it
> 	requires expensive atomic instructions as well.
local_irqs_disable() andor preempt_disable() should work as they counters
are per-cpu, right?

Or see the alternative above: The counter is per task but latched to a
per-cpu on schedule().

> 
> 4.	The Australian National Zoo alternative:  keep the counter pairs
> 	in the task structure rather than keeping them per-CPU.  This
> 	eliminates the need for atomic operations in rcu_read_lock() and
> 	rcu_read_unlock(), but makes the update side do horribly expensive
> 	task-list trawls.  [So named because I thought of it while trying
> 	to jog to the Australian National Zoo.  I took a wrong turn, and
> 	ended up running up a valley on the other side of Black Mountain,
> 	so never did make it to the zoo.  On the other hand, I did encounter
> 	a herd of wild kangaroo and also thought up this approach, so I
> 	think I came out OK on the deal.]
> 
> 5.	The National Train notion:  #4 above, but keep a separate list
> 	containing only preempted tasks that had non-zero RCU counters
> 	at the time of preemption.  In the (presumably) common case of
> 	no preemption in RCU read-side critical sections, both the
> 	read-side and the update-side overhead is low.  But...  There
> 	is a problem with detecting tasks that are in long-running
> 	RCU read-side critical sections that don't get preempted.
> 	[So named because I thought of it on the UK National Train
> 	somewhere between London and Winchester.]
> 
> 6.	Oak Hills option:  keep per-CPU counters, which require atomic
> 	increment/decrement in the general case, but use a fastpath
> 	that (with preemption disabled) checks to see if the value of
> 	the counter is zero (for rcu_read_lock()) or one (for
> 	rcu_read_unlock()), and, if so, does the counter manipulation
> 	non-atomically.  Use atomics on the (presumably infrequent)
> 	slow path, which is taken if someone gets preempted in the middle
> 	of an RCU read-side critical section.
> 
> 	Handle races between rcu_read_lock() and counter flips by
> 	having rcu_read_lock() increment the counter, then checking
> 	to see if it incremented the correct counter of the pair.
> 	If it did not (i.e., the flip just happened), increment
> 	the other counter of the pair as well, recording the fact that
> 	both were incremented in the task struct.  The rcu_read_unlock()
> 	primitive then decrements any/all counters that rcu_read_lock()
> 	incremented.
> 
> 	Memory barriers are still needed in the non-atomic increment
> 	and decrement cases.  However, it may be possible to leverage
> 	naturally occuring memory barriers (see for example Joe Seigh's
> 	recent LKML posting on RCU+SMR: http://lkml.org/lkml/2005/5/9/129).
> 	If the naturally occuring memory barriers aren't happening fast
> 	enough (e.g., low memory situation), a round of IPIs should
> 	suffice, for example, smp_call_function() to a function that
> 	advances the callbacks on each CPU.
> 
> 	If this one pans out, the common-case overhead of rcu_read_lock()
> 	and rcu_read_unlock() would not be much more expensive than the
> 	current CONFIG_PREEMPT implementations.
> 
> There are probably better approaches, but that is what I have thus far.
>

I was playing around with it a little while back. I didn't sned a patch
though as I didn't have time. It works on a UP machine but I don't have a
SMP to test on :-(

The ingreedients are:
1) A per-cpu read-side counter, protected locally by preempt_disable().
2) A task read-side counter (doesn't need protectection at all).
3) Tasks having non-zero read-side counter can't be migrated to other
CPUs. That is to make the per-cpu counter truely per-cpu.
4) When the scheduler sees a SCHED_OTHER task with a rcu-read-counter>0 it
boost the priority to the maximum non-RT priority such it will not be 
preempted by other SCHED_OTHER tasks. This makes the  delay in
syncronize_kernel() somewhat deterministic (it depends on how
"deterministic" the RT tasks in the system are.)

I'll try to send you what I got when I get my computer at home back up.
I have only testet id on my UP labtop, where it seems to run fine.

> Thoughts?
> 
> 							Thanx, Paul

Esben

