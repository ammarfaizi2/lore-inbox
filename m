Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWATIgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWATIgf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 03:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbWATIgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 03:36:35 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:41165 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750733AbWATIge (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 03:36:34 -0500
Date: Fri, 20 Jan 2006 09:36:51 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Brent Casavant <bcasavan@sgi.com>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, jes@sgi.com,
       tony.luck@intel.com
Subject: Re: [PATCH] SN2 user-MMIO CPU migration
Message-ID: <20060120083651.GA3970@elte.hu>
References: <20060118163305.Y42462@chenjesu.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060118163305.Y42462@chenjesu.americas.sgi.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Brent Casavant <bcasavan@sgi.com> wrote:

> --- a/kernel/sched.c
> +++ b/kernel/sched.c
> @@ -291,6 +291,9 @@ for (domain = rcu_dereference(cpu_rq(cpu
>  #ifndef finish_arch_switch
>  # define finish_arch_switch(prev)	do { } while (0)
>  #endif
> +#ifndef arch_task_migrate
> +# define arch_task_migrate(task)	do { } while (0)
> +#endif

>  	if (!p->array && !task_running(rq, p)) {
> +		arch_task_migrate(p);
>  		set_task_cpu(p, dest_cpu);

>  	if (new_cpu != cpu) {
> +		arch_task_migrate(p);
>  		set_task_cpu(p, new_cpu);

>  	dec_nr_running(p, src_rq);
> +	arch_task_migrate(p);
>  	set_task_cpu(p, this_cpu);

> +	arch_task_migrate(p);
>  	set_task_cpu(p, dest_cpu);

hm, why isnt the synchronization done in switch_to()? Your arch-level 
switch_to() could have something like thread->last_cpu_sync, and if 
thread->last_cpu_sync != this_cpu, do the flush. This would not only 
keep this stuff out of the generic scheduler, but it would also optimize 
things a bit more: the moment we do a set_task_cpu() it does not mean 
that CPU _will_ run the task. Another CPU could grab that task later on.  
So we should delay such IO-synchronization to the last possible moment: 
when we know that we've hit a new CPU on which we havent done a flush 
yet. For same-CPU context switches there wouldnt be any extra 
synchronization, because thread->last_cpu_sync == this_cpu.

	Ingo
