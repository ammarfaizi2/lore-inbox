Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946198AbWJTUAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946198AbWJTUAA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 16:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946482AbWJTUAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 16:00:00 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:51627 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1946450AbWJTT75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 15:59:57 -0400
Date: Fri, 20 Oct 2006 12:59:32 -0700
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: akpm@osdl.org, mbligh@google.com, menage@google.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, dino@in.ibm.com, rohitseth@google.com,
       holt@sgi.com, dipankar@in.ibm.com, suresh.b.siddha@intel.com,
       clameter@sgi.com
Subject: Re: [RFC] cpuset: add interface to isolated cpus
Message-Id: <20061020125932.224d68d8.pj@sgi.com>
In-Reply-To: <453882AC.3070500@yahoo.com.au>
References: <20061019092607.17547.68979.sendpatchset@sam.engr.sgi.com>
	<453750AA.1050803@yahoo.com.au>
	<20061019105515.080675fb.pj@sgi.com>
	<4537BEDA.8030005@yahoo.com.au>
	<20061019115652.562054ca.pj@sgi.com>
	<4537CC1E.60204@yahoo.com.au>
	<20061019203744.09b8c800.pj@sgi.com>
	<453882AC.3070500@yahoo.com.au>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick wrote:
> I'm talking about isolcpus. What do isolcpus have to do with cpusets.c?
> You can turn off CONFIG_CPUSETS and still use isolcpusets, can't you?

The connection of isolcpus with cpusets is about as strong (or weak)
as the connection of sched domain partitioning with cpusets.

Both isolcpus and sched domain partitions are tweaks to the scheduler
domain code, to lessen the impact of load balancing, by making sched
domains smaller, or by avoiding some cpus entirely.

Cpusets is concerned with the placement of tasks on cpus and nodes.

That's more related to sched domains (and hence to isolated cpus and
sched domain partitioning) than it is, say, to the crypto code for
generating randomly random numbers from /dev/random.

But I will grant it is not a strong connection.

Apparently you were seeing the potential for a stronger connection
between cpusets and sched domain partitioning, because you thought
that the cpuset configuration naturally defined some partitions of
the systems cpus, that it would behoove the sched domain partitioning
code to take advantage of.

Unfortunately, cpusets define no such partitioning ... not system wide.

> So if you have a particular policy you need to implement, which is
> one cpus_exclusive cpuset off the root, covering half the cpus in
> the system (as a simple example)... why is it good to implement
> that with set_cpus_allowed and bad to implement it with partitions?

A cpu_exclusive cpuset does not implement the policy of partitioning
a system, such that no one else can use those cpus.  It implements
a policy of limiting the sharing of cpus, just to ones cpuset ancestors
and descendents - no distant cousins.  That makes it easier for system
admins and batch schedulers to manage the sharing of resources to meet
their needs.  They have fewer places to worry about that might be
intruding.

It would be reasonable, for example, to do the following.  One could
have a big job, that depended on scheduler load balancing, that ran
in the top cpuset, covering the entire system.  And one could have
smaller jobs, in child cpusets.  During the day one pauses the big
job and lets the smaller jobs run.  During the night, one does the
reverse.  Granted, this example is a little bit hypothetical.  Things
like this are done, but usually a couple layers further down the
cpuset hierarchy.  At the top level, one common configuration that
I am aware of puts almost the entire system into one cpuset, to be
managed by the batch scheduler, and just a handful of cpus into a
separate cpuset, to handle the classic Unix load (init, daemons, cron,
admins login.)

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
