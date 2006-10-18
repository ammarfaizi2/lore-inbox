Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750849AbWJRHFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbWJRHFg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 03:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbWJRHFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 03:05:36 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:43175 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750843AbWJRHFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 03:05:35 -0400
Date: Wed, 18 Oct 2006 00:05:12 -0700
From: Paul Jackson <pj@sgi.com>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: suresh.b.siddha@intel.com, dino@in.ibm.com, menage@google.com,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, mbligh@google.com,
       rohitseth@google.com, dipankar@in.ibm.com, nickpiggin@yahoo.com.au
Subject: Re: [RFC] Cpuset: explicit dynamic sched domain control flags
Message-Id: <20061018000512.1d13aabd.pj@sgi.com>
In-Reply-To: <20061017190144.A19901@unix-os.sc.intel.com>
References: <20061016230351.19049.29855.sendpatchset@jackhammer.engr.sgi.com>
	<20061017114306.A19690@unix-os.sc.intel.com>
	<20061017121823.e6f695aa.pj@sgi.com>
	<20061017190144.A19901@unix-os.sc.intel.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suresh wrote:
> > What happens then is that the job manager marks the cpuset of this
> > newly activated job as being a sched_domain.
> 
> With your patch, that will fail because there is already a cpuset defining
> a sched domain and which overlaps with the one that is becoming active.

No, this does not fail.  The job manager also turned off the other cpusets
sched_domain flag, because that job went inactive.

The job manager does not run active jobs on overlapping CPUs.  It marks
the cpusets of only the active jobs as sched domains, and turns off the
sched_domain flag on the cpusets of the inactive jobs.

> So job manager need to set/reset these flags when ever jobs in overlaping
> cpusets become active/inactive. Is that where you are going with this patch?

Yes.  Jobs don't go active or inactive all that often, and when they do,
the job manager expects to do a fair bit of work to reassign the CPU
and Memory resources to the newly activated job.

For example, one job might have to be inactivated before completion
because some other job of higher or more urgent priority has come along
and should get those resources.

For a more specific example, one might have three small jobs, on three
small, non-overlapping cpusets, that have to be made inactive to run one
larger job using the combined resources of those cpusets, as one larger
cpuset.  If say the jobs were CPU bound, but didn't need all the memory
on those nodes, it might be desirable to just inactivate the three
small jobs inplace, define a new cpuset that contains the union of the
three small cpusets, and run the new, larger, higher priority job
there.  Then when that new big job finishes, reactivate the original
three small jobs, which would include tearing down the one big cpuset,
and re-enabling the sched_domain flag on the three small cpusets.

> Once the sched domains are partitioned, there is no interaction/scheduling
> happening between those partitions.

Ok ...

Is there anyway to determine, on a running system, what sched domains
and groups are present?

Given the difficulty I am having predicting what sched domains will
result from a particular setup, as well as your parallel thread on the
problems with the interaction of cpu_hotplug and sched domains, it
would seem that it is not easy for others to know how a running systems
sched domains are layed out.

Does a sched domain configuration depend on the order in which the
partition_sched_domains() calls are made?  If so, wouldn't this make it
difficult to determine the actual sched domain configuration of a live
system?

How would -you- determine the sched domains defined on a live system?

How would you advise me to explain to my users how to determine this?

> > If you put a task in cpuset "cs1" (not in one of the sub cpusets)
> > then it can't load balance between CPUs 0-3 and CPUs 4-7 (or can't
> > load balance as often - depending on how this works.)
> 
> hmm... tasks in "cs1" won't properly be balanced between 0-7cpus..

er eh - yes - like I just said.

> In this case, shouldn't we remove cpus0-3 from "cs1" cpus_allowed?

No, you missed my point.  The point of my example wasn't to show how to
do this right.  It was to show that even the existing cpu_exclusive
flag lets one create sched domains configurations that might not be
what one wanted.

If the basis for your objections to my patch was that one could create
bogus sched domain configurations, I claim that's nothing new.  What's
more it is not a valid objection.  Most kernel facilities let one do
bogus things.  What matters is that people can understand what they are
doing and can figure out how to get the kernel to do useful things.

We are not designing scheduler internals here, where the kernel is left
pretty much on its own to do the best it can, with a generous dose of
magic and heuristics.  We are designing kernel-user API's, which should
be transparent, repeatable and predictable.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
