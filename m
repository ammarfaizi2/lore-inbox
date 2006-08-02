Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbWHBQAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbWHBQAz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 12:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932073AbWHBQAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 12:00:54 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:17387 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S932072AbWHBQAy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 12:00:54 -0400
Date: Wed, 2 Aug 2006 18:00:23 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Andrew Victor <andrew@sanpeople.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] at91_serial: support AVR32
Message-ID: <20060802180023.65fe6434@cad-250-152.norway.atmel.com>
In-Reply-To: <20060802151505.GA32102@flint.arm.linux.org.uk>
References: <11545303083273-git-send-email-hskinnemoen@atmel.com>
	<11545303082669-git-send-email-hskinnemoen@atmel.com>
	<20060802151505.GA32102@flint.arm.linux.org.uk>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Aug 2006 16:15:05 +0100
Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> On Wed, Aug 02, 2006 at 04:51:46PM +0200, Haavard Skinnemoen wrote:
> > diff --git a/drivers/serial/at91_serial.c
> > b/drivers/serial/at91_serial.c index 54c6b2a..f2fecc6 100644
> > --- a/drivers/serial/at91_serial.c
> > +++ b/drivers/serial/at91_serial.c
> > @@ -40,8 +40,10 @@ #include <asm/arch/at91rm9200_usart.h>
> >  #include <asm/arch/at91rm9200_pdc.h>
> >  #include <asm/mach/serial_at91.h>
> >  #include <asm/arch/board.h>
> > +#ifdef CONFIG_ARM
> >  #include <asm/arch/system.h>
> 
> I'd rather this file wasn't included in any drivers in any case.

I suppose the cpu_is_*() stuff I've heard about through David Brownell
is going to solve that. Could someone point me at the patch
implementing it for ARM so that I can implement something similar for
AVR32?

> > @@ -611,7 +615,8 @@ static int at91_request_port(struct uart
> >  		return -EBUSY;
> >  
> >  	if (port->flags & UPF_IOREMAP) {
> > -		port->membase = ioremap(port->mapbase, size);
> > +		if (port->membase == NULL)
> > +			port->membase = ioremap(port->mapbase,
> > size);
> 
> This change makes no sense.  If you don't want ioremap, don't set
> UPF_IOREMAP.

It's supposed to prevent it from ioremap()ing it again if it was
previously ioremap()ed for use by the console. I'll drop it along with
the call to ioremap() in the next hunk.

> >  		if (port->membase == NULL) {
> >  			release_mem_region(port->mapbase, size);
> >  			return -ENOMEM;
> > @@ -693,12 +698,19 @@ static void __devinit at91_init_port(str
> >  	port->mapbase	= pdev->resource[0].start;
> >  	port->irq	= pdev->resource[1].start;
> >  
> > +#ifdef CONFIG_AVR32
> > +	port->flags |= UPF_IOREMAP;
> > +	port->membase = ioremap(pdev->resource[0].start,
> > +				pdev->resource[0].end
> > +				- pdev->resource[0].start + 1);
> 
> Don't see the requirement for this.

Well, maybe I misunderstood something. The reason I added it was to get
a pointer to the USART registers for use by the serial console. I guess
it would work equally well to just set UPF_IOREMAP, except that the
console will start working a bit later...

What is the best way to get the serial console up and running early in
the boot process? ioremap() only happens to work because the internal
peripherals are permanently mapped on AVR32, so I shouldn't really
depend on that.

Haavard
