Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267306AbUJBGKc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267306AbUJBGKc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 02:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267312AbUJBGKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 02:10:32 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:53448 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267306AbUJBGKF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 02:10:05 -0400
Date: Fri, 1 Oct 2004 23:06:44 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: nagar@watson.ibm.com, ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       mbligh@aracnet.com, lse-tech@lists.sourceforge.net, hch@infradead.org,
       steiner@sgi.com, jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com, efocht@hpce.nec.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-Id: <20041001230644.39b551af.pj@sgi.com>
In-Reply-To: <20041001164118.45b75e17.akpm@osdl.org>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	<20040805190500.3c8fb361.pj@sgi.com>
	<247790000.1091762644@[10.10.2.4]>
	<200408061730.06175.efocht@hpce.nec.com>
	<20040806231013.2b6c44df.pj@sgi.com>
	<411685D6.5040405@watson.ibm.com>
	<20041001164118.45b75e17.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Adding Erich Focht <efocht@hpce.nec.com>]

Are cpusets a special case of CKRM?

Andrew raises (again) the question - can CKRM meet the needs
which cpusets is trying to meet, enabling CKRM to subsume
cpusets?

  Step 1 - Why cpusets?
  Step 2 - Can CKRM do that?

Basically - cpusets implements dynamic soft partitioning to 
provide jobs with sets of isolated CPUs and Memory Nodes.

The following begins Step 1, describing who has or is expected
to use cpusets, and what I understand of their requirements
for cpusets.

Cpuset Users
============

The users of cpusets want to run jobs in relative isolation, by
dividing the system into dynamically adjustable (w/o rebooting)
subsets of compute resources (dedicated CPUs and Memory Nodes),
and run one or sometimes several jobs within a given subset.

Many such users, if they push this model far enough, tend toward
using a batch manager, aka workload manager, such as OpenPBS
or LSF.

So the actual people who scream (gently) at me the most if I
miss something in cpusets for SGI are (or have been, on 2.4
kernels and/or Irix):

  1) The PBS and LSF folks porting their workload
     managers on top of cpusets, and

  2) the SGI support engineers supporting customers
     of our biggest configurations running high value
     HPC applications.
     
  3) Cpusets are also used by various graphics, storage and
     soft-realtime projects to obtain dedicated or precisely
     placed compute resources.

The other declared potential users of cpusets, Bull and NEC at
least, seem from what I can tell to have a somewhat different
focus, toward providing a mix of compute services with minimum
interference, from what I'd guess are more departmental size
systems.

Bull (Simon) and NEC (Erich) should also look closely at CKRM,
and then try to describe their requirements, so we can understand
whether CKRM, cpusets or both or neither can meet their needs.

If I've forgotten any other likely users of cpusets who are
lurking out there, I hope they will speak up and describe how
they expect to use cpusets, what they require, and whether
they find that CKRM would also meet their needs, or why not.

I will try to work with the folks in PBS and LSF a bit, to see
if I can get a simple statement of their essential needs that
would be useful to the CKRM folks.  I'll begin taking a stab
at it, below.

CKRM folks - what would be the best presentation of CKRM that
I could point the PBS/LSF folks at?

  It's usually easier for users to determine if something will
  meet their needs if they can see and understand it.  Trying to
  do requirements analysis to drive design choices with no
  feedback loop is crazy.
  
    They'll know it when they see it, not a day sooner ;)
 
  If some essential capability is missing, they might not
  articulate that capability at all, until someone tries to
  push a "solution" on them that is missing that capability.

Cpuset Requirements
===================

The three primary requirements that the SGI support engineers
on our biggest configurations keep telling me are most important
are:
  1) isolation,
  2) isolation, and
  3) isolation.  
A big HPC job running on a dedicated set of CPUs and Memory Nodes
should not lose any CPU cycles or Memory pages to outsiders.

Both the batch managers and the HPC shops need to be able to
guarantee exclusive use of some set of CPUS and Memory to a job.

