Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266017AbRGLPdD>; Thu, 12 Jul 2001 11:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265994AbRGLPcy>; Thu, 12 Jul 2001 11:32:54 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:26784 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S266017AbRGLPcf>; Thu, 12 Jul 2001 11:32:35 -0400
Date: Thu, 12 Jul 2001 10:32:30 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200107121532.KAA52989@tomcat.admin.navo.hpc.mil>
To: ralf@uni-koblenz.de, Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Subject: Re: Switching Kernels without Rebooting?
Cc: Andreas Dilger <adilger@turbolinux.com>, "C. Slater" <cslater@wcnet.org>,
        linux-kernel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------

> 
> On Thu, Jul 12, 2001 at 07:23:06AM -0500, Jesse Pollard wrote:
> 
> > That isn't even the same problem.
> 
> Sure - the original problem is hard to solve so I suggest to cheat a bit :)
> 
> > First, processes do not survive the upgrade.
> 
> You care about services to continue or only want an entry for an uptime
> contest?

Yes to the first, no to the second.

Processes need to continue if it takes days to arrive at a solution. If
the system DOES need to go down, then the process needs to be checkpointed.
After the outage, the process is resumed.

This is NOT easy. The last system that did it reliably (in the systems
I work with) is UNICOS 7. It did not try to save processes that had open
network connections (even NFS) or pipes. Between  UNICOS 7-10, it was
attempted to include pipes and sockets, provided both ends of the communication
were controlled by the same host (socket to a local daemon, both processes
in the pipe within the same batch job). This didn't work (well, partly worked:
pipes seem to work, but sockets didn't). During this time more and more
processes failed on restart, unless they were contrained to only single
process events. Cluster systems - no chance. It seems impossible to force
a synchronous checkpoint across a cluster (well - theoretically possible).

The problem was that it may take 10-20 minutes to checkpoint a single process.
During that time the corresponding process on another node approaches the
checkpoint location, and fails due to a network timeout. Distributed batch
job dies.

I've seen some processes (single process now) take over a half an hour
to checkpoint (120 MWword (64bit words) = 960 MB being written to disk.
First it has to stop the process syncronously with all file activity (might
take 5 minutes for all buffers to complete). Then the kernel saves the active
process memory (the 960MB - 5-10 minutes), then all outstanding I/O buffers and status 
structures (scatter/gather, reformat, write - might take another 5 minutes)
During the entire time, the system would be doing other I/O for other processes
not being checkpointed (daemons, interactive logins, etc). When the process
reached 4-8GB in size, stopping a batch stream could take over an hour.

During the outage, drivers could be updated, scheduling parameters altered,
hardware fixes like raid disk replacements or cpu, just low level activity.
Anything that affected the file structure (ie changing dates, relocated
files, renamed files...) would cause the checkpointed process to fail to
restart.

The restart procedure had to allocate memory for I/O buffers (cache buffers),
reload them, reload the process private structures, verify that files remained
consistant with parameters in the private structures, reset file pointer
locations for any open files, reload pipe buffers. Then repeat for the
process at the other end of the pipe. After all pipes and processes are
reloaded (without any consistency errors) all processes involved would
be entered in the run queue

The architecture of the Cray YMP systems simplified a LOT of the activity.
1. The hardware did NOT support paging..
2. All data structures were contigeous in memory (excluding only the cache
   buffers for pipes, and disk.
3. All data structures contained only offset location (relative to the
   physical address of the process private data structure). The process
   memory ALWAYS followed the process private data structure.
4. Buffer cache pointers were independant of the user process, only the
   queue identifiers were needed in the process private space, not pointers
   to the queue.

Note: a process that was swapped out was really swapped out (all memory). It
looked like (from the documentation) it was a slightly simplified form of
a checkpoint file.

None of this applies to other Cray hardware (T3, SV1). The SV1 is most
similar to the YMP line, but because of the more "cluster" operations
I'm less familar with how the checkpoint/restart works across the SV1.

The uptime contest is still lost because the system DID go down.

Process checkpoint/restart has been advertised for SGI IRIX systems,
but I've not seen it (first release didn't work if files were open).

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
