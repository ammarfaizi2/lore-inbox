Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262444AbVCJIwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262444AbVCJIwu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 03:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262448AbVCJIwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 03:52:50 -0500
Received: from one.firstfloor.org ([213.235.205.2]:61863 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262444AbVCJIvY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 03:51:24 -0500
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Reduce cacheline bouncing in cpu_idle_wait
References: <Pine.LNX.4.61.0503091839200.2903@montezuma.fsmlabs.com>
From: Andi Kleen <ak@muc.de>
Date: Thu, 10 Mar 2005 09:51:22 +0100
In-Reply-To: <Pine.LNX.4.61.0503091839200.2903@montezuma.fsmlabs.com> (Zwane
 Mwaikambo's message of "Wed, 9 Mar 2005 19:41:35 -0700 (MST)")
Message-ID: <m1mztbvq7p.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@arm.linux.org.uk> writes:

> Andi noted that during normal runtime cpu_idle_map is bounced around a 
> lot, and occassionally at a higher frequency than the timer interrupt 
> wakeup which we normally exit pm_idle from. So switch to a percpu 
> variable. Andi i didn't move things to the slow path because it would 
> involve adding scheduler code to wakeup the idle thread on the cpus we're 
> waiting for.

Thanks. 
>  
> -
>  void cpu_idle_wait(void)
>  {
> -        int cpu;
> -        cpumask_t map;
> +	unsigned int cpu, this_cpu = get_cpu();
> +	cpumask_t map;
> +
> +	set_cpus_allowed(current, cpumask_of_cpu(this_cpu));
> +	put_cpu();

You need a cpus_clear(map); here I think (probably same for the other
archs) 

> +
> +	for_each_online_cpu(cpu) {
> +		per_cpu(cpu_idle_state, cpu) = 1;
> +		cpu_set(cpu, map);
> +	}



-Andi
