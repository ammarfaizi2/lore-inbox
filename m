Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261783AbVCGXiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbVCGXiY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 18:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbVCGXg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 18:36:29 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:26287 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261771AbVCGXBm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 18:01:42 -0500
Message-ID: <422CDD48.10006@austin.ibm.com>
Date: Mon, 07 Mar 2005 17:01:28 -0600
From: Joel Schopp <jschopp@austin.ibm.com>
Reply-To: jschopp@austin.ibm.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nathan Lynch <ntl@pobox.com>
CC: Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linuxppc64-dev@ozlabs.org, zwane@arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] explicitly bind idle tasks
References: <Pine.LNX.4.61.0502010009010.3010@montezuma.fsmlabs.com> <20050227031655.67233bb5.akpm@osdl.org> <1109542971.14993.217.camel@gaston> <20050227144928.6c71adaf.akpm@osdl.org> <20050302014701.GA5897@otto>
In-Reply-To: <20050302014701.GA5897@otto>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Lynch wrote:

> With hotplug cpu and preempt, we tend to see smp_processor_id warnings
> from idle loop code because it's always checking whether its cpu has
> gone offline.  Replacing every use of smp_processor_id with
> _smp_processor_id in all idle loop code is one solution; another way
> is explicitly binding idle threads to their cpus (the smp_processor_id
> warning does not fire if the caller is bound only to the calling cpu).
> This has the (admittedly slight) advantage of letting us know if an
> idle thread ever runs on the wrong cpu.

I also prefer explicitly binding idle threads to their cpus instead of 
replacing use of smp_processor_id with _smp_processor_id.

> 
> 
> Signed-off-by: Nathan Lynch <ntl@pobox.com>

Acked-by: Joel Schopp <jschopp@austin.ibm.com>

> 
> Index: linux-2.6.11-rc5-mm1/init/main.c
> ===================================================================
> --- linux-2.6.11-rc5-mm1.orig/init/main.c	2005-03-02 00:12:07.000000000 +0000
> +++ linux-2.6.11-rc5-mm1/init/main.c	2005-03-02 00:53:04.000000000 +0000
> @@ -638,6 +638,10 @@
>  {
>  	lock_kernel();
>  	/*
> +	 * init can run on any cpu.
> +	 */
> +	set_cpus_allowed(current, CPU_MASK_ALL);
> +	/*
>  	 * Tell the world that we're going to be the grim
>  	 * reaper of innocent orphaned children.
>  	 *
> Index: linux-2.6.11-rc5-mm1/kernel/sched.c
> ===================================================================
> --- linux-2.6.11-rc5-mm1.orig/kernel/sched.c	2005-03-02 00:12:07.000000000 +0000
> +++ linux-2.6.11-rc5-mm1/kernel/sched.c	2005-03-02 00:47:14.000000000 +0000
> @@ -4092,6 +4092,7 @@
>  	idle->array = NULL;
>  	idle->prio = MAX_PRIO;
>  	idle->state = TASK_RUNNING;
> +	idle->cpus_allowed = cpumask_of_cpu(cpu);
>  	set_task_cpu(idle, cpu);
>  
>  	spin_lock_irqsave(&rq->lock, flags);
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

