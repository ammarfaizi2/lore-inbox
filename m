Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268717AbUIXMxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268717AbUIXMxe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 08:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268726AbUIXMxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 08:53:34 -0400
Received: from scanner2.mail.elte.hu ([157.181.151.9]:34190 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268717AbUIXMx3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 08:53:29 -0400
Date: Fri, 24 Sep 2004 14:55:00 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: linux-kernel@vger.kernel.org, David Brownell <david-b@pacbell.net>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       David Brownell <dbrownell@users.sourceforge.net>,
       Roman Weissgaerber <weissg@vienna.at>,
       linux-usb-devel@lists.sourceforge.net, "K.R. Foley" <kr@cybsft.com>
Subject: Re: OHCI_QUIRK_INITRESET (was: 2.6.9-rc2-mm2 ohci_hcd doesn't work)
Message-ID: <20040924125500.GB9369@elte.hu>
References: <414F8CFB.3030901@cybsft.com> <20040921071854.GA7604@elte.hu> <20040921074426.GA10477@elte.hu> <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu> <24137.195.245.190.93.1095946528.squirrel@195.245.190.93> <20040923134000.GA15455@elte.hu> <35929.195.245.190.93.1095956611.squirrel@195.245.190.93> <48836.195.245.190.94.1095962870.squirrel@195.245.190.94> <1076.195.245.190.93.1096029825.squirrel@195.245.190.93>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1076.195.245.190.93.1096029825.squirrel@195.245.190.93>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Rui Nuno Capela <rncbc@rncbc.org> wrote:

> Then, in a silent suggestion from David Brownell, I hacked ohci_hcd.c,
> forcing the OHCI_QUIRK_INITRESET flag behaviour, build a new kernel and
> modules and voila', all USB is back to functionality.

> diff -duPNr linux.0/drivers/usb/host/ohci-hcd.c linux.1/drivers/usb/host/ohci-hcd.c
> --- linux.0/drivers/usb/host/ohci-hcd.c	2004-09-24 11:07:00.982690336 +0100
> +++ linux.1/drivers/usb/host/ohci-hcd.c	2004-09-24 11:19:06.232435616 +0100
> @@ -564,11 +564,12 @@
>  	 * (SiS, OPTi ...), so reset again instead.  SiS doesn't need
>  	 * this if we write fmInterval after we're OPERATIONAL.
>  	 */
> -	if (ohci->flags & OHCI_QUIRK_INITRESET) {
> +	 ohci_dbg(ohci, "OHCI_QUIRK_INITRESET forced!\n");
> +/*	if (ohci->flags & OHCI_QUIRK_INITRESET) { */
>  		writel (ohci->hc_control, &ohci->regs->control);
>  		// flush those writes
>  		(void) ohci_readl (&ohci->regs->control);
> -	}
> +/*	} */
>  	writel (ohci->fminterval, &ohci->regs->fminterval);

it would be cleaner to make this dependent on your chipset/vendor-id -
look how OHCI_QUIRK_INITRESET gets activated for e.g. SiS
(PCI_VENDOR_ID_SI) and OPTi (PCI_VENDOR_ID_OPTI). What is your box's
pdev->vendor and pdev->device? (lspci -v) (If it's indeed a quirk that
is needed, not some other fix.)

	Ingo
