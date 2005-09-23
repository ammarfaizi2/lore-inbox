Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbVIWQwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbVIWQwA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 12:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbVIWQv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 12:51:59 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:34239 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1751114AbVIWQv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 12:51:59 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Daniel Ritz <daniel.ritz@gmx.ch>
Subject: Re: 2.6.13-mm2
Date: Fri, 23 Sep 2005 18:52:15 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Hugh Dickins <hugh@veritas.com>
References: <20050908053042.6e05882f.akpm@osdl.org> <200509121209.47736.rjw@sisk.pl> <200509182349.17632.daniel.ritz@gmx.ch>
In-Reply-To: <200509182349.17632.daniel.ritz@gmx.ch>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509231852.15950.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[sorry for the delay]

On Sunday, 18 of September 2005 23:49, Daniel Ritz wrote:
]--snip--[
> > 
> > BTW, please have a look at:
> > http://bugzilla.kernel.org/show_bug.cgi?id=4416#c36
> > and
> > http://bugzilla.kernel.org/show_bug.cgi?id=4416#c37
> > 
> 
> interesting. i'd say we get interrupt storms from usb which then hurt when
> yenta has it's handler installed but usb has not. usb/hcd-pci.c frees the
> irq on suspend...so it may be enough not to do that (survives suspend-to-ram
> and suspend-to-disk here. yes, restore too :)
> 
> could you give that a tree w/o any free_irq-patches for yenta and co?

I've tried and it apparently works provided that _none_ of the IRQ-sharing
devices drops the IRQ on suspend.

I think that's the whole point: Either all of the devices should drop/request
IRQs on suspend/resume, or none of them should do this.  IMHO we need to
chose one of these options and call it "the right way" or there always
will be problems with this.

Greetings,
Rafael


> diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
> --- a/drivers/usb/core/hcd-pci.c
> +++ b/drivers/usb/core/hcd-pci.c
> @@ -242,7 +242,9 @@ int usb_hcd_pci_suspend (struct pci_dev 
>  	case HC_STATE_SUSPENDED:
>  		/* no DMA or IRQs except when HC is active */
>  		if (dev->current_state == PCI_D0) {
> +#if 0
>  			free_irq (hcd->irq, hcd);
> +#endif
>  			pci_save_state (dev);
>  			pci_disable_device (dev);
>  		}
> @@ -374,6 +376,7 @@ int usb_hcd_pci_resume (struct pci_dev *
>  
>  	hcd->state = HC_STATE_RESUMING;
>  	hcd->saw_irq = 0;
> +#if 0
>  	retval = request_irq (dev->irq, usb_hcd_irq, SA_SHIRQ,
>  				hcd->irq_descr, hcd);
>  	if (retval < 0) {
> @@ -382,6 +385,7 @@ int usb_hcd_pci_resume (struct pci_dev *
>  		usb_hc_died (hcd);
>  		return retval;
>  	}
> +#endif
>  
>  	retval = hcd->driver->resume (hcd);
>  	if (!HC_IS_RUNNING (hcd->state)) {
> 
> 

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
