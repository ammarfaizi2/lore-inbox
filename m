Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266228AbUFPJzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266228AbUFPJzK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 05:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266227AbUFPJzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 05:55:10 -0400
Received: from holomorphy.com ([207.189.100.168]:51372 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266229AbUFPJzB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 05:55:01 -0400
Date: Wed, 16 Jun 2004 02:54:59 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Zoltan Menyhart <Zoltan.Menyhart_AT_bull.net@nospam.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Scheduler questions
Message-ID: <20040616095459.GE1444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zoltan Menyhart <Zoltan.Menyhart_AT_bull.net@nospam.org>,
	linux-kernel@vger.kernel.org
References: <40C090DE.55A6C699@nospam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40C090DE.55A6C699@nospam.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2004 at 05:10:22PM +0200, Zoltan Menyhart wrote:
> I'd like to understand which task structure elements are protected by
> which locks (as far as scheduling is concerned). Is there somewhere a
> paper summarizing the mutual exclusion rules ?
> Let's take some code e.g. from the 2.6.5 kernel:
> set_cpus_allowed(task_t *p, cpumask_t new_mask):
> 
> 	rq = task_rq_lock(p, &flags)
> 	__set_cpus_allowed(p, new_mask, &req):
> 
> 		p->cpus_allowed = new_mask
> 		/*
> 		 * If the task is not on a runqueue (and not running), then
> 		 * it is sufficient to simply update the task's cpu field.
> 		 */
> 		if (!p->array && !task_running(rq, p))
> 			set_task_cpu(p, any_online_cpu(p->cpus_allowed))
> 		/* ... */
> 
> 	task_rq_unlock(rq, &flags)

Okay.

On Fri, Jun 04, 2004 at 05:10:22PM +0200, Zoltan Menyhart wrote:
> Apparently, the "p->cpus_allowed" and the "p->thread_info->cpu" fields
> are protected by the "(&per_cpu(runqueues, (p->thread_info->cpu)))->lock".
> Which are the other task structure elements protected by the same lock ?
> Let's take an example:

Yes. ->cpus_allowed is protected by rq->lock. Do not look at the midget
behind the curtain for what protects ->cpus_allowed of a sleeping task.


On Fri, Jun 04, 2004 at 05:10:22PM +0200, Zoltan Menyhart wrote:
> - I've got a sleeping task that ran on the CPU #3 previously
> - I want to set its CPU mask equal to {1, 2}
> - I take the lock of the run queue #3
> - I do set the CPU mask of the task
> - It's not running (BTW when can happen that "p->array" is NULL and the
>   task is still running ?)
> - I do set the task's CPU e.g. equal to 2. As a consequence, the task
>   falls out of the protection provided by the lock of the run queue #3.
> - Someone else deciding to play with the same task, s/he takes the
>   lock of the run queue #2 !!!
> - Me, I have not arrived yet to the unlock. There are stuffs to do before.
> - Both of us think to have the exclusive access right to the task...
> Can someone explain me, please, why I have to take a run queue lock
> to protect a not running task, and why we do not use "proc_lock"
> instead ?

You looked at the midget behind the curtain. Anyway, rq->lock is just
reused based on the sleeping task's cpu affinity.

->array == NULL while a task is running should not happen apart from
a dequeueing in progress. ->array should be protected by
per_cpu(runqueues, task_cpu(task)).lock.

Scheduler-private fields of tasks are considered to be under the
protection of per_cpu(runqueues, task_cpu(task)).lock until someone
succeeds in a double runqueue lock acquisition and moves the task
between two cpus, or as an optimization, to reset task->thread_info->cpu
under its current rq->lock without holding the target's lock if it's not
queued anywhere.

There is some retry logic in task_rq_lock() to make sure the cpu and
the runqueue are consistent that resolves the remainder of the cases.


-- wli
