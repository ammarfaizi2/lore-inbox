Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030600AbWJCWPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030600AbWJCWPJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 18:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030602AbWJCWPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 18:15:08 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:44932 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030600AbWJCWPG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 18:15:06 -0400
Message-ID: <4522E0E0.9020404@garzik.org>
Date: Tue, 03 Oct 2006 18:14:56 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Frederik Deweerdt <deweerdt@free.fr>
CC: linux-kernel@vger.kernel.org, arjan@infradead.org, matthew@wil.cx,
       alan@lxorguk.ukuu.org.uk, akpm@osdl.org, rdunlap@xenotime.net,
       gregkh@suse.de
Subject: Re: [RFC PATCH] add pci_{request,free}_irq take #2
References: <20061003220732.GE2785@slug>
In-Reply-To: <20061003220732.GE2785@slug>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frederik Deweerdt wrote:
> +int pci_request_irq(struct pci_dev *pdev,
> +		    irqreturn_t(*handler) (int, void *, struct pt_regs *),
> +		    unsigned long flags, const char *name)
> +{
> +	if (!is_irq_valid(pdev->irq)) {
> +		dev_printk(KERN_ERR, &pdev->dev,
> +			   "No usable irq line was found (got #%d)\n",
> +			   pdev->irq);
> +		return -EINVAL;
> +	}
> +
> +	return request_irq(pdev->irq, handler, flags,
> +			   name ? name : pdev->driver->name,
> +			   pci_get_drvdata(pdev));
> +}
> +EXPORT_SYMBOL(pci_request_irq);

> +void pci_free_irq(struct pci_dev *pdev)
> +{
> +	free_irq(pdev->irq, pci_get_drvdata(pdev));
> +}
> +EXPORT_SYMBOL(pci_free_irq);

ACK these parts


> Index: 2.6.18-mm3/include/linux/interrupt.h
> ===================================================================
> --- 2.6.18-mm3.orig/include/linux/interrupt.h
> +++ 2.6.18-mm3/include/linux/interrupt.h
> @@ -75,6 +75,13 @@ struct irqaction {
>  	struct proc_dir_entry *dir;
>  };
>  
> +#ifndef ARCH_VALIDATE_PCI_IRQ
> +static inline int is_irq_valid(unsigned int irq)
> +{
> +	return irq ? 1 : 0;
> +}
> +#endif /* ARCH_VALIDATE_PCI_IRQ */

It's not appropriate to have PCI IRQ stuff in linux/interrupt.h.

This is precisely why I passed 'struct pci_dev *' to a PCI-specific irq 
validation function, and prototyped it in linux/pci.h.

	Jeff


