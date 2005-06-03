Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261221AbVFCD34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbVFCD34 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 23:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbVFCD3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 23:29:55 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:58852 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261221AbVFCD3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 23:29:53 -0400
Date: Thu, 2 Jun 2005 20:29:51 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: kumar.gala@freescale.com, linux-kernel@vger.kernel.org,
       linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] cpm_uart: Route SCC2 pins for the STx GP3 board
Message-ID: <20050602202951.A28314@cox.net>
References: <20050601105145.B15351@cox.net> <20050602153540.53486bde.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050602153540.53486bde.akpm@osdl.org>; from akpm@osdl.org on Thu, Jun 02, 2005 at 03:35:40PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2005 at 03:35:40PM -0700, Andrew Morton wrote:
> Matt Porter <mporter@kernel.crashing.org> wrote:
> >
> > +++ uncommitted/drivers/serial/cpm_uart/cpm_uart_cpm2.c  (mode:100644)
> > @@ -134,12 +134,21 @@
> >  
> >  void scc2_lineif(struct uart_cpm_port *pinfo)
> >  {
> > +	/*
> > +	 * STx GP3 uses the SCC2 secondary option pin assignment
> > +	 * which this driver doesn't account for in the static
> > +	 * pin assignments. This kind of board specific info
> > +	 * really has to get out of the driver so boards can
> > +	 * be supported in a sane fashion.
> > +	 */
> > +#ifndef CONFIG_STX_GP3
> >  	volatile iop_cpm2_t *io = &cpm2_immr->im_ioport;
> >  	io->iop_pparb |= 0x008b0000;
> 
> Silly question: why is this driver using a volatile pointer to
> memory-mapped I/O rather than readl and writel?

readl/writel just won't work.  They are byte swapped on PPC since
they are specifically for PCI access.  In other "on-chip" drivers
for PPC32, we typically ioremap() to a non-volatile type and then
use out_be32()/in_be32() since everything except PCI on PPC is
in right-endian (big endian) form. out_be*()/in_be*() contain
an eieio instruction to guarantee proper ordering.

I know this driver was recently rewritten but the authors may have
missed the past threads about why volatile use is discouraged.  We
do something similar with register overlay structures in
drivers/net/ibm_emac. However, we don't use a volatile type and do
use PPC32-specific (these are PPC-specific drivers anyway)
out_be32()/in_be32() for correctness.

-Matt
