Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261599AbULNSAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbULNSAV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 13:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbULNSAC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 13:00:02 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:46731 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261583AbULNRxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 12:53:22 -0500
Date: Tue, 14 Dec 2004 11:53:13 -0600
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
cc: linux-ia64@vger.kernel.org, ak@suse.de
Subject: [PATCH 0/3] NUMA boot hash allocation interleaving
Message-ID: <Pine.SGI.4.61.0412141140030.22462@kzerza.americas.sgi.com>
Organization: "Silicon Graphics, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NUMA systems running current Linux kernels suffer from substantial
inequities in the amount of memory allocated from each NUMA node
during boot.  In particular, several large hashes are allocated
using alloc_bootmem, and as such are allocated contiguously from
a single node each.

This becomes a problem for certain workloads that are relatively common
on big-iron HPC NUMA systems.  In particular, a number of MPI and OpenMP
applications which require nearly all available processors in the system
and nearly all the memory on each node run into difficulties.  Due to the
uneven memory distribution onto a few nodes, any thread on those nodes will
require a portion of its memory be allocated from remote nodes.  Any
access to those memory locations will be slower than local accesses,
and thereby slows down the effective computation rate for the affected
CPUs/threads.  This problem is further amplified if the application is
tightly synchronized between threads (as is often the case), as they entire
job can run only at the speed of the slowest thread.

Additionally since these hashes are usually accessed by all CPUS in the
system, the NUMA network link on the node which hosts the hash experiences
disproportionate traffic levels, thereby reducing the memory bandwidth
available to that node's CPUs, and further penalizing performance of the
threads executed thereupon.

As such, it is desired to find a way to distribute these large hash
allocations more evenly across NUMA nodes.  Fortunately current
kernels do perform allocation interleaving for vmalloc() during boot,
which provides a stepping stone to a solution.

This series of patches enables (but does not require) the kernel to
allocate several boot time hashes using vmalloc rather than alloc_bootmem,
thereby causing the hashes to be interleaved amongst NUMA nodes.  In
particular the dentry cache, inode cache, TCP ehash, and TCP bhash have been
changed to be allocated in this manner.  Due to the limited vmalloc space
on architectures such as i386, this behavior is turned on by default only
for IA64 NUMA systems (though there is no reason other interested
architectures could not enable it if desired).  Non-IA64 and non-NUMA
systems continue to use the existing alloc_bootmem() allocation mechanism.
A boot line parameter "hashdist" can be set to override the default
behavior.

The following two sets of example output show the uneven distribution
just after boot, using init=/bin/sh to eliminate as much non-kernel
allocation as possible.

Without the boot hash distribution patches:

 Nid  MemTotal   MemFree   MemUsed      (in kB)
   0   3870656   3697696    172960
   1   3882992   3866656     16336
   2   3883008   3866784     16224
   3   3882992   3866464     16528
   4   3883008   3866592     16416
   5   3883008   3866720     16288
   6   3882992   3342176    540816
   7   3883008   3865440     17568
   8   3882992   3866560     16432
   9   3883008   3866400     16608
  10   3882992   3866592     16400
  11   3883008   3866400     16608
  12   3882992   3866400     16592
  13   3883008   3866432     16576
  14   3883008   3866528     16480
  15   3864768   3848256     16512
 ToT  62097440  61152096    945344

Notice that nodes 0 and 6 have a substantially larger memory utilization
than all other nodes.

With the boot hash distribution patch:

 Nid  MemTotal   MemFree   MemUsed      (in kB)
   0   3870656   3789792     80864
   1   3882992   3843776     39216
   2   3883008   3843808     39200
   3   3882992   3843904     39088
   4   3883008   3827488     55520
   5   3883008   3843712     39296
   6   3882992   3843936     39056
   7   3883008   3844096     38912
   8   3882992   3843712     39280
   9   3883008   3844000     39008
  10   3882992   3843872     39120
  11   3883008   3843872     39136
  12   3882992   3843808     39184
  13   3883008   3843936     39072
  14   3883008   3843712     39296
  15   3864768   3825760     39008
 ToT  62097440  61413184    684256

While not perfectly even, we can see that there is a substantial
improvement in the spread of memory allocated by the kernel during
boot.  The remaining uneveness may be due in part to further boot
time allocations that could be addressed in a similar manner, but
some difference is due to the somewhat special nature of node 0
during boot.  However the uneveness has fallen to a much more
acceptable level (at least to a level that SGI isn't concerned about).

The astute reader will also notice that in this example, with this patch
approximately 256 MB less memory was allocated during boot.  This is due
to the size limits of a single vmalloc.  More specifically, this is because
the automatically computed size of the TCP ehash exceeds the maximum
size which a single vmalloc can accomodate.  However this is of little
practical concern as the vmalloc size limit simply reduces one ridiculously
large allocation (512MB) to a slightly less ridiculously large allocation
(256MB).  In practice machines with large memory configurations are using
the thash_entries setting to limit the size of the TCP ehash _much_ lower
than either of the automatically computed values.  Illustrative of the
exceedingly large nature of the automatically computed size, SGI
currently recommends that customers boot with thash_entries=2097152,
which works out to a 32MB allocation.  In any case, setting hashdist=0
will allow for allocations in excess of vmalloc limits, if so desired.

Other than the vmalloc limit, great care was taken to ensure that the
size of TCP hash allocations was not altered by this patch.  Due to
slightly different computation techniques between the existing TCP code
and alloc_large_system_hash (which is now utilized), some of the magic
constants in the TCP hash allocation code were changed.  On all sizes
of system (128MB through 64GB) that I had access to, the patched code
preserves the previous hash size, as long as the vmalloc limit
(256MB on IA64) is not encountered.

There was concern that changing the TCP-related hashes to use vmalloc
space may adversely impact network performance.  To this end the netperf
set of benchmarks was run.  Some individual tests seemed to benefit
slightly, some seemed to be harmed slightly, but in all cases the average
difference with and without these patches was well within the variabilty
I would see from run to run.

The following is the overall netperf averages (30 10 second runs each)
against an older kernel with these same patches. These tests were run
over loopback as GigE results were so inconsistent run to run both with
and without these patches that they provided no meaningful comparison that
I could discern.  I used the same kernel (IA64 generic) for each run,
simply varying the new "hashdist" boot parameter to turn on or off the new
allocation behavior.  In all cases the thash_entries value was manually
specified as discussed previously to eliminate any variability that
might result from that size difference.

HP ZX1, hashdist=0
==================
TCP_RR = 19389
TCP_MAERTS = 6561 
TCP_STREAM = 6590 
TCP_CC = 9483 
TCP_CRR = 8633 

HP ZX1, hashdist=1
==================
TCP_RR = 19411
TCP_MAERTS = 6559 
TCP_STREAM = 6584 
TCP_CC = 9454 
TCP_CRR = 8626 

SGI Altix, hashdist=0
=====================
TCP_RR = 16871
TCP_MAERTS = 3925 
TCP_STREAM = 4055 
TCP_CC = 8438 
TCP_CRR = 7750 

SGI Altix, hashdist=1
=====================
TCP_RR = 17040
TCP_MAERTS = 3913 
TCP_STREAM = 4044 
TCP_CC = 8367 
TCP_CRR = 7538 

I believe the TCP_CC and TCP_CRR are the tests most sensitive to this
particular change.  But again, I want to emphasize that even the
differences you see above are _well_ within the variability I saw
from run to run of any given test.

-- 
Brent Casavant                          If you had nothing to fear,
bcasavan@sgi.com                        how then could you be brave?
Silicon Graphics, Inc.                    -- Queen Dama, Source Wars
