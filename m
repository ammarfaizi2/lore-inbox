Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261572AbSJURe4>; Mon, 21 Oct 2002 13:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261583AbSJURez>; Mon, 21 Oct 2002 13:34:55 -0400
Received: from fmr03.intel.com ([143.183.121.5]:22773 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP
	id <S261572AbSJURej>; Mon, 21 Oct 2002 13:34:39 -0400
Message-Id: <200210211740.g9LHeeP01777@unix-os.sc.intel.com>
Content-Type: text/plain; charset=US-ASCII
From: mgross <mgross@unix-os.sc.intel.com>
Reply-To: mgross@unix-os.sc.intel.com
Organization: SSG Intel
To: eranian@hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: how to force a task out in SMP?
Date: Mon, 21 Oct 2002 10:44:11 -0400
X-Mailer: KMail [version 1.3.1]
References: <20021018155046.H30560@frankl.hpl.hp.com>
In-Reply-To: <20021018155046.H30560@frankl.hpl.hp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 October 2002 06:50 pm, Stephane Eranian wrote:
> Hi,
>
> I am developing a kernel performance monitoring (perfmon) subsystem in
> Linux/ia64 and I need to access the perfmon state of another task that
> is *possibly* running at the same time in a SMP configurations. Unlike
> debuggers, I don't want to change the behavior of the task. For instance,
> if it was blocked, then it must stay blocked, i.e., no EINTR.
>
> I have looked in the lkml archives and found that some people have had
> to deal with the same problem when trying to dump core in a multithreaded
> applications. While their goal is different, what they need is similar.
>
> What we want: "a mechanism to force a task out of the CPU, if it is
> running, which also ensures that it will not be scheduled again  until we
> tell it to do so".

The semaphore lock problem has been a killer for my "pantom runqueue" 
approach.  While you have said process forced off the CPU's (put onto the 
pantom queue, or even cpus_allowed == 0 for 2.4) If your code grabs a 
semaphore indirectly or directly, then you will have the opportunity to 
deadlock.  Now this can only happen IF this lock is one that the suspended 
process may have been holding or in line to hold.  

(If you can get in and out of the code you could be OK, but if your design 
needs to take time or do some type of synchronization you have a challenge.)

This being said, Ingo's method for suspending processes for the current 
multithreaded core dumpper is to add synchronization on exit for the thread 
group, and has the dumping thread sig-kill all the other threads and sleeps 
on the synchronization object.  It works, and is a nice way to look at the 
problem for crashing user space code.  Further it fixes the race condition I 
had with threads in the thread group exiting before the suspending code could 
get hit.

You're problem sounds like it needs the brutish approach I was trying to make 
work.  I spent a number of weeks trying to figure out an LKM acceptable way 
to get something like that to work.  I think one could work around some of 
this sadness I had depending on the requirements.

Transparent process suspending has one sticky requirement.
*) suspended processes must not NOT hold or be waiting on any semaphore locks.

How to do this is hard. 

However; we do know the following assertions are true, (actually they are 
equivalent)
1) If the process is in the run state and NOT current on any CPU, then it 
does NOT hold any lock. 
2) Processes can NOT hold any lock in user space.  


Some basic kernel plumbing needed to make this work are either of the 
following things:
1) A semaphore counter for tasks with a call back that gets hit when the last 
semaphore dropped by the task, if registered.  (I'd like to see this approach 
explored myself)

2) Change entry.S ret_from_intr / resume_userspace to do the deed based on a 
flag in the task structure.  (SCHED_BATCH does this)


The following are some ideas I've thought about:  (I like #3 , myself ;)

1) One could mimic/extend the SCHED_BATCH work done earlier this summer, and 
create a SCHED_PHANTOM policy.
2) You could only move tasks that are in the RUN state to the phantom queue, 
and poll for those that aren't in the run state. 
3) Using the TBD semaphore task counter, you could only move tasks that are 
not holding a lock to the phantom queue, and use the TBD semaphore released 
callback that gets hit when a process drops its last semaphore lock to do the 
migration to the phantom queue.
4) Lets not forget the Suspend to Swap's refrigerator design.  Its 
implementation is all over the code base, but its likely a good option.


>
> There has been several iterations of the multithreaded core dump patch,
> some for 2.4 and some for 2.5. They used the following techniques:
>
> For 2.4:
> 	1/ cpus_allowed
>
> 	stop   : force task->cpus_allowed=0, task->need_resched=1 and force a
> 	         reschedule. Then wait until task leaves cpu.
> 	restart: restablish a good task->cpus_allowed and force a resched.
>
> For 2.5 several versions exist:
>
> 	1/ SIGSTOP/SIGCONT
>
> 	stop   : send SIGSTOP to the other task, wait until it leaves the CPU
> 	restart: send SIGCONT.
>
> 	2/ Phantom runqueue
>
> 	add a runqueue not associated with any CPU (NR_CPUS+1).
> 	stop   : move task to phantom runqueue
> 	restart: move back to valid queue.
>
>
> The cpus_allowed is clearly a hack which is not possible in 2.5 (see
> set_cpus_allowed()).
>
> The SIGSTOP/SIGCONT technique is not that good because it is visible to the
> program and possibly others. For instance, your shell gets notified if the
> task is stopped (if was launched from it). Then the job control gets
> confused.
>
> The shadow runqueue seems interesting but I am wondering if it could not be
> implemented with no extra queue. All that is needed is to get the task out
> of the queue it is on and then put it back into a queue when we're done.
> I am no expert in the scheduler code but it seems to have internal routines
> to do just that (deactivate_task() and activate_task()). I wonder if those
> could be used (if made visible outside of sched.c), however I can believe
> that they are called in a specific context and that it may be difficult to
> export them.

You need some way of handling tasks sleeping on I/O (or a semaphore ;) at the 
time your are suspending them.  They will get activated on you, but yes I 
think you could only deactivate_task / activate_task running tasks, this 
could work for you. 

If they aren't on a runqueue, they could be put on one after their I/O 
completes and calls activate_task for you at any time.

If you are worried about loosing CPU affinity, you could save off the cpu the 
process was migrated from, and put it back onto that one when its time to 
resume.

>
> My question is then what is the right way of implementing this in 2.5?

I don't believe anyone can answer this other than offer ideas you could try 
and then you give them a go, post your patch, and see if its sticks or see of 
someone picks up some of your work.

--mgross
