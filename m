Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311486AbSCNC65>; Wed, 13 Mar 2002 21:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311485AbSCNC6s>; Wed, 13 Mar 2002 21:58:48 -0500
Received: from rj.sgi.com ([204.94.215.100]:17856 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S311486AbSCNC63>;
	Wed, 13 Mar 2002 21:58:29 -0500
Date: Wed, 13 Mar 2002 18:58:18 -0800
From: Jesse Barnes <jbarnes@sgi.com>
To: Erich Focht <efocht@ess.nec.de>
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Node affine NUMA scheduler
Message-ID: <20020314025818.GA136486@sgi.com>
Mail-Followup-To: Erich Focht <efocht@ess.nec.de>, lse-tech@lists.sf.net,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0203131948140.8009-100000@sx6.ess.nec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0203131948140.8009-100000@sx6.ess.nec.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I ran hackbench on a 16 way system with the new version of your patch,
here are the results:

#	vanilla		ingo		ingo+erich_numa
--	-------		----		---------------
1	0.476		0.224		0.320
10	6.503		1.467		1.591
20	14.497		2.811		2.776
30	23.806		4.000		4.016
40	34.472		5.036		5.251
50	48.402		6.552		6.494
60	59.656		7.861		8.032
70	75.220		9.762		9.564
80	87.675		10.791		10.669
90	106.264		15.429		13.697
100	123.883		17.212		15.814

I only did one run for each kernel.  Do these numbers compare to what
you're getting?  The macros for SN boxes are as follows (if I got them
correct), maybe you could include them in your next patch?

/*
 * SGI SN1 specific macros
 */
#elif defined(CONFIG_IA64_SGI_SN1)
#define NR_NODES 4
#define CPU_TO_NODE(cpu) ((cpu_physical_id(cpu) >> 8) & 0xff)
#define SAPICID_TO_NODE(hwid) ((hwid >> 8) & 0xff)
/*
 * SGI SN2 specific macros
 */
#elif defined(CONFIG_IA64_SGI_SN2)
#define NR_NODES 2
#define CPU_TO_NODE(cpu) ((cpu_physical_id(cpu) >> 12) & 0xff)
#define SAPICID_TO_NODE(hwid) ((hwid >> 12) & 0xff)


Thanks,
Jesse

On Wed, Mar 13, 2002 at 09:10:07PM +0100, Erich Focht wrote:
> Hi,
> 
> here is an update of the NUMA scheduler I'm playing with. It is built on
> top of Ingo's O(1) scheduler, the patch is for the IA-64 port of the 
> latest 2.4.17 version of the O(1) scheduler which I posted to the LSE
> mailing list. Once again, please don't regard this as a finished solution,
> it is more a discussion basis.
> 
> Here is a description of the background and the implementation.
> 
> This scheduler extension is targeted to cc-NUMA machines with CPUs grouped
> in multiple nodes, each node having its own memory. Accessing the memory
> of a remote node implies taking penalties in memory access latency and
> bandwidth. Therefore it is desirable to keep processes on or near the node
> on which their memory (or most of it) is allocated. Fixing the
> cpus_allowed mask of tasks to a particular nodes would of course be a
> solution but experiments show that for loads >100% this leads to poorer
> performance (due to bad load balancing). In this approach I assign each
> task a homenode on which its memory will be allocated (different patch
> needed) and the scheduler will try to keep the task on its homenode or
> attract it to it.
> 
> - CPUs are grouped in pools or nodes, the topology is described in the
> macro CPU_TO_NODE and architecture/platform dependent.
> 
> - Each task_structure has an additional variable called node.
> 
> - The homenode of a task (and its initial CPU) is chosen in do_execve(). I
> switched to this kind of initial balancing instead of do_fork() after some
> discussions. For some cases (multithreaded tasks) this is not always
> optimal and will require some additional treatment.
> 
> - The load_balance routine is changed as follows:
>     - Tries to balance the load inside the own node when invoked
>     (i.e. each tick on idle cpus, every 250ms on busy cpus). This is the
>     same behavior as Ingo's design, but restricted to the nearest CPUs
>     (the node).
> 
>     - If the local node is balanced, finds the most loaded node and its
>     most loaded CPU. 
>         - If the local node's load is below the machines average load,
>         tries to steal a task immediately from the most loaded CPU.
>         - If the local node load is (within some margins) same as the
>         machine's average load, remebers the most loaded node and waits
>         100ms before trying to steal a task. As all idle CPUs are racing
>         for getting a task from the most loaded node, this gives us a
>         chance to get better balance between nodes.
> 
>     - Tasks not running on their homenode are treated preferrentially by
>     the CPUs belonging to the homenode. The load seen by a CPU is
>     "subjective" because the tasks originating from its node are counted
>     twice. This is basically the force attracting the tasks back to their
>     homenode.
> 
> - I kept Ingo's timings and margins for balancing:
>     - 1ms or 1 tick for idle cpus, 250ms for busy cpus,
>     - >= 25% load imbalance necessary.
> 
> The patch is tested on a 16 CPU Itanium server (NEC AzusA) and I've seen
> gains of 10-80% in performance, depending on the load. I'd be curious to
> hear whether anybody else is working on node affinity and/or has
> ideas/comments...
> 
> Best regards,
> Erich
