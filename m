Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266143AbUHRMXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266143AbUHRMXF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 08:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266129AbUHRMXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 08:23:05 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:2494 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S266143AbUHRMWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 08:22:25 -0400
Date: Wed, 18 Aug 2004 14:22:20 +0200 (DFT)
From: Simon Derr <Simon.Derr@bull.net>
X-X-Sender: derrs@isabelle.frec.bull.fr
To: linux-kernel@vger.kernel.org
cc: simon chez Bull <simon.derr@bull.net>
Subject: sched_setaffinity() and load balancing
Message-ID: <Pine.A41.4.53.0408181338030.20680@isabelle.frec.bull.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

This is probably a known issue, or even maybe the expected behaviour, but
it seems that using sched_setaffinity() can severely disturb load
balancing on recent kernels. My tests are with 2.6.8-rc3 but I suppose
other kernel versions behave the same way.

All this happens on a 16-way (4 numa nodes of 4 cpu) ia64 system.

At timer ticks, load balancing between the CPUs is done by pulling tasks
from the busiest CPU onto less loaded CPUs. But if these tasks have been
bound on a specific CPU with sched_setaffinity(), they can't be moved, and
the result is that load balancing is somewhat disabled, at least inside
this sched_domain.

Example:
Bind current shell on CPU 0

$ ./bind $$ 0

Run ten loops on CPU 0:
floop10 forks 9 times (so 10 tasks) and then loops.

$ ./floop10

Run 4 loops from another shell:

# ./floop4

The expected behaviour would be: 10 'floop10' tasks on cpu 0, and 4
'floop4' tasks running each on a different CPU.

But instead we see:

Cpu(s): 12.5% us,  0.0% sy,  0.0% ni, 87.4% id,  0.0% wa,  0.0% hi,  0.0% si

  PID USER      PR  NI S %CPU #C Command
12692 root      25   0 R 26.9  2 floop4
12691 root      25   0 R 25.8  2 floop4
12689 root      25   0 R 23.8  2 floop4
12690 root      25   0 R 23.5  2 floop4
 2384 derr      25   0 R 10.1  0 floop10
 2385 derr      25   0 R 10.1  0 floop10
 2386 derr      25   0 R 10.1  0 floop10
 2387 derr      25   0 R 10.1  0 floop10
 2389 derr      25   0 R 10.1  0 floop10
 2390 derr      25   0 R 10.1  0 floop10
 2391 derr      25   0 R 10.1  0 floop10
 2392 derr      25   0 R 10.1  0 floop10
 2393 derr      25   0 R 10.1  0 floop10
 2388 derr      25   0 R  9.3  0 floop10
 2446 derr      16   0 R  0.7  4 top


The damage is limited to the sched_domain of CPU 0, to which belongs CPU
2. If by chance 'floop4' is launched from say, CPU 5, then it will be
properly balanced on 4 CPUs.

Now one can argue that in the real world this is not really an issue since
most apps will call exec() after fork() and be balanced at this point.

Indeed:

Here fexecloop4foo forks 4 tasks and then each task will exec() once, and
then loop.

$ ./fexecloop4foo

Cpu(s): 37.5% us,  0.0% sy,  0.0% ni, 62.4% id,  0.0% wa,  0.0% hi,  0.0% si

  PID USER      PR  NI S %CPU #C Command
12761 derr      25   0 R 99.9  3 fexecloop4
12764 derr      25   0 R 99.9  5 fexecloop4
12763 derr      25   0 R 99.9  6 fexecloop4
12762 derr      25   0 R 99.9  1 fexecloop4
12689 root      25   0 R 26.9  2 floop4
12690 root      25   0 R 25.4  2 floop4
12692 root      25   0 R 24.2  2 floop4
12691 root      25   0 R 23.5  2 floop4
 2384 derr      25   0 R 10.1  0 floop10
 2385 derr      25   0 R 10.1  0 floop10
 2386 derr      25   0 R 10.1  0 floop10
 2387 derr      25   0 R 10.1  0 floop10
 2388 derr      25   0 R 10.1  0 floop10
 2390 derr      25   0 R 10.1  0 floop10
 2391 derr      25   0 R 10.1  0 floop10
 2392 derr      25   0 R 10.1  0 floop10
 2393 derr      25   0 R 10.1  0 floop10
 2389 derr      25   0 R  9.3  0 floop10
 2446 derr      16   0 R  0.7  4 top

