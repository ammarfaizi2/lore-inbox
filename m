Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030501AbVI3Xi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030501AbVI3Xi7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 19:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030502AbVI3Xi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 19:38:59 -0400
Received: from mail.kroah.org ([69.55.234.183]:40681 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030501AbVI3Xi7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 19:38:59 -0400
Date: Fri, 30 Sep 2005 16:38:33 -0700
From: Greg KH <greg@kroah.com>
To: daniel.ritz@gmx.ch, David Brownell <david-b@pacbell.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] usb/core/hcd-pci.c: don't free_irq() on suspend
Message-ID: <20050930233833.GA19471@kroah.com>
References: <200509302101.j8UL1Htj026067@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509302101.j8UL1Htj026067@hera.kernel.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<top-post on purpose...>

Daniel, are you sure about this patch (the second part specifically)?
It directly conflicts with a set of patches in my current tree in this
area that fix all of the reported suspend/resume issues with usb host
controllers (that patch series written by David Brownell.)

Yeah, I see that we shouldn't have been dropping the irq on suspend and
getting a new one on resume, that's not good and could have caused
problems for people.

But could you at least drop the linux-usb-devel mailing list a note that
you are having issues, and post the proposed patch?  Directly sending it
to Linus is a bit rude, it's not like the USB developers aren't
responsive to emails (yeah, I've been a bit slow at times these past few
weeks, but my traveling all over the place for the past month is now
over, and I'm not going anywhere for a long time...)

David, this conflicts with your usb/usb-pm-06.patch in my quilt tree.
I'll try to resolve the merge with my best guess, but you should check
that I got it right...

thanks,

greg k-h


On Fri, Sep 30, 2005 at 02:01:17PM -0700, Linux Kernel Mailing List wrote:
> tree 04e9dcf7801245d9a31fcab36dde7dd3a846c86b
> parent 1294b118cb53fb14515666e2b218ad5ab40318c1
> author Daniel Ritz <daniel.ritz@gmx.ch> Thu, 29 Sep 2005 21:39:32 +0200
> committer Linus Torvalds <torvalds@g5.osdl.org> Fri, 30 Sep 2005 23:23:30 -0700
> 
> [PATCH] usb/core/hcd-pci.c: don't free_irq() on suspend
> 
> the free_irq() in USB suspend breaks resume on some setups where USB
> (ohci/ehci) shares the interrupt with an other device.
> 
> Signed-off-by: Daniel Ritz <daniel.ritz@gmx.ch>
> Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> 
>  drivers/usb/core/hcd-pci.c |    9 ---------
>  1 files changed, 9 deletions(-)
> 
> diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
> --- a/drivers/usb/core/hcd-pci.c
> +++ b/drivers/usb/core/hcd-pci.c
> @@ -242,7 +242,6 @@ int usb_hcd_pci_suspend (struct pci_dev 
>  	case HC_STATE_SUSPENDED:
>  		/* no DMA or IRQs except when HC is active */
>  		if (dev->current_state == PCI_D0) {
> -			free_irq (hcd->irq, hcd);
>  			pci_save_state (dev);
>  			pci_disable_device (dev);
>  		}
> @@ -374,14 +373,6 @@ int usb_hcd_pci_resume (struct pci_dev *
>  
>  	hcd->state = HC_STATE_RESUMING;
>  	hcd->saw_irq = 0;
> -	retval = request_irq (dev->irq, usb_hcd_irq, SA_SHIRQ,
> -				hcd->irq_descr, hcd);
> -	if (retval < 0) {
> -		dev_err (hcd->self.controller,
> -			"can't restore IRQ after resume!\n");
> -		usb_hc_died (hcd);
> -		return retval;
> -	}
>  
>  	retval = hcd->driver->resume (hcd);
>  	if (!HC_IS_RUNNING (hcd->state)) {
> -
> To unsubscribe from this list: send the line "unsubscribe git-commits-head" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
