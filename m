Return-Path: <linux-kernel-owner+w=401wt.eu-S1423080AbWLUUKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423080AbWLUUKo (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 15:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423081AbWLUUKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 15:10:44 -0500
Received: from relais.videotron.ca ([24.201.245.36]:10495 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423080AbWLUUKn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 15:10:43 -0500
Date: Thu, 21 Dec 2006 15:10:42 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 2.6.20-rc1 4/6] PXA GPIO wrappers
In-reply-to: <74d0deb30612211132j6186ad00te536eb420636e7c8@mail.gmail.com>
X-X-Sender: nico@xanadu.home
To: pHilipp Zabel <philipp.zabel@gmail.com>
Cc: David Brownell <david-b@pacbell.net>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Victor <andrew@sanpeople.com>,
       Bill Gatliff <bgat@billgatliff.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>,
       Kevin Hilman <khilman@mvista.com>, Russell King <rmk@arm.linux.org.uk>,
       Tony Lindgren <tony@atomide.com>
Message-id: <Pine.LNX.4.64.0612211457390.18171@xanadu.home>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <200611111541.34699.david-b@pacbell.net>
 <200612201312.36616.david-b@pacbell.net>
 <20061220221252.732f4e97.akpm@osdl.org>
 <200612202244.03351.david-b@pacbell.net>
 <Pine.LNX.4.64.0612210925130.18171@xanadu.home>
 <74d0deb30612210703y735e53kf14e7c800dae7140@mail.gmail.com>
 <Pine.LNX.4.64.0612211205530.18171@xanadu.home>
 <74d0deb30612211132j6186ad00te536eb420636e7c8@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Dec 2006, pHilipp Zabel wrote:

> > > --- linux-2.6.orig/arch/arm/mach-pxa/generic.c        2006-12-16
> > > +++ linux-2.6/arch/arm/mach-pxa/generic.c     2006-12-16
> > > 16:47:45.000000000
> > > @@ -129,6 +129,29 @@
> > > EXPORT_SYMBOL(pxa_gpio_mode);
> > >
> > > /*
> > > + * Return GPIO level, nonzero means high, zero is low
> > > + */
> > > +int pxa_gpio_get_value(unsigned gpio)
> > > +{
> > > +     return GPLR(gpio) & GPIO_bit(gpio);
> > > +}
> > > +
> > > +EXPORT_SYMBOL(pxa_gpio_get_value);
> > > +
> > > +/*
> > > + * Set output GPIO level
> > > + */
> > > +void pxa_gpio_set_value(unsigned gpio, int value)
> > > +{
> > > +     if (value)
> > > +             GPSR(gpio) = GPIO_bit(gpio);
> > > +     else
> > > +             GPCR(gpio) = GPIO_bit(gpio);
> > > +}
> > > +
> > > +EXPORT_SYMBOL(pxa_gpio_set_value);
> >
> > Instead of duplicating code here, you probably should just reuse
> > __gpio_set_value() and __gpio_get_value() inside those functions.
> 
> Probably? What I am wondering is this: can the compiler
> optimize away the range check that is duplicated in GPSR/GPCR
> and  GPIO_bit for __gpio_set/get_value? Or could we optimize
> this case by expanding the macros in place (which would mean
> duplicating code from pxa-regs.h)...

Sorry I don't quite follow you here.  Why would you expand the macro in 
place?

My suggestion is only about not duplicating the source code.  The 
generated assembly will be the same.

And your patch looks fine to me now, except for this:

+int pxa_gpio_get_value(unsigned gpio)
+{
+       __gpio_get_value(gpio);
+}

You certainly meant to add a "return" in there, right?


Nicolas
