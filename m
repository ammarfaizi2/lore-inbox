Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262196AbVEMAeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbVEMAeh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 20:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbVEMAe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 20:34:29 -0400
Received: from orb.pobox.com ([207.8.226.5]:47827 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S262179AbVEMAeS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 20:34:18 -0400
Date: Thu, 12 May 2005 19:34:08 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Paul Jackson <pj@sgi.com>
Cc: dino@in.ibm.com, Simon.Derr@bull.net, lse-tech@lists.sourceforge.net,
       akpm@osdl.org, nickpiggin@yahoo.com.au, vatsa@in.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpusets+hotplug+preepmt broken
Message-ID: <20050513003408.GG3614@otto>
References: <20050511191654.GA3916@in.ibm.com> <20050511195156.GE3614@otto> <20050511134235.5cecf85c.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050511134235.5cecf85c.pj@sgi.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> 
> I share you preference for not nesting these semaphores.
> 
> The other choice I am aware of would be for the hotplug code to be less
> cpuset-friendly.  In the move_task_off_dead_cpu() code, at the point it
> says "No more Mr. Nice Guy", instead of looking for the nearest
> enclosing cpuset that has something online, which is what the
> cpuset_cpus_allowed() does, instead we could just take any damn cpu that
> was online.
> 
> Something along the lines of the following fix:
> 
> --- pj/kernel.old/sched.c	2005-05-11 13:00:17.000000000 -0700
> +++ pj/kernel.new/sched.c	2005-05-11 13:02:24.000000000 -0700
> @@ -4229,7 +4229,7 @@ static void move_task_off_dead_cpu(int d
>  
>  	/* No more Mr. Nice Guy. */
>  	if (dest_cpu == NR_CPUS) {
> -		tsk->cpus_allowed = cpuset_cpus_allowed(tsk);
> +		tsk->cpus_allowed = cpu_online_map;
>  		dest_cpu = any_online_cpu(tsk->cpus_allowed);

Well, CPU_MASK_ALL rather than cpu_online_map, I would think.  That is
what the behavior was before the cpuset merge, anyway.  It might be
the best short term solution, more below...

> So what we'd really like to do would be to first fallback to all the
> cpus allowed in the specified tasks cpuset (no walking the cpuset
> hierarchy), and see if any of those cpus are still online to receive
> this orphan task.  Unless someone has botched the system configuration,
> and taken offline all the cpus in a cpuset, this should yield up a cpu
> that is still both allowed and online.  If that fails, then to heck with
> honoring cpuset placement - just take the first online cpu we can find.
> 
> This is doable without holding cpuset_sem.  We can look at a current
> tasks cpuset without cpuset_sem, just with the task lock.

Yes, but your patch doesn't lock the task itself (unless I'm
misreading patches again).  However, have a look at the comments above
task_lock in sched.h:

/*
 * Protects ->fs, ->files, ->mm, ->ptrace, ->group_info, ->comm, keyring
 * subscriptions and synchronises with wait4().  Also used in procfs.
 *
 * Nests both inside and outside of read_lock(&tasklist_lock).
 * It must not be nested with write_lock_irq(&tasklist_lock),
 * neither inside nor outside.
 */
static inline void task_lock(struct task_struct *p)
{
        spin_lock(&p->alloc_lock);
}


Unfortunately, move_task_off_dead_cpu is called from
migrate_live_tasks while the latter has a write_lock_irq on
tasklist_lock.  So we can't use task_lock in this context, assuming
the comments are valid.  Right?


Nathan
