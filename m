Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267649AbTAQTzF>; Fri, 17 Jan 2003 14:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267652AbTAQTzF>; Fri, 17 Jan 2003 14:55:05 -0500
Received: from [195.39.17.254] ([195.39.17.254]:3076 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267649AbTAQTzD>;
	Fri, 17 Jan 2003 14:55:03 -0500
Date: Sun, 12 Jan 2003 15:27:40 +0100
From: Pavel Machek <pavel@ucw.cz>
To: john stultz <johnstul@us.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] linux-2.5.54_delay-cleanup_A0
Message-ID: <20030112142740.GA1691@elf.ucw.cz>
References: <1041993975.1052.71.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1041993975.1052.71.camel@w-jstultz2.beaverton.ibm.com>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Linus, all, 
> 	I've been busy with other things, so I've just been sitting on this for
> a while. Anyway, I figured it was about time to resend. 
> 
> This patch tries to cleanup the delay code by moving the timer-specific
> implementations into the timer_ops struct. Thus, rather then doing:
> 
> 	if(x86_delay_tsc)
> 		__rdtsc_delay(loops);
> 	else if(x86_delay_cyclone)
> 		__cyclone_delay(loops);
> 	else if(whatever....
> 
> we just simply do:
> 
> 	if(timer)
> 		timer->delay(loops);
> 
> diff -Nru a/arch/i386/kernel/timers/timer_pit.c b/arch/i386/kernel/timers/timer_pit.c
> --- a/arch/i386/kernel/timers/timer_pit.c	Tue Jan  7 17:11:03 2003
> +++ b/arch/i386/kernel/timers/timer_pit.c	Tue Jan  7 17:11:03 2003
> @@ -27,6 +27,19 @@
>  	/* nothing needed */
>  }
>  
> +static void delay_pit(unsigned long loops)
> +{
> +	int d0;
> +	__asm__ __volatile__(
> +		"\tjmp 1f\n"
> +		".align 16\n"
> +		"1:\tjmp 2f\n"
> +		".align 16\n"
> +		"2:\tdecl %0\n\tjns 2b"
> +		:"=&a" (d0)
> +		:"0" (loops));
> +}
> +

But... this is not using pit to do the delay, right? It is sensitive
to CPU clock changes, pit-delay should not be.

								Pavel

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
