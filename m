Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316393AbSETVXm>; Mon, 20 May 2002 17:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316396AbSETVXl>; Mon, 20 May 2002 17:23:41 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:16886 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S316393AbSETVXi>; Mon, 20 May 2002 17:23:38 -0400
Subject: [PATCH] 2.4-ac: more scheduler updates (3/3)
From: Robert Love <rml@tech9.net>
To: Lord Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1021929382.9901.4.camel@sinai>
Content-Type: multipart/mixed; boundary="=-QWcNrlRgXkHeh22NFrqZ"
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 20 May 2002 14:22:51 -0700
Message-Id: <1021929771.9986.9.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-QWcNrlRgXkHeh22NFrqZ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Alan,

This patch adds documentation to Documentation/ about the O(1)
scheduler.  It is unrelated to the previous changes.  I like good docs
and the new scheduler is complicated and could use some explanation, if
nothing else behind the design.

When I get some time, I would like to write up a formal analysis of the
design and implementation myself.  For now, we have:

	Documentation/sched-coding.txt
A short doc I wrote on the various interfaces and magic numbers the
scheduler uses, as well as quick run-down of the locking rules.

	Documentation/sched-design.txt
An edited version of Ingo's original announcement which includes a good
overview of the design and goals of the scheduler.

Patch is against 2.4.19-pre8-ac5, please apply if you like good
documentation :-)

	Robert Love

--=-QWcNrlRgXkHeh22NFrqZ
Content-Disposition: attachment; filename=sched-docs-rml-2.4.19-pre8-ac5-1.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=sched-docs-rml-2.4.19-pre8-ac5-1.patch;
	charset=ISO-8859-1

diff -urN linux-2.4.19-pre8-ac5/Documentation/sched-coding.txt linux/Docume=
ntation/sched-coding.txt
--- linux-2.4.19-pre8-ac5/Documentation/sched-coding.txt	Wed Dec 31 16:00:0=
0 1969
+++ linux/Documentation/sched-coding.txt	Mon May 20 13:57:43 2002
@@ -0,0 +1,126 @@
+     Reference for various scheduler-related methods in the O(1) scheduler
+		Robert Love <rml@tech9.net>, MontaVista Software
+
+
+Note most of these methods are local to kernel/sched.c - this is by design=
.
+The scheduler is meant to be self-contained and abstracted away.  This doc=
ument
+is primarily for understanding the scheduler, not interfacing to it.  Some=
 of
+the discussed interfaces, however, are general process/scheduling methods.
+They are typically defined in include/linux/sched.h.
+
+
+Main Scheduling Methods
+-----------------------
+
+void load_balance(runqueue_t *this_rq, int idle)
+	Attempts to pull tasks from one cpu to another to balance cpu usage,
+	if needed.  This method is called explicitly if the runqueues are
+	inbalanced or periodically by the timer tick.  Prior to calling,
+	the current runqueue must be locked and interrupts disabled.
+
+void schedule()
+	The main scheduling function.  Upon return, the highest priority
+	process will be active.
+
+
+Locking
+-------
+
+Each runqueue has its own lock, rq->lock.  When multiple runqueues need
+to be locked, lock acquires must be ordered by ascending &runqueue value.
+
+A specific runqueue is locked via
+
+	task_rq_lock(task_t pid, unsigned long *flags)
+
+which disables preemption, disables interrupts, and locks the runqueue pid=
 is
