Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932445AbWDGO40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbWDGO40 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 10:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbWDGO40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 10:56:26 -0400
Received: from dvhart.com ([64.146.134.43]:12744 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S932445AbWDGO40 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 10:56:26 -0400
From: Darren Hart <darren@dvhart.com>
To: Bill Huey (hui) <billh@gnuppy.monkey.org>
Subject: Re: RT task scheduling
Date: Fri, 7 Apr 2006 07:56:20 -0700
User-Agent: KMail/1.8.3
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       "Stultz, John" <johnstul@us.ibm.com>,
       Peter Williams <pwil3058@bigpond.net.au>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
References: <200604052025.05679.darren@dvhart.com> <20060407091946.GA28421@elte.hu> <20060407103926.GC11706@gnuppy.monkey.org>
In-Reply-To: <20060407103926.GC11706@gnuppy.monkey.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604070756.21625.darren@dvhart.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 07 April 2006 03:39, Bill Huey wrote:
> On Fri, Apr 07, 2006 at 11:19:46AM +0200, Ingo Molnar wrote:
> > -ENOPARSE. CPU binding brings with itself obvious disadvantages that
> > some applications are not ready to pay. CPU binding restricts the
> > scheduler from achieving best resource utilization. That may be fine for
> > some applications, but is not good enough for a good number of
> > applications. So in no way can any 'CPU binding mechanism' (which
> > already exists in multiple forms) replace the need and desire for a
> > globally scheduled class of RT tasks.
>
> You're discussing a different problem than what I'm talking about. Some
> of it probably is terminology, some it is actually multipule problems
> that need to be seperated out and discussed individually. I'm open for
> any help on this matter to communicate my view on this topic.
>
> I'm talking about two scenarios, (1) a high performance strict RT usage
> of SCHED_FIFO and friends verses (2) a kernel that might have a more
> general purpose orientation that would be looser about rebalancing,
> permitting some RT task of lower priority to run above a higher priority
> for performance sake, what ever...
>
> > > [...] the key here is "robust". [...]
> >
> > -ENOPARSE. CPU binding is CPU binding. Could you outline an example of a
> > "non-robust" CPU binding solution?
>
> We're having a terminology problem here... let's pull back a bit.
>
> Any solution that depends on a general purpose algorithm, heuristic or
> any of thing of that nature, that means any kind of load rebalancing,
> may interfere with RT app of type (1).

The rt-overload mechanism is distinct from load balancing.  RT overload 
attempts to make sure the NR_CPUS highest priority runnable tasks are running 
on each of the available CPUs.  This isn't load balancing, this is "system 
wide strict realtime priority scheduling" (SWSRPS).  This scheduling should 
take place even if there are 1000 non RT tasks on CPU 0 and none on all the 
others.  The load balancer would be responsible for distributing those 1000 
non rt tasks to all the CPUs.

>
> RT applications tend to want explicit control over the scheduling of
> the system with as little interference from the kernel as possible. The
> general purpose policies (RT rebalancing) of the Linux kernel can impede
> RT apps from getting at CPU time more directly. 

I don't feel that SWSRPS in anyway interferes with realtime applications.  If 
an application does not explicitly set a cpu affinity, then the kernel should 
assume the task can run on any CPU and should make SWSRPS decisions 
accordingly.  In fact, in my experience, applications expect this type of 
scheduling - and don't consider it an interference.

> If you have a SCHED_FIFO
> task, it's by default globally rebalanced, right ? Well, the run queue
> search and IPI is going to add to the maximum deterministic response time
> of that thread

Actually the SWSRPS is what makes the scheduling deterministic.  That 
determinism comes at a cost, but without it it doesn't exist at all on an SMP 
machine.  So saying it "adds to the maximum deterministic response time" 
doesn't really make any sense.

> . 
>
> How do you avoid that ? Well, give the RT app designer the decision to
> hot wire a thread to a CPU so that the rebalancing logic never gets
> triggered. That'll improve latency and the expense of rebalancing. This
> is up to the discretion of the RT app designer and that person is best
> suited to decide where and when that RT thread will run. Current Linux
> kernel policies are sufficient to meet at least part of this requirement
> fairly well. This does not address the general case (2) and is a
> different problem.

It's my impression (RT folks please pipe up if it's wrong) that if you don't 
care about priority scheduling (i.e. it's OK for a lower priority task to run 
while one with a higher priority sits waiting on another queue), then you 
don't use SCHED_FIFO.  So I don't think case 2 is really valid.

>
> Here I've though of it in terms of letting a per CPU binding suggest
> to the scheduler what kind of rebalancing policy I want verses letting
> a run class determine it. In my opinion, creation of SCHED_FIFO_GLOBAL
> is unneeded because of it. What I meant by "robust" was that folks
> should consider "fully" if binding address the solution or not before
> introducing a new run category. I'm asking "does this address the
> problem entirely ?" if not, *then* consider a new run category only after
> this fails. That's what I'm saying.
>
> As a side note, consider extended this notion of thread binding so that
> it excludes any other thread from running on a CPU that might make the
> cache cold for that bounded thread. That'll give maximum latency
> performance (sub-microsecond). That's more thinking in terms of CPU
> binding.

You've made a lot of references to binding tasks to CPUs (or forbidding them, 
which is essentially a bind to non-forbidden CPUs).  While application 
developers can certainly take this approach, the linux kernel should schedule 
realtime tasks globally according to priority in the generic case.

--Darren

