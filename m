Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262461AbVFJETH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262461AbVFJETH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 00:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262487AbVFJETH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 00:19:07 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:56299 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S262461AbVFJES6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 00:18:58 -0400
X-ORBL: [67.117.73.34]
Date: Thu, 9 Jun 2005 21:18:42 -0700
From: Tony Lindgren <tony@atomide.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Dynamic tick for x86 version 050602-1
Message-ID: <20050610041842.GD18103@atomide.com>
References: <20050602013641.GL21597@atomide.com> <20050607203614.3932.qmail@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050607203614.3932.qmail@lwn.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jonathan Corbet <corbet@lwn.net> [050607 13:36]:
> Tony Lindgren <tony@atomide.com> wrote:
> 
> > --- linux-dev.orig/arch/i386/kernel/irq.c	2005-06-01 17:51:36.000000000 -0700
> > +++ linux-dev/arch/i386/kernel/irq.c	2005-06-01 17:54:32.000000000 -0700
> > [...]
> > @@ -102,6 +103,12 @@ fastcall unsigned int do_IRQ(struct pt_r
> >  		);
> >  	} else
> >  #endif
> > +
> > +#ifdef CONFIG_NO_IDLE_HZ
> > +	if (dyn_tick->state & (DYN_TICK_ENABLED | DYN_TICK_SKIPPING) && irq != 0)
> > +		dyn_tick->interrupt(irq, NULL, regs);
> > +#endif
> > +
> >  		__do_IRQ(irq, regs);
> 
> Forgive me if I'm being obtuse (again...), but this hunk doesn't look
> like it would work well in the 4K stacks case.  When 4K stacks are being
> used, dyn_tick->interrupt() will only get called in the nested interrupt
> case, when the interrupt stack is already in use.  This change also
> pushes the non-assembly __do_IRQ() call out of the else branch, meaning
> that, when the switch is made to the interrupt stack (most of the time),
> __do_IRQ() will be called twice for the same interrupt.

Good catch as mentioned earlier :)

> It looks to me like you want to put your #ifdef chunk *after* the call
> to __do_IRQ(), unless you have some reason for needing it to happen
> before the regular interrupt handler is invoked.

Time needs to be updated before __do_IRQ() so interrupt handlers have
correct time.

Tony