+running on.  Likewise,
+
+	task_rq_unlock(task_t pid, unsigned long *flags)
+
+unlocks the runqueue pid is running on, restores interrupts to their previ=
ous
+state, and reenables preemption.
+
+The routines
+
+	double_rq_lock(runqueue_t *rq1, runqueue_t *rq2)
+
+and
+
+	double_rq_unlock(runqueue_t *rq1, runqueue_t rq2)
+
+safely lock and unlock, respectively, the two specified runqueues.  They d=
o
+not, however, disable and restore interrupts.  Users are required to do so
+manually before and after calls.
+
+
+Values
+------
+
+MAX_PRIO
+	The maximum priority of the system, stored in the task as task->prio.
+	Lower priorities are higher.  Normal (non-RT) priorities range from
+	MAX_RT_PRIO to (MAX_PRIO - 1).
+MAX_RT_PRIO
+	The maximum real-time priority of the system.  Valid RT priorities
+	range from 0 to (MAX_RT_PRIO - 1).
+MAX_USER_RT_PRIO
+	The maximum real-time priority that is exported to user-space.  Should
+	always be equal to or less than MAX_RT_PRIO.  Setting it less allows
+	kernel threads to have higher priorities than any user-space task.
+MIN_TIMESLICE
+MAX_TIMESLICE
+	Respectively, the minimum and maximum timeslices (quanta) of a process.
+
+Data
+----
+
+struct runqueue
+	The main per-CPU runqueue data structure.
+struct task_struct
+	The main per-process data structure.
+
+
+General Methods
+---------------
+
+cpu_rq(cpu)
+	Returns the runqueue of the specified cpu.
+this_rq()
+	Returns the runqueue of the current cpu.
+task_rq(pid)
+	Returns the runqueue which holds the specified pid.
+cpu_curr(cpu)
+	Returns the task currently running on the given cpu.
+rt_task(pid)
+	Returns true if pid is real-time, false if not.
+
+
+Process Control Methods
+-----------------------
+
+void set_user_nice(task_t *p, long nice)
+	Sets the "nice" value of task p to the given value.
+int setscheduler(pid_t pid, int policy, struct sched_param *param)
+	Sets the scheduling policy and parameters for the given pid.
+void set_cpus_allowed(task_t *p, unsigned long new_mask)
+	Sets a given task's CPU affinity and migrates it to a proper cpu.
+	Callers must have a valid reference to the task and assure the
+	task not exit prematurely.  No locks can be held during the call.
+set_task_state(tsk, state_value)
+	Sets the given task's state to the given value.
+set_current_state(state_value)
+	Sets the current task's state to the given value.
+void set_tsk_need_resched(struct task_struct *tsk)
+	Sets need_resched in the given task.
+void clear_tsk_need_resched(struct task_struct *tsk)
+	Clears need_resched in the given task.
+void set_need_resched()
+	Sets need_resched in the current task.
+void clear_need_resched()
+	Clears need_resched in the current task.
+int need_resched()
+	Returns true if need_resched is set in the current task, false
+	otherwise.
+yield()
+	Place the current process at the end of the runqueue and call schedule.
diff -urN linux-2.4.19-pre8-ac5/Documentation/sched-design.txt linux/Docume=
ntation/sched-design.txt
--- linux-2.4.19-pre8-ac5/Documentation/sched-design.txt	Wed Dec 31 16:00:0=
0 1969
+++ linux/Documentation/sched-design.txt	Mon May 20 13:57:33 2002
@@ -0,0 +1,165 @@
+		   Goals, Design and Implementation of the
+		      new ultra-scalable O(1) scheduler
+
+
+  This is an edited version of an email Ingo Molnar sent to
+  lkml on 4 Jan 2002.  It describes the goals, design, and
+  implementation of Ingo's new ultra-scalable O(1) scheduler.
+  Last Updated: 18 April 2002.
+
+
+Goal
+=3D=3D=3D=3D
+
+The main goal of the new scheduler is to keep all the good things we know
+and love about the current Linux scheduler:
+
+ - good interactive performance even during high load: if the user
+   types or clicks then the system must react instantly and must execute
+   the user tasks smoothly, even during considerable background load.
+
+ - good scheduling/wakeup performance with 1-2 runnable processes.
+
+ - fairness: no process should stay without any timeslice for any
+   unreasonable amount of time. No process should get an unjustly high
+   amount of CPU time.
+
+ - priorities: less important tasks can be started with lower priority,
+   more important tasks with higher priority.
+
+ - SMP efficiency: no CPU should stay idle if there is work to do.
+
+ - SMP affinity: processes which run on one CPU should stay affine to
+   that CPU. Processes should not bounce between CPUs too frequently.
+
+ - plus additional scheduler features: RT scheduling, CPU binding.
+
+and the goal is also to add a few new things:
+
+ - fully O(1) scheduling. Are you tired of the recalculation loop
+   blowing the L1 cache away every now and then? Do you think the goodness
+   loop is taking a bit too long to finish if there are lots of runnable
+   processes? This new scheduler takes no prisoners: wakeup(), schedule(),
+   the timer interrupt are all O(1) algorithms. There is no recalculation
+   loop. There is no goodness loop either.
+
+ - 'perfect' SMP scalability. With the new scheduler there is no 'big'
+   runqueue_lock anymore - it's all per-CPU runqueues and locks - two
+   tasks on two separate CPUs can wake up, schedule and context-switch
+   completely in parallel, without any interlocking. All
+   scheduling-relevant data is structured for maximum scalability.
+
+ - better SMP affinity. The old scheduler has a particular weakness that
+   causes the random bouncing of tasks between CPUs if/when higher
+   priority/interactive tasks, this was observed and reported by many
+   people. The reason is that the timeslice recalculation loop first needs
+   every currently running task to consume its timeslice. But when this
+   happens on eg. an 8-way system, then this property starves an
+   increasing number of CPUs from executing any process. Once the last
+   task that has a timeslice left has finished using up that timeslice,
+   the recalculation loop is triggered and other CPUs can start executing
+   tasks again - after having idled around for a number of timer ticks.
+   The more CPUs, the worse this effect.
+
+   Furthermore, this same effect causes the bouncing effect as well:
+   whenever there is such a 'timeslice squeeze' of the global runqueue,
+   idle processors start executing tasks which are not affine to that CPU.
+   (because the affine tasks have finished off their timeslices already.)
+
+   The new scheduler solves this problem by distributing timeslices on a
+   per-CPU basis, without having any global synchronization or
+   recalculation.
+
+ - batch scheduling. A significant proportion of computing-intensive tasks
+   benefit from batch-scheduling, where timeslices are long and processes
+   are roundrobin scheduled. The new scheduler does such batch-scheduling
+   of the lowest priority tasks - so nice +19 jobs will get
+   'batch-scheduled' automatically. With this scheduler, nice +19 jobs are
+   in essence SCHED_IDLE, from an interactiveness point of view.
+
+ - handle extreme loads more smoothly, without breakdown and scheduling
+   storms.
+
+ - O(1) RT scheduling. For those RT folks who are paranoid about the
+   O(nr_running) property of the goodness loop and the recalculation loop.
+
+ - run fork()ed children before the parent. Andrea has pointed out the
+   advantages of this a few months ago, but patches for this feature
+   do not work with the old scheduler as well as they should,
+   because idle processes often steal the new child before the fork()ing
+   CPU gets to execute it.
+
+
+Design
+=3D=3D=3D=3D=3D=3D
+
+the core of the new scheduler are the following mechanizms:
+
+ - *two*, priority-ordered 'priority arrays' per CPU. There is an 'active'
+   array and an 'expired' array. The active array contains all tasks that
+   are affine to this CPU and have timeslices left. The expired array
+   contains all tasks which have used up their timeslices - but this array
+   is kept sorted as well. The active and expired array is not accessed
+   directly, it's accessed through two pointers in the per-CPU runqueue
+   structure. If all active tasks are used up then we 'switch' the two
+   pointers and from now on the ready-to-go (former-) expired array is the
+   active array - and the empty active array serves as the new collector
+   for expired tasks.
+
+ - there is a 64-bit bitmap cache for array indices. Finding the highest
+   priority task is thus a matter of two x86 BSFL bit-search instructions.
+
+the split-array solution enables us to have an arbitrary number of active
+and expired tasks, and the recalculation of timeslices can be done
+immediately when the timeslice expires. Because the arrays are always
+access through the pointers in the runqueue, switching the two arrays can
+be done very quickly.
+
+this is a hybride priority-list approach coupled with roundrobin
+scheduling and the array-switch method of distributing timeslices.
+
+ - there is a per-task 'load estimator'.
+
+one of the toughest things to get right is good interactive feel during
+heavy system load. While playing with various scheduler variants i found
+that the best interactive feel is achieved not by 'boosting' interactive
+tasks, but by 'punishing' tasks that want to use more CPU time than there
+is available. This method is also much easier to do in an O(1) fashion.
+
+to establish the actual 'load' the task contributes to the system, a
+complex-looking but pretty accurate method is used: there is a 4-entry
+'history' ringbuffer of the task's activities during the last 4 seconds.
+This ringbuffer is operated without much overhead. The entries tell the
+scheduler a pretty accurate load-history of the task: has it used up more
+CPU time or less during the past N seconds. [the size '4' and the interval
+of 4x 1 seconds was found by lots of experimentation - this part is
+flexible and can be changed in both directions.]
+
+the penalty a task gets for generating more load than the CPU can handle
+is a priority decrease - there is a maximum amount to this penalty
+relative to their static priority, so even fully CPU-bound tasks will
+observe each other's priorities, and will share the CPU accordingly.
+
+the SMP load-balancer can be extended/switched with additional parallel
+computing and cache hierarchy concepts: NUMA scheduling, multi-core CPUs
+can be supported easily by changing the load-balancer. Right now it's
+tuned for my SMP systems.
+
+i skipped the prev->mm =3D=3D next->mm advantage - no workload i know of s=
hows
+any sensitivity to this. It can be added back by sacrificing O(1)
+schedule() [the current and one-lower priority list can be searched for a
+that->mm =3D=3D current->mm condition], but costs a fair number of cycles
+during a number of important workloads, so i wanted to avoid this as much
+as possible.
+
+- the SMP idle-task startup code was still racy and the new scheduler
+triggered this. So i streamlined the idle-setup code a bit. We do not call
+into schedule() before all processors have started up fully and all idle
+threads are in place.
+
+- the patch also cleans up a number of aspects of sched.c - moves code
+into other areas of the kernel where it's appropriate, and simplifies
+certain code paths and data constructs. As a result, the new scheduler's
+code is smaller than the old one.
+
+	Ingo

--=-QWcNrlRgXkHeh22NFrqZ--

