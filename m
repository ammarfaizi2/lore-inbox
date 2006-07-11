Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbWGKSUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWGKSUb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 14:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932072AbWGKSUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 14:20:31 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:15557 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932071AbWGKSUa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 14:20:30 -0400
Date: Tue, 11 Jul 2006 11:21:04 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, Andrew Morton <akpm@osdl.org>,
       matthltc@us.ibm.com, dipankar@in.ibm.com, mingo@elte.hu,
       tytso@us.ibm.com, dvhltc@us.ibm.com, jes@sgi.com,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] srcu-3: RCU variant permitting read-side blocking
Message-ID: <20060711182104.GE1288@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060711172530.GA93@oleg> <Pine.LNX.4.44L0.0607111044021.6494-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0607111044021.6494-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 10:56:05AM -0400, Alan Stern wrote:
> On Tue, 11 Jul 2006, Oleg Nesterov wrote:
> 
> > Let's look at the 3-rd synchronize_sched() call.
> > 
> > Suppose that the reader writes to the rcu-protected memory and then
> > does srcu_read_unlock(). It is possible that the writer sees the result
> > of srcu_read_unlock() (so that srcu_readers_active_idx() returns 0)
> > but does not see other writes yet. The writer does synchronize_sched(),
> > the reader (according to 2) above) does mb(). But this doesn't guarantee
> > that all preceding mem ops were finished, so it is possible that
> > synchronize_srcu() returns and probably frees that memory too early.
> > 
> > If it were possible to "insert" mb() into srcu_read_unlock() before ->c[]--,
> > we are ok, but synchronize_sched() is a "shot in the dark".
> > 
> > In a similar manner, the 2-nd synchronize_sched() requires (I think) that
> > all changes which were done by the current CPU should be visible to other
> > CPUs before return.
> > 
> > Does it make sense?
> 
> Yes, it's a valid concern.
> 
> Paul will correct me if this is wrong...  As I understand it, the code 
> which responds to a synchronize_sched() call (that is, the code which runs 
> on other CPUs) does lots of stuff, involving context changes and 
> who-knows-what else.  There are lots of memory barriers in there, buried 
> in the middle, along with plenty of other memory reads and writes.
> 
> In outline, the reader's CPU responds to synchronize_sched() something 
> like this:
> 
> 	At the next safe time (context switch):
> 		mb();
> 		Tell the writer's CPU that the preempt count on
> 			the reader's CPU is 0
> 
> Since that "tell the writer's CPU" step won't complete until after the 
> mb() has forced all preceding memory operations to complete, we are safe.
> 
> So perhaps the documentation for synchronize_sched() and synchronize_rcu()  
> should say that when the call returns, all CPUs (including the caller's)
> will have executed a memory barrier and so will have completed all memory
> operations that started before the synchronize_xxx() call was issued.

I would instead think of this in the context of memory-barrier pairings
as documented in Documentation/memory-barriers.txt.

As Oleg notes above, synchronize_sched() is a "shot in the dark", since
there is nothing that lines up the synchronize_srcu() with any concurrent
srcu_read_lock() or srcu_read_unlock().  The trick here is that the
synchronize_sched() eliminates one of the possibilities (taking this
from the viewpoint of the last synchronize_sched() in synchronize_srcu()
on CPU 0 interacting with a concurrent srcu_read_unlock() on CPU 1):

1.	srcu_read_unlock()'s counter decrement is perceived by CPU 1
	as happening after all of the read-side critical-section
	accesses.  This is OK, because this means that the critical
	section completes before synchronize_srcu()'s checks, and thus
	before any destructive operations following the synchronize_srcu().

2.	srcu_read_unlock()'s counter decrement is perceived by CPU 1
	as happening -before- some of the read-side critical-section
	accesses.  This could be bad, but...  The synchronize_srcu()
	forces CPU 0 to execute a memory barrier on each active CPU,
	including CPU 1.  CPU 0 must subsequently execute a memory
	barrier to become aware of the grace period ending, so that
	it sees -all- CPU 1's earlier memory accesses (required, because
	CPU 0 had to have seen, perhaps indirectly, CPU 1's indication
	that it had gone through a quiescent state).

	Therefore, by the time CPU 0 is done with the synchronize_sched(),
	the memory accesses that CPU 1 executed as part of the SRCU
	read-side critical section must all be visible.

Any sequence of events that has the srcu_read_unlock() happening after
the synchronize_sched() starts is prohibited, since the synchronize_sched()
won't start until the counters all hit zero.

In case people were wondering, the ornateness of the above reasoning is
one reason I have been resisting any attempt to further complicate
the SRCU stuff.  ;-)

							Thanx, Paul
