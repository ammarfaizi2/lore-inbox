Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261869AbVGZPT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbVGZPT6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 11:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbVGZPKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 11:10:32 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:39324 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261880AbVGZPJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 11:09:14 -0400
Date: Tue, 26 Jul 2005 10:08:51 -0500
From: Dean Nelson <dcn@sgi.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: torvalds@osdl.org, akpm@osdl.org, mingo@elte.hu, dcn@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix (again) MAX_USER_RT_PRIO and MAX_RT_PRIO (was: MAX_USER_RT_PRIO and MAX_RT_PRIO are wrong!)
Message-ID: <20050726150851.GA3609@sgi.com>
References: <1122323319.4895.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122323319.4895.3.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve, your change to XPC looks good. Thanks, Dean

Signed-off-by: Dean Nelson <dcn@sgi.com>


On Mon, Jul 25, 2005 at 04:28:39PM -0400, Steven Rostedt wrote:
> Dean,
> 
> I've CC you since it also has the change to
> linux-2.6.13-rc3/arch/ia64/sn/kernel/xpc_main.c in it. But I don't see
> this in -mm.  I don't have a ia64 so I can't test it. You tested this
> for me before, so it should still work. This part should be at least
> acknowledged by you.
> 
> -- Steve
> 
> PS. I'm currently running this patched kernel with MAX_RT_USER set to 95
> and MAX_RT_PRIO set to 100 on an SMP machine.
> 
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> 
> --- linux-2.6.13-rc3/kernel/sched.c.orig	2005-07-25 10:16:31.000000000 -0400
> +++ linux-2.6.13-rc3/kernel/sched.c	2005-07-25 10:23:35.000000000 -0400
> @@ -3486,7 +3486,7 @@ static void __setscheduler(struct task_s
>  	p->policy = policy;
>  	p->rt_priority = prio;
>  	if (policy != SCHED_NORMAL)
> -		p->prio = MAX_USER_RT_PRIO-1 - p->rt_priority;
> +		p->prio = MAX_RT_PRIO-1 - p->rt_priority;
>  	else
>  		p->prio = p->static_prio;
>  }
> @@ -3518,7 +3518,8 @@ recheck:
>  	 * 1..MAX_USER_RT_PRIO-1, valid priority for SCHED_NORMAL is 0.
>  	 */
>  	if (param->sched_priority < 0 ||
> -	    param->sched_priority > MAX_USER_RT_PRIO-1)
> +	    (p->mm &&  param->sched_priority > MAX_USER_RT_PRIO-1) ||
> +	    (!p->mm && param->sched_priority > MAX_RT_PRIO-1))
>  		return -EINVAL;
>  	if ((policy == SCHED_NORMAL) != (param->sched_priority == 0))
>  		return -EINVAL;
> --- linux-2.6.13-rc3/arch/ia64/sn/kernel/xpc_main.c.orig	2005-07-25 10:23:22.000000000 -0400
> +++ linux-2.6.13-rc3/arch/ia64/sn/kernel/xpc_main.c	2005-07-25 10:23:35.000000000 -0400
> @@ -420,7 +420,7 @@ xpc_activating(void *__partid)
>  	partid_t partid = (u64) __partid;
>  	struct xpc_partition *part = &xpc_partitions[partid];
>  	unsigned long irq_flags;
> -	struct sched_param param = { sched_priority: MAX_USER_RT_PRIO - 1 };
> +	struct sched_param param = { sched_priority: MAX_RT_PRIO - 1 };
>  	int ret;
>  
> 
> 
