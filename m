Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267794AbUG3TER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267794AbUG3TER (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 15:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267791AbUG3TER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 15:04:17 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:18394 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267794AbUG3TD4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 15:03:56 -0400
Message-ID: <410A9B83.9050303@austin.ibm.com>
Date: Fri, 30 Jul 2004 14:03:31 -0500
From: Joel Schopp <jschopp@austin.ibm.com>
Reply-To: jschopp@austin.ibm.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: Andrew Morton <akpm@osdl.org>, Nathan Lynch <nathanl@austin.ibm.com>,
       anton@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppc64: Fix cpu_up race
References: <1091052774.24763.14.camel@pants.austin.ibm.com> <20040729052716.GA24612@in.ibm.com> <20040729053011.GC6456@krispykreme> <20040730052413.GB32010@in.ibm.com>
In-Reply-To: <20040730052413.GB32010@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've tested this patch extensively and it does fix the race.

In more detail the race is that the cpu can be running before it is 
marked in the cpu_online_map.  While running it can go idle and the idle 
loop checks cpu_online_map, sees that it is not set, and assumes that a 
hotplug remove is in progress and that it should stop itself.  By the 
time the cpu is marked online it is stopped.

Srivatsa Vaddagiri wrote:

> On Thu, Jul 29, 2004 at 03:30:11PM +1000, Anton Blanchard wrote:
> 
>> 
>>
>>>I think Anton pushed this to ameslab. I presume there should be some mechanism
>>>for ameslab stuff to be included mainline. If there is such mechanism, then
>>>I dont want to push the patch myself.
>>
>>It looks good, could you send it directly to akpm, ccing me?
> 
> 
> Andrew,
> 	Patch below fixes a cpu_up race in PPC64. Please apply.
> 
> 
> Signed-off-by : Srivatsa Vaddagiri <vatsa@in.ibm.com>
> Signed-off-by : Anton Blanchard <anton@samba.org>
> 
> 
> ---
> 
>  linux-2.6.8-rc2-vatsa/arch/ppc64/kernel/smp.c |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff -puN arch/ppc64/kernel/smp.c~ppc64_cpu_up_fix arch/ppc64/kernel/smp.c
> --- linux-2.6.8-rc2/arch/ppc64/kernel/smp.c~ppc64_cpu_up_fix	2004-07-30 10:33:55.000000000 +0530
> +++ linux-2.6.8-rc2-vatsa/arch/ppc64/kernel/smp.c	2004-07-30 10:34:02.000000000 +0530
> @@ -927,7 +927,11 @@ int __devinit __cpu_up(unsigned int cpu)
>  
>  	if (smp_ops->give_timebase)
>  		smp_ops->give_timebase();
> -	cpu_set(cpu, cpu_online_map);
> +
> +	/* Wait until cpu puts itself in the online map */
> +	while (!cpu_online(cpu))
> +		cpu_relax();
> +
>  	return 0;
>  }
>  
> @@ -963,6 +967,10 @@ int __devinit start_secondary(void *unus
>  #endif
>  #endif
>  
> +	spin_lock(&call_lock);
> +	cpu_set(cpu, cpu_online_map);
> +	spin_unlock(&call_lock);
> +
>  	local_irq_enable();
>  
>  	return cpu_idle(NULL);
> 
> _
> 
