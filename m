Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932415AbWDGKjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbWDGKjl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 06:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWDGKjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 06:39:41 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:8858
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S932412AbWDGKjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 06:39:40 -0400
Date: Fri, 7 Apr 2006 03:39:26 -0700
To: Ingo Molnar <mingo@elte.hu>
Cc: Darren Hart <darren@dvhart.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       "Stultz, John" <johnstul@us.ibm.com>,
       Peter Williams <pwil3058@bigpond.net.au>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: RT task scheduling
Message-ID: <20060407103926.GC11706@gnuppy.monkey.org>
References: <200604052025.05679.darren@dvhart.com> <20060406073753.GA18349@elte.hu> <20060407030713.GA9623@gnuppy.monkey.org> <20060407071125.GA2563@elte.hu> <20060407083931.GA11393@gnuppy.monkey.org> <20060407091946.GA28421@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060407091946.GA28421@elte.hu>
User-Agent: Mutt/1.5.11+cvs20060126
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2006 at 11:19:46AM +0200, Ingo Molnar wrote:
> -ENOPARSE. CPU binding brings with itself obvious disadvantages that 
> some applications are not ready to pay. CPU binding restricts the 
> scheduler from achieving best resource utilization. That may be fine for 
> some applications, but is not good enough for a good number of 
> applications. So in no way can any 'CPU binding mechanism' (which 
> already exists in multiple forms) replace the need and desire for a 
> globally scheduled class of RT tasks.

You're discussing a different problem than what I'm talking about. Some
of it probably is terminology, some it is actually multipule problems
that need to be seperated out and discussed individually. I'm open for
any help on this matter to communicate my view on this topic.

I'm talking about two scenarios, (1) a high performance strict RT usage
of SCHED_FIFO and friends verses (2) a kernel that might have a more
general purpose orientation that would be looser about rebalancing,
permitting some RT task of lower priority to run above a higher priority
for performance sake, what ever...

> > [...] the key here is "robust". [...]
> 
> -ENOPARSE. CPU binding is CPU binding. Could you outline an example of a 
> "non-robust" CPU binding solution?

We're having a terminology problem here... let's pull back a bit.

Any solution that depends on a general purpose algorithm, heuristic or
any of thing of that nature, that means any kind of load rebalancing,
may interfere with RT app of type (1).

RT applications tend to want explicit control over the scheduling of
the system with as little interference from the kernel as possible. The
general purpose policies (RT rebalancing) of the Linux kernel can impede
RT apps from getting at CPU time more directly. If you have a SCHED_FIFO
task, it's by default globally rebalanced, right ? Well, the run queue
search and IPI is going to add to the maximum deterministic response time
of that thread.

How do you avoid that ? Well, give the RT app designer the decision to
hot wire a thread to a CPU so that the rebalancing logic never gets
triggered. That'll improve latency and the expense of rebalancing. This
is up to the discretion of the RT app designer and that person is best
suited to decide where and when that RT thread will run. Current Linux
kernel policies are sufficient to meet at least part of this requirement
fairly well. This does not address the general case (2) and is a
different problem.

Here I've though of it in terms of letting a per CPU binding suggest
to the scheduler what kind of rebalancing policy I want verses letting
a run class determine it. In my opinion, creation of SCHED_FIFO_GLOBAL
is unneeded because of it. What I meant by "robust" was that folks
should consider "fully" if binding address the solution or not before
introducing a new run category. I'm asking "does this address the
problem entirely ?" if not, *then* consider a new run category only after
this fails. That's what I'm saying.

As a side note, consider extended this notion of thread binding so that
it excludes any other thread from running on a CPU that might make the
cache cold for that bounded thread. That'll give maximum latency
performance (sub-microsecond). That's more thinking in terms of CPU
binding.

Does this help with the communication ?

bill

