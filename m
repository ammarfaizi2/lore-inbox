Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262396AbVBLFtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262396AbVBLFtm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 00:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262392AbVBLFtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 00:49:42 -0500
Received: from gizmo03ps.bigpond.com ([144.140.71.13]:63372 "HELO
	gizmo03ps.bigpond.com") by vger.kernel.org with SMTP
	id S262410AbVBLFs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 00:48:26 -0500
Message-ID: <420D98A3.3060508@bigpond.net.au>
Date: Sat, 12 Feb 2005 16:48:19 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: nagar@watson.ibm.com
CC: ckrm-tech <ckrm-tech@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ckrm-e17
References: <41F92A48.2010100@watson.ibm.com>
In-Reply-To: <41F92A48.2010100@watson.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh Nagar wrote:
> Version e17 of the Class-based Kernel Resource Management
> is now available for download from
> 
> http://sourceforge.net/project/showfiles.php?group_id=85838&package_id=94608 
> 
>     
> The major updates since the previous version include:
> 1. Numerous bugfixes
> 2. Control over rate of process forks through the numtasks controller.
> The rate of forking is a single systemwide parameter affecting all 
> classes. Existing share-based control over total number of forks allowed 
> per class remains the same.
> 3. Interface change: The "target" file has been removed from the RCFS 
> interface. The same functionality can now be obtained by writing to the 
> "members" file of any class.
> 
> Files released:
> 
> ckrm-e17.2610.patch
>     Combined patch against 2.6.10. Includes the numtasks and          
> listenaq controllers.
> e17-incr.tar.bz2
>     Tarball of broken down patches. First 10 patches constitute
>     the e16 release and subsequent ones contain the updates since
>     then.
> cpu.ckrm-e17.v10.patch
>     CPU controller.
> 
> 
> Still to come:
> 
> memory controller
> I/O controller
> test packages
> 
> 
> Please note that updates to CKRM based on the feedback from lkml on
> the previous release (http://lkml.org/lkml/2004/11/29/152) are in 
> progress and will be included in the next release.
> 
> Testing and feedback welcome.

At line 3887 of cpu.ckrm-e17.v10.patch you add the line:

		set_task_cpu(p,this_cpu);

to the middle of the function wake_up_new_task() resulting in the 
following code:

	} else {
		this_rq = cpu_rq(this_cpu);

		/*
		 * Not the local CPU - must adjust timestamp. This should
		 * get optimised away in the !CONFIG_SMP case.
		 */
		p->sdu.ingosched.timestamp = (p->sdu.ingosched.timestamp - 
this_rq->timestamp_last_tick)
					+ rq->timestamp_last_tick;
		set_task_cpu(p,this_cpu);
		__activate_task(p, rq);
		if (TASK_PREEMPTS_CURR(p, rq))
			resched_task(rq->curr);

		schedstat_inc(rq, wunt_moved);
		/*
		 * Parent and child are on different CPUs, now get the
		 * parent runqueue to update the parent's ->sdu.ingosched.sleep_avg:
		 */
		task_rq_unlock(rq, &flags);
		this_rq = task_rq_lock(current, &flags);
	}

where "rq" has been set by the return value of "task_rq_lock(p, 
&flags)", and the test "(cpu == this_cpu)" has failed with "cpu" set to 
"task_cpu(p)".  The result of this when the CKRM CPU code is not 
configured into the build is that "p" will be queued on a runqueue that 
is not in agreement with "p->thread_info->cpu" which in turn will lead 
to future use of "task_rq_lock()" locking the wrong run queue and 
eventually triggering some form of race condition.

If CKRM CPU is configured into the build the results are less drastic as 
they only result in "nr_running" being incremented for the wrong run 
queue.  However, even this will have adverse scheduling effects as it 
will probably confuse the load balancing code.  Another potentially 
confusing thing with this code (when CKRM CPU is configured in) is that 
__activate_task() does NOT queue "p" on "rq" but on the queue found by 
the call "get_task_lrq(p)".

The recommended fix for this problem would be to withdraw the:

		set_task_cpu(p,this_cpu);

Peter
PS I reported this to the ckrm-tech list 5 days ago but it was ignored.
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
