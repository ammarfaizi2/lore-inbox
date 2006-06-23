Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932984AbWFWKFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932984AbWFWKFF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 06:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932987AbWFWKFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 06:05:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42440 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932984AbWFWKFD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 06:05:03 -0400
Date: Fri, 23 Jun 2006 03:04:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org, rmk@arm.linux.org.uk
Subject: Re: [patch 36/61] lock validator: special locking: serial
Message-Id: <20060623030447.a8061690.akpm@osdl.org>
In-Reply-To: <20060623094941.GE4889@elte.hu>
References: <20060529212109.GA2058@elte.hu>
	<20060529212604.GJ3155@elte.hu>
	<20060529183533.75381871.akpm@osdl.org>
	<20060623094941.GE4889@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2006 11:49:41 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > > +/*
> > > + * lockdep: port->lock is initialized in two places, but we
> > > + *          want only one lock-type:
> > > + */
> > > +static struct lockdep_type_key port_lock_key;
> > > +
> > >  /**
> > >   *	uart_set_options - setup the serial console parameters
> > >   *	@port: pointer to the serial ports uart_port structure
> > > @@ -1869,7 +1875,7 @@ uart_set_options(struct uart_port *port,
> > >  	 * Ensure that the serial console lock is initialised
> > >  	 * early.
> > >  	 */
> > > -	spin_lock_init(&port->lock);
> > > +	spin_lock_init_key(&port->lock, &port_lock_key);
> > >  
> > >  	memset(&termios, 0, sizeof(struct termios));
> > >  
> > > @@ -2255,7 +2261,7 @@ int uart_add_one_port(struct uart_driver
> > >  	 * initialised.
> > >  	 */
> > >  	if (!(uart_console(port) && (port->cons->flags & CON_ENABLED)))
> > > -		spin_lock_init(&port->lock);
> > > +		spin_lock_init_key(&port->lock, &port_lock_key);
> > >  
> > >  	uart_configure_port(drv, state, port);
> > >  
> > 
> > Is there a cleaner way of doing this?
> > 
> > Perhaps write a new helper function which initialises the spinlock, 
> > call that?  Rather than open-coding lockdep stuff?
> 
> yes, we can do that too - but that would have an effect to non-lockdep 
> kernels too.
> 
> Also, the initialization of the 'port' seems a bit twisted here, already 
> initialized and not-yet-initialized ports can be passed in to 
> uard_add_one_port(). So i did not want to touch the structure of the 
> code - hence the open-coded solution.
> 

btw, I was looking at this change:

diff -puN drivers/scsi/libata-core.c~lock-validator-locking-init-debugging-improvement drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c~lock-validator-locking-init-debugging-improvement
+++ a/drivers/scsi/libata-core.c
@@ -1003,6 +1003,7 @@ unsigned ata_exec_internal(struct ata_de
 	unsigned int err_mask;
 	int rc;
 
+	init_completion(&wait);
 	spin_lock_irqsave(ap->lock, flags);
 
 	/* no internal command while frozen */

That local was already initialised with DEFINE_WAIT().  Am surprised that
an init_wait() also was needed?

