Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132422AbRDJWmP>; Tue, 10 Apr 2001 18:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132433AbRDJWlz>; Tue, 10 Apr 2001 18:41:55 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:27570 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S132422AbRDJWlo>; Tue, 10 Apr 2001 18:41:44 -0400
Subject: Re: [Lse-tech] Re: [PATCH for 2.5] preemptible kernel
To: nigel@nrg.org
Cc: ak@suse.de, "Dipankar Sarma" <dipankar.sarma@in.ibm.com>,
        linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
        "Suparna Bhattacharya" <bsuparna@in.ibm.com>
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF6C3EA7C6.99519DF9-ON88256A2A.0079A408@LocalDomain>
From: "Paul McKenney" <Paul.McKenney@us.ibm.com>
Date: Tue, 10 Apr 2001 15:08:44 -0700
X-MIMETrack: Serialize by Router on D03NM045/03/M/IBM(Release 5.0.6 |December 14, 2000) at
 04/10/2001 04:41:35 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > As you've observed, with the approach of waiting for all pre-empted
tasks
> > to synchronize, the possibility of a task staying pre-empted for a long
> > time could affect the latency of an update/synchonize (though its hard
for
> > me to judge how likely that is).
>
> It's very unlikely on a system that doesn't already have problems with
> CPU starvation because of runaway real-time tasks or interrupt handlers.

Agreed!

> First, preemption is a comparitively rare event with a mostly
> timesharing load, typically from 1% to 10% of all context switches.

Again, agreed!

> Second, the scheduler should not penalize the preempted task for being
> preempted, so that it should usually get to continue running as soon as
> the preempting task is descheduled, which is at most one timeslice for
> timesharing tasks.

The algorithms we have been looking at need to have absolute guarantees
that earlier activity has completed.  The most straightforward way to
guarantee this is to have the critical-section activity run with preemption
disabled.  Most of these code segments either take out locks or run
with interrupts disabled anyway, so there is little or no degradation of
latency in this case.  In fact, in many cases, latency would actually be
improved due to removal of explicit locking primitives.

I believe that one of the issues that pushes in this direction is the
discovery that "synchronize_kernel()" could not be a nop in a UP kernel
unless the read-side critical sections disable preemption (either in
the natural course of events, or artificially if need be).  Andi or
Rusty can correct me if I missed something in the previous exchange...

The read-side code segments are almost always quite short, and, again,
they would almost always otherwise need to be protected by a lock of
some sort, which would disable preemption in any event.

Thoughts?

                              Thanx, Paul

