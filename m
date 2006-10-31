Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423796AbWJaSzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423796AbWJaSzK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 13:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423794AbWJaSzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 13:55:10 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:29345 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1423805AbWJaSzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 13:55:08 -0500
Date: Tue, 31 Oct 2006 11:55:07 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: linux-scsi@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: PCI Error Recovery: Symbios SCSI device driver
Message-ID: <20061031185506.GE26964@parisc-linux.org>
References: <20061020180510.GN6537@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061020180510.GN6537@austin.ibm.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2006 at 01:05:10PM -0500, Linas Vepstas wrote:
> Index: linux-2.6.19-rc1-git11/drivers/scsi/sym53c8xx_2/sym_glue.c
> ===================================================================
> --- linux-2.6.19-rc1-git11.orig/drivers/scsi/sym53c8xx_2/sym_glue.c	2006-10-20 12:25:11.000000000 -0500
> +++ linux-2.6.19-rc1-git11/drivers/scsi/sym53c8xx_2/sym_glue.c	2006-10-20 12:41:15.000000000 -0500
> @@ -659,6 +659,11 @@ static irqreturn_t sym53c8xx_intr(int ir
>  
>  	if (DEBUG_FLAGS & DEBUG_TINY) printf_debug ("[");
>  
> +	/* Avoid spinloop trying to handle interrupts on frozen device */
> +	if ((np->s.device->error_state != pci_channel_io_normal) &&
> +	    (np->s.device->error_state != 0))
> +		return IRQ_HANDLED;
> +

This needs to be before the printf_debug call.

> @@ -726,6 +731,19 @@ static int sym_eh_handler(int op, char *
>  
>  	dev_warn(&cmd->device->sdev_gendev, "%s operation started.\n", opname);
>  
> +	/* We may be in an error condition because the PCI bus
> +	 * went down. In this case, we need to wait until the
> +	 * PCI bus is reset, the card is reset, and only then
> +	 * proceed with the scsi error recovery.  There's no
> +	 * point in hurrying; take a leisurely wait.
> +	 */
> +#define WAIT_FOR_PCI_RECOVERY	35
> +	if ((np->s.device->error_state != pci_channel_io_normal) &&
> +	    (np->s.device->error_state != 0) &&
> +	    (wait_for_completion_timeout(&np->s.io_reset_wait,
> +		                         WAIT_FOR_PCI_RECOVERY*HZ) == 0))
> +			return SCSI_FAILED;
> +

Is it safe / reasonable / a good idea to sleep for 35 seconds in the EH
handler?  I'm not that familiar with how the EH code works.  It has its
own thread, so I suppose that's OK.

Are the driver's data structures still intact after a reset?

I generally prefer not to be so perlish in conditionals, ie:

	if ((np->s.device->error_state != pci_channel_io_normal) &&
	    (np->s.device->error_state != 0) {
		int timed_out = wait_for_completion_timeout(
			&np->s.io_reset_wait, WAIT_FOR_PCI_RECOVERY*HZ);
		if (!timed_out)
			return SCSI_FAILED;
	}

Why is the condition so complicated though?  What does 0 mean if it's
not io_normal?  At least let's hide that behind a convenience macro:

	if (abnormal_error_state(np->s.device->error_state)) {
		...
	}

> Index: linux-2.6.19-rc1-git11/drivers/scsi/sym53c8xx_2/sym_hipd.c
> ===================================================================
> --- linux-2.6.19-rc1-git11.orig/drivers/scsi/sym53c8xx_2/sym_hipd.c	2006-10-20 12:25:11.000000000 -0500
> +++ linux-2.6.19-rc1-git11/drivers/scsi/sym53c8xx_2/sym_hipd.c	2006-10-20 12:41:16.000000000 -0500
> @@ -2761,6 +2761,7 @@ void sym_interrupt (struct sym_hcb *np)
>  	u_char	istat, istatc;
>  	u_char	dstat;
>  	u_short	sist;
> +	u_int    icnt;

The cryptic names in this routine are actually register names.  Calling
a counter 'icnt' is unhelpful (rather than fitting in with the style).
Just 'i' will do.

>  	/*
>  	 *  interrupt on the fly ?
> @@ -2802,6 +2803,7 @@ void sym_interrupt (struct sym_hcb *np)
>  	sist	= 0;
>  	dstat	= 0;
>  	istatc	= istat;
> +	icnt = 0;
>  	do {
>  		if (istatc & SIP)
>  			sist  |= INW(np, nc_sist);
> @@ -2809,6 +2811,14 @@ void sym_interrupt (struct sym_hcb *np)
>  			dstat |= INB(np, nc_dstat);
>  		istatc = INB(np, nc_istat);
>  		istat |= istatc;
> +
> +		/* Prevent deadlock waiting on a condition that may never clear. */
> +		icnt ++;
> +		if (icnt > 100) {
> +			if ((np->s.device->error_state != pci_channel_io_normal)
> +			   && (np->s.device->error_state != 0))
> +				return;
> +		}
>  	} while (istatc & (SIP|DIP));

Though, since INB and INW will return 0xff and 0xffff, why not use that
as our test rather than using a counter?

		if (sist == 0xffff && dstat == 0xff) {
			if (abnormal_error_state(np->s.device->error_state)
				return;
		}
