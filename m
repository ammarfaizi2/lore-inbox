Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbWJIIJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbWJIIJi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 04:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbWJIIJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 04:09:38 -0400
Received: from www.osadl.org ([213.239.205.134]:4806 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932340AbWJIIJg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 04:09:36 -0400
Subject: Re: + clocksource-add-generic-sched_clock.patch added to -mm tree
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Daniel Walker <dwalker@mvista.com>
Cc: akpm@osdl.org, johnstul@us.ibm.com, mingo@elte.hu, zippel@linux-m68k.org,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1160348466.3693.203.camel@c-67-180-230-165.hsd1.ca.comcast.net>
References: <200610070153.k971ruEZ020872@shell0.pdx.osdl.net>
	 <1160301340.22911.27.camel@localhost.localdomain>
	 <1160318750.3693.12.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <1160319112.5686.8.camel@localhost.localdomain>
	 <1160321570.3693.34.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <1160322376.5686.25.camel@localhost.localdomain>
	 <1160323597.3693.62.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <1160324354.5686.41.camel@localhost.localdomain>
	 <1160324846.3693.78.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <1160326451.5686.51.camel@localhost.localdomain>
	 <1160328400.3693.100.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <1160333127.5686.58.camel@localhost.localdomain>
	 <1160342108.3693.144.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <1160342483.5686.104.camel@localhost.localdomain>
	 <1160343221.3693.154.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <1160343715.5686.118.camel@localhost.localdomain>
	 <1160345282.3693.175.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <1160346908.5686.143.camel@localhost.localdomain>
	 <1160348466.3693.203.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Content-Type: text/plain
Date: Mon, 09 Oct 2006 10:09:37 +0200
Message-Id: <1160381377.5686.192.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-08 at 16:01 -0700, Daniel Walker wrote:
> > You move tons of code into timer.c, which does not belong there.
> > clocksource is a different thing than timekeeping. timekeeping makes use
> > of clocksources, and your extra layer of timekeeping_clocksource API
> > does not change that at all. What you call abstraction is just an
> > artificial extra layer, as it is intrinsically tied to the clocksource
> > core.
> 
> I think that code does belong there. Yes clocksources and timekeeping
> are different. Which is the point of the patch set.

And I have to accept that you think, that the code belongs there ?

> It's not less maintainable now, or if it is your going to have to be a
> lot more specific.

In order to satisfy your idea of abstraction, you add glue code to make
it work:

clocksource.c:
> +int clocksource_sysfs_register(struct sysdev_attribute * attr)
> +{
> +       return sysdev_create_file(&device_clocksource, attr);
> +}
> +

timer.c:
> +
> +#ifdef CONFIG_GENERIC_TIME
> +       clocksource_sysfs_register(&attr_timeofday_clocksource);

Abstractions are good in general, but this is artificial for no benefit.


You claim, that you optmize update_wll_time()

>         /* check to see if there is a new clocksource to use */
> -       if (change_clocksource()) {
> +       if (unlikely(atomic_read(&clock_check))) {
> +
> +               /*
> +                * Switch to the new override clock, or the highest
> +                * rated clock.
> +                */
> +               if (*clock_override_name)
> +                       change_clocksource(clock_override_name);
> +               else
> +                       change_clocksource(NULL);
> +
>                 clock->error = 0;
>                 clock->xtime_nsec = 0;
>                 hrtimer_clock_notify();
>                 clocksource_calculate_interval(clock, tick_nsec);
> +
> +               /*
> +                * Remove the change signal
> +                */
> +               atomic_dec(&clock_check);
> +
>         }

Well, I guess I have some perceptional disturbance. What exactly is the
optimization ? Pushing clock_override_name into that code path ? As I
said before, the performance difference of change_clocksource() and
atomic_read() is not big enough to justify the mess you create all over
the place.

The whole notifier business is not necessary, if you keep the
clocksource related code in one place. 

You break sched_clock on x86 for no good reason.

	tglx


