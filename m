Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315463AbSFTRXl>; Thu, 20 Jun 2002 13:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315468AbSFTRXk>; Thu, 20 Jun 2002 13:23:40 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:30101 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S315463AbSFTRXi>; Thu, 20 Jun 2002 13:23:38 -0400
Date: Thu, 20 Jun 2002 12:23:39 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200206201723.MAA04517@tomcat.admin.navo.hpc.mil>
To: pashley@storm.ca, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: McVoy's Clusters (was Re: latest linus-2.5 BK broken)
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sandy Harris <pashley@storm.ca>
> 
> [ I removed half a dozen cc's on this, and am just sending to the
>   list. Do people actually want the cc's?]
> 
> Larry McVoy wrote:
> 
> > > Checkpointing buys three things.  The ability to preempt jobs, the
> > > ability to migrate processes,
> 
> For large multi-processor systems, it isn't clear that those matter
> much. On single user systems I've tried , ps -ax | wc -l usually
> gives some number 50 < n < 100. For a multi-user general purpose
> system, my guess would be something under 50 system processes plus
> 50 per user. So for a dozen to 20 users on a departmental server,
> under 1000. A server for a big application, like database or web,
> would have fewer users and more threads, but still only a few 100
> or at most, say 2000.

You don't use compute servers much? The problems we are currently running
require the cluster (IBM SP) to have 100% uptime for a single job. that
job may run for several days. If a detected problem is reported (not yet
catastrophic) it is desired/demanded to checkpoint the users process.

Currently, we can't - but should be able to by this fall.

Having the users job checkpoint midway in it's computations will allow us
to remove a node from active service, substitute a different node, and
resume the users process without losing many hours of computation (we have
a maximum of 300 nodes for computation, another 30 for I/O and front end).

Just because a network interface fails is no reason to lose the job.

> So at something like 8 CPUs in a personal workstation and 128 or
> 256 for a server, things average out to 8 processes per CPU, and
> it is not clear that process migration or any form of pre-emption
> beyond the usual kernel scheduling is needed.
> 
> What combination of resources and loads do you think preemption
> and migration are need for?

It depends on the job. A web server farm shouldn't need one. A distributed
compute cluster needs it to:

a. be able to suspend large (256-300 nodes), long running (4-8 hours),
   low priority jobs, to favor high priority production jobs (which may
   also be relatively long running: say 2-4 hours on 256 nodes.
b. be able to replace/substitute nodes (switch processing from a failing
   node to allow for on-line replacement of the failing node or to wait for
   spare parts).

> > > and the ability to recover from failed nodes, (assuming the 
> > > failed hardware didn't corrupt your jobs checkpoint).
> 
> That matters, but it isn't entirely clear that it needs to be done
> in the kernel. Things like databases and journalling filesystems
> already have their own mechanisms and it is not remarkably onerous
> to put them into applications where required.

Which is why I realized you don't use compute clusters very often.

1. User jobs, written in fortran/C/other do not usually come with the ability
   to take snapshots of computation.
2. there is the problem of redirecting network connections (MPI/PVM) from one
   place to another.
3. (related to 2) Synchronized process suspension is difficult-to-impossible
   to do outside the kernel.

> [big snip]
> 
> > Larry McVoy's SMP Clusters
> > 
> > Discussion on November 8, 2001
> > 
> > Larry McVoy, Ted T'so, and Paul McKenney
> > 
> > What is SMP Clusters?
> > 
> >      SMP Clusters is a method of partioning an SMP (symmetric
> >      multiprocessing) machine's CPUs, memory, and I/O devices
> >      so that multiple "OSlets" run on this machine.  Each OSlet
> >      owns and controls its partition.  A given partition is
> >      expected to contain from 4-8 CPUs, its share of memory,
> >      and its share of I/O devices.  A machine large enough to
> >      have SMP Clusters profitably applied is expected to have
> >      enough of the standard I/O adapters (e.g., ethernet,
> >      SCSI, FC, etc.) so that each OSlet would have at least
> >      one of each.
> 
> I'm not sure whose definition this is:
>    supercomputer: a device for converting compute-bound problems
>       into I/O-bound problems
> but I suspect it is at least partially correct, and Beowulfs are
> sometimes just devices to convert them to network-bound problems.
> 
> For a network-bound task like web serving, I can see a large
> payoff in having each OSlet doing its own I/O.
> 
> However, in general I fail to see why each OSlet should have
> independent resources rather than something like using one to
> run a shared file system and another to handle the networking
> for everybody.

How about reliability, security isolation (accounting server isolated
from a web server or audit server.. or both).

See Suns use of "domains" in Solaris which does this in a single host.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
