Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263241AbTJaLqU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 06:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263256AbTJaLqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 06:46:20 -0500
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:10761 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263241AbTJaLqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 06:46:18 -0500
Date: Fri, 31 Oct 2003 11:46:17 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org, garloff@suse.de, matthias.andree@gmx.de,
       gl@dsa-ac.de
Subject: Re: [PATCH] Re: AMD 53c974 SCSI driver in 2.6
Message-ID: <20031031114616.A16435@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	linux-kernel@vger.kernel.org, garloff@suse.de,
	matthias.andree@gmx.de, gl@dsa-ac.de
References: <20031031094645.A14820@infradead.org> <24432.1067599508@www47.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <24432.1067599508@www47.gmx.net>; from g.liakhovetski@gmx.de on Fri, Oct 31, 2003 at 12:25:08PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 31, 2003 at 12:25:08PM +0100, Guennadi Liakhovetski wrote:
> (Replying fromo the web-interface, hope, the email will not be scrued up 
> completely).

Seems fine.

> > Any reason you fix this driver?  The tmcsim one for the same hardware
> > looks like much better structured (though a bit obsufacted :))?
> 
> This is the easiest to asnwer: Kurt Garloff wrote to me, saying that he 
> would fix the tmcsim driver, so, I didn't want to duplicate the work. Also, 
> I was considering this mostly as a fun-excersice, not really hoping / aiming

Ah, okay.

> > > +#ifdef AM53C974_MULTIPLE_CARD
> > > +#error "FIXME! Multiple card support is broken. Looks like it never
> > really worked. Might have to be fixed."
> > >  static struct Scsi_Host *first_host;	/* Head of list of AMD boards */
> > > +#endif
> > 
> > Why do you need the undef?  It looks like you need to kill a #define for
> > this symbol somewhere else :)
> 
> So that, when it is fixed, somebody can easily switch it on / off:-)

Then just comment ou the #define.  Rule of the thumb:  #undef always means
you screwed up elsewhere :)

> 
> > > -	save_flags(flags);
> > > -	cli();
> > > +	local_irq_save(flags);
> > 
> > That's not safe on SMP, you must mark the driver BROKEN_ON_SMP or better
> > fix this.
> 
> Yes. Again - the fix was pretty much mechanical. I didn't understand why it
> was considered SMP-safe to just disable local interrupts, so, just preferred
> to go the "minimal modifications" path.

cli() disabled all intereupts in 2.4 which was safe, you only disable local
interrupts which is ok on UP but doesn't work on SMP.  The right fix would
be to introduce spinlocks.  But given the driver design this might be
everything but easy - that's why I think killing the driver in favour of tmcsim
might be the better idea.

> > Not sure whether you're interested in fixing this, but the proper way
> > to fix that would be to call request_irq for each card, mark the irq's
> > sharable.  The irq handler then can use the void * argument to find the
> > right host and you can kill all this ugly host list walking.  That shold
> > get multiple host support working again in theory  (ok, except that the
> > driver has a totally broken single state machine..)
> 
> Sure - in irq-handler. But are these lists needed anywhere else, where a
> function is called in an "abstract" context without a dev-pointer? Probably,
> not.

A poper driver shouldn't do that, but we already know this one isn't..

> > >  	if (cmd->use_sg) {
> > >  		cmd->SCp.buffer = (struct scatterlist *) cmd->buffer;
> > >  		cmd->SCp.buffers_residual = cmd->use_sg - 1;
> > > -		cmd->SCp.ptr = (char *) cmd->SCp.buffer->address;
> > > +		cmd->SCp.ptr = (char *) page_address(cmd->SCp.buffer->page) +
> > cmd->SCp.buffer->offset;
> > 
> > This means you need a dma_mask < highmem to work.  I don't think we
> > want such crude hacks merged, could you please convert it to the proper
> > dma API?
> 
> Found in a "working" driver (which has to be fixed too, then). Will try to 
> find a proper fix (for the new driver).

Oh.  What driver did you find this construct in?

