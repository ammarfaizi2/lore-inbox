Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262123AbVAUIQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbVAUIQm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 03:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262311AbVAUIQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 03:16:42 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:64754 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262123AbVAUIQZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 03:16:25 -0500
Message-ID: <41F0BA56.9000605@mvista.com>
Date: Fri, 21 Jan 2005 00:16:22 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       john stultz <johnstul@us.ibm.com>
Subject: Re: [PATCH] to fix xtime lock for in the RT kernel patch
References: <41F04573.7070508@mvista.com> <20050121063519.GA19954@elte.hu>
In-Reply-To: <20050121063519.GA19954@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * George Anzinger <george@mvista.com> wrote:
> 
> 
>>It seems to me that we need to either do the attached or to rewrite
>>the timer front end code to just gather the offset info and defer to
>>the timer irq thread to update jiffies and the offset stuff.  In
>>either case we really can not split the two and we do need the
>>xtime_lock protection.
> 
> 
> how about the patch below? One of the important benefits of the threaded
> timer IRQ is the ability to make xtime_lock a mutex.

The problem is that that removes the
	cur_timer->mark_offset();
	do_timer(regs);
in time.  If this were accompanied by code in the actual interrupt path that 
grabbed the offset info and the above was deferred to the irq thread I think it 
would be much better.

Something like:

	cur_timer->get_offset_info();

in the interrupt path and then, in the thread:

	cur_timer->apply_offset_info();

In the non-RT system we would just do:

	cur_timer->get_offset_info();
	cur_timer->apply_offset_info();

I think then we should let the apply code do the do_timer(regs) call as well as 
it is already messing with jiffies to correct for lost ticks.  An interesting 
point here is what to actually pass for "regs".  I suspect we would like the 
get_offset code to grab the relevant part of regs as well.  But then, we only 
really use regs in the accounting path which is else where on SMP machines.

This then bubbles up into a change in the common code (do_timer()) but we 
already have that.

I could code this up if you like.  Might want to get John Stultz's two cents on 
all this.

A related change I made in the HRT SMP code is to not use the local apic timers 
to kick off the accounting and run_timers code, but to define a new IPI.  In my 
current HRT code I send an IPI to all but self right after the jiffies update 
(calling the current cpus accounting code right after the IPI request).  I 
suspect the right thing to do here is to make that an IPI to all cpus, including 
self.  The reason for this change is to get the run_timers code to run as close 
to the jiffies update as possible.  This is required to get reasonable high res 
timers.
> 
> 	Ingo
> 
> --- linux/arch/i386/kernel/time.c.orig2	
> +++ linux/arch/i386/kernel/time.c	
> @@ -313,6 +313,7 @@ irqreturn_t timer_interrupt(int irq, voi
>  	write_seqlock(&xtime_lock);
>  
>  	cur_timer->mark_offset();
> +	do_timer(regs);
>   
>  	do_timer_interrupt(irq, NULL, regs);
>  
> --- linux/include/asm-i386/mach-default/do_timer.h.orig2	
> +++ linux/include/asm-i386/mach-default/do_timer.h	
> @@ -16,7 +16,6 @@
>  
>  static inline void do_timer_interrupt_hook(struct pt_regs *regs)
>  {
> -	do_timer(regs);
>  #ifndef CONFIG_SMP
>  	update_process_times(user_mode(regs));
>  #endif
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

