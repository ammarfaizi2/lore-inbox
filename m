Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752636AbWKBD5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752636AbWKBD5Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 22:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752639AbWKBD5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 22:57:24 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:1932 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1751679AbWKBD5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 22:57:24 -0500
Date: Wed, 1 Nov 2006 20:57:22 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: linux-scsi@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4]: PCI Error Recovery: Symbios SCSI device driver
Message-ID: <20061102035722.GA31830@parisc-linux.org>
References: <20061020180510.GN6537@austin.ibm.com> <20061031185506.GE26964@parisc-linux.org> <20061031231334.GR6360@austin.ibm.com> <20061102000745.GX6360@austin.ibm.com> <20061102011935.GZ6360@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061102011935.GZ6360@austin.ibm.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2006 at 07:19:37PM -0600, Linas Vepstas wrote:
> @@ -657,6 +657,10 @@ static irqreturn_t sym53c8xx_intr(int ir
>  	unsigned long flags;
>  	struct sym_hcb *np = (struct sym_hcb *)dev_id;
>  
> +	/* Avoid spinloop trying to handle interrupts on frozen device */
> +	if (pci_channel_offline(np->s.device))
> +		return IRQ_HANDLED;
> +
>  	if (DEBUG_FLAGS & DEBUG_TINY) printf_debug ("[");
>  
>  	spin_lock_irqsave(np->s.host->host_lock, flags);

Just wondering ... should we really be returning HANDLED?  What if the
IRQ is shared?  Will the hardware de-assert the level interrupt when it
puts the device in reset (ie is this a transitory glitch?), or do we
have to cope with a screaming interrupt?

> +#define WAIT_FOR_PCI_RECOVERY	35
> +	if (pci_channel_offline(np->s.device))
> +	{

I prefer if () {

> +static pci_ers_result_t sym2_io_slot_reset (struct pci_dev *pdev)
> +{
> +	struct sym_hcb *np = pci_get_drvdata(pdev);
> +
> +	printk(KERN_INFO "%s: recovering from a PCI slot reset\n",
> +	          sym_name(np));
> +
> +	if (pci_enable_device(pdev)) {
> +		printk(KERN_ERR "%s: Unable to enable afer PCI reset\n",
> +		        sym_name(np));
> +		return PCI_ERS_RESULT_DISCONNECT;
> +	}
> +
> +	pci_set_master(pdev);
> +	enable_irq(pdev->irq);

Hm.  If we need to call pci_set_master, then we're also going to need to
call pci_set_mwi (if appropriate) which is currently done in
sym_set_workarounds().  Except you don't have a sym_device, or a
sym_chip around at this point.  Bother.  Need to do some refactoring to
take care of that.

> +		/* Prevent deadlock waiting on a condition that may never clear. */
> +		if (unlikely(sist == 0xffff && dstat == 0xff)) {
> +			if (unlikely(pci_channel_offline(np->s.device)))
> +				return;
> +		}

I like the first unlikely ... but I'd drop the second one.  If they are
both ffff ff, I'd say it's quite likely ;-)  Anyway, the first unlikely
is good enough a hint to GCC, IMO.

Thanks!
