Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268113AbUIVXlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268113AbUIVXlt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 19:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268105AbUIVXlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 19:41:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:23750 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268088AbUIVXlS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 19:41:18 -0400
Date: Wed, 22 Sep 2004 16:40:44 -0700
From: Greg KH <greg@kroah.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [RFC] put symbolic links between drivers and modules in the sysfs tree
Message-ID: <20040922234044.GA14552@kroah.com>
References: <1095701390.2016.34.camel@mulgrave> <20040922230423.GA14279@kroah.com> <20040922230650.GB14279@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040922230650.GB14279@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2004 at 04:06:50PM -0700, Greg KH wrote:
> On Wed, Sep 22, 2004 at 04:04:23PM -0700, Greg KH wrote:
> > I'll post my usb core change after this, to show you how USB can
> > be hooked up to it.
> 
> And here's the 3 line patch that I added to the usb core to hook up both
> the usb and usb-serial drivers to support the modules symlinks.
> 
> I'll go mess with the pci core now, but as there is no "struct module *"
> in the pci driver structure, it will take a bit of auditing to get them
> all hooked up properly.

Here's that patch, if anyone cares...

thanks,

greg k-h

------


PCI: add "struct module *" to struct pci_driver to show symlink in sysfs for pci drivers.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

diff -Nru a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
--- a/drivers/pci/pci-driver.c	2004-09-22 16:24:57 -07:00
+++ b/drivers/pci/pci-driver.c	2004-09-22 16:24:57 -07:00
@@ -417,6 +417,7 @@
 	drv->driver.bus = &pci_bus_type;
 	drv->driver.probe = pci_device_probe;
 	drv->driver.remove = pci_device_remove;
+	drv->driver.owner = drv->owner;
 	drv->driver.kobj.ktype = &pci_driver_kobj_type;
 	pci_init_dynids(&drv->dynids);
 
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	2004-09-22 16:24:57 -07:00
+++ b/include/linux/pci.h	2004-09-22 16:24:57 -07:00
@@ -632,9 +632,11 @@
 	unsigned int use_driver_data:1; /* pci_driver->driver_data is used */
 };
 
+struct module;
 struct pci_driver {
 	struct list_head node;
 	char *name;
+	struct module *owner;
 	const struct pci_device_id *id_table;	/* must be non-NULL for probe to be called */
 	int  (*probe)  (struct pci_dev *dev, const struct pci_device_id *id);	/* New device inserted */
 	void (*remove) (struct pci_dev *dev);	/* Device removed (NULL if not a hot-plug capable driver) */
