Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbWJRCVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbWJRCVj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 22:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbWJRCVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 22:21:39 -0400
Received: from mga07.intel.com ([143.182.124.22]:27194 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751102AbWJRCVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 22:21:38 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,322,1157353200"; 
   d="scan'208"; a="132425312:sNHT18517289"
Date: Tue, 17 Oct 2006 19:01:44 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Paul Jackson <pj@sgi.com>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, dino@in.ibm.com,
       menage@google.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       mbligh@google.com, rohitseth@google.com, dipankar@in.ibm.com,
       nickpiggin@yahoo.com.au
Subject: Re: [RFC] Cpuset: explicit dynamic sched domain control flags
Message-ID: <20061017190144.A19901@unix-os.sc.intel.com>
References: <20061016230351.19049.29855.sendpatchset@jackhammer.engr.sgi.com> <20061017114306.A19690@unix-os.sc.intel.com> <20061017121823.e6f695aa.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20061017121823.e6f695aa.pj@sgi.com>; from pj@sgi.com on Tue, Oct 17, 2006 at 12:18:23PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2006 at 12:18:23PM -0700, Paul Jackson wrote:
> > What happens when the job in the cpuset with no sched domain
> > becomes active? In this case, scheduler can't make use of all cpus
> > that this cpuset is allowed to use.
> 
> What happens then is that the job manager marks the cpuset of this
> newly activated job as being a sched_domain.

With your patch, that will fail because there is already a cpuset defining
a sched domain and which overlaps with the one that is becoming active.

So job manager need to set/reset these flags when ever jobs in overlaping
cpusets become active/inactive. Is that where you are going with this patch?

What happens when both these jobs/cpusets are active at the same time?

> 
> And if the job manager doesn't do that, and sets up a situation in
> which the scheduler domains don't line up with the active jobs, then
> they can't get scheduler load balancing across all the CPUs in those
> jobs cpusets.  That's exactly what they asked for -- that's exactly
> what they got.
> 
> (Actually, is that right?  I thought load balancing would still occur
> at higher levels in the sched domain/group hierarchy, just not as
> often.)

Once the sched domains are partitioned, there is no interaction/scheduling
happening between those partitions.

> 
> It is not the kernels job to make it impossible for user code to do
> stupid things.  It's the kernels job to offer up various mechanisms,
> and let user space code decide what to do when.
> 
> And, anyhow, how does this differ from overloading the cpu_exclusive
> flag to define sched domains.  One can setup the same thing there,
> where a job can't balance across all its CPUs:
> 
> 	/dev/cpuset/cs1		cpu_exclusive = 1; cpus = 0-7
> 	/dev/cpuset/cs1/suba	cpu_exclusive = 1; cpus = 0-3
> 	/dev/cpuset/cs1/subb	cpu_exclusive = 1; cpus = 4-7
> 
> (sched_domain_enabled = 0 in all cpusets)
> 
> If you put a task in cpuset "cs1" (not in one of the sub cpusets)
> then it can't load balance between CPUs 0-3 and CPUs 4-7 (or can't
> load balance as often - depending on how this works.)

hmm... tasks in "cs1" won't properly be balanced between 0-7cpus..
In this case, shouldn't we remove cpus0-3 from "cs1" cpus_allowed?

Current code makes sure that "suba" cpus are removed from "cs1" sched domain
but allows the tasks in "cs1" to have "suba" cpus.  I don't know much about
how job manager interacts with cpusets but this behavior sounds bad to me.

copying Nick to get his thoughts..

thanks,
suresh
