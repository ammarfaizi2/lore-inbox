Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbWI3IgU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWI3IgU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 04:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbWI3IgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 04:36:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46239 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751117AbWI3IgQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 04:36:16 -0400
Date: Sat, 30 Sep 2006 01:35:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: Re: [patch 02/23] GTOD: persistent clock support, core
Message-Id: <20060930013558.679bf961.akpm@osdl.org>
In-Reply-To: <20060929234439.041924000@cruncher.tec.linutronix.de>
References: <20060929234435.330586000@cruncher.tec.linutronix.de>
	<20060929234439.041924000@cruncher.tec.linutronix.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 29 Sep 2006 23:58:21 -0000
Thomas Gleixner <tglx@linutronix.de> wrote:

> From: John Stultz <johnstul@us.ibm.com>
> 
> persistent clock support: do proper timekeeping across suspend/resume.

How?

> +/* Weak dummy function for arches that do not yet support it.
> + * XXX - Do be sure to remove it once all arches implement it.
> + */
> +unsigned long __attribute__((weak)) read_persistent_clock(void)
> +{
> +	return 0;
> +}

Seconds?  microseconds?  jiffies?  walltime?  uptime?

Needs some comments.


>  void __init timekeeping_init(void)
>  {
> -	unsigned long flags;
> +	unsigned long flags, sec = read_persistent_clock();

So it apparently returns seconds-since-epoch?

If so, why?

>  	write_seqlock_irqsave(&xtime_lock, flags);
>  
> @@ -758,11 +769,18 @@ void __init timekeeping_init(void)
>  	clocksource_calculate_interval(clock, tick_nsec);
>  	clock->cycle_last = clocksource_read(clock);
>  
> +	xtime.tv_sec = sec;
> +	xtime.tv_nsec = (jiffies % HZ) * (NSEC_PER_SEC / HZ);

Why is it valid to take the second from the persistent clock and the
fraction-of-a-second from jiffies?  Some comments describing the
implementation would improve its understandability and maintainability.

This statement can set xtime.tv_nsec to a value >= NSEC_PER_SEC.  Should it
not be normalised?

> +	set_normalized_timespec(&wall_to_monotonic,
> +		-xtime.tv_sec, -xtime.tv_nsec);
> +
>  	write_sequnlock_irqrestore(&xtime_lock, flags);
>  }
>  
>  
>  static int timekeeping_suspended;
> +static unsigned long timekeeping_suspend_time;

In what units?

> +
>  /**
>   * timekeeping_resume - Resumes the generic timekeeping subsystem.
>   * @dev:	unused
> @@ -773,14 +791,23 @@ static int timekeeping_suspended;
>   */
>  static int timekeeping_resume(struct sys_device *dev)
>  {
> -	unsigned long flags;
> +	unsigned long flags, now = read_persistent_clock();

Would whoever keeps doing that please stop it?  This:

	unsigned long flags;
	unsigned long now = read_persistent_clock();

is more readable and makes for more readable patches in the future.

>  	write_seqlock_irqsave(&xtime_lock, flags);
> -	/* restart the last cycle value */
> +
> +	if (now && (now > timekeeping_suspend_time)) {
> +		unsigned long sleep_length = now - timekeeping_suspend_time;
> +		xtime.tv_sec += sleep_length;
> +		jiffies_64 += sleep_length * HZ;

sleep_length will overflow if we slept for more than 49 days, and HZ=1000.

> +	}
> +	/* re-base the last cycle value */
>  	clock->cycle_last = clocksource_read(clock);
>  	clock->error = 0;
>  	timekeeping_suspended = 0;
>  	write_sequnlock_irqrestore(&xtime_lock, flags);
> +
> +	hrtimer_notify_resume();
> +
>  	return 0;
>  }
>  
> @@ -790,6 +817,7 @@ static int timekeeping_suspend(struct sy
>  
>  	write_seqlock_irqsave(&xtime_lock, flags);
>  	timekeeping_suspended = 1;
> +	timekeeping_suspend_time = read_persistent_clock();
>  	write_sequnlock_irqrestore(&xtime_lock, flags);
>  	return 0;
>  }
> 
> --
