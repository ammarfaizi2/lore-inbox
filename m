Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316465AbSFJWaA>; Mon, 10 Jun 2002 18:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316477AbSFJWaA>; Mon, 10 Jun 2002 18:30:00 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:19691 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316465AbSFJW36>;
	Mon, 10 Jun 2002 18:29:58 -0400
To: Bill Davidsen <davidsen@tmr.com>
cc: Rick Bressler <rickb@mushroom.ca.boeing.com>, linux-kernel@vger.kernel.org,
        rml@tech9.net
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [PATCH] scheduler hints 
In-Reply-To: Your message of Mon, 10 Jun 2002 17:05:59 EDT.
             <Pine.LNX.3.96.1020610165913.23851B-100000@gatekeeper.tmr.com> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9664.1023748047.1@us.ibm.com>
Date: Mon, 10 Jun 2002 15:27:27 -0700
Message-Id: <E17HXdH-0002Vw-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.3.96.1020610165913.23851B-100000@gatekeeper.tmr.com>, > : 
Bill Davidsen writes:
> On Wed, 5 Jun 2002, Rick Bressler wrote:
> 
> > > So I went ahead and implemented scheduler hints on top of the O(1)
> > > scheduler. 
> > 
> > > Other hints could be "I am interactive" or "I am a batch (i.e. cpu hog)
> > > task" or "I am cache hot: try to keep me on this CPU". 
> > 
> > Sequent had an interesting hint they cooked up with Oracle. (Or maybe it
> > was the other way around.)  As I recall they called it 'twotask.'
> > Essentially Oracle clients processes spend a lot of time exchanging
> > information with its server process. It usually makes sense to bind them
> > to the same CPU in an SMP (and especially NUMA) machine.  (Probably
> > obvious to most of the folks on the group, but it is generally lots
> > better to essentially communicate through the cache and local memory
> > than across the NUMA bus.)
> 
> Are you really saying that you think serializing all the clients through a
> single processor will gain more than than you lose by not using all the
> other CPUs for clients?
  
When the number of runnable processes exceeds the number of CPUs
in an SMP system, and subsets of the runnable processes share data
(pipes, sockets, shared memory, etc.), minimizing the cache invalidate
effects of the subset by scheduling them on the same CPU (with some
level of cache-affinity, or stickiness) can increase throughput
dramatically.  Oracle Apps and BAAN are two application sets that have
this kind of behavior which benefited from having these subsets of
related processes "tied at the wrists" when they were scheduled.

Figure 1000 runnable process, in sets of two or even sets of ten.
The subsets should be scheduled together if possible, but still
smeared across all processors.  No one is suggesting that a UP machine
will always outperform an SMP machine.  ;-)

As was mentioned in another aspect of this thread, this is different
from explicit user-specified CPU affinity in that there are more processes
than a user wants to allocate explicitly to CPUs.  Instead, the scheduler
can do load balancing by moving/migrating sets of processes from an
overloaded CPU to a less loaded CPU.  However, the cache effects can
make a difference of something like 20-50% of overall throughput in
a fairly intensive data sharing workload like this.

> > As I recall it made a significant difference in Oracle performance, and
> > would probably also translate to similar performance in many situations
> > where you had a client and server process doing lots of interaction in
> > an SMP environment.
> 
> I've certainly seen a "significant difference" between uni and SMP, but it
> was always in the other direction. Is this particular to some hardware, or
> running multiple servers somehow? I'm only fmailiar with Linux, AIX and
> Solaris, maybe this is Sequent magic? Or were you talking about having
> only one client total on the machine and just making that run fast?

This is an SMP thing, which also benefits NUMA pretty dramatically.
And this is about how processes are scheduled, and how hints can
be provided to the scheduler.  It also relates to the overhead of
cache invalidation, the size of CPU caches, etc.  Sequent's hardware
might have seen a bigger improvement from this type of change than
other types of hardware might.  Or vice versa.

gerrit
