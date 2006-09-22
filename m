Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932547AbWIVOm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932547AbWIVOm4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 10:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932546AbWIVOm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 10:42:56 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:36810 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S932547AbWIVOmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 10:42:55 -0400
Subject: Re: 2.6.18-rt1
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>, Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <20060921190257.GA15151@elte.hu>
References: <20060920141907.GA30765@elte.hu>
	 <1158774118.29177.13.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <20060920182553.GC1292@us.ibm.com>
	 <200609201436.47042.gene.heskett@verizon.net>
	 <20060920194650.GA21037@elte.hu>
	 <1158783590.29177.19.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <20060920201450.GA22482@elte.hu>
	 <1158784266.29177.21.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <20060921190257.GA15151@elte.hu>
Content-Type: text/plain
Date: Fri, 22 Sep 2006 07:42:50 -0700
Message-Id: <1158936170.21405.11.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-21 at 21:02 +0200, Ingo Molnar wrote:
> * Daniel Walker <dwalker@mvista.com> wrote:
> 
> > On Wed, 2006-09-20 at 22:14 +0200, Ingo Molnar wrote:
> > > >         if (up->port.sysrq) {
> > > >                 /* serial8250_handle_port() already took the lock */
> > > >                 locked = 0;
> > 
> > 
> > In this case it had interrupts off in the !PREEMPT_RT case, but your 
> > change leaves them on here.. _irqsave only runs in two of the three 
> > cases..
> 
> doh, right you are. I updated to the patch below.
> 
> 	Ingo


On closer inspection I still think this is wrong. (Although it looks
really nice..) find below speaking only in term of !PREEMPT_RT ,


> Index: linux/drivers/serial/8250.c
> ===================================================================
> --- linux.orig/drivers/serial/8250.c
> +++ linux/drivers/serial/8250.c
> @@ -2252,14 +2252,10 @@ serial8250_console_write(struct console 
>  
>  	touch_nmi_watchdog();
>  
> -	local_irq_save(flags);
> -	if (up->port.sysrq) {
> -		/* serial8250_handle_port() already took the lock */
> -		locked = 0;

in the old version interrupts are off, and stay off until the function
returns in all cases. Even "locked = 0" .

> -	} else if (oops_in_progress) {
> -		locked = spin_trylock(&up->port.lock);
> -	} else
> -		spin_lock(&up->port.lock);
> +	if (up->port.sysrq || oops_in_progress)
> +		locked = spin_trylock_irqsave(&up->port.lock, flags);

Now in the new version interrupts are only off if you _get the lock_.
Presumably the lock is taken in the calling function, but interrupts
aren't disabled. 

I'm assuming the code is disabling interrupts for a good reason, I don't
know enough about the code to say it isn't.

> +	else
> +		spin_lock_irqsave(&up->port.lock, flags);
>  
>  	/*
>  	 *	First save the IER then disable the interrupts
> @@ -2281,8 +2277,7 @@ serial8250_console_write(struct console 
>  	serial_out(up, UART_IER, ier);
>  
>  	if (locked)
> -		spin_unlock(&up->port.lock);
> -	local_irq_restore(flags);
> +		spin_unlock_irqrestore(&up->port.lock, flags);
>  }
>  
>  static int serial8250_console_setup(struct console *co, char *options)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

