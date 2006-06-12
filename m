Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750873AbWFLReQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbWFLReQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 13:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWFLReQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 13:34:16 -0400
Received: from mga05.intel.com ([192.55.52.89]:18260 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750898AbWFLReO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 13:34:14 -0400
X-IronPort-AV: i="4.05,229,1146466800"; 
   d="scan'208"; a="50859404:sNHT5713564073"
Date: Mon, 12 Jun 2006 10:28:58 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Gerd Hoffmann <kraxel@suse.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] scheduler issue & patch
Message-ID: <20060612102847.A5687@unix-os.sc.intel.com>
References: <448D88A2.1060002@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <448D88A2.1060002@suse.de>; from kraxel@suse.de on Mon, Jun 12, 2006 at 05:30:42PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2006 at 05:30:42PM +0200, Gerd Hoffmann wrote:
>   Hi,
> 
> I'm looking into a scheduler issue with a NUMA box and scheduling
> domains.  The machine is a dual-core opteron with with two nodes, i.e.
> four cpus.  cpu0+1 build node0, cpu2+3 build node1.
> 
> Now I have an application (benchmark) with two threads which performs
> best when the two threads are running on different nodes (probably
> because the cpus on each node share the L2 cache).  The scheduler tends
> to keep threads on the local node though, wihch probably makes sense on
> most cases because local memory is faster.
> 
> Ok, we have tools to give hints to the scheduler (taskset, numactl).
> The problem is it doesn't work well.  I can ask the scheduler to use
> cpu1 (node0) and cpu3 (node1) only (via "taskset 0x0a").  But the
> scheduler very often schedules both threads on the same cpu :-(
> 
> I think the reason is that the scheduler always checks the complete cpu
> groups when calculation the group load, without looking at
> task->cpus_allowed.  So we have the effect that the scheduler walks down
> the scheduler domain tree, looks at the group for node0, looks at both
> cpu0 and cpu1, finds node0 being not overloaded due to cpu0 being idle
> and decides to keep the thread on the local node.  Next it walks down
> the tree and finds it isn't allowed to use the idle cpu0.  So both
> threads get scheduled to cpu1.  Oops.

I don't think it is the problem with sched_balance_self(). sched_balance_self()
probably is doing the right thing based on the load that is present at the
time of fork/exec. Once the node-1 becomes idle, we expect the two threads
on node-0 cpu-1 to get distributed between the two nodes.

Perhaps the real issue is how cpu_power is calculated for node domain
on these systems. Because of the shared resources between the cpus in a node,
cpu_power for a group in node domain should be < 2 * SCHED_LOAD_SCALE..

Once this is the case, find_busiest_group() should detect the imbalance and
move one of the threads from cpu-1(node-0) to cpu-3(node-1)

> The patch attached takes the sledgehammer approach to fix it:  In case
> we have a non-default cpumask in task->cpus_allowed the scheduler
> ignores all the fancy scheduling domains and simply spreads the load
> equally over the cpus allowed by task->cpus_allowed.  Not exactly
> elegant, but works.  Not each time, but very often.
> 
> Comments?  Ideas how to solve this better?  I've also tried to play with
> the group load calculation, but it didn't work well.  I'm kida lost in
> all those scheduler tuning knobs ...

In my opinion, this patch is not the correct fix for the issue.

thanks,
suresh
