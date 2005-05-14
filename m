Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262751AbVENMOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262751AbVENMOq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 08:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262750AbVENMOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 08:14:46 -0400
Received: from orb.pobox.com ([207.8.226.5]:5257 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S262753AbVENMOn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 08:14:43 -0400
Date: Sat, 14 May 2005 07:14:34 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Paul Jackson <pj@sgi.com>
Cc: dino@in.ibm.com, Simon.Derr@bull.net, lse-tech@lists.sourceforge.net,
       akpm@osdl.org, nickpiggin@yahoo.com.au, vatsa@in.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpusets+hotplug+preepmt broken
Message-ID: <20050514121434.GK3614@otto>
References: <20050511191654.GA3916@in.ibm.com> <20050511195156.GE3614@otto> <20050511134235.5cecf85c.pj@sgi.com> <20050511135850.3df60a9f.pj@sgi.com> <20050513192331.2244ada9.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050513192331.2244ada9.pj@sgi.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> 
> Ah to heck with it.  This subtle distinction over what level of cpuset
> we fall back to when a hot unplug leaves a task with no online cpuset in
> its current allowed set is not worth it.
> 
> Every variation I consider is either sufficiently complicated that I
> can't be sure it's right, or sufficiently simple that it's obviously
> broken.

Heh, I feel your pain.

> diff -Naurp 2.6.12-rc1-mm4.orig/kernel/sched.c 2.6.12-rc1-mm4/kernel/sched.c
> --- 2.6.12-rc1-mm4.orig/kernel/sched.c	2005-05-13 18:39:54.000000000 -0700
> +++ 2.6.12-rc1-mm4/kernel/sched.c	2005-05-13 19:02:49.000000000 -0700
> @@ -4301,7 +4301,8 @@ static void move_task_off_dead_cpu(int d
>  
>  	/* No more Mr. Nice Guy. */
>  	if (dest_cpu == NR_CPUS) {
> -		tsk->cpus_allowed = cpuset_cpus_allowed(tsk);
> +		cpus_setall(tsk->cpus_allowed);
> +		tsk->cpuset = &top_cpuset;

Hmm, tsk->cpuset will break the build if !CONFIG_CPUSETS, no?  Plus,
the task's original cpuset->count will be unbalanced and it will never
be released, methinks.

As a short-term (i.e. 2.6.12) solution, would it be terrible to set
tsk->cpus_allowed to the default value without messing with the
cpuset?  That is, is it Bad for a task's cpus_allowed to be a superset
of its cpuset's cpus_allowed?  I ran Dinakar's test on 2.6.12-rc4 +
this proposed "fix" on ppc64 without any crashes or warnings, but I
would need you to confirm that this doesn't violate some fundamental
cpuset constraint.

However, I think making a best effort to honor the task's cpuset is a
reasonable goal in this context.  But it will require some nontrivial
changes to the code for migrating tasks off the dead cpu, as well as
some changes to the cpuset code.  Not 2.6.12 material.

I'll patch soon.

Nathan
