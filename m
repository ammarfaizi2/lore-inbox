Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751359AbWJWUrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbWJWUrx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 16:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbWJWUrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 16:47:53 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:31115 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751359AbWJWUrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 16:47:52 -0400
Date: Mon, 23 Oct 2006 13:47:30 -0700
From: Paul Jackson <pj@sgi.com>
To: dino@in.ibm.com
Cc: nickpiggin@yahoo.com.au, akpm@osdl.org, mbligh@google.com,
       menage@google.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       rohitseth@google.com, holt@sgi.com, dipankar@in.ibm.com,
       suresh.b.siddha@intel.com
Subject: Re: [RFC] cpuset: add interface to isolated cpus
Message-Id: <20061023134730.62e791a2.pj@sgi.com>
In-Reply-To: <20061023195011.GB1542@in.ibm.com>
References: <20061019092607.17547.68979.sendpatchset@sam.engr.sgi.com>
	<20061020210422.GA29870@in.ibm.com>
	<20061022201824.267525c9.pj@sgi.com>
	<453C4E22.9000308@yahoo.com.au>
	<20061023195011.GB1542@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dinakar wrote:
> This as far as I can tell is the only problem with the current code.
> So I dont see why we need a major rewrite that involves a complete change
> in the approach to the dynamic sched domain implementation.

Nick and I agree that if we can get an adequate automatic partition of
sched domains, without any such explicit 'sched_domain' API, then that
would be better.

Nick keeps hoping we can do this automatically, and I have been fading
in and out of agreement.  I have doubts we can do an automatic
partition that is adequate.

Last night, Nick suggested we could do this by partitioning based on
the cpus_allowed masks of the tasks in the system, instead of based on
selected cpusets in the system.  We could create a partition any place
that didn't cut across some tasks cpus_allowed. This would seem to have
a better chance than basing it on the cpus masks in cpusets - for
example a task in top cpuset that was pinned to a single CPU (many
kernel threads fit this description) would no longer impede
partitioning.

Right now, I am working on a posting that spells out an algorithm
to compute such a partitioning, based on all task cpus_allowed masks
in the system.  I think that's doable.

But I doubt it works.  I afraid it will result in useful partitions
only in the cases we seem to need them least, on systems using cpusets
to nicely carve up a system.

==

Why the heck are we doing this partitioning in the first place?

Putting aside for a moment the specialized needs of the real-time folks
who want to isolate some nodes from any source of jitter, aren't these
sched domain partitions just a workaround for performance issues, that
arise from trying to load balance across big sched domains?

Granted, there may be no better way to address this performance issue.
And granted, it may well be my own employers big honkin NUMA boxes
that are most in need of this, and I just don't realize it.

But could someone whack me upside the head with a clear cut instance
where we know we need this partitioning?

In particular, if (extreme example) I have 1024 threads on a 1024 CPU
system, each compute bound and each pinned to a separate CPU, and
nothing else, then do I still need these sched partitions?  Or does the
scheduler efficiently handle this case, quickly recognizing that it has
no useful balancing work worth doing?

==

As it stands right now, if I had to place my "final answer" in Jeopardy
on this, I'd vote for something like the patch you describe, which I
take it is much like the sched_domain patch with which I started this
scrum a week ago, minus the 'sched_domain_enabled' flag that I had in
for backwards compatibility.  I suspect we agree that we can do without
that flag, and that a single clean long term API outweighs perfect
backward compatibility, in this case.

==

The only twist to your patch I would like you to consider - instead
of a 'sched_domain' flag marking where the partitions go, how about
a flag that tells the kernel it is ok not to load balance tasks in
a cpuset?

Then lower level cpusets could set such a flag, without immediate and
brutal affects on the partitioning of all their parent cpusets.  But if
the big top level non-overlapping cpusets were so marked, then we could
partition all the way down to where we were no longer able to do so,
because we hit a cpuset that didn't have this flag set.

I think such a "ok not to load balance tasks in this cpuset" flag
better fits what the users see here.  They are being asked to let us
turn off some automatic load balancing, in return for which they get
better performance. I doubt that the phrase "dynamic scheduler domain
partitions" is in the vocabulary of most of our users.  More of them
will understand the concept of load balancing automatically moving
tasks to underutilized CPUs, and more of them would be prepared to
make the choice between turning off load balancing in some top cpusets,
and better kernel scheduler performance.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
