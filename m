Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311904AbSCOB6M>; Thu, 14 Mar 2002 20:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311908AbSCOB6D>; Thu, 14 Mar 2002 20:58:03 -0500
Received: from artemis.rus.uni-stuttgart.de ([129.69.1.28]:10988 "EHLO
	artemis.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S311904AbSCOB5n>; Thu, 14 Mar 2002 20:57:43 -0500
Date: Fri, 15 Mar 2002 02:57:40 +0100 (MET)
From: Erich Focht <focht@ess.nec.de>
To: Jesse Barnes <jbarnes@sgi.com>
cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Node affine NUMA scheduler
In-Reply-To: <20020314172808.GB138234@sgi.com>
Message-ID: <Pine.LNX.4.21.0203150117230.16174-100000@sx6.ess.nec.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Mar 2002, Jesse Barnes wrote:

> Alright, I'll try running some other numbers too, what can you
> recommend other than aim and kernel compiles?

Hmmm, take any ISV MPI code. I tried StarCD.

You can also try a small test which is sensitive on both memory latency
and bandwidth. The core is an indirect update loop
	for(i=0; i<n; i++)
		a[ix[i]] = a[ix[i]] + b[i];
with random ix[]. This is quite typical for simulations using unstructured
grids. You find it at:
	http://home.arcor.de/efocht/linux/affinity_test.tgz

There are two similar perl scripts included which can be used for
submitting several such processes in parallel and formatting the
output. They are hardwired for 4 nodes (sorry) and need a file describing
the cpu to node assignement. It should contain the node numbers of the
logical CPUs separated by _one_ blank (sorry for the inconvenience, I was
using a patch for accessing this info in /proc...).

Try calling:
time ./disp 8 ./affinity 1000000

This will start 8 copies of ./affinity and collect some statistics about
percentage of time spent on each node, maximum percentage spent on a
node, the node number on which it spent most of the time, the initial
node, the user time. Interesting is also the elapsed time returned by
the "time" command. The output looks like this:

[focht@azusa ~/affinity]> ./dispn 4 ./affinity 1000000
Executing 4 times: ./affinity 1000000 
-----------------------------------------------------------------------
                % Time on Node            Scheduled node               
Job        0       1       2       3       Max  (m , i)      Time (s)  
-----------------------------------------------------------------------
1       100.0     0.0     0.0     0.0   | 100.0 (0 = 0)   |   29.5
2         0.0     0.0     0.0   100.0   | 100.0 (3 = 3)   |   26.5
3       100.0     0.0     0.0     0.0   | 100.0 (0 = 0)   |   29.5
4         0.0   100.0     0.0     0.0   | 100.0 (1 = 1)   |   26.6
-----------------------------------------------------------------------
 Average user time = 28.00 seconds


Normally you should see:
1: on kernels with the old scheduler:
	- for #jobs < #cpus: poor balancing among nodes => bad times due
	to bandwidth limitations
	- for #jobs > #cpus: jobs are hopping from node to node: poor
	latency

2: on kernels with Ingo's scheduler:
	- less hopping across the nodes, but poor balance among nodes
	(case 1).
	- short additional load peaks can shift jobs away from their
	memory to another node, from where they don't have a reason to 
	return.

3: on kernels with Ingo's O(1) + node affine extension:
	- hopefully better balanced nodes (at least in average) for
	#jobs < #cpus therefore better bandwidth available.
	- better latency due to node affinity (though there is a problem
	when a single job is running on a remote node: it can't be taken
	back to the homenode even if that one is empty because a running
	job can't be stolen).

With no memory affinity (but you have it, because of DISCONTIG) timings
are much worse...

> Sounds good, I'll have to update those macros later too (Jack
> reminded me that physical node numbers aren't always the same as
> logical node numbers).

Ah, ok... I'd prefer to use
#define CPU_TO_NODE(i) node_number[i]
The macro SAPICID_TO_NODE() is mainly used to build this one and its speed
doesn't matter. So make it a function, or whatever you need...

Regards,
Erich

PS: I heard that on your big systems you currently have 32 nodes, maybe
that's a better choice for NR_NODES?

