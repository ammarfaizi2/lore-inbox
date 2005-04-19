Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261349AbVDSR1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbVDSR1A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 13:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbVDSR07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 13:26:59 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:7615 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261349AbVDSR0x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 13:26:53 -0400
Date: Tue, 19 Apr 2005 10:23:48 -0700
From: Paul Jackson <pj@sgi.com>
To: dino@in.ibm.com
Cc: Simon.Derr@bull.net, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, akpm@osdl.org, dipankar@in.ibm.com,
       colpatch@us.ibm.com
Subject: Re: [Lse-tech] Re: [RFC PATCH] Dynamic sched domains aka Isolated
 cpusets
Message-Id: <20050419102348.118005c1.pj@sgi.com>
In-Reply-To: <20050419093438.GB3963@in.ibm.com>
References: <1097110266.4907.187.camel@arrakis>
	<20050418202644.GA5772@in.ibm.com>
	<20050418225427.429accd5.pj@sgi.com>
	<20050419093438.GB3963@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dinakar wrote:
> I was hoping that by the time we are done with this, we would
> be able to completely get rid of the isolcpus= option.

I won't miss it.  Though, since it's in the main line kernel,
do you need to mark it deprecated for a while first?

> For that
> ofcourse we need to be able build domains that dont run
> load balance

Ah - so that's what these isolcpus are - ones not load balanced?
This was never clear to me.


> The wording [/* Set ... */ ] was from the users point of view
> for what action was being done, guess I'll change that

Ok - at least now I can read and understand the comments, knowing this. 
The other comments in cpuset.c don't follow this convention, of speaking
in the "user's voice", but rather speak in the "responding systems
voice."  Best to remain consistent in this matter.

> It is complicated because it has to handle all of the different
> possible actions that the user can initiate. It can be simplified
> if we have stricter rules of what the user can/cannot do
> w.r.t to isolated cpusets

It is complicated because you are trying to pretend that to be doing a
complex state change one step at a time, without a precise statement (at
least, not that I saw) of what the invariants are, and atomic operations
that preserve the invariants.

> > First, let me verify one thing.  I understand that the _key_
> > purpose of your patch is not so much to isolate cpus, as it
> > is to allow for structuring scheduling domains to align with
> > cpuset boundaries.  I understand real isolated cpus to be ones
> > that don't have a scheduling domain (have only the dummy one),
> > as requested by the "isolcpus=..." boot flag.
> 
> Not really. Isolated cpusets allows you to do a soft-partition
> of the system, and it would make sense to continue to have load
> balancing within these partitions. I would think not having
> load balancing should be one of the options available

Ok ... then is it correct to say that your purpose is to partition
the systems CPUs into subsets, such that for each subset, either
there is a scheduler domain for that exactly the CPUs in that subset,
or none of the CPUs in the subset are in any scheduler domain?

> I must confess that I havent looked at the memory side all that much,
> having more interest in trying to build soft-partitioning of the cpu's

This is an understandable focus of interest.  Just know that one of the
sanity tests I will apply to a solution for CPUs is whether there is a
corresponding solution for Memory Nodes, using much the same principles,
invariants and conventions.

> ok I need to spend more time on you model Paul, but my first
> guess is that it doesn't seem to be very intuitive and seems
> to make it very complex from the users perspective. However as
> I said I need to understand your model a bit more before I
> comment on it

Well ... I can't claim that my approach is simple.  It does have a
clearly defined (well, clear to me ;) mathematical model, with some
invariants that are always preserved in what user space sees, with
atomic operations for changing from one legal state to the next.

The primary invariant is that the sets of CPUs in the cpusets
marked domain_cpu_current form a partition (disjoint covering)
of the CPUs in the system.

What are your invariants, and how can you assure yourself and us
that your code preserves these invariants?

Also, I don't know that the sequence of user operations required
by my interface is that much worse than yours.  Let's take an
example, and compare what the user would have to do.

Let's say we have the following cpusets on our 8 CPU system:

	/		# CPUs 0-7
	/Alpha		# CPUs   0-3
	/Alpha/phi	# CPUs    0-1
	/Alpha/chi	# CPUs    2-3
	/Beta		# CPUs  4-7

Let's say we currently have three scheduler domains, for three isolated
(in your terms) cpusets: /Alpha/phi, /Alpha/chi and /Beta.

Let's say we want to change the configuration to have just two scheduler
domains (two isolated cpusets): /Alpha and /Beta.

A user of my API would do the operations:

	echo 1 > /Alpha/domain_cpu_pending
	echo 1 > /Beta/domain_cpu_pending
	echo 0 > /Alpha/phi/domain_cpu_pending
	echo 0 > /Alpha/chi/domain_cpu_pending
	echo 1 > /domain_cpu_rebuild

The domain_cpu_current state would not change until the final write
(echo) above, at which time the cpuset_sem lock would be taken, and the
system would, atomically to all viewing tasks, change from having the
three cpusets /Alpha/phi, /Alpha/chi and /Beta marked with a true
domain_cpu_current, to having the two cpusets /Alpha and /Beta so
marked.

The alternative API, which I didn't explore, could do this in one step
by writing the new list of cpusets defining the partition, doing the
rough equivalent (need nul separators, not space separators) of:

	echo /Alpha /Beta > /list_cpu_subdomains

How does this play out in your interface?  Are you convinced that
your invariants are preserved at all times, to all users?  Can
you present a convincing argument to others that this is so?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
