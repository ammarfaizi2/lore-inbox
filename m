Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263136AbTJaJqt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 04:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263142AbTJaJqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 04:46:49 -0500
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:2823 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263136AbTJaJqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 04:46:47 -0500
Date: Fri, 31 Oct 2003 09:46:45 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org, Kurt Garloff <garloff@suse.de>,
       Matthias Andree <matthias.andree@gmx.de>
Subject: Re: [PATCH] Re: AMD 53c974 SCSI driver in 2.6
Message-ID: <20031031094645.A14820@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	linux-kernel@vger.kernel.org, Kurt Garloff <garloff@suse.de>,
	Matthias Andree <matthias.andree@gmx.de>
References: <Pine.LNX.4.44.0310262035270.3346-100000@poirot.grange> <Pine.LNX.4.44.0310302221400.5533-100000@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0310302221400.5533-100000@poirot.grange>; from g.liakhovetski@gmx.de on Thu, Oct 30, 2003 at 11:12:57PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any reason you fix this driver?  The tmcsim one for the same hardware
looks like much better structured (though a bit obsufacted :))?

> +#include <linux/version.h>

What do you need version.h for?

> +#undef AM53C974_MULTIPLE_CARD
> +#ifdef AM53C974_MULTIPLE_CARD
> +#error "FIXME! Multiple card support is broken. Looks like it never really worked. Might have to be fixed."
>  static struct Scsi_Host *first_host;	/* Head of list of AMD boards */
> +#endif

Why do you need the undef?  It looks like you need to kill a #define for
this symbol somewhere else :)

> -	save_flags(flags);
> -	cli();
> +	local_irq_save(flags);

That's not safe on SMP, you must mark the driver BROKEN_ON_SMP or better fix
this.

>  static void AM53C974_print(struct Scsi_Host *instance)
>  {
>  	AM53C974_local_declare();
> +#if 0 /* Called only from error-handling paths with sufficient protection? */
>  	unsigned long flags;
> +#endif

So don't if 0 it but completely kill it.

>  /* Set up an interrupt handler if we aren't already sharing an IRQ with another board */
> +#ifdef AM53C974_MULTIPLE_CARD
>  	for (search = first_host;
>  	     search && (((the_template != NULL) && (search->hostt != the_template)) ||
>  		 (search->irq != instance->irq) || (search == instance));
>  	     search = search->next);
>  	if (!search) {
> +#endif

Not sure whether you're interested in fixing this, but the proper way
to fix that would be to call request_irq for each card, mark the irq's
sharable.  The irq handler then can use the void * argument to find the
right host and you can kill all this ugly host list walking.  That shold
get multiple host support working again in theory  (ok, except that the
driver has a totally broken single state machine..)

>  	if (cmd->use_sg) {
>  		cmd->SCp.buffer = (struct scatterlist *) cmd->buffer;
>  		cmd->SCp.buffers_residual = cmd->use_sg - 1;
> -		cmd->SCp.ptr = (char *) cmd->SCp.buffer->address;
> +		cmd->SCp.ptr = (char *) page_address(cmd->SCp.buffer->page) + cmd->SCp.buffer->offset;

This means you need a dma_mask < highmem to work.  I don't think we
want such crude hacks merged, could you please convert it to the proper
dma API?

