Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262703AbVCXHFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262703AbVCXHFq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 02:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263072AbVCXHD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 02:03:59 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:50879 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263069AbVCXHCD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 02:02:03 -0500
Date: Wed, 23 Mar 2005 23:02:07 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Ingo Molnar <mingo@elte.hu>, dipankar@in.ibm.com, shemminger@osdl.org,
       akpm@osdl.org, torvalds@osdl.org, rusty@au1.ibm.com, tgall@us.ibm.com,
       jim.houston@comcast.net, manfred@colorfullife.com, gh@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption and RCU
Message-ID: <20050324070207.GI1298@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050323054034.GC1294@us.ibm.com> <Pine.OSF.4.05.10503231232070.15818-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10503231232070.15818-100000@da410.phys.au.dk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2005 at 12:44:52PM +0100, Esben Nielsen wrote:
> On Tue, 22 Mar 2005, Paul E. McKenney wrote:
> 
> > On Tue, Mar 22, 2005 at 09:55:26AM +0100, Esben Nielsen wrote:
> > > On Mon, 21 Mar 2005, Paul E. McKenney wrote:
> > [ . . . ]
> > > > On Mon, Mar 21, 2005 at 12:23:22AM +0100, Esben Nielsen wrote:
> > > > This is in some ways similar to the K42 approach to RCU (which they call
> > > > "generations").  Dipankar put together a similar patch for Linux, but
> > > > the problem was that grace periods could be deferred for an extremely
> > > > long time.  Which I suspect is what you were calling out as causing
> > > > RCU batches never to run.
> > > 
> > > That is where the preempt_by_nonrt_disable/enable() is supposed to help:
> > > Then it can't take longer than the normal kernel in the situation where
> > > there is no RT tasks running. RT tasks will prolong the grace periods if
> > > they go into RCU regions, but they are supposed to be relatively small -
> > > and deterministic!
> > 
> > The part that I am missing is how this helps in the case where a non-RT
> > task gets preempted in the middle of an RCU read-side critical section
> > indefinitely.  Or are you boosting the priority of any task that
> > enters an RCU read-side critical section?
> 
> Yes in effect: I set the priority to MAX_RT_PRIO. But actually I am
> playing around (when I get time for it that is :-( ) with cheaper
> solution: 
> I assume you enter these regions where you don't want to be
> preempted by non-RT tasks are relatively short. Therefore the risc of
> getting preempted is small. Moving the priority is expensive since you
> need to lock the runqueue. I only want to do the movement when
> there is an preemption. Therefore I added code in schedule() to take care
> of it: If a task is in a rcu-read section, is non-RT and is preempted it's
> priority is set to MAX_RT_PRIO for the time being. It will keep that
> priority until the priority is recalculated, but that shouldn't hurt
> anyone. 
> I am not happy about adding code to schedule() but setting the
> priority in there is very cheap because it already has the lock
> on the runqueue. Furthermore, I assume it only happens very rarely. In the
> execution of schedule() my code only takes a single test on wether the
> previous task was in a rcu-section or not. That is not very much code.

Interesting approach -- could come in handy.

> I have not yet tested it (no time :-( )

Well, being as I haven't got the lock-based scheme fully running yet,
I can't give you too much trouble about that.  :-/

							Thanx, Paul

> > [...]
> > > > Yes, but this is true of every other lock in the system as well, not?
> > > 
> > > Other locks are not globaly used but only used for a specific subsystem.
> > > On a real-time system you are supposed to know which subsystems you can
> > > call into and still have a low enough latency as each subsystem has it's
> > > own bound. But with a global RCU locking mechanism all RCU using code is
> > > to be regarded as _one_ such subsystem.
> > 
> > Yep.  As would the things protected by the dcache lock, task list lock,
> > and so on, right?
> 
> Yep
> 
> > 
> > 						Thanx, Paul
> > 
> Esben
> 
> 
