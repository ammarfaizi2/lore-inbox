Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752013AbWG1PZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752013AbWG1PZI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 11:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752014AbWG1PZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 11:25:08 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:15833 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1752013AbWG1PZF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 11:25:05 -0400
Date: Fri, 28 Jul 2006 08:25:41 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Esben Nielsen <nielsen.esben@googlemail.com>
Cc: Bill Huey <billh@gnuppy.monkey.org>, linux-kernel@vger.kernel.org,
       compudj@krystal.dyndns.org, rostedt@goodmis.org, tglx@linutronix.de,
       mingo@elte.hu, dipankar@in.ibm.com, rusty@au1.ibm.com
Subject: Re: [RFC, PATCH -rt] NMI-safe mb- and atomic-free RT RCU
Message-ID: <20060728152541.GA1289@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060726001733.GA1953@us.ibm.com> <Pine.LNX.4.64.0607262202560.15681@localhost.localdomain> <20060727013943.GE4338@us.ibm.com> <Pine.LNX.4.64.0607270946030.10276@localhost.localdomain> <20060727154637.GA1288@us.ibm.com> <20060727195355.GA2887@gnuppy.monkey.org> <20060728000231.GB1288@us.ibm.com> <20060728004857.GA5096@gnuppy.monkey.org> <20060728045619.GE1288@us.ibm.com> <Pine.LNX.4.64.0607281154410.10047@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607281154410.10047@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2006 at 12:14:18PM +0100, Esben Nielsen wrote:
> On Thu, 27 Jul 2006, Paul E. McKenney wrote:
> >On Thu, Jul 27, 2006 at 05:48:57PM -0700, Bill Huey wrote:
> >>Another thing. What you mention above is really just having a set of 
> >>owners
> >>for the read side and not really a preemption list tracking thing with RCU
> >>and special scheduler path. The more RCU does this kind of thing the more
> >>it's just like a traditional read/write lock but with more parallelism 
> >>since
> >>it's holding on to read side owners on a per CPU basis.
> >
> >There are certainly some similarities between a priority-boosted RCU
> >read-side critical section and a priority-boosted read-side rwlock.
> >In theory, the crucial difference is that as long as one has sufficient
> >memory, one can delay priority-boosting the RCU read-side critical
> >sections without hurting update-side latency (aside from the grace period
> >delays, of course).

Here is a better list of the similarities and differences between
rwlock and RCU in -rt:

	Attribute			rwlock		RCU

	Readers block updates		Y		N

	Readers block freeing		Y		Y (synchronize_rcu())

	Updates block readers		Y		N

	Deterministic readers		N		Y

	Readers block readers		Y (-rt!)	N

	Readers preemptible		Y		Y

	Readers can block on locks	Y		Y

	Readers can block arbitrarily	Y		N (SRCU for this)


So in rwlock, priority boosting of readers is required to allow
updates to happen -at- -all-, while in RCU, priority boosting is
required to get deferred free (call_rcu(), synchronize_rcu()) unstuck.

> >So I will no doubt be regretting my long-standing advice to use
> >synchronize_rcu() over call_rcu().  Sooner or later someone will care
> >deeply about the grace-period latency.  In fact, I already got some
> >questions about that at this past OLS.  ;-)
> 
> Yick!! Do people really expect these things to finish in a predictable 
> amount of time?

Yeah, this is -almost- as unreasonable as expecting preemptible RCU
read-side critical sections!!!  ;-)  ;-)  ;-)

> This reminds me of C++ hackers starting to code Java. They want to use the 
> finalizer to close files etc. just as they use the destructor in C++, but 
> can't understand that they have to wait until the garbage collector has 
> run.
> RCU is a primitive kind of garbage collector. You should never depend on 
> how long it is about doing it's work, just that it will get done at some 
> point.

Seriously, it probably is not all that hard to get an upper bound on
synchronize_rcu() latency, as long as one is willing to put up with the
upper bound being a handful of jiffies (as opposed to being down in the
microsecond range.  In addition, this upper bound would be a function
of the number of tasks, and would also require boosting RCU read-side
priority to maximum.

That said, a (say) ten-jiffy upper bound on synchronize_rcu() would
probably not be what they were looking for.  ;-)

							Thanx, Paul
