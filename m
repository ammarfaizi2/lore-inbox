Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161051AbWKUXDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161051AbWKUXDU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 18:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161130AbWKUXDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 18:03:19 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:12706 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161051AbWKUXDS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 18:03:18 -0500
Date: Tue, 21 Nov 2006 15:03:14 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
       Oleg Nesterov <oleg@tv-sign.ru>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-ID: <20061121230314.GH2013@us.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20061121195638.GC2013@us.ibm.com> <Pine.LNX.4.44L0.0611211517190.6410-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0611211517190.6410-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2006 at 03:26:44PM -0500, Alan Stern wrote:
> On Tue, 21 Nov 2006, Paul E. McKenney wrote:
> 
> > On Tue, Nov 21, 2006 at 07:44:20PM +0300, Oleg Nesterov wrote:
> > > On 11/20, Paul E. McKenney wrote:
> > > >
> > > > On Mon, Nov 20, 2006 at 09:57:12PM +0300, Oleg Nesterov wrote:
> > > > > >
> > > > > So, if we have global A == B == 0,
> > > > >
> > > > > 	CPU_0		CPU_1
> > > > >
> > > > > 	A = 1;		B = 2;
> > > > > 	mb();		mb();
> > > > > 	b = B;		a = A;
> > > > >
> > > > > It could happen that a == b == 0, yes? Isn't this contradicts with definition
> > > > > of mb?
> > > >
> > > > It can and does happen.  -Which- definition of mb()?  ;-)
> > >
> > > I had a somewhat similar understanding before this discussion
> > >
> > > 	[PATCH] Fix RCU race in access of nohz_cpu_mask
> > > 	http://marc.theaimsgroup.com/?t=113378060600003
> > >
> > > 	Semantics of smp_mb() [was : Re: [PATCH] Fix RCU race in access of nohz_cpu_mask ]
> > > 	http://marc.theaimsgroup.com/?t=113432312600001
> > >
> > > Could you please explain me again why that fix was correct? What we have now is:
> > >
> > > CPU_0					CPU_1
> > > rcu_start_batch:			stop_hz_timer:
> > >
> > >   rcp->cur++;			STORE	  nohz_cpu_mask |= cpu
> > >
> > >   smp_mb();				  mb();		// missed actually
> > >
> > >   ->cpumask = ~nohz_cpu_mask;	LOAD	  if (rcu_pending()) // reads rcp->cur
> > > 							nohz_cpu_mask &= ~cpu
> > >
> > > So, it is possible that CPU_0 reads an empty nohz_cpu_mask and starts a grace
> > > period with CPU_1 included in rcp->cpumask. CPU_1 in turn reads an old value
> > > of rcp->cur (so rcu_pending() returns 0) and becomes CPU_IDLE.
> >
> > At this point, I am not certain that it is in fact correct.  :-/
> >
> > > Take another patch,
> > >
> > > 	Re: Oops on 2.6.18
> > > 	http://marc.theaimsgroup.com/?l=linux-kernel&m=116266392016286
> > >
> > > switch_uid:			__sigqueue_alloc:
> > >
> > >   STORE 'new_user' to ->user	  STORE "locked" to ->siglock
> > >
> > >   mb();				  "mb()"; // sort of, wrt loads/stores above
> > >
> > >   LOAD ->siglock		  LOAD ->siglock
> > >
> > > Agian, it is possible that switch_uid() doesn't notice that ->siglock is locked
> > > and frees ->user. __sigqueue_alloc() in turn reads an old (freed) value of ->user
> > > and does get_uid() on it.
> >
> > Ditto.
> 
> > > Paul, Alan, in case it was not clear: I am not arguing, just trying to
> > > understand, and I appreciate very much your time and your explanations.
> >
> > Either way, we clearly need better definitions of what the memory barriers
> > actually do!  And I expect that we will need your help.
> 
> Things may not be quite as bad as they appear.  On many architectures the
> store-mb-load pattern will work as expected.  (In fact, I don't know which
> architectures it might fail on.)

Several weak-memory-ordering CPUs.  :-/

> Furthermore this is a very difficult race to trigger.  You couldn't force
> it to happen, for example, by adding a delay somewhere.

I have only seen it when explicitly forcing it, and even then it is not
easy to make happen.  But how would you know whether or not it happened
in a kernel or large multithreaded application?

I am gaining increasing sympathy with anyone who might wish to reduce
the number of non-MMIO-related memory barriers in the Linux kernel!

							Thanx, Paul
