Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbTEFACx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 20:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbTEFACx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 20:02:53 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:4231 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261851AbTEFACv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 20:02:51 -0400
Date: Mon, 5 May 2003 17:15:28 -0700
From: Greg KH <greg@kroah.com>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: alan@redhat.com, linux-kernel@vger.kernel.org, jgarzik@redhat.com
Subject: Re: [RFC][PATCH] Dynamic PCI Device IDs
Message-ID: <20030506001528.GA3945@kroah.com>
References: <20030502231558.GA16209@kroah.com> <Pine.LNX.4.44.0305051734050.25115-100000@humbolt.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305051734050.25115-100000@humbolt.us.dell.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 05, 2003 at 05:51:35PM -0500, Matt Domsch wrote:
> > Ah, can't you just not worry about that driver_data field somehow?  
> 
> How about this?  I've added a 'uses_driver_data' bit to the struct that
> holds the dynids list, and the store_new_id() function always allows
> driver_data to be passed in from userspace, but unless the driver sets
> 'uses_driver_data' (and therefore should check that the values are
> reasonable), it only ever gets passed a 0 there.

I like this patch a _lot_ better, nice job.  Only one comment:

> +/**
> + * store_new_id
> + * @ pdrv
> + * @ buf
> + * @ count
> + *
> + * Adds a new dynamic pci device ID to this driver,
> + * and causes the driver to probe for all devices again.
> + */
> +static inline ssize_t
> +store_new_id(struct device_driver * driver, const char * buf, size_t count)
> +{
> +	struct dynid *dynid;
> +	struct pci_driver *pdrv = to_pci_driver(driver);
> +	__u32 vendor=PCI_ANY_ID, device=PCI_ANY_ID, subvendor=PCI_ANY_ID,
> +		subdevice=PCI_ANY_ID, class=0, class_mask=0;
> +	unsigned long driver_data=0;
> +	int fields=0, error=0;
> +
> +	fields = sscanf(buf, "%x %x %x %x %x %x %lux",
> +			&vendor, &device, &subvendor, &subdevice,
> +			&class, &class_mask, &driver_data);
> +	if (fields < 0) return -EINVAL;
> +
> +	dynid = kmalloc(sizeof(*dynid), GFP_KERNEL);
> +	if (!dynid) return -ENOMEM;
> +	dynid_init(dynid);
> +
> +	dynid->id.vendor = vendor;
> +	dynid->id.device = device;
> +	dynid->id.subvendor = subvendor;
> +	dynid->id.subdevice = subdevice;
> +	dynid->id.class = class;
> +	dynid->id.class_mask = class_mask;
> +	dynid->id.driver_data = pdrv->dynids.use_driver_data ? driver_data : 0UL;
> +
> +	spin_lock(&pdrv->dynids.lock);
> +	list_add(&pdrv->dynids.list, &dynid->node);
> +	spin_unlock(&pdrv->dynids.lock);
> +
> +        if (get_driver(&pdrv->driver)) {
> +                error = probe_each_pci_dev(pdrv);
> +                put_driver(&pdrv->driver);
> +        }
> +        if (error < 0)
> +                return error;
> +        return count;
> +
> +
> +	return count;
> +}

Oops, lost the tabs at the end of the function :)

This function will not link up a device to a driver properly within the
driver core, only with the pci code.  So if you do this, the driver core
still thinks you have a device that is unbound, right?  Also, the
symlinks don't get created from the bus to the device I think, correct?

Unfortunatly, looking at the driver core real quickly, I don't see a
simple way to kick the probe cycle off again for all pci devices, but
I'm probably just missing something somewhere...

thanks,

greg k-h
