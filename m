Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315454AbSFJU6G>; Mon, 10 Jun 2002 16:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316217AbSFJU6F>; Mon, 10 Jun 2002 16:58:05 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:24716 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S316163AbSFJU6D>; Mon, 10 Jun 2002 16:58:03 -0400
Date: Mon, 10 Jun 2002 13:57:34 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: Scheduler Bug (set_cpus_allowed)
Message-ID: <20020610135734.D1565@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <20020607121207.B1532@w-mikek2.des.beaverton.ibm.com> <Pine.LNX.4.44.0206102053310.28876-100000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2002 at 10:12:46PM +0200, Ingo Molnar wrote:
> 
> i agree that this is a subtle issue. My first version of the migration
> code did something like this - it's a natural desire to manually migrate
> the target task (there are various levels of doing this - the very first
> version of the code directly unlinked the thread from the current runqueue
> and linked it into the target runqueue), instead of having to switch to a
> migration-thread.
> 
> the fundamental reason for this fragility is the following: the room to
> move the concept of migration into the O(1) design is very very small, if
> the condition is to not increase the cost of the scheduler fastpath.
> 
> the only robust way i found was to use a highprio helper thread which
> naturally unschedules the current task. Attempts to somehow unschedule a
> to-be-migrated task without having to switch into the helper thread turned
> out to be problematic.
> 

Ingo, I saw your patch to remove the frozen lock from the scheduler
and agree this is the best way to go.  Once this change is made, I
think it is then safe to add a fast path for migration
(to set_cpus_allowed) as:

	/*
	 * If the task is not on a runqueue (and not running), then
	 * it is sufficient to simply update the task's cpu field.
	 */
	if (!p->array && (p != rq->curr)) {
		p->thread_info->cpu = __ffs(p->cpus_allowed);
		task_rq_unlock(rq, &flags);
		goto out;
	}

Would you agree that this is now safe?  My concern is not so
much with the performance of set_cpus_allowed, but rather in
using the same concept to 'move' tasks in this state.

Consider the '__wake_up_sync' functionality that existed in the
old scheduler for pipes.  One result of __wake_up_sync is that
the reader and writer of the pipe were scheduled on the same
CPU.  This seemed to help with pipe bandwidth.  Perhaps we could
add code something like the above to wakeup a task on a specific
CPU.  This could be used in VERY VERY specific cases (such as
blocking reader/writer on pipe) to increase performance.

-- 
Mike
