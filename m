Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267376AbRGKRUm>; Wed, 11 Jul 2001 13:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267370AbRGKRUd>; Wed, 11 Jul 2001 13:20:33 -0400
Received: from e22.nc.us.ibm.com ([32.97.136.228]:6807 "EHLO e22.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267371AbRGKRUM>;
	Wed, 11 Jul 2001 13:20:12 -0400
Date: Wed, 11 Jul 2001 10:19:01 -0700
From: Mike Kravetz <mkravetz@sequent.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
        Andrew Morton <andrewm@uow.edu.au>,
        Klaus Dittrich <kladit@t-online.de>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.7p6 hang
Message-ID: <20010711101901.A1349@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <200107110849.f6B8nlm00414@df1tlpc.local.here> <shslmlv62us.fsf@charged.uio.no> <3B4C56F1.3085D698@uow.edu.au> <15180.24844.687421.239488@charged.uio.no> <20010711175809.F3496@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010711175809.F3496@athlon.random>; from andrea@suse.de on Wed, Jul 11, 2001 at 05:58:09PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2001 at 05:58:09PM +0200, Andrea Arcangeli wrote:
> 
> this one I forgot to sumbit but here it is now for easy merging:
> 
> --- 2.4.4aa3/kernel/sched.c.~1~	Sun Apr 29 17:37:05 2001
> +++ 2.4.4aa3/kernel/sched.c	Tue May  1 16:39:42 2001
> @@ -674,8 +674,10 @@
>  #endif
>  	spin_unlock_irq(&runqueue_lock);
>  
> -	if (prev == next)
> +	if (prev == next) {
> +		current->policy &= ~SCHED_YIELD;
>  		goto same_process;
> +	}
>  
>  #ifdef CONFIG_SMP
>   	/*

I would like to second the need for this patch in the 'mainline' kernel.
Not too long ago, I came up with the following senario caused by this
bug.  The scenario is based on the unmodified 2.4.4 scheduler.

- Task A calls sched_yield(), and the code in sys_sched_yield()
  determines that a yield is in order and sets SCHED_YIELD in
  the task's policy field and need_resched is set for this task.

- When Task A attempts to return to user land, schedule() will
  be called (since need_resched was set).  However, in this case
  schedule() does not find a better task than A to run.  Since
  task A will continue to run, the 'same_process' goto is taken
  in schedule().  Note that __schedule_tail() is not called, so
  the SCHED_YIELD flag remains set in A when it continues to
  execute.

- Task A then performs some operation which causes it to go into
  a non-runnable state (such as calling nanosleep()).  After setting
  the state of Task A to something other than TASK_RUNNING, a call
  to schedule() will be made.  At this time Task A will be removed
  from the runqueue (again note that SCHED_YIELD remains set in A).
  Also, assume that there are no other runnable tasks so the idle
  task is chosen to run next on this CPU.

- Now, after schedule() releases the runqueue lock the timer for
  Task A fires and we call the wake_up code.  This code path will
  eventually call try_to_wake_up() which will set the state of A
  to TASK_RUNNING, add A to the runqueue and call reschedule_idle()
  for A.

- Note that we have not yet cleared the has_cpu field in A.  Hence,
  can_schedule() will never be true for task A.  As a result, we
  will not send an IPI to any other CPU.  In effect, reschedule_idle()
  is a noop.

- Now, we finally call __schedule_tail() for task A.  After clearing
  the SCHED_YIELD and has_cpu flags, we notice that the state of A
  is TASK_RUNNING (it was set by try_to_wake_up()) and take the
  needs_resched goto.

- The needs_resched block of code usually results in a call to
  reschedule_idle for the task.  However, the first line of code
  in this block is:

                /*
                 * Avoid taking the runqueue lock in cases where
                 * no preemption-check is necessery:
                 */
                if ((prev == idle_task(smp_processor_id())) ||
                                                (policy & SCHED_YIELD))
                        goto out_unlock;

  Since, the SCHED_YIELD flag was set in A when we entered this routine
  we will not call reschedule_idle().

In this case, the CPU associated with task A is still idle yet we will
not schedule the task on the CPU.  In addition, it is possible that at
this time ALL CPUs in the system could be idle.  Hence, we would end up
with all CPUs idle while task A is on the runqueue.  Not good!

-- 
Mike Kravetz                                 mkravetz@sequent.com
IBM Linux Technology Center
