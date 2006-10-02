Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965301AbWJBTLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965301AbWJBTLS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 15:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965363AbWJBTLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 15:11:17 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:34351 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965356AbWJBTLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 15:11:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=DRbAk+dlxa2nTCHk0LvGQH/XUbA3if0fKKlylohbYSReJBN1aY4DLjshxjgaXUQTGbDTNN/Nh/Cn3WGcf9/zpHKiasxnJtpzGR8WE5kF7Suabc6Ixjhpjae1BNNusRtk3/Grrz4BGvV2/4YH4J/U8x85y3vbASbEv/Jbz5rq97I=
Date: Mon, 2 Oct 2006 21:09:49 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-scsi@vger.kernel.org,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>,
       "J.A. Magall??n" <jamagallon@ono.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFC PATCH] pci_request_irq (was [-mm patch] aic7xxx: check irq validity)
Message-ID: <20061002210949.GJ3003@slug>
References: <20060929235054.GB2020@slug> <1159573404.13029.96.camel@localhost.localdomain> <20060930140946.GA1195@slug> <451F049A.1010404@garzik.org> <20061001142807.GD16272@parisc-linux.org> <1159729523.2891.408.camel@laptopd505.fenrus.org> <20061001193616.GF16272@parisc-linux.org> <1159755141.2891.434.camel@laptopd505.fenrus.org> <20061002200048.GC3003@slug> <20061002181522.GL16272@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061002181522.GL16272@parisc-linux.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2006 at 12:15:22PM -0600, Matthew Wilcox wrote:
> On Mon, Oct 02, 2006 at 08:00:48PM +0000, Frederik Deweerdt wrote:
> >  /**
> > + * pci_request_irq - Reserve an IRQ for a PCI device
> > + * @pdev: The PCI device whose irq is to be reserved
> > + * handler: The interrupt handler function,
> 
> > + * pci_get_drvdata(pdev) shall be passed as an argument to that function
> 
> I don't think you can (or should) do this.  Move it to the body of the
> comment below.
OK, thanks for pointing this, will do.
> 
> > + * @flags: The flags to be passed to request_irq()
> > + * @name: The name of the device to be associated with the irq
> > + *
> > + * Returns 0 on success, or a negative value on error.  A warning
> > + * message is also printed on failure.
> > + */
> > +int pci_request_irq(struct pci_dev *pdev,
> > +		    irqreturn_t (*handler)(int, void *, struct pt_regs *),
> > +		    unsigned long flags, const char *name)
> > +{
> > +	int rc;
> > +	const char *actual_name = name;
> > +
> > +	rc = is_irq_valid(pdev->irq);
> > +	if (!rc) {
> > +		dev_printk(KERN_ERR, &pdev->dev, "invalid irq #%d\n", pdev->irq);
> > +		return -EINVAL;
> > +	}
> 
> Why is that more readable than
> 
> 	if (!is_irq_valid(pdev->irq)) {
> 		dev_err(&pdev->dev, "invalid irq #%d\n", pdev->irq);
> 		return -EINVAL;
> 	}
> 
Better too.
> > +	if (!actual_name)
> > +		actual_name = pci_name(pdev);
> > +
> > +	return request_irq(pdev->irq, handler, flags | IRQF_SHARED,
> > +			   actual_name, pci_get_drvdata(pdev));
> 
> The driver name is a far more common usage than the pci_name.
> 
> 	return request_irq(pdev->irq, handler, flags | IRQF_SHARED,
> 			name ? name : pdev->driver->name,
> 			pci_get_drvdata(pdev));
OK, thanks for the feedback,
Frederik
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