Apparently fexecloop4 started on CPU 3, inside the same sched_domain as
CPU 0, and was properly balanced anyway.

Of course this "screenshot" is not a proof, but the problematic behaviour
of floop4 could not be reproduced with fexecloop4.

At least, not as easily.

Let's see:

# ./bind $$ 0
# ./floop10

Other shell:

$ ./fexecloop15

We wait a bit, we have 10 "floop10" on CPU0, one fexecloop15 on each of
the other CPUs. Good. Then, on another shell:

$ ./fexecloop4

Cpu(s): 100.0% us,  0.0% sy,  0.0% ni,  0.0% id,  0.0% wa,  0.0% hi,  0.0% si

  PID USER      PR  NI S %CPU #C Command
13358 derr      25   0 R 99.9 15 fexecloop15
13357 derr      25   0 R 99.9 14 fexecloop15
13356 derr      25   0 R 99.9 13 fexecloop15
13355 derr      25   0 R 99.9 12 fexecloop15
13354 derr      25   0 R 99.9 11 fexecloop15
13353 derr      25   0 R 99.9 10 fexecloop15
13352 derr      25   0 R 99.9  9 fexecloop15
13351 derr      25   0 R 99.9  8 fexecloop15
13350 derr      25   0 R 99.2  7 fexecloop15
13344 derr      25   0 R 99.9  6 fexecloop15
13348 derr      25   0 R 99.9  5 fexecloop15
13349 derr      25   0 R 99.9  4 fexecloop15
13347 derr      25   0 R 99.9  3 fexecloop15
13346 derr      25   0 R 20.1  2 fexecloop15
13425 derr      25   0 R 20.1  2 fexecloop4
13426 derr      25   0 R 20.1  2 fexecloop4
13427 derr      25   0 R 20.1  2 fexecloop4
13428 derr      25   0 R 19.4  2 fexecloop4
13345 derr      25   0 R 99.9  1 fexecloop15
13325 root      25   0 R 10.1  0 floop10
13326 root      25   0 R 10.1  0 floop10
13327 root      25   0 R 10.1  0 floop10
13328 root      25   0 R  9.4  0 floop10
13329 root      25   0 R 10.1  0 floop10
13330 root      25   0 R 10.1  0 floop10
13331 root      25   0 R 10.1  0 floop10
13332 root      25   0 R 10.1  0 floop10
13333 root      25   0 R 10.1  0 floop10

You can see that all four fexecloop4 tasks remain on CPU 2, and are not
properly balanced onto others CPUs.

I tried to understand what happens here, but I'm no scheduler guru.

I found that in sched_balance_exec(), the fexecloop4 tasks decide to
choose another less loaded CPU than 2, say CPU 1. Then they ask the
migration thread (on CPU 2) to move them, and sleep on
wait_for_completion(). The migration thread sees that these tasks are not
running, and only calls set_task_cpu(), and then it will call
try_to_wake_up() on these tasks through complete().

Now it seems that try_to_wake_up() decides that since these tasks are
cache-cold, they can stay on the current CPU (i.e CPU 2) and ignores the
CPU change made earlier by set_task_cpu(). So balancing on exec mostly
fails, and since load balancing during timer ticks is somewhat disabled by
the tasks 'floop10', the 'fexecloop4' stay on CPU 2 forever.


I'm not sure all this has any severity at all, but it seemed to me to be
pretty interesting stuff.

	Simon.


