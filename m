Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263221AbTJaLZU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 06:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263229AbTJaLZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 06:25:20 -0500
Received: from mail.gmx.de ([213.165.64.20]:7601 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263221AbTJaLZK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 06:25:10 -0500
Date: Fri, 31 Oct 2003 12:25:08 +0100 (MET)
From: "Guennadi Liakhovetski" <g.liakhovetski@gmx.de>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, garloff@suse.de, matthias.andree@gmx.de,
       gl@dsa-ac.de
MIME-Version: 1.0
References: <20031031094645.A14820@infradead.org>
Subject: Re: [PATCH] Re: AMD 53c974 SCSI driver in 2.6
X-Priority: 3 (Normal)
X-Authenticated: #20450766
Message-ID: <24432.1067599508@www47.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Replying fromo the web-interface, hope, the email will not be scrued up 
completely).

> Any reason you fix this driver?  The tmcsim one for the same hardware
> looks like much better structured (though a bit obsufacted :))?

This is the easiest to asnwer: Kurt Garloff wrote to me, saying that he 
would fix the tmcsim driver, so, I didn't want to duplicate the work. Also, 
I was considering this mostly as a fun-excersice, not really hoping / aiming

at merging it inthe kernel (also given the current freeze). But now, if Kurt
doesn't mind, I can try fixing the other driver, and, hopefully, with your
help, I'll try to do it properly.

> > +#include <linux/version.h>
> 
> What do you need version.h for?

Yep, I had my changes encapsulated in #if KERNEL_VERSION... first, but then 
I removed them, but forgot to remove this include.

> > +#undef AM53C974_MULTIPLE_CARD
> > +#ifdef AM53C974_MULTIPLE_CARD
> > +#error "FIXME! Multiple card support is broken. Looks like it never
> really worked. Might have to be fixed."
> >  static struct Scsi_Host *first_host;	/* Head of list of AMD boards */
> > +#endif
> 
> Why do you need the undef?  It looks like you need to kill a #define for
> this symbol somewhere else :)

So that, when it is fixed, somebody can easily switch it on / off:-)

> > -	save_flags(flags);
> > -	cli();
> > +	local_irq_save(flags);
> 
> That's not safe on SMP, you must mark the driver BROKEN_ON_SMP or better
> fix this.

Yes. Again - the fix was pretty much mechanical. I didn't understand why it
was considered SMP-safe to just disable local interrupts, so, just preferred
to go the "minimal modifications" path.

> >  static void AM53C974_print(struct Scsi_Host *instance)
> >  {
> >  	AM53C974_local_declare();
> > +#if 0 /* Called only from error-handling paths with sufficient
> protection? */
> >  	unsigned long flags;
> > +#endif
> 
> So don't if 0 it but completely kill it.

There's a "?" there:-) Which means, I wasn't quite sure, so, is my
assumption correct? I just saw, that other drivers do not implement any 
locking in these functions.

> >  /* Set up an interrupt handler if we aren't already sharing an IRQ with
> another board */
> > +#ifdef AM53C974_MULTIPLE_CARD
> >  	for (search = first_host;
> >  	     search && (((the_template != NULL) && (search->hostt !=
> the_template)) ||
> >  		 (search->irq != instance->irq) || (search == instance));
> >  	     search = search->next);
> >  	if (!search) {
> > +#endif
> 
> Not sure whether you're interested in fixing this, but the proper way
> to fix that would be to call request_irq for each card, mark the irq's
> sharable.  The irq handler then can use the void * argument to find the
> right host and you can kill all this ugly host list walking.  That shold
> get multiple host support working again in theory  (ok, except that the
> driver has a totally broken single state machine..)

Sure - in irq-handler. But are these lists needed anywhere else, where a
function is called in an "abstract" context without a dev-pointer? Probably,
not.

> >  	if (cmd->use_sg) {
> >  		cmd->SCp.buffer = (struct scatterlist *) cmd->buffer;
> >  		cmd->SCp.buffers_residual = cmd->use_sg - 1;
> > -		cmd->SCp.ptr = (char *) cmd->SCp.buffer->address;
> > +		cmd->SCp.ptr = (char *) page_address(cmd->SCp.buffer->page) +
> cmd->SCp.buffer->offset;
> 
> This means you need a dma_mask < highmem to work.  I don't think we
> want such crude hacks merged, could you please convert it to the proper
> dma API?

Found in a "working" driver (which has to be fixed too, then). Will try to 
find a proper fix (for the new driver).

So, thanks a lot for commenting on the patch, and, if nobody minds, I'll try
to fix the tmcsim driver, will try to do it better this time:-)

Thanks
Guennadi
---
Guennadi Liakhovetski

