Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261978AbVFGUg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261978AbVFGUg1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 16:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbVFGUgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 16:36:25 -0400
Received: from vena.lwn.net ([206.168.112.25]:12483 "HELO lwn.net")
	by vger.kernel.org with SMTP id S261978AbVFGUgP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 16:36:15 -0400
Message-ID: <20050607203614.3932.qmail@lwn.net>
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Dynamic tick for x86 version 050602-1 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Wed, 01 Jun 2005 18:36:41 PDT."
             <20050602013641.GL21597@atomide.com> 
Date: Tue, 07 Jun 2005 14:36:14 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tony Lindgren <tony@atomide.com> wrote:

> --- linux-dev.orig/arch/i386/kernel/irq.c	2005-06-01 17:51:36.000000000 -0700
> +++ linux-dev/arch/i386/kernel/irq.c	2005-06-01 17:54:32.000000000 -0700
> [...]
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

Forgive me if I'm being obtuse (again...), but this hunk doesn't look
like it would work well in the 4K stacks case.  When 4K stacks are being
used, dyn_tick->interrupt() will only get called in the nested interrupt
case, when the interrupt stack is already in use.  This change also
pushes the non-assembly __do_IRQ() call out of the else branch, meaning
that, when the switch is made to the interrupt stack (most of the time),
__do_IRQ() will be called twice for the same interrupt.

It looks to me like you want to put your #ifdef chunk *after* the call
to __do_IRQ(), unless you have some reason for needing it to happen
before the regular interrupt handler is invoked.

What am I missing?

jon

Jonathan Corbet
Executive editor, LWN.net
corbet@lwn.net
