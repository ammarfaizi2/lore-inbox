Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261395AbVCWLpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbVCWLpk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 06:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbVCWLpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 06:45:40 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:28812 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261395AbVCWLp2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 06:45:28 -0500
Date: Wed, 23 Mar 2005 12:44:52 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, dipankar@in.ibm.com, shemminger@osdl.org,
       akpm@osdl.org, torvalds@osdl.org, rusty@au1.ibm.com, tgall@us.ibm.com,
       jim.houston@comcast.net, manfred@colorfullife.com, gh@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption and RCU
In-Reply-To: <20050323054034.GC1294@us.ibm.com>
Message-Id: <Pine.OSF.4.05.10503231232070.15818-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: 0 () 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2005, Paul E. McKenney wrote:

> On Tue, Mar 22, 2005 at 09:55:26AM +0100, Esben Nielsen wrote:
> > On Mon, 21 Mar 2005, Paul E. McKenney wrote:
> [ . . . ]
> > > On Mon, Mar 21, 2005 at 12:23:22AM +0100, Esben Nielsen wrote:
> > > This is in some ways similar to the K42 approach to RCU (which they call
> > > "generations").  Dipankar put together a similar patch for Linux, but
> > > the problem was that grace periods could be deferred for an extremely
> > > long time.  Which I suspect is what you were calling out as causing
> > > RCU batches never to run.
> > 
> > That is where the preempt_by_nonrt_disable/enable() is supposed to help:
> > Then it can't take longer than the normal kernel in the situation where
> > there is no RT tasks running. RT tasks will prolong the grace periods if
> > they go into RCU regions, but they are supposed to be relatively small -
> > and deterministic!
> 
> The part that I am missing is how this helps in the case where a non-RT
> task gets preempted in the middle of an RCU read-side critical section
> indefinitely.  Or are you boosting the priority of any task that
> enters an RCU read-side critical section?

Yes in effect: I set the priority to MAX_RT_PRIO. But actually I am
playing around (when I get time for it that is :-( ) with cheaper
solution: 
I assume you enter these regions where you don't want to be
preempted by non-RT tasks are relatively short. Therefore the risc of
getting preempted is small. Moving the priority is expensive since you
need to lock the runqueue. I only want to do the movement when
there is an preemption. Therefore I added code in schedule() to take care
of it: If a task is in a rcu-read section, is non-RT and is preempted it's
priority is set to MAX_RT_PRIO for the time being. It will keep that
priority until the priority is recalculated, but that shouldn't hurt
anyone. 
I am not happy about adding code to schedule() but setting the
priority in there is very cheap because it already has the lock
on the runqueue. Furthermore, I assume it only happens very rarely. In the
execution of schedule() my code only takes a single test on wether the
previous task was in a rcu-section or not. That is not very much code.

I have not yet tested it (no time :-( )


> [...]
> > > Yes, but this is true of every other lock in the system as well, not?
> > 
> > Other locks are not globaly used but only used for a specific subsystem.
> > On a real-time system you are supposed to know which subsystems you can
> > call into and still have a low enough latency as each subsystem has it's
> > own bound. But with a global RCU locking mechanism all RCU using code is
> > to be regarded as _one_ such subsystem.
> 
> Yep.  As would the things protected by the dcache lock, task list lock,
> and so on, right?

Yep

> 
> 						Thanx, Paul
> 
Esben

