Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031244AbWI0XVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031244AbWI0XVS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 19:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031245AbWI0XVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 19:21:18 -0400
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206]:39545 "HELO
	smtp107.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1031244AbWI0XVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 19:21:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=QGaYKaJztISYaEMGN2EYpu6eYPo2l0DGJ5HY5Mhi70UQ2FAncsjmqbPLArNz9IZoZiHnknJXV2yK3SqaplqCwrM5+AKRGLPxOGeZdx98m5usr+o7u+GgWh8DetLibrkmw9PFL51c5ahqdCIFJjem6woPxIE5INOH48lYit7aYWU=  ;
From: David Brownell <david-b@pacbell.net>
To: tglx@linutronix.de
Subject: Re: [patch 2.6.18] genirq: remove oops with fasteoi irq_chip descriptors
Date: Wed, 27 Sep 2006 16:21:10 -0700
User-Agent: KMail/1.7.1
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, mingo@redhat.com
References: <200609220641.58938.david-b@pacbell.net> <200609220643.07750.david-b@pacbell.net> <1159393098.9326.546.camel@localhost.localdomain>
In-Reply-To: <1159393098.9326.546.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609271621.11608.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 September 2006 2:38 pm, Thomas Gleixner wrote:
> On Fri, 2006-09-22 at 06:43 -0700, David Brownell wrote:
> > The irq handler code can oops when used with an irq_chip with just
> > enable/disable/eoi methods, appropriate for handle_fasteoi_irq(),
> > either by (a) uninstalling, or (b) using it with a chained handler.
> > 
> > The problem was that the original code expected there would always
> > be mask/unmask/ack methods, and the fix is to instead use methods
> > which are always present and which more closely correspond to the
> > flag manipulation being done.
> > 
> > Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> 
> NACK. 

Explain yourself then ...


> # grep startup kernel/irq/manage.c
> 307:                    if (desc->chip->startup)
> 308:                            desc->chip->startup(irq);
> 
> # grep shutdown kernel/irq/manage.c
> 386:                            if (desc->chip->shutdown)
> 387:                                    desc->chip->shutdown(irq);
> 
> startup() and shutdown() are optional and mostly there to keep the not
> converted do_IRQ() users working.

As you should know, irq_chip_set_defaults() ensures that every
irqchip has startup() and shutdown() methods.  Their default
implementations use enable() and disable() ... which in turn
have default implementations using mask()/unmask(), for use
with non-EIO handlers. 

So what's the correct fix then ... use enable() and disable()?
Oopsing isn't OK...


> This patch will simply break _all_ ARM and PowerPC in one go and as well
> the i386 and x86_64 conversion which is in -mm.

I can understand breaking patches in MM that I've not seen, but not about
breaking anything else.

It was certainly _tested_ on a 2.6.18 ARM board, so you're clearly wrong
about at least that part of your feedback as well as the bits about the
shartup and shutdown calls being "optional" (in any practical sense, since
they are in fact _always_ present).

- Dave


> 	tglx
> 
> > --- d26.rc4test.orig/kernel/irq/chip.c	2006-09-21 16:41:11.000000000 -0700
> > +++ d26.rc4test/kernel/irq/chip.c	2006-09-21 18:04:07.000000000 -0700
> > @@ -482,10 +482,8 @@ __set_irq_handler(unsigned int irq,
> >  
> >  	/* Uninstall? */
> >  	if (handle == handle_bad_irq) {
> > -		if (desc->chip != &no_irq_chip) {
> > -			desc->chip->mask(irq);
> > -			desc->chip->ack(irq);
> > -		}
> > +		if (desc->chip != &no_irq_chip)
> > +			desc->chip->shutdown(irq);
> >  		desc->status |= IRQ_DISABLED;
> >  		desc->depth = 1;
> >  	}
> > @@ -495,7 +493,7 @@ __set_irq_handler(unsigned int irq,
> >  		desc->status &= ~IRQ_DISABLED;
> >  		desc->status |= IRQ_NOREQUEST | IRQ_NOPROBE;
> >  		desc->depth = 0;
> > -		desc->chip->unmask(irq);
> > +		desc->chip->startup(irq);
> >  	}
> >  	spin_unlock_irqrestore(&desc->lock, flags);
> >  }
> 
