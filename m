Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265633AbTAXXEG>; Fri, 24 Jan 2003 18:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265736AbTAXXEG>; Fri, 24 Jan 2003 18:04:06 -0500
Received: from air-2.osdl.org ([65.172.181.6]:4834 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265633AbTAXXEE>;
	Fri, 24 Jan 2003 18:04:04 -0500
Subject: Re: [RFC][PATCH] linux-2.5.59_lost-tick_A0
From: Stephen Hemminger <shemminger@osdl.org>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1043189962.15683.82.camel@w-jstultz2.beaverton.ibm.com>
References: <1043189962.15683.82.camel@w-jstultz2.beaverton.ibm.com>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1043449992.10150.29.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 24 Jan 2003 15:13:13 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Minor nit: detect_lost_tick could be static and inline.

On Tue, 2003-01-21 at 14:59, john stultz wrote:
> All,
> 	This patch addresses the following problem: Linux cannot properly
> handle the case where interrupts are disabled for longer then two ticks.
> 
> Quick background: 
> 	gettimeofday() calculates wall time using roughly the following
> equation: xtime + (jiffies - wall_jiffies) + timer->get_offset()
> 
> When a tick is lost, the system is able to compensate short-term because
> even though jiffies is not incremented, timer->get_offset() (which is
> hardware based) continues to increase. However this falls apart, because
> if after 3 or so lost-ticks an interrupt does occur, jiffies is
> incremented only once and we reset timer->get_offset() effectively
> loosing the time we had been compensating for. This causes brief
> inconsistencies in time, in addition to causing system time to drift
> behind that of other systems.
> 
> This patch solves the problem by checking when an interrupt occurs if
> timer->get_offset() is a value greater then 2 ticks. If so, it
> increments jiffies appropriately. 
> 
> Comments, flames and suggestions are requested and welcome.
> 
> thanks
> -john
> 
> diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
> --- a/arch/i386/kernel/time.c	Tue Jan 21 14:14:18 2003
> +++ b/arch/i386/kernel/time.c	Tue Jan 21 14:14:18 2003
> @@ -265,6 +265,21 @@
>  #endif
>  }
>  
> +/*Lost tick detection and compensation*/
> +void detect_lost_tick(void)
> +{
> +	/*read time since last interrupt*/
> +	unsigned long delta = timer->get_offset();
> +
> +	/*check if delta is greater then two ticks*/
> +	if(delta > 2*(1000000/HZ)){
> +		/*calculate number of missed ticks*/
> +		delta = delta/(1000000/HZ)-1;
> +		jiffies += delta;
> +	}
> +		
> +}
> +
>  /*
>   * This is the same as the above, except we _also_ save the current
>   * Time Stamp Counter value at the time of the timer interrupt, so that
> @@ -281,6 +296,7 @@
>  	 */
>  	write_lock(&xtime_lock);
>  
> +	detect_lost_tick();
>  	timer->mark_offset();
>   
>  	do_timer_interrupt(irq, NULL, regs);
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Stephen Hemminger <shemminger@osdl.org>
Open Source Devlopment Lab

