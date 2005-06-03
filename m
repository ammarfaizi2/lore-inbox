Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbVFCWiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVFCWiY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 18:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbVFCWiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 18:38:23 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:55248 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261153AbVFCWiP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 18:38:15 -0400
Date: Sat, 4 Jun 2005 00:37:58 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Tony Lindgren <tony@atomide.com>
Cc: Christian Hesse <mail@earthworm.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Dynamic tick for x86 version 050602-2
Message-ID: <20050603223758.GA2227@elf.ucw.cz>
References: <20050602013641.GL21597@atomide.com> <200506021030.50585.mail@earthworm.de> <20050602174219.GC21363@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050602174219.GC21363@atomide.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Should be fixed now, the header was defining it as a function un UP
> system with no local apic. Can you try the following version?

Some comments below...

> @@ -102,6 +103,12 @@ fastcall unsigned int do_IRQ(struct pt_r
>  		);
>  	} else
>  #endif
> +
> +#ifdef CONFIG_NO_IDLE_HZ
> +	if (dyn_tick->state & (DYN_TICK_ENABLED | DYN_TICK_SKIPPING) && irq != 0)
> +		dyn_tick->interrupt(irq, NULL, regs);
> +#endif
> +
>  		__do_IRQ(irq, regs);
>  
>  	irq_exit();

Is not indentation little wrong here?


> Index: linux-dev/arch/i386/kernel/process.c
> ===================================================================
> --- linux-dev.orig/arch/i386/kernel/process.c	2005-06-01 17:51:36.000000000 -0700
> +++ linux-dev/arch/i386/kernel/process.c	2005-06-01 17:54:32.000000000 -0700
> @@ -160,6 +161,10 @@ void cpu_idle (void)
>  			if (!idle)
>  				idle = default_idle;
>  
> +#ifdef CONFIG_NO_IDLE_HZ
> +			dyn_tick_reprogram_timer();
> +#endif
> +
>  			__get_cpu_var(irq_stat).idle_timestamp = jiffies;
>  			idle();
>  		}

Your headers are good enough; this should not be neccessary.
> +
> +#define NS_TICK_LEN		((1 * 1000000000)/HZ)
> +#define DYN_TICK_MIN_SKIP	2
> +
> +#ifdef CONFIG_NO_IDLE_HZ
> +
> +extern unsigned long dyn_tick_reprogram_timer(void);
> +
> +#else
> +
> +#define arch_has_safe_halt()		0
> +#define dyn_tick_reprogram_timer()	{}

do {} while (0)

, else you are preparing trap for someone.

> Index: linux-dev/kernel/dyn-tick.c
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-dev/kernel/dyn-tick.c	2005-06-02 10:37:12.000000000 -0700
> @@ -0,0 +1,235 @@
> +/*
> + * linux/arch/i386/kernel/dyn-tick.c
> + *
> + * Beginnings of generic dynamic tick timer support
> + *
> + * Copyright (C) 2004 Nokia Corporation
> + * Written by Tony Lindgen <tony@atomide.com> and
> + * Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
> + *

Heh, you work for Nokia? Can I get one of those nokia 770 toys? I
should have 100 euros somewhere here :-).
								Pavel

