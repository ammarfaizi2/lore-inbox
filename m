Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031360AbWKUT6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031360AbWKUT6I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 14:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031362AbWKUT6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 14:58:08 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:45769 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1031360AbWKUT6F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 14:58:05 -0500
Date: Tue, 21 Nov 2006 11:56:39 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
       Alan Stern <stern@rowland.harvard.edu>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-ID: <20061121195638.GC2013@us.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20061119214315.GI4427@us.ibm.com> <Pine.LNX.4.44L0.0611201212040.3224-100000@iolanthe.rowland.org> <20061120185712.GA95@oleg> <20061120203836.GH8033@us.ibm.com> <20061121164420.GA199@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061121164420.GA199@oleg>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2006 at 07:44:20PM +0300, Oleg Nesterov wrote:
> On 11/20, Paul E. McKenney wrote:
> >
> > On Mon, Nov 20, 2006 at 09:57:12PM +0300, Oleg Nesterov wrote:
> > > >
> > > So, if we have global A == B == 0,
> > >
> > > 	CPU_0		CPU_1
> > >
> > > 	A = 1;		B = 2;
> > > 	mb();		mb();
> > > 	b = B;		a = A;
> > >
> > > It could happen that a == b == 0, yes? Isn't this contradicts with definition
> > > of mb?
> >
> > It can and does happen.  -Which- definition of mb()?  ;-)
> 
> I had a somewhat similar understanding before this discussion
> 
> 	[PATCH] Fix RCU race in access of nohz_cpu_mask
> 	http://marc.theaimsgroup.com/?t=113378060600003
> 
> 	Semantics of smp_mb() [was : Re: [PATCH] Fix RCU race in access of nohz_cpu_mask ]
> 	http://marc.theaimsgroup.com/?t=113432312600001
> 
> Could you please explain me again why that fix was correct? What we have now is:
> 
> CPU_0					CPU_1
> rcu_start_batch:			stop_hz_timer:
> 
>   rcp->cur++;			STORE	  nohz_cpu_mask |= cpu
> 
>   smp_mb();				  mb();		// missed actually
> 
>   ->cpumask = ~nohz_cpu_mask;	LOAD	  if (rcu_pending()) // reads rcp->cur
> 							nohz_cpu_mask &= ~cpu
> 
> So, it is possible that CPU_0 reads an empty nohz_cpu_mask and starts a grace
> period with CPU_1 included in rcp->cpumask. CPU_1 in turn reads an old value
> of rcp->cur (so rcu_pending() returns 0) and becomes CPU_IDLE.

At this point, I am not certain that it is in fact correct.  :-/

> Take another patch,
> 
> 	Re: Oops on 2.6.18
> 	http://marc.theaimsgroup.com/?l=linux-kernel&m=116266392016286
> 
> switch_uid:			__sigqueue_alloc:
> 
>   STORE 'new_user' to ->user	  STORE "locked" to ->siglock
> 
>   mb();				  "mb()"; // sort of, wrt loads/stores above
> 
>   LOAD ->siglock		  LOAD ->siglock
> 
> Agian, it is possible that switch_uid() doesn't notice that ->siglock is locked
> and frees ->user. __sigqueue_alloc() in turn reads an old (freed) value of ->user
> and does get_uid() on it.

Ditto.

> > To see how this can happen, thing of the SMP system as a message-passing
> > system, and consider the following sequence of events:
> >
> > o	The cache line for A is initially in CPU 1's cache, and the
> > 	cache line for B is initially in CPU 0's cache (backwards of
> > 	what you would want knowing about the upcoming writes).
> >
> > o	CPU 0 stores to A, but because A is not in cache, places it in
> > 	CPU 0's store queue.  It also puts out a request for ownership
> > 	of the cache line containing A.
> >
> > o	CPU 1 stores to B, with the same situation as for CPU 0's store
> > 	to A.
> >
> > o	Both CPUs execute an mb(), which ensures that any subsequent writes
> > 	follow the writes to A and B, respectively.  Since neither CPU
> > 	has yet received the other CPU's request for ownership, there is
> > 	no ordering effects on subsequent reads.
> >
> > o	CPU 0 executes "b = B", and since B is in CPU 0's cache, it loads
> > 	the current value, which is zero.
> >
> > o	Ditto for CPU 1 and A.
> >
> > o	CPUs 0 and 1 now receive each other's requests for ownership, so
> > 	exchange the cache lines containing A and B.
> >
> > o	Once CPUs 0 and 1 receive ownership of the respective cache lines,
> > 	they complete their writes to A and B (moving the values from the
> > 	store buffers to the cache lines).
> 
> Paul, Alan, in case it was not clear: I am not arguing, just trying to
> understand, and I appreciate very much your time and your explanations.

Either way, we clearly need better definitions of what the memory barriers
actually do!  And I expect that we will need your help.

							Thanx, Paul
