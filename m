Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932735AbWBUU4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932735AbWBUU4k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 15:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932766AbWBUU4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 15:56:40 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:2760 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S932735AbWBUU4j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 15:56:39 -0500
Date: Tue, 21 Feb 2006 12:56:40 -0800
From: Greg KH <greg@kroah.com>
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       akpm@osdl.org, ak@suse.de, rmk+lkml@arm.linux.org.uk
Subject: Re: [PATCH 3/6] PCI legacy I/O port free driver (take2) - Add device_flags into pci_device_id
Message-ID: <20060221205640.GA12423@kroah.com>
References: <43FAB283.8090206@jp.fujitsu.com> <43FAB375.2020007@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FAB375.2020007@jp.fujitsu.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 03:30:13PM +0900, Kenji Kaneshige wrote:
> This patch adds the device_flags field into struct pci_device_id to
> enables pci device drivers to pass per device ID flags to the
> kernel. This patch also defines the PCI_DEVICE_ID_FLAG_NOIOPOT flag of
> the device_flags field which is used to tell the kernel whether the
> driver need to use I/O port regions to handle the device.
> 
> Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
> 
> ---
>  drivers/pci/pci-driver.c        |   14 +++++++++++---
>  include/linux/mod_devicetable.h |    3 +++
>  2 files changed, 14 insertions(+), 3 deletions(-)
> 
> Index: linux-2.6.16-rc4/drivers/pci/pci-driver.c
> ===================================================================
> --- linux-2.6.16-rc4.orig/drivers/pci/pci-driver.c	2006-02-21 14:40:55.000000000 +0900
> +++ linux-2.6.16-rc4/drivers/pci/pci-driver.c	2006-02-21 14:40:55.000000000 +0900
> @@ -43,13 +43,13 @@
>  	struct pci_dynid *dynid;
>  	struct pci_driver *pdrv = to_pci_driver(driver);
>  	__u32 vendor=PCI_ANY_ID, device=PCI_ANY_ID, subvendor=PCI_ANY_ID,
> -		subdevice=PCI_ANY_ID, class=0, class_mask=0;
> +		subdevice=PCI_ANY_ID, class=0, class_mask=0, device_flags=0;
>  	unsigned long driver_data=0;
>  	int fields=0;
>  
> -	fields = sscanf(buf, "%x %x %x %x %x %x %lx",
> +	fields = sscanf(buf, "%x %x %x %x %x %x %lx %x",
>  			&vendor, &device, &subvendor, &subdevice,
> -			&class, &class_mask, &driver_data);
> +			&class, &class_mask, &driver_data, &device_flags);
>  	if (fields < 0)
>  		return -EINVAL;
>  
> @@ -67,6 +67,7 @@
>  	dynid->id.class_mask = class_mask;
>  	dynid->id.driver_data = pdrv->dynids.use_driver_data ?
>  		driver_data : 0UL;
> +	dynid->id.device_flags = device_flags;
>  
>  	spin_lock(&pdrv->dynids.lock);
>  	list_add_tail(&pdrv->dynids.list, &dynid->node);
> @@ -170,6 +171,12 @@
>  	return NULL;
>  }
>  
> +static inline void pci_extract_per_id_flags(struct pci_dev *dev,
> +					    const struct pci_device_id *id)
> +{
> +	dev->no_ioport = !!(id->device_flags & PCI_DEVICE_ID_FLAG_NOIOPORT);
> +}
> +
>  static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
>  			  const struct pci_device_id *id)
>  {
> @@ -189,6 +196,7 @@
>  	current->mempolicy = &default_policy;
>  	mpol_get(current->mempolicy);
>  #endif
> +	pci_extract_per_id_flags(dev, id);
>  	error = drv->probe(dev, id);
>  #ifdef CONFIG_NUMA
>  	set_cpus_allowed(current, oldmask);
> Index: linux-2.6.16-rc4/include/linux/mod_devicetable.h
> ===================================================================
> --- linux-2.6.16-rc4.orig/include/linux/mod_devicetable.h	2006-02-21 14:40:46.000000000 +0900
> +++ linux-2.6.16-rc4/include/linux/mod_devicetable.h	2006-02-21 14:40:55.000000000 +0900
> @@ -19,8 +19,11 @@
>  	__u32 subvendor, subdevice;	/* Subsystem ID's or PCI_ANY_ID */
>  	__u32 class, class_mask;	/* (class,subclass,prog-if) triplet */
>  	kernel_ulong_t driver_data;	/* Data private to the driver */
> +	__u32 device_flags;		/* Per device ID flags (See below) */

I don't think you can add fields here, after the driver_data field.  It
might mess up userspace tools a lot, as you are changing a userspace
api.

Do you _really_ need to pass this information back from userspace to the
driver in this manner?

thanks,

greg k-h
