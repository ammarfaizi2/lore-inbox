Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266782AbUHIR2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266782AbUHIR2s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 13:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266783AbUHIR2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 13:28:48 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:41689 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S266782AbUHIR2n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 13:28:43 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Max Asbock <masbock@us.ibm.com>
Subject: Re: [PATCH] ibmasm: add missing pci_enable_device()
Date: Mon, 9 Aug 2004 11:28:35 -0600
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200408041532.55146.bjorn.helgaas@hp.com> <1092071925.3711.17.camel@w-amax>
In-Reply-To: <1092071925.3711.17.camel@w-amax>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408091128.35896.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 August 2004 11:18 am, Max Asbock wrote:
> I tested this on the hardware. It works fine.
> Is there any reason we shouldn't use dev_err() for the pci_enable error
> message like in the other messages?

That would probably be fine, too.  ISTR looking at one case where the
printk wrapper wouldn't work quite right if pci_enable_device() failed.
But dev_err() looks like it should work fine.

> regards,
> max
> 
> On Wed, 2004-08-04 at 14:32, Bjorn Helgaas wrote:
> > I don't have this hardware, so this has not been tested.
> > 
> > 
> > Add pci_enable_device()/pci_disable_device().  In the past, drivers
> > often worked without this, but it is now required in order to route
> > PCI interrupts correctly.
> > 
> > Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> > 
> > ===== drivers/misc/ibmasm/module.c 1.2 vs edited =====
> > --- 1.2/drivers/misc/ibmasm/module.c	2004-05-14 06:00:50 -06:00
> > +++ edited/drivers/misc/ibmasm/module.c	2004-08-04 13:15:46 -06:00
> > @@ -62,10 +62,17 @@
> >  	int result = -ENOMEM;
> >  	struct service_processor *sp;
> >  
> > +	if (pci_enable_device(pdev)) {
> > +		printk(KERN_ERR "%s: can't enable PCI device at %s\n",
> > +			DRIVER_NAME, pci_name(pdev));
> > +		return -ENODEV;
> > +	}
> > +
> >  	sp = kmalloc(sizeof(struct service_processor), GFP_KERNEL);
> >  	if (sp == NULL) {
> >  		dev_err(&pdev->dev, "Failed to allocate memory\n");
> > -		return result;
> > +		result = -ENOMEM;
> > +		goto error_kmalloc;
> >  	}
> >  	memset(sp, 0, sizeof(struct service_processor));
> >  
> > @@ -148,6 +155,8 @@
> >  	ibmasm_event_buffer_exit(sp);
> >  error_eventbuffer:
> >  	kfree(sp);
> > +error_kmalloc:
> > +	pci_disable_device(pdev);
> >  
> >  	return result;
> >  }
> > @@ -166,6 +175,7 @@
> >  	iounmap(sp->base_address);
> >  	ibmasm_event_buffer_exit(sp);
> >  	kfree(sp);
> > +	pci_disable_device(pdev);
> >  }
> >  
> >  static struct pci_device_id ibmasm_pci_table[] =
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> > 
> 
> 
