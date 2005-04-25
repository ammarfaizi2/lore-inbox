Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262772AbVDYUMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbVDYUMv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 16:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262779AbVDYUMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 16:12:50 -0400
Received: from HELIOUS.MIT.EDU ([18.248.3.87]:42153 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S262772AbVDYUMZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 16:12:25 -0400
Date: Mon, 25 Apr 2005 16:08:25 -0400
From: Adam Belay <ambx1@neo.rr.com>
To: Greg KH <greg@kroah.com>, Pavel Machek <pavel@ucw.cz>
Cc: Amit Gud <gud@eth.net>, Alan Stern <stern@rowland.harvard.edu>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       akpm@osdl.org, jgarzik@pobox.com, cramerj@intel.com,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: Re: [PATCH] PCI: Add pci shutdown ability
Message-ID: <20050425200825.GA3951@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Greg KH <greg@kroah.com>, Pavel Machek <pavel@ucw.cz>,
	Amit Gud <gud@eth.net>, Alan Stern <stern@rowland.harvard.edu>,
	linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
	akpm@osdl.org, jgarzik@pobox.com, cramerj@intel.com,
	USB development list <linux-usb-devel@lists.sourceforge.net>,
	Linux-pm mailing list <linux-pm@lists.osdl.org>
References: <Pine.LNX.4.44L0.0504251128070.5751-100000@iolanthe.rowland.org> <20050425182951.GA23209@kroah.com> <SVLXCHCON1syWVLEFN00000099e@SVLXCHCON1.enterprise.veritas.com> <20050425185113.GC23209@kroah.com> <20050425190606.GA23763@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050425190606.GA23763@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2005 at 12:06:06PM -0700, Greg KH wrote:
> Well it seems that people are starting to want to hook the reboot
> notifier, or the device shutdown facility in order to properly shutdown
> pci drivers to make kexec work nicer.
> 
> So here's a patch for the PCI core that allows pci drivers to now just
> add a "shutdown" notifier function that will be called when the system
> is being shutdown.  It happens just after the reboot notifier happens,
> and it should happen in the proper device tree order, so everyone should
> be happy.
> 
> Any objections to this patch?
> 
> thanks,
> 
> greg k-h
> ------

Hi Greg,

I think this could be important for any type of device, so the power
management subsystem and driver core should handle it.  I'm not really
sure if it's useful in pci alone, as it lacks the necessary ordering and
coordination.

I'm currently developing an interface for quieting devices without turning
them off in my Power Management model.  Pavel seems to also have plans along
those lines:

(from the current pm.h)
> * There are 4 important states driver can be in:
> * ON     -- driver is working
> * FREEZE -- stop operations and apply whatever policy is applicable to a suspended driver
> *           of that class, freeze queues for block like IDE does, drop packets for
> *           ethernet, etc... stop DMA engine too etc... so a consistent image can be
> *           saved; but do not power any hardware down.
> * SUSPEND - like FREEZE, but hardware is doing as much powersaving as possible. Roughly
> *           pci D3.

Thanks,
Adam

> 
> PCI: Add pci shutdown ability
> 
> Now pci drivers can know when the system is going down without having to
> add a reboot notifier event.
> 
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> --- gregkh-2.6.orig/include/linux/pci.h	2005-04-20 21:25:11.000000000 -0700
> +++ gregkh-2.6/include/linux/pci.h	2005-04-25 11:54:20.000000000 -0700
> @@ -671,6 +671,7 @@
>  	int  (*suspend) (struct pci_dev *dev, pm_message_t state);	/* Device suspended */
>  	int  (*resume) (struct pci_dev *dev);	                /* Device woken up */
>  	int  (*enable_wake) (struct pci_dev *dev, pci_power_t state, int enable);   /* Enable wake event */
> +	void (*shutdown) (struct pci_dev *dev);
>  
>  	struct device_driver	driver;
>  	struct pci_dynids dynids;
> Index: gregkh-2.6/drivers/pci/pci-driver.c
> ===================================================================
> --- gregkh-2.6.orig/drivers/pci/pci-driver.c	2005-04-06 11:47:47.000000000 -0700
> +++ gregkh-2.6/drivers/pci/pci-driver.c	2005-04-25 12:02:12.000000000 -0700
> @@ -318,6 +318,14 @@
>  	return 0;
>  }
>  
> +static void pci_device_shutdown(struct device *dev)
> +{
> +	struct pci_dev *pci_dev = to_pci_dev(dev);
> +	struct pci_driver *drv = pci_dev->driver;
> +
> +	if (drv && drv->shutdown)
> +		drv->shutdown(pci_dev);
> +}
>  
>  #define kobj_to_pci_driver(obj) container_of(obj, struct device_driver, kobj)
>  #define attr_to_driver_attribute(obj) container_of(obj, struct driver_attribute, attr)
> @@ -385,6 +393,7 @@
>  	drv->driver.bus = &pci_bus_type;
>  	drv->driver.probe = pci_device_probe;
>  	drv->driver.remove = pci_device_remove;
> +	drv->driver.shutdown = pci_device_shutdown,
>  	drv->driver.owner = drv->owner;
>  	drv->driver.kobj.ktype = &pci_driver_kobj_type;
>  	pci_init_dynids(&drv->dynids);
> -

