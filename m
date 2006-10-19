Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946069AbWJSHdc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946069AbWJSHdc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 03:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946073AbWJSHdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 03:33:32 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:56964 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1946069AbWJSHdb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 03:33:31 -0400
Date: Thu, 19 Oct 2006 00:33:16 -0700
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: holt@sgi.com, suresh.b.siddha@intel.com, dino@in.ibm.com,
       menage@google.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       mbligh@google.com, rohitseth@google.com, dipankar@in.ibm.com
Subject: Re: exclusive cpusets broken with cpu hotplug
Message-Id: <20061019003316.f6a77b34.pj@sgi.com>
In-Reply-To: <4537238A.7060106@yahoo.com.au>
References: <20061017192547.B19901@unix-os.sc.intel.com>
	<20061018001424.0c22a64b.pj@sgi.com>
	<20061018095621.GB15877@lnx-holt.americas.sgi.com>
	<20061018031021.9920552e.pj@sgi.com>
	<45361B32.8040604@yahoo.com.au>
	<20061018231559.8d3ede8f.pj@sgi.com>
	<45371CBB.2030409@yahoo.com.au>
	<20061018235746.95343e77.pj@sgi.com>
	<4537238A.7060106@yahoo.com.au>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So that depends on what cpusets asks for. If, when setting up a and
> b, it asks to partition the domains, then yes that breaks the parent
> cpuset gets broken.

That probably makes good sense from the sched domain side of things.

It is insanely counterintuitive from the cpuset side of things.

Using heirarchical cpuset properties to drive this is the wrong
approach.

In the general case, looking at it (as best I can) from the sched
domain side of things, it seems that the sched domain could be
defined on a system as follows.

    Partition the CPUs on the system - into one or more subsets
    (partitions), non-overlapping, and covering.

    Each of those partitions can either have a sched domain setup on
    it, to support load balancing across the CPUs in that partition,
    or can be isolated, with no load balancing occuring within that
    partition.

    No load balancing occurs across partitions.

Using cpu_exclusive cpusets for this is next to impossible.  It could
be approximated perhaps by having just the immediate children of the
root cpuset, /dev/cpuset/*, define the partition.

But if any lower level cpusets have any affect on the partitioning,
by setting their cpu_exclusive flag in the current implementation,
it is -always- the case, by the basic structure of the cpuset
hierarchy, that the lower level cpuset is a subset of its parents
cpus, and that that parent also has cpu_exclusive set.

The resulting partitioning, even in such simple examples as above, is
not obvious.  If you look back a couple days, when I first presented
essentially this example, I got the resulting sched domain partitioning
entirely wrong.

The essential detail in my big patch of yesterday, to add new specific
sched_domain flags to cpusets, is that it -removed- the requirement to
mark a parent as defining a sched domain anytime a child defined one.

That requirement is one of the defining properties of the cpu_exclusive
flag, and makes that flag -outrageously- unsuited for defining sched
domain partitions.

My new sched_domain flags at least had the right properties, defaults
and rules, that they perhaps could have been used to sanely define sched
domain partitions.  One could mark a few select cpusets, at any depth
in the hierarchy, as defining sched domain partions, without being
forced to mark a whole bunch more ancestor cpusets the same way,
slicing and dicing the sched domain partions into hamburger.

However, fortunately, ... so far as I can tell ... no one needs the
general case described above, of multiple sched domain partitions.

So far as I know, the only essential special case that user land
requires to deal with is to isolate one partition (one subset of CPUs)
from any scheduler load balancing.  Every CPU is either load
balanced however the kernel/sched.c chooses to load balance it,
with potentially every other non-isolated CPU, or is in the isolated
partition (cpu_isolated_map) and not considered for load balancing.

Have I missed any case requiring explicit user intervention?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
