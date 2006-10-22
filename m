Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751779AbWJVMDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbWJVMDL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 08:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbWJVMDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 08:03:11 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:3741 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751779AbWJVMDJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 08:03:09 -0400
Date: Sun, 22 Oct 2006 05:02:52 -0700
From: Paul Jackson <pj@sgi.com>
To: dino@in.ibm.com
Cc: nickpiggin@yahoo.com.au, mbligh@google.com, akpm@osdl.org,
       menage@google.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       rohitseth@google.com, holt@sgi.com, dipankar@in.ibm.com,
       suresh.b.siddha@intel.com, clameter@sgi.com
Subject: Re: [RFC] cpuset: remove sched domain hooks from cpusets
Message-Id: <20061022050252.b7bcf848.pj@sgi.com>
In-Reply-To: <20061020223553.GA14357@in.ibm.com>
References: <20061019092358.17547.51425.sendpatchset@sam.engr.sgi.com>
	<4537527B.5050401@yahoo.com.au>
	<20061019120358.6d302ae9.pj@sgi.com>
	<4537D056.9080108@yahoo.com.au>
	<4537D6E8.8020501@google.com>
	<4538F34A.7070703@yahoo.com.au>
	<20061020120005.61239317.pj@sgi.com>
	<20061020203016.GA26421@in.ibm.com>
	<20061020144153.b40b2cc9.pj@sgi.com>
	<20061020223553.GA14357@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dinikar wrote:
> On Fri, Oct 20, 2006 at 02:41:53PM -0700, Paul Jackson wrote:
> > 
> > > 2. The main change is that we dont allow tasks to be added to a cpuset
> > >    if it has child cpusets that also have the sched_domain flag turned on
> > >    (Maybe return a EINVAL if the user tries to do that)
> > 
> > This I would not like.  It's ok to have tasks in cpusets that are
> > cut by sched domain partitions (which is what I think you were getting
> > at), just so long as one doesn't mind that they don't load balance
> > across the partition boundaries.
> > 
> > For example, we -always- have several tasks per-cpu in the top cpuset.
> > These are the per-cpu kernel threads.  They have zero interest in
> > load balancing, because they are pinned on a cpu, for their life.
> 
> I cannot think of any reason why this change would affect per-cpu tasks.

You are correct that cpu pinned tasks don't mind not being load balanced.

I was reading too much into what you had suggested.

You suggested not adding tasks to cpusets that have child cpusets
defining sched domains.

But the fate of tasks that were already there was an open issue.

That kind of ordering dependency struck me as so odd that I
leapt to the false conclusion that you couldn't possibly have
meant it, and really mean to disallow any tasks in such a cpuset,
whether there before we setup the sched_domain or not.

So ... nevermind that comment.


Popping the stack, yes, as a practical matter, when setting up
some nodes to be used by real time software, we offload everything
else we can from those nodes, to minimize the interference.

We don't need more error conditions from the kernel to handle that,
not even on big systems.  We just need some way to isolate those
nodes (cpu and memory) from any scheduler load balancing efforts.

This is easy.  It can be done now at boottime (isolcpus=), and at
runtime with the existing cpu_exclusive overloading.  It essentially
just involves setting a single system wide cpumask of isolated cpus.


In addition large systems (apparently for scheduler load balancing
performance reasons) need a way to partition sched domains down to
more reasonable sizes.

Partitioning sched domains interacts with cpusets in ways that are
still confounding us, and depends critcally on information that really
only system services such as the batch scheduler can actually provide
(such as which jobs are active.)  And this, even at a mathematical
minimum, involves a partition of the systems cpus, which is a set of
subsets, or multiple cpumasks instead of just one.  It's harder.

My sense is that your proposal, to try to get rid of, or not allow more
of, the tasks in the overlapping parent cpusets that were complicating
this effort, just makes life harder for such system services, forcing
them to work around our efforts to make life 'safe' for them.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
