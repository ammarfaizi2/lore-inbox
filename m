Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbWELUFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbWELUFF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 16:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbWELUFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 16:05:05 -0400
Received: from 216-54-166-5.static.twtelecom.net ([216.54.166.5]:39089 "EHLO
	mx1.compro.net") by vger.kernel.org with ESMTP id S932198AbWELUFD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 16:05:03 -0400
Message-ID: <4464EA6A.6070903@compro.net>
Date: Fri, 12 May 2006 16:04:58 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH -rt] irqd starvation on SMP by a single process?
References: <1147401812.1907.14.camel@cog.beaverton.ibm.com>	 <20060512055025.GA25824@elte.hu> <1147457058.9343.22.camel@localhost.localdomain>
In-Reply-To: <1147457058.9343.22.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> On Fri, 2006-05-12 at 07:50 +0200, Ingo Molnar wrote:
>> +		if (!cpus_equal(current->cpus_allowed, irq_affinity[irq]));
>> +			set_cpus_allowed(current, irq_affinity[irq]);
> 
> Gah! I introduced a terrible bug there. 
> 
> Note the semi-colon at the end of the if statement! Sorry about that!
> 
> The following patch (which I've tested as well) fixes that.
> 
> --- 2.6-rt/kernel/irq/manage.c	2006-05-11 18:37:36.000000000 -0500
> +++ dev-rt/kernel/irq/manage.c	2006-05-12 12:55:56.000000000 -0500
> @@ -724,6 +724,7 @@
>  		set_current_state(TASK_INTERRUPTIBLE);
>  		do_hardirq(desc);
>  		cond_resched_all();
> +		local_irq_disable();
>  		__do_softirq();
>  //		do_softirq_from_hardirq();
>  		local_irq_enable();
> @@ -731,10 +732,8 @@
>  		/*
>  		 * Did IRQ affinities change?
>  		 */
> -		if (!cpu_isset(smp_processor_id(), irq_affinity[irq])) {
> -			mask = cpumask_of_cpu(any_online_cpu(irq_affinity[irq]));
> -			set_cpus_allowed(current, mask);
> -		}
> +		if(!cpus_equal(current->cpus_allowed, irq_affinity[irq]))
> +			set_cpus_allowed(current, irq_affinity[irq]);
>  #endif
>  		schedule();
>  	}
> 
> 
> 
> 

FYI,

I just looked at rt21 and the first version of this patch seems to be in
it. Not this version.

Mark

