Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276249AbRJGJ6I>; Sun, 7 Oct 2001 05:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276247AbRJGJ55>; Sun, 7 Oct 2001 05:57:57 -0400
Received: from cs181196.pp.htv.fi ([213.243.181.196]:22915 "EHLO
	cs181196.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S276249AbRJGJ5p>; Sun, 7 Oct 2001 05:57:45 -0400
Message-ID: <3BC02709.A8E6F999@welho.com>
Date: Sun, 07 Oct 2001 12:57:29 +0300
From: Mika Liljeberg <Mika.Liljeberg@welho.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Benjamin LaHaise <bcrl@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Context switch times
In-Reply-To: <E15pWfR-0006g5-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> This isnt idle speculation - I've done some minimal playing with this but
> my initial re-implementation didnt handle SMP at all and I am still not 100%
> sure how to resolve SMP or how SMP will improve out of the current cunning
> plan.

Here's some idle speculation on SMP to top it off. :) I tend to think
that the load balancing between CPUs should be a completely separate
algorithim and should not necessarily be run at every schedule(). The
idea is to compeletely decouple the problem of scheduling a single CPU
between tasks and the problem of load balancing between the CPUs, making
each problem simpler to solve.

Consider the following basic rules:

A) When a new task comes along, pick the "least loaded" CPU and lock the
new task onto that.
B) Whenever the load imbalance between least loaded CPU and most loaded
CPU becomes too great, move one or more tasks from most loaded CPU to
the least loaded CPU.

The rules themselves should be self-explanatory: A provides initial load
balancing, while B tries to keep the balance (with a sensible hysteresis
to avoid thrashing). However, there are a few minor details to solve:

1) How to determine the load of a CPU? If we can quantify this clearly,
we can easily set a hysteresis level to trigger load balancing between
two CPUs.
2) When and how often to check for load imbalance?
3) How to select the task(s) that should be moved between two CPUs to
correct an imbalance?

For problems 1 and 2 I propose the following solution: Insert the the
load balancing routine itself as a (fake) task on each CPU and run it
when the CPU gets around to it. The load balancer should behave almost
like a CPU-bound task, scheduled on the lowest priority level with other
runnable tasks. The last bit is important: the load balancer should not
be allowed to starve but should be invoked approximately once every
"full rotation" of the scheduler.

With the above it is easy to estimate the load of a CPU. We can simply
use the elapsed time between two invokations of the load balancer task.
When the load balancer task of a particular CPU gets run, it chalks up
the elapsed time on a score board somewhere, and checks whether there is
a significant imbalance between itself and some other CPU. If there is,
it commences to move some tasks between itself and the other CPU (note
rule B, though, it should be enough to mess with just two CPU queues at
a time to minimize balancing and locking overhead).

Problem 3 is tricky. Basically, there should be a cost/benefit function
F(tasks to move) that should be minimized. Ideally F(task_i), the
cost/benefit of moving a single task, would be calculated as a byproduct
of the CPU scheduler algorithm. 

F(task_i) might be function of elapsed time since task_i was last
scheduled and the average time slice used by task_i, to account for the
probable cache hit. This would leave it up to the load balancer to move
as many lowest cost tasks to a new CPU as is needed to correct the
imbalance (average time slices used by each task would be needed in
order to make this decision).

Naturally, some additional rules might be necessary to make a task
eligible for moving, e.g., never move the only/last CPU bound task to
another CPU. In addition, it might actually make sense to move at most
one task at each invocation of the load balancer, to further reduce the
probability of thrashing. The load would still converge fairly quickly
towards a balanced state. It would also scale fairly well with the
number of CPUs.

How does that sound?

	MikaL
