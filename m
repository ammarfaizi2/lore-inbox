Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288419AbSADAWL>; Thu, 3 Jan 2002 19:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288420AbSADAWD>; Thu, 3 Jan 2002 19:22:03 -0500
Received: from mx2.elte.hu ([157.181.151.9]:3973 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S288419AbSADAVw>;
	Thu, 3 Jan 2002 19:21:52 -0500
Date: Fri, 4 Jan 2002 03:19:10 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
Message-ID: <Pine.LNX.4.33.0201040050440.1363-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


now that new-year's parties are over things are getting boring again. For
those who want to see and perhaps even try something more complex, i'm
announcing this patch that is a pretty radical rewrite of the Linux
scheduler for 2.5.2-pre6:

	http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.5.2-A0.patch

for 2.4.17:

	http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.4.17-A0.patch

Goal
====

The main goal of the new scheduler is to keep all the good things we know
and love about the current Linux scheduler:

 - good interactive performance even during high load: if the user
   types or clicks then the system must react instantly and must execute
   the user tasks smoothly, even during considerable background load.

 - good scheduling/wakeup performance with 1-2 runnable processes.

 - fairness: no process should stay without any timeslice for any
   unreasonable amount of time. No process should get an unjustly high
   amount of CPU time.

 - priorities: less important tasks can be started with lower priority,
   more important tasks with higher priority.

 - SMP efficiency: no CPU should stay idle if there is work to do.

 - SMP affinity: processes which run on one CPU should stay affine to
   that CPU. Processes should not bounce between CPUs too frequently.

 - plus additional scheduler features: RT scheduling, CPU binding.

and the goal is also to add a few new things:

 - fully O(1) scheduling. Are you tired of the recalculation loop
   blowing the L1 cache away every now and then? Do you think the goodness
   loop is taking a bit too long to finish if there are lots of runnable
   processes? This new scheduler takes no prisoners: wakeup(), schedule(),
   the timer interrupt are all O(1) algorithms. There is no recalculation
   loop. There is no goodness loop either.

 - 'perfect' SMP scalability. With the new scheduler there is no 'big'
   runqueue_lock anymore - it's all per-CPU runqueues and locks - two
   tasks on two separate CPUs can wake up, schedule and context-switch
   completely in parallel, without any interlocking. All
   scheduling-relevant data is structured for maximum scalability. (see
   the benchmark section later on.)

 - better SMP affinity. The old scheduler has a particular weakness that
   causes the random bouncing of tasks between CPUs if/when higher
   priority/interactive tasks, this was observed and reported by many
   people. The reason is that the timeslice recalculation loop first needs
   every currently running task to consume its timeslice. But when this
   happens on eg. an 8-way system, then this property starves an
   increasing number of CPUs from executing any process. Once the last
   task that has a timeslice left has finished using up that timeslice,
   the recalculation loop is triggered and other CPUs can start executing
   tasks again - after having idled around for a number of timer ticks.
   The more CPUs, the worse this effect.

   Furthermore, this same effect causes the bouncing effect as well:
   whenever there is such a 'timeslice squeeze' of the global runqueue,
   idle processors start executing tasks which are not affine to that CPU.
   (because the affine tasks have finished off their timeslices already.)

   The new scheduler solves this problem by distributing timeslices on a
   per-CPU basis, without having any global synchronization or
   recalculation.

 - batch scheduling. A significant proportion of computing-intensive tasks
   benefit from batch-scheduling, where timeslices are long and processes
   are roundrobin scheduled. The new scheduler does such batch-scheduling
   of the lowest priority tasks - so nice +19 jobs will get
   'batch-scheduled' automatically. With this scheduler, nice +19 jobs are
   in essence SCHED_IDLE, from an interactiveness point of view.

 - handle extreme loads more smoothly, without breakdown and scheduling
   storms.

 - O(1) RT scheduling. For those RT folks who are paranoid about the
   O(nr_running) property of the goodness loop and the recalculation loop.

 - run fork()ed children before the parent. Andrea has pointed out the
   advantages of this a few months ago, but patches for this feature
   do not work with the old scheduler as well as they should,
   because idle processes often steal the new child before the fork()ing
   CPU gets to execute it.


Design
======

(those who find the following design issues boring can skip to the next,
'Benchmarks' section.)

the core of the new scheduler are the following mechanizms:

 - *two*, priority-ordered 'priority arrays' per CPU. There is an 'active'
   array and an 'expired' array. The active array contains all tasks that
   are affine to this CPU and have timeslices left. The expired array
   contains all tasks which have used up their timeslices - but this array
   is kept sorted as well. The active and expired array is not accessed
   directly, it's accessed through two pointers in the per-CPU runqueue
   structure. If all active tasks are used up then we 'switch' the two
   pointers and from now on the ready-to-go (former-) expired array is the
   active array - and the empty active array serves as the new collector
   for expired tasks.

 - there is a 64-bit bitmap cache for array indices. Finding the highest
   priority task is thus a matter of two x86 BSFL bit-search instructions.

the split-array solution enables us to have an arbitrary number of active
and expired tasks, and the recalculation of timeslices can be done
immediately when the timeslice expires. Because the arrays are always
access through the pointers in the runqueue, switching the two arrays can
be done very quickly.

this is a hybride priority-list approach coupled with roundrobin
scheduling and the array-switch method of distributing timeslices.

 - there is a per-task 'load estimator'.

one of the toughest things to get right is good interactive feel during
heavy system load. While playing with various scheduler variants i found
that the best interactive feel is achieved not by 'boosting' interactive
tasks, but by 'punishing' tasks that want to use more CPU time than there
is available. This method is also much easier to do in an O(1) fashion.

to establish the actual 'load' the task contributes to the system, a
complex-looking but pretty accurate method is used: there is a 4-entry
'history' ringbuffer of the task's activities during the last 4 seconds.
This ringbuffer is operated without much overhead. The entries tell the
scheduler a pretty accurate load-history of the task: has it used up more
CPU time or less during the past N seconds. [the size '4' and the interval
of 4x 1 seconds was found by lots of experimentation - this part is
flexible and can be changed in both directions.]

the penalty a task gets for generating more load than the CPU can handle
is a priority decrease - there is a maximum amount to this penalty
relative to their static priority, so even fully CPU-bound tasks will
observe each other's priorities, and will share the CPU accordingly.

I've separated the RT scheduler into a different codebase, while still
keeping some of the scheduling codebase common. This does not look pretty
in certain places such as __sched_tail() or activate_task(), but i dont
think it can be avoided. RT scheduling is different, it uses a global
runqueue (and global spinlock) and it needs global decisions. To make RT
scheduling more instant, i've added a broadcast-reschedule message as
well, to make it absolutely sure that RT tasks of the right priority are
scheduled apropriately, even on SMP systems. The RT-scheduling part is
O(1) as well.

the SMP load-balancer can be extended/switched with additional parallel
computing and cache hierarchy concepts: NUMA scheduling, multi-core CPUs
can be supported easily by changing the load-balancer. Right now it's
tuned for my SMP systems.

i skipped the prev->mm == next->mm advantage - no workload i know of shows
any sensitivity to this. It can be added back by sacrificing O(1)
schedule() [the current and one-lower priority list can be searched for a
that->mm == current->mm condition], but costs a fair number of cycles
during a number of important workloads, so i wanted to avoid this as much
as possible.

- the SMP idle-task startup code was still racy and the new scheduler
triggered this. So i streamlined the idle-setup code a bit. We do not call
into schedule() before all processors have started up fully and all idle
threads are in place.

- the patch also cleans up a number of aspects of sched.c - moves code
into other areas of the kernel where it's appropriate, and simplifies
certain code paths and data constructs. As a result, the new scheduler's
code is smaller than the old one.

(i'm sure there are other details i forgot to explain. I've commented some
of the more important code paths and data constructs. If you think some
aspect of this design is faulty or misses some important issue then please
let me know.)

(the current code is by no means perfect, my main goal right now, besides
fixing bugs is to make the code cleaner. Any suggestions for
simplifications are welcome.)

Benchmarks
==========

i've performed two major groups of benchmarks: first i've verified the
interactive performance (interactive 'feel') of the new scheduler on UP
and SMP systems as well. While this is a pretty subjective thing, i found
that the new scheduler is at least as good as the old one in all areas,
and in a number of high load workloads it feels visibly smoother. I've
tried a number of workloads, such as make -j background compilation or
1000 background processes. Interactive performance can also be verified
via tracing both schedulers, and i've done that and found no areas of
missed wakeups or imperfect SMP scheduling latencies in either of the two
schedulers.

the other group of benchmarks was the actual performance of the scheduler.
I picked the following ones (some were intentionally picked to load the
scheduler, others were picked to make the benchmark spectrum more
complete):

 - compilation benchmarks

 - thr chat-server workload simulator written by Bill Hartner

 - the usual components from the lmbench suite

 - a heavily sched_yield()-ing testcode to measure yield() performance.

 [ i can test any other workload too that anyone would find interesting. ]

i ran these benchmarks on a 1-CPU box using a UP kernel, a 2-CPU and a
8-CPU box as well, using the SMP kernel.

The chat-server simulator creates a number of processes that are connected
to each other via TCP sockets, the processes send messages to each other
randomly, in a way that simulates actual chat server designs and
workloads.

3 successive runs of './chat_c 127.0.0.1 10 1000' produce the following
message throughput:

vanilla-2.5.2-pre6:

 Average throughput : 110619 messages per second
 Average throughput : 107813 messages per second
 Average throughput : 120558 messages per second

O(1)-schedule-2.5.2-pre6:

 Average throughput : 131250 messages per second
 Average throughput : 116333 messages per second
 Average throughput : 179686 messages per second

this is a rougly 20% improvement.

To get all benefits of the new scheduler, i ran it reniced, which in
essence triggers round-robin batch scheduling for the chat server tasks:

3 successive runs of 'nice -n 19 ./chat_c 127.0.0.1 10 1000' produce the
following throughput:

vanilla-2.5.2-pre6:

 Average throughput : 77719 messages per second
 Average throughput : 83460 messages per second
 Average throughput : 90029 messages per second

O(1)-schedule-2.5.2-pre6:

 Average throughput : 609942 messages per second
 Average throughput : 610221 messages per second
 Average throughput : 609570 messages per second

throughput improved by more than 600%. The UP and 2-way SMP tests show a
similar edge for the new scheduler. Furthermore, during these chatserver
tests, the old scheduler doesnt handle interactive tasks very well, and
the system is very jerky. (which is a side-effect of the overscheduling
situation the scheduler gets into.)

the 1-CPU UP numbers are interesting as well:

vanilla-2.5.2-pre6:

 ./chat_c 127.0.0.1 10 100
 Average throughput : 102885 messages per second
 Average throughput : 95319 messages per second
 Average throughput : 99076 messages per second

 nice -n 19 ./chat_c 127.0.0.1 10 1000
 Average throughput : 161205 messages per second
 Average throughput : 151785 messages per second
 Average throughput : 152951 messages per second

O(1)-schedule-2.5.2-pre6:

 ./chat_c 127.0.0.1 10 100 # NEW
 Average throughput : 128865 messages per second
 Average throughput : 115240 messages per second
 Average throughput : 99034 messages per second

 nice -n 19 ./chat_c 127.0.0.1 10 1000 # NEW
 Average throughput : 163112 messages per second
 Average throughput : 163012 messages per second
 Average throughput : 163652 messages per second

this shows that while on UP we dont have the scalability improvements, the
O(1) scheduler is still slightly ahead.


another benchmark measures sched_yield() performance. (which the pthreads
code relies on pretty heavily.)

on a 2-way system, starting 4 instances of ./loop_yield gives the
following context-switch throughput:

vanilla-2.5.2-pre6

  # vmstat 5 | cut -c57-
     system         cpu
   in    cs  us  sy  id
  102 241247   6  94   0
  101 240977   5  95   0
  101 241051   6  94   0
  101 241176   7  93   0

O(1)-schedule-2.5.2-pre6

  # vmstat 5 | cut -c57-
     system         cpu
   in     cs  us  sy  id
  101 977530  31  69   0
  101 977478  28  72   0
  101 977538  27  73   0

the O(1) scheduler is 300% faster, and we do nearly 1 million context
switches per second!

this test is even more interesting on the 8-way system, running 16
instances of loop_yield:

vanilla-2.5.2-pre6:

   vmstat 5 | cut -c57-
      system         cpu
    in     cs  us  sy  id
   106 108498   2  98   0
   101 108333   1  99   0
   102 108437   1  99   0

100K/sec context switches - the overhead of the global runqueue makes the
scheduler slower than the 2-way box!

O(1)-schedule-2.5.2-pre6:

    vmstat 5 | cut -c57-
     system         cpu
    in      cs  us  sy  id
   102 6120358  34  66   0
   101 6117063  33  67   0
   101 6117124  34  66   0

this is more than 6 million context switches per second! (i think this is
a first, no Linux box in existence did so many context switches per second
before.) This is one workload where the per-CPU runqueues and scalability
advantages show up big time.

here are the lat_proc and lat_ctx comparisons (the results quoted here are
the best numbers from a series of tests):

vanilla-2.5.2-pre6:

  ./lat_proc fork
  Process fork+exit: 440.0000 microseconds
  ./lat_proc exec
  Process fork+execve: 491.6364 microseconds
  ./lat_proc shell
  Process fork+/bin/sh -c: 3545.0000 microseconds

O(1)-schedule-2.5.2-pre6:

  ./lat_proc fork
  Process fork+exit: 168.6667 microseconds
  ./lat_proc exec
  Process fork+execve: 279.6500 microseconds
  ./lat_proc shell
  Process fork+/bin/sh -c: 2874.0000 microseconds

the difference is pretty dramatic - it's mostly due to avoiding much of
the COW overhead that comes from fork()+execve(). The fork()+exit()
improvement is mostly due to better CPU affinity - parent and child are
running on the same CPU, while the old scheduler pushes the child to
another, idle CPU, which creates heavy interlocking traffic between the MM
structures.

the compilation benchmarks i ran gave very similar results for both
schedulers. The O(1) scheduler has a small 2% advantage in make -j
benchmarks (not accounting statistical noise - it's hard to produce
reliable compilation benchmarks) - probably due to better SMP affinity
again.

Status
======

i've tested the new scheduler under the aforementioned range of systems
and workloads, but it's still experimental code nevertheless. I've
developed it on SMP systems using the 2.5.2-pre kernels, so it has the
most testing there, but i did a fair number of UP and 2.4.17 tests as
well. NOTE! For the 2.5.2-pre6 kernel to be usable you should apply
Andries' latest 2.5.2pre6-kdev_t patch available at:

	http://www.kernel.org/pub/linux/kernel/people/aeb/

i also tested the RT scheduler for various situations such as
sched_yield()-ing of RT tasks, strace-ing RT tasks and other details, and
it's all working as expected. There might be some rough edges though.

Comments, bug reports, suggestions are welcome,

	Ingo