The batch managers need to be able to efficiently list
the process id's of all tasks currently attached to a set.
By default, set membership should be inherited across fork and
exec, but batch managers need to be able to move tasks between
sets without regard to the process creation hierarchy.

A job running in a cpuset should be able to use various configuration,
resource management (CKRM for example), cpu and memory (numa) affinity
tools, performance analysis and thread management facilities within a
set, including pthreads and MPI, independently from what is happening
on the rest of the system.

One should be able to run a stock 3rd party app (Oracle is
the canonical example) on a system side-by-side with a special
customer app, each in their own set, neither interfering with
the other, and the Oracle folks happy that their app is running
in a supported environment.

And of course, a cpuset needs to be able to be setup and torn
down without impacting the rest of the system, and then its
CPU and Memory resources put back in the free pool, to be
reallocated in different configurations for other cpusets.

The batch or workload manager folks want to be hibernate and
migrate jobs, so that they can move long running jobs around to
get higher priority jobs through, and so that they can sensibly
over commit without thrashing.  And they want to be able to
add and remove CPU and Memory resources to an existing cpuset,
which might appear to jobs currently executing within that
cpuset as resources going on and offline.

The HPC apps folks need to control some kernel memory
allocations, swapping, classic Unix daemons and kernel threads
along cpuset lines as well.  When the kernel page cache is
many times larger than the memory on a single node, leaving
placement up to willy-nilly kernel decisions can totally blow
out a nodes memory, which is deadly to the performance of
the job using that node.  Similarly, one job can interfere
with another if it abuses the swapper. Kernel threads that
don't require specific placement, as well as the classic Unix
daemons both need to be kept off the CPUs and Memory Nodes
used for the main applications, typically by confining them to
their own small cpuset.

The graphics, realtime and storage folks in particular need
to place their cpusets on very specific CPUs and Memory Nodes
near some piece of hardware of interest to them.  The pool
of CPUs and Memory Nodes is not homogeneous to these folks.
If not all CPUs are the same speed, or not all Memory Nodes
the same size, then CPUs and Memory Nodes are not homogeneous
to the HPC folks either.  And in any case, big numa machines
have complex bus topologies, which the system admins or batch
managers have to take into account when deciding which CPUs
and Memory Nodes to put together into a cpuset.

There must not be any presumption that composition of cpusets
is done on a per-node basis, with all the CPUs and Memory on
a node the unit of allocation.  While this is often the case,
sometimes other combinations of CPUs and Memory Nodes are needed,
not along node boundaries.

For the larger configurations, I am beginning to see requests
for hierarchical "soft partitions" reflecting typically the
complex coorperate or government organization that purchased
the big system, and needs to share it amongst different,
semi-uncooperative groups and subgroups.  I anticipate that
SGI will see more of this over the next few years, but I will
(reluctantly) admit that a hierarchy of some fixed depth of
two or three could meet the current needs as I hear them.

Even the flat model (no hierarchy) uses require some way to
name and control access to cpusets, with distinct permissions
for examining, attaching to, and changing them, that can be
used and managed on a system wide basis.

At least Bull has a requirement to automatically remove a
cpuset when the last user of it exits - which the current
implementation in Andrew's tree provides by calling out to a
user level program on the last release.  User level code can
handle the actual removal.

Bull also has a requirement for the kernel to provide
cpuset-relative numbering of CPUs and Memory Nodes to some
applications, so that they can be run oblivious to the fact
that they don't own the entire machine.  This requirement is
not satisfied by the current implementation in Andrew's tree -
Simon has a separate patch for that.

Cpusets needs to be able to interoperate with hotplug, which
can be a bit of challenge, given the tendency of cpuset code
to stash its own view of the current system CPU/Memory
configuration.

The essential implementation hooks required by cpusets follow from
their essential purpose.  Cpusets control on which CPUs a task may
be scheduled, and on which Memory Nodes it may allocate memory. 
Therefore hooks are required in the scheduler and allocator, which
constrain scheduling and allocation to only use the allowed CPUs
and Memory Nodes.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
