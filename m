Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965009AbWA1C7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965009AbWA1C7A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 21:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWA1C7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 21:59:00 -0500
Received: from proof.pobox.com ([207.106.133.28]:20417 "EHLO proof.pobox.com")
	by vger.kernel.org with ESMTP id S1751236AbWA1C7A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 21:59:00 -0500
Date: Fri, 27 Jan 2006 20:58:55 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Jack Steiner <steiner@sgi.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16 - sys_sched_getaffinity & hotplug
Message-ID: <20060128025854.GA18730@localhost.localdomain>
References: <20060127230659.GA4752@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060127230659.GA4752@sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jack Steiner wrote:
> 
> It appears if CONFIG_HOTPLUG_CPU is enabled, then all possible
> cpus (0 .. NR_CPUS-1) are set in the cpu_possible_map on IA64.

That's too bad...


> sched_getaffinity() returns the cpu_possible_map and'd with the current
> task p->cpus_allowed. The default cpus_allowed is all ones.
> 
> This is causing problems for apps that use sched_get_sched_affinity()
> to determine which cpus that they are allowed to run on.

How?  Are these apps expecting all set bits to correspond to online
cpus?


> The call to sched_getaffinity returns:
> 
> 	(from strace on a 2 cpu system with NR_CPUS = 512)
> 	sched_getaffinity(0, 1024,  { ffffffffffffffff, ffffff ...
> 
> 
> 
> The man page for sched_getaffinity() is ambiguous. It says:
> 	- A set bit corresponds to a legally  schedulable  CPU
> 
> But it also says:
> 	- Usually, all bits in the mask are set.
> 
> 
> Should the following change be made to sched_getaffinity(). 
> 
> Index: linux/kernel/sched.c
> ===================================================================
> --- linux.orig/kernel/sched.c	2006-01-25 08:50:21.401747695 -0600
> +++ linux/kernel/sched.c	2006-01-27 16:57:24.504871895 -0600
> @@ -4031,7 +4031,7 @@ long sched_getaffinity(pid_t pid, cpumas
>  		goto out_unlock;
>  
>  	retval = 0;
> -	cpus_and(*mask, p->cpus_allowed, cpu_possible_map);
> +	cpus_and(*mask, p->cpus_allowed, cpu_online_map);


I don't think so.

For one, that would be mucking around with a kernel/userspace ABI, I
guess.

Additionally, it would mean that the result of sched_getaffinity would
vary with the number of online cpus in the system, which I don't think
is desirable.
