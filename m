Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932977AbWFWJyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932977AbWFWJyq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 05:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932965AbWFWJyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 05:54:46 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:26818 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932150AbWFWJyp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 05:54:45 -0400
Date: Fri, 23 Jun 2006 11:49:41 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: [patch 36/61] lock validator: special locking: serial
Message-ID: <20060623094941.GE4889@elte.hu>
References: <20060529212109.GA2058@elte.hu> <20060529212604.GJ3155@elte.hu> <20060529183533.75381871.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529183533.75381871.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5015]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > +/*
> > + * lockdep: port->lock is initialized in two places, but we
> > + *          want only one lock-type:
> > + */
> > +static struct lockdep_type_key port_lock_key;
> > +
> >  /**
> >   *	uart_set_options - setup the serial console parameters
> >   *	@port: pointer to the serial ports uart_port structure
> > @@ -1869,7 +1875,7 @@ uart_set_options(struct uart_port *port,
> >  	 * Ensure that the serial console lock is initialised
> >  	 * early.
> >  	 */
> > -	spin_lock_init(&port->lock);
> > +	spin_lock_init_key(&port->lock, &port_lock_key);
> >  
> >  	memset(&termios, 0, sizeof(struct termios));
> >  
> > @@ -2255,7 +2261,7 @@ int uart_add_one_port(struct uart_driver
> >  	 * initialised.
> >  	 */
> >  	if (!(uart_console(port) && (port->cons->flags & CON_ENABLED)))
> > -		spin_lock_init(&port->lock);
> > +		spin_lock_init_key(&port->lock, &port_lock_key);
> >  
> >  	uart_configure_port(drv, state, port);
> >  
> 
> Is there a cleaner way of doing this?
> 
> Perhaps write a new helper function which initialises the spinlock, 
> call that?  Rather than open-coding lockdep stuff?

yes, we can do that too - but that would have an effect to non-lockdep 
kernels too.

Also, the initialization of the 'port' seems a bit twisted here, already 
initialized and not-yet-initialized ports can be passed in to 
uard_add_one_port(). So i did not want to touch the structure of the 
code - hence the open-coded solution.

	Ingo
