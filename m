Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293337AbSEAKlF>; Wed, 1 May 2002 06:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293510AbSEAKlE>; Wed, 1 May 2002 06:41:04 -0400
Received: from artemis.rus.uni-stuttgart.de ([129.69.1.28]:57227 "EHLO
	artemis.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S293337AbSEAKlD> convert rfc822-to-8bit; Wed, 1 May 2002 06:41:03 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Erich Focht <efocht@ess.nec.de>
To: LSE <lse-tech@lists.sourceforge.net>
Subject: Node Affine NUMA scheduler, updated
Date: Wed, 1 May 2002 12:22:05 +0200
X-Mailer: KMail [version 1.4]
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200205011102.12502.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

an updated patch for the node affine NUMA scheduler extension based on the 
O(1) scheduler can be found at 
http://home.arcor.de/efocht/sched/Nod15_O1-2.4.18.patch

Detailed information on the implementation is at 
http://home.arcor.de/efocht/sched .

What's new:
The topology information has been updated and supports the following ccNUMA 
platforms:
 - IBM NUMA-Q - i386 (thanks to Matt Dobson),
 - SGI SN1/2 - ia64 (thanks to Jesse Barnes),
 - NEC AzusA - ia64
No other i386 platforms have been tested, yet.

The topology info now uses the notions of logical and physical node, also the 
variables are protected by a rw_lock. This was a must for the integration 
with the cpu-hotplug patch.

There are two configuration variables which control the way how the scheduler 
works:
 - CONFIG_NUMA_SCHED : switch on pooling scheduler (otherwise it behaves like 
the O(1) scheduler, though it looks different).
 - CONFIG_NODE_AFFINE_SCHED: tasks remember their homenode and are attracted 
back to it.
For platforms with a big node-level cache it might be better to only configure 
CONFIG_NUMA_SCHED=y and leave CONFIG_NODE_AFFINE_SCHED undefined. This is 
better if the penalty for trashing the node-level cache is bigger than the 
benefit of running on the right node (where the memory is allocated).

I added a variable node_policy to the task structure which is inheritable and 
decides on the initial load balancing. There is a prctl interface to change 
this from userland, a utility called nodpol is available on the web page. The 
possible values for node_policy are:
  0 (default) : select homenode in do_exec(),
  1           : select homenode in do_fork() only if CLONE_VM is unset,
  2           : select homenode in do_fork() (allways).
It's mainly meant for experiments and benchmarks. Some benchmarks (e.g. AIM7, 
which simulates large loads) only fork but don't exec, thus the default 
homenode selection mechanism doesn't apply and the load balance is bad right 
from the start. In real life one should just check whether multithreaded jobs 
need to be distributed across multiple nodes or better take their memory from 
one node and change the node_policy accordingly before starting them. The 
default behavior should be fine otherwise.

On the web page I included some results showing performance increase with the 
node affine scheduler and its functionality. Basically it works fine for 
medium and high loads but has some trouble with low loads. This is due to the 
fact that a task running on a remote node alone on its CPU cannot be stolen 
by CPUs on the homenode. load_balance() is called in such places that the 
only mechanism for moving a currently running task (migration_thread) cannot 
be used. Any ideas (besides a signal) are welcome. The initial load balancing 
is improveable, too, a better measure for load will help.

Thanks in advance for your feedback, I'm especially curious about results for 
the affinity_test on other platforms than NEC AzusA.

Best regards,
Erich
