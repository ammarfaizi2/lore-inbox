Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262154AbTCHThR>; Sat, 8 Mar 2003 14:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262153AbTCHThR>; Sat, 8 Mar 2003 14:37:17 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:51591 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S262158AbTCHThG>;
	Sat, 8 Mar 2003 14:37:06 -0500
Date: Sat, 8 Mar 2003 20:47:14 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Jeff Garzik <jgarzik@pobox.com>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: PCI driver module unload race?
Message-ID: <20030308194714.GA7340@vana.vc.cvut.cz>
References: <20030308104749.A29145@flint.arm.linux.org.uk> <20030308191237.GA26374@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030308191237.GA26374@kroah.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 08, 2003 at 11:12:37AM -0800, Greg KH wrote:
> On Sat, Mar 08, 2003 at 10:47:49AM +0000, Russell King wrote:
> > Hi,
> > 
> > What prevents the following scenario from happening?  It's purely
> > theoretical - I haven't seen this occuring.
> > 
> > - Load PCI driver.
> > 
> > - PCI driver registers using pci_module_init(), and adds itself to sysfs.
> > 
> > - Hot-plugin a PCI device which uses this driver.  sysfs matches the PCI
> >   driver, and calls the PCI drivers probe function.
> 
> Ugh, yes you are correct, I can't believe I missed this before.
> 
> How does this patch look?

Bad...

What are you trying to solve? After driver calls pci_unregister_driver,
it is sure that there are no other users of this pci driver. So I do
not understand why you are adding these additional protections (and one
in remove looks suspicious to me: if you unplug device while module
in unloading, you do not call remove?! who will call it then? you'll
not get oopses in pci_unregister_driver? leaked memory?). Driver
authors simple have to unregister from subsystems in correct order,
no try_module_get() put anywhere is not going to solve this problem.

There is simple no relation between modules and drivers - and anyone
who is trying to force this is misguided. Driver starts its life
inside call to *_register_*, and ceases in *_unregister_*, not 
somewhere after call to init_module, and before cleanup_module.
And if module registers resources in wrong order, module has to
cope with its stupidity, not kernel (and I have yet to see two
kernel interfaces which cannot be properly ordered for both init 
and shutdown).
						Petr Vandrovec
						vandrove@vc.cvut.cz


> thanks,
> 
> greg k-h
> 
> 
> ===== drivers/pci/pci-driver.c 1.17 vs edited =====
> --- 1.17/drivers/pci/pci-driver.c	Sat Nov 23 13:23:03 2002
> +++ edited/drivers/pci/pci-driver.c	Sat Mar  8 11:21:06 2003
> @@ -48,6 +48,12 @@
>  	if (!pci_dev->driver && drv->probe) {
>  		const struct pci_device_id *id;
>  
> +		if (!try_module_get(drv->owner)) {
> +			dev_err(dev, "Can't get a module reference for %s\n",
> +				drv->name);
> +			error = -ENODEV;
> +			goto exit;
> +		}
>  		id = pci_match_device(drv->id_table, pci_dev);
>  		if (id)
>  			error = drv->probe(pci_dev, id);
> @@ -55,7 +61,9 @@
>  			pci_dev->driver = drv;
>  			error = 0;
>  		}
> +		module_put(drv->owner);
>  	}
> +exit:
>  	return error;
>  }
>  
> @@ -66,7 +74,10 @@
>  
>  	if (drv) {
>  		if (drv->remove)
> -			drv->remove(pci_dev);
> +			if (try_module_get(drv->owner)) {
> +				drv->remove(pci_dev);
> +				module_put(drv->owner);
> +			}
>  		pci_dev->driver = NULL;
>  	}
>  	return 0;
> ===== include/linux/pci.h 1.36 vs edited =====
> --- 1.36/include/linux/pci.h	Tue Mar  4 21:09:58 2003
> +++ edited/include/linux/pci.h	Sat Mar  8 11:20:15 2003
> @@ -493,6 +493,7 @@
>  
>  struct pci_driver {
>  	struct list_head node;
> +	struct module *owner;
>  	char *name;
>  	const struct pci_device_id *id_table;	/* NULL if wants all devices */
>  	int  (*probe)  (struct pci_dev *dev, const struct pci_device_id *id);	/* New device inserted */
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
