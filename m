Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262211AbVFIBtn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262211AbVFIBtn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 21:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbVFIBtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 21:49:43 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:14281 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S262211AbVFIBt0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 21:49:26 -0400
X-ORBL: [67.117.73.34]
Date: Wed, 8 Jun 2005 18:40:33 -0700
From: Tony Lindgren <tony@atomide.com>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Dynamic tick for x86 version 050602-1
Message-ID: <20050609014033.GA30827@atomide.com>
References: <88056F38E9E48644A0F562A38C64FB6004EBD10C@scsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88056F38E9E48644A0F562A38C64FB6004EBD10C@scsmsx403.amr.corp.intel.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Pallipadi, Venkatesh <venkatesh.pallipadi@intel.com> [050608 15:14]:
> 
> >-----Original Message-----
> >From: linux-kernel-owner@vger.kernel.org 
> >[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
> >Jonathan Corbet
> >Sent: Tuesday, June 07, 2005 1:36 PM
> >To: Tony Lindgren
> >Cc: linux-kernel@vger.kernel.org
> >Subject: Re: [PATCH] Dynamic tick for x86 version 050602-1 
> >
> >Tony Lindgren <tony@atomide.com> wrote:
> >
> >> --- linux-dev.orig/arch/i386/kernel/irq.c	2005-06-01 
> >17:51:36.000000000 -0700
> >> +++ linux-dev/arch/i386/kernel/irq.c	2005-06-01 
> >17:54:32.000000000 -0700
> >> [...]
> >> @@ -102,6 +103,12 @@ fastcall unsigned int do_IRQ(struct pt_r
> >>  		);
> >>  	} else
> >>  #endif
> >> +
> >> +#ifdef CONFIG_NO_IDLE_HZ
> >> +	if (dyn_tick->state & (DYN_TICK_ENABLED | 
> >DYN_TICK_SKIPPING) && irq != 0)
> >> +		dyn_tick->interrupt(irq, NULL, regs);
> >> +#endif
> >> +
> >>  		__do_IRQ(irq, regs);
> >
> >Forgive me if I'm being obtuse (again...), but this hunk doesn't look
> >like it would work well in the 4K stacks case.  When 4K stacks 
> >are being
> >used, dyn_tick->interrupt() will only get called in the nested 
> >interrupt
> >case, when the interrupt stack is already in use.  This change also
> >pushes the non-assembly __do_IRQ() call out of the else branch, meaning
> >that, when the switch is made to the interrupt stack (most of 
> >the time),
> >__do_IRQ() will be called twice for the same interrupt.
> >
> >It looks to me like you want to put your #ifdef chunk *after* the call
> >to __do_IRQ(), unless you have some reason for needing it to happen
> >before the regular interrupt handler is invoked.
> >
> 
> Good catch. This indeed looks like a bug. 
> With 050602-1 version I am seeing double the number of calls to 
> timer_interrupt routine than expected. Say, when all CPUs are fully
> busy, 
> I see 2*HZ timer interrupt count in /proc/interrupts
> 
> And things look normal once I change this hunk as below
> 
> >>  	} else
> >>  #endif
> >> +
>    + {
> >> +#ifdef CONFIG_NO_IDLE_HZ
> >> +	if (dyn_tick->state & (DYN_TICK_ENABLED | 
> >DYN_TICK_SKIPPING) && irq != 0)
> >> +		dyn_tick->interrupt(irq, NULL, regs);
> >> +#endif
> >> +
> >>  		__do_IRQ(irq, regs);
>    + }

Cool. Sorry for not responding earlier, my hard drive crashed yesterday
morning... I also managed to fry my spare computer's motherboard
while trying to recover some data from the broken disk :)

I'll try to post an updated patch tomorrow.

Tony
